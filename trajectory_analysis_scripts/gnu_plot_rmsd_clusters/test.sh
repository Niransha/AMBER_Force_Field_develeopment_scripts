#!/bin/bash

#sed -e "1,1d" cnu*.dat > frame_vs_clusters.dat

paste rmsd.dat cnumvtime.dat | awk '{print $1"\t"$2"\t"$4}' > tmp.dat  # frames to time in gnuplot script


sed -i "s/-1/0/g" tmp.dat # remove -1 s

cat tmp.dat | awk '{if($3>9) $3=0;  print($0) }' > plot_gnu_data.dat

gnuplot gnuplot.gp

set terminal pngcairo size 3000,1300 enhanced font 'Arial,12' linewidth 1.5 background rgb '#f0f0f0'
set output 'output.png'





