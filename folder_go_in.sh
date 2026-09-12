#!/bin/bash

source /opt/ohpc/pub/apps/rnachem/amber18/modules2load.txt
source /opt/ohpc/pub/apps/rnachem/amber18/amber.sh
module load openbabel-3.0.0-gcc-9.2.0-ygr4xiu
module load gaussian/R09


shopt -s extglob 

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT` 

#for dimerf in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "2d_*" \) );
#for dimerf in $(cat list); 
#for directory in $(find . -mindepth 1 -maxdepth 1 -type d); #find directory in depth of 1 and 1
#for epsi_d in $(find . -mindepth 1 -maxdepth 1 -type d \( -name "epsi_*" -a ! -name "epsi_210" -a ! -name "epsi_220"  \) );  #find directory in depth of 1 and 1
for dimerf in $( find . -maxdepth 1 -mindepth 1 -type d \( -name "2d_*" \) );
do 
cd $directory
	echo $directory "########################################## "
	rm -e
#	perl ../create_init_md.pl
#	tleap -f ../xleap.in 
#	perl ../create_correct_prmtop.pl

cd ..	
done

shopt -u extglob

echo "DONE ####################### "


