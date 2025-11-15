/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_hotel.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  PrecacheString(&"MP_CALL_ELEVATOR");
  PrecacheString(&"MP_USE_ELEVATOR");
  PrecacheModel("p_htl_slot_machine_symbols");
  PrecacheModel("p_htl_slot_machine_symbols_off");
  precachemodel("collision_wall_256x256x10");
  maps\mp\mp_hotel_fx::main();
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_hotel2_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_hotel2");
  }
  maps\mp\mp_hotel_amb::main();
  maps\mp\gametypes\_teamset_cubans::level_init();
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
  SetDvar("scr_spawn_enemy_influencer_radius", 2600);
  SetDvar("scr_spawn_dead_friend_influencer_radius", 1100);
  level.water_duds = false;
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  maps\mp\mp_hotel_elevators::init();
  spawncollision("collision_wall_256x256x10", "collider", (3452, 875, 91), (0, 0, 0));
  spawncollision("collision_wall_256x256x10", "collider", (2500, 875, 91), (0, 0, 0));
  spawncollision("collision_wall_256x256x10", "collider", (1601, -2178, 62), (0, 0, 0));
}