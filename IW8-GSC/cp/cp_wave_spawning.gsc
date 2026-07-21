/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_wave_spawning.gsc
***********************************************/

init_wave_spawning() {
  if(!isDefined(level.wave_table)) {
    if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_B6570B78A33FB39B3317E886AB")
      level.wave_table = "_encstr_911904535326" + getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") + "_encstr_A6C11037FF878B87E73D4F66726D1AC3F634";
    else
      level.wave_table = "_encstr_A74B1D73F16ACEDBB0A9DAD2917D9F849197E9EE6341D367C68072DE39D653";
  }

  level thread initialize_wave_spawn_modules();
}

initialize_wave_spawn_modules() {
  var_0 = [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_99FB16EC27BD5D835991BE7758ECACBEB9E00BDDE64B37EC", 0, 0];
  var_1 = [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_99FB16EC27BD5D835991BE7758ECACBEB9E00BDDE64B37EC", [scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  var_2 = [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_99FB16EC27BD5D835991BE7758ECACBEB9E00BDDE64B37EC", [scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", var_0, var_1, undefined, [::wave_spawn_proc, undefined, undefined, 0.1, [scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, ::return_wave_veh_spawners, ::init_wave_spawning_module_proc);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", var_0, var_2, undefined, [::wave_spawn, undefined, undefined, [scripts\cp\cp_modular_spawning::get_spawn_time_from_wave, 1], [scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, scripts\cp\cp_modular_spawning::return_cover_spawners, ::init_wave_spawning_module);
  scripts\cp\cp_spawning_util::_id_12AEC("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::_id_12216, ::_id_13F23);
  scripts\cp\cp_spawning_util::register_module_init_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_spawning_util::combine_module_counters, "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2"]);
  scripts\cp\cp_modular_spawning::register_module_as_passive("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", "_encstr_A6F90CB2FC09825758B150955870", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAC, 750]);
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAB, 64]);
    scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", 750, 1024, 2500, 1);
  } else
    scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", 1024, 1536, 2500, 1);

  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::start_leave_cave);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", ::start_leave_cave);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::start_lap_time);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", ::start_lap_time);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::update_current_count_death);
  level thread create_paratrooper_spawners();
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 0, 30, 8, 0.5, undefined, ::return_paratroopers_spawners, ::init_paratroopers_spawners);
  scripts\cp\cp_spawning_util::register_module_init_func("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", [scripts\cp\cp_spawning_util::combine_module_counters, "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2"]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", scripts\cp\cp_aiparachute::paratrooper_spawnfunc);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 0, 2000, 200000, 1);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", ::update_current_count_death);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_99EC0E5397235BF8B3CDA9C1983B3070", 0, 24, undefined, 0.1, undefined, ::return_wave_veh_spawners, ::force_wave_vehicles_on);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A57811BBAB3BCF98E3599831BDD941FD822F19", 0, 1, undefined, 0.1, 0, "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, undefined, undefined);
  scripts\cp\cp_spawning_util::register_module_init_func("_encstr_A57811BBAB3BCF98E3599831BDD941FD822F19", [::cap_vehicle_type_on_module, "_encstr_A6F90CB2FC09825758B150955870", 1]);
}

start_leave_cave(var_0) {
  level._id_14519++;
}

start_lap_time(var_0) {
  if(!isDefined(var_0) && isDefined(self.group))
    var_0 = self.group;

  if(isDefined(var_0) && !istrue(var_0.kamikaze) && istrue(self._id_11E52)) {
    scripts\cp\cp_modular_spawning::_id_1393E(var_0);
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", undefined, "_encstr_A7D40BBB2C672BD7E459E8395E");
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [::_id_1301C, "_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03"]);
    level._id_14519--;
    return;
  }

  level._id_14518++;
}

_id_1301C(var_0, var_1) {
  var_0 notify(var_1);
}

init_wave_spawning_module(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag_exist("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4"))
    scripts\engine\utility::flag_init("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4");

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_0 scripts\cp\cp_modular_spawning::get_current_wave_ref(), 1);

  if(isDefined(level.spawn_module_structs_memory[var_0.group_name])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0.group_name].size; var_2++) {
      level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference = var_1;
      level.spawn_module_structs_memory[var_0.group_name][var_2].cover_node_spawners_override_id = 0;
      level.spawn_module_structs_memory[var_0.group_name][var_2].cover_node_spawners_override = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].wave_spawner_overrides = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].requested_spawners = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2]._id_12C43 = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].last_wave_num = level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference;
      level.spawn_module_structs_memory[var_0.group_name][var_2].last_wave_ref = level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference;
    }
  }

  var_0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
  scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", scripts\cp\cp_modular_spawning::setup_wave_vars);
  scripts\engine\utility::flag_set("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4");
  var_0 start_wave();
}

start_wave() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_14519 = 0;
  level._id_14518 = 0;
  scripts\cp\cp_modular_spawning::set_wave_settings();
  update_current_count(self);
  thread scripts\cp\cp_modular_spawning::show_all_player_wave_started_splash();
}

init_wave_spawning_module_proc(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag_exist("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4"))
    scripts\engine\utility::flag_init("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4");

  var_0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
  scripts\engine\utility::flag_wait("_encstr_860F1A13495CFFB9E899E1FF4DD03D2F10E03A7A73BBA72D4B951DF4");
}

cap_vehicle_type_on_module(var_0, var_1, var_2) {
  if(!isDefined(var_0.vehicle_caps))
    var_0.vehicle_caps = [];

  var_0.vehicle_caps[var_1] = var_2;
}

create_paratrooper_spawners() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = spawnStruct();
    scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", "_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", var_1);
    var_1.origin = getclosestpointonnavmesh((0, 0, 0));
    var_1.script_forcespawn = 1;
    var_1 scripts\cp\cp_modular_spawning::spawner_init();
  }
}

return_paratroopers_spawners(var_0) {
  if(istrue(var_0.respawning))
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var_0);
  else {
    var_1 = scripts\engine\utility::getStructArray("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    return var_1;
  }
}

init_paratroopers_spawners(var_0) {
  var_0 scripts\cp\cp_modular_spawning::ignoredeathsdoor(var_0, "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  var_1 = var_0 _id_11D96();
  var_2 = var_1.parachute_land_origin + (0, 0, 12000);
  var_3 = var_2 + anglesToForward((0, randomint(360), 0)) * -20000;

  if(getdvarint("_encstr_A3E6164B486839BF2963F170E298407B254BC0E98F605B32", 0)) {
    thread scripts\cp\utility::drawsphere(var_1.origin, 128, 60, (1, 1, 1));
    thread scripts\cp\utility::drawsphere(var_2, 128, 60, (1, 1, 0));
    thread scripts\cp\utility::drawsphere(var_3, 128, 60, (0, 1, 0));
  }

  var_4 = var_1 scripts\cp\cp_aiparachute::_id_135B0(var_0.group_name, var_3, var_2);
  var_0.ac130 = var_4;
  var_4 scripts\cp\cp_aiparachute::armored_basic_combat(var_2);
  var_4 thread scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::mp_deadzone_patch);
  var_0 _id_11D95();
  var_1 = var_0 _id_11D96(1);
}

mp_deadzone_patch() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1);
}

_id_11D95() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].origin = self.ac130.origin;

  waitframe();
}

_id_11D96(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = race_flow(scripts\cp\utility::get_center_point_of_array(level.players));

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].origin = var_2[var_3];
    var_1[var_3].parachute_land_origin = var_1[var_3].origin;

    if(istrue(var_0)) {
      if(getdvarint("_encstr_A3E6164B486839BF2963F170E298407B254BC0E98F605B32", 0))
        thread scripts\cp\utility::drawsphere(var_1[var_3].origin, 32, 60, (0, 1, 1));
    }
  }

  return var_1[0];
}

race_flow(var_0) {
  var_1 = [];
  var_2 = 12;
  var_3 = 2048;
  var_4 = 360 / var_2;
  var_5 = var_0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_3;
    var_9 = sin(var_7) * var_3;
    var_10 = var_5[0] + var_8;
    var_11 = var_5[1] + var_9;
    var_12 = var_5[2];
    var_0 = getclosestpointonnavmesh((var_10, var_11, var_12));
    var_13 = scripts\engine\trace::sphere_trace(var_5 + (0, 0, 48), var_0, 32, level.characters);

    if(isDefined(var_13) && isDefined(var_13["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"])) {
      var_0 = var_13["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
      var_0 = getgroundposition(var_0, 1, 1000, 1000);
      var_1[var_1.size] = var_0;
    }
  }

  return scripts\engine\utility::array_randomize(var_1);
}

force_wave_vehicles_on(var_0) {
  var_0.wave_use_vehicles = 1;
  var_0.valid_vehicles = [];
  var_0.valid_vehicles["_encstr_93230F29863BDBDB7F7718F03B9AF01BE3"] = 500;
  var_0.valid_vehicles["_encstr_88520840BAB5F918BF78"] = 500;
  var_0.valid_vehicles["_encstr_A9100DDA2D37325A161C7D53D59DCE"] = 500;
}

return_wave_veh_spawners(var_0) {
  if(istrue(var_0.respawning))
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var_0);
  else if(isDefined(var_0._id_12C43) && var_0._id_12C43.size > 0) {
    var_1 = [];

    for(var_2 = 0; var_2 < var_0._id_12C43.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_0._id_12C43[var_2], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = scripts\engine\utility::array_combine(var_1, var_3);
    }

    if(var_1.size > 0)
      return var_1;
    else if(istrue(var_0.wave_use_vehicles))
      return scripts\engine\utility::getStructArray("_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  } else if(istrue(var_0.wave_use_vehicles))
    return scripts\engine\utility::getStructArray("_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else
    return [];
}

wave_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("_encstr_8A2A0BBF610B8F89833BC79BE3");
  var_0 endon("_encstr_8A2A0BBF610B8F89833BC79BE3");

  if(isDefined(var_0.paratroopers_allowed) && var_0.paratroopers_allowed > 0) {
    var_0.paratroopers_allowed--;
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E");
  }

  if(isDefined(var_0._id_1451A) && var_0._id_1451A > 0) {
    var_0._id_1451A--;
    var_7 = spawnStruct();
    var_7.streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";

    if(!isDefined(var_7.shots_fired))
      var_7.shots_fired = 0;

    var_8 = scripts\cp\utility::get_array_of_valid_players();

    if(var_8.size > 0) {
      var_9 = scripts\engine\utility::random(var_8);
      var_7.owner = var_9;
      var_10 = level.scr_anim[var_7.streakname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"];
      thread scripts\cp_mp\killstreaks\airstrike::callstrike(var_9, var_9.origin, var_9.angles[1], undefined, var_7, var_10);
    }
  }

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var_2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var_3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_3, 0.1);
  var_11 = var_0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", "_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E"]);
  var_12 = var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var_4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var_0, var_4);
  var_5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var_0, var_5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var_4) && isDefined(var_5)) {
    if(istrue(var_0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "_encstr_96320917DD09B9C8E1FD2A");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_96320917DD09B9C8E1FD2A");
      var_0 waittill("_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03");
    } else if(var_11 < var_0.spawn_wave_total) {
      if(var_12 >= var_5) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_A9C00FBBC2A58ED743BE36BD5D9B8E7440" + var_4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_A9C00FBBC2A58ED743BE36BD5D9B8E7440" + var_4]);
        var_0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var_4);
        return var_3;
      } else {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_968D09CD0E85DDDC2D9BB3"]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_968D09CD0E85DDDC2D9BB3"]);
        return var_3;
      }
    } else {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "_encstr_96320917DD09B9C8E1FD2A");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_96320917DD09B9C8E1FD2A");
      var_0 waittill("_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03");
    }
  } else if(isDefined(var_0.spawn_wave_total) && isDefined(var_11) && var_11 >= var_0.spawn_wave_total) {
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "_encstr_96320917DD09B9C8E1FD2A");
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_96320917DD09B9C8E1FD2A");
    var_0 waittill("_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03");
  } else
    return var_3;
}

wave_spawn_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("_encstr_8A2A0BBF610B8F89833BC79BE3");
  var_0 endon("_encstr_8A2A0BBF610B8F89833BC79BE3");

  while(getdvarint("_encstr_A10C1738923A17C31FD18768A75F2B3B296B3068AA96B9D947", 0))
    wait 1;

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var_2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var_3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_3, 0.1);
  var_7 = var_0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", "_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E"]);
  var_8 = var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var_4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var_0, var_4);
  var_5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var_0, var_5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var_4) && isDefined(var_5)) {
    var_9 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var_0.use_only_veh_spawners) && (!isDefined(var_9) || var_9.size < 1))
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, ::_id_13F62);

    if(istrue(var_0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "_encstr_96320917DD09B9C8E1FD2A");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_96320917DD09B9C8E1FD2A");
      var_0 waittill("_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03");
    } else if(var_8 >= var_5) {
      if(var_7 < var_0.spawn_wave_total) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_A9C00FBBC2A58ED743BE36BD5D9B8E7440" + var_4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_A9C00FBBC2A58ED743BE36BD5D9B8E7440" + var_4]);
        var_0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var_4);
        return var_3;
      } else {
        scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "_encstr_96320917DD09B9C8E1FD2A");
        scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_96320917DD09B9C8E1FD2A");
        var_0 waittill("_encstr_8A8A108FE703D591142FF0A9D0C7D894EA03");
      }
    } else {
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_968D09CD0E85DDDC2D9BB3"]);
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", [scripts\cp\cp_modular_spawning::change_module_status, "_encstr_968D09CD0E85DDDC2D9BB3"]);
      return var_3;
    }
  } else
    return var_3;
}

_id_13F62(var_0, var_1) {
  var_0.wave_use_vehicles = undefined;
  var_0.use_only_veh_spawners = undefined;
}

_id_12A87() {
  return istrue(self._id_12A87);
}

increase_wave_num(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var_1)) {
    scripts\cp\cp_modular_spawning::reset_spawn_count_from_groupname(self.group_name);

    if(isstring(self.next_wave) && self.next_wave != "_encstr_B40101")
      self.last_wave_ref = self.next_wave;
    else if(isint(var_1)) {
      if(var_1 == self.last_wave_num)
        self.last_wave_num++;
      else
        self.last_wave_num = var_1;

      self.last_wave_ref = self.last_wave_num;
    } else
      self.last_wave_ref = var_1;

    self.wave_reference = self.last_wave_ref;
    scripts\cp\cp_modular_spawning::set_wave_settings_for_all_with_groupname(self.group_name, self.wave_reference, self.last_wave_ref, self.last_wave_num);

    if(istrue(var_0)) {
      return;
    }
    start_wave();
  }
}

_id_12216(var_0) {
  var_0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "_encstr_84AC0E2F609155E2E33F2266FDB70A0C");
  setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);
}

_id_13F23(var_0) {
  var_0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "_encstr_81BB10C107FBC3A92F7E29F893C643DB57B4");
}

killstreaks(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  scripts\cp\cp_modular_spawning::set_wave_ref_override(var_1);
}

update_current_count_death(var_0) {
  if(isDefined(var_0))
    var_1 = var_0;
  else if(isDefined(self.group))
    var_1 = self.group;
  else
    return 0;

  var_2 = var_1 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  level thread scripts\cp\cp_modular_spawning::_id_1451F(var_1);

  if(var_1 scripts\cp\cp_modular_spawning::turn_off_steam() && !istrue(var_1.kamikaze))
    _id_13F81(undefined, var_1);

  if(!istrue(var_1.kamikaze) && (istrue(var_1.stop_wave_spawning) && var_2 < var_1._id_11E6B)) {
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_1.group_name, [scripts\cp\cp_modular_spawning::toggle_kamikaze_for_group, 1]);
    level thread scripts\cp\cp_modular_spawning::wave_go_kamikaze(var_1);
  }
}

_id_13F81(var_0, var_1) {
  if(isDefined(var_0)) {
    if(var_0 >= 0)
      setomnvar("_encstr_B41B151BC1FACA73955B4B9537F59C595B582DCDB4B99D", var_0);

    level._id_1451E = var_0;
  } else {
    var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
    var_2 = scripts\engine\utility::array_combine(var_2, scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E"));
    var_1._id_13BE5 = var_1._id_13BE5 + 1;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(isDefined(var_2[var_4]._id_13BE5))
        var_3 = var_3 + var_2[var_4]._id_13BE5;
    }

    var_3 = level._id_14518;
    var_0 = var_1.spawn_wave_total - var_3;

    if(var_0 >= 0)
      setomnvar("_encstr_B41B151BC1FACA73955B4B9537F59C595B582DCDB4B99D", var_0);

    level._id_1451E = var_0;
  }
}

update_current_count(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.group))
      var_0 = self.group;
    else
      return 0;
  }

  if(var_0 scripts\cp\cp_modular_spawning::turn_off_steam() && var_0._id_13BE5 == 0)
    _id_13F81(var_0.spawn_wave_total, var_0);
}