#!/usr/bin/env perl

# generate TSV accepted by Pg's COPY command

use strict;
use warnings;

my $lang = shift
    or die "No language tag specified.\n";

my $dirname = "html/$lang";
if (!-d $dirname) {
    die "directory $dirname does not exist yet. maybe you forgot to make?\n";
}

opendir my $dir, $dirname
     or die "cannot open $dirname for reading: $!\n";

my @rows;
while (my $entity = readdir $dir) {
    #warn $entity;
    my $fname = "$dirname/$entity";
    if (-f $fname && $entity =~ /(.+)\.html$/) {
        my $name = $1;
        #next if $name eq 'main-menu';
        #warn $name;
        my $rec = parse_file($name, $fname);
        push @rows, $rec;
    }
}

close $dir;

my $outfile = "posts-$lang.tsv";
my $n = dump_rows(\@rows, $outfile);
print "$n rows dumped to $outfile.\n";

sub parse_file {
    my ($name, $file) = @_;

    open my $in, "<:encoding(UTF-8)", $file
        or die "cannot open $file for reading: $!\n";
    my $html = do { local $/; <$in> };
    close $in;

    my %attr;
    if ($html =~ s/ \A <!--- \s* (.*?) ---> (?: \n | $ ) //xsm) {
        my $meta = $1;
        %attr = map { if (/\@(\S+)\s+(.*)/) { ($1, $2) } else { () } }
                        split /\n/, $meta;

    } else {

        if ($html =~ s{ \A \s* <p> \s* \&lt; !--- (.*?)
                        --- \&gt; \s* </p> (?: \n | $ ) }{}xsm)
        {
            my $meta = $1;
            $meta =~ s/^\s+|\s+$//g;
            $meta =~ s/\&quot;/"/g;
            $meta =~ s/\&lt;/</g;
            $meta =~ s/\&gt;/>/g;
            $meta =~ s/\&amp;/&/g;
            $meta =~ s/\&nbsp;/ /g;

            %attr = map { if (/\@(\S+)\s+(.*)/) { ($1, $2) } else { () } }
                        split / \s+ (?= \@\w+ )/x, $meta;

        } else {
            die "bad HTML content in file $file";
        }
    }

    #use Data::Dumper;
    #warn Dumper(\%attr);
    $attr{html_body} = $html;
    $attr{permlink} = $name;

    {
        my $txtfile = "text/$lang/$name.txt";
        if (!-f $txtfile) {
            die "$txtfile not found (maybe you should run \"make text\" first?).\n";
        }

        open my $in, "<:encoding(UTF-8)", $txtfile
            or die "cannot open $txtfile for reading: $!\n";

        my $txt = do { local $/; <$in> };

        close $in;

        $txt =~ s/\s+/ /gs;
        $txt =~ s/\A\s+|\s+\z//gs;
        $attr{txt_body} = $txt;
    }

    if ($attr{modifier} && !$attr{modified} && $attr{created}) {
        # for data extracted from tiddlywiki
        $attr{modified} = $attr{created};
    }

    my (%missing_keys);
    for my $key (qw/ creator created modifier modified changes /) {
        if (!$attr{$key}) {
            warn "$lang/$name: key \@$key not found. parsing git meta...\n";
            $missing_keys{$key} = 1;
        }
    }

    if (%missing_keys) {
        my $cmd = "git log -- $lang/$name.md";

        open my $in, "$cmd|"
            or die "cannot open pipe to command $cmd: $!\n";

        my ($changes, $modifier, $creator, $modified, $created);
        while (<$in>) {
            if (/^commit /) {
                $changes++;
                next;
            }
            if (/ ^ Author: \s* ( [^<]* ) /x) {
                if (!defined $modifier) {
                    $modifier = $1;
                    $modifier =~ s/^\s+|\s+$//g;
                }

                $creator = $1;
                next;
            }
            if (/ ^ Date: \s* (.*) /x) {
                if (!defined $modified) {
                    $modified = $1;
                    $modified =~ s/^\s+|\s+$//g;
                }

                $created = $1;
            }
        }

        close $in;

        if (defined $creator) {
            $creator =~ s/^\s+|\s+$//g;
            if ($missing_keys{creator}) {
                $attr{creator} = $creator;
            }
        }

        if (defined $created) {
            $created =~ s/^\s+|\s+$//g;
            if ($missing_keys{created}) {
                $attr{created} = $created;
            }
        }

        if ($missing_keys{modified}) {
            $attr{modified} = $modified;
        }

        if ($missing_keys{modifier}) {
            $attr{modifier} = $modifier;
        }

        if ($missing_keys{changes}) {
            $attr{changes} = $changes;
        }
    }

    return \%attr;
}

sub dump_rows {
    my ($rows, $file) = @_;

    open my $out, ">:encoding(UTF-8)", $file
        or die "cannot open $file for writing: $!\n";

    for my $r (@$rows) {
        #warn $r->{txt_body};

        my $created = quote_value($r, 'created');
        print $out quote_value($r, 'title'), "\t",
              quote_value($r, 'permlink'), "\t",
              quote_value($r, 'html_body'), "\t",
              quote_value($r, 'txt_body'), "\t",
              quote_value($r, 'creator'), "\t",
              $created, "\t",
              quote_value($r, 'modifier'), "\t",
              $r->{modifier_link} // "\\N", "\t",
              quote_value($r, 'modified'), "\t",
              quote_value($r, 'changes'),
              "\n";
    }

    close $out;

    scalar @$rows;
}

sub quote_value {
    my ($r, $k) = @_;

    my $s = $r->{$k};
    if (!$s) {
        die "html/$lang/$r->{permlink}.html: meta data \"\@$k\" not defined.\n";
    }

    $s =~ s/\\/\\\\/g;
    $s =~ s/\x{08}/\\b/g;
    $s =~ s/\f/\\f/g;
    $s =~ s/\n/\\n/g;
    $s =~ s/\r/\\r/g;
    $s =~ s/\t/\\t/g;
    $s =~ s/\v/\\v/g;
    $s;
}
