#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

package Range {
    use Class::Accessor::Lite (
        ro => ['min', 'max'],
    );
    sub new {
        my ($class, $min, $max) = @_;
        my $self = {
            min => $min,
            max => $max,
        };
        bless $self, $class;
    }
    sub contains {
        my ($self, $value) = @_;
        return $self->min <= $value && $value <= $self->max;
    }
};


subtest 'contains', sub {
    my $range = Range->new(0.1, 0.3);
    ok( !$range->contains(0.09) );
    ok( $range->contains(0.1) );
    ok( $range->contains(0.3) );
    ok( !$range->contains(0.31) );
};

done_testing;
