use strict;
use warnings;
use lib 'lib';
use Common;

package Serve {
    sub serve {
        my $file = 'out.md';
        my ($result, $sw) = @_;
        open my $fh, '>', $file or die $!;
            for my $line (@$result) {
                print $fh "$line";
            }
        close $fh;
        if ($sw eq 'c') {
            print `open dest/chat.md $file`;
        } elsif ($sw eq 'd') {
            print `open dest/diary.md $file`;
        } else {
            print `open $file`;
        }
    }
}

1;
