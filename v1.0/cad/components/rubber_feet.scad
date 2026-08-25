// ============================================================================
// Rubber foot — Adam Hall 4900SM4AH (simplified)
//
// This file is fully independent from the legacy model library.
// The component is built around the local origin and can be opened directly.
//
// Local axes:
// X/Y = circular footprint
// Z   = from floor side toward the mounting surface
// ============================================================================

/* [Component view] */

component_selection = "component_1"; // [assembled,exploded,all_unique,component_1]
component_orientation = "model"; // [model,print]

/* [Rubber feet] */

show_steel_disc = true;

module rubber_foot(
    bottom_diameter=21,
    mounting_diameter=25,
    height=11,
    mounting_hole_diameter=5.3,
    steel_disc_diameter=18,
    steel_disc_thickness=0.8,
    show_steel_disc=true,
    rubber_color=[0.05,0.05,0.05],
    steel_color=[0.35,0.35,0.35],
    curve_segments=48
) {
    assert(bottom_diameter > 0,
        "bottom_diameter must be positive.");
    assert(mounting_diameter >= bottom_diameter,
        "mounting_diameter must not be smaller than bottom_diameter.");
    assert(height > steel_disc_thickness,
        "height must exceed steel_disc_thickness.");
    assert(mounting_hole_diameter > 0
        && mounting_hole_diameter < bottom_diameter,
        "mounting_hole_diameter must fit inside the rubber foot.");

    difference() {
        color(rubber_color)
            cylinder(
                d1=bottom_diameter,
                d2=mounting_diameter,
                h=height,
                $fn=curve_segments
            );

        translate([0,0,-0.2])
            cylinder(
                d=mounting_hole_diameter,
                h=height+0.4,
                $fn=curve_segments
            );
    }

    if(show_steel_disc)
        color(steel_color)
            translate([0,0,height-1])
                difference() {
                    cylinder(
                        d=steel_disc_diameter,
                        h=steel_disc_thickness,
                        $fn=curve_segments
                    );

                    translate([0,0,-0.1])
                        cylinder(
                            d=mounting_hole_diameter,
                            h=steel_disc_thickness+0.2,
                            $fn=curve_segments
                        );
                }
}

module rubber_feet_view(
    selection="component_1",
    orientation="model",
    show_steel_disc=true,
    spacing=40
) {
    assert(
        selection=="assembled"
        || selection=="exploded"
        || selection=="all_unique"
        || selection=="component_1",
        "Unknown rubber-foot component selection."
    );
    assert(
        orientation=="model" || orientation=="print",
        "orientation must be model or print."
    );

    module oriented_foot() {
        // The model orientation already has the flat floor side on Z=0 and is
        // also the preferred print orientation.
        rubber_foot(
            show_steel_disc=show_steel_disc
        );
    }

    if(selection=="component_1" || selection=="all_unique") {
        oriented_foot();

    } else {
        layout_spacing = selection=="exploded" ? spacing*1.5 : spacing;

        for(x=[-layout_spacing/2,layout_spacing/2])
            for(y=[-layout_spacing/2,layout_spacing/2])
                translate([x,y,0])
                    oriented_foot();
    }
}

rubber_feet_view(
    component_selection,
    component_orientation,
    show_steel_disc
);
