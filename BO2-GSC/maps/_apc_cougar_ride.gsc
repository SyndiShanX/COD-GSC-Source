/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_apc_cougar_ride.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  vehicle_anims();
  player_anims();
  fx();
}

#using_animtree("vehicles");

vehicle_anims() {
  level.cougar_steer_anim = % v_la_04_01_drive_leftturn_cougar;
}

#using_animtree("player");

player_anims() {
  level.viewarms = precachemodel(level.player_interactive_model);
  level.viewarms_steer_anim = % ch_la_04_01_drive_leftturn_player;
}

fx() {
}