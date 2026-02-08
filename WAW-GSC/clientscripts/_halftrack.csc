/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_halftrack.csc
****************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_halftrack", true);
  build_treadfx("halftrack");
  build_rumble("halftrack", "tank_rumble", 0.15, 4.5, 600, 1, 1);
}