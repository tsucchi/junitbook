#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Time::HiRes;

package BackgroundTask {
    use Coro;
    sub new {
        my ($class) = @_;
        my $self = {
            tasks => [],
        };
        bless $self, $class;
    }
    sub add {
        my ($self, $coderef) = @_;
        push @{ $self->{tasks} }, $coderef;
    }
    sub run {
        my ($self) = @_;
        my @coros;
        for my $task_coderef ( @{ $self->{tasks} } ) {
            push @coros, async {
                $task_coderef->();
            };
        }
        $_->join for @coros;
    }
    sub yield {
        cede;
    }
};

subtest '通常の実行', sub {
    my $count = 0;
    my $task = BackgroundTask->new();
    $task->add(sub { $count++ });
    $task->run();
    is( $count, 1 );
};

subtest '前の実行がブロックしているが、マルチスレッドなら後ろのタスクが解除するので流れる', sub {
    local $SIG{ALRM} = sub { die "timeout" };
    alarm 3; # 無限ループする可能性があるのでタイムアウト入れる

    my $blocked = 1;
    my $count = 0;
    my $task = BackgroundTask->new();
    $task->add(sub {
        while( $blocked ) {#ブロックする
            sleep(0.1);
            $task->yield;
        }
    });
    $task->add(sub {
        $blocked = 0;#解除
        $count++;
    });
    $task->run();
    is( $count, 1 );
    is( $blocked, 0 );
};

done_testing;
