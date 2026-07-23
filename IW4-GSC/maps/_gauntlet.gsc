/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_gauntlet.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("gauntlet", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_sa15_gauntlet", "vehicle_sa15_gauntlet_destroy");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "exp_armor_vehicle");
  build_treadfx();
  build_life(999, 500, 1500);
  build_team("axis");
  build_idle(%sa15_turret_scanloop);
  build_idle(%sa15_radar_spinloop);

  build_bulletshield(true);
  build_grenadeshield(true);
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 11; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].getout_delete = true;
  return positions;
}