include <common_vars.scad>

module back_wall() {
    translate([0, -wall_thickness / 2, 0])
        cube(size = [board_size + extra_space * 2 + bolt_well_diameter_wide * 2, wall_thickness, board_size + extra_space * 2], center = true);
}

module screw_well() {
    rotate(a=[90, 0, 0]) difference() {
        cylinder($fn = 24, h = screw_depth, d = screw_wall_thickness * 2 + screw_diameter);
        cylinder($fn = 24, h = screw_depth, d = screw_diameter);
    }
}

module lens_screw_well() {
    rotate(a=[90, 0, 0])
        cylinder($fn = 24, h = screw_depth, d = screw_wall_thickness * 2 + lens_screw_head_diameter);
}

module lens_screw_hole() {
    rotate(a=[90, 0, 0]) cylinder($fn = 24, h = 100, d = lens_screw_head_diameter);
}

module tail_top() {
    difference() {
        tail();
        translate([-bolt_well_diameter_wide / 2, 0, 0]) cube(size = [tail_x_dim + bolt_well_diameter_wide, tail_y_dim, socket_height / 2 + extra_space]);
    }
}

module back_panel() {
    difference() {
        union() {
            translate([0, -screw_depth, 0]) back_wall();
            translate([0, -screw_depth - wall_thickness, board_size / 2 + extra_space]) horizontal_wall();
            // Add screw wells
            translate([screw_well_x_offset, 0, screw_well_z_offset]) screw_well();
            translate([-screw_well_x_offset, 0, screw_well_z_offset]) screw_well();
            translate([screw_well_x_offset, 0, -screw_well_z_offset]) screw_well();
            translate([-screw_well_x_offset, 0, -screw_well_z_offset]) screw_well();
            // Add lens screw wells
            translate([lens_screw_offset, 0, 0]) lens_screw_well();
            translate([-lens_screw_offset, 0, 0]) lens_screw_well();
            // Add connection bolt wells
            translate([bolt_well_x_offset, bolt_well_y_offset, bolt_well_z_offset]) bolt_well(false, bolt_well_height);
            translate([-bolt_well_x_offset, bolt_well_y_offset, bolt_well_z_offset]) bolt_well(false, bolt_well_height);
            translate([bolt_well_x_offset, bolt_well_y_offset, -bolt_well_z_offset]) bolt_well(false, bolt_well_height);
            translate([-bolt_well_x_offset, bolt_well_y_offset, -bolt_well_z_offset]) bolt_well(false, bolt_well_height);
            // Add tail
            translate([-socket_width / 2 - wall_thickness, -wire_length - wall_thickness - screw_depth, -board_size / 2 - extra_space]) tail_top();
        }
        translate([lens_screw_offset, 0, 0]) lens_screw_hole();
        translate([-lens_screw_offset, 0, 0]) lens_screw_hole();
        translate([bolt_well_x_offset, bolt_hole_y_offset, bolt_well_z_offset]) bolt_hole(false);
        translate([-bolt_well_x_offset, bolt_hole_y_offset, bolt_well_z_offset]) bolt_hole(false);
        translate([bolt_well_x_offset, bolt_hole_y_offset, -bolt_well_z_offset]) bolt_hole(false);
        translate([-bolt_well_x_offset, bolt_hole_y_offset, -bolt_well_z_offset]) bolt_hole(false);
        // Socket cutout
        translate([0, -wire_length / 2 - screw_depth, -board_size / 2 - extra_space + socket_height / 2]) socket_cutout();
    }
}

back_panel();
