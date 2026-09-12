#!/bin/bash

file=$1

readarray row < $file    # split linesto get number of rows
declare -A matrix
IFS=' \t\r\n' read -a cell <<< $row #split each cells to get number of cells


num_rows=${#row[@]}     
num_cells=${#cell[@]}

echo ${#row[@]}
echo ${#cell[@]}

for ((i=0; i<num_rows; i++)) 
do

IFS=' \t\r\n' read -a cell <<< ${row[$i]}  #split eachrow

    for ((j=0; j<num_cells; j++)) 
    do
    
      	#echo ${cell[$j]}
       
        matrix[$i,$j]=${cell[$j]}
    done
done

f1=" %5s"			# column number and print setttings
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

