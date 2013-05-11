#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Test::MockTime;
use Time::Piece;

sub days_until_last_day_of_month {
    my $t = localtime;
    return $t->month_last_day - $t->mday;
}

subtest 'days_until_last_day_of_month', sub {
    local $ENV{TZ} = 'JST';
    Test::MockTime::set_fixed_time('2009-03-23 11:22:33', "%Y-%m-%d %H:%M:%S");
    is( days_until_last_day_of_month, 8 );

    Test::MockTime::set_fixed_time('2009-03-31 11:22:33', "%Y-%m-%d %H:%M:%S");
    is( days_until_last_day_of_month, 0 );
};

done_testing;
