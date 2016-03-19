#!/usr/bin/env perl

# extract data from TiddlyWiki files

use v5.10.1;
use strict;
use warnings;

use Data::Dumper;

my $infile = shift or die "No input file specified.\n";
my $lang = shift or die "No language tag specified.\n";

if ($lang !~ /^[a-z]{2}$/) {
    die "bad language tag: $lang\n";
}

if (!-d $lang) {
    mkdir $lang
        or die "cannot mkdir $lang: $!\n";
}

open my $in, $infile
    or die "cannot open $infile for reading: $!\n";

my $entered;
my %wikiwords;
my ($r, @records);
while (<$in>) {
    if (/^<div ([^>]*?\bcreated=[^>]*?)>/) {
        my $attrs = $1;
        if ($entered) {
            die "nested div";
        }
        $r = {
            body => '',
        };
        while ($attrs =~ /\b(\w+)="([^"]*)"/g) {
            my ($k, $v) = ($1, decode_entity($2));
            $r->{$k} = $v;
        }
        if ($r->{title}) {
            $wikiwords{$r->{title}} = 1;
        }
        push @records, $r;
        $entered = 1;
        next;
    }
    if ($entered) {
        if (m{^</div>$}) {
            my $count = ($r->{body} =~ s{^<pre>|</pre>}{}g);
            $r->{body} = decode_entity($r->{body});
            if ($count != 2) {
                die "unexpected body: $r->{body}";
            }
            undef $r;
            undef $entered;
            next;
        }
        $r->{body} .= $_;
    }
}

close $in;

@records = grep { $_->{title}
                  && (!$_->{tags} || $_->{tags} ne 'admin') #|| $_->{title} eq 'MainMenu')
                  && $_->{title} !~ /StyleSheet|ColorPalette|Markup(?:Post|Pre)/
              } @records;

#warn Dumper(\@records);
my %permlinks;
for my $r (@records) {
    my $title = $r->{title};
    my $fname = gen_uri_name($title);
    #warn $fname;
    #say $title;
    $permlinks{$title} = $fname;
    write_file("$lang/$fname.md", $r);
}

{
    my @kv;
    for my $tag (sort keys %permlinks) {
        push @kv, "$tag:'$permlinks{$tag}'";
    }

    my $outfile = "old-permlinks.js";
    open my $out, ">$outfile"
        or die "cannot open $outfile for writing: $!\n";
    print $out "var permlinks = {" . join(",", @kv) . "};\n";
    close $out;
}

say "Found ", scalar(@records), " records.";

sub gen_uri_name {
    my $fname = shift;

    for ($fname) {
        s/MySQL/-mysql/g;
        s/LuaJIT/-luajit/g;
        s/ChangeLog/-changelog-/g;
        s/eBook(s?)/-ebook$1/g;
        s/GitHub/-github/g;
        s/OpenResty/-openresty/g;
        s/FastCGI/-fastcgi/g;
        s/DNS/-dns/g;
        s/URI/-uri/g;
        s/URL/-url/g;
        s/SystemTap/-systemtap/g;
        s/LuaRocks/-luarocks/g;

        s/([A-Z])([^A-Z]+)/'-' . lc($1) . $2/ge;
        s/([A-Z]+)/'-' . lc($1) . '-'/eg;
        s/([a-zA-Z]+)(\d+)/$1-$2/g;
        s/^-+|-+$//g;
        s/--+/-/g;
    }

    $fname;
}

sub decode_entity {
    my $s = shift;
    for ($s) {
        s/\&quot;/"/gs;
        s/\&lt;/</gs;
        s/\&gt;/>/gs;
        s/\&nbsp;/ /gs;

        if (/(\&\w+;)/ || /(\&\#[a-zA-Z0-9]+;)/) {
            if ($1 ne '&amp;') {
                die "unknown entity: $1";
            }
        }

        s/\&amp;/\&/gs;
    }
    $s;
}

sub write_file {
    my ($fname, $r) = @_;

    open my $out, ">$fname"
        or die "cannot open $fname for writing: $!\n";

    my $title = $r->{title} or die "no title found";

    $title = fmt_wiki_word($title);

    my $changes = $r->{changecount} // 0;
    my $creator = $r->{creator} or die "no creator found for $title";

    $creator = fmt_wiki_word($creator);

    my $created = parse_ts($r->{created}) or die "no created found for $title";

    my $modifier = $r->{modifier} or die "no modifier found for $title";

    my $modifier_link = '';
    #warn "modifier $modifier";
    if ($wikiwords{$modifier}) {
        #warn "HIT";
        $modifier_link = gen_uri_name($modifier);
    }

    $modifier = fmt_wiki_word($modifier);

    my $modified = parse_ts($r->{modified}) // '';
    my $body = $r->{body} or die "no body found for $title";

    $body = wiki2md($body);

    print $out <<_EOC_;
<!---
    \@title         $title
    \@creator       $creator
    \@created       $created
    \@modifier      $modifier
    \@modifier_link $modifier_link
    \@modified      $modified
    \@changes       $changes
--->

$body
_EOC_

    close $out;
}

sub parse_ts {
    my $s = shift;

    return undef unless $s;

    if ($s =~ /^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})$/) {
        my ($year, $month, $day, $hour, $min) = ($1, $2, $3, $4, $5, $6);

        return "$year-$month-$day $hour:$min GMT";
    }

    die "invalid timestamp $s";
}

sub wiki2md {
    my $s = shift;
    for ($s) {
        s/<<toolbar\s+permalink>>//g;
        s/\n\n\n+/\n\n/g;
        s/\A\s+//msg;
        s/\s+\z//msg;
    }

    my $out = '';
    while (1) {
        my $seen_list_item;

        if ($s =~ /\G \{{3} (.*?) \}{3} /gxcms) {
            my $data = $1;
            if ($data =~ /\n/) {
                $data =~ s/\n+\z|\A\s+//g;
                $out .= <<_EOC_

```
$data
```
_EOC_

            } else {
                $out .= "`$data`";
            }

        } elsif ($s =~ / \G <<.*?>> /gxcms) {
            # do nothing. ignore it.

        } elsif ($s =~ / \G ~([A-Z]\w+) /gxcms) {
            $out .= $1;

        } elsif ($s =~ / \G \b ([A-Z]\w+) /gxcms) {
            my $word = $1;
            if ($wikiwords{$word}) {
                my $label = fmt_wiki_word($word);
                my $link = gen_uri_name($word) . ".html";
                $out .= "[$label]($link)";
            } else {
                $out .= $word;
            }

        } elsif ($s =~ / \G \[\[ ([^\]]*) \| ([^\]]*) \]\] /gxcms) {
            my ($tag, $link) = ($1, $2);
            if ($link =~ /^[A-Z]\w+$/) {
                $link = gen_uri_name($link) . ".html";
            }

            $out .= "[$tag]($link)";

        } elsif ($s =~ / \G \[img\[ ([^\]]+) \]\] /gxcms) {
            $out .= "![image]($1)";

        } elsif ($s =~ / \G ^ (\*\*+) /gxcms) {
            my $level = length $1;
            if ($level > 1) {
                $out .= " " x (4 * ($level - 1)) . "*";
            } else {
                $out .= $1;
            }

        } elsif ($s =~ m/ \G ^ : /gxcms) {
            $out .= "\n    ";

        } elsif ($s =~ m{ \G // ([^\n]*?) // }gxcms) {
            $out .= "*$1*";

        } elsif ($s =~ m{ \G (https? :// \S+) }gxcms) {
            $out .= $1;

        } elsif ($s =~ / \G \[\[ ( [^\]\|]* ) \]\] /gxcms) {
            my $tag = $1;

            my $link = gen_uri_name($tag) . ".html";

            $out .= "[$tag]($link)";

        } elsif ($s =~ / \G ("[^~\[\n]*?") /gxcms) {
            $out .= $1;

        } elsif ($s =~ /\G ^ (!+) /gcxcms) {
            my $prefix = '#' x length($1);
            $out .= "\n$prefix ";

        } elsif ($s =~ m#\G ([^\[\{!~<A-Z*:/h"]+) #gcxms) {
            $out .= $1;

        } elsif ($s =~ /\G (.) /gcxms) {
            $out .= $1;
        } else {
            last;
        }
    }

    $out =~ s{src="[^"]*donate-with-alipay\.png"}{src="/images/donate-with-alipay\.png"}g;
    $out =~ s{src="[^"]*donate_button_paypal_01\.gif"}{src="/images/donate_paypal\.gif"}g;
    $out =~ s{src="[^"]*alipay-qrcode\.png"}{src="/images/alipay-qrcode.png"}g;
    $out =~ s{src="[^"]*kugou-music\.jpg"}{src="/images/kugou-music.jpg"}g;

    $out = reformat_md($out);

    return $out;
}

sub reformat_md {
    my $s = shift;

    open my $in, "<", \$s or die $!;

    my $out = '';
    my ($in_code);
    while (<$in>) {
        if (/^```\w*\s*$/) {
            $in_code = !$in_code;
            $out .= $_;
            next;
        }

        if ($in_code) {
            $out .= $_;
            next;
        }

        if (/^[\s>]/) {
            # TODO: process list items
            $out .= $_;
            next;
        }

        while (1) {
            my $done;
            while (1) {
                if (/ \G (?: !? \[ [^\]]* \] \( [^\)]* \)
                               | \[ [^\]]* \] \[ [^\]]* \]
                               | \[ [^\]]* \]
                               | ` [^`]* `
                               | ~~ .*? ~~
                               | __ .*? __
                               | _ .*? _
                               | \*\* .*? \*\*
                               | \* .*? \*
                               )
                          /xmsgc)
                {
                    # do nothing

                } elsif (/ \G [^\[\]`~_*\s]+ (\s+) (?![-+>#=\d*\@]) /xmsgc) {
                    my $pos = pos;
                    if ($pos > 75) {
                        #warn "split!";
                        my $len = length $1;
                        $out .= substr $_, 0, $pos - $len;
                        $out .= "\n";
                        $_ = substr $_, pos;
                        if (length $_ < 80) {
                            $out .= $_;
                            $done = 1;
                            last;
                        }
                    }

                } elsif (/ \G [^\[\]`~_*\s]+ /xmsgc) {
                    # do nothing

                } elsif (/ \G . /xmsgc) {
                    # do nothing

                } else {
                    $out .= $_;
                    $done = 1;
                    last;
                }
            }

            if ($done) {
                last;
            }
        }
    }

    close $in;

    return $out;
}

sub fmt_wiki_word {
    my $s = shift;

    return undef unless $s;

    my $out;
    while (1) {
        if ($s =~ /\G (MySQL|DNS|URI|URL|GitHub|eBooks?|SystemTap|OpenResty|LuaJIT|JSON|FastCGI|LuaRocks|ChangeLog) /gcxms) {
            $out .= "$1 ";

        } elsif ($s =~ / \G (?<=\D) ([01]) (\d{3}) (\d{3}) \b /gcxms) {
            my $ver = sprintf("%d.%d.%d", $1, $2, $3);
            #warn $ver;
            $out .= "$ver ";

        } elsif ($s =~ / \G ([^A-Z]+)(?=[A-Z]) /gcxms) {
            $out .= "$1 ";

        } elsif ($s =~ / \G (\W+) /gcxms) {
            $out .= $1;

        } elsif ($s =~ / \G (.) /gcxms) {
            $out .= $1;

        } else {
            last;
        }
    }

    if (!defined $out) {
        die "$s bad";
    }

    $out =~ s/ {2,}/ /g;
    $out =~ s/^\s+|\s+$//g;
    $out;
}
