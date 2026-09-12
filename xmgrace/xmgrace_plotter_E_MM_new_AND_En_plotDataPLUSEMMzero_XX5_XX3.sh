#!/bin/bash


top=`cat E_MM_new.dat | sort -nk2,2 | tail -1 | awk '{printf "%3.0f\n", $2+1}'`
addfile=`ls add_En_plotData_??_PLUS_EMMzero_??5_??3.dat`
dim=`pwd | awk '{split($1,a,"."); print a[2]}'`  #AC
tor=`pwd | awk '{split($1,a,"/"); print a[8]}'` #tor


cat > tmp_grace.in << EOF
arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ NXY "E_MM_new.dat"
 READ NXY "add_En_plotData_GA_PLUS_EMMzero_BB5_RA3.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "E_MM_new_${dim}.dat"
 S1  line color 2
 S1  legend "$addfile"
 AUTOSCALE

yaxis  label "Energy (kcal/mol)"
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "$tor torsion (\c0\C)"	
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

#world 0, 0, 400, $top

legend 0.1, 0.95
legend box linewidth 2

PRINT TO "new_min_${tor}_${dim}_vs_MMzeroPlus_${dim}profile.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF

xmgrace -batch tmp_grace.in -nosafe -maxpath 1000000 -hardcopy

