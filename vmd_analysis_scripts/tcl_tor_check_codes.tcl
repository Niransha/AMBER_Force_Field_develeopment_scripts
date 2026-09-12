# NRK 8/June/2024
# check torsion of a dimer in Tk console 


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



puts "################# alfa ###########"
        set alfa_definition [atomselect top "((resname $fiveP) and (type O3')) or ((resname $threeP) and (type P O5' C5'))"] ;

        set alfa_four_index_list [lsort [$alfa_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set alfa_four_serial_list [$alfa_definition get serial] ;

        set alfa_tor [measure dihed $alfa_four_index_list] ;

        # 180 below --> 360 range
        if { $alfa_tor < 0 } { set alfa_tor [ expr $alfa_tor+360 ] }  else {puts $alfa_tor} 



puts "################# beta ###########"

        set beta2_definition [atomselect top "( ((resname $threeP) and (type P O5' C5' C4')) )"] ;

        set beta2_four_index_list [lsort [$beta2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 

        set beta2_four_serial_list [$beta2_definition get serial] ;

        set beta2_tor [measure dihed $beta2_four_index_list] ;

        # 180 below --> 360 range
        if { $beta2_tor < 0 } { set beta2_tor [ expr $beta2_tor+360 ] }  else {puts $beta2_tor} 


puts "################# gamma ###########"

        set gamma2_definition [atomselect top "( ((resname $threeP) and (type O5' C5' C4' C3')) )"] ;

        set gamma2_four_index_list [lsort [$gamma2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 3

        set gamma2_four_serial_list [$gamma2_definition get serial] ;

        set gamma2_tor [measure dihed $gamma2_four_index_list] ;

        # 180 below --> 360 range
        if { $gamma2_tor < 0 } { set gamma2_tor [ expr $gamma2_tor+360 ] }  else {puts $gamma2_tor} 
        
puts "################# delta ###########"
        set delta1_low_definition [atomselect top "( ((resname $threeP) and (type C5' C4' C3' O3')) )"] ;

        set delta1_low_four_index_list [lsort [$delta1_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set delta1_low_four_serial_list [$delta1_low_definition get serial] ;

         set delta1_tor [measure dihed $delta1_low_four_index_list] ;

        # 180 below --> 360 range
        if { $delta1_tor < 0 } { set delta1_tor [ expr $delta1_tor+360 ] }  else {puts $delta1_tor} 



puts "################# epsi ###########"

        set epsilon2_definition [atomselect top "( ((resname $threeP) and (type C4' C3' O3' H3T)) )"] ;

        set epsilon2_four_index_list [lsort [$epsilon2_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 

        set epsilon2_four_serial_list [$epsilon2_definition get serial] ;

       set epsilon2_tor [measure dihed $epsilon2_four_index_list] ;

        # 180 below --> 360 range
        if { $epsilon2_tor < 0 } { set epsilon2_tor [ expr $epsilon2_tor+360 ] }  else {puts $epsilon2_tor} 


puts "################# zeta ###########"
        set zeta_definition [atomselect top "((resname $fiveP) and (type C3' O3')) or ((resname $threeP) and (type P O5'))"] ;

        set zeta_four_index_list [lsort [$zeta_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set zeta_four_serial_list [$zeta_definition get serial] ;
 
        set zeta_tor [measure dihed $zeta_four_index_list] ;
 
        # 180 below --> 360 range
        if { $zeta_tor < 0 } { set zeta_tor [ expr $zeta_tor+360 ] }  else {puts $zeta_tor} 

 


puts "################# OH grop right ###########"
        set delta2_low_definition [atomselect top "( ((resname $threeP) and (type C1' C2' O2' HO'2)) )"] ;

        set delta2_low_four_index_list [lsort [$delta2_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial

        set delta2_low_four_serial_list [$delta2_low_definition get serial] ;

        set delta2_tor [measure dihed $delta2_low_four_index_list] ;

        # 180 below --> 360 range
        if { $delta2_tor < 0 } { set delta2_tor [ expr $delta2_tor+360 ] }  else {puts $delta2_tor} 



puts "################# suger pucker lower  ###########"

        set suger_low_definition [atomselect top "( ((resname $threeP) and (type O4' C1' C2' C3')) )"] ;

        set suger_low_four_index_list [lsort [$suger_low_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set suger_low_four_serial_list [$suger_low_definition get serial] ;

         set suger_low_four_index_list  [concat [lindex $suger_low_four_index_list 0] [lindex $suger_low_four_index_list 1] [lindex $suger_low_four_index_list 3] [lindex $suger_low_four_index_list 2] ]

       set suger_low_tor [measure dihed $suger_low_four_index_list] ;



puts "################# CHI-1 ###########"
    set chi1_lower_definition [atomselect top "( ((resname $threeP) and (type O4' C1' N1 C6)) )"] ;

        set chi1_lower_four_index_list [lsort [$chi1_lower_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 3

        set chi1_lower_four_serial_list [$chi1_lower_definition get serial] ;


        set chi1_lower_tor [measure dihed $chi1_lower_four_index_list] ;

        # 180 below --> 360 range
        if { $chi1_lower_tor < 0 } { set chi1_lower_tor [ expr $chi1_lower_tor+360 ] }  else {puts $chi1_lower_tor} 



puts "################# CHI-2 ###########"

        set chi2_lower_definition [atomselect top "( ((resname $threeP) and (type C2' C1' N1 C6)) )"] ;

        set chi2_lower_four_index_list [lsort [$chi2_lower_definition get index]] ; #get FOUR ATOM SERIAL-INDEXES for ALFA : serial 31 32 35 36

        set chi2_lower_four_serial_list [$chi2_lower_definition get serial] ;

        set chi2_lower_four_index_list  [concat [lindex $chi2_lower_four_index_list 3] [lindex $chi2_lower_four_index_list 0] [lindex $chi2_lower_four_index_list 1] [lindex $chi2_lower_four_index_list 2] ]

        set chi2_lower_tor [measure dihed $chi2_lower_four_index_list] ;

        # 180 below --> 360 range
        if { $chi2_lower_tor < 0 } { set chi2_lower_tor [ expr $chi2_lower_tor+360 ] }  else {puts $chi2_lower_tor} 





puts "alfa : $alfa_tor"
puts "beta : $beta2_tor"
puts "gamma : $gamma2_tor"
puts "delta low: $delta1_tor"
puts "epsi : $epsilon2_tor"
puts "zeta : $zeta_tor"
puts "OH lower right : $delta2_tor"
puts " suger pucker 3' end ] : $suger_low_tor "
puts "CHI-1 : $chi1_lower_tor"
puts "CHI-2 : $chi2_lower_tor"

