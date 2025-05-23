include <Round-Anything-1.0.4/polyround.scad>

curve_divisions = 10;

niche_width = 77;
niche_height = 26.5;
niche_depth = 50;
wedge_narrow_end = 1.0;
wedge_wide_end = 0;
wedge_curve_radius = 3;

proclip_width = 50.0;
proclip_height = 41.5;
proclip_hole_distance_from_top = 5.5;
proclip_hole_distance_from_side = 5.5;
proclip_depth = 5.5;
proclip_hole_diameter = 1.5;
proclip_curve_radius = 5.5;

tilt_up_angle = 0;
tilt_left_angle = 0;
offset_right = 0;
offset_forward = -proclip_depth;
offset_up = 0;

module wedge () {
    wedge_points = [
        [0, 0, wedge_curve_radius],
        [niche_width + wedge_wide_end * 2, 0, wedge_curve_radius],
        [niche_width + wedge_wide_end - wedge_narrow_end, niche_depth, wedge_curve_radius],
        [wedge_wide_end + wedge_narrow_end, niche_depth, wedge_curve_radius]
    ];
    polyRoundExtrude(wedge_points, niche_height, wedge_curve_radius, wedge_curve_radius, curve_divisions);
}

module magsafe_mount() {
    proclip_points = [
        [0, 0, proclip_curve_radius],
        [proclip_width, 0, proclip_curve_radius],
        [proclip_width, proclip_height, proclip_curve_radius],
        [0, proclip_height, proclip_curve_radius]
    ];
    translate([-proclip_width / 2, 0, -proclip_height / 2])
        rotate([90, 0, 0])
            difference() {
                polyRoundExtrude(proclip_points, proclip_depth, 0, 1, curve_divisions);
                translate([proclip_hole_distance_from_side, proclip_hole_distance_from_top, 0])
                    cylinder(h=proclip_depth, d=proclip_hole_diameter, center=false, $fn=curve_divisions);
                translate([proclip_width - proclip_hole_distance_from_side, proclip_hole_distance_from_top, 0])
                    cylinder(h=proclip_depth, d=proclip_hole_diameter, center=false, $fn=curve_divisions);
                translate([proclip_width - proclip_hole_distance_from_side, proclip_height - proclip_hole_distance_from_top, 0])
                    cylinder(h=proclip_depth, d=proclip_hole_diameter, center=false, $fn=curve_divisions);
                translate([proclip_hole_distance_from_side, proclip_height - proclip_hole_distance_from_top, 0])
                    cylinder(h=proclip_depth, d=proclip_hole_diameter, center=false, $fn=curve_divisions);
            }
}

module connection() {
    hull() {
        intersection() {
            wedge();
            cube([niche_width + wedge_wide_end * 2, wedge_curve_radius, niche_height]);
        }
        rotate([-tilt_up_angle, 0, -tilt_left_angle])
            translate([niche_width / 2 + wedge_wide_end + offset_right, -offset_forward, niche_height / 2 + offset_up])
                intersection() {
                    magsafe_mount();
                    translate([-proclip_width / 2, -1, -proclip_height / 2])
                        cube([proclip_width, 1, proclip_height]);
                }
    }
}

union() {
    wedge();
    rotate([-tilt_up_angle, 0, -tilt_left_angle])
        translate([niche_width / 2 + wedge_wide_end + offset_right, -offset_forward, niche_height / 2 + offset_up])
            magsafe_mount();
//    connection();
}
