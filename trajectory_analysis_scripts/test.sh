#!/bin/bash

#sed -e "1,1d" cnu*.dat > frame_vs_clusters.dat

vmd -parm7 strip.prmtop.new -netcdf combined_md.mdcrd -e ../rmsd_of_a_trajectory.tcl

gnuplot ../gnu_traj_plot_no_cluster.gp


