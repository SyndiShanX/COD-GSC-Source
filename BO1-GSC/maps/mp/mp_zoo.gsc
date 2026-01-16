/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zoo.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_zoo_fx::main();
  precachemodel("collision_wall_256x256x10");
  precachemodel("collision_geo_32x32x128");
  precachemodel("collision_geo_128x128x10");
  precachemodel("collision_geo_64x64x64");
  maps\mp\_load::main();
  maps\mp\mp_zoo_amb::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_zoo_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_zoo");
  }
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
  gate1 = Spawn("script_model", (1040, 1495, 56));
  if(isDefined(gate1)) {
    gate1.angles = (0, 270, 0);
    gate1 SetModel("p_zoo_bend_gate_mid");
  }
  gate2 = Spawn("script_model", (1104, 1495, 56));
  if(isDefined(gate2)) {
    gate2.angles = (0, 270, 0);
    gate2 SetModel("p_zoo_bend_gate_mid");
  }
  spawncollision("collision_wall_256x256x10", "collider", (876, 2034, 169), (0, 90, 0));
  spawncollision("collision_geo_32x32x128", "collider", (49, 832, 66), (0, 0, 0));
  spawncollision("collision_geo_32x32x128", "collider", (49, 832, 194), (0, 0, 0));
  spawncollision("collision_geo_64x64x64", "collider", (47, 833, -16), (0, 0, 0));
  spawncollision("collision_geo_64x64x64", "collider", (47, 833, -16), (0, 315, 0));
  spawncollision("collision_geo_128x128x10", "collider", (934, 205, 74), (28.2, 340.6, -38.4));
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    spawncollision("collision_wall_256x256x10", "collider", (-5, 821, 72), (0, 297, 0));
  }
}