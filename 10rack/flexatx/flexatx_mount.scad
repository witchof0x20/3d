// 10" rack mount for two Flex ATX power supplies, side by side, using the
// 1U bracket that ships with many Flex ATX PSUs (a flat plate over the IEC
// end with a mounting ear on each side).
//
// Coordinates: x across the rack (centered), y front-to-back (y = 0 is the
// back face of the front panel, the panel occupies -face_t..0), z up
// (z = 0 is the bottom of the panel/floor).
//
// Each PSU drops in from the top: its bracket slides down a slot between the
// front panel and the bay walls. M3 screws go through the front panel and
// the bracket ears into M3 nuts pressed into hex pockets in the wall ends;
// the pockets open toward the bracket, so the nut clamps straight onto it.
// A rear plate bolts onto the back of the walls the same way and into the
// PSU's two 6-32 holes on the DC end, per Intel's Flex ATX drawing.
//
// Print the body standing on its floor; print the clamp flat.

/* [Output] */
part = "assembly"; // [assembly, body, clamp]

/* [Rack] */
units = 1;                  // rack units tall
panel_w = 250;              // 254 is nominal; 250 fits a 256 mm bed
rail_hole_pitch = 236.525;  // 10" rack rail hole center-to-center
rack_hole_d = 6.6;          // M6 / cage-nut clearance
rack_hole_slot = 1.5;       // extra horizontal travel in the ear holes
u_clear = 0.8;              // total vertical gap to neighbouring gear
face_t = 5;

/* [PSU] */
psu_w = 81.5;
psu_h = 40.5;
psu_l = 150;
psu_clr = 0.5;              // per side across the width
psu_len_clr = 0.3;          // between the PSU's DC end and the rear plate

/* [Bracket - measure yours] */
bracket_w = 100;
bracket_h = 40;
bracket_t = 1.2;
bracket_clr = 0.4;          // extra slot thickness
bracket_z = 0;              // bracket bottom relative to the PSU bottom
// [x from the PSU centerline, z up from the bracket bottom]
bracket_holes = [[-45, 20], [45, 20]];
bracket_gap = 2;            // between the two brackets

/* [Structure] */
floor_t = 3;
wall_t = 9;
window_side = 0;            // how far the panel overlaps the PSU face at the sides
window_bottom = 1;
top_bar = 2.5;              // panel material above the window
rear_lip_side = 4;
rear_lip_bottom = 6;
gusset_x = 9;
gusset_y = 24;
corner_r = 2;
vents = true;

/* [Fasteners] */
nut_af = 5.7;               // M3 nut across flats, plus press-fit slack
nut_t = 2.6;                // pocket depth
screw_d = 3.4;
screw_tip_depth = 8;        // clearance for the screw beyond the nut
clamp_t = 5;
// PSU DC-end holes: [u from the IEC-side edge, v up from the PSU bottom]
rear_holes = [[15.0, 33.5], [66.5, 33.5]];
psu_screw_d = 3.8;          // #6-32 clearance
screw_pad_r = 4.5;

/* [Hidden] */
$fn = 48;
eps = 0.01;
U = 44.45;

panel_h = units * U - u_clear;
wall_h = panel_h;
slot = bracket_t + bracket_clr;
bay_x = bracket_w / 2 + bracket_gap / 2;
wall_in = psu_w / 2 + psu_clr;          // bay center to wall inner face
body_half = bay_x + wall_in + wall_t;
center_half = bay_x - wall_in;          // the center block between the bays
y_end = bracket_t + psu_l + psu_len_clr;
psu_top = floor_t + psu_h;
rear_z = [floor_t + 7, wall_h - 7];
rear_x = [-(body_half - wall_t / 2), 0, body_half - wall_t / 2];

rail_inner = rail_hole_pitch / 2 - 8;
assert(body_half + gusset_x <= rail_inner, "body/gussets would hit the rack rails");
assert(bay_x + bracket_w / 2 <= rail_inner, "brackets would hit the rack rails");
assert(panel_w > rail_hole_pitch + rack_hole_d + rack_hole_slot + 4, "ears too narrow for the rail holes");
assert(psu_top <= units * U - u_clear / 2, "PSU sticks out of the rack unit; reduce floor_t");
assert(bracket_z >= 0, "bracket hangs below the PSU; the floor would need a notch");
assert(floor_t + bracket_z + bracket_h <= panel_h, "bracket taller than the panel");
assert(center_half >= 0, "brackets narrower than the PSU? check bracket_w");
for (h = bracket_holes)
    assert(abs(h[0]) - wall_in >= nut_af / 2 + 0.5 && abs(h[0]) <= wall_in + wall_t - nut_af / 2 - 0.5,
           str("bracket hole at x=", h[0], " does not land in a wall; adjust wall_t or psu_clr"));

// Extrude a 2D shape drawn in (x, z) so it occupies y in [-t, 0].
module xz_extrude(t) {
    rotate([90, 0, 0]) linear_extrude(t) children();
}

module rounded_rect(x0, z0, x1, z1, r) {
    translate([x0 + r, z0 + r]) offset(r) square([x1 - x0 - 2 * r, z1 - z0 - 2 * r]);
}

// Map PSU-face coordinates (u from the IEC side, v up from the PSU bottom)
// into the (x, z) plane for the bay centered at cx. The IEC end is on the
// right, seen from the front.
module psu_face(cx) {
    translate([cx + psu_w / 2, floor_t]) mirror([1, 0]) children();
}

function bracket_hole_xz(sx, h) = [sx * bay_x + h[0], floor_t + bracket_z + h[1]];

// Hex nut pocket plus screw clearance, opening at the origin and running
// into the part along +z. Flats face +-x so the pocket fits thin walls and
// a corner points up, which prints cleanly sideways.
module nut_pocket() {
    translate([0, 0, -eps]) {
        rotate([0, 0, 90]) cylinder(d = nut_af / cos(30), h = nut_t + eps, $fn = 6);
        cylinder(d = screw_d, h = nut_t + screw_tip_depth);
    }
}

module rack_holes() {
    for (sx = [-1, 1], u = [0 : units - 1], hz = [6.35, 38.1])
        translate([sx * rail_hole_pitch / 2, u * U + hz - u_clear / 2])
            hull() for (dx = [-1, 1]) translate([dx * rack_hole_slot / 2, 0]) circle(d = rack_hole_d);
}

module front_panel() {
    xz_extrude(face_t) difference() {
        rounded_rect(-panel_w / 2, 0, panel_w / 2, panel_h, corner_r);
        rack_holes();
        for (sx = [-1, 1]) {
            hw = psu_w / 2 - window_side;
            rounded_rect(sx * bay_x - hw, floor_t + window_bottom, sx * bay_x + hw, panel_h - top_bar, corner_r);
            for (h = bracket_holes) translate(bracket_hole_xz(sx, h)) circle(d = screw_d);
        }
    }
}

module floor_vents() {
    slot_w = 4;
    pitch = 10;
    margin = 20;
    n = floor((y_end - 2 * margin) / pitch);
    for (sx = [-1, 1], i = [0 : n])
        translate([sx * bay_x, margin + i * pitch, -eps])
            hull() for (dx = [-1, 1])
                translate([dx * (wall_in - 12), 0, 0]) cylinder(d = slot_w, h = floor_t + 2 * eps);
}

module body() {
    difference() {
        union() {
            front_panel();
            translate([-body_half, -eps, 0]) cube([2 * body_half, y_end + eps, floor_t]);
            // outer walls and the center block
            for (sx = [-1, 1])
                translate([sx > 0 ? body_half - wall_t : -body_half, -eps, 0])
                    cube([wall_t, y_end + eps, wall_h]);
            translate([-center_half, -eps, 0]) cube([2 * center_half, y_end + eps, wall_h]);
            // full-height triangular gussets tying the ears to the outer walls
            for (sx = [-1, 1])
                mirror([sx < 0 ? 1 : 0, 0, 0])
                    linear_extrude(wall_h)
                        polygon([[body_half - eps, -eps], [body_half + gusset_x, -eps], [body_half - eps, gusset_y]]);
        }
        // slot the brackets drop into
        for (sx = [-1, 1])
            translate([sx * bay_x - bracket_w / 2 - 0.5, 0, floor_t])
                cube([bracket_w + 1, slot, wall_h]);
        if (vents) floor_vents();
        // nuts for the bracket screws, in the front ends of the walls
        for (sx = [-1, 1], h = bracket_holes)
            let(p = bracket_hole_xz(sx, h))
                translate([p[0], slot, p[1]]) rotate([-90, 0, 0]) nut_pocket();
        // nuts for the rear plate
        for (x = rear_x, z = rear_z)
            translate([x, y_end, z]) rotate([90, 0, 0]) nut_pocket();
    }
}

module clamp_2d() {
    cut_top = min([for (h = rear_holes) h[1]]) - screw_pad_r;
    difference() {
        rounded_rect(-body_half, 0, body_half, wall_h, corner_r);
        for (sx = [-1, 1]) {
            psu_face(sx * bay_x) {
                rounded_rect(rear_lip_side, rear_lip_bottom, psu_w - rear_lip_side, cut_top, corner_r);
                for (h = rear_holes) translate(h) circle(d = psu_screw_d);
            }
        }
        for (x = rear_x, z = rear_z) translate([x, z]) circle(d = screw_d);
    }
}

// Placed in its installed position behind the body.
module clamp() {
    translate([0, y_end + clamp_t, 0]) xz_extrude(clamp_t) clamp_2d();
}

module psu_ghost() {
    for (sx = [-1, 1]) {
        %translate([sx * bay_x - psu_w / 2, bracket_t, floor_t]) cube([psu_w, psu_l, psu_h]);
        %translate([sx * bay_x - bracket_w / 2, 0, floor_t + bracket_z]) cube([bracket_w, bracket_t, bracket_h]);
    }
}

if (part == "body") {
    body();
} else if (part == "clamp") {
    linear_extrude(clamp_t) clamp_2d();
} else {
    body();
    color("orange") clamp();
    psu_ghost();
}
