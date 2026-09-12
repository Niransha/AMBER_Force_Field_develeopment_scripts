#!/bin/bash

#SBATCH --job-name=%x
#SBATCH -N 1
#SBATCH -n 20 
##SBATCH --gres=gpu:1
#SBATCH --partition=shortq7,mediumq7,longq7,shortq7-gpu,longq7-rna
##SBATCH --partition=longq7-rna
##SBATCH --mail-type=ALL
#SBATCH --time=6:00:00
##SBATCH --exclusive
##SBATCH --nodelist=nodegpu025


###################################
#load amber 18 on atlas
###################################
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt

rm rmsd*

cat>input<<EOF
parm ./strip.prmtop.new
trajin ./combined_md.mdcrd

symmrmsd ToFirst :1-24&!@H= first out rmsd1.agr mass

rms first out rmsd1.dat

go
EOF

#cpptraj -i input

mpirun -n 20 cpptraj.MPI -i input

