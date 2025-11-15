/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_kneedeep.gsc
*****************************************************/

main() {
  maps\mp\mp_kneedeep_fx::main();
  precachemodel("collision_wall_64x64x10");
  precachemodel("collision_geo_64x64x64");
  precachemodel("collision_geo_32x32x128");
  precachemodel("collision_wall_128x128x10");
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_kneedeep");
  game["allies"] = "marines";
  game["axis"] = "japanese";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "pacific";
  game["axis_soldiertype"] = "pacific";
  game["strings"]["war_callsign_a"] = & "PATCH_CALLSIGN_KNEEDEEP_A";
  game["strings"]["war_callsign_b"] = & "PATCH_CALLSIGN_KNEEDEEP_B";
  game["strings"]["war_callsign_c"] = & "PATCH_CALLSIGN_KNEEDEEP_C";
  game["strings"]["war_callsign_d"] = & "PATCH_CALLSIGN_KNEEDEEP_D";
  game["strings"]["war_callsign_e"] = & "PATCH_CALLSIGN_KNEEDEEP_E";
  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_KNEEDEEP_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_KNEEDEEP_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_KNEEDEEP_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_KNEEDEEP_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_KNEEDEEP_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_wall_64x64x10", "collider", (730, 260, 52), (0, 289.4, 0));
  spawncollision("collision_geo_64x64x64", "collider", (-350.5, -37, 75.5), (0, 66.2, 0));
  spawncollision("collision_geo_64x64x64", "collider", (2170, -295, 119.5), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (2256.5, -328, 157), (0, 0, 0));
  spawncollision("collision_geo_32x32x128", "collider", (-1245, -2207.5, 67.5), (0, 281.4, 0));
  spawncollision("collision_wall_256x256x10", "collider", (-1556, -484, -44), (0, 0, 0));
  spawncollision("collision_geo_256x256x256", "collider", (-929, -1065, 444), (0, 13.4, 0));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}