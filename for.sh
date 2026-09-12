#!/bin/bash

cdir=`pwd`
edir=$(dirname "0") # executing directry

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "1BNA" -o -name "1SDR" -o -name "2KOC" -o -name "1D0U" \) ); #--- [1]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "XCCCC" -o -name "GACC" -o -name "UUUU" \) ); # --- [2]
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "17RA" -o -name "1D0U" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "????" \) );

#1AL5/  1K8S/        1SDR/  2KOC/  2koc_2017ag/  4XKO/  CAAU/  GACC/  backups/             cugr/     dimers/   test_2koc/  wrong_confor_2koc/
#1BNA/  1L2X_psedo/  1ZIH/  2LK3/  4AS4/         AAAA/  CCCC/  UUUU/  basetriple_a_bulge/  cugr300/  scripts/  test_hrpn/

#all 
#for folder in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "2KOC" -o -name "1BNA" -o -name "1SDR" -o -name "2LK3" -o -name "4AS4" -o -name "1ZIH" -o -name "basetriple_a_bulge" -o -name "4XKO" -o -name "1L2X_psedo" -o -name "test_hrpn" -o -name "test_2koc" -o -name "cugr" -o -name "cugr300" -o -name "wrong_confor_2koc" -o -name "2koc_2017ag" -o -name "2lk3_2017ag" -o -name "cug_3dpred" -o -name "CUG_fAAAAAAAAAAAA" -o -name "cug_rep_Aform_310.15" \) ); # --- [2]

#running 
#for folder in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "1AL5" -o -name "2KOC" -o -name "1BNA" -o -name "1SDR" -o -name "2LK3" -o -name "4AS4" -o -name "1ZIH" -o -name "basetriple_a_bulge" -o -name "4XKO" -o -name "1L2X_psedo" -o -name "test_hrpn" -o -name "test_2koc" -o -name "cugr" -o -name "cugr300" -o -name "wrong_confor_2koc" -o -name "2koc_2017ag" -o -name "2lk3_2017ag" -o -name "cug_3dpred" -o -name "CUG_f1" -o -name "CUG_f2" -o -name "CUG_f3" -o -name "CUG_f4" -o -name "CUG_f5" -o -name "cug_rep_Aform_310.15" \) ); # --- [2]
		
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA" -o -name "CAAU" -o -name "CCCC" -o -name "GACC" -o -name "UUUU" \) ); # --- [2]

#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "CUG_f*" \) );

for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA_nobeta" -o -name "UUUU_nobeta" -o -name "AAAA_2012*" -o -name "UUUU_2012*" -o -name "AAAA_parm10" -o -name "UUUU_parm10" -o -name "AAAA_chirestrained" -o -name "UUUU_chirestrained" -o -name "AAAA_roc" -o -name "UUUU_roc" -o -name "AAAA_rocchi1dbeta" -o -name "UUUU_rocchi1dbeta" -o -name "AAAA_OL" -o -name "UUUU_OL" \) );
#for folder in $(find . -maxdepth 1 -mindepth 1 -type d \( -name "AAAA_OL" -o -name "UUUU_OL" \) );
do
cd $folder

echo $folder "#################"
folname=`basename $folder` 

#combine2 0.9 , comb3 1.2 comb4 1.5


############################### cd combine ##################################

#mkdir combine
#cd combine

#rm combined_md.mdcrd slurm*

#sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh   # NO resnames @1-4 in this script

#ls *

#joe cpptraj.*.rmsd.sh

#sbatch cpptraj.*.rmsd.sh



########  reguler sims like 2KOC CUG_test etc ###################################

#mkdir combine
#cd combine

#rm combined_md.mdcrd slurm*

	# combine all
#jb1=$(sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh)   # run combine
#id1=`echo $jb1 | awk '{print $4}'`

	#rmsd with respect to fist frame
#jobsub=$(sbatch --dependency=afterany:$id1 cpptraj.*.rmsd.sh)  # rmsd calc uniq in each folders
#id2=`echo $jobsub | awk '{print $4}'`

#echo " second job $id2 depends on $id1 #####"

#cd ../


####################### convergence clustering folder ############## A

mkdir combine_convclus
cd combine_convclus


cp ../combine/combined_md.mdcrd ./
cp ../combine/strip.prmtop.new ./

sbatch $SCRIPTPATH/cluster_convergence_clus/cpptraj.reference_pdb.sh
ls
cp  $SCRIPTPATH/cluster_convergence_clus/* ./

sbatch koko_convergence_cluster.sh

cd ../

############################## cd torsion_probabilities ######
#	change folders to AAAA XXXX GACCC etc 

#mkdir torsion_probabilities
#cd torsion_probabilities

	## get Alltorsion1.dat
#cp $SCRIPTPATH/cpptraj.torsion_analysis.sh ./
#sbatch cpptraj.torsion_analysis.sh

	#### wait till cpptraj.torsion_analysis.sh  done then run following
#cp $SCRIPTPATH/xmgrace_gen_normalized_histogram_ABGEZnCHI_of_trajec.sh ./
#bash xmgrace_gen_normalized_histogram_ABGEZnCHI_of_trajec.sh


#display hist_alfa_*.png
#display hist_beta_*.png
#display hist_gamma_*.png
#display hist_delta_*.png
#display hist_epsi_*.png
#display hist_zeta_*.png
#display hist_chi_*.png


#mkdir $SCRIPTPATH/PLOTS_tetramers_new_1Dcomb_normalized_ABGEZ
#cp *.png $SCRIPTPATH/PLOTS_tetramers_new_1Dcomb_normalized_ABGEZ


#cd ../

#################### AAAA and UUUU no beta - Chirestrained and etc ################################# 
#ls -ltr md_*.rst
#ls -ltr md_*.mdcrd

mkdir combine
cd combine

#:<<'AAA'
rm combined_md.mdcrd slurm* *.pdb

        # combine all
jb1=$(sbatch $SCRIPTPATH/cpptraj.combine_md_all.sh)   # run combine
id1=`echo $jb1 | awk '{print $4}'`


cp $SCRIPTPATH/cpptraj_rmsd_scripts/cpptraj.AAAA.rmsd.sh ./


        #rmsd with respect to fist frame
jobsub=$(sbatch --dependency=afterany:$id1 cpptraj.AAAA.rmsd.sh)  # rmsd calc uniq in each folders
id2=`echo $jobsub | awk '{print $4}'`

echo " second job $id2 depends on $id1 #####"

#AAA

#ls -lthr *.mdcrd
cd ../





########################################################
#mkdir combine4
#cp combine/combined_md.mdcrd combine4/
#cp combine/strip.prmtop.new combine4/
#cd combine4 
#sbatch ../../scripts/cluster.dbscan.cpptraj.hpc.sh
#cd ../

cd ../ # AAAA
done





