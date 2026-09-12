#!/bin/bash


file_in=$1

echo "if double helix, type - dh " 
echo "single strand, type - ss"
read htype  # catching input
echo Structure is $htype

#modify RSCB to get a NAB like structure
echo " begin scripts/modify_RCSB_pdbs_and_change_resnames.sh ################################## 1111 ##"
bash /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/modify_RCSB_pdbs_and_change_resnames.sh $file_in # inpit is RCSB pdb output is resname.pdb
echo " end of scripts/modify_RCSB_pdb.sh ############################################# "
#^ it will give NAB like pdb format at the end of the above script ^

#change resname
echo "begin scripts/resname_modify_duplex_rna.pl sed4.pdb ################################ 2222 ##" 

if [[ $htype == dh ]];
then
# this is old version	perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/resname_modify_duplex_rna.pl resname.pdb  #  input is resname.pdb out is resname.new.pdb    
	echo "##############################################VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV dublex#####"
else
# this is old version	perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/create_newRESNAMEs.pl resname.pdb # for single stranded
	echo "##############################################VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV single#####"

fi

#rm resname.pdb
echo " END scripts/resname_modify_duplex_rna.pl sed4.pdb ##########################################"

# solvate in water
echo "begin ../scripts/xleap.new.water.in ####################################### 333 ##  "
tleap -f /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/xleap.new.water.in      #input is resname.new.pdb where inside the script moldel = loadpbd ./resname.new.pdb, output inpcrd prmtop
#tleap -f /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/xleap.new.water.in xleap.new.water.in_for_nab_pdbs
echo "END ../scripts/xleap.new.water.in ############################### "

#correct parmtom file and get prmtop.new file 
echo "begin scripts/create_correct_prmtop.pl ############################# 444 ## "
perl /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/create_correct_prmtop.pl # input is prmtop out is parmtop.new
rm prmtop
echo "END scripts/create_correct_prmtop.pl #########################################  "

# not nessorsry posisional strain done by amber codes see min.in and eq.in not
#ntr=1, restraint_wt = 1.0, restraintmask = " ! @H= & ! :WAT,Na+,Cl-",
#echo "begin scripts/amber_commands.sh #######################################555##"
bash /home/nkumarachchi2019/dimeric_force_field/Test/dev_2d_benchmark_systems/scripts/amber_commands.sh	#input prmtop.new >> out >>  inpcrd.aatm.pdb >>> out >> amber_hold_atoms_list.dat 
#echo "END scripts/amber_commands.sh ############################################## "

echo " END "



