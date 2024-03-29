lens_outside_diameter = 62.7;
lens_wall_thickness = 5.0;
ring_outside_width = 10;
holes_count = 3;
holes_diameter = 2;

side_wall_height = 15;
side_wall_thickness = 1.2;
front_ring_thickness = 1.2;

$fn = 360;

module hole() {
    cylinder(h=front_ring_thickness, d=holes_diameter);
}

module holes() {
    for (i=[0 : (holes_count - 1)]) {
        rotate([0, 0, (360 / holes_count) * i])
            translate([lens_outside_diameter / 2 + side_wall_thickness + ring_outside_width / 2 - holes_diameter / 2, 0, 0])
                hole();
    }
};

module ring(height, outside_diameter, inside_diameter) {
    difference () {
        cylinder(h=height, d=outside_diameter); 
        cylinder(h=height, d=inside_diameter);
    }
};

module cover_ring() {
    ring_front_outside_diameter = lens_outside_diameter + (side_wall_thickness + ring_outside_width) * 2;
    ring_front_inside_diameter = lens_outside_diameter - lens_wall_thickness * 2;
    difference() {
        ring(front_ring_thickness, ring_front_outside_diameter, ring_front_inside_diameter);
        holes();
    }
}
