#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

package Item {
    use Class::Accessor::Lite (
        ro => ['name', 'price'],
    );
    sub new {
        my ($class, $name, $price) = @_;
        my $self = {
            name  => $name,
            price => $price,
        };
        bless $self, $class;
    }
};

package ItemStock {
    use Class::Accessor::Lite (
        ro => ['total_num'],
    );
    sub new {
        my ($class) = @_;
        my $self = {
            total_num   => 0,
            items => {},
        };
        bless $self, $class;
    }
    sub add {
        my ($self, $item) = @_;
        $self->{total_num}++;
        $self->{num}->{$item->name}++;
        $self->{items}->{$item->name} = $item;
    }
    sub find {
        my ($self, $name) = @_;
        return $self->{items}->{$name};
    }
    sub num_for {
        my ($self, $name) = @_;
        return 0 if ( !defined $self->{num}->{$name} );
        return $self->{num}->{$name};
    }
};


my $name  = 'ユメユメエキスプレス';
my $price = 1400;

my $name2  = '正解はひとつ！じゃない！！';
my $price2 = 1500;

subtest '初期値', sub {
    my $stock = ItemStock->new();
    is( $stock->total_num, 0 );

    is( $stock->num_for($name), 0 );
    is( $stock->find($name), undef );
};

subtest '一つ add', sub {
    my $stock = ItemStock->new();

    $stock->add( Item->new($name, $price) );
    is( $stock->total_num, 1 );
    is( $stock->num_for($name), 1);

    my $item = $stock->find($name);
    is( $item->name,  $name );
    is( $item->price, $price );
};

subtest '同一のものを2つ add', sub {
    my $stock = ItemStock->new();

    $stock->add( Item->new($name, $price) );
    $stock->add( Item->new($name, $price) );

    is( $stock->total_num, 2 );
    is( $stock->num_for($name), 2);

    my $item = $stock->find($name);
    is( $item->name,  $name );
    is( $item->price, $price );
};

subtest '別のものを2つ(1つずつ) add', sub {
    my $stock = ItemStock->new();

    $stock->add( Item->new($name, $price) );
    $stock->add( Item->new($name2, $price2) );

    is( $stock->total_num, 2 );
    is( $stock->num_for($name),  1);
    is( $stock->num_for($name2), 1);

    my $item = $stock->find($name);
    is( $item->name,  $name );
    is( $item->price, $price );
};



done_testing;
