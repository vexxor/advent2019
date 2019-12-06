#!/usr/bin/env perl

# https://adventofcode.com/2019/day/1

use strict;
use warnings;
use 5.30.0;
#use Data::Dumper;

my $input_file = substr($0,0,-3) . ".in";
open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";

my $fuel_total = 0;

$fuel_total += int($_ / 3) - 2 for <$fh>;

say $fuel_total;
