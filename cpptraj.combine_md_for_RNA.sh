#!/bin/bash

last=`ls -l ../md_*.mdcrd | awk '{split($9,a,"/"); split(a[2],b,"_"); split(b[2],c,"."); print c[1] }' | sort -nk1 | tail -1`
pdb_last_res=`cat ../resname.new.pdb | awk '{print $5}' | uniq | sort -nk1 | tail -1`


###################################
#load amber 18 on atlas
###################################
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt

#trajin ../md_\$i.mdcrd 0 last 100  $skip every 100,  

cat>input_combine<<EOF
parm ../prmtop.new

for i=1;i<$(($last+1));i++
   trajin ../md_\$i.mdcrd 0 last 1000
done

autoimage
strip :Na+,Cl-,WAT
rms fit :1-$pdb_last_res
trajout combined_md.mdcrd netcdf
parmstrip :Na+,Cl-,WAT
parmwrite out strip.prmtop.new
go
EOF

cpptraj -i input_combine


