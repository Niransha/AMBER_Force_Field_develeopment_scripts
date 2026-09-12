grep "^ D "  pes.log  | grep -v F  | awk '{l=" &rst           iat ="; for(i=2; i<=5; i++){l=l $i","}; \
 l=l"\n                r1 = "sprintf("%.1f", $6-180)", r2 = "sprintf("%.1f", $6)", r3 = "sprintf("%.1f", $6)", r4 = "sprintf("%.1f", $6+180)",\n                rk2 =   100000.0, rk3 =   100000.0, ialtd=0,               &end"; print l}'  > RST

#sed -i -e "48r../../../../scripts3_2d/filelines" RST

