include <common_vars.scad>

module lens_box() {
    cube(size = [lens_box_size, 100, lens_box_size], center = true);
}

module lens_eyelet() {
    cube(size = [box_eyelet_size, 100, box_eyelet_size], center = true);
}

module front_wall() {
    translate([0, wall_thickness / 2, 0]) cube(size = [board_size + extra_space * 2 + bolt_well_diameter_wide * 2, wall_thickness, board_size + extra_space * 2], center = true);
}

module tail_bottom() {
    difference() {
        tail();
        translate([-bolt_well_diameter_wide / 2, 0, socket_height / 2 + extra_space]) cube(size = [tail_x_dim + bolt_well_diameter_wide, tail_y_dim, socket_height / 2 + wall_thickness]);
    }
}

module front_panel() {
    difference() {
        union() {
            front_wall();
            translate([board_size / 2 + extra_space + bolt_well_diameter_wide, 0, 0] ) side_wall();
            translate([-board_size / 2 - extra_space - bolt_well_diameter_wide - wall_thickness, 0, 0] ) side_wall();
            translate([0, -wall_thickness - bolt_well_height, -board_size / 2 - extra_space - wall_thickness]) horizontal_wall();
            translate([-socket_width / 2 - wall_thickness, -wire_length - wall_thickness - bolt_well_height - wall_thickness, -board_size / 2 - extra_space - wall_thickness]) tail_bottom();
            translate([-hinge_length / 2, -bolt_well_height, -board_size / 2 - extra_space - wall_thickness]) rotate(a = [270, 0, 0]) hinge_block(hinge_length);
        }
        lens_box();
        translate([lens_box_size / 2 + box_eyelet_size / 2, 0, 0]) lens_eyelet();
        translate([-lens_box_size / 2 - box_eyelet_size / 2, 0, 0]) lens_eyelet();
        translate([bolt_well_x_offset, bolt_hole_y_offset, bolt_well_z_offset]) bolt_hole(false);
        translate([-bolt_well_x_offset, bolt_hole_y_offset, bolt_well_z_offset]) bolt_hole(false);
        translate([bolt_well_x_offset, bolt_hole_y_offset, -bolt_well_z_offset]) bolt_hole(false);
        translate([-bolt_well_x_offset, bolt_hole_y_offset, -bolt_well_z_offset]) bolt_hole(false);
        // Socket cutout
        translate([0, -tail_y_dim / 2 - bolt_well_height, socket_height / 2 + extra_space / 2 - board_size / 2 - extra_space]) socket_cutout();
        socket_cutout();
    }
}

translate([0, board_thickness + board_elements_height, 0]) front_panel();
