/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_drum.gsc
**************************************/

main() {
  maps\mp\mp_drum_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_drum");

  game["allies"] = "marines";
  game["axis"] = "japanese";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "pacific";
  game["axis_soldiertype"] = "pacific";

  game["strings"]["war_callsign_a"] = &"PATCH_CALLSIGN_DRUM_A";
  game["strings"]["war_callsign_b"] = &"PATCH_CALLSIGN_DRUM_B";
  game["strings"]["war_callsign_c"] = &"PATCH_CALLSIGN_DRUM_C";
  game["strings"]["war_callsign_d"] = &"PATCH_CALLSIGN_DRUM_D";
  game["strings"]["war_callsign_e"] = &"PATCH_CALLSIGN_DRUM_E";

  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_DRUM_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_DRUM_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_DRUM_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_DRUM_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_DRUM_E";

  setDvar("r_specularcolorscale", "1");

  setDvar("compassmaxrange", "2100");

  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}