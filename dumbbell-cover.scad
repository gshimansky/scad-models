include <Round-Anything-1.0.4/polyround.scad>

curve_radius = 150;
radius = 163.0 / 2;
height = 20;
thickness = 6;
fn = 360;
borders_extra_width = 5;
borders_thickness = 3;

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

module main_ring() {
    angle = asin(height / (2 * curve_radius));
    echo(angle);
    angles = [180 - angle, 180 + angle];
    echo(angles);
    intersection() {
        rotate_extrude(angle=360, $fn=360)
            translate([curve_radius - radius, 0, 0])
                arc(curve_radius, angles, thickness, fn);
        cylinder(h=height, r=radius * 2, center=true);
    }
}

module border() {
    angle = asin(height / (2 * curve_radius + thickness));
    outer_radius = (radius + thickness) * cos(angle) * 0.9984;
    inner_radius = outer_radius - borders_extra_width - thickness;
    
    difference() {
        extrudeWithRadius(borders_thickness, borders_thickness, 0)
            circle(outer_radius, $fn=360);
        cylinder(borders_thickness+1, r=inner_radius, center=false, $fn=360);
    }
}

union() {
    main_ring();
    translate([0, 0, -(borders_thickness + height / 2)]) border();
    translate([0, 0, borders_thickness + height / 2]) mirror([0, 0, 1]) border();
}
