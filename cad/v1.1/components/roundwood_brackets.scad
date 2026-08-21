// ============================================================================
// HUB75 Display Case V1.1 — printed roundwood interfaces
//
// These parts are still concept geometry. They establish the intended
// structural relationships but are not yet production-ready print models.
// ============================================================================

use <_lib/geometry.scad>

module lower_rod_mount(rod_x,side="left",x_shift=0) {
    socket_height = end_zone_socket_height;
    socket_outer = vertical_socket_outer_diameter;
    socket_stop = vertical_socket_bottom_thickness;
    socket_z0 = lower_socket_z0;

    plate_height = side_end_straight_height;
    plate_z0 = display_bottom_z;
    plate_thickness = vertical_bracket_thickness;
    plate_depth = vertical_bracket_depth;

    plate_x =
        side=="left"
        ? -plate_thickness
        : case_outer_width;

    color(vertical_color)
    difference() {
        union() {
            translate([rod_x+x_shift,rod_axis_y,socket_z0])
                cylinder(h=socket_height,d=socket_outer);

            translate([
                plate_x+x_shift,
                upper_end_depth-plate_depth,
                plate_z0
            ])
                cube([
                    plate_thickness,
                    plate_depth,
                    plate_height
                ]);

            hull() {
                translate([
                    plate_x+x_shift,
                    upper_end_depth-12,
                    plate_z0+5
                ])
                    cube([
                        plate_thickness,
                        12,
                        plate_height-10
                    ]);

                translate([
                    rod_x+x_shift,
                    rod_axis_y,
                    socket_z0+3
                ])
                    cylinder(
                        h=socket_height-6,
                        d=socket_outer
                    );
            }
        }

        translate([
            rod_x+x_shift,
            rod_axis_y,
            socket_z0+socket_stop
        ])
            cylinder(
                h=socket_height-socket_stop+0.1,
                d=rod_diameter+rod_clearance
            );
    }
}

module vertical_socket_module(rod_x,side="left",x_shift=0) {
    plate_x =
        side=="left"
        ? -vertical_bracket_thickness
        : case_outer_width;

    color(vertical_color)
    difference() {
        union() {
            translate([
                rod_x+x_shift,
                rod_axis_y,
                vertical_socket_bottom_z
            ])
                cylinder(
                    h=vertical_socket_height,
                    d=vertical_socket_outer_diameter
                );

            translate([
                plate_x+x_shift,
                upper_end_depth-vertical_bracket_depth,
                vertical_bracket_z0
            ])
                cube([
                    vertical_bracket_thickness,
                    vertical_bracket_depth,
                    vertical_bracket_height
                ]);

            hull() {
                translate([
                    plate_x+x_shift,
                    upper_end_depth-12,
                    vertical_socket_bottom_z+5
                ])
                    cube([
                        vertical_bracket_thickness,
                        12,
                        vertical_socket_height-10
                    ]);

                translate([
                    rod_x+x_shift,
                    rod_axis_y,
                    vertical_socket_bottom_z+5
                ])
                    cylinder(
                        h=vertical_socket_height-10,
                        d=vertical_socket_outer_diameter
                    );
            }
        }

        translate([
            rod_x+x_shift,
            rod_axis_y,
            vertical_socket_bottom_z
                + vertical_socket_bottom_thickness
        ])
            cylinder(
                h=vertical_socket_height
                    - vertical_socket_bottom_thickness
                    + 0.1,
                d=rod_diameter+rod_clearance
            );
    }
}

module horizontal_socket_module(side="left",x_shift=0,z_shift=0) {
    socket_x0 =
        side=="left"
        ? left_horizontal_socket_x0
        : right_horizontal_socket_x0;

    plate_x0 =
        socket_x0
        + (horizontal_socket_length-horizontal_bracket_width_x)/2;

    color(horizontal_color)
    difference() {
        union() {
            translate([
                socket_x0+x_shift,
                rod_axis_y,
                horizontal_rod_axis_z+z_shift
            ])
                cyl_x(
                    horizontal_socket_length,
                    horizontal_socket_outer_diameter
                );

            translate([
                plate_x0+x_shift,
                horizontal_bracket_y0,
                horizontal_bracket_z0+z_shift
            ])
                cube([
                    horizontal_bracket_width_x,
                    horizontal_bracket_thickness,
                    horizontal_bracket_height
                ]);

            hull() {
                translate([
                    plate_x0+x_shift,
                    horizontal_bracket_y0,
                    horizontal_bracket_z0+8+z_shift
                ])
                    cube([
                        horizontal_bracket_width_x,
                        horizontal_bracket_thickness,
                        horizontal_bracket_height-16
                    ]);

                translate([
                    socket_x0+6+x_shift,
                    rod_axis_y-8,
                    horizontal_rod_axis_z-8+z_shift
                ])
                    cube([
                        horizontal_socket_length-12,
                        16,
                        16
                    ]);
            }
        }

        if(side=="left")
            translate([
                socket_x0
                    + horizontal_socket_stop_thickness
                    + x_shift,
                rod_axis_y,
                horizontal_rod_axis_z+z_shift
            ])
                cyl_x(
                    horizontal_socket_length
                        - horizontal_socket_stop_thickness
                        + 0.1,
                    rod_diameter+rod_clearance
                );
        else
            translate([
                socket_x0-0.1+x_shift,
                rod_axis_y,
                horizontal_rod_axis_z+z_shift
            ])
                cyl_x(
                    horizontal_socket_length
                        - horizontal_socket_stop_thickness
                        + 0.1,
                    rod_diameter+rod_clearance
                );
    }
}

module center_support(x,y_shift=0,z_shift=0) {
    plate_y0 =
        cross_member_front_y
        - center_support_plate_thickness
        + y_shift;

    plate_z0 =
        cross_member_top_z
        - center_support_plate_height;

    color(support_color)
    difference() {
        union() {
            translate([
                x-center_support_width/2,
                plate_y0,
                plate_z0
            ])
                cube([
                    center_support_width,
                    center_support_plate_thickness,
                    center_support_plate_height
                ]);

            translate([
                x,
                rod_axis_y,
                horizontal_rod_axis_z+z_shift
            ])
                cyl_x(
                    center_support_boss_length,
                    center_support_boss_outer,
                    true
                );

            hull() {
                translate([
                    x-center_support_width/2,
                    plate_y0,
                    plate_z0+6
                ])
                    cube([
                        center_support_width,
                        center_support_plate_thickness,
                        12
                    ]);

                translate([
                    x-center_support_width/2,
                    plate_y0,
                    cross_member_top_z-18
                ])
                    cube([
                        center_support_width,
                        center_support_plate_thickness,
                        18
                    ]);

                translate([
                    x-center_support_width/2,
                    rod_axis_y-8,
                    horizontal_rod_axis_z-8+z_shift
                ])
                    cube([
                        center_support_width,
                        16,
                        16
                    ]);
            }
        }

        translate([
            x,
            rod_axis_y,
            horizontal_rod_axis_z+z_shift
        ])
            cyl_x(
                center_support_boss_length+0.4,
                rod_diameter+rod_clearance,
                true
            );
    }
}

module center_supports(y_shift=0,z_shift=0) {
    for(x=center_support_positions)
        center_support(x,y_shift,z_shift);
}
