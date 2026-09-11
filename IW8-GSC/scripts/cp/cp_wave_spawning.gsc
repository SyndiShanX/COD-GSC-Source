/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_wave_spawning.gsc
***********************************************/

function init_wave_spawning() {
  if(!isDefined(level.wave_table)) {
    if(getDvar("MOLPOSLOMO") == "cp_wave_sv") {
      level.wave_table = "cp/" + getDvar("NSQLTTMRMP") + "_wave_table.csv";
    } else {
      level.wave_table = "cp/cp_donetsk_wave_table.csv";
    }
  }

  thread initialize_wave_spawn_modules();
}

function initialize_wave_spawn_modules() {
  var0 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", 0, 0];
  var1 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  var2 = [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &scripts\cp\cp_modular_spawning::get_ambient_max_count, 30], 30];
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_spawning", var0, var1, undefined, [ &wave_spawn_proc, undefined, undefined, 0.1, [ &scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], &scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, &return_wave_veh_spawners, &init_wave_spawning_module_proc);
  scripts\cp\cp_modular_spawning::registerambientgroup("wave_spawning", var0, var2, undefined, [ &wave_spawn, undefined, undefined, [ &scripts\cp\cp_modular_spawning::get_spawn_time_from_wave, 1], [ &scripts\cp\cp_modular_spawning::regenhealthaddfunc, 0], &scripts\cp\cp_modular_spawning::get_wave_high_threshold, 1], undefined, &scripts\cp\cp_modular_spawning::return_cover_spawners, &init_wave_spawning_module);
  scripts\cp\cp_spawning_util::ref_12aec("wave_spawning", &ref_12216, &ref_13f23);
  scripts\cp\cp_spawning_util::register_module_init_func("wave_spawning", [ &scripts\cp\cp_spawning_util::combine_module_counters, "wave_spawning"]);
  scripts\cp\cp_modular_spawning::register_module_as_passive("wave_spawning");
  scripts\cp\cp_vehicles::ref_12ae5("wave_spawning", "attack_heli", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cac, 750]);
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cab, 64]);
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

function start_leave_cave(var0) {
  level.ref_14519++;
}

function start_lap_time(var0) {
  if(!isDefined(var0) && isDefined(self.group)) {
    var0 = self.group;
  }

  if(isDefined(var0) && !istrue(var0.kamikaze) && istrue(self.ref_11e52)) {
    scripts\cp\cp_modular_spawning::ref_1393e(var0);
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "wave_retry");
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &ref_1301c, "wave_delay_over"]);
    level.ref_14519--;
    return;
  }

  level.ref_14518++;
}

function ref_1301c(var0, var1) {
  var0 notify(var1);
}

function init_wave_spawning_module(var0) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized")) {
    scripts\engine\utility::flag_init("wave_spawning_initialized");
  }

  var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var0 scripts\cp\cp_modular_spawning::get_current_wave_ref(), 1);

  if(isDefined(level.spawn_module_structs_memory[var0.group_name])) {
    for(var2 = 0; var2 < level.spawn_module_structs_memory[var0.group_name].size; var2++) {
      level.spawn_module_structs_memory[var0.group_name][var2].wave_reference = var1;
      level.spawn_module_structs_memory[var0.group_name][var2].cover_node_spawners_override_id = 0;
      level.spawn_module_structs_memory[var0.group_name][var2].cover_node_spawners_override = [];
      level.spawn_module_structs_memory[var0.group_name][var2].wave_spawner_overrides = [];
      level.spawn_module_structs_memory[var0.group_name][var2].requested_spawners = [];
      level.spawn_module_structs_memory[var0.group_name][var2].ref_12c43 = [];
      level.spawn_module_structs_memory[var0.group_name][var2].last_wave_num = level.spawn_module_structs_memory[var0.group_name][var2].wave_reference;
      level.spawn_module_structs_memory[var0.group_name][var2].last_wave_ref = level.spawn_module_structs_memory[var0.group_name][var2].wave_reference;
    }
  }

  var0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", &scripts\cp\cp_modular_spawning::setup_wave_vars);
  scripts\engine\utility::flag_set("wave_spawning_initialized");
  start_wave(var0);
}

function start_wave() {
  level endon("game_ended");
  level.ref_14519 = 0;
  level.ref_14518 = 0;
  scripts\cp\cp_modular_spawning::set_wave_settings();
  update_current_count(self);
  thread scripts\cp\cp_modular_spawning::show_all_player_wave_started_splash();
}

function init_wave_spawning_module_proc(var0) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("wave_spawning_initialized")) {
    scripts\engine\utility::flag_init("wave_spawning_initialized");
  }

  var0 scripts\cp\cp_modular_spawning::init_passive_wave_struct();
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\engine\utility::flag_wait("wave_spawning_initialized");
}

function cap_vehicle_type_on_module(var0, var1, var2) {
  if(!isDefined(var0.vehicle_caps)) {
    var0.vehicle_caps = [];
  }

  var0.vehicle_caps[var1] = var2;
}

function create_paratrooper_spawners() {
  for(var0 = 0; var0 < 8; var0++) {
    var1 = spawnStruct();
    scripts\cp\utility::addtostructarray("targetname", "wave_paratroopers", var1);
    var1.origin = getclosestpointonnavmesh((0, 0, 0));
    var1.script_forcespawn = 1;
    var1 scripts\cp\cp_modular_spawning::spawner_init();
  }
}

function return_paratroopers_spawners(var0) {
  if(istrue(var0.respawning)) {
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var0);
  }

  var1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  return var1;
}

function init_paratroopers_spawners(var0) {
  var0 scripts\cp\cp_modular_spawning::ignoredeathsdoor(var0, "wave_spawning");
  var1 = ref_11d96(var0);
  var2 = var1.parachute_land_origin + (0, 0, 12000);
  var3 = var2 + anglesToForward((0, randomint(360), 0)) * -20000;

  if(getdvarint("scr_paratrooper_debug", 0)) {
    thread scripts\cp\utility::drawsphere(var1.origin, 128, 60, (1, 1, 1));
    thread scripts\cp\utility::drawsphere(var2, 128, 60, (1, 1, 0));
    thread scripts\cp\utility::drawsphere(var3, 128, 60, (0, 1, 0));
  }

  var4 = var1 scripts\cp\cp_aiparachute::ref_135b0(var0.group_name, var3, var2);
  var0.ac130 = var4;
  var4 scripts\cp\cp_aiparachute::armored_basic_combat(var2);
  var4 thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &mp_deadzone_patch);
  ref_11d95(var0);
  var1 = ref_11d96(var0, 1);
}

function mp_deadzone_patch() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_paratroopers", 1);
}

function ref_11d95() {
  var0 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].origin = self.ac130.origin;
  }

  waitframe();
}

function ref_11d96(var0) {
  var1 = scripts\engine\utility::getStructArray("wave_paratroopers", "targetname");
  var2 = race_flow(scripts\cp\utility::get_center_point_of_array(level.players));

  for(var3 = 0; var3 < var1.size; var3++) {
    var1[var3].origin = var2[var3];
    var1[var3].parachute_land_origin = var1[var3].origin;

    if(istrue(var0)) {
      if(getdvarint("scr_paratrooper_debug", 0)) {
        thread scripts\cp\utility::drawsphere(var1[var3].origin, 32, 60, (0, 1, 1));
      }
    }
  }

  return var1[0];
}

function race_flow(var0) {
  var1 = [];
  var2 = 12;
  var3 = 2048;
  var4 = 360 / var2;
  var5 = var0;

  for(var6 = 0; var6 < var2; var6++) {
    var7 = var4 * var6;
    var8 = cos(var7) * var3;
    var9 = sin(var7) * var3;
    var10 = var5[0] + var8;
    var11 = var5[1] + var9;
    var12 = var5[2];
    var0 = getclosestpointonnavmesh((var10, var11, var12));
    var13 = scripts\engine\trace::sphere_trace(var5 + (0, 0, 48), var0, 32, level.characters);

    if(isDefined(var13) && isDefined(var13["shape_position"])) {
      var0 = var13["shape_position"];
      var0 = getgroundposition(var0, 1, 1000, 1000);
      var1 = var0;
    }
  }

  return scripts\engine\utility::array_randomize(var1);
}

function force_wave_vehicles_on(var0) {
  var0.wave_use_vehicles = 1;
  var0.valid_vehicles = [];
  var0.valid_vehicles["lbravo_carrier"] = 500;
  var0.valid_vehicles["mindia8"] = 500;
  var0.valid_vehicles["mindia8_jugg"] = 500;
}

function return_wave_veh_spawners(var0) {
  if(istrue(var0.respawning)) {
    return scripts\cp\cp_modular_spawning::return_cover_spawners(var0);
  }

  if(isDefined(var0.ref_12c43) && var0.ref_12c43.size > 0) {
    var1 = [];

    for(var2 = 0; var2 < var0.ref_12c43.size; var2++) {
      var3 = scripts\engine\utility::getStructArray(var0.ref_12c43[var2], "targetname");
      var1 = scripts\engine\utility::array_combine(var1, var3);
    }

    if(var1.size > 0) {
      return var1;
    }

    if(istrue(var0.wave_use_vehicles)) {
      return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
    }

    return;
  }

  if(istrue(var3.wave_use_vehicles)) {
    return scripts\engine\utility::getStructArray("wave_veh_spawners", "targetname");
  }

  return [];
}

function wave_spawn(var0, var1, var2, var3, var4, var5, var6) {
  var0 notify("wave_spawn");
  var0 endon("wave_spawn");

  if(isDefined(var0.paratroopers_allowed) && var0.paratroopers_allowed > 0) {
    var0.paratroopers_allowed--;
    scripts\cp\cp_modular_spawning::run_spawn_module("wave_paratroopers");
  }

  if(isDefined(var0.ref_1451a) && var0.ref_1451a > 0) {
    var0.ref_1451a--;
    var7 = spawnStruct();
    var7.streakname = "precision_airstrike";

    if(!isDefined(var7.shots_fired)) {
      var7.shots_fired = 0;
    }

    var8 = scripts\cp\utility::get_array_of_valid_players();

    if(var8.size > 0) {
      var9 = scripts\engine\utility::random(var8);
      var7.owner = var9;
      var10 = level.scr_anim[var7.streakname]["airstrike_flyby"];
      thread scripts\cp_mp\killstreaks\airstrike::callstrike(var9, var9.origin, var9.angles[1], undefined, var7, var10);
    }
  }

  var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var3, 0.1);
  var11 = var0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["wave_spawning", "wave_paratroopers"]);
  var12 = var0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var0, var4);
  var5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var0, var5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var4) && isDefined(var5)) {
    if(istrue(var0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var0 waittill("wave_delay_over");
      return;
    }

    if(var11 < var0.spawn_wave_total) {
      if(var12 >= var5) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var4]);
        var0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var4);
        return var3;
      }

      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
      return var3;
    }

    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var0.group_name, 1, "end_wave");
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
    var0 waittill("wave_delay_over");
    return;
  }

  if(isDefined(var0.spawn_wave_total) && isDefined(var11) && var11 >= var0.spawn_wave_total) {
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var0.group_name, 1, "end_wave");
    scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
    var0 waittill("wave_delay_over");
    return;
  }

  return var3;
}

function wave_spawn_proc(var0, var1, var2, var3, var4, var5, var6) {
  var0 notify("wave_spawn");
  var0 endon("wave_spawn");

  while(getdvarint("scr_skip_wave_vehicles", 0)) {
    wait 1;
  }

  var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var1, scripts\cp\cp_modular_spawning::get_passive_wave_spawn_time());
  var2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var2, scripts\cp\cp_modular_spawning::get_passive_spawn_window_time());
  var3 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var3, 0.1);
  var7 = var0 scripts\cp\cp_spawning_util::rear_door_collision_brush(["wave_spawning", "wave_paratroopers"]);
  var8 = var0 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  var4 = scripts\cp\cp_modular_spawning::get_passive_wave_low_threshold(var0, var4);
  var5 = scripts\cp\cp_modular_spawning::get_passive_wave_high_threshold(var0, var5);
  scripts\cp\cp_gameskill::wave_difficulty_update(self.wave_difficulty);

  if(isDefined(var4) && isDefined(var5)) {
    var9 = var0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var0.use_only_veh_spawners) && (!isDefined(var9) || var9.size < 1)) {
      scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var0.group_name, &ref_13f62);
    }

    if(istrue(var0.stop_wave_spawning)) {
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var0 waittill("wave_delay_over");
      return;
    }

    if(var8 >= var5) {
      if(var7 < var0.spawn_wave_total) {
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var4]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "wait_4_count: " + var4]);
        var0 scripts\cp\cp_modular_spawning::group_wait_for_activecount_notify(var4);
        return var3;
      }

      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname(var0.group_name, 1, "end_wave");
      scripts\cp\cp_modular_spawning::toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "end_wave");
      var0 waittill("wave_delay_over");
      return;
    }

    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var0.group_name, [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_paratroopers", [ &scripts\cp\cp_modular_spawning::change_module_status, "spawning"]);
    return var3;
  }

  return var4;
}

function ref_13f62(var0, var1) {
  var0.wave_use_vehicles = undefined;
  var0.use_only_veh_spawners = undefined;
}

function ref_12a87() {
  return istrue(self.ref_12a87);
}

function increase_wave_num(var0) {
  var1 = scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var1)) {
    scripts\cp\cp_modular_spawning::reset_spawn_count_from_groupname(self.group_name);

    if(isstring(self.next_wave) && self.next_wave != "") {
      self.last_wave_ref = self.next_wave;
    } else if(isint(var1)) {
      if(var1 == self.last_wave_num) {
        self.last_wave_num++;
      } else {
        self.last_wave_num = var1;
      }

      self.last_wave_ref = self.last_wave_num;
    } else {
      self.last_wave_ref = var1;
    }

    self.wave_reference = self.last_wave_ref;
    scripts\cp\cp_modular_spawning::set_wave_settings_for_all_with_groupname(self.group_name, self.wave_reference, self.last_wave_ref, self.last_wave_num);

    if(istrue(var0)) {
      return;
    }

    start_wave();
    return;
  }
}

function ref_12216(var0) {
  var0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Module Paused");
  setomnvar("cp_wave_timer", 0);
}

function ref_13f23(var0) {
  var0 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Module Unpaused");
}

function killstreaks(var0, var1) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  scripts\cp\cp_modular_spawning::set_wave_ref_override(var1);
}

function update_current_count_death(var0) {
  if(isDefined(var0)) {
    var1 = var0;
  } else if(isDefined(self.group)) {
    var1 = self.group;
  } else {
    return 0;
  }

  var2 = var1 scripts\cp\cp_modular_spawning::get_activecount_from_group();
  level thread scripts\cp\cp_modular_spawning::ref_1451f(var1);

  if(var1 scripts\cp\cp_modular_spawning::turn_off_steam() && !istrue(var1.kamikaze)) {
    ref_13f81(undefined, var1);
  }

  if(!istrue(var1.kamikaze) && istrue(var1.stop_wave_spawning) && var2 < var1.ref_11e6b) {
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname(var1.group_name, [ &scripts\cp\cp_modular_spawning::toggle_kamikaze_for_group, 1]);
    level thread scripts\cp\cp_modular_spawning::wave_go_kamikaze(var1);
    return;
  }
}

function ref_13f81(var0, var1) {
  if(isDefined(var0)) {
    if(var0 >= 0) {
      setomnvar("cp_enemies_remaining", var0);
    }

    level.ref_1451e = var0;
    return;
  }

  var2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");
  var2 = scripts\engine\utility::array_combine(var2, scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_paratroopers"));
  var1.ref_13be5 += 1;
  var3 = 0;

  for(var4 = 0; var4 < var2.size; var4++) {
    if(isDefined(var2[var4].ref_13be5)) {
      var3 += var2[var4].ref_13be5;
    }
  }

  var3 = level.ref_14518;
  var0 = var1.spawn_wave_total - var3;

  if(var0 >= 0) {
    setomnvar("cp_enemies_remaining", var0);
  }

  level.ref_1451e = var0;
}

function update_current_count(var0) {
  if(!isDefined(var0)) {
    if(isDefined(self.group)) {
      var0 = self.group;
    } else {
      return 0;
    }
  }

  if(var0 scripts\cp\cp_modular_spawning::turn_off_steam() && var0.ref_13be5 == 0) {
    ref_13f81(var0.spawn_wave_total, var0);
    return;
  }
}