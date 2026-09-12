#!/bin/bash
#
# Written by IY on Sept. 8, 2020
#
# This script is going to be run in a dimer step where you have results for individual angles such as angle_10, angle_20, ...
#
# Extract MM energies (zero energies)
#
dim3=`pwd | awk '{split($1,a,"/") ; print (a[7])}' | awk '{split($a[7],b,"_"); print (b[2])}'`
tor3=`pwd | awk '{split($1,a,"/") ; print (a[8])}' | awk '{split($a[8],b,"_"); print (b[2])}'`

grep Etot angle_*/md.out | \
awk '{ \
  split($1,a,"/"); \
  split(a[1],b,"_"); \
  angle=b[2]; \
  etot=$4; \
  print angle"\t"etot \
}' | sort -nk1,1  > E_MM_zero_$dim3\_$tor3.txt
#
cat E_MM_zero_$dim3\_$tor3.txt | \
awk '{ \
  s++; \
  if(s==1){ \
  min=9999}; \
  if($2<min){ \
    min=$2 \
  }; \
  e[s]=$2; \
  a[s]=$1 \
} END { \
  for(i=1; i<=s; i++){ \
    diff=sprintf("%.6f", e[i]-min); \
    print a[i]"\t"diff \
  } \
}' > E_MM_zero_refpoint_zero_$dim3\_$tor3.txt
#
# Extract QM energies
#
grep EUMP2 angle_*/pes.log | \
awk '{ \
  cf=627.509474; \
  split($1,a,"/"); \
  split(a[1],b,"_"); \
  angle=b[2]; \
  split($NF,a,"D"); \
  v1=a[1]; \
  v2=a[2]; \
  gsub(/\+/,"",v2); \
  energy=sprintf("%.10f", v1*10^v2*cf); print angle"\t"energy \
}' | sort -nk1,1 > E_QM_$dim3\_$tor3.txt
#
cat E_QM_$dim3\_$tor3.txt | \
awk '{ \
  s++; \
  if(s==1){ \
  min=9999}; \
  if($2<min){ \
    min=$2 \
  }; \
  e[s]=$2; \
  a[s]=$1 \
} END { \
  for(i=1; i<=s; i++){ \
    diff=sprintf("%.10f", e[i]-min); \
    print a[i]"\t"diff \
  } \
}' > E_QM_refpoint_zero_$dim3\_$tor3.txt
#
# Difference between QM and MM_zero
#
paste E_QM_$dim3\_$tor3.txt E_MM_zero_$dim3\_$tor3.txt | \
awk '{ \
  diff=sprintf("%.10f", $2-$4); \
  print $1"\t"diff \
}' > E_QM-MM_zero_$dim3\_$tor3.txt
#
cat E_QM-MM_zero_$dim3\_$tor3.txt | \
awk '{ \
  s++; \
  if(s==1){ \
  min=9999}; \
  if($2<min){ \
    min=$2 \
  }; \
  e[s]=$2; \
  a[s]=$1 \
} END { \
  for(i=1; i<=s; i++){ \
    diff=sprintf("%.6f", e[i]-min); \
    print a[i]"\t"diff \
  } \
}' > E_QM-MM_zero_refpoint_zero_$dim3\_$tor3.txt
