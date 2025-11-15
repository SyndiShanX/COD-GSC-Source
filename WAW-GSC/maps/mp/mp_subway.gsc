/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_subway.gsc
*****************************************************/

main() {
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  maps\mp\mp_subway_fx::main();
  maps\mp\_load::main();
  maps\mp\mp_subway_amb::main();
  precachemodel("collision_geo_128x128x10");
  precachemodel("collision_geo_128x128x128");
  maps\mp\_compass::setupMiniMap("compass_map_mp_subway");
  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "russian";
  game["axis_soldiertype"] = "german";
  game["strings"]["war_callsign_a"] = & "PATCH_CALLSIGN_SUBWAY_A";
  game["strings"]["war_callsign_b"] = & "PATCH_CALLSIGN_SUBWAY_B";
  game["strings"]["war_callsign_c"] = & "PATCH_CALLSIGN_SUBWAY_C";
  game["strings"]["war_callsign_d"] = & "PATCH_CALLSIGN_SUBWAY_D";
  game["strings"]["war_callsign_e"] = & "PATCH_CALLSIGN_SUBWAY_E";
  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_SUBWAY_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_SUBWAY_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_SUBWAY_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_SUBWAY_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_SUBWAY_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_wall_64x64x10", "collider", (-2637.5, 2962, 746), (0, 294.9, 0));
  spawncollision("collision_geo_128x128x128", "collider", (-3328, 1280, 928), (0, 14, 0));
  spawncollision("collision_geo_128x128x128", "collider", (-3445, 1722, 928), (0, 14, 0));
  spawncollision("collision_wall_256x256x10", "collider", (-195, 2307.5, 1026), (0, 9, 0));
  spawncollision("collision_geo_32x32x128", "collider", (-1962.5, 3907.5, 783.5), (0, 30.8, 0));
}