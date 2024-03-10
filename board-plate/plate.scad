include <common-vars.scad>

module line(start, end, thickness = screw_well_base) {
    hull() {
        translate(start) rotate(a=[270, 0, 0]) cylinder($fn = 24, h = wall_thickness, d = thickness);
        translate(end) rotate(a=[270, 0, 0]) cylinder($fn = 24, h = wall_thickness, d = thickness);
    }
}

module bolt_hole(vertical) {
    angle = vertical ? 0 : 270;
    translate([0, bolt_hole_y_offset, 0]) rotate(a=[angle, 0, 0]) cylinder($fn = 24, h = bolt_hole_depth, d = bolt_diameter);
}

module back_wall() {
    union() {
        for (i = [0 : len(board_holes) - 1]) 
        {
            translate(board_holes[i]) rotate(a=[270, 0, 0]) cylinder($fn = 24, h = wall_thickness, d = bolt_diameter + board_hole_center_distance_from_board_edge * 2);
        }
        line(board_holes[1], board_holes[2]);
        line(board_holes[0], board_holes[3]);
    }
}

module back_wall_holes() {
    union() {
        for (i = [0 : len(board_holes) - 1])
        {
            translate(board_holes[i]) bolt_hole();
        }
    }
}

module screw_well() {
    rotate(a=[270, 0, 0]) difference() {
        cylinder($fn = 24, h = screw_depth, d1 = screw_well_base, d2 = screw_wall_thickness * 2 + screw_diameter);
        cylinder($fn = 24, h = screw_depth, d = screw_diameter);
    }
}

module btt_board_screws() {
    union() {
        for (i = [0 : len(btt_holes) - 1]) 
        {
            translate(btt_holes[i]) screw_well();
        }
        line(btt_holes[0], btt_holes[2]);
        line(btt_holes[2], btt_holes[4]);
        line(btt_holes[2], btt_holes[3]);
    }
}

module mosfet() {
    union() {
        for (i = [0 : len(mosfet_holes) - 1]) 
        {
            translate(mosfet_holes[i]) screw_well();
            if (i > 0)
                line(mosfet_holes[i - 1], mosfet_holes[i]);
        }
        line(mosfet_holes[0], mosfet_holes[3]);
    }
}

module back_panel() {
    difference() {
        union() {
            translate([0, 0, 0]) back_wall();
            board_vector = [(board_width - btt_board_width) / 2, 0, btt_board_z_offset - screw_wall_thickness - screw_diameter / 2 - btt_hole1_z_from_top];
            translate(board_vector) btt_board_screws();
            line(btt_holes[1] + board_vector, board_holes[0]);
            line(btt_holes[1] + board_vector, board_holes[1]);
            line(btt_holes[0] + board_vector, board_holes[0]);
            line(btt_holes[2] + board_vector, board_holes[1]);
            line(btt_holes[3] + board_vector, board_holes[3]);
            line(btt_holes[2] + board_vector, board_holes[2]);
            line(btt_holes[4] + board_vector, board_holes[2]);
            line(btt_holes[4] + board_vector, board_holes[3]);

            mosfet_x_shift = screw_well_base / 2 - mosfet_hole_center_distance_from_board_edge - mosfet_hole_diameter / 2;
            mosfet_z_shift = mosfet_hole_diameter / 2 - mosfet_height;
            mosfet1_vector = [mosfet_width + mosfet_x_shift + mosfet_spacer, 0, mosfet_z_shift];
            mosfet2_vector = [mosfet_x_shift, 0, mosfet_z_shift];
            translate(mosfet1_vector) mosfet();
            translate(mosfet2_vector) mosfet();
            line(mosfet_holes[0] + mosfet1_vector, board_holes[3]);
            line(mosfet_holes[1] + mosfet2_vector, board_holes[2]);
            line(mosfet_holes[1] + mosfet1_vector, mosfet_holes[0] + mosfet2_vector);
            line(mosfet_holes[2] + mosfet1_vector, mosfet_holes[3] + mosfet2_vector);

            line(btt_holes[4] + board_vector, mosfet_holes[0] + mosfet2_vector);
        }
        back_wall_holes();
    }
}

back_panel();
