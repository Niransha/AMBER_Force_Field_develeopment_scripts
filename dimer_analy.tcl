##########################################################
## This script will analyse rna torsion of any rcsb pbd ##
##    Niransha Kumarachchi 2/5/2020                     ##
##########################################################

# checked on 4c7o.pdb rcsb 

set file [open "dimer_alfa.dat" w]

set nuc [atomselect top "resname A G C U"] ; # selection for nuclecic acid 

set resname_list [ lsort -unique [ $nuc get resname ] ] ; # give A C G U in list > resname_list

set nresnametype [ llength $resname_list ] ; # length = 4

for { set j 0 } { $j < $nresnametype } { incr j } {
	 
	 set resname_sel($j) [ atomselect top "resname [ lindex $resname_list $j ]" ]  ;
                                       # do the selection based on resname  
        #making resnames selection(0)(1) 2 3 4 .. to be on  resname A C G U
        
         set residue_list($j) [ lsort -unique [ $resname_sel($j) get residue ] ] ;
     # GIVE **residue** list for
     # residue_list(0) as A: residue 1153 1154 1160 1161 1174 1178 1185 
     # residue_list(1) as C: residue 1146 1148 1149 1150 1152 1155 1157 1163 1169 1170 1180 1184
     # residue_list(2) as G: residue 1139 1142 1143 1151 1156 1158 1159 1162 1164 1166 1168 1171 1172 1173 1176 1179 1182 1183
     # residue_list(3) as  U: residue 1138 1140 1141 1144 1145 1147 1165 1167 1175 1177 1181
 
}	 

set fiveP C
set threeP A

for { set j 0 } { $j < $nresnametype } { incr j } {

    #################
 foreach residueX $residue_list($j) {
# read residue_list(0)A..(1)C..2(G)..3(U) eg : residue_list(0) as A: residue 1153 1154 1160 1161 1174 1178 1185 

	#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	#selection for dimer

#	set dimer [ atomselect top " ( (resname C) and (residue [expr $residueX-1]) ) or ( (resname A) and (residue $residueX) )  " ] ; # selection for dimer

#	set n_atoms [$dimer num] ; # get number of atoms in dimer, if n_atom == 0 dont do any , else get torions values

                # if there is no C A dimer selection > skip to next iteration  
#                if { $n_atoms == 0 } { ; # if there is no selection 
	
		# no atom in the selection	
#                puts "$residueX no atoms " ; 
#                continue ; # skip to next iteration 
                #skip the iteration for no atoms in selection 
                
#                }                
	#@@@@@@@@@@@@@@@@@@@@@                 

#$#$#$#$ ALFA #$#$#

#	puts [expr $residueX] ; #print each value= resdueID
	set alfa_definition [atomselect top "(  ( (resname $fiveP) and (residue [expr $residueX-1]) and (type O3') )  or ( (resname $threeP) and (residue $residueX) and (type P O5' C5') )  ) "] ; # selection for alfa ; for four atoms
        set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

		#to skip the iteration for indexes less than 4 : end groups 
		if { [llength $alfa_four_index_list] != 4 } {
		continue
		#skip the iteration for indexes less than 4 : end groups				
		} ; #skipping loop over
	set alfa_tor [measure dihed $alfa_four_index_list] ; # using indexs mesure torsion
	

#$#$#$#$#$#$ Zeta over
                
	puts $file "$residueX $alfa_tor " ; # print torsion

#    	puts "$residueX $tor"

	$alfa_definition delete
	
        } ; # foreach over # reading over : read residue_list(0)..1..2..3 eg : residue_list(0) as A: residue 1153 1154 1160 1161 1174 1178 1185 
    
    ##################

} ; # for loop over # end of component  A C G U loop



close $file

#set index_list [ lsort -unique [ $nuc get index ] ]
#set index_list [ lsort [ $nuc get index ] ]
#set n_index_list [ llength $index_list]




