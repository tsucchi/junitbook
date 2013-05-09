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

sub employee_ok {
    my ($employee, $first, $last, $email) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    is( $employee->first_name, $first, 'first name' );
    is( $employee->last_name,  $last,  'last name' );
    is( $employee->email,      $email, 'email' );
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
    employee_ok($result[0], 'Suzuko', 'Mimori', 'mimori_suzuko@example.com' );
    employee_ok($result[1], 'Sora',   'Tokui',  'tokui_sorangley@example.com' );
};

done_testing;
