#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

sub fizzbuzz {
    my ($num) = @_;
    return 'FizzBuzz' if ( $num % 15 == 0 );
    return 'Fizz'     if ( $num % 3 == 0 );
    return 'Buzz'     if ( $num % 5 == 0 );
    return $num;
}

sub list_fizzbuzz {
    my ($limit) = @_;
    my @result = ();
    for (my $i=1; $i<=$limit; $i++) {
        push @result, fizzbuzz($i);
    }
    return @result;
}

subtest 'Fizz でも Buzz でもない', sub {
    is( fizzbuzz(1), '1' );
};

subtest '3の倍数', sub {
    is( fizzbuzz(6), 'Fizz' );
};

subtest '5の倍数', sub {
    is( fizzbuzz(10), 'Buzz' );
};

subtest '3の倍数かつ5の倍数(15の倍数)', sub {
    is( fizzbuzz(30), 'FizzBuzz' );
};


subtest 'list_fizzbuzz ジェネレーター部分', sub {
    is_deeply( [list_fizzbuzz(4)], ['1', '2', 'Fizz', '4']);
};

done_testing;
