#!/bin/bash
#
parnum=24
#
for (( i=0; i<=parnum-1; i++ ))
do
  echo $i
  cat implicit_paths  | \
  awk -v cs=$i -v parnum=$parnum '{ \
    split($1,a,"/"); \
    split(a[3],b,"_"); \
    k="cd "a[1]"/"a[2]"/"a[3]"; "; \
    if(b[1]=="old"){ \
      k=k "../../../runmin.implicit.old_prmtop > error; cd ../../.." \
    } else { \
      k=k "../../../runmin.implicit.new_prmtop > error; cd ../../.." \
    }; \
    s++; \
    if(s%parnum == cs){ \
      print k; \
#      system(k) \
    } \
  }'
  echo "==============================================================";
done
#
