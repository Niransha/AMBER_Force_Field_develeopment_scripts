#!/bin/bash

ssh nkumarachchi2019@koko-login.hpc.fau.edu "bash -s" -- < ./ex.sh "-time" "bye"

echo $1 $2
cd /mnt/rna/home/nkumarachchi2019/scratch/dev_1d_ABGEZ_benckmark_systems
bash scripts/combine_folder_go_in.sh

squeue | grep nku

cd /mnt/rna/home/nkumarachchi2019/scratch/dev_1d_ABGEZ_benckmark_systems/dimers
bash scripts/combine_folder_go_in.sh

squeue | grep nku 


 