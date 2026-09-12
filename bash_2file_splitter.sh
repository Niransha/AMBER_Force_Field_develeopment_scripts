#!/bin/bash


##########PDB column compair ########### Based on following script #############
################################################################################
############ This script check two different data files and write new file  ####
################ Niransha Kumarachchi 21/07/2020 ###############################
################################################################################

# Usage # bash bash_2file_splitter.sh <file_1_higer_number_of_rows.dat> <file_2_lower_number_of_rows.dat> 
# 

# eg 
#file1
#Frame             c1uster
#      1            2
#      2            2
#      3            0
#      4            0
#      5            0
#      6            0

#file2
#Cluster   Frames     Frac  AvgDist    Stdev Centroid AvgCDist
#      0    25340    0.507    0.784    0.214    43731    2.080
#      1     8044    0.161    0.860    0.250    15618    2.193
#      2     6405    0.128    1.111    0.494    45027    2.199
#      3     3902    0.078    1.135    0.409    29807    2.598

#output
     #FRAME #CLUSTER #AvgDistance		
#       1       2   1.111
#       2       2   1.111
#       3       0   0.784
#       4       0   0.784
#       5       0   0.784
#       6       0   0.784





file1=$1
file2=$2


##### for file 1 ###########################################

readarray row < $file1    # split linesto get number of rows
declare -A matrix
IFS=' \t\r\n' read -a cell <<< $row #split each cells to get number of cells


num_rows=${#row[@]}
num_cells=${#cell[@]}

echo ${#row[@]}
echo ${#cell[@]}
echo 'wait'

for ((i=0; i<num_rows; i++)) 
do

IFS=' \t\r\n' read -a cell <<< ${row[$i]}  #split each row

    for ((j=0; j<num_cells; j++)) 
    do
    
        #echo ${cell[$j]}

        matrix[$i,$j]=${cell[$j]}
    done
done

f1=" %5s"                       # column number and print setttings
f2="%$((${#num_rows}+1))s"  # row number and print settings


#printf "$f2"
#for ((i=1;i<=num_cells;i++)) do

 #   printf "$f1" $i
#done
#echo

for ((i=0;i<=num_rows;i++)) do

   # printf "$f2" $i

    for ((j=0;j<=num_cells;j++)) do

        printf "$f1" ${matrix[$i,$j]}

    done
    echo
done



########## for file 2 ###############################################

readarray row2 < $file2
declare -A matrix2

IFS=' \t\r\n' read -a cell2 <<< $row2

num_rows2=${#row2[@]}
num_cells2=${#cell2[@]}

echo ${#row2[@]}
echo ${#cell2[@]}


for ((i2=0; i2<num_rows2; i2++)) do

IFS=' \t\r\n' read -a cell2 <<< ${row2[$i2]}

    for ((j2=0; j2<num_cells2; j2++)) do
    
    	#echo ${cell[$j]}
       
        matrix2[$i2,$j2]=${cell2[$j2]}
    done
done

f12="   %5s"
#cat sed3.pdb | awk '{ if ($1=="TER") {printf "TER\n"} else  printf ("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f \n", $1, $2, $3, $4, $5, $6, $7, $8) }'

#f2="%$((${#num_rows}+1))s"
#printf "$f2"
#for ((i=1;i<=num_cells;i++)) do

 #   printf "$f1" $i
#done
#echo
#retrive array data

for ((i2=0;i2<=num_rows2;i2++)) do

   # printf "$f2" $i
    
    for ((j2=0;j2<=num_cells2;j2++)) do
   
    printf "$f12" ${matrix2[$i2,$j2]}
	
	done
    echo
done

################## matching ###################

rm data.dat

#first data set rows
for ((i=0;i<=num_rows;i++)) do

	
	#second data set rows
	for ((i2=i;i2<=i;i2++)) do
		
		#matching
	#	if [ "${matrix[$i,1]}" = "${matrix2[$i2,0]}" ]; then	
			 
		echo ${matrix[$i,1]} ${matrix[$i,2]} ${matrix2[$i2,1]} ${matrix2[$i2,2]} >> data.dat
		
		#echo  ${matrix2[$i2,1]} ${matrix2[$i2,1]} >> data.dat
		

		printf "$f12" ${matrix[$i,1]} ${matrix[$i,2]} ${matrix2[$i2,1]} ${matrix2[$i2,2]}
		#printf "$f12" ${matrix[$i,2]} ${matrix[$i,3]} ${matrix2[$i2,2]} ${matrix2[$i2,3]}


		#break file2 row "checking loop" 		
		break
		#fi

	done  
       
    echo
done


echo "done"


