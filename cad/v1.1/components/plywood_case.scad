// ============================================================================
// HUB75 Display Case V1.1 — plywood case components
// ============================================================================

module lower_side_wall(side="left") {
    x0 = side=="left" ? 0 : case_outer_width-plywood_thickness;

    color(wood_color)
        translate([x0,0,lower_bottom_thickness])
            cube([
                plywood_thickness,
                lower_depth,
                lower_internal_height+lower_top_thickness
            ]);
}

module lower_storage() {
    color(wood_color) {
        cube([
            case_outer_width,
            lower_depth,
            lower_bottom_thickness
        ]);

        translate([
            plywood_thickness,
            0,
            lower_total_height-lower_top_thickness
        ])
            cube([
                case_outer_width-2*plywood_thickness,
                lower_depth,
                lower_top_thickness
            ]);
    }

    lower_side_wall("left");
    lower_side_wall("right");
}

module upper_side_profile_2d() {
    lower_radius_center_z =
        side_end_straight_height + side_transition_radius;

    upper_radius_center_z =
        upper_side_wall_height
        - side_end_straight_height
        - side_transition_radius;

    difference() {
        union() {
            square([upper_depth,upper_side_wall_height]);

            square([
                upper_end_depth,
                side_end_straight_height+side_transition_radius
            ]);

            translate([
                0,
                upper_side_wall_height
                - side_end_straight_height
                - side_transition_radius
            ])
                square([
                    upper_end_depth,
                    side_end_straight_height+side_transition_radius
                ]);
        }

        translate([upper_end_depth,lower_radius_center_z])
            circle(r=side_transition_radius);

        translate([upper_end_depth,upper_radius_center_z])
            circle(r=side_transition_radius);
    }
}

module upper_side_wall(x0) {
    color(wood_color)
        translate([x0,0,display_bottom_z])
            rotate([90,0,90])
                linear_extrude(height=plywood_thickness)
                    upper_side_profile_2d();
}

module top_panel_profile_2d() {
    panel_x0 = -top_side_overhang;
    panel_x1 = case_outer_width + top_side_overhang;

    left_straight_end =
        panel_x0 + top_end_straight_width;

    right_straight_start =
        panel_x1 - top_end_straight_width;

    left_arc_center_x =
        left_straight_end + top_transition_radius;
    right_arc_center_x =
        right_straight_start - top_transition_radius;

    arc_steps = 16;

    left_arc = [
        for(i=[0:arc_steps])
            let(a = 180 + 90*i/arc_steps)
                [
                    left_arc_center_x
                        + top_transition_radius*cos(a),
                    top_end_depth
                        + top_transition_radius*sin(a)
                ]
    ];

    right_arc = [
        for(i=[0:arc_steps])
            let(a = 270 + 90*i/arc_steps)
                [
                    right_arc_center_x
                        + top_transition_radius*cos(a),
                    top_end_depth
                        + top_transition_radius*sin(a)
                ]
    ];

    polygon(points=concat(
        [
            [panel_x0,0],
            [panel_x1,0],
            [panel_x1,top_end_depth],
            [right_straight_start,top_end_depth]
        ],
        [for(i=[arc_steps:-1:0]) right_arc[i]],
        [[left_straight_end+top_transition_radius,top_center_depth]],
        [for(i=[arc_steps:-1:0]) left_arc[i]],
        [[panel_x0,top_end_depth]]
    ));
}

module removable_top(z_shift=0) {
    color(wood_color)
        translate([0,0,top_z0+z_shift])
            linear_extrude(height=top_thickness)
                top_panel_profile_2d();
}

module upper_cross_member(y_shift=0) {
    color(wood_secondary_color)
        translate([
            plywood_thickness,
            cross_member_front_y+y_shift,
            cross_member_bottom_z
        ])
            cube([
                case_outer_width-2*plywood_thickness,
                cross_member_thickness,
                cross_member_height
            ]);
}

module plywood_body_without_top() {
    lower_storage();

    upper_side_wall(0);
    upper_side_wall(case_outer_width-plywood_thickness);
}
