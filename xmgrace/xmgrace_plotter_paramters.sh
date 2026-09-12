#!/bin/bash

for item in alfa beta gamma epsi zeta
do
cd $item
echo $item
pwd


tor="$item"

#file="E_QM_ref_zero.dat"
#file="E_MM_zero_ref_zero.dat"
#file="E_QM-MM_zero_ref_zero.dat"
#file="ref_zero_plot_data.dat"

#outname="_QM_refpoint_zero.png"
#outname="_MM_zero_refpoint_zero.png"
#outname="_QM-MM_zero_refpoint_zero.png"
outname="_parameters.png"


top=`cat R?5_R?3/combine/plot_ref_zero_plot_data.dat | sort -nk2,2 | tail -1 | awk '{printf "%3.0f\n", $2+1}'`

dash="_"

cat > tmp_grace.in << EOF
arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ NXY "RA5_RA3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RA5_RC3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RA5_RG3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RA5_RU3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RC5_RA3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RC5_RC3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RC5_RG3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RC5_RU3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RG5_RA3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RG5_RC3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RG5_RG3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RG5_RU3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RU5_RA3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RU5_RC3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RU5_RG3/combine/plot_ref_zero_plot_data.dat"
 READ NXY "RU5_RU3/combine/plot_ref_zero_plot_data.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "AA"
 S1  line color 2
 S1  legend "AC"
 S2  line color 3
 S2  legend "AG"
 S3  line color 4
 S3  legend "AU"
 S4  line color 5
 S4  legend "CA"
 S5  line color 6
 S5  legend "CC"
 S6  line color 7
 S6  legend "CG"
 S7  line color 8
 S7  legend "CU"
 S8  line color 9
 S8  legend "GA"
 S9  line color 10
 S9  legend "GC"
 S10  line color 11
 S10  legend "GG"
 S11  line color 12
 S11  legend "GU"
 S12  line color 13
 S12  legend "UA"
 S13  line color 14
 S13  legend "UC"
 S14  line color 15
 S14  legend "UG"
 S15  line color 1
 S15  legend "UU"
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

legend 1.10, 0.8
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


