/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_80s_wagon1.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type) {
  build_template("80s_wagon1", model, type);
  build_localinit(::init_local);
  build_destructible("vehicle_80s_wagon1_brn_destructible_mp", "vehicle_80s_wagon1_brn");
  build_destructible("vehicle_80s_wagon1_green_destructible_mp", "vehicle_80s_wagon1_green");
  build_destructible("vehicle_80s_wagon1_red_destructible_mp", "vehicle_80s_wagon1_red");
  build_destructible("vehicle_80s_wagon1_silv_destructible_mp", "vehicle_80s_wagon1_silv");
  build_destructible("vehicle_80s_wagon1_tan_destructible_mp", "vehicle_80s_wagon1_tan");
  build_destructible("vehicle_80s_wagon1_yel_destructible_mp", "vehicle_80s_wagon1_yel");

  build_compassicon("automobile", false);
  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);

  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");

  build_life(999, 500, 1500);
  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  return positions;

  return positions;
}