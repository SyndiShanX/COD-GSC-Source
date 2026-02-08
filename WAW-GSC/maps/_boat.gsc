/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_boat.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include common_scripts\utility;

main(model, type) {
  build_template("jap_gunboat", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_jap_ship_gunboat", "vehicle_jap_ship_gunboat");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(99999, 5000, 15000);
  build_treadfx();

  if(model == "vehicle_jap_ship_gunboat") {
    build_team("axis");
  } else {
    build_team("allies");
  }
}
init_local() {}