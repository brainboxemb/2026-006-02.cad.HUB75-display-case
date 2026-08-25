// ============================================================================
// Removable rear panel
//
// Local coordinate system:
// - X: panel width
// - Y: panel thickness, from front face to rear face
// - Z: panel height
// - origin: lower-left corner of the front face
// ============================================================================

/* [Component view] */

component_orientation = "model"; // [model,print]

/* [Rear panel] */

panel_width = 876;
panel_height = 465;
panel_thickness = 10;

curve_segments = 48;
$fn = curve_segments;

module rear_panel(
    width=panel_width,
    height=panel_height,
    thickness=panel_thickness,
    orientation="model"
) {
    assert(width > 0, "Rear-panel width must be positive.");
    assert(height > 0, "Rear-panel height must be positive.");
    assert(thickness > 0, "Rear-panel thickness must be positive.");

    if(orientation=="model")
        rear_panel_geometry(width,height,thickness);
    else if(orientation=="print")
        // Lay the broad face on the print bed.
        rotate([90,0,0])
            rear_panel_geometry(width,height,thickness);
    else
        assert(false,
            "orientation must be model or print.");
}

module rear_panel_geometry(width,height,thickness) {
    color([0.76,0.50,0.27,1])
        cube([width,thickness,height]);
}

rear_panel(
    panel_width,
    panel_height,
    panel_thickness,
    component_orientation
);
