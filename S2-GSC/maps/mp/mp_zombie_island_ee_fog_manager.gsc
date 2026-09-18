/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_ee_fog_manager.gsc
*******************************************************/

init() {
  maps / mp / mp_zombie_island_fog_zones::init();
  level.current_fog_mode = "run";
  initializefogzone("default", "mp_zombie_island", "mp_zombie_island", "mp_zombie_island_fog", "mp_zombie_island_fog");
  initializefogzone("introduction", "mp_zombie_island_beach_intro", "mp_zombie_island", "mp_zombie_island_beach_intro", "mp_zombie_island");
  initializefogzone("interior_fog_sub_pens", "mp_zombie_island_interior", "mp_zombie_island_interior", "mp_zombie_island_interior", "mp_zombie_island_interior");
  initializefogzone("interior_fog_transition", "mp_zombie_island_transition", "mp_zombie_island_interior", "mp_zombie_island_fog_transition", "mp_zombie_island_fog_interior");
  initializefogzone("interior_fog_freezer", "mp_zombie_island_freezer", "mp_zombie_island_interior", "mp_zombie_island_freezer", "mp_zombie_island_interior");
  initializefogzone("interior_fog_shrine", "mp_zombie_island_shrine", "mp_zombie_island_interior_nosun", "mp_zombie_island_shrine", "mp_zombie_island_interior_nosun");
  initializefogzone("interior_fog_bunker", "mp_zombie_island_bunker", "mp_zombie_island", "mp_zombie_island_fog", "mp_zombie_island_fog");
  initializefogzone("interior_fog_ships", "mp_zombie_island_ships", "mp_zombie_island", "mp_zombie_island_fog", "mp_zombie_island_fog");
  initializefogzone("fog_beach", "mp_zombie_island_beach", "mp_zombie_island", "mp_zombie_island_fog_beach", "mp_zombie_island_fog");
  initializefogzone("fog_tunnel", "mp_zombie_island_tunnel", "mp_zombie_island_tunnel", "mp_zombie_island_fog", "mp_zombie_island_fog");
  initializefogzone("fog_mines", "mp_zombie_island_mines", "mp_zombie_island_nosun", "mp_zombie_island_mines", "mp_zombie_island_nosun");
  maps / mp / mp_zombie_island_fog_behavior::init();
  level thread maps / mp / mp_zombie_island_fog_zombie_ai_modifications::init();
  level.fogfuncs = [];
  level.max_fog_assassin_spawns = 1;
  level.next_assassin_add = 20;
  add_fog_function(::fog_start, 45, "1. fog start");
  add_fog_function(::fog_rolling_in, 0, "2. fog rolling in");
  add_fog_function(::on_fog_settled, 90, "3. fog active");
  add_fog_function(::fog_rolling_out, 8, "4. fog rolling out");
  add_fog_function(::wait_for_intermission, 240, "5. fog intermission");
  level thread run_fog_functions_loop();
  initializeclientsideexplodervolume("cliffside_effects_zone", ::cliffside_vista_fog_on, ::cliffside_vista_fog_off, [(3102.35, -495.533, 353.745), "zmb_isl_fog_vista_vol_cliffs_rnr"]);
}

update_assassin_fog_count() {
  if(!isDefined(level.continue_adding_to_assassin_count)) {
    level.continue_adding_to_assassin_count = 1;
  }

  if(level.continue_adding_to_assassin_count <= 0) {
    return;
  }

  if(level.var_A980 >= level.next_assassin_add) {
    level.continue_adding_to_assassin_count--;
    level.next_assassin_add = level.var_A980 + 20;
    level.max_fog_assassin_spawns++;
  }
}

initializeclientsideexplodervolume(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.clientside_exploder_runners)) {
    level.clientside_exploder_runners = [];
  }

  var_04 = spawnStruct();
  var_04.var_A615 = getEntArray(param_00, "targetname");
  var_04.optionaldebug = param_03;
  var_04.var_6B05 = param_01;
  var_04.onvacantfunc = param_02;
  var_04.var_5764 = 0;
  level.clientside_exploder_runners = common_scripts\utility::func_F6F(level.clientside_exploder_runners, var_04);
}

fog_start(param_00, param_01) {
  level endon(param_01);
  maps / mp / mp_zombie_island_fog_zones::set_fog_is_heavy(0);
  level.first_fog_sequence = 1;
  wait_for_initial_fog_conditions();
  param_00 = randomint(param_00) + 10;
  common_scripts\utility::func_A63E(param_00, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(param_01);
}

wait_for_initial_fog_conditions() {
  level endon("fasttrack_to_next_fog_state");
  if(isDefined(level.wait_for_initial_fog_conditions_func)) {
    level[[level.wait_for_initial_fog_conditions_func]]();
  }
}

fog_rolling_in(param_00, param_01) {
  level endon(param_01);
  foreach(var_03 in level.players) {
    var_03 lib_0378::func_8D74("aud_fog_rolling_in");
  }

  level childthread common_scripts\_exploder::func_2A6D(206, undefined, 0);
  common_scripts\utility::func_A63E(1, "fasttrack_to_next_fog_state");
  level childthread common_scripts\_exploder::func_88E(205);
  common_scripts\utility::func_A63E(8, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(param_01);
}

on_fog_settled(param_00, param_01) {
  level endon(param_01);
  level thread track_fog_settle_time();
  level thread spawn_assassin_zombies(gettime());
  maps / mp / mp_zombie_island_fog_zones::set_fog_is_heavy(1);
  level thread run_effects_fog();
  level lib_0378::func_8D74("aud_fog_settled");
  level thread turn_on_fog_lights();
  common_scripts\utility::func_A63E(0.2, "fasttrack_to_next_fog_state");
  common_scripts\utility::func_A63E(param_00, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(param_01);
}

fog_rolling_out(param_00, param_01) {
  level endon(param_01);
  level notify("fog_rolling_out");
  foreach(var_03 in level.players) {
    var_03 lib_0378::func_8D74("aud_fog_rolling_out");
  }

  level lib_0378::func_8D74("aud_fog_lifted");
  level thread stop_effects_fog();
  level childthread common_scripts\_exploder::func_88E(204);
  level childthread common_scripts\_exploder::func_88E(206);
  level thread turn_off_fog_lights();
  common_scripts\utility::func_A63E(9, "fasttrack_to_next_fog_state");
  level.island_fog_settle_time = 0;
  maps / mp / mp_zombie_island_fog_zones::set_fog_is_heavy(0);
  common_scripts\utility::func_A63E(param_00, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(param_01);
}

wait_for_intermission(param_00, param_01) {
  level endon(param_01);
  wait_for_wave_requirement();
  param_00 = randomint(240);
  common_scripts\utility::func_A63E(param_00, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(param_01);
}

run_fog_functions_loop() {
  play_start_state();
  run_fog_sequence();
}

set_fog_locked_to_on(param_00) {
  unlock_fog_from_lock();
  if(common_scripts\utility::func_562E(param_00)) {
    lock_to_any_phase(["3. fog active"]);
    return;
  }

  lock_to_any_phase(["2. fog rolling in", "3. fog active"]);
}

set_fog_rolling_in() {
  unlock_fog_from_lock();
  lock_to_any_phase(["2. fog rolling in"], 1);
}

set_fog_locked_to_off(param_00) {
  unlock_fog_from_lock();
  if(common_scripts\utility::func_562E(param_00)) {
    lock_to_any_phase(["5. fog intermission"]);
    return;
  }

  lock_to_any_phase(["4. fog rolling out", "5. fog intermission"]);
}

unlock_fog_from_lock() {
  level.fog_state_is_locked = 0;
}

lock_to_any_phase(param_00, param_01) {
  while(isDefined(level.current_fog_flag) && !common_scripts\utility::func_F79(param_00, level.current_fog_flag)) {
    level notify("fasttrack_to_next_fog_state");
    wait 0.05;
  }

  while(param_00.size > 1 && !lib_0547::func_5565(level.current_fog_flag, param_00[param_00.size - 1])) {
    wait 0.05;
  }

  if(!common_scripts\utility::func_562E(param_01)) {
    level.fog_state_is_locked = 1;
  }
}

is_fog_rolling_in() {
  return lib_0547::func_5565(level.current_fog_flag, "2. fog rolling in");
}

wait_for_wave_requirement() {
  level endon("fasttrack_to_next_fog_state");
  var_00 = level.var_A980 + randomintrange(2, 5);
  while(level.var_A980 <= var_00) {
    wait(1);
  }
}

track_fog_settle_time() {
  level notify("new_fog_settled_timer");
  level endon("new_fog_settled_timer");
  level endon("4. fog rolling out");
  level.island_fog_settle_time = 0;
  for(;;) {
    level.island_fog_settle_time = level.island_fog_settle_time + 0.1;
    wait(0.1);
  }
}

spawn_assassin_zombies(param_00) {
  wait(6.5);
  if(!common_scripts\utility::func_562E(level.block_normal_assassin_spawns)) {
    level thread spawn_an_assassin_zombie(level.first_fog_sequence, param_00);
    level thread ramp_zombies();
  }
}

turn_on_fog_lights() {
  wait(4);
  var_00 = function_021F("fog_light", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

turn_off_fog_lights() {
  wait(4);
  var_00 = function_021F("fog_light", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

spawn_first_assassins() {
  var_00 = [];
  foreach(var_02 in level.var_AC80.var_ACB3) {
    if(common_scripts\utility::func_562E(var_02.var_556E) && var_02.var_AC8A != "cart_tunnel_zone") {
      var_00 = common_scripts\utility::func_F6F(var_00, var_02.var_AC8A);
    }
  }

  for(var_04 = 0; var_04 < 3; var_04++) {
    var_05 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(undefined, 7000, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, var_00);
    var_05.isassassindemo = 1;
    var_05 maps / mp / zombies / zombie_assassin::assassin_set_alarmed();
    wait 0.05;
  }
}

ramp_zombies() {
  var_00 = lib_0547::func_408F();
  var_01 = int(min(15, lib_056D::func_4577()));
  var_02 = var_00.size;
  var_03 = var_01 - var_02;
  if(var_03 <= 0) {
    return;
  }

  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = lib_054D::func_90BA("zombie_generic", undefined, "fog ramp", 0, 0, 1);
  }
}

next_fog_state(param_00) {
  level.current_fog_flag = param_00.waitflag;
  level childthread play_fog_state(param_00);
  common_scripts\utility::func_3C9F(param_00.waitflag);
  while(common_scripts\utility::func_562E(level.fog_state_is_locked)) {
    wait 0.05;
  }
}

run_fog_sequence() {
  clear_all_fog_flags();
  foreach(var_01 in level.fogfuncs) {
    next_fog_state(var_01);
  }
}

play_start_state() {
  var_00 = initialize_fog_loop();
  next_fog_state(var_00);
}

initialize_fog_loop() {
  var_00 = level.fogfuncs[0];
  level.fogfuncs = common_scripts\utility::func_F93(level.fogfuncs, var_00);
  return var_00;
}

clear_all_fog_flags() {
  foreach(var_01 in level.fogfuncs) {
    common_scripts\utility::func_3C7B(var_01.waitflag);
  }
}

set_all_fog_flags() {
  foreach(var_01 in level.fogfuncs) {
    common_scripts\utility::flag_set(var_01.waitflag);
  }
}

toggle_next_fog_state() {
  common_scripts\utility::flag_set(level.current_fog_flag);
}

get_fog_volumn_touched(param_00) {
  foreach(var_02 in self) {
    foreach(var_04 in var_02.var_A615) {
      if(param_00 istouching(var_04)) {
        return var_02;
      }
    }
  }

  if(common_scripts\utility::func_562E(param_00.var_A019)) {
    return self[1];
  }

  return self[0];
}

run_effects_fog() {
  wait(1);
  level thread common_scripts\_exploder::func_88E(201);
  level thread common_scripts\_exploder::func_88E(208);
  wait(1);
  level thread common_scripts\_exploder::func_88E(202);
}

stop_effects_fog() {
  level thread common_scripts\_exploder::func_2A6D(201, undefined, 0);
  level thread common_scripts\_exploder::func_2A6D(202, undefined, 0);
  level thread common_scripts\_exploder::func_2A6D(208, undefined, 0);
}

cliffside_vista_fog_on(param_00) {
  level thread common_scripts\_exploder::func_88E(212, param_00);
}

cliffside_vista_fog_off(param_00) {
  level thread common_scripts\_exploder::func_2A6D(212, param_00, 0);
}

spawn_assassin_cover() {
  var_00 = common_scripts\utility::func_46B7("assassin_despawners", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_905E = common_scripts\utility::func_46B7(var_02.target, "targetname");
    foreach(var_04 in var_02.var_905E) {
      var_04.spawner_fog_fx = lib_0547::func_8FBA(var_04, "zmb_isl_fog_zmb_assn_01");
      triggerfx(var_04.spawner_fog_fx);
    }
  }
}

despawn_assassin_cover() {
  var_00 = common_scripts\utility::func_46B7("assassin_despawners", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_905E = common_scripts\utility::func_46B7(var_02.target, "targetname");
    foreach(var_04 in var_02.var_905E) {
      if(isDefined(var_04.spawner_fog_fx)) {
        var_04.spawner_fog_fx delete();
      }
    }
  }
}

zombie_fog_effects_start() {
  wait(2);
  foreach(var_01 in lib_0547::func_408F()) {
    playFXOnTag(level._effect["zmb_isl_fog_zmb_emerge_01"], var_01, "J_SpineUpper");
  }
}

add_fog_function(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_52BC = param_00;
  var_03.var_A796 = param_01;
  var_03.waitflag = param_02;
  common_scripts\utility::flag_init(var_03.waitflag);
  level.fogfuncs = common_scripts\utility::func_F6F(level.fogfuncs, var_03);
}

initializefogzone(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.zmb_island_fog_volumes)) {
    level.zmb_island_fog_volumes = [];
  }

  var_05 = spawnStruct();
  if(param_00 == "default" || param_00 == "introduction") {
    var_05.var_A615 = [];
  } else {
    var_05.var_A615 = getEntArray(param_00, "targetname");
  }

  var_05.name = param_00;
  var_05.fog_set_normal = param_01;
  var_05.light_set_normal = param_02;
  var_05.fog_set_active = param_03;
  var_05.light_set_active = param_04;
  level.zmb_island_fog_volumes = common_scripts\utility::func_F6F(level.zmb_island_fog_volumes, var_05);
}

fog_wait(param_00) {
  var_01 = param_00;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    if(var_02 + 1 % 5 == 1) {}

    wait(1);
  }
}

play_fog_state(param_00) {
  level childthread[[param_00.var_52BC]](param_00.var_A796, param_00.waitflag);
}

get_is_fog_active() {
  return common_scripts\utility::func_562E(level.island_fog_is_thick) || lib_0547::func_5565(level.current_fog_flag, "3. fog active");
}

wait_till_fog_active() {
  common_scripts\utility::func_3C9F("2. fog rolling in");
}

get_fog_active_flag() {
  return "3. fog active";
}

spawn_an_assassin_zombie(param_00, param_01) {
  var_02 = undefined;
  if(common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(level.st_144545)) {
      level.first_fog_sequence = 0;
      return;
    }

    level.first_fog_sequence = 0;
    var_02 = 3010;
  }

  for(var_03 = 0; var_03 < level.max_fog_assassin_spawns; var_03++) {
    if(var_03 > 0) {
      if(!randomint(100) < 60 && 90 - gettime() - param_01 / 1000 > 50) {
        continue;
      } else {
        wait(25);
      }
    }

    var_04 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(undefined, var_02);
    if(common_scripts\utility::func_562E(param_00)) {
      var_04.assassinmustleave = 1;
      var_04.isfirstlethalassassin = 1;
    }
  }
}