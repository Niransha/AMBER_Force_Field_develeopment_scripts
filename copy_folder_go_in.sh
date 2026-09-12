#!/bin/bash
shopt -s extglob		# open pattern shell

for dimer_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "dimer_*" \) ) ;
do 
cd $dimer_dir
  echo $dimer_dir "########################################## "
  
  dimer2=`pwd | awk '{split($1,a,"/") ; print (a[7])}' | awk '{split($a[7],b,"_"); print (b[2])}'` # get dimer name by pwd	
  		
			
   for directory_rot in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "*gamma" \) ) ; #find directory in depth of 1 and 1
   do 
   cd $directory_rot
      echo $directory_rot "########################################## "
     
      tor2=`pwd | awk '{split($1,a,"/") ; print (a[8])}' | awk '{split($a[8],b,"_"); print (b[2])}'` # get tortion name by pwd
	
#       this was done in a full path script /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/submit_all_jobs.sh & ##4 run inside rotation_* folder  
	
        ####### md.out count #########################################
 
#	 ls -l ./angle_*/md.out | wc  ##5
	
	######### get qm and mm profiles ###############################

#	rm mm_prof_tmp3* ##5.2
#	rm qm_prof_tmp4* ##5.2
#	bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/profiles.sh ##5.2

        ######### check torsions energy #########

#       sed -n '/FINAL RESULTS/,$p' */min2.out | grep "Torsion" */min2.out  ##6

        #####################################
	
#	bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/extract_e_zero_ene_dirInLable.sh ##7 get qm and mm profiles
	# file renaming included in the extract script

	###################################################
	
	########## get parmeters #######################################

	rm parameters_*  ##8
	bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_params.sh  ##8
	mv parameters.txt parameters_$dimer2\_$tor2.txt  ##8 rename


	#####################################

#$##$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
								######### check here * or 10 ###		
#		for angles_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "angle_*" \) ) ; 
#		do
#		cd $angles_dir
#		echo $angles_dir "########################################## "

#	pwd

	######## remove unwanted files in qm optimized folder ##########

#	rm -rf !("opt.xyz"|"pes.log")  # except these two  ##1

 	######### create opt.xyz #################
#	/home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/extract_single_structure.sh  ##2  

	################ check for RST (restrains and sample.pdb atoms || inside angle_10 #####
#	bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/check_RST_terms_equal.sh ## 4

#	run simulation ##4 crate new all_paths, commands are in commnd file and use submit_all_576.jobs ##3
	
#	tleap -f ../xleap.in 
#	perl ../create_correct_prmtop.pl


#	perl ../create_init_md.pl



	#angle #####
#	cd ../
#	done
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$##$#$#$

	
  #rotation #####	
  cd ../	
  done
  
#dimer ###### 
cd ../
done

shopt -u extglob 	# closing pattern shell

echo "DONE ####################### "


#part I
#finding the the directories;
# file structure a/b/c/d you're in .a/

#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 3 -mindepth 2
#./b/c
#./b/c/d
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 1 -mindepth 2
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 1 -mindepth 3
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 3 -mindepth 3
#./b/c/d
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 3 -mindepth 1
#./b
#./b/c
#./b/c/d
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 3 -mindepth 2
#./b/c
#./b/c/d
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 3 -mindepth 3
#./b/c/d
#hutch_lap@DESKTOP-3G86THH:~/a$ find . -maxdepth 1 -mindepth 1
#./b