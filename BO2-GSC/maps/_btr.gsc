/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_btr.gsc
**************************************/

#include maps\_vehicle;

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 4; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_gunner1";
  positions[1].sittag = "tag_driver";
  positions[2].sittag = "tag_passenger";
  positions[0].idle = % ai_50cal_gunner_aim;
  positions[1].idle = % crew_uaz_driver_idle;
  positions[2].idle = % crew_uaz_passenger1_idle;
  positions[0].vehiclegunner = 1;
  positions[0].aimup = % ai_50cal_gunner_aim_up;
  positions[0].aimdown = % ai_50cal_gunner_aim_down;
  return positions;
}