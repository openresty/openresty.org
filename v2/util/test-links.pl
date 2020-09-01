#!/usr/bin/env perl

use strict;
use warnings;

my %seen_links;

my $i = 0;

sub test_link ($) {
    my $link = shift;

    return if $seen_links{$link};
    $seen_links{$link} = 1;

    return if $link =~ /\b(?:foo|example|blah)\.com\b/ || /\bmybackend\b/;
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

my $seen_code;
while (<>) {
    if (/^\`\`\`\w*\s*$/) {
        $seen_code = !$seen_code;
    }

    next if $seen_code;
    while (m{ \b ( https?:// [^\)\s\]'">]+ ) }xmg) {
        test_link $1;
    }
}
print "\n";
