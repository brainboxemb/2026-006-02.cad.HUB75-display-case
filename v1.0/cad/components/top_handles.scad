// ============================================================================
// Top side handles
//
// One unique printable corner handle is used twice. The left instance is a
// mirrored copy of the right-hand model.
//
// Local coordinates:
// - X: outward from the wooden side panel
// - Y: from front to rear
// - Z: relative to the underside of the top wooden panel
// ============================================================================

/* [Component view] */

component_selection = "assembled"; // [assembled,exploded,all_unique,component_1]
component_orientation = "model"; // [model,print]

/* [Geometry quality] */

curve_segments = 48;
$fn = curve_segments;

module rounded_outer_wall(
    thickness=4,
    depth=124,
    height=54,
    lower_band_height=12,
    lower_band_overlap=4,
    lower_corner_radius=2
) {
    band_h = min(lower_band_height,height);
    overlap = min(lower_band_overlap,band_h);
    radius = min(lower_corner_radius,thickness/2,band_h/2);

    union() {
        translate([0,0,band_h-overlap])
            cube([thickness,depth,height-(band_h-overlap)]);

        hull()
            for(x=[radius,thickness-radius])
                for(z=[radius,band_h-radius])
                    translate([x,0,z])
                        rotate([-90,0,0])
                            cylinder(h=depth,r=radius);
    }
}

module triangular_prism_y(p0,p1,p2,y0,depth) {
    polyhedron(
        points=[
            [p0[0],y0,p0[1]],
            [p1[0],y0,p1[1]],
            [p2[0],y0,p2[1]],
            [p0[0],y0+depth,p0[1]],
            [p1[0],y0+depth,p1[1]],
            [p2[0],y0+depth,p2[1]]
        ],
        faces=[
            [0,2,1],
            [3,4,5],
            [0,1,4,3],
            [1,2,5,4],
            [2,0,3,5]
        ],
        convexity=10
    );
}

// Canonical right-hand handle. Mirror in X for the left-hand instance.
module top_side_handle(
    overhang_width=16,
    depth=124,
    wood_thickness=19,
    support_height=20,
    outer_wall_thickness=4,
    lower_grip_extension=12,
    top_lip_thickness=3,
    lower_band_height=12,
    lower_band_overlap=4,
    lower_corner_radius=2,
    upper_transition_start=9,
    upper_transition_size=9,
    lower_rib_size=9,
    bolt_hole_diameter=4.3,
    bolt_y=[46,90],
    show_mounting_holes=true
) {
    support_z0 = -support_height;
    wall_z0 = support_z0-lower_grip_extension;
    wall_height =
        lower_grip_extension
        +support_height
        +wood_thickness
        +top_lip_thickness;

    assert(overhang_width > 0,"overhang_width must be positive.");
    assert(depth > 6,"depth must be greater than 6 mm.");
    assert(len(bolt_y) == 2,"Two mounting-hole Y positions are required.");

    color([0.18,0.72,0.24,1])
    difference() {
        union() {
            // Horizontal support beneath the top-panel overhang.
            translate([0,0,support_z0])
                cube([overhang_width,depth,support_height]);

            // Outer vertical wall with rounded lower grip edge.
            translate([overhang_width,0,wall_z0])
                rounded_outer_wall(
                    outer_wall_thickness,
                    depth,
                    wall_height,
                    lower_band_height,
                    lower_band_overlap,
                    lower_corner_radius
                );

            // Short lip over the outer end of the wooden top panel.
            translate([0,0,wood_thickness])
                cube([overhang_width,depth,top_lip_thickness]);

            // Upper 45-degree transition.
            triangular_prism_y(
                [overhang_width,upper_transition_start],
                [overhang_width,wood_thickness],
                [overhang_width-upper_transition_size,wood_thickness],
                0,
                depth
            );

            // Lower internal strengthening rib.
            triangular_prism_y(
                [overhang_width,support_z0],
                [overhang_width-lower_rib_size,support_z0],
                [overhang_width,support_z0-lower_rib_size],
                3,
                depth-6
            );
        }

        if(show_mounting_holes)
            for(ypos=bolt_y)
                translate([
                    overhang_width+outer_wall_thickness+0.2,
                    ypos,
                    -support_height/2
                ])
                    rotate([0,-90,0])
                        cylinder(
                            d=bolt_hole_diameter,
                            h=overhang_width+outer_wall_thickness+2
                        );
    }
}

module top_side_handle_oriented(
    side="right",
    orientation="model",
    show_mounting_holes=true
) {
    module selected_side() {
        if(side=="right")
            top_side_handle(show_mounting_holes=show_mounting_holes);
        else if(side=="left")
            mirror([1,0,0])
                top_side_handle(show_mounting_holes=show_mounting_holes);
        else
            assert(false,"side must be left or right.");
    }

    if(orientation=="model")
        selected_side();
    else if(orientation=="print")
        rotate([0,90,0]) selected_side();
    else
        assert(false,"orientation must be model or print.");
}

module top_handles_view(
    selection="assembled",
    orientation="model",
    show_mounting_holes=true
) {
    spacing = selection=="exploded" ? 70 : 30;

    if(selection=="assembled" || selection=="exploded") {
        translate([-spacing,0,0])
            top_side_handle_oriented(
                "left",orientation,show_mounting_holes
            );
        translate([spacing,0,0])
            top_side_handle_oriented(
                "right",orientation,show_mounting_holes
            );
    } else if(selection=="all_unique" || selection=="component_1") {
        top_side_handle_oriented(
            "right",orientation,show_mounting_holes
        );
    } else {
        assert(false,str("Unknown component_selection: ",selection));
    }
}

top_handles_view(component_selection,component_orientation,true);
