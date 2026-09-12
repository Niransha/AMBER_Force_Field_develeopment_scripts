#!/bin/sh

cat pes.*.log | \
awk ' \
  BEGIN { \
    f=0; \
    xyz=""; \
    count=0; \
  }{; \
  if(/Coordinates \(Angstroms\)/){ \
    f=1; \
    xyz=""; \
    count=0;
    next; \
  }else if ((f==1) && (/\-\-/)){ \
    f++; \
    next; \
  }else if((f==2) && (/\-\-/)){ \
    f=0; \
    next; \
  }else if(f==2){ \
    count++;
    xyz = xyz sprintf("%12.7f%12.7f%12.7f", $4, $5, $6); \
    if(count % 2 == 0){ \
      xyz = xyz"\n"; \
    }; \
  }else if(/Optimization completed/){ \
    gsub(/\n$/, "", xyz);
    k="echo \"default_structure\n"sprintf("%6d", count)"\n"xyz"\" > opt.xyz"; \
    count=0; \
    xyz=""; \
    system(k); \
  }; \
}'
