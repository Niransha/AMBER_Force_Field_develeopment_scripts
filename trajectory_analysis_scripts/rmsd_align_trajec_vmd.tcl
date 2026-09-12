# #https://www.ks.uiuc.edu/Research/vmd/mailing_list/vmd-l/att-3497/rmsd.tcl
# vmd -parm7 parameter -netcdf combine.mdcrd -e ../../rmsd_align_vmd.tcl



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

display resetview

