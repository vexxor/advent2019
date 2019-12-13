#!/usr/bin/env perl

# https://adventofcode.com/2019/day/3

use strict;
use warnings;
use 5.30.0;
use Data::Dumper;

# [X,Y] increments to avoid a four way if-elsif code block
my %move = (U => [0,1], D => [0,-1], R => [1,0], L => [-1,0]);
my %paths = (); # Contains "x,y" => [wire, total distance traveled]
my @intersects = ();
my $wire_nr = 0;
my $min_steps = 999999;

my $input_file = substr($0,0,-3) . ".in";
open (my $fh, '<', substr($0,0,-3) . ".in") or die "Couldn't open file: $!";


while(<$fh>){
    my ($x,$y) = (0,0); #path starts at origin port
    ++$wire_nr; # We use a 1 indexed wire-number and -1 for crossing
    my $total_steps = 0;

    for (split ',') {
        my ($dir,$steps) = $_ =~ /([UDRL])(.+)/;
        for (1 .. $steps) {
            # Advance x and y for the current step & use new "x,y" as a key in our paths hash
            my $coord = ($x+=$move{$dir}->[0]) . "," . ($y+=$move{$dir}->[1]);
            $total_steps++;

            if(!defined $paths{$coord}) {
                $paths{$coord} = [$wire_nr, $total_steps];
            } elsif ( $paths{$coord}->[0] != $wire_nr ) {
                $paths{$coord} = [$wire_nr, $paths{$coord}->[1] + $total_steps];
                # Let's just get this immediately here, and avoid intermediate
                # storage. Ignore the minimum calculations for first wire
                $min_steps = $paths{$coord}->[1] if $wire_nr > 1 && $paths{$coord}->[1] < $min_steps;
            } # no else here, in case we cross own wire, just ignore since we only care about shortest distance ( as per problem definition )
        }
    }
}

say $min_steps;
