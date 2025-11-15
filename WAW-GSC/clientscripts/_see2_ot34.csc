/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_see2_ot34.csc
*****************************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_t34");
  build_treadfx("see2_ot34");
  build_gear("see2_ot34", "vehicle_rus_tracked_t34_seta_body", "tag_body");
  build_gear("see2_ot34", "vehicle_rus_tracked_t34_seta_turret", "tag_turret");
}