#commented are for rc5_bb3.xleap.init.pdb RC5 BB3 type
#babel -ipdb RA5_BB3.init.model.pdb -ogau test.inp
#exec sed -i "s/Ho/H /g" test.inp


set file [open "pes_test.com" w]


set nuc [atomselect top all] ;
set resname_list [ lsort -unique [ $nuc get resname ] ] ;  # give resname list > BB3 RA5

set nresnametype [ llength $resname_list ] ; # length = 2

for { set j 0 } { $j < $nresnametype } { incr j } {
         
         set resname_sel($j) [ atomselect top "resname [ lindex $resname_list $j ]" ]  ;
                                       # do the selection based on resname  
        #making resnames selection(0)..(1) .. to be on resname BB3 RA5
        
         set resid_list($j) [ lsort -unique [ $resname_sel($j) get resid ] ] ;
     # GIVE **serial** list for
     # residue_list(0) as BB3:  resid 2
     # residue_list(1) as RA5: resid 1 
}


set fiveP [ lindex $resname_list 0 ] ; #: RA5
set threeP [ lindex $resname_list 1 ] ; # : BB3



#$#$#$#$#$#$#$#$$ beta1 #$#$#$#$#$#$

	set beta1_definition [atomselect top " (  ( (resname $fiveP) and (type H5T O5' C5' C4') )  )"] ;

        set beta1_four_index_list [lsort [$beta1_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set beta1_four_serial_list [$beta1_definition get serial] ; # do not add "lsort" here it won't give proper oder for the gaussian torsions, lsort will oder list(1)(2)(3)(4) atoms names can be 1 2 6 3  
                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $beta1_four_index_list] == 4 } {
	        set beta1_tor [measure dihed $beta1_four_index_list] ; # using indexs mesure torsion
       		 puts $file "$beta1_four_serial_list 180.00 B" 
                  puts $file "$beta1_four_serial_list F" 

		 	
                } else {} ; 

#$#$#$#$#$#$#$#$$ gamma1 #$#$#$#$#$#$

        set gamma1_definition [atomselect top " (  ( (resname $fiveP) and (type O5' C5' C4' C3') )  )"] ;

        set gamma1_four_index_list [lsort [$gamma1_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set gamma1_four_serial_list [$gamma1_definition get serial] ; # do not add lsort here

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $gamma1_four_index_list] == 4 } {

	        set gamma1_tor [measure dihed $gamma1_four_index_list] ; # using indexs mesure torsion
		puts $file "$gamma1_four_serial_list 50.00 B"
                puts $file "$gamma1_four_serial_list F"

               } else {}; 

#  puts "[lindex $gamma1_four_serial_list 0] [lindex $gamma1_four_serial_list 2] [lindex $gamma1_four_serial_list 3] [lindex $gamma1_four_serial_list 1] 50.00 B" 

#$#$#$#$#$#$#$#$$ delta1 #$#$#$#$#$#$

        set delta1_definition [atomselect top " (  ( (resname $fiveP) and (type C5' C4' C3' O3') )  )"] ;

        set delta1_four_index_list [lsort [$delta1_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set delta1_four_serial_list [$delta1_definition get serial] ;

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $delta1_four_index_list] == 4 } {

	        set delta1_tor [measure dihed $delta1_four_index_list] ; # using indexs mesure torsion
 		puts $file "$delta1_four_serial_list 82.00 B"
                puts $file "$delta1_four_serial_list F"

                } else {};


#$#$#$#$#$#$#$#$$ delta2 #$#$#$#$#$#$

        set delta2_definition [atomselect top " (  ( (resname $fiveP) and (type C1' C2' O2' HO'2 ) )  )"] ;

        set delta2_four_index_list [lsort [$delta2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set delta2_four_serial_list [$delta2_definition get serial] ;

                #to skip the iteration for indexes less than 4 : end groups 
                if { [llength $delta2_four_index_list] == 4 } {
              
               set delta2_tor [measure dihed $delta2_four_index_list] ; # using indexs mesure torsion
	       puts $file "$delta2_four_serial_list -70.00 B"
               puts $file "$delta2_four_serial_list F"

                } else {};

#      puts "[lindex $delta2_four_serial_list 0] [lindex $delta2_four_serial_list 2] [lindex $delta2_four_serial_list 3] [lindex $delta2_four_serial_list 1] 50.00 



#$#$#$#$#$#$#$#$$ epsilon1 #$#$#$#$#$#$

        set epsilon1_definition [atomselect top "((resname $fiveP) and (type C4' C3' O3')) or ((resname $threeP) and (type P))"] ;

        set epsilon1_four_index_list [lsort [$epsilon1_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set epsilon1_four_serial_list [$epsilon1_definition get serial] ;

                if { [llength $epsilon1_four_index_list] == 4 } {            
                set epsilon1_tor [measure dihed $epsilon1_four_index_list] ; # using indexs mesure torsion
                puts $file "$epsilon1_four_serial_list 210.00 B"
                puts $file "$epsilon1_four_serial_list F"


                } else {} ;
#      puts "[lindex $epsilon1_four_serial_list 0] [lindex $epsilon1_four_serial_list 2] [lindex $epsilon1_four_serial_list 3] [lindex $epsilon1_four_serial_list 1] 50.00 


#$#$#$#$#$#$#$#$$ zeta #$#$#$#$#$#$

        set zeta_definition [atomselect top "((resname $fiveP) and (type C3' O3')) or ((resname $threeP) and (type P O5'))"] ;

        set zeta_four_index_list [lsort [$zeta_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set zeta_four_serial_list [$zeta_definition get serial] ;
        
        set zeta_tor [measure dihed $zeta_four_index_list] ;
        
        # 180 below --> 360 range
        if { $zeta_tor < 0 } { set zeta_tor [ expr $zeta_tor+360 ] }  else {puts $zeta_tor} 

        
        

                if { [llength $zeta_four_index_list] == 4 } {            
                set zeta_tor [measure dihed $zeta_four_index_list] ; # using indexs mesure torsion
                puts $file "$zeta_four_serial_list 290.00 B"
                puts $file "$zeta_four_serial_list F"

                } else {} ;
#      puts "[lindex $zeta_four_serial_list 0] [lindex $zeta_four_serial_list 2] [lindex $zeta_four_serial_list 3] [lindex $zeta_four_serial_list 1] 50.00 


#$#$#$#$#$#$#$#$$ alfa  #$#$#$#$#$#$


        set alfa_definition [atomselect top "((resname $fiveP) and (type O3')) or ((resname $threeP) and (type P O5' C5'))"] ;

        set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set alfa_four_serial_list [$alfa_definition get serial] ;

	set alfa_tor [measure dihed $alfa_four_index_list] ;
	
	# 180 below --> 360 range
	if { $alfa_tor < 0 } { set alfa_tor [ expr $alfa_tor+360 ] }  else {puts $alfa_tor} 


                if { [llength $alfa_four_index_list] == 4 } {
                set alfa_tor [measure dihed $alfa_four_index_list] ; # using indexs mesure torsion
                
                	if {$alfa_tor <= 0 } {                             
                	puts $file "$alfa_four_serial_list [format %0.2f [expr round( ($alfa_tor+360)/10 )*10] ] B"
                        puts $file "$alfa_four_serial_list F"
	
			} else {
                        puts $file "$alfa_four_serial_list [format %0.2f [expr round( ($alfa_tor)/10 )*10] ] B"
			puts $file "$alfa_four_serial_list F"			
				
			};                
                
                } else {} ;
#      puts "[lindex $alfa_four_serial_list 0] [lindex $alfa_four_serial_list 2] [lindex $alfa_four_serial_list 3] [lindex $alfa_four_serial_list 1] 50.00 


#$#$#$#$#$#$#$#$$ beta2  #$#$#$#$#$#$


        set beta2_definition [atomselect top "( ((resname $threeP) and (type P O5' C5' C4')) )"] ;

        set beta2_four_index_list [lsort [$beta2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set beta2_four_serial_list [$beta2_definition get serial] ;
        
        set beta2_tor [measure dihed $beta2_four_index_list] ;

        # 180 below --> 360 range
        if { $beta2_tor < 0 } { set beta2_tor [ expr $beta2_tor+360 ] }  else {puts $beta2_tor} 


                if { [llength $beta2_four_index_list] == 4 } {
                set beta2_tor [measure dihed $beta2_four_index_list] ; # using indexs mesure torsion

		puts $file "$beta2_four_serial_list 180.00 B"
                puts $file "$beta2_four_serial_list F"
		
#                        if {$beta2_tor <= 0 } {
#                        puts "$beta2_four_serial_list [format %.2f [expr $beta2_tor+360] ] B"
#                        } else {
#                        puts "$beta2_four_serial_list [format %.2f [expr $beta2_tor] ] B"                              
#                        };

                } else {} ;

#      puts "[lindex $beta2_four_serial_list 0] [lindex $beta2_four_serial_list 2] [lindex $beta2_four_serial_list 3] [lindex $beta2_four_serial_list 1] 50.



#$#$#$#$#$#$#$#$$ gamma2  #$#$#$#$#$#$


        set gamma2_definition [atomselect top "( ((resname $threeP) and (type O5' C5' C4' C3')) )"] ;

        set gamma2_four_index_list [lsort [$gamma2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set gamma2_four_serial_list [$gamma2_definition get serial] ;
       
        set gamma2_tor [measure dihed $gamma2_four_index_list] ;

        # 180 below --> 360 range
        if { $gamma2_tor < 0 } { set gamma2_tor [ expr $gamma2_tor+360 ] }  else {puts $gamma2_tor} 


                if { [llength $gamma2_four_index_list] == 4 } {
                set gamma2_tor [measure dihed $gamma2_four_index_list] ; # using indexs mesure torsion

#                puts "$gamma2_four_serial_list 180.00 B"

                        if {$gamma2_tor <= 0 } {
                        puts $file "$gamma2_four_serial_list [format %.2f [expr round( ($gamma2_tor+360)/10 )*10] ] B" ; # need to round up to near 10
                        puts $file "$gamma2_four_serial_list F" ; # need to round up to near 10

                        
                        } else {
                        puts $file "$gamma2_four_serial_list [format %.2f [expr floor($gamma2_tor/10)*10] ] B" ; # rounding up to near 10                              
                        puts $file "$gamma2_four_serial_list F" ; # rounding up to near 10                              
                        
                        
                        };

                } else {} ;

#puts $gamma2_tor
#      puts "[lindex $gamma2_four_serial_list 0] [lindex $gamma2_four_serial_list 2] [lindex $gamma2_four_serial_list 3] [lindex $gamma2_four_serial_

#$#$#$#$#$#$#$#$$ delta1_low  #$#$#$#$#$#$


        set delta1_low_definition [atomselect top "( ((resname $threeP) and (type C5' C4' C3' O3')) )"] ;

        set delta1_low_four_index_list [lsort [$delta1_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set delta1_low_four_serial_list [$delta1_low_definition get serial] ;

	 set delta1_tor [measure dihed $delta1_low_four_index_list] ;

        # 180 below --> 360 range
        if { $delta1_tor < 0 } { set delta1_tor [ expr $delta1_tor+360 ] }  else {puts $delta1_tor} 



                if { [llength $delta1_low_four_index_list] == 4 } {
                set delta1_low_tor [measure dihed $delta1_low_four_index_list] ; # using indexs mesure torsion

                puts $file "$delta1_low_four_serial_list 82.00 B"
                puts $file "$delta1_low_four_serial_list F"



                } else {} ;

#      puts "[lindex $delta1_low_four_serial_list 0] [lindex $delta1_low_four_serial_list 2] [lindex $delta1_low_four_serial_list 3] [lindex $delta1_low_four_ser


#$#$#$#$#$#$#$#$$ delta2_low - OH right side  #$#$#$#$#$#$


        set delta2_low_definition [atomselect top "( ((resname $threeP) and (type C1' C2' O2' HO'2)) )"] ;

        set delta2_low_four_index_list [lsort [$delta2_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set delta2_low_four_serial_list [$delta2_low_definition get serial] ;

        set delta2_tor [measure dihed $delta2_low_four_index_list] ;

        # 180 below --> 360 range
        if { $delta2_tor < 0 } { set delta2_tor [ expr $delta2_tor+360 ] }  else {puts $delta2_tor} 




                if { [llength $delta2_low_four_index_list] == 4 } {
                set delta2_low_tor [measure dihed $delta2_low_four_index_list] ; # using indexs mesure torsion

                puts $file "$delta2_low_four_serial_list -70.00 B"
                puts $file "$delta2_low_four_serial_list F"

                } else {} ;

#      puts "[lindex $delta2_low_four_serial_list 0] [lindex $delta2_low_four_serial_list 2] [lindex $delta2_low_four_serial_list 3] [lindex $del

#$#$#$#$#$#$#$#$$ epsilon2  #$#$#$#$#$#$


        set epsilon2_definition [atomselect top "( ((resname $threeP) and (type C4' C3' O3' H3T)) )"] ;

        set epsilon2_four_index_list [lsort [$epsilon2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set epsilon2_four_serial_list [$epsilon2_definition get serial] ;
        
       set epsilon2_tor [measure dihed $epsilon2_four_index_list] ;

        # 180 below --> 360 range
        if { $epsilon2_tor < 0 } { set epsilon2_tor [ expr $epsilon2_tor+360 ] }  else {puts $epsilon2_tor} 



                if { [llength $epsilon2_four_index_list] == 4 } {
                set epsilon2_tor [measure dihed $epsilon2_four_index_list] ; # using indexs mesure torsion

                puts $file "$epsilon2_four_serial_list 180.00 B"
                puts $file "$epsilon2_four_serial_list F"

                } else {} ;

#      puts "[lindex $epsilon2_four_serial_list 0] [lindex $epsilon2_four_serial_list 2] [lindex $epsilon2_four_serial_list 3] [lindex $del


#$#$#$#$#$#$#$#$$ FOR CHI UPPEr  #$#$#$#$#$#$
																		
if { $fiveP == "RC5" || $fiveP == "RU5" } {
			
        set chi_upper_definition [atomselect top "( ((resname $fiveP) and (t1ype O4' C1' N1 C4)) )"] ;

        set chi_upper_four_index_list [lsort [$chi_upper_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_upper_four_serial_list [$chi_upper_definition get serial] ;

        
                if { [llength $chi_upper_four_index_list] == 4 } {
                set chi_upper_tor [measure dihed $chi_upper_four_index_list] ; # using indexs mesure torsion

                puts $file "$chi_upper_four_serial_list 220.00 B"
                puts $file "$chi_upper_four_serial_list F"

                } else {} ;
                
} else  { ; # for A and G with N9 - C8 combination 

        set chi_upper_definition [atomselect top "( ((resname $fiveP) and (type O4' C1' N9 C8)) )"] ;

        set chi_upper_four_index_list [lsort [$chi_upper_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_upper_four_serial_list [$chi_upper_definition get serial] ;
        
        
                if { [llength $chi_upper_four_index_list] == 4 } {
                set chi_upper_tor [measure dihed $chi_upper_four_index_list] ; # using indexs mesure torsion

                puts $file "$chi_upper_four_serial_list 220.00 B"
                puts $file "$chi_upper_four_serial_list F"


                } else {} ;
}

#$#$#$#$#$#$#$#$$ FOR CHI LOWER  #$#$#$#$#$#$


if { $fiveP == "RC3" || $fiveP == "RU3" } {
                        
        set chi_upper_definition [atomselect top "( ((resname $threeP) and (type O4' C1' N1 C2)) )"] ;

        set chi_upper_four_index_list [lsort [$chi_upper_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_upper_four_serial_list [$chi_upper_definition get serial] ;
        

                if { [llength $chi_upper_four_index_list] == 4 } {
                set chi_upper_tor [measure dihed $chi_upper_four_index_list] ; # using indexs mesure torsion

                puts $file "$chi_upper_four_serial_list 180.00 B"
                puts $file "$chi_upper_four_serial_list F"

                } else {} ;

} else  { ; # for A and G with N9 - C8 combination 

        set chi_upper_definition [atomselect top "( ((resname $threeP) and (type O4' C1' N9 C8)) )"] ;

        set chi_upper_four_index_list [lsort [$chi_upper_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_upper_four_serial_list [$chi_upper_definition get serial] ;

                if { [llength $chi_upper_four_index_list] == 4 } {
                set chi_upper_tor [measure dihed $chi_upper_four_index_list] ; # using indexs mesure torsion

                puts $file "$chi_upper_four_serial_list 180.00 B"
                puts $file "$chi_upper_four_serial_list F"


                } else {} ;
}

#$#$#$#$#$#$#$#$$ CH3 UPPER  #$#$#$#$#$#$


#$#$#$#$#$#$#$#$# suger_upper #$#$#$#$#$ #####CCCHHHEEECCKK

        set suger_upper_definition [atomselect top "( ((resname $fiveP) and (type O4' C1' C2' C3')) )"] ;

        set suger_upper_four_index_list [lsort [$suger_upper_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set suger_upper_four_serial_list [$suger_upper_definition get serial] ;

                if { [llength $suger_upper_four_index_list] == 4 } {
                set suger_upper_tor [measure dihed $suger_upper_four_index_list] ; # using indexs mesure torsion

#                puts "$suger_upper_four_serial_list -26.10 B" ; not working gives 8 9 23 25; should be 8 9 25 23

puts $file "[lindex $suger_upper_four_serial_list 0] [lindex $suger_upper_four_serial_list 1]\
      [lindex $suger_upper_four_serial_list 3] [lindex $suger_upper_four_serial_list 2] -26.10 B"  

puts $file "[lindex $suger_upper_four_serial_list 0] [lindex $suger_upper_four_serial_list 1]\
      [lindex $suger_upper_four_serial_list 3] [lindex $suger_upper_four_serial_list 2] F"
        
                } else {} ;

#      puts "[lindex $suger_upper_four_serial_list 0] [lindex $suger_upper_four_serial_list 2] [lindex $suger_upper_four_serial_list 3] [lindex $del


#$#$#$#$#$#$#$#$$ suger_low  #$#$#$#$#$#$  ##### CHHHEEECCCKK

        set suger_low_definition [atomselect top "( ((resname $threeP) and (type O4' C1' C2' C3')) )"] ;

        set suger_low_four_index_list [lsort [$suger_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set suger_low_four_serial_list [$suger_low_definition get serial] ;
        
         set suger_low_four_index_list  [concat [lindex $suger_low_four_index_list 0] [lindex $suger_low_four_index_list 1] [lindex $suger_low_four_index_list 3] [lindex $suger_low_four_index_list 2] ]

       set suger_low_tor [measure dihed $suger_low_four_index_list] ;

        # 180 below --> 360 range
 #       if { $suger_low_tor < 0 } { set suger_low_tor [ expr $suger_low_tor+360 ] }  else {puts $suger_low_tor} 




                if { [llength $suger_low_four_index_list] == 4 } {
                set suger_low_tor [measure dihed $suger_low_four_index_list] ; # using indexs mesure torsion

#                puts "$suger_low_four_serial_list -26.10 B"

puts $file "[lindex $suger_low_four_serial_list 0] [lindex $suger_low_four_serial_list 1]\
      [lindex $suger_low_four_serial_list 3] [lindex $suger_low_four_serial_list 2] -26.10 B " 


puts $file "[lindex $suger_low_four_serial_list 0] [lindex $suger_low_four_serial_list 1]\
      [lindex $suger_low_four_serial_list 3] [lindex $suger_low_four_serial_list 2] F"
                } else {} ;

#      puts "[lindex $suger_low_four_serial_list 0] [lindex $suger_low_four_serial_list 2] [lindex $suger_low_four_serial_list 3] [lindex $del


puts " done ###################"




########### CHI-1 ############################


        set chi_lower_definition [atomselect top "( ((resname $threeP) and (type O4' C1' N1 C6)) )"] ;

        set chi_lower_four_index_list [lsort [$chi_lower_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_lower_four_serial_list [$chi_lower_definition get serial] ;


        set chi_lower_tor [measure dihed $chi_lower_four_index_list] ;

        # 180 below --> 360 range
        if { $chi_lower_tor < 0 } { set chi_lower_tor [ expr $chi_lower_tor+360 ] }  else {puts $chi_lower_tor} 


############## CHI-2 ##############################


        set chi_lower_definition [atomselect top "( ((resname $threeP) and (type C2' C1' N1 C6)) )"] ;

        set chi_lower_four_index_list [lsort [$chi_lower_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi_lower_four_serial_list [$chi_lower_definition get serial] ;

        set chi_lower_four_index_list  [concat [lindex $chi_lower_four_index_list 3] [lindex $chi_lower_four_index_list 0] [lindex $chi_lower_four_index_list 1] [lindex $chi_lower_four_index_list 2] ]

        set chi_lower_tor [measure dihed $chi_lower_four_index_list] ;

        # 180 below --> 360 range
        if { $chi_lower_tor < 0 } { set chi_lower_tor [ expr $chi_lower_tor+360 ] }  else {puts $chi_lower_tor} 

























