hole_width = 16.8;
hole_height = 6.1;
hole_depth = 5;
distance_from_corner = 38.5;
distance_from_top = 15.5;
height = 31;
length = 100;
thickness1 = 7;
thickness2 = 2;
full_thickness = thickness1 + thickness2;
full_height = height + thickness2;
radius = thickness1 / 2 + full_height * full_height / 8 / thickness1;
angle = asin(full_height / length);

echo("radius = ", radius);
echo("angle = ", angle);

module side(side_length, ledge) {
    difference() {
        union() {
            translate([radius - full_thickness, side_length, height / 2 - thickness2 / 2]) {
                rotate([90, 0, 0]) {
                    difference() {
                        cylinder(r = radius, h = side_length);
                        translate([thickness1 - radius, -radius, 0]) cube(size = [2 * radius, 2 * radius, side_length]);
                    }
                }
            }
            translate([-thickness2, 0, 0]) cube(size = [thickness2, side_length, height]);
            translate([-thickness2, 0, -thickness2]) cube(size = [thickness2 * 2, side_length, thickness2]);
            if (ledge) {
                translate([0, distance_from_corner, height - distance_from_top - hole_height]) cube(size = [hole_depth, hole_width, hole_height]);
            }
        }
        translate([-full_thickness, length / 2, -full_height - thickness2]) rotate([angle, 0, 0]) cube(size = [full_thickness + thickness2, length, full_height]);
    }
}


module corner() {
    intersection() {
        translate([0, -full_thickness, 0]) side(length + full_thickness, false);
        translate([-full_thickness, 0, 0]) mirror([0, 1, 0]) rotate([0, 0, 270]) side(length + full_thickness, false);
    }
}

union() {
    corner();
    side(length, true);
    mirror([0, 1, 0]) rotate([0, 0, 270]) side(length, true);
}
