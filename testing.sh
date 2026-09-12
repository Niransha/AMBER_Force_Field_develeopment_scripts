#!/bin/bash
cat parameters.txt  | \
awk '{ \
  pi=4*atan2(1,1); \
  for(i=1; i<=NF; i+=2){ \
    val=(i-1)/2+1; \
    V[val]=$i \
  }; \
  for(i=2; i<=NF; i+=2){ \
    val=i/2; \
    P[val]=$i; \
  } \
} END { \
  for(i=0; i<=350; i+=10){ \
    ene=0; \
    for(j=1; j<=4; j++){ \
      ene += V[j]*(1+cos((j*i - P[j])/180*pi)) \
    }; \
    print i"\t"ene \
  } \
}' | \
awk '{ \
  s++; \
  if(s==1){ \
    min=999; \
  }; \
  if($2<min){ \
    min=$2; \
  }; \
  e[i]=$2; \
  a[i]=$1; \
} END { \
  for(i=1; i<=s; i++) { \
    printf("%-3d %.6f\n", a[i], e[i]-min); \
  }; \
}'

  
