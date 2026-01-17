/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_array.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_array_fx::main();
  precachemodel("collision_geo_10x10x512");
  precachemodel("collision_geo_64x64x64");
  precachemodel("collision_wall_64x64x10");
  precachemodel("collision_wall_512x512x10");
  precachemodel("collision_geo_64x64x256");
  precachemodel("p_glo_concrete_barrier_damaged");
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_array_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_array");
  }
  maps\mp\mp_array_amb::main();
  maps\mp\gametypes\_teamset_winterspecops::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  spawncollision("collision_geo_10x10x512", "collider", (1397, 1095, 346), (0, 0, 0));
  spawncollision("collision_geo_10x10x512", "collider", (1387, 1095, 346), (0, 0, 0));
  spawncollision("collision_geo_64x64x64", "collider", (-399, 1615, 614), (0, 15, 0));
  spawncollision("collision_wall_64x64x10", "collider", (-445, 1593, 642), (0, 150, 0));
  spawncollision("collision_wall_512x512x10", "collider", (-1682, 1046, 496), (0, 30, 0));
  spawncollision("collision_geo_64x64x64", "collider", (-387, 307, 346), (0, 360, 0));
  spawncollision("collision_geo_64x64x256", "collider", (-852, 852, 496), (0, 15, 90));
  spawncollision("collision_geo_64x64x256", "collider", (-788, 652, 492), (0, 15, 90));
  addNoTurretTrigger((-692, 3292, 500), 180, 800);
  addNoTurretTrigger((-1236, 3292, 500), 180, 800);
  kRail1 = spawn("script_model", (-824, 672, 480));
  if(isDefined(kRail1)) {
    kRail1.angles = (0, 105, 0);
    kRail1 setModel("p_glo_concrete_barrier_damaged");
  }
  kRail2 = spawn("script_model", (-804, 600, 468));
  if(isDefined(kRail2)) {
    kRail2.angles = (15, 285, 0);
    kRail2 setModel("p_glo_concrete_barrier_damaged");
  }
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  radar_move_init();
}
radar_move_init() {
  level endon("game_ended");
  dish_top = GetEnt("dish_top", "targetname");
  dish_base = GetEnt("dish_base", "targetname");
  dish_inside = GetEnt("dish_inside", "targetname");
  dish_gears = getEntArray("dish_gear", "targetname");
  total_time_for_rotation_outside = 240;
  total_time_for_rotation_inside = 60;
  dish_top LinkTo(dish_base);
  dish_base thread rotate_dish_top(total_time_for_rotation_outside);
  dish_inside thread rotate_dish_top(total_time_for_rotation_inside);
  if(dish_gears.size > 0) {
    array_thread(dish_gears, ::rotate_dish_gears, total_time_for_rotation_inside);
  }
}
rotate_dish_top(time) {
  self endon("game_ended");
  while(1) {
    self RotateYaw(360, time);
    self waittill("rotatedone");
  }
}
rotate_dish_gears(time) {
  self endon("game_ended");
  gear_ratio = 5.0 / 60.0;
  inverse_gear_ratio = 1.0 / gear_ratio;
  while(1) {
    self RotateYaw(360 * inverse_gear_ratio, time);
    self waittill("rotatedone");
  }
}
addNoTurretTrigger(position, radius, height) {
  while(!isDefined(level.noTurretPlacementTriggers))
    wait(0.1);
  trigger = spawn("trigger_radius", position, 0, radius, height);
  level.noTurretPlacementTriggers[level.noTurretPlacementTriggers.size] = trigger;
}