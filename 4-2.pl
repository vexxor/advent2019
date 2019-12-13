#!/usr/bin/env perl

# https://adventofcode.com/2019/day/4

use strict;
use warnings;
use 5.30.0;

# Your puzzle input is 125730-579381.

my ($start_range,$end_range) = (125730,579381);
my $num_matching = 0;

$num_matching+=check_num($_) for ($start_range .. $end_range);
say $num_matching;

sub check_num {
    my $num = shift;
    my ($largest,$last,$conseq, $nr_conseq) = (0,-1,0,1);

    # the last number ($end_range+1) is so we can catch the edge case where the
    # last digit matches the one before it.
    # By putting a number outside of the high side of the range, we always hit a
    # digit change at the end and don't need to repeat step on ln:42 outside of the
    # loop
    for((split "",$num),$end_range+1) {
        return 0 if $_ < $largest; # Bail immediately if found a lower number than before

        # Don't need to do the next if we already have 2 conseq digits found
        if($conseq) {
            $last = $largest = $_;
            next;
        } else {
            # If we're seeing a same number, increment the matches
            if ( $_ == $last ) {
                $nr_conseq++;
            } else {
            # If we're switching to a new number, check if we saw a number exactly
            # twice ever, so we can set the flag that we have
                $conseq ||= 1 if $nr_conseq == 2;
                $nr_conseq = 1;
            }
            $last = $largest = $_;
        }

    }
    return $conseq;
}
