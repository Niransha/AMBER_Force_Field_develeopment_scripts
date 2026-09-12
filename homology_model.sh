#!/bin/bash
###########################################################################################
#
# March 31, 2021 - Written by IY (FAU)
#
# This is the initial script to homology model the dimer models for the development of dimeric RNA force field.
#
###########################################################################################
#
# The lines below is specific for this case. A generic version needs to be created.
#
cat alfa_0_gamma_60.pdb | grep HETATM > tmp1

cat model.pdb | grep ATOM > tmp2

paste tmp1 tmp2 | awk '{printf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $12,$13,$14,$15,$16,$6,$7,$8)}' > model.opt.pdb

rm tmp1 tmp2
###########################################################################################
#
# Create initial homology model of the system from model.opt.pdb file.
#
cat model.opt.pdb | \
awk -v prime="'" '{ \
  s++; \
  if (s==1){ \
    hresname[1]="RA5"; \
    hresname[2]="BB3"; \
  }; \
  resname[$5]=$4; \
  aname=$3; \
  if(resname[$5] != hresname[$5]){ \
    if((aname ~ prime) || (aname == "N1") || (aname == "C6") || (aname ~ /T/)){ \
      newresname=hresname[$5]; \
      newaname=$3; \
      if(aname == "N1"){ \
        newaname="N9"; \
      } else if(aname == "C6"){ \
        newaname ="C8"; \
      }; \
      printf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $1,$2,newaname,newresname,$5,$6,$7,$8); \
    } else { \
      next; \
    } \
  } else { \
    print $0; \
  }; \
}' > tmp.pdb
###########################################################################################
#
# Create the xleap input file, and let Leap include the missing atoms.
#
cat << EOF > xleap.tmp.in 
source oldff/leaprc.rna.ff99
addAtomTypes {
  { "DH"  "H" "sp3" }
  { "C1"  "C" "sp2" }
  { "C2"  "C" "sp2" }
  { "C3"  "C" "sp2" }
  { "C4"  "C" "sp2" }
  { "C5"  "C" "sp2" }
  { "C6"  "C" "sp2" }
  { "CI"  "C" "sp3" }
  { "OZ"  "O" "sp3" }
}
loadoff         /home/nkumarachchi2019/dimeric_force_field/lib_bb5_bb3/bb3.off
loadoff         /home/nkumarachchi2019/dimeric_force_field/lib_bb5_bb3/bb5.off
model = loadpdb tmp.pdb
savepdb model RA5_BB3.init.model.pdb
quit
EOF
#
# Run the leap with the input created above.
#
tleap -f xleap.tmp.in > /dev/null
###########################################################################################
#
# Remove the temp files
#
rm -f tmp.pdb xleap.tmp.in leap.out
###########################################################################################
