// ============================================================================
// Side clamp guide
//
// This component is defined entirely in local coordinates.
//
// Local axes:
// X = width across the L profile
// Y = length toward the side clamp
// Z = vertical
//
// The component can be opened and rendered directly. It does not depend on
// assembly coordinates or derived legacy variables.
// ============================================================================

module side_clamp_guide(
    side="left",
    height=50,
    glass_leg_width=25.8,
    guide_length=40,
    wall_thickness=2,
    screw_diameter=3.5,
    screw_z=[8,42],
    show_screw_holes=true
) {
    assert(side=="left" || side=="right",
        "side must be \"left\" or \"right\".");
    assert(height > 0,
        "height must be positive.");
    assert(glass_leg_width > wall_thickness,
        "glass_leg_width must exceed wall_thickness.");
    assert(guide_length >= 40,
        "guide_length must cover the 30 mm clamp section plus 10 mm overhang.");
    assert(wall_thickness > 0,
        "wall_thickness must be positive.");

    right_side = side=="right";

    // Build one left-hand local profile, then mirror it for the right side.
    mirror([right_side ? 1 : 0,0,0])
    difference() {
        union() {
            // Full leg against the oak/glass trim.
            cube([
                glass_leg_width,
                wall_thickness,
                height
            ]);

            // Straight guide leg toward the metal side clamp.
            cube([
                wall_thickness,
                guide_length,
                height
            ]);
        }

        if(show_screw_holes)
            for(z_position=screw_z)
                translate([
                    -0.2,
                    guide_length/2,
                    z_position
                ])
                    rotate([0,90,0])
                        cylinder(
                            d=screw_diameter,
                            h=wall_thickness+0.4,
                            $fn=36
                        );
    }
}

module side_clamp_guide_view(
    side="left",
    orientation="model"
) {
    assert(
        orientation=="model" || orientation=="print",
        "orientation must be \"model\" or \"print\"."
    );

    if(orientation=="model")
        side_clamp_guide(side=side);
    else
        rotate([90,0,0])
            side_clamp_guide(side=side);
}

/* [Component view] */

side = "left"; // [left,right]
orientation = "model"; // [model,print]

/* [Component dimensions] */

guide_length = 40;
glass_leg_width = 25.8;
height = 50;
wall_thickness = 2;

side_clamp_guide(
    side=side,
    height=height,
    glass_leg_width=glass_leg_width,
    guide_length=guide_length,
    wall_thickness=wall_thickness
);
