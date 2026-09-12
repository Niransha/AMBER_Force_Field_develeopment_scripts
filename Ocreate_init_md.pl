#!/usr/bin/perl -w
#
# Written by Ilyas Yildirim, 1/29/2018, FAU.
#
# This script will create the init rst files for the dimeric systems utilizing the GG dimers. It will then build the full structure. Only the chi torsions will be different. This should
# be adjusted after AM1 optimization step.
#
$initxyz = "opt.xyz";
$prmtop  = "../../prmtop.zeroed.new";
#
# Create sample.pdb file
#
system("ambpdb -aatm -p $prmtop -c $initxyz > sample.pdb");   ## create sample.pdb
#
# Open .pdb file to store necessary data for RST file
#
$count = -1;
open(F2O, "sample.pdb") || die "cannot open sample.pdb: $!";
while(<F2O>){
  if(! /^ATOM/){next};
  chomp($_);
  s/^\s+//g;
  $count++;
  @tmp = split(/\s+/, $_);
  $atomid[$count]   = $tmp[1];
  $atomname[$count] = $tmp[2];
  $resname[$count]  = $tmp[3];
#  $resname[$count]  =~ s/[R,3,5]//g;
  $resid[$count]    = $tmp[4];
#  $x[$count]        = $tmp[5];
#  $y[$count]        = $tmp[6];
#  $z[$count]        = $tmp[7];
  $atid{"$atomname[$count]"}{"$resid[$count]"} = $atomid[$count];
##  @tmp1 = split(//, $atomname[$count]);
 ## $element[$count]  = $tmp1[0];	# First character of the name is the element type.
}

close(F2O) || die "cannot close sample.pdb: $!";
#
check_dihedrals("$initxyz");
#
# Constant torsions used...
#



$h5t_o5s_c5s_c4s  = 180;
$o5s_c5s_c4s_c3s  = 50; 	# terminal gamma
$c5s_c4s_c3s_o3s  = 82;		# delta
$c1s_c2s_o2s_ho2s = 80.30;	# -OH orientation
#$epsilon = "";
#$zeta    = "";
#$alfa    = ""; 
#$beta    = "";
#$gamma   = "";
$c4s_c3s_o3s_h3t  = 180;
$chi              = 200;
$nonplanar        = 180;
$o4s_c1s_c2s_c3s  = -26.10;
#
#############################################
$pwd = $ENV{"PWD"};
@tmp = split(/\//, $pwd);
for($i=0; $i<=$#tmp; $i++){
  if($tmp[$i] =~ /2d_/){
    $dimer_type = $tmp[$i];
    $dimer_type =~ s/2d_//g;
  } elsif($tmp[$i] =~ /rotation/){
    $tor_case = $tmp[$i];
    $tor_case =~ s/rotation_//g;
  }
}
#print "$dimer_type\n";
@res = split(//, $dimer_type);
####################################################


$RST_FILE = "RST";
open(FILE2WRITE,">$RST_FILE") || die "cannot open $RST_FILE: $!";
print FILE2WRITE "# 1 $resname[0] 5'END: (1 $resname[0] H5T)-(1 $resname[0] O5')-(1 $resname[0] C5')-(1 $resname[0] C4') $h5t_o5s_c5s_c4s\n";
print FILE2WRITE " &rst           iat = ".$atid{"H5T"}{"1"}.",".$atid{"O5'"}{"1"}.",".$atid{"C5'"}{"1"}.",".$atid{"C4'"}{"1"}.",\n";
print FILE2WRITE "                r1 = ".($h5t_o5s_c5s_c4s-180).", r2 = ".($h5t_o5s_c5s_c4s).", r3 = ".($h5t_o5s_c5s_c4s).", r4 = ".($h5t_o5s_c5s_c4s+180).",\n";
print FILE2WRITE "                rk2 =   100000.0, rk3 =   100000.0, ialtd=0,               &end\n\n";
print FILE2WRITE "# 1 $resname[0] TERMINAL GAMMA: (1 $resname[0] O5')-(1 $resname[0] C5')-(1 $resname[0] C4')-(1 $resname[0] C3') $o5s_c5s_c4s_c3s\n";
print FILE2WRITE " &rst           iat = ".$atid{"O5'"}{"1"}.",".$atid{"C5'"}{"1"}.",".$atid{"C4'"}{"1"}.",".$atid{"C3'"}{"1"}.",\n";
print FILE2WRITE "                r1 = ".($o5s_c5s_c4s_c3s-180).", r2 = ".($o5s_c5s_c4s_c3s).", r3 = ".($o5s_c5s_c4s_c3s).", r4 = ".($o5s_c5s_c4s_c3s+180).", &end\n\n";
print FILE2WRITE "# 1 $resname[0] DELTA-1: (1 $resname[0] C5')-(1 $resname[0] C4')-(1 $resname[0] C3')-(1 $resname[0] O3') $c5s_c4s_c3s_o3s\n";
print FILE2WRITE " &rst           iat = ".$atid{"C5'"}{"1"}.",".$atid{"C4'"}{"1"}.",".$atid{"C3'"}{"1"}.",".$atid{"O3'"}{"1"}.",\n";
print FILE2WRITE "                r1 = ".($c5s_c4s_c3s_o3s-180).", r2 = ".($c5s_c4s_c3s_o3s).", r3 = ".($c5s_c4s_c3s_o3s).", r4 = ".($c5s_c4s_c3s_o3s+180).", &end\n\n";
print FILE2WRITE "# 1 $resname[0] DELTA-2: (1 $resname[0] O4')-(1 $resname[0] C1')-(1 $resname[0] C2')-(1 $resname[0] C3') $o4s_c1s_c2s_c3s\n";
print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"1"}.",".$atid{"C1'"}{"1"}.",".$atid{"C2'"}{"1"}.",".$atid{"C3'"}{"1"}.",\n";
print FILE2WRITE "                r1 = ".($o4s_c1s_c2s_c3s-180).", r2 = ".($o4s_c1s_c2s_c3s).", r3 = ".($o4s_c1s_c2s_c3s).", r4 = ".($o4s_c1s_c2s_c3s+180).", &end\n\n";
print FILE2WRITE "# 1 $resname[0] 2'-OH: (1 $resname[0] C1')-(1 $resname[0] C2')-(1 $resname[0] O2')-(1 $resname[0] HO'2) $c1s_c2s_o2s_ho2s\n";
print FILE2WRITE " &rst           iat = ".$atid{"C1'"}{"1"}.",".$atid{"C2'"}{"1"}.",".$atid{"O2'"}{"1"}.",".$atid{"HO'2"}{"1"}.",\n";
print FILE2WRITE "                r1 = ".($c1s_c2s_o2s_ho2s-180).", r2 = ".($c1s_c2s_o2s_ho2s).", r3 = ".($c1s_c2s_o2s_ho2s).", r4 = ".($c1s_c2s_o2s_ho2s+180).", &end\n\n";
print FILE2WRITE "# 2 $resname[$count] DELTA-1: (2 $resname[$count] C5')-(2 $resname[$count] C4')-(2 $resname[$count] C3')-(2 $resname[$count] O3') $c5s_c4s_c3s_o3s\n";
print FILE2WRITE " &rst           iat = ".$atid{"C5'"}{"2"}.",".$atid{"C4'"}{"2"}.",".$atid{"C3'"}{"2"}.",".$atid{"O3'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($c5s_c4s_c3s_o3s-180).", r2 = ".($c5s_c4s_c3s_o3s).", r3 = ".($c5s_c4s_c3s_o3s).", r4 = ".($c5s_c4s_c3s_o3s+180).", &end\n\n";
print FILE2WRITE "# 2 $resname[$count] DELTA-2: (2 $resname[$count] O4')-(2 $resname[$count] C1')-(2 $resname[$count] C2')-(2 $resname[$count] C3') $o4s_c1s_c2s_c3s\n";
print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"2"}.",".$atid{"C1'"}{"2"}.",".$atid{"C2'"}{"2"}.",".$atid{"C3'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($o4s_c1s_c2s_c3s-180).", r2 = ".($o4s_c1s_c2s_c3s).", r3 = ".($o4s_c1s_c2s_c3s).", r4 = ".($o4s_c1s_c2s_c3s+180).", &end\n\n";
print FILE2WRITE "# 2 $resname[$count] 2'-OH: (2 $resname[$count] C1')-(2 $resname[$count] C2')-(2 $resname[$count] O2')-(2 $resname[$count] HO'2) $c1s_c2s_o2s_ho2s\n";
print FILE2WRITE " &rst           iat = ".$atid{"C1'"}{"2"}.",".$atid{"C2'"}{"2"}.",".$atid{"O2'"}{"2"}.",".$atid{"HO'2"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($c1s_c2s_o2s_ho2s-180).", r2 = ".($c1s_c2s_o2s_ho2s).", r3 = ".($c1s_c2s_o2s_ho2s).", r4 = ".($c1s_c2s_o2s_ho2s+180).", &end\n\n";
print FILE2WRITE "# 2 $resname[$count] 3'END: (2 $resname[$count] C4')-(2 $resname[$count] C3')-(2 $resname[$count] O3')-(2 $resname[$count] H3T) $c4s_c3s_o3s_h3t\n";
print FILE2WRITE " &rst           iat = ".$atid{"C4'"}{"2"}.",".$atid{"C3'"}{"2"}.",".$atid{"O3'"}{"2"}.",".$atid{"H3T"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($c4s_c3s_o3s_h3t-180).", r2 = ".($c4s_c3s_o3s_h3t).", r3 = ".($c4s_c3s_o3s_h3t).", r4 = ".($c4s_c3s_o3s_h3t+180).", &end\n\n";
print FILE2WRITE "# EPSILON: (1 $resname[0] C4')-(1 $resname[0] C3')-(1 $resname[0] O3')-(2 $resname[$count] P) $epsilon\n";
print FILE2WRITE " &rst           iat = ".$atid{"C4'"}{"1"}.",".$atid{"C3'"}{"1"}.",".$atid{"O3'"}{"1"}.",".$atid{"P"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($epsilon-180).", r2 = ".($epsilon).", r3 = ".($epsilon).", r4 = ".($epsilon+180).", &end\n\n";
print FILE2WRITE "# ZETA: (1 $resname[0] C3')-(1 $resname[0] O3')-(2 $resname[$count] P)-(2 $resname[$count] O5') $zeta\n";
print FILE2WRITE " &rst           iat = ".$atid{"C3'"}{"1"}.",".$atid{"O3'"}{"1"}.",".$atid{"P"}{"2"}.",".$atid{"O5'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($zeta-180).", r2 = ".($zeta).", r3 = ".($zeta).", r4 = ".($zeta+180).", &end\n\n";
print FILE2WRITE "# ALFA: (1 $resname[0] O3')-(2 $resname[$count] P)-(2 $resname[$count] O5')-(2 $resname[$count] C5') $alfa\n";
print FILE2WRITE " &rst           iat = ".$atid{"O3'"}{"1"}.",".$atid{"P"}{"2"}.",".$atid{"O5'"}{"2"}.",".$atid{"C5'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($alfa-180).", r2 = ".($alfa).", r3 = ".($alfa).", r4 = ".($alfa+180).", &end\n\n";
print FILE2WRITE "# BETA: (2 $resname[$count] P)-(2 $resname[$count] O5')-(2 $resname[$count] C5')-(2 $resname[$count] C4') $beta\n";
print FILE2WRITE " &rst           iat = ".$atid{"P"}{"2"}.",".$atid{"O5'"}{"2"}.",".$atid{"C5'"}{"2"}.",".$atid{"C4'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($beta-180).", r2 = ".($beta).", r3 = ".($beta).", r4 = ".($beta+180).", &end\n\n";
print FILE2WRITE "# GAMMA: (2 $resname[$count] O5')-(2 $resname[$count] C5')-(2 $resname[$count] C4')-(2 $resname[$count] C3') $gamma\n";
print FILE2WRITE " &rst           iat = ".$atid{"O5'"}{"2"}.",".$atid{"C5'"}{"2"}.",".$atid{"C4'"}{"2"}.",".$atid{"C3'"}{"2"}.",\n";
print FILE2WRITE "                r1 = ".($gamma-180).", r2 = ".($gamma).", r3 = ".($gamma).", r4 = ".($gamma+180).", &end\n\n";
#
# CHI torsions
#
 # NRK 
if (($resname[1] eq "BB3")){
 if (($res[0] eq "C") || ($res[0] eq "U")){
  print FILE2WRITE "# CHI 1: (1 $resname[0] O4')-(1 $resname[0] C1')-(1 $resname[0] N1)-(1 $resname[0] C2) $chi\n";
  print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"1"}.",".$atid{"C1'"}{"1"}.",".$atid{"N1"}{"1"}.",".$atid{"C2"}{"1"}.",\n";
  print FILE2WRITE "                r1 = ".($chi-180).", r2 = ".($chi).", r3 = ".($chi).", r4 = ".($chi+180).", &end\n\n";
  } elsif(($res[0] eq "A") || ($res[0] eq "G")){
  print FILE2WRITE "# CHI 1: (1 $resname[0] O4')-(1 $resname[0] C1')-(1 $resname[0] N9)-(1 $resname[0] C4) $chi\n";
  print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"1"}.",".$atid{"C1'"}{"1"}.",".$atid{"N9"}{"1"}.",".$atid{"C4"}{"1"}.",\n";  #############131
  print FILE2WRITE "                r1 = ".($chi-180).", r2 = ".($chi).", r3 = ".($chi).", r4 = ".($chi+180).", &end\n\n";
 }
}
elsif (($resname[0] eq "BB5")) {  #NRK
if (($res[1] eq "C") || ($res[1] eq "U")){
  print FILE2WRITE "# CHI 2: (2 $resname[$count] O4')-(2 $resname[$count] C1')-(2 $resname[$count] N1)-(2 $resname[$count] C2) $chi\n";
  print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"2"}.",".$atid{"C1'"}{"2"}.",".$atid{"N1"}{"2"}.",".$atid{"C2"}{"2"}.",\n";
  print FILE2WRITE "                r1 = ".($chi-180).", r2 = ".($chi).", r3 = ".($chi).", r4 = ".($chi+180).", &end\n\n";
  } elsif(($res[1] eq "A") || ($res[1] eq "G")){
  print FILE2WRITE "# CHI 2: (2 $resname[$count] O4')-(2 $resname[$count] C1')-(2 $resname[$count] N9)-(2 $resname[$count] C4) $chi\n";
  print FILE2WRITE " &rst           iat = ".$atid{"O4'"}{"2"}.",".$atid{"C1'"}{"2"}.",".$atid{"N9"}{"2"}.",".$atid{"C4"}{"2"}.",\n";
  print FILE2WRITE "                r1 = ".($chi-180).", r2 = ".($chi).", r3 = ".($chi).", r4 = ".($chi+180).", &end\n\n";
  }
}
##

#
# Planar amino groups
############################
if (($resname[1] eq "BB3")){     #NRK
 if ($res[0] eq "C") {
    print FILE2WRITE "# -NH2: (1 $resname[0] C4)-(1 $resname[0] H41)-(1 $resname[0] N4)-(1 $resname[0] H42) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C4"}{"1"}.",".$atid{"H41"}{"1"}.",".$atid{"N4"}{"1"}.",".$atid{"H42"}{"1"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n";
  } elsif ($res[0] eq "A") {
    print FILE2WRITE "# -NH2: (1 $resname[0] C6)-(1 $resname[0] H61)-(1 $resname[0] N6)-(1 $resname[0] H62) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C6"}{"1"}.",".$atid{"H61"}{"1"}.",".$atid{"N6"}{"1"}.",".$atid{"H62"}{"1"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n";
  } elsif ($res[0] eq "G") {
    print FILE2WRITE "# -NH2: (1 $resname[0] C2)-(1 $resname[0] H21)-(1 $resname[0] N2)-(1 $resname[0] H22) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C2"}{"1"}.",".$atid{"H21"}{"1"}.",".$atid{"N2"}{"1"}.",".$atid{"H22"}{"1"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n";
  }
}
elsif (($resname[0] eq "BB5")) { #NRK
  if ($res[1] eq "C") {
    print FILE2WRITE "# -NH2: (2 $resname[$count] C4)-(2 $resname[$count] H41)-(2 $resname[$count] N4)-(2 $resname[$count] H42) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C4"}{"2"}.",".$atid{"H41"}{"2"}.",".$atid{"N4"}{"2"}.",".$atid{"H42"}{"2"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n"; 
  } elsif ($res[1] eq "A") {
    print FILE2WRITE "# -NH2: (2 $resname[$count] C6)-(2 $resname[$count] H61)-(2 $resname[$count] N6)-(2 $resname[$count] H62) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C6"}{"2"}.",".$atid{"H61"}{"2"}.",".$atid{"N6"}{"2"}.",".$atid{"H62"}{"2"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n";
  } elsif ($res[1] eq "G") {
    print FILE2WRITE "# -NH2: (2 $resname[$count] C2)-(2 $resname[$count] H21)-(2 $resname[$count] N2)-(2 $resname[$count] H22) $nonplanar\n";
    print FILE2WRITE " &rst           iat = ".$atid{"C2"}{"2"}.",".$atid{"H21"}{"2"}.",".$atid{"N2"}{"2"}.",".$atid{"H22"}{"2"}.",\n";
    print FILE2WRITE "                r1 = ".($nonplanar-180).", r2 = ".($nonplanar).", r3 = ".($nonplanar).", r4 = ".($nonplanar+180).", &end\n\n";
  }
}
#########################################
#die;

#
# Create runmin
#
$prevrst = "opt.xyz";
open(FILE2WRITE,">runmin") || die "cannot open runmin: $!";
print FILE2WRITE "\#!/bin/csh -f\n\n";
print FILE2WRITE "set sander = \"\$AMBERHOME/bin/sander\"\n\n";
print FILE2WRITE "/bin/rm -f min\n\n";
print FILE2WRITE "cat > min <<EOF\n";
print FILE2WRITE "Minimization with NMR restraints\n";
print FILE2WRITE " &cntrl\n";
print FILE2WRITE "  imin=1,maxcyc=500000,ncyc=50000,ntb=0,cut= 999.0,\n";
print FILE2WRITE "  nmropt=1,ntpr=50000,\n";   
print FILE2WRITE " /\n";   
print FILE2WRITE " &wt type='REST', istep1=0,istep2=0,value1=1.0,value2=1.0,\n";   
print FILE2WRITE " /\n";   
print FILE2WRITE " &wt type='END'\n";   
print FILE2WRITE " /\n";   
print FILE2WRITE "LISTOUT=POUT\n";   
print FILE2WRITE "DISANG=./RST\n";   
print FILE2WRITE "EOF\n\n";
print FILE2WRITE "cat > md.in <<EOF\n"; 
print FILE2WRITE "0 step MD for alpha = $alfa beta = $beta gamma = $gamma\n";
print FILE2WRITE " &cntrl\n";
print FILE2WRITE "  imin=0,ntb=0,cut=999,nstlim=0,dt=0.001,nscm=5000,nrespa=2,ntt=3,gamma_ln=1,tempi=0,temp0=0,\n";
print FILE2WRITE " /\n";
print FILE2WRITE "EOF\n\n";
print FILE2WRITE "\$sander -O -i min   -p $prmtop -c $prevrst -o min1.out -r min1.rst < /dev/null || goto error\n\n";	# Sometimes the initial minimization does not work. Thus,
print FILE2WRITE "\$sander -O -i min   -p $prmtop -c min1.rst -o min2.out -r min2.rst < /dev/null || goto error\n\n";	# do a 2-step minimization process.
print FILE2WRITE "\$sander -O -i md.in -p $prmtop -c min2.rst -o md.out   -r md.rst   < /dev/null || goto error\n";
#print FILE2WRITE "cp min.rst prev.rst\n";
print FILE2WRITE "\$AMBERHOME/bin/ambpdb -aatm -p $prmtop -c min2.rst > min.pdb\n";
print FILE2WRITE "exit(0)\n";
print FILE2WRITE "echo \"  \${0}:  Program error\"\n";
print FILE2WRITE "exit(1)\n";
close(FILE2WRITE) || die "cannot close runmin: $!";
system("chmod a+rwx ./runmin");
#system("./runmin");
############################## done with runmin ##################################



############# Subroutines #############
sub check_dihedrals {
  my($spdbfile) = (@_);
  open(F2W_PTRAJ, ">ptraj_torsion.in") || die "cannot open ptraj_torsion.in: $!";
  print F2W_PTRAJ "trajin $spdbfile\n";
  print F2W_PTRAJ "dihedral epsilon out e.txt :1\@C4\' :1\@C3\' :1\@O3\' :2\@P    \n";
  print F2W_PTRAJ "dihedral zeta    out z.txt :1\@C3\' :1\@O3\' :2\@P    :2\@O5\' \n";
  print F2W_PTRAJ "dihedral alfa    out a.txt :1\@O3\' :2\@P    :2\@O5\' :2\@C5\' \n";
  print F2W_PTRAJ "dihedral beta    out b.txt :2\@P    :2\@O5\' :2\@C5\' :2\@C4\' \n";
  print F2W_PTRAJ "dihedral gamma   out g.txt :2\@O5\' :2\@C5\' :2\@C4\' :2\@C3\' \n";
  close(F2W_PTRAJ) || die "cannot closse ptraj_torsion.in: $!";
  system("cpptraj $prmtop <ptraj_torsion.in> out_torsion");
  $epsilon = `cat e.txt | grep -v \"\#\" | awk '{print \$2}'`;
  $zeta    = `cat z.txt | grep -v \"\#\" | awk '{print \$2}'`;
  $alfa    = `cat a.txt | grep -v \"\#\" | awk '{print \$2}'`;
  $beta    = `cat b.txt | grep -v \"\#\" | awk '{print \$2}'`;
  $gamma   = `cat g.txt | grep -v \"\#\" | awk '{print \$2}'`;
  chomp($epsilon);
  chomp($zeta);
  chomp($alfa);
  chomp($beta);
  chomp($gamma);
  $epsilon = sprintf("%.0f", $epsilon);
  $zeta    = sprintf("%.0f", $zeta);
  $alfa    = sprintf("%.0f", $alfa);
  $beta    = sprintf("%.0f", $beta);
  $gamma   = sprintf("%.0f", $gamma);
  if($epsilon < 0){$epsilon += 360};
  if($zeta    < 0){$zeta    += 360};
  if($alfa    < 0){$alfa    += 360};
  if($beta    < 0){$beta    += 360};
  if($gamma   < 0){$gamma   += 360};
}
