#!/bin/bash

cdir=`pwd`
edir=$(dirname "0") # executing directry

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "2KOC" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1BNA" -o -name "1SDR" -o -name "GACC" -o -name "1AL5" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "1BNA" -o -name "1SDR" -o -name "2KOC" -o -name "1D0U" \) ); #--- [1]

#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "CCCC" -o -name "UUUU" \) ); # --- [2]
for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "2KOC" \) );

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
	
#	sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh
#	sbatch $SCRIPTPATH/cpptraj.combine_md_10.sh

	jb1=$(sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh)
	id1=`echo $jb1 | awk '{print $4}'`	
	echo  " combine job $id1 "
	echo  " combine job $id1 "  >> jobs.txt
	nid=$id1

	#for clustering	
	jobsub=$(sbatch --dependency=afterany:$nid $SCRIPTPATH/cluster.dbscan.cpptraj.hpc.sh)
	nid=`echo $jobsub | awk '{print $4}'`
	echo " cluster job $nid depends on $id1 #####"
	echo " cluster job $nid depends on $id1 #####"  >> jobs.txt

	
	cd ../ #exit combine
			

cd ..
done



