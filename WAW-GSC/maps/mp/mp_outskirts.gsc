/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_outskirts.gsc
**************************************/

main() {
  maps\mp\mp_outskirts_fx::main();
  maps\mp\createart\mp_outskirts_art::main();

  maps\mp\_load::main();

  precachemodel("collision_geo_128x128x128");
  precachemodel("collision_wall_512x512x10");
  precachemodel("collision_geo_512x512x512");
  precachemodel("collision_wall_128x128x10");

  maps\mp\_compass::setupMiniMap("compass_map_mp_outskirts");

  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "german";
  game["axis_soldiertype"] = "german";

  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_OUTSKIRTS_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_OUTSKIRTS_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_OUTSKIRTS_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_OUTSKIRTS_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_OUTSKIRTS_E";

  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_OUTSKIRTS_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_OUTSKIRTS_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_OUTSKIRTS_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_OUTSKIRTS_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_OUTSKIRTS_E";

  setDvar("r_specularcolorscale", "1");

  setDvar("compassmaxrange", "2100");

  spawncollision("collision_geo_128x128x128", "collider", (834, 1282, -1276), (0, 350, 0));
  spawncollision("collision_geo_32x32x128", "collider", (-416, 392, -1188), (0, 0, 0));
  spawncollision("collision_geo_512x512x512", "collider", (1002, 350, -1064), (0, 0, 0));
  spawncollision("collision_wall_512x512x10", "collider", (19, 2112, -1003), (0, 0, 0));

  spawncollision("collision_wall_128x128x10", "collider", (-1111, -503, -1404), (0, 270, 0));

  spawncollision("collision_geo_512x512x512", "collider", (3763, 2861, -751), (0, 0, 0));

  spawncollision("collision_wall_128x128x10", "collider", (-224, -474, -1360), (0, 0, 0));

  spawncollision("collision_geo_512x512x512", "collider", (-2913, -1129, -1502), (0, 330, 0));

  spawncollision("collision_geo_512x512x512", "collider", (-684, 768, -1209), (0, 0, 0));

  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}