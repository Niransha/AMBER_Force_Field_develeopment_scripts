proc align { molid seltext } {
  set ref [atomselect $molid $seltext frame 0]
  set sel [atomselect $molid $seltext]
  set all [atomselect $molid all]
  set n [molinfo $molid get numframes]

  for { set i 1 } { $i < $n } { incr i } {
    $sel frame $i   
    $all frame $i
    $all move [measure fit $sel $ref]
  }
  return
}


align 0 "all"





        # Prints the RMSD of the protein atoms between each timestep
        # and the first timestep for the given molecule id (default: top)
        proc print_rmsd_through_time {mol myselection} {

		set file [open "rmsd.dat" w]

                # use frame 0 for the reference
                set reference [atomselect $mol $myselection  frame 0]
                # the frame being compared
                set compare [atomselect $mol $myselection]

                set nf [molinfo $mol get numframes]
#		set nf 100
                for {set frame 0} {$frame < $nf} {incr frame} {
                        # get the correct frame
                        $compare frame $frame

                        # compute the transformation
                        set trans_mat [measure fit $compare $reference]
                        # do the alignment
                        $compare move $trans_mat
                        # compute the RMSD
                        set rmsd [measure rmsd $compare $reference]
                        # print the RMSD in file
#                        puts "RMSD of $frame is $rmsd"
 			
 			puts $file "$frame $rmsd"
                }

		 close $file

       }


print_rmsd_through_time 0 "all"
# ^ calling the above function MoliD=0 myselection=all

       


