#!/bin/bash

#mkdir 1AL5  1BNA  1SDR  2KOC  AAAA  CAAU  CCCC GACC_tmp

for fol in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "??" \)) ;
do
cd $fol

        echo $fol
        rm *

        scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_dimers/$fol/last.*.pdb ./
        scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_dimers/$fol/*.new.pdb ./
        
        scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_dimers/$fol/combine ./



cd ../
done




#cd ./GACC_tmp
#rm*

#scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_ff_GACC/last.*.pdb ./
#scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_ff_GACC/*.new.pdb ./
#scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_2d_ff_GACC/combine ./
#cd ../