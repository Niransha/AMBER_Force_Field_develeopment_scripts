#!/bin/csh  -f 
#
set sander = "$AMBERHOME/bin/pmemd.cuda"
#
/bin/rm -f eq1.in eq2.in
#
# First Equilibration
#
cat > eq1.in << EOF
First Minimize
 &cntrl
  imin=0, irest=0, ntx=1, ntb=1, 
  cut=8.0, ntr=1,    
  ntc=2, ntf=2, tempi=0.0, temp0=300.0, ntt=3,   
  gamma_ln=1.0, ig=-1, nstlim=10000, dt=0.002,   
  ntpr=1000, ntwx=1000, ntwr=1000, 
 /
Hold RNA fixed - heavy atom
1.0

END
END
EOF
#
# Second equilibration
#
cat > eq2.in << EOF
Second minimization
 &cntrl
  imin=0, irest=1, ntx=5, ntb=2, cut=8.0, ntr=1,    
  pres0=1.0, ntp=1, taup=2.0, ntc=2, ntf=2,    
  tempi=300.0, temp0=300.0, ntt=3, gamma_ln=1.0,   
  ig=-1, nstlim=1000000, dt=0.002,   
  ntpr = 1000, ntwx = 1000, ntwr = 1000,   
  pencut=-0.001, nmropt=0, 
 /
Hold RNA fixed - heavy atom
1.0

END
END
EOF
#
# Run the equilibration
#
$sander -O -i eq1.in -p prmtop.new -c min2.rst -o eq1.out -r eq1.rst -x eq1.mdcrd -ref min2.rst
#
$sander -O -i eq2.in -p prmtop.new -c eq1.rst -o eq2.out -r eq2.rst -x eq2.mdcrd -ref min2.rst
