#!/bin/bash

SCRIPT=`realpath $0`
SCRITPATH=`dirname $SCRIPT`

shopt -s extglob                # open pattern shell
module load openbabel-3.0.0-gcc-9.2.0-ygr4xiu  # load babel on hpc 

#source /opt/ohpc/pub/apps/rnachem/amber18/modules2load.txt
#source /opt/ohpc/pub/apps/rnachem/amber18/amber.sh
#module load openbabel-3.0.0-gcc-9.2.0-ygr4xiu

#for tor_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "alfa" \) ) ;
#for tor_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "gamma*" \) ) ;
#for tor_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "epsi*" \) ) ;
#for tor_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "zeta*" \) ) ;
for tor_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "alfa" -o -name "gamma" -o -name "epsi" -o -name "zeta" \) ) ;

do 
cd $tor_dir
  echo $tor_dir "########################################## " #2d_AA
  tord=`basename $tor_dir`


shopt -s extglob		# open pattern shell

for dimer_dir in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "2d_??" \) ) ;
do 
cd $dimer_dir
  echo $dimer_dir "########################################## " #2d_AA
  dim=`basename $dimer_dir`	
	  
 # dimer2=`pwd | awk '{split($1,a,"/") ; print (a[7])}' | awk '{split($a[7],b,"_"); print (b[2])}'` # get dimer name by pwd	
 # dimer2=` echo $dimer_dir | awk '{split($1,a,"/") ; print (a[2])}' | awk '{split($a[2],b,"_"); print (b[2])}'`		
#	echo $dimer2
			
#   for directory_rr in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "???_???" \) ) ; #find directory in depth of 1 and 1

for directory_rr in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "??5_??3" \) ) ;  
   do 
   cd $directory_rr
      
      echo $directory_rr "########################################## " #BB5_RA3

	rr=`basename $directory_rr`

	#copy files
#        cp -r /mnt/rna/home/nkumarachchi2019/scratch/NEW_GAU_OPT/epsi_gamma/$dim/$rr/epsi_gamma_all_in_one ./   #__1
	
	#copy parameter files         
#       tleap -f ../../scripts2/xleap.in # parameters files and models files from :  /mnt/rna/home/nkumarachchi2019/scratch/2d_minimized_c1c2/2d_AA/BB5_RA3 , 
                                                # very first is malatya : /home/nkumarachchi2019/dimeric_force_field/cp_new_modeling/2d_minimized_init_prmtop_here/2d_AA/BB5_RA3

#	cp /mnt/rna/home/nkumarachchi2019/scratch/2d_minimized_c1c2/$dim/$rr/prmtop.zeroed ./  #____2
#	cp /mnt/rna/home/nkumarachchi2019/scratch/2d_minimized_c1c2/$dim/$rr/prmtop.zeroed.new ./
	
#	 diff prmtop.zeroed prmtop.zeroed.new
	 
	

### go to begin here ````begin here ``` ### this is when everything is don and when creating profiles ####

#      mv *.pdb model.pdb 
     
	####################### creating prmtop.zeroed.new ################################
#	rm leap.log min1.out prmtop.zeroed prmtop.zeroed.new init.xleap.pdb md.in min inpcrd out_torsion ptraj_torsion.in runmin RST sample.pdb
#	tleap -f /home/nkumarachchi2019/dimeric_force_field/2d_minimization/scripts2/xleap.in #__1
#	perl /home/nkumarachchi2019/dimeric_force_field/2d_minimization/scripts2/create_correct_prmtop.pl  #__2 # gives the same file becasue no new force feild stuff

	# create all paths and minimized everything using atlas.cpu.min.sh #___3

        ####### md.out count #########################################
#2d
#        ls -l ./alfa_gamma_all_in_one/*/md.out   >> ../../md_check_tmp.txt #__4 
 
#2d#
        ######### get qm and mm profiles E_QM.dat   ###############################

	##change  the folder name ###   ##8
#	cd epsi_gamma_all_in_one
#	pwd
#	 ls -ltrd * | awk ' {split($9,a,"."); split(a[1],b,"_"); if(b[2]>=360) {c=b[2]-360; system("mv "$9" z_"c"."a[2])} else {system("mv "$9" "a[1]"."a[2])} }'  ##8   # give and error where it no needs to change
#	cd ../

	# creating profiles ## ##9
#	rm *.dat *.txt
	bash $SCRITPATH/profiles.sh ##9

#2D        ######### check torsions energy - should be near zero ######### 			##10
        
#        grep -A 11 "FINAL RESULTS" epsi_gamma_all_in_one/*/min2.out | grep Tor > tor_check.txt
#	cat tor_check.txt | wc
#	printf " MINNN $(cat tor_check.txt | sort -nk12,12 | head -1) \n"
#	printf " MAXX $(cat tor_check.txt | sort -nk12,12 | tail -1) \n"

	 ######### check MM zero energy some can be very high ######### 			 ##11

#	cat E_MM_zero.dat | sort -nk3,3 | tail -20   ##10 lst 20 should be close to each other...


#2d     ################## creating gnu plots #######################

#       sed -i "s/AAA/$rr1-/g ; s/BBB/$rr2\_QM-MM_zero/g" gnuplot/gnuplot.gp 

#       cd gnuplot
#       cp E_QM-MM_zero_ref_zero.dat all_data_4_gnuplot.txt
#       ./gnuplot.gp
#       mv 2D_plot.ps 2D_plot_zero.ps
#       cd ../  


	##8 changing folder names

################################################################################

#2D								######### check here * or 10 ###		

#               for angles_dir in $(find . -mindepth 2 -maxdepth 2 -type d \( -name "z_220.g_0" -o -name "z_20.g_140" \) ) ;
#               for angles_dir in $(find . -mindepth 2 -maxdepth 2 -type d \( -name "z_330.g_30" -o -name "z_610.g_200" -o -name "z_630.g_150" -o -name "z_550.g_150" \) ) ;


#               for angles_dir in $(find . -mindepth 2 -maxdepth 2 -type d \( -name "?_*" \) ) ; 
#		do
#		cd $angles_dir
#		echo $angles_dir "########################################## " #alfa_gamma_all_in_one/a_0.g_0 /
#			ang=`basename $angles_dir`
			
#			 cp -r /mnt/rna/home/nkumarachchi2019/scratch/NEW_GAU_OPT/epsi_gamma/$dim/$rr/epsi_gamma_all_in_one/$ang/pes.*.log ./


#2D        ######### combine a_*.g_120 line to one pdb  -mindepth 1 requred #########
#rm *.pdb
#ls -l *.g_120/min.pdb | awk '{split($9,a,"/");  split(a[1],b,"."); split(b[1],c,"_"); print c[2]"\t"$9}' | sort -nk1,1 | awk '{s++; print "MODEL "s; system("cat "$2" | grep ATOM"); print "ENDMDL"}' > ambr_min_a0-360.g_120_$rr.pdb
#ls -l ./a_*.g_120/gau_opt.pdb | awk '{split($9,a,"/"); split(a[2],b,"."); split(b[1],c,"_"); print c[2]"\t"$NF}' | sort -nk1,1  | awk '{s++; print "MODEL "s; system("cat "$2"|  grep HETATM");  print "ENDMDL"}'  >  gau_opt_a0-360.g_120_$rr.pdb
		
	  
#	printf "$dimer_dir $directory_rr $angles_dir  $(tail -n -1 pes.log ) \n" >> ../../opt_done.txt

	######## remove unwanted files in qm optimized folder ##########

#### `````````` begin here `````````` ###########

#	rm -rf -v !(opt.xyz|pes.*.log)  # except these two #____1  ##1

 	######### create opt.xyz #################
#	bash $SCRITPATH/extract_single_structure.sh  #___2  out opt.xyz

 	################ check for RST (restrains and sample.pdb atoms || inside angle_10 #####
####	bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/check_RST_terms_equal.sh ##  (not nessessary) rst created byy pes.log file see inside runmin

#	use dipendancey job script ###run simulation ##4 crate new all_paths, commands are in commnd file ##3
	
#	tleap -f ../../scripts2/xleap.in # parameters files and models files from :  /home/nkumarachchi2019/dimeric_force_field/cp_new_modeling/2d_minimized_init_prmtop_here_EGzeroed     ##4
						# very first is malatya : /home/nkumarachchi2019/dimeric_force_field/cp_new_modeling/2d_minimized_init_prmtop_here/2d_AA/BB5_RA3
									
#	perl ../create_correct_prmtop.pl  # not necessary cp prmtopfile

	##### md.in and min.in files are created inside the runmin file see below ##### 
	######	perl /mnt/rna/home/nkumarachchi2019/scratch/2d_minimized_c1c2/scripts3_2d/create_init_md.pl # will create intial sample.pdb file for amber simulation. thing will be done inside runmin script see below NO need to run create_init_md.pl
	
#2d	### create similation file #############
	## creating a sample.pdb from opt corrdinate AND MM.IN MIN.IN files are inside runmin  ###

#	 cp ../../prmtop.zeroed.new ./	##4
#	cp $SCRITPATH/runmin ./   #____3 copy runmin    ##5

##	bash /mnt/rna/home/nkumarachchi2019/scratch/2d_minimized_c1c2/scripts3_2d/RST_gen.sh #______3 (this is not nessassry, everyting correct in RST file, see oneline code inside runmin )
#	sbatch ../../../../../atlas.cpu.min.sh # use dependacy job script #____4   ##6 use dependacy script or sbatch --exclusive
#   		#if the folder do not contain md.out submit sbatch

#	find . -type d '!' -exec test -e "{}/md.out" ';' -print  |  awk '{if($1==".") system("sbatch ../../../../atlas.cpu.min.sh")}'     ##6 
	
		
	#run all the runmin files use altls.cpu.min.sh   #___4   ##7     run with --exclusive no need of dependancy   ##7
	
	#change folder name if nessassry ##8
	# create profiles		 ##9 above
	# create profiles 		##10 above
	# check min max energies 	##11 above

#	joe runmin  # change 10,000 to 5000
#	sed -i "s/100000.0/5000.0/g" runmin
#	sbatch ../../../../atlas.cpu.min.sh	
#        obabel -ig09 pes.log -opdb -Ogau_opt.pdb		
	 
	 
	#angle #####
#	cd ../../
#	done
######################################################################################
	
	
  #rotation #####	
  cd ../	
  done
  
#dimer ###### 
cd ../
done

cd ../ # alfa gamma epsi
done 

shopt -u extglob 	# closing pattern shell

echo "DONE ####################### "


