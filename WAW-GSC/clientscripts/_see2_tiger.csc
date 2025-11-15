/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_see2_tiger.csc
*****************************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_tiger");
  build_treadfx("see2_tiger");
  build_rumble("see2_tiger", "tank_rumble", 0.15, 4.5, 600, 1, 1);
}