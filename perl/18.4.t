#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

sub is_even {
    my ($num) = @_;
    return $num % 2 == 0;
}

ok( is_even(2) );
ok( !is_even(3) );
ok( is_even(-2) );

done_testing;
