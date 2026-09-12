#!/bin/bash

for item in alfa beta gamma epsi zeta
do
cd $item
echo $item
pwd


tor="$item"

#file="E_QM_ref_zero.dat"
#file="E_MM_zero_ref_zero.dat"
file="E_QM-MM_zero_ref_zero.dat"

#outname="_QM_refpoint_zero.png"
#outname="_MM_zero_refpoint_zero.png"
outname="_QM-MM_zero_refpoint_zero.png"


top=`cat 2d_??/???_???/$file  | sort -nk2,2 | tail -1 | awk '{printf "%3.0f\n", $2+1}'`  # y axis max

dash="_"

cat > tmp_grace.in << EOF
arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ NXY "2d_AA/BB5_RA3/$file"
 READ NXY "2d_AA/RA5_BB3/$file"
 READ NXY "2d_CC/BB5_RC3/$file"
 READ NXY "2d_CC/RC5_BB3/$file"
 READ NXY "2d_GG/BB5_RG3/$file"
 READ NXY "2d_GG/RG5_BB3/$file"
 READ NXY "2d_UU/BB5_RU3/$file"
 READ NXY "2d_UU/RU5_BB3/$file"
 #hides the NXY graph
 S0  line color 1
 S0  legend "BB5_RA3"
 S1  line color 2
 S1  legend "RA5_BB3"
 S2  line color 3
 S2  legend "BB5_RC3"
 S3  line color 4
 S3  legend "RC5_BB3"
 S4  line color 5
 S4  legend "BB5_RG3"
 S5  line color 6
 S5  legend "RG5_BB3"
 S6  line color 7
 S6  legend "BB5_RU3"
 S7  line color 8
 S7  legend "RU5_BB3"
 AUTOSCALE

#yaxis  label "QM (kcal/mol)"	
#yaxis  label "MM\szero\N (kcal/mol)"
#yaxis  label "QM-MM\szero\N (kcal/mol)"
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

world 0, 0, 400, $top

legend 1.05, 0.8
legend box linewidth 2

PRINT TO "$tor$outname"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF

xmgrace -batch tmp_grace.in -nosafe -maxpath 1000000 -hardcopy


cd ../
done


