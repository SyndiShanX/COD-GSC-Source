/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_motorcycle.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type) {
  build_template("motorcycle", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_motorcycle_01", "vehicle_motorcycle_01");
  build_deathmodel("vehicle_motorcycle_02", "vehicle_motorcycle_02");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");

  build_treadfx();
  build_life(999, 500, 1500);
  build_team("axis");
  build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];

  for(i = 0; i < 1; i++) {
    positions[i] = spawnStruct();
  }
  positions[0].sittag = "tag_body";
  positions[0].idle = % motorcycle_rider_pose_f;

  return positions;
}