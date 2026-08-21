// ============================================================================
// HUB75 Display Case V1.1 — project configuration
//
// Slim upper display-case concept with external Ø22 mm roundwood carry frame.
// ============================================================================

/* [Geometry quality] */
curve_segments = 96;
$fn = curve_segments;

/* [Plywood] */
plywood_thickness = 18;
inner_width = 846;
case_outer_width = inner_width + 2*plywood_thickness;

lower_depth = 110;
upper_depth = 60;

lower_bottom_thickness = 18;
lower_internal_height = 70;
lower_top_thickness = 18;
lower_total_height =
    lower_bottom_thickness +
    lower_internal_height +
    lower_top_thickness;

display_height = 365;
display_bottom_z = lower_total_height;
display_top_z = display_bottom_z + display_height;

side_transition_radius = 20;
upper_end_depth = upper_depth + side_transition_radius;
side_end_straight_height = 30;

end_zone_socket_margin = 5;
end_zone_socket_height = 20;

/* [Top panel] */
top_thickness = 18;
top_side_overhang = 13;
top_z0 = display_top_z - top_thickness;

top_center_depth = upper_depth;
top_end_depth = upper_end_depth;
top_end_straight_width = side_end_straight_height;
top_transition_radius = side_transition_radius;

top_outer_width = case_outer_width + 2*top_side_overhang;
upper_side_wall_height = display_height - top_thickness;

/* [Upper cross member] */
cross_member_thickness = 18;
cross_member_height = 72;
cross_member_top_gap = 0;
cross_member_rear_y = upper_depth;
cross_member_front_y = cross_member_rear_y - cross_member_thickness;
cross_member_top_z = top_z0 - cross_member_top_gap;
cross_member_bottom_z = cross_member_top_z - cross_member_height;

/* [Roundwood] */
rod_diameter = 22;
rod_radius = rod_diameter/2;
rod_clearance = 0.5;

rod_outside_projection = 13;
rod_axis_y = lower_depth - rod_radius;

left_vertical_rod_x = rod_radius - rod_outside_projection;
right_vertical_rod_x =
    case_outer_width - rod_radius + rod_outside_projection;

/* [Vertical rod connection zones] */
lower_connection_zone_z0 = display_bottom_z;
lower_socket_z0 =
    lower_connection_zone_z0 + end_zone_socket_margin;
lower_socket_z1 = lower_socket_z0 + end_zone_socket_height;

upper_connection_zone_z1 = top_z0;
upper_socket_z1 =
    upper_connection_zone_z1 - end_zone_socket_margin;
upper_socket_z0 = upper_socket_z1 - end_zone_socket_height;

vertical_rod_bottom_z = lower_socket_z0;
vertical_rod_top_z = upper_socket_z1;
vertical_rod_working_length =
    vertical_rod_top_z - vertical_rod_bottom_z;

/* [Vertical socket modules] */
vertical_socket_outer_diameter = 34;
vertical_socket_height = end_zone_socket_height;
vertical_socket_bottom_thickness = 5;

vertical_socket_bottom_z = upper_socket_z0;

vertical_bracket_thickness = 7;
vertical_bracket_depth = 36;
vertical_bracket_height = side_end_straight_height;
vertical_bracket_z0 = top_z0 - side_end_straight_height;

/* [Horizontal top rod] */
horizontal_rod_axis_z = display_top_z - rod_radius;

horizontal_socket_outer_diameter = 34;
horizontal_socket_outer_radius =
    horizontal_socket_outer_diameter/2;
horizontal_socket_length = 32;
horizontal_socket_stop_thickness = 5;

left_vertical_socket_right_x =
    left_vertical_rod_x + vertical_socket_outer_diameter/2;
right_vertical_socket_left_x =
    right_vertical_rod_x - vertical_socket_outer_diameter/2;

horizontal_module_gap_x = 7;

left_horizontal_socket_x0 =
    left_vertical_socket_right_x + horizontal_module_gap_x;
left_horizontal_socket_x1 =
    left_horizontal_socket_x0 + horizontal_socket_length;

right_horizontal_socket_x1 =
    right_vertical_socket_left_x - horizontal_module_gap_x;
right_horizontal_socket_x0 =
    right_horizontal_socket_x1 - horizontal_socket_length;

left_horizontal_rod_end_x =
    left_horizontal_socket_x0 + horizontal_socket_stop_thickness;
right_horizontal_rod_end_x =
    right_horizontal_socket_x1 - horizontal_socket_stop_thickness;

horizontal_rod_length =
    right_horizontal_rod_end_x - left_horizontal_rod_end_x;

/* [Horizontal bracket modules] */
horizontal_bracket_thickness = 7;
horizontal_bracket_width_x = 30;
horizontal_bracket_height = 42;
horizontal_bracket_y0 = cross_member_rear_y;
horizontal_bracket_z0 =
    cross_member_top_z - horizontal_bracket_height;

/* [Center supports] */
center_support_positions = [
    case_outer_width * 0.35,
    case_outer_width * 0.65
];

center_support_width = 22;
center_support_plate_thickness = 8;
center_support_plate_height = 46;
center_support_boss_outer = 34;
center_support_boss_length = 28;

/* [Appearance] */
wood_color = [0.74,0.58,0.39,1];
wood_secondary_color = [0.62,0.46,0.30,1];
rod_color = [0.72,0.52,0.30,1];
vertical_color = [0.15,0.68,0.25,1];
horizontal_color = [0.10,0.58,0.21,1];
support_color = [0.12,0.62,0.22,1];
display_color = [0.025,0.025,0.025,1];

/* [Checks] */
assert(
    end_zone_socket_margin*2 + end_zone_socket_height
        == side_end_straight_height,
    "Socket + margins must fit the 30 mm straight end zone."
);

assert(
    left_horizontal_socket_x0 > left_vertical_socket_right_x,
    "Left horizontal socket intersects vertical socket."
);

assert(
    right_horizontal_socket_x1 < right_vertical_socket_left_x,
    "Right horizontal socket intersects vertical socket."
);
