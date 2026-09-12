#!/bin/sh
#
# Written by Ilyas Yildirim, FAU (Jan 29, 2018).
#
# Automated to calculate the parameters for all the backbone torsions of the dimeric systems.
#
# First, decide the torsion and dimer system we will analyze. For this purpose, use the 'pwd' command.
#
pwd=`pwd`
#tor=`echo $pwd | awk '{s=split($1,a,"/"); print a[s]}'`
tor=`pwd | awk '{s=split($1,a,"/"); for(i=1; i<=s; i++){if(a[i] ~ /^rotation_/){split(a[i],b,"_"); print b[2]; exit}}}'`
#dimer=`echo $pwd | awk '{s=split($1,a,"/"); print a[s-1]}'`
dimer=`pwd  | awk '{s=split($1,a,"/"); for(i=1; i<=s; i++){if(a[i] ~ /^dimer_/){print a[i]; exit}}}'`
rm tmp.qm tmp.mm QM-MM_notor.txt angles.txt matrix_A.txt linear_least_square_fit.pl parameters.txt energy_line.txt tmp.prediction tmp.qm_mod tmp.mm_mod tmp.prediction_final tmp.rmsd # Remove these files, which will be created throughout the script.
#
# Here we specify the locations of the qm and mm calculations.
#
qm_dir="/home/nkumarachchi2019/dimeric_force_field/qm_calcs"
#mm_dir="/media/iyildirim/FantomHD/dimeric_force_field/mm_calcs/mm_zeroed"
mm_dir="/home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/mm_zeroed"
#
# Now, extract the energies. And then compare/print/extract data for linear-least-squares-fitting.
#
ls -l $qm_dir/$dimer/qm_hf_mp2_631g/rotation_$tor/angle_*/pes.log | awk '{size=split($9,a,"/"); split(a[size-1],b,"_"); angle=b[2]; k="grep EUMP2 "$9; l=""; k|getline l; close(k); print angle"\t"l}' | sort -nk1,1 > tmp.qm
ls -l $mm_dir/$dimer/rotation_$tor/angle_*/md.out | awk '{s=split($9,a,"/"); split(a[s-1],b,"_"); angle=b[2]; k="grep Etot "$9; l=""; k|getline l; close(k); print angle"\t"l}' | sort -nk1,1 > tmp.mm
#
# Extract the energy difference (QM-MM).
#
paste tmp.qm tmp.mm | awk '{if($1 != $8){print "Error in the data"; exit}; ene_mm=$11; ene_qm=$7; gsub(/D/,"E",ene_qm); conv_rate=627.509474; diff=sprintf("%.10f", ene_qm*conv_rate - ene_mm); print diff}'  > QM-MM_notor.txt
#
# Extract the angles to create the matrix.
#
paste tmp.qm tmp.mm | awk '{if($1 != $8){print "Error in the data"; exit}; ene_mm=$11; ene_qm=$7; gsub(/D/,"E",ene_qm); conv_rate=627.509474; diff=sprintf("%.10f", ene_qm*conv_rate - ene_mm); print $1}'  > angles.txt
#
# Create the matrix (matrix_A). For this dimeric force field, I will use 4 cosine terms to describe each torsion.
#
cat angles.txt | awk '{pi=4*atan2(1,1); l=""; for(j=1; j<=NF; j++){for(i=1; i<=4; i++){vcos=cos(i*$j/180*pi); vsin=sin(i*$j/180*pi); l=l sprintf("%-13.10f %-13.10f ", vcos, vsin)}}; print l "1"}' > matrix_A.txt
#
# Start the linear-least-squares-fitting. Do we have the perl script for this case? Create the perl script, and run it.
#
cat << EOF > ./linear_least_square_fit.pl
#!/usr/bin/perl -w
#
# Written by Ilyas Yildirim (iyildirim [at] fau.edu)
#
# Single Value Decomposition (SVD):
#    A = U x S x VT
# where A is mxn matrix, U is a unitary mxm, S is a diagonal mxn, and VT is (transpose of V) is unitary nxn matrix.
# A matrix/vector operation of 
#    A.x = b 
# can be solved using SVD method, where A is an mxn matrix, and b is an mx1 vector.
#    => x = (A^-1 x b)
# where 
#    A^-1 = (VT)^-1 x S^-1 x U^-1 (aka PseudoInverse)
# Any code calculating A^-1 is also enough to solve A.x = b. In the code below, we will use PDL module of PERL.
#
use PDL;
#
\$file2open   = "matrix_A.txt";  # This is for testing purposes. In general, any file will be used in the prediction
\$file_energy = "QM-MM_notor.txt";
#
\$count=0;
open(FILE, "\$file2open") || die "cannot open \$file2open: \$!";
while(<FILE>){
  if(/#/){next};
  chomp(@_);
  s/^\s+//g;
  @tmp=split(/\s+/,\$_);
  for(\$i=0; \$i <= \$#tmp; \$i++){
    \$matrix[\$count][\$i] = \$tmp[\$i];	# Store the cosine terms
    \$A_nopdl->[\$count][\$i] = \$matrix[\$count][\$i];
  }
  \$count++;
}
close(FILE) || die "cannot close \$file2open: \$!";
#
\$A = pdl(\$A_nopdl);
#
\$count = 0;
open(FILE, "\$file_energy") || die "cannot open \$file_energy: \$!";
while(<FILE>){
  chomp(\$_);
  s/^\s+//g;
  \$E[\$count] = \$_;
  \$b_nopdl->[\$count][0] = \$E[\$count];
  \$count++;
}
close(FILE) || die "cannot close \$file_energy: \$!";
\$b = pdl(\$b_nopdl);
#
\$AT = transpose(\$A);
\$invATA = (\$AT x \$A)->inv;
#
print transpose(\$invATA x \$AT x \$b)."\n";
#
EOF
#
# Run the linear-least-squares-fitting and store the parameters...
#
chmod a+rwx ./linear_least_square_fit.pl
./linear_least_square_fit.pl | grep "\[" | grep "\]"| awk '{gsub(/\[/,""); gsub(/\]/,""); print $0}' | awk '{pi=4*atan2(1,1); l=""; for(i=1; i<=NF-1; i+=2){v=i+1; phase=atan2($v,$i)/pi*180; constant= $i/cos(phase/180*pi); l= l constant" "phase" "}; print l}' > parameters.txt
#
# Now, we will test the fitting proces...
#
./linear_least_square_fit.pl  | grep "\[" | grep "\]"| awk '{gsub(/\[/,""); gsub(/\]/,""); print $0}' | awk '{print $NF}' > energy_line.txt
#
cat angles.txt  | awk '{pi=4*atan2(1,1); k="cat ./energy_line.txt"; energy_line=""; k| getline energy_line; close(k); k="cat ./parameters.txt"; l=""; k | getline l; close(k); for(i=1; i<=10; i++){gsub(/  /," ",l); gsub(/^ /,"",l)}; size=split(l,a," "); count=0; for(i=1; i<=size; i+=2){count++; V[count]=a[i]}; count=0; for(i=2; i<=size; i+=2){count++; if(a[i]<0){a[i]+=360}; P[count]=a[i]}; ene="";for(i=1; i<=NF; i++){count=0; for(j=i*4-3; j<=i*4; j++){count++; ene+=V[j]*cos(count*$i/180*pi-P[j]/180*pi)}}; printf("%-20.10f\n", ene+energy_line)}'  > tmp.prediction
#
cat tmp.qm  | awk '{gsub(/D/,"E"); ene=sprintf("%.10f", $NF*627.509474); print ene}'  > tmp.qm_mod
cat tmp.mm  | awk '{print $4}'  > tmp.mm_mod
paste tmp.prediction tmp.mm_mod  | awk '{printf("%.10f\n", $1+$2)}'  > tmp.prediction_final
#
paste tmp.prediction_final tmp.qm_mod | awk '{s++; t+=($1-$2)^2}END{print sqrt(t/s)}'  > tmp.rmsd
#
