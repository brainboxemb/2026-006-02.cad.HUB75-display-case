// ============================================================================
// Front-panel plastic inserts
//
// One unique printable component exists.
// The left and right assembly instances use the same part in a different
// orientation.
//
// Open this file directly to inspect or export the insert.
// ============================================================================

/* [Component view] */

component_selection = "assembled"; // [assembled,exploded,all_unique,component_1]
component_orientation = "model"; // [model,print]

include <../assemblies/display_case_core.scad>

module front_panel_insert_component(
    orientation="print"
) {
    assert(
        orientation=="model"
        || orientation=="print",
        "orientation must be \"model\" or \"print\"."
    );

    // The left-hand source geometry is the single unique manufactured part.
    // The right-hand assembly instance is obtained by rotation/mirroring
    // during placement, not by manufacturing a second variant.
    if(orientation=="print")
        print_kunststof_inzet(false);
    else
        kunststof_randzadel(false);
}


module front_panel_inserts_exploded(
    distance=80
) {
    translate([-distance,0,0])
        kunststof_randzadel(false);

    translate([distance,0,0])
        kunststof_randzadel(true);
}

module front_panel_inserts_all_unique(
    orientation="print"
) {
    front_panel_insert_component(
        orientation
    );
}


module front_panel_inserts_view(
    selection="assembled",
    orientation="model"
) {
    if(selection=="assembled") {
        kunststof_randzadel(false);
        kunststof_randzadel(true);

    } else if(selection=="exploded") {
        front_panel_inserts_exploded();

    } else if(
        selection=="all_unique"
        || selection=="component_1"
    ) {
        front_panel_insert_component(
            orientation
        );

    } else {
        assert(false,str(
            "Unknown front-panel insert selection: ",
            selection
        ));
    }
}


front_panel_inserts_view(
    component_selection,
    component_orientation
);
