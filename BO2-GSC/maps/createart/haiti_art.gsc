/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\haiti_art.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 8);
  vs_trigs = getentarray("visionset", "targetname");
  array_thread(vs_trigs, ::vision_set);
}

vision_set_trigger_think() {
  self endon("death");

  while(true) {
    self waittill("trigger");

    if(level.haiti_vision != self.script_string)
      vision_set_change(self.script_string);

    wait 0.1;
  }
}

vision_set_change(str_vision_set) {
  n_vs_time = 2;
  n_near_start = undefined;
  n_near_end = undefined;
  n_far_start = undefined;
  n_far_end = undefined;
  n_near_blur = undefined;
  n_far_blur = undefined;
  n_time = undefined;

  switch (str_vision_set) {
    case "sp_haiti_intro":
      setdvar("r_rimIntensity_debug", 1);
      setdvar("r_rimIntensity", 15);
  }

  visionsetnaked(str_vision_set, n_vs_time);
  level.haiti_vision = str_vision_set;
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

vtol_interior() {
  visionsetnaked("sp_haiti_vtol_interior", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  setsaveddvar("sm_sunAlwaysCastsShadow", 1);
  setsaveddvar("r_lightTweakSunDirection", (-5, 115, 0));
  wait 45;
  setsaveddvar("r_lightTweakSunDirection", (-38, 130.8, 0));
}

vtol_interior_door_open() {
  visionsetnaked("sp_haiti_vtol_interior", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

skydive_pre_gameplay() {
  visionsetnaked("sp_haiti_skydive_pre_gameplay", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
  setsaveddvar("sm_sunAlwaysCastsShadow", 0);
  setsaveddvar("r_lightTweakSunDirection", (-38, 130.8, 0));
}

skydive_section_01() {
  visionsetnaked("sp_haiti_skydive_section_01", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

skydive_section_02() {
  visionsetnaked("sp_haiti_skydive_section_01", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

skydive_landing() {
  visionsetnaked("sp_haiti_landing", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

ground() {
  visionsetnaked("sp_haiti_ground", 0.1);
  setdvar("r_rimIntensity", 8);
  n_sun_sample_size = 0.5;
  setsaveddvar("sm_sunSampleSizeNear", n_sun_sample_size);
}

slip_and_slide() {
  setsaveddvar("r_skyTransition", 1);
  setsunlight(1, 0.85, 0.618);
}

team_america() {
  visionsetnaked("sp_haiti_team_america", 1);
  setsaveddvar("r_lightTweakSunDirection", (-38, 83, 0));
}

dof_vtol_1(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 10000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_quadrotor(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_vtol_2(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 10000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_drag_guy_1(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_drag_guy_2(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_kid_helper(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_kids(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_vtol_liftoff(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 0;
  n_time = 4;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_vtol_flight(m_player_body) {
}

dof_sunset(m_player_body) {
}

dof_harper(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 5;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_look_down(m_player_body) {
  n_near_start = 0;
  n_near_end = 40;
  n_far_start = 200;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_menendez_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 2;
  n_far_start = 200;
  n_far_end = 500;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_defalco_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 300;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 2;
  n_far_start = 100;
  n_far_end = 300;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_gun_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 50;
  n_far_end = 150;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_back_to_hanging(m_player_body) {
  n_near_start = 0;
  n_near_end = 40;
  n_far_start = 200;
  n_far_end = 500;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_land(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_pmc2_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 5;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_pmc1_closeup(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 5;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_stab_menendez(m_player_body) {
  n_near_start = 0;
  n_near_end = 5;
  n_far_start = 5;
  n_far_end = 100;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_faraway(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_1(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_2(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_track_3(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_4(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 2000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_passing_gaurd(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_harper_capture(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_menendez_capture(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_focus_on_hands(m_player_body) {
  n_near_start = 5;
  n_near_end = 12;
  n_far_start = 50;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_start(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_walk_out(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 1;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_walk_menendez(m_player_body) {
  n_near_start = 0;
  n_near_end = 10;
  n_far_start = 100;
  n_far_end = 1000;
  n_near_blur = 6;
  n_far_blur = 0.2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

dof_vtol_leave(m_player_body) {
  n_near_start = 0;
  n_near_end = 16;
  n_far_start = 100;
  n_far_end = 20000;
  n_near_blur = 6;
  n_far_blur = 0;
  n_time = 4;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

vision_open_doors(m_player_body) {
  level thread lerp_sun_direction((-38, 81, 0), 20);
}

lerp_sun_direction(v_pos, n_lerp_time) {
  v_start_pos = (-38, 182, 0);
  s_timer = new_timer();

  do {
    n_time_delta = s_timer timer_wait(0.05);
    n_curr_val = lerpvector(v_start_pos, v_pos, n_time_delta / n_lerp_time);
    setsaveddvar("r_lightTweakSunDirection", n_curr_val);
  }
  while(n_time_delta < n_lerp_time);
}