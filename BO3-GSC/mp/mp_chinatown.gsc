/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_chinatown.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_chinatown_fx;
#using scripts\mp\mp_chinatown_sound;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_chinatown;

function main() {
  precache();
  mp_chinatown_fx::main();
  mp_chinatown_sound::main();
  level.remotemissile_kill_z = -435 + 50;
  load::main();
  compass::setupminimap("compass_map_mp_chinatown");
  setDvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  spawncollision("collision_clip_128x128x128", "collider", (-814.75, 1490.75, 354.75), (0, 0, 0));
  spawncollision("collision_clip_256x256x256", "collider", (-694.25, 1553.5, 298.25), vectorscale((0, 1, 0), 315));
  spawncollision("collision_clip_128x128x128", "collider", (-788.25, 1554.75, 354.75), vectorscale((0, 1, 0), 315));
  spawncollision("collision_clip_wedge_32x128", "collider", (-898, 1074, 388), vectorscale((0, 1, 0), 315));
  spawncollision("collision_clip_wedge_32x128", "collider", (-864, 1599.25, 381.75), vectorscale((0, 1, 0), 315));
  spawncollision("collision_player_64x64x256", "collider", (-840, 1540, 366), vectorscale((0, 1, 0), 25));
  if(util::isprophuntgametype()) {
    spawncollision("collision_player_64x64x256", "collider", (-853, 1187, 192), vectorscale((0, 1, 0), 45));
    spawncollision("collision_player_64x64x256", "collider", (-853, 1187, 415), vectorscale((0, 1, 0), 45));
    spawncollision("collision_clip_256x256x256", "collider", (-746, 1201, 181), (0, 0, 0));
    spawncollision("collision_clip_64x64x256", "collider", (-969, -1839, 132), vectorscale((0, 1, 0), 135));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-376, -1491, 141), vectorscale((0, 1, 0), 314));
  }
  level.cleandepositpoints = array((-97.928, -7.61413, 0.125), (1384.68, 1934.86, 8.125), (438.717, 1, 144.125), (857.493, -1991.98, 24.125));
}

function precache() {}