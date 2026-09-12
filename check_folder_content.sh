#!/bin/bash
shopt -s extglob		# open pattern shell

for dimer_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "dimer_*" \) ) ;
do 
cd $dimer_dir
  echo $dimer_dir "########################################## "
  
  dimer2=`pwd | awk '{split($1,a,"/") ; print (a[7])}' | awk '{split($a[7],b,"_"); print (b[2])}'` # get dimer name by pwd	
  		
#   ls -l | wc	
	
#  cd ./qm_hf_mp2_631g			 			
   for directory_rot in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "*gamma" \) ) ; #find directory in depth of 1 and 1
   do 
   cd $directory_rot
      echo $directory_rot "########################################## "
     
      tor2=`pwd | awk '{split($1,a,"/") ; print (a[8])}' | awk '{split($a[8],b,"_"); print (b[2])}'` # get tortion name by pwd
 
# 	 ls -l | wc	 	


	#####################################

#$##$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
								######### check here * or 10 ###		
		for angles_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "angle_*" \) ) ; 
		do
		cd $angles_dir
		echo $angles_dir "########################################## "
	
		ls -l | wc
#	pwd



	#angle #####
	cd ../
	done
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$##$#$#$

	
  #rotation #####	
  cd ../	
  done
#cd ../ link to cd ./qm_hf_mp2_631g 
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