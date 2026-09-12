#!/bin/bash
#SBATCH --job-name=1x1_CU_md
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH --partition=shortq7
##SBATCH --nodelist=nodenviv[100001-100005,100016]
#SBATCH --exclude=nodenviv[100006-100015]
#SBATCH --mail-type=ALL
#SBATCH --time=6:00:00
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
cp    ../production_run.pl ./md_*.rst ./mdeq2.rst ./prmtop /tmp/$USER/$SLURM_JOBID
sleep 1
cd    /tmp/$USER/$SLURM_JOBID
sleep 1
#
# Run production runs
#
perl ./production_run.pl > error.prod
sleep 1
#
# Remove the temp directory
#
rm -dvfr /tmp/$USER/$SLURM_JOBID
sleep 1
cd $SLURM_SUBMIT_DIR
sleep 1
#
# Decide if we want to run the md again
#
val=`ls -l md_1/md_50.rst 2> /dev/null | awk 'BEGIN{s=0}{s++}END{print s}'`
if [ ! $val  == 1 ]
then
  sbatch ../atlas.gpu.for_md.sh   # if md_50. will not run this script
fi