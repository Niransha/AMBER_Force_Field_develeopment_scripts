#!/bin/bash

cdir=`pwd`
edir=$(dirname "0") # executing directry

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "1BNA" -o -name "1SDR" -o -name "2KOC" -o -name "1D0U" \) ); #--- [1]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "XCCCC" -o -name "GACC" -o -name "UUUU" \) ); # --- [2]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "17RA" -o -name "1D0U" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "????" \) );

#for folder in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "2LK3" -o -name "4AS4" -o -name "1ZIH" -o -name "basetriple_a_bulge" -o -name "4XKO" -o -name "1L2X_psedo" -o -name "test_hrpn" -o -name "test_2koc" \) ); # --- [2]

#for folder in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "2LK3" -o -name "4AS4" -o -name "1ZIH" -o -name "1L2X_psedo" -o -name "2KOC" \) ); # --- [2]

for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "4A*" \) );
do
cd $folder

echo $folder "#################"
folname=`basename $folder` 


scp -r  $cpkoko/mnt/rna/home/nkumarachchi2019/scratch/dev_1d_ABGEZ_benckmark_systems/$folname/combine/* ./


vmd -parm7 strip.prmtop.new -netcdf combined_md.mdcrd -e ../rmsd_of_a_trajectory.tcl

#gnuplot ../gnu_traj_plot_no_cluster.gp

#vmd -parm7 strip.prmtop.new -netcdf combined_md.mdcrd 


cd ../
done



