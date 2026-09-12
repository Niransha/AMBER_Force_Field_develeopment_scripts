#!/usr/bin/perl -w
#
# Pseudorotation Phase angle vs five nu torsional angles
#
use Math::Trig;
#
$omegaM = 49;
$pi = pi();
#die;
#
for($i=0; $i <= 360; $i+=1){
  for($j=0; $j <= 4; $j++){
    $nu[$j] = $omegaM * cos(($i + 144*($j-2))/180*$pi);
  }
  $omegaM_check = $nu[2]/cos($i/180*$pi);
  #
  # We know what nu angles are for a specific $i value (which is P). Print it.
  #
  printf("P = %8.2f | Ampl = %8.2f | nu[0] = %8.2f | nu[1] = %8.2f | nu[2] = %8.2f | nu[3] = %8.2f | nu[4] = %8.2f\n",  $i, $omegaM_check, $nu[0], $nu[1], $nu[2], $nu[3], $nu[4]);
}
