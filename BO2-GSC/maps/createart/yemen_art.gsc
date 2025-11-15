/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\yemen_art.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  visionsetnaked("yemen_start", 1);
  r_rimintensity_debug = getdvar(#"r_rimIntensity_debug");
  setsaveddvar("r_rimIntensity_debug", 1);
  r_rimintensity = getdvar(#"r_rimIntensity");
  setsaveddvar("r_rimIntensity", 8);
  capture_swap_vision_and_sky();
}

capture_swap_vision_and_sky() {
  level waittill("capture_started");
  level thread lerp_dvar("r_skyTransition", 1, 2, 1);
  visionsetnaked("yemen_end02", 2);
}

menendez_intro() {
  visionsetnaked("sp_yemen_menendez_intro", 1);
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 10;
  n_far_end = 800;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  r_rimintensity_debug = getdvar(#"r_rimIntensity_debug");
  setsaveddvar("r_rimIntensity_debug", 1);
  r_rimintensity = getdvar(#"r_rimIntensity");
  setsaveddvar("r_rimIntensity", 3);
}

intro_hall() {
  visionsetnaked("sp_yemen_intro_hall", 1);
}

large_crowd() {
  visionsetnaked("sp_yemen_crowd", 1);
  r_rimintensity_debug = getdvar(#"r_rimIntensity_debug");
  setsaveddvar("r_rimIntensity_debug", 1);
  r_rimintensity = getdvar(#"r_rimIntensity");
  setsaveddvar("r_rimIntensity", 8);
}

hallway_exposure() {
  wait 2.55;
  current_exposure = getdvarfloat(#"r_exposureValue");
  setdvar("r_exposureTweak", 1);
  setdvar("r_exposureValue", 0.65);
  wait 1;
  difference_expo_per_frame = (current_exposure - 0.65) / 40;

  for(i = 0; i < 40; i++) {
    new_expo = i * difference_expo_per_frame + 0.65;
    setdvar("r_exposureValue", new_expo);
    wait 0.05;
  }

  setdvar("r_exposureValue", current_exposure);
  setdvar("r_exposureTweak", 0);
}

market() {
  visionsetnaked("sp_yemen_market", 1);
}

alleyway() {
  visionsetnaked("sp_yemen_alley", 1);
}

market_2() {
  visionsetnaked("sp_yemen_market2", 1);
}

outdoors() {
  visionsetnaked("sp_yemen_outdoors", 1);
}

end_start() {
  visionsetnaked("sp_yemen_end_start", 1);
}

end_menendez() {
  setsaveddvar("r_lightTweakSunDirection", (-15, 360, 0));
  visionsetnaked("sp_yemen_end_menendez", 1);
}

dof_menendez(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 10;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_room(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_menendez_1(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_goons(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_menendez_2(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_vtol(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_menendez_3(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 20;
  n_far_end = 5000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3;
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 20;
  n_far_end = 5000;
  n_near_blur = 0.1;
  n_far_blur = 0.1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  level.player thread depth_of_field_off(0.01);
}

dof_shoot_vtol1(m_player_body) {
  n_near_start = 1;
  n_near_end = 50;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 0.1;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  visionsetnaked("sp_yemen_morals", 1);
}

dof_shoot_vtol2(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 5000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol3(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 5000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol4(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 700;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol5(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol6(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol7(m_player_body) {
  n_near_start = 1;
  n_near_end = 10;
  n_far_start = 20;
  n_far_end = 200;
  n_near_blur = 6;
  n_far_blur = 3;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol8(m_player_body) {
  n_near_start = 1;
  n_near_end = 24;
  n_far_start = 25;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1.2;
  n_time = 0.8;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol9(m_player_body) {
  n_near_start = 1;
  n_near_end = 24;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.8;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol10(m_player_body) {
  n_near_start = 1;
  n_near_end = 24;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 4.0;
  level.player thread depth_of_field_off(0.01);
}

dof_shoot_vtol11(m_player_body) {
  n_near_start = 1;
  n_near_end = 30;
  n_far_start = 600;
  n_far_end = 2000;
  n_near_blur = 4.5;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol12(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 30;
  n_far_end = 700;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol13(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 8000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3.0;
  level.player thread depth_of_field_off(0.01);
}

dof_shoot_vtol14(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_shoot_vtol15(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.0;
  level.player thread depth_of_field_off(0.01);
}