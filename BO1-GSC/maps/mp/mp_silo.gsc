/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_silo.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_silo_fx::main();
  maps\mp\createart\mp_silo_art::main();
  precachemodel("collision_wall_256x256x10");
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_silo_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_silo");
  }
  maps\mp\mp_silo_amb::main();
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = & "MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = & "MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = & "MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = & "MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = & "MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level thread crane_container();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    spawncollision("collision_wall_256x256x10", "collider", (1527, 71, 16), (0, 337, 0));
  }
}
crane_container() {
  crane_container = GetEnt("crane_container", "targetname");
  if(!isDefined(crane_container)) {
    return;
  }
  crane_container thread rotate_crane_container();
}
rotate_crane_container() {
  rotate_time = 8;
  rotate_angle = 30;
  self RotateYaw(rotate_angle / 2, rotate_time / 2);
  self waittill("rotatedone");
  while (true) {
    rotate_angle = rotate_angle * -1;
    self RotateYaw(rotate_angle, rotate_time, rotate_time / 2, rotate_time / 2);
    self waittill("rotatedone");
  }
}