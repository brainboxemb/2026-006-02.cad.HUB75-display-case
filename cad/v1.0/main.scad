// ============================================================================
// HUB75 Display Case — main Customizer and view router
//
// Open this file for the complete project.
// Individual component and assembly files can also be opened directly.
// ============================================================================

/* [Geometry quality] */

curve_segments = 48;
$fn = curve_segments;

include <config/project_info.scad>
include <assemblies/display_case_core.scad>

use <components/side_clamp_guide.scad>
use <components/wooden_panels.scad>
use <components/wooden_frame.scad>
use <components/front_panel.scad>
use <components/rear_panel.scad>
use <components/front_panel_inserts.scad>
use <components/aluminium_frame.scad>
use <components/clamps.scad>
use <components/top_handles.scad>
use <components/top_center_handle.scad>
use <components/corner_brackets.scad>
use <components/rubber_feet.scad>
use <assemblies/display_case.scad>
use <assemblies/front_panel_assembly.scad>

/* [View] */

view_mode = "complete"; // [complete,exploded,wooden_frame,front_panel_horizontal,front_panel_vertical,rear_panel,front_panel_inserts,wooden_panels,wooden_panels_exploded,side_clamp_guide_left,side_clamp_guide_right,aluminium_frame,aluminium_with_led_panels,clamps_lower,clamps_upper,clamps_both,top_handles,top_handles_exploded,top_center_handle,corner_brackets,rubber_feet]

/* [Complete assembly] */

show_aluminium_frame = true;
show_led_panels = true;
show_acrylic = true;
show_ground_panel = true;
show_front_panel = false;
show_rear_panel = false;

/* [Front panel] */

show_front_panel_inserts = true;

/* [Wooden panels] */

wooden_panel_selection = "assembled"; // [assembled,exploded,all_unique,left_side_panel,right_side_panel,top_panel,middle_panel,bottom_panel]
show_side_clamp_guides = true;

/* [Individual component] */

component_selection = "assembled"; // [assembled,exploded,all_unique,component_1,component_2]
component_orientation = "model"; // [model,print]

// ----------------------------------------------------------------------------
// View router
// ----------------------------------------------------------------------------

if(view_mode=="complete") {
    display_case_assembly(
        "normal",
        show_aluminium_frame,
        show_led_panels,
        show_acrylic,
        show_ground_panel,
        show_front_panel,
        show_rear_panel,
        true
    );

} else if(view_mode=="exploded") {
    display_case_assembly(
        "exploded",
        show_aluminium_frame,
        show_led_panels,
        show_acrylic,
        show_ground_panel,
        show_front_panel,
        show_rear_panel,
        true
    );

} else if(view_mode=="wooden_frame") {
    wooden_frame(
        false,
        false,
        show_rear_panel,
        show_aluminium_frame,
        show_led_panels,
        show_acrylic
    );

} else if(view_mode=="front_panel_horizontal") {
    front_panel(
        "horizontal",
        true,
        true,
        true
    );

} else if(view_mode=="front_panel_vertical") {
    front_panel(
        "vertical",
        true,
        true,
        true
    );

} else if(view_mode=="rear_panel") {
    rear_panel(
        hout_buiten_breedte,
        hout_buiten_hoogte,
        achterpaneel_hout_dikte,
        component_orientation
    );

} else if(view_mode=="front_panel_inserts") {
    front_panel_inserts_view(
        component_selection,
        component_orientation
    );

} else if(view_mode=="wooden_panels") {
    wooden_panels_view(
        wooden_panel_selection,
        component_orientation,
        show_side_clamp_guides
    );

} else if(view_mode=="wooden_panels_exploded") {
    wooden_panels_view(
        "exploded",
        component_orientation,
        show_side_clamp_guides
    );

} else if(view_mode=="side_clamp_guide_left") {
    side_clamp_guide_view(
        "left",
        component_orientation
    );

} else if(view_mode=="side_clamp_guide_right") {
    side_clamp_guide_view(
        "right",
        component_orientation
    );

} else if(view_mode=="aluminium_frame") {
    aluminium_frame_view(
        "frame_only",
        component_orientation,
        false
    );

} else if(view_mode=="aluminium_with_led_panels") {
    aluminium_frame_view(
        component_selection,
        component_orientation,
        true
    );

} else if(view_mode=="clamps_lower") {
    clamp_plates("lower");

} else if(view_mode=="clamps_upper") {
    clamp_plates("upper");

} else if(view_mode=="clamps_both") {
    clamp_plates("both");

} else if(view_mode=="top_handles") {
    top_handles_view("assembled",component_orientation,true);

} else if(view_mode=="top_handles_exploded") {
    top_handles_view("exploded",component_orientation,true);

} else if(view_mode=="top_center_handle") {
    top_center_handle_view(component_orientation,true);

} else if(view_mode=="corner_brackets") {
    corner_brackets_view(
        component_selection,
        component_orientation
    );

} else if(view_mode=="rubber_feet") {
    rubber_feet_view(
        component_selection,
        component_orientation,
        true
    );

} else {
    assert(false,str("Unknown view_mode: ",view_mode));
}
