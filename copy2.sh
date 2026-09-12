#!/bin/bash
#SBATCH --job-name=cp2
#SBATCH -N 1
#SBATCH -n 16 
#SBATCH --mem=50gb
##SBATCH --gres=gpu:1
##SBATCH --partition=shortq7,mediumq7,longq7,shortq7-gpu,longq7-rna
#SBATCH --partition=longq7-rna
##SBATCH --mail-type=ALL
#SBATCH --time=UNLIMITED
##SBATCH --exclusive
##SBATCH --nodelist=nodegpu025


#rsync -P --stats /mnt/rna/home/project_tetraloop_mbondi3/* /mnt/rna/home/nkumarachchi2019/scratch/project_tetraloop_mbondi3/
#rsync -r -P /mnt/rna/home/project_tetraloop_mbondi3/* /mnt/rna/home/nkumarachchi2019/scratch/project_tetraloop_mbondi3/ 

# many file folder 
#nohup rsync -r -P --include='pes.com' --include='pes.chk' --exclude='*.log' --exclude='*.fchk' --exclude='*pdb' /mnt/rna/home/nkumarachchi2019/monomer_d1d2chi_QM_done/A/O_chi2_rest_P_chi_all_in_one/* /mnt/rna/home/nkumarachchi2019/monomer_d1d2chi_QM_done/A/P_chi_all_in_one/ >  nohup2.out &
rsync -r -P --include='pes.com' --include='pes.chk' --exclude='*.log' --exclude='*.fchk' --exclude='*pdb' /mnt/rna/home/nkumarachchi2019/monomer_d1d2chi_QM_done/A/O_chi2_rest_P_chi_all_in_one/* /mnt/rna/home/nkumarachchi2019/monomer_d1d2chi_QM_done/A/P_chi_all_in_one/ 

echo "DONE ##########################"








