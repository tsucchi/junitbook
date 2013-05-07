#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Try::Tiny;

sub divide {
    my ($x, $y) = @_;
    die 'divide by zero.' if ( $y == 0 );
    return int( $x / $y );
}


subtest '通常の場合 (3/2 = 1)', sub {
    is( divide(3, 2), 1);
};

subtest '0除算', sub {
    try {
        divide(3, 0);
        fail('exception expected');
    } catch {
        like( $_, qr/^divide by zero\./ );
    };
};

done_testing;
