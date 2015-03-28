#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Common;
use Serve;

my @timestamp_tidy;
my $ymd = '\d{4}[\/-]\d\d?¥\/-]\d\d?';
my $time = '\d\d?:\d\d?';
my $time_local = 'time';
for my $timestamp (<DATA>) {
    if ($timestamp =~ /^\# (.+) ?(.*)$/) {
        push @timestamp_tidy, "\n# $1\t$2\n\n";
    } elsif ($timestamp =~ /^  (.+)$/) {
        push @timestamp_tidy, "\t\t\t$1\n";
    } elsif ($timestamp =~ /^(.+)($ymd) ($time):?\d?\d?$/) {
        $time_local = $3;
        push @timestamp_tidy, "$2\t$3\t\t$1\n";
    } elsif ($timestamp =~ /^(.+)($ymd)$/) {
        push @timestamp_tidy, "$2\t$time_local\t\t$1\n";
    } elsif ($timestamp =~ /^(.*?)($time):?\d?\d?$/) {
        $time_local = $2;
        push @timestamp_tidy, "\t$2\t\t$1\n";
    } elsif ($timestamp =~ /^(.+)$/) {
        push @timestamp_tidy, "\t$time_local\t\t$1\n";
    } else {
        push @timestamp_tidy, "";
    }
}
my $result = Common::treat(\@timestamp_tidy);
Serve::serve($result, 'd');

__DATA__
# 2015-03-05
- 洗濯 #wash
- ドラフト＆データ整理完了 2015-03-05 14:12
- 送信完了 2015-03-05 14:33

# 2015-03-09
- 洗濯 #wash
- リビング書棚掃除 2015-03-09 19:54

