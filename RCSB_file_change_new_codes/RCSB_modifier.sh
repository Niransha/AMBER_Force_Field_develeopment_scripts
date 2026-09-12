#!/bin/bash
######################################################################
#        NRK 11 agust 2021                                         ###
# any RCSB pdb will modify and chage resname to 5AC ACG AC3 system  #
# perpose is to get transform  RCSB.pdb  to NAB format              #
# rename.pdb has the NAB format                                      #
# ussage bash ./modify_RCSB_pdbs_and_change_resnames.sh rcsb.pdb     #
# output is resname.pdb                                              # 
# check all_in_one_RCSB_pbs.sh  script also,                         #   
#######################################################################


file1=$1

pdb4amber $file1 > foramber.pdb #get RCSB to amber pdb format input : rscb.pbd out : foramber.pdb

#automatically convert DNA (T) to RNAs(U) by removeing C7 of T can get U
#here C7 is 1BNA's : this is DNA and has T , diffrent between C and T is this C7 and it will be remove, i
# initially 1BNA is DNA B-form and it will now U and should lead to A-form 
#
cat foramber.pdb | grep -v HETAT | grep -v REMARK | grep -v CRYST1 | grep -v C7 | grep -v MASTER | grep -v END > tmp1.pdb #remove END and CRYST1 input : foramber.pdb output : tmp1.pdb

awk '!($5="")' tmp1.pdb > tmp2.pdb # remove chain 5th column input : tmp1.pdb  output :tmp2.pdb

cat tmp2.pdb | awk '{ if ($1=="TER") {printf "TER\n"} else  printf ("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f \n", $1, $2, $3, $4, $5, $6, $7, $8) }' > tmp3.pdb # this is now looks loke nab p

sed  -e 's/DG/ G/g' -e  's/DC/ C/g' -e 's/DA/ A/g' -e 's/DU/ U/g'  -e 's/DT/ U/g'  tmp3.pdb > resname.pdb  # /_G/ space is important to keep the for

rm tmp1.pdb 
rm tmp2.pdb 
rm tmp3.pdb
#rm resname.
rm stdout_nonprot.pdb stdout_renum.txt stdout_sslink


