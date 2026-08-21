// ============================================================================
// Top center handle
//
// Purchased black recessed corner handle mounted in the center of the top
// wooden panel. Geometry is defined in local component coordinates:
// - X: handle width
// - Y: depth, extending toward negative Y
// - Z: height, extending toward negative Z
// - origin: rear/top corner at the center of the handle
// ============================================================================

/* [Component view] */

component_orientation = "model"; // [model,print]
show_mounting_holes = true;

/* [Geometry quality] */

curve_segments = 48;
$fn = curve_segments;

module top_center_handle(
    total_width=150,
    flange_depth=57.2,
    material_thickness=1.5,
    opening_width=104,
    opening_depth=35,
    cup_wall=4,
    cup_back=4,
    cup_bottom=4,
    cup_depth=35,
    cup_height=35,
    grip_bar_diameter=10,
    grip_bar_inset=1.5,
    mounting_hole_diameter=5,
    mounting_hole_outer_x=66.2,
    mounting_hole_front_y=25,
    mounting_hole_rear_y=50.6,
    include_mounting_holes=true
) {
    cup_width = opening_width + 2*cup_wall;
    grip_bar_y =
        -material_thickness - grip_bar_diameter/2 + grip_bar_inset;
    grip_bar_z =
        -grip_bar_diameter/2 + grip_bar_inset;

    assert(total_width > opening_width,
        "total_width must be greater than opening_width.");
    assert(flange_depth > opening_depth,
        "flange_depth must be greater than opening_depth.");
    assert(cup_depth > cup_back + material_thickness,
        "The cup needs space behind the opening.");

    color([0.28,0.29,0.30,1])
    union() {
        difference() {
            union() {
                // Horizontal top flange.
                translate([-total_width/2,-flange_depth,0])
                    cube([total_width,flange_depth,material_thickness]);

                // Vertical rear flange.
                translate([
                    -total_width/2,
                    -material_thickness,
                    -flange_depth
                ])
                    cube([
                        total_width,
                        material_thickness,
                        flange_depth
                    ]);

                // Cup surrounding the hand opening.
                translate([-cup_width/2,-cup_depth,-cup_height])
                    cube([cup_width,cup_depth,cup_height]);
            }

            // Inner cup space; rear wall, bottom and side walls remain.
            translate([
                -opening_width/2,
                -cup_depth+cup_back,
                -cup_height+cup_bottom
            ])
                cube([
                    opening_width,
                    cup_depth-cup_back-material_thickness,
                    cup_height-cup_bottom+1
                ]);

            // Vertical hand opening.
            translate([
                -opening_width/2,
                -material_thickness-1,
                -cup_height+cup_bottom
            ])
                cube([
                    opening_width,
                    material_thickness+2,
                    opening_depth
                ]);

            // Horizontal hand opening.
            translate([
                -opening_width/2,
                -cup_depth+cup_back,
                -1
            ])
                cube([
                    opening_width,
                    opening_depth,
                    material_thickness+2
                ]);

            if(include_mounting_holes) {
                // Five holes in the horizontal flange.
                for(x=[-mounting_hole_outer_x,mounting_hole_outer_x])
                    translate([x,-mounting_hole_front_y,-1])
                        cylinder(
                            h=material_thickness+2,
                            d=mounting_hole_diameter
                        );

                for(x=[-mounting_hole_outer_x,0,mounting_hole_outer_x])
                    translate([x,-mounting_hole_rear_y,-1])
                        cylinder(
                            h=material_thickness+2,
                            d=mounting_hole_diameter
                        );

                // Five matching holes in the vertical flange.
                for(x=[-mounting_hole_outer_x,mounting_hole_outer_x])
                    translate([
                        x,
                        -material_thickness-1,
                        -mounting_hole_front_y
                    ])
                        rotate([-90,0,0])
                            cylinder(
                                h=material_thickness+2,
                                d=mounting_hole_diameter
                            );

                for(x=[-mounting_hole_outer_x,0,mounting_hole_outer_x])
                    translate([
                        x,
                        -material_thickness-1,
                        -mounting_hole_rear_y
                    ])
                        rotate([-90,0,0])
                            cylinder(
                                h=material_thickness+2,
                                d=mounting_hole_diameter
                            );
            }
        }

        // Grip bar is added after cutting the openings.
        translate([
            -opening_width/2,
            grip_bar_y,
            grip_bar_z
        ])
            rotate([0,90,0])
                cylinder(
                    h=opening_width,
                    d=grip_bar_diameter
                );
    }
}

module top_center_handle_view(
    orientation="model",
    include_mounting_holes=true
) {
    if(orientation=="model")
        top_center_handle(
            include_mounting_holes=include_mounting_holes
        );
    else if(orientation=="print")
        rotate([90,0,0])
            top_center_handle(
                include_mounting_holes=include_mounting_holes
            );
    else
        assert(false,
            "orientation must be \"model\" or \"print\".");
}

top_center_handle_view(
    component_orientation,
    show_mounting_holes
);
