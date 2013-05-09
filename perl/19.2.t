#!/usr/bin/perl
use strict;
use warnings;

package Employee {
    use Class::Accessor::Lite (
        ro => ['first_name', 'last_name', 'email'],
    );
    sub new {
        my ($class, $first_name, $last_name, $email) = @_;
        my $self = {
            first_name => $first_name,
            last_name  => $last_name,
            email      => $email,
        };
        bless $self, $class;
    }
};

use Test::More;
use Path::Tiny;

sub load {
    my ($filename) = @_;
    my @result = ();
    my $path = path($filename);
    for my $line ( $path->lines ) {
        chomp $line;
        my ($first, $last, $email, @other) = split(/,/, $line);
        die "invalid email format" . sprintf("$email%s",join('', @other))  if ( @other );
        push @result, Employee->new($first, $last, $email);
    }
    return @result;
}


subtest 'load 読み込み', sub {
    my $temp = Path::Tiny->tempfile();
    my @data = (
        "Suzuko,Mimori,mimori_suzuko\@example.com\n",
        "Sora,Tokui,tokui_sorangley\@example.com\n",
    );
    $temp->spew(@data);
    my @result = load($temp);
    is( scalar(@result), scalar(@data) );
    is( $result[0]->first_name, 'Suzuko' );
    is( $result[0]->last_name,  'Mimori' );
    is( $result[0]->email,      'mimori_suzuko@example.com');
};

done_testing;
