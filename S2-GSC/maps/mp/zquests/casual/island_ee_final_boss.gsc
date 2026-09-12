/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\casual\island_ee_final_boss.gsc
***********************************************************/

init() {
  level thread lib_0564::func_3BFB(0);
  level.zmb_final_boss_intro_goal = common_scripts\utility::func_46B5("zmb_final_boss_intro_goal", "targetname");
  level thread ensure_no_fireman_spawn();
  level.zmb_island_final_boss_phases_spawns = common_scripts\utility::func_46B7("zmb_final_boss_start_spawns", "targetname");
  common_scripts\utility::func_3C87("spawn_the_fireman_zombie");
  common_scripts\utility::func_3C87("fireman_boss_wait");
  var_00 = spawnStruct();
  var_00.var_3F11 = [::wait_for_boss_intro_done];
  var_00.asn_arr = [1, 0, 0, 0];
  var_01 = [1, 0, 0, 0];
  var_02 = [1, 1, 1, 1];
  initialize_zmi_final_boss_settings();
  add_zmb_island_boss_phase("zombie_island_boss_phase_1", "zmb_assassin_spawnpoint_boss_intro", 1, 4, 0, ::spawn_a_fireman, "start_zone", "sub_pens_1_zone", 0, var_00, var_01);
  add_zmb_island_boss_phase("zombie_island_boss_phase_2", undefined, 2, 4, 0, ::open_sub_pens_door, "sub_pens_1_zone", "mining_corner", 0, undefined, undefined);
  add_zmb_island_boss_phase("zombie_island_boss_phase_3", "zmb_assassin_spawnpoint_boss_phase_3", 4, 4, 0, ::ensure_sub_pens_door_opened, "mining_corner", "start_zone", 0, undefined, var_02);
  add_zmb_island_boss_phase("zombie_island_boss_phase_4", undefined, 4, 4, 1, ::maps / mp / mp_zombie_island_ee_fog_manager::unlock_fog_from_lock, undefined, undefined, 1, undefined, undefined);
}

initialize_zmi_final_boss_settings() {
  if(!isDefined(level.zmi_final_boss_settings)) {
    level.zmi_final_boss_settings = [];
  }

  set_island_final_boss_settings_casual();
}

set_island_final_boss_settings_casual() {
  level.zmi_final_boss_settings["intro_zombies"] = ["zombie_generic"];
  level.zmi_final_boss_settings["phase_2_mercy"] = 1;
}

ensure_no_fireman_spawn() {
  for(;;) {
    wait(1);
    level.var_66A6 = level.var_A980 + 99999;
  }
}

wait_for_boss_intro_done() {
  level.zmb_boss_introduction_finished = 1;
  self.bossintroassassin = 1;
  self.preformingbossintro = 1;
  if(isDefined(self.mod_fx)) {
    self.mod_fx delete();
  }

  while(!isDefined(level.zmb_final_boss_intro_goal)) {
    wait 0.05;
  }

  while(distance2d(self.origin, level.zmb_final_boss_intro_goal.origin) > 64) {
    self.var_1928 = level.zmb_final_boss_intro_goal;
    wait 0.05;
  }

  self.dontwaitonfirstattack = 1;
  self.readytosprint = 1;
  self.var_1928 = undefined;
  level.zmb_fog_passive_lock = 0;
  self.bossintroassassin = 0;
  self.preformingbossintro = 0;
  maps / mp / zombies / zombie_assassin::attach_assassin_mod_fx();
  return "Assassin Reached Boss Goal";
}

spawn_a_fireman() {
  common_scripts\utility::func_3C9F("spawn_the_fireman_zombie");
  wait(2.15);
  var_00 = common_scripts\utility::func_46B5("zmb_fireman_spawnpoint_phase_2", "targetname");
  var_01 = lib_0564::func_3C11(0, var_00, 0);
  var_01 lib_0547::func_84CB();
  var_01 maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_assassin_boss_fireman_health")));
  var_02 = common_scripts\utility::func_44BE("stove_panel", "targetname");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(lib_0547::func_5565(var_05.var_819A, "zmb_boss_fight_brenner_intro")) {
      var_03 = common_scripts\utility::func_F6F(var_03, var_05);
    }
  }

  foreach(var_05 in var_03) {
    playFX(common_scripts\utility::func_44F5("zmb_isl_fire_pyro_rnr"), var_05.origin);
    var_05 lib_0378::func_8D74("sub_pen_floor_trap_pyro_flame");
  }

  level notify("sub_pen_blockers_close");
  wait(7.5);
  common_scripts\utility::func_3C8F("fireman_boss_wait");
  var_09 = [];
  var_0A = getEntArray("stove_panel", "targetname");
  var_0B = [];
  for(var_0C = 1; var_0C < 35; var_0C++) {
    var_05 = getEnt("fire_panel_" + var_0C, "targetname");
    var_09 = common_scripts\utility::func_F6F(var_09, var_05);
  }

  foreach(var_05 in var_09) {
    var_0E = common_scripts\utility::func_4461(var_05.origin, var_0A);
    var_0B = common_scripts\utility::func_F6F(var_0B, var_0E);
  }

  level.burn_tags = [];
  lib_0378::func_8D74("start_corpse_gate_alarm");
  level.continue_final_boss_fire = 1;
  while(level.continue_final_boss_fire) {
    var_10 = var_0B;
    var_10 = common_scripts\utility::func_FA3(common_scripts\utility::func_F92(var_10), 0, int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_assassin_boss_num_fire_panels") - 1));
    foreach(var_05 in var_10) {
      level thread maps / mp / zquests / casual / island_ee_main::fire_panels_new(var_05);
    }

    wait(8.5);
  }
}

open_sub_pens_door() {
  common_scripts\utility::func_3C9F("zombie_island_boss_phase_2_rush_defeated");
  level.stop_final_boss_fire_alarm = 1;
  level.continue_final_boss_fire = 0;
  if(level.zmi_final_boss_settings["phase_2_mercy"]) {
    level notify("sub_pen_blockers_open");
  }
}

ensure_sub_pens_door_opened() {
  level notify("sub_pen_blockers_open");
}

start_zombie_island_boss_phase(param_00) {
  level.zmb_locked_spawn_zones = get_spawner_targetname_for_phase(param_00.start_zone);
  param_00 childthread maps / mp / zquests / casual / island_ee_util::enforce_zombie_limit();
  if(isDefined(param_00.assassinmanagerfunc)) {
    param_00 thread[[param_00.assassinmanagerfunc]]();
  }

  maps / mp / mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "lockdown", param_00.start_zone, param_00.next_zone);
  if(param_00.final_phase) {
    level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  }

  level thread run_assassin_boss_phase(param_00.phase_flag, param_00.phase_num, param_00.optionalbossspawnoverride, int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_assassin_boss_health_" + param_00.phase_num)), param_00.num_alive, param_00.num_to_kill, param_00.enable_death, param_00.assassin_alarm_overrides, param_00.optionalsetenteredgame);
  wait_for_phase_combat(param_00);
  if(param_00.final_phase) {
    common_scripts\utility::func_3C8F(param_00.phase_flag);
    return;
  }

  level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  level thread run_assassin_zombie_rush(param_00);
  wait_for_phase_rush(param_00);
  complete_boss_phase_step(param_00);
  maps / mp / mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
  level thread wait_for_players_to_mine_cart(param_00);
  wait_for_phase_cart_ride(param_00);
}

complete_boss_phase_step(param_00) {
  switch (param_00.phase_flag) {
    case "zombie_island_boss_phase_1":
      var_01 = lib_0557::func_782F(undefined, level.zmb_island_artillery_sled);
      lib_0557::func_781D("Final Boss Island", var_01, 0);
      level thread remove_cart_data(var_01);
      lib_0557::func_782D("Final Boss Island", "Final Boss Island Part 1");
      break;

    case "zombie_island_boss_phase_2":
      lib_0557::func_782D("Final Boss Island", "Final Boss Island Part 2");
      break;

    case "zombie_island_boss_phase_3":
      lib_0557::func_782D("Final Boss Island", "Final Boss Island Part 3");
      break;

    case "zombie_island_boss_phase_4":
      lib_0557::func_782D("Final Boss Island", "Defeat Wustlings");
      break;
  }
}

remove_cart_data(param_00) {
  level.mine_cart_notification = "players_left_beach_on_cart";
  level waittill(level.mine_cart_notification);
  lib_0557::func_7847("Final Boss Island", param_00);
}

set_fireman_spawn_flag() {
  while(level.zmb_transport_system["current_station"] != "start_zone") {
    wait(0.125);
  }

  while(level.zmb_island_artillery_sled common_scripts\utility::func_3794("zmb_island_cart_path_mid_complete")) {
    wait(0.125);
  }

  maps / mp / mp_zombie_island_cart::wait_for_cart_finished_with_mid_route();
  common_scripts\utility::func_3C8F("spawn_the_fireman_zombie");
}

run_assassin_zombie_rush(param_00) {
  var_01 = 45;
  var_02 = get_spawner_targetname_for_phase(param_00.start_zone);
  wait 0.05;
  level thread run_an_island_beach_assault(param_00.phase_flag, var_02, var_01);
  wait(var_01 - 15);
  level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
}

get_spawner_targetname_for_phase(param_00) {
  var_01 = [];
  if(!isDefined(param_00)) {
    param_00 = "start_zone";
  }

  switch (param_00) {
    case "start_zone":
      var_01 = ["start_zone"];
      break;

    case "sub_pens_1_zone":
      var_01 = ["sub_pens_1_zone"];
      break;

    case "mining_corner":
      var_01 = ["high_canon", "vista_middle_zone", "mining_corner"];
      break;
  }

  return var_01;
}

wait_for_phase_cart_ride(param_00) {
  common_scripts\utility::func_3C9F(param_00.phase_flag);
}

wait_for_phase_rush(param_00) {
  common_scripts\utility::func_3C9F(param_00.phase_flag + "_rush_defeated");
}

wait_for_phase_combat(param_00) {
  common_scripts\utility::func_3C9F(param_00.phase_flag + "_assassins_defeated");
}

wait_for_players_to_mine_cart(param_00) {
  if(!param_00.final_phase) {
    if(lib_0547::func_5565(param_00.phase_flag, "zombie_island_boss_phase_1")) {
      level thread set_fireman_spawn_flag();
    }

    level.zmb_island_artillery_sled waittill("arrived at " + param_00.next_zone);
    common_scripts\utility::func_3C8F(param_00.phase_flag);
  }
}

kill_remaining_zombies(param_00) {
  level.zmb_island_artillery_sled waittill("cart_start_leave_done");
  var_01 = lib_0547::func_408F();
  foreach(var_03 in var_01) {
    var_03 suicide();
  }
}

get_rush_spawners() {
  var_00 = common_scripts\utility::func_46B5("intro_bunker_struct", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.target, "targetname");
  var_00.rush_spawners = [];
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "zombie_spawner":
        switch (var_03.var_81A1) {
          case "zombie_beach_rush_spawner":
            var_00.rush_spawners = common_scripts\utility::func_F6F(var_00.rush_spawners, var_03);
            break;
        }
        break;
    }
  }

  return var_00.rush_spawners;
}

run_an_island_beach_assault(param_00, param_01, param_02) {
  level.zmb_locked_spawn_zones = param_01;
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8606();
  wait(param_02 - 10);
  common_scripts\utility::func_3C8F(param_00 + "_rush_defeated");
  wait(10);
  level.zmb_locked_spawn_zones = undefined;
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
}

show_transport_instructions() {
  var_00 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_00 maps\mp\gametypes\_hud_util::setpoint("TOP");
  var_00.label = &"ZOMBIE_ISLAND_MINE_CART_AVAILABLE_BOSS";
  level waittill(level.mine_cart_notification);
  var_00 destroy();
}

add_zmb_island_boss_phase(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(level.zmb_island_final_boss_phases)) {
    level.zmb_island_final_boss_phases = [];
  }

  var_0B = spawnStruct();
  var_0B.assassinmanagerfunc = param_05;
  var_0B.phase_flag = param_00;
  var_0B.num_alive = param_02;
  var_0B.num_to_kill = param_03;
  var_0B.enable_death = param_04;
  var_0B.phase_num = level.zmb_island_final_boss_phases.size + 1;
  var_0B.start_zone = param_06;
  var_0B.next_zone = param_07;
  var_0B.final_phase = common_scripts\utility::func_562E(param_08);
  var_0B.optionalbossspawnoverride = param_01;
  var_0B.assassin_alarm_overrides = param_09;
  var_0B.optionalsetenteredgame = param_0A;
  common_scripts\utility::func_3C87(var_0B.phase_flag + "_assassins_defeated");
  common_scripts\utility::func_3C87(var_0B.phase_flag + "_rush_defeated");
  common_scripts\utility::func_3C87(var_0B.phase_flag);
  level.zmb_island_final_boss_phases = common_scripts\utility::func_F6F(level.zmb_island_final_boss_phases, var_0B);
}

run_assassin_boss_phase(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = maps / mp / zombies / zombie_assassin::get_all_special_assassins();
  var_0A = 0;
  var_0B = undefined;
  for(var_0C = 0; var_0C < param_05; var_0C = var_0C + param_04) {
    var_0D = [];
    for(var_0E = 0; var_0E < param_04; var_0E++) {
      if(param_01 == 3) {
        var_0B = ["vista_middle_zone", "high_canon"];
      }

      if(param_01 == 4) {
        var_0B = ["start_zone"];
      }

      if(param_01 == 2) {
        common_scripts\utility::func_3C9F("fireman_boss_wait");
      }

      var_0F = undefined;
      if(isDefined(param_02)) {
        var_10 = common_scripts\utility::func_46B7(param_02, "targetname");
        var_0F = var_10[var_0A];
      }

      var_11 = undefined;
      if(isDefined(param_07) && param_07.asn_arr[var_0A]) {
        var_11 = spawnStruct();
        var_11.var_3F11 = param_07.var_3F11;
      }

      var_12 = isDefined(param_08) && common_scripts\utility::func_562E(param_08[var_0A]);
      var_13 = "Phase 1: Entrance";
      if(common_scripts\utility::func_562E(var_12)) {
        if(param_01 <= 1) {
          var_13 = "Phase 3: ATTACK";
        } else {
          var_13 = "Phase 2: EXIT AMBUSH";
        }
      }

      var_14 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(var_09[var_0A], param_03, var_0F, var_12, var_13, 1, 0, undefined, var_11, 1, "boss look", var_0B);
      if(var_12) {
        var_14 lib_0547::func_84CB();
        if(param_01 <= 1) {
          var_14.noflurry = 1;
        }
      }

      var_14.enable_final_death = param_06;
      var_14.activeassassinboss = 1;
      var_0A++;
    }

    wait 0.05;
    wait_for_assassin_wave_clear();
  }

  common_scripts\utility::func_3C8F(param_00 + "_assassins_defeated");
}

wait_for_assassin_wave_clear(param_00) {
  for(;;) {
    var_01 = lib_0547::func_408F();
    var_02 = 1;
    var_03 = [];
    foreach(var_05 in var_01) {
      if(common_scripts\utility::func_562E(var_05.activeassassinboss)) {
        var_03 = common_scripts\utility::func_F6F(var_03, var_05);
      }
    }

    if(var_03.size == 0) {
      break;
    }

    wait 0.05;
    wait 0.05;
  }
}

init_final_boss_event() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    var_02 suicide();
  }
}

move_players_to_boss_start() {
  maps / mp / gametypes / zombies::func_7E57();
  wait 0.05;
  level thread maps / mp / zquests / casual / island_ee_util::func_7432(1, 1, "black");
  wait(1);
  wait 0.05;
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("tag_origin");
  setDvar("1874", 0);
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    level.players[var_01] maps / mp / mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
    level.players[var_01] setOrigin(level.zmb_island_final_boss_phases_spawns[var_01].origin);
    if(isDefined(level.zmb_island_final_boss_phases_spawns[var_01].angles)) {
      level.players[var_01] setplayerangles(level.zmb_island_final_boss_phases_spawns[var_01].angles);
    }

    level.players[var_01] setclientomnvar("ui_hide_hud", 1);
    level.players[var_01] method_812B(0);
    level.players[var_01] method_848D();
    level.players[var_01] lib_0547::func_8A6D(1);
    level.players[var_01] playerlinkTo(var_00);
    level.players[var_01].var_480F = 1;
    level.players[var_01] disableoffhandweapons();
    level.players[var_01] method_84CB();
  }

  while(!maps / mp / mp_zombie_island_ee_fog_manager::is_fog_rolling_in()) {
    wait 0.05;
  }

  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    level.players[var_01] maps / mp / mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
  }

  wait 0.05;
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    level.players[var_01] thread maps / mp / mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island", "mp_zombie_island", 1, 1);
  }

  common_scripts\utility::func_3C8F("players_boss_spawn_done");
  wait(1);
  level thread maps / mp / zquests / casual / island_ee_util::func_7432(1, 0, "black");
  common_scripts\utility::func_3C9F("asn_players_are_blinded");
  setDvar("1874", 1);
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    level.players[var_01] setclientomnvar("ui_hide_hud", 0);
    level.players[var_01] method_812B(1);
    level.players[var_01] method_848C();
    level.players[var_01] lib_0547::func_8A6D(0);
    level.players[var_01] unlink();
    level.players[var_01].var_480F = 0;
    level.players[var_01] enableoffhandweapons();
    level.players[var_01] method_84CC();
  }
}