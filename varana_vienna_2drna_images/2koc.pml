reinitialize

load 2koc-bestview.pdb, whole_str
hide everything, whole_str

create na_A, chain A
set cartoon_nucleic_acid_color, red, na_A
show cartoon, na_A

load 2koc.r3d, block

set cartoon_ladder_mode, 1
set cartoon_ladder_radius, 0.1
set cartoon_ladder_color, black

set cartoon_tube_radius, 0.16889
set cartoon_nucleic_acid_mode, 1

bg_color white
remove solvent
hide everything, hydro

util.cbaw
set sphere_quality, 4
set stick_quality, 16

set depth_cue, 0
set ray_trace_fog, 0

set ray_shadow, off
set orthoscopic, 1

set antialias, 1
set valence, 0

set ambient, 0.68
set reflect, 0
set direct, 0.6
set spec_direct, 0
set light_count, 1

