/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_submarine_nuclear.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type) {
  build_template("submarine_nuclear", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_submarine_nuclear");
  build_compassicon("camera", false);
  build_life(999, 500, 1500);
  build_team("allies");
}

init_local() {}