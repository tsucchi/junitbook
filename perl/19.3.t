#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::Differences;
use utf8;
binmode STDOUT, ':utf8';

unified_diff;

subtest 'perl の場合はただの join のテストなので意味ないね', sub {
    my @data = (
        '佐々木 未来',
        '橘田 いずみ',
    );
    my $expected = [
        "佐々木 未来\n橘田 いずみ",
    ];
    eq_or_diff( [join("\n", @data)], $expected );
};

done_testing;
