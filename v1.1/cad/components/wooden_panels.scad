// ============================================================================
// Wooden panels with their associated oak trim
//
// The oak pieces remain separate physical parts, but are presented together
// with the wooden panel to which they belong. In exploded mode the oak trim is
// moved forward so the joint between plywood and oak remains visible.
// ============================================================================

/* [Component view] */

panel_selection = "assembled"; // [assembled,exploded,all_unique,left_side_panel,right_side_panel,top_panel,middle_panel,bottom_panel]
component_orientation = "model"; // [model,print]
include_side_guides = true;

include <../assemblies/display_case_core.scad>

module wooden_panel_with_oak(
    panel="left_side_panel",
    exploded=false,
    include_side_guides=true
) {
    oak_offset_y = exploded ? eiken_lijst_explode_y : 0;

    if(panel=="left_side_panel") {
        houten_zijwand(false);
        translate([0,oak_offset_y,0])
            eiken_lijst_links(include_side_guides);

    } else if(panel=="right_side_panel") {
        houten_zijwand(true);
        translate([0,oak_offset_y,0])
            eiken_lijst_rechts(include_side_guides);

    } else if(panel=="top_panel") {
        houten_bovenkap();
        translate([0,oak_offset_y,0])
            eiken_lijst_boven();

    } else if(panel=="middle_panel") {
        houten_tussenbodem();
        translate([0,oak_offset_y,0])
            eiken_lijst_onder();

    } else if(panel=="bottom_panel") {
        houten_onderbodem();
    }
}

module wooden_panels_assembly(
    exploded=false,
    include_side_guides=true
) {
    wooden_panel_with_oak("left_side_panel",exploded,include_side_guides);
    wooden_panel_with_oak("right_side_panel",exploded,include_side_guides);
    wooden_panel_with_oak("top_panel",exploded,include_side_guides);
    wooden_panel_with_oak("middle_panel",exploded,include_side_guides);
    wooden_panel_with_oak("bottom_panel",exploded,include_side_guides);
}

module wooden_panels_unique(include_side_guides=true) {
    // Keep the real assembly coordinates so every joint can still be checked.
    // Each physical panel is shown once; left and right remain separate because
    // their machining and clamp recesses are mirrored.
    wooden_panels_assembly(true,include_side_guides);
}

module wooden_panels_view(
    selection="assembled",
    orientation="model",
    include_side_guides=true
) {
    rotate_for_print = orientation=="print" ? [90,0,0] : [0,0,0];

    rotate(rotate_for_print) {
        if(selection=="assembled")
            wooden_panels_assembly(false,include_side_guides);
        else if(selection=="exploded")
            wooden_panels_assembly(true,include_side_guides);
        else if(selection=="all_unique")
            wooden_panels_unique(include_side_guides);
        else
            wooden_panel_with_oak(selection,false,include_side_guides);
    }
}

wooden_panels_view(
    panel_selection,
    component_orientation,
    include_side_guides
);
