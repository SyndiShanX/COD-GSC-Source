/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_see2_t34.csc
*****************************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_t34");
  build_treadfx("see2_t34");
  build_rumble("see2_t34", "tank_rumble", 0.15, 4.5, 600, 1, 1);
  build_gear("see2_t34", "vehicle_rus_tracked_t34_setb_body", "tag_body");
  build_gear("see2_t34", "vehicle_rus_tracked_t34_setb_turret", "tag_turret");
  build_gear("see2_t34", "vehicle_rus_tracked_t34_setc_body", "tag_body");
  build_gear("see2_t34", "vehicle_rus_tracked_t34_setc_turret", "tag_turret");
}