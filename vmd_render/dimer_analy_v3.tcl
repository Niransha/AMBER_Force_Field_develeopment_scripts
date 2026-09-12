##########################################################
## This script will analyse rna torsion of any rcsb pbd ##
##    Niransha Kumarachchi 2/5/2020                     ##
## commented  on 4C7O.pdb rcsb.com 			##  
##########################################################

# AA AC AG AU CA CC CG CU GA GC GG GU UA UC UG UU
set fiveP A
set threeP A
set file [open "tor_$fiveP$threeP.dat" w]

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

#set alfa_definition [atomselect top "((resid 7) and (type O3' )) or ((resid 8) and (type P O5' C5')) " ] ; # specific alfa section
#set alfa_definition [atomselect top "((residue 1152) and (type O3' )) or ((residue 1153) and (type P O5' C5')) " ] ; # example alfa definition
#set alfa_four_index_list [lsort [$alfa_definition get index]] ; #four atom indexes for alfa : 8981 8993 8996 8997

for { set j 0 } { $j < $nresnametype } { incr j } {

    #################
 foreach residueX $residue_list($j) {
# read residue_list(0)A..(1)C..2(G)..3(U) eg : residue_list(0) as A: residue 1153 1154 1160 1161 1174 1178 1185 

#$#$#$#$ ALFA #$#$#

#	puts [expr $residueX] ; #print each value= resdueID
	set alfa_definition [atomselect top " (  ( (resname $fiveP) and (residue [expr $residueX-1]) and (type O3') )  or ( (resname $threeP) and (residue $residueX) and (type P O5' C5') )  )"] ; # selection for alfa ; for four atoms
        set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

		#to skip the iteration for indexes less than 4 : end groups 
		if { [llength $alfa_four_index_list] != 4 } {
		continue
		#skip the iteration for indexes less than 4 : end groups				
		} ; #skipping loop over
	set alfa_tor [measure dihed $alfa_four_index_list] ; # using indexs mesure torsion
	

#$#$#$#$ BETA #$#$#
       # puts [expr $residueX] ; #print each value= resdueID
        set beta_definition [atomselect top "((residue $residueX) and (type P O5' C5' C4')) "] ; # selection for BETA
        set beta_four_index_list [lsort [$beta_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $beta_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set beta_tor [measure dihed $beta_four_index_list] ; # using indexs mesure torsion

#$#$#$# GAMMA #$#$#
	
        set gamma_definition [atomselect top "((residue $residueX) and (type O5' C5' C4' C3')) "] ; # section for GAMMA
        set gamma_four_index_list [lsort [$gamma_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $gamma_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set gamma_tor [measure dihed $gamma_four_index_list] ; # using indexs mesure torsion

		
#$#$#$# DELTA 1 #$#$#$
        set d1_definition [atomselect top "((residue $residueX) and (type O4' C4' C3' C2')) "] ; # section for GAMMA
        set d1_four_index_list [lsort [$d1_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $d1_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set d1_tor [measure dihed $d1_four_index_list] ; # using indexs mesure torsion



#$#$#$# DELTA 2 #$#$#$
        set d2_definition [atomselect top "((residue $residueX) and (type O4' C1' C2' C3')) "] ; # section for GAMMA
        set d2_four_index_list [lsort [$d2_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $d2_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set d2_tor [measure dihed $d2_four_index_list] ; # using indexs mesure torsion

#$#$#$# EPSI #$#$#$#

        set epsi_definition [atomselect top "( ((resname $threeP) and (residue $residueX) and (type C4' C3' O3')) or ( (residue [expr $residueX+1]) and (type P ) )  )"] ; # section for GAMMA
        set epsi_four_index_list [lsort [$epsi_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $epsi_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set epsi_tor [measure dihed $epsi_four_index_list] ; # using indexs mesure torsion

#$#$#$# zeta #$#$#

        set zeta_definition [atomselect top "( ( (resname $threeP) and (residue $residueX) and (type C3' O3') ) or ( (residue [expr $residueX+1]) and (type P O5') )  )"] ; # section for GAMMA
        set zeta_four_index_list [lsort [$zeta_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $zeta_four_index_list] != 4 } {
                continue
                #skip the iteration for indexes less than 4 : end groups                                
                } ; #skipping loop over
        set zeta_tor [measure dihed $zeta_four_index_list] ; # using indexs mesure torsion

#$#$#$#$#$#$ Zeta over
                
	puts $file "$residueX $alfa_tor $beta_tor $gamma_tor $epsi_tor $zeta_tor $d1_tor $d2_tor" ; # print torsion

#    	puts "$residueX $tor"

	$alfa_definition delete
	$beta_definition delete
	$gamma_definition delete
	$d1_definition delete
	$d2_definition delete
	$epsi_definition delete
	$zeta_definition delete   
	
				
        } ; # foreach over # reading over : read residue_list(0)..1..2..3 eg : residue_list(0) as A: residue 1153 1154 1160 1161 1174 1178 1185 
    
    ##################

} ; # for loop over # end of component  A C G U loop



close $file

#set index_list [ lsort -unique [ $nuc get index ] ]
#set index_list [ lsort [ $nuc get index ] ]
#set n_index_list [ llength $index_list]

