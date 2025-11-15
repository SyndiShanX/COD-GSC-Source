/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_see2_panzeriv.csc
*****************************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_panzerIV");
  build_treadfx("see2_panzeriv");
  build_rumble("see2_panzeriv", "tank_rumble", 0.15, 4.5, 600, 1, 1);
}