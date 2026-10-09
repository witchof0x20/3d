// 3U 10" rack insert for eight 3.5" drives standing on edge, sized for racks
// with a narrow opening between the posts (DeskPi RackMate T2: 212 mm).
//
// There is no box: eight drives side by side need the whole opening, so
// there is no room for side walls. A bottom and a top plate bolt to the front
// posts by ears, and the drives ride between them in caddies whose arms run
// in grooves cut into the plates. The top plate is the bottom plate turned
// over, so the plate prints twice.
//
// Behind the drives a cross beam stops the caddies. One backplane bar per
// drive screws to the beams (M3 into heat-set inserts) and carries a SATA
// 22-pin male/female pass-through adapter by its ears. A fan panel slides
// into the same grooves from the back and screws to both plates, tying them
// together at the rear. The whole insert - plates, drives, backplane, fans -
// comes out the front in one piece.
//
// At the rear, four small braces bolt to the rear posts. Each has a bar that
// slides into a socket in a plate's rear corner as the insert goes in, so
// the rear needs no screws and the socket length takes up rack depth
// tolerance. The braces are optional on paper, but without them the insert
// hangs off the narrow joint between the ears and the plates, and the parts
// are small enough to reprint for another rack.
//
// Caddies are a handle with an arm above and below the drive; four
// countersunk 6-32 screws go through the arms into the drive's side holes
// (SFF-8301). The caddy prints lying on the side the drive's PCB faces, so
// its layers run along the arms; the tongues are chamfered on that side to
// print without support.
//
// Coordinates: x across the rack (centered), y front to back (y = 0 is the
// front face of the front posts), z up (z = 0 is the bottom of the 3U slot).
// Drives stand on edge with their PCB side facing +x.

/* [Output] */
part = "assembly"; // [assembly, plate, caddy, pull, backplane, fan_panel, brace_left, brace_right, test_ear]

/* [Rack - measure yours] */
opening_w = 212;            // clear width between the posts
rack_depth = 250;           // front face of the front posts to rear face of the rear posts
post_t = 3;                 // rear post flange thickness, front to back (ghost only)
units = 3;
panel_w = 250;              // 254 is nominal; 250 fits a 256 mm bed
rail_hole_pitch = 236.525;  // 10" rack rail hole center-to-center
rack_hole_d = 6.6;          // M6 clearance
rack_hole_slot = 1.5;       // extra horizontal travel in the ear holes
hole_z = [6.35, 22.225, 38.1]; // hole heights within each U (EIA-310)
u_clear = 0.8;              // total vertical gap to neighbouring gear

/* [Drive - SFF-8301 / SFF-8323] */
drive_w = 101.6;
drive_t = 26.1;             // max thickness
drive_l = 147;
side_holes = [28.5, 130.1]; // side screw holes, from the connector end
side_hole_z = 6.35;         // side screw holes, from the PCB face
conn_from_edge = 13.43;     // connector start, from the drive's datum-Y edge
conn_len = 42.73;
conn_from_pcb = 3.5;        // connector centerline, from the PCB face
conn_edge_up = true;        // datum-Y edge faces up with the PCB facing +x; flip if the backplane lands upside down

/* [SATA adapter - guessed from a photo] */
adapter_ear_pitch = 40;     // ear hole center-to-center (measured)
adapter_len = 50;           // overall length including ears
adapter_t = 7;              // body thickness
adapter_d = 20;             // mating direction, female face to male tip
adapter_ear_y = 8;          // ear holes, from the female face
adapter_screw_pilot = 2.5;  // M3 self-tapping into the bar; 4.0 for heat-sets
mate_gap = 0.3;             // drive's rear face to the adapter's female face

/* [Cage] */
plate_t = 12;
groove_w = 6.5;
groove_taper = 2;           // the caddy grooves are this much wider at the front, narrowing to groove_w at the beam
tongue_clr = 0.25;          // per side, between the caddy's (tapered) tongue and its groove
groove_d = 4.5;
tongue_w = 6;
tongue_d = 4;
side_clr = 0.3;             // plate edge to the post's inner edge
ear_t = 5;
ear_h = 58;                 // bottom plate ears cover U1 and the lowest hole of U2
arm_t = 3;
arm_x = [9, 25.8];          // arm span across the drive's thickness, from its -x face; the +x end is the print bed
handle_d = 8;
handle_clr = 0.3;           // extra gap above and below the handle, on top of the arms'
handle_chamfer = 0.8;       // around the handle's front face, as a lead-in
beam_h = 9;
beam_d = 8;
cable_room = 35;            // behind the adapters, in front of the fans

/* [Caddy] */
drive_clr = 0.4;            // between the arms, on top of the drive's height
screw_d = 3.6;              // 6-32 clearance
screw_head = "pan";         // [pan, countersunk]
csk_d = 7.0;                // 6-32 flat head is 6.6 across
csk_angle = 82;
pan_head_d = 7.0;           // measure yours; counterbored 0.4 wider
pan_head_h = 1.8;           // a standard 6-32 pan head (~2.3) is too tall for 3 mm arms; button/wafer heads fit
csk_recess = 0.3;           // head sits this far below the arm face
min_floor = 0.8;            // plastic left under a pan head

/* [Caddy handle mount] */
handle_mount = true;        // two M3 heat-sets in each handle's front face for a pull or knobs
mount_spacing = 64;         // center-to-center; 64 mm is a standard cabinet-pull spacing
pull_reach = 22;            // finger room between the pull's bar and the handle
pull_bar_t = 8;             // pull bar thickness, front to back
pull_w = 11;                // pull width; posts and bar
pull_screw_l = 10;          // M3 screw length; the post's counterbore stops so it bites heatset_l - 0.5

/* [Backplane bar] */
bar_wall = 5;
foot_d = 8;

/* [Fans] */
fan_size = 92;
fan_hole_pitch = 82.5;
fan_t = 25;
fan_gap = 14;               // between the two fans, for the cable slot
fan_panel_t = 3;
fan_slots = [1, 6];         // grooves the fan panel's tongues ride in

/* [Rear braces] */
socket_x = [93, 104.2];     // |x| span of the socket in the plate's rear corner
socket_h = 6;
socket_l = 35;
brace_engage = 20;          // nominal bar length inside the socket
brace_clr = 0.3;
brace_ear_h = 40;

/* [Fasteners] */
m3_clear = 3.4;
m3_head_d = 6.5;
heatset_d = 4.0;
heatset_l = 5;

/* [Hidden] */
$fn = 40;
eps = 0.01;
U = 44.45;
n = 8;

H = units * U - u_clear;
cage_w = opening_w - 2 * side_clr;
pitch = (cage_w - drive_t) / (n - 1);
inner_h = H - 2 * plate_t;

y_front = -ear_t;
drive_y0 = y_front + handle_d;
drive_y1 = drive_y0 + drive_l;
beam_y0 = drive_y1;
beam_y1 = beam_y0 + beam_d;
foot_y = [beam_y1 + 0.2, beam_y1 + 0.2 + foot_d];
ad_y0 = drive_y1 + mate_gap;
y_end = ad_y0 + adapter_d + cable_room + fan_t;  // rear end of the plates

drive_z0 = plate_t + arm_t;
drive_z1 = drive_z0 + drive_w;
arm_top_z = drive_z1 + drive_clr;              // top arm's inner face
handle_mid = (plate_t + arm_top_z + arm_t) / 2;
mount_zs = [handle_mid - mount_spacing / 2, handle_mid + mount_spacing / 2];

ad_dx = drive_t - conn_from_pcb - adapter_t / 2;  // adapter's -x face, from the slot's -x edge
bar_dx = drive_t / 2;                            // bar's screw line: the slot center, so the plate
                                                 // does not depend on the adapter, and the turned-over
                                                 // top plate uses the same holes
conn_zc = conn_edge_up ? drive_z1 - conn_from_edge - conn_len / 2
                       : drive_z0 + conn_from_edge + conn_len / 2;

function x0(i) = -cage_w / 2 + i * pitch;        // slot's -x edge (the drive's -x face)
function sc(i) = x0(i) + drive_t / 2;            // slot center
function bnd(i) = sc(i) + pitch / 2;             // between slot i and i + 1
// Half-width of a caddy groove at depth y: groove_taper wider at the front
// face, narrowing linearly to groove_w at the beam.
function groove_half(y) = groove_w / 2 + groove_taper / 2 * (beam_y0 - y) / (beam_y0 - y_front);
function rack_hole_zs() = [for (u = [0 : units - 1], hz = hole_z) u * U + hz - u_clear / 2];

fan_x = [bnd(0), bnd(6)];
fan_cx = [-(fan_size + fan_gap) / 2, (fan_size + fan_gap) / 2];
socket_z = [plate_t / 2 - socket_h / 2, plate_t / 2 + socket_h / 2];

assert(pitch >= drive_t + 0.2, str("drives do not fit: pitch ", pitch, " for ", drive_t, " mm drives; widen opening_w"));
assert(drive_w + drive_clr + 2 * arm_t + 0.3 <= inner_h, "caddy taller than the gap between the plates; thin plate_t or arm_t");
assert(tongue_d + 0.3 <= groove_d, "tongue bottoms out in the groove");
assert(arm_x[0] <= drive_t / 2 - tongue_w / 2 && arm_x[1] >= drive_t - side_hole_z + head_d / 2,
       "arm does not cover the tongue and the screw heads");
assert(arm_x[0] <= drive_t / 2 - tongue_half(y_front) && arm_x[1] >= drive_t / 2 + tongue_half(y_front),
       "arm narrower than the front of the caddy tongue");
assert(!handle_mount || (mount_zs[0] - heatset_d / 2 > plate_t + handle_clr + handle_chamfer + 2
                         && mount_zs[0] + heatset_d / 2 < handle_mid - 17 - 2),
       "handle mount points run into the finger pocket or the handle's edge; change mount_spacing");
assert(!handle_mount || heatset_l + 2 <= handle_d, "handle too shallow for the mount heat-sets");
assert(arm_x[1] == drive_t - 0.3, "arm_x[1] must be flush with the handle's +x face, which the caddy prints on");
assert(2 * tongue_half(beam_y0) - tongue_d - 0.5 >= 1.2, "chamfered tongue tip too thin; reduce tongue_d");
assert(screw_head != "countersunk" || (csk_d - screw_d) / 2 / tan(csk_angle / 2) + csk_recess < arm_t - 0.5,
       "countersink too deep for arm_t");
assert(screw_head != "pan" || arm_t - pan_head_h - csk_recess >= min_floor,
       str("pan heads need arm_t >= ", pan_head_h + csk_recess + min_floor,
           "; there is no height for thicker arms without thinner plates (plate_t), so use lower heads or countersunk screws"));
assert(bar_dx + m3_head_d / 2 + 0.5 <= ad_dx, "adapter too thick: the bar's wall would cover its screw head");
assert(conn_zc - adapter_len / 2 > plate_t + beam_h + 1 && conn_zc + adapter_len / 2 < H - plate_t - beam_h - 1,
       "adapter collides with a beam");
assert(y_end - y_front <= 256 && panel_w <= 256, "plate does not fit a 256 mm bed");
assert(2 * (fan_size / 2 + abs(fan_cx[0])) <= cage_w, "fans wider than the cage");
assert(fan_size <= inner_h, "fans taller than the gap between the plates");
assert(y_end - socket_l > foot_y[1] + 2, "brace sockets run into the backplane feet");
for (i = [0, n - 1]) assert(abs(sc(i)) + groove_w / 2 < socket_x[0] - 1 || y_end - socket_l > foot_y[1] + 2);
assert(socket_x[1] < cage_w / 2 - 1, "socket breaks out of the plate edge");
assert(rack_depth - (y_end - brace_engage) > 0, "rack shallower than the insert");

// ---------------------------------------------------------------- helpers

module box(x0, x1, y0, y1, z0, z1) {
    translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
}

// Hole along +y from y0 to y1 at (x, z), with a teardrop tip toward +z so it
// prints without support when the part lies flat.
module hole_y(d, x, z, y0, y1) {
    translate([x, y1, z]) rotate([90, 0, 0]) linear_extrude(y1 - y0)
        hull() { circle(d = d); rotate(45) square(d / 2); }
}

module rack_hole_y(x, z, y0, y1) {
    hull() for (dx = [-1, 1]) hole_y(rack_hole_d, x + dx * rack_hole_slot / 2, z, y0, y1);
}

// ---------------------------------------------------------------- plate

module plate() {
    difference() {
        union() {
            box(-cage_w / 2, cage_w / 2, y_front, y_end, 0, plate_t);
            for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0])
                box(cage_w / 2 - eps, panel_w / 2, y_front, 0, 0, ear_h);
            box(-cage_w / 2, cage_w / 2, beam_y0, beam_y1, plate_t - eps, plate_t + beam_h);
        }
        for (i = [0 : n - 1]) {
            // caddy groove, tapering from the front so the caddy goes in loose
            // and centers itself as it seats
            translate([sc(i), 0, plate_t - groove_d]) linear_extrude(groove_d + eps)
                polygon([[-groove_half(y_front - eps), y_front - eps], [-groove_half(beam_y0), beam_y0],
                         [groove_half(beam_y0), beam_y0], [groove_half(y_front - eps), y_front - eps]]);
            // backplane bar groove behind the beam; the fan panel's run to the end
            box(sc(i) - groove_w / 2, sc(i) + groove_w / 2, beam_y1,
                len([for (s = fan_slots) if (s == i) s]) > 0 ? y_end + eps : foot_y[1] + 2,
                plate_t - groove_d, plate_t + eps);
        }
        // rack holes; the top plate's are these turned over
        for (sx = [-1, 1], z = rack_hole_zs()) if (z < ear_h - rack_hole_d / 2 - 2)
            rack_hole_y(sx * rail_hole_pitch / 2, z, y_front - eps, eps);
        // heat-sets for the backplane bars
        for (i = [0 : n - 1], x = [x0(i) + bar_dx])
            translate([x, beam_y1 + eps, plate_t + beam_h / 2]) rotate([90, 0, 0]) cylinder(d = heatset_d, h = heatset_l);
        // heat-sets for the fan panel in the rear end face
        for (x = fan_x)
            translate([x, y_end + eps, plate_t / 2]) rotate([90, 0, 0]) cylinder(d = heatset_d, h = heatset_l);
        // sockets for the rear braces, with a lead-in
        for (s = [-1, 1]) mirror([s < 0 ? 1 : 0, 0, 0]) hull() {
            box(socket_x[0], socket_x[1], y_end - socket_l, y_end - 1, socket_z[0], socket_z[1]);
            box(socket_x[0] - 1, socket_x[1] + 1, y_end - eps, y_end + eps, socket_z[0] - 1, socket_z[1] + 1);
        }
    }
}

// The top plate is the bottom plate turned over about the y axis.
module top() {
    translate([0, 0, H]) rotate([0, 180, 0]) children();
}

// ---------------------------------------------------------------- caddy

// Built for slot 0; x is relative to the slot's -x edge.
screw_x = drive_t - side_hole_z;
head_d = screw_head == "pan" ? pan_head_d + 0.4 : csk_d;
screw_ys = [for (s = side_holes) drive_y1 - s];
tongue_x = [drive_t / 2 - tongue_w / 2, drive_t / 2 + tongue_w / 2];  // straight tongues (backplane bar)
function tongue_half(y) = groove_half(y) - tongue_clr;               // the caddy's tapered tongue

// 6-32 hole through an arm whose outer face is at z, pointing into the arm
// along +z (`up`) or -z: countersunk, or counterbored for a pan head. Either
// way the head ends up below the arm face, since the arms ride on the plates.
module screw_hole(z, up) {
    cone_h = (csk_d - screw_d) / 2 / tan(csk_angle / 2);
    translate([screw_x, 0, z]) mirror([0, 0, up ? 0 : 1]) {
        translate([0, 0, -eps]) cylinder(d = screw_d, h = arm_t + 2 * eps);
        if (screw_head == "pan") {
            translate([0, 0, -eps]) cylinder(d = pan_head_d + 0.4, h = eps + pan_head_h + csk_recess);
        } else {
            translate([0, 0, -eps]) cylinder(d = csk_d, h = eps + csk_recess);
            translate([0, 0, csk_recess - eps]) cylinder(d1 = csk_d, d2 = screw_d, h = cone_h);
        }
    }
}

// One piece: the handle and both arms. The drive slides in from the side
// and four countersunk 6-32 screws go through the arms into its side holes;
// the heads sit below the arm faces because the arms ride on the plates.
module caddy() {
    mid = handle_mid;
    difference() {
        union() {
            // handle, a little shorter than the arms and chamfered round its
            // front face so it eases in between the plates
            hull() {
                hz = [plate_t + handle_clr, arm_top_z + arm_t - handle_clr];
                box(0.3 + handle_chamfer, drive_t - 0.3 - handle_chamfer, y_front, y_front + eps, hz[0] + handle_chamfer, hz[1] - handle_chamfer);
                box(0.3, drive_t - 0.3, y_front + handle_chamfer, drive_y0, hz[0], hz[1]);
            }
            for (t = [false, true])
                translate([0, 0, t ? arm_top_z + arm_t + plate_t : 0]) mirror([0, 0, t ? 1 : 0]) {
                    box(arm_x[0], arm_x[1], drive_y0 - eps, drive_y1, plate_t, drive_z0);
                    // tapered tongue; its +x side (the print bed side) is chamfered
                    // at 45 degrees so it is not a ledge with nothing under it
                    hull() for (y = [y_front + 0.5, drive_y1 - 0.5]) {
                        h = tongue_half(y);
                        box(drive_t / 2 - h, drive_t / 2 + h, y, y + eps, plate_t - eps, plate_t + handle_clr + eps);
                        box(drive_t / 2 - h + 0.5, drive_t / 2 + h - tongue_d, y, y + eps, plate_t - tongue_d, plate_t - tongue_d + eps);
                    }
                }
        }
        for (y = screw_ys) translate([0, y, 0]) {
            screw_hole(plate_t, true);
            screw_hole(arm_top_z + arm_t, false);
        }
        // finger pull: a pocket with an undercut to hook a fingertip into
        box(4, drive_t - 4, y_front - eps, y_front + 5, mid - 11, mid + 11);
        box(4, drive_t - 4, y_front + 2.5, y_front + 5, mid - 11, mid + 17);
        // vents, skipping the ones the mount heat-sets would break into
        for (z = [plate_t + 8 : 7 : mid - 16], z2 = [z, 2 * mid - z])
            if (!handle_mount || min([for (m = mount_zs) abs(z2 - m)]) > heatset_d / 2 + 1.5 + 2)
                box(4, drive_t - 4, y_front - eps, drive_y0 + eps, z2 - 1.5, z2 + 1.5);
        // heat-sets for a pull or knobs
        if (handle_mount) for (z = mount_zs)
            translate([drive_t / 2, y_front - eps, z]) rotate([-90, 0, 0]) cylinder(d = heatset_d, h = heatset_l + eps);
    }
}

// D-shaped pull for a caddy, built in place in front of slot 0's handle. M3
// screws drop through counterbores in the bar and posts into the handle's
// heat-sets.
module pull() {
    assert(pull_screw_l - (heatset_l - 0.5) >= 3, "pull_screw_l too short to leave a post floor under the head");
    bar_y = [y_front - pull_reach - pull_bar_t, y_front - pull_reach];
    floor_t = pull_screw_l - (heatset_l - 0.5);   // post material the screw head bears on
    difference() {
        union() {
            for (z = mount_zs)
                translate([drive_t / 2, bar_y[1] - eps, z]) rotate([-90, 0, 0]) cylinder(d = pull_w, h = pull_reach + eps);
            // bar, rounded at its ends
            hull() for (z = mount_zs)
                translate([drive_t / 2, bar_y[0], z]) rotate([-90, 0, 0]) cylinder(d = pull_w, h = pull_bar_t);
        }
        for (z = mount_zs) {
            translate([drive_t / 2, bar_y[0] - eps, z]) rotate([-90, 0, 0]) cylinder(d = m3_clear, h = y_front - bar_y[0] + 2 * eps);
            translate([drive_t / 2, bar_y[0] - eps, z]) rotate([-90, 0, 0]) cylinder(d = m3_head_d + 0.3, h = y_front - floor_t - bar_y[0] + eps);
        }
    }
}

// ---------------------------------------------------------------- backplane

// One per drive, built for slot 0. The adapter's ears lie flat on the wall's
// +x face; M3 screws go through the ears into the wall. The feet screw into
// heat-sets in the rear faces of the two beams.
module backplane() {
    ax = ad_dx;
    wx = [ax - bar_wall, ax];
    fx = [tongue_x[0] - 1.5, ax];
    difference() {
        union() {
            box(wx[0], wx[1], ad_y0, foot_y[1], plate_t + beam_h + 0.3, H - plate_t - beam_h - 0.3);
            for (t = [false, true])
                translate([0, 0, t ? H : 0]) mirror([0, 0, t ? 1 : 0]) {
                    box(fx[0], fx[1], foot_y[0], foot_y[1], plate_t + 0.2, plate_t + beam_h + 0.3 + eps);
                    box(wx[0], wx[1], foot_y[0], foot_y[1], plate_t + 0.2, plate_t + beam_h + 1);
                    // tongue, chamfered on its +x side so it prints lying on that side
                    hull() {
                        box(tongue_x[0], tongue_x[1], foot_y[0] + 0.5, foot_y[1], plate_t - 1, plate_t + 0.2 + eps);
                        box(tongue_x[0], tongue_x[1] - (tongue_d - 1), foot_y[0] + 0.5, foot_y[1], plate_t - tongue_d, plate_t - 1);
                    }
                }
        }
        for (z = [plate_t + beam_h / 2, H - plate_t - beam_h / 2]) {
            translate([bar_dx, foot_y[0] - eps, z]) rotate([-90, 0, 0]) cylinder(d = m3_clear, h = foot_d + 1);
            translate([bar_dx, foot_y[1] - 3, z]) rotate([-90, 0, 0]) cylinder(d = m3_head_d, h = foot_d);
        }
        for (dz = [-1, 1])
            translate([wx[0] - eps, ad_y0 + adapter_ear_y, conn_zc + dz * adapter_ear_pitch / 2])
                rotate([0, 90, 0]) cylinder(d = adapter_screw_pilot, h = bar_wall + 2 * eps);
    }
}

// ---------------------------------------------------------------- fans

// Two fans pulling air back past the drives. The panel sits behind the
// plates' rear ends, its tongues ride in two grooves, and tabs screw into
// heat-sets in both plates' end faces.
module fan_panel() {
    py = [y_end + 0.2, y_end + 0.2 + fan_panel_t];
    difference() {
        union() {
            box(-cage_w / 2 + 0.3, cage_w / 2 - 0.3, py[0], py[1], plate_t + 0.3, H - plate_t - 0.3);
            for (t = [false, true])
                translate([0, 0, t ? H : 0]) mirror([0, 0, t ? 1 : 0]) {
                    // tongues, each standing on a tab so they print without support
                    for (i = fan_slots) {
                        box(sc(i) - tongue_w / 2, sc(i) + tongue_w / 2, py[0] - fan_t, py[0] + eps, plate_t - tongue_d, plate_t + 4);
                        box(sc(i) - tongue_w / 2 - 1, sc(i) + tongue_w / 2 + 1, py[0], py[1], 0.5, plate_t + 0.3 + eps);
                    }
                    for (x = fan_x)
                        box(x - 6, x + 6, py[0], py[1], 0.5, plate_t + 0.3 + eps);
                }
        }
        for (cx = fan_cx) {
            translate([cx, py[0] - eps, H / 2]) rotate([-90, 0, 0]) cylinder(d = fan_size - 4, h = fan_panel_t + 2 * eps, $fn = 96);
            for (dx = [-1, 1], dz = [-1, 1])
                translate([cx + dx * fan_hole_pitch / 2, py[0] - eps, H / 2 + dz * fan_hole_pitch / 2])
                    rotate([-90, 0, 0]) cylinder(d = 4.4, h = fan_panel_t + 2 * eps);
        }
        // pass-through for the SATA and power cables
        box(-fan_gap / 2 + 2, fan_gap / 2 - 2, py[0] - eps, py[1] + eps, plate_t + 10, H - plate_t - 10);
        for (x = fan_x, z = [plate_t / 2, H - plate_t / 2])
            translate([x, py[0] - eps, z]) rotate([-90, 0, 0]) cylinder(d = m3_clear, h = fan_panel_t + 2 * eps);
    }
    // finger guards across the fan openings
    intersection() {
        for (cx = fan_cx) translate([cx, py[0], H / 2]) rotate([-90, 0, 0]) cylinder(d = fan_size - 4, h = fan_panel_t, $fn = 96);
        union() for (cx = fan_cx, a = [45, -45], k = [-4 : 4])
            translate([cx, (py[0] + py[1]) / 2, H / 2]) rotate([0, a, 0]) translate([k * 11, 0, 0])
                cube([1.6, fan_panel_t, fan_size], center = true);
    }
}

// ---------------------------------------------------------------- rear braces

// Bottom right (+x) brace, bolted to the back of the rear post. The bottom
// left one is its mirror image; the two top braces are the bottom ones
// turned over (top right = bottom left turned over, and so on).
module brace() {
    bx = [socket_x[0] + brace_clr, socket_x[1] - brace_clr];
    bz = [socket_z[0] + brace_clr, socket_z[1] - brace_clr];
    difference() {
        union() {
            // bar, with a chamfered nose
            hull() {
                box(bx[0], bx[1], y_end - brace_engage + 1, rack_depth + eps, bz[0], bz[1]);
                box(bx[0] + 1, bx[1] - 1, y_end - brace_engage, rack_depth + eps, bz[0] + 1, bz[1] - 1);
            }
            // ear behind the rear post; inside the opening it stays as low as
            // the plate so it does not shade the fans
            box(bx[0], panel_w / 2, rack_depth, rack_depth + ear_t, 0, plate_t);
            box(opening_w / 2 - 2, panel_w / 2, rack_depth, rack_depth + ear_t, 0, brace_ear_h);
        }
        for (z = rack_hole_zs()) if (z < brace_ear_h - rack_hole_d / 2 - 2)
            rack_hole_y(rail_hole_pitch / 2, z, rack_depth - eps, rack_depth + ear_t + eps);
    }
}

// ---------------------------------------------------------------- ghosts

module drive_ghost(i) {
    %translate([x0(i), drive_y0, drive_z0]) cube([drive_t, drive_l, drive_w]);
    %translate([x0(i) + ad_dx, ad_y0, conn_zc - adapter_len / 2 + 3]) cube([adapter_t, adapter_d, adapter_len - 6]);
}

module rack_ghost() {
    for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0]) {
        %box(opening_w / 2, panel_w / 2 + 2, 0, 3, -10, H + 10);
        %box(opening_w / 2, panel_w / 2 + 2, rack_depth - post_t, rack_depth, -10, H + 10);
    }
}

module fan_ghost() {
    for (cx = fan_cx) %translate([cx - fan_size / 2, y_end + 0.2 - fan_t, H / 2 - fan_size / 2]) cube([fan_size, fan_t, fan_size]);
}

// ---------------------------------------------------------------- output

module at_slot(i) {
    translate([x0(i), 0, 0]) children();
}

if (part == "plate") {
    plate();
} else if (part == "pull") {
    // standing on the bar's front face
    translate([0, 0, -(y_front - pull_reach - pull_bar_t)]) rotate([90, 0, 0]) pull();
} else if (part == "caddy") {
    // lying on the side the drive's PCB faces
    translate([0, 0, arm_x[1]]) rotate([0, 90, 0]) caddy();
} else if (part == "backplane") {
    // lying on the face the adapter mounts to
    translate([0, 0, ad_dx]) rotate([0, 90, 0]) backplane();
} else if (part == "fan_panel") {
    translate([0, 0, y_end + 0.2 + fan_panel_t]) rotate([-90, 0, 0]) fan_panel();
} else if (part == "brace_right") {
    // standing on the ear's rear face
    translate([0, 0, rack_depth + ear_t]) rotate([-90, 0, 0]) brace();
} else if (part == "brace_left") {
    translate([0, 0, rack_depth + ear_t]) rotate([-90, 0, 0]) mirror([1, 0, 0]) brace();
} else if (part == "test_ear") {
    // the front 15 mm of the plate: checks the opening, ears and grooves
    intersection() {
        plate();
        box(-panel_w, panel_w, y_front - 1, 15, -1, ear_h + 1);
    }
} else if (part == "assembly") {
    color("steelblue") { plate(); top() plate(); }
    for (i = [0 : n - 1]) at_slot(i) {
        color("orange") caddy();
        if (handle_mount) color("dimgray") pull();
        color("tomato") backplane();
    }
    for (i = [0 : n - 1]) drive_ghost(i);
    color("slategray") fan_panel();
    fan_ghost();
    color("darkkhaki") for (m = [0, 1]) mirror([m, 0, 0]) { brace(); top() brace(); }
    rack_ghost();
}
