#!/usr/bin/env perl

use strict;
use warnings;

my $infile = shift
    or die "No input file specified.\n";

open my $in, $infile
    or die "cannot open file $infile for reading: $!\n";
my $changes = 0;
while (<$in>) {
    $changes += s/^(\s*```)\w+\s*$/$1\n/g;
    print;
}
close $in;
