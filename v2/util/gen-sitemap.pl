#!/usr/bin/env perl

# generate sitemap.xml from the posts-*.tsv data files so that the
# <lastmod> values always reflect the posts' modification times.

use strict;
use warnings;

my $base_url = "https://openresty.org";
my $outfile = "sitemap.xml";

my %months = (
    Jan => '01', Feb => '02', Mar => '03', Apr => '04',
    May => '05', Jun => '06', Jul => '07', Aug => '08',
    Sep => '09', Oct => '10', Nov => '11', Dec => '12',
);

my @entries;
for my $lang (qw/ en cn /) {
    my $tsvfile = "posts-$lang.tsv";
    if (!-f $tsvfile) {
        die "$tsvfile not found (maybe you should run \"make gendata\" first?).\n";
    }

    open my $in, "<:encoding(UTF-8)", $tsvfile
        or die "cannot open $tsvfile for reading: $!\n";

    my (%lastmod, $index_lastmod);
    while (<$in>) {
        chomp;
        my @fields = split /\t/;
        my ($permlink, $modified) = ($fields[1], $fields[8]);
        if (!defined $permlink || !defined $modified) {
            die "$tsvfile: line $.: bad TSV record.\n";
        }

        my $date = parse_date($modified)
            or die "$tsvfile: line $.: bad \@modified date \"$modified\".\n";

        # the site's index page renders the "openresty" post; the
        # "main-menu" post is not a real page.
        if ($permlink eq 'openresty') {
            $index_lastmod = $date;
            next;
        }
        next if $permlink eq 'main-menu';

        $lastmod{$permlink} = $date;
    }

    close $in;

    push @entries, ["$base_url/$lang/", $index_lastmod];
    push @entries, ["$base_url/$lang/videos.html", undef];
    for my $permlink (sort keys %lastmod) {
        push @entries, ["$base_url/$lang/$permlink.html", $lastmod{$permlink}];
    }
}

open my $out, ">:encoding(UTF-8)", $outfile
    or die "cannot open $outfile for writing: $!\n";

print $out qq{<?xml version="1.0" encoding="UTF-8"?>\n};
print $out qq{<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n};

for my $entry (@entries) {
    my ($loc, $lastmod) = @$entry;
    print $out "  <url>\n";
    print $out "    <loc>$loc</loc>\n";
    if (defined $lastmod) {
        print $out "    <lastmod>$lastmod</lastmod>\n";
    }
    print $out "  </url>\n";
}

print $out "</urlset>\n";

close $out;

print scalar(@entries), " URLs dumped to $outfile.\n";

sub parse_date {
    my $s = shift;

    # tiddlywiki style, like "2012-01-05 15:15 GMT"
    if ($s =~ /^(\d{4}-\d{2}-\d{2})\b/) {
        return $1;
    }

    # git style, like "Tue Jan 16 08:01:13 2024 +0800"
    if ($s =~ /^\w{3} (\w{3}) (\d{1,2}) [\d:]+ (\d{4})\b/) {
        my ($mon, $mday, $year) = ($1, $2, $3);
        my $mm = $months{$mon} or return undef;
        return sprintf "%s-%s-%02d", $year, $mm, $mday;
    }

    return undef;
}
