// ============================================================================
// Aluminium frame and HUB75 LED panels
// ============================================================================

/* [Component view] */

component_selection = "assembled"; // [assembled,exploded,all_unique,frame_only,led_panel]
component_orientation = "model"; // [model,print]
include_led_panels = true;

/* [Geometry quality] */

curve_segments = 48;
$fn = curve_segments;

// ----------------------------------------------------------------------------
// Local component dimensions
// ----------------------------------------------------------------------------

aluminium_profile_size = 20;
frame_width = 840;
frame_height = 360;
vertical_profile_length = frame_height-2*aluminium_profile_size;

led_panel_width = 159.70;
led_panel_height = 319.71;
led_panel_depth = 13.00;
led_panel_count = 5;
led_panel_front_offset = 1;

aluminium_color = [0.70,0.72,0.74,1];
led_front_color = [0.015,0.015,0.015,1];
led_pcb_color = [0.02,0.20,0.07,1];
led_rear_color = [0.07,0.08,0.07,1];

frame_explode_distance = 55;
led_panels_explode_distance = 85;
component_spacing = 70;

inner_width = frame_width-2*aluminium_profile_size;
led_panel_pitch = inner_width/led_panel_count;
led_panel_x_margin = (led_panel_pitch-led_panel_width)/2;
led_panel_z_offset = aluminium_profile_size
    +(vertical_profile_length-led_panel_height)/2;

assert(frame_width == 840,
    "The aluminium frame must remain 840 mm wide.");
assert(frame_height == 360,
    "The aluminium frame must remain 360 mm high.");
assert(led_panel_count == 5,
    "The frame must contain five HUB75 panels.");
assert(led_panel_count*led_panel_pitch == inner_width,
    "The five panel positions must fill the inner frame width.");
assert(led_panel_width <= led_panel_pitch,
    "Each HUB75 panel must fit inside its frame position.");

function led_panel_x(index) =
    aluminium_profile_size
    +index*led_panel_pitch
    +led_panel_x_margin;

// ----------------------------------------------------------------------------
// Unique parts
// ----------------------------------------------------------------------------

module aluminium_profile_cross_section() {
    difference() {
        square([aluminium_profile_size,aluminium_profile_size],center=true);
        circle(d=4.2,$fn=32);

        for(angle=[0:90:270])
            rotate(angle)
                translate([0,aluminium_profile_size/2])
                    square([6,2.5],center=true);
    }
}

module aluminium_profile(length,horizontal=true) {
    color(aluminium_color)
    if(horizontal)
        translate([
            0,
            aluminium_profile_size/2,
            aluminium_profile_size/2
        ])
            rotate([0,90,0])
                linear_extrude(height=length,convexity=10)
                    aluminium_profile_cross_section();
    else
        translate([
            aluminium_profile_size/2,
            aluminium_profile_size/2,
            0
        ])
            linear_extrude(height=length,convexity=10)
                aluminium_profile_cross_section();
}

module hub75_led_panel() {
    color(led_front_color)
        cube([led_panel_width,1.5,led_panel_height]);

    color(led_pcb_color)
        translate([0,1.5,0])
            cube([led_panel_width,1.5,led_panel_height]);

    color(led_rear_color)
        translate([2,3,2])
            cube([
                led_panel_width-4,
                led_panel_depth-3,
                led_panel_height-4
            ]);
}

// ----------------------------------------------------------------------------
// Component assemblies in local coordinates
// ----------------------------------------------------------------------------

module aluminium_frame_geometry(y_offset=0) {
    translate([0,y_offset,0]) {
        aluminium_profile(frame_width,true);

        translate([0,0,frame_height-aluminium_profile_size])
            aluminium_profile(frame_width,true);

        translate([0,0,aluminium_profile_size])
            aluminium_profile(vertical_profile_length,false);

        translate([
            frame_width-aluminium_profile_size,
            0,
            aluminium_profile_size
        ])
            aluminium_profile(vertical_profile_length,false);
    }
}

module hub75_led_panel_set(y_offset=0) {
    translate([0,led_panel_front_offset+y_offset,led_panel_z_offset])
        for(index=[0:led_panel_count-1])
            translate([led_panel_x(index),0,0])
                hub75_led_panel();
}

module aluminium_frame_package(
    show_frame=true,
    show_led_panels=true,
    frame_y_offset=0,
    panel_y_offset=0
) {
    if(show_frame)
        aluminium_frame_geometry(frame_y_offset);

    if(show_led_panels)
        hub75_led_panel_set(panel_y_offset);
}

// Backward-compatible public module used by main.scad.
module aluminium_frame(include_led_panels=false) {
    aluminium_frame_package(true,include_led_panels);
}

module aluminium_frame_view(
    selection="assembled",
    orientation="model",
    show_led_panels=true
) {
    rotate_for_print = orientation == "print" ? [90,0,0] : [0,0,0];

    rotate(rotate_for_print) {
        if(selection == "assembled")
            aluminium_frame_package(true,show_led_panels);
        else if(selection == "exploded")
            aluminium_frame_package(
                true,
                show_led_panels,
                frame_explode_distance,
                led_panels_explode_distance
            );
        else if(selection == "all_unique") {
            aluminium_profile(140,true);
            translate([190,0,0])
                aluminium_profile(140,false);
            translate([260,0,0])
                hub75_led_panel();
        }
        else if(selection == "frame_only")
            aluminium_frame_geometry();
        else if(selection == "led_panel")
            hub75_led_panel();
        else
            assert(false,str("Unknown component_selection: ",selection));
    }
}

aluminium_frame_view(
    component_selection,
    component_orientation,
    include_led_panels
);
