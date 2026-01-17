/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_vodka.gsc
*****************************************************/

main() {
  maps\mp\mp_vodka_fx::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_vodka");
  VisionSetNaked("mp_vodka");
  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "german";
  game["axis_soldiertype"] = "german";
  game["strings"]["war_callsign_a"] = &"PATCH_CALLSIGN_VODKA_A";
  game["strings"]["war_callsign_b"] = &"PATCH_CALLSIGN_VODKA_B";
  game["strings"]["war_callsign_c"] = &"PATCH_CALLSIGN_VODKA_C";
  game["strings"]["war_callsign_d"] = &"PATCH_CALLSIGN_VODKA_D";
  game["strings"]["war_callsign_e"] = &"PATCH_CALLSIGN_VODKA_E";
  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_VODKA_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_VODKA_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_VODKA_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_VODKA_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_VODKA_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}