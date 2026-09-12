#!/bin/bash

cdir=`pwd`
edir=$(dirname "0") # executing directry

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "1BNA" -o -name "1SDR" -o -name "2KOC" -o -name "1D0U" \) ); #--- [1]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "CCCC" -o -name "GACC" -o -name "1K8S" -o -name "UUUU" \) ); # --- [2]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "17RA" -o -name "1D0U" \) );
for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "????" \) );
do
cd $folder

echo $folder "#################"
folname=`basename $folder` 


#	echo $cdir
#	echo $folder "#################"
#	echo $SCRIPT
#	echo $SCRIPTPATH
	#rm prmtop prmtop.new


if [[ $folname == "1AL5" || $folname == "1BNA" || $folname == "1SDR" || $folname == "2KOC" || $folname == "1D0U" ]]; then 

#       rm prmtop prmtop.new
#       tleap -f $SCRIPTPATH/xleap.new.water.in &&     # with ---[1] use 
#       perl $SCRIPTPATH/create_correct_prmtop.pl       # use this one as well  

        parmed -i ../scripts/parmed_commands -p ./prmtop.new -e

	ambpdb -aatm -p prmtop.new -c inpcrd > test.pdb

elif [[ $folname == "AAAA" || $folname == "CAAU" || $folname == "CCCC" || $folname == "GACC" || $folname == "UUUU" || $folname == "1K8S" ]]; then


#       joe $SCRIPTPATH/xleap.new.water.in_for_nab_pdbs  # with  --- [2]   # change the name
#       rm prmtop prmtop.new
#       sleep 1 
#       tleap -f $SCRIPTPATH/xleap.new.water.in_for_nab_pdbs   # with --- [2]
#       perl $SCRIPTPATH/create_correct_prmtop.pl               # use this one too

        parmed -i ../scripts/parmed_commands -p ./prmtop.new -e

	ambpdb -aatm -p prmtop.new -c inpcrd > test.pdb
fi
	
#	cp $SCRIPTPATH/run_eq.sh ./
#	cp $SCRIPTPATH/run_min.sh ./
#	cp $SCRIPTPATH/production_run.pl ./
#	cp $SCRIPTPATH/atlas.gpu_run_min_eq_prodction.sh ./
#	cp $SCRIPTPATH/md.in ./
	
#	joe atlas.gpu_run_min_eq_prodction.sh

#	parmed -i ../scripts/parmed_commands -p ./prmtop.new -e 
	
	#get last md form a pdb
#	$SCRIPTPATH/get_last_MD_pdb.sh
	

cd ..
done




