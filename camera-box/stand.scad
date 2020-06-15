include <common_vars.scad>

translate([-hinge_length / 2, 0, 0]) hinge_block(hinge_length / 2 - extra_space);
translate([hinge_length + extra_space, 0, 0]) hinge_block(hinge_length / 2 - extra_space);
translate([-hinge_length / 2, -stand_length, 0]) cube(size = [hinge_length * 2, stand_length, hinge_diameter]);
translate([-extra_space, -stand_length, 0]) rotate(a = [0, 0, 180]) hinge_block(hinge_length / 2 - extra_space);
translate([hinge_length * 3 / 2, -stand_length, 0]) rotate(a = [0, 0, 180]) hinge_block(hinge_length / 2 - extra_space);
