/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dome.gsc
*****************************************************/

main() {
  maps\mp\mp_dome_fx::main();
  maps\mp\createart\mp_dome_art::main();
  setdvar("scr_spawn_twar_linked_flag_influencer_score_falloff_percentage", "1");
  maps\mp\_load::main();
  maps\mp\mp_dome_amb::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_dome");
  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "german";
  game["axis_soldiertype"] = "german";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_DOME_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_DOME_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_DOME_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_DOME_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_DOME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_DOME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_DOME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_DOME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_DOME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_DOME_E";
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}