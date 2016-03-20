#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
#use Data::Dumper;

my $outdir = '.';

GetOptions(
    "l|locale=s@" => \(my $locales),
    "h|help" => \(my $help),
    "outdir=s" => \($outdir),
) or usage(1);

if ($help) {
    usage(0);
}

if (!@$locales) {
    die "no --locale=LOCALE option specified.\n";
}

if (!@ARGV) {
    die "no input file specified.\n";
}

my @hits;
for my $file (@ARGV) {
    if (!-f $file) {
        die "file $file not found.\n";
    }

    if ($file =~ /\.tt2?$/) {
        process_tt2($file, \@hits);

    } elsif ($file =~ /\.lua$/) {
        process_lua($file, \@hits);

    } else {
        die "unknown file type of $file.\n";
    }
}

#warn Dumper(\@hits);
for my $locale (@$locales) {
    write_po($locale, \@hits);
}

sub read_file {
    my $file = shift;
    open my $in, "<:encoding(UTF-8)", $file
        or die "cannot open $file for reading: $!\n";
    my $s = do { local $/; <$in> };
    close $in;
    return $s;
}

sub process_tt2 {
    my ($file, $hits) = @_;
    local $_ = read_file($file);
    my $fg;
    my $line = 1;
    while (1) {
        if (/\G \[ \% /gcxms) {
            $fg = 1;

        } elsif ($fg && /\G \% \] /gcxms) {
            undef $fg;

        } elsif ($fg && /\G (?: ' (?: \\. | [^'\\\n] )* ' | " (?: \\. | [^"\\\n] )* " ) /gcxms) {
            # skip

        } elsif ($fg && /\G \b c \. l [ \t]* \( [ \t]* ( ' (?: \\. | [^'\\\n] )* ' | " (?: \\. | [^"\\\n] )* " ) [ \t]* \) /gcxms) {
            push @$hits, [$file, $line, $1];

        } elsif ($fg && /\G [^c'"\n\%]+ /gcxms) {
            # skip

        } elsif (/\G \n /gcxms) {
            $line++;

        } elsif (!$fg && /\G [^\[\n]+ /gcxms) {
            # skip

        } elsif (/\G . /gcxms) {
            # skip

        } else {
            last;
        }
    }
}

sub process_lua {
    my ($file, $hits) = @_;
    #warn "processing $file";
    local $_ = read_file($file);
    my $line = 1;
    while (1) {
        if (/\G (?: ' (?: \\. | [^'\\\n] )* ' | " (?: \\. | [^"\\\n] )* " ) /gcxms) {
            # skip

        } elsif (/\G \[ (=*) \[ (.*?) \] \1 \] /gcxms) {
            my $s = $1;
            while ($s =~ /\n/g) {
                $line++;
            }

        } elsif (/\G \b _ \s* \( \s* ( ' (?: \\. | [^'\\\n] )* ' | " (?: \\. | [^"\\\n] )* " ) \s* \) /gcxm) {
            #warn "Hit! $1";
            push @$hits, [$file, $line, $1];

        } elsif (/\G [^\['"\n_]+ /gcxms) {
            # skip

        } elsif (/\G \n /gcxms) {
            $line++;

        } elsif (/\G . /gcxms) {
            # skip

        } else {
            last;
        }
    }
}

sub write_po {
    my ($locale, $hits) = @_;

    my $pofile = "$outdir/$locale.po";

    if (-f $pofile) {
        # load existing translations
        load_po($pofile, $hits);
    }

    open my $out, ">:encoding(UTF-8)", $pofile
        or die "cannot open $pofile for writing: $!\n";

    print $out <<_EOC_;
#. TRANSLATORS: Please leave %s, %d, and etc as is, because it is needed by the program.
#. Thank you for contributing to this project.

_EOC_

    my @entries;
    for my $hit (@$hits) {
        next if !@$hit;

        my ($file, $line, $msgid, $msgstr) = @$hit;

        if (!defined $msgstr) {
            $msgstr = $msgid;
        }

        push @entries, <<_EOC_;
#: $file:$line
msgid  $msgid
msgstr $msgstr
_EOC_
    }

    print $out join "\n", @entries;

    close $out;

    print "wrote $pofile\n";
}

sub load_po {
    my ($pofile, $hits) = @_;

    open my $in, "<:encoding(UTF-8)", $pofile
        or die "cannot open $pofile for reading: $!\n";

    my ($msgid, %trans, $file, $line);

    while (<$in>) {
        if (/ ^ \s* msg(id|str) \s* (.*? \S) \s* $ /xms) {
            my ($type, $val) = ($1, $2);
            if ($type eq 'id') {
                if (defined $msgid) {
                    die "ERROR: $pofile: line $.: no msgstr defined for msgid $msgid.\n";
                }

                $msgid = $val;

            } else {
                # eq 'str'

                if (!defined $msgid) {
                    die "ERROR: $pofile: line $.: no msgid defined for msgstr $val.\n";
                }

                $trans{$msgid} = $val;
                undef $msgid;
            }

        } elsif (/^\s*$/) {
            next;

        } elsif (/ ^ \s* \# /xms) {
            next;

        } else {
            die "ERROR: $pofile: line $.: invalid line $_";
        }
    }

    close $in;

    my %visited;
    for my $hit (@$hits) {
        my ($file, $line, $msgid) = @$hit;
        if ($visited{$msgid}) {
            @$hit = ();
            next;
        }

        my $msgstr = $trans{$msgid};
        if (defined $msgstr) {
            #warn "Hit!";
            push @$hit, $msgstr;
        }

        $visited{$msgid} = 1;
    }
}

sub usage {
    my $code = shift;
    my $msg = <<_EOC_;
Usage:
    $0 [options] <input-file>...

Options:

    -h
    --help              Print this help.

    -l LANG
    --locale=LANG       Specify the locale name (multiple instances are allowed).

    --outdir=DIR        Specify the output directory for the .po files.

Copyright (C) Yichun Zhang (agentzh). All rights reserved.
_EOC_

    if ($code == 0) {
        print $msg;
        exit(0);
    }

    print STDERR $msg;
    exit($code);
}
