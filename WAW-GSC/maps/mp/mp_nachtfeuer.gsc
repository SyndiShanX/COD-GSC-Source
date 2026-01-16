/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_nachtfeuer.gsc
*****************************************************/

main() {
  maps\mp\mp_nachtfeuer_fx::main();
  precachemodel("collision_wall_256x256x10");
  precachemodel("collision_geo_64x64x64");
  precachemodel("collision_geo_32x32x128");
  setdvar("scr_spawn_twar_contested_flag_influencer_radius", "600");
  move_spawn_point("mp_twar_spawn", (592, -1332, 1292), (600, -1356, 1292));
  move_spawn_point("mp_twar_spawn", (304, -360, 1203), (272, -360, 1203));
  maps\mp\_load::main();
  maps\mp\mp_nachtfeuer_amb::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_nachtfeuer");
  game["allies"] = "russian";
  game["axis"] = "german";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "german";
  game["axis_soldiertype"] = "german";
  game["strings"]["war_callsign_a"] = & "MPUI_CALLSIGN_NACHTFEUER_A";
  game["strings"]["war_callsign_b"] = & "MPUI_CALLSIGN_NACHTFEUER_B";
  game["strings"]["war_callsign_c"] = & "MPUI_CALLSIGN_NACHTFEUER_C";
  game["strings"]["war_callsign_d"] = & "MPUI_CALLSIGN_NACHTFEUER_D";
  game["strings"]["war_callsign_e"] = & "MPUI_CALLSIGN_NACHTFEUER_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_NACHTFEUER_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_NACHTFEUER_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_NACHTFEUER_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_NACHTFEUER_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_NACHTFEUER_E";
  setdvar("r_specularcolorscale", "1");
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_wall_256x256x10", "collider", (232, -323, 1211), (0, 0, 0));
  spawncollision("collision_geo_32x32x128", "collider", (318, -320, 1414), (0, 0, 0));
  spawncollision("collision_geo_32x32x128", "collider", (318, -320, 1286), (0, 0, 0));
  spawncollision("collision_geo_64x64x64", "collider", (1052, -752, 1300), (0, 0, 0));
  spawncollision("collision_geo_32x32x128", "collider", (-820, 1602, 1348), (0, 0, 0));
  remove_dog_spawn_point((1592, -2558, 1191));
  remove_dog_spawn_point((1636, -2558, 1191));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}

move_spawn_point(targetname, start_point, new_point) {
  spawn_points = getentarray(targetname, "classname");
  for (i = 0; i < spawn_points.size; i++) {
    if(distancesquared(spawn_points[i].origin, start_point) < 1) {
      spawn_points[i].origin = new_point;
      return;
    }
  }
}

remove_dog_spawn_point(point) {
  spawn_points = [];
  for (i = 0; i < level.dogspawnnodes.size; i++) {
    if(distancesquared(level.dogspawnnodes[i].origin, point) > 25) {
      spawn_points[spawn_points.size] = level.dogspawnnodes[i];
    }
  }
  level.dogspawnnodes = spawn_points;
}