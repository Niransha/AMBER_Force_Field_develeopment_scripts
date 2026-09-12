#!/bin/bash
#SBATCH --job-name=cp2
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --mem=25gb
##SBATCH --gres=gpu:1
##SBATCH --partition=shortq7,mediumq7,longq7,shortq7-gpu,longq7-rna
#SBATCH --partition=longq7-rna
##SBATCH --mail-type=ALL
#SBATCH --time=UNLIMITED
##SBATCH --exclusive
##SBATCH --nodelist=nodegpu025

mkdir all_ipynb_sss

SRC_DIR="/mnt/rna/home/nkumarachchi2019/"
DEST_DIR="/mnt/rna/home/nkumarachchi2019/SCRIPTS/all_ipynb_sss"

mkdir -p "$DEST_DIR"

find "$SRC_DIR" -type f -name "*.ipynb" -user nkumarachchi2019 | while read file; do
    cp "$file" "$DEST_DIR/$(basename "$file")_$(date +%Y%m%d_%H%M%S)"
done

echo "All Python scripts copied safely."

