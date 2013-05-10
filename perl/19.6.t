#!/usr/bin/perl
use strict;
use warnings;
use Readonly;
use Test::More;

Readonly my %APP_SERVER => (
    GlassFish => 1,
    JBoss     => 2,
    Tomcat    => 3,
);

Readonly my %DATABASE => (
    Oracle     => 1,
    DB2        => 2,
    PostgreSQL => 3,
    MySQL      => 4,
);
use List::MoreUtils qw(any);

sub is_supported {
    my ($app_server, $dbms) = @_;
    if( $app_server eq $APP_SERVER{GlassFish} ) {
        if( any { $dbms eq $DATABASE{$_} } keys %DATABASE ) {
            return 1;
        }
        return 0;
    }
    if( $app_server eq $APP_SERVER{JBoss} ) {
        if( $dbms eq $DATABASE{DB2} || $dbms eq $DATABASE{PostgreSQL} ) {
            return 1;
        }
        return 0;
    }
    if( $app_server eq $APP_SERVER{Tomcat} ) {
        if( $dbms eq $DATABASE{MySQL} ) {
            return 1;
        }
        return 0;
    }

    return 0;
}

subtest 'is_supported', sub {
    my @patterns = (
        # [アプリサーバ,          DB,                    想定する答え]
        [$APP_SERVER{GlassFish}, $DATABASE{Oracle},     1],
        [$APP_SERVER{GlassFish}, $DATABASE{DB2},        1],
        [$APP_SERVER{GlassFish}, $DATABASE{PostgreSQL}, 1],
        [$APP_SERVER{GlassFish}, $DATABASE{MySQL},      1],
        [$APP_SERVER{JBoss},     $DATABASE{Oracle},     0],
        [$APP_SERVER{JBoss},     $DATABASE{DB2},        1],
        [$APP_SERVER{JBoss},     $DATABASE{PostgreSQL}, 1],
        [$APP_SERVER{JBoss},     $DATABASE{MySQL},      0],
        [$APP_SERVER{Tomcat},    $DATABASE{Oracle},     0],
        [$APP_SERVER{Tomcat},    $DATABASE{DB2},        0],
        [$APP_SERVER{Tomcat},    $DATABASE{PostgreSQL}, 0],
        [$APP_SERVER{Tomcat},    $DATABASE{MySQL},      1],
    );
    for my $pattern ( @patterns ) {
        my ($app, $db, $answer) = @{ $pattern };
        is( is_supported($app, $db), $answer ) or diag join(',', @{ $pattern });
    }
};

done_testing;
