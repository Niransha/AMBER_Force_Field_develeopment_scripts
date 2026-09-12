k#!/bin/bash

file1=$1

#echo " begin scripts/modify_RCSB_pdb.sh " 
#bash ../scripts/modify_RCSB_pdb.sh $file1 # inpit is RCSB pdb output is sed4.pdb
#echo " end of scripts/modify_RCSB_pdb.sh "

echo "begin scripts/resname_modify_duplex_rna.pl " 
perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/resname_modify_duplex_rna.pl $file1  #  input is NAME.pdb out is NAME.new.pdb    for double helix
#perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/create_newRESNAMEs.pl $file1     #for sinle srcutures
echo " END scripts/resname_modify_duplex_rna.pl  "

echo "begin ../scripts/xleap.new.water.in  "
tleap -f /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/xleap.new.water.in_for_nab_pdbs      #input is NAME.new.pdb where inside the script moldel = loadpbd ./NAME.new.pdb, output inpcrd prmtop
echo "END ../scripts/xleap.new.water.in  "

echo " checking xleap file source pdb name if any errors "

echo "begin scripts/create_correct_prmtop.pl "
perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/create_correct_prmtop.pl # input is prmtop out is parmtop.new
echo "END scripts/create_correct_prmtop.pl  "

echo "begin scripts/amber_commands.sh "
bash /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/amber_commands.sh	#input prmtop.new >> out >>  inpcrd.aatm.pdb >>> out >> amber_hold_atoms_list.dat
echo "END scripts/amber_commands.sh "

echo " END "