#!/usr/bin/env perl

# https://adventofcode.com/2019/day/1 - Part 2

use strict;
use warnings;
use 5.30.0;
#use Data::Dumper;

my $input_file = substr($0,0,-3) . ".in";

open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";

my $fuel_total = 0;

while (<$fh>) {
    my $current_fuel = $_;
    while ($current_fuel > 0) {
        $current_fuel = int($current_fuel / 3) - 2;
        $fuel_total += $current_fuel if $current_fuel > 0;
    };
}

say $fuel_total;
