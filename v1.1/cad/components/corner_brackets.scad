// ============================================================================
// Plastic lower corner bracket
//
// The positioning recess now has the same entry ramp at both Y ends.
// Front/rear and left/right placements can therefore use the same printed
// component after rotation.
//
// component_1 = the single unique manufactured bracket
// ============================================================================

include <../assemblies/display_case_core.scad>

module corner_bracket_component(
    orientation="print"
) {
    assert(
        orientation=="model" || orientation=="print",
        "orientation must be \"model\" or \"print\"."
    );

    if(orientation=="print")
        print_hoekbeugel(false,true);
    else
        kunststof_hoekbeugel(
            false,
            eiken_lijst_voor_y,
            true
        );
}

module corner_brackets_exploded(
    distance_x=55,
    distance_y=55
) {
    // Four instances remain oriented as assembly parts, but are moved away
    // from the enclosure corners for inspection.
    translate([-distance_x,-distance_y,0])
        kunststof_hoekbeugel(
            false,
            eiken_lijst_voor_y,
            true
        );

    translate([-distance_x,distance_y,0])
        kunststof_hoekbeugel(
            false,
            kast_y_achter-hoekbeugel_breedte_y,
            false
        );

    translate([distance_x,-distance_y,0])
        kunststof_hoekbeugel(
            true,
            eiken_lijst_voor_y,
            true
        );

    translate([distance_x,distance_y,0])
        kunststof_hoekbeugel(
            true,
            kast_y_achter-hoekbeugel_breedte_y,
            false
        );
}

module corner_brackets_view(
    selection="assembled",
    orientation="model"
) {
    if(selection=="assembled") {
        kunststof_hoekbeugels();

    } else if(selection=="exploded") {
        corner_brackets_exploded();

    } else if(
        selection=="all_unique"
        || selection=="component_1"
    ) {
        corner_bracket_component(orientation);

    } else {
        assert(false,str(
            "Unknown component selection: ",
            selection
        ));
    }
}

/* [Component view] */

component_selection = "assembled"; // [assembled,exploded,all_unique,component_1]
component_orientation = "model"; // [model,print]

corner_brackets_view(
    component_selection,
    component_orientation
);
