#!/usr/bin/env perl

# https://adventofcode.com/2019/day/3

use strict;
use warnings;
use 5.30.0;
#use Data::Dumper;


# [X,Y] increments to avoid a four way if-elsif code block
my %move = (U => [0,1], D => [0,-1], R => [1,0], L => [-1,0]);
my %paths = ();
my $min_distance = 999999;
my $wire_nr = 0;

my $input_file = substr($0,0,-3) . ".in";
open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";

while(<$fh>){
    my ($x,$y) = (0,0); #path starts at origin port
    ++$wire_nr; # We use a 1 indexed wire-number and -1 for crossing
    for (split ',') {
        my ($dir,$steps) = $_ =~ /([UDRL])(.+)/;
        for (1 .. $steps) {
            # Advance x and y for the current step & use new "x,y" as a key in our paths hash
            my $coord = ($x+=$move{$dir}->[0]) . "," . ($y+=$move{$dir}->[1]);

            # Nothing there or same wire
            if (($paths{$coord} // $wire_nr) == $wire_nr) {
                $paths{$coord} = $wire_nr;
            } else { # Found cross with another wire
                $paths{$coord} = -1;
                my $distance = abs($x)+abs($y);
                $min_distance = $distance if $distance < $min_distance;
            }
        }
    }
}

say $min_distance;
