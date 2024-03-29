include <common-definitions.scad>

module main_ring() {
    union() {
        translate([0, 0, front_ring_thickness])
            ring(side_wall_height, lens_outside_diameter + side_wall_thickness * 2, lens_outside_diameter);
        cover_ring();
    }
}

main_ring();
