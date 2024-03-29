#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

sub camel2snake {
    my ($str) = @_;

    return if !defined $str;

    if( $str =~ qr/^([A-Z])/ ) { # 先頭が大文字
        my $lc = lc($1);
        $str =~ s/^(?:[A-Z])/$lc/;
    }

    while ( $str =~ qr/([A-Z])/ ) {
        my $lc = lc($1);
        $str =~ s/(?:[A-Z])/_$lc/;
    }
    return $str;
}

is( camel2snake('aaa'),                'aaa' );
is( camel2snake('_aaa'),               '_aaa' );
is( camel2snake('HelloWorld'),         'hello_world' );
is( camel2snake('practiceJunit'),      'practice_junit' );
is( camel2snake('HelloBeautifulWorld'),'hello_beautiful_world' );
is( camel2snake(undef),                undef );

done_testing;

