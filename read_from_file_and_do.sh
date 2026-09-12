file1=$1


##### for file 1 ###########################################

readarray row < $file1    # split linesto get number of rows
declare -A matrix
IFS=' \t\r\n' read -a cell <<< $row #split each cells to get number of cells


num_rows=${#row[@]}
num_cells=${#cell[@]}

echo ${#row[@]}
echo ${#cell[@]}
echo 'wait...'

for ((i=0; i<num_rows; i++)) 
do

IFS=',' read -a cell <<< ${row[$i]}  #split each row

    for ((j=0; j<num_cells; j++)) 
    do

        echo ${cell[@]}

       # matrix[$i,$j]=${cell[$j]}
    done
done