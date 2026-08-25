// ============================================================================
// Removable front / ground panel
//
// This component is independent from the legacy model library. The same
// physical panel can be shown horizontally as a ground panel or vertically as
// a removable front panel.
// ============================================================================

use <rubber_feet.scad>

/* [Component view] */

component_orientation = "horizontal"; // [horizontal,vertical]
show_metal_hooks = true;
show_rubber_feet = true;
show_steel_disc = true;

/* [Panel dimensions] */

panel_width = 876;
panel_height = 480;
panel_thickness = 10;

/* [Insert interface] */

insert_core_depth = 16;
insert_core_length = 24;
insert_clearance = 0.30;
insert_center = 240;

/* [Metal hook plates] */

hook_plate_thickness = 2;
hook_plate_length = 24;
hook_plate_height = 20;
hook_corner_radius = 3;
hook_hole_diameter = 4.3;
hook_hole_spacing = 14;
hook_hole_height = 5;
hook_recess = 2;

/* [Rubber feet] */

foot_edge_inset_x = 35;
foot_edge_inset_y = 35;

module front_panel_wood(
    width=panel_width,
    height=panel_height,
    thickness=panel_thickness,
    insert_depth=insert_core_depth,
    insert_length=insert_core_length,
    insert_clearance=insert_clearance,
    insert_center=insert_center,
    wood_color=[0.72,0.50,0.28]
) {
    assert(width > 2*insert_depth,
        "Panel width must exceed both insert depths.");
    assert(height > insert_length,
        "Panel height must exceed the insert length.");
    assert(thickness > 0,
        "Panel thickness must be positive.");

    color(wood_color)
    difference() {
        translate([0,-height,-thickness])
            cube([width,height,thickness]);

        for(right=[false,true])
            translate([
                right
                    ? width-insert_depth-insert_clearance-0.1
                    : -0.1,
                -insert_center-insert_length/2-insert_clearance,
                -thickness-0.1
            ])
                cube([
                    insert_depth+insert_clearance+0.2,
                    insert_length+2*insert_clearance,
                    thickness+0.2
                ]);
    }
}

module front_panel_hook_plate(
    thickness=hook_plate_thickness,
    length=hook_plate_length,
    height=hook_plate_height,
    corner_radius=hook_corner_radius,
    hole_diameter=hook_hole_diameter,
    hole_spacing=hook_hole_spacing,
    hole_height=hook_hole_height,
    metal_color=[0.65,0.68,0.72]
) {
    color(metal_color)
    multmatrix([
        [0,0,1,0],
        [1,0,0,0],
        [0,1,0,0],
        [0,0,0,1]
    ])
        difference() {
            linear_extrude(height=thickness,convexity=10)
                offset(r=corner_radius,$fn=48)
                    offset(delta=-corner_radius)
                        square([length,height]);

            for(x=[
                length/2-hole_spacing/2,
                length/2+hole_spacing/2
            ])
                translate([x,hole_height,-0.2])
                    cylinder(
                        d=hole_diameter,
                        h=thickness+0.4,
                        $fn=48
                    );
        }
}

module front_panel_hooks(
    width=panel_width,
    thickness=panel_thickness,
    insert_center=insert_center,
    hook_recess=hook_recess
) {
    translate([
        -hook_plate_thickness+hook_recess,
        -insert_center-hook_plate_length/2,
        -thickness
    ])
        front_panel_hook_plate();

    translate([
        width-hook_recess,
        -insert_center-hook_plate_length/2,
        -thickness
    ])
        front_panel_hook_plate();
}

module front_panel_rubber_feet(
    width=panel_width,
    height=panel_height,
    thickness=panel_thickness,
    edge_inset_x=foot_edge_inset_x,
    edge_inset_y=foot_edge_inset_y,
    show_steel_disc=true
) {
    for(x=[edge_inset_x,width-edge_inset_x])
        for(y=[-height+edge_inset_y,-edge_inset_y])
            translate([x,y,-thickness-11])
                rubber_foot(
                    bottom_diameter=21,
                    mounting_diameter=25,
                    height=11,
                    mounting_hole_diameter=5.3,
                    steel_disc_diameter=18,
                    show_steel_disc=show_steel_disc
                );
}

module front_panel_horizontal(
    show_metal_hooks=true,
    show_rubber_feet=true,
    show_steel_disc=true
) {
    front_panel_wood();

    if(show_metal_hooks)
        front_panel_hooks();

    if(show_rubber_feet)
        front_panel_rubber_feet(
            show_steel_disc=show_steel_disc
        );
}

module front_panel(
    orientation="horizontal",
    show_metal_hooks=true,
    show_rubber_feet=true,
    show_steel_disc=true
) {
    assert(
        orientation=="horizontal"
        || orientation=="vertical",
        "orientation must be horizontal or vertical."
    );

    if(orientation=="horizontal")
        front_panel_horizontal(
            show_metal_hooks,
            show_rubber_feet,
            show_steel_disc
        );
    else
        translate([0,0,panel_height])
            rotate([-90,0,0])
                front_panel_horizontal(
                    show_metal_hooks,
                    show_rubber_feet,
                    show_steel_disc
                );
}

front_panel(
    component_orientation,
    show_metal_hooks,
    show_rubber_feet,
    show_steel_disc
);
