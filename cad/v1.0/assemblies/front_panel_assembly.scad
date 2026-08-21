// ============================================================================
// Front-panel subassembly
// ============================================================================

include <display_case_core.scad>

module front_panel_assembly(
    orientation="horizontal",
    include_inserts=true,
    show_steel_disc=true
) {
    if(orientation=="horizontal")
        voorplaat_subassemblage_horizontaal(
            include_inserts,
            onderste_klem_y_hart,
            show_steel_disc
        );
    else if(orientation=="vertical")
        voorplaat_subassemblage_verticaal(
            include_inserts,
            show_steel_disc
        );
    else
        assert(false,
            "orientation must be \"horizontal\" or \"vertical\".");
}

/* [Assembly view] */
orientation = "horizontal"; // [horizontal,vertical]
include_inserts = true;
show_steel_disc = true;

front_panel_assembly(
    orientation,
    include_inserts,
    show_steel_disc
);
