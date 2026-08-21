// ============================================================================
// Toggle clamps
// ============================================================================

/* [Component view] */

component_selection = "both_pairs"; // [assembled,exploded,all_unique,lower_pair,upper_pair,both_pairs,component_1]
component_orientation = "model"; // [model,print]
show_mounting_holes = true;

/* [Geometry quality] */

curve_segments = 48;
$fn = curve_segments;

// ----------------------------------------------------------------------------
// Local component dimensions
// ----------------------------------------------------------------------------

clamp_plate_thickness = 2;
clamp_base_width = 16.5;
clamp_base_length = 43;
clamp_mounting_hole_diameter = 4.2;
clamp_mounting_hole_spacing = 14;
clamp_first_hole_position = 23;

clamp_closed_length = 73;
clamp_bracket_outer_width = 23.5;
clamp_bracket_profile_width = 2;
clamp_bracket_profile_height = 3;
clamp_bracket_clearance = 1;
clamp_bracket_overhang = 15.5;
clamp_hinge_pin_diameter = 4.2;
clamp_hinge_position = 13.5;

clamp_color = [0.58,0.61,0.66,1];

pair_spacing = 75;
group_spacing = 115;
explode_distance = 40;

assert(clamp_plate_thickness == 2,
    "The purchased clamp base plate must remain 2 mm thick.");
assert(clamp_base_width == 16.5,
    "The purchased clamp base must remain 16.5 mm wide.");
assert(clamp_base_length == 43,
    "The purchased clamp base must remain 43 mm long.");
assert(clamp_mounting_hole_spacing == 14,
    "The clamp mounting holes must remain 14 mm centre-to-centre.");
assert(clamp_closed_length == 73,
    "The purchased clamp must remain 73 mm long when closed.");
assert(clamp_bracket_outer_width == 23.5,
    "The purchased clamp bracket must remain 23.5 mm wide.");

// ----------------------------------------------------------------------------
// Unique purchased component
// ----------------------------------------------------------------------------

module toggle_clamp(show_mounting_holes=true) {
    hole_y = clamp_base_width/2;
    hole_1_z = clamp_first_hole_position;
    hole_2_z = hole_1_z+clamp_mounting_hole_spacing;

    bracket_front_z = -clamp_bracket_overhang;
    bracket_rear_z = clamp_hinge_position;
    bracket_left_y =
        (clamp_base_width-clamp_bracket_outer_width)/2;
    bracket_right_y =
        (clamp_base_width+clamp_bracket_outer_width)/2
        -clamp_bracket_profile_width;
    bracket_x =
        clamp_plate_thickness+clamp_bracket_clearance;

    color(clamp_color)
    difference() {
        union() {
            cube([
                clamp_plate_thickness,
                clamp_base_width,
                clamp_base_length
            ]);

            for(y0=[0,clamp_base_width-3])
                translate([
                    clamp_plate_thickness,
                    y0,
                    clamp_hinge_position-5
                ])
                    cube([6,3,12]);

            for(y0=[bracket_left_y,bracket_right_y])
                translate([bracket_x,y0,bracket_front_z])
                    cube([
                        clamp_bracket_profile_height,
                        clamp_bracket_profile_width,
                        bracket_rear_z-bracket_front_z
                    ]);

            translate([
                bracket_x,
                bracket_left_y,
                bracket_front_z
            ])
                cube([
                    clamp_bracket_profile_height,
                    clamp_bracket_outer_width,
                    clamp_bracket_profile_width
                ]);

            translate([
                clamp_plate_thickness+3,
                clamp_bracket_profile_width,
                clamp_hinge_position
            ])
                rotate([-90,0,0])
                    cylinder(
                        d=clamp_hinge_pin_diameter,
                        h=max(
                            0.1,
                            clamp_base_width
                            -2*clamp_bracket_profile_width
                        )
                    );
        }

        if(show_mounting_holes)
            for(z_hole=[hole_1_z,hole_2_z])
                translate([-0.2,hole_y,z_hole])
                    rotate([0,90,0])
                        cylinder(
                            d=clamp_mounting_hole_diameter,
                            h=clamp_plate_thickness+0.4
                        );
    }
}

// ----------------------------------------------------------------------------
// Local component arrangements
// ----------------------------------------------------------------------------

module lower_clamp_pair(
    separation=pair_spacing,
    show_mounting_holes=true
) {
    translate([-separation/2,0,0])
        mirror([1,0,0])
            toggle_clamp(show_mounting_holes);

    translate([separation/2,0,0])
        toggle_clamp(show_mounting_holes);
}

module upper_clamp_pair(
    separation=pair_spacing,
    show_mounting_holes=true
) {
    translate([-separation/2,0,0])
        mirror([1,0,0])
            rotate([-90,0,0])
                toggle_clamp(show_mounting_holes);

    translate([separation/2,0,0])
        rotate([-90,0,0])
            toggle_clamp(show_mounting_holes);
}

module clamp_pairs(
    exploded=false,
    show_mounting_holes=true
) {
    offset = exploded ? explode_distance : 0;

    translate([0,-group_spacing/2-offset,0])
        lower_clamp_pair(pair_spacing,show_mounting_holes);

    translate([0,group_spacing/2+offset,0])
        upper_clamp_pair(pair_spacing,show_mounting_holes);
}

module clamps_view(
    selection="both_pairs",
    orientation="model",
    show_mounting_holes=true
) {
    print_rotation = orientation == "print" ? [0,90,0] : [0,0,0];

    rotate(print_rotation) {
        if(selection == "assembled" || selection == "both_pairs")
            clamp_pairs(false,show_mounting_holes);
        else if(selection == "exploded")
            clamp_pairs(true,show_mounting_holes);
        else if(selection == "lower_pair")
            lower_clamp_pair(pair_spacing,show_mounting_holes);
        else if(selection == "upper_pair")
            upper_clamp_pair(pair_spacing,show_mounting_holes);
        else if(selection == "all_unique" || selection == "component_1")
            toggle_clamp(show_mounting_holes);
        else
            assert(false,
                "Unknown clamp component_selection value.");
    }
}

// Backward-compatible view name used by main.scad.
module clamp_plates(group="both") {
    if(group == "lower")
        clamps_view("lower_pair","model",true);
    else if(group == "upper")
        clamps_view("upper_pair","model",true);
    else if(group == "both")
        clamps_view("both_pairs","model",true);
    else
        assert(false,
            "group must be lower, upper or both.");
}

clamps_view(
    component_selection,
    component_orientation,
    show_mounting_holes
);
