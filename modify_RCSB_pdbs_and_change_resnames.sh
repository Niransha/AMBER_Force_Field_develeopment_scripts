#!/bin/bash
######################################################################
#        NRK 11 agust 2021                                        #####
#### any RCSB pdb will modify and chage resname to 5AC ACG AC3 system #
#######################################################################


file1=$1

pdb4amber $file1 > foramber.pdb #get RCSB to amber pdb format

cat foramber.pdb | grep -v END | grep -v CRYST1 > tmp1.pdb #remove END and CRYST1

awk '!($5="")' tmp1.pdb > tmp2.pdb # remove chain 5th column

cat tmp2.pdb | awk '{ if ($1=="TER") {printf "TER\n"} else  printf ("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f \n", $1, $2, $3, $4, $5, $6, $7, $8) }' > resname.pdb # this is now looks loke nab pdb. so then follwoing script

perl ~/scripts/create_resname_modify_duplex_rna.pl resname.pdb   # give correctedresname.pdb


echo "output : resname.new.pdb "
echo "DONE!!"

#remove tmps
rm foramber.pdb resname.pdb 
rm tmp1.pdb 
rm tmp2.pdb 
rm stdout_nonprot.pdb stdout_renum.txt stdout_sslink
