// ============================================================================
// HUB75 Display Case V1.1 — complete assembly
// ============================================================================

include <../config/project_config.scad>
include <../components/plywood_case.scad>
include <../components/display_reference.scad>
include <../components/roundwood_frame.scad>
include <../components/roundwood_brackets.scad>

module v11_body(
    show_lower_storage=true,
    show_display=true
) {
    if(show_lower_storage)
        lower_storage();

    if(show_display) {
        upper_side_wall(0);
        upper_side_wall(case_outer_width-plywood_thickness);
        display_reference();
    }
}

module v11_roundwood_structure() {
    vertical_roundwood(left_vertical_rod_x);
    vertical_roundwood(right_vertical_rod_x);
    horizontal_roundwood();

    lower_rod_mount(left_vertical_rod_x,"left");
    lower_rod_mount(right_vertical_rod_x,"right");

    vertical_socket_module(left_vertical_rod_x,"left");
    vertical_socket_module(right_vertical_rod_x,"right");

    horizontal_socket_module("left");
    horizontal_socket_module("right");

    center_supports();
}

module display_assembly(
    view="normal",
    show_lower_storage=true,
    show_display=true,
    show_top_panel=true,
    show_cross_member=true,
    show_roundwood=true,
    show_corner_modules=true,
    show_center_supports=true
) {
    if(view=="normal") {
        if(show_lower_storage || show_display)
            v11_body(show_lower_storage,show_display);

        if(show_top_panel)
            removable_top();

        if(show_cross_member)
            upper_cross_member();

        if(show_roundwood) {
            vertical_roundwood(left_vertical_rod_x);
            vertical_roundwood(right_vertical_rod_x);
            horizontal_roundwood();
        }

        if(show_corner_modules) {
            lower_rod_mount(left_vertical_rod_x,"left");
            lower_rod_mount(right_vertical_rod_x,"right");
            vertical_socket_module(left_vertical_rod_x,"left");
            vertical_socket_module(right_vertical_rod_x,"right");
            horizontal_socket_module("left");
            horizontal_socket_module("right");
        }

        if(show_center_supports)
            center_supports();

    } else if(view=="structure") {
        upper_side_wall(0);
        upper_side_wall(case_outer_width-plywood_thickness);
        upper_cross_member();

        vertical_roundwood(left_vertical_rod_x);
        vertical_roundwood(right_vertical_rod_x);
        horizontal_roundwood();

        lower_rod_mount(left_vertical_rod_x,"left");
        lower_rod_mount(right_vertical_rod_x,"right");
        vertical_socket_module(left_vertical_rod_x,"left");
        vertical_socket_module(right_vertical_rod_x,"right");
        horizontal_socket_module("left");
        horizontal_socket_module("right");
        center_supports();

    } else if(view=="body_only") {
        v11_body(show_lower_storage,show_display);
        removable_top();
        upper_cross_member();

    } else if(view=="exploded") {
        v11_body(show_lower_storage,show_display);

        removable_top(65);
        upper_cross_member(-45);

        translate([-50,0,0]) {
            vertical_roundwood(left_vertical_rod_x);
            vertical_socket_module(left_vertical_rod_x,"left");
            lower_rod_mount(left_vertical_rod_x,"left");
        }

        translate([50,0,0]) {
            vertical_roundwood(right_vertical_rod_x);
            vertical_socket_module(right_vertical_rod_x,"right");
            lower_rod_mount(right_vertical_rod_x,"right");
        }

        horizontal_roundwood(0,42);

        translate([-28,0,0])
            horizontal_socket_module("left",0,42);

        translate([28,0,0])
            horizontal_socket_module("right",0,42);

        center_supports(-45,42);

    } else {
        assert(false,str("Unknown V1.1 assembly view: ",view));
    }
}
