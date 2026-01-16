/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\la_1_art.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;

main() {
  flag_wait("level.player");
  level.tweakfile = 1;
  level thread swap_vista();
  r_rimintensity_debug = getdvar(#"r_rimIntensity_debug");
  setsaveddvar("r_rimIntensity_debug", 1);
  r_rimintensity = getdvar(#"r_rimIntensity");
  setsaveddvar("r_rimIntensity", 8);

  foreach(m_godray in getentarray("godrays", "targetname"))
  m_godray hide();

  level.map_default_sun_direction = getdvar(#"r_lightTweakSunDirection");
  setsaveddvar("r_lightTweakSunDirection", (-12.9, 3.6, 0));
  visionsetnaked("sp_la_1_intro_secretary", 2);
  start_dist = 224.631;
  half_dist = 8471.2;
  half_height = 2372.87;
  base_height = 745.287;
  fog_r = 0.3;
  fog_g = 0.36;
  fog_b = 0.4;
  fog_scale = 9.6;
  sun_col_r = 1;
  sun_col_g = 0.64;
  sun_col_b = 0.27;
  sun_dir_x = 0.479594;
  sun_dir_y = 0.713709;
  sun_dir_z = 0.510498;
  sun_start_ang = 0;
  sun_stop_ang = 42;
  time = 0;
  max_fog_opacity = 0.729652;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  flag_wait("intro_done");
  start_dist = 224.631;
  half_dist = 8471.2;
  half_height = 2372.87;
  base_height = 745.287;
  fog_r = 0.3;
  fog_g = 0.36;
  fog_b = 0.4;
  fog_scale = 9.6;
  sun_col_r = 1;
  sun_col_g = 0.64;
  sun_col_b = 0.27;
  sun_dir_x = 0.479594;
  sun_dir_y = 0.713709;
  sun_dir_z = 0.510498;
  sun_start_ang = 0;
  sun_stop_ang = 42;
  time = 0;
  max_fog_opacity = 0.729652;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  visionsetnaked("sp_la_1", 5);
  n_sun_sample_size = 0.25;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  setsaveddvar("r_lightTweakSunDirection", level.map_default_sun_direction);
  flag_wait("started_rappelling");
  n_sun_sample_size = 0.25;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);

  foreach(m_godray in getentarray("godrays", "targetname"))
  m_godray show();

  flag_wait("done_rappelling");
  start_dist = 224.631;
  half_dist = 8471.2;
  half_height = 3000;
  base_height = 0;
  fog_r = 0.3;
  fog_g = 0.36;
  fog_b = 0.4;
  fog_scale = 9.6;
  sun_col_r = 1;
  sun_col_g = 0.64;
  sun_col_b = 0.27;
  sun_dir_x = 0.479594;
  sun_dir_y = 0.713709;
  sun_dir_z = 0.510498;
  sun_start_ang = 0;
  sun_stop_ang = 42;
  time = 0;
  max_fog_opacity = 0.729652;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  visionsetnaked("sp_la_1_after_rope", 5);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  flag_wait("player_in_cougar");
  start_dist = 224.631;
  half_dist = 8471.2;
  half_height = 3000;
  base_height = 0;
  fog_r = 0.3;
  fog_g = 0.36;
  fog_b = 0.4;
  fog_scale = 9.6;
  sun_col_r = 1;
  sun_col_g = 0.64;
  sun_col_b = 0.27;
  sun_dir_x = 0.479594;
  sun_dir_y = 0.713709;
  sun_dir_z = 0.510498;
  sun_start_ang = 0;
  sun_stop_ang = 42;
  time = 0;
  max_fog_opacity = 0.729652;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  flag_wait("la_1_sky_transition");
  visionsetnaked("sp_la1_2", 5);
  start_dist = 224.631;
  half_dist = 16000;
  half_height = 3000;
  base_height = 0;
  fog_r = 0.3;
  fog_g = 0.36;
  fog_b = 0.4;
  fog_scale = 16;
  sun_col_r = 1;
  sun_col_g = 0.64;
  sun_col_b = 0.27;
  sun_dir_x = 0.479594;
  sun_dir_y = 0.713709;
  sun_dir_z = 0.510498;
  sun_start_ang = 0;
  sun_stop_ang = 42;
  time = 0;
  max_fog_opacity = 0.729652;
  setvolfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  v_sun_color = (0.847, 0.647, 0.455);
  setsunlight(v_sun_color[0], v_sun_color[1], v_sun_color[2]);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  level thread swap_skybox_over_time(5);
}

swap_vista() {
  a_skyline_2 = getentarray("downtown_skyline_2", "targetname");
  a_skyline_1 = getentarray("downtown_skyline_1", "targetname");

  foreach(model in a_skyline_2)
  model hide();

  flag_wait("la_1_vista_swap");

  foreach(model in a_skyline_1)
  model hide();

  foreach(model in a_skyline_2)
  model show();
}

mount_turret_dof1(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.5);
}

mount_turret_dof2(m_player_body) {
  level.player depth_of_field_tween(0, 20, 20, 1000, 6, 2, 0.2);
}

mount_turret_dof3(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 2000, 6, 1, 0.2);
}

mount_turret_dof4(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 3600, 6, 1, 0.2);
}

mount_turret_dof5(m_player_body) {
  level.player thread depth_of_field_off(0.5);
  scene_wait("sam_cougar_mount");
}

cougar_fall_dof1(m_player_body) {
  level.player depth_of_field_tween(0, 40, 40, 10000, 0, 0, 1.5);
}

cougar_fall_dof2(m_player_body) {
  level.player depth_of_field_tween(0, 40, 40, 10000, 0, 0, 0.2);
}

cougar_fall_dof3(m_player_body) {
  level.player depth_of_field_off(0.5);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
}

intro_player_dof1(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 40, 0, 2, 0.2);
  setsaveddvar("sm_sunSampleSizeNear", 0.2);
  setsaveddvar("r_flashLightSpecularScale", 50);
}

intro_player_dof2(m_player_body) {
  level.player depth_of_field_tween(0, 0, 0, 10000, 0, 0, 0.2);
  visionsetnaked("sp_la_1_intro", 3);
}

intro_player_dof3(m_player_body) {
  setsaveddvar("r_lightTweakSunDirection", (-45, 53, 0));
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  setsaveddvar("r_flashLightSpecularScale", 1);
  visionsetnaked("sp_la_1_intro_front_view", 2);
  setvolfog(224.631, 25000, 2372.87, 745.287, 0.3, 0.36, 0.4, 13, 1, 0.64, 0.27, 0.479594, 0.713709, 0.510498, 0, 42, 0, 0.729652);
  level.player depth_of_field_tween(0, 10, 10, 10000, 6, 1, 0.5);
}

intro_player_dof4(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 20000, 6, 0, 0.1);
  visionsetnaked("sp_la_1_intro", 1);
}

intro_player_dof5(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 20000, 6, 0.5, 0.5);
  setsaveddvar("r_lightTweakSunDirection", (-8.9, -3.6, 0));
  setsaveddvar("sm_sunSampleSizeNear", 0.2);
}

intro_player_dof6(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 75, 6, 2, 0.25);
}

intro_player_dof7(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 10000, 6, 1, 0.5);
}

intro_player_dof8(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 75, 6, 2, 0.25);
  level.orig_lighttweaksunlight = getdvarfloat(#"r_lightTweakSunLight");
  lerp_dvar("r_lightTweakSunLight", 16, 1, 1);
}

intro_player_dof9(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

intro_player_dof10(m_player_body) {
  level.player depth_of_field_tween(0, 5, 5, 20000, 6, 1, 0.2);
  lerp_dvar("r_lightTweakSunLight", level.orig_lighttweaksunlight, 2, 1);
}

intro_player_dof11(m_player_body) {
  setsaveddvar("r_lightTweakSunDirection", (-45, 53, 0));
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  level.player depth_of_field_off(0.5);
  visionsetnaked("sp_la_1_intro_front_view", 6);
  setvolfog(220.052, 25000, 2372, 745, 0.3, 0.36, 0.4, 13, 1, 0.64, 0.27, 0.479594, 0.713709, 0.510498, 0, 42, 0, 0.72);
}

intro_player_dof12(m_player_body) {
  level.player depth_of_field_tween(0, 80, 80, 20000, 6, 0, 0.5);
}

intro_player_dof13(m_player_body) {
  level.player depth_of_field_tween(0, 80, 80, 20000, 6, 0, 0.5);
}

intro_player_dof14(m_player_body) {
  level.player depth_of_field_tween(0, 80, 80, 20000, 6, 0, 0.2);
}

intro_player_dof15(m_player_body) {
  level.player depth_of_field_off(0.5);
  n_sun_sample_size = 0.25;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  visionsetnaked("sp_la_1_intro", 3);
}

lerp_sun_direction(v_sun_direction_angles, n_time) {
  if(!isDefined(n_time))
    n_time = 0;

  if(n_time > 0) {
    r_lighttweaksundirection = getdvar(#"r_lightTweakSunDirection");
    a_angle_strings = strtok(r_lighttweaksundirection, " ");
    v_current_angles = (int(a_angle_strings[0]), int(a_angle_strings[1]), int(a_angle_strings[2]));
    t_delta = 0;

    while(t_delta < n_time) {
      wait 0.05;
      t_delta = t_delta + 0.05;
      v_angles_0 = anglelerp(v_current_angles[0], v_sun_direction_angles[0], t_delta / n_time);
      v_angles_1 = anglelerp(v_current_angles[1], v_sun_direction_angles[1], t_delta / n_time);
      v_angles_2 = anglelerp(v_current_angles[2], v_sun_direction_angles[2], t_delta / n_time);
      setsaveddvar("r_lightTweakSunDirection", (v_angles_0, v_angles_1, v_angles_2));
    }
  } else
    setsaveddvar("r_lightTweakSunDirection", v_sun_direction_angles);
}

reset_sun_direction(n_time) {
  lerp_sun_direction(level.map_default_sun_direction, n_time);
}

swap_skybox_over_time(n_time) {
  t_delta = 0;

  while(t_delta < n_time) {
    wait 0.05;
    t_delta = t_delta + 0.05;
    n_val = min(t_delta / n_time, 0.9);
    setsaveddvar("r_skyTransition", n_val);
  }
}

enter_cougar_hands(m_player_body) {
  level.player depth_of_field_tween(0, 25, 1000, 7000, 6, 1.8, 0.5);
}

enter_cougar_potus(m_player_body) {
  level.player depth_of_field_tween(0, 300, 5000, 20000, 4, 1.8, 0.5);
}

enter_cougar_wheel(m_player_body) {
  level.player depth_of_field_tween(0, 10, 5000, 20000, 4, 0.1, 0.2);
  wait 1.0;
  level.player depth_of_field_off(3);
}

dof_hookup(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

dof_rappelers(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 3500;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_hands(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_rappelers2(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 3500;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_truck(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 3500;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_rappelers3(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_rappelers4(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 400;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.0;
  level.player depth_of_field_off(0.01);
}

dof_sr_first_rpg(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 8000;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_first_explosion(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 8000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_hook_up(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 3;
  n_far_end = 800;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_hands(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 8000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.25;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_second_rpg(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 8000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_second_explosion(m_player_body) {
  n_near_start = 1;
  n_near_end = 30;
  n_far_start = 200;
  n_far_end = 3000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_debris_falling(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 200;
  n_far_end = 3500;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_car(m_player_body) {
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 200;
  n_far_end = 3500;
  n_near_blur = 6;
  n_far_blur = 1.0;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_sr_get_up_hand(m_player_body) {
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 3;
  n_far_end = 800;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 0.5;
  n_near_start = 1;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 0.25;
  level.player depth_of_field_off(0.01);
}