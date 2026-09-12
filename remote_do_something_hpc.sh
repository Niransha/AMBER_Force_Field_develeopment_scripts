#!/bin/bash

#ssh nkumarachchi2019@koko-login.hpc.fau.edu "bash -s" -- < ./ex.sh "-time" "bye"

echo $1 $2
cd /mnt/beegfs/scratch/nkumarachchi2019/dev_AGEZ_2d_benchmark_systems
bash scripts/folder_go_in.sh

squeue | grep nku

cd /mnt/beegfs/scratch/nkumarachchi2019/dev_1dcomb_AGEZ_benchmark_systems/
bash scripts/folder_go_in.sh

squeue | grep nku 


 