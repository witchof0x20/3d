// 10" rack mount for two Flex ATX power supplies, side by side.
//
// Coordinates: x across the rack (centered), y front-to-back (y = 0 is the
// back face of the front panel, the panel occupies -face_t..0), z up
// (z = 0 is the bottom of the panel/floor).
//
// The PSUs slide in from the rear, IEC end first, and bottom out against
// lips around the front cutouts. A bolt-on rear clamp plate (M3 screws into
// heat-set inserts in the wall posts) pins them forward. The front lips go
// all the way round the cutout (the top bar sits in front of the PSU face, so
// it fits even in 1U).
//
// With psu_screws on, the PSUs are also bolted through the front panel (4x)
// and the rear plate (2x) using the 6-32 holes from Intel's Flex ATX
// drawing. That drawing's IEC face has three holes along one long edge; this
// mount assumes that edge is at the bottom, which puts the IEC inlet on the
// right (seen from the front) and the DC-end holes 7 mm below the top.
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
psu_len_clr = 0.3;          // total along the length; keep small, both ends are bolted

/* [PSU screws] */
psu_screws = true;
// [u, v] in mm on the PSU face: u from the IEC-side edge, v up from the bottom.
front_holes = [[4.4, 4.6], [15.2, 3.5], [76.0, 4.1], [76.0, 36.1]];
rear_holes = [[15.0, 33.5], [66.5, 33.5]];
psu_screw_d = 3.8;          // #6-32 clearance
screw_pad_r = 4.5;
// Front pockets so a C13 plug body can seat and the two screws beside the
// inlet sit flush. Each is [u0, u1, v0, v1].
iec_relief = [[3, 30, 0, 45], [0, 20, 0, 9]];
iec_relief_t = 2;           // panel left behind the pocket

/* [Structure] */
floor_t = 3;
outer_wall_t = 6;
center_wall_t = 8;
lip_side = 3;               // how far the front lips cover the PSU face
lip_bottom = 2;
lip_top = 3;
rear_lip_side = 4;
rear_lip_bottom = 6;
gusset_x = 14;
gusset_y = 24;
post_w = 10;                // outer rear posts, measured from the wall's inner face
post_l = 12;
corner_r = 2;
vents = true;

/* [Fasteners] */
insert_d = 4.2;             // M3 heat-set insert hole
insert_depth = 7;
screw_d = 3.4;
clamp_t = 5;

/* [Hidden] */
$fn = 48;
eps = 0.01;
U = 44.45;

panel_h = units * U - u_clear;
wall_h = panel_h;
bay_w = psu_w + 2 * psu_clr;
bay_l = psu_l + psu_len_clr;
body_w = 2 * bay_w + 2 * outer_wall_t + center_wall_t;
bay_x = center_wall_t / 2 + bay_w / 2;
post_x = body_w / 2 - outer_wall_t + post_w / 2;
post_z = [floor_t + 7, wall_h - 7];
psu_top = floor_t + psu_h;
// Only close the cutout over the PSU if the bar above it is worth having.

rail_inner = rail_hole_pitch / 2 - 8;
assert(body_w / 2 + gusset_x <= rail_inner, "body/gussets would hit the rack rails");
assert(body_w / 2 - outer_wall_t + post_w <= rail_inner, "rear posts would hit the rack rails");
assert(panel_w > rail_hole_pitch + rack_hole_d + rack_hole_slot + 4, "ears too narrow for the rail holes");
assert(psu_top <= units * U - u_clear / 2, "PSU sticks out of the rack unit; reduce floor_t");
assert(panel_h - psu_top + lip_top >= 2.5, "front top bar too thin");

// Extrude a 2D shape drawn in (x, z) so it occupies y in [-t, 0].
module xz_extrude(t) {
    rotate([90, 0, 0]) linear_extrude(t) children();
}

module rounded_rect(x0, z0, x1, z1, r) {
    translate([x0 + r, z0 + r]) offset(r) square([x1 - x0 - 2 * r, z1 - z0 - 2 * r]);
}

// Map PSU-face coordinates (u from the IEC side, v up from the PSU bottom)
// into the (x, z) plane for the bay centered at cx.
module psu_face(cx) {
    translate([cx + psu_w / 2, floor_t]) mirror([1, 0]) children();
}

// Solid tab around a PSU screw hole, run out to the nearest edge that has
// panel material to hang it from.
module screw_pad(h) {
    u = h[0];
    v = h[1];
    hull() {
        translate([u, v]) circle(r = screw_pad_r);
        if (v <= 10)
            translate([u - screw_pad_r, -1]) square([2 * screw_pad_r, 1]);
        else if (v >= psu_h - 10)
            translate([u - screw_pad_r, psu_h]) square([2 * screw_pad_r, 1]);
        else
            translate([u < psu_w / 2 ? -1 : psu_w, v - screw_pad_r]) square([1, 2 * screw_pad_r]);
    }
}

// Opening in a plate in front of / behind a bay, leaving lips around the PSU
// face plus pads for any PSU screws.
module bay_cutout(cx, side, bottom, top, holes) {
    psu_face(cx) difference() {
        rounded_rect(side, bottom, psu_w - side, top, corner_r);
        if (psu_screws) {
            for (h = holes) screw_pad(h);
            // merge neighbouring pads on the same edge so there is no notch between them
            for (i = [0 : len(holes) - 2], j = [i + 1 : len(holes) - 1])
                if (abs(holes[i][0] - holes[j][0]) < 4 * screw_pad_r
                    && abs(holes[i][1] - holes[j][1]) < screw_pad_r)
                    hull() { screw_pad(holes[i]); screw_pad(holes[j]); }
        }
    }
    if (psu_screws) psu_face(cx) for (h = holes) translate(h) circle(d = psu_screw_d);
}

front_cut_top = psu_h - lip_top;
rear_cut_top = psu_screws ? min([for (h = rear_holes) h[1]]) - screw_pad_r
             : front_cut_top;

module rack_holes() {
    for (sx = [-1, 1], u = [0 : units - 1], hz = [6.35, 38.1])
        translate([sx * rail_hole_pitch / 2, u * U + hz - u_clear / 2])
            hull() for (dx = [-1, 1]) translate([dx * rack_hole_slot / 2, 0]) circle(d = rack_hole_d);
}

module front_panel() {
    difference() {
        xz_extrude(face_t) difference() {
            rounded_rect(-panel_w / 2, 0, panel_w / 2, panel_h, corner_r);
            rack_holes();
            for (sx = [-1, 1])
                bay_cutout(sx * bay_x, lip_side, lip_bottom, front_cut_top, front_holes);
        }
        if (psu_screws)
            for (sx = [-1, 1], r = iec_relief)
                translate([0, -iec_relief_t, 0]) xz_extrude(face_t) psu_face(sx * bay_x)
                    translate([r[0], r[2]]) square([r[1] - r[0], r[3] - r[2]]);
    }
}

module floor_vents() {
    slot_w = 4;
    pitch = 10;
    margin = 20;
    n = floor((bay_l - 2 * margin) / pitch);
    for (sx = [-1, 1], i = [0 : n])
        translate([sx * bay_x, margin + i * pitch, -eps])
            hull() for (dx = [-1, 1])
                translate([dx * (bay_w / 2 - 12), 0, 0]) cylinder(d = slot_w, h = floor_t + 2 * eps);
}

module body() {
    difference() {
        union() {
            front_panel();
            // floor
            translate([-body_w / 2, -eps, 0]) cube([body_w, bay_l + eps, floor_t]);
            // outer + center walls
            for (sx = [-1, 1])
                translate([sx * (body_w / 2 - outer_wall_t / 2) - outer_wall_t / 2, -eps, 0])
                    cube([outer_wall_t, bay_l + eps, wall_h]);
            translate([-center_wall_t / 2, -eps, 0]) cube([center_wall_t, bay_l + eps, wall_h]);
            // rear posts on the outside of the outer walls
            for (sx = [-1, 1])
                translate([sx * (body_w / 2 - outer_wall_t) + (sx < 0 ? -post_w : 0), bay_l - post_l, 0])
                    cube([post_w, post_l, wall_h]);
            // full-height triangular gussets tying the ears to the outer walls
            for (sx = [-1, 1])
                mirror([sx < 0 ? 1 : 0, 0, 0])
                    linear_extrude(wall_h)
                        polygon([[body_w / 2 - eps, -eps], [body_w / 2 + gusset_x, -eps], [body_w / 2 - eps, gusset_y]]);
        }
        if (vents) floor_vents();
        // heat-set insert holes in the rear of each post / the center wall
        for (x = [-post_x, 0, post_x], z = post_z)
            translate([x, bay_l + eps, z]) rotate([90, 0, 0]) cylinder(d = insert_d, h = insert_depth);
    }
}

module clamp_2d() {
    cw = body_w / 2 - outer_wall_t + post_w;
    difference() {
        rounded_rect(-cw, 0, cw, wall_h, corner_r);
        for (sx = [-1, 1])
            bay_cutout(sx * bay_x, rear_lip_side, rear_lip_bottom, rear_cut_top, rear_holes);
        for (x = [-post_x, 0, post_x], z = post_z) translate([x, z]) circle(d = screw_d);
    }
}

// Placed in its installed position behind the body.
module clamp() {
    translate([0, bay_l + clamp_t, 0]) xz_extrude(clamp_t) clamp_2d();
}

module psu_ghost() {
    for (sx = [-1, 1])
        %translate([sx * bay_x - psu_w / 2, 0, floor_t]) cube([psu_w, psu_l, psu_h]);
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
