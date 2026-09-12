#!/usr/bin/perl -w
#
#
$initxyz = "opt.xyz";
$prmtop  = "../../prmtop.zeroed.new";
#
# Create sample.pdb file
#
system("ambpdb -aatm -p $prmtop -c $initxyz > sample.pdb");   ## create sample.pdb
#
# Open .pdb file to store necessary data for RST file
#
