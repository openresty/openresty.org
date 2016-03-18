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
                  && (!$_->{tags} || $_->{tags} ne 'admin' || $_->{title} eq 'MainMenu')
                  && $_->{title} !~ /StyleSheet|ColorPalette|Markup(?:Post|Pre)/
              } @records;

#warn Dumper(\@records);
for my $r (@records) {
    my $title = $r->{title};
    my $fname = gen_uri_name($title);
    #warn $fname;
    #say $title;
    write_file("$lang/$fname.md", $r);
}
say "Found ", scalar(@records), " records.";

sub gen_uri_name {
    my $fname = shift;

    for ($fname) {
        s/MySQL/-mysql/g;
        s/LuaJIT/-luajit/g;
        s/eBook/-ebook/g;
        s/GitHub/-github/g;
        s/OpenResty/-openresty/g;
        s/FastCGI/-fastcgi/g;
        s/DNS/-dns/g;
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
    my $modified = parse_ts($r->{modified}) // '';
    my $body = $r->{body} or die "no body found for $title";

    $body = wiki2md($body);

    print $out <<_EOC_;
<!---
    \@title         $title
    \@creator       $creator
    \@created       $created
    \@modifier      $modifier
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
                my $link = gen_uri_name($word) . "/";
                $out .= "[$label]($link)";
            } else {
                $out .= $word;
            }

        } elsif ($s =~ / \G \[\[ ([^\]]*) \| ([^\]]*) \]\] /gxcms) {
            my ($tag, $link) = ($1, $2);
            if ($link =~ /^[A-Z]\w+$/) {
                $link = gen_uri_name($link) . "/";
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

        } elsif ($s =~ / \G \[\[ ( [^\]\|]* ) \]\] /gxcms) {
            my $tag = $1;

            my $link = gen_uri_name($tag) . "/";

            $out .= "[$tag]($link)";

        } elsif ($s =~ /\G ^ (!+) /gcxcms) {
            my $prefix = '#' x length($1);
            $out .= "\n$prefix ";

        } elsif ($s =~ /\G ([^\[\{!~<A-Z*]+) /gcxms) {
            $out .= $1;

        } elsif ($s =~ /\G (.) /gcxms) {
            $out .= $1;
        } else {
            last;
        }
    }
    $out;
}

sub fmt_wiki_word {
    my $s = shift;

    return undef unless $s;

    my $out;
    while (1) {
        if ($s =~ /\G (MySQL|DNS|GitHub|eBook|SystemTap|OpenResty|LuaJIT|JSON|FastCGI|LuaRocks) /gcxms) {
            $out .= $1;

        } elsif ($s =~ / \G ([^A-Z]+)([A-Z]) /gcxms) {
            $out .= "$1 $2";

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
    $out;
}
