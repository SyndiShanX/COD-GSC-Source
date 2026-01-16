/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_mi28_aud.gsc
*****************************************/

snd_init_mi28() {
  soundscripts\_snd::snd_message("snd_register_vehicle", "mi28", ::snd_mi28_constructor);
}

snd_start_mi28() {
  if(isdefined(self.snd_instance)) {
    wait 1.0;
    snd_stop_mi28(1.0);
  }

  var_0 = spawnstruct();
  var_0.preset_name = "mi28";
  soundscripts\_snd::snd_message("snd_start_vehicle", var_0);
}

snd_stop_mi28(var_0) {
  if(isdefined(self.snd_instance)) {
    soundscripts\_snd::snd_message("snd_stop_vehicle", var_0);
    self notify("snd_stop_vehicle");
  }
}

snd_mi28_constructor() {
  soundscripts\_audio_vehicle_manager::avm_begin_preset_def("mi28");
  soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("havoc_engine_dist_loop");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "mi28_dist_towards_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_dist_towards_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler", 0.65, 0.3);
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_doppler2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("havoc_engine_high");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "mi28_close_towards_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler", 0.65, 0.3);
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_doppler2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("havoc_idle_high");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "mi28_close_towards_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler", 0.65, 0.3);
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_doppler2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_end_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("h1r_havoc_start_rev", "mi28_windup_duck");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "mi28_by_windup_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("h1r_havoc_pass_by", "mi28_flyby_duck_envelope");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_flyby_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "mi28_flyby_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler", 0.65, 0.3);
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "mi28_doppler2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover", ::mi28_condition_callback_to_hover, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly", ::mi28_condition_callback_to_fly, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_hover", ::mi28_condition_callback_to_fly, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_add_oneshots("h1r_havoc_start_rev");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant", ::mi28_condition_callback_to_distant, ["distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("havoc_engine_dist_loop");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby", ::mi28_condition_callback_to_flyby, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_add_oneshots("h1r_havoc_pass_by");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
  soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25, 0.5);
  soundscripts\_audio_vehicle_manager::avm_begin_state_group("engine_oneshots", "state_fly", "to_state_fly", 50, 1.0);
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly", "to_state_fly_from_hover");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby", "to_state_flyby");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant", "to_state_distant");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover", "to_state_hover");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly", "to_state_fly");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby", "to_state_flyby");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_fly");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover", "to_state_hover");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby", "to_state_flyby");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant", "to_state_distant");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby", 7.0);
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover", "to_state_hover");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly", "to_state_fly");
  soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant", "to_state_distant");
  soundscripts\_audio_vehicle_manager::avm_end_state_def();
  soundscripts\_audio_vehicle_manager::avm_end_state_group();
  soundscripts\_audio_vehicle_manager::avm_end_state_data();
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_dist_towards_vel2vol", [[0, 1.0],
    [10, 1.0],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_close_towards_vel2vol", [[0, 1.0],
    [20, 1.0],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_dist_towards_vel2pch", [[0, 0.8],
    [10, 1.0],
    [20, 1.1]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_windup_duck", [[0.0, 1.0],
    [0.25, 1.0],
    [0.3, 0.7],
    [0.7, 1.0],
    [1.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_by_windup_vel2vol", [[0.0, 0.0],
    [3.0, 0.3],
    [5.0, 0.7],
    [8.0, 0.8],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_flyby_duck_envelope", [[0.0, 1.0],
    [0.15, 1.0],
    [0.3, 0.5],
    [0.5, 0.55],
    [0.6, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_flyby_vel2vol", [[0.0, 0.0],
    [16.08, 0.0],
    [20.1, 0.5],
    [40.2, 0.8],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_flyby_vel2pch", [[0.0, 0.8],
    [20.1, 1.0],
    [150.0, 1.1]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("mi28_doppler2pch", [[0.0, 0.0],
    [2.0, 2.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

mi28_condition_callback_to_hover(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["distance2d"];
  var_4 = soundscripts\_audio_vehicle_manager::dist2yards(var_3);

  if(var_2 < 1.1 && var_4 < 3000)
    return 1;

  return 0;
}

mi28_condition_callback_to_fly(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["distance2d"];
  var_4 = soundscripts\_audio_vehicle_manager::dist2yards(var_3);

  if(var_2 >= 1.1 && var_4 < 3000)
    return 1;

  return 0;
}

mi28_condition_callback_to_flyby(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0["distance2d"];
  var_4 = soundscripts\_audio_vehicle_manager::dist2yards(var_3);
  var_5 = var_0["speed"];

  if(!isdefined(var_1.flyby)) {
    var_1.flyby = spawnstruct();
    var_1.flyby.prev_dist = var_3;
    var_1.flyby.prev_dx = 0;
  } else {
    var_6 = var_3 - var_1.flyby.prev_dist;

    if(var_6 < 0 && var_4 < 2500 && var_5 >= 20.1)
      var_2 = 1;

    var_1.flyby.prev_dist = var_3;
    var_1.flyby.prev_dx = var_6;
  }

  return var_2;
}

mi28_condition_callback_to_distant(var_0, var_1) {
  var_2 = var_0["distance2d"];
  var_3 = soundscripts\_audio_vehicle_manager::dist2yards(var_2);

  if(var_3 >= 3000)
    return 1;

  return 0;
}