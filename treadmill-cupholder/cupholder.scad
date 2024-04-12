include <Round-Anything-1.0.4/polyround.scad>

bottle_diameter = 80.0;
bottle_height = 100.0;
wall_thickness = 10.0;

holder_curve_radius = 3.0;
inside_curve_radius = 10.0;
handle_inside_curve_radius = 20.0;
curve_divisions = 30;

handle_width = 57.0;
handle_height = bottle_height;
handle_offset = bottle_height / 4;
handle_depth = bottle_diameter + wall_thickness * 2 - handle_inside_curve_radius * 2 - holder_curve_radius * 2;

module main_cube() {
    side_width = bottle_diameter + wall_thickness * 2;
    cube_side_points = [
        [0, 0, holder_curve_radius],
        [side_width, 0, holder_curve_radius],
        [side_width, side_width, holder_curve_radius],
        [0, side_width, holder_curve_radius]
     ];
     polyRoundExtrude(cube_side_points, bottle_height + wall_thickness, holder_curve_radius, holder_curve_radius, curve_divisions);
}
 
module inside_cube_hole() {
    cube_side_points = [
        [0, 0, inside_curve_radius],
        [bottle_diameter, 0, inside_curve_radius],
        [bottle_diameter, bottle_diameter, inside_curve_radius],
        [0, bottle_diameter, inside_curve_radius]
     ];
     polyRoundExtrude(cube_side_points, bottle_height, -inside_curve_radius, inside_curve_radius, curve_divisions);
}

module handle_outside1() {
    cube_side_points = [
        [0, 0, holder_curve_radius],
        [handle_depth, 0, holder_curve_radius],
        [handle_depth, handle_height, holder_curve_radius],
        [0, handle_height, holder_curve_radius],
    ];
    polyRoundExtrude(cube_side_points, handle_width + wall_thickness * 2, 0, handle_inside_curve_radius, curve_divisions);
}

module handle_inside1() {
    cube_side_points = [
        [0, 0, handle_inside_curve_radius],
        [handle_width, 0, handle_inside_curve_radius],
        [handle_width, handle_height, handle_inside_curve_radius],
        [0, handle_height, handle_inside_curve_radius],
    ];
    polyRoundExtrude(cube_side_points, handle_depth, -holder_curve_radius, -holder_curve_radius, curve_divisions);
}

module handle1() {
    difference() {
        handle_outside1();
        translate([0, -wall_thickness * 2, handle_width + wall_thickness * 2]) rotate([0, 90, 0]) handle_inside1();
    }
}

module handle2() {
    cube_side_points = [
        [0, 0, holder_curve_radius],
        [handle_depth, 0, holder_curve_radius],
        [handle_depth, wall_thickness * 2, holder_curve_radius],
        [0, wall_thickness * 2, holder_curve_radius],
    ];
    polyRoundExtrude(cube_side_points, handle_inside_curve_radius, -handle_inside_curve_radius, 0, curve_divisions);
}

module handle() {
    union() {
        intersection() {
            handle1();
            translate([-handle_inside_curve_radius, 0, 0])
                cube([handle_depth + handle_inside_curve_radius * 2, handle_height + handle_inside_curve_radius, handle_width + wall_thickness * 2 - handle_inside_curve_radius]);
        }
        translate([0, handle_height - wall_thickness * 2, handle_width + wall_thickness * 2 - handle_inside_curve_radius]) handle2();
    }
}

module holder_main_cube() {
    difference() {
        main_cube();
        translate([wall_thickness, wall_thickness, wall_thickness]) inside_cube_hole();
    }
}

module holder() {
    union() {
        holder_main_cube();
        translate([handle_inside_curve_radius + holder_curve_radius, handle_width + wall_thickness * 2 + bottle_diameter + wall_thickness * 2, -handle_offset]) rotate([90, 0, 0]) handle();
    }
}
holder();