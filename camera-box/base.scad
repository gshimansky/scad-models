include <common_vars.scad>

module t_nut_spike() {
    cube(size = [t_nut_cap_thicklness, t_nut_spike_width, t_nut_spike_length]);
}

module t_nut() {
    cylinder($fn = 24, d = t_nut_well_diameter, h = t_nut_height);
    cylinder($fn = 24, d = t_nut_cap_diameter, h = t_nut_cap_thicklness);
    translate([0, t_nut_cap_diameter / 2 - t_nut_spike_width, 0]) t_nut_spike();
    rotate(a = [0, 0, 90]) translate([0, t_nut_cap_diameter / 2 - t_nut_spike_width, 0]) t_nut_spike();
    rotate(a = [0, 0, 180]) translate([0, t_nut_cap_diameter / 2 - t_nut_spike_width, 0]) t_nut_spike();
    rotate(a = [0, 0, 270]) translate([0, t_nut_cap_diameter / 2 - t_nut_spike_width, 0]) t_nut_spike();
}

hinge_block(hinge_length);
difference() {
    translate([-hinge_length / 2, -stand_length, 0]) cube(size = [hinge_length * 2,     stand_length, t_nut_height]);
    translate([hinge_length / 2, -stand_length + t_nut_cap_diameter / 2 + wall_thickness, 0]) t_nut();
}
