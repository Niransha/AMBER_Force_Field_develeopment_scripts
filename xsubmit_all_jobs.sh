#!/bin/bash

#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==0) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==1) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==2) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==3) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==4) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==5) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==6) {print k ; system(k)}}'
#cat paths | awk '{split($1,a,"/") ; k="cd "a[1]"; ../extract_single_structure.sh; cd .."; s++; if(s%8==7) {print k ; system(k)}}'

dir="/home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/"

#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==0) {print k ; system(k)}}' > error.1 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==1) {print k ; system(k)}}' > error.2 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==2) {print k ; system(k)}}' > error.3 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==3) {print k ; system(k)}}' > error.4 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==4) {print k ; system(k)}}' > error.5 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==5) {print k ; system(k)}}' > error.6 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==6) {print k ; system(k)}}' > error.7 2>&1 &
#cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; perl /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/create_init_md.pl; cd .."; s++; if(s%8==7) {print k ; system(k)}}' > error.8 2>&1 &

cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a1 ; cd .."; s++; if(s%8==0) {print k ; system(k)}}' > error.1 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a2 ; cd .."; s++; if(s%8==1) {print k ; system(k)}}' > error.2 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a3 ; cd .."; s++; if(s%8==2) {print k ; system(k)}}' > error.3 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a4 ; cd .."; s++; if(s%8==3) {print k ; system(k)}}' > error.4 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a5 ; cd .."; s++; if(s%8==4) {print k ; system(k)}}' > error.5 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a6 ; cd .."; s++; if(s%8==5) {print k ; system(k)}}' > error.6 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a7 ; cd .."; s++; if(s%8==6) {print k ; system(k)}}' > error.7 2>&1 &
cat $dir/paths | awk '{split($1,a,"/") ; k="cd "a[1]"; bash /home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/scripts2/echo_test  > a8 ; cd .."; s++; if(s%8==7) {print k ; system(k)}}' > error.8 2>&1 &