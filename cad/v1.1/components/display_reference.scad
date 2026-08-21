// HUB75 Display Case V1.1 — display reference
//
// This is intentionally still a simple envelope. The detailed HUB75 frame
// remains a separate project and can be integrated later.

module display_reference() {
    color(display_color)
        translate([
            plywood_thickness,
            -1.5,
            display_bottom_z+3
        ])
            cube([
                case_outer_width-2*plywood_thickness,
                4,
                display_height-top_thickness-6
            ]);
}
