/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_wave_spawning.gsc
***********************************************/

function init_wave_spawning() {
  if(!isDefined(level.wave_table)) {
    if(getDvar("ui_gametype") == "cp_wave_sv") {
      level.wave_table = "cp/" + getDvar("ui_mapname") + "_wave_table.csv";
    } else {
      level.wave_table = "cp/cp_donetsk_wave_table.csv";
    }
  }

  thread initialize_wave_spawn_modules();
}

function initialize_wave_spawn_modules() {
  var_0 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", 0, 0];
  var_1 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  var_2 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_spawning", var_0, var_1, undefined, [ &wave_spawn_proc, undefined, undefined, 0.1, [ &scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], &scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, &return_wave_veh_spawners, &init_wave_spawning_module_proc);
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_spawning", var_0, var_2, undefined, [ &wave_spawn, undefined, undefined, [ &scripts\cp\cp_modular_spawning::get_spawn_time_from_wave, 1], [ &scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], &scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, &scripts\cp\cp_modular_spawning::return_cover_spawners, &init_wave_spawning_module);
  scripts\cp\cp_spawning_util::ref_12AEC("wave_spawning", &ref_12216, &ref_13F23);
  scripts\cp\cp_spawning_util::register_module_init_func("wave_spawning", [ &scripts\cp\cp_spawning_util::combine_module_counters, "wave_spawning"]);
  scripts\cp\cp_modular_spawning::register_module_as_passive("wave_spawning");
  scripts\cp\cp_vehicles::ref_12AE5("wave_spawning", "attack_heli", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11CAC, 750]);
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11CAB, 64]);
    scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("wave_spawning", 750, 1024, 2500, 1);
  } else {
    scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("wave_spawning", 1024, 1536, 2500, 1);
  }

  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", &start_leave_cave);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_paratroopers", &start_leave_cave);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("wave_spawning", &start_lap_time);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("wave_paratroopers", &start_lap_time);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("wave_spawning", &update_current_count_death);
  thread create_paratrooper_spawners();
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_paratroopers", 0, 30, 8, 0.5, undefined, &return_paratroopers_spawners, &init_paratroopers_spawners);
  scripts\cp\cp_spawning_util::register_module_init_func("wave_paratroopers", [ &scripts\cp\cp_spawning_util::combine_module_counters, "wave_spawning"]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_paratroopers", &scripts\cp\cp_aiparachute::paratrooper_spawnfunc);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("wave_paratroopers", 0, 2000, 200000, 1);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("wave_paratroopers", &update_current_count_death);
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_veh_test", 0, 24, undefined, 0.1, undefined, &return_wave_veh_spawners, &force_wave_vehicles_on);
  scripts\cp\cp_modular_spawning::registerambientgroup("attack_heli_test", 0, 1, undefined, 0.1, 0, "wave_veh_spawners", undefined, undefined, undefined);
  scripts\cp\cp_spawning_util::register_module_init_func("attack_heli_test", [ &cap_vehicle_type_on_module, "attack_heli", 1]);
}

function start_leave_cave(var_0) {
  level.ref_14519++;
}

function start_lap_time(var_0) {
  if(!isDefined(var_0) && isDefined(self.group)) {
    var_0 = self.group;
  }

  if(isDefined(var_0) && !istrue(var_0.kamikaze) && istrue(self.ref_11E52)) {
    scripts\cp\cp_modular_spawning::ref_1393E(var_0);
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "wave_retry");
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &ref_1301C, "wave_delay_over"]);
    level.ref_14519--;
    return;
  }

  level.ref_14518++;
}

function ref_1301C(var_0, var_1) {
  var_0 notify(var_1);
}

function init_wave_spawning_module(var_0) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized")) {
    scripts\engine\utility::flag_init("wave_spawning_initialized");
  }

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_0 scripts\cp\cp_modular_spawning::get_current_wave_ref(), 1);

  if(isDefined(level.spawn_module_structs_memory[var_0.group_name])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0.group_name].size; var_2++) {
      level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference = var_1;
      level.spawn_module_structs_memory[var_0.group_name][var_2].cover_node_spawners_override_id = 0;
      level.spawn_module_structs_memory[var_0.group_name][var_2].cover_node_spawners_override = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].wave_spawner_overrides = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].requested_spawners = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].ref_12C43 = [];
      level.spawn_module_structs_memory[var_0.group_name][var_2].last_wave_num = level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference;
      level.spawn_module_structs_memory[var_0.group_name][var_2].last_wave_ref = level.spawn_module_structs_memory[var_0.group_name][var_2].wave_reference;
    }
  }

  var_0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", &scripts\cp\cp_modular_spawning::setup_wave_vars);
  scripts\engine\utility::flag_set("wave_spawning_initialized");
  start_wave(var_0);
}

function start_wave() {
  level endon("game_ended");
  level.ref_14519 = 0;
  level.ref_14518 = 0;
  scripts\cp\cp_modular_spawning::set_wave_settings();
  update_current_count(self);
  thread scripts\cp\cp_modular_spawning::show_all_player_wave_started_splash();
}

function init_wave_spawning_module_proc(var_0) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized")) {
    scripts\engine\utility::flag_init("wave_spawning_initialized");
  }

  var_0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\engine\utility::flag_wait("wave_spawning_initialized");
}

function cap_vehicle_type_on_module(var_0, var_1, var_2) {
  if(!isDefined(var_0.vehicle_caps)) {
    var_0.vehicle_caps = [];
  }

  var_0.vehicle_caps[var_1] = var_2;
}

function create_paratrooper_spawners() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = spawnStruct();
    scripts\cp\utility::addtostructarray("targetname", "wave_paratroopers", var_1);
    var_1.origin = getclosestpointonnavmesh((0, 0, 0));
    var_1.script_forcespawn = 1;
    var_1 scripts\cp\cp_modular_spawning::spawner_init();
  }
}

function return_paratroopers_spawners(var_0) {
  if(istrue(var_0.respawning)) {
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var_0);
  }

  var_1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  return var_1;
}

function init_paratroopers_spawners(var_0) {
  var_0 scripts\cp\cp_modular_spawning::ignoredeathsdoor(var_0, "wave_spawning");
  var_1 = ref_11D96(var_0);
  var_2 = var_1.parachute_land_origin + (0, 0, 12000);
  var_3 = var_2 + anglesToForward((0, randomint(360), 0)) * -20000;

  if(getdvarint("scr_paratrooper_debug", 0)) {
    thread scripts\cp\utility::drawsphere(var_1.origin, 128, 60, (1, 1, 1));
    thread scripts\cp\utility::drawsphere(var_2, 128, 60, (1, 1, 0));
    thread scripts\cp\utility::drawsphere(var_3, 128, 60, (0, 1, 0));
  }

  var_4 = var_1 scripts\cp\cp_aiparachute::ref_135B0(var_0.group_name, var_3, var_2);
  var_0.ac130 = var_4;
  var_4 scripts\cp\cp_aiparachute::armored_basic_combat(var_2);
  var_4 thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &mp_deadzone_patch);
  ref_11D95(var_0);
  var_1 = ref_11D96(var_0, 1);
}

function mp_deadzone_patch() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_paratroopers", 1);
}

function ref_11D95() {
  var_0 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].origin = self.ac130.origin;
  }

  waitframe();
}

function ref_11D96(var_0) {
  var_1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  var_2 = race_flow(scripts\cp\utility::get_center_point_of_array(level.players));

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].origin = var_2[var_3];
    var_1[var_3].parachute_land_origin = var_1[var_3].origin;

    if(istrue(var_0)) {
      if(getdvarint("scr_paratrooper_debug", 0)) {
        thread scripts\cp\utility::drawsphere(var_1[var_3].origin, 32, 60, (0, 1, 1));
      }
    }
  }

  return var_1[0];
}

function race_flow(var_0) {
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

    if(isDefined(var_13) && isDefined(var_13["shape_position"])) {
      var_0 = var_13["shape_position"];
      var_0 = getgroundposition(var_0, 1, 1000, 1000);
      var_1 = var_0;
    }
  }

  return scripts\engine\utility::array_randomize(var_1);
}

function force_wave_vehicles_on(var_0) {
  var_0.wave_use_vehicles = 1;
  var_0.valid_vehicles = [];
  var_0.valid_vehicles["lbravo_carrier"] = 500;
  var_0.valid_vehicles["mindia8"] = 500;
  var_0.valid_vehicles["mindia8_jugg"] = 500;
}

function return_wave_veh_spawners(var_0) {
  if(istrue(var_0.respawning)) {
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var_0);
  }

  if(isDefined(var_0.ref_12C43) && var_0.ref_12C43.size > 0) {
    var_1 = [];

    for(var_2 = 0; var_2 < var_0.ref_12C43.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_0.ref_12C43[var_2], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_3);
    }

    if(var_1.size > 0) {
      return var_1;
    }

    if(istrue(var_0.wave_use_vehicles)) {
      return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
    }

    return;
  }

  if(istrue(var_3.wave_use_vehicles)) {
    return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
  }

  return [];
}

function wave_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("wave_spawn");
  var_0 endon("wave_spawn");

  if(isDefined(var_0.paratroopers_allowed) && var_0.paratroopers_allowed > 0) {
    var_0.paratroopers_allowed--;
    scripts\cp\cp_modular_spawning::run_spawn_module("wave_paratroopers");
  }

  if(isDefined(var_0.ref_1451A) && var_0.ref_1451A > 0) {
    var_0.ref_1451A--;
    var_7 = spawnStruct();
    var_7.streakname = "precision_airstrike";

    if(!isDefined(var_7.shots_fired)) {
      var_7.shots_fired = 0;
    }

    var_8 = scripts\cp\utility::get_array_of_valid_players();

    if(var_8.size > 0) {
      var_9 = scripts\engine\utility::random(var_8);
      var_7.owner = var_9;
      var_10 = level.scr_anim[var_7.streakname]["airstrike_flyby"];
      thread scripts\cp_mp\killstreaks\airstrike::callstrike(var_9, var_9.origin, var_9.angles[1], undefined, var_7, var_10);
    }
  }

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var_2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var_3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_3, 0.1);
  var_11 = var_0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["wave_spawning", "wave_paratroopers"]);
  var_12 = var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var_4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var_0, var_4);
  var_5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var_0, var_5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var_4) && isDefined(var_5)) {
    if(istrue(var_0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
      return;
    }

    if(var_11 < var_0.spawn_wave_total) {
      if(var_12 >= var_5) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var_4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var_4]);
        var_0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var_4);
        return var_3;
      }

      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
      return var_3;
    }

    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "end_wave");
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
    var_0 waittill("wave_delay_over");
    return;
  }

  if(isDefined(var_0.spawn_wave_total) && isDefined(var_11) && var_11 >= var_0.spawn_wave_total) {
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "end_wave");
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
    var_0 waittill("wave_delay_over");
    return;
  }

  return var_3;
}

function wave_spawn_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("wave_spawn");
  var_0 endon("wave_spawn");

  while(getdvarint("scr_skip_wave_vehicles", 0)) {
    wait 1;
  }

  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var_2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var_3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_3, 0.1);
  var_7 = var_0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["wave_spawning", "wave_paratroopers"]);
  var_8 = var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var_4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var_0, var_4);
  var_5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var_0, var_5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var_4) && isDefined(var_5)) {
    var_9 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var_0.use_only_veh_spawners) && (!isDefined(var_9) || var_9.size < 1)) {
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, &ref_13F62);
    }

    if(istrue(var_0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
      return;
    }

    if(var_8 >= var_5) {
      if(var_7 < var_0.spawn_wave_total) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var_4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var_4]);
        var_0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var_4);
        return var_3;
      }

      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var_0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var_0 waittill("wave_delay_over");
      return;
    }

    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
    return var_3;
  }

  return var_4;
}

function ref_13F62(var_0, var_1) {
  var_0.wave_use_vehicles = undefined;
  var_0.use_only_veh_spawners = undefined;
}

function ref_12A87() {
  return istrue(self.ref_12A87);
}

function increase_wave_num(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var_1)) {
    scripts\cp\cp_modular_spawning::reset_spawn_count_from_groupname(self.group_name);

    if(isstring(self.next_wave) && self.next_wave != "") {
      self.last_wave_ref = self.next_wave;
    } else if(isint(var_1)) {
      if(var_1 == self.last_wave_num) {
        self.last_wave_num++;
      } else {
        self.last_wave_num = var_1;
      }

      self.last_wave_ref = self.last_wave_num;
    } else {
      self.last_wave_ref = var_1;
    }

    self.wave_reference = self.last_wave_ref;
    scripts\cp\cp_modular_spawning::set_wave_settings_for_all_with_groupname(self.group_name, self.wave_reference, self.last_wave_ref, self.last_wave_num);

    if(istrue(var_0)) {
      return;
    }

    start_wave();
    return;
  }
}

function ref_12216(var_0) {
  var_0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Module Paused");
  setomnvar("cp_wave_timer", 0);
}

function ref_13F23(var_0) {
  var_0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Module Unpaused");
}

function killstreaks(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  scripts\cp\cp_modular_spawning::set_wave_ref_OVERRIDE(var_1);
}

function update_current_count_death(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else if(isDefined(self.group)) {
    var_1 = self.group;
  } else {
    return 0;
  }

  var_2 = var_1 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  level thread scripts\cp\cp_modular_spawning::ref_1451F(var_1);

  if(var_1 scripts\cp\cp_modular_spawning::turn_off_steam() && !istrue(var_1.kamikaze)) {
    ref_13F81(undefined, var_1);
  }

  if(!istrue(var_1.kamikaze) && istrue(var_1.stop_wave_spawning) && var_2 < var_1.ref_11E6B) {
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var_1.group_name, [ &scripts\cp\cp_modular_spawning::toggle_kamikaze_for_group, 1]);
    level thread scripts\cp\cp_modular_spawning::wave_go_kamikaze(var_1);
    return;
  }
}

function ref_13F81(var_0, var_1) {
  if(isDefined(var_0)) {
    if(var_0 >= 0) {
      setomnvar("cp_enemies_remaining", var_0);
    }

    level.ref_1451E = var_0;
    return;
  }

  var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");
  var_2 = scripts\engine\utility::array_combine(var_2, scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_paratroopers"));
  var_1.ref_13BE5 += 1;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(isDefined(var_2[var_4].ref_13BE5)) {
      var_3 += var_2[var_4].ref_13BE5;
    }
  }

  var_3 = level.ref_14518;
  var_0 = var_1.spawn_wave_total - var_3;

  if(var_0 >= 0) {
    setomnvar("cp_enemies_remaining", var_0);
  }

  level.ref_1451E = var_0;
}

function update_current_count(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.group)) {
      var_0 = self.group;
    } else {
      return 0;
    }
  }

  if(var_0 scripts\cp\cp_modular_spawning::turn_off_steam() && var_0.ref_13BE5 == 0) {
    ref_13F81(var_0.spawn_wave_total, var_0);
    return;
  }
}