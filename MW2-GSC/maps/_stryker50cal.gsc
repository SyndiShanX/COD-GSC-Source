/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stryker50cal.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("stryker50cal", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_stryker_config2", "vehicle_stryker_config2_destroyed");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "exp_armor_vehicle");
  build_drive(%stryker_movement, %stryker_movement_backwards, 10);

  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_mainturret();
  build_compassicon("tank");
  build_frontarmor(.33);
  build_rumble("stryker_rumble", 0.15, 4.5, 900, 1, 1);
}

init_local() {}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 11; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].getout_delete = true;
  return positions;
}