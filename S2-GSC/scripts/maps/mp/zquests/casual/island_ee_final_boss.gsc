/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\casual\island_ee_final_boss.gsc
*******************************************************************/

init() {
  level thread _id_0564::_id_3BFB(0);
  level.zmb_final_boss_intro_goal = common_scripts\utility::_id_46B5("zmb_final_boss_intro_goal", "targetname");
  level thread ensure_no_fireman_spawn();
  level.zmb_island_final_boss_phases_spawns = common_scripts\utility::_id_46B7("zmb_final_boss_start_spawns", "targetname");
  common_scripts\utility::flag_init("spawn_the_fireman_zombie");
  common_scripts\utility::flag_init("fireman_boss_wait");
  var_0 = spawnStruct();
  var_0._id_3F11 = [::wait_for_boss_intro_done];
  var_0.asn_arr = [1, 0, 0, 0];
  var_1 = [1, 0, 0, 0];
  var_2 = [1, 1, 1, 1];
  initialize_zmi_final_boss_settings();
  add_zmb_island_boss_phase("zombie_island_boss_phase_1", "zmb_assassin_spawnpoint_boss_intro", 1, 4, 0, ::spawn_a_fireman, "start_zone", "sub_pens_1_zone", 0, var_0, var_1);
  add_zmb_island_boss_phase("zombie_island_boss_phase_2", undefined, 2, 4, 0, ::open_sub_pens_door, "sub_pens_1_zone", "mining_corner", 0, undefined, undefined);
  add_zmb_island_boss_phase("zombie_island_boss_phase_3", "zmb_assassin_spawnpoint_boss_phase_3", 4, 4, 0, ::ensure_sub_pens_door_opened, "mining_corner", "start_zone", 0, undefined, var_2);
  add_zmb_island_boss_phase("zombie_island_boss_phase_4", undefined, 4, 4, 1, maps\mp\mp_zombie_island_ee_fog_manager::unlock_fog_from_lock, undefined, undefined, 1, undefined, undefined);
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
    wait 1;
    level._id_66A6 = level._id_A980 + 99999;
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
    waitframe();
  }

  while(_distance2d(self.origin, level.zmb_final_boss_intro_goal.origin) > 64) {
    self._id_1928 = level.zmb_final_boss_intro_goal;
    waitframe();
  }

  self.dontwaitonfirstattack = 1;
  self.readytosprint = 1;
  self._id_1928 = undefined;
  level.zmb_fog_passive_lock = 0;
  self.bossintroassassin = 0;
  self.preformingbossintro = 0;
  maps\mp\zombies\zombie_assassin::attach_assassin_mod_fx();
  return "Assassin Reached Boss Goal";
}

spawn_a_fireman() {
  common_scripts\utility::_id_3C9F("spawn_the_fireman_zombie");
  wait 2.15;
  var_0 = common_scripts\utility::_id_46B5("zmb_fireman_spawnpoint_phase_2", "targetname");
  var_1 = _id_0564::_id_3C11(0, var_0, 0);
  var_1 _id_0547::disableoffhandsecondaryweapons();
  var_1 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_assassin_boss_fireman_health")));
  var_2 = common_scripts\utility::_id_44BE("stove_panel", "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(_id_0547::_id_5565(var_5.getnegotiationnextnode, "zmb_boss_fight_brenner_intro")) {
      var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
    }
  }

  foreach(var_5 in var_3) {
    playFX(common_scripts\utility::_id_44F5("zmb_isl_fire_pyro_rnr"), var_5.origin);
    var_5 _id_0378::_id_8D74("sub_pen_floor_trap_pyro_flame");
  }

  level notify("sub_pen_blockers_close");
  wait 7.5;
  common_scripts\utility::flag_set("fireman_boss_wait");
  var_9 = [];
  var_10 = getEntArray("stove_panel", "targetname");
  var_11 = [];

  for(var_12 = 1; var_12 < 35; var_12++) {
    var_5 = _getEnt("fire_panel_" + var_12, "targetname");
    var_9 = common_scripts\utility::_id_0F6F(var_9, var_5);
  }

  foreach(var_5 in var_9) {
    var_14 = common_scripts\utility::_id_4461(var_5.origin, var_10);
    var_11 = common_scripts\utility::_id_0F6F(var_11, var_14);
  }

  level.burn_tags = [];
  _id_0378::_id_8D74("start_corpse_gate_alarm");
  level.continue_final_boss_fire = 1;

  while(level.continue_final_boss_fire) {
    var_16 = var_11;
    var_16 = common_scripts\utility::_id_0FA3(common_scripts\utility::array_randomize(var_16), 0, int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_assassin_boss_num_fire_panels") - 1));

    foreach(var_5 in var_16) {
      level thread maps\mp\zquests\casual\island_ee_main::fire_panels_new(var_5);
    }

    wait 8.5;
  }
}

open_sub_pens_door() {
  common_scripts\utility::_id_3C9F("zombie_island_boss_phase_2_rush_defeated");
  level.stop_final_boss_fire_alarm = 1;
  level.continue_final_boss_fire = 0;

  if(level.zmi_final_boss_settings["phase_2_mercy"]) {
    level notify("sub_pen_blockers_open");
  }
}

ensure_sub_pens_door_opened() {
  level notify("sub_pen_blockers_open");
}

start_zombie_island_boss_phase(var_0) {
  level.zmb_locked_spawn_zones = get_spawner_targetname_for_phase(var_0.start_zone);
  var_0 childthread maps\mp\zquests\casual\island_ee_util::enforce_zombie_limit();

  if(isDefined(var_0.assassinmanagerfunc)) {
    var_0 thread[[var_0.assassinmanagerfunc]]();
  }

  maps\mp\mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "lockdown", var_0.start_zone, var_0.next_zone);

  if(var_0.final_phase) {
    level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  }

  level thread run_assassin_boss_phase(var_0.phase_flag, var_0.phase_num, var_0.optionalbossspawnoverride, int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_assassin_boss_health_" + var_0.phase_num)), var_0.num_alive, var_0.num_to_kill, var_0.enable_death, var_0.assassin_alarm_overrides, var_0.optionalsetenteredgame);
  wait_for_phase_combat(var_0);

  if(var_0.final_phase) {
    common_scripts\utility::flag_set(var_0.phase_flag);
    return;
  }

  level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  level thread run_assassin_zombie_rush(var_0);
  wait_for_phase_rush(var_0);
  complete_boss_phase_step(var_0);
  maps\mp\mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
  level thread wait_for_players_to_mine_cart(var_0);
  wait_for_phase_cart_ride(var_0);
}

complete_boss_phase_step(var_0) {
  switch (var_0.phase_flag) {
    case "zombie_island_boss_phase_1":
      var_1 = _id_0557::_id_782F(undefined, level.zmb_island_artillery_sled);
      _id_0557::_id_781D("Final Boss Island", var_1, 0);
      level thread remove_cart_data(var_1);
      _id_0557::_id_782D("Final Boss Island", "Final Boss Island Part 1");
      break;
    case "zombie_island_boss_phase_2":
      _id_0557::_id_782D("Final Boss Island", "Final Boss Island Part 2");
      break;
    case "zombie_island_boss_phase_3":
      _id_0557::_id_782D("Final Boss Island", "Final Boss Island Part 3");
      break;
    case "zombie_island_boss_phase_4":
      _id_0557::_id_782D("Final Boss Island", "Defeat Wustlings");
      break;
  }
}

remove_cart_data(var_0) {
  level.mine_cart_notification = "players_left_beach_on_cart";
  level waittill(level.mine_cart_notification);
  _id_0557::_id_7847("Final Boss Island", var_0);
}

set_fireman_spawn_flag() {
  while(level.zmb_transport_system["current_station"] != "start_zone") {
    wait 0.125;
  }

  while(level.zmb_island_artillery_sled common_scripts\utility::_id_3794("zmb_island_cart_path_mid_complete")) {
    wait 0.125;
  }

  maps\mp\mp_zombie_island_cart::wait_for_cart_finished_with_mid_route();
  common_scripts\utility::flag_set("spawn_the_fireman_zombie");
}

run_assassin_zombie_rush(var_0) {
  var_1 = 45;
  var_2 = get_spawner_targetname_for_phase(var_0.start_zone);
  waitframe();
  level thread run_an_island_beach_assault(var_0.phase_flag, var_2, var_1);
  wait(var_1 - 15);
  level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
}

get_spawner_targetname_for_phase(var_0) {
  var_1 = [];

  if(!isDefined(var_0)) {
    var_0 = "start_zone";
  }

  switch (var_0) {
    case "start_zone":
      var_1 = ["start_zone"];
      break;
    case "sub_pens_1_zone":
      var_1 = ["sub_pens_1_zone"];
      break;
    case "mining_corner":
      var_1 = ["high_canon", "vista_middle_zone", "mining_corner"];
      break;
  }

  return var_1;
}

wait_for_phase_cart_ride(var_0) {
  common_scripts\utility::_id_3C9F(var_0.phase_flag);
}

wait_for_phase_rush(var_0) {
  common_scripts\utility::_id_3C9F(var_0.phase_flag + "_rush_defeated");
}

wait_for_phase_combat(var_0) {
  common_scripts\utility::_id_3C9F(var_0.phase_flag + "_assassins_defeated");
}

wait_for_players_to_mine_cart(var_0) {
  if(!var_0.final_phase) {
    if(_id_0547::_id_5565(var_0.phase_flag, "zombie_island_boss_phase_1")) {
      level thread set_fireman_spawn_flag();
    }

    level.zmb_island_artillery_sled waittill("arrived at " + var_0.next_zone);
    common_scripts\utility::flag_set(var_0.phase_flag);
  }
}

kill_remaining_zombies(var_0) {
  level.zmb_island_artillery_sled waittill("cart_start_leave_done");
  var_1 = _id_0547::_id_408F();

  foreach(var_3 in var_1) {
    var_3 suicide();
  }
}

get_rush_spawners() {
  var_0 = common_scripts\utility::_id_46B5("intro_bunker_struct", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  var_0.rush_spawners = [];

  foreach(var_3 in var_1) {
    switch (var_3._id_0165) {
      case "zombie_spawner":
        switch (var_3.setgoalnode) {
          case "zombie_beach_rush_spawner":
            var_0.rush_spawners = common_scripts\utility::_id_0F6F(var_0.rush_spawners, var_3);
            break;
        }

        break;
    }
  }

  return var_0.rush_spawners;
}

run_an_island_beach_assault(var_0, var_1, var_2) {
  level.zmb_locked_spawn_zones = var_1;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  wait(var_2 - 10);
  common_scripts\utility::flag_set(var_0 + "_rush_defeated");
  wait 10;
  level.zmb_locked_spawn_zones = undefined;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
}

show_transport_instructions() {
  var_0 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_0 maps\mp\gametypes\_hud_util::setpoint("TOP");
  var_0.label = &"ZOMBIE_ISLAND_MINE_CART_AVAILABLE_BOSS";
  level waittill(level.mine_cart_notification);
  var_0 destroy();
}

add_zmb_island_boss_phase(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(level.zmb_island_final_boss_phases)) {
    level.zmb_island_final_boss_phases = [];
  }

  var_11 = spawnStruct();
  var_11.assassinmanagerfunc = var_5;
  var_11.phase_flag = var_0;
  var_11.num_alive = var_2;
  var_11.num_to_kill = var_3;
  var_11.enable_death = var_4;
  var_11.phase_num = level.zmb_island_final_boss_phases.size + 1;
  var_11.start_zone = var_6;
  var_11.next_zone = var_7;
  var_11.final_phase = common_scripts\utility::_id_562E(var_8);
  var_11.optionalbossspawnoverride = var_1;
  var_11.assassin_alarm_overrides = var_9;
  var_11.optionalsetenteredgame = var_10;
  common_scripts\utility::flag_init(var_11.phase_flag + "_assassins_defeated");
  common_scripts\utility::flag_init(var_11.phase_flag + "_rush_defeated");
  common_scripts\utility::flag_init(var_11.phase_flag);
  level.zmb_island_final_boss_phases = common_scripts\utility::_id_0F6F(level.zmb_island_final_boss_phases, var_11);
}

run_assassin_boss_phase(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = maps\mp\zombies\zombie_assassin::get_all_special_assassins();
  var_10 = 0;
  var_11 = undefined;

  for(var_12 = 0; var_12 < var_5; var_12 = var_12 + var_4) {
    var_13 = [];

    for(var_14 = 0; var_14 < var_4; var_14++) {
      if(var_1 == 3) {
        var_11 = ["vista_middle_zone", "high_canon"];
      }

      if(var_1 == 4) {
        var_11 = ["start_zone"];
      }

      if(var_1 == 2) {
        common_scripts\utility::_id_3C9F("fireman_boss_wait");
      }

      var_15 = undefined;

      if(isDefined(var_2)) {
        var_16 = common_scripts\utility::_id_46B7(var_2, "targetname");
        var_15 = var_16[var_10];
      }

      var_17 = undefined;

      if(isDefined(var_7) && var_7.asn_arr[var_10]) {
        var_17 = spawnStruct();
        var_17._id_3F11 = var_7._id_3F11;
      }

      var_18 = isDefined(var_8) && common_scripts\utility::_id_562E(var_8[var_10]);
      var_19 = "Phase 1: Entrance";

      if(common_scripts\utility::_id_562E(var_18)) {
        if(var_1 <= 1) {
          var_19 = "Phase 3: ATTACK";
        } else {
          var_19 = "Phase 2: EXIT AMBUSH";
        }
      }

      var_20 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(var_9[var_10], var_3, var_15, var_18, var_19, 1, 0, undefined, var_17, 1, "boss look", var_11);

      if(var_18) {
        var_20 _id_0547::disableoffhandsecondaryweapons();

        if(var_1 <= 1) {
          var_20.noflurry = 1;
        }
      }

      var_20.enable_final_death = var_6;
      var_20.activeassassinboss = 1;
      var_10++;
    }

    waitframe();
    wait_for_assassin_wave_clear();
  }

  common_scripts\utility::flag_set(var_0 + "_assassins_defeated");
}

wait_for_assassin_wave_clear(var_0) {
  for(;;) {
    var_1 = _id_0547::_id_408F();
    var_2 = 1;
    var_3 = [];

    foreach(var_5 in var_1) {
      if(common_scripts\utility::_id_562E(var_5.activeassassinboss)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
      }
    }

    if(var_3.size == 0) {
      break;
    }

    waitframe();
    waitframe();
  }
}

init_final_boss_event() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    var_2 suicide();
  }
}

move_players_to_boss_start() {
  maps\mp\gametypes\zombies::_id_7E57();
  waitframe();
  level thread maps\mp\zquests\casual\island_ee_util::_id_7432(1, 1, "black");
  wait 1;
  waitframe();
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  setDvar("1874", 0);

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] maps\mp\mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
    level.players[var_1] setOrigin(level.zmb_island_final_boss_phases_spawns[var_1].origin);

    if(isDefined(level.zmb_island_final_boss_phases_spawns[var_1].angles)) {
      level.players[var_1] setplayerangles(level.zmb_island_final_boss_phases_spawns[var_1].angles);
    }

    level.players[var_1] setclientomnvar("ui_hide_hud", 1);
    level.players[var_1] allowfire(0);
    level.players[var_1] hideviewmodel();
    level.players[var_1] _id_0547::_id_8A6D(1);
    level.players[var_1] playerlinkTo(var_0);
    level.players[var_1]._id_480F = 1;
    level.players[var_1] disableoffhandweapons();
    level.players[var_1] disableoffhandsecondaryweapons();
  }

  while(!maps\mp\mp_zombie_island_ee_fog_manager::is_fog_rolling_in()) {
    waitframe();
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] maps\mp\mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
  }

  waitframe();

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] thread maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island", "mp_zombie_island", 1, 1);
  }

  common_scripts\utility::flag_set("players_boss_spawn_done");
  wait 1;
  level thread maps\mp\zquests\casual\island_ee_util::_id_7432(1, 0, "black");
  common_scripts\utility::_id_3C9F("asn_players_are_blinded");
  setDvar("1874", 1);

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] setclientomnvar("ui_hide_hud", 0);
    level.players[var_1] allowfire(1);
    level.players[var_1] showviewmodel();
    level.players[var_1] _id_0547::_id_8A6D(0);
    level.players[var_1] unlink();
    level.players[var_1]._id_480F = 0;
    level.players[var_1] enableoffhandweapons();
    level.players[var_1] enableoffhandsecondaryweapons();
  }
}