#!/bin/bash

#for (( i=0; i<=95; i++ ))
#do  
# printf " $(echo clus_$i)           $(ncdump -h clust_traj.c$i | grep UNLIMITED | awk '{print($6)}' | sed s/\(//g) \n" 


#done


# cat tmp | awk '{g++; a=a+$2; print(g" "$1" "a)}'

#:<< 'AAA'
nclus=`ls -ltrd cluster_*/ | wc | awk '{print $1}'`

for (( i=0; i<$nclus; i++ ))
do  
 printf " $(echo clus_$i)           $(ncdump -h cluster_$i/mdcrd.netcdf | grep UNLIMITED | awk '{print($6)}' | sed s/\(//g) \n" 


done > clus_vs_pupulation.dat

echo "##################"

sort -nk2 clus_vs_pupulation.dat | tac | head -n 20

total=`cat clus_vs_pupulation.dat | awk '{a=a+$2}END{print a}'`

sort -nk2 clus_vs_pupulation.dat | tac | head -n 20 | awk -v tot=$total '{s++; printf("%-10s%-10d%2.2f%1s\n", $1,$2,($2*100/tot),"%" )}END{print("total  " tot)}' > clus_pop_precentages.dat

echo "##################"

cat clus_pop_precentages.dat

#AAA

cat clus_pop_precentages.dat | grep -v tot | awk '{split($1,a,"_"); print a[2] }' | \
 awk '{printf(" -f cluster_"$1"/avg.pdb")}END{print(" -e ~/scripts/vmd_render/this_vmd_ren_looped_20_lines_AND_newRebbons_backbone_remove_wat_no_snap.tcl")}'


#folder
cat clus_pop_precentages.dat | grep -v tot | awk '{split($1,a,"_"); print a[2] }' | \
  awk '{print("scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_1d_ABGEZ_benckmark_systems/AAAA/combine_convclus_1.5/cluster_"$1" ./") }' 
  
 #folder 2017_ag
#cat clus_pop_precentages.dat | grep -v tot | awk '{split($1,a,"_"); print a[2] }' | \
#  awk '{print("scp -r $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_1d_ABGEZ_benckmark_systems/2017ag_tetramers/AAAA/combine_convclus_1.5/cluster_"$1" ./") }'   												  # ^^^ 					












