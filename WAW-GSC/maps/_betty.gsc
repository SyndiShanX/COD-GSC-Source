/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_betty.gsc
*****************************************************/

#include maps\_vehicle;
#include common_scripts\utility;

main(model, type) {
  build_template("betty", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_jap_airplane_betty_static", "vehicle_jap_airplane_betty_static");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(99999, 5000, 15000);
  build_team("allies");
}

init_local() {}