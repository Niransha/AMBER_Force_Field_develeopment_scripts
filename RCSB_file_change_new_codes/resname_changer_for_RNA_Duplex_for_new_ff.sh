#!/bin/bash

#######################################################################################
############ PBD RESNAME CHANGE  FOR double helix RNA #################################
############# written by NRK 22 Agust 2021 ############################################
#use together with script to modify RCSB pdbs modify_RCSB_pdbs_and_change_resnames.sh #
#######################################################################################
#######################################################################################


file=./resname.pdb

cat resname.pdb | grep ATOM | awk '{print $4" "$5}' | uniq > res_id_list.txt

rm ./h1_new.pdb ./h2_new.pdb

sed '/TER/q' ./resname.pdb > h1.pdb   # grep untill forst TER
sed -ne '/^TER/ { :a; n; p; ba; }' ./resname.pdb > h2.pdb #grep from first TER to and TER

readarray row < ./h1.pdb    # split linesto get number of rows
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

# for printing arrays
for ((i=0;i<=num_rows;i++)) do

   # printf "$f2" $i
    
   for ((j=0;j<=num_cells;j++)) do
    
#        printf "$f1" ${matrix[$i,$j]}
 	tmp=1     
    done
    echo
done

#################################################################


declare -a resnew

seq=`cat ./h1.pdb | grep ATOM | awk '{print $4" "$5}' | uniq | awk '{l=l $1}END{print l}'`

res=( `echo $seq | grep -o .` ) # A C  G U in seperate array sequnece

#echo ${res[@]}  
#echo ${res[12]}
res_len=${#res[@]}
echo $res_len


for (( i=0; i<res_len; i++ ));
do

 if [[ $i -eq 0 ]];                               # 5' end           #for 1st in seq  #cheked using for (( i=6; i<=6; i++ )); work !
 then
        a=zero
        resnew[$i]=5${res[$i]}${res[$i+1]}    #5XX

#        echo $resnew[$i]

 elif [[ $i -eq $(($res_len-1)) ]];          # 3' end one below the res_len array  #for last in eq #cheked using for (( i=6; i<=6; i++ )); work ! legth is 6, i 0-6 but array make for 0-5 ,
 then
        a=equal
        resnew[$i]=${res[$i-1]}${res[$i]}3    #CU3 like 3' ends  
 #       echo $resnew[$i];
 else
        a=others
        resnew[$i]=${res[$i-1]}${res[$i]}${res[$i+1]}  #  AGC middle, not 5' or 3' ends                                 
#        echo $resnew[$i];

 fi
done

echo 5prime: ${resnew[0]}
echo 3prime : ${resnew[$(($res_len -1))]} 

#res numbers
resnuml=`cat ./h1.pdb | awk '{print $5}' | uniq`  # resids 13 14 15 16 17 18 ....

Aresnum=( $resnuml ) 
echo length : ${#Aresnum[@]}
echo resnums :  ${Aresnum[@]}
echo resnum 0:  ${Aresnum[0]}



for (( i=0; i<res_len; i++ ))
do
#printf "${resnew[$i]} ${Aresnum[$i]}  \n" 
#echo ${!resnew[@]} #key 
tmp=2
done
printf "TER \n" 






###############################################################

#orgi for ((i=0;i<=num_rows;i++)) do
for ((i=0;i<=num_rows;i++)) do
   
   #org printf "$f2" $i
    
	###### marix[$i,4]  is pdb coumn 5 = resid 
	# we hve first created two arrays 
	# Aresnum : 13 14 15 16 17 18 19 20 21 22 23 24   n elements	
	# resnew : 5CG CCG CGA GAU ....................... CA3  n element
	# resnum and Aresnum elements are equal 
	# ${matrix[$,4]}  is resid 13 13 13 14 14 14 15 15 15 16 ..... 
	# here if ${matrix[$,4]} matched to ${Aresnums[$i]} = 13 14 15 or 16 , using ""BREAK"" we get k value, the $k use in ${resnew[$k]} to correspond resnew 5CG CCG CGA GAU
	# complicated but I did it :)  	

 	##            #resnum length
	for (( k=0; k<${#Aresnum[@]}; k++  ))
	do
		      #resnun in array    #file $5 13
        	if [ "${Aresnum[$k]}" == "${matrix[$i,4]}" ] ; then
      		#echo $k
		#echo "Found2"
        	#echo ${resnew[$k]} ${matrix[$i,4]}
		break
		tmp=3
		fi

	done
	
	
        printf "${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]} ${resnew[$k]} ${matrix[$i,4]} ${matrix[$i,5]} ${matrix[$i,6]} ${matrix[$i,7]} \n" >> h1_new.pdb
      	#echo test 2
       #tmp=5
            
done

#printf "TER \n" >> h1_new.pdb

#echo resnums : 13 14 15 16 17 18 19 20 21 22 23 24
#echo resnew : 5CG C G A A ....................... CA3

###################################################################
################# second half #####################################
###################################################################


readarray row < ./h2.pdb    # split linesto get number of rows
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

# for printing arrays
for ((i=0;i<=num_rows;i++)) do

   # printf "$f2" $i
    
   for ((j=0;j<=num_cells;j++)) do
    
#        printf "$f1" ${matrix[$i,$j]}
 	tmp=1     
    done
    echo
done

#################################################################


declare -a resnew

seq=`cat ./h2.pdb | grep ATOM | awk '{print \$4" "\$5}' | uniq | awk '{l=l \$1}END{print l}'`

res=( `echo $seq | grep -o .` ) # A C  G U in seperate array sequnece

echo ${res[@]}  
echo ${res[12]}
res_len=${#res[@]}
echo $res_len


for (( i=0; i<res_len; i++ ));
do

 if [[ $i -eq 0 ]];                               # 5' end           #for 1st in seq  #cheked using for (( i=6; i<=6; i++ )); work !
 then
        a=zero
        resnew[$i]=5${res[$i]}${res[$i+1]}    #5XX

#        echo $resnew[$i]

 elif [[ $i -eq $(($res_len-1)) ]];          # 3' end one below the res_len array  #for last in eq #cheked using for (( i=6; i<=6; i++ )); work ! legth is 6, i 0-6 but array make for 0-5 ,
 then
        a=equal
        resnew[$i]=${res[$i-1]}${res[$i]}3    #CU3 like 3' ends  
 #       echo $resnew[$i];
 else
        a=others
        resnew[$i]=${res[$i-1]}${res[$i]}${res[$i+1]}  #  AGC middle, not 5' or 3' ends                                 
#        echo $resnew[$i];

 fi
done

echo 5prime: ${resnew[0]}
echo 3prime : ${resnew[$(($res_len -1))]} 

#res numbers
resnuml=`cat ./h2.pdb | awk '{print $5}' | uniq`  # resids 13 14 15 16 17 18 ....

Aresnum=( $resnuml ) 
echo length : ${#Aresnum[@]}
echo resnums :  ${Aresnum[@]}
echo resnum 0:  ${Aresnum[0]}



for (( i=0; i<res_len; i++ ))
do
#printf "${resnew[$i]} ${Aresnum[$i]}  \n" 
#echo ${!resnew[@]} #key 
tmp=2
done
#printf "TER \n" 


###############################################################

#orgi for ((i=0;i<=num_rows;i++)) do
for ((i=0;i<=num_rows;i++)) do
   
   #org printf "$f2" $i
    
	###### marix[$i,4]  is pdb coumn 5 = resid 
	# we hve first created two arrays 
	# Aresnum : 13 14 15 16 17 18 19 20 21 22 23 24   n elements	
	# resnew : 5CG CCG CGA GAU ....................... CA3  n element
	# resnum and Aresnum elements are equal 
	# ${matrix[$,4]}  is resid 13 13 13 14 14 14 15 15 15 16 ..... 
	# here if ${matrix[$,4]} matched to ${Aresnums[$i]} = 13 14 15 or 16 , using ""BREAK"" we get k value, the $k use in ${resnew[$k]} to correspond resnew 5CG CCG CGA GAU
	# complicated but I did it :)  	

 	##            #resnum length
	for (( k=0; k<${#Aresnum[@]}; k++  ))
	do
		      #resnun in array    #file $5 13
        	if [ "${Aresnum[$k]}" == "${matrix[$i,4]}" ] ; then
      		#echo $k
		#echo "Found2"
        	#echo ${resnew[$k]} ${matrix[$i,4]}
		break
		tmp=3
		fi

	done
	
	
        printf "${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]} ${resnew[$k]} ${matrix[$i,4]} ${matrix[$i,5]} ${matrix[$i,6]} ${matrix[$i,7]} \n" >> h2_new.pdb
      	#echo test 2
       #tmp=5
            
done

#printf "TER \n" >> h2_new.pdb


cat h1_new.pdb h2_new.pdb > tmp5

grep "\S" tmp5 > tmp6

cat ./tmp6 | awk '{ if ($1=="TER") {printf "TER\n"} else  printf ("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f \n", $1, $2, $3, $4, $5, $6, $7, $8) }' > tmp7

head -n -1 tmp7 > resname.new.pdb #delete last line


rm h1_new.pdb h2_new.pdb tmp5 tmp6 h1.pdb h2.pdb tmp7



