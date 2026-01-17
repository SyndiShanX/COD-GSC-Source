/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_kwai.gsc
*****************************************************/

main() {
  maps\mp\mp_kwai_fx::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_kwai");
  VisionSetNaked("mp_kwai");
  game["allies"] = "marines";
  game["axis"] = "japanese";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "pacific";
  game["axis_soldiertype"] = "pacific";
  game["strings"]["war_callsign_a"] = &"PATCH_CALLSIGN_KWAI_A";
  game["strings"]["war_callsign_b"] = &"PATCH_CALLSIGN_KWAI_B";
  game["strings"]["war_callsign_c"] = &"PATCH_CALLSIGN_KWAI_C";
  game["strings"]["war_callsign_d"] = &"PATCH_CALLSIGN_KWAI_D";
  game["strings"]["war_callsign_e"] = &"PATCH_CALLSIGN_KWAI_E";
  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_KWAI_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_KWAI_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_KWAI_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_KWAI_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_KWAI_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}