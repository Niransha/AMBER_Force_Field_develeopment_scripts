#!/bin/bash
###########################################################
###### NKR 2022-April-17 ##################################
# first run cpptraj.torsion_analysis.sh to get dat file ###
###########################################################

sys=UUUU

rm tmp_*.in
rm hist_*.png

alfacol=7
betacol=8
gammacol=2
deltacol=3
epsicol=4
zetacol=5
chicol=6

#################################################################
#gamma deta chi has 4 times

for tor in gamma delta
do 

name=$tor
echo $name

if [[ $tor == "gamma" ]]; 
then
	var=$gammacol
	echo "$var th col"
	
elif [[ $tor == "delta" ]]; 
then
	var=$deltacol
	echo "$var th col"
fi
	

#name=$gamma
#var=$gamma
#sys=UUUU

cat > tmp_grace_${tor}.in << EOF

arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ BLOCK "AllTorsions1.dat"
 BLOCK XY "1:$var"
 BLOCK XY "1:$(($var+7))"
 BLOCK XY "1:$(($var+14))"
 BLOCK XY "1:$(($var+21))"
 #range(0..10) with 101 bins of 0.1 each
 HISTOGRAM (S0, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S1, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S2, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S3, MESH(0, 360, 361), OFF, ON)
 # output histograms to files
 WRITE G0.S4 FILE "${name}_1.dat"
 WRITE G0.S5 FILE "${name}_2.dat"
 WRITE G0.S6 FILE "${name}_3.dat"
 WRITE G0.S7 FILE "${name}_4.dat"
 # clear all data from program
 KILL G0.S0
 KILL G0.S1
 KILL G0.S2
 KILL G0.S3
 KILL G0.S4
 KILL G0.S5
 KILL G0.S6
 KILL G0.S7
# reread data back in to get rid of formatting
 READ NXY "${name}_1.dat"
 READ NXY "${name}_2.dat"
 READ NXY "${name}_3.dat"
 READ NXY "${name}_4.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "${name}:1"
 S1  line color 2
 S1  legend "${name}:2"
 S2  line color 3
 S2  legend "${name}:3"
 S3  line color 4
 S3  legend "${name}:4"
 AUTOSCALE

title "Probability distribution of ${tor} torisons - ${sys}"

yaxis  label "Normalized Probability"   
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "${name} torsion (\c0\C)"  
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

legend 1.05, 0.8
legend box linewidth 2

PRINT TO "hist_${tor}_${sys}.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF


xmgrace -batch tmp_grace_${tor}.in -nosafe -maxpath 1000000 -hardcopy


done

##################################################################################################
#alfa beta epsi zeta 3 times

for tor in alfa beta epsi zeta 
do 

name=$tor
echo $name

if [[ $tor == "alfa" ]]; 
then
	var=$alfacol
	echo "$var th col"
	
elif [[ $tor == "beta" ]]; 
then
	var=$betacol
	echo "$var th col"
elif [[ $tor == "epsi" ]]; 
then
        var=$epsicol
        echo "$var th col"

elif [[ $tor == "zeta" ]]; 
then
        var=$zetacol
        echo "$var th col"
fi
	

#name=$gamma
#var=$gamma
#sys=UUUU

cat > tmp_grace_${tor}.in << EOF

arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ BLOCK "AllTorsions1.dat"
 BLOCK XY "1:$var"
 BLOCK XY "1:$(($var+7))"
 BLOCK XY "1:$(($var+14))"
 #range(0..10) with 101 bins of 0.1 each
 HISTOGRAM (S0, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S1, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S2, MESH(0, 360, 361), OFF, ON)
 # output histograms to files
 WRITE G0.S3 FILE "${name}_rid2.dat"
 WRITE G0.S4 FILE "${name}_rid3.dat"
 WRITE G0.S5 FILE "${name}_rid4.dat"
 # clear all data from program
 KILL G0.S0
 KILL G0.S1
 KILL G0.S2
 KILL G0.S3
 KILL G0.S4
 KILL G0.S5
# reread data back in to get rid of formatting
 READ NXY "${name}_rid2.dat"
 READ NXY "${name}_rid3.dat"
 READ NXY "${name}_rid4.dat"
 #hides the NXY graph
 S0  line color 1
 S0  legend "${name}:2"
 S1  line color 2
 S1  legend "${name}:3"
 S2  line color 3
 S2  legend "${name}:4"
 AUTOSCALE

title "Probability distribution of ${tor} torisons - ${sys}"

yaxis  label "Normalized Probability"   
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "${name} torsion (\c0\C)"  
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

legend 1.05, 0.8
legend box linewidth 2

PRINT TO "hist_${tor}_${sys}.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF


xmgrace -batch tmp_grace_${tor}.in -nosafe -maxpath 1000000 -hardcopy


done

###########################  chi ############################################"
#chi 4 time occue but column issue

echo "chi"

tor=chi
var=$chicol
#sys=UUUU

cat > tmp_grace_${tor}.in << EOF

arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ BLOCK "AllTorsions1.dat"
 BLOCK XY "1:6"
 BLOCK XY "1:13"
 BLOCK XY "1:20"
 BLOCK XY "1:25"
 #range(0..10) with 101 bins of 0.1 each
 HISTOGRAM (S0, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S1, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S2, MESH(0, 360, 361), OFF, ON)
 HISTOGRAM (S3, MESH(0, 360, 361), OFF, ON)

 # output histograms to files
 WRITE G0.S4 FILE "${tor}_rid1.dat"
 WRITE G0.S5 FILE "${tor}_rid2.dat"
 WRITE G0.S6 FILE "${tor}_rid3.dat" 
 WRITE G0.S7 FILE "${tor}_rid4.dat"

 # clear all data from program
 KILL G0.S0
 KILL G0.S1
 KILL G0.S2
 KILL G0.S3
 KILL G0.S4
 KILL G0.S5
 KILL G0.S6
 KILL G0.S7

# reread data back in to get rid of formatting
 READ NXY "${tor}_rid1.dat"
 READ NXY "${tor}_rid2.dat"
 READ NXY "${tor}_rid3.dat"
 READ NXY "${tor}_rid4.dat"

 #hides the NXY graph
 S0  line color 1
 S0  legend "${tor}:1"
 S1  line color 2
 S1  legend "${tor}:2"
 S2  line color 3
 S2  legend "${tor}:3"
 S3  line color 4
 S4  legend "${tor}:4"
 AUTOSCALE

title "Probability distribution of ${tor} torisons - ${sys}"

yaxis  label "Normalized Probability"   
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "${tor} torsion (\c0\C)"  
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

legend 1.05, 0.8
legend box linewidth 2

PRINT TO "hist_${tor}_${sys}.png"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF


xmgrace -batch tmp_grace_${tor}.in -nosafe -maxpath 1000000 -hardcopy


echo "DONE ################# "






display hist_alfa_*.png
display hist_beta_*.png
display hist_gamma_*.png
display hist_delta_*.png
display hist_epsi_*.png
display hist_zeta_*.png
display hist_chi_*.png









