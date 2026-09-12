#!/bin/bash
#SBATCH --job-name=GG
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH --partition=shortq7-gpu
#SBATCH --mail-type=ALL
#SBATCH --time=6:00:00
#SBATCH --mem=50gb
#SBATCH --nodelist=nodenviv100013

echo   "NODE NAMES           = "$SLURM_NODELIST
echo   "CUDA_VISIBLE_DEVICES = "$CUDA_VISIBLE_DEVICES
#
# Load the necessary modules, etc...
#
#module load amber16/gnu
source /opt/ohpc/pub/apps/rnachem/amber18/modules2load.txt
source /opt/ohpc/pub/apps/rnachem/amber18/amber.sh
#
# Go to the submission dir, and create the necessary temp files under /tmp/$USER
#
cd     $SLURM_SUBMIT_DIR
sleep 1
mkdir -p /tmp/$USER
sleep 1
mkdir -p /tmp/$USER/$SLURM_JOBID
sleep 1
#
# Copy the files to the recently created temp directory
#
#cp    ../production_run.pl ./md_*.rst ./mdeq2.rst ./prmtop /tmp/$USER/$SLURM_JOBID
###cp ./inpcrd ./min*.rst ./eq*.rst ./prmtop ../../run_eq.sh ../../run_min.sh ../../production_run.pl ../../md.in /tmp/$
###sleep 1
###cd    /tmp/$USER/$SLURM_JOBID
###sleep 1
#
# Run min, eq, and then production...
#
################perl ./production_run.pl > error.prod
#####csh ./run_min.sh
###sleep 1
####csh ./run_eq.sh
####sleep 1

	    #md_rst included	
cp ./inpcrd ./md_*.rst ./min*.rst ./eq*.rst ./prmtop ./prmtop.new ./run_eq.sh ./run_min.sh ./production_run.pl ./md.in /tmp/$USER/$SLURM_JOBID
sleep 1
cd    /tmp/$USER/$SLURM_JOBID
sleep 1

cp * $SLURM_SUBMIT_DIR
perl ./production_run.pl  > error.prod
#line for copy to submitted directory is inside the productio_run.pl
sleep 1
cp ./error.prod $SLURM_SUBMIT_DIR
#
# Remove the temp directory
#
rm -dvfr /tmp/$USER/$SLURM_JOBID
sleep 1
cd $SLURM_SUBMIT_DIR
sleep 1
# ./GG 




