include <common_vars.scad>

hinge_block(hinge_length);
translate([-hinge_length / 2, -stand_length, 0]) cube(size = [hinge_length * 2, stand_length, hinge_diameter]);
translate([0, -stand_length, 0]) rotate(a = [0, 0, 180]) hinge_block(hinge_length / 2);
translate([hinge_length * 3 / 2, -stand_length, 0]) rotate(a = [0, 0, 180]) hinge_block(hinge_length / 2);
