$fn = 30;

wall_thickness = 3;
cover_edge_thickness = wall_thickness / 2;
cover_edge_height = wall_thickness / 2;
cover_screw_cutout_length = 10;
cover_screw_cutout_radius = cover_edge_height + 10;
cover_screw_cutout_degrees = 45;

usb_plug_height = 6.5;
usb_plug_width = 12.0;
usb_plug_offset = 4.2;

pins_height = 8;
pin_wire_socket_height = 12.0;
pin_wire_extra = 0.5;
pin_base_height = 2.5;
nodemcu_board_thickness = 1.8;
nodemcu_chip_height = 5;
nodemcu_width = 20.8;
nodemcu_length = 43.2;

nut_size = 6.2;
nut_height = 2.3;
screw_support_hole = 2.6;
screw_support_size_bottom = nut_size + 2;
screw_support_size_top = screw_support_hole + 1;

interboard_distance = 2;

bme_length = 13.5;
bme_width = 10.6;
bme_height = 3.4;
bme_chips_height = 0.5;
bme_outside_offset = screw_support_size_bottom;
bme_screw_hole_offset = 2.6;

wall_height = wall_thickness + nodemcu_chip_height + nodemcu_board_thickness + pin_base_height + pin_wire_socket_height + pin_wire_extra + cover_edge_height;
platform_width = wall_thickness + screw_support_size_bottom + nodemcu_width + wall_thickness;
platform_depth = wall_thickness + screw_support_size_bottom + nodemcu_length + interboard_distance + bme_length - bme_outside_offset + wall_thickness;

module nut_trap (w = nut_size, h = nut_height) {
    cylinder(r = w / 2 / cos(180 / 6) + 0.05, h = h, center = false, $fn = 6);
}    

module wedge_180(h, r, d)
{
	rotate(d) difference()
	{
		rotate(180-d) difference()
		{
			cylinder(h = h, r = r);
			translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
		}
		translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
	}
}

module wedge(h, r, d)
{
	if(d <= 180)
		wedge_180(h, r, d);
	else
		rotate(d) difference()
		{
			cylinder(h = h, r = r);
			translate([0, 0, -1]) wedge_180(h+2, r+1, 360-d);
		}
}

// Height is from inner platform base
module screw_support (h = wall_height) {
    translate([0, 0, wall_thickness]) {
        cylinder(d1 = screw_support_size_bottom, d2 = screw_support_size_top, h = h, center = false);
    }
}

module screw_hole (h = wall_height) {
    translate([0, 0, -0.1]) {
        cylinder(d = screw_support_hole, h = h + 0.2, center = false);
        nut_trap();
    }
}

module nodemcu_supports() {
    screw_support(h = nodemcu_chip_height);
    translate([nodemcu_width, 0, 0]) screw_support(h = nodemcu_chip_height);
    translate([0, nodemcu_length, 0]) screw_support(h = nodemcu_chip_height);
    translate([nodemcu_width, nodemcu_length, 0]) screw_support(h = nodemcu_chip_height);
}

module nodemcu_holes() {
    screw_hole(h = nodemcu_chip_height + wall_thickness);
    translate([nodemcu_width, 0, 0]) screw_hole(h = nodemcu_chip_height + wall_thickness);
    translate([0, nodemcu_length, 0]) screw_hole(h = nodemcu_chip_height + wall_thickness);
    translate([nodemcu_width, nodemcu_length, 0]) screw_hole(h = nodemcu_chip_height + wall_thickness);
}

module case_frame() {
    union() {
        // Main platform
        cube(size = [platform_width, platform_depth, wall_thickness], center = false);
        // Front wall
        translate([0, 0, 0]) cube(size = [platform_width, wall_thickness, wall_height], center = false);
        // Back wall
        translate([0, platform_depth - wall_thickness, 0]) cube(size = [platform_width, wall_thickness, wall_height], center = false);
        // Left wall
        translate([0, 0, 0]) cube(size = [wall_thickness, platform_depth, wall_height], center = false);
        // Right wall
        translate([platform_width - wall_thickness, 0, 0]) cube(size = [wall_thickness, platform_depth, wall_height], center = false);
    }
}

module case() {
    union() {
        case_frame();
        translate([screw_support_size_bottom / 2 + wall_thickness, screw_support_size_bottom / 2 + wall_thickness, 0]) nodemcu_supports();
        // Platform for BME chip outside of main case
        translate([platform_width / 2 - bme_width / 2 - (screw_support_size_bottom / 2 - bme_screw_hole_offset), platform_depth - 0.1, 0]) cube(size = [bme_width + screw_support_size_bottom / 2 - bme_screw_hole_offset, bme_outside_offset + 0.1, wall_thickness]);
        translate([platform_width / 2 - bme_width / 2 + screw_support_size_bottom / 2, platform_depth + bme_outside_offset - screw_support_size_bottom / 2, 0]) screw_support(h = nodemcu_chip_height);
    }
}

module case_cover() {
    difference() {
        union() {
            translate([cover_edge_thickness, cover_edge_thickness, 0]) cube(size = [platform_width - cover_edge_thickness * 2, platform_depth - cover_edge_thickness * 2,cover_edge_height + 0.1], center = false);
            translate([0, 0, cover_edge_thickness]) cube(size = [platform_width, platform_depth, wall_thickness]);
        }
        translate([platform_width - cover_edge_thickness, (platform_depth - 2 * cover_screw_cutout_length) / 3 + cover_screw_cutout_length, cover_edge_thickness - 0.1]) rotate(a = [90, 0, 0]) {
            wedge(cover_screw_cutout_length, cover_screw_cutout_radius + 0.1, cover_screw_cutout_degrees);
        }
        translate([platform_width - cover_edge_thickness, (platform_depth - 2 * cover_screw_cutout_length) / 3 * 2 + cover_screw_cutout_length * 2, cover_edge_thickness - 0.1]) rotate(a = [90, 0, 0]) {
            wedge(cover_screw_cutout_length, cover_screw_cutout_radius + 0.1, cover_screw_cutout_degrees);
        }
        translate([cover_edge_thickness, (platform_depth - 2 * cover_screw_cutout_length) / 3, cover_edge_thickness - 0.1]) rotate(a = [270, 180, 0]) {
            wedge(cover_screw_cutout_length, cover_screw_cutout_radius + 0.1, cover_screw_cutout_degrees);
        }
        translate([cover_edge_thickness, (platform_depth - 2 * cover_screw_cutout_length) / 3 * 2 + cover_screw_cutout_length, cover_edge_thickness - 0.1]) rotate(a = [270, 180, 0]) {
            wedge(cover_screw_cutout_length, cover_screw_cutout_radius + 0.1, cover_screw_cutout_degrees);
        }
    }
}

/*
difference() {
    case();
    // Holes for NodeMCU
    translate([screw_support_size_bottom / 2 + wall_thickness, screw_support_size_bottom / 2 + wall_thickness, 0]) nodemcu_holes();
    translate([platform_width / 2 - bme_width / 2 + screw_support_size_bottom / 2, platform_depth + bme_outside_offset - screw_support_size_bottom / 2, 0]) screw_hole();
    // Remove cover from top
    translate([0, 0, wall_height - cover_edge_height]) case_cover();
    // Hole for USB socket
    translate([platform_width / 2 - usb_plug_width / 2, -0.1, wall_thickness + nodemcu_chip_height - usb_plug_offset]) cube(size = [usb_plug_width, wall_thickness + 0.2, usb_plug_height]);
    // Hole for BME chip
    translate([platform_width / 2 - bme_width / 2, platform_depth - wall_thickness - 0.1, wall_thickness + nodemcu_chip_height - bme_chips_height]) cube(size = [bme_width, wall_thickness + 0.2, bme_height]);
}
*/
case_cover();
