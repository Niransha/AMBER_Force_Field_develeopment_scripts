#### amber command to create pdb from inpcrd #### and extract HOLD ATOMs to eq.in ####

ambpdb -aatm -p prmtop.new -c inpcrd > inpcrd.aatm.pdb

cat inpcrd.aatm.pdb | grep ATOM | grep -v WAT | grep -v Na+ | grep -v " H" | awk '{print "ATOM "$2" "$2}' > amber_hold_atoms.list

