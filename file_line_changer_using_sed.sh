#!/bin/bash
#grep -rl "source /mnt/rna/home/programs/amber22/amber22_athene.sh" | while read -r file; do
#grep -rl "source /mnt/rna/home/programs/amber22/amber.sh" * | while read -r file; do
#grep -rl "source /opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh" | while read -r file; do

grep -rl "source /opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt" | while read -r file; do

#/opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh

echo $file 

#    sed -i  's|/mnt/rna/home/programs/amber22/amber22_athene.sh|/mnt/rna/home/programs/amber22/amber.sh|g' "$file" 
#    sed -i  's|/mnt/rna/home/programs/amber22/amber.sh|/mnt/rna/home/programs/amber22/amber.sh|g' "$file" 

#     sed -i  's|/opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh|/mnt/rna/home/programs/amber22/amber.sh|g' "$file" 
     sed -i  's|/opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt|/mnt/rna/home/programs/amber22/amber.sh|g' "$file" 



done