use strict;
use warnings;
use 5.012;

package Common {
    sub treat {
        my $source = shift;
        my @treat_exchanged;
        for my $treat (@$source) {
            if ($treat =~ /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                    push @treat_exchanged, "* $2\t$4";
            } else {
                push @treat_exchanged, $treat;
            }
        }
        my @port;
        for my $cut_endwhite (@treat_exchanged) {
            if ($cut_endwhite =~ /(.+) +$/ ) {
                push @port, "$1\n";
            } else {
                push @port, $cut_endwhite;
            }
        }
        my @autolink;
        for my $autolink (@port) {
            if ($autolink =~ s/([^\<\>"]?)((http:|https:)[^ \s]+)/$1<$2>/g ) {
                push @autolink, $autolink;
            } else {
                push @autolink, $autolink;
            }
        }
        my @anchor;
        for my $anchor (@autolink) {
            if ($anchor =~ /^(\D*)\# ((\d{4})[\/-](\d\d?)[\/-](\d\d?))(\D*)$/) {
                push @anchor, "$1\# $3-$4-$5\<a name=\"$2\"\>\<\/a\>$6";
            } else {
                push @anchor, $anchor;
            }
        }
        my @index;
        for my $index (@anchor) {
            if ($index =~ /\# (\d{4})[\/-](\d\d?)[\/-](\d\d?)/) {
                push @index, "[$1/$2/$3](\#$1-$2-$3)<br>\n";
            } else {
                push @index, "";
            }
        }

        my @rev_index = reverse @index;
        my @blank = ("\n");
        my @convert = (@anchor, @blank, @rev_index);

        my @cut_tail_blank;
        for my $cut_tail_blank (@convert) {
            $cut_tail_blank =~ s/[ \t]*$//g;
            push @cut_tail_blank, $cut_tail_blank;
        }
        my @replace_blank;
        for my $replace_blank (@cut_tail_blank) {
            $replace_blank =~ s/　/ /g;
            push @replace_blank, $replace_blank;
        }
        my @re_date;
        my $ymd = 'ymd';
        for my $re_date (@replace_blank) {
            if ($re_date =~ /\# (\d{4})[\/-](\d\d?)[\/-](\d\d?)(.*)/) {
                $ymd = "$1-$2-$3";
                push @re_date, $re_date;
            } elsif ($re_date =~ /^\* (\d\d:\d\d)[ \t](.*)$/) {
                push @re_date, "* $ymd $1\t$2\n";
            } else {
                push @re_date, $re_date;
            }
        }
        my @re_name;
        for my $re_name (@re_date) {
            if ($re_name =~ s/a name="(\d{4})\/(\d\d?)\/(\d\d?)"/a name="$1-$2-$3"/) {
                push @re_name, $re_name;
            } else {
                push @re_name, $re_name;
            }
        }
        return \@re_name;
    }
}

1;
