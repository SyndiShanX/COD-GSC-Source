/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_m1a1_aud.gsc
*****************************************/

snd_init_m1a1() {
  soundscripts\_audio_vehicle_manager::avm_register_callback("about_to_stop", ::m1a1_input_callback_about_to_stop);
  soundscripts\_snd::snd_message("snd_register_vehicle", "m1a1", ::snd_m1a1_constructor);
}

snd_start_m1a1() {
  if(isdefined(self.snd_instance)) {
    wait 1.0;
    snd_stop_m1a1(1.0);
  }

  thread snd_monitor_about_to_stop();
  var_0 = spawnstruct();
  var_0.preset_name = "m1a1";
  soundscripts\_snd::snd_message("snd_start_vehicle", var_0);
}

snd_monitor_about_to_stop() {
  self endon("death");
  self endon("snd_stop_vehicle");
  self waittill("about_to_stop", var_0);

  if(var_0 > 1.0) {
    wait(var_0 - 1.0);

    if(!isdefined(self))
      return;
  }

  self.about_to_stop = 1;
}

snd_stop_m1a1(var_0) {
  if(isdefined(self.snd_instance)) {
    soundscripts\_snd::snd_message("snd_stop_vehicle", var_0);
    self notify("snd_stop_vehicle");
  }
}

snd_m1a1_constructor() {
  soundscripts\_audio_vehicle_manager::avm_begin_preset_def("m1a1");
  soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_idle_close_loop");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "m1a1_idle_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "m1a1_idle_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_close_loop");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "m1a1_engine_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "m1a1_engine_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_treads_loop");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "m1a1_treads_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "m1a1_treads_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_treads_loop_2");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "m1a1_treads_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "m1a1_treads_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_end_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle", ::m1a1_condition_callback_to_idle);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed", 1.0, 1.0);
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_stop");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_engine", ::m1a1_condition_callback_to_engine);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed", 1.0, 1.0);
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_stop");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
  soundscripts\_audio_vehicle_manager::avm_begin_state_data();
  soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots", "state_idle", "to_state_idle", 50, 0.1);
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_engine", "to_state_engine");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_engine", 1.0);
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle", "to_state_idle");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_end_state_group();
  soundscripts\_audio_vehicle_manager::avm_end_state_data();
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_idle_vel2vol", [[0.0, 1.0],
    [8.0, 0.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_idle_vel2pch", [[0.0, 1.0],
    [2.5, 1.25]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_engine_vel2vol", [[0.0, 0.0],
    [5.0, 0.7],
    [8.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_engine_vel2pch", [[0.0, 0.8],
    [8.0, 1.0],
    [10.0, 1.1]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_treads_vel2vol", [[0.0, 0.0],
    [5.0, 0.7],
    [8.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_treads_vel2pch", [[0.0, 0.8],
    [8.0, 1.2]
  ]);
  soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

m1a1_input_callback_about_to_stop() {
  var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
  return isdefined(var_0.about_to_stop);
}

m1a1_condition_callback_to_idle(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["about_to_stop"];

  if(var_2 <= 0.01 || var_3 > 0.5)
    return 1;

  return 0;
}

m1a1_condition_callback_to_engine(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["about_to_stop"];

  if(var_2 > 0.01 && var_3 < 0.5)
    return 1;

  return 0;
}