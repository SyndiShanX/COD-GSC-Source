/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_80s_hatch1.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("80s_hatch1", model, type);
  build_localinit(::init_local);

  build_destructible("vehicle_80s_hatch1_brn_destructible_mp", "vehicle_80s_hatch1_brn");
  build_destructible("vehicle_80s_hatch1_green_destructible_mp", "vehicle_80s_hatch1_green");
  build_destructible("vehicle_80s_hatch1_red_destructible_mp", "vehicle_80s_hatch1_red");
  build_destructible("vehicle_80s_hatch1_silv_destructible_mp", "vehicle_80s_hatch1_silv");
  build_destructible("vehicle_80s_hatch1_tan_destructible_mp", "vehicle_80s_hatch1_tan");
  build_destructible("vehicle_80s_hatch1_yel_destructible_mp", "vehicle_80s_hatch1_yel");

  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);

  build_life(999, 500, 1500);

  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_compassicon("automobile", false);
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