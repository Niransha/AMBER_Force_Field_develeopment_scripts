#!/bin/bash


file1=`ls -l md_*.rst | sort | tail -1 | awk '{print $9}'`

source /opt/ohpc/pub/apps/rnachem/amber18/modules2load.txt
source /opt/ohpc/pub/apps/rnachem/amber18/amber.sh

ambpdb -aatm -p prmtop.new -c $file1 > last.$file1.pdb
