/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_player_rappel.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;

rappel_precache() {
  precachemodel("viewmodel_hands_no_model");
}

rappel_start(s_aligned) {
  assert(isDefined(s_aligned), "s_aligned is a required parameter for rappel_start");

  if(!isDefined(self._rappel))
    self rappel_init_2h();

  if(isDefined(self._rappel.anims.rappel_viewmodel)) {
    str_viewmodel = self._rappel.anims.rappel_viewmodel;
    assert(isassetloaded("xmodel", str_viewmodel), str_viewmodel + " xmodel is not loaded in memory. make sure custom viewarms are precached before using rappel_start!");
  }

  self._rappel _rappel_init_status(s_aligned);
  self _rappel_hook_up(s_aligned);
  self _rappel_control_start(s_aligned);
}

rappel_init_1h() {
  rappel_init_2h();
  _rappel_setup_default_anims_1h();
  self._rappel.controls.allow_weapons = 1;
  self._rappel.controls.is_2h_rappel = 0;
  self._rappel.strings.rappel_hint = "Press and hold [{+speed_throw}] to rappel";
  self._rappel.strings.brake_hint = "Release [{+speed_throw}] to brake";
  self._rappel.movement.enable_rotation = 0;
  self._rappel.movement.is_wall_rappel = 0;
  self._rappel.viewcone.link_tag = "tag_player";
  self._rappel.viewcone.right_arc = 90;
  self._rappel.viewcone.left_arc = 50;
  self._rappel.viewcone.top_arc = 80;
  self._rappel.viewcone.bottom_arc = 80;
  self._rappel.viewcone.use_tag_angles = 1;
  self._rappel.viewcone.use_absolute = 0;
  self._rappel.difficulty.can_fail = 1;
  self._rappel.movement.acceleration = -50;
  self._rappel.movement.brake_frames_max = 15;
  self._rappel.controls.should_grab_rope = 0;
  self._rappel.movement.should_charge = 0;
  self._rappel.movement.disable_decend_until_notify = undefined;
  self._rappel.movement.threshold_to_ground = 55;
  self._rappel.controls.should_switch_to_sidearm = 0;
  self._rappel.anims.rappel_viewmodel = "viewmodel_hands_no_model";
}

rappel_init_2h() {
  self._rappel = spawnstruct();
  _rappel_setup_default_anims_2h();
  self._rappel _rappel_init_controls();
  self._rappel _rappel_init_anims();
  self._rappel _rappel_init_depth_of_field();
  self._rappel _rappel_init_movement();
  self._rappel _rappel_init_viewcone();
  self._rappel _rappel_init_status();
  self._rappel _rappel_init_difficulty();
  self._rappel _rappel_init_strings();
  self._rappel.ent = spawn("script_origin", self.origin);
  return self._rappel;
}

rappel_set_wall_rappel(b_is_wall_rappel, n_kick_strength_min, n_kick_strength_max) {
  assert(isDefined(b_is_wall_rappel), "b_is_wall_rappel parameter missing for rappel_set_wall_rappel");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_wall_rappel");
  self._rappel.movement.is_wall_rappel = b_is_wall_rappel;

  if(isDefined(n_kick_strength_min) && isDefined(n_kick_strength_max)) {
    self._rappel.movement.impulse_min = n_kick_strength_min;
    self._rappel.movement.impulse_max = n_kick_strength_max;
  }
}

rappel_set_control_scheme(func_rappel, func_brake) {
  assert(isDefined(func_rappel), "func_rappel is missing in rappel_set_control_scheme!");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_control_scheme");

  if(self _is_2h_rappel() && !isDefined(func_brake)) {
    assertmsg("func_brake is a required parameter for two-handed rappels in rappel_set_control_scheme!");

  }

  self._rappel.controls.rappel_button = func_rappel;

  if(isDefined(func_brake))
    self._rappel.controls.rappel_brake_button = func_brake;
}

rappel_set_can_fail(b_can_fail, n_drop_speed_before_fail) {
  assert(isDefined(b_can_fail), "b_can_fail is missing in rappel_set_can_fail!");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_can_fail");
  self._rappel.difficulty.can_fail = b_can_fail;

  if(isDefined(n_drop_speed_before_fail))
    self._rappel.movement.drop_speed_max = n_drop_speed_before_fail;
}

rappel_set_drop_and_stop_parameters(n_speed_drop, n_brake_time_min, n_brake_time_max) {
  assert(isDefined(n_speed_drop), "n_speed_drop is a required parameter for rappel_set_drop_and_stop_parameters");
  assert(isDefined(n_brake_time_min), "n_brake_time_min is a required parameter for rappel_set_drop_and_stop_parameters");
  assert(isDefined(n_brake_time_max), "n_brake_time_max is a required parameter for rappel_set_drop_and_stop_parameters");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_drop_and_stop_parameters");
  assert(n_brake_time_min > 0, "n_brake_time_min must be at least one frame in duration");
  assert(n_brake_time_max > n_brake_time_min, "n_brake_time_max must exceed n_brake_time_min in rappel_set_drop_and_stop_parameters");
  self._rappel.movement.acceleration = abs(n_speed_drop) * -1;
  n_brake_frames_min = int(ceil(n_brake_time_min * 20));
  self._rappel.movement.brake_frames_min = n_brake_frames_min;
  n_brake_frames_max = int(n_brake_time_max * 20);
  self._rappel.movement.brake_frames_max = n_brake_frames_max;
}

rappel_set_ground_tolerance_height(n_height) {
  assert(isDefined(n_height), "n_height is a required parameter in rappel_set_ground_tolerance_height");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_ground_tolerance_height");
  self._rappel.movement.threshold_to_ground = n_height;
}

rappel_set_clear_data_after_landing(b_should_clear_data) {
  assert(isDefined(b_should_clear_data), "b_should_clear_data is a required parameter for rappel_set_clear_data_after_landing");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_ground_tolerance_height");
  self._rappel.status.cleanup_after_landing = b_should_clear_data;
}

rappel_set_hint_strings(str_rappel_message, str_brake_message) {
  assert(isDefined(str_rappel_message), "str_rappel_message is a required parameter for rappel_set_hint_strings");
  assert(isDefined(str_brake_message), "str_brake_message is a required parameter for rappel_set_hint_strings");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_hint_strings");
  self._rappel.strings.rappel_hint = str_rappel_message;
  self._rappel.strings.brake_hint = str_brake_message;
}

rappel_set_falling_death_quote(str_deadquote) {
  assert(isDefined(str_deadquote), "str_deadquote is a required parameter for rappel_set_falling_death_quote");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". Run rappel_init_1h or rappel_init_2h before running this function!");
  self._rappel.strings.death_string = str_deadquote;
}

rappel_set_viewcone(n_right_arc, n_left_arc, n_top_arc, n_bottom_arc, b_use_tag_angles) {
  assert(isDefined(n_right_arc), "n_right_arc is a required parameter for rappel_set_viewcone");
  assert(isDefined(n_left_arc), "n_left_arc is a required parameter for rappel_set_viewcone");
  assert(isDefined(n_top_arc), "n_top_arc is a required parameter for rappel_set_viewcone");
  assert(isDefined(n_bottom_arc), "n_bottom_arc is a required parameter for rappel_set_viewcone");
  assert(isDefined(b_use_tag_angles), "b_use_tag_angles is a required parameter for rappel_set_viewcone");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_viewcone");
  self._rappel.viewcone.use_absolute = 0;
  self._rappel.viewcone.right_arc = n_right_arc;
  self._rappel.viewcone.left_arc = n_left_arc;
  self._rappel.viewcone.top_arc = n_top_arc;
  self._rappel.viewcone.bottom_arc = n_bottom_arc;
  self._rappel.viewcone.use_tag_angles = b_use_tag_angles;
}

rappel_set_depth_of_field_parameters(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur) {
  assert(isDefined(n_near_start), "n_near_start is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(n_near_end), "n_near_end is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(n_far_start), "n_far_start is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(n_far_end), "n_far_end is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(n_near_blur), "n_near_blur is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(n_far_blur), "n_far_blur is a required parameter for rappel_set_depth_of_field_parameters!");
  assert(isDefined(self._rappel), "rappel struct has not been set up on entity " + self getentitynumber() + ". run rappel_init_1h or rappel_init_2h prior to rappel_set_depth_of_field_parameters!");
  self._rappel.depth_of_field.near_start = n_near_start;
  self._rappel.depth_of_field.near_end = n_near_end;
  self._rappel.depth_of_field.far_start = n_far_start;
  self._rappel.depth_of_field.far_end = n_far_end;
  self._rappel.depth_of_field.near_blur = n_near_blur;
  self._rappel.depth_of_field.far_blur = n_far_blur;
}

rappel_get_data_struct() {
  assert(isDefined(self._rappel), "rappel data is not set up on entity " + self getentitynumber() + "! Run rappel_init functions on this entity before attempting to access rappel data");
  s_rappel_data = self._rappel;
  return s_rappel_data;
}

rappel_set_data_struct(s_rappel_data) {
  assert(isDefined(s_rappel_data), "s_rappel_data is a required parameter for rappel_set_data_struct");
  self._rappel = s_rappel_data;

  if(!isDefined(self._rappel.ent))
    self._rappel.ent = spawn("script_origin", self.origin);
}

rappel_update_anim_set(a_anims) {
  assert(isDefined(a_anims), "a_anims is a required parameter for rappel_update_anim_set");

  if(isDefined(a_anims["hookup"]))
    self._rappel.anims.rappel_start = a_anims["hookup"];

  if(isDefined(a_anims["idle_hang"]))
    self._rappel.anims.idle_loop = a_anims["idle_hang"];

  if(isDefined(a_anims["charge"]))
    self._rappel.anims.charge = a_anims["charge"];

  if(isDefined(a_anims["charge_loop"]))
    self._rappel.anims.charge_loop = a_anims["charge_loop"];

  if(isDefined(a_anims["kickoff"]))
    self._rappel.anims.push = a_anims["kickoff"];

  if(isDefined(a_anims["brake"]))
    self._rappel.anims.brake = a_anims["brake"];

  if(isDefined(a_anims["brake_loop"]))
    self._rappel.anims.brake_loop = a_anims["brake_loop"];

  if(isDefined(a_anims["fall_start"]))
    self._rappel.anims.fall = a_anims["fall_start"];

  if(isDefined(a_anims["fall_loop"]))
    self._rappel.anims.fall_loop = a_anims["fall_loop"];

  if(isDefined(a_anims["fall_ground_hit"]))
    self._rappel.anims.fall_splat = a_anims["fall_ground_hit"];

  if(isDefined(a_anims["land"]))
    self._rappel.anims.land = a_anims["land"];
}

rappel_set_viewmodel(str_viewmodel_name) {
  assert(isDefined(str_viewmodel_name), "str_viewmodel_name is a required parameter for rappel_set_viewmodel!");
  assert(isDefined(self._rappel), "player rappel is not set up on entity " + self getentitynumber() + "! make sure to run rappel_init_1h or rappel_init_2h before calling rappel_set_viewmodel");
  assert(isassetloaded("xmodel", str_viewmodel_name), "rappel_set_viewmodel could not find xmodel" + str_viewmodel_name + " loaded in memory. Load this in your level CSV!");
  self._rappel.anims.rappel_viewmodel = str_viewmodel_name;
}

rappel_pause() {
  assert(isDefined(self._rappel), "rappel not initialized on entity " + self getentitynumber() + "! Call rappel_init_1h or rappel_init_2h before using rappel_pause");
  screen_message_delete();
  self._rappel.status.can_rappel_now = 0;
}

rappel_resume() {
  assert(isDefined(self._rappel), "rappel not initialized on entity " + self getentitynumber() + "! Call rappel_init_1h or rappel_init_2h before using rappel_resume");
  _rappel_print_controls_full();
  self._rappel.status.can_rappel_now = 1;
}

rappel_play_custom_anim(str_animname, n_blend_time_to_idle) {
  self endon("death");
  self endon("_rappel_safe_landing");
  assert(isDefined(str_animname), "str_animname is a required parameter for rappel_play_custom_anim");
  assert(isDefined(level.scr_anim["player_body"][str_animname]), str_animname + " is not set up in level.scr_anim['player_body']! Add this reference before using rappel_play_custom_anim!");
  assert(isDefined(self._rappel), "rappel not initialized on entity " + self getentitynumber() + "! Call rappel_init_1h or rappel_init_2h before using rappel_play_custom_anim");
  assert(!self._rappel.status.can_rappel_now, "rappel_play_custom_anim() called while rappel controls were active. call rappel_pause() before rappel_play_custom_anim()!");

  while(self._rappel.status.is_descending)
    wait 0.05;

  str_idle_loop = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.idle_loop][0];
  str_idle_stop_notify = self._rappel.anims.idle_stop_notify;

  if(!isDefined(n_blend_time_to_idle))
    n_blend_time_to_idle = 1;

  self disableweapons();
  self unlink();
  self _rappel_player_link(self.body, 1);
  self.body maps\_anim::anim_single(self.body, str_animname);
  self.body anim_stopanimscripted();
  wait 0.05;
  self _rappel_enable_weapons_if_allowed();
  self.body setanim(str_idle_loop, 1, n_blend_time_to_idle);
  self unlink();
  self _rappel_player_link(self.body);
}

#using_animtree("player");

_rappel_setup_default_anims_2h() {
  level.scr_model["player_body"] = level.player_interactive_model;
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["rappel_hookup"] = % int_rappel_hookup;
  level.scr_anim["player_body"]["player_rappel_idle"][0] = % int_rappel_idle;
  level.scr_anim["player_body"]["player_rappel_compress"] = % int_rappel_compress;
  level.scr_anim["player_body"]["player_rappel_compress_loop"][0] = % int_rappel_compress_loop;
  level.scr_anim["player_body"]["player_rappel_kickoff"] = % int_rappel_kickoff;
  level.scr_anim["player_body"]["player_rappel_brake"] = % int_rappel_brake;
  level.scr_anim["player_body"]["player_rappel_brake_loop"][0] = % int_rappel_brake_loop;
  level.scr_anim["player_body"]["player_rappel_2_fall"] = % int_rappel_2_fall;
  level.scr_anim["player_body"]["player_rappel_fall_loop"][0] = % int_rappel_fall_loop;
  level.scr_anim["player_body"]["player_rappel_fall_hit_a"] = % int_rappel_fall_hit_a;
  level.scr_anim["player_body"]["player_rappel_land"] = % ch_wmd_b01_player_control_rappel_land;
}

_rappel_anim_loaded_check() {
  s_anims = self._rappel.anims;
  a_animations = array(s_anims.rappel_start, s_anims.idle_loop, s_anims.charge, s_anims.charge_loop, s_anims.push, s_anims.brake, s_anims.brake_loop, s_anims.land);

  if(self._rappel.difficulty.can_fail) {
    a_animations[a_animations.size] = s_anims.fall;
    a_animations[a_animations.size] = s_anims.fall_loop;
    a_animations[a_animations.size] = s_anims.fall_splat;
  }

  a_keys = getarraykeys(a_animations);

  for(i = 0; i < a_keys.size; i++) {
    str_anim = level.scr_anim[self._rappel.anims.body_model][a_animations[a_keys[i]]];
    assert(isassetloaded("xanim", str_anim), str_anim + " is not loaded into memory for use with the player rappel system. Include it in your level CSV!");
  }
}

_rappel_setup_default_anims_1h() {
  level.scr_model["player_body"] = level.player_interactive_model;
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["rappel_hookup"] = % int_rappel_hookup;
  level.scr_anim["player_body"]["player_rappel_idle"][0] = % int_rappel_idle;
  level.scr_anim["player_body"]["player_rappel_compress"] = % int_rappel_compress;
  level.scr_anim["player_body"]["player_rappel_compress_loop"][0] = % int_rappel_compress_loop;
  level.scr_anim["player_body"]["player_rappel_kickoff"] = % int_rappel_kickoff;
  level.scr_anim["player_body"]["player_rappel_brake"] = % int_rappel_brake;
  level.scr_anim["player_body"]["player_rappel_brake_loop"][0] = % int_rappel_brake_loop;
  level.scr_anim["player_body"]["player_rappel_2_fall"] = % int_rappel_2_fall;
  level.scr_anim["player_body"]["player_rappel_fall_loop"][0] = % int_rappel_fall_loop;
  level.scr_anim["player_body"]["player_rappel_fall_hit_a"] = % int_rappel_fall_hit_a;
  level.scr_anim["player_body"]["player_rappel_land"] = % ch_wmd_b01_player_control_rappel_land;
}

_rappel_init_strings() {
  self.strings = spawnstruct();
  self.strings.rappel_1h_grab = "Press [{+speed_throw}] to grab rappel rope";
  self.strings.rappel_hint = "Charge and release [{+speed_throw}] to rappel";
  self.strings.brake_hint = "Hold [{+attack}] to brake";
  self.strings.death_string = "You fell to your death. Try braking earlier to slow your fall.";
}

_rappel_init_difficulty() {
  self.difficulty = spawnstruct();
  self.difficulty.can_fail = 1;
}

_rappel_init_status(s_aligned) {
  if(isDefined(self.status))
    self.status = undefined;

  self.status = spawnstruct();
  self.status.is_rotating = 0;
  self.status.is_descending = 0;
  self.status.is_near_ground = 0;
  self.status.is_braking = 0;
  self.status.falling_to_death = 0;
  self.status.can_rappel_now = 1;
  self.status.on_ground = 0;
  self.status.cleanup_after_landing = 1;
  self.status.ground_position = undefined;
  self.status.frames_since_jump = 0;

  if(isDefined(s_aligned))
    self.status.reference_node = s_aligned;
}

_rappel_init_controls() {
  self.controls = spawnstruct();
  self.controls.rappel_button = ::_check_rappel_button;
  self.controls.rappel_brake_button = ::_check_rappel_brake_button;
  self.controls.allow_weapons = 0;
  self.controls.is_2h_rappel = 1;
  self.controls.should_switch_to_sidearm = 0;
}

_rappel_init_anims() {
  self.anims = spawnstruct();
  self.anims.anim_tag = "tag_player";
  self.anims.body_model = "player_body";
  self.anims.rappel_start = "rappel_hookup";
  self.anims.rappel_1h_grab_notify = "rope_grab";
  self.anims.idle_loop = "player_rappel_idle";
  self.anims.idle_stop_notify = "stop_rappel_idle_loop";
  self.anims.charge = "player_rappel_compress";
  self.anims.charge_loop = "player_rappel_compress_loop";
  self.anims.push = "player_rappel_kickoff";
  self.anims.brake = "player_rappel_brake";
  self.anims.brake_loop = "player_rappel_brake_loop";
  self.anims.fall = "player_rappel_2_fall";
  self.anims.fall_loop = "player_rappel_fall_loop";
  self.anims.fall_splat = "player_rappel_fall_hit_a";
  self.anims.land = "player_rappel_land";
}

_rappel_init_depth_of_field() {
  self.depth_of_field = spawnstruct();
  self.depth_of_field.near_start = 5;
  self.depth_of_field.near_end = 33;
  self.depth_of_field.far_start = 0;
  self.depth_of_field.far_end = 0;
  self.depth_of_field.near_blur = 4;
  self.depth_of_field.far_blur = 0;
}

_rappel_set_depth_of_field(e_player) {
  assert(isDefined(e_player), "e_player is a required parameter for _rappel_set_depth_of_field!");
  assert(isDefined(e_player._rappel), "rappel struct is not set up on entity " + e_player getentitynumber() + "! Make sure to run rappel_init_1h or rappel_init_2h before calling _rappel_set_depth_of_field!");
  e_player setdepthoffield(self.near_start, self.near_end, self.far_start, self.far_end, self.near_blur, self.far_blur);
}

_rappel_get_depth_of_field_old() {
  self._rappel.depth_of_field_old = spawnstruct();
  self._rappel.depth_of_field_old.near_start = self getdepthoffield_nearstart();
  self._rappel.depth_of_field_old.near_end = self getdepthoffield_nearend();
  self._rappel.depth_of_field_old.near_blur = self getdepthoffield_nearblur();
  self._rappel.depth_of_field_old.far_blur = self getdepthoffield_farblur();
  self._rappel.depth_of_field_old.far_start = self getdepthoffield_farstart();
  self._rappel.depth_of_field_old.far_end = self getdepthoffield_farend();
}

_rappel_init_viewcone() {
  self.viewcone = spawnstruct();
  self.viewcone.link_tag = "tag_player";
  self.viewcone.percentage = 0;
  self.viewcone.right_arc = 0;
  self.viewcone.left_arc = 0;
  self.viewcone.top_arc = 0;
  self.viewcone.bottom_arc = 0;
  self.viewcone.use_tag_angles = 1;
  self.viewcone.use_absolute = 1;
  self.viewcone.threshold_edge = 1;
}

_rappel_init_movement() {
  self.movement = spawnstruct();
  self.movement.rotate_speed = 10;
  self.movement.threshold_to_ground = 55;
  self.movement.enable_rotation = 0;
  self.movement.is_wall_rappel = 1;
  self.movement.acceleration = -85;
  self.movement.impulse_min = 160;
  self.movement.impulse_max = 260;
  self.movement.drop_speed_max = 60;
  self.movement.brake_frames_min = 1;
  self.movement.brake_frames_max = 30;
  self.movement.should_charge = 1;
}

_check_rappel_button() {
  b_is_rappelling = self throwbuttonpressed();
  return b_is_rappelling;
}

_check_rappel_brake_button() {
  b_is_braking = self attackbuttonpressed();
  return b_is_braking;
}

_descent_control_active() {
  b_is_2h_rappel = self _is_2h_rappel();

  if(b_is_2h_rappel)
    b_control_active = self _is_pressing_rappel_button();
  else
    b_control_active = self _is_pressing_rappel_button();

  return b_control_active;
}

_is_pressing_rappel_button() {
  b_is_rappelling = 0;

  if(self _is_2h_rappel()) {
    if(self[[self._rappel.controls.rappel_button]]())
      b_is_rappelling = 1;
  } else if(self[[self._rappel.controls.rappel_button]]())
    b_is_rappelling = 1;

  return b_is_rappelling;
}

_rappel_hook_up(s_aligned) {
  self disableweapons();
  self playsound("evt_rappel_hookup");
  self.body = spawn_anim_model(self._rappel.anims.body_model, self.origin);
  self.body.angles = self.angles;
  self.body hide();
  self thread _1h_rappel_start(s_aligned);
  s_aligned thread maps\_anim::anim_single_aligned(self.body, self._rappel.anims.rappel_start);
  wait 0.05;
  self startcameratween(0.2);
  self _rappel_player_link(self.body, 1);
  wait 0.3;
  self.body show();
  self _rappel_get_depth_of_field_old();
  self._rappel.depth_of_field _rappel_set_depth_of_field(self);
  self thread _rappel_switch_to_sidearm();
  s_aligned waittill(self._rappel.anims.rappel_start);
  self notify("rappel_hookup_done");
}

_1h_rappel_start(s_aligned) {
  b_is_2h_rappel = self _is_2h_rappel();
  b_require_input_for_grab = self._rappel.controls.should_grab_rope;

  if(!b_is_2h_rappel && b_require_input_for_grab) {
    str_hookup_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.rappel_start];
    n_hookup_anim_length = getanimlength(str_hookup_anim);
    n_hookup_control_delay = n_hookup_anim_length * 0.95;
    n_notify_delay = n_hookup_anim_length - n_hookup_control_delay;
    str_grab_notify = self._rappel.anims.rappel_1h_grab_notify;
    self waittill_notify_or_timeout(str_grab_notify, n_hookup_control_delay);
    self.body setanimlimited(str_hookup_anim, 1, 0, 0);
    screen_message_create(self._rappel.strings.rappel_1h_grab);

    while(!self _is_pressing_rappel_button())
      wait 0.05;

    self.body setanimlimited(str_hookup_anim, 1, 0, 1);
    screen_message_delete();
    wait(n_notify_delay);
    s_aligned notify(self._rappel.anims.rappel_start);
  }
}

_rappel_player_link(e_to_link, b_no_viewlook) {
  assert(isDefined(e_to_link), "_rappel_player_link is missing e_to_link parameter");

  if(!isDefined(b_no_viewlook))
    b_no_viewlook = 0;

  b_use_absolute = self._rappel.viewcone.use_absolute;

  if(b_use_absolute)
    self playerlinktoabsolute(e_to_link, self._rappel.viewcone.link_tag);
  else if(!b_use_absolute && b_no_viewlook)
    self playerlinktodelta(e_to_link, self._rappel.viewcone.link_tag, 80, 0, 0, 0, 0, 1);
  else
    self playerlinktodelta(e_to_link, self._rappel.viewcone.link_tag, self._rappel.viewcone.percentage, self._rappel.viewcone.right_arc, self._rappel.viewcone.left_arc, self._rappel.viewcone.top_arc, self._rappel.viewcone.bottom_arc, self._rappel.viewcone.use_tag_angles);
}

_rappel_print_controls_full() {
  screen_message_delete();
  str_line_1 = self._rappel.strings.rappel_hint;
  str_line_2 = self._rappel.strings.brake_hint;
  screen_message_create(str_line_1, str_line_2);
}

_rappel_controls_print_brake() {
  screen_message_delete();
  str_brake = self._rappel.strings.brake_hint;

  if(isDefined(str_brake) && str_brake != "")
    screen_message_create(str_brake);
}

_rappel_control_start(s_aligned) {
  self endon("_rappel_falling_death");
  _rappel_print_controls_full();
  self unlink();
  self _rappel_player_link(self.body);
  self._rappel.ent.origin = self.origin;
  self._rappel.ent.angles = self getplayerangles();
  self.body linkto(self._rappel.ent);
  self.body thread maps\_anim::anim_loop(self.body, self._rappel.anims.idle_loop, self._rappel.anims.idle_stop_notify);

  if(isDefined(self._rappel.anims.rappel_viewmodel))
    self setviewmodel(self._rappel.anims.rappel_viewmodel);

  self _rappel_enable_weapons_if_allowed();

  if(isDefined(self._rappel.movement.disable_decend_until_notify))
    self waittill(self._rappel.movement.disable_decend_until_notify);

  self allowads(0);

  while(!self._rappel.status.is_near_ground) {
    if(self _descent_control_active() && !self._rappel.status.is_descending && self._rappel.status.can_rappel_now) {
      self thread _rappel_descend();
      self thread decend_sound();
    }

    if(self._rappel.movement.enable_rotation) {
      v_angles_player_forward = self.angles;
      v_angles_player_forward = anglestoforward(v_angles_player_forward);
      v_angles_player_forward = _rappel_vector_remove_z(v_angles_player_forward);
      v_angles_body_forward = anglestoforward(self.body.angles);
      v_angles_body_forward = _rappel_vector_remove_z(v_angles_body_forward);
      v_angles_body_right = anglestoright(self.body.angles);
      n_dot_forward_view = vectordot(v_angles_body_forward, v_angles_player_forward);
      n_degrees_from_center = acos(n_dot_forward_view);
      n_dot_right = vectordot(v_angles_body_right, v_angles_player_forward);
      b_is_looking_right = n_dot_right > 0;
      n_viewcone_left = self._rappel.viewcone.left_arc;
      n_viewcone_right = self._rappel.viewcone.right_arc;
      b_at_left_edge = !b_is_looking_right && self._rappel.viewcone.left_arc - self._rappel.viewcone.threshold_edge < n_degrees_from_center;
      b_at_right_edge = b_is_looking_right && self._rappel.viewcone.right_arc - self._rappel.viewcone.threshold_edge < n_degrees_from_center;
      v_movement = self getnormalizedcameramovement();
      n_movement_y = v_movement[1];

      if(b_at_left_edge) {
        if(n_movement_y <= -0.2 && !self._rappel.status.is_rotating) {
          iprintlnbold("rotating left");
          self thread _rappel_rotate_origin(20);
        }
      } else if(b_at_right_edge) {
        if(n_movement_y >= 0.2 && !self._rappel.status.is_rotating) {
          iprintlnbold("rotating right");
          self thread _rappel_rotate_origin(20 * -1);
        }
      }
    }

    wait 0.05;
  }

  self _rappel_landing();
  self _rappel_cleanup();
}

_rappel_enable_weapons_if_allowed() {
  if(self._rappel.controls.allow_weapons) {
    self showviewmodel();
    self enableweapons();
  }
}

_rappel_switch_to_sidearm() {
  if(self._rappel.controls.should_switch_to_sidearm) {
    a_weapon_list = self getweaponslist();

    for(i = 0; i < a_weapon_list.size; i++) {
      str_class = weaponclass(a_weapon_list[i]);

      if(str_class == "pistol")
        self switchtoweapon(a_weapon_list[i]);
    }
  }
}

_rappel_landing() {
  screen_message_delete();
  level.player stoploopsound(0.25);
  level.player playsound("fly_land_plr_default");

  if(!self._rappel.status.falling_to_death) {
    self notify("_rappel_safe_landing");
    self disableweapons();
    self reset_near_plane();
    self.body clearanim( % root, 0.2);
    self.body maps\_anim::anim_single(self.body, self._rappel.anims.land);
    self unlink();
    self.body hide();
    self.body delete();
    self allowads(1);

    if(isDefined(self._rappel.anims.rappel_viewmodel)) {
      str_viewmodel = level.player_viewmodel;
      self setviewmodel(str_viewmodel);
    }

    self._rappel.depth_of_field_old _rappel_set_depth_of_field(self);
    self enableweapons();
  }
}

_rappel_cleanup() {
  if(self._rappel.status.cleanup_after_landing) {
    self._rappel.ent delete();
    self._rappel = undefined;
  }
}

decend_sound() {
  self endon("_rappel_safe_landing");

  if(self._rappel.status.is_descending == 1)
    level.player playloopsound("evt_rappel_slide");
  else
    level.player stoploopsound(0.25);
}

_rappel_descend() {
  assert(isDefined(self._rappel), "rappel struct not set up! can't use _rappel_descend");
  self._rappel.status.is_descending = 1;
  n_charge_time = 0;
  b_is_fully_charged = 0;
  str_idle_loop = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.idle_loop][0];
  str_charge_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.charge];
  n_charge_anim_length = getanimlength(str_charge_anim);
  str_charge_loop_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.charge_loop][0];
  b_should_charge = self._rappel.movement.should_charge;
  self.body anim_stopanimscripted();

  if(b_should_charge) {
    self.body setanim(str_charge_anim, n_charge_anim_length);
    self thread notify_delay_with_ender("_rappel_start_charge_loop", n_charge_anim_length, "_rappel_jump_start");
    self thread _rappel_charge_loop_starter(str_charge_loop_anim, 1);

    while(self _is_pressing_rappel_button() && b_should_charge) {
      n_charge_time = n_charge_time + 0.05;
      wait 0.05;
    }
  }

  if(!isDefined(self._rappel.status.ground_position))
    self._rappel.status.ground_position = self _rappel_get_ground_trace_position();

  _rappel_controls_print_brake();

  if(n_charge_time >= 1) {
    n_charge_time = 1;
    b_is_fully_charged = 1;
  }

  self thread _rappel_jump(n_charge_time);
  self _rappel_brake(n_charge_time);
}

_rappel_charge_loop_starter(str_charge_loop_anim, n_charge_time_full) {
  self endon("_rappel_jump_start");
  self waittill("_rappel_start_charge_loop");
  self.body setanimknoball(str_charge_loop_anim, % root, 1, n_charge_time_full, 1);
}

_rappel_jump(n_charge_time) {
  self endon("_rappel_safe_landing");
  self notify("_rappel_jump_start");
  n_acceleration_base = self._rappel.movement.acceleration;
  n_impulse_min = self._rappel.movement.impulse_min;
  n_impulse_max = self._rappel.movement.impulse_max;
  self._rappel.status.is_braking = 0;
  n_scale = n_impulse_min + (n_impulse_max - n_impulse_min) * n_charge_time;
  v_velocity = (0, 0, 0);

  if(self._rappel.movement.is_wall_rappel) {
    v_wall_normal = self _rappel_get_wall_normal();
    v_velocity = v_wall_normal * -1 * n_scale;
  }

  self thread _rappel_fall(v_velocity);
  self.body clearanim( % root, 1);
  str_push_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.push];
  str_idle_loop_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.idle_loop][0];
  n_anim_time_push = getanimlength(str_push_anim);
  n_counter = 0;
  self.body setanim(str_push_anim, 1, n_anim_time_push);

  while(self _is_freefalling()) {
    if(n_counter < n_anim_time_push)
      n_counter = n_counter + 0.05;
    else {
      self.body setanimknoball(str_idle_loop_anim, % root, 1, n_anim_time_push, 1);
      break;
    }

    wait 0.05;
  }
}

_rappel_fall(v_velocity) {
  self endon("_rappel_safe_landing");
  self endon("_rappel_stop_movement");

  if(!isDefined(self._rappel.movement.acceleration_per_frame))
    self._rappel.movement.acceleration_per_frame = self._rappel.movement.acceleration / 20;

  self._rappel.status.frames_since_jump = 0;

  if(!isDefined(self._rappel.status.ground_position))
    self._rappel.status.ground_position = self _rappel_get_ground_trace_position();

  v_ground_pos = self._rappel.status.ground_position;
  n_counter_threshold = self _rappel_get_frames_to_threshold();
  n_counter = 0;
  n_fail_speed = self._rappel.movement.drop_speed_max;
  v_velocity_per_frame = v_velocity / n_counter_threshold;
  v_drop_per_frame = (0, 0, self._rappel.movement.acceleration_per_frame);

  while(self _is_freefalling()) {
    if(n_counter > n_counter_threshold)
      v_velocity_per_frame = (0, 0, 0);

    v_fall_vector_current = v_velocity_per_frame + v_drop_per_frame * n_counter;
    v_new_position = self._rappel.ent.origin + v_fall_vector_current;
    n_distance_to_ground = distance(self.origin, v_ground_pos);
    b_next_point_above_threshold = self _is_above_threshold();

    if(!b_next_point_above_threshold)
      self._rappel.status.is_near_ground = 1;

    b_is_point_below_threshold = self._rappel.movement.threshold_to_ground > n_distance_to_ground;
    b_is_point_above_ground = self _is_point_above_ground(v_new_position, v_ground_pos);

    if(!b_is_point_above_ground || b_is_point_below_threshold) {
      self._rappel.status.is_near_ground = 1;
      self._rappel.status.on_ground = 1;

      if(!self._rappel.status.falling_to_death) {
        self._rappel.difficulty.can_fail = 0;
        self notify("_rappel_stop_movement");
      }
    }

    n_drop_this_frame = abs(v_fall_vector_current[2]);
    self._rappel.ent.origin = v_new_position;

    if(self._rappel.difficulty.can_fail && n_drop_this_frame > n_fail_speed && !self._rappel.status.falling_to_death)
      self thread _rappel_do_falling_death();

    n_counter++;
    self._rappel.status.frames_since_jump = n_counter;
    wait 0.05;
  }
}

_rappel_get_frames_to_threshold() {
  n_distance_after_frames = 0;
  n_drop_speed = abs(self._rappel.movement.acceleration_per_frame);
  n_distance_to_ground = self _rappel_get_distance_to_ground();
  n_distance_to_threshold = n_distance_to_ground - self._rappel.movement.threshold_to_ground;
  n_distance_after_frames = 0;

  for(n_frames_to_threshold = 0; n_distance_after_frames < n_distance_to_threshold; n_frames_to_threshold++)
    n_distance_after_frames = n_distance_after_frames + (n_frames_to_threshold + 1) * n_drop_speed;

  n_frames_to_threshold = clamp(n_frames_to_threshold, 1, 20);
  return n_frames_to_threshold;
}

_is_above_threshold() {
  b_is_above_threshold = 1;
  n_threshold_height = self._rappel.movement.threshold_to_ground;
  n_distance_to_ground = self _rappel_get_distance_to_ground();

  if(n_threshold_height > n_distance_to_ground)
    b_is_above_threshold = 0;

  return b_is_above_threshold;
}

_is_point_above_ground(v_next_position, v_ground_position) {
  b_is_above_ground = 1;
  n_height_next = v_next_position[2];
  n_height_ground = v_ground_position[2];

  if(n_height_ground > n_height_next)
    b_is_above_ground = 0;

  return b_is_above_ground;
}

_rappel_do_falling_death() {
  self playsound("evt_rappel_fail");
  screen_message_delete();
  self disableweapons();
  self notify("_rappel_falling_death");
  self._rappel.status.falling_to_death = 1;
  str_fall_death = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.fall];
  str_fall_death_loop = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.fall_loop][0];
  str_fall_death_splat = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.fall_splat];
  n_anim_length = getanimlength(str_fall_death);
  str_deadquote = self._rappel.strings.death_string;
  self.body setanimknoball(str_fall_death, % root, 1, 0.2, 1);
  n_counter = 0;

  while(!self._rappel.status.on_ground) {
    if(n_counter < n_anim_length)
      n_counter = n_counter + 0.05;
    else
      self.body setanimknoball(str_fall_death_loop, % root, 1, 0.2, 1);

    wait 0.05;
  }

  v_ground_pos = self._rappel.status.ground_position;
  v_offset = vectorscale((0, 0, 1), 10.0);
  self._rappel.ent moveto(v_ground_pos + v_offset, 0.05);
  n_fall_death_length = getanimlength(str_fall_death_splat);
  self.body setanimknoball(str_fall_death_splat, % root, 1, 0, 1);
  earthquake(1.0, 0.5, self.origin, 500);
  wait(n_fall_death_length);
  setdvar("ui_deadquote", str_deadquote);
  missionfailed();
}

_is_2h_rappel() {
  b_is_2h_rappel = self._rappel.controls.is_2h_rappel;
  return b_is_2h_rappel;
}

_is_pressing_brake_button() {
  if(self _is_2h_rappel())
    b_is_pressing_brake = self[[self._rappel.controls.rappel_brake_button]]();
  else
    b_is_pressing_brake = !self[[self._rappel.controls.rappel_button]]();

  return b_is_pressing_brake;
}

_rappel_brake(n_charge_time) {
  self endon("_rappel_safe_landing");
  self endon("_rappel_falling_death");

  if(!isDefined(self._rappel.movement.acceleration_per_frame))
    self._rappel.movement.acceleration_per_frame = self._rappel.movement.acceleration / 20;

  self._rappel.status.is_braking = 0;

  while(!self _is_pressing_brake_button() && self._rappel.status.can_rappel_now)
    wait 0.05;

  n_frames_to_stop_min = self._rappel.movement.brake_frames_min;
  n_frames_to_stop_max = self._rappel.movement.brake_frames_max;
  b_is_short_stop = 0;
  n_frames_since_jump = self._rappel.status.frames_since_jump;

  if(self._rappel.status.frames_since_jump > n_frames_to_stop_max)
    n_frames_since_jump = n_frames_to_stop_max;

  n_frames_to_stop = int(n_frames_to_stop_min + (n_frames_to_stop_max - n_frames_to_stop_min) * (n_frames_since_jump / n_frames_to_stop_max));
  n_distance_to_ground = self _rappel_get_distance_to_ground();
  n_distance_left_to_stop = n_distance_to_ground - self._rappel.movement.threshold_to_ground;
  n_required_distance_to_stop = 0;

  for(i = 0; i < n_frames_to_stop; i++) {
    if(n_required_distance_to_stop > n_distance_left_to_stop) {
      n_frames_to_stop = i;

      if(i == 0)
        n_frames_to_stop = 1;

      b_is_short_stop = 1;
      break;
    }

    n_required_distance_to_stop = n_required_distance_to_stop + abs(self._rappel.movement.acceleration_per_frame * (i + 1));
  }

  if(b_is_short_stop && self._rappel.difficulty.can_fail) {
    self thread _rappel_do_falling_death();
    return;
  }

  self._rappel.status.is_braking = 1;

  if(self._rappel.status.can_rappel_now)
    _rappel_print_controls_full();

  v_movement_down = (0, 0, self._rappel.movement.acceleration_per_frame);
  v_to_wall = (0, 0, 0);

  if(self._rappel.movement.is_wall_rappel) {
    v_to_wall = self _rappel_get_wall_vector();
    v_to_wall = _rappel_vector_remove_z(v_to_wall);
  }

  v_to_wall_per_frame = v_to_wall / n_frames_to_stop;
  str_brake_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.brake];
  str_brake_loop_anim = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.brake_loop][0];
  n_brake_anim_length = getanimlength(str_brake_anim);
  n_time_to_stop = n_frames_to_stop * 0.05;
  self.body setanimknoball(str_brake_anim, % root, 1, 0, 1);
  v_distance_traveled = (0, 0, 0);

  for(i = n_frames_to_stop; i > 0; i--) {
    v_distance_traveled = v_distance_traveled + i * v_movement_down;
    v_movement_current = v_to_wall_per_frame + i * v_movement_down;
    v_new_position = self._rappel.ent.origin + v_movement_current;
    self._rappel.ent.origin = v_new_position;
    wait 0.05;
  }

  self.body setanimknoball(str_brake_loop_anim, % root, 1, 0.5, 1);
  wait 0.5;
  self._rappel.status.is_descending = 0;
  self thread _rappel_brake_then_idle();
}

_rappel_brake_then_idle() {
  self endon("_rappel_jump_start");
  wait 1;
  str_idle_loop = level.scr_anim[self._rappel.anims.body_model][self._rappel.anims.idle_loop][0];
  self.body setanim(str_idle_loop, 1, 1);
}

_is_freefalling() {
  b_is_freefalling = 1;

  if(self._rappel.status.on_ground || self._rappel.status.is_braking)
    b_is_freefalling = 0;

  return b_is_freefalling;
}

_rappel_get_wall_vector() {
  v_normal = self _rappel_get_wall_normal();
  v_scaled = v_normal * 999999;
  a_trace = bullettrace(self.origin, v_scaled, 0, undefined);
  v_hit = a_trace["position"];
  v_to_wall = v_hit - self.origin;
  v_from_wall = self.origin - v_hit;
  v_from_wall_normalized = vectornormalize(v_from_wall);
  v_offset = v_from_wall_normalized * 30;
  v_to_wall_final = v_to_wall + v_offset;
  return v_to_wall_final;
}

_rappel_get_wall_normal() {
  assert(isDefined(self._rappel.status.reference_node), "missing reference node for _rappel_get_wall_normal");
  v_node_normal = anglestoforward(self._rappel.status.reference_node.angles);
  return v_node_normal;
}

_rappel_get_distance_to_ground() {
  assert(isDefined(self._rappel), "rappel struct not set up on player attempting to use _rappel_get_distance_to_ground!");
  v_ground_line = self.origin - (0, 0, 999999);
  a_trace = bullettrace(self.origin, v_ground_line, 0, undefined);
  v_trace_hit = a_trace["position"];
  n_height = distance(v_trace_hit, self.origin);
  return n_height;
}

_rappel_get_ground_trace_position() {
  v_ground_line = self.origin - (0, 0, 999999);
  a_trace = bullettrace(self.origin, v_ground_line, 0, undefined);
  v_trace_hit = a_trace["position"];
  return v_trace_hit;
}

_rappel_rotate_origin(n_rotate_angle) {
  self._rappel.status.is_rotating = 1;
  self._rappel.ent.origin = self.origin;
  self._rappel.ent rotateyaw(n_rotate_angle, 0.5);
  self._rappel.ent waittill("rotatedone");
  self._rappel.status.is_rotating = 0;
}

_rappel_vector_remove_z(v_with_z) {
  assert(isvec(v_with_z), "only vectors can be used with _rappel_vector_remove_z");
  v_without_z = (v_with_z[0], v_with_z[1], 0);
  return v_without_z;
}