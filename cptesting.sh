file=$1

echo " output_filename?  "
read outname1 


cat $1  | \
awk '{ \
  pi=4*atan2(1,1); \
  for(i=1; i<=8; i+=2){ \
      val=(i-1)/2+1; \
    V[val]=$i \
  }; \
  for(i=2; i<=8; i+=2){ \
    val=i/2; \
    P[val]=$i; \
  } \
} END { \
  for(i=0; i<=350; i+=10){ \
    ene=0; \
    for(j=1; j<=4; j++){ \
      ene += V[j]*(1+cos((3*i - P[j])/180*pi)) \
    }; \
    print i"\t"ene \
  } \
}' > plot_data.dat


min_epsi=`cat plot_data.dat | sort -nk2,2 | head -1 |  awk '{print $2}'`

cat plot_data.dat | awk -v ref=$min_epsi '{print $1"\t"$2-ref}' > $outname1\_ref_zero_plot_data.dat

####################################################
echo  plot $outname1\_ref_zero_plot_data.dat 

xmgrace $outname1\_ref_zero_plot_data.dat &