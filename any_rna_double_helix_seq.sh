triplet[1]="CGCAAAUUUGCG"
declare -p triplet

mkdir ./${triplet[1]}  #create directiroy with name of triplet
cd ./${triplet[1]} # go to created directory

echo ${triplet[1]} # print triplets
			#echo ${#triplet[@]}  
		#triplet_len=${#triplet[@]}
	
echo "molecule m;" >> ${triplet[1]}.nab
echo "m = fd_helix(\"arna\", \"${triplet[1]}\", \"rna\" );" >> ${triplet[1]}.nab
echo "putpdb( \"${triplet[1]}.pdb\", m, \"-wwpdb\");" >> ${triplet[1]}.nab
	
nab ${triplet[1]}.nab   #nab will creat a.out file
./a.out			# running a..out will create PDBs