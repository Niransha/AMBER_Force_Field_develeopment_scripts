#!/bin/bash

#for (( i=0; i<=95; i++ ))
#do  
# printf " $(echo clus_$i)           $(ncdump -h clust_traj.c$i | grep UNLIMITED | awk '{print($6)}' | sed s/\(//g) \n" 


#done


# cat tmp | awk '{g++; a=a+$2; print(g" "$1" "a)}'


last=`ls -ltrd cluster_* | grep ^dr | awk '{ split($NF,a,"_"); print(a[2])}' | sort -nk1 | tail -1`

for (( i=0; i<=$last; i++ )); 
do  
  printf " $(echo $i)  $(ncdump -h cluster_$i/mdcrd.netcdf | grep UNLIMITED | awk '{print($6)}' | sed s/\(//g) \n" ;  

  done > tmp1
  
  
#sort -nk2,2 tmp1

sort -nk2,2 tmp1 | tail -20 | tac 

sort -nk2,2 tmp1 | tail -20 | tac | awk '{printf(" -f cluster_"$1"/avg.pdb ")}'  

echo "##########"

sort -nk2,2 tmp1 | tail -20 | tac | awk '{printf(" -f cluster_"$1"/avg.pdb ")}END{print(" -e ~/scripts/vmd_render/this_vmd_ren_looped_20_lines_AND_newRebbons_backbone_remove_wat_no_snap.tcl")}'



