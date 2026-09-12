#!/bin/bash


#top=`cat tmp.dat | sort -nk3,3 | tail -1 | awk '{printf "%3.0f\n", $3+1}'` 
top=`cat rmsd1.dat | sort -nk2,2 | tail -1 | awk '{printf "%3.0f\n", $2+1}'`
xmax=10 # 10 us
#addfile=`ls add_En_plotData_??_PLUS_EMMzero_??5_??3.dat`
#dim=`pwd | awk '{split($1,a,"."); print a[2]}'`  #AC
#tor=`pwd | awk '{split($1,a,"/"); print a[8]}'` #tor

cat > tmp_grace.in << EOF
arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ BLOCK "rmsd1.dat" 
 BLOCK xy "1:2"
 #READ BLOCK "tmp.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "ToExpHairpin4-7"
# S1  line color 2
# S1  legend "ToExpHairpin3-8"
 AUTOSCALE

yaxis  label "RMSD (\cE\C)"
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "Time (\f{Symbol}m\f{}s)"	
#xaxis  tick major 4
#xaxis  tick minor ticks 4
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

world 0, 0, $xmax, $top

legend 0.1, 0.95
legend box linewidth 2

PRINT TO "test.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF

xmgrace -batch tmp_grace.in -nosafe -maxpath 1000000 -hardcopy



