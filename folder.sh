for folder in 1SDR #1AL5 GACC_test CCCC UUUU CAAU AAAA 1AL5 1SDR 1BNA 2KOC 
do
cd $folder
# run folowing commands in the folder
	
#	perl ../create_newRESNAMEs.pl *.pdb

	tleap -f ../xleap.new.water.in
	
	perl ../create_correct_prmtop.pl
	
	echo " $folder done" > ../Completed
	
	
	cd ..
	done

