#radius of Gyration

#give output on GRoutput.dat
#############################################
#################
#set name1 [ molinfo top get name]
#set name2 [split $name1 . ]
#set pdbname [lindex $name2 0]
#puts $pdbname
################


set nuc [atomselect top all]

set n [molinfo top get numframes]

set file [open "F_resnames.dat" w]

for {set i 0} {$i < $n} {incr i} {

	$nuc frame $i			
	$nuc update			
	
	set resname_list [ lsort -dictionary -unique [ $nuc get resname ] ] ;	
	#puts $file [ expr $i]    # convert frames to nano second $i/50 
	

	puts $file " $i [lindex $resname_list 0] [lindex $resname_list 1]";	


	# in vmd



	
}
#puts $file [ expr $sumRG/$n ]

close $file


#



