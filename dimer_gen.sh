###################################################
################ create all the dimers ############
##################################################

declare -a myArray

myArray=(A C G U)

#echo ${myArray[0]}
#creating array

i=0
for x1 in ${myArray[@]}
  do
    for x2 in ${myArray[@]}
      do
         dimer[i++]="$x1$x2"
      done
  done
declare -p dimer


echo ${dimer[@]} # print dimers
#echo ${#dimer[@]}  
dimer_len=${#dimer[@]}



j=0
while [ $j -lt $dimer_len ]
  do

   echo ${dimer[j]}

#	cp  dimer_analy_v3.tcl dimer_analy_v3_${dimer[j]}.tcl

#    mkdir ./${dimer[j]}  #create directiroy with name of dimer
#    cd ./${dimer[j]} # go to created directory
	
	#nuc.nab file start here with dimer name
	
#	echo "molecule m;" >> ${dimer[j]}.nab
#    cd ../../../ #go back to home directory
         
    
    ((j++))
  done




