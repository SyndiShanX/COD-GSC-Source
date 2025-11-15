/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_stalingrad.gsc
*****************************************************/

main() {
  maps\mp\mp_stalingrad_fx::main();
  maps\mp\createart\mp_stalingrad_art::main();
  move_spawn_point("mp_dm_spawn", (528, -600, 28), (471, -595, 60));
  move_spawn_point("mp_twar_spawn", (-104, -1012, 23.5), (-102, -1023, 56));
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_stalingrad");
  VisionSetNaked("mp_stalingrad");
  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "german";
  game["axis_soldiertype"] = "german";
  game["strings"]["war_callsign_a"] = & "PATCH_CALLSIGN_STALINGRAD_A";
  game["strings"]["war_callsign_b"] = & "PATCH_CALLSIGN_STALINGRAD_B";
  game["strings"]["war_callsign_c"] = & "PATCH_CALLSIGN_STALINGRAD_C";
  game["strings"]["war_callsign_d"] = & "PATCH_CALLSIGN_STALINGRAD_D";
  game["strings"]["war_callsign_e"] = & "PATCH_CALLSIGN_STALINGRAD_E";
  game["strings_menu"]["war_callsign_a"] = "@PATCH_CALLSIGN_STALINGRAD_A";
  game["strings_menu"]["war_callsign_b"] = "@PATCH_CALLSIGN_STALINGRAD_B";
  game["strings_menu"]["war_callsign_c"] = "@PATCH_CALLSIGN_STALINGRAD_C";
  game["strings_menu"]["war_callsign_d"] = "@PATCH_CALLSIGN_STALINGRAD_D";
  game["strings_menu"]["war_callsign_e"] = "@PATCH_CALLSIGN_STALINGRAD_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}

move_spawn_point(targetname, start_point, new_point) {
  spawn_points = getEntArray(targetname, "classname");
  for(i = 0; i < spawn_points.size; i++) {
    if(distancesquared(spawn_points[i].origin, start_point) < 1) {
      spawn_points[i].origin = new_point;
      return;
    }
  }
}