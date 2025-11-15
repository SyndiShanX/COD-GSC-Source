/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_boat_soct_ride.gsc
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
  level.soct_wheels_up = % v_soct_wheels_up;
  level.soct_wheels_down = % v_soct_wheels_down;
}

#using_animtree("player");

player_anims() {
  level.viewarms = precachemodel("c_usa_cia_masonjr_viewbody");
  level.viewarms_steer_anim = % int_boat_steering;
  level.viewarms_steer_boost = % int_boat_boost_press;
}

fx() {
}