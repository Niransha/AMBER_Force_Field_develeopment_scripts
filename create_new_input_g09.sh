#!/bin/bash
#
# 1/15/2021 Written by Ilyas Yildirim (FAU)
#
# First, extract the optimized coordinates from G09 log file
#
babel -ig09 pes.log -ogau test.inp
#
# Now, create the initial files from pes.com file as well as test.inp file - which has the optimized geometries
#
cat pes.com | awk '{if(NF == 4){if(/Single/){print $0}; next}; print $0}'  > tmp.1
#
cat test.inp  | awk '{if(NF==4){print $0}}' > tmp.2
#
# Create the initial g09 input file
#
cat tmp.1 | awk '{if(! f){f=0}; if(/\-1 1/){f++; print $0; if(f==1){system("cat tmp.2")}}else{print $0}}' > init_g09.com
#
# Now, change the epsilon and zeta angles
#
sed -i 's/6 23 29 30 41.00/6 23 29 30 210.00/' init_g09.com
sed -i 's/23 29 30 33 180.00 B/23 29 30 33 290.00 B/' init_g09.com
#
# Finalize the directory
#
cp init_g09.com pes.com
rm pes.log pes.fchk.gz tmp.1 tmp.2 init_g09.com test.inp
#
