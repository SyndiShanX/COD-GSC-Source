/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_tiger.csc
*****************************************************/

#include clientscripts\_vehicle;

main(model, type) {
  if(!isDefined(type)) {
    type = "tiger";
  }
  build_shoot_rumble(type, "tank_fire");
  build_shoot_shock(type, "tankblast");
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_tiger");
  build_treadfx(type);
  build_rumble(type, "tank_rumble", 0.15, 4.5, 600, 1, 1);
}