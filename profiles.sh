#!/bin/bash
#qm profile
# run inside rotation_gamma / epsi / beta folder


# $rr is from folder_go_in_ script, -> BB5_RX3 or RX5_BB3

####################### 2D QM-profile #########################
#2D # not doing anything with REF

#2d get qm data # not doing anything with ref here
grep EUMP2 epsi_gamma_all_in_one/e_*.g_*/pes.*.log | awk -v env_var="$rr" '{gsub(/D/,"E"); split($1,a,"/"); split(a[2],b,"."); \
split(b[1],c,"_"); split(b[2],d,"_");  printf("%3d %3d %22.10f\n",  c[2], d[2], 627.509474*$NF)}' \
| awk '{if($1 >=360){$1-=360}; if($2 >=360){$2-=360}; print $1"\t"$2"\t"$3}' \
| awk '{ref1=-1246067.7438705449; print $1"\t"$2"\t"$NF}' \
| sort -nk1,1 -nk2,2 > E_QM.dat

#2d get ref zero point

min=`cat E_QM.dat | sort -nk3,3 | head -1 | awk '{print $3}'` # min value of E_QM.dat


printf "$(cat E_QM.dat | sort -nk3,3 | head -1 | awk '{print $1" " $2" " $3}') \n" > min_qm.txt 
printf "$(cat E_QM.dat | sort -nk3,3 | tail -1 | awk '{print $1" " $2" " $3}') \n" > max_qm.txt


cat E_QM.dat | awk -v ref=$min '{printf("%3d    %5d    %5.10f\n",  $1,  $2, $3-ref) }' > E_QM_ref_zero.dat


##### 1D ############
#min=`grep EUMP2 epsi_gamma_all_in_one/*/pes.*.log | awk '{gsub(/D/,"E"); split($1,a,"/"); split(a[2],b,"."); \
#split(b[1],c,"_"); split(b[2],d,"_");  printf("%3d %3d %22.10f\n",  c[2], d[2], 627.509474*$NF)}' \
#| awk '{if($1 >=360){$1-=360}; if($2 >=360){$2-=360}; print $1"\t"$2"\t"$3}' \
#| sort -nk3,3 | head -1 | awk '{print $3}'`

#grep EUMP2 epsi_gamma_all_in_one/e_*.g_*/pes.*.log | awk -v env_var="$rr" -v ref=$min '{gsub(/D/,"E"); split($1,a,"/"); split(a[2],b,"."); \
#split(b[1],c,"_"); split(b[2],d,"_");  printf("%3d %3d %22.10f\n",  c[2], d[2], 627.509474*$NF-ref)}' \
#| awk '{if($1 >=360){$1-=360}; if($2 >=360){$2-=360}; print $1"\t"$2"\t"$3}' \
#| sort -nk1,1 -nk2,2 > E_QM_ref_zero.dat

#1D
#grep EUMP2 angle_*/pes.*.log | awk '{cf=627.509; split($1,a,"/"); split(a[1],b,"_"); angle=b[2]; split($NF,a,"D"); v1=a[1]; v2=a[2]; gsub(/\+/,"",v2); energy=sprintf("%.6f", v1*10^v2*cf); print angle"\t"energy}' |  sort -nk1,1 > qm_prof_tmp4
#################

#mm-profile

######################### 2D MM-zero energy  ############################3

grep Etot epsi_gamma_all_in_one/e_*.g_*/md.out | awk -v env_var="$rr" '{split($1,a,"/"); split(a[2],b,"."); split(b[1],c,"_"); split(b[2],d,"_"); print c[2]"\t"d[2]"\t"$4}' | sort -nk1,1 -nk2,2 > E_MM_zero.dat

#2D mm-zero ref zero energy

min_mm=`cat E_MM_zero.dat | sort -nk3,3 | head -1 | awk '{print $3}'` # # min value of E_MM_zero.dat


printf "$(cat E_MM_zero.dat | sort -nk3,3 | head -1 | awk '{print $1" " $2" " $3}') \n" > min_mm.txt 
printf "$(cat E_MM_zero.dat | sort -nk3,3 | tail -1 | awk '{print $1" " $2" " $3}') \n" > max_mm.txt 


cat E_MM_zero.dat | awk -v ref2=$min_mm '{printf("%3d    %5d    %5.10f\n",  $1,  $2, $3-ref2) }' >  E_MM_zero_ref_zero.dat


###############
##min_mm=`grep Etot epsi_gamma_all_in_one/e_*.g_*/md.out | awk -v env_var="$rr" '{split($1,a,"/"); split(a[2],b,"."); split(b[1],c,"_"); split(b[2],d,"_"); print c[2]"\t"d[2]"\t"$4}' \
#| sort -nk3,3 | head -1 | awk '{print $3}'`

##grep Etot epsi_gamma_all_in_one/e_*.g_*/md.out | awk -v env_var="$rr" -v ref2=$min_mm '{split($1,a,"/"); split(a[2],b,"."); split(b[1],c,"_"); split(b[2],d,"_"); \
##printf("%3d %3d %22.10f\n",  c[2],  d[2], $NF-ref2)}' |  awk '{if($1 >=360){$1-=360}; if($2 >=360){$2-=360}; print $1"\t"$2"\t"$3}' \
##| sort -nk1,1 -nk2,2 > E_MM_zero_ref_zero.dat
###############


#################################2D QM-MM_zero ######################################
paste E_QM.dat E_MM_zero.dat | awk '{printf("%3d    %5d    %5.10f\n",  $1,  $2, $3-$6)}' > E_QM-MM_zero.dat

minz=`cat E_QM-MM_zero.dat | sort -nk3,3 | head -1 | awk '{print $3}'`

echo $minz > min_qm-mm_zero.txt

printf "$(cat E_QM-MM_zero.dat | sort -nk3,3 | head -1 | awk '{print $1" " $2" " $3}') \n" > min_qm-mm_zero.txt
printf "$(cat E_QM-MM_zero.dat | sort -nk3,3 | tail -1 | awk '{print $1" " $2" " $3}') \n" > max_qm-mm_zero.txt


cat E_QM-MM_zero.dat | awk -v ref3=$minz '{printf("%3d    %5d    %5.10f\n",  $1,  $2, $3-ref3) }' > E_QM-MM_zero_ref_zero.dat



############
#1D MM-zero
#grep Etot angle_*/md.out  | awk '{split($1,a,"/"); split(a[1],b,"_"); print b[2]"\t"$4}' | sort -nk1,1  > mm_prof_tmp3
#############
