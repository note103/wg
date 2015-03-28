#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Common;
use Serve;

my (@timestamp, @tag_out);
my $time = '\d\d?:\d\d?';
my $time_local = 'time';
my $day = '\D+';
my $num = '\d\d?';

for my $timestamp_pre (<DATA>) {
    if ($timestamp_pre =~ s/\t+/ /g) {
        push @tag_out, $timestamp_pre;
    } else {
        push @tag_out, $timestamp_pre;
    }
}

for my $timestamp (@tag_out) {
    if ($timestamp =~ /^\[($time)?\] ([^:]+)?: (.*)$/) {
        $time_local = $1;
        push @timestamp, "today\t$1\t\t$3\n";
    } elsif ($timestamp =~ /^\[($time)?\] ([^:]+)?: (.*)$/) {
        $time_local = $1;
        push @timestamp, "today\t$1\t\t$3\n";
    } elsif ($timestamp =~ /^\[($num)月-($num) ($time)\] ([^:]+)?: (.*)$/) {
        $time_local = $3;
        push @timestamp, "$1/$2\t$3\t\t$5\n";
    } elsif ($timestamp =~ /^\s+($day)($num)月 ($num), (\d{4})$/) {
        push @timestamp, "$4/$2/$3\t$1\n";
    } elsif ($timestamp =~ /\[\[($day)($num)月 ($num), (\d{4})\]\]$/) {
        push @timestamp, "$4/$2/$3\t$1\n";
    } elsif ($timestamp =~ /^\[($num)月-($num) ($time)\] ([^:]+)?: (.*)$/) {
        $time_local = $3;
        push @timestamp, "$1/$2\t$3\t\t$5\n";
    } elsif ($timestamp =~ /^\s+($num)月-.+($time)$/) {
        $time_local = $2;
        push @timestamp, "";
    } elsif ($timestamp =~ /^$/) {
        push @timestamp, "";
    } elsif ($timestamp =~ /^\s+(.*)$/) {
        push @timestamp, "\t$time_local\t\t$1\n";
    } elsif ($timestamp =~ /\n/) {
        push @timestamp, "";
    } else {
        push @timestamp, "\t$time_local\t\t$timestamp\n";
    }
}

my @timestamp_tidy;
my ($lastdate, $year);
my $ymd = '\d{4}\/\d\d?\/\d\d?';
for my $day2en (@timestamp) {
    if ($day2en =~ /^((\d{4})\/\d\d?\/\d\d?)\t(.+)$/){
        $lastdate = $1;
        $year = $2;
        if ($day2en =~ /^($ymd)\t日曜日 $/){
                push @timestamp_tidy, "\n# $1\tSunday\n\n";
        } elsif ($day2en =~ /^($ymd)\t月曜日 $/){
                push @timestamp_tidy, "\n# $1\tMonday\n\n";
        } elsif ($day2en =~ /^($ymd)\t火曜日 $/){
                push @timestamp_tidy, "\n# $1\tTuesday\n\n";
        } elsif ($day2en =~ /^($ymd)\t水曜日 $/){
                push @timestamp_tidy, "\n# $1\tWednesday\n\n";
        } elsif ($day2en =~ /^($ymd)\t木曜日 $/){
                push @timestamp_tidy, "\n# $1\tTursday\n\n";
        } elsif ($day2en =~ /^($ymd)\t金曜日 $/){
                push @timestamp_tidy, "\n# $1\tFriday\n\n";
        } elsif ($day2en =~ /^($ymd)\t土曜日 $/){
                push @timestamp_tidy, "\n# $1\tSaturday\n\n";
        }
    } else {
        push @timestamp_tidy, "$day2en";
    }
}
my $result = Common::treat(\@timestamp_tidy);
Serve::serve($result, 'c');

__DATA__
		土曜日 3月 28, 2015
[17:14] Hiroaki Kadomatsu: リリース用wgかなり作った
