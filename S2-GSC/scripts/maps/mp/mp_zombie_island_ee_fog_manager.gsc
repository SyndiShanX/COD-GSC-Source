/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_ee_fog_manager.gsc
***************************************************************/

init() {
  maps\mp\mp_zombie_island_fog_zones::init();
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
  maps\mp\mp_zombie_island_fog_behavior::init();
  level thread maps\mp\mp_zombie_island_fog_zombie_ai_modifications::init();
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
  if(!isDefined(level.continue_adding_to_assassin_count))
    level.continue_adding_to_assassin_count = 1;

  if(level.continue_adding_to_assassin_count <= 0) {
    return;
  }
  if(level._id_A980 >= level.next_assassin_add) {
    level.continue_adding_to_assassin_count--;
    level.next_assassin_add = level._id_A980 + 20;
    level.max_fog_assassin_spawns++;
  }
}

initializeclientsideexplodervolume(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.clientside_exploder_runners))
    level.clientside_exploder_runners = [];

  var_4 = spawnStruct();
  var_4._id_A615 = getEntArray(var_0, "targetname");
  var_4.optionaldebug = var_3;
  var_4._id_6B05 = var_1;
  var_4.onvacantfunc = var_2;
  var_4._id_5764 = 0;
  level.clientside_exploder_runners = common_scripts\utility::_id_0F6F(level.clientside_exploder_runners, var_4);
}

fog_start(var_0, var_1) {
  level endon(var_1);
  maps\mp\mp_zombie_island_fog_zones::set_fog_is_heavy(0);
  level.first_fog_sequence = 1;
  wait_for_initial_fog_conditions();
  var_0 = randomint(var_0) + 10;
  common_scripts\utility::_id_A63E(var_0, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(var_1);
}

wait_for_initial_fog_conditions() {
  level endon("fasttrack_to_next_fog_state");

  if(isDefined(level.wait_for_initial_fog_conditions_func))
    level[[level.wait_for_initial_fog_conditions_func]]();
}

fog_rolling_in(var_0, var_1) {
  level endon(var_1);

  foreach(var_3 in level.players)
  var_3 _id_0378::_id_8D74("aud_fog_rolling_in");

  level childthread common_scripts\_exploder::_id_2A6D(206, undefined, 0);
  common_scripts\utility::_id_A63E(1, "fasttrack_to_next_fog_state");
  level childthread common_scripts\_exploder::_id_088E(205);
  common_scripts\utility::_id_A63E(8, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(var_1);
}

on_fog_settled(var_0, var_1) {
  level endon(var_1);
  level thread track_fog_settle_time();
  level thread spawn_assassin_zombies(gettime());
  maps\mp\mp_zombie_island_fog_zones::set_fog_is_heavy(1);
  level thread run_effects_fog();
  level _id_0378::_id_8D74("aud_fog_settled");
  level thread turn_on_fog_lights();
  common_scripts\utility::_id_A63E(0.2, "fasttrack_to_next_fog_state");
  common_scripts\utility::_id_A63E(var_0, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(var_1);
}

fog_rolling_out(var_0, var_1) {
  level endon(var_1);
  level notify("fog_rolling_out");

  foreach(var_3 in level.players)
  var_3 _id_0378::_id_8D74("aud_fog_rolling_out");

  level _id_0378::_id_8D74("aud_fog_lifted");
  level thread stop_effects_fog();
  level childthread common_scripts\_exploder::_id_088E(204);
  level childthread common_scripts\_exploder::_id_088E(206);
  level thread turn_off_fog_lights();
  common_scripts\utility::_id_A63E(9, "fasttrack_to_next_fog_state");
  level.island_fog_settle_time = 0;
  maps\mp\mp_zombie_island_fog_zones::set_fog_is_heavy(0);
  common_scripts\utility::_id_A63E(var_0, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(var_1);
}

wait_for_intermission(var_0, var_1) {
  level endon(var_1);
  wait_for_wave_requirement();
  var_0 = randomint(240);
  common_scripts\utility::_id_A63E(var_0, "fasttrack_to_next_fog_state");
  common_scripts\utility::flag_set(var_1);
}

run_fog_functions_loop() {
  play_start_state();

  for(;;)
    run_fog_sequence();
}

set_fog_locked_to_on(var_0) {
  unlock_fog_from_lock();

  if(common_scripts\utility::_id_562E(var_0))
    lock_to_any_phase(["3. fog active"]);
  else
    lock_to_any_phase(["2. fog rolling in", "3. fog active"]);
}

set_fog_rolling_in() {
  unlock_fog_from_lock();
  lock_to_any_phase(["2. fog rolling in"], 1);
}

set_fog_locked_to_off(var_0) {
  unlock_fog_from_lock();

  if(common_scripts\utility::_id_562E(var_0))
    lock_to_any_phase(["5. fog intermission"]);
  else
    lock_to_any_phase(["4. fog rolling out", "5. fog intermission"]);
}

unlock_fog_from_lock() {
  level.fog_state_is_locked = 0;
}

lock_to_any_phase(var_0, var_1) {
  while(isDefined(level.current_fog_flag) && !common_scripts\utility::_id_0F79(var_0, level.current_fog_flag)) {
    level notify("fasttrack_to_next_fog_state");
    waitframe();
  }

  while(var_0.size > 1 && !_id_0547::_id_5565(level.current_fog_flag, var_0[var_0.size - 1]))
    waitframe();

  if(!common_scripts\utility::_id_562E(var_1))
    level.fog_state_is_locked = 1;
}

is_fog_rolling_in() {
  return _id_0547::_id_5565(level.current_fog_flag, "2. fog rolling in");
}

wait_for_wave_requirement() {
  level endon("fasttrack_to_next_fog_state");
  var_0 = level._id_A980 + _func_0A4(2, 5);

  while(level._id_A980 <= var_0)
    wait 1;
}

track_fog_settle_time() {
  level notify("new_fog_settled_timer");
  level endon("new_fog_settled_timer");
  level endon("4. fog rolling out");
  level.island_fog_settle_time = 0;

  for(;;) {
    level.island_fog_settle_time = level.island_fog_settle_time + 0.1;
    wait 0.1;
  }
}

spawn_assassin_zombies(var_0) {
  wait 6.5;

  if(!common_scripts\utility::_id_562E(level.block_normal_assassin_spawns)) {
    level thread spawn_an_assassin_zombie(level.first_fog_sequence, var_0);
    level thread ramp_zombies();
  }
}

turn_on_fog_lights() {
  wait 4;
  var_0 = _func_21F("fog_light", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_83FA("lightpart", "on");
}

turn_off_fog_lights() {
  wait 4;
  var_0 = _func_21F("fog_light", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_83FA("lightpart", "off");
}

spawn_first_assassins() {
  var_0 = [];

  foreach(var_2 in level._id_AC80._id_ACB3) {
    if(common_scripts\utility::_id_562E(var_2._id_556E) && var_2._id_AC8A != "cart_tunnel_zone")
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2._id_AC8A);
  }

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(undefined, 7000, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, var_0);
    var_5.isassassindemo = 1;
    var_5 maps\mp\zombies\zombie_assassin::assassin_set_alarmed();
    waitframe();
  }
}

ramp_zombies() {
  var_0 = _id_0547::_id_408F();
  var_1 = int(_func_0AF(15, _id_056D::_id_4577()));
  var_2 = var_0.size;
  var_3 = var_1 - var_2;

  if(var_3 <= 0) {
    return;
  }
  for(var_4 = 0; var_4 < var_3; var_4++)
    var_5 = _id_054D::_id_90BA("zombie_generic", undefined, "fog ramp", 0, 0, 1);
}

next_fog_state(var_0) {
  level.current_fog_flag = var_0.waitflag;
  level childthread play_fog_state(var_0);
  common_scripts\utility::_id_3C9F(var_0.waitflag);

  while(common_scripts\utility::_id_562E(level.fog_state_is_locked))
    waitframe();
}

run_fog_sequence() {
  clear_all_fog_flags();

  foreach(var_1 in level.fogfuncs)
  next_fog_state(var_1);
}

play_start_state() {
  var_0 = initialize_fog_loop();
  next_fog_state(var_0);
}

initialize_fog_loop() {
  var_0 = level.fogfuncs[0];
  level.fogfuncs = common_scripts\utility::_id_0F93(level.fogfuncs, var_0);
  return var_0;
}

clear_all_fog_flags() {
  foreach(var_1 in level.fogfuncs)
  common_scripts\utility::_id_3C7B(var_1.waitflag);
}

set_all_fog_flags() {
  foreach(var_1 in level.fogfuncs)
  common_scripts\utility::flag_set(var_1.waitflag);
}

toggle_next_fog_state() {
  common_scripts\utility::flag_set(level.current_fog_flag);
}

get_fog_volumn_touched(var_0) {
  foreach(var_2 in self) {
    foreach(var_4 in var_2._id_A615) {
      if(var_0 istouching(var_4))
        return var_2;
    }
  }

  if(common_scripts\utility::_id_562E(var_0._id_A019))
    return self[1];
  else
    return self[0];
}

run_effects_fog() {
  wait 1;
  level thread common_scripts\_exploder::_id_088E(201);
  level thread common_scripts\_exploder::_id_088E(208);
  wait 1;
  level thread common_scripts\_exploder::_id_088E(202);
}

stop_effects_fog() {
  level thread common_scripts\_exploder::_id_2A6D(201, undefined, 0);
  level thread common_scripts\_exploder::_id_2A6D(202, undefined, 0);
  level thread common_scripts\_exploder::_id_2A6D(208, undefined, 0);
}

cliffside_vista_fog_on(var_0) {
  level thread common_scripts\_exploder::_id_088E(212, var_0);
}

cliffside_vista_fog_off(var_0) {
  level thread common_scripts\_exploder::_id_2A6D(212, var_0, 0);
}

spawn_assassin_cover() {
  var_0 = common_scripts\utility::_id_46B7("assassin_despawners", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_905E = common_scripts\utility::_id_46B7(var_2.target, "targetname");

    foreach(var_4 in var_2._id_905E) {
      var_4.spawner_fog_fx = _id_0547::_id_8FBA(var_4, "zmb_isl_fog_zmb_assn_01");
      _func_14C(var_4.spawner_fog_fx);
    }
  }
}

despawn_assassin_cover() {
  var_0 = common_scripts\utility::_id_46B7("assassin_despawners", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_905E = common_scripts\utility::_id_46B7(var_2.target, "targetname");

    foreach(var_4 in var_2._id_905E) {
      if(isDefined(var_4.spawner_fog_fx))
        var_4.spawner_fog_fx delete();
    }
  }
}

zombie_fog_effects_start() {
  wait 2;

  foreach(var_1 in _id_0547::_id_408F())
  _func_147(level._effect["zmb_isl_fog_zmb_emerge_01"], var_1, "J_SpineUpper");
}

add_fog_function(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_52BC = var_0;
  var_3._id_A796 = var_1;
  var_3.waitflag = var_2;
  common_scripts\utility::flag_init(var_3.waitflag);
  level.fogfuncs = common_scripts\utility::_id_0F6F(level.fogfuncs, var_3);
}

initializefogzone(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.zmb_island_fog_volumes))
    level.zmb_island_fog_volumes = [];

  var_5 = spawnStruct();

  if(var_0 == "default" || var_0 == "introduction")
    var_5._id_A615 = [];
  else
    var_5._id_A615 = getEntArray(var_0, "targetname");

  var_5.name = var_0;
  var_5.fog_set_normal = var_1;
  var_5.light_set_normal = var_2;
  var_5.fog_set_active = var_3;
  var_5.light_set_active = var_4;
  level.zmb_island_fog_volumes = common_scripts\utility::_id_0F6F(level.zmb_island_fog_volumes, var_5);
}

fog_wait(var_0) {
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if((var_2 + 1) % 5 == 1) {}

    wait 1;
  }
}

play_fog_state(var_0) {
  level childthread[[var_0._id_52BC]](var_0._id_A796, var_0.waitflag);
}

get_is_fog_active() {
  return common_scripts\utility::_id_562E(level.island_fog_is_thick) || _id_0547::_id_5565(level.current_fog_flag, "3. fog active");
}

wait_till_fog_active() {
  common_scripts\utility::_id_3C9F("2. fog rolling in");
}

get_fog_active_flag() {
  return "3. fog active";
}

spawn_an_assassin_zombie(var_0, var_1) {
  var_2 = undefined;

  if(common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(level.st_144545)) {
      level.first_fog_sequence = 0;
      return;
    }

    level.first_fog_sequence = 0;
    var_2 = 3010;
  }

  for(var_3 = 0; var_3 < level.max_fog_assassin_spawns; var_3++) {
    if(var_3 > 0) {
      if(!(randomint(100) < 60) && 90 - (gettime() - var_1) / 1000 > 50)
        continue;
      else
        wait 25;
    }

    var_4 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(undefined, var_2);

    if(common_scripts\utility::_id_562E(var_0)) {
      var_4.assassinmustleave = 1;
      var_4.isfirstlethalassassin = 1;
    }
  }
}