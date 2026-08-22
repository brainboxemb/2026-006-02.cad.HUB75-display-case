// ============================================================================
// HUB75 Display Case V1.1 — roundwood carry structure
//
// Concept-level geometry for the external Ø22 mm beech carry structure.
// The printed interfaces are deliberately kept as separate socket/bracket
// modules so they can be refined independently after the overall arrangement
// has been validated.
// ============================================================================

module roundwood_cylinder_x(length,d=22) {
    rotate([0,90,0]) cylinder(h=length,d=d);
}

module roundwood_vertical_rod(x,y,z0,z1,d=22) {
    color([0.72,0.52,0.30,1])
        translate([x,y,z0]) cylinder(h=z1-z0,d=d);
}

module roundwood_horizontal_rod(x0,x1,y,z,d=22) {
    color([0.72,0.52,0.30,1])
        translate([x0,y,z]) roundwood_cylinder_x(x1-x0,d);
}

module roundwood_vertical_socket(
    rod_x,
    rod_y,
    z0,
    socket_h=20,
    rod_d=22,
    outer_d=34,
    stop=5,
    plate_x=0,
    plate_y0=0,
    plate_depth=36,
    plate_thickness=7,
    plate_height=30,
    side="left"
) {
    color([0.15,0.68,0.25,1])
    difference() {
        union() {
            translate([rod_x,rod_y,z0])
                cylinder(h=socket_h,d=outer_d);

            translate([plate_x,plate_y0,z0-(plate_height-socket_h)/2])
                cube([plate_thickness,plate_depth,plate_height]);

            hull() {
                translate([rod_x,rod_y,z0+4])
                    cylinder(h=max(1,socket_h-8),d=outer_d);

                translate([
                    plate_x,
                    plate_y0+plate_depth-12,
                    z0+4
                ])
                    cube([
                        plate_thickness,
                        12,
                        max(1,socket_h-8)
                    ]);
            }
        }

        translate([rod_x,rod_y,z0+stop])
            cylinder(h=socket_h-stop+0.2,d=rod_d+0.5);
    }
}

module roundwood_horizontal_socket(
    x0,
    rod_y,
    rod_z,
    side="left",
    length=32,
    rod_d=22,
    outer_d=34,
    stop=5,
    plate_y=0,
    plate_z0=0,
    plate_w=30,
    plate_h=42,
    plate_t=7
) {
    plate_x = x0+(length-plate_w)/2;

    color([0.10,0.58,0.21,1])
    difference() {
        union() {
            translate([x0,rod_y,rod_z])
                roundwood_cylinder_x(length,outer_d);

            translate([plate_x,plate_y,plate_z0])
                cube([plate_w,plate_t,plate_h]);

            hull() {
                translate([plate_x,plate_y,plate_z0+8])
                    cube([plate_w,plate_t,max(1,plate_h-16)]);

                translate([x0+6,rod_y-8,rod_z-8])
                    cube([max(1,length-12),16,16]);
            }
        }

        if(side=="left")
            translate([x0+stop,rod_y,rod_z])
                roundwood_cylinder_x(length-stop+0.2,rod_d+0.5);
        else
            translate([x0-0.1,rod_y,rod_z])
                roundwood_cylinder_x(length-stop+0.2,rod_d+0.5);
    }
}

module roundwood_center_support(
    x,
    rod_y,
    rod_z,
    plate_y,
    plate_z0,
    plate_h=46,
    plate_t=8,
    width=22,
    boss_d=34,
    boss_len=28,
    rod_d=22
) {
    color([0.12,0.62,0.22,1])
    difference() {
        union() {
            translate([x-width/2,plate_y,plate_z0])
                cube([width,plate_t,plate_h]);

            translate([x-boss_len/2,rod_y,rod_z])
                roundwood_cylinder_x(boss_len,boss_d);

            hull() {
                translate([x-width/2,plate_y,plate_z0+6])
                    cube([width,plate_t,12]);

                translate([x-width/2,rod_y-8,rod_z-8])
                    cube([width,16,16]);
            }
        }

        translate([x-boss_len/2-0.1,rod_y,rod_z])
            roundwood_cylinder_x(boss_len+0.2,rod_d+0.5);
    }
}

module roundwood_cross_member(
    x0,
    x1,
    rear_y,
    thickness,
    z0,
    height
) {
    color([0.62,0.46,0.30,1])
        translate([x0,rear_y-thickness,z0])
            cube([x1-x0,thickness,height]);
}

module roundwood_carry_structure(
    case_x_min,
    case_x_max,
    case_y_rear,
    upper_structure_rear_y,
    upper_z0,
    top_z0,
    top_thickness,
    plywood_thickness,
    show_rods=true,
    show_sockets=true,
    show_cross_member=true,
    show_center_supports=true,
    exploded=false
) {
    rod_d = 22;
    rod_r = rod_d/2;
    outside_projection = 13;
    rod_y = case_y_rear + 1;

    left_rod_x = case_x_min + rod_r - outside_projection;
    right_rod_x = case_x_max - rod_r + outside_projection;

    lower_socket_z = upper_z0 + 5;
    upper_socket_z = top_z0 - 25;
    vertical_rod_z0 = lower_socket_z;
    vertical_rod_z1 = upper_socket_z + 20;

    horizontal_rod_z = top_z0 + top_thickness/2;

    socket_outer_d = 34;
    socket_len = 32;
    socket_gap = 7;

    left_vertical_socket_right = left_rod_x + socket_outer_d/2;
    right_vertical_socket_left = right_rod_x - socket_outer_d/2;

    left_hsocket_x0 = left_vertical_socket_right + socket_gap;
    right_hsocket_x0 = right_vertical_socket_left - socket_gap - socket_len;

    horizontal_rod_x0 = left_hsocket_x0 + 5;
    horizontal_rod_x1 = right_hsocket_x0 + socket_len - 5;

    cross_member_h = 72;
    cross_member_t = plywood_thickness;
    cross_member_z0 = top_z0-cross_member_h;
    // Cross member follows the 60 mm central rear line of the slim upper
    // case. The roundwood itself remains farther rearward, as in the concept.
    cross_member_rear_y = upper_structure_rear_y;

    dx = exploded ? 45 : 0;
    dz = exploded ? 38 : 0;
    dy_cross = exploded ? 36 : 0;

    if(show_cross_member)
        translate([0,dy_cross,0])
            roundwood_cross_member(
                case_x_min+plywood_thickness,
                case_x_max-plywood_thickness,
                cross_member_rear_y,
                cross_member_t,
                cross_member_z0,
                cross_member_h
            );

    if(show_rods) {
        translate([-dx,0,0])
            roundwood_vertical_rod(
                left_rod_x,rod_y,vertical_rod_z0,vertical_rod_z1,rod_d
            );

        translate([dx,0,0])
            roundwood_vertical_rod(
                right_rod_x,rod_y,vertical_rod_z0,vertical_rod_z1,rod_d
            );

        translate([0,0,dz])
            roundwood_horizontal_rod(
                horizontal_rod_x0,
                horizontal_rod_x1,
                rod_y,
                horizontal_rod_z,
                rod_d
            );
    }

    if(show_sockets) {
        translate([-dx,0,0]) {
            roundwood_vertical_socket(
                left_rod_x,rod_y,lower_socket_z,
                plate_x=case_x_min-7,
                plate_y0=case_y_rear-36,
                side="left"
            );
            roundwood_vertical_socket(
                left_rod_x,rod_y,upper_socket_z,
                plate_x=case_x_min-7,
                plate_y0=case_y_rear-36,
                side="left"
            );
        }

        translate([dx,0,0]) {
            roundwood_vertical_socket(
                right_rod_x,rod_y,lower_socket_z,
                plate_x=case_x_max,
                plate_y0=case_y_rear-36,
                side="right"
            );
            roundwood_vertical_socket(
                right_rod_x,rod_y,upper_socket_z,
                plate_x=case_x_max,
                plate_y0=case_y_rear-36,
                side="right"
            );
        }

        translate([-dx,0,dz])
            roundwood_horizontal_socket(
                left_hsocket_x0,
                rod_y,
                horizontal_rod_z,
                "left",
                plate_y=cross_member_rear_y-cross_member_t,
                plate_z0=cross_member_z0+cross_member_h-42
            );

        translate([dx,0,dz])
            roundwood_horizontal_socket(
                right_hsocket_x0,
                rod_y,
                horizontal_rod_z,
                "right",
                plate_y=cross_member_rear_y-cross_member_t,
                plate_z0=cross_member_z0+cross_member_h-42
            );
    }

    if(show_center_supports)
        for(x=[
            case_x_min+(case_x_max-case_x_min)*0.35,
            case_x_min+(case_x_max-case_x_min)*0.65
        ])
            translate([0,dy_cross,dz])
                roundwood_center_support(
                    x,
                    rod_y-dy_cross,
                    horizontal_rod_z-dz,
                    cross_member_rear_y-cross_member_t,
                    cross_member_z0+cross_member_h-46
                );
}

/* [Component view] */
component_orientation = "model"; // [model,print]

// Standalone reference view with neutral dimensions. The complete mounted
// version is supplied by the display-case assembly.
if(component_orientation=="print")
    roundwood_horizontal_socket(0,0,0,"left",plate_y=-18,plate_z0=-42);
