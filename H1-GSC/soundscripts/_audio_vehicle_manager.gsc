/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_vehicle_manager.gsc
***************************************************/

avm_add_oneshot(var_0, var_1) {}

avm_init() {
  if(isdefined(level._audio.vm)) {
    return;
  }
  if(!isdefined(level._audio.vm))
    level._audio.vm = spawnstruct();

  var_0 = avmx_get();
  var_0.init_time = gettime();
  var_0.callbacks = [];
  var_0.preset_constructors = [];
  var_0.presets = [];
  var_0.running_intance_accumulator = 0;
  var_0.def_asset_type = "alias";
  var_0.def_player_mode = 0;
  var_0.def_fadein_time = 1.0;
  var_0.def_fadeout_time = 1.0;
  var_0.def_state_min_retrigger_time = 0;
  var_0.def_sound_offset = (0, 0, 0);
  var_0.def_smooth_up = 1.0;
  var_0.def_smooth_down = 1.0;
  var_0.def_input_name = "distance";
  var_0.def_output_name = "volume";
  var_0.def_output_scalar = 1.0;
  var_0.def_priority = 50;
  soundscripts\_snd::snd_register_message("snd_register_vehicle", ::snd_register_vehicle);
  soundscripts\_snd::snd_register_message("snd_start_vehicle", ::snd_start_vehicle);
  soundscripts\_snd::snd_register_message("snd_stop_vehicle", ::snd_stop_vehicle);
  avm_register_callback("distance2d", ::input_callback_distance2d);
  avm_register_callback("distance", ::input_callback_distance);
  avm_register_callback("throttle", ::input_callback_throttle);
  avm_register_callback("speed", ::input_callback_speed);
  avm_register_callback("relative_speed", ::input_callback_relative_speed);
  avm_register_callback("doppler", ::input_callback_doppler);
  avm_register_callback("doppler_exaggerated", ::input_callback_doppler_exaggerated);
  avm_register_callback("doppler_subtle", ::input_callback_doppler_subtle);
  avm_register_callback("speed_mph", ::input_callback_speed_mph);
  avm_register_callback("acceleration_g", ::input_callback_acceleration_g);
  avm_register_callback("jerk_gps", ::input_callback_jerk_gps);
  avm_register_callback("pitch", ::input_callback_pitch);
  avm_register_callback("yaw", ::input_callback_yaw);
  avm_register_callback("pitch_roll_max", ::input_callback_pitch_roll_max);
  avm_register_callback("degrees_from_upright", ::input_callback_degrees_from_upright);
  avm_register_callback("jetbike_thrust", ::input_callback_jetbike_thrust);
  avm_register_callback("jetbike_drag", ::input_callback_jetbike_drag);
  avm_register_callback("jetbike_anti_slip", ::input_callback_jetbike_anti_slip);
  avm_register_callback("jetbike_total_repulsor", ::input_callback_jetbike_total_repulsor);
  avm_register_callback("jetbike_height", ::input_callback_player_jetbike_height);
  avm_register_callback("hovertank_anti_slip_magnitude", ::input_hovertank_anti_slip_magnitude);
  avm_register_callback("hovertank_anti_slip_direction", ::input_hovertank_anti_slip_direction);
  avm_register_callback("hovertank_auto_yaw_magnitude", ::input_hovertank_auto_yaw_magnitude);
  avm_register_callback("hovertank_auto_yaw_direction", ::input_hovertank_auto_yaw_direction);
  avm_register_callback("hovertank_repulsor_front_left", ::input_hovertank_repulsor_front_left);
  avm_register_callback("hovertank_repulsor_front_right", ::input_hovertank_repulsor_front_right);
  avm_register_callback("hovertank_repulsor_back_left", ::input_hovertank_repulsor_back_left);
  avm_register_callback("hovertank_repulsor_back_right", ::input_hovertank_repulsor_back_right);
  avm_register_callback("hovertank_throttle_magnitude", ::input_hovertank_throttle_magnitude);
  avm_register_callback("hovertank_throttle_direction", ::input_hovertank_throttle_direction);
  avm_register_callback("hovertank_uprighting", ::input_hovertank_uprighting);
  avm_register_callback("hovertank_turret_yaw", ::input_hovertank_turret_yaw);
  avm_register_callback("hovertank_turret_pitch", ::input_hovertank_turret_pch);
  avm_register_callback("diveboat_throttle", ::input_diveboat_throttle);
  avm_register_callback("diveboat_drag", ::input_diveboat_drag);
  avm_register_callback("diveboat_drag_with_mph", ::input_diveboat_drag_with_mph);
  avm_register_callback("player_pdrone_look", ::input_player_pdrone_look);
}

snd_register_vehicle(var_0, var_1) {
  var_2 = avmx_get();
  var_2.preset_constructors[var_0] = var_1;
}

snd_start_vehicle(var_0) {
  var_1 = avmx_get();

  if(isstring(var_0)) {
    var_2 = var_0;
    var_0 = spawnstruct();
    var_0.preset_name = var_2;
  }

  var_2 = var_0.preset_name;
  var_3 = soundscripts\_audio::aud_get_optional_param(var_1.def_player_mode, var_0.player_mode);
  var_4 = soundscripts\_audio::aud_get_optional_param(var_1.def_fadein_time, var_0.fadein_time);
  var_5 = soundscripts\_audio::aud_get_optional_param(var_1.def_fadeout_time, var_0.fadeout_time);
  var_6 = soundscripts\_audio::aud_get_optional_param(var_1.def_sound_offset, var_0.offset);
  var_7 = soundscripts\_audio::aud_get_optional_param(undefined, var_0.initial_state_spec);
  self.snd_instance = thread avmx_start_instance(var_2, var_3, var_4, var_5, var_6, var_7);
}

snd_stop_vehicle(var_0, var_1) {
  var_2 = self;
  var_3 = avmx_get();
  var_4 = var_2.snd_instance;
  var_2.snd_instance = undefined;
  var_5 = var_4 avmx_get_instance_preset();
  var_6 = soundscripts\_audio::aud_get_optional_param(var_4.fadeout_time, var_5.header.fadeout_time);
  var_4.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_6, var_0);
  var_1 = soundscripts\_audio::aud_get_optional_param(0, var_1);
  var_4 maps\_utility::delaythread(var_1, ::avmx_stop_instance, var_4.fadeout_time);
}

avm_create_vehicle_proxy() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.vm_is_proxy = 1;
  return var_0;
}

avmx_is_vehicle_proxy() {
  return isdefined(self.vm_is_proxy) && self.vm_is_proxy == 1;
}

avm_begin_preset_def(var_0, var_1) {
  var_2 = avmx_get();
  avmx_set_preset_name(var_0);
  avmx_set_instance_init_callback(var_1);
  var_2.vehicle_under_construction = self;
}

avm_begin_loop_data(var_0, var_1, var_2) {
  var_3 = avmx_get();
  self.loop_data = spawnstruct();
  self.loop_data.loops = [];
  self.loop_data.defaults = spawnstruct();
  self.loop_data.defaults.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_3.def_fadeout_time, var_0);
  self.loop_data.defaults.smooth_up = soundscripts\_audio::aud_get_optional_param(var_3.def_smooth_up, var_1);
  self.loop_data.defaults.smooth_down = soundscripts\_audio::aud_get_optional_param(var_3.def_smooth_down, var_2);
}

avm_begin_loop_def(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isarray(var_0))
    var_6 = var_0;
  else
    var_6 = [var_0];

  var_1 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.fadeout_time, var_1);
  var_2 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.smooth_up, var_2);
  var_3 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.smooth_down, var_3);
  var_4 = soundscripts\_audio::aud_get_optional_param(var_0, var_4);
  var_5 = soundscripts\_audio::aud_get_optional_param("alias", var_5);
  var_10 = spawnstruct();
  var_10.name = var_4;
  var_10.fadeout_time = var_1;
  var_10.asset_type = var_5;
  var_10.asset_names = var_6;
  var_10.preset_name = avmx_get_preset_name();
  var_10.param_maps = [];
  var_10 avmx_preset_set_param_map_defaults(var_2, var_3);
  self.loop_data.loops[var_10.name] = var_10;
  self.loop_data.loop_under_construction = var_10;
}

avmx_preset_determine_param_map_owner(var_0) {
  var_1 = undefined;

  if(isdefined(self.loop_data) && isdefined(self.loop_data.loop_under_construction)) {
    var_1 = self.loop_data.loop_under_construction;

    if(isdefined(self.behavior_data)) {

    }
  } else if(isdefined(self.oneshot_data) && isdefined(self.oneshot_data.oneshot_under_construction))
    var_1 = self.oneshot_data.oneshot_under_construction;
  else if(isdefined(self.behavior_data) && isdefined(self.behavior_data.behavior_under_construction))
    var_1 = self.behavior_data.behavior_under_construction;

  return var_1;
}

avmx_preset_determine_param_map_env_owner(var_0) {
  var_1 = undefined;
  var_2 = avmx_preset_determine_param_map_owner(var_0);

  if(isdefined(var_2))
    var_1 = var_2.pmap_under_construction;

  return var_1;
}

avmx_preset_set_param_map_defaults(var_0, var_1) {
  var_2 = avmx_get();
  self.param_map_defaults = spawnstruct();
  var_3 = soundscripts\_audio::aud_get_optional_param(var_2.def_smooth_up, self.param_map_defaults.smooth_up);
  var_4 = soundscripts\_audio::aud_get_optional_param(var_2.def_smooth_down, self.param_map_defaults.smooth_down);
  self.param_map_defaults.smooth_up = soundscripts\_audio::aud_get_optional_param(var_3, var_0);
  self.param_map_defaults.smooth_down = soundscripts\_audio::aud_get_optional_param(var_4, var_1);
  self.param_map_defaults.input_name = var_2.def_input_name;
  self.param_map_defaults.output_name = var_2.def_output_name;
  self.param_map_defaults.input_modifiers = [];
}

avm_begin_param_map(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_3 = var_0;

  if(!isstring(var_3))
    var_3 = "";

  var_4 = avmx_preset_determine_param_map_owner(var_3);
  var_3 = var_0;
  var_6 = spawnstruct();
  var_6.envs = [];
  var_6.input_name = var_0;
  var_6.smooth_up = soundscripts\_audio::aud_get_optional_param(var_4.param_map_defaults.smooth_up, var_1);
  var_6.smooth_down = soundscripts\_audio::aud_get_optional_param(var_4.param_map_defaults.smooth_down, soundscripts\_audio::aud_get_optional_param(var_1, var_2));
  var_6.def_output_name = var_4.param_map_defaults.output_name;
  var_6.smooth_up = avm_change_smoothing_rate(var_6.smooth_up, 0.1, 0.1);
  var_6.smooth_down = avm_change_smoothing_rate(var_6.smooth_down, 0.1, 0.1);
  var_4.param_maps[var_3] = var_6;
  var_4.pmap_under_construction = var_6;
}

avm_compute_smoothing_rc_from_alpha(var_0, var_1) {
  return var_1 * (1 - var_0) / var_0;
}

avm_compute_alpha_from_rc(var_0, var_1) {
  return var_1 / (var_0 + var_1);
}

avm_change_smoothing_rate(var_0, var_1, var_2) {
  var_3 = avm_compute_smoothing_rc_from_alpha(var_0, var_1);
  var_4 = avm_compute_alpha_from_rc(var_3, var_2);
  return var_4;
}

avmx_add_behavior_shortcut_param_maps(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    avm_begin_param_map(var_4, var_1, var_2);
    avm_end_param_map();
  }
}

avm_add_param_map_env(var_0, var_1, var_2) {
  if(isstring(var_1))
    var_2 = soundscripts\_audio::aud_get_optional_param(var_1, var_2);

  var_3 = avmx_preset_determine_param_map_env_owner(var_2);
  var_4 = var_1;

  if(!isstring(var_4))
    var_4 = "???";

  var_5 = spawnstruct();
  var_5.asset_name = var_1;
  var_5.output_name = var_0;
  var_3.envs[var_2] = var_5;
}

avm_end_param_map() {
  var_0 = avmx_preset_determine_param_map_owner("UNKNOWN param_map being terminated by AVM_end_param_map()");

  if(isdefined(var_0))
    var_0.pmap_under_construction = undefined;
}

avm_end_loop_def() {
  self.loop_data.loop_under_construction = undefined;
}

avm_end_loop_data() {}

avm_begin_oneshot_data(var_0) {
  var_1 = avmx_get();
  self.oneshot_data = spawnstruct();
  self.oneshot_data.oneshots = [];
  self.oneshot_data.defaults = spawnstruct();
  self.oneshot_data.defaults.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_1.def_fadeout_time, var_0);
}

avm_begin_oneshot_def(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = avmx_get();
  var_1 = soundscripts\_audio::aud_get_optional_param(undefined, var_1);
  var_2 = soundscripts\_audio::aud_get_optional_param(self.oneshot_data.defaults.fadeout_time, var_2);
  var_3 = soundscripts\_audio::aud_get_optional_param(1, var_3);
  var_4 = soundscripts\_audio::aud_get_optional_param(var_0, var_4);
  var_5 = soundscripts\_audio::aud_get_optional_param(var_6.def_asset_type, var_5);
  var_7 = var_4;

  if(isstring(var_4))
    var_7 = [var_4];

  var_11 = spawnstruct();
  var_11.name = var_0;
  var_11.asset_names = var_7;
  var_11.asset_type = var_5;
  var_11.duck_env_name = var_1;
  var_11.fadeout_time = var_2;
  var_11.oneshot_poly_mode = var_3;
  var_11.param_maps = [];
  var_11.snd_ents = [];
  var_11 avmx_preset_set_param_map_defaults();
  self.oneshot_data.oneshots[var_11.name] = var_11;
  self.oneshot_data.oneshot_under_construction = var_11;
}

avmx_set_oneshot_update_mode(var_0) {
  var_1 = self.oneshot_data.oneshot_under_construction;
  var_1.oneshot_update_mode = var_0;
}

avm_end_oneshot_def() {
  self.oneshot_data.oneshot_under_construction = undefined;
}

avm_end_oneshot_data() {}

avm_begin_behavior_data(var_0, var_1) {
  self.behavior_data = spawnstruct();
  self.behavior_data.behaviors = [];
  self.behavior_data.defaults = spawnstruct();
  self.behavior_data.defaults.smooth_up = var_0;
  self.behavior_data.defaults.smooth_down = var_1;
}

avm_begin_behavior_def(var_0, var_1, var_2, var_3, var_4) {
  var_5 = avmx_get();
  var_6 = spawnstruct();
  var_6.oneshots = [];
  var_6.loops = [];
  var_6.preset_name = avmx_get_preset_name();
  var_6.param_maps = [];
  var_6.name = var_0;
  var_6.condition_callback = var_1;
  var_3 = soundscripts\_audio::aud_get_optional_param(self.behavior_data.defaults.smooth_up, var_3);
  var_4 = soundscripts\_audio::aud_get_optional_param(self.behavior_data.defaults.smooth_down, var_4);
  var_6 avmx_preset_set_param_map_defaults(var_3, var_4);
  self.behavior_data.behaviors[var_6.name] = var_6;
  self.behavior_data.behavior_under_construction = var_6;

  if(isarray(var_2))
    avmx_add_behavior_shortcut_param_maps(var_2, self.behavior_data.defaults.smooth_up, self.behavior_data.defaults.smooth_down);
}

avm_add_init_state_callback(var_0) {
  self.behavior_data.behavior_under_construction.init_state_callback = var_0;
}

avm_add_in_state_callback(var_0) {
  self.behavior_data.behavior_under_construction.in_state_callback = var_0;
}

avm_add_oneshots(var_0) {
  if(isstring(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0) {
    var_3 = self.behavior_data.behavior_under_construction;
    var_3.oneshots[var_2] = var_2;
  }
}

avm_add_loops(var_0) {
  var_1 = self.behavior_data.behavior_under_construction;

  if(!isdefined(var_0) || var_0.size == 0)
    var_0 = "none";

  if(isstring(var_0)) {
    if(tolower(var_0) == "all")
      var_1.loops[0] = "all";
    else if(tolower(var_0) == "none")
      var_1.loops[0] = "none";
    else
      var_1.loops[var_0] = var_0;
  } else {
    var_1.loops[0] = undefined;

    foreach(var_3 in var_0) {
      if(var_3 != "all" && var_3 != "none") {

      }

      var_1.loops[var_3] = var_3;
    }
  }
}

avm_end_behavior_def() {
  self.behavior_data.behavior_under_construction = undefined;
}

avm_end_behavior_data() {}

avm_begin_state_data(var_0, var_1) {
  if(isdefined(var_0))
    var_0 = var_0 * 1000;

  var_2 = avmx_get();
  self.state_data = spawnstruct();
  self.state_data.state_groups = [];
  self.state_data.defaults = spawnstruct();
  self.state_data.defaults.priority = soundscripts\_audio::aud_get_optional_param(var_2.def_priority, var_1);
  self.state_data.defaults.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(var_2.def_state_min_retrigger_time, var_0);
}

avm_begin_state_group(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4))
    var_4 = var_4 * 1000;

  var_5 = spawnstruct();
  var_5.name = var_0;
  var_5.initial_state_name_pair = [var_1, var_2];
  var_5.priority = soundscripts\_audio::aud_get_optional_param(self.state_data.defaults.priority, var_3);
  var_5.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(self.state_data.defaults.min_retrigger_time, var_4);
  var_5.states = [];
  self.state_data.state_groups[var_0] = var_5;
  self.state_data.group_under_construction = var_5;
}

avm_begin_state_def(var_0, var_1, var_2) {
  if(isdefined(var_1))
    var_1 = var_1 * 1000;

  var_3 = self.state_data.group_under_construction;
  var_4 = var_3.name;
  var_5 = spawnstruct();
  var_5.name = var_0;
  var_5.transitions = [];
  var_5.priority = soundscripts\_audio::aud_get_optional_param(var_3.priority, var_2);
  var_5.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(var_3.min_retrigger_time, var_1);
  var_5.preset_name = avmx_get_preset_name();
  var_3.states[var_0] = var_5;
  self.state_data.group_under_construction.state_under_construction = var_5;
}

avm_add_state_transition(var_0, var_1) {
  var_3 = self.state_data.group_under_construction.state_under_construction;
  var_3.transitions[var_3.transitions.size] = [var_0, var_1];
}

avm_end_state_def() {
  self.state_data.group_under_construction.state_under_construction = undefined;
}

avm_end_state_group() {
  self.state_data.group_under_construction = undefined;
}

avm_end_state_data() {}

avm_add_envelope(var_0, var_1) {
  if(isstring(var_0))
    var_0 = tolower(var_0);

  var_4 = avmx_get();

  if(!isdefined(self.env_data))
    self.env_data = [];

  var_5 = spawnstruct();

  if(isarray(var_1)) {
    var_5.env_array = [];

    if(getdvarint("enableMW1GetArrayKeysAndForEach") != 0) {
      for (var_6 = 0; var_6 < var_1.size; var_6++) {
        var_7 = var_1[var_6];
        var_5.env_array[var_5.env_array.size] = (var_7[0], var_7[1], 0);
      }
    } else {
      foreach(var_7 in var_1)
      var_5.env_array[var_5.env_array.size] = (var_7[0], var_7[1], 0);
    }
  } else
    var_5.env_function = var_1;

  self.env_data[var_0] = var_5;
}

avm_end_preset_def() {
  var_0 = avmx_get();
  self.consolidated_inputs = [];

  foreach(var_8, var_2 in self.loop_data.loops) {
    var_3 = var_8;
    var_4 = var_2;

    foreach(var_7, var_6 in var_4.param_maps)
    self.consolidated_inputs[var_7] = avmx_get_callback(var_7);
  }

  foreach(var_8, var_2 in self.oneshot_data.oneshots) {
    var_10 = var_8;
    var_11 = var_2;

    foreach(var_7, var_6 in var_11.param_maps)
    self.consolidated_inputs[var_7] = avmx_get_callback(var_7);
  }

  foreach(var_8, var_2 in self.behavior_data.behaviors) {
    var_14 = var_8;
    var_15 = var_2;

    foreach(var_7, var_6 in var_15.param_maps)
    self.consolidated_inputs[var_7] = avmx_get_callback(var_7);
  }

  var_0.vehicle_under_construction = undefined;
}

avmx_get_master_volume() {
  return self.master_volume;
}

vm2_get_vehicle_snd_instance() {
  return self.snd_instance;
}

vm2_get_instance_name() {
  return avmx_get_instance_name();
}

avm_set_instance_master_volume(var_0, var_1) {
  thread avmx_set_instance_master_volume(var_0, var_1);
}

avmx_set_instance_master_volume(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 avmx_get_instance_name();
  var_4 = var_2 avmx_get_vehicle_entity();
  var_0 = clamp(var_0, 0, 1);
  var_1 = clamp(soundscripts\_audio::aud_get_optional_param(1, var_1), 0, 60);
  var_5 = var_3;
  var_2 notify(var_5);
  var_2 endon(var_5);
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + var_2 avmx_get_instance_name());
  var_4 endon("death");
  var_6 = avm_get_update_rate();
  var_7 = var_0 - var_2.master_volume;
  var_8 = max(1, var_1 / var_6);
  var_9 = var_7 / var_8;

  for (;;) {
    if(var_9 < 0) {
      if(var_2.master_volume > var_0)
        var_2.master_volume = max(0, var_2.master_volume + var_9);
      else
        break;
    } else if(var_9 > 0) {
      if(var_2.master_volume < var_0)
        var_2.master_volume = min(1.0, var_2.master_volume + var_9);
      else
        break;
    }

    wait(var_6);
  }
}

avm_get_running_instance_count(var_0) {
  return avmx_get().running_intance_accumulator;
}

avm_get_update_rate() {
  return 0.1;
}

vm2_get_vehicle_instance_count(var_0) {
  var_1 = 0;
  var_2 = avmx_get();

  if(isstring(var_0)) {
    var_3 = var_2.presets[var_0];

    if(isdefined(var_3) & isarray(var_3.instances))
      var_1 = var_3.instances.size;
  } else {
    foreach(var_3 in var_2.presets) {
      if(isarray(var_3.instances))
        var_1 = var_1 + var_3.instances.size;
    }
  }

  return var_1;
}

avmx_create_preset(var_0) {
  var_1 = avmx_get();
  var_2 = var_1.preset_constructors[var_0];
  var_3 = spawnstruct();
  var_3.global_data = spawnstruct();
  var_3.user_data = spawnstruct();
  var_3.header = spawnstruct();
  var_3.instances = [];
  var_3.header.preset_name = soundscripts\_audio::aud_get_optional_param(undefined, var_0);
  var_3.header.fadein_time = var_1.def_fadein_time;
  var_3.header.fadeout_time = var_1.def_fadeout_time;
  var_3.header.sound_offset = var_1.def_sound_offset;
  var_3[[var_2]]();
  var_3 avmx_add_preset();
  return var_3;
}

avmx_add_preset() {
  var_0 = avmx_get();
  var_0.presets[self.header.preset_name] = self;
}

vm2x_remove_preset() {
  var_0 = avmx_get();
  var_0.presets[self.header.preset_name] = undefined;
}

avmx_add_instance() {
  var_0 = avmx_get();
  var_0.presets[self.preset_name].instances[self.instance_name] = self;
  var_0.running_intance_accumulator++;
}

avmx_remove_instance() {
  var_0 = avmx_get();
  var_0.presets[self.preset_name].instances[self.instance_name] = undefined;
}

avmx_generate_instance_name(var_0) {
  var_1 = self.header.preset_name + "_" + avm_get_running_instance_count();

  if(isdefined(var_0) && var_0 == 1)
    var_1 = var_1 + "_player";

  return var_1;
}

avm_register_callback(var_0, var_1, var_2) {
  avmx_get().callbacks[var_0] = [var_1, var_2];
}

avmx_get_instance_state_struct(var_0) {
  var_1 = self;
  var_2 = undefined;

  foreach(var_4 in var_1.state_group_list) {
    var_2 = var_4[var_0];

    if(isdefined(var_2)) {
      break;
    }
  }

  return var_2;
}

avmx_get_behavior_instance_struct(var_0) {
  var_1 = self;
  return var_1.behavior_list[var_0];
}

avmx_get_state_preset_struct(var_0) {
  var_1 = self;
  var_2 = undefined;

  foreach(var_4 in var_1.state_data.state_groups) {
    var_2 = var_4.states[var_0];

    if(isdefined(var_2)) {
      break;
    }
  }

  return var_2;
}

avmx_get_behavior_preset_struct(var_0) {
  var_1 = self;
  return var_1.behavior_data.behaviors[var_0];
}

avmx_create_instance_struct(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = spawnstruct();
  var_6.user_data = spawnstruct();
  var_6.preset_name = var_5 avmx_get_preset_name();
  var_6.instance_name = var_5 avmx_generate_instance_name(var_4);
  var_6.veh_ent = var_0;
  var_6.fadein_time = var_1;
  var_6.fadeout_time = var_2;
  var_6.sound_offset = var_3;
  var_6.player_mode = var_4;
  var_6.loop_duck_scalar = 1.0;
  var_6.oneshot_duck_vals = [];
  var_6.master_volume = 1.0;
  var_6.loop_list = [];

  foreach(var_8 in var_5.loop_data.loops) {
    var_9 = spawnstruct();
    var_9.ps_item = var_8;
    var_9.play_mode = 0;
    var_9.curr_io = var_6 avmx_create_param_io_struct(var_8);
    var_9.snd_ents = [];
    var_9.volume = 1.0;
    var_6.loop_list[var_8.name] = var_9;
  }

  var_6.oneshot_list = [];

  foreach(var_8 in var_5.oneshot_data.oneshots) {
    var_9 = spawnstruct();
    var_9.ps_item = var_8;
    var_9.curr_io = var_6 avmx_create_param_io_struct(var_8);
    var_9.snd_ents = [];
    var_6.oneshot_list[var_8.name] = var_9;
  }

  var_6.behavior_list = [];

  foreach(var_8 in var_5.behavior_data.behaviors) {
    var_9 = spawnstruct();
    var_9.ps_item = var_8;
    var_9.curr_io = var_6 avmx_create_param_io_struct(var_8);
    var_6.behavior_list[var_8.name] = var_9;
  }

  var_6.state_group_list = [];

  foreach(var_21, var_16 in var_5.state_data.state_groups) {
    var_6.state_group_list[var_21] = [];

    foreach(var_20, var_18 in var_16.states) {
      var_19 = spawnstruct();
      var_19.ps_item = var_18;
      var_19.start_time = 0;
      var_6.state_group_list[var_21][var_20] = var_19;
    }
  }

  if(isdefined(var_5.global_data.instance_init_callback))
    var_6[[var_5.global_data.instance_init_callback]](var_6.user_data);

  return var_6;
}

avmx_start_instance(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;

  if(var_6 avmx_is_vehicle_proxy() == 0)
    var_6 vehicle_turnengineoff();

  var_7 = avmx_get_preset(var_0);

  if(!isdefined(var_7))
    var_7 = avmx_create_preset(var_0);

  var_8 = var_7 avmx_create_instance_struct(var_6, var_2, var_3, var_4, var_1);
  var_8 avmx_add_instance();
  var_8 thread avmx_update_loops();
  var_8 thread avmx_launch_state_machines(var_5);
  var_6 thread avmx_monitor_death(var_8);
  return var_8;
}

avmx_stop_instance(var_0) {
  if(!isdefined(self.is_stopping)) {
    self.is_stopping = 1;
    var_1 = self;
    var_2 = var_1 avmx_get_instance_preset();
    var_3 = var_1 avmx_get_instance_name();
    var_0 = max(0.01, soundscripts\_audio::aud_get_optional_param(var_1.fadeout_time, var_0));
    level notify("msg_snd_vehicle_stop_" + var_3);

    foreach(var_5 in var_1.loop_list) {
      var_6 = soundscripts\_audio::aud_get_optional_param(var_5.ps_item.fadeout_time, var_0);
      var_5 thread avmx_fade_stop_and_delete_sound_obj(var_6);
    }

    foreach(var_9 in var_1.oneshot_list) {
      var_6 = soundscripts\_audio::aud_get_optional_param(var_9.ps_item.fadeout_time, var_0);
      var_9 thread avmx_fade_stop_and_delete_sound_obj(var_6);
    }

    wait(var_0 + 0.05);
    var_1 avmx_remove_instance();
  }
}

avmx_monitor_death(var_0) {
  var_1 = var_0 avmx_get_instance_name();
  level endon("msg_snd_vehicle_stop_" + var_1);
  self waittill("death");
  var_0 thread avmx_stop_instance();
}

avmx_create_param_io_struct(var_0) {
  var_1 = self;
  var_2 = spawnstruct();
  var_2.smoothed_input = [];
  var_2.physical_output = [];

  foreach(var_4 in var_0.param_maps) {
    var_2.smoothed_input[var_4.input_name] = 0;

    foreach(var_6 in var_4.envs) {
      if(!isdefined(var_2.physical_output[var_6.output_name]))
        var_2.physical_output[var_6.output_name] = 1.0;
    }
  }

  if(!isdefined(var_2.physical_output["volume"]))
    var_2.physical_output["volume"] = 1.0;

  if(!isdefined(var_2.physical_output["pitch"]))
    var_2.physical_output["pitch"] = 1.0;

  return var_2;
}

vm2x_init_param_io_struct(var_0) {
  var_1 = self;

  foreach(var_4, var_3 in var_0.smoothed_input)
  var_0.smoothed_input[var_4] = 0;

  foreach(var_4, var_3 in var_0.physical_output)
  var_0.physical_output[var_4] = 1.0;
}

avmx_get_current_instance_sound_item_input() {
  return self.curr_io.smoothed_input;
}

avmx_get_instance_sound_item_output() {
  return self.curr_io.physical_output;
}

avmx_get_instance_sound_item_volume() {
  var_0 = avmx_get_instance_sound_item_output();
  var_1 = var_0["volume"];

  if(!isdefined(var_1))
    var_1 = 1.0;

  return var_1;
}

avmx_update_loops() {
  var_0 = self;
  var_1 = avmx_get_instance_preset();
  var_2 = avmx_get_vehicle_entity();
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + avmx_get_instance_name());
  var_2 endon("death");
  var_3 = undefined;

  for (;;) {
    var_0 avmx_update_loop_ducking_scalar();

    foreach(var_5 in var_0.loop_list) {
      if(var_5.play_mode == 1) {
        var_6 = var_5.ps_item.name;
        var_0 avmx_map_io(var_5, var_3);
        var_0 avmx_update_instance_loop_assets(var_5);
      }
    }

    var_3 = gettime();
    var_8 = distance2d(var_0.veh_ent.origin, level.player.origin);

    if(var_8 < 400)
      var_9 = 1.0;
    else if(var_8 > 1500)
      var_9 = 10.0;
    else
      var_9 = 1.0 + 9.0 * ((var_8 - 400) / 1100);

    wait(0.1 * var_9);
  }
}

avmx_set_loop_play_state(var_0, var_1) {
  var_2 = self;

  switch (var_0.ps_item.asset_type) {
    case "alias":
      if(var_1 == 1 && var_0.play_mode != 1) {
        var_2 avmx_start_loop(var_0);
        var_0.play_mode = 1;
      } else if(var_1 == 0 && var_0.play_mode != 0) {
        var_2 avmx_stop_loop(var_0);
        var_0.play_mode = 0;
      } else {

      }

      break;
    case "soundevent":
      break;
    case "damb":
      break;
    default:
      break;
  }
}

avmx_map_io(var_0, var_1) {
  if(var_0.ps_item.param_maps.size == 0) {
    return;
  }
  var_2 = self;
  var_3 = avmx_get_instance_preset();
  var_4 = var_0.ps_item;
  var_5 = var_0.curr_io;
  var_6 = gettime();
  var_1 = soundscripts\_audio::aud_get_optional_param(var_6 - 100, var_1);
  var_5.physical_output = [];
  var_7 = [];

  foreach(var_10, var_9 in var_3.consolidated_inputs)
  var_7[var_10] = var_2[[var_9]]();

  foreach(var_12 in var_4.param_maps) {
    var_13 = var_12.input_name;
    var_14 = var_7[var_13];
    var_15 = var_5.smoothed_input[var_13];

    if(var_14 > var_15)
      var_16 = var_12.smooth_up;
    else
      var_16 = var_12.smooth_down;

    var_17 = (var_6 - var_1) / 100.0;
    var_16 = 1.0 - pow(1 - var_16, var_17);
    var_18 = var_15 + var_16 * (var_14 - var_15);

    foreach(var_23, var_20 in var_12.envs) {
      var_21 = var_3.env_data[var_23];
      var_22 = piecewiselinearlookup(var_18, var_21.env_array);

      if(isdefined(var_5.physical_output[var_20.output_name])) {
        var_5.physical_output[var_20.output_name] = var_5.physical_output[var_20.output_name] * var_22;
        continue;
      }

      var_5.physical_output[var_20.output_name] = var_22;
    }

    var_5.smoothed_input[var_13] = var_18;
  }
}

avmx_update_loop_ducking_scalar() {
  self.loop_duck_scalar = 1.0;

  foreach(var_1 in self.oneshot_duck_vals)
  self.loop_duck_scalar = self.loop_duck_scalar * var_1;
}

avmx_update_instance_loop_assets(var_0) {
  var_1 = self;

  foreach(var_7, var_3 in var_0.curr_io.physical_output) {
    if(var_7 == "volume") {
      var_3 = var_3 * (var_1.loop_duck_scalar * var_0.volume);

      if(isdefined(var_0.fade_in_scalar)) {
        var_0.fade_in_scalar = min(var_0.fade_in_scalar + var_0.fade_in_inc, 1.0);
        var_3 = var_3 * var_0.fade_in_scalar;

        if(var_0.fade_in_scalar >= 1.0)
          var_0.fade_in_scalar = undefined;
      }
    }

    foreach(var_5 in var_0.snd_ents)
    var_5 avmx_update_sound_ent_output_param(var_7, var_3);
  }
}

avm_set_loop_mute_state(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = var_3.loop_list[var_0];
  var_5 = 1.0;

  if(var_1 == 1)
    var_5 = 0;

  var_2 = soundscripts\_audio::aud_get_optional_param(0.05, var_2);
  var_6 = var_5 - var_4.volume;
  var_7 = max(1, var_2 / avm_get_update_rate());
  var_8 = var_6 / var_7;
  var_3 thread avmx_set_loop_volume(var_4, var_5, var_8, avm_get_update_rate());
}

avmx_set_loop_volume(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = var_4 avmx_get_vehicle_entity();
  var_6 = var_0.ps_item.name;
  var_4 notify(var_6);
  var_4 endon(var_6);
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + var_4 avmx_get_instance_name());
  var_5 endon("death");

  for (;;) {
    if(var_2 < 0) {
      if(var_0.volume > var_1)
        var_0.volume = max(0, var_0.volume + var_2);
      else
        break;
    } else if(var_2 > 0) {
      if(var_0.volume < var_1)
        var_0.volume = min(1.0, var_0.volume + var_2);
      else
        break;
    }

    wait(var_3);
  }
}

avmx_launch_state_machines(var_0) {
  var_1 = self;
  var_2 = avmx_get_instance_preset();

  foreach(var_10, var_4 in var_2.state_data.state_groups) {
    var_5 = var_4.initial_state_name_pair;

    if(isarray(var_0))
      var_5 = var_0[var_10];

    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_1.state_group_list[var_10][var_6];
    var_9 = var_1.behavior_list[var_7];
    var_1 avmx_map_io(var_9);
    var_1 thread avmx_state_enter_action_function(var_8, var_9, 1);
  }
}

avmx_state_enter_action_function(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = var_3 avmx_get_instance_preset();
  var_5 = var_0.ps_item;
  var_6 = var_3 avmx_get_vehicle_entity();
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + avmx_get_instance_name());
  var_6 endon("death");
  var_0.start_time = gettime();
  var_3 avmx_state_enter_action_init_data(var_0, var_1);
  var_3 avmx_state_enter_action_play_oneshots(var_0, var_1);
  var_3 avmx_state_enter_action_play_loops(var_0, var_1);

  if(isdefined(var_1.ps_item.init_state_callback))
    var_3[[var_1.ps_item.init_state_callback]](var_3.user_data);

  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = 1;

  for (;;) {
    if(isdefined(var_1.ps_item.in_state_callback)) {
      var_3 avmx_map_io(var_1);
      var_3[[var_1.ps_item.in_state_callback]](var_1.curr_io.smoothed_input, var_3.user_data);
    }

    foreach(var_14 in var_5.transitions) {
      var_15 = var_14[0];
      var_16 = var_14[1];
      var_17 = var_14[2];
      var_18 = var_3 avmx_get_instance_state_struct(var_15);
      var_19 = var_3 avmx_get_behavior_instance_struct(var_16);
      var_20 = var_18.ps_item;
      var_21 = var_19.ps_item;

      if(gettime() - var_18.start_time < var_20.min_retrigger_time) {
        continue;
      }
      var_3 avmx_map_io(var_19, var_11);
      var_22 = var_3 avmx_state_condition_function(var_18, var_19);

      if(isarray(var_22)) {
        var_10 = var_22;
        var_22 = 1;
      }

      if(var_22) {
        if(!isdefined(var_7) || var_20.priority > var_7.ps_item.priority) {
          var_7 = var_18;
          var_8 = var_19;
          var_9 = var_10;
          var_10 = undefined;
        }
      }
    }

    if(isdefined(var_7)) {
      break;
    }

    var_12 = 0;
    var_11 = gettime();
    var_24 = distance2d(var_3.veh_ent.origin, level.player.origin);

    if(var_24 < 400)
      var_25 = 1.0;
    else if(var_24 > 1500)
      var_25 = 10.0;
    else
      var_25 = 1.0 + 9.0 * ((var_24 - 400) / 1100);

    wait(0.1 * var_25);
  }

  var_3 avmx_set_behavior_oneshot_overrides(var_8, var_9);
  var_26 = var_3 avmx_get_behavior_restricted_oneshots(var_8);
  var_27 = var_26.size > 0;
  var_3 thread avmx_state_exit_action_function(var_1, var_27);

  if(var_12 && !var_2) {}

  var_3 thread avmx_state_enter_action_function(var_7, var_8, 0);
}

avmx_state_enter_action_init_data(var_0, var_1) {
  var_2 = self;
  var_3 = var_1.ps_item;

  if(isdefined(var_3.loops[0])) {
    if(var_3.loops[0] == "all") {
      foreach(var_5 in var_2.loop_list)
      var_5.volume = 1.0;
    }
  } else {
    foreach(var_8 in var_3.loops) {
      var_5 = var_2.loop_list[var_8];
      var_5.volume = 1.0;
    }
  }
}

avmx_state_exit_action_function(var_0, var_1) {
  var_2 = self;
  var_3 = var_0.ps_item.oneshots;

  foreach(var_5 in var_3) {
    var_6 = var_2.oneshot_list[var_5];
    var_7 = var_6.ps_item.oneshot_poly_mode;

    if(var_7 == 2 || var_7 == 1 && var_1) {
      var_8 = var_6.snd_ents;
      var_6.snd_ents = [];
      var_9 = var_6.ps_item.fadeout_time;

      foreach(var_12, var_11 in var_8)
      var_11 thread avmx_stop_snd_ent(var_9);
    }
  }
}

vm2x_fade_sound_obj(var_0) {
  var_1 = self;
  var_0 = max(0.01, soundscripts\_audio::aud_get_optional_param(0.05, var_0));

  switch (var_1.ps_item.asset_type) {
    case "alias":
      foreach(var_4, var_3 in var_1.snd_ents) {
        if(isdefined(var_3)) {
          var_3 setvolume(0, var_0);
          wait(var_0);

          if(isdefined(var_3))
            var_3 stopsounds();
        }
      }

      break;
    case "soundevent":
      break;
    case "damb":
      break;
    default:
      break;
  }
}

avmx_state_condition_function(var_0, var_1) {
  var_2 = 0;
  var_3 = self;
  var_2 = var_3[[var_1.ps_item.condition_callback]](var_1.curr_io.smoothed_input, var_3.user_data);
  return var_2;
}

avmx_state_enter_action_play_oneshots(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 avmx_get_instance_preset();
  var_4 = var_0.ps_item;
  var_5 = var_1.ps_item;
  var_6 = var_1.oneshot_overrides;

  if(!isdefined(var_6))
    var_6 = var_5.oneshots;

  foreach(var_8 in var_6) {
    var_9 = var_2.oneshot_list[var_8];
    var_10 = var_9.ps_item;
    var_11 = var_2 avmx_get_oneshot_poly_mode(var_8);
    var_12 = var_2 avmx_get_oneshot_update_mode(var_8);

    if(var_10.asset_type == "alias") {
      var_2 avmx_map_io(var_9);

      for (var_13 = 0; var_13 < var_10.asset_names.size; var_13++) {
        var_14 = var_2 avmx_start_oneshot_alias(var_9, var_13);

        foreach(var_17, var_16 in var_9.curr_io.physical_output)
        var_14 avmx_update_sound_ent_output_param(var_17, var_16);

        if(var_12)
          var_2 thread avmx_continuously_update_snd_ent(var_9, var_14);

        if(var_11 == 1 || var_11 == 2)
          var_9.snd_ents[var_13] = var_14;
      }

      var_2 thread avmx_handle_oneshot_ducking(var_9);
    }
  }
}

avmx_continuously_update_snd_ent(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 avmx_get_vehicle_entity();
  var_4 = avm_get_update_rate();
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + var_2 avmx_get_instance_name());
  var_3 endon("death");
  wait(var_4);

  while (isdefined(var_1)) {
    var_2 avmx_map_io(var_0);

    if(isdefined(var_1)) {
      foreach(var_7, var_6 in var_0.curr_io.physical_output)
      var_1 avmx_update_sound_ent_output_param(var_7, var_6);
    }

    wait(var_4);
  }
}

avmx_state_enter_action_play_loops(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 avmx_get_instance_preset();
  var_4 = var_0.ps_item;
  var_5 = var_1.ps_item;
  var_6 = var_5.loops;

  if(isdefined(var_6[0])) {
    if(var_6[0] == "all") {
      foreach(var_9, var_8 in var_2.loop_list)
      avmx_set_loop_play_state(var_8, 1);
    } else if(var_6[0] == "none") {
      foreach(var_9, var_8 in var_2.loop_list)
      avmx_set_loop_play_state(var_8, 0);
    } else {

    }
  } else if(var_6.size > 0) {
    var_11 = [];
    var_12 = [];

    foreach(var_9, var_8 in var_2.loop_list) {
      if(isdefined(var_6[var_9])) {
        var_11[var_9] = var_8;
        continue;
      }

      var_12[var_9] = var_8;
    }

    foreach(var_9, var_8 in var_11)
    avmx_set_loop_play_state(var_8, 1);

    foreach(var_9, var_8 in var_12)
    avmx_set_loop_play_state(var_8, 0);
  }
}

input_callback_distance2d() {
  var_0 = avmx_get_vehicle_entity();
  return distance2d(var_0.origin, level.player.origin);
}

input_callback_distance() {
  var_0 = avmx_get_vehicle_entity();
  return distance(var_0.origin, level.player.origin);
}

input_callback_throttle() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_getthrottle();
}

input_callback_speed() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = length(var_0 vehicle_getvelocity() * 0.0568182);
  return var_1;
}

input_callback_relative_speed() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0 vehicle_getvelocity();
  var_2 = level.player getvelocity();
  var_3 = var_1 - var_2;
  var_4 = length(var_3) * 0.0568182;
  return var_4;
}

input_callback_speed_mph() {
  var_0 = avmx_get_vehicle_entity();

  if(isdefined(var_0.fakespeed))
    return var_0.fakespeed;

  return var_0 maps\_shg_utility::get_differentiated_speed() * 0.0568182;
}

input_callback_acceleration_g() {
  var_0 = avmx_get_vehicle_entity();
  return length(var_0 maps\_shg_utility::get_differentiated_acceleration()) * 0.00125;
}

input_callback_jerk_gps() {
  var_0 = avmx_get_vehicle_entity();
  return length(var_0 maps\_shg_utility::get_differentiated_jerk()) * 0.00125;
}

input_callback_doppler() {
  var_0 = avmx_get_vehicle_entity();
  return dopplerpitch(var_0.origin, var_0 vehicle_getvelocity(), level.player.origin, level.player getvelocity());
}

input_callback_doppler_exaggerated() {
  var_0 = avmx_get_vehicle_entity();
  return dopplerpitch(var_0.origin, var_0 vehicle_getvelocity(), level.player.origin, level.player getvelocity(), 2, 5);
}

input_callback_doppler_subtle() {
  var_0 = avmx_get_vehicle_entity();
  return dopplerpitch(var_0.origin, var_0 vehicle_getvelocity(), level.player.origin, level.player getvelocity(), 1, 0.5);
}

avm_compute_doppler_pitch(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_4))
    var_4 = 1;

  if(!isdefined(var_5))
    var_5 = 1;

  if(!isdefined(var_6))
    var_6 = 13397;

  if(var_4 != 1) {
    var_7 = var_1 - var_3;
    var_8 = vectornormalize(var_7);
    var_9 = var_2 - var_0;
    var_10 = var_8 * vectordot(var_8, var_9);
    var_11 = var_9 - var_10;
    var_2 = var_0 + var_10 + var_11 / var_4;
  }

  var_12 = vectornormalize(var_0 - var_2);
  var_13 = vectordot(var_1, var_12);
  var_14 = vectordot(var_3, var_12);
  var_15 = (var_6 + var_14) / (var_6 + var_13);
  var_15 = pow(var_15, var_5);
  var_15 = clamp(var_15, 0.1, 1.99);
  return var_15;
}

input_callback_pitch() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0.angles[0];
  return var_1;
}

input_callback_yaw() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0.angles[1];
  return var_1;
}

input_callback_pitch_roll_max() {
  var_0 = avmx_get_vehicle_entity();
  return max(abs(angleclamp180(var_0.angles[0])), abs(angleclamp180(var_0.angles[2])));
}

input_callback_degrees_from_upright() {
  var_0 = avmx_get_vehicle_entity();
  return acos(anglestoup(var_0.angles)[2]);
}

input_callback_jetbike_thrust() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_jetbikegetthrustfraction();
}

input_callback_jetbike_drag() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_jetbikegetdragfraction();
}

input_callback_jetbike_anti_slip() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_jetbikegetantislipfraction();
}

input_callback_jetbike_total_repulsor() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_jetbikegettotalrepulsorfraction();
}

input_callback_player_jetbike_height() {
  var_0 = 0;
  var_1 = avmx_get_vehicle_entity();
  var_2 = 0.1;

  if(avmx_is_player_mode()) {
    if(!isdefined(var_1.amv_jetbike_height_time))
      var_1.amv_jetbike_height_time = 0;

    var_3 = gettime();

    if(var_3 > var_1.amv_jetbike_height_time + var_2) {
      var_1.amv_jetbike_height_time = var_3;
      var_4 = bullettrace(var_1.origin, var_1.origin - (0, 0, 360), 0);
      var_1.amv_jetbike_height_val = var_4["fraction"];

      if(!isdefined(var_1.amv_jetbike_height_val))
        var_1.amv_jetbike_height_val = 0;
    }

    var_0 = clamp(var_1.amv_jetbike_height_val, 0, 1.0);
  }

  return var_0;
}

input_hovertank_anti_slip() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_hovertankgetantislipforce();
}

input_hovertank_anti_slip_magnitude() {
  var_0 = input_hovertank_anti_slip();
  return var_0[0];
}

input_hovertank_anti_slip_direction() {
  var_0 = input_hovertank_anti_slip();
  return var_0[1];
}

input_hovertank_auto_yaw() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_hovertankgetautoyawforce();
}

input_hovertank_auto_yaw_magnitude() {
  var_0 = input_hovertank_auto_yaw();
  return var_0[0];
}

input_hovertank_auto_yaw_direction() {
  var_0 = input_hovertank_auto_yaw();
  return var_0[1];
}

input_hovertank_repulsors() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_hovertankgetrepulsorforces();
}

input_hovertank_repulsor_front_left() {
  var_0 = input_hovertank_repulsors();
  return var_0[0];
}

input_hovertank_repulsor_front_right() {
  var_0 = input_hovertank_repulsors();
  return var_0[1];
}

input_hovertank_repulsor_back_left() {
  var_0 = input_hovertank_repulsors();
  return var_0[2];
}

input_hovertank_repulsor_back_right() {
  var_0 = input_hovertank_repulsors();
  return var_0[3];
}

input_hovertank_throttle() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_hovertankgetthrottleforce();
}

input_hovertank_throttle_magnitude() {
  var_0 = input_hovertank_throttle();
  return var_0[0];
}

input_hovertank_throttle_direction() {
  var_0 = input_hovertank_throttle();
  return var_0[1];
}

input_hovertank_uprighting() {
  var_0 = avmx_get_vehicle_entity();
  return var_0 vehicle_hovertankgetuprightingforce();
}

input_hovertank_turret_pch() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0.turret getturretpitchrate();
  var_1 = abs(var_1);
  var_1 = clamp(var_1, 0, 90);
  var_1 = avmx_normalize_ranged_value(var_1, 0, 90);
  var_2 = level.player getnormalizedcameramovement();
  var_3 = abs(var_2[0]);
  return 0;
}

input_hovertank_turret_yaw() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0.turret getturretyawrate();
  var_1 = abs(var_1);
  var_2 = var_0.turret getturretpitchrate();
  var_2 = abs(var_2);
  var_3 = length2d((var_1, var_2, 0));
  var_3 = clamp(var_3, 0, 135);
  var_4 = avmx_normalize_ranged_value(var_3, 0, 135);
  var_5 = level.player getnormalizedcameramovement();
  var_6 = length2d(var_5);
  return var_4 * var_6;
}

input_diveboat_throttle() {
  var_0 = avmx_get_vehicle_entity();

  if(isdefined(level.aud.diveboat_ending) && level.aud.diveboat_ending == 1) {
    level.aud.diveboat_throttle = level.aud.diveboat_throttle * 0.94;
    return level.aud.diveboat_throttle;
  } else {
    var_1 = var_0 vehicle_diveboatgetthrottleforce();

    if(var_1 != 0)
      level.aud.diveboat_throttle = var_1;

    return var_1;
  }
}

input_diveboat_drag() {
  var_0 = avmx_get_vehicle_entity();
  var_1 = var_0 vehicle_diveboatgetdragforce();
  return var_1;
}

input_diveboat_drag_with_mph() {
  var_0 = input_diveboat_drag();
  var_1 = input_callback_speed_mph();
  var_2 = var_1 + abs(var_0) * 0.1;
  return var_1 + abs(var_0) * 0.1;
}

input_player_pdrone_look() {
  var_0 = level.player getnormalizedcameramovement();
  var_1 = abs(var_0[0]);
  var_2 = abs(var_0[1]);

  if(var_1 > var_2)
    return var_1;
  else
    return var_2;
}

avmx_start_oneshot_alias(var_0, var_1) {
  var_2 = self;
  var_3 = var_0.ps_item;
  var_4 = undefined;
  var_5 = var_2 avmx_get_sound_alias(var_3, var_1);

  if(isstring(var_5)) {
    var_6 = var_2 avmx_get_vehicle_entity();
    var_4 = spawn("script_origin", var_6.origin);
    var_4 linkto(var_6, "tag_origin", var_2.sound_offset, (0, 0, 0));
    var_4 scalevolume(0);
    var_4 soundscripts\_snd_playsound::snd_play(var_5, "sound_done");
    var_4 thread avmx_monitor_oneshot_done("sound_done");
  }

  return var_4;
}

avmx_monitor_oneshot_done(var_0) {
  self endon("death");
  self waittill(var_0);

  if(isdefined(self))
    self delete();
}

avmx_is_player_mode() {
  return isdefined(self.player_mode) && self.player_mode;
}

avmx_get_sound_alias(var_0, var_1) {
  var_2 = self;
  var_3 = var_0.asset_names[soundscripts\_audio::aud_get_optional_param(0, var_1)];

  if(isdefined(var_3) && var_2 avmx_is_player_mode())
    var_3 = var_3 + "_plr";

  return var_3;
}

avmx_get_sound_alias_count(var_0) {
  return var_0.asset_names.size;
}

avmx_update_sound_ent_output_param(var_0, var_1) {
  switch (var_0) {
    case "volume":
      self scalevolume(var_1, 0.1);
      break;
    case "pitch":
      self scalepitch(var_1, 0.1);
      break;
    default:
      break;
  }
}

avmx_handle_oneshot_ducking(var_0) {
  var_1 = self;
  var_2 = var_0.ps_item;
  var_1 avmx_add_oneshot_ducking_scalar(var_2.name);
  var_1 avmx_update_oneshot_duck_scalar(var_0);
  var_1 avmx_remove_oneshot_ducking_scalar(var_2.name);
}

avmx_update_oneshot_duck_scalar(var_0) {
  var_1 = self;
  var_2 = var_1 avmx_get_instance_preset();
  var_3 = var_0.ps_item;
  level endon("msg_snd_vehicle_stop");
  level endon("msg_snd_vehicle_stop_" + var_1 avmx_get_instance_name());
  var_1 avmx_get_vehicle_entity() endon("death");

  if(isdefined(var_3.duck_env_name)) {
    var_4 = var_2 avmx_get_envelope(var_3.duck_env_name);
    var_5 = soundscripts\_audio::aud_get_envelope_domain(var_4);
    var_6 = 0;
    var_7 = var_5[1];

    for (var_8 = var_3.name; avmx_are_all_defined(var_0.snd_ents) && var_6 < var_7; var_6 = var_6 + 0.1) {
      var_9 = var_0 avmx_get_instance_sound_item_volume();
      var_10 = var_2 avmx_map_input(var_6, var_3.duck_env_name);
      var_10 = 1.0 - var_9 * (1.0 - var_10);
      var_1 avmx_set_oneshot_ducking_scalar(var_8, var_10);
      wait 0.1;
    }
  }
}

avmx_are_all_defined(var_0) {
  var_1 = 1;

  foreach(var_3 in var_0) {
    if(!isdefined(var_3)) {
      var_1 = 0;
      break;
    }
  }

  return var_1;
}

avmx_add_oneshot_ducking_scalar(var_0) {
  self.oneshot_duck_vals[var_0] = 1.0;
}

avmx_remove_oneshot_ducking_scalar(var_0) {
  self.oneshot_duck_vals[var_0] = undefined;
}

avmx_set_oneshot_ducking_scalar(var_0, var_1) {
  self.oneshot_duck_vals[var_0] = var_1;
}

avmx_normalize_ranged_value(var_0, var_1, var_2) {
  return (var_0 - var_1) / (var_2 - var_1);
}

avmx_get() {
  return level._audio.vm;
}

avmx_get_callback(var_0) {
  return avmx_get().callbacks[var_0][0];
}

avmx_get_preset_name() {
  return self.header.preset_name;
}

avmx_set_preset_name(var_0) {
  self.header.preset_name = var_0;
}

avmx_set_instance_init_callback(var_0) {
  self.global_data.instance_init_callback = var_0;
}

avmx_get_instance_name() {
  return self.instance_name;
}

avmx_get_instance_preset_name() {
  return self.preset_name;
}

avmx_get_instance_preset() {
  return avmx_get_preset(self.preset_name);
}

avmx_get_preset(var_0) {
  var_1 = avmx_get();
  return var_1.presets[var_0];
}

avmx_get_instance(var_0, var_1) {
  var_2 = undefined;
  var_3 = avmx_get();

  if(isstring(var_1)) {
    var_4 = avmx_get_preset(var_1);

    if(isdefined(var_4))
      var_2 = var_4.instances[var_0];
  } else {
    foreach(var_4 in var_3.presets) {
      foreach(var_7 in var_4.instances) {
        if(var_7.instance_name == var_0) {
          var_2 = var_7;
          break;
        }
      }
    }
  }

  return var_2;
}

avmx_get_vehicle_entity() {
  return self.veh_ent;
}

avmx_get_sound_instance() {
  return self.snd_instance;
}

avmx_get_fadein_time() {
  return self.header.fadein_time;
}

avmx_get_fadeout_time() {
  return self.header.fadeout_time;
}

avmx_set_behavior_oneshot_overrides(var_0, var_1) {
  var_0.oneshot_overrides = var_1;
}

avmx_get_behavior_restricted_oneshots(var_0) {
  var_1 = self;
  var_2 = [];
  var_3 = var_0.ps_item;
  var_4 = avmx_get_preset(var_3.preset_name);
  var_5 = var_0.oneshot_overrides;

  if(!isdefined(var_5))
    var_5 = var_3.oneshots;

  foreach(var_7 in var_5) {
    if(var_1 avmx_get_oneshot_poly_mode(var_7) == 1)
      var_2[var_7] = var_7;
  }

  return var_2;
}

avmx_get_oneshot_poly_mode(var_0) {
  var_1 = self;
  var_2 = var_1.oneshot_list[var_0].ps_item;
  return var_2.oneshot_poly_mode;
}

avmx_get_oneshot_update_mode(var_0) {
  var_1 = self;
  var_2 = 0;

  if(isstring(var_0))
    var_3 = var_1.oneshot_list[var_0].ps_item;
  else
    var_3 = var_0.ps_item;

  var_2 = var_3.oneshot_update_mode;

  if(!isdefined(var_2))
    var_2 = 0;

  return var_2;
}

avmx_get_envelope(var_0) {
  return self.env_data[var_0];
}

avmx_map_input(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 avmx_get_envelope(var_1);

  if(isdefined(var_3.env_function))
    var_4 = [
      [var_3.env_function]
    ](var_0);
  else
    var_4 = piecewiselinearlookup(var_0, var_3.env_array);

  return var_4;
}

avmx_start_loop(var_0) {
  var_1 = self;
  var_2 = var_1 avmx_get_instance_preset();
  var_3 = var_1 avmx_get_vehicle_entity();
  var_4 = var_0.ps_item;
  var_5 = var_2 avmx_get_sound_alias_count(var_4);
  var_6 = var_1.sound_offset;
  var_7 = var_0.ps_item.fadeout_time;
  var_8 = 1.0;
  var_0.fade_in_inc = 0.1 / var_7;
  var_0.fade_in_scalar = 0;

  for (var_9 = 0; var_9 < var_5; var_9++) {
    var_10 = var_1 avmx_get_sound_alias(var_4, var_9);
    var_11 = spawn("script_origin", var_3.origin);
    var_11 linkto(var_3, "tag_origin", var_6, (0, 0, 0));
    var_11 scalevolume(0);
    var_11 soundscripts\_snd_playsound::snd_play_loop(var_10);
    var_0.snd_ents[var_10] = var_11;
  }
}

avmx_stop_loop(var_0) {
  var_1 = self;
  var_2 = var_0.snd_ents;
  var_0.snd_ents = [];

  foreach(var_4 in var_2)
  var_4 thread avmx_stop_snd_ent(var_0.ps_item.fadeout_time);
}

avmx_stop_snd_ent(var_0) {
  var_1 = self;
  var_0 = max(0.05, soundscripts\_audio::aud_get_optional_param(0.05, var_0));

  if(isdefined(var_1)) {
    var_1 setvolume(0, var_0);
    wait(var_0);

    if(isdefined(var_1))
      var_1 stopsounds();

    wait 0.05;

    if(isdefined(var_1))
      var_1 delete();
  }
}

vm2x_fadeout_vehicle(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.loop_list)
  var_3 avmx_fade_stop_and_delete_sound_obj(var_0);

  foreach(var_6 in var_1.oneshot_list)
  var_6 avmx_fade_stop_and_delete_sound_obj(var_0);
}

avmx_fade_stop_and_delete_sound_obj(var_0) {
  var_1 = self;

  switch (var_1.ps_item.asset_type) {
    case "alias":
      foreach(var_4, var_3 in var_1.snd_ents) {
        var_3 avmx_stop_snd_ent(var_0);
        var_1.snd_ents[var_4] = undefined;
      }

      break;
    case "soundevent":
      break;
    case "damb":
      break;
  }
}

vm2x_delete_vehicle_sound_ents() {
  var_0 = self;

  foreach(var_2 in var_0.loop_list) {
    switch (var_2.ps_item.asset_type) {
      case "alias":
        var_2.snd_ents thread avmx_stop_snd_ent(0.05);
        var_2.snd_ents = [];
        break;
      case "soundevent":
        break;
      case "damb":
        break;
      default:
        break;
    }
  }

  foreach(var_5 in var_0.oneshot_list) {
    foreach(var_7 in var_5.snd_ents)
    var_7 thread avmx_stop_snd_ent(0.05);

    var_5.snd_ents = [];
  }
}

units2yards(var_0) {
  return var_0 * 0.0277778;
}

yards2units(var_0) {
  return var_0 * 36;
}

dist2yards(var_0) {
  return var_0 * 0.0277778;
}

yards2dist(var_0) {
  return var_0 * 36;
}

avmx_vehicle_getspeed() {
  var_0 = 0;

  if(avmx_is_vehicle_proxy() == 0)
    var_0 = self vehicle_getspeed();

  return var_0;
}