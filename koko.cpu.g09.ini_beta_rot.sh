#!/bin/bash
#SBATCH --job-name=g09
##SBATCH -N 1
#SBATCH -n 9
##SBATCH --gres=gpu:1
#SBATCH -p longq7
##SBATCH --nodelist=nodeamd003
##SBATCH --exclude=nodeeng[003-004],nodegpu[022-025]
#SBATCH --exclusive
##SBATCH -p shortq7
#SBATCH --mail-type=ALL
#SBATCH --time=168:00:00
#echo   "CUDA_VISIBLE_DEVICES = "$CUDA_VISIBLE_DEVICES
#
# Load the necessary modules, etc...
#
csh
date
echo $SLURM_NODELIST
cd     $SLURM_SUBMIT_DIR
#csh
module load gaussian/R09
#
# Create the scratch directory in the compute node temp directory
#
mkdir -p /tmp/$USER
mkdir -p /tmp/$USER/$SLURM_JOBID
export GAUSS_SCRDIR="/tmp/$USER/$SLURM_JOBID"

#cd /tmp/$USER/$SLURM_JOBID
#
# Run the G09 job
#

cp pes.com sample.pes.com

#g09 pes.com pes.log

init=180.00
for (( a=$init; a < 360 + $init; a+=10 ))
do

  mkdir b_$a
  #cd b_$a	
 
  #cat ../sample.pes.com | sed 's/21 22 25 26 0.00 B/21 22 25 26 '$a'.00 B/g' > pes.com # b
  #cp ../pes.chk ./

	### change b	 
#6 15 21 22 210.00 B

  cat sample.pes.com | sed 's/6 15 21 22 210.00 B/6 15 21 22 '$a'.00 B/g' > pes.com # b
  
  g09 pes.com  pes.log
 
	sleep 1 
 
  cp pes.chk ./b_$a/
  cp pes.com ./b_$a/
  
  cp pes.log pes.$a\.log
  formchk pes.chk pes.$a\.fchk
 
  cp pes.$a\.log ./b_$a
  cp pes.$a\.fchk ./b_$a
  
 
 	
done

#g09 pes.com > pes.log

#
#cp pes.fchk.gz pes.log $SLURM_SUBMIT_DIR
#

rm -dvfr $GAUSS_SCRDIR

sleep 1
date

