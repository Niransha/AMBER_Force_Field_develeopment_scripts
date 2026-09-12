#!/bin/bash

file1=$1

echo " begin scripts/modify_RCSB_pdb.sh " 
bash ../scripts/modify_RCSB_pdb.sh $file1 # inpit is RCSB pdb output is sed4.pdb
echo " end of scripts/modify_RCSB_pdb.sh "

echo "begin scripts/resname_modify_duplex_rna.pl sed4.pdb" 
perl ../scripts/resname_modify_duplex_rna.pl sed4.pdb  #  input is sed4.pdb out is sed4.new.pdb    
echo " END scripts/resname_modify_duplex_rna.pl sed4.pdb "

echo "begin ../scripts/xleap.new.water.in  "
tleap -f ../scripts/xleap.new.water.in      #input is sed4.new.pdb where inside the script moldel = loadpbd ./sed4.new.pdb, output inpcrd prmtop
echo "END ../scripts/xleap.new.water.in  "

echo "begin scripts/create_correct_prmtop.pl "
perl ../scripts/create_correct_prmtop.pl # input is prmtop out is parmtop.new
echo "END scripts/create_correct_prmtop.pl  "

echo "begin scripts/amber_commands.sh "
bash ../scripts/amber_commands.sh	#input prmtop.new >> out >>  inpcrd.aatm.pdb >>> out >> amber_hold_atoms_list.dat
echo "END scripts/amber_commands.sh "

echo " END "