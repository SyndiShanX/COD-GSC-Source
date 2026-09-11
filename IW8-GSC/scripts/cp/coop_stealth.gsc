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
  ref_129fd();
  ref_129fe();
  thread ref_134e4();
  level.bonusdeathplunderot = [];
  level.stealth_soundaliases = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
}

function ref_12c57() {
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

function register_stealth_state_func(var0, var1, var2) {
  level.enter_stealth_state_func[var0] = var1;
  level.exit_stealth_state_func[var0] = var2;
}

function start_coop_stealth() {
  thread flash_crate_update_hint_logic_alt();
}

function ai_sight_monitor(var0) {
  self.sightlastactivetime = 0;
  self.sightstate = 0;
  updateaisightonplayer(self.sightstate);
}

function getaisightdirection(var0) {
  var1 = anglesToForward(self getplayerangles());
  var2 = (var1[0], var1[1], var1[2]);
  var2 = vectorNormalize(var2);
  var3 = var0.origin - self.origin;
  var4 = (var3[0], var3[1], var3[2]);
  var4 = vectorNormalize(var4);
  var5 = vectordot(var2, var4);

  if(var5 >= 0.92388) {
    return 2;
  }

  if(var5 >= 0.382683) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var2, var0.origin), 4, 1);
  }

  if(var5 >= -0.382683) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var2, var0.origin), 128, 64);
  }

  if(var5 >= -0.92388) {
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var2, var0.origin), 32, 8);
  }

  return 16;
}

function isleft2d(var0, var1, var2) {
  var3 = (var0[0], var0[1], 0);
  var4 = (var2[0], var2[1], 0);
  var5 = var4 - var3;
  var6 = (var1[0], var1[1], 0);
  return var5[0] * var6[1] - var5[1] * var6[0] < 0;
}

function regular_enemy_death_func() {
  var0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  if(isDefined(level.bonusdeathplunderot) && scripts\engine\utility::array_contains(level.bonusdeathplunderot, self)) {
    scripts\engine\utility::array_remove(level.bonusdeathplunderot, self);
  }

  leave_corpse_for_others_to_see(var0);
  delete_stealth_meter(var0, var0);
  delete_combat_icon(var0, var0);
}

function leave_corpse_for_others_to_see() {
  if(!isDefined(level.enemy_ai_corpse_locations)) {
    level.enemy_ai_corpse_locations = [];
  }

  if(!istrue(self.died_poorly)) {
    var0 = spawnStruct();
    var0.loc = self.origin + (0, 0, 120);
    var0.time_stamp = gettime();
    var0.index = self getentitynumber() + randomint(100);
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_add(level.enemy_ai_corpse_locations, var0);
    return;
  }
}

function weapon_xp_iw8_sn_kilo98() {
  if(scripts\cp\utility::coop_mode_has("sp_stealth")) {
    return 1;
  }

  return getdvarint("cp_sp_stealth", 0);
}

function ref_132d7() {
  if(level.script == "cp_raid_complex") {
    return (weapon_xp_iw8_sn_kilo98() && (self.unittype == "soldier" || self.unittype == "juggernaut"));
  }

  return weapon_xp_iw8_sn_kilo98() && self.unittype == "soldier";
}

function run_common_functions(var0, var1, var2, var3, var4, var5, var6) {
  if(!scripts\engine\utility::flag("stealth_settings_activated")) {
    setdvarifuninitialized("cp_sp_stealth", 0);
    attachdrill();
  }

  if(istrue(level.global_stealth_broken)) {
    var0 thread scripts\cp\cp_modular_spawning::enter_combat();
    return;
  }

  if(ref_132d7(var0)) {
    if(isDefined(var0.group) && isDefined(var0.group.group_name)) {
      var0.script_stealthgroup = var0.group.group_name;
    } else {
      var0.script_stealthgroup = "group";
    }

    if(isDefined(var0.spawnpoint) && isDefined(var0.spawnpoint.script_sightrange)) {
      var0.stealth.override_damage_auto_range = int(var0.script_sightrange);
    }

    var0 thread scripts\stealth\enemy::main();
    var0 thread scripts\mp\vehicles\cargo_truck_mg_mp::ref_11cd7(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
    thread seeing_player_time_tracker(var0);
    thread ref_14458();
    thread stealth_meter_display_think(var0);
    var0.stealth.console_being_hacked = 1;
    var0.stealth.funcs["event_combat"] = &nuke_stoptheclock;
    var0.fnstealthgotonode = &select_bunker_server_two_spawners;
    var0.pacifist_override = 1;
    return;
  }

  if(!isDefined(var3)) {
    var3 = 0.34202;
  } else {
    var3 = cos(var3);
  }

  if(!isDefined(var4)) {
    var4 = 250000;
  }

  var0 addaieventlistener("glass_destroyed");
  var0 enablestatelookat(1);
  var0 enablescriptedlookat(1);
  var0.pacifist_override = 1;
  set_current_stealth_state(var0, var0, "casual");
  enter_current_stealth_state(var0, var0);

  if(!istrue(var5)) {
    thread open_scriptable_door_monitor(var0);
  }

  thread watch_for_ai_events();
  thread i_see_player_watcher(var0, var0, var2, var3, var4);
  thread i_see_friendly_corpse_watcher(var0, var0);
  thread delay_enter_combat_after_stealth(var0);
  thread watch_for_alarm_triggered();
  thread spotlight_min_dist_sq_from_node(var0, var3);
  thread spotlight_goal_node(var0, var3);
  thread spotlight_max_dist_sq_from_node(var0, var3);
  thread spotlight_angles_offset(var0, var3);
  thread ref_119d0(var0);
  thread blueprint_chancebase(var0);
  thread bomb_count_down_end_time_stamp_ms(var0);
}

function blueprint_chancebase(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
  thread play_enemy_radio_chat(level, propwatchcleanupondisconnect());
  var0 notify("watch_for_ai_events");
  getbestintersectionpt(var0, var0, var2.name, "enemies_are_alerted");
}

function bomb_count_down_end_time_stamp_ms(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var0 waittill("hit_ai", var1);
  thread play_enemy_radio_chat(level, propwatchcleanupondisconnect());
  var0 notify("watch_for_ai_events");
  getbestintersectionpt(var0, var0, var1.name, "enemies_are_alerted");
}

function ref_119d0(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0.a.disablelongdeath = 1;
  var1 = scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", var0, "enter_combat");
  var0.a.disablelongdeath = 0;
}

function nuke_stoptheclock(var0) {
  thread scripts\cp\cp_modular_spawning::enter_combat();
  return false;
}

function select_bunker_server_two_spawners(var0, var1, var2) {
  if(istrue(self.using_goto_node)) {
    if(isDefined(self.currentnode)) {
      thread scripts\cp\cp_modular_spawning::go_to_node(self.currentnode);
      return;
    }

    return;
  }

  scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function ref_139bf() {
  self notify("suspicious_door_monitor_end");
  self endon("death");
  self endon("disconnect");
  self endon("suspicious_door_monitor_end");
  var0 = 384;
  var1 = 80;
}

function ref_13b3a() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(isDefined(self.stealth.maxthreat)) {
      if(self.stealth.maxthreat > 0.2 && isDefined(self.stealth.maxthreat_enemy)) {
        var0 = self.stealth.maxthreat_enemy;
        mark_seen_this_player_this_frame(var0, self);
        var0 notify("display_stealth_meter_to", self);
      }
    }

    waitframe();
  }
}

function spotlight_max_dist_sq_from_node(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var2 = self;
  var3 = 3000;
  var4 = var3 * var3;
  var5 = 0.1;
  var6 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var1 *= 6.25;

  for(;;) {
    wait 0.4;

    if(!isDefined(level.taccovers)) {
      continue;
    }

    var7 = self getapproxeyepos();

    foreach(var9 in level.taccovers) {
      if(isDefined(var9)) {
        var10 = lengthsquared(var9.origin - self.origin);
        var11 = raritycamsmall(var2, var9, var0, var3, var5);

        if(var10 < var11 * var11) {
          var12 = self cansee(var9);

          if(!var12) {
            var12 = scripts\engine\trace::ray_trace_passed(var7, var9.origin, [self, var9], var6);
          }

          if(var12) {
            if(var10 <= var1) {
              getbestintersectionpt(self, var9.owner.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var9, 1);
            } else {
              i_saw_player(self, var9.owner, 0);
            }

            break;
          }
        }
      }
    }

    var5 = undefined;
    var7 = undefined;
  }
}

function raritycamsmall(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var5 = 0.34202;
  } else {
    var5 = cos(var3);
  }

  if(!scripts\engine\utility::within_fov(var1.origin, var1.angles, var2.origin, var3)) {
    var4 *= var5;
  }

  return var4;
}

function spotlight_goal_node(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var2 = self;
  var3 = 3000;
  var4 = 200;
  var5 = 1500;
  var6 = 0.6;
  var7 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var1 *= 6.25;

  for(;;) {
    var8 = self getapproxeyepos();

    foreach(var10 in level.players) {
      var11 = quickdropnewitem(var10);

      if(isDefined(var11)) {
        var12 = lengthsquared(var11.origin - self.origin);
        var13 = raritycamwatch(self, var11, var0, var3, var5, var4, var6);

        if(var12 < var13 * var13) {
          var14 = self cansee(var11);

          if(!var14) {
            var14 = scripts\engine\trace::ray_trace_passed(var8, var11.origin, [self, var11], var7);
          }

          if(var14) {
            if(var12 <= var1) {
              getbestintersectionpt(self, var10.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var11, 1);
            } else {
              i_saw_player(self, var10, 0);
            }

            break;
          }
        }
      }
    }

    var6 = undefined;
    var9 = undefined;
    wait 0.1;
  }
}

function quickdropnewitem(var0) {
  if(isDefined(var0.ref_12f15)) {
    return var0.ref_12f15;
  }

  if(isDefined(var0.monitorhotfoot)) {
    return var0.monitorhotfoot;
  }

  return undefined;
}

function spotlight_min_dist_sq_from_node(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var2 = 3000;
  var3 = 200;
  var4 = 1500;
  var5 = 0.6;
  var6 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var7 = self getapproxeyepos();

    foreach(var9 in level.players) {
      if(var9 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        var10 = lengthsquared(var9.origin - self.origin);
        var11 = raritycamwatch(self, var9.vehicle, var0, var2, var4, var3, var5);

        if(var10 < var11 * var11) {
          var12 = self cansee(var9);

          if(!var12) {
            var12 = scripts\engine\trace::ray_trace_passed(var7, var9 getEye(), [self, var9, var9.vehicle], var6);
          }

          if(var12) {
            if(var10 <= var1) {
              getbestintersectionpt(self, var9.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var9, 0);
            } else {
              i_saw_player(self, var9, 0);
            }

            break;
          }
        }
      }
    }

    var5 = undefined;
    var7 = undefined;
    wait 0.1;
  }
}

function spotlight_angles_offset(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  var2 = 2000;
  var3 = 0.6;
  var4 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var5 = self getapproxeyepos();

    foreach(var7 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var7)) {
        var8 = lengthsquared(var7.origin - self.origin);
        var9 = raritycammedium(self, var7, var2, var0, var3);

        if(var8 < var9 * var9) {
          var10 = self cansee(var7);

          if(!var10) {
            var10 = scripts\engine\trace::ray_trace_passed(var5, var7 getEye(), [self, var7], var4);
          }

          if(var10) {
            if(var8 <= var1) {
              getbestintersectionpt(self, var7.name, "enemies_are_alerted");
            } else if(get_current_stealth_state(self) != "alert") {
              enemy_ai_enter_alert(self, var7, 0);
            } else {
              i_saw_player(self, var7, 0);
            }

            break;
          }
        }
      }
    }

    var3 = undefined;
    var5 = undefined;
    wait 0.1;
  }
}

function raritycammedium(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var5 = 0.34202;
  } else {
    var5 = cos(var4);
  }

  var6 = anglesToForward(var1.angles);
  var7 = var2.origin - var1.origin;
  var7 = vectorNormalize(var7);

  if(vectordot(var6, var7) < var5) {
    var3 *= var5;
  }

  return var3;
}

function raritycamwatch(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var2)) {
    var7 = 0.34202;
  } else {
    var7 = cos(var3);
  }

  var8 = anglesToForward(var1.angles);
  var9 = length(var2 vehicle_getvelocity());
  var10 = var5 + (var4 - var5) * min(1, 1 - (var6 - var9) / var6);
  var11 = var2.origin - var1.origin;
  var12 = lengthsquared(var11);
  var11 = vectorNormalize(var11);

  if(vectordot(var8, var11) < var7) {
    var10 *= var7;
  }

  return var10;
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

function delay_enter_combat_after_stealth(var0) {
  var0 endon("death");
  var0 endon("long_death");

  if(!istrue(var0.ref_11e50)) {
    var0.never_kill_off = 0;
    var0.dontkilloff = 0;
  }

  var0 scripts\cp\cp_modular_spawning::ref_12bc9();
  var0 thread scripts\cp\cp_modular_spawning::enter_combat_after_stealth();
}

function open_scriptable_door_monitor(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("use_scriptable_door", var1, var0, var2, var3);

    if(var2 == "door" && (var3 == "right_90" || var3 == "left_90")) {
      var4 = scripts\engine\utility::getclosest(var1.origin, scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy"));

      if(isDefined(var4)) {
        scripts\cp\cp_interaction::remove_from_current_interaction_list(var4);
      }
    }
  }
}

function change_stealth_state_to(var0, var1) {
  level endon("weapons_free");
  var0 notify("change_stealth_state_to", var1);
  var0 endon("change_stealth_state_to");
  var0 endon("death");
  var0 endon("enter_combat");
  exit_current_stealth_state(var0);
  set_current_stealth_state(var0, var1);
  enter_current_stealth_state(var0);
}

function exit_current_stealth_state(var0) {
  var0[[level.exit_stealth_state_func[get_current_stealth_state(var0)]]](var0);
}

function enter_current_stealth_state(var0) {
  var0[[level.enter_stealth_state_func[get_current_stealth_state(var0)]]](var0);
}

function set_current_stealth_state(var0, var1) {
  var0.current_stealth_state = var1;
}

function get_current_stealth_state(var0) {
  return var0.current_stealth_state;
}

function trial_trigger_think(var0) {
  return isDefined(get_current_stealth_state(var0));
}

function enter_casual(var0) {
  var0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("patrol");
  var0 scripts\engine\utility::set_movement_speed(25);
}

function exit_casual(var0) {}

function enter_alert(var0) {
  var0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("alert");
  var0 scripts\engine\utility::set_movement_speed(25);
  thread stealth_meter_display_think(var0);
  thread stealth_meter_degree_think(var0);
}

function stealth_meter_display_think(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("enter_combat");
  var0 endon("exit_stealth_think");

  for(;;) {
    var0 waittill("display_stealth_meter_to", var1);
    var0.spawnposition = var1;
    show_stealth_meter_to(var1, var0);
    thread ping_enemy_and_player_for_duration(var1, var0, var1);
  }
}

function ping_enemy_and_player_for_duration(var0, var1, var2) {
  var1 notify("ping_enemy_and_player_for_duration");
  var1 endon("disconnect");
  var1 endon("ping_enemy_and_player_for_duration");

  if(!isDefined(var2)) {
    var2 = 3;
  }

  thread ref_123c4(var1);
  var1 setscriptablepartstate("sixthsense", "loop");
  wait var2;
  var1 setscriptablepartstate("sixthsense", "neutral");
}

function stopsoundoncompletion(var0) {
  wait lookupsoundlength(var0);
  self.bplayingspecificstealthsound = undefined;
}

function increase_stealth_meter(var0, var1) {
  if(get_current_stealth_state(var0) == "alert") {
    var2 = max(distancesquared(var0.origin, var1.origin), 1);
    var3 = 1 / var2 * 110889;

    if(var0.stealth_meter_state == "decreasing") {
      var0.target_stealth_meter_progress = clamp(var0.current_stealth_meter_progress + var3, 0, 1);
    } else {
      var0.target_stealth_meter_progress = clamp(var0.target_stealth_meter_progress + var3, 0, 1);
    }

    var0 notify("increase_stealth_meter");
    return;
  }
}

function decrease_stealth_meter(var0, var1) {
  if(get_current_stealth_state(var0) == "alert") {
    if(var0.stealth_meter_state == "increasing") {
      var0.target_stealth_meter_progress = clamp(var0.current_stealth_meter_progress + var1, 0, 1);
    } else {
      var0.target_stealth_meter_progress = clamp(var0.target_stealth_meter_progress + var1, 0, 1);
    }

    var0 notify("decrease_stealth_meter");
    return;
  }
}

function stop_stealth_meter(var0) {
  var0.target_stealth_meter_progress = var0.current_stealth_meter_progress;
  var0 notify("stop_stealth_meter");
}

function stealth_meter_degree_think(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("enter_combat");
  var0 endon("exit_stealth_think");
  var0.current_stealth_meter_progress = 0;
  var0.target_stealth_meter_progress = 0;
  var0.stealth_meter_state = "stopped";

  for(;;) {
    if(var0.current_stealth_meter_progress == var0.target_stealth_meter_progress) {
      var0.stealth_meter_state = "stopped";
    } else {
      var1 = min(0.2, abs(var0.target_stealth_meter_progress - var0.current_stealth_meter_progress));

      if(var0.target_stealth_meter_progress > var0.current_stealth_meter_progress) {
        var0.stealth_meter_state = "increasing";
      } else {
        var0.stealth_meter_state = "decreasing";
        var1 *= -1;
      }

      var0.current_stealth_meter_progress = clamp(var0.current_stealth_meter_progress + var1, 0, 0.99);

      if(getdvarint("scr_phj_disable_icons", 0) == 0) {
        objective_setprogress(var0.stealth_meter_objective_id, var0.current_stealth_meter_progress);
      }

      check_stealth_state_change(var0);
    }

    var2 = var0 scripts\engine\utility::ref_143b9(0.1, "stop_stealth_meter");

    if(var2 == "stop_stealth_meter") {
      var0.target_stealth_meter_progress = var0.current_stealth_meter_progress;
    }
  }
}

function check_stealth_state_change(var0) {
  if(var0.current_stealth_meter_progress >= 0.99) {
    var1 = var0.spawnposition.name;
    wait 0.1;
    getbestintersectionpt(var0, var0, var1, "player_spotted");
    return;
  }
}

function exit_alert(var0) {
  delete_stealth_meter(var0);
}

function enter_combat(var0) {
  var0 endon("death");
  var0 endon("enter_combat");

  if(!istrue(level.global_stealth_broken)) {
    stop_patrol(0);

    if(!ref_132c1(var0)) {
      friendly_exit(var0);
    }

    if(ref_132c5(var0)) {
      thread logevent_spawnviaplayer(var0);
    }

    thread global_stealth_broken(level);
    return;
  }
}

function ref_1215d(var0) {
  var1 = 5;
  scripts\cp\cp_outline::enable_outline_for_players(var0, level.players, "snapshotgrenade", "high");
  var0 scripts\engine\utility::waittill_any_in_array_or_timeout(["death"], var1);
  scripts\cp\cp_outline::disable_outline_for_players(var0, level.players);
}

function ref_132c1(var0) {
  if(bomber_damage_thread(var0)) {
    return 1;
  }

  if(istrue(var0.ref_133b9)) {
    return 1;
  }

  if(isDefined(var0.ref_132c2)) {
    return [[var0.ref_132c2]](var0);
  }

  if(!isDefined(level.bonusdeathplunderot)) {
    level.bonusdeathplunderot = [];
  }

  if(level.bonusdeathplunderot.size > max(2, level.players.size)) {
    return 1;
  }

  return 0;
}

function logevent_spawnviaplayer(var0) {
  var0 endon("death");
  var1 = 3;
  waittillframeend();

  if(isDefined(var0.ref_11bd5)) {
    logevent_challengeitemunlocked(var0, var0.ref_11bd5, &keypadscriptableused_altbunker);
  } else {
    logevent_challengeitemunlocked(var0, "cellphone", &keypadscriptableused_altbunker);
  }

  wait var1;
  var0 notify("delete_reinforcement_icon");
}

function ref_132c5(var0) {
  return true;
}

function bomber_damage_thread(var0) {
  return var0.agent_type == "actor_enemy_cp_rus_juggernaut";
}

function friendly_exit(var0) {
  var0.bcallingreinforcements = 1;
  level.ai_going_to_alarm = var0;
  var0 notify("alerted");
  GscBinSkip4(0x6e, var0);
}

function modified_enter_combat(var0) {
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
  var0 = undefined;

  if(isDefined(level.alarm_box_structs)) {
    var0 = scripts\engine\utility::get_array_of_closest(self.origin, level.alarm_box_structs, undefined, 1, 666);
  }

  if(!isDefined(level.ai_going_to_alarm)) {
    if(isDefined(var0) && isarray(var0) && var0.size > 0) {
      logevent_challengeitemunlocked(self, "alert", &keypadscriptableused);
      self.ref_11bd6 = "alarm";
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("combat");
      self.scripted_mode = 1;
      thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::run_to_and_set_alarm(var0[0]);
      level waittill("alarm_on");
      self.scripted_mode = 0;
      self notify("called_reinforcements");

      foreach(var2 in var0) {
        var2 notify("stop_attracting");
      }

      foreach(var5 in getaiarray("axis")) {
        if(isDefined(var5.going_to_object)) {
          var5.going_to_object = undefined;
          var5.goalradius = 2048;
          var5 scripts\cp\maps\cp_donetsk\milbase\ai_flare::clear_custom_anim();
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
  var7 = self findbestcovernode("cover_default", 1, self.origin, 1);

  if(isDefined(var7)) {
    var8 = var7.angles;
    var9 = var7.origin;

    if(!issubstr(var7.type, "Prone")) {
      if(issubstr(var7.type, "Left")) {
        var8 += (0, 90, 0);
      } else if(issubstr(var7.type, "Right") || issubstr(var7.type, "Cover Crouch") || issubstr(var7.type, "Conceal") || issubstr(var7.type, "Cover Stand")) {
        var8 -= (0, 90, 0);
      }
    }

    scripts\common\utility::demeanor_override("sprint");
    self setgoalnode(var7);
    self waittill("goal");
    self setgoalpos(self.origin);
    wait 3;
    scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
    return;
  }

  var7 = getclosestnodeinsight(self.origin);

  if(isDefined(var7)) {
    scripts\common\utility::demeanor_override("sprint");
    self.scripted_mode = 1;
    scripts\cp\cp_modular_spawning::set_goal_pos(var7.origin);
    wait 1;
    self usecovernode(var7, 1);
    self setgoalnode(var7);
    wait 3;
    self.scripted_mode = 0;
    scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
    return;
  }

  wait 3;
  scripts\cp\utility::array_notify(getaiarray("axis"), "called_reinforcements");
}

function exit_combat(var0) {}

function global_stealth_broken(var0) {
  if(istrue(level.global_stealth_broken)) {
    return;
  }

  level endon("game_ended");
  level notify("weapons_free");
  level.global_stealth_broken = 1;
  level.battlechatterenabled = 1;
  level.ref_139b5 = 0;
  isenemyteamplayer();

  if(isDefined(level.select_boss_two_spawners)) {
    [[level.select_boss_two_spawners]](var0);
  }

  thread play_combat_music_to_players();
}

function i_see_friendly_corpse_watcher(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("long_death");
  var0 endon("enter_combat");

  if(!isDefined(level.enemy_ai_corpse_locations)) {
    level.enemy_ai_corpse_locations = [];
  }

  var2 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);

  for(;;) {
    if(istrue(self.bcallingreinforcements)) {
      wait 1;
      continue;
    }

    foreach(var4 in level.enemy_ai_corpse_locations) {
      if(distance(var0.origin, var4.loc) > var0.sightmaxdistance) {
        wait 1;
        continue;
      }

      if(!var0 scripts\engine\math::point_in_fov(var4.loc, cos(50), 1)) {
        wait 1;
        continue;
      }

      var5 = angleclamp180(vectortopitch(var4.loc - var0.origin));

      if(var5 < var0.upaimlimit || var5 > var0.downaimlimit) {
        wait 1;
        continue;
      }

      var6 = scripts\engine\trace::ray_trace_passed(var0 getEye(), var4.loc, [var0], var2);

      if(var6) {
        if(istrue(var1) && allow_to_get_to_corpse(var4) && corpse_is_too_far_away(var0, var4.loc)) {
          level.num_time_getting_to_corpse[var4.index]++;
          go_check_out_corpse(var0, var4, 1);
        }
      }

      wait 1;
    }

    wait 1;
  }
}

function go_check_out_corpse(var0, var1, var2) {
  var0 notify("checking_friendly_corpse");
  var0.investigating_friendly_corpse = 1;
  thread change_stealth_state_to(var0, var0);
  show_stealth_meter_to_all_players(var0, var0);

  if(istrue(var2)) {
    stop_patrol(var0, 1);
    var3 = vectorNormalize(var0.origin - var1.loc);
    var4 = getclosestpointonnavmesh(var1.loc + var3 * 15);
    var0 scripts\cp\cp_modular_spawning::set_goal_pos(var4);
    var0 scripts\engine\utility::ref_143b9(15, "forever");
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_remove(level.enemy_ai_corpse_locations, var1);
    check_around_the_area(var0);
    return;
  }

  thread increase_stealth_meter_when_approaching_corpse(var2, var2);
  stop_patrol(var2, 1);
  var2 scripts\engine\utility::set_movement_speed(100);
  var3 = vectorNormalize(var2.origin - var3.loc);
  var4 = getclosestpointonnavmesh(var3.loc + var3 * 15);
  var2 scripts\cp\cp_modular_spawning::set_goal_pos(var4);
  var2 waittill("forever");
}

function stop_patrol(var0) {
  var1 = self;
  var1 notify("stop_going_to_node");
  var1 notify("patrol_using_cover_nodes");

  if(istrue(var0)) {
    var1 scripts\cp\cp_modular_spawning::set_goal_pos(var1.origin);
    return;
  }
}

function show_stealth_meter_to_all_players(var0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  foreach(var2 in level.players) {
    show_stealth_meter_to(var2, var0);
  }
}

function increase_stealth_meter_when_approaching_corpse(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("enter_combat");
  var2 = distancesquared(var0.origin, var1.loc) - 40000;

  for(var3 = 0;; var3 = var6) {
    waitframe();
    var4 = distancesquared(var0.origin, var1.loc);
    var5 = clamp(1 - var4 / var2, 0, 1);
    var6 = max(var5, var3 + 0.05);
    set_stealth_meter_progress(var0, var6);
  }
}

function allow_to_get_to_corpse(var0) {
  if(!isDefined(level.num_time_getting_to_corpse)) {
    level.num_time_getting_to_corpse = [];
  }

  if(!isDefined(level.num_time_getting_to_corpse[var0.index])) {
    level.num_time_getting_to_corpse[var0.index] = 0;
  }

  return level.num_time_getting_to_corpse[var0.index] < 1;
}

function corpse_is_too_far_away(var0, var1) {
  return distance2dsquared(var0.origin, var1) >= 90000;
}

function updateaisightonplayer(var0) {
  self setclientomnvar("ui_edge_glow", var0);
}

function sendout_notify_of_vehicle_kill(var0, var1) {
  foreach(var3 in getaiarray("axis")) {
    if(isDefined(var0) && var3 == var0) {
      continue;
    }

    var3 notify("ai_events", var1);
    waitframe();
  }
}

function turn_off_hours_later_chyron_text(var0) {
  return true;
}

function watch_for_ai_events(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  self endon("death");
  self endon("long_death");
  self endon("enter_combat");
  waitframe();
  self notify("watch_for_ai_events");
  self endon("watch_for_ai_events");
  var1 = 2000;
  jumpiffalse(isDefined(self.sightmaxdistance)) LOC_0000004a;
  var1 = self.sightmaxdistance;

  for(;;) {
    self waittill("ai_events", var2);

    if(istrue(self.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    var3 = self getapproxeyepos();

    for(var4 = 0; var4 < var2.size; var4++) {
      var5 = var2[var4];

      if(!turn_off_hours_later_chyron_text(var5)) {
        waitframe();
        continue;
      }

      if(scripts\cp\cp_modular_spawning::has_func_for_aievent(var5.type)) {
        scripts\cp\cp_modular_spawning::run_aievent_func(var5.type, var2);
      }

      if(var5.type == "enemy") {
        if(isDefined(var5.entity) && isPlayer(var5.entity)) {
          var7 = self cansee(var5.entity) && sighttracepassed(var3, var5.entity getEye(), 0, self);

          if(var7) {
            if(istrue(var5.entity.disguised)) {
              if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                continue;
              }
            } else if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance) {
              waitframe();
              continue;
            }

            var8 = angleclamp180(vectortopitch(var5.entity.origin - self.origin));

            if(var8 < self.upaimlimit || var8 > self.downaimlimit) {
              waitframe();
              continue;
            }

            var5.type = "enemy_visible";
          } else {
            waitframe();
            continue;
          }
        } else {
          waitframe();
          continue;
        }
      }

      if(var5.type == "footstep_sprint") {
        var7 = self cansee(var5.entity) && sighttracepassed(var3, var5.entity getEye(), 0, self);

        if(var7) {
          if(istrue(var5.entity.disguised)) {
            if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance / 6) {
              waitframe();
              continue;
            }
          } else if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance) {
            waitframe();
            continue;
          }

          var8 = angleclamp180(vectortopitch(var5.entity.origin - self.origin));

          if(var8 < self.upaimlimit || var8 > self.downaimlimit) {
            waitframe();
            continue;
          }
        }

        self setlookat(var5.entity.origin, 1);
      } else if(var5.type == "bulletwhizby" || var5.type == "grenade danger" || var5.type == "gunshot" || var5.type == "vehicle_hit_me") {
        if(isPlayer(var5.entity)) {
          if(var5.type == "bulletwhizby") {
            if(!scripts\cp\killstreaks\init_cp::gastrap_dmg_trig(var5.entity getcurrentweapon())) {
              continue;
            }
          }

          if(var5.type == "vehicle_hit_me") {
            var9 = self cansee(var5.entity) && sighttracepassed(var3, var5.entity getEye(), 0, self);
            var10 = isDefined(var5.entity.vehicle) && self cansee(var5.entity.vehicle) && sighttracepassed(var3, var5.entity.vehicle.origin, 0, self);

            if(var9 || var10) {
              if(istrue(var5.entity.disguised)) {
                if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var8 = angleclamp180(vectortopitch(var5.entity.origin - self.origin));

              if(var8 < self.upaimlimit || var8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var5.type = "vehicle_hit_me";
            }
          } else if(!istrue(self.stack_patch_waittill_context_patch) && var5.entity scripts\cp\cp_weapon::player_has_silencer(var5.entity getcurrentweapon())) {
            var7 = self cansee(var5.entity) && sighttracepassed(var3, var5.entity getEye(), 0, self);

            if(var7) {
              if(istrue(var5.entity.disguised)) {
                if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var8 = angleclamp180(vectortopitch(var5.entity.origin - self.origin));

              if(var8 < self.upaimlimit || var8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var5.type = "shot_fired_seen";
            } else {
              var5.type = "silenced_shot";
            }
          }
        }
      }

      switch (var5.type) {
        case "enemy_visible":
          if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var5.entity, var0, var5.type);
          } else {
            i_saw_player(self, var5.entity, var0);
          }

          break;
        case "shot_fired_notseen":
          if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var5.entity, var0, var5.type);
          } else {
            i_saw_player(self, var5.entity, var0);
          }

          break;
        case "shot_fired_seen":
          if(distancesquared(self.origin, var5.entity.origin) <= 10000) {
            thread play_enemy_radio_chat(level, processassist_regularcp());
            thread delay_enter_combat(self, var5.type, var5.entity);
          } else if(did_anyone_see_this(self, var5.entity.origin, var1, 1, var5.entity.origin)) {
            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var5.type, var5.entity);
          } else if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var5.entity, var0, var5.type);
          } else {
            i_saw_player(self, var5.entity, var0);
          }

          break;
        case "silenced_shot":
        case "vehicle_hit_me":
          if(did_anyone_see_this(self, var5.origin, var1, 1, var5.origin)) {
            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var5.type, var5.entity);
          } else if(get_current_stealth_state(self) != "alert") {
            enemy_ai_enter_alert(self, var5.entity, var0, var5.type);
          } else {
            i_saw_player(self, var5.entity, var0);
          }

          break;
        case "footstep_walk":
        case "footstep":
        case "footstep_sprint":
          var9 = self cansee(var5.entity) && sighttracepassed(self getEye(), var5.entity getEye(), 0, self);

          if(var9) {
            if(istrue(var5.entity.disguised)) {
              if(distance(self.origin, var5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                break;
              }
            }

            thread play_enemy_radio_chat(level, receivingampeddamage());
            thread delay_enter_combat(self, var5.type, var5.entity);
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
          thread delay_enter_combat(self, var5.type, var5.entity);
          break;
        default:
          break;
      }
    }
  }
}

function vehicle_hit_event(var0, var1) {
  if(did_anyone_see_this(var0, var1, 2000, 1, var1)) {
    return;
  }
}

function delay_enter_combat(var0, var1, var2) {
  var0 endon("death");
  self notify("watch_for_ai_events");

  if(!(isDefined(var2) && isPlayer(var2))) {
    var2 = quickdropremoveselfrevivetokenfrominventory(var0.origin, &quickdropremoveweaponfrominventory);
  }

  wait 0.75;
  getbestintersectionpt(var0, var0, var2.name, "enemies_are_alerted");
}

function i_see_player_watcher(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("long_death");
  var0 endon("enter_combat");
  thread seeing_player_time_tracker(var0);
  jumpiftrue(isDefined(var4)) LOC_0000003b;
  var4 = 1024;

  for(;;) {
    var0 waittill("known_event", var5, var6, var7, var8);

    if(istrue(var0.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    if(player_in_concealment_area(var5)) {
      continue;
    }

    var9 = var0.sightmaxdistance;
    var9 *= var5.perk_data["stealth_dist_scalar"];

    if(istrue(var5.disguised)) {
      var9 /= 6;
    }

    if(distance(var0.origin, var5.origin) > var9) {
      waitframe();
      continue;
    }

    if(var5.origin[2] - var0.origin[2] > var4) {
      waitframe();
      continue;
    }

    var10 = angleclamp180(vectortopitch(var5.origin - var0.origin));

    if(var10 < var0.upaimlimit || var10 > var0.downaimlimit) {
      waitframe();
      continue;
    }

    var11 = var0 getapproxeyepos();
    var12 = var5 getEye();
    var13 = anglesToForward(var0.angles);
    var14 = vectorNormalize(var12 - var11);
    var15 = vectordot(var14, var13);

    if(var15 < var2) {
      waitframe();
      continue;
    }

    var16 = 0;

    if(var5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      if(scripts\engine\trace::ray_trace_passed(var11, var5.vehicle.origin, var0, scripts\engine\trace::create_vehicle_contents())) {
        var16 = 1;
      }
    } else {
      var16 = var0 cansee(var5) && sighttracepassed(var11, var12, 0, var0);
    }

    if(var16) {
      if(distancesquared(var0.origin, var5.origin) <= var3) {
        getbestintersectionpt(var0, var0, var5.name, "player_spotted");
        continue;
      }

      if(get_current_stealth_state(self) != "alert") {
        enemy_ai_enter_alert(var0, var5, var1);
        continue;
      }

      i_saw_player(var0, var5, var1);
      LOC_00000219:
    }
    LOC_00000219:
  }
}

function i_saw_player(var0, var1, var2) {
  var0 notify("display_stealth_meter_to", var1);
  mark_seen_this_player_this_frame(var0, var1);

  if(has_seen_any_player_long_enough_to_trigger_alert(var0)) {
    enemy_ai_enter_alert(var0, var1, var2);
  }

  increase_stealth_meter(var0, var1);
}

function display_combat_icon_to_player(var0) {
  thread delay_delete_combat_icon(var0);

  foreach(var2 in level.players) {
    show_combat_icon_to(var2, var0);
  }
}

function logevent_challengeitemunlocked(var0, var1, var2) {
  var0.ref_12b4c = var1;

  foreach(var4 in level.players) {
    ref_13336(var4, var0, var2);
  }
}

function keypadscriptableused(var0, var1, var2) {
  var3 = var2 getentitynumber();
  var4 = var2 scripts\engine\utility::waittill_any_ents_return(var2, "death", var2, "called_reinforcements", level, "weapons_free");
  laser_func(var0, var1, var2, var3);
}

function keypadscriptableused_altbunker(var0, var1, var2) {
  var3 = var2 getentitynumber();
  var4 = var2 scripts\engine\utility::waittill_any_ents_return(var2, "death", var2, "delete_reinforcement_icon");
  laser_func(var0, var1, var2, var3);
}

function delay_delete_combat_icon(var0) {
  var0 endon("death");
  wait 3;
  delete_combat_icon(var0);
}

function get_player_with_player_id(var0) {
  foreach(var2 in level.players) {
    var3 = var2 getentitynumber();

    if(var3 == var0) {
      return var2;
    }
  }
}

function enemy_ai_enter_alert(var0, var1, var2, var3, var4) {
  if(get_current_stealth_state(var0) != "alert") {
    if(isDefined(var1) && isPlayer(var1)) {
      display_warning_message_to_player(var1, var3);
    }

    thread change_stealth_state_to(var0, var0);

    if(istrue(var2)) {
      thread select_bunker_interior_one_spawners(var0, var0, var1, var4);
      return;
    }

    return;
  }
}

function propwaitminigamerun(var0) {
  var1 = undefined;

  if(isPlayer(var0)) {
    var1 = var0.name;
    return;
  }

  var1 = var0.owner.name;
}

function select_bunker_interior_one_spawners(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("enter_combat");
  thread play_enemy_radio_chat(level, processlobbydataforclient());
  var0 notify("basic_combat");
  waitframe();
  var0.goalradius = 128;
  stop_patrol(var0, 1);
  var0 scripts\engine\utility::set_movement_speed(75);
  var0 scripts\cp\cp_modular_spawning::set_goal_pos(get_investigate_loc(var0, var1.origin));
  var0 waittill("goal");

  if(isDefined(var2) && [[var2]](var1)) {
    thread kickplayersatcircleedge(var0, var0);
  }

  check_around_the_area(var0);
  thread play_enemy_radio_chat(level, prevbrbonusxp());
  thread change_stealth_state_to(var0, var0);
  var0 scripts\cp\cp_modular_spawning::start_patrol();
}

function kickplayersatcircleedge(var0, var1) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 endon("death");
  var0 endon("enter_combat");
  logevent_challengeitemunlocked(var0, "alert", &keypadscriptableused);
  wait 3;
  getbestintersectionpt(var0, var0, var1, "enemies_are_alerted");
}

function play_enemy_radio_chat(var0, var1) {
  if(isDefined(var1) && isai(var1) && isalive(var1)) {
    var1 notify("play_enemy_radio_chat");
    var1 endon("play_enemy_radio_chat");
    var1 endon("death");
    var1.trucks_intel_sequence = 1;
    var1 playsoundonmovingent(var0);
    wait lookupsoundlength(var0) / 1000;
    var1.trucks_intel_sequence = 0;
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies");
  wait lookupsoundlength(var0) / 1000;
  play_enemy_radio_beep();
}

function play_enemy_radio_beep() {
  foreach(var1 in level.players) {
    var1 playlocalsound("weap_uav_radio_button_npc_cp");
  }

  wait lookupsoundlength("weap_uav_radio_button_npc_cp") / 1000;
}

function get_investigate_loc(var0, var1) {
  var2 = vectorNormalize(var0.origin - var1);
  var3 = var1 + var2 * randomfloatrange(75, 125);
  return getclosestpointonnavmesh(var3);
}

function check_around_the_area(var0) {
  wait randomfloatrange(0.75, 1.5);

  if(istrue(var0.using_goto_node)) {
    if(isDefined(var0.currentnode)) {
      var0 thread scripts\cp\cp_modular_spawning::go_to_node(var0.currentnode);
      return;
    }

    return;
  }

  var1 = randomintrange(2, 4);
  var0 scripts\cp\cp_modular_spawning::set_goal_radius(36);
  var0 scripts\engine\utility::set_movement_speed(25);

  for(var2 = 0; var2 < var1; var2++) {
    var3 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var4 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var5 = (var0.origin[0] + var3, var0.origin[1] + var4, var0.origin[2]);
    var0 scripts\cp\cp_modular_spawning::set_goal_pos(getclosestpointonnavmesh(var5));
    var0 scripts\engine\utility::waittill_notify_or_timeout("goal", 5);
    wait randomfloatrange(0.75, 1.5);
  }

  var0 scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function display_warning_message_to_player(var0, var1) {
  if(!isDefined(var0.next_warning_message_time)) {
    var0.next_warning_message_time = 0;
  }

  var2 = gettime();

  if(var2 > var0.next_warning_message_time) {
    var0.next_warning_message_time = var2 + 1000;
    return;
  }
}

function has_seen_any_player_long_enough_to_trigger_alert(var0) {
  return has_seen_any_player_long_enough(var0, 0.1);
}

function has_seen_any_player_long_enough(var0, var1) {
  foreach(var3 in var0.time_seeing_players) {
    if(var3 >= var1) {
      return true;
    }
  }

  return false;
}

function mark_seen_this_player_this_frame(var0, var1) {
  var0.player_most_recently_saw = var1;
  var2 = var1 getentitynumber();

  if(!isDefined(var0.time_seeing_players)) {
    thread seeing_player_time_tracker(var0);
  }

  if(!isDefined(var0.time_seeing_players[var2])) {
    var0.time_seeing_players[var2] = 0;
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

function seeing_player_time_tracker(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 notify("seeing_player_time_tracker");
  var0 endon("seeing_player_time_tracker");
  var0 endon("death");
  var0 endon("long_death");
  var0 endon("enter_combat");
  var0.player_most_recently_saw = undefined;
  var0.time_seeing_players = [];
  var1 = 0;

  for(;;) {
    if(isDefined(var0.player_most_recently_saw)) {
      var1 = 0;
    } else {
      var1 += 0.1;
    }

    foreach(var4, var3 in var0.time_seeing_players) {
      if(isDefined(var0.player_most_recently_saw) && var4 == var0.player_most_recently_saw getentitynumber()) {
        var0.time_seeing_players[var4] += 0.1;
        var0.player_most_recently_saw = undefined;
        continue;
      }

      var0.time_seeing_players[var4] = max(var0.time_seeing_players[var4] - 0.05, 0);
    }

    foreach(var6 in level.players) {
      var4 = var6 getentitynumber();

      if(isDefined(var0.time_seeing_players[var4]) && var0.time_seeing_players[var4] == 0) {
        hide_stealth_meter_from(var6, var0);
      }
    }

    if(var1 >= 0.5) {
      stop_stealth_meter(var0);
    }

    wait 0.1;
  }
}

function player_in_concealment_area(var0) {
  return istrue(var0.tracking_munitions_purchase);
}

function ref_11a86(var0, var1) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(sg_respawn(var0)) {
    return;
  }

  var2 = ragdoll_on_vehicle_death(var0);
  var3 = deleteheadicon(var0);
  setheadiconfriendlyimage(var3, var2);
  addclienttoheadiconmask(var3, 10);
  setheadicondrawthroughgeo(var3, 0);
  setheadiconzoffset(var3, 1);
  setheadiconsnaptoedges(var3, 5000);
  setheadiconmaxdistance(var3, 500);
  var4 = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + var0 getentitynumber(), 22);
  objective_state(var4, "active");
  objective_icon(var4, var2);
  objective_setbackground(var4, 1);
  objective_removeallfrommask(var4);
  objective_setplayoutro(var4, 0);
  objective_setshowdistance(var4, 0);
  objective_setshowprogress(var4, 0);
  objective_setfadedisabled(var4, 1);
  objective_sethot(var4, 1);
  objective_setpulsate(var4, 1);
  objective_setshowoncompass(var4, 1);
  objective_onentity(var4, var0);
  var0 thread[[var1]](var4, var3, var0);
  var0.ref_12b4a = var4;
}

function ragdoll_on_vehicle_death(var0) {
  switch (var0.ref_12b4c) {
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

function ref_11a7b(var0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(has_combat_icon(var0)) {
    return;
  }

  var1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_combat_ID_" + var0 getentitynumber(), 22);
  objective_state(var1, "active");
  objective_icon(var1, "hud_icon_stealth");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 90);
  objective_removeallfrommask(var1);
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_setshowdistance(var1, 0);
  objective_setshowprogress(var1, 1);
  objective_setfadedisabled(var1, 1);
  objective_sethot(var1, 1);
  objective_setpulsate(var1, 1);
  objective_setshowoncompass(var1, 1);
  var0.combat_icon_objective_id = var1;
}

function make_stealth_meter_on_ai(var0) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(has_stealth_meter(var0)) {
    return;
  }

  var1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_stealth_ID_" + var0 getentitynumber(), 21);
  objective_state(var1, "active");
  objective_icon(var1, "hud_icon_stealth");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 90);
  objective_removeallfrommask(var1);
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_setshowdistance(var1, 0);
  objective_setshowprogress(var1, 1);
  objective_setprogress(var1, 0);
  objective_setfadedisabled(var1, 1);
  objective_sethot(var1, 1);
  objective_setpulsate(var1, 1);
  objective_setshowoncompass(var1, 1);
  var0.showing_the_stealth_meter_to_players = [];
  var0.stealth_meter_objective_id = var1;
  thread clear_up_stealth_meter_when_enter_combat(var0);
}

function clear_up_stealth_meter_when_enter_combat(var0) {
  var0 endon("death");
  var0 waittill("enter_combat");
  delete_stealth_meter(var0);
}

function show_stealth_meter_to(var0, var1) {
  if(!has_stealth_meter(var1)) {
    make_stealth_meter_on_ai(var1);
  }

  if(is_showing_stealth_meter_to(var0, var1)) {
    return;
  }

  var1.showing_the_stealth_meter_to_players[var1.showing_the_stealth_meter_to_players.size] = var0;
  objective_addclienttomask(var1.stealth_meter_objective_id, var0);
}

function show_combat_icon_to(var0, var1) {
  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(!has_combat_icon(var1)) {
    ref_11a7b(var1);
  }

  objective_addclienttomask(var1.combat_icon_objective_id, var0);
}

function ref_13336(var0, var1, var2) {
  if(istrue(level.little_bird_mg_handleflarerecharge)) {
    return;
  }

  if(getdvarint("scr_phj_disable_icons", 0) != 0) {
    return;
  }

  if(!sg_respawn(var1)) {
    ref_11a86(var1, var2);
  }

  objective_addclienttomask(var1.ref_12b4a, var0);
}

function set_stealth_meter_progress(var0, var1) {
  if(get_current_stealth_state(var0) == "alert") {
    var0.target_stealth_meter_progress = var1;
    return;
  }
}

function hide_stealth_meter_from(var0, var1) {
  if(!has_stealth_meter(var1)) {
    return;
  }

  if(!is_showing_stealth_meter_to(var0, var1)) {
    return;
  }

  var1.showing_the_stealth_meter_to_players = scripts\engine\utility::array_remove(var1.showing_the_stealth_meter_to_players, var0);
  objective_removeclientfrommask(var1.stealth_meter_objective_id, var0);

  if(var1.showing_the_stealth_meter_to_players.size == 0) {
    var1.spawnposition = undefined;
    return;
  }
}

function is_showing_stealth_meter_to(var0, var1) {
  return scripts\engine\utility::array_contains(var1.showing_the_stealth_meter_to_players, var0);
}

function has_stealth_meter(var0) {
  return isDefined(var0.stealth_meter_objective_id);
}

function has_combat_icon(var0) {
  return isDefined(var0.combat_icon_objective_id);
}

function sg_respawn(var0) {
  return isDefined(var0.ref_12b4a);
}

function delete_stealth_meter(var0) {
  if(has_stealth_meter(var0)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_stealth_ID_" + var0 getentitynumber());
    objective_delete(var0.stealth_meter_objective_id);
    var0.stealth_meter_objective_id = undefined;
    var0 notify("exit_stealth_think");
    return;
  }
}

function delete_combat_icon(var0) {
  if(has_combat_icon(var0)) {
    scripts\cp\cp_objectives::freeworldid("enemy_AI_combat_ID_" + var0 getentitynumber());
    objective_delete(var0.combat_icon_objective_id);
    var0.combat_icon_objective_id = undefined;
    var0 notify("exit_stealth_think");
    return;
  }
}

function laser_func(var0, var1, var2, var3) {
  scripts\cp\cp_objectives::freeworldid("enemy_AI_reinforcement_ID_" + var3);
  objective_delete(var0);
  var2.ref_12b4a = undefined;
  setheadiconimage(var1);
  var2 notify("exit_stealth_think");
}

function did_anyone_see_this(var0, var1, var2, var3, var4, var5) {
  var6 = getaiarray("axis");
  var7 = var2 * var2;

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = var1;
  }

  var8 = 3;
  var9 = 0;

  foreach(var11 in var6) {
    if(var0 == var11) {
      if(!isDefined(var0.times_hit)) {
        var0.times_hit = 1;
      } else {
        var0.times_hit++;
      }

      if(var0.times_hit > 1) {
        return true;
      } else {
        continue;
      }
    }

    if(!isalive(var11)) {
      continue;
    }

    var12 = distancesquared(var11.origin, var1);

    if(var12 > var7) {
      continue;
    }

    if(isDefined(var5) && var12 <= var5 * var5) {
      continue;
    }

    if(!var11 hastacvis(var4, var3)) {
      if(var3 && !var11 aipointinfov(var1)) {
        continue;
      }

      var9++;

      if(var9 > var8) {
        waitframe();
        var9 = 0;
      }

      if(!sighttracepassed(var11 getEye(), var1, 0, var0)) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function increase_script_maxdist(var0, var1, var2, var3) {
  var4 = scripts\cp\cp_modular_spawning::process_module_var(var0, var0.spawn_points);

  for(var5 = 0; var5 < var4.size; var5++) {
    var6 = var4[var5];
    var6.script_maxdist = 20000;
  }
}

function flash_crate_update_hint_logic_alt() {
  level.flash_icon_extraction = 0;
  var0 = 2;
  level.flash_group = getEnt("bush_trig", "targetname");
  level.flashbang_ai = [];
  var1 = scripts\engine\utility::getStructArray("bush_zone", "targetname");
  var2 = scripts\engine\utility::getStructArray("bush_struct", "targetname");

  if(!isDefined(level.flash_group)) {
    return;
  }

  var3 = gettime();

  foreach(var5 in var1) {
    var6 = [];
    var7 = var5.origin;
    var8 = var5.radius * var5.radius;

    foreach(var10 in var2) {
      if(!isDefined(var10) || istrue(var10.should_break_stealth_immediately_func)) {
        continue;
      }

      if(scripts\engine\utility::distance_2d_squared(var10.origin, var7) < var8) {
        var6 = [var10.origin, (var10.radius + var0) * (var10.radius + var0)];
        var10.should_break_stealth_immediately_func = 1;
      }
    }

    level.flashbang_ai[level.flashbang_ai.size] = [var7, var8, var6];
  }

  scripts\engine\utility::deletestructarray("bush_zone", "targetname");
  scripts\engine\utility::deletestructarray("bush_struct", "targetname");
  thread ref_124b6();
}

function ref_124b6() {
  level endon("game_ended");

  foreach(var1 in level.players) {
    thread ref_11cd6(var1);
  }

  thread flash_crate_use();
}

function flash_crate_use() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    thread ref_11cd6(var0);
  }
}

function ref_11cd6(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var1 = 100;
  var2 = 0.1;

  for(;;) {
    wait var2;
    var0.tracking_munitions_purchase = 0;

    if(var0 istouching(level.flash_group)) {
      var0.tracking_munitions_purchase = 1;
      continue;
    }

    var3 = propcircleindex(var0);

    if(!isDefined(var3)) {
      continue;
    }

    foreach(var5 in var3[2]) {
      var6 = var5[0];
      var7 = var5[1];

      if(scripts\engine\utility::distance_2d_squared(var6, var0.origin) < var7 && abs(var6[2] - var0.origin[2]) < var1) {
        var0.tracking_munitions_purchase = 1;
      }
    }
  }
}

function propcircleindex(var0) {
  foreach(var2 in level.flashbang_ai) {
    if(scripts\engine\utility::distance_2d_squared(var0.origin, var2[0]) < var2[1]) {
      return var2;
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

  foreach(var1 in level.players) {
    thread ref_124a7(var1);
  }

  for(;;) {
    level waittill("connected", var1);
    thread killstreak_createobjective_engineer(var1);
  }
}

function killstreak_createobjective_engineer(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 scripts\engine\utility::ref_143a5("loadout_given", "start_hotjoining_via_c130");
  thread ref_124a7(var0);
}

function ref_124a7(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 notify("player_grenade_fire_monitor");
  var0 endon("player_grenade_fire_monitor");

  for(;;) {
    var0 waittill("grenade_fire");
    var0.waittill_any_timeout_no_endon_death_2 = gettime();
  }
}

function quit_game_in() {
  var0 = undefined;
  var1 = -1;

  foreach(var3 in level.players) {
    if(var3.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(var3.waittill_any_timeout_no_endon_death_2) && var3.waittill_any_timeout_no_endon_death_2 > var1) {
      var0 = var3;
      var1 = var3.waittill_any_timeout_no_endon_death_2;
    }
  }

  return var0;
}

function ref_12665() {
  level endon("game_ended");
  level endon("weapons_free");
  level notify("players_weapon_fired_monitor");
  level endon("players_weapon_fired_monitor");

  foreach(var1 in level.players) {
    thread ref_12506(var1);
  }

  for(;;) {
    level waittill("connected", var1);
    thread killstreak_loadout_state(var1);
  }
}

function killstreak_loadout_state(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 scripts\engine\utility::ref_143a5("loadout_given", "start_hotjoining_via_c130");
  thread ref_12506(var0);
}

function ref_12506(var0) {
  level endon("game_ended");
  level endon("weapons_free");
  var0 notify("player_weapon_fired_monitor");
  var0 endon("player_weapon_fired_monitor");

  for(;;) {
    var0 waittill("weapon_fired");
    var0.waittill_player_dropkit_crate_used = gettime();
  }
}

function quickdropremoveselfrevivetokenfrominventory(var0, var1) {
  var2 = [[var1]]();

  if(isDefined(var2)) {
    return var2;
  }

  return projectiledeleteonnote(var0);
}

function projectiledeleteonnote(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(var3.sessionstate == "spectator") {
      continue;
    }

    var1 = var3;
  }

  return scripts\engine\utility::getclosest(var0, var1);
}

function quickdropremoveweaponfrominventory() {
  var0 = undefined;
  var1 = -1;

  foreach(var3 in level.players) {
    if(var3.sessionstate == "spectator") {
      continue;
    }

    if(isDefined(var3.waittill_player_dropkit_crate_used) && var3.waittill_player_dropkit_crate_used > var1) {
      var0 = var3;
      var1 = var3.waittill_player_dropkit_crate_used;
    }
  }

  return var0;
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
    level waittill("grenade_exploded_during_stealth", var0, var1, var2);

    switch (var1) {
      case "claymore_mp":
        thread ref_11e31(level, 4194304, 2, var0, 1);
        break;
      case "suicide_vest":
        thread ref_11e31(level, 4194304, 2, var0, 1);
        break;
      case "frag_grenade_mp":
        thread ref_11e31(level, 4194304, 2, var0, 1);
        break;
      case "molotov_mp":
        thread ref_11e31(level, 4194304, 2, var0, 1);
        break;
      case "c4_mp_p":
        thread ref_11e31(level, 4194304, 2, var0, 1);
        break;
      case "semtex_mp":
        thread ref_11e31(level, 4194304, 2, var0, 1.8);
        break;
      case "throwingknife_mp":
        ref_11e32(1048576, 1, var0, var1, &ref_132d1, var2);
        break;
      case "at_mine_mp":
        thread ref_11e31(level, 4194304, 2, var0, 0.6);
        break;
      case "thermite_mp":
        thread ref_11e31(level, 4194304, 2, var0, 0.6);
        break;
      case "flash_grenade_mp":
        thread ref_11e31(level, 4194304, 2, var0, 0.6);
        break;
      case "concussion_grenade_mp":
        thread ref_11e31(level, 4194304, 2, var0, 0.75);
        break;
      case "smoke_grenade_mp":
        ref_11e32(4194304, 2, var0, var1, &ref_132cf, var2);
        break;
      case "snapshot_grenade_mp":
        ref_11e32(4194304, 2, var0, var1, &ref_132d0, var2);
        break;
      case "gas_mp":
        ref_11e32(4194304, 2, var0, var1, &ref_132ce, var2);
        break;
      case "decoy_grenade_mp":
        ref_11e32(9437184, 2, var0, var1, &ref_132cd, var2);
        break;
      default:
        return;
    }
  }
}

function ref_11e31(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    if(isvector(var2)) {
      var5 = quickdropremoveselfrevivetokenfrominventory(var2, &quit_game_in);
    } else {
      var5 = quickdropremoveselfrevivetokenfrominventory(var3.origin, &quit_game_in);
    }

    var5 = var5.name;
  }

  wait var4;

  if(isvector(var3)) {
    var6 = prematchloadoutindex(var3, var1, var2);
  } else {
    var6 = prematchloadoutindex(var4.origin, var2, var3);
  }

  foreach(var8 in var6) {
    if(isDefined(get_current_stealth_state(var8))) {
      getbestintersectionpt(var8, var8, var6, "enemies_are_alerted");
    }
  }
}

function ref_11e32(var0, var1, var2, var3, var4, var5) {
  var6 = prematchloadoutindex(var2.origin, var0, var1);

  foreach(var8 in var6) {
    if(trial_trigger_think(var8)) {
      next_mortar_vo(var8, var2, var3, var4, var5);
    }
  }
}

function next_mortar_vo(var0, var1, var2, var3, var4) {
  if(get_current_stealth_state(var0) != "alert") {
    thread change_stealth_state_to(var0, var0);
  }

  thread select_bunker_interior_one_spawners(var0, var0, var1, var3);
}

function prematchloadoutindex(var0, var1, var2) {
  var3 = [];
  var4 = [];
  var5 = getaiarray("axis");

  foreach(var7 in var5) {
    if(distancesquared(var0, var7.origin) <= var1) {
      var4 = var7;
    }
  }

  var4 = sortbydistance(var4, var0);
  var9 = int(min(var4.size, var2));

  for(var10 = 0; var10 < var9; var10++) {
    var3 = var4[var10];
  }

  return var3;
}

function ref_132d1(var0) {
  return false;
}

function ref_132d0(var0) {
  return false;
}

function ref_132cf(var0) {
  return isDefined(var0);
}

function ref_132ce(var0) {
  return isDefined(var0);
}

function ref_132cd(var0) {
  return isDefined(var0);
}

function ref_129fd() {
  var0 = ["mus_cp_stealth_1", "mus_cp_stealth_2", "mus_cp_stealth_3", "mus_cp_stealth_4", "mus_cp_stealth_5", "mus_cp_stealth_6"];

  for(var1 = 0; var1 < 5; var1++) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  level.ref_13894 = var0;
  level.ref_13895 = 0;
}

function rear_spawn_type_adjuster() {
  var0 = level.ref_13894[level.ref_13895];
  level.ref_13895++;

  if(level.ref_13895 == level.ref_13894.size - 1) {
    ref_129fd();
  }

  return var0;
}

function ref_129fe() {
  var0 = ["mus_cp_stealth_broken_1", "mus_cp_stealth_broken_2", "mus_cp_stealth_broken_3", "mus_cp_stealth_broken_4", "mus_cp_stealth_broken_5", "mus_cp_stealth_broken_6"];

  for(var1 = 0; var1 < 5; var1++) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  level.ref_13896 = var0;
  level.ref_13897 = 0;
}

function rear_spotlight_angles_offset() {
  var0 = level.ref_13896[level.ref_13897];
  level.ref_13897++;

  if(level.ref_13897 == level.ref_13896.size - 1) {
    ref_129fe();
  }

  return var0;
}

function ref_123c4(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("play_alert_music_to_player");
  var0 endon("play_alert_music_to_player");
  var1 = 3;

  if(!isDefined(var0.ref_1273e)) {
    var2 = rear_spawn_type_adjuster();
    var0.ref_1273e = var2;
    scripts\cp\utility::ref_123fe(var2, var0);
  }

  var3 = level scripts\engine\utility::ref_143b9(var1, "weapons_free");
  var0.ref_1273e = undefined;
  var0 setplayermusicstate("");
}

function play_combat_music_to_players() {
  scripts\cp\utility::ref_123fe(rear_spotlight_angles_offset(), level.players);
}

function getbestintersectionpt(var0, var1, var2) {
  var0.ref_124d1 = var1;
  var0.ref_12a6e = var2;
  thread change_stealth_state_to(var0, var0);
}

function logloadoutcopy(var0) {
  foreach(var2 in level.players) {
    if(var2.name == var0.ref_124d1) {
      logevent_playerregen(var2, var0.ref_12a6e);
      continue;
    }

    logevent_servermatchend(var2, var0.ref_124d1, var0.ref_12a6e);
  }
}

function logevent_playerregen(var0, var1) {
  switch (var1) {
    case "enemies_are_alerted":
      var0 iprintlnbold("^1You ^7have alerted the enemies");
      break;
    case "player_spotted":
      var0 iprintlnbold("^1You ^7have been spotted by the enemies");
      break;
  }
}

function logevent_servermatchend(var0, var1, var2) {
  switch (var2) {
    case "enemies_are_alerted":
      var0 iprintlnbold("^1" + var1 + "^7 has alerted the enemies");
      break;
    case "player_spotted":
      var0 iprintlnbold("^1" + var1 + "^7 has been spotted by the enemies");
      break;
  }
}

function ref_134e4() {
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
  var0 = ["dx_cst_aq1_alert_reset_10", "dx_cst_aq2_alert_reset_10", "dx_cst_aq3_alert_reset_10", "dx_cst_aq4_alert_reset_10"];
  return var0[randomint(var0.size)];
}

function puddle_structs() {
  var0 = ["dx_cst_aq1_investigate_generic_10", "dx_cst_aq2_investigate_generic_10", "dx_cst_aq3_investigate_generic_10", "dx_cst_aq4_investigate_generic_10"];
  return var0[randomint(var0.size)];
}

function propane_detonate_fiery_drips() {
  var0 = ["dx_cst_aq1_coverblown_generic_10", "dx_cst_aq2_coverblown_generic_10", "dx_cst_aq3_coverblown_generic_10", "dx_cst_aq4_coverblown_generic_10"];
  return var0[randomint(var0.size)];
}

function projectileimpactthermite() {
  var0 = ["dx_cst_aq1_combat_generic_10", "dx_cst_aq2_combat_generic_10", "dx_cst_aq3_combat_generic_10", "dx_cst_aq4_combat_generic_10"];
  return var0[randomint(var0.size)];
}

function raritycamlarge() {
  var0 = ["dx_cst_aq1_sight_generic_10", "dx_cst_aq2_sight_generic_10", "dx_cst_aq3_sight_generic_10", "dx_cst_aq4_sight_generic_10"];
  return var0[randomint(var0.size)];
}

function propnumclones() {
  var0 = ["dx_cst_aq1_explosion_generic_10", "dx_cst_aq2_explosion_generic_10", "dx_cst_aq3_explosion_generic_10", "dx_cst_aq4_explosion_generic_10"];
  return var0[randomint(var0.size)];
}

function propwaitminigamehudsetpoint() {
  var0 = ["dx_cst_aq1_grenade_danger_10", "dx_cst_aq2_grenade_danger_10", "dx_cst_aq3_grenade_danger_10", "dx_cst_aq4_grenade_danger_10"];
  return var0[randomint(var0.size)];
}

function ray_trace_trigger_radius_2d() {
  var0 = ["dx_cst_aq1_silenced_shot_10", "dx_cst_aq2_silenced_shot_10", "dx_cst_aq3_silenced_shot_10", "dx_cst_aq4_silenced_shot_10"];
  return var0[randomint(var0.size)];
}

function propwatchcleanupondisconnect() {
  var0 = ["dx_cst_aq1_gunshot_generic_10", "dx_cst_aq2_gunshot_generic_10", "dx_cst_aq3_gunshot_generic_10", "dx_cst_aq4_gunshot_generic_10"];
  return var0[randomint(var0.size)];
}

function propwatchcleanuponroundend() {
  var0 = ["dx_cst_aq1_gunshot_teammate_10", "dx_cst_aq2_gunshot_teammate_10", "dx_cst_aq3_gunshot_teammate_10", "dx_cst_aq4_gunshot_teammate_10"];
  return var0[randomint(var0.size)];
}

function pressure_timeout() {
  var0 = ["dx_cst_aq1_ally_killed_10", "dx_cst_aq2_ally_killed_10", "dx_cst_aq3_ally_killed_10", "dx_cst_aq4_ally_killed_10"];
  return var0[randomint(var0.size)];
}

function race_set_player_safe() {
  var0 = ["dx_cst_aq1_proximity_generic_10", "dx_cst_aq2_proximity_generic_10", "dx_cst_aq3_proximity_generic_10", "dx_cst_aq4_proximity_generic_10"];
  return var0[randomint(var0.size)];
}

function propsizetext() {
  var0 = ["dx_cst_aq1_footstep_generic_10", "dx_cst_aq2_footstep_generic_10", "dx_cst_aq3_footstep_generic_10", "dx_cst_aq4_footstep_generic_10"];
  return var0[randomint(var0.size)];
}

function propspawnorigin() {
  var0 = ["dx_cst_aq1_footstep_sprint_10", "dx_cst_aq2_footstep_sprint_10", "dx_cst_aq3_footstep_sprint_10", "dx_cst_aq4_footstep_sprint_10"];
  return var0[randomint(var0.size)];
}

function recent_spawn_threshold() {
  var0 = ["dx_cst_aq1_team_inquiry_10", "dx_cst_aq2_team_inquiry_10", "dx_cst_aq3_team_inquiry_10", "dx_cst_aq4_team_inquiry_10"];
  return var0[randomint(var0.size)];
}

function put_passenger_in_truck() {
  var0 = ["dx_cst_aq1_lost_sight_10", "dx_cst_aq2_lost_sight_10", "dx_cst_aq3_lost_sight_10", "dx_cst_aq4_lost_sight_10"];
  return var0[randomint(var0.size)];
}

function proximity_explode() {
  var0 = ["dx_cst_aq1_hunt_firstlost_10", "dx_cst_aq2_hunt_firstlost_10", "dx_cst_aq3_hunt_firstlost_10", "dx_cst_aq4_hunt_firstlost_10"];
  return var0[randomint(var0.size)];
}