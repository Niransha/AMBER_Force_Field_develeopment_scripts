# #https://www.ks.uiuc.edu/Research/vmd/mailing_list/vmd-l/att-3497/rmsd.tcl
# vmd -parm7 parameter -netcdf combine.mdcrd -e ../../rmsd_align_vmd.tcl


#set npdb [molinfo num]

#  for { set i 0 } { $i < $npdb } { incr i } {

#	print $i;
#	[atomselect $npdb all] move  [measure fit [atomselect $npdb all] [atomselect 0 all] ]


#  }

#forloop NOT working TO FIX

[atomselect 1 all] move  [measure fit [atomselect 1 all] [atomselect 0 all] ]


