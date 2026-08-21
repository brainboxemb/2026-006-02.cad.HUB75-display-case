// HUB75 Display Case V1.1 — shared geometry helpers

module cyl_x(length, diameter, center=false) {
    rotate([0,90,0])
        cylinder(h=length,d=diameter,center=center);
}
