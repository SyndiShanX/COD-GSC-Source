/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\panama_art.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setsaveddvar("r_rimIntensity_debug", 1);
  setsaveddvar("r_rimIntensity", 4);
  setsaveddvar("r_lightTweakSunLight", 5);
  visionsetnaked("sp_panama_house", 0.5);
}

house() {
  setsaveddvar("r_rimIntensity", 1);
  visionsetnaked("sp_panama_house", 0.5);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
}

zodiac() {
  visionsetnaked("sp_panama_airstrip", 0.5);
  setsaveddvar("r_rimIntensity", 10);
  setsaveddvar("r_sky_intensity_factor0", 0.5);
  setsaveddvar("sm_sunSampleSizeNear", 1);
}

beach() {
  visionsetnaked("sp_panama_airstrip", 0.5);
  setsaveddvar("r_sky_intensity_factor0", 1);
  setsaveddvar("r_lightTweakSunLight", 18);
}

airfield() {
  visionsetnaked("sp_panama_airstrip", 0.5);
  setsaveddvar("r_lightTweakSunLight", 6);
}

learjet() {
  visionsetnaked("sp_panama_airstrip", 0.5);
}

motel() {
  visionsetnaked("sp_panama_motel", 0.5);
}

slums_start() {
  visionsetnaked("sp_panama_slums", 0.5);
  setsaveddvar("r_rimIntensity", 10);
}

burning_building() {
  visionsetnaked("sp_panama_slums", 0.5);
  setsaveddvar("r_rimIntensity", 10);
}

slums() {
  visionsetnaked("sp_panama_slums", 0.5);
  setsaveddvar("r_rimIntensity", 10);
}

set_water_dvar() {
  setsaveddvar("r_waterwaveangle", "0 130 0 0");
  setsaveddvar("r_waterwavewavelength", "230 321 0 0");
  setsaveddvar("r_waterwavespeed", "0.39 0.54 0 0");
}

dof_intro(m_player_body) {
}

dof_grab_hat(m_player_body) {
}

dof_close_door(m_player_body) {
}

dof_reflection(m_player_body) {
}

dof_shed_open(m_player_body) {
  n_near_start = 1;
  n_near_end = 35;
  n_far_start = 80;
  n_far_end = 350;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_mirror(m_player_body) {
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 50;
  n_far_end = 100;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 202;
  n_far_end = 600;
  n_near_blur = 4;
  n_far_blur = 0.65;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_look_at_guys1(m_player_body) {
  n_near_start = 1;
  n_near_end = 45;
  n_far_start = 202;
  n_far_end = 600;
  n_near_blur = 4;
  n_far_blur = 0.65;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
}

dof_look_at_bag1(m_player_body) {
  n_near_start = 1;
  n_near_end = 25;
  n_far_start = 26;
  n_far_end = 65;
  n_near_blur = 4;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_look_at_guys2(m_player_body) {
  n_near_start = 1;
  n_near_end = 25;
  n_far_start = 202;
  n_far_end = 600;
  n_near_blur = 4;
  n_far_blur = 0.65;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 28;
  level.player depth_of_field_off(0.5);
}

dof_kid(m_player_body) {
  n_near_start = 1;
  n_near_end = 30;
  n_far_start = 250;
  n_far_end = 2500;
  n_near_blur = 4;
  n_far_blur = 0.65;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_mkcnight_mason(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 50;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_humvee(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 50;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  level.player depth_of_field_off(0.5);
}

dof_kill_men(m_player_body) {
  n_near_start = 1;
  n_near_end = 45;
  n_far_start = 290;
  n_far_end = 400;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.5;
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 27;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_tv_smash(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 27;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1;
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 100;
  n_far_end = 256;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_throw_bag(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 80;
  n_far_end = 256;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_point_gun(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 50;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 4;
  n_near_start = 0;
  n_near_end = 50;
  n_far_start = 200;
  n_far_end = 300;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_mason_bag_empty(m_player_body) {
  n_near_start = 1;
  n_near_end = 50;
  n_far_start = 200;
  n_far_end = 300;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3.3;
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 50;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 180;
  n_far_end = 300;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_hit_noriega(m_player_body) {
  n_near_start = 1;
  n_near_end = 5;
  n_far_start = 50;
  n_far_end = 80;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_grab_chair(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 60;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_grab_noriega(m_player_body) {
  n_near_start = 1;
  n_near_end = 5;
  n_far_start = 60;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shove_noriega(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 60;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 80;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_mason_gun_at_noriega(m_player_body) {
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 80;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_walk_out(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 0.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  level.player depth_of_field_off(0.5);
}

dof_chopper(m_player_body) {
}

dof_noriega(m_player_body) {
}

dof_noriega_shoots(m_player_body) {
}

dof_take_gun(m_player_body) {
}

dof_throw_gun(m_player_body) {
}