// ============================================================================
// HUB75 Display Case — documentation assembly wrapper
// ============================================================================

include <display_case_core.scad>

module display_assembly(
    view="normal",
    include_aluminium=true,
    include_led_panels=true,
    include_acrylic=true,
    include_ground_panel=true,
    include_front_panel=false,
    include_rear_panel=false,
    show_steel_disc=true
) {
    if(view == "normal")
        normale_montageweergave(
            include_aluminium,
            include_led_panels,
            include_acrylic,
            include_ground_panel,
            include_front_panel,
            include_rear_panel,
            show_steel_disc
        );
    else if(view == "exploded")
        exploded_montageweergave(
            include_aluminium,
            include_led_panels,
            include_acrylic,
            include_ground_panel,
            include_front_panel,
            include_rear_panel,
            show_steel_disc
        );
    else
        assert(false, "view must be normal or exploded");
}
