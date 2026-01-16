/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\angola_art.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  level.tweakfile = 1;
  visionsetnaked("sp_angola_burning_man", 0.1);
}

burning_man() {
  visionsetnaked("sp_angola_burning_man", 0.1);
  setdvar("r_rimIntensity", 4);
  n_near_start = 1;
  n_near_end = 8;
  n_far_start = 20;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  n_exposure = 3.6;
  setdvar("r_exposureTweak", 1);
  setdvar("r_exposureValue", n_exposure);
  n_sun_sample_size = 0.25;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

burning_sky() {
  visionsetnaked("sp_angola_burning_sky", 0.5);
  setdvar("r_rimIntensity", 4);
  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 20;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  setdvar("r_exposureTweak", 1);
  setdvar("r_exposureValue", 3.6);
  n_sun_sample_size = 0.25;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

riverbed() {
  visionsetnaked("sp_angola_riverbed", 2);
  setdvar("r_rimIntensity", 4);
  level.player depth_of_field_off(0.1);
  n_exposure = 3.0;
  setdvar("r_exposureTweak", 1);
  level thread ramp_dvar("r_exposureValue", 3.6, 3.0, 2, 0.05);
  ramp_dvar("r_lightGridContrast", -0.1, 0, 2, 0.05);
  setsaveddvar("r_lightGridEnableTweaks", 0);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

savimbi_reveal() {
  visionsetnaked("sp_angola_savimbi_reveal", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  level.player depth_of_field_off(0.1);
}

riverbed_skipto() {
  visionsetnaked("sp_angola_riverbed", 3);
  level.player depth_of_field_off(0.1);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  setsaveddvar("r_exposureValue", 3.0);
}

savannah_start() {
  visionsetnaked("sp_angola_savannah", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
}

savannah_hill() {
  visionsetnaked("sp_angola_savannah", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
}

savimbi_ride_along_on() {
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

savimbi_ride_along_off() {
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
}

savannah_finish() {
  visionsetnaked("sp_angola_savannah", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
}

river() {
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  visionsetnaked("sp_angola_2_river", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
}

heli_jump() {
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

river_barge() {
  visionsetnaked("sp_angola_2_river", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

vision_find_woods(m_player_body) {
  visionsetnaked("sp_angola_2_container_in", 5.0);
  level.map_default_sun_direction = getdvar(#"r_lightTweakSunDirection");
  level thread lerp_sun_direction((-95, 48, 0), 5);
}

vision_leave_container(m_player_body) {
  visionsetnaked("sp_angola_2_container_out", 2.0);
  wait 5;
  visionsetnaked("sp_angola_2_river", 0.5);
  level thread lerp_sun_direction((-36, 48, 0), 5);
}

lerp_sun_direction(v_pos, n_lerp_time) {
  v_start_pos = getdvarvector(#"r_lightTweakSunDirection");
  s_timer = new_timer();

  do {
    n_time_delta = s_timer timer_wait(0.05);
    n_curr_val = lerpvector(v_start_pos, v_pos, n_time_delta / n_lerp_time);
    setsaveddvar("r_lightTweakSunDirection", n_curr_val);
  }
  while(n_time_delta < n_lerp_time);
}

jungle_stealth() {
  vs_trigs = getentarray("visionset", "targetname");
  array_thread(vs_trigs, ::vision_set);
  visionsetnaked("sp_angola_2_jungle_stealth", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

village() {
  vs_trigs = getentarray("visionset", "targetname");
  array_thread(vs_trigs, ::vision_set);
  visionsetnaked("sp_angola_2_village", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

jungle_escape() {
  vs_trigs = getentarray("visionset", "targetname");
  array_thread(vs_trigs, ::vision_set);
  visionsetnaked("sp_angola_2_jungle_escape", 0.5);
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 4);
  n_sun_sample_size = 0.4;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

angola_2_dof_enter_hut(guy) {
  n_near_start = 0;
  n_near_end = 1;
  n_far_start = 1.2;
  n_far_end = 836;
  n_near_blur = 6;
  n_far_blur = 1.3;
  n_time = 0.3;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola_2_dof_gun_to_head(guy) {
  n_near_start = 0;
  n_near_end = 1;
  n_far_start = 1.2;
  n_far_end = 836;
  n_near_blur = 6;
  n_far_blur = 1.3;
  n_time = 0.3;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola_2_dof_jump_out(guy) {
  n_near_start = 0;
  n_near_end = 1;
  n_far_start = 1.2;
  n_far_end = 836;
  n_near_blur = 6;
  n_far_blur = 1.3;
  n_time = 0.3;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.0;
  level.player depth_of_field_off(0.1);
}

angola_2_finale_dof_hind(m_player_body) {
  n_near_start = 1;
  n_near_end = 1.5;
  n_far_start = 20.6;
  n_far_end = 1300;
  n_near_blur = 4;
  n_far_blur = 0.95;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola_2_finale_dof_enemy(m_player_body) {
  n_near_start = 1;
  n_near_end = 1.5;
  n_far_start = 20.6;
  n_far_end = 900;
  n_near_blur = 4;
  n_far_blur = 0.95;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola2_finale_dof1() {
  n_near_start = 0;
  n_near_end = 1;
  n_far_start = 7;
  n_far_end = 50;
  n_near_blur = 8;
  n_far_blur = 7.5;
  n_time = 0.1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola2_finale_dof2() {
  n_near_start = 2.5;
  n_near_end = 22;
  n_far_start = 130;
  n_far_end = 170;
  n_near_blur = 8;
  n_far_blur = 7.5;
  n_time = 1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola2_finale_dof3() {
  n_near_start = 0;
  n_near_end = 40;
  n_far_start = 100;
  n_far_end = 4000;
  n_near_blur = 6;
  n_far_blur = 5;
  n_time = 3.0;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

angola2_finale_hudson_ground() {
  n_near_start = 1;
  n_near_end = 1.5;
  n_far_start = 20.6;
  n_far_end = 350;
  n_near_blur = 4;
  n_far_blur = 0.95;
  n_time = 1;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  setsaveddvar("r_lightGridEnableTweaks", 1);
  level thread ramp_dvar("r_lightGridContrast", 0, -0.58, 5, 0.01);
  level thread ramp_dvar("r_lightTweakSunLight", 19, 12, 5, 0.1);
}

ramp_dvar(str_dvar, n_start, n_end, n_transition_time, n_increment_time) {
  if(!isDefined(n_transition_time))
    n_transition_time = 2;

  if(!isDefined(n_increment_time))
    n_increment_time = 0.1;

  assert(n_start != n_end, "Nothing to ramp for " + str_dvar + " because start value (" + n_start + ") equals end value (" + n_end + ")");

  if(n_transition_time <= 0)
    n_transition_time = 2;

  if(n_transition_time <= 0)
    n_increment_time = 0.1;

  n_iterations = n_transition_time / n_increment_time;
  n_new = n_start;

  if(n_start < n_end) {
    n_increment = (n_end - n_start) / n_iterations;

    while(true) {
      n_new = n_new + n_increment;

      if(n_new >= n_end) {
        setsaveddvar(str_dvar, n_end);
        break;
      }

      setsaveddvar(str_dvar, n_new);
      wait(n_increment_time);
    }
  } else if(n_start > n_end) {
    n_decrement = (n_start - n_end) / n_iterations;

    while(true) {
      n_new = n_new - n_decrement;

      if(n_new <= n_end) {
        setsaveddvar(str_dvar, n_end);
        break;
      }

      setsaveddvar(str_dvar, n_new);
      wait(n_increment_time);
    }
  }
}

lightgridcontrast_transition(n_contrast, n_contrast_transition_time, n_contrast_increment_time) {
  n_iterations = n_contrast_transition_time / n_contrast_increment_time;
  n_contrast_increment = abs((n_contrast - 0) / n_iterations);

  while(true) {
    n_contrast = n_contrast + n_contrast_increment;

    if(n_contrast >= 0) {
      n_contrast = 0;
      setsaveddvar("r_lightGridContrast", n_contrast);
      break;
    }

    setsaveddvar("r_lightGridContrast", n_contrast);
    wait(n_contrast_increment_time);
  }
}

heli_run_dof_on() {
  n_near_start = 0;
  n_near_end = 80;
  n_far_start = 1000;
  n_far_end = 12000;
  n_near_blur = 6;
  n_far_blur = 1.8;
  n_time = 0.25;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

heli_run_dof_off() {
  level.player depth_of_field_off(0.25);
}

set_water_dvars_strafe() {
  setdvar("r_waterwavespeed", "0.470637 0.247217 1 1");
  setdvar("r_waterwaveamplitude", "2.8911 0 0 0");
  setdvar("r_waterwavewavelength", "9.71035 3.4 1 1");
  setdvar("r_waterwaveangle", "56.75 237.203 0 0");
  setdvar("r_waterwavephase", "0 2.6 0 0");
  setdvar("r_waterwavesteepness", "0 0 0 0");
  setdvar("r_waterwavelength", "9.71035 3.40359 1 1");
}

hiding_log_dof_start(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 60.1;
  n_far_end = 1310;
  n_near_blur = 4;
  n_far_blur = 0.76;
  n_time = 8;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

hiding_log_dof_end(m_player_body) {
  n_near_start = 1;
  n_near_end = 60;
  n_far_start = 60.1;
  n_far_end = 1310;
  n_near_blur = 4;
  n_far_blur = 0.76;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.0;
  level.player depth_of_field_off(0.1);
}

victory_ending_dof_start(m_player_body) {
  n_near_start = 1;
  n_near_end = 15;
  n_far_start = 20.6;
  n_far_end = 1310;
  n_near_blur = 4;
  n_far_blur = 0.76;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

victory_ending_dof_end(m_player_body) {
  n_near_start = 1;
  n_near_end = 15;
  n_far_start = 20.6;
  n_far_end = 1310;
  n_near_blur = 4;
  n_far_blur = 0.76;
  n_time = 0.5;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1.0;
  level.player depth_of_field_off(0.1);
}

vision_set() {
  time = 2.0;

  if(isDefined(self.script_float))
    time = self.script_float;

  while(true) {
    self waittill("trigger");
    player = get_players()[0];

    if(player getvisionsetnaked() != self.script_noteworthy)
      visionsetnaked(self.script_noteworthy, time);
  }
}