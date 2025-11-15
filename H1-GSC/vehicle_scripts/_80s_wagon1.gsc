/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_80s_wagon1.gsc
*******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("80s_wagon1", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_brn_destructible", "vehicle_80s_wagon1_brn");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_green_destructible", "vehicle_80s_wagon1_green");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_red_destructible", "vehicle_80s_wagon1_red");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_silv_destructible", "vehicle_80s_wagon1_silv");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_tan_destructible", "vehicle_80s_wagon1_tan");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_yel_destructible", "vehicle_80s_wagon1_yel");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_brn_destructible", "vehicle_80s_wagon1_decayed_brn");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_green_destructible", "vehicle_80s_wagon1_decayed_green");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_red_destructible", "vehicle_80s_wagon1_decayed_red");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_silv_destructible", "vehicle_80s_wagon1_decayed_silv");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_white_destructible", "vehicle_80s_wagon1_decayed_white");
  maps\_vehicle::build_destructible("vehicle_80s_wagon1_decayed_yel_destructible", "vehicle_80s_wagon1_decayed_yel");
  maps\_vehicle::build_drive( % technical_driving_idle_forward, % technical_driving_idle_backward, 10);
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];
  return var_0;
  return var_0;
}