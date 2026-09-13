/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_wave_spawning.gsc
***********************************************/

init_wave_spawning() {
  if(!isDefined(level.wave_table)) {
    if(getDvar("ui_gametype") == "cp_wave_sv")
      level.wave_table = "cp/" + getDvar("ui_mapname") + "_wave_table.csv";
    else
      level.wave_table = "cp/cp_donetsk_wave_table.csv";
  }

  level thread initialize_wave_spawn_modules();
}

initialize_wave_spawn_modules() {
  _id_C28F7DF6D5D55A37 = [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "grouped_wave_spawning", 0, 0];
  _id_61671992D4830187 = [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "grouped_wave_spawning", [::get_ambient_max_count, 30], 30];
  _id_C2B28BF6D5FBC0B9 = [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "grouped_wave_spawning", [::get_ambient_max_count, 30], 30];
  _id_18A73A64992DD07D::registerambientgroup("wave_spawning", _id_C28F7DF6D5D55A37, _id_61671992D4830187, undefined, [::wave_spawn_proc, undefined, undefined, 0.1, [::get_wave_low_threshold, 0], ::get_wave_high_threshold, 1], undefined, ::return_wave_veh_spawners, ::init_wave_spawning_module_proc);
  _id_18A73A64992DD07D::registerambientgroup("wave_spawning", _id_C28F7DF6D5D55A37, _id_C2B28BF6D5FBC0B9, undefined, [::wave_spawn, undefined, undefined, [::get_spawn_time_from_wave, 1], [::get_wave_low_threshold, 0], ::get_wave_high_threshold, 1], undefined, _id_18A73A64992DD07D::return_cover_spawners, ::init_wave_spawning_module);
  scripts\cp\cp_spawning_util::register_module_pause_unpause_funcs("wave_spawning", ::pause_wave_hud, ::unpause_wave_hud);
  scripts\cp\cp_spawning_util::register_module_init_func("wave_spawning", [scripts\cp\cp_spawning_util::combine_module_counters, "wave_spawning"]);
  _id_18A73A64992DD07D::register_module_as_passive("wave_spawning");

  if(scripts\cp\utility::is_wave_gametype()) {
    _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawning", [_id_18A73A64992DD07D::module_set_goal_radius, 750]);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawning", [_id_18A73A64992DD07D::module_set_goal_height, 64]);
    _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawning", 750, 1024, 2500, 1);
  } else
    _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawning", 1024, 1536, 2500, 1);

  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawning", ::increase_wave_ai_spawned_counter);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_paratroopers", ::increase_wave_ai_spawned_counter);
  _id_18A73A64992DD07D::register_module_ai_death_func("wave_spawning", ::increase_wave_ai_killed_counter);
  _id_18A73A64992DD07D::register_module_ai_death_func("wave_paratroopers", ::increase_wave_ai_killed_counter);
  _id_18A73A64992DD07D::register_module_ai_death_func("wave_spawning", ::update_current_count_death);
  level thread create_paratrooper_spawners();
  _id_18A73A64992DD07D::registerambientgroup("wave_paratroopers", 0, 30, 8, 0.5, undefined, ::return_paratroopers_spawners, ::init_paratroopers_spawners);
  scripts\cp\cp_spawning_util::register_module_init_func("wave_paratroopers", [scripts\cp\cp_spawning_util::combine_module_counters, "wave_spawning"]);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_paratroopers", scripts\cp\cp_aiparachute::paratrooper_spawnfunc);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_paratroopers", 0, 2000, 200000, 1);
  _id_18A73A64992DD07D::register_module_ai_death_func("wave_paratroopers", ::update_current_count_death);
  _id_18A73A64992DD07D::registerambientgroup("wave_veh_test", 0, 24, undefined, 0.1, undefined, ::return_wave_veh_spawners, ::force_wave_vehicles_on);
  _id_18A73A64992DD07D::registerambientgroup("attack_heli_test", 0, 1, undefined, 0.1, 0, "wave_veh_spawners", undefined, undefined, undefined);
  scripts\cp\cp_spawning_util::register_module_init_func("attack_heli_test", [::cap_vehicle_type_on_module, "attack_heli", 1]);
}

increase_wave_ai_spawned_counter(_id_F8E5E3AA5762A8E7) {
  level.wave_ai_spawned++;
}

increase_wave_ai_killed_counter(_id_F8E5E3AA5762A8E7) {
  if(!isDefined(_id_F8E5E3AA5762A8E7) && isDefined(self.group))
    _id_F8E5E3AA5762A8E7 = self.group;

  if(isDefined(_id_F8E5E3AA5762A8E7) && !istrue(_id_F8E5E3AA5762A8E7.kamikaze) && istrue(self.never_unloaded_from_vehicle)) {
    _id_18A73A64992DD07D::subtract_from_spawn_count_from_group(_id_F8E5E3AA5762A8E7);
    _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "wave_retry");
    _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_spawning", [::send_notify_to_module_struct, "wave_delay_over"]);
    level.wave_ai_spawned--;
    return;
  }

  level.wave_ai_killed++;
}

send_notify_to_module_struct(_id_F8E5E3AA5762A8E7, _id_FF5CCEDE2521CB13) {
  _id_F8E5E3AA5762A8E7 notify(_id_FF5CCEDE2521CB13);
}

init_wave_spawning_module(group) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized"))
    scripts\engine\utility::flag_init("wave_spawning_initialized");

  _id_A93265A5807D2927 = _id_18A73A64992DD07D::define_var_if_undefined(group get_current_wave_ref(), 1);

  if(isDefined(level.spawn_module_structs_memory[group.group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group.group_name].size; _id_AC0E594AC96AA3A8++) {
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].wave_reference = _id_A93265A5807D2927;
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].cover_node_spawners_override_id = 0;
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].cover_node_spawners_override = [];
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].wave_spawner_overrides = [];
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].requested_spawners = [];
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].requested_veh_spawners = [];
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].last_wave_num = level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].wave_reference;
      level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].last_wave_ref = level.spawn_module_structs_memory[group.group_name][_id_AC0E594AC96AA3A8].wave_reference;
    }
  }

  group init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_spawning", _id_18A73A64992DD07D::setup_wave_vars);
  scripts\engine\utility::flag_set("wave_spawning_initialized");
  group start_wave();
}

start_wave() {
  level endon("game_ended");
  level.wave_ai_spawned = 0;
  level.wave_ai_killed = 0;
  set_wave_settings();
  update_current_count(self);
  thread show_all_player_wave_started_splash();
}

init_wave_spawning_module_proc(group) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized"))
    scripts\engine\utility::flag_init("wave_spawning_initialized");

  group init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\engine\utility::flag_wait("wave_spawning_initialized");
}

cap_vehicle_type_on_module(_id_F8E5E3AA5762A8E7, _id_3D22F278EFD315CC, max_num) {
  if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps))
    _id_F8E5E3AA5762A8E7.vehicle_caps = [];

  _id_F8E5E3AA5762A8E7.vehicle_caps[_id_3D22F278EFD315CC] = max_num;
}

create_paratrooper_spawners() {
  scripts\engine\utility::flag_wait("cover_spawners_initialized");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    struct = spawnStruct();
    scripts\cp\utility::addtostructarray("targetname", "wave_paratroopers", struct);
    struct.origin = getclosestpointonnavmesh((0, 0, 0));
    struct.script_forcespawn = 1;
    struct _id_18A73A64992DD07D::spawner_init();
  }
}

return_paratroopers_spawners(group) {
  if(istrue(group.respawning))
    return _id_18A73A64992DD07D::return_cover_spawners(group);
  else {
    _id_07132F053DB6712D = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
    return _id_07132F053DB6712D;
  }
}

init_paratroopers_spawners(group) {
  group copy_wave_settings_from_module(group, "wave_spawning");
  spawner = group move_spawnpoints_to_valid_positions();
  _id_1E4BCE6C927436E0 = spawner.parachute_land_origin + (0, 0, 12000);
  spawnpos = _id_1E4BCE6C927436E0 + anglesToForward((0, randomint(360), 0)) * -20000;

  if(getdvarint("dvar_188F3D56A3849A78", 0)) {
    thread scripts\cp\utility::drawsphere(spawner.origin, 128, 60, (1, 1, 1));
    thread scripts\cp\utility::drawsphere(_id_1E4BCE6C927436E0, 128, 60, (1, 1, 0));
    thread scripts\cp\utility::drawsphere(spawnpos, 128, 60, (0, 1, 0));
  }

  ac130 = spawner scripts\cp\cp_aiparachute::spawn_paratrooper_ac130(group.group_name, spawnpos, _id_1E4BCE6C927436E0);
  group.ac130 = ac130;
  ac130 scripts\cp\cp_aiparachute::ac130_flight_path(_id_1E4BCE6C927436E0);
  ac130 thread scripts\engine\utility::thread_on_notify_no_endon_death("death", ::end_paratroopers_group);
  group move_spawnpoints_to_ac130();
  spawner = group move_spawnpoints_to_valid_positions(1);
}

end_paratroopers_group() {
  _id_18A73A64992DD07D::stop_module_by_groupname("wave_paratroopers", 1);
}

move_spawnpoints_to_ac130() {
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_07132F053DB6712D.size; _id_AC0E594AC96AA3A8++)
    _id_07132F053DB6712D[_id_AC0E594AC96AA3A8].origin = self.ac130.origin;

  waitframe();
}

move_spawnpoints_to_valid_positions(debug) {
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  _id_E4B7E99A96C8829F = get_positions_around_vector(scripts\cp\utility::get_center_point_of_array(level.players));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_07132F053DB6712D.size; _id_AC0E594AC96AA3A8++) {
    _id_07132F053DB6712D[_id_AC0E594AC96AA3A8].origin = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8];
    _id_07132F053DB6712D[_id_AC0E594AC96AA3A8].parachute_land_origin = _id_07132F053DB6712D[_id_AC0E594AC96AA3A8].origin;

    if(istrue(debug)) {
      if(getdvarint("dvar_188F3D56A3849A78", 0))
        thread scripts\cp\utility::drawsphere(_id_07132F053DB6712D[_id_AC0E594AC96AA3A8].origin, 32, 60, (0, 1, 1));
    }
  }

  return _id_07132F053DB6712D[0];
}

get_positions_around_vector(pos) {
  _id_7BBDA18A855C7111 = [];
  _id_152C303131C72FE2 = 12;
  dist = 2048;
  _id_9C59AFEFC22F0C25 = 360 / _id_152C303131C72FE2;
  starting_pos = pos;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_152C303131C72FE2; _id_AC0E594AC96AA3A8++) {
    angle = _id_9C59AFEFC22F0C25 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * dist;
    _id_D867033AB311670B = sin(angle) * dist;
    x = starting_pos[0] + _id_8A9F895755FD607E;
    y = starting_pos[1] + _id_D867033AB311670B;
    z = starting_pos[2];
    pos = getclosestpointonnavmesh((x, y, z));
    results = scripts\engine\trace::sphere_trace(starting_pos + (0, 0, 48), pos, 32, level.characters);

    if(isDefined(results) && isDefined(results["shape_position"])) {
      pos = results["shape_position"];
      pos = getgroundposition(pos, 1, 1000, 1000);
      _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = pos;
    }
  }

  return scripts\engine\utility::array_randomize(_id_7BBDA18A855C7111);
}

force_wave_vehicles_on(group) {
  group.wave_use_vehicles = 1;
  group.valid_vehicles = [];
  group.valid_vehicles["lbravo_carrier"] = 500;
  group.valid_vehicles["mindia8"] = 500;
}

return_wave_veh_spawners(group) {
  if(istrue(group.respawning))
    return _id_18A73A64992DD07D::return_cover_spawners(group);
  else if(isDefined(group.requested_veh_spawners) && group.requested_veh_spawners.size > 0) {
    _id_6D906809844C7CB1 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.requested_veh_spawners.size; _id_AC0E594AC96AA3A8++) {
      spawners = scripts\engine\utility::getStructArray(group.requested_veh_spawners[_id_AC0E594AC96AA3A8], "targetname");
      _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, spawners);
    }

    if(_id_6D906809844C7CB1.size > 0)
      return _id_6D906809844C7CB1;
    else if(istrue(group.wave_use_vehicles))
      return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
  } else if(istrue(group.wave_use_vehicles))
    return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
  else
    return [];
}

wave_spawn(group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count) {
  group notify("wave_spawn");
  group endon("wave_spawn");

  if(isDefined(group.paratroopers_allowed) && group.paratroopers_allowed > 0) {
    group.paratroopers_allowed--;
    _id_18A73A64992DD07D::run_spawn_module("wave_paratroopers");
  }

  if(isDefined(group.wave_airstrikes_allowed) && group.wave_airstrikes_allowed > 0) {
    group.wave_airstrikes_allowed--;
    streakinfo = spawnStruct();
    streakinfo.streakname = "precision_airstrike";

    if(!isDefined(streakinfo.shots_fired))
      streakinfo.shots_fired = 0;

    players = scripts\cp\utility::get_array_of_valid_players();

    if(players.size > 0) {
      player = scripts\engine\utility::random(players);
      streakinfo.owner = player;
      animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
      thread scripts\cp_mp\killstreaks\airstrike::callstrike(player, player.origin, player.angles[1], undefined, streakinfo, animname);
    }
  }

  wavetime = _id_18A73A64992DD07D::define_var_if_undefined(wavetime, _id_18A73A64992DD07D::get_passive_wave_spawn_time());
  spawn_window_time = _id_18A73A64992DD07D::define_var_if_undefined(spawn_window_time, _id_18A73A64992DD07D::get_passive_spawn_window_time());
  spawntime = _id_18A73A64992DD07D::define_var_if_undefined(spawntime, 0.1);
  _id_766E55DDCA02DFBA = group scripts\cp\cp_spawning_util::get_spawncount_from_groupnames(["wave_spawning", "wave_paratroopers"]);
  _id_3260FE8E5DBC524B = group _id_18A73A64992DD07D::get_activecount_from_group();
  low_threshold = _id_18A73A64992DD07D::get_passive_wave_low_threshold(group, low_threshold);
  high_threshold = _id_18A73A64992DD07D::get_passive_wave_high_threshold(group, high_threshold);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(low_threshold) && isDefined(high_threshold)) {
    if(istrue(group.stop_wave_spawning)) {
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname(group.group_name, 1, "end_wave");
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      group waittill("wave_delay_over");
    } else if(_id_766E55DDCA02DFBA < group.spawn_wave_total) {
      if(_id_3260FE8E5DBC524B >= high_threshold) {
        _id_18A73A64992DD07D::run_func_on_group_by_groupname(group.group_name, [_id_18A73A64992DD07D::change_module_status, "wait_4_count: " + low_threshold]);
        _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_paratroopers", [_id_18A73A64992DD07D::change_module_status, "wait_4_count: " + low_threshold]);
        group _id_18A73A64992DD07D::group_wait_for_activecount_notify(low_threshold);
        return spawntime;
      } else {
        _id_18A73A64992DD07D::run_func_on_group_by_groupname(group.group_name, [_id_18A73A64992DD07D::change_module_status, "spawning"]);
        _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_paratroopers", [_id_18A73A64992DD07D::change_module_status, "spawning"]);
        return spawntime;
      }
    } else {
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname(group.group_name, 1, "end_wave");
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      group waittill("wave_delay_over");
    }
  } else if(isDefined(group.spawn_wave_total) && isDefined(_id_766E55DDCA02DFBA) && _id_766E55DDCA02DFBA >= group.spawn_wave_total) {
    _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname(group.group_name, 1, "end_wave");
    _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
    group waittill("wave_delay_over");
  } else
    return spawntime;
}

wave_spawn_proc(group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count) {
  group notify("wave_spawn");
  group endon("wave_spawn");

  while(getdvarint("dvar_0B27EC95E27463B0", 0))
    wait 1;

  wavetime = _id_18A73A64992DD07D::define_var_if_undefined(wavetime, _id_18A73A64992DD07D::get_passive_wave_spawn_time());
  spawn_window_time = _id_18A73A64992DD07D::define_var_if_undefined(spawn_window_time, _id_18A73A64992DD07D::get_passive_spawn_window_time());
  spawntime = _id_18A73A64992DD07D::define_var_if_undefined(spawntime, 0.1);
  _id_766E55DDCA02DFBA = group scripts\cp\cp_spawning_util::get_spawncount_from_groupnames(["wave_spawning", "wave_paratroopers"]);
  _id_3260FE8E5DBC524B = group _id_18A73A64992DD07D::get_activecount_from_group();
  low_threshold = _id_18A73A64992DD07D::get_passive_wave_low_threshold(group, low_threshold);
  high_threshold = _id_18A73A64992DD07D::get_passive_wave_high_threshold(group, high_threshold);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(low_threshold) && isDefined(high_threshold)) {
    _id_F7A6739C47BA2EE1 = group _id_18A73A64992DD07D::get_allowed_vehicle_types_from_wave();

    if(istrue(group.use_only_veh_spawners) && (!isDefined(_id_F7A6739C47BA2EE1) || _id_F7A6739C47BA2EE1.size < 1))
      _id_18A73A64992DD07D::run_func_on_group_by_groupname(group.group_name, ::unset_vehicle_only_wave);

    if(istrue(group.stop_wave_spawning)) {
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname(group.group_name, 1, "end_wave");
      _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      group waittill("wave_delay_over");
    } else if(_id_3260FE8E5DBC524B >= high_threshold) {
      if(_id_766E55DDCA02DFBA < group.spawn_wave_total) {
        _id_18A73A64992DD07D::run_func_on_group_by_groupname(group.group_name, [_id_18A73A64992DD07D::change_module_status, "wait_4_count: " + low_threshold]);
        _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_paratroopers", [_id_18A73A64992DD07D::change_module_status, "wait_4_count: " + low_threshold]);
        group _id_18A73A64992DD07D::group_wait_for_activecount_notify(low_threshold);
        return spawntime;
      } else {
        _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname(group.group_name, 1, "end_wave");
        _id_18A73A64992DD07D::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
        group waittill("wave_delay_over");
      }
    } else {
      _id_18A73A64992DD07D::run_func_on_group_by_groupname(group.group_name, [_id_18A73A64992DD07D::change_module_status, "spawning"]);
      _id_18A73A64992DD07D::run_func_on_group_by_groupname("wave_paratroopers", [_id_18A73A64992DD07D::change_module_status, "spawning"]);
      return spawntime;
    }
  } else
    return spawntime;
}

unset_vehicle_only_wave(group, _id_B386118C13EFB928) {
  group.wave_use_vehicles = undefined;
  group.use_only_veh_spawners = undefined;
}

increase_wave_num(_id_2248EAE0B480DF1B) {
  _id_A980F9185C6C9DF8 = get_current_wave_ref();

  if(isDefined(_id_A980F9185C6C9DF8)) {
    _id_18A73A64992DD07D::reset_spawn_count_from_groupname(self.group_name);

    if(isstring(self.next_wave) && self.next_wave != "")
      self.last_wave_ref = self.next_wave;
    else if(isint(_id_A980F9185C6C9DF8)) {
      if(_id_A980F9185C6C9DF8 == self.last_wave_num)
        self.last_wave_num++;
      else
        self.last_wave_num = _id_A980F9185C6C9DF8;

      self.last_wave_ref = self.last_wave_num;
    } else
      self.last_wave_ref = _id_A980F9185C6C9DF8;

    self.wave_reference = self.last_wave_ref;
    _id_18A73A64992DD07D::set_wave_settings_for_all_with_groupname(self.group_name, self.wave_reference, self.last_wave_ref, self.last_wave_num);

    if(istrue(_id_2248EAE0B480DF1B)) {
      return;
    }
    start_wave();
  }
}

pause_wave_hud(_id_F8E5E3AA5762A8E7) {
  _id_F8E5E3AA5762A8E7 _id_18A73A64992DD07D::change_module_status(undefined, "Module Paused");
  setomnvar("cp_wave_timer", 0);
}

unpause_wave_hud(_id_F8E5E3AA5762A8E7) {
  _id_F8E5E3AA5762A8E7 _id_18A73A64992DD07D::change_module_status(undefined, "Module Unpaused");
}

delay_then_run_wave_override(timer, _id_9C3CFAF7756AAAC2) {
  if(isDefined(timer) && timer > 0)
    wait(timer);

  _id_18A73A64992DD07D::set_wave_ref_override(_id_9C3CFAF7756AAAC2);
}

update_current_count_death(group) {
  if(isDefined(group))
    _id_DE3A9F49D03BDACC = group;
  else if(isDefined(self.group))
    _id_DE3A9F49D03BDACC = self.group;
  else
    return 0;

  _id_3260FE8E5DBC524B = _id_DE3A9F49D03BDACC _id_18A73A64992DD07D::get_activecount_from_group();
  level thread _id_18A73A64992DD07D::wave_failsafe_end(_id_DE3A9F49D03BDACC);

  if(_id_DE3A9F49D03BDACC is_wave_hud_enabled() && !istrue(_id_DE3A9F49D03BDACC.kamikaze))
    update_enemies_remaining(undefined, _id_DE3A9F49D03BDACC);

  if(!istrue(_id_DE3A9F49D03BDACC.kamikaze) && (istrue(_id_DE3A9F49D03BDACC.stop_wave_spawning) && _id_3260FE8E5DBC524B < _id_DE3A9F49D03BDACC.next_threshold)) {
    _id_18A73A64992DD07D::run_func_on_group_by_groupname(_id_DE3A9F49D03BDACC.group_name, [_id_18A73A64992DD07D::toggle_kamikaze_for_group, 1]);
    level thread _id_18A73A64992DD07D::wave_go_kamikaze(_id_DE3A9F49D03BDACC);
  }
}

update_enemies_remaining(num, group) {
  if(isDefined(num)) {
    setomnvar("cp_enemies_remaining", num);
    level.wave_enemies_remaining = num;
  } else {
    _id_C43C439E2DF8BD7C = _id_18A73A64992DD07D::get_module_structs_by_groupname("wave_spawning");
    _id_C43C439E2DF8BD7C = scripts\engine\utility::array_combine(_id_C43C439E2DF8BD7C, _id_18A73A64992DD07D::get_module_structs_by_groupname("wave_paratroopers"));
    group.total_killed = group.total_killed + 1;
    count = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C43C439E2DF8BD7C.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8].total_killed))
        count = count + _id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8].total_killed;
    }

    count = level.wave_ai_killed;
    num = group.spawn_wave_total - count;
    setomnvar("cp_enemies_remaining", num);
    level.wave_enemies_remaining = num;
  }
}

update_current_count(group) {
  if(!isDefined(group)) {
    if(isDefined(self.group))
      group = self.group;
    else
      return 0;
  }

  if(group is_wave_hud_enabled() && group.total_killed == 0)
    update_enemies_remaining(group.spawn_wave_total, group);
}

init_passive_wave_struct() {
  struct = spawnStruct();
  struct.high_threshold = undefined;
  struct.low_threshold = undefined;
  struct.spawn_window_time = 5;
  struct.wave_spawn_time = 15;
  struct.min_count = 0;
  struct.max_count = 48;
  struct.wave_time_between_spawns = 1;
  struct.disable_wave_hud = 0;
  self.passive_wave_settings = struct;
}

set_wave_settings() {
  if(isDefined(level.wave_table))
    wave_table = level.wave_table;
  else if(getDvar("ui_gametype") == "cp_wave_sv")
    wave_table = "cp/" + getDvar("ui_mapname") + "_wave_table.csv";
  else
    wave_table = "cp/cp_donetsk_wave_table.csv";

  if(getdvarint("dvar_1661CDBAEDD6CA75", 1) && tableexists(wave_table)) {
    table = wave_table;
    group_name = "wave_spawning";

    if(isDefined(level.spawn_module_structs_memory[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++) {
        _id_F8E5E3AA5762A8E7 = level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8];
        _id_FD12DFCA9E789574 = _id_F8E5E3AA5762A8E7 get_current_wave_ref();
        _id_F8E5E3AA5762A8E7.valid_vehicles = [];
        _id_F8E5E3AA5762A8E7.valid_vehicles["lbravo_carrier"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 15));
        _id_F8E5E3AA5762A8E7.valid_vehicles["mindia8"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 16));
        _id_F8E5E3AA5762A8E7.valid_vehicles["attack_heli"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 19));

        if(scripts\engine\utility::array_sum(_id_F8E5E3AA5762A8E7.valid_vehicles) > 0)
          _id_F8E5E3AA5762A8E7.wave_use_vehicles = 1;

        _id_F8E5E3AA5762A8E7.spawn_aitype_counts = [];
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["ar"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 1));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["ar_heavy"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 2));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["ar_heavy_laser"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 3));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["smg"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 4));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["smg_heavy"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 5));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["shotgun"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 6));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["shotgun_heavy"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 7));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["rpg"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 8));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["lmg"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 9));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["lmg_heavy"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 10));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["sniper"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 11));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["goliath"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 12));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["suicidebomber"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 13));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts["juggernaut"] = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 14));
        _id_F8E5E3AA5762A8E7.spawn_aitype_counts = _id_F8E5E3AA5762A8E7 _id_18A73A64992DD07D::remove_invalid_aitypes();
        _id_F8E5E3AA5762A8E7.wave_difficulty = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 22));
        _id_F8E5E3AA5762A8E7.high_threshold = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 23));
        _id_F8E5E3AA5762A8E7.min_count = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 24));
        _id_F8E5E3AA5762A8E7.next_threshold = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 25));
        _id_F8E5E3AA5762A8E7.timeout_after_min_count = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 26));
        _id_F8E5E3AA5762A8E7.next_wave = tablelookup(table, 0, _id_FD12DFCA9E789574, 29);
        _id_F8E5E3AA5762A8E7.use_only_veh_spawners = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 32));
        _id_F8E5E3AA5762A8E7.paratroopers_allowed = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 20));
        _id_F8E5E3AA5762A8E7.wave_airstrikes_allowed = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 21));
        _id_2831269A752E5BF5 = float(tablelookup(table, 0, _id_FD12DFCA9E789574, 30));
        _id_F8E5E3AA5762A8E7.wave_time_between_spawns = scripts\engine\utility::ter_op(_id_2831269A752E5BF5 > 0, _id_2831269A752E5BF5, 1);

        if(scripts\cp\utility::is_wave_gametype())
          _id_F8E5E3AA5762A8E7.disable_wave_hud = int(tablelookup(table, 0, _id_FD12DFCA9E789574, 31));
        else
          _id_F8E5E3AA5762A8E7.disable_wave_hud = 1;

        _id_F8E5E3AA5762A8E7.spawn_wave_total = scripts\engine\utility::array_sum(_id_F8E5E3AA5762A8E7.spawn_aitype_counts) + _id_F8E5E3AA5762A8E7.paratroopers_allowed * 8;
        _id_F8E5E3AA5762A8E7.total_killed = 0;
        _id_F8E5E3AA5762A8E7.requested_spawners = [];
        _id_F077ADF688122C36 = strtok(tablelookup(table, 0, _id_FD12DFCA9E789574, 27), ",");

        if(isDefined(_id_F077ADF688122C36) && _id_F077ADF688122C36.size > 0) {
          for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F077ADF688122C36.size; _id_AC0E5C4AC96AAA41++)
            _id_F8E5E3AA5762A8E7 add_spawners_to_passive_wave_spawning(_id_F077ADF688122C36[_id_AC0E5C4AC96AAA41]);
        }

        _id_F8E5E3AA5762A8E7.requested_veh_spawners = [];
        _id_F077ADF688122C36 = strtok(tablelookup(table, 0, _id_FD12DFCA9E789574, 28), ",");

        if(isDefined(_id_F077ADF688122C36) && _id_F077ADF688122C36.size > 0) {
          for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F077ADF688122C36.size; _id_AC0E5C4AC96AAA41++)
            _id_F8E5E3AA5762A8E7 add_veh_spawners_to_passive_wave_spawning(_id_F077ADF688122C36[_id_AC0E5C4AC96AAA41]);
        }
      }
    }
  }
}

copy_wave_settings_from_module(_id_F8E5E3AA5762A8E7, group_name) {
  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    group = level.spawn_module_structs_memory[group_name][0];
    _id_F8E5E3AA5762A8E7.high_threshold = group.high_threshold;
    _id_F8E5E3AA5762A8E7.next_threshold = group.next_threshold;
    _id_F8E5E3AA5762A8E7.min_count = group.min_count;
    _id_F8E5E3AA5762A8E7.disable_wave_hud = group.disable_wave_hud;
  } else
    _id_F8E5E3AA5762A8E7.spawn_wave_total = _id_F8E5E3AA5762A8E7.totalspawns;
}

show_all_player_wave_started_splash() {
  level endon("game_ended");
  self endon("death");
  self endon("show_all_player_wave_started_splash");

  if(is_wave_hud_enabled() || scripts\cp\utility::is_wave_gametype()) {
    level notify("wave_starting");

    if(!isDefined(level.display_wave_num))
      level.display_wave_num = 1;
    else
      level.display_wave_num = level.display_wave_num + 1;

    setomnvar("cp_wave_number", level.display_wave_num);
    wait 0.1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      level.players[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level.display_wave_num, undefined);
      level.players[_id_AC0E594AC96AA3A8] setplayerdata("cp", "alienSession", "waveNum", level.display_wave_num);
      _id_3BCAA2CBAF54ABDD::update_player_career_highest_wave(level.players[_id_AC0E594AC96AA3A8], level.display_wave_num, level.players.size);
    }
  }

  wait 2;
}

is_wave_hud_enabled() {
  return !istrue(self.disable_wave_hud);
}

clear_wave_ref_override() {
  self.wave_reference_override = undefined;
}

get_wave_high_threshold(group) {
  if(isDefined(group.high_threshold))
    return int(group.high_threshold);
  else
    return int(group.spawn_wave_total);
}

get_spawn_time_from_wave(group, _id_D795F37A2BE44743) {
  if(isDefined(self.wave_time_between_spawns))
    return self.wave_time_between_spawns;
  else
    return _id_D795F37A2BE44743;
}

get_wave_low_threshold(group, _id_748A5B6E1EB008F5) {
  if(isDefined(group.min_count))
    return int(group.min_count);
  else
    return _id_748A5B6E1EB008F5;
}

get_current_wave_ref() {
  if(isDefined(level.first_wave_override)) {
    _id_748A5B6E1EB008F5 = level.first_wave_override;
    level.first_wave_override = undefined;
    return _id_748A5B6E1EB008F5;
  } else if(isDefined(self.wave_reference_override)) {
    _id_748A5B6E1EB008F5 = self.wave_reference_override;
    self.wave_reference_override = undefined;
    return _id_748A5B6E1EB008F5;
  } else if(isDefined(self.wave_reference))
    return self.wave_reference;
  else
    return undefined;
}

add_spawners_to_passive_wave_spawning(_id_B8C9EE08C9DB35F6) {
  if(!scripts\engine\utility::array_contains(self.requested_spawners, _id_B8C9EE08C9DB35F6)) {
    spawners = scripts\engine\utility::getStructArray(_id_B8C9EE08C9DB35F6, "targetname");

    if(spawners.size > 0) {
      self.requested_spawners[self.requested_spawners.size] = _id_B8C9EE08C9DB35F6;
      scripts\engine\utility::array_thread(spawners, _id_18A73A64992DD07D::spawner_init);
    }
  }
}

add_veh_spawners_to_passive_wave_spawning(_id_B8C9EE08C9DB35F6) {
  if(!scripts\engine\utility::array_contains(self.requested_veh_spawners, _id_B8C9EE08C9DB35F6)) {
    spawners = scripts\engine\utility::getStructArray(_id_B8C9EE08C9DB35F6, "targetname");

    if(spawners.size > 0) {
      self.requested_veh_spawners[self.requested_veh_spawners.size] = _id_B8C9EE08C9DB35F6;
      scripts\engine\utility::array_thread(spawners, _id_18A73A64992DD07D::spawner_init);
    }
  }
}

module_wave_spawn(group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count) {
  wavetime = _id_18A73A64992DD07D::define_var_if_undefined(wavetime, _id_18A73A64992DD07D::get_passive_wave_spawn_time());
  spawn_window_time = _id_18A73A64992DD07D::define_var_if_undefined(spawn_window_time, _id_18A73A64992DD07D::get_passive_spawn_window_time());
  spawntime = _id_18A73A64992DD07D::define_var_if_undefined(spawntime, 0.1);
  _id_766E55DDCA02DFBA = _id_18A73A64992DD07D::define_var_if_undefined(spawn_count, group _id_18A73A64992DD07D::get_activecount_from_group());
  low_threshold = _id_18A73A64992DD07D::get_passive_wave_low_threshold(group, low_threshold);
  high_threshold = _id_18A73A64992DD07D::get_passive_wave_high_threshold(group, high_threshold);

  if(istrue(group.spawn_window_open)) {
    if(!istrue(group.disable_wave_hud))
      setomnvar("cp_wave_timer", 0);

    return spawntime;
  } else {
    time = gettime();

    if(isDefined(low_threshold) && isDefined(high_threshold)) {
      if(isDefined(spawn_count)) {
        if(group.spawn_count > 0 && group.spawn_count % high_threshold == 0) {
          group _id_18A73A64992DD07D::change_module_status(undefined, "low_threshold: " + low_threshold);
          group _id_18A73A64992DD07D::group_wait_for_activecount_notify(low_threshold);
          group _id_18A73A64992DD07D::change_module_status(undefined, "wave_delay");
          group _id_18A73A64992DD07D::wave_cooldown_time(wavetime);
          wait(wavetime);

          if(!istrue(group.disable_wave_hud))
            setomnvar("cp_wave_timer", 0);

          group increase_wave_num();
          group _id_18A73A64992DD07D::change_module_status(undefined, "spawning_after_low_threshold");
        } else {
          group _id_18A73A64992DD07D::change_module_status(undefined, "spawning_to_high_threshold");
          return spawntime;
        }
      } else if(_id_766E55DDCA02DFBA >= high_threshold) {
        group _id_18A73A64992DD07D::change_module_status(undefined, "low_threshold: " + low_threshold);
        group _id_18A73A64992DD07D::group_wait_for_activecount_notify(low_threshold);
        group _id_18A73A64992DD07D::change_module_status(undefined, "wave_delay");
        group _id_18A73A64992DD07D::wave_cooldown_time(wavetime);
        wait(wavetime);

        if(!istrue(group.disable_wave_hud))
          setomnvar("cp_wave_timer", 0);

        group increase_wave_num();
        group _id_18A73A64992DD07D::change_module_status(undefined, "spawning_after_low_threshold");
      } else {
        group _id_18A73A64992DD07D::change_module_status(undefined, "spawning_to_high_threshold");
        return spawntime;
      }
    } else if(!isDefined(group.last_wave_time)) {
      group _id_18A73A64992DD07D::change_module_status(undefined, "first_spawn_window");
      group.spawn_window_open = 1;
      group scripts\engine\utility::delaythread(spawn_window_time, _id_18A73A64992DD07D::disable_spawn_window);
      group scripts\engine\utility::delaythread(spawn_window_time, _id_18A73A64992DD07D::wave_cooldown_time, wavetime);
      return spawntime;
    } else {
      _id_546BDD6F69FD53E0 = group.last_wave_time + wavetime * 1000 - time;

      if(_id_546BDD6F69FD53E0 < 0) {
        group _id_18A73A64992DD07D::change_module_status(undefined, "full_spawn_window");
        group.spawn_window_open = 1;
        group scripts\engine\utility::delaythread(spawn_window_time, _id_18A73A64992DD07D::disable_spawn_window);
        group scripts\engine\utility::delaythread(spawn_window_time, _id_18A73A64992DD07D::wave_cooldown_time, wavetime);
        return spawntime;
      } else {
        group _id_18A73A64992DD07D::change_module_status(undefined, "wave_delay");
        return wavetime;
      }
    }
  }
}

get_ambient_max_count(group, _id_74EC7A474B47B41C) {
  if(getdvarint("dvar_A70FA5936C87D3FF", -1) != -1)
    return getdvarint("dvar_A70FA5936C87D3FF");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.max_count))
    return self.passive_wave_settings.max_count;
  else
    return _id_74EC7A474B47B41C;
}