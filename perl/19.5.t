#!/usr/bin/perl
use strict;
use warnings;

package ConsumptionTax {
    use Class::Accessor::Lite ( ro => ['rate'] );

    sub new {
        my ($class, $rate) = @_;
        my $self = {
            rate => $rate,
        };
        bless $self, $class;
    }
    sub apply {
        my ($self, $amount) = @_;
        return int( $amount * ( 1.0 + $self->rate / 100 ) );
    }
};

use Test::More;

subtest 'apply', sub {
    my $c = ConsumptionTax->new(5);
    is( $c->apply(100), 105, '通常の場合' );
    is( $c->apply(30),  31,  '小数点以下切り捨て');
};

done_testing;
