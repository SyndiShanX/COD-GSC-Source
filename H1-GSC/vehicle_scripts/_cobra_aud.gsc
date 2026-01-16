/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_cobra_aud.gsc
******************************************/

snd_init_cobra() {
  soundscripts\_snd::snd_message("snd_register_vehicle", "cobra", ::snd_cobra_constructor);
}

snd_start_cobra() {
  if(isdefined(self.snd_instance)) {
    wait 1.0;
    snd_stop_cobra(1.0);
  }

  var_0 = spawnstruct();
  var_0.preset_name = "cobra";
  soundscripts\_snd::snd_message("snd_start_vehicle", var_0);
}

snd_stop_cobra(var_0) {
  if(isdefined(self.snd_instance)) {
    soundscripts\_snd::snd_message("snd_stop_vehicle", var_0);
    self notify("snd_stop_vehicle");
  }
}

snd_cobra_constructor() {
  soundscripts\_audio_vehicle_manager::avm_begin_preset_def("cobra");
  soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cobra_engine_far");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "cobra_dist_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "cobra_dist_vel2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cobra_idle_low");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "cobra_close_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated", 0.65, 0.3);
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch", "cobra_doppler2pch");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_loop_def();
  soundscripts\_audio_vehicle_manager::avm_end_loop_data();
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cobra_engine_rev", "cobra_engine_rev_duck");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "cobra_engine_rev_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
  soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cobra_pass_by", "cobra_flyby_duck_envelope");
  soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
  soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume", "cobra_flyby_vel2vol");
  soundscripts\_audio_vehicle_manager::avm_end_param_map();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
  soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover", ::cobra_condition_callback_to_hover, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly", ::cobra_condition_callback_to_fly, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_hover", ::cobra_condition_callback_to_fly, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_add_oneshots("cobra_engine_rev");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant", ::cobra_condition_callback_to_distant, ["distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("cobra_engine_far");
  soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
  soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby", ::cobra_condition_callback_to_flyby, ["speed", "distance2d"]);
  soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
  soundscripts\_audio_vehicle_manager::avm_add_oneshots("cobra_pass_by");
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
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_dist_vel2vol", [[0, 1.0],
    [10, 1.0],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_dist_vel2pch", [[0, 0.8],
    [10, 1.0],
    [20, 1.1]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_close_vel2vol", [[0, 1.0],
    [20, 1.0],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_engine_rev_duck", [[0.0, 1.0],
    [0.25, 1.0],
    [0.3, 0.7],
    [0.7, 1.0],
    [1.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_engine_rev_vel2vol", [[0.0, 0.0],
    [1.0, 0.3],
    [3.0, 0.7],
    [8.0, 0.8],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_flyby_duck_envelope", [[0.0, 1.0],
    [0.15, 1.0],
    [0.3, 0.5],
    [0.5, 0.55],
    [0.6, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_flyby_vel2vol", [[0.0, 0.0],
    [16.08, 0.0],
    [20.1, 0.5],
    [40.2, 0.8],
    [150.0, 1.0]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_flyby_vel2pch", [[0.0, 0.8],
    [20.1, 1.0],
    [150.0, 1.1]
  ]);
  soundscripts\_audio_vehicle_manager::avm_add_envelope("cobra_doppler2pch", [[0.0, 0.8],
    [1.0, 1.0],
    [2.0, 1.8]
  ]);
  soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

cobra_condition_callback_to_hover(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["distance2d"];
  var_4 = soundscripts\_audio_vehicle_manager::dist2yards(var_3);

  if(var_2 < 1.1 && var_4 < 3000)
    return 1;

  return 0;
}

cobra_condition_callback_to_fly(var_0, var_1) {
  var_2 = var_0["speed"];
  var_3 = var_0["distance2d"];
  var_4 = soundscripts\_audio_vehicle_manager::dist2yards(var_3);

  if(var_2 >= 1.1 && var_4 < 3000)
    return 1;

  return 0;
}

cobra_condition_callback_to_flyby(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0["distance2d"];
  var_4 = var_0["speed"];

  if(!isdefined(var_1.flyby)) {
    var_1.flyby = spawnstruct();
    var_1.flyby.prev_dist = var_3;
  } else {
    var_5 = var_3 - var_1.flyby.prev_dist;
    var_6 = var_4 * 63360 / 60 / 60;
    var_7 = var_6 * 1.7;

    if(var_5 < 0 && var_3 <= var_7 && var_4 >= 20.1)
      var_2 = 1;

    var_1.flyby.prev_dist = var_3;
  }

  return var_2;
}

cobra_condition_callback_to_distant(var_0, var_1) {
  var_2 = var_0["distance2d"];
  var_3 = soundscripts\_audio_vehicle_manager::dist2yards(var_2);

  if(var_3 >= 3000)
    return 1;

  return 0;
}