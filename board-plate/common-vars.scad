// General parameters
wall_thickness = 2.0;
extra_space = 0.5;

// Anet frame board dimensions
board_hole_x_distance = 85.2;
board_hole_z_distance = 91.0;
board_hole_diameter = 4.0;
board_hole_center_distance_from_board_edge = 3.0;
board_width = board_hole_x_distance + board_hole_diameter + board_hole_center_distance_from_board_edge * 2;

// Screw dimensions
screw_diameter = 3.0;
screw_depth = 10.0;
screw_wall_thickness = 2.4;
screw_well_base = screw_wall_thickness * 2 + screw_diameter;

// Bolt dimensions
bolt_diameter = 3.0;
bolt_hole_depth = 100.0;
bolt_hole_y_offset = -bolt_hole_depth / 2;

// Board bolt holes
board_holes = [
    [board_hole_center_distance_from_board_edge + board_hole_x_distance + bolt_diameter / 2, 0, board_hole_center_distance_from_board_edge + board_hole_z_distance + bolt_diameter / 2],
    [board_hole_center_distance_from_board_edge + bolt_diameter / 2, 0, board_hole_center_distance_from_board_edge + board_hole_z_distance + bolt_diameter / 2],
    [board_hole_center_distance_from_board_edge + bolt_diameter / 2, 0, board_hole_center_distance_from_board_edge + bolt_diameter / 2],
    [board_hole_center_distance_from_board_edge + board_hole_x_distance + bolt_diameter / 2, 0, board_hole_center_distance_from_board_edge + bolt_diameter / 2]
];
echo(board_holes = board_holes);
echo(width = board_holes[0][0] - board_holes[1][0]);
echo(height = board_holes[0][2] - board_holes[2][2]);
// BTT board holes
btt_board_height = 103.75;
btt_board_width = 70.25;
btt_board_z_offset = 10;
btt_hole1_z_from_top = 2.53;
btt_hole1_x_from_right = 2.56;
btt_hole2_z_from_top = 18.20;
btt_hole2_x_from_left = 3.02;
btt_hole3_z_from_bottom = 37.34;
btt_hole3_x_from_right = 29.41;
btt_hole4_z_from_bottom = 23.39;
btt_hole4_x_from_left = 3.22;
btt_hole5_z_from_bottom = 5.53;
btt_hole5_x_from_right = 32.05;
btt_holes = [
    [btt_board_width - btt_hole2_x_from_left, 0, btt_board_height - btt_hole2_z_from_top],
    [btt_hole1_x_from_right, 0, btt_board_height - btt_hole1_z_from_top],
    [btt_hole3_x_from_right, 0, btt_hole3_z_from_bottom],
    [btt_board_width - btt_hole4_x_from_left, 0, btt_hole4_z_from_bottom],
    [btt_hole5_x_from_right, 0, btt_hole5_z_from_bottom]
];

// Mosfet board
mosfet_hole_x_distance = 41.5;
mosfet_hole_z_distance = 51.5;
mosfet_hole_diameter = 3.0;
mosfet_hole_center_distance_from_board_edge = 2.7;
mosfet_width = mosfet_hole_x_distance + mosfet_hole_diameter + mosfet_hole_center_distance_from_board_edge * 2;
mosfet_height = mosfet_hole_z_distance + mosfet_hole_diameter + mosfet_hole_center_distance_from_board_edge * 2;
mosfet_spacer = 3.0;
mosfet_holes = [
    [mosfet_hole_center_distance_from_board_edge + mosfet_hole_x_distance + mosfet_hole_diameter / 2, 0, mosfet_hole_center_distance_from_board_edge + mosfet_hole_z_distance + mosfet_hole_diameter / 2],
    [mosfet_hole_center_distance_from_board_edge + mosfet_hole_diameter / 2, 0, mosfet_hole_center_distance_from_board_edge + mosfet_hole_z_distance + mosfet_hole_diameter / 2],
    [mosfet_hole_center_distance_from_board_edge + mosfet_hole_diameter / 2, 0, mosfet_hole_center_distance_from_board_edge + mosfet_hole_diameter / 2],
    [mosfet_hole_center_distance_from_board_edge + mosfet_hole_x_distance + mosfet_hole_diameter / 2, 0, mosfet_hole_center_distance_from_board_edge + mosfet_hole_diameter / 2]
];
echo(mosfet_holes = mosfet_holes);
echo(width = mosfet_holes[0][0] - mosfet_holes[1][0]);
echo(height = mosfet_holes[0][2] - mosfet_holes[2][2]);