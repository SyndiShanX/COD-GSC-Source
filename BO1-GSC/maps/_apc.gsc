/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_apc.gsc
**************************************/

#include maps\_vehicle;

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}
#using_animtree("tank");
set_vehicle_anims(positions) {
  return positions;
}
#using_animtree("generic_human");

setanims() {
  positions = [];
  positions[0] = spawnStruct();
  positions[0].sittag = "tag_gunner4";
  positions[0].vehiclegunner = 4;
  positions[0].idle = % ai_m113_gunner_aim;
  positions[0].aimup = % ai_m113_gunner_aim_up;
  positions[0].aimdown = % ai_m113_gunner_aim_down;
  return positions;
}
unload_groups() {}