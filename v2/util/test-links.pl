#!/usr/bin/env perl

use strict;
use warnings;

my $i = 0;

sub test_link ($) {
    my $link = shift;
    my $out = `curl -I -sS '$link'`;
    #print "$link\n";
    #my $out = "HTTP/1.1 200 OK";
    if ($out !~ m{\bHTTP/\d+(?:\.\d+)?\s+(?:200|30[0-9])\b}) {
        die "\nFailed to test link: $link\n$out";
    } else {
        $i++;
        print STDERR "$i OK\r";
    }
}

while (<>) {
    while (m{ \b ( https?:// [^\)\s\]]+ ) }xmg) {
        test_link $1;
    }
}
print "\n";
