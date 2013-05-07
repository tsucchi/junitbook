#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

sub camel2snake {
    my ($str) = @_;

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
is( camel2snake('HelloWorld'),         'hello_world' );
is( camel2snake('practiceJunit'),      'practice_junit' );
is( camel2snake('HelloBeautifulWorld'),'hello_beautiful_world' );

done_testing;

