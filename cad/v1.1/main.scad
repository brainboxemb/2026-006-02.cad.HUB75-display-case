// ============================================================================
// HUB75 Display Case V1.1 — main Customizer and view router
// ============================================================================

include <assemblies/display_assembly.scad>

/* [View] */
view_mode = "complete"; // [complete,structure,body_only,exploded]

/* [Visibility] */
show_lower_storage = true;
show_display = true;
show_top_panel = true;
show_cross_member = true;
show_roundwood = true;
show_corner_modules = true;
show_center_supports = true;

if(view_mode=="complete")
    display_assembly(
        "normal",
        show_lower_storage,
        show_display,
        show_top_panel,
        show_cross_member,
        show_roundwood,
        show_corner_modules,
        show_center_supports
    );
else if(view_mode=="structure")
    display_assembly("structure");
else if(view_mode=="body_only")
    display_assembly("body_only");
else if(view_mode=="exploded")
    display_assembly("exploded");
else
    assert(false,str("Unknown view_mode: ",view_mode));
