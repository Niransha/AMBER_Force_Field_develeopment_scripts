#!/bin/bash
#SBATCH --job-name=dimExtr
#SBATCH -N 1
#SBATCH -n 1
##SBATCH --gres=gpu:1
#SBATCH --partition=longq7
#SBATCH --exclude=node[008-015,018-026,028,030-031,035-039,041-046,048-051,053-054,056-057,059-065,067-068,071-073,082],nodeamd[009-016]
#SBATCH --mail-type=ALL
#SBATCH --time=100:00:00

echo   "NODE NAMES           = "$SLURM_NODELIST
echo   "CUDA_VISIBLE_DEVICES = "$CUDA_VISIBLE_DEVICES
date
#
# Load the necessary modules, etc...
#
#module load amber16/gnu
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh
#
# Go to the submission dir, and create the necessary temp files under /tmp/$USER
#
cd     $SLURM_SUBMIT_DIR
sleep 1
mkdir /tmp/$USER
mkdir /tmp/$USER/$SLURM_JOBID

rm *_*.pdb
cp * ../extract_dimers_from_pdb.pl /tmp/$USER/$SLURM_JOBID
cd /tmp/$USER/$SLURM_JOBID

./extract_dimers_from_pdb.pl *.cif > error

cp * $SLURM_SUBMIT_DIR
rm -dvfr /tmp/$USER/$SLURM_JOBID

date
