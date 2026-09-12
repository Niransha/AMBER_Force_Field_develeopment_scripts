#!/bin/bash

cdir=`pwd`
edir=$(dirname "0") # executing directry

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "2KOC" \) );
for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1BNA" -o -name "1SDR" -o -name "GACC" -o -name "1AL5" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "1BNA" -o -name "1SDR" -o -name "2KOC" -o -name "1D0U" \) ); #--- [1]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "CCCC" -o -name "GACC" -o -name "1K8S" -o -name "UUUU" \) ); # --- [2]

#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "17RA" -o -name "1D0U" \) );
do
cd $folder

#	echo $cdir
	echo $folder "#################"
#	echo $SCRIPT
#	echo $SCRIPTPATH
	
	#joe atlas.gpu_run_min_eq_prodction.sh
	
	#get last md form a pdb
	rm last.*.pdb 
	$SCRIPTPATH/get_last_MD_pdb.sh

	mkdir combine
	cd combine
        rm slurm*
        rm combine*
	sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh
#	sbatch $SCRIPTPATH/cpptraj.combine_md_10.sh

	cd ../
			

cd ..
done



