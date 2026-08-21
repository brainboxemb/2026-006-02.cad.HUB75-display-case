// ============================================================================
// HUB75 Display Case V1.1 — Ø22 mm roundwood carry frame
// ============================================================================

use <_lib/geometry.scad>

module vertical_roundwood(x,z_shift=0) {
    color(rod_color)
        translate([
            x,
            rod_axis_y,
            vertical_rod_bottom_z+z_shift
        ])
            cylinder(
                h=vertical_rod_top_z-vertical_rod_bottom_z,
                d=rod_diameter
            );
}

module horizontal_roundwood(x_shift=0,z_shift=0) {
    color(rod_color)
        translate([
            left_horizontal_rod_end_x+x_shift,
            rod_axis_y,
            horizontal_rod_axis_z+z_shift
        ])
            cyl_x(horizontal_rod_length,rod_diameter);
}
