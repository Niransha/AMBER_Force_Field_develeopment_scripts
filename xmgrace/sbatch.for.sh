#!/bin/bash

rm tmp_*.in

dash="_";
#for fol in bulges hairpins iloops junction single-strands stems
for tor in $(cat tor_list)
do 


declare -a myArray
myArray=(A C G U)
i=0
for x1 in ${myArray[@]}
  do
    for x2 in ${myArray[@]}
      do
         dimer[i++]="$x1$x2"
      done
  done
declare -p dimer
#echo ${dimer[@]} # print dimers
dimer_len=${#dimer[@]}
j=0
while [ $j -lt $dimer_len ]
  do
 #   echo ${dimer[j]}
##################
	
#echo dimer_all_$fol\_${dimer[j]} 

cat > tmp_grace_${dimer[j]}.in << EOF

arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ NXY "../dimer_all_stems/outfiles/$tor$dash${dimer[j]}.dat"
 READ NXY "../dimer_all_hairpins/outfiles/$tor$dash${dimer[j]}.dat"
 READ NXY "../dimer_all_bulges/outfiles/$tor$dash${dimer[j]}.dat"
 READ NXY "../dimer_all_iloops/outfiles/$tor$dash${dimer[j]}.dat"
 READ NXY "../dimer_all_single-strands/outfiles/$tor$dash${dimer[j]}.dat"
 READ NXY "../dimer_all_junctions/outfiles/$tor$dash${dimer[j]}.dat"
 #range(0..10) with 101 bins of 0.1 each
 HISTOGRAM (S0, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S1, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S2, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S3, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S4, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S5, MESH(0, 360, 361), OFF, ON)
 # output histograms to files
 WRITE G0.S6 FILE "stems_$tor$dash${dimer[j]}.dat"
 WRITE G0.S7 FILE "hairpins_$tor$dash${dimer[j]}.dat"
 WRITE G0.S8 FILE "bulges_$tor$dash${dimer[j]}.dat"
 WRITE G0.S9 FILE "iloops_$tor$dash${dimer[j]}.dat"
 WRITE G0.S10 FILE "sstrands_$tor$dash${dimer[j]}.dat"
 WRITE G0.S11 FILE "junctions_$tor$dash${dimer[j]}.dat"
 # clear all data from program
 KILL G0.S0
 KILL G0.S1
 KILL G0.S2
 KILL G0.S3
 KILL G0.S4
 KILL G0.S5
 KILL G0.S6
 KILL G0.S7
 KILL G0.S8
 KILL G0.S9
 KILL G0.S10
 KILL G0.S11
# reread data back in to get rid of formatting
 READ NXY "stems_$tor$dash${dimer[j]}.dat"
 READ NXY "hairpins_$tor$dash${dimer[j]}.dat"
 READ NXY "bulges_$tor$dash${dimer[j]}.dat"
 READ NXY "iloops_$tor$dash${dimer[j]}.dat"
 READ NXY "sstrands_$tor$dash${dimer[j]}.dat"
 READ NXY "junctions_$tor$dash${dimer[j]}.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "stems"
 S1  line color 2
 S1  legend "hairpins"
 S2  line color 3
 S2  legend "bulges"
 S3  line color 4
 S3  legend "iloops"
 S4  line color 5
 S4  legend "sstrands"
 S5  line color 6
 S5  legend "junctions"
 AUTOSCALE

title "${dimer[j]}-$tor"

yaxis  label "Normalized Porbability"   
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "torsion (\c0\C)"  
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

legend 1.05, 0.8
legend box linewidth 2

PRINT TO "$tor$dash${dimer[j]}.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF


xmgrace -batch tmp_grace_${dimer[j]}.in -nosafe -maxpath 1000000 -hardcopy




#####################
    ((j++))
  done
#date



echo $fol 
done 

