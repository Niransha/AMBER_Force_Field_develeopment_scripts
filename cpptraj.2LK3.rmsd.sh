#!/bin/bash

#SBATCH --job-name=cpprmsd
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

rm rmsd*.agr
rm rmsd*.dat
rm first.pdb last.pdb

find $SLURM_SUBMIT_DIR -maxdepth 1 -type f \( -name "slurm-*" ! -name "slurm-$SLURM_JOB_ID.out" \) -delete

###############################
cat>input<<EOF
parm ./strip.prmtop.new
trajin ./combined_md.mdcrd


symmrmsd ToFirstAll2-23 :1-24&!@H= first out rmsd1.agr mass time 0.00002 xlabel "  " 
symmrmsd ToFirstHairpin12-15 :12-15&!@H= first out rmsd1.agr mass time 0.00002 
symmrmsd ToFirstStem2-3,8-11,16-19,22-23 :2-3,8-11,16-19,22-23&!@H= first out rmsd1.agr mass time 0.00002 
symmrmsd ToFirstBulge4-7 :4-7&!@H= first out rmsd1.agr mass time 0.00002
symmrmsd ToFirstBulge20-21 :20-21&!@H= first out rmsd1.agr mass time 0.00002


symmrmsd ToFirstAll :1-24&!@H= first out rmsd1.dat mass time 0.00002 xlabel "  " 
symmrmsd ToFirstHairpin :12-15&!@H= first out rmsd1.dat mass time 0.00002 
symmrmsd ToFirstStem :2-3,8-11,16-19,22-23&!@H= first out rmsd1.dat mass time 0.00002 
symmrmsd ToFirstBulgeSideA :4-7&!@H= first out rmsd1.dat mass time 0.00002
symmrmsd ToFirstBulgeSideB :20-21&!@H= first out rmsd1.dat mass time 0.00002


go
EOF

#cpptraj -i input

mpirun -n 20 cpptraj.MPI -i input


############################

cat>input2<<EOF

parm ./strip.prmtop.new
trajin ./combined_md.mdcrd 1 1
trajout first.pdb pdb
run
EOF

cpptraj -i input2

############################

cat>input3<<EOF

parm ./strip.prmtop.new
trajin ./combined_md.mdcrd lastframe
trajout last.pdb pdb 
run
EOF


cpptraj -i input3



  