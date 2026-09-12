#!/bin/bash

###############################################
### run this inside HF_MP2_optimized_folder  ##
###############################################


module load openbabel-3.0.0-gcc-9.2.0-ygr4xiu


for fol in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "*"  \)   );
do
cd $fol
#        echo $fol "########################################## "

obabel -ig09 pes.log -opdb -Otest.pdb


cd ../
done

#grep EUMP2 a_*.g_60/pes.log | awk '{split($1,a,"."); split(a[1],b,"_"); gsub(/D/,"E"); printf("%3d %22.10f\n",  b[2], 627.509*$NF) }' | sort  -nk1,1 > xmgrace_energy_line.dat

ls -l ./a_*.g_60/test.pdb | awk '{split($9,a,"/"); split(a[2],b,"."); split(b[1],c,"_"); print c[2]"\t"$NF}' | sort -nk1,1  | awk '{s++; print "MODEL "s; system("cat "$2"|  grep HETATM");  print "ENDMDL"}'  >  all_pdb_rotation.pdb

