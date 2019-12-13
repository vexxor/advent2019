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
    my ($largest,$last,$conseq) = (0,-1,0);

    for(split "",$num) {
        return 0 if $_ < $largest; # Bail immediately if found a lower number than before
        $conseq ||= (($_ == $last) ? 1 : 0); # Set flag if we saw conseq. digits, keep if set
        $last = $largest = $_;
    }

    return $conseq; # Bingo if we haven't bailed by now the return value depends only on this flag
}
