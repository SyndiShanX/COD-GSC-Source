/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\panama3_art.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 15);
  visionsetnaked("sp_panama_default", 5);
}

clinic() {
  visionsetnaked("sp_panama3_clinic", 0.5);
}

chase() {
  visionsetnaked("sp_panama3_chase", 0.5);
}

checkpoint() {
  visionsetnaked("sp_panama3_checkpoint", 0.5);
}

docks() {
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 8);
  setsaveddvar("sm_sunSampleSizeNear", 1.9);
  visionsetnaked("sp_panama3_docks", 0.5);
}

sniper() {
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 8);
  visionsetnaked("sp_panama3_sniper", 0.5);
  setsaveddvar("r_lightTweakSunLight", 18);
}

walk() {
  visionsetnaked("sp_panama3_sniper", 0.5);
}

menedez_ambush() {
  visionsetnaked("sp_panama3_sniper", 0.5);
}

basement() {
  visionsetnaked("sp_panama3_sniper", 0.5);
}

set_water_dvar() {
  setdvar("r_waterwaveangle", "0 130 0 0");
  setdvar("r_waterwavewavelength", "230 321 0 0");
  setdvar("r_waterwavespeed", "0.39 0.54 0 0");
}

dof_mason_jump(m_player_body) {
  n_near_start = 5;
  n_near_end = 100;
  n_far_start = 350;
  n_far_end = 970;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.2;

  iprintlnbold("DOF:dof_mason_jump");

  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_get_up(m_player_body) {
  n_near_start = 5;
  n_near_end = 50;
  n_far_start = 400;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;

  iprintlnbold("DOF:dof_get_up");

  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 0.1;
  level.player depth_of_field_off(0.1);
}

dof_chopper(m_player_body) {
}

dof_noriega(m_player_body) {
}

dof_noriega_shoots(m_player_body) {
  wait 0.1;
  sniper = getent("end_roof_sniper_ai", "targetname");
  playfxontag(level._effect["soldier_impact_blood"], sniper, "j_clavicle_le");
}

dof_take_gun(m_player_body) {
}

dof_throw_gun(m_player_body) {
}

dof_noriega_look_1(m_player_body) {
  iprintlnbold("dof_noriega_look_1");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 1, 0.1);
  visionsetnaked("sp_panama3_end", 0.1);
}

dof_fwd_look_1(m_player_body) {
  iprintlnbold("dof_fwd_look_1");

  level.player depth_of_field_tween(10, 300, 750, 10000, 4, 1, 0.1);
}

dof_noriega_look_2(m_player_body) {
  iprintlnbold("dof_noriega_look_2");

  level.player depth_of_field_tween(0, 20, 100, 150, 4, 1, 0.1);
  visionsetnaked("sp_panama3_end", 1);
}

dof_fwd_look_2(m_player_body) {
  iprintlnbold("dof_fwd_look_2");

  level.player depth_of_field_tween(10, 300, 750, 10000, 4, 1, 0.1);
}

dof_noriega_look_3(m_player_body) {
  iprintlnbold("dof_noriega_look_3");

  level.player depth_of_field_tween(0, 20, 200, 300, 4, 1, 0.1);
}

dof_fwd_look_3(m_player_body) {
  iprintlnbold("dof_fwd_look_3");

  n_near_start = 10;
  n_near_end = 300;
  n_far_start = 750;
  n_far_end = 10000;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 6;
  n_near_start = 10;
  n_near_end = 50;
  n_far_start = 750;
  n_far_end = 10000;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_mason_look(m_player_body) {
  wait 2;

  iprintlnbold("dof_mason_look");

  level.player depth_of_field_tween(0, 20, 30, 50, 6, 2, 0.5);
}

dof_noriega_look_4(m_player_body) {
  iprintlnbold("dof_noriega_look_4");

  level.player depth_of_field_tween(0, 20, 125, 175, 4, 1, 0.1);
}

dof_gun_look_1(m_player_body) {
  iprintlnbold("dof_gun_look_1");

  level notify("start_heartbeat");
  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_leg_look(m_player_body) {
  iprintlnbold("dof_leg_look");

  level.player depth_of_field_tween(0, 20, 30, 50, 4, 1, 0.1);
}

dof_arm_look(m_player_body) {
  iprintlnbold("dof_arm_look");

  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_menendez_look_1(m_player_body) {
  iprintlnbold("dof_menendez_look_1");

  level.player depth_of_field_tween(0, 20, 90, 120, 4, 1, 0.1);
}

dof_gun_look_2(m_player_body) {
  iprintlnbold("dof_gun_look_2");

  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_menendez_look_2(m_player_body) {
  iprintlnbold("dof_menendez_look_2");

  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_shotgun_look_2(m_player_body) {
  iprintlnbold("dof_shotgun_look_2");

  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_shoot_leg(m_player_body) {
  iprintlnbold("dof_shoot_leg");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 1, 0.1);
}

dof_gun_look_3(m_player_body) {
  iprintlnbold("dof_gun_look_3");

  level.player depth_of_field_tween(0, 20, 70, 120, 4, 1, 0.1);
}

dof_shoe_look(m_player_body) {
  iprintlnbold("dof_shoe_look");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 1, 0.1);
}

dof_menendez_look_3(m_player_body) {
  iprintlnbold("dof_menendez_look_3");

  level.player depth_of_field_tween(0, 20, 150, 200, 4, 1, 0.1);
  wait 5;
  visionsetnaked("sp_panama3_basement", 1);
}