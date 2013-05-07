#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

package Counter {
    sub new {
        my ($class) = @_;
        my $self = {
            counter => 1,
        };
        bless $self, $class;
    }
    sub increment {
        my ($self) = @_;
        return $self->{counter}++;
    }
};


subtest 'increment', sub {
    my $counter = Counter->new();
    is( $counter->increment, 1 );
    is( $counter->increment, 2 );
};


done_testing;
