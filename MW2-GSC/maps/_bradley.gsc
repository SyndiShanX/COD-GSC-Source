/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_bradley.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("bradley", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_bradley", "vehicle_bradley");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "exp_armor_vehicle");
  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_mainturret();
  build_compassicon("tank");
  build_frontarmor(.33);
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 11; i++)
    positions[i] = spawnStruct();

  positions[0].getout_delete = true;
  return positions;
}