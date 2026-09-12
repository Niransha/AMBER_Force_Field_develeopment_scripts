#!/bin/bash
cat RST  | grep -e "#" -e " iat " | \
awk '{ \
  if(/^#/){ \
    gsub(/\)/,""); \
    gsub(/\(/,""); \
    gsub(/\-/," "); \
    l1=""; \
    f=0; \
    for(i=1; i<=NF-1; i++){ \
      if($i ~ /\:/){ \
        f=1; \
        continue \
      }; \
      if(f==1){ \
        l1=l1 $i" " \
      } \
    }; \
    gsub(/ $/,"",l) \
  } else { \
    gsub(/,$/,"",$4); \
    size=split($4,a,","); \
    l2 = ""; \
    for(i=1; i<=size; i++){ \
      var = sprintf("ATOM%7d ",a[i]); \
      k="cat sample.pdb | grep \"^"var"\""; \
      l="";
      k | getline l; \
      close(k); \
      for(j=1; j<=10; j++){ \
        gsub(/  /," ", l); \
      }; \
      split(l,b," "); \
      l2 = l2 b[5]" "b[4]" "b[3]" "; \
    }; \
    gsub(/ $/,"",l2); \
    print l1 " | " l2  ; \
        
    {if ($l1 == $l2) print "SAME" ; \
    else print "DIFFERENT"} 
 
    
      
    
  } \
}'


