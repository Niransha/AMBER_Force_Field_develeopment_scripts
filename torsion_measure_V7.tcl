##########################################################
## This script will analyse rna torsion of any rcsb pbd ##
##    Niransha Kumarachchi 2/5/2020                     ##
## commented  on 1msy.pdb rcsb.com 			##  
# vmd -dispdev text new.pdb -eofexit < torison_measure_V7.tcl #
## residueX = 5'end, residueX+1 is 3'end  P includes for 3' residueX #
##########################################################


set AfiveP(0) A
set AfiveP(1) C
set AfiveP(2) G
set AfiveP(3) U
set AthreeP(0) A
set AthreeP(1) C
set AthreeP(2) G
set AthreeP(3) U

for { set p 0 }  { $p < 4 }  { incr p } {
   
			for { set q 0 }  { $q < 4 }  { incr q } {
	
			puts "$AfiveP($p) $AthreeP($q) "
			
			set fiveP $AfiveP($p)
			set threeP $AthreeP($q)
			
			puts "########### $fiveP $threeP #################"
					




#AA AC AG AU CA CC CG CU GA GC GG GU UA UC UG UU
#set fiveP C
#set threeP G

#set file [open "tor_$fiveP$threeP.dat" w]

########## get pdb name ########
set name1 [ molinfo top get name]
set name2 [split $name1 . ]
set pdbname [lindex $name2 0]
puts $pdbname
#############################

set file [open "tor_$fiveP$threeP.dat" w]


set nuc [atomselect top "resname A G C U"] ; # selection for nuclecic acid 

$nuc frame 0
$nuc update	
#animate goto 0
#$nuc writepdb tmp_0.pdb

set resname_list [ lsort -dictionary -unique [ $nuc get resname ] ] ; # give A C G U in list > resname_list

set nresnametype [ llength $resname_list ] ; # length = 4

for { set j 0 } { $j < $nresnametype } { incr j } {
	 
	 set resname_sel($j) [ atomselect top "resname [ lindex $resname_list $j ]" ]  ;
                                       # do the selection based on resname  
        #making resnames selection(0)(1) (2) (3)  to be on  resname 0=A 1=C 2=G 3=U
        
         set residue_list($j) [ lsort -integer -unique [ $resname_sel($j) get residue ] ] ;
     # GIVE **residue** list for
     #residue_list(0) as A:  # residue 10 14 15 18 23 7 
 	 # residue_list(1) as C: #residue 11 19 2 20 4 5
      # residue_list(2) as G: #residue  1 12 16 17 21 22 24 26 8
      # residue_list(3) as  U: #residue 0 13 25 3 6 9 
 
} ; # residue assigning loop over

#puts $residue_list(0)    
#puts $residue_list(1) 
#puts $residue_list(2) 
#uts $residue_list(3)  



for { set j 0 } { $j < $nresnametype } { incr j } {
 foreach residueX $residue_list($j) {
 

##$#$#$#$#$#$# LENGTH OUT #$#$#$#$#$	

	#lengths
	
		set alfa_O3_P_sel [atomselect top "(  ( (resname $fiveP) and ((residue $residueX)) and (type O3') )  or ( (resname $threeP) and (residue [expr $residueX+1]) and (type P) )  )"] ;
		#set alfa_O3_P_sel [atomselect top "(  ( (resname A) and ((residue 14)) and (type O3') )  or ( (resname A) and (residue 15) and (type P) )  )"] ;
		set alfa_two_index_list [lsort [$alfa_O3_P_sel get index]] ;
		
			###### if - selection check with O3' and P of alfa ####	
			if { [llength $alfa_two_index_list] == 2 } {
					
					set dis_alfa_O3_P [measure bond $alfa_two_index_list] ;	
										
					puts "DIS $dis_alfa_O3_P $j $residueX" ;
					puts $alfa_two_index_list
					$alfa_O3_P_sel delete

				
				
				####################################################	
				################### O3' and P legth check ######
							
							if { $dis_alfa_O3_P <= 2.00 } {
									
								puts "$pdbname $fiveP $threeP matching lengths checking torsions ########" ;
								
								
								#$#$#$#$ ALFA TOR#$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] ALFA #####" ;
									
									set a_o3 [atomselect top " (resname $fiveP) and (residue $residueX) and (type O3')   "]
									set a_p [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type P)  "]
									set a_o5 [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type O5')  "]
									set a_c5 [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type C5') "]
									
									set alfa_four_index_list [concat [$a_o3 get index] [$a_p get index] [$a_o5 get index] [$a_c5 get index]]	

									
								#	puts [expr $residueX] ; #print each value= resdueID
									#set alfa_definition [atomselect top " (  ( (resname $fiveP) and ((residue $residueX)) and (type O3') )  or ( (resname $threeP) and (residue [expr $residueX+1]) and (type P O5' C5') )  )"] ; # selection for alfa ; for four atoms
									
									# set alfa_definition [atomselect top " (  ( (resname A) and ((residue 21)) and (type O3') )  or ( (resname G) and (residue 22) and (type P O5' C5') )  )  "] ; # selection for alfa ; for four atoms

									#set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

									
										if { [llength $alfa_four_index_list] == 4 } {

												set alfa_tor [measure dihed $alfa_four_index_list] ;
												puts "TOR $alfa_tor $j $residueX" ;
												puts $alfa_four_index_list
												#$alfa_definition delete
												$a_o3 delete
												$a_p delete
												$a_o5 delete
												$a_c5 delete
												
												
												
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
										
							
								#$#$#$#$ ALFA TOR OVER #$#$#
								

								#$#$#$#$ BETA #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] BETA #####" ;
									  
										set b_P [atomselect top "(residue [expr $residueX+1]) and (type P) "]
										set b_O5 [atomselect top "(residue [expr $residueX+1]) and (type  O5') "]
										set b_C5 [atomselect top "(residue [expr $residueX+1]) and (type C5') "]
										set b_C4 [atomselect top "(residue [expr $residueX+1]) and (type C4') "]
										
										set beta_four_index_list [concat [$b_P get index] [$b_O5 get index] [$b_C5 get index] [$b_C4 get index] ]
										

									  # puts [expr $residueX] ; #print each value= resdueID
										#set beta_definition [atomselect top "((residue [expr $residueX+1]) and (type P O5' C5' C4')) "] ; # selection for BETA
										#set beta_four_index_list [lsort [$beta_definition get index]] ; #get FOUR ATOM INDEXES for beta : 8981 8993 8996 8997
										
										#check selection has four atoms
										if { [llength $beta_four_index_list] == 4 } {

												set beta_tor [measure dihed $beta_four_index_list] ;
												puts "TOR $beta_tor $j $residueX" ;
												puts $beta_four_index_list
												#$beta_definition delete
												$b_P delete
												$b_O5 delete
												$b_C5 delete
												$b_C4 delete
												
									
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
										
								#$#$#$#$ BETA over #$#$#

								#$#$#$# GAMMA #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] GAMMA #####" ;
									
										set g_O5 [atomselect top "((residue [expr $residueX+1]) and (type O5')) "]
										set g_C5 [atomselect top "((residue [expr $residueX+1]) and (type C5' )) "]
										set g_C4 [atomselect top "((residue [expr $residueX+1]) and (type C4' )) "]
										set	g_C3 [atomselect top "((residue [expr $residueX+1]) and (type  C3')) "]					
									
										set gamma_four_index_list [concat [$g_O5 get index] [$g_C5 get index] [$g_C4 get index] [$g_C3 get index] ]
									
										#set gamma_definition [atomselect top "((residue [expr $residueX+1]) and (type O5' C5' C4' C3')) "] ; # section for GAMMA
										#set gamma_four_index_list [lsort [$gamma_definition get index]] ; #get FOUR ATOM INDEXES for GAMMA : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $gamma_four_index_list] == 4 } {

												set gamma_tor [measure dihed $gamma_four_index_list] ;
												puts "TOR $gamma_tor $j $residueX" ;
												puts $gamma_four_index_list
												#$gamma_definition delete
												$g_O5 delete
												$g_C5 delete
												$g_C4 delete
												$g_C3 delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}				
										
								#$#$#$# GAMMA over #$#$#
								
		
								#$#$#$# DELTAx #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] DELTAx #####" ;
								
												set dx_C5 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C5')) "]
												set dx_C4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C4')) "]
												set dx_C3 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C3')) "]
												set dx_O3 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O3')) "]

												set dx_four_index_list [concat [$dx_C5  get index] [$dx_C4 get index] [$dx_C3 get index] [$dx_O3 get index]]
												
																								
												#set dx_definition [atomselect top "((residue $residueX) and (type C5' C4' C3' O3')) "] ; # section for DELTA1
												#set dx_four_index_list [lsort [$dx_definition get index]] ; #get FOUR ATOM INDEXES for DELTA1: 8981 8993 8996 8997

												#check selection has four atoms
												if { [llength $dx_four_index_list] == 4 } {

																set dx_tor [measure dihed $dx_four_index_list] ;
																puts "TOR $dx_tor $j $residueX" ;
																puts $dx_four_index_list
																#$dx_definition delete
																$dx_C5 delete
																$dx_C4 delete
																$dx_C3 delete
																$dx_O3 delete


												} else {
																puts "NO_tor $j $residueX" ;
																#break
																continue
												}

								#$#$#$# DELTAx over #$#$#$ 
								
 
								#$#$#$# DELTA 1 #$#$#$

								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] DELTA1 #####" ;

												set d1_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
												set d1_C4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C4')) "]
												set d1_C3 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C3')) "]
												set d1_C2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C2')) "]

												set d1_four_index_list [concat [$d1_O4 get index] [$d1_C4 get index] [$d1_C3 get index] [$d1_C2 get index]]




												#set d1_definition [atomselect top "((residue $residueX) and (type O4' C4' C3' C2')) "] ; # section for DELTA1
												#set d1_four_index_list [lsort [$d1_definition get index]] ; #get FOUR ATOM INDEXES for DELTA1: 8981 8993 8996 8997

												#check selection has four atoms
												if { [llength $d1_four_index_list] == 4 } {

																set d1_tor [measure dihed $d1_four_index_list] ;
																puts "TOR $d1_tor $j $residueX" ;
																puts $d1_four_index_list
																$d1_O4 delete
																$d1_C4 delete
																$d1_C3 delete
																$d1_C2 delete
												
												} else {
																puts "NO_tor $j $residueX" ;
																#break
																continue
												}

                             
								#$#$#$# DELTA 1 over #$#$#$ 
 
								#$#$#$# DELTA 2 #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] DELTA2 #####" ;
												
												
												#$$$$$$$$$$$
												set d2_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
												set d2_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
												set d2_C2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C2')) "]
												set d2_C3 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C3')) "]

												set d2_four_index_list [concat [$d2_O4 get index] [$d2_C1 get index] [$d2_C2 get index] [$d2_C3 get index]]
																														
												
												#$#$$$$$$$$
												
												#set d2_definition [atomselect top "((residue $residueX) and (type O4' C1' C2' C3')) "] ; # section for  DELTA2
												#set d2_four_index_list [lsort [$d2_definition get index]] ; #get FOUR ATOM INDEXES for  DELTA2: 8981 8993 8996 8997

												#check selection has four atoms
												if { [llength $d2_four_index_list] == 4 } {

																set d2_tor [measure dihed $d2_four_index_list] ;
																puts "TOR $d2_tor $j $residueX" ;
																puts $d2_four_index_list
																
																$d2_O4 delete
																$d2_C1 delete
																$d2_C2 delete
																$d2_C3 delete
																
												} else {
																puts "NO_tor $j $residueX" ;
																#break
																continue
												}

								#$#$#$# DELTA 2 over #$#$#$


								#$#$#$# EPSI #$#$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] EPSI #####" ;
										
										set e_C4 [atomselect top "(resname $fiveP) and (residue $residueX) and (type C4') "]
										set e_C3 [atomselect top "(resname $fiveP) and (residue $residueX) and (type C3') "]
										set e_O3 [atomselect top "(resname $fiveP) and (residue $residueX) and (type O3') "]
										set e_P [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type P ) " ]
										
										set epsi_four_index_list [concat [$e_C4 get index] [$e_C3 get index] [$e_O3 get index] [$e_P get index] ]
										
										#set epsi_definition [atomselect top "( ((resname $fiveP) and (residue $residueX) and (type C4' C3' O3')) or ( (residue [expr $residueX+1]) and (type P ) )  )"] ; # section for epsi 
										#set epsi_four_index_list [lsort [$epsi_definition get index]] ; #get FOUR ATOM INDEXES for EPSI : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $epsi_four_index_list] == 4 } {

												set epsi_tor [measure dihed $epsi_four_index_list] ;
												puts "TOR $epsi_tor $j $residueX" ;
												puts $epsi_four_index_list
												#$epsi_definition delete
												$e_C4 delete 
												$e_C3 delete
												$e_O3 delete
												$e_P delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
								#$#$#$# EPSI over #$#$#$#


								#$#$#$# zeta #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] ZETA #####" ;

										set z_C3 [atomselect top " (resname $fiveP) and (residue [expr $residueX]) and (type  C3')"] 
										set z_O3 [atomselect top " (resname $fiveP) and (residue [expr $residueX]) and (type  O3')"]
										set z_P  [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type P)"]
										set z_O5 [atomselect top " (resname $threeP) and (residue [expr $residueX+1]) and (type O5')"]
							
										set zeta_four_index_list [concat [$z_C3 get index] [$z_O3 get index] [$z_P get index] [$z_O5 get index]] ;
										
										#set zeta_definition [atomselect top "( ( (resname $fiveP) and (residue $residueX) and (type C3' O3') ) or ( (residue [expr $residueX+1]) and (type P O5') )  )"] ; # section for zeta
										#set zeta_four_index_list [lsort [$zeta_definition get index]] ; #get FOUR ATOM INDEXES for ZETA : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $zeta_four_index_list] == 4 } {

												set zeta_tor [measure dihed $zeta_four_index_list] ;
												puts "TOR $zeta_tor $j $residueX" ;
												puts $zeta_four_index_list
												#$zeta_definition delete
												$z_C3 delete
												$z_O3 delete
												$z_P delete
												$z_O5 delete
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												#continue
										}
										
								#$#$#$#$#$#$ Zeta over #$#$#$#$#$#$

								#$#$#$# chi Orginal #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] CHI_0 #####" ;
							
								if { $fiveP == "A" || $fiveP == "G"} {
			
											set chi0_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
											set chi0_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
											set chi0_N9 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N9)) "]
											set chi0_C4 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C4)) "]
			
											set chi0_four_index_list [concat [$chi0_O4 get index] [$chi0_C1 get index] [$chi0_N9 get index] [$chi0_C4 get index]] ;
											
											
											#set chi0_definition [atomselect top "((residue $residueX) and (type O4' C1' N9 C4)) "] ; # section for CHI_O
											#set chi0_four_index_list [lsort [$chi0_definition get index]] ; #get FOUR ATOM INDEXES for CHI_O : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi0_four_index_list] == 4 } {

															set chi0_tor [measure dihed $chi0_four_index_list] ;
															puts "TOR $chi0_tor $j $residueX" ;
															puts $chi0_four_index_list
															$chi0_O4 delete
															$chi0_C1 delete
															$chi0_N9 delete
															$chi0_C4 delete
															
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}
									} else {

										#for C U
										
											set chi0_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
											set chi0_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
											set chi0_N1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N1)) "]
											set chi0_C2 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C2)) "]

			
											set chi0_four_index_list [concat [$chi0_O4 get index] [$chi0_C1 get index] [$chi0_N1 get index] [$chi0_C2 get index]] ;
											
											#set chi0_definition [atomselect top "((residue $residueX) and (type O4' C1' N1 C2)) "] ; # section for CHI_O
											#set chi0_four_index_list [lsort [$chi0_definition get index]] ; #get FOUR ATOM INDEXES for CHI_O : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi0_four_index_list] == 4 } {

															set chi0_tor [measure dihed $chi0_four_index_list] ;
															puts "TOR $chi0_tor $j $residueX" ;
															puts $chi0_four_index_list
															#$chi0_definition delete
															$chi0_O4 delete
															$chi0_C1 delete
															$chi0_N1 delete
															$chi0_C2 delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
															
													}
									}

									#$#$#$# chi Orginal over #$#$#$

								#$#$#$# chi1 force feild #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] CHI_1 #####" ;
							
								if { $fiveP == "A" || $fiveP == "G"} {
										
										set chi1_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
										set chi1_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
										set chi1_N9 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N9)) "]
										set chi1_C8 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C8)) "]
		
																	
										set chi1_four_index_list [concat [$chi1_O4 get index] [$chi1_C1 get index] [$chi1_N9 get index] [$chi1_C8 get index] ]
										
										#set chi1_definition [atomselect top "((residue $residueX) and (type O4' C1' N9 C8)) "] ; # section for CHI_1
										#set chi1_four_index_list [lsort [$chi1_definition get index]] ; #get FOUR ATOM INDEXES for CHI_1 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi1_four_index_list] == 4 } {

															set chi1_tor [measure dihed $chi1_four_index_list] ;
															puts "TOR $chi1_tor $j $residueX" ;
															puts $chi1_four_index_list
															#$chi1_definition delete
															$chi1_O4 delete
															$chi1_C1 delete
															$chi1_N9 delete
															$chi1_C8 delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								} else {

										#for C U
										
										set chi1_O4 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O4')) "]
										set chi1_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
										set chi1_N1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N1)) "]
										set chi1_C6 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C6)) "]
		
																	
										set chi1_four_index_list [concat [$chi1_O4 get index] [$chi1_C1 get index] [$chi1_N1 get index] [$chi1_C6 get index] ]
										
										
										#set chi1_definition [atomselect top "((residue $residueX) and (type O4' C1' N1 C6)) "] ; # section for CHI_1
										#set chi1_four_index_list [lsort [$chi1_definition get index]] ; #get FOUR ATOM INDEXES for CHI_1 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi1_four_index_list] == 4 } {

															set chi1_tor [measure dihed $chi1_four_index_list] ;
															puts "TOR $chi1_tor $j $residueX" ;
															puts $chi1_four_index_list
															#$chi1_definition delete
															$chi1_O4 delete
															$chi1_C1 delete
															$chi1_N1 delete
															$chi1_C6 delete
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}
								}
								#$#$#$# chi1 force feild over #$#$#$	 
																
								#$#$#$# chi2 force feild #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] CHI_2 #####" ;
															
								if { $fiveP == "A" || $fiveP == "G"} {
										
										set chi2_C2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C2')) "]
										set chi2_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
										set chi2_N9 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N9)) "]
										set chi2_C8 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C8)) "]
		
										set chi2_four_index_list [concat [$chi2_C2 get index] [$chi2_C1 get index] [$chi2_N9 get index] [$chi2_C8 get index] ]
																				
										#set chi2_definition [atomselect top "((residue $residueX) and (type C2' C1' N9 C8)) "] ; # section for CHI_2
										#set chi2_four_index_list [lsort [$chi2_definition get index]] ; #get FOUR ATOM INDEXES for CHI_2 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi2_four_index_list] == 4 } {

															set chi2_tor [measure dihed $chi2_four_index_list] ;
															puts "TOR $chi2_tor $j $residueX" ;
															puts $chi2_four_index_list
															#$chi2_definition delete
															$chi2_C2 delete
															$chi2_C1 delete
															$chi2_N9 delete
															$chi2_C8 delete
	
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								} else {

										#for C U
										
										set chi2_C2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C2')) "]
										set chi2_C1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C1')) "]
										set chi2_N1 [atomselect top "((resname $fiveP) and (residue $residueX) and (type N1)) "]
										set chi2_C6 [atomselect top "((resname $fiveP) and  (residue $residueX) and (type C6)) "]
		
										set chi2_four_index_list [concat [$chi2_C2 get index] [$chi2_C1 get index] [$chi2_N1 get index] [$chi2_C6 get index] ]
										
										
										#set chi2_definition [atomselect top "((residue $residueX) and (type C2' C1' N1 C6)) "] ; # section for CHI_2
										#set chi2_four_index_list [lsort [$chi2_definition get index]] ; #get FOUR ATOM INDEXES for CHI_2 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi2_four_index_list] == 4 } {

															set chi2_tor [measure dihed $chi2_four_index_list] ;
															puts "TOR $chi2_tor $j $residueX" ;
															puts $chi2_four_index_list
															#$chi2_definition delete
															$chi2_C2 delete
															$chi2_C1 delete
															$chi2_N1 delete
															$chi2_C6 delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								}
								#$#$#$# chi2 force feild over #$#$#$									 

                                                                #$#$#$# OHx #$#$#$
                                                                puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] OHx #####" ;
												
                                                                                                set oh_O3 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O3')) "]
                                                                                                set oh_C3 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C3')) "]
                                                                                                set oh_C2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type C2')) "]
                                                                                                set oh_O2 [atomselect top "((resname $fiveP) and (residue $residueX) and (type O2')) "]

                                                                                                set oh_four_index_list [concat [$oh_C5  get index] [$oh_C4 get index] [$oh_C3 get index] [$oh_O3 get index]]
                                                                                                
                                                                                                                                                                                                
                                                                                                #set oh_definition [atomselect top "((residue $residueX) and (type C5' C4' C3' O3')) "] ; # section for DELTA1
                                                                                                #set oh_four_index_list [lsort [$oh_definition get index]] ; #get FOUR ATOM INDEXES for DELTA1: 8981 8993 8996 8997

                                                                                                #check selection has four atoms
                                                                                                if { [llength $oh_four_index_list] == 4 } {

                                                                                                                                set oh_tor [measure dihed $oh_four_index_list] ;
                                                                                                                                puts "TOR $oh_tor $j $residueX" ;
                                                                                                                                puts $oh_four_index_list
                                                                                                                                #$oh_definition delete
                                                                                                                                $oh_O3 delete
                                                                                                                                $oh_C3 delete
                                                                                                                                $oh_C2 delete
                                                                                                                                $oh_O2 delete


                                                                                                } else {
                                                                                                                                puts "NO_tor $j $residueX" ;
                                                                                                                                #break
                                                                                                                                continue
                                                                                                }

                                                                #$#$#$# DELTAx over #$#$#$ 
								
 
								######## wrinting output file ################################	

								
										puts "$fiveP $threeP"            
													
										#puts $file "$residueX $alfa_tor $dis_alfa_O3_P " ; # print torsion
										
										#puts "$residueX $alfa_tor $dis_alfa_O3_P" ; # print torsion
										
										puts $file " $fiveP$threeP $residueX $alfa_tor $beta_tor $gamma_tor $dx_tor $epsi_tor $zeta_tor $d1_tor $d2_tor $chi0_tor $chi1_tor $chi2_tor" ; # print torsion
	
										puts "$fiveP$threeP $residueX alfa: $alfa_tor beta: $beta_tor gamma: $gamma_tor delta: $dx_tor epsi: $epsi_tor zeta: $zeta_tor d1: $d1_tor d2: $d2_tor chi0: $chi0_tor chi1: $chi1_tor chi2: $chi2_tor oh: $oh_tor" ; # print torsion
		
										
								######## wrinting output file over ###########################
								
								

								############## DIMER OUT ################
#									set dimer_sel_pdb [atomselect top " (  ( (resname $fiveP) and (residue $residueX) )  or ( (resname $threeP) and (residue [expr $residueX+1]) )  )"] ;
#									$dimer_sel_pdb writepdb $pdbname\_$fiveP$threeP\_$residueX.pdb	
#									puts "dimer out at residue $residueX for $fiveP$threeP " ; #print each value= resdueID	
								############## DIMER OUT ################


									
							} else {
									puts " residue# $residueX and residue# [expr $residueX+1] - lengths above 2.00 A | termial or missing residues" ;
									#continue dont use continue let it print everything instead
							}
					
				################### O3' and P lengths check over ######
				######################################################


					
			} else {
					puts "NO_dis  $residueX" ;
					#puts "NO_dis $j $residueX" ;
					#break
					#continue
			}
			###### if - selection check with O3' and P of alfa over ####	
			
	#lenths
##$#$#$#$#$#$# LENGTH OUT OVER #$#$#$#$#$	


        } ; # foreach over # reading over : read residue_list(0)..1..2..3 eg : residue_list(0) as A: residue 0 13 25 3 6 9 
    
    ##################

} ; # for loop over # end of component  A C G U loop

	close $file	



} ; # premutaion for loops1 over
} ; # premutaion for loops2 over


