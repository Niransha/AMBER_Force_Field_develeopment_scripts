
# NOT working ## use this script : modify_RCSB_pdbs_and_change_resnames.sh 
######################################################################
##### script to modify RCSB PBD : remove unwanted lines and etc#####
####### NRK 28 Jun 2020 ################ ############################
####################################################################

#!/bin/bash

file=$1    # $1 is given pdb file when call the script eg :  $ bash bash.sh PBD.pbd

#awk '/^ATOM/{p=1}p' $file | grep -v HETAT | grep -v C7 | grep -v MASTER | grep -v END 
awk '/^ATOM/{p=1}p' $file | grep -v HETAT | grep -v C7 | grep -v MASTER | grep -v END > sed.pdb     # grap begin from ATOM

awk '!($5="")' sed.pdb > sed2.pdb       # remove column 5 : chain

sed  -e 's/DG/G/g' -e  's/DC/C/g' -e 's/DT/U/g' -e 's/DA/A/g' sed2.pdb > sed3.pdb   # repalce resnames

cat sed3.pdb | awk '{ if ($1=="TER") {printf "TER\n"} else  printf ("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f \n", $1, $2, $3, $4, $5, $6, $7, $8) }' > sed4.pdb    # print with format

cat sed4.pdb
rm sed.pdb
rm sed2.pdb
rm sed3.pdb

