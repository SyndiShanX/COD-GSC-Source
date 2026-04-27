/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_submarine_sdv.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type) {
  build_template("submarine_sdv", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_submarine_sdv");
  build_compassicon("camera", false);
  build_life(999, 500, 1500);
  build_rumble("tank_rumble", 0.05, 1.5, 900, 1, 1);
  build_team("allies");
}

init_local() {}