// ============================================================================
// Wooden enclosure frame
// ============================================================================

include <../assemblies/display_case_core.scad>

module wooden_frame(
    exploded=false,
    mount_front_panel=false,
    mount_rear_panel=true,
    include_aluminium=false,
    include_led_panels=false,
    include_acrylic=true
) {
    houten_frame_assemblage(
        exploded,
        mount_front_panel,
        mount_rear_panel,
        include_aluminium,
        include_led_panels,
        include_acrylic
    );
}

/* [Component view] */
exploded = false;
mount_front_panel = false;
mount_rear_panel = true;
include_aluminium = false;
include_led_panels = false;
include_acrylic = true;

wooden_frame(
    exploded,
    mount_front_panel,
    mount_rear_panel,
    include_aluminium,
    include_led_panels,
    include_acrylic
);
