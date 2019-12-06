#!/usr/bin/env perl

# https://adventofcode.com/2019/day/2

use strict;
use warnings;
use 5.30.0;
use Data::Dumper;

my $input_file = substr($0,0,-3) . ".in";
open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";

# Perl should be able to handle these as strings just fine, but lets be cool
# about it and turn them into ints
my @ops = map {int($_)} split ",", <$fh>;
my $pc = 0; #program counter


# Once you have a working computer, the first step is to restore the gravity
# assist program (your puzzle input) to the "1202 program alarm" state it had
# just before the last computer caught fire. To do this, before running the
# program, replace position 1 with the value 12 and replace position 2 with the
# value 2. What value is left at position 0 after the program halts?

$ops[0] = 12;
$ops[1] = 2;

while($pc < scalar(@ops)) {
    my ($op, $addr_1, $addr_2, $res_addr) = @ops[$pc .. $pc+4];
    if ($op == 99) {
        last;
    } elsif ($op == 1) {
        $ops[$res_addr] = $ops[$addr_1] + $ops[$addr_2];
    } elsif ($op == 2) {
        $ops[$res_addr] = $ops[$addr_1] * $ops[$addr_2];
    }

    $pc += 4;
}

#say Dumper \@ops;

say $ops[0];
