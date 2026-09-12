#!/usr/bin/sh

#SBATCH --job-name=aMD
#SBATCH -n 1
#SBATCH -p gpu-rnachem
#SBATCH --gress=gpu:1
#SBATCH --output=error.out

module load amber16/gnu

sander -O -i a_vac_min.in -o a_vac_init_min.out -c a_vac.rst7 -p a_vac.prmtop -r a_vac_init_min.ncrst