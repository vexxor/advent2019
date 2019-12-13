#!/usr/bin/env perl

# https://adventofcode.com/2019/day/2

use strict;
use warnings;
use 5.30.0;
use Data::Dumper;

my $input_file = substr($0,0,-3) . ".in";
open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";

# So in part 2, new terminology was introduced, so we rename things here a litle

my @initial_memory = map {int($_)} split ",", <$fh>;
my $ic = 0; #instruction counter


# Find the input noun and verb that cause the program to produce the output
# 19690720. What is 100 * noun + verb? (For example, if noun=12 and verb=2, the
# answer would be 1202.) Noun and verb are 0-99

my ($noun, $verb);

OUTER:
for ($noun = 0; $noun < 100; $noun++) {
    for ($verb = 0; $verb < 100; $verb++) {
        last OUTER if compute($noun, $verb) == 19690720
    }
}

say 100 * $noun + $verb;

sub compute {
    my @memory = @initial_memory;
    $memory[1] = $_[0];
    $memory[2] = $_[1];

    my $ic = 0; #gotcha

    while($ic < scalar(@memory)) {
        # So in part 2, new terminology was introduced, so we rename things here a litle
        my ($op, $noun, $verb, $res_addr) = @memory[$ic .. $ic+4];

        if ($op == 99) {
            #printf "%s - %s -> %s\n", $input_1, $input_2, $memory[0];
            last;
        } elsif ($op == 1) {
            $memory[$res_addr] = $memory[$noun] + $memory[$verb];
        } elsif ($op == 2) {
            $memory[$res_addr] = $memory[$noun] * $memory[$verb];
        }
        $ic += 4;
    }

    return $memory[0];
}
