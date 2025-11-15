/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\la_1b_art.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  visionsetnaked("sp_la1_2", 5);
  r_rimintensity_debug = getdvar(#"r_rimIntensity_debug");
  setsaveddvar("r_rimIntensity_debug", 1);
  r_rimintensity = getdvar(#"r_rimIntensity");
  setsaveddvar("r_rimIntensity", 15);
}

cougar_exit_dof1(m_player_body) {
  level.player depth_of_field_tween(0, 30, 31, 7000, 6, 1.8, 0.2);
  setsaveddvar("r_lightTweakSunDirection", (-45, 78, 0));
}

cougar_exit_dof2(m_player_body) {
  level.player depth_of_field_tween(0, 30, 31, 250, 6, 1.8, 0.2);
}

cougar_exit_dof3(m_player_body) {
  level.player depth_of_field_tween(0, 5, 31, 500, 6, 1.8, 0.2);
  setsaveddvar("r_lightTweakSunDirection", (-45, 53, 0));
}

cougar_exit_dof4(m_player_body) {
  level.player depth_of_field_tween(0, 30, 31, 7000, 6, 1.8, 1.0);
}

cougar_exit_dof5(m_player_body) {
  level.player depth_of_field_tween(0, 30, 31, 15000, 6, 1.8, 1.0);
}

cougar_exit_dof6(m_player_body) {
  level.player depth_of_field_tween(10, 60, 1000, 7000, 0.1, 0.1, 0.2);
  level.player thread depth_of_field_off(0.01);
}