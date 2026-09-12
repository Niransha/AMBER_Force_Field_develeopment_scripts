#!/bin/bash
#SBATCH --job-name=g09
##SBATCH -N 1
#SBATCH -n 1
##SBATCH --gres=gpu:1
#SBATCH -p longq7-rna
#SBATCH --exclude=nodegpu[021-025]
##SBATCH --nodelist=nodeamd002
##SBATCH -p shortq7
#SBATCH --mail-type=ALL
#SBATCH --time=168:00:00
#echo   "CUDA_VISIBLE_DEVICES = "$CUDA_VISIBLE_DEVICES


csh
date
echo $SLURM_NODELIST
cd     $SLURM_SUBMIT_DIR

#module load amber16/gnu
source /opt/ohpc/pub/apps/rnachem/amber18/modules2load.txt
source /opt/ohpc/pub/apps/rnachem/amber18/amber.sh


mkdir -p /tmp/$USER
mkdir -p /tmp/$USER/$SLURM_JOBID
export SAND_SCRDIR="/tmp/$USER/$SLURM_JOBID"



csh ./runmin

rm -dvfr $SAND_SCRDIR

sleep 1
date