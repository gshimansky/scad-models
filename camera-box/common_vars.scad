// General parameters
wall_thickness = 3.0;
extra_space = 0.5;

// Board dimensions
board_thickness = 1.3;
board_size = 37.8;
board_hole_diameter = 2.0;
board_hole_center_distance_from_board_edge = 1.8;
board_elements_height = 2.0;

// Lens dimensions
lens_box_distance_from_board_edge = 11.0;
lens_box_size = 16.6;
lens_screw_head_diameter = 4.5;
lens_screw_offset = 9.8;
box_eyelet_size = 4;
box_eyelet_thickness = 3.2;

// Screw dimensions
screw_diameter = 1.5;
screw_depth = 9.0;
screw_wall_thickness = board_hole_center_distance_from_board_edge - screw_diameter / 2;
screw_well_x_offset = board_size / 2 - board_hole_center_distance_from_board_edge;
screw_well_z_offset = board_size / 2 - board_hole_center_distance_from_board_edge;
board_extra_size = wall_thickness - screw_wall_thickness;

// Wire parameters
wire_diameter = 6.3;
wire_length = 35.0;
socket_width = 10.8;
socket_height = 10.8;

// Bolt parameters
nut_diameter = 6.4;
nut_height = 2.4;
bolt_diameter = 2.8 +  extra_space;
bolt_well_wall_thickness = 1.0;
bolt_well_diameter_wide = nut_diameter / cos(180 / 6) + bolt_well_wall_thickness * 2;
bolt_well_diameter_narrow = bolt_diameter + bolt_well_wall_thickness * 2;
bolt_well_height = screw_depth + board_thickness + board_elements_height;
bolt_well_x_offset = board_size / 2 + board_extra_size + bolt_well_diameter_wide / 2;
bolt_well_y_offset = board_thickness + board_elements_height;
bolt_well_z_offset = board_size / 2 - bolt_well_diameter_wide / 2 + board_extra_size;
bolt_hole_y_offset = -bolt_well_height;

// Tail dimension
tail_x_dim = socket_width + wall_thickness * 2;
tail_y_dim = wire_length + wall_thickness;
tail_z_dim = socket_height + wall_thickness + board_extra_size + wall_thickness;

// Hinge
hinge_length = 10.0;
hinge_diameter = bolt_diameter + 2 * wall_thickness;

// Stand
stand_length = board_size;

// T-Nut parameters
t_nut_well_diameter = 7.3;
t_nut_height = 8.8;
t_nut_cap_thicklness = 1.4;
t_nut_cap_diameter = 18.0;
t_nut_spike_length = 7.4;
t_nut_spike_width = 2.6;

module nut_trap() {
    cylinder(d = nut_diameter / cos(180 / 6) + 0.2, h = nut_height + 0.2, $fn = 6);
}

module bolt_well(vertical, height) {
    angle = vertical ? 180 : 90;
    rotate(a=[angle, 0, 0])
        cylinder($fn = 24, d1 = bolt_well_diameter_narrow, d2 = bolt_well_diameter_wide, h = height);
}

module bolt_hole(vertical) {
    angle = vertical ? 0 : 270;
    rotate(a=[angle, 0, 0]) union() {
        nut_trap();
        cylinder($fn = 24, h = 100, d = bolt_diameter);
    }
}

module tail() {
    difference() {
        union() {
            cube(size = [tail_x_dim, tail_y_dim, tail_z_dim]);
            translate([tail_x_dim, tail_y_dim / 3, tail_z_dim]) bolt_well(true, tail_z_dim);
            translate([0, tail_y_dim / 3 * 2, tail_z_dim]) bolt_well(true, tail_z_dim);
        }
        translate([tail_x_dim, tail_y_dim / 3, 0]) bolt_hole(true);
        translate([0, tail_y_dim / 3 * 2, 0]) bolt_hole(true);
        translate([socket_width / 2 + wall_thickness, 50, socket_height / 2 + board_extra_size + wall_thickness]) rotate(a=[90, 0, 0]) cylinder($fn = 24, d = wire_diameter, h = 100);
    }
}

module socket_cutout() {
    cube(size = [socket_width, tail_y_dim, socket_height + board_extra_size], center=true);
}

module horizontal_wall() {
    translate([0, bolt_well_height / 2 + wall_thickness, wall_thickness / 2]) cube(size = [board_size + board_extra_size * 2 + bolt_well_diameter_wide * 2 + wall_thickness * 2, wall_thickness + bolt_well_height + wall_thickness, wall_thickness], center=true);
}

module side_wall() {
    translate([0, -wall_thickness - bolt_well_height, -board_size / 2 - board_extra_size - wall_thickness]) cube(size = [wall_thickness, wall_thickness + bolt_well_height + wall_thickness, board_size + board_extra_size * 2 + wall_thickness * 2]);
}

module hinge_block(cylinder_length) {
    difference() {
        union() {
            cube(size = [cylinder_length, hinge_diameter, hinge_diameter]);
            translate([0, hinge_diameter, hinge_diameter / 2]) rotate(a = [0, 90, 0]) cylinder($fn = 24, d = hinge_diameter, h = cylinder_length);
        }
        translate([0, hinge_diameter, hinge_diameter / 2]) rotate(a = [0, 90, 0]) cylinder($fn = 24, d = bolt_diameter, h = cylinder_length);
    }
}
