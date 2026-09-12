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
$file2open   = "matrix_A.txt";  # This is for testing purposes. In general, any file will be used in the prediction
$file_energy = "QM-MM_notor.txt";
#
$count=0;
open(FILE, "$file2open") || die "cannot open $file2open: $!";
while(<FILE>){
  if(/#/){next};
  chomp(@_);
  s/^\s+//g;
  @tmp=split(/\s+/,$_);
  for($i=0; $i <= $#tmp; $i++){
    $matrix[$count][$i] = $tmp[$i];	# Store the cosine terms
    $A_nopdl->[$count][$i] = $matrix[$count][$i];
  }
  $count++;
}
close(FILE) || die "cannot close $file2open: $!";
#
$A = pdl($A_nopdl);
#
$count = 0;
open(FILE, "$file_energy") || die "cannot open $file_energy: $!";
while(<FILE>){
  chomp($_);
  s/^\s+//g;
  $E[$count] = $_;
  $b_nopdl->[$count][0] = $E[$count];
  $count++;
}
close(FILE) || die "cannot close $file_energy: $!";
$b = pdl($b_nopdl);
#
$AT = transpose($A);
$invATA = ($AT x $A)->inv;
#
print transpose($invATA x $AT x $b)."\n";
#
