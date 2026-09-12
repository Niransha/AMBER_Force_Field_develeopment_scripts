set sel [atomselect top all]
set nm [$sel num]

for {set i 0} {$i < $nm} {incr i} {
	label add Atoms 0/$i
}

#color Display Background white
