/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_stealth.gsc
***********************************************/

function coop_stealth_init() {
  if(!scripts\engine\utility::flag_exist("raid_active")) {
    scripts\engine\utility::flag_init("raid_active");
  }

  scripts\engine\utility::flag_init("stealth_settings_activated");
  register_stealth_state_funcs();
  ref_129FD();
  ref_129FE();
  thread ref_134E4();
  level.bonusdeathplunderot = [];
  level.stealth_soundaliases = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
}

function ref_12C57() {
  level.bonusdeathplunderot = [];
  level.global_stealth_broken = 0;
}

function register_stealth_state_funcs() {
  level.enter_stealth_state_func = [];
  level.exit_stealth_state_func = [];
  register_stealth_state_func("idle", &enter_casual, &exit_casual);
  register_stealth_state_func("casual", &enter_casual, &exit_casual);
  register_stealth_state_func("alert", &enter_alert, &exit_alert);
  register_stealth_state_func("combat", &enter_combat, &exit_combat);
}

function register_stealth_state_func(var_0, var_1, var_2) {
  level.enter_stealth_state_func[var_0] = var_1;
  level.exit_stealth_state_func[var_0] = var_2;
}

function start_coop_stealth() {
  thread flash_crate_update_hint_logic_alt();
}

function ai_sight_monitor(var_0) {
  self.sightlastactivetime = 0;
  self.sightstate = 0;
  updateaisightonplayer(self.sightstate);
}

function getaisightdirection(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  }

  if(var_5 >= 0.382683) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  }

  if(var_5 >= -0.382683) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  }

  if(var_5 >= -0.92388) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  }

  return 16;
}

function isleft2d(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

function regular_enemy_death_func() {
  var_0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  if(isDefined(level.bonusdeathplunderot) && scripts\engine\utility::array_contains(level.bonusdeathplunderot, self)) {
    scripts\engine\utility::array_remove(level.bonusdeathplunderot, self);
  }

  leave_corpse_for_others_to_see(var_0);
  delete_stealth_meter(var_0, var_0);
  delete_combat_icon(var_0, var_0);
}

function leave_corpse_for_others_to_see() {
  if(!isDefined(level.enemy_ai_corpse_locations)) {
    level.enemy_ai_corpse_locations = [];
  }

  if(!istrue(self.died_poorly)) {
    var_0 = spawnStruct();
    var_0.loc = self.origin + (0, 0, 120);
    var_0.time_stamp = gettime();
    var_0.index = self getentitynumber() + randomint(100);
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_add(level.enemy_ai_corpse_locations, var_0);
    return;
  }
}

function weapon_xp_iw8_sn_kilo98() {
  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    return 1;
  }

  return getdvarint("cp_sp_stealth", 0);
}

function ref_132D7() {
  if(level.script == "cp_raid_complex") {
    return (weapon_xp_iw8_sn_kilo98() && (self.unittype == "soldier" || self.unittype == "juggernaut"));
  }

  return weapon_xp_iw8_sn_kilo98() && self.unittype == "soldier";
}

function run_common_functions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\engine\utility::flag("stealth_settings_activated")) {
    setdvarifuninitialized("cp_sp_stealth", 0);
    attachdrill();
  }

  if(istrue(level.global_stealth_broken)) {
    var_0 thread scripts\cp\cp_modular_spawning::enter_combat();
    return;
  }

  if(ref_132D7(var_0)) {
    if(isDefined(var_0.group) && isDefined(var_0.group.group_name)) {
      var_0.script_stealthgroup = var_0.group.group_name;
    } else {
      var_0.script_stealthgroup = "group";
    }

    if(isDefined(var_0.spawnpoint) && isDefined(var_0.spawnpoint.script_sightrange)) {
      var_0.stealth.override_damage_auto_range = int(var_0.script_sightrange);
    }

    var_0 thread scripts\stealth\enemy::main();
    var_0 thread scripts\mp\vehicles\cargo_truck_mg_mp::ref_11CD7(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
    thread seeing_player_time_tracker(var_0);
    thread ref_14458();
    thread stealth_meter_display_think(var_0);
    var_0.stealth.console_being_hacked = 1;
    var_0.stealth.funcs["event_combat"] = &nuke_stoptheclock;
    var_0.fnstealthgotonode = &select_bunker_server_two_spawners;
    var_0.pacifist_override = 1;
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.34202;
  } else {
    var_3 = cos(var_3);
  }

  if(!isDefined(var_4)) {
    var_4 = 250000;
  }

  var_0 addaieventlistener("glass_destroyed");
  var_0 enablestatelookat(1);
  var_0 enablescriptedlookat(1);
  var_0.pacifist_override = 1;
  set_current_stealth_state(var_0, var_0, "casual");
  enter_current_stealth_state(var_0, var_0);

  if(!istrue(var_5)) {
    thread open_scriptable_door_monitor(var_0);
  }

  thread watch_for_ai_events();
  thread i_see_player_watcher(var_0, var_0, var_2, var_3, var_4);
  thread i_see_friendly_corpse_watcher(var_0, var_0);
  thread delay_enter_combat_after_stealth(var_0);
  thread watch_for_alarm_triggered();
  thread spotlight_min_dist_sq_from_node(var_0, var_3);
  thread spotlight_goal_node(var_0, var_3);
  thread spotlight_max_dist_sq_from_node(var_0, var_3);
  thread spotlight_angles_offset(var_0, var_3);
  thread ref_119D0(var_0);
  thread blueprint_chancebase(var_0);
  thread bomb_count_down_end_time_stamp_ms(var_0);
}

function blueprint_chancebase(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  thread play_enemy_radio_chat(level, propwatchcleanupondisconnect());
  var_0 notify("watch_for_ai_events");
  getbestintersectionpt(var_0, var_0, var_2.name, "enemies_are_alerted");
}

function bomb_count_down_end_time_stamp_ms(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_0 waittill("hit_ai", var_1);
  thread play_enemy_radio_chat(level, propwatchcleanupondisconnect());
  var_0 notify("watch_for_ai_events");
  getbestintersectionpt(var_0, var_0, var_1.name, "enemies_are_alerted");
}

function ref_119D0(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0.a.disablelongdeath = 1;
  var_1 = scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", var_0, "enter_combat");
  var_0.a.disablelongdeath = 0;
}

function nuke_stoptheclock(var_0) {
  thread scripts\cp\cp_modular_spawning::enter_combat();
  return false;
}

function select_bunker_server_two_spawners(var_0, var_1, var_2) {
  if(istrue(self.using_goto_node)) {
    if(isDefined(self.currentnode)) {
      thread scripts\cp\cp_modular_spawning::go_to_node(self.currentnode);
      return;
    }

    return;
  }

  scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function ref_139BF() {
  self notify("suspicious_door_monitor_end");
  self endon("death");
  self endon("disconnect");
  self endon("suspicious_door_monitor_end");
  var_0 = 384;
  var_1 = 80;
}

function ref_13B3A() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(isDefined(self.stealth.maxthreat)) {
      if(self.stealth.maxthreat > 0.2 && isDefined(self.stealth.maxthreat_enemy)) {
        var_0 = self.stealth.maxthreat_enemy;
        mark_seen_this_player_this_frame(var_0, self);
        var_0 notify("display_stealth_meter_to", self);
      }
    }

    waitframe();
  }
}

function spotlight_max_dist_sq_from_node(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_2 = self;
  var_3 = 3000;
  var_4 = var_3 * var_3;
  var_5 = 0.1;
  var_6 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_1 *= 6.25;

  for(;;) {
    wait 0.4;

    if(!isDefined(level.taccovers)) {
      continue;
    }

    var_7 = self getapproxeyepos();

    foreach(var_9 in level.taccovers) {
      if(isDefined(var_9)) {
        var_10 = lengthsquared(var_9.origin - self.origin);
        var_11 = raritycamsmall(var_2, var_9, var_0, var_3, var_5);

        if(var_10 < var_11 * var_11) {
          var_12 = self cansee(var_9);

          if(!var_12) {
            var_12 = scripts\engine\trace::ray_trace_passed(var_7, var_9.origin, [self, var_9], var_6);
          }

          if(var_12) {
            if(var_10 <= var_1) {
              getbestintersectionpt(self, var_9.owner.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var_9, 1);
            } else {
              i_saw_player(self, var_9.owner, 0);
            }

            break;
          }
        }
      }
    }

    var_5 = undefined;
    var_7 = undefined;
  }
}

function raritycamsmall(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_5 = 0.34202;
  } else {
    var_5 = cos(var_3);
  }

  if(!scripts\engine\utility::within_fov(var_1.origin, var_1.angles, var_2.origin, var_3)) {
    var_4 *= var_5;
  }

  return var_4;
}

function spotlight_goal_node(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_2 = self;
  var_3 = 3000;
  var_4 = 200;
  var_5 = 1500;
  var_6 = 0.6;
  var_7 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_1 *= 6.25;

  for(;;) {
    var_8 = self getapproxeyepos();

    foreach(var_10 in level.players) {
      var_11 = quickdropnewitem(var_10);

      if(isDefined(var_11)) {
        var_12 = lengthsquared(var_11.origin - self.origin);
        var_13 = raritycamwatch(self, var_11, var_0, var_3, var_5, var_4, var_6);

        if(var_12 < var_13 * var_13) {
          var_14 = self cansee(var_11);

          if(!var_14) {
            var_14 = scripts\engine\trace::ray_trace_passed(var_8, var_11.origin, [self, var_11], var_7);
          }

          if(var_14) {
            if(var_12 <= var_1) {
              getbestintersectionpt(self, var_10.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var_11, 1);
            } else {
              i_saw_player(self, var_10, 0);
            }

            break;
          }
        }
      }
    }

    var_6 = undefined;
    var_9 = undefined;
    wait 0.1;
  }
}

function quickdropnewitem(var_0) {
  if(isDefined(var_0.ref_12F15)) {
    return var_0.ref_12F15;
  }

  if(isDefined(var_0.monitorhotfoot)) {
    return var_0.monitorhotfoot;
  }

  return undefined;
}

function spotlight_min_dist_sq_from_node(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_2 = 3000;
  var_3 = 200;
  var_4 = 1500;
  var_5 = 0.6;
  var_6 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var_7 = self getapproxeyepos();

    foreach(var_9 in level.players) {
      if(var_9 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        var_10 = lengthsquared(var_9.origin - self.origin);
        var_11 = raritycamwatch(self, var_9.vehicle, var_0, var_2, var_4, var_3, var_5);

        if(var_10 < var_11 * var_11) {
          var_12 = self cansee(var_9);

          if(!var_12) {
            var_12 = scripts\engine\trace::ray_trace_passed(var_7, var_9 getEye(), [self, var_9, var_9.vehicle], var_6);
          }

          if(var_12) {
            if(var_10 <= var_1) {
              getbestintersectionpt(self, var_9.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var_9, 0);
            } else {
              i_saw_player(self, var_9, 0);
            }

            break;
          }
        }
      }
    }

    var_5 = undefined;
    var_7 = undefined;
    wait 0.1;
  }
}

function spotlight_angles_offset(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var_2 = 2000;
  var_3 = 0.6;
  var_4 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var_5 = self getapproxeyepos();

    foreach(var_7 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_7)) {
        var_8 = lengthsquared(var_7.origin - self.origin);
        var_9 = raritycammedium(self, var_7, var_2, var_0, var_3);

        if(var_8 < var_9 * var_9) {
          var_10 = self cansee(var_7);

          if(!var_10) {
            var_10 = scripts\engine\trace::ray_trace_passed(var_5, var_7 getEye(), [self, var_7], var_4);
          }

          if(var_10) {
            if(var_8 <= var_1) {
              getbestintersectionpt(self, var_7.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var_7, 0);
            } else {
              i_saw_player(self, var_7, 0);
            }

            break;
          }
        }
      }
    }

    var_3 = undefined;
    var_5 = undefined;
    wait 0.1;
  }
}

function raritycammedium(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_5 = 0.34202;
  } else {
    var_5 = cos(var_4);
  }

  var_6 = anglesToForward(var_1.angles);
  var_7 = var_2.origin - var_1.origin;
  var_7 = vectorNormalize(var_7);

  if(vectordot(var_6, var_7) < var_5) {
    var_3 *= var_5;
  }

  return var_3;
}

function raritycamwatch(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2)) {
    var_7 = 0.34202;
  } else {
    var_7 = cos(var_3);
  }

  var_8 = anglesToForward(var_1.angles);
  var_9 = length(var_2 vehicle_getvelocity());
  var_10 = var_5 + (var_4 - var_5) * min(1, 1 - (var_6 - var_9) / var_6);
  var_11 = var_2.origin - var_1.origin;
  var_12 = lengthsquared(var_11);
  var_11 = vectorNormalize(var_11);

  if(vectordot(var_8, var_11) < var_7) {
    var_10 *= var_7;
  }

  return var_10;
}

function watch_for_alarm_triggered() {
  level endon("weapons_free");
  self notify("watch_for_alarm_triggered");
  self endon("watch_for_alarm_triggered");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  level waittill("alarm_on");
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

function delay_enter_combat_after_stealth(var_0) {
  var_0 endon("death");
  var_0 endon("long_death");

  if(!istrue(var_0.ref_11E50)) {
    var_0.never_kill_off = 0;
    var_0.dontkilloff = 0;
  }

  var_0 scripts\cp\cp_modular_spawning::ref_12BC9();
  var_0 thread scripts\cp\cp_modular_spawning::enter_combat_after_stealth();
}

function open_scriptable_door_monitor(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("use_scriptable_door", var_1, var_0, var_2, var_3);

    if(var_2 == "door" && (var_3 == "right_90" || var_3 == "left_90")) {
      var_4 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy"));

      if(isDefined(var_4)) {
        scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
      }
    }
  }
}

function change_stealth_state_to(var_0, var_1) {
  level endon("weapons_free");
  var_0 notify("change_stealth_state_to", var_1);
  var_0 endon("change_stealth_state_to");
  var_0 endon("death");
  var_0 endon("enter_combat");
  exit_current_stealth_state(var_0);
  set_current_stealth_state(var_0, var_1);
  enter_current_stealth_state(var_0);
}

function exit_current_stealth_state(var_0) {
  var_0[[level.exit_stealth_state_func[get_current_stealth_state(var_0)]]](var_0);
}

function enter_current_stealth_state(var_0) {
  var_0[[level.enter_stealth_state_func[get_current_stealth_state(var_0)]]](var_0);
}

function set_current_stealth_state(var_0, var_1) {
  var_0.current_stealth_state = var_1;
}

function get_current_stealth_state(var_0) {
  return var_0.current_stealth_state;
}

function trial_trigger_think(var_0) {
  return isDefined(get_current_stealth_state(var_0));
}

function enter_casual(var_0) {
  var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("patrol");
  var_0 scripts\engine\utility::set_movement_speed(25);
}

function exit_casual(var_0) {}

function enter_alert(var_0) {
  var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("alert");
  var_0 scripts\engine\utility::set_movement_speed(25);
  thread stealth_meter_display_think(var_0);
  thread stealth_meter_degree_think(var_0);
}

function stealth_meter_display_think(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("enter_combat");
  var_0 endon("exit_stealth_think");

  for(;;) {
    var_0 waittill("display_stealth_meter_to", var_1);
    var_0.spawnposition = var_1;
    show_stealth_meter_to(var_1, var_0);
    thread ping_enemy_and_player_for_duration(var_1, var_0, var_1);
  }
}

function ping_enemy_and_player_for_duration(var_0, var_1, var_2) {
  var_1 notify("ping_enemy_and_player_for_duration");
  var_1 endon("disconnect");
  var_1 endon("ping_enemy_and_player_for_duration");

  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  thread ref_123C4(var_1);
  var_1 setscriptablepartstate("sixthsense", "loop");
  wait var_2;
  var_1 setscriptablepartstate("sixthsense", "neutral");
}

function stopsoundoncompletion(var_0) {
  wait lookupsoundlength(var_0);
  self.bplayingspecificstealthsound = undefined;
}

function increase_stealth_meter(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "alert") {
    var_2 = max(distancesquared(var_0.origin, var_1.origin), 1);
    var_3 = 1 / var_2 * 110889;

    if(var_0.stealth_meter_state == "decreasing") {
      var_0.target_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_3, 0, 1);
    } else {
      var_0.target_stealth_meter_progress = clamp(var_0.target_stealth_meter_progress + var_3, 0, 1);
    }

    var_0 notify("increase_stealth_meter");
    return;
  }
}

function decrease_stealth_meter(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "alert") {
    if(var_0.stealth_meter_state == "increasing") {
      var_0.target_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_1, 0, 1);
    } else {
      var_0.target_stealth_meter_progress = clamp(var_0.target_stealth_meter_progress + var_1, 0, 1);
    }

    var_0 notify("decrease_stealth_meter");
    return;
  }
}

function stop_stealth_meter(var_0) {
  var_0.target_stealth_meter_progress = var_0.current_stealth_meter_progress;
  var_0 notify("stop_stealth_meter");
}

function stealth_meter_degree_think(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("enter_combat");
  var_0 endon("exit_stealth_think");
  var_0.current_stealth_meter_progress = 0;
  var_0.target_stealth_meter_progress = 0;
  var_0.stealth_meter_state = "stopped";

  for(;;) {
    if(var_0.current_stealth_meter_progress == var_0.target_stealth_meter_progress) {
      var_0.stealth_meter_state = "stopped";
    } else {
      var_1 = min(0.2, abs(var_0.target_stealth_meter_progress - var_0.current_stealth_meter_progress));

      if(var_0.target_stealth_meter_progress > var_0.current_stealth_meter_progress) {
        var_0.stealth_meter_state = "increasing";
      } else {
        var_0.stealth_meter_state = "decreasing";
        var_1 *= -1;
      }

      var_0.current_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_1, 0, 0.99);

      if(getdvarint("scr_phj_disable_icons", 0) == 0) {
        objective_setprogress(var_0.stealth_meter_objective_id, var_0.current_stealth_meter_progress);
      }

      check_stealth_state_change(var_0);
    }

    var_2 = var_0 scripts\engine\utility::ref_143B9(0.1, "stop_stealth_meter");

    if(var_2 == "stop_stealth_meter") {
      var_0.target_stealth_meter_progress = var_0.current_stealth_meter_progress;
    }
  }
}

function check_stealth_state_change(var_0) {
  if(var_0.current_stealth_meter_progress >= 0.99) {
    var_1 = var_0.spawnposition.name;
    wait 0.1;
    getbestintersectionpt(var_0, var_0, var_1, "player_spotted");
    return;
  }
}

function exit_alert(var_0) {
  delete_stealth_meter(var_0);
}

function enter_combat(var_0) {
  var_0 endon("death");
  var_0 endon("enter_combat");

  if(!istrue(level.global_stealth_broken)) {
    stop_patrol(0);

    if(!ref_132C1(var_0)) {
      friendly_exit(var_0);
    }

    if(ref_132C5(var_0)) {
      thread logevent_spawnviaplayer(var_0);
    }

    thread global_stealth_broken(level);
    return;
  }
}

function ref_1215D(var_0) {
  var_1 = 5;
  scripts\cp\cp_outline::enable_outline_for_players(var_0, level.players, "snapshotgrenade", "high");
  var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["death"], var_1);
  scripts\cp\cp_outline::disable_outline_for_players(var_0, level.players);
}

function ref_132C1(var_0) {
  if(bomber_damage_thread(var_0)) {
    return 1;
  }

  if(istrue(var_0.ref_133B9)) {
    return 1;
  }

  if(isDefined(var_0.ref_132C2)) {
    return [[var_0.ref_132C2]](var_0);
  }

  if(!isDefined(level.bonusdeathplunderot)) {
    level.bonusdeathplunderot = [];
  }

  if(level.bonusdeathplunderot.size > max(2, level.players.size)) {
    return 1;
  }

  return 0;
}

function logevent_spawnviaplayer(var_0) {
  var_0 endon("death");
  var_1 = 3;
  waittillframeend();

  if(isDefined(var_0.ref_11BD5)) {
    logevent_challengeitemunlocked(var_0, var_0.ref_11BD5, &keypadscriptableused_altbunker);
  } else {
    logevent_challengeitemunlocked(var_0, "cellphone", &keypadscriptableused_altbunker);
  }

  wait var_1;
  var_0 notify("delete_reinforcement_icon");
}

function ref_132C5(var_0) {
  return true;
}

function bomber_damage_thread(var_0) {
  return var_0.agent_type == "actor_enemy_cp_rus_juggernaut";
}

function friendly_exit(var_0) {
  var_0.bcallingreinforcements = 1;
  level.ai_going_to_alarm = var_0;
  var_0 notify("alerted");
  GscBinSkip4(0x6e, var_0);
}

function modified_enter_combat(var_0) {
  if(istrue(self.aggressive) || istrue(self.dont_enter_combat)) {
    return;
  }

  self endon("death");
  level endon("game_ended");
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("combat");
  scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "outline_nodepth_green", "high");
  self.pacifist_override = undefined;
  self.scripted_mode = 0;
  self.entered_combat = 1;

  if(isDefined(self.script_radius)) {
    scripts\cp\cp_modular_spawning::set_goal_radius(self.script_radius);
  } else if(!istrue(self.is_on_platform)) {
    scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  } else {
    scripts\cp\cp_modular_spawning::set_goal_radius(512);
  }

  if(isDefined(self.script_goalheight)) {
    self.goalheight = self.script_goalheight;
  } else {
    self.goalheight = 256;
  }

  if(!scripts\cp\cp_modular_spawning::is_specified_unittype("suicidebomber") && !scripts\cp\cp_modular_spawning::is_specified_unittype("civilian")) {
    self.script_pacifist = undefined;
    self.pacifist = 0;
    thread scripts\cp\cp_modular_spawning::get_enemy_info_loop();
  }

  scripts\cp\cp_modular_spawning::run_combat_func();
  self notify("stop_going_to_node");
}

function goto_alarm_or_nearest_cover() {
  self endon("death");
  var_0 = undefined;

  if(isDefined(level.alarm_box_structs)) {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.alarm_box_structs, undefined, 1, 666);
  }

  if(!isDefined(level.ai_going_to_alarm)) {
    if(isDefined(var_0) && isarray(var_0) && var_0.size > 0) {
      logevent_challengeitemunlocked(self, "alert", &keypadscriptableused);
      self.ref_11BD6 = "alarm";
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("combat");
      self.scripted_mode = 1;
      thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::run_to_and_set_alarm(var_0[0]);
      level waittill("alarm_on");
      self.scripted_mode = 0;
      self notify("called_reinforcements");

      foreach(var_2 in var_0) {
        var_2 notify("stop_attracting");
      }

      foreach(var_5 in getaiarray("axis")) {
        if(isDefined(var_5.going_to_object)) {
          var_5.going_to_object = undefined;
          var_5.goalradius = 2048;
          var_5 scripts\cp\maps\cp_donetsk\milbase\ai_flare::clear_custom_anim();
        }
      }

      return;
    }

    return;
  }

  logevent_challengeitemunlocked(self, "alert", &keypadscriptableused);

  if(!isDefined(level.bonusdeathplunderot)) {
    level.bonusdeathplunderot = [];
  }

  level.bonusdeathplunderot[level.bonusdeathplunderot.size] = self;
  var_7 = self findbestcovernode("cover_default", 1, self.origin, 1);

  if(isDefined(var_7)) {
    var_8 = var_7.angles;
    var_9 = var_7.origin;

    if(!issubstr(var_7.type, "Prone")) {
      if(issubstr(var_7.type, "Left")) {
        var_8 += (0, 90, 0);
      } else if(issubstr(var_7.type, "Right") || issubstr(var_7.type, "Cover Crouch") || issubstr(var_7.type, "Conceal") || issubstr(var_7.type, "Cover Stand")) {
        var_8 -= (0, 90, 0);
      }
    }

    scripts\common\utility::demeanor_override("sprint");
    self setgoalnode(var_7);
    self waittill("goal");
    self setgoalpos(self.origin);
    wait 3;
    scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
    return;
  }

  var_7 = getclosestnodeinsight(self.origin);

  if(isDefined(var_7)) {
    scripts\common\utility::demeanor_override("sprint");
    self.scripted_mode = 1;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_7.origin);
    wait 1;
    self usecovernode(var_7, 1);
    self setgoalnode(var_7);
    wait 3;
    self.scripted_mode = 0;
    scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
    return;
  }

  wait 3;
  scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
}

function exit_combat(var_0) {}

function global_stealth_broken(var_0) {
  if(istrue(level.global_stealth_broken)) {
    return;
  }

  level endon("game_ended");
  level notify("weapons_free");
  level.global_stealth_broken = 1;
  level.battlechatterenabled = 1;
  level.ref_139B5 = 0;
  isenemyteamplayer();

  if(isDefined(level.select_boss_two_spawners)) {
    [[level.select_boss_two_spawners]](var_0);
  }

  thread play_combat_music_to_players();
}

function i_see_friendly_corpse_watcher(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("long_death");
  var_0 endon("enter_combat");

  if(!isDefined(level.enemy_ai_corpse_locations)) {
    level.enemy_ai_corpse_locations = [];
  }

  var_2 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);

  for(;;) {
    if(istrue(self.bcallingreinforcements)) {
      wait 1;
      continue;
    }

    foreach(var_4 in level.enemy_ai_corpse_locations) {
      if(distance(var_0.origin, var_4.loc) > var_0.sightmaxdistance) {
        wait 1;
        continue;
      }

      if(!var_0 scripts\engine\math::point_in_fov(var_4.loc, cos(50), 1)) {
        wait 1;
        continue;
      }

      var_5 = angleclamp180(vectortopitch(var_4.loc - var_0.origin));

      if(var_5 < var_0.upaimlimit || var_5 > var_0.downaimlimit) {
        wait 1;
        continue;
      }

      var_6 = scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_4.loc, [var_0], var_2);

      if(var_6) {
        if(istrue(var_1) && allow_to_get_to_corpse(var_4) && corpse_is_too_far_away(var_0, var_4.loc)) {
          level.num_time_getting_to_corpse[var_4.index]++;
          go_check_out_corpse(var_0, var_4, 1);
        }
      }

      wait 1;
    }

    wait 1;
  }
}

function go_check_out_corpse(var_0, var_1, var_2) {
  var_0 notify("checking_friendly_corpse");
  var_0.investigating_friendly_corpse = 1;
  thread change_stealth_state_to(var_0, var_0);
  show_stealth_meter_to_all_players(var_0, var_0);

  if(istrue(var_2)) {
    stop_patrol(var_0, 1);
    var_3 = vectorNormalize(var_0.origin - var_1.loc);
    var_4 = getclosestpointonnavmesh(var_1.loc + var_3 * 15);
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
    var_0 scripts\engine\utility::ref_143B9(15, "forever");
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_remove(level.enemy_ai_corpse_locations, var_1);
    check_around_the_area(var_0);
    return;
  }

  thread increase_stealth_meter_when_approaching_corpse(var_2, var_2);
  stop_patrol(var_2, 1);
  var_2 scripts\engine\utility::set_movement_speed(100);
  var_3 = vectorNormalize(var_2.origin - var_3.loc);
  var_4 = getclosestpointonnavmesh(var_3.loc + var_3 * 15);
  var_2 scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
  var_2 waittill("forever");
}

function stop_patrol(var_0) {
  var_1 = self;
  var_1 notify("stop_going_to_node");
  var_1 notify("patrol_using_cover_nodes");

  if(istrue(var_0)) {
    var_1 scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
    return;
  }
}

function show_stealth_meter_to_all_players(var_0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  foreach(var_2 in level.players) {
    show_stealth_meter_to(var_2, var_0);
  }
}

function increase_stealth_meter_when_approaching_corpse(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("enter_combat");
  var_2 = distancesquared(var_0.origin, var_1.loc) - 40000;

  for(var_3 = 0;; var_3 = var_6) {
    waitframe();
    var_4 = distancesquared(var_0.origin, var_1.loc);
    var_5 = clamp(1 - var_4 / var_2, 0, 1);
    var_6 = max(var_5, var_3 + 0.05);
    set_stealth_meter_progress(var_0, var_6);
  }
}

function allow_to_get_to_corpse(var_0) {
  if(!isDefined(level.num_time_getting_to_corpse)) {
    level.num_time_getting_to_corpse = [];
  }

  if(!isDefined(level.num_time_getting_to_corpse[var_0.index])) {
    level.num_time_getting_to_corpse[var_0.index] = 0;
  }

  return level.num_time_getting_to_corpse[var_0.index] < 1;
}

function corpse_is_too_far_away(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1) >= 90000;
}

function updateaisightonplayer(var_0) {
  self setclientomnvar("ui_edge_glow", var_0);
}

function sendout_notify_of_vehicle_kill(var_0, var_1) {
  foreach(var_3 in getaiarray("axis")) {
    if(isDefined(var_0) && var_3 == var_0) {
      continue;
    }

    var_3 notify("ai_events", var_1);
    waitframe();
  }
}

function turn_off_hours_later_chyron_text(var_0) {
  return true;
}

function watch_for_ai_events(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  waitframe();
  self notify("watch_for_ai_events");
  self endon("watch_for_ai_events");
  var_1 = 2000;
  jumpiffalse(isDefined(self.sightmaxdistance)) LOC_0000004a;
  var_1 = self.sightmaxdistance;

  for(;;) {
    self waittill("ai_events", var_2);

    if(istrue(self.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    var_3 = self getapproxeyepos();

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(!turn_off_hours_later_chyron_text(var_5)) {
        waitframe();
        continue;
      }

      if(scripts\cp\cp_modular_spawning::has_func_for_aievent(var_5.type)) {
        scripts\cp\cp_modular_spawning::run_aievent_func(var_5.type, var_2);
      }

      if(var_5.type == "enemy") {
        if(isDefined(var_5.entity) && isPlayer(var_5.entity)) {
          var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

          if(var_7) {
            if(istrue(var_5.entity.disguised)) {
              if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                continue;
              }
            } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
              waitframe();
              continue;
            }

            var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

            if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
              waitframe();
              continue;
            }

            var_5.type = "enemy_visible";
          } else {
            waitframe();
            continue;
          }
        } else {
          waitframe();
          continue;
        }
      }

      if(var_5.type == "footstep_sprint") {
        var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

        if(var_7) {
          if(istrue(var_5.entity.disguised)) {
            if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
              waitframe();
              continue;
            }
          } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
            waitframe();
            continue;
          }

          var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

          if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
            waitframe();
            continue;
          }
        }

        self setlookat(var_5.entity.origin, 1);
      } else if(var_5.type == "bulletwhizby" || var_5.type == "grenade danger" || var_5.type == "gunshot" || var_5.type == "vehicle_hit_me") {
        if(isPlayer(var_5.entity)) {
          if(var_5.type == "bulletwhizby") {
            if(!scripts\cp\killstreaks\init_cp::gastrap_dmg_trig(var_5.entity getcurrentweapon())) {
              continue;
            }
          }

          if(var_5.type == "vehicle_hit_me") {
            var_9 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);
            var_10 = isDefined(var_5.entity.vehicle) && self cansee(var_5.entity.vehicle) && sighttracepassed(var_3, var_5.entity.vehicle.origin, 0, self);

            if(var_9 || var_10) {
              if(istrue(var_5.entity.disguised)) {
                if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

              if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var_5.type = "vehicle_hit_me";
            }
          } else if(!istrue(self.stack_patch_waittill_context_patch) && var_5.entity scripts\cp\cp_weapon::player_has_silencer(var_5.entity getcurrentweapon())) {
            var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

            if(var_7) {
              if(istrue(var_5.entity.disguised)) {
                if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

              if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var_5.type = "shot_fired_seen";
            } else {
              var_5.type = "silenced_shot";
            }
          }
        }
      }

      switch (var_5.type) {
        case "enemy_visible":
          if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          } else {
            i_saw_player(self, var_5.entity, var_0);
          }

          break;
        case "shot_fired_notseen":
          if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          } else {
            i_saw_player(self, var_5.entity, var_0);
          }

          break;
        case "shot_fired_seen":
          if(distancesquared(self.origin, var_5.entity.origin) <= 10000) {
            thread play_enemy_radio_chat(level, processassist_regularcp());
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(did_anyone_see_this(self, var_5.entity.origin, var_1, 1, var_5.entity.origin)) {
            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          } else {
            i_saw_player(self, var_5.entity, var_0);
          }

          break;
        case "silenced_shot":
        case "vehicle_hit_me":
          if(did_anyone_see_this(self, var_5.origin, var_1, 1, var_5.origin)) {
            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          } else {
            i_saw_player(self, var_5.entity, var_0);
          }

          break;
        case "footstep_walk":
        case "footstep":
        case "footstep_sprint":
          var_9 = self cansee(var_5.entity) && sighttracepassed(self getEye(), var_5.entity getEye(), 0, self);

          if(var_9) {
            if(istrue(var_5.entity.disguised)) {
              if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                break;
              }
            }

            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          }

          break;
        case "break_stealth_with_no_damage":
        case "gunshot_teammate":
        case "gunshot":
        case "bulletwhizby":
        case "glass_destroyed":
        case "explode":
          if(istrue(self.compare_higher_score)) {
            waitframe();
            break;
          }

          thread play_enemy_radio_chat(level, processassist_regularcp());
          thread delay_enter_combat(self, var_5.type, var_5.entity);
          break;
        default:
          break;
      }
    }
  }
}

function vehicle_hit_event(var_0, var_1) {
  if(did_anyone_see_this(var_0, var_1, 2000, 1, var_1)) {
    return;
  }
}

function delay_enter_combat(var_0, var_1, var_2) {
  var_0 endon("death");
  self notify("watch_for_ai_events");

  if(!(isDefined(var_2) && isPlayer(var_2))) {
    var_2 = quickdropremoveselfrevivetokenfrominventory(var_0.origin, &quickdropremoveweaponfrominventory);
  }

  wait 0.75;
  getbestintersectionpt(var_0, var_0, var_2.name, "enemies_are_alerted");
}

function i_see_player_watcher(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("long_death");
  var_0 endon("enter_combat");
  thread seeing_player_time_tracker(var_0);
  jumpiftrue(isDefined(var_4)) LOC_0000003b;
  var_4 = 1024;

  for(;;) {
    var_0 waittill("known_event", var_5, var_6, var_7, var_8);

    if(istrue(var_0.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    if(player_in_concealment_area(var_5)) {
      continue;
    }

    var_9 = var_0.sightmaxdistance;
    var_9 *= var_5.perk_data["stealth_dist_scalar"];

    if(istrue(var_5.disguised)) {
      var_9 /= 6;
    }

    if(distance(var_0.origin, var_5.origin) > var_9) {
      waitframe();
      continue;
    }

    if(var_5.origin[2] - var_0.origin[2] > var_4) {
      waitframe();
      continue;
    }

    var_10 = angleclamp180(vectortopitch(var_5.origin - var_0.origin));

    if(var_10 < var_0.upaimlimit || var_10 > var_0.downaimlimit) {
      waitframe();
      continue;
    }

    var_11 = var_0 getapproxeyepos();
    var_12 = var_5 getEye();
    var_13 = anglesToForward(var_0.angles);
    var_14 = vectorNormalize(var_12 - var_11);
    var_15 = vectordot(var_14, var_13);

    if(var_15 < var_2) {
      waitframe();
      continue;
    }

    var_16 = 0;

    if(var_5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      if(scripts\engine\trace::ray_trace_passed(var_11, var_5.vehicle.origin, var_0, scripts\engine\trace::create_vehicle_contents())) {
        var_16 = 1;
      }
    } else {
      var_16 = var_0 cansee(var_5) && sighttracepassed(var_11, var_12, 0, var_0);
    }

    if(var_16) {
      if(distancesquared(var_0.origin, var_5.origin) <= var_3) {
        getbestintersectionpt(var_0, var_0, var_5.name, "player_spotted");
        continue;
      }

      if(get_current_stealth_state(self) != "alert") {
        enemy_ai_enter_alert(var_0, var_5, var_1);
        continue;
      }

      i_saw_player(var_0, var_5, var_1);
      LOC_00000219:
    }
    LOC_00000219:
  }
}

function i_saw_player(var_0, var_1, var_2) {
  var_0 notify("display_stealth_meter_to", var_1);
  mark_seen_this_player_this_frame(var_0, var_1);

  if(has_seen_any_player_long_enough_to_trigger_alert(var_0)) {
    enemy_ai_enter_alert(var_0, var_1, var_2);
  }

  increase_stealth_meter(var_0, var_1);
}

function display_combat_icon_to_player(var_0) {
  thread delay_delete_combat_icon(var_0);

  foreach(var_2 in level.players) {
    show_combat_icon_to(var_2, var_0);
  }
}

function logevent_challengeitemunlocked(var_0, var_1, var_2) {
  var_0.ref_12B4C = var_1;

  foreach(var_4 in level.players) {
    ref_13336(var_4, var_0, var_2);
  }
}

function keypadscriptableused(var_0, var_1, var_2) {
  var_3 = var_2 getentitynumber();
  var_4 = var_2 scripts\engine\utility::waittill_any_ents_return(var_2, "death", var_2, "called_reinforcements", level, "weapons_free");
  laser_func(var_0, var_1, var_2, var_3);
}

function keypadscriptableused_altbunker(var_0, var_1, var_2) {
  var_3 = var_2 getentitynumber();
  var_4 = var_2 scripts\engine\utility::waittill_any_ents_return(var_2, "death", var_2, "delete_reinforcement_icon");
  laser_func(var_0, var_1, var_2, var_3);
}

function delay_delete_combat_icon(var_0) {
  var_0 endon("death");
  wait 3;
  delete_combat_icon(var_0);
}

function get_player_with_player_id(var_0) {
  foreach(var_2 in level.players) {
    var_3 = var_2 getentitynumber();

    if(var_3 == var_0) {
      return var_2;
    }
  }
}

function enemy_ai_enter_alert(var_0, var_1, var_2, var_3, var_4) {
  if(get_current_stealth_state(var_0) != "alert") {
    if(isDefined(var_1) && isPlayer(var_1)) {
      display_warning_message_to_player(var_1, var_3);
    }

    thread change_stealth_state_to(var_0, var_0);

    if(istrue(var_2)) {
      thread select_bunker_interior_one_spawners(var_0, var_0, var_1, var_4);
      return;
    }

    return;
  }
}

function propwaitminigamerun(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0)) {
    var_1 = var_0.name;
    return;
  }

  var_1 = var_0.owner.name;
}

function select_bunker_interior_one_spawners(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("enter_combat");
  thread play_enemy_radio_chat(level, processlobbydataforclient());
  var_0 notify("basic_combat");
  waitframe();
  var_0.goalradius = 128;
  stop_patrol(var_0, 1);
  var_0 scripts\engine\utility::set_movement_speed(75);
  var_0 scripts\cp\cp_modular_spawning::set_goal_pos(get_investigate_loc(var_0, var_1.origin));
  var_0 waittill("goal");

  if(isDefined(var_2) && [[var_2]](var_1)) {
    thread kickplayersatcircleedge(var_0, var_0);
  }

  check_around_the_area(var_0);
  thread play_enemy_radio_chat(level, prevbrbonusxp());
  thread change_stealth_state_to(var_0, var_0);
  var_0 scripts\cp\cp_modular_spawning::start_patrol();
}

function kickplayersatcircleedge(var_0, var_1) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 endon("death");
  var_0 endon("enter_combat");
  logevent_challengeitemunlocked(var_0, "alert", &keypadscriptableused);
  wait 3;
  getbestintersectionpt(var_0, var_0, var_1, "enemies_are_alerted");
}

function play_enemy_radio_chat(var_0, var_1) {
  if(isDefined(var_1) && isai(var_1) && isalive(var_1)) {
    var_1 notify("play_enemy_radio_chat");
    var_1 endon("play_enemy_radio_chat");
    var_1 endon("death");
    var_1.trucks_intel_sequence = 1;
    var_1 playsoundonmovingent(var_0);
    wait lookupsoundlength(var_0) / 1000;
    var_1.trucks_intel_sequence = 0;
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "allies");
  wait lookupsoundlength(var_0) / 1000;
  play_enemy_radio_beep();
}

function play_enemy_radio_beep() {
  foreach(var_1 in level.players) {
    var_1 playlocalsound("weap_uav_radio_button_npc_cp");
  }

  wait lookupsoundlength("weap_uav_radio_button_npc_cp") / 1000;
}

function get_investigate_loc(var_0, var_1) {
  var_2 = vectorNormalize(var_0.origin - var_1);
  var_3 = var_1 + var_2 * randomfloatrange(75, 125);
  return getclosestpointonnavmesh(var_3);
}

function check_around_the_area(var_0) {
  wait randomfloatrange(0.75, 1.5);

  if(istrue(var_0.using_goto_node)) {
    if(isDefined(var_0.currentnode)) {
      var_0 thread scripts\cp\cp_modular_spawning::go_to_node(var_0.currentnode);
      return;
    }

    return;
  }

  var_1 = randomintrange(2, 4);
  var_0 scripts\cp\cp_modular_spawning::set_goal_radius(36);
  var_0 scripts\engine\utility::set_movement_speed(25);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var_4 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var_5 = (var_0.origin[0] + var_3, var_0.origin[1] + var_4, var_0.origin[2]);
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(getclosestpointonnavmesh(var_5));
    var_0 scripts\engine\utility::waittill_notify_or_timeout("goal", 5);
    wait randomfloatrange(0.75, 1.5);
  }

  var_0 scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function display_warning_message_to_player(var_0, var_1) {
  if(!isDefined(var_0.next_warning_message_time)) {
    var_0.next_warning_message_time = 0;
  }

  var_2 = gettime();

  if(var_2 > var_0.next_warning_message_time) {
    var_0.next_warning_message_time = var_2 + 1000;
    return;
  }
}

function has_seen_any_player_long_enough_to_trigger_alert(var_0) {
  return has_seen_any_player_long_enough(var_0, 0.1);
}

function has_seen_any_player_long_enough(var_0, var_1) {
  foreach(var_3 in var_0.time_seeing_players) {
    if(var_3 >= var_1) {
      return true;
    }
  }

  return false;
}

function mark_seen_this_player_this_frame(var_0, var_1) {
  var_0.player_most_recently_saw = var_1;
  var_2 = var_1 getentitynumber();

  if(!isDefined(var_0.time_seeing_players)) {
    thread seeing_player_time_tracker(var_0);
  }

  if(!isDefined(var_0.time_seeing_players[var_2])) {
    var_0.time_seeing_players[var_2] = 0;
    return;
  }
}

function ref_14458() {
  level endon("game_ended");
  self notify("watch_for_level_weapons_free");
  self endon("watch_for_level_weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  level waittill("weapons_free");
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  self aieventlistenerevent("combat", self, self.origin);
}

function seeing_player_time_tracker(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 notify("seeing_player_time_tracker");
  var_0 endon("seeing_player_time_tracker");
  var_0 endon("death");
  var_0 endon("long_death");
  var_0 endon("enter_combat");
  var_0.player_most_recently_saw = undefined;
  var_0.time_seeing_players = [];
  var_1 = 0;

  for(;;) {
    if(isDefined(var_0.player_most_recently_saw)) {
      var_1 = 0;
    } else {
      var_1 += 0.1;
    }

    foreach(var_4, var_3 in var_0.time_seeing_players) {
      if(isDefined(var_0.player_most_recently_saw) && var_4 == var_0.player_most_recently_saw getentitynumber()) {
        var_0.time_seeing_players[var_4] += 0.1;
        var_0.player_most_recently_saw = undefined;
        continue;
      }

      var_0.time_seeing_players[var_4] = max(var_0.time_seeing_players[var_4] - 0.05, 0);
    }

    foreach(var_6 in level.players) {
      var_4 = var_6 getentitynumber();

      if(isDefined(var_0.time_seeing_players[var_4]) && var_0.time_seeing_players[var_4] == 0) {
        hide_stealth_meter_from(var_6, var_0);
      }
    }

    if(var_1 >= 0.5) {
      stop_stealth_meter(var_0);
    }

    wait 0.1;
  }
}

function player_in_concealment_area(var_0) {
  return istrue(var_0.tracking_munitions_purchase);
}

function ref_11A86(var_0, var_1) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(sg_respawn(var_0)) {
    return;
  }

  var_2 = ragdoll_on_vehicle_death(var_0);
  var_3 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_3, var_2);
  addclienttoheadiconmask(var_3, 10);
  setheadicondrawthroughgeo(var_3, 0);
  setheadiconzoffset(var_3, 1);
  setheadiconsnaptoedges(var_3, 5000);
  setheadiconmaxdistance(var_3, 500);
  var_4 = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + var_0 getentitynumber(), 22);
  objective_state(var_4, "active");
  objective_icon(var_4, var_2);
  objective_setbackground(var_4, 1);
  objective_removeallfrommask(var_4);
  objective_setplayoutro(var_4, 0);
  objective_setshowdistance(var_4, 0);
  objective_setshowprogress(var_4, 0);
  objective_setfadedisabled(var_4, 1);
  objective_sethot(var_4, 1);
  objective_setpulsate(var_4, 1);
  objective_setshowoncompass(var_4, 1);
  objective_onentity(var_4, var_0);
  var_0 thread[[var_1]](var_4, var_3, var_0);
  var_0.ref_12B4A = var_4;
}

function ragdoll_on_vehicle_death(var_0) {
  switch (var_0.ref_12B4C) {
    case "alert":
      return "hud_alert";
    case "alarm":
      return "hud_icon_head_tacops_alarm";
    case "cellphone":
      return "hud_icon_head_tacops_cellphone";
    case "head_marked":
      return "hud_icon_esc_bounty_target";
  }
}

function ref_11A7B(var_0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(has_combat_icon(var_0)) {
    return;
  }

  var_1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + var_0 getentitynumber(), 22);
  objective_state(var_1, "active");
  objective_icon(var_1, "hud_icon_stealth");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  objective_sethot(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  var_0.combat_icon_objective_id = var_1;
}

function make_stealth_meter_on_ai(var_0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(has_stealth_meter(var_0)) {
    return;
  }

  var_1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_stealth_ID_" + var_0 getentitynumber(), 21);
  objective_state(var_1, "active");
  objective_icon(var_1, "hud_icon_stealth");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 1);
  objective_setprogress(var_1, 0);
  objective_setfadedisabled(var_1, 1);
  objective_sethot(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  var_0.showing_the_stealth_meter_to_players = [];
  var_0.stealth_meter_objective_id = var_1;
  thread clear_up_stealth_meter_when_enter_combat(var_0);
}

function clear_up_stealth_meter_when_enter_combat(var_0) {
  var_0 endon("death");
  var_0 waittill("enter_combat");
  delete_stealth_meter(var_0);
}

function show_stealth_meter_to(var_0, var_1) {
  if(!has_stealth_meter(var_1)) {
    make_stealth_meter_on_ai(var_1);
  }

  if(is_showing_stealth_meter_to(var_0, var_1)) {
    return;
  }

  var_1.showing_the_stealth_meter_to_players[var_1.showing_the_stealth_meter_to_players.size] = var_0;
  objective_addclienttomask(var_1.stealth_meter_objective_id, var_0);
}

function show_combat_icon_to(var_0, var_1) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(!has_combat_icon(var_1)) {
    ref_11A7B(var_1);
  }

  objective_addclienttomask(var_1.combat_icon_objective_id, var_0);
}

function ref_13336(var_0, var_1, var_2) {
  if(istrue(level.little_bird_mg_handleflarerecharge)) {
    return;
  }

  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(!sg_respawn(var_1)) {
    ref_11A86(var_1, var_2);
  }

  objective_addclienttomask(var_1.ref_12B4A, var_0);
}

function set_stealth_meter_progress(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "alert") {
    var_0.target_stealth_meter_progress = var_1;
    return;
  }
}

function hide_stealth_meter_from(var_0, var_1) {
  if(!has_stealth_meter(var_1)) {
    return;
  }

  if(!is_showing_stealth_meter_to(var_0, var_1)) {
    return;
  }

  var_1.showing_the_stealth_meter_to_players = scripts\engine\utility::array_remove(var_1.showing_the_stealth_meter_to_players, var_0);
  objective_removeclientfrommask(var_1.stealth_meter_objective_id, var_0);

  if(var_1.showing_the_stealth_meter_to_players.size == 0) {
    var_1.spawnposition = undefined;
    return;
  }
}

function is_showing_stealth_meter_to(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.showing_the_stealth_meter_to_players, var_0);
}

function has_stealth_meter(var_0) {
  return isDefined(var_0.stealth_meter_objective_id);
}

function has_combat_icon(var_0) {
  return isDefined(var_0.combat_icon_objective_id);
}

function sg_respawn(var_0) {
  return isDefined(var_0.ref_12B4A);
}

function delete_stealth_meter(var_0) {
  if(has_stealth_meter(var_0)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_stealth_ID_" + var_0 getentitynumber());
    objective_delete(var_0.stealth_meter_objective_id);
    var_0.stealth_meter_objective_id = undefined;
    var_0 notify("exit_stealth_think");
    return;
  }
}

function delete_combat_icon(var_0) {
  if(has_combat_icon(var_0)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_combat_ID_" + var_0 getentitynumber());
    objective_delete(var_0.combat_icon_objective_id);
    var_0.combat_icon_objective_id = undefined;
    var_0 notify("exit_stealth_think");
    return;
  }
}

function laser_func(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_objectives::freeworldid("enemy_AI_reinforcement_ID_" + var_3);
  objective_delete(var_0);
  var_2.ref_12B4A = undefined;
  setheadiconimage(var_1);
  var_2 notify("exit_stealth_think");
}

function did_anyone_see_this(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getaiarray("axis");
  var_7 = var_2 * var_2;

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = var_1;
  }

  var_8 = 3;
  var_9 = 0;

  foreach(var_11 in var_6) {
    if(var_0 == var_11) {
      if(!isDefined(var_0.times_hit)) {
        var_0.times_hit = 1;
      } else {
        var_0.times_hit++;
      }

      if(var_0.times_hit > 1) {
        return true;
      } else {
        continue;
      }
    }

    if(!isalive(var_11)) {
      continue;
    }

    var_12 = distancesquared(var_11.origin, var_1);

    if(var_12 > var_7) {
      continue;
    }

    if(isDefined(var_5) && var_12 <= var_5 * var_5) {
      continue;
    }

    if(!var_11 hastacvis(var_4, var_3)) {
      if(var_3 && !var_11 aipointinfov(var_1)) {
        continue;
      }

      var_9++;

      if(var_9 > var_8) {
        waitframe();
        var_9 = 0;
      }

      if(!sighttracepassed(var_11 getEye(), var_1, 0, var_0)) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function increase_script_maxdist(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_6.script_maxdist = 20000;
  }
}

function flash_crate_update_hint_logic_alt() {
  level.flash_icon_extraction = 0;
  var_0 = 2;
  level.flash_group = getEnt("bush_trig", "targetname");
  level.flashbang_ai = [];
  var_1 = scripts\engine\utility::getStructArray("bush_zone", "targetname");
  var_2 = scripts\engine\utility::getStructArray("bush_struct", "targetname");

  if(!isDefined(level.flash_group)) {
    return;
  }

  var_3 = gettime();

  foreach(var_5 in var_1) {
    var_6 = [];
    var_7 = var_5.origin;
    var_8 = var_5.radius * var_5.radius;

    foreach(var_10 in var_2) {
      if(!isDefined(var_10) || istrue(var_10.should_break_stealth_immediately_func)) {
        continue;
      }

      if(scripts\engine\utility::distance_2d_squared(var_10.origin, var_7) < var_8) {
        var_6 = [var_10.origin, (var_10.radius + var_0) * (var_10.radius + var_0)];
        var_10.should_break_stealth_immediately_func = 1;
      }
    }

    level.flashbang_ai[level.flashbang_ai.size] = [var_7, var_8, var_6];
  }

  scripts\engine\utility::deletestructarray("bush_zone", "targetname");
  scripts\engine\utility::deletestructarray("bush_struct", "targetname");
  thread ref_124B6();
}

function ref_124B6() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    thread ref_11CD6(var_1);
  }

  thread flash_crate_use();
}

function flash_crate_use() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    thread ref_11CD6(var_0);
  }
}

function ref_11CD6(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 100;
  var_2 = 0.1;

  for(;;) {
    wait var_2;
    var_0.tracking_munitions_purchase = 0;

    if(var_0 istouching(level.flash_group)) {
      var_0.tracking_munitions_purchase = 1;
      continue;
    }

    var_3 = propcircleindex(var_0);

    if(!isDefined(var_3)) {
      continue;
    }

    foreach(var_5 in var_3[2]) {
      var_6 = var_5[0];
      var_7 = var_5[1];

      if(scripts\engine\utility::distance_2d_squared(var_6, var_0.origin) < var_7 && abs(var_6[2] - var_0.origin[2]) < var_1) {
        var_0.tracking_munitions_purchase = 1;
      }
    }
  }
}

function propcircleindex(var_0) {
  foreach(var_2 in level.flashbang_ai) {
    if(scripts\engine\utility::distance_2d_squared(var_0.origin, var_2[0]) < var_2[1]) {
      return var_2;
    }
  }

  return undefined;
}

function tryspawnscriptableparenting() {
  if(!scripts\engine\utility::flag_exist("stealth_settings_activated")) {
    return 0;
  }

  return scripts\engine\utility::flag("stealth_settings_activated");
}

function attachdrill() {
  setDvar("ai_eventDistExplosion", 2048);
  setDvar("ai_eventDistGunShot", 1024);
  setDvar("ai_eventDistFootstep", 128);
  setDvar("ai_eventDistFootstepWalk", 64);
  setDvar("ai_eventDistFootstepSprint", 200);
  scripts\engine\utility::flag_set("stealth_settings_activated");
  thread serverroomtvs();
  thread ref_12665();
  thread ref_12655();
}

function ref_12655() {
  level endon("game_ended");
  level endon("weapons_free");
  level notify("players_grenade_fire_monitor");
  level endon("players_grenade_fire_monitor");

  foreach(var_1 in level.players) {
    thread ref_124A7(var_1);
  }

  for(;;) {
    level waittill("connected", var_1);
    thread killstreak_createobjective_engineer(var_1);
  }
}

function killstreak_createobjective_engineer(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 scripts\engine\utility::ref_143A5("loadout_given", "start_hotjoining_via_c130");
  thread ref_124A7(var_0);
}

function ref_124A7(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 notify("player_grenade_fire_monitor");
  var_0 endon("player_grenade_fire_monitor");

  for(;;) {
    var_0 waittill("grenade_fire");
    var_0.waittill_any_timeout_no_endon_death_2 = gettime();
  }
}

function quit_game_in() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(var_3.waittill_any_timeout_no_endon_death_2) && var_3.waittill_any_timeout_no_endon_death_2 > var_1) {
      var_0 = var_3;
      var_1 = var_3.waittill_any_timeout_no_endon_death_2;
    }
  }

  return var_0;
}

function ref_12665() {
  level endon("game_ended");
  level endon("weapons_free");
  level notify("players_weapon_fired_monitor");
  level endon("players_weapon_fired_monitor");

  foreach(var_1 in level.players) {
    thread ref_12506(var_1);
  }

  for(;;) {
    level waittill("connected", var_1);
    thread killstreak_loadout_state(var_1);
  }
}

function killstreak_loadout_state(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 scripts\engine\utility::ref_143A5("loadout_given", "start_hotjoining_via_c130");
  thread ref_12506(var_0);
}

function ref_12506(var_0) {
  level endon("game_ended");
  level endon("weapons_free");
  var_0 notify("player_weapon_fired_monitor");
  var_0 endon("player_weapon_fired_monitor");

  for(;;) {
    var_0 waittill("weapon_fired");
    var_0.waittill_player_dropkit_crate_used = gettime();
  }
}

function quickdropremoveselfrevivetokenfrominventory(var_0, var_1) {
  var_2 = [[var_1]]();

  if(isDefined(var_2)) {
    return var_2;
  }

  return projectiledeleteonnote(var_0);
}

function projectiledeleteonnote(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator") {
      continue;
    }

    var_1 = var_3;
  }

  return scripts\engine\utility::getclosest(var_0, var_1);
}

function quickdropremoveweaponfrominventory() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(var_3.waittill_player_dropkit_crate_used) && var_3.waittill_player_dropkit_crate_used > var_1) {
      var_0 = var_3;
      var_1 = var_3.waittill_player_dropkit_crate_used;
    }
  }

  return var_0;
}

function isenemyteamplayer() {
  setDvar("ai_eventDistExplosion", 1024);
  setDvar("ai_eventDistGunShot", 1024);
  setDvar("ai_eventDistGlassDestroyed", 384);
  setDvar("ai_eventDistFootstep", 256);
  setDvar("ai_eventDistFootstepWalk", 128);
  setDvar("ai_eventDistFootstepSprint", 400);
  scripts\engine\utility::flag_clear("stealth_settings_activated");
}

function serverroomtvs() {
  level endon("stealth_settings_activated");
  level endon("game_ended");

  for(;;) {
    level waittill("grenade_exploded_during_stealth", var_0, var_1, var_2);

    switch (var_1) {
      case "claymore_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 1);
        break;
      case "suicide_vest":
        thread ref_11E31(level, 4194304, 2, var_0, 1);
        break;
      case "frag_grenade_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 1);
        break;
      case "molotov_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 1);
        break;
      case "c4_mp_p":
        thread ref_11E31(level, 4194304, 2, var_0, 1);
        break;
      case "semtex_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 1.8);
        break;
      case "throwingknife_mp":
        ref_11E32(1048576, 1, var_0, var_1, &ref_132D1, var_2);
        break;
      case "at_mine_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 0.6);
        break;
      case "thermite_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 0.6);
        break;
      case "flash_grenade_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 0.6);
        break;
      case "concussion_grenade_mp":
        thread ref_11E31(level, 4194304, 2, var_0, 0.75);
        break;
      case "smoke_grenade_mp":
        ref_11E32(4194304, 2, var_0, var_1, &ref_132CF, var_2);
        break;
      case "snapshot_grenade_mp":
        ref_11E32(4194304, 2, var_0, var_1, &ref_132D0, var_2);
        break;
      case "gas_mp":
        ref_11E32(4194304, 2, var_0, var_1, &ref_132CE, var_2);
        break;
      case "decoy_grenade_mp":
        ref_11E32(9437184, 2, var_0, var_1, &ref_132CD, var_2);
        break;
      default:
        return;
    }
  }
}

function ref_11E31(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    if(isvector(var_2)) {
      var_5 = quickdropremoveselfrevivetokenfrominventory(var_2, &quit_game_in);
    } else {
      var_5 = quickdropremoveselfrevivetokenfrominventory(var_3.origin, &quit_game_in);
    }

    var_5 = var_5.name;
  }

  wait var_4;

  if(isvector(var_3)) {
    var_6 = prematchloadoutindex(var_3, var_1, var_2);
  } else {
    var_6 = prematchloadoutindex(var_4.origin, var_2, var_3);
  }

  foreach(var_8 in var_6) {
    if(isDefined(get_current_stealth_state(var_8))) {
      getbestintersectionpt(var_8, var_8, var_6, "enemies_are_alerted");
    }
  }
}

function ref_11E32(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = prematchloadoutindex(var_2.origin, var_0, var_1);

  foreach(var_8 in var_6) {
    if(trial_trigger_think(var_8)) {
      next_mortar_vo(var_8, var_2, var_3, var_4, var_5);
    }
  }
}

function next_mortar_vo(var_0, var_1, var_2, var_3, var_4) {
  if(get_current_stealth_state(var_0) != "alert") {
    thread change_stealth_state_to(var_0, var_0);
  }

  thread select_bunker_interior_one_spawners(var_0, var_0, var_1, var_3);
}

function prematchloadoutindex(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = getaiarray("axis");

  foreach(var_7 in var_5) {
    if(distancesquared(var_0, var_7.origin) <= var_1) {
      var_4 = var_7;
    }
  }

  var_4 = sortbydistance(var_4, var_0);
  var_9 = int(min(var_4.size, var_2));

  for(var_10 = 0; var_10 < var_9; var_10++) {
    var_3 = var_4[var_10];
  }

  return var_3;
}

function ref_132D1(var_0) {
  return false;
}

function ref_132D0(var_0) {
  return false;
}

function ref_132CF(var_0) {
  return isDefined(var_0);
}

function ref_132CE(var_0) {
  return isDefined(var_0);
}

function ref_132CD(var_0) {
  return isDefined(var_0);
}

function ref_129FD() {
  var_0 = ["mus_cp_stealth_1", "mus_cp_stealth_2", "mus_cp_stealth_3", "mus_cp_stealth_4", "mus_cp_stealth_5", "mus_cp_stealth_6"];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  level.ref_13894 = var_0;
  level.ref_13895 = 0;
}

function rear_spawn_type_adjuster() {
  var_0 = level.ref_13894[level.ref_13895];
  level.ref_13895++;

  if(level.ref_13895 == level.ref_13894.size - 1) {
    ref_129FD();
  }

  return var_0;
}

function ref_129FE() {
  var_0 = ["mus_cp_stealth_broken_1", "mus_cp_stealth_broken_2", "mus_cp_stealth_broken_3", "mus_cp_stealth_broken_4", "mus_cp_stealth_broken_5", "mus_cp_stealth_broken_6"];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  level.ref_13896 = var_0;
  level.ref_13897 = 0;
}

function rear_spotlight_angles_offset() {
  var_0 = level.ref_13896[level.ref_13897];
  level.ref_13897++;

  if(level.ref_13897 == level.ref_13896.size - 1) {
    ref_129FE();
  }

  return var_0;
}

function ref_123C4(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("play_alert_music_to_player");
  var_0 endon("play_alert_music_to_player");
  var_1 = 3;

  if(!isDefined(var_0.ref_1273E)) {
    var_2 = rear_spawn_type_adjuster();
    var_0.ref_1273E = var_2;
    scripts\cp\utility::ref_123FE(var_2, var_0);
  }

  var_3 = level scripts\engine\utility::ref_143B9(var_1, "weapons_free");
  var_0.ref_1273E = undefined;
  var_0 setplayermusicstate("");
}

function play_combat_music_to_players() {
  scripts\cp\utility::ref_123FE(rear_spotlight_angles_offset(), level.players);
}

function getbestintersectionpt(var_0, var_1, var_2) {
  var_0.ref_124D1 = var_1;
  var_0.ref_12A6E = var_2;
  thread change_stealth_state_to(var_0, var_0);
}

function logloadoutcopy(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.name == var_0.ref_124D1) {
      logevent_playerregen(var_2, var_0.ref_12A6E);
      continue;
    }

    logevent_servermatchend(var_2, var_0.ref_124D1, var_0.ref_12A6E);
  }
}

function logevent_playerregen(var_0, var_1) {
  switch (var_1) {
    case "enemies_are_alerted":
      var_0 iprintlnbold("^1You ^7have alerted the enemies");
      break;
    case "player_spotted":
      var_0 iprintlnbold("^1You ^7have been spotted by the enemies");
      break;
  }
}

function logevent_servermatchend(var_0, var_1, var_2) {
  switch (var_2) {
    case "enemies_are_alerted":
      var_0 iprintlnbold("^1" + var_1 + "^7 has alerted the enemies");
      break;
    case "player_spotted":
      var_0 iprintlnbold("^1" + var_1 + "^7 has been spotted by the enemies");
      break;
  }
}

function ref_134E4() {
  level notify("sp_stealth_broken_listener");
  level endon("sp_stealth_broken_listener");

  if(weapon_xp_iw8_sn_kilo98()) {
    while(!(isDefined(level.stealth) && isDefined(level.stealth.groupdata))) {
      wait 0.25;
    }

    for(;;) {
      if(scripts\stealth\manager::anyone_in_combat()) {
        thread global_stealth_broken();
        return;
      }

      wait 0.25;
    }

    return;
  }
}

function prevbrbonusxp() {
  return scripts\engine\utility::random(["dx_cst_aq1_alert_callin_10", "dx_cst_aq2_alert_callin_10", "dx_cst_aq3_alert_callin_10", "dx_cst_aq4_alert_callin_10"]);
}

function processlobbydataforclient() {
  return scripts\engine\utility::random(["dx_cst_aq1_investigate_callin_10", "dx_cst_aq2_investigate_callin_10", "dx_cst_aq3_investigate_callin_10", "dx_cst_aq4_investigate_callin_10"]);
}

function raid_objective_cleanup_func() {
  return scripts\engine\utility::random(["dx_cst_aq1_seek_backup_10", "dx_cst_aq2_seek_backup_10", "dx_cst_aq3_seek_backup_10", "dx_cst_aq4_seek_backup_10"]);
}

function processassist_regularcp() {
  return scripts\engine\utility::random(["dx_cst_aq1_bulletwhizby_generic_10", "dx_cst_aq2_bulletwhizby_generic_10", "dx_cst_aq3_bulletwhizby_generic_10", "dx_cst_aq4_bulletwhizby_generic_10"]);
}

function receivingampeddamage() {
  return scripts\engine\utility::random(["dx_cst_aq1_coverblown_generic_10", "dx_cst_aq2_coverblown_generic_10", "dx_cst_aq3_coverblown_generic_10", "dx_cst_aq4_coverblown_generic_10"]);
}

function prematchmusic() {
  var_0 = ["dx_cst_aq1_alert_reset_10", "dx_cst_aq2_alert_reset_10", "dx_cst_aq3_alert_reset_10", "dx_cst_aq4_alert_reset_10"];
  return var_0[randomint(var_0.size)];
}

function puddle_structs() {
  var_0 = ["dx_cst_aq1_investigate_generic_10", "dx_cst_aq2_investigate_generic_10", "dx_cst_aq3_investigate_generic_10", "dx_cst_aq4_investigate_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propane_detonate_fiery_drips() {
  var_0 = ["dx_cst_aq1_coverblown_generic_10", "dx_cst_aq2_coverblown_generic_10", "dx_cst_aq3_coverblown_generic_10", "dx_cst_aq4_coverblown_generic_10"];
  return var_0[randomint(var_0.size)];
}

function projectileimpactthermite() {
  var_0 = ["dx_cst_aq1_combat_generic_10", "dx_cst_aq2_combat_generic_10", "dx_cst_aq3_combat_generic_10", "dx_cst_aq4_combat_generic_10"];
  return var_0[randomint(var_0.size)];
}

function raritycamlarge() {
  var_0 = ["dx_cst_aq1_sight_generic_10", "dx_cst_aq2_sight_generic_10", "dx_cst_aq3_sight_generic_10", "dx_cst_aq4_sight_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propnumclones() {
  var_0 = ["dx_cst_aq1_explosion_generic_10", "dx_cst_aq2_explosion_generic_10", "dx_cst_aq3_explosion_generic_10", "dx_cst_aq4_explosion_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propwaitminigamehudsetpoint() {
  var_0 = ["dx_cst_aq1_grenade_danger_10", "dx_cst_aq2_grenade_danger_10", "dx_cst_aq3_grenade_danger_10", "dx_cst_aq4_grenade_danger_10"];
  return var_0[randomint(var_0.size)];
}

function ray_trace_trigger_radius_2d() {
  var_0 = ["dx_cst_aq1_silenced_shot_10", "dx_cst_aq2_silenced_shot_10", "dx_cst_aq3_silenced_shot_10", "dx_cst_aq4_silenced_shot_10"];
  return var_0[randomint(var_0.size)];
}

function propwatchcleanupondisconnect() {
  var_0 = ["dx_cst_aq1_gunshot_generic_10", "dx_cst_aq2_gunshot_generic_10", "dx_cst_aq3_gunshot_generic_10", "dx_cst_aq4_gunshot_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propwatchcleanuponroundend() {
  var_0 = ["dx_cst_aq1_gunshot_teammate_10", "dx_cst_aq2_gunshot_teammate_10", "dx_cst_aq3_gunshot_teammate_10", "dx_cst_aq4_gunshot_teammate_10"];
  return var_0[randomint(var_0.size)];
}

function pressure_timeout() {
  var_0 = ["dx_cst_aq1_ally_killed_10", "dx_cst_aq2_ally_killed_10", "dx_cst_aq3_ally_killed_10", "dx_cst_aq4_ally_killed_10"];
  return var_0[randomint(var_0.size)];
}

function race_set_player_safe() {
  var_0 = ["dx_cst_aq1_proximity_generic_10", "dx_cst_aq2_proximity_generic_10", "dx_cst_aq3_proximity_generic_10", "dx_cst_aq4_proximity_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propsizetext() {
  var_0 = ["dx_cst_aq1_footstep_generic_10", "dx_cst_aq2_footstep_generic_10", "dx_cst_aq3_footstep_generic_10", "dx_cst_aq4_footstep_generic_10"];
  return var_0[randomint(var_0.size)];
}

function propspawnorigin() {
  var_0 = ["dx_cst_aq1_footstep_sprint_10", "dx_cst_aq2_footstep_sprint_10", "dx_cst_aq3_footstep_sprint_10", "dx_cst_aq4_footstep_sprint_10"];
  return var_0[randomint(var_0.size)];
}

function recent_spawn_threshold() {
  var_0 = ["dx_cst_aq1_team_inquiry_10", "dx_cst_aq2_team_inquiry_10", "dx_cst_aq3_team_inquiry_10", "dx_cst_aq4_team_inquiry_10"];
  return var_0[randomint(var_0.size)];
}

function put_passenger_in_truck() {
  var_0 = ["dx_cst_aq1_lost_sight_10", "dx_cst_aq2_lost_sight_10", "dx_cst_aq3_lost_sight_10", "dx_cst_aq4_lost_sight_10"];
  return var_0[randomint(var_0.size)];
}

function proximity_explode() {
  var_0 = ["dx_cst_aq1_hunt_firstlost_10", "dx_cst_aq2_hunt_firstlost_10", "dx_cst_aq3_hunt_firstlost_10", "dx_cst_aq4_hunt_firstlost_10"];
  return var_0[randomint(var_0.size)];
}