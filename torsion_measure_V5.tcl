##########################################################
## This script will analyse rna torsion of any rcsb pbd ##
##    Niransha Kumarachchi 2/5/2020                     ##
## commented  on 1msy.pdb rcsb.com 			##  
# vmd -dispdev text new.pdb -eofexit < torison_measure_V5.tcl #
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
set pdbname [ molinfo top get name]
#set name2 [split $name1 . ]
#set pdbname [lindex $name2 0]
puts $pdbname
#############################

set file [open "tor_$pdbname\_$fiveP$threeP.dat" w]

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
								
								#	puts [expr $residueX] ; #print each value= resdueID
									set alfa_definition [atomselect top " (  ( (resname $fiveP) and ((residue $residueX)) and (type O3') )  or ( (resname $threeP) and (residue [expr $residueX+1]) and (type P O5' C5') )  )"] ; # selection for alfa ; for four atoms
									
									# set alfa_definition [atomselect top " (  ( (resname A) and ((residue 21)) and (type O3') )  or ( (resname G) and (residue 22) and (type P O5' C5') )  )  "] ; # selection for alfa ; for four atoms

									set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM INDEXES for ALFA : 8981 8993 8996 8997

									
										if { [llength $alfa_four_index_list] == 4 } {

												set alfa_tor [measure dihed $alfa_four_index_list] ;
												puts "TOR $alfa_tor $j $residueX" ;
												puts $alfa_four_index_list
												$alfa_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
										
							
								#$#$#$#$ ALFA TOR OVER #$#$#
								

								#$#$#$#$ BETA #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] BETA #####" ;
									   # puts [expr $residueX] ; #print each value= resdueID
										set beta_definition [atomselect top "((residue [expr $residueX+1]) and (type P O5' C5' C4')) "] ; # selection for BETA
										set beta_four_index_list [lsort [$beta_definition get index]] ; #get FOUR ATOM INDEXES for beta : 8981 8993 8996 8997
										
										#check selection has four atoms
										if { [llength $beta_four_index_list] == 4 } {

												set beta_tor [measure dihed $beta_four_index_list] ;
												puts "TOR $beta_tor $j $residueX" ;
												puts $beta_four_index_list
												$beta_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
										
								#$#$#$#$ BETA over #$#$#

								#$#$#$# GAMMA #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] GAMMA #####" ;
									
										set gamma_definition [atomselect top "((residue [expr $residueX+1]) and (type O5' C5' C4' C3')) "] ; # section for GAMMA
										set gamma_four_index_list [lsort [$gamma_definition get index]] ; #get FOUR ATOM INDEXES for GAMMA : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $gamma_four_index_list] == 4 } {

												set gamma_tor [measure dihed $gamma_four_index_list] ;
												puts "TOR $gamma_tor $j $residueX" ;
												puts $gamma_four_index_list
												$gamma_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}				
										
								#$#$#$# GAMMA over #$#$#
 
								#$#$#$# DELTA 1 #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] DELTA1 #####" ;
										set d1_definition [atomselect top "((residue $residueX) and (type O4' C4' C3' C2')) "] ; # section for DELTA1
										set d1_four_index_list [lsort [$d1_definition get index]] ; #get FOUR ATOM INDEXES for DELTA1: 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $d1_four_index_list] == 4 } {

												set d1_tor [measure dihed $d1_four_index_list] ;
												puts "TOR $d1_tor $j $residueX" ;
												puts $d1_four_index_list
												$d1_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}

								#$#$#$# DELTA 1 over #$#$#$ 
 
								#$#$#$# DELTA 2 #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] DELTA2 #####" ;

										set d2_definition [atomselect top "((residue $residueX) and (type O4' C1' C2' C3')) "] ; # section for  DELTA2
										set d2_four_index_list [lsort [$d2_definition get index]] ; #get FOUR ATOM INDEXES for  DELTA2: 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $d2_four_index_list] == 4 } {

												set d2_tor [measure dihed $d2_four_index_list] ;
												puts "TOR $d2_tor $j $residueX" ;
												puts $d2_four_index_list
												$d2_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}

								#$#$#$# DELTA 2 over #$#$#$

								#$#$#$# EPSI #$#$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] EPSI #####" ;

										set epsi_definition [atomselect top "( ((resname $fiveP) and (residue $residueX) and (type C4' C3' O3')) or ( (residue [expr $residueX+1]) and (type P ) )  )"] ; # section for epsi
										set epsi_four_index_list [lsort [$epsi_definition get index]] ; #get FOUR ATOM INDEXES for EPSI : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $epsi_four_index_list] == 4 } {

												set epsi_tor [measure dihed $epsi_four_index_list] ;
												puts "TOR $epsi_tor $j $residueX" ;
												puts $epsi_four_index_list
												$epsi_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
								#$#$#$# EPSI over #$#$#$#


								#$#$#$# zeta #$#$#
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] ZETA #####" ;

										set zeta_definition [atomselect top "( ( (resname $fiveP) and (residue $residueX) and (type C3' O3') ) or ( (residue [expr $residueX+1]) and (type P O5') )  )"] ; # section for zeta
										set zeta_four_index_list [lsort [$zeta_definition get index]] ; #get FOUR ATOM INDEXES for ZETA : 8981 8993 8996 8997

										#check selection has four atoms
										if { [llength $zeta_four_index_list] == 4 } {

												set zeta_tor [measure dihed $zeta_four_index_list] ;
												puts "TOR $zeta_tor $j $residueX" ;
												puts $zeta_four_index_list
												$zeta_definition delete
												
										
										} else {
												puts "NO_tor $j $residueX" ;
												#break
												continue
										}
										
								#$#$#$#$#$#$ Zeta over #$#$#$#$#$#$

								#$#$#$# chi Orginal #$#$#$
								puts " ##### checking $pdbname $fiveP $threeP residue# $residueX and residue# [expr $residueX+1] CHI_O #####" ;
							
								if { $fiveP == "A" || $fiveP == "G"} {

											set chiO_definition [atomselect top "((residue $residueX) and (type O4' C1' N9 C4)) "] ; # section for CHI_O
											set chiO_four_index_list [lsort [$chiO_definition get index]] ; #get FOUR ATOM INDEXES for CHI_O : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chiO_four_index_list] == 4 } {

															set chiO_tor [measure dihed $chiO_four_index_list] ;
															puts "TOR $chiO_tor $j $residueX" ;
															puts $chiO_four_index_list
															$chiO_definition delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}
									} else {

										#for C U
											set chiO_definition [atomselect top "((residue $residueX) and (type O4' C1' N1 C2)) "] ; # section for CHI_O
											set chiO_four_index_list [lsort [$chiO_definition get index]] ; #get FOUR ATOM INDEXES for CHI_O : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chiO_four_index_list] == 4 } {

															set chiO_tor [measure dihed $chiO_four_index_list] ;
															puts "TOR $chiO_tor $j $residueX" ;
															puts $chiO_four_index_list
															$chiO_definition delete
															
													
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

										set chi1_definition [atomselect top "((residue $residueX) and (type O4' C1' N9 C8)) "] ; # section for CHI_1
										set chi1_four_index_list [lsort [$chi1_definition get index]] ; #get FOUR ATOM INDEXES for CHI_1 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi1_four_index_list] == 4 } {

															set chi1_tor [measure dihed $chi1_four_index_list] ;
															puts "TOR $chi1_tor $j $residueX" ;
															puts $chi1_four_index_list
															$chi1_definition delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								} else {

										#for C U
										set chi1_definition [atomselect top "((residue $residueX) and (type O4' C1' N1 C6)) "] ; # section for CHI_1
										set chi1_four_index_list [lsort [$chi1_definition get index]] ; #get FOUR ATOM INDEXES for CHI_1 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi1_four_index_list] == 4 } {

															set chi1_tor [measure dihed $chi1_four_index_list] ;
															puts "TOR $chi1_tor $j $residueX" ;
															puts $chi1_four_index_list
															$chi1_definition delete
															
													
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

										set chi2_definition [atomselect top "((residue $residueX) and (type C2' C1' N9 C8)) "] ; # section for CHI_2
										set chi2_four_index_list [lsort [$chi2_definition get index]] ; #get FOUR ATOM INDEXES for CHI_2 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi2_four_index_list] == 4 } {

															set chi2_tor [measure dihed $chi2_four_index_list] ;
															puts "TOR $chi2_tor $j $residueX" ;
															puts $chi2_four_index_list
															$chi2_definition delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								} else {

										#for C U
										set chi2_definition [atomselect top "((residue $residueX) and (type C2' C1' N1 C6)) "] ; # section for CHI_2
										set chi2_four_index_list [lsort [$chi2_definition get index]] ; #get FOUR ATOM INDEXES for CHI_2 : 8981 8993 8996 8997

													#check selection has four atoms
													if { [llength $chi2_four_index_list] == 4 } {

															set chi2_tor [measure dihed $chi2_four_index_list] ;
															puts "TOR $chi2_tor $j $residueX" ;
															puts $chi2_four_index_list
															$chi2_definition delete
															
													
													} else {
															puts "NO_tor $j $residueX" ;
															#break
															continue
													}

								}
								#$#$#$# chi2 force feild over #$#$#$									 

 
								######## wrinting output file ################################	

								
										puts "$fiveP $threeP"            
													
										#puts $file "$residueX $alfa_tor $dis_alfa_O3_P " ; # print torsion
										
										#puts "$residueX $alfa_tor $dis_alfa_O3_P" ; # print torsion
										
										puts $file " $fiveP$threeP $residueX $alfa_tor $beta_tor $gamma_tor $epsi_tor $zeta_tor $d1_tor $d2_tor $chiO_tor $chi1_tor $chi2_tor" ; # print torsion                                   
	
										puts "$fiveP$threeP $residueX alfa: $alfa_tor beta: $beta_tor gamma: $gamma_tor epsi: $epsi_tor zeta: $zeta_tor d1: $d1_tor d2: $d2_tor chiO: $chiO_tor chi1: $chi1_tor chi2: $chi2_tor" ; # print torsion  
		
										
								######## wrinting output file over ###########################
								
								

								############## DIMER OUT ################
										set dimer_sel_pdb [atomselect top " (  ( (resname $fiveP) and (residue $residueX) )  or ( (resname $threeP) and (residue [expr $residueX+1]) )  )"] ;
										$dimer_sel_pdb writepdb $pdbname\_$fiveP$threeP\_$residueX.pdb	
										puts "dimer out at residue $residueX for $fiveP$threeP " ; #print each value= resdueID	
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






