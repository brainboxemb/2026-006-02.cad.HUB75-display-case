// ============================================================================
// HUB75 Display Case V1.1 — complete display case STL export
//
// Intended for automatic STL generation by the shared export workflow.
// This file contains no camera settings and exports the complete assembled
// display case with the removable ground panel, but without the rear panel.
// ============================================================================

include <../assemblies/display_assembly.scad>

display_assembly(
    "normal",
    true,   // aluminium frame
    true,   // HUB75 LED panels
    true,   // acrylic front panel
    true,   // removable panel in ground position
    false,  // same removable panel not duplicated in front position
    false,  // rear panel intentionally omitted from STL export
    true,   // steel discs
    true,   // roundwood frame
    true,   // roundwood sockets
    true,   // roundwood cross member
    true    // roundwood center supports
);
