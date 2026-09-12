/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_soa_tower_ai_event.gsc
**********************************************************/

function init() {
  if(getdvarint("scr_arms_deal_enabled", 1) > 0 && istrue(level.tryupdategenericprogress)) {
    ac130_flight_path::registerscriptedagent();
    module_set_script_origin_other_on_ai();
    thread object_is_valid();
    return;
  }
}

function module_set_script_origin_other_on_ai() {
  if(!isDefined(level.ai_event)) {
    level.ai_event = spawnStruct();
  }

  level.ai_event.bnoself = getdvarint("scr_arms_deal_ai_event_cooldown_time", 15);
  level.ai_event.bodyonly_guy_in_car_damage_monitor = getdvarfloat("scr_arms_deal_ai_event_timeout_time", 180);
  level.ai_event.binoculars_setuidata = getdvarint("scr_arms_deal_total_agent_points_wave_1", 15);
  level.ai_event.binoculars_showtargetmarker = getdvarint("scr_arms_deal_total_agent_points_wave_2", 50);
  level.ai_event.binoculars_targetismarked = getdvarint("scr_arms_deal_total_agent_points_wave_3", 25);
  level.ai_event.binoculars_updateheadiconvisibilityforplayer = getdvarint("scr_arms_deal_agent_spawn_count_max", 8);
  level.ai_event.binoculars_targetisvalidmark = getdvarint("scr_arms_deal_agent_spawn_count_base", 6);
  level.ai_event.binoculars_updateprojectiondistance = getdvarint("scr_arms_deal_agent_spawn_count_min", 6);
  level.ai_event.binoculars_updateheadiconvisibility = getdvarint("scr_arms_deal_agent_spawn_count_gain_per_wave", 2);
  level.ai_event.binoculars_updateuidata = getdvarint("scr_arms_deal_agent_spawn_next_group_threshold", 7);
  level.ai_event.binoculars_registertargetstate = getdvarint("scr_arms_deal_agent_health_value_default", 100);
  level.ai_event.binoculars_ontake = getdvarint("scr_arms_deal_agent_armor_value_default", 250);
  level.ai_event.binoculars_processlosqueue = getdvarint("scr_arms_deal_agent_armor_gain_per_wave", 50);
  level.ai_event.binoculars_targetisvalid = getdvarfloat("scr_arms_deal_agent_reposition_interval", 5);
  level.ai_event.binoculars_onstateunmarkedexit = getdvarfloat("scr_arms_deal_agent_accuray_max", 0.45);
  level.ai_event.binoculars_onstatemarkpendingupdate = getdvarfloat("scr_arms_deal_agent_accuray_base", 0.27);
  level.ai_event.binoculars_onstateunmarkedupdate = getdvarfloat("scr_arms_deal_agent_accuray_min", 0.25);
  level.ai_event.binoculars_onstateunmarkedenter = getdvarfloat("scr_arms_deal_agent_accuray_gain_per_wave", 0.12);
  level.ai_event.binoculars_processlosqueuelow = getdvarint("scr_arms_deal_agent_brute_health_default", 10000);
  level.ai_event.binoculars_processlosqueuehigh = getdvarint("scr_arms_deal_agent_brute_armor_default", 10000);
  level.ai_event.binoculars_updatetargetmarker = getdvarfloat("scr_arms_deal_agent_spawn_delay_after_brute_spawn", 0);
  level.ai_event.binoculars_processtargetlos = getdvarfloat("scr_arms_deal_agent_agent_brute_stop_agent_spawns_at_health_percentage", 0.2);
  level.ai_event.binoculars_removeheadicon = getdvarint("scr_arms_deal_agent_melee_damage", 30);
  level.ai_event.binoculars_processtargetdata = getdvarint("scr_arms_deal_agent_brute_melee_damage", 90);
  level.ai_event.ref_11C20 = getdvarfloat("scr_arms_deal_agent_minimap_ping_lifetime", 0.5);
  level.ai_event.ref_11C1F = getdvarfloat("scr_arms_deal_agent_minimap_ping_interval", 2.5);
}

function object_is_valid() {
  scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
  level.agent_funcs["actor_enemy_lw_br"]["on_damaged"] = &black_screen_overlay;
  level.agent_funcs["actor_enemy_lw_br_brute"]["on_damaged"] = &black_screen_overlay;
  level.agent_funcs["actor_enemy_lw_br"]["gametype_on_damage_finished"] = &blade_trigger_think;
  level.agent_funcs["actor_enemy_lw_br_brute"]["gametype_on_damage_finished"] = &blade_trigger_think;
  level.disable_oob_immunity_on_riders = 1;
  level.playerentersafearea = &ref_1320F;

  if(!isDefined(level.ai_event)) {
    level.ai_event = spawnStruct();
  }

  level.ai_event.inited = 0;
  level.ai_event.states = ["inactive", "wave_incoming", "wave_active", "wave_active_brute", "wave_complete", "complete"];
  level.ai_event.current_state = "inactive";
  level.ai_event.ref_13B97 = -1;
  level.ai_event.spawn_points = scripts\engine\utility::getStructArray("agent_spawn_point_team_200", "targetname");
  level.ai_event.ref_135B5 = [];
  level.ai_event.helidestroyvehiclestouchtrace = [];
  level.ai_event.select_hostage_room_three_spawners = bomb_wires_to_cut();
  level.ai_event.select_hostage_room_two_spawners = [];
  level.ai_event.occupied_rpg_trig = getEnt("br_soa_tower_ai_event_vol", "targetname");
  level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(level.ai_event.occupied_rpg_trig, &ref_13DAB, &ref_13DAC, undefined, undefined, &ref_13DA5);
  level.ai_event.ref_12659 = [];
  level.ai_event.ref_12662 = [];
  level.ai_event.ref_12663 = [];
  level.ai_event.ref_12660 = [];
  level.ai_event.brclearscoreboardstats = [];
  level.ai_event.ref_13BE2 = 0;
  level.ai_event.ref_13BE3 = [];
  level.ai_event.ref_13BE4 = 0;
  level.ai_event.ref_14525 = [];
  level.ai_event.new_col_map = -1;
  level.ai_event.enemy_mine_damaged_think = 0;
  level.ai_event.binoculars_settargetmarkerstate = [];
  level.ai_event.binoculars_settargetmarkerstate[0] = getdvarint("scr_arms_deal_total_agent_points_wave_0", 10);
  level.ai_event.binoculars_settargetmarkerstate[1] = level.ai_event.binoculars_setuidata;
  level.ai_event.binoculars_settargetmarkerstate[2] = level.ai_event.binoculars_setuidata;
  level.ai_event.binoculars_settargetmarkerstate[3] = level.ai_event.binoculars_setuidata;
  level.ai_event.pour = 1;
  level.ai_event.nolandingdamage = [];
  level.ai_event.ref_13005 = [];
  level.ai_event.nogroundfoundtime = ["smg", "smg_frag", "smg_molotov", "smg_flash", "smg_gas", "smg_smoke", "assault", "assault_frag", "assault_molotov", "assault_flash", "assault_gas", "assault_smoke", "brute_danny_the_firecracker", "brute_johnny_the_detonator", "brute_tommy_the_toxic", "brute_gary_the_blinder", "brute_anthony_fogwalker"];
  level.ai_event.initoperatorunlocks = 0;
  level.ai_event.ref_14528 = "NULL";
  level.ai_event.start_coop_escort_enter_vehicles = 0;
  waittillframeend();
  scripts\mp\gametypes\br_soa_tower_rewards::init();
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  thread objectives_finale();
  thread blockade_get_bomb_icon_on_cell_phone();
}

function objectives_finale() {
  var_0 = scripts\engine\utility::getStruct("arms_deal_start_button", "targetname");
  var_1 = 0;
  var_2 = scripts\engine\utility::ter_op(var_1, (8, 17, 3), (0, 0, 0));
  var_3 = scripts\mp\gameobjects::createhintobject(var_0.origin + var_2, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/AI_EVENT_INTERACT");
  thread objectivespawner();
  var_3 waittill("trigger");
  var_3 notify("kill_interact_fx");
  var_3 delete();
  thread obj_room_fire_05();
}

function objectivespawner() {
  self endon("death");
  self endon("kill_interact_fx");

  for(;;) {
    playsoundatpos(self.origin, "emt_soa_static_glitch");
    wait 4;
  }
}

function obj_room_fire_05() {
  thread objectiveachievementkillcount();
  wait 0.01;

  if(level.ai_event.initoperatorunlocks < 1) {
    objective_minimapupdate("br_soa_tower_event_arms_deal");
  }

  level.ai_event.start_coop_escort_enter_vehicles = 1;
  level.ai_event.initoperatorunlocks += 1;
  ref_13EE8();
  objectivelocations(level.ai_event);
}

function objective_hide_for_mlg_spectator() {
  if(!level.ai_event.pour) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, 1, ["brute_danny_the_firecracker", "brute_johnny_the_detonator", "brute_tommy_the_toxic", "brute_gary_the_blinder", "brute_anthony_fogwalker"]);
}

function objectivelocations() {
  obj_room_fire_06(level.ai_event);
  objective_hide_for_mlg_spectator(level.ai_event);
  var_0 = level.ai_event.nolandingdamage[level.ai_event.initoperatorunlocks];

  switch (level.ai_event.initoperatorunlocks) {
    case 1:
      thread bomb_detonator_holder(level.ai_event, var_0, 4, 7);
      break;
    case 2:
      thread bomb_detonator_holder(level.ai_event, level.ai_event.ref_13005, 3, 5);
      thread bomb_detonator_holder(level.ai_event, var_0, 4, 7, level.ai_event.binoculars_settargetmarkerstate[2]);
      break;
    default:
      thread bomb_detonator_holder(level.ai_event, level.ai_event.nogroundfoundtime, 3, 6);
      break;
  }

  obj_room_fire_11(level.ai_event);
}

function obj_room_fire_06() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  level.ai_event.current_state = "wave_incoming";
  ref_13EEA("wave_incoming");
  var_0 = 0;
  var_1 = gettime() / 1000;
  var_2 = gettime() / 1000;
  var_3 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks == 1, 1, 10);

  for(;;) {
    var_4 = gettime() / 1000;
    var_0 = var_3 - var_4 - var_1;

    foreach(var_6 in level.ai_event.ref_12662) {
      if(isDefined(var_6.boardroomdoorcodeentrysuccess)) {
        var_6.boltunlink setvalue(ceil(var_0));

        if(var_4 - var_2 > 1) {
          var_7 = objloc(var_0);
          var_6 playlocalsound(var_7);
          var_2 = gettime() / 1000;
        }
      }
    }

    if(var_0 <= 0) {
      break;
    }

    waitframe();
  }

  if(level.ai_event.initoperatorunlocks > 1) {
    foreach(var_6 in level.ai_event.ref_12662) {
      var_6 playlocalsound("iw8_games_splash_silver");
    }
  }

  level.ai_event.ref_13B97 = gettime();
  level.ai_event.current_state = "wave_active";
  level.ai_event.new_col_map = level.ai_event.binoculars_settargetmarkerstate[level.ai_event.initoperatorunlocks];
  ref_13EEA("wave_active");
}

function obj_room_fire_11() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  var_0 = gettime() / 1000;
  var_1 = 0;
  var_2 = undefined;

  for(;;) {
    var_3 = gettime() / 1000;
    var_1 = floor(var_3 - var_0);

    if(var_1 >= level.ai_event.bodyonly_guy_in_car_damage_monitor && level.ai_event.ref_12662.size == 0) {
      level.ai_event.initoperatorunlocks -= 1;
      var_2 = "timeout";
      break;
    }

    if(level.ai_event.brclearscoreboardstats.size <= 0 && level.ai_event.ref_14525.size == 0) {
      var_2 = "success";
      break;
    }

    wait 0.1;
  }

  obj_room_fire_10(var_2);
}

function obj_room_fire_10(var_0) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");

  switch (var_0) {
    case "success":
      level.ai_event.current_state = "wave_complete";
      ref_13EEA("wave_complete");

      if(level.ai_event.initoperatorunlocks < 2) {
        objective_minimapupdate("br_soa_tower_ai_event_wave_cleared", int(level.ai_event.initoperatorunlocks));
        wait 0.1;
        thread obj_room_fire_05();
      } else {
        objective_minimapupdate("br_soa_tower_event_arms_deal_complete_full_splash");
        level.ai_event.current_state = "complete";
        ref_13EEA("complete");
        scripts\mp\gametypes\br_soa_tower_rewards::ref_12D21("most_agent_kills");

        foreach(var_2 in level.ai_event.ref_12662) {
          if(getdvarint("MLNNMOPQOP", 0) == 6) {
            var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
          }
        }

        objectiveloc();
      }

      break;
    case "timeout":
      objective_minimapupdate("br_soa_tower_ai_event_timer_expired");

      foreach(var_5 in level.ai_event.brclearscoreboardstats) {
        var_5.ref_11E90 = 1;
        var_5[[var_5.isinlaststand]]();
        var_5 kill();
      }

      objectiveloc();
      break;
  }
}

function objectiveloc() {
  level.ai_event.pour = 1;
  level.ai_event.ref_13005 = [];
  level.ai_event.enemy_mine_damaged_think = 0;
  level.ai_event.start_coop_escort_enter_vehicles = 0;
  level.ai_event.ref_13B97 = -1;
  level.ai_event.initoperatorunlocks = 0;
  level.ai_event.current_state = "inactive";
  level.ai_event.new_col_map = -1;
  level.ai_event.ref_14525 = [];
  ref_13EE9();

  foreach(var_1 in level.ai_event.ref_12660) {
    var_1.boardroomopen = 0;
    var_1.body0 = 0;
  }

  level.ai_event.ref_12660 = [];
  thread objectives_finale();
  level.ai_event notify("soa_tower_stop_ai_event");
}

function objectiveachievementkillcount() {
  level endon("game_ended");
  level.ai_event endon("soa_tower_stop_ai_event");
  level.ai_event notify("stop_subscription_watcher");
  level.ai_event endon("stop_subscription_watcher");

  for(;;) {
    var_0 = scripts\engine\utility::array_combine_unique(level.ai_event.ref_12659, level.ai_event.ref_12662);

    foreach(var_2 in var_0) {
      var_3 = objective_set_hot(var_2);

      if(!var_3 && objectiveids(var_2)) {
        objective_timers_reset_both(var_2);
      } else if(isalive(var_2)) {
        objectiveicon(var_2);
      } else {
        objectivedescription(var_2);
      }

      var_4 = gettime() / 1000;

      foreach(var_2 in level.ai_event.ref_12663) {
        var_6 = gettime() / 1000 - var_2.boltunlinkonnote / 1000;
        var_7 = var_2.boltdeletethread;

        if(isDefined(var_7)) {
          if(var_7.hidden) {
            var_7 scripts\mp\hud_util::showelem();
          }

          var_7 setvalue(ceil(10 - var_6));
        }

        if(objectiveids(var_2)) {
          objective_timers_reset_both(var_2);

          if(isDefined(var_7)) {
            var_7 scripts\mp\hud_util::hideelem();
          }

          continue;
        }

        if(var_6 >= 10) {
          objectivedescription(var_2);
          objective_locations_logic(var_2, "br_soa_tower_ai_event_unsubscribe");
        }
      }
    }

    wait 0.1;
  }
}

function objective_timers_reset_both() {
  if(!isDefined(self)) {
    return;
  }

  if(!objective_set_hot()) {
    level.ai_event.ref_12662 = scripts\engine\utility::array_add(level.ai_event.ref_12662, self);
    self.boardroomopen = 0;
    self.body0 = 0;
    ref_13EF3();

    if(level.ai_event.current_state != "inactive") {
      objective_locations_logic(self, "br_soa_tower_event_arms_deal");
      return;
    }

    return;
  }

  if(objective_origin()) {
    self.boltunlinkonnote = undefined;
    level.ai_event.ref_12663 = scripts\engine\utility::array_remove(level.ai_event.ref_12663, self);
    return;
  }
}

function objectivedescription() {
  if(!isDefined(self)) {
    return;
  }

  if(objective_set_hot()) {
    ref_13EF4();
    level.ai_event.ref_12662 = scripts\engine\utility::array_remove(level.ai_event.ref_12662, self);
    level.ai_event.ref_12663 = scripts\engine\utility::array_remove(level.ai_event.ref_12663, self);
    return;
  }
}

function objectiveicon() {
  if(!isDefined(self)) {
    return;
  }

  if(objective_set_hot() && !objective_origin()) {
    self.boltunlinkonnote = gettime();
    level.ai_event.ref_12663 = scripts\engine\utility::array_add(level.ai_event.ref_12663, self);
    return;
  }
}

function objectiveids() {
  if(!isDefined(self)) {
    return false;
  }

  var_0 = 150;
  var_1 = abs(self.origin[2] - level.ai_event.occupied_rpg_trig.origin[2] - var_0) < 100;

  if(scripts\engine\utility::array_contains(level.ai_event.ref_12659, self) && var_1) {
    return true;
  }

  return false;
}

function objective_set_hot() {
  if(!isDefined(self)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ai_event.ref_12662, self);
}

function objective_origin() {
  if(!isDefined(self)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ai_event.ref_12663, self);
}

function objectives_amount(var_0) {
  foreach(var_2 in level.ai_event.brclearscoreboardstats) {
    if(isDefined(var_2.squadleaderbeacon_fxent)) {
      if(var_0) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.squadleaderbeacon_fxent, self);
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2.squadleaderbeacon_fxent, self);
    }
  }
}

function objective_show_for_mlg_spectator() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!scripts\engine\utility::array_contains(level.ai_event.ref_12660, self)) {
    level.ai_event.ref_12660 = scripts\engine\utility::array_add(level.ai_event.ref_12660, self);
    self.boardroomopen = 0;
    self.body0 = 0;
    return;
  }
}

function objloc(var_0) {
  return "ui_mp_timer_countdown_10";
}

function ref_13DAB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(issubstr(var_1.targetname, "event")) {
    if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level.ai_event.ref_12659, var_0)) {
      level.ai_event.ref_12659 = scripts\engine\utility::array_add(level.ai_event.ref_12659, var_0);
      objectives_amount(var_0, 1);
    }
  }

  if(issubstr(var_1.targetname, "garage")) {
    var_2 = getsubstr(var_1.targetname, 11);

    if(isDefined(var_0.waittill_any_timeout_5)) {
      if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0)) {
        level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0);
      }
    }

    if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0)) {
      level.ai_event.select_hostage_room_three_spawners[var_2].players = scripts\engine\utility::array_add(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0);
      var_0.waittill_any_timeout_5 = var_2;
      return;
    }

    return;
  }
}

function ref_13DAC(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(issubstr(var_1.targetname, "event")) {
    if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.ref_12659, var_0)) {
      level.ai_event.ref_12659 = scripts\engine\utility::array_remove(level.ai_event.ref_12659, var_0);
      objectives_amount(var_0, 0);

      if(isDefined(var_0.waittill_any_timeout_5)) {
        if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0)) {
          level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0);
        }
      }
    }
  }

  if(issubstr(var_1.targetname, "garage")) {
    waitframe();
    var_2 = getsubstr(var_1.targetname, 11);
    var_3 = var_2 != var_0.waittill_any_timeout_5;

    if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0) && var_3) {
      level.ai_event.select_hostage_room_three_spawners[var_2].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0);
      return;
    }

    return;
  }
}

function ref_13DA5(var_0, var_1) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isPlayer(var_0)) {
    return true;
  }

  return false;
}

function objective_minimapupdate(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.intvar = var_1;
  }

  foreach(var_4 in level.ai_event.ref_12662) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_4, var_0, var_2);
  }
}

function objective_locations_logic(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, var_1, var_3);
}

function ref_1320F() {
  if(scripts\mp\utility\game::getgametype() != "brtdm") {
    return;
  }

  if(!isDefined(level.teamnamelist) || !scripts\engine\utility::array_contains(level.teamnamelist, "team_two_hundred")) {
    return;
  }

  scripts\mp\utility\teams::setteamdata("team_two_hundred", "teamCount", 999);
}

function bot_allowed_weapons(var_0, var_1, var_2, var_3) {
  var_4 = issubstr(var_2, "brute");
  var_5 = scripts\mp\mp_agent::spawnnewagent(scripts\engine\utility::ter_op(var_4, "actor_enemy_lw_br_brute", "actor_enemy_lw_br"), "team_two_hundred", var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }

  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_add(level.ai_event.brclearscoreboardstats, var_5);
  thread bomber_death_thread();
  var_5.type = var_2;
  var_5.enemy_left_monitor = var_4;
  var_5 scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("frag_grenade_mp", 1);
  bomb_detonator_bomb_type(var_5);
  bomber(var_5);
  thread bomber_delay_thread();
  var_5.guid = var_5 getguid();
  var_5.name = var_5.guid;
  var_5.agentname = &"BR_SOA_EVENT/HENCHMAN";
  boss_one_minion_watcher(var_5);
  bomb_detonator_waiting_for_pick_up(var_5);
  boss_two_minion_watcher(var_5, var_2);
  boss_fight_combat_forest(var_5, var_3);

  if(var_4) {
    boss_fight_combat_laser_trap(var_5);

    foreach(var_7 in level.ai_event.ref_12662) {
      var_7 playlocalsound("ui_splash_zxp_juggspawn");
    }

    if(level.ai_event.initoperatorunlocks == 2) {
      level.ai_event.enemy_mine_damaged_think = 1;
      ref_13EEA("wave_active_brute");
    }
  }

  thread bonuskillscharge();
  thread bot_choose_attack_zone();
  return var_5;
}

function bomber() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self.ref_1407D = 0;
}

function boss_one_minion_watcher() {
  self.maxhealth = level.ai_event.binoculars_registertargetstate;
  self.health = level.ai_event.binoculars_registertargetstate;
  self.health_remaining = level.ai_event.binoculars_registertargetstate;
  self.showseasonalcontent = level.ai_event.binoculars_registertargetstate;
  self.showsplashtoall = level.ai_event.binoculars_registertargetstate;
  self.meleedamageoverride = level.ai_event.binoculars_removeheadicon;
  self.sound_events = 0;
  self.ref_12D29 = undefined;
  self.ref_12D2A = undefined;
  self.ref_12D25 = 0;
  var_0 = level.ai_event.binoculars_onstateunmarkedexit;
  var_1 = level.ai_event.binoculars_onstatemarkpendingupdate;
  var_2 = level.ai_event.binoculars_onstateunmarkedupdate;
  var_3 = level.ai_event.binoculars_onstateunmarkedenter;
  var_4 = var_1 + var_3 * (level.ai_event.initoperatorunlocks - 1);
  var_5 = clamp(var_4, var_2, var_0);
  self.baseaccuracy = var_5;
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  self.isinlaststand = &blank_relic_func;
  self.ref_119EA = &scripts\mp\gametypes\br_soa_tower_rewards::ref_119F7;
  self.ref_130DF = &scripts\mp\gametypes\br_soa_tower_rewards::ref_12D28;
  self.scriptable_carriable_damage = &scripts\mp\gametypes\br_soa_tower_rewards::ref_12D22;
  self.ref_11E90 = scripts\mp\utility\game::getgametype() == "brtdm";
  self.enemy_mine_proximity_think = 0;
  self.ignoreall = getdvarint("scr_br_arms_ai_diable_agent_fire", 0);
}

function bomber_death_thread() {
  self endon("death");
  level endon("game_ended");
  var_0 = randomfloatrange(1.25, 2.75);
  wait var_0;
  scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest(self);
  scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent("move", "movecombat", anim.player);
}

function bomb_detonator_waiting_for_pick_up(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!isDefined(var_0)) {
      var_1 = level.ai_event.binoculars_ontake;
      var_2 = level.ai_event.binoculars_processlosqueue;
      var_0 = var_1 + clamp(level.ai_event.initoperatorunlocks - 1, 0, 10) * var_2;
    }

    scripts\mp\gametypes\br_armor::teamfriendlyto();
    scripts\mp\gametypes\br_armor::searchcirclesize();
    boss_fight_combat_cave(var_0);
    return;
  }
}

function boss_fight_combat_cave(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }

  self.br_maxarmorhealth = var_0;
  self.br_armorhealth = var_0;
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    return;
  }
}

function boss_two_minion_watcher(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(issubstr(var_0, "assault")) {
    bomb_hostage_play_anim("iw8_ar_akilo47");
    self.goalradius = randomintrange(100, 200);
  }

  if(issubstr(var_0, "smg")) {
    bomb_hostage_play_anim("iw8_sm_mpapa5");
    self.goalradius = randomintrange(50, 100);
  }

  var_1 = undefined;

  if(issubstr(var_0, "frag")) {
    var_1 = "frag_grenade_mp";
  }

  if(issubstr(var_0, "molotov")) {
    var_1 = "molotov_mp";
  }

  if(issubstr(var_0, "flash")) {
    var_1 = "flash_grenade_mp";
  }

  if(issubstr(var_0, "gas")) {
    var_1 = "gas_grenade_mp";
  }

  if(issubstr(var_0, "smoke")) {
    var_1 = "smoke_grenade_mp";
  }

  if(isDefined(var_1)) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F(var_1, 2);
  }

  if(self.enemy_left_monitor) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("frag_grenade_mp", 10);
    self.baseaccuracy = 0.65;
    self.meleedamageoverride = 30;
    self.scripted_long_deaths = 1;
    self.maxhealth = level.ai_event.binoculars_processlosqueuelow;
    self.health = level.ai_event.binoculars_processlosqueuelow;
    self.health_remaining = level.ai_event.binoculars_processlosqueuelow;
    self.showseasonalcontent = level.ai_event.binoculars_processlosqueuelow;
    self.showsplashtoall = level.ai_event.binoculars_processlosqueuelow;
    self.agentdamagefeedback = 0;
    self.eliminate_drone_minigun_speed = 8000;
    self.eliminate_drone_internal = 5;
    self.meleedamageoverride = level.ai_event.binoculars_processtargetdata;
    boss_fight_combat_cave(level.ai_event.binoculars_processlosqueuehigh);

    switch (var_0) {
      case "brute_danny_the_firecracker":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("molotov_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mike4", 30);
        boss_wave(10);
        self.agentname = &"BR_SOA_EVENT/BRUTE_DANNY";
        break;
      case "brute_johnny_the_detonator":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("frag_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mike4", 32);
        boss_wave(11);
        self.agentname = &"BR_SOA_EVENT/BRUTE_JOHNNY";
        break;
      case "brute_tommy_the_toxic":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("gas_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mcharlie", 24);
        boss_wave(12);
        self.agentname = &"BR_SOA_EVENT/BRUTE_TOMMY";
        break;
      case "brute_gary_the_blinder":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("flash_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_akilo47", 20);
        boss_wave(13);
        self.agentname = &"BR_SOA_EVENT/BRUTE_GARY";
        break;
      case "brute_anthony_fogwalker":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349F("smoke_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_anovember94", 3);
        boss_wave(14);
        self.agentname = &"BR_SOA_EVENT/BRUTE_ANTHONY";
        break;
    }

    return;
  }

  boss_wave(level.ai_event.initoperatorunlocks);
}

function boss_fight_combat_forest(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, scripts\engine\utility::random(level.ai_event.select_hostage_room_three_spawners));
  self setgoalvolumeauto(var_1);
}

function bomb_hostage_play_anim(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["laserrange", "none", "none", "none", "none", "none"], "none", "none", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

function bombzone_press_use(var_0) {
  if(level.ai_event.brclearscoreboardstats.size <= var_0 && level.ai_event.ref_14525.size == 0) {
    foreach(var_2 in level.ai_event.brclearscoreboardstats) {
      if(!isDefined(var_2.squadleaderbeacon_fxent)) {
        boss_fight_combat_laser_trap(var_2);
      } else {
        continue;
      }

      var_3 = scripts\engine\utility::array_randomize(level.ai_event.select_hostage_room_three_spawners);
      var_4 = scripts\engine\utility::random(var_3);

      foreach(var_6 in var_3) {
        if(var_6.players.size > var_4.players.size) {
          var_4 = var_6;
        }
      }

      var_2 setgoalvolumeauto(var_4);
    }

    return;
  }
}

function boss_fight_combat_laser_trap() {
  var_0 = undefined;
  var_1 = undefined;

  if(self.enemy_left_monitor) {
    var_1 = "icon_waypoint_jugg";
    var_0 = "BR_SOA_EVENT/BRUTE_";
    var_2 = undefined;

    switch (self.type) {
      case "brute_danny_the_firecracker":
        var_2 = "DANNY";
        break;
      case "brute_johnny_the_detonator":
        var_2 = "JOHNNY";
        break;
      case "brute_tommy_the_toxic":
        var_2 = "TOMMY";
        break;
      case "brute_gary_the_blinder":
        var_2 = "GARY";
        break;
      case "brute_anthony_fogwalker":
        var_2 = "ANTHONY";
        break;
    }

    if(isDefined(var_2)) {
      var_0 += var_2;
    }
  } else {
    var_1 = "icon_waypoint_generic";
  }

  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.squadleaderbeacon_fxent = var_3;
  objective_state(self.squadleaderbeacon_fxent, "current");
  objective_position(self.squadleaderbeacon_fxent, self.origin + (0, 0, 100));
  objective_setplayintro(self.squadleaderbeacon_fxent, self.enemy_left_monitor);
  objective_setshowoncompass(self.squadleaderbeacon_fxent, 0);
  objective_setshowdistance(self.squadleaderbeacon_fxent, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(self.squadleaderbeacon_fxent, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.squadleaderbeacon_fxent, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.squadleaderbeacon_fxent, 80);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.squadleaderbeacon_fxent, self);

  if(isDefined(var_0)) {
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.squadleaderbeacon_fxent, var_0);
  }

  if(self.enemy_left_monitor) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(self.squadleaderbeacon_fxent, 1);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.squadleaderbeacon_fxent);

  foreach(var_5 in level.ai_event.ref_12662) {
    objectives_amount(var_5, 1);
  }
}

function boss_wave(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.ai_event.initoperatorunlocks;
  }

  var_1 = [];

  switch (var_0) {
    case 1:
      GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(30000, 50000));

    case 2:
      GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(5000, 12000));

    case 3:
      GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(3000, 6000));

    case 10:
      GscBinSkip0(0x2e, "AI_molotov_mp", randomintrange(2000, 4000));

    case 11:
      GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(2000, 6000));

    case 12:
      GscBinSkip0(0x2e, "AI_gas_mp", randomintrange(2000, 4000));

    case 13:
      GscBinSkip0(0x2e, "AI_flash_grenade_mp", randomintrange(2000, 6000));

    case 14:
      GscBinSkip0(0x2e, "AI_smoke_grenade_mp", randomintrange(2000, 5000));

    default:
      GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(5000, 20000));
  }

  if(var_1.size > 0) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134B1(var_1);
    return;
  }
}

function bot_choose_attack_zone() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }

    scripts\mp\weapons::grenadeinitialize(var_0, var_1, var_2, var_3);
    self notify("grenade_throw");

    if(!isDefined(var_0)) {
      return;
    }

    if(!isDefined(var_0.weapon_name)) {
      return;
    }

    var_0.spawnpos = var_0.origin;

    switch (var_0.weapon_name) {
      case "molotov_mp":
        thread scripts\mp\equipment\molotov::molotov_used(var_0);
        break;
      case "gas_grenade_mp":
        thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
        break;
    }
  }
}

function bonuskillscharge() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  self endon("terminate_ai_threads");
  self endon("death");
  var_0 = gettime() / 1000;

  for(;;) {
    var_1 = self getgoalvolume();
    var_2 = distance2d(self.origin, var_1.origin);
    var_3 = var_2 < 600;
    self.ref_145D4 = var_3;

    if(var_3) {
      var_4 = gettime() / 1000;
      var_5 = var_4 - var_0;
      self.ref_13B6B = var_5;
      var_6 = level.ai_event.binoculars_targetisvalid;
      self.ref_13B6C = var_6 - var_5;

      if(var_4 - var_0 >= var_6) {
        var_7 = [];

        foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var_9.players.size > 0 && var_9 != var_1) {
            var_7 = var_9;
          }
        }

        if(var_7.size > 0) {
          var_11 = scripts\engine\utility::random(var_7);
          self setgoalvolumeauto(var_11);
        }

        var_0 = gettime() / 1000;
      }
    } else {
      var_0 = gettime() / 1000;
    }

    wait 1;
  }
}

function bomber_delay_thread() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  self endon("terminate_ai_threads");
  self endon("death");

  while(!self.enemy_left_monitor) {
    self setperk("specialty_radarblip", 1);
    wait level.ai_event.ref_11C20;
    self unsetperk("specialty_radarblip", 1);
    wait level.ai_event.ref_11C1F;
  }
}

function bomb_detonator_bomb_type() {
  if(!ispointonnavmesh(self.origin, self, 1)) {
    var_0 = getclosestpointonnavmesh(self.origin, self);

    if(isDefined(var_0)) {
      self forceteleport(var_0, self.angles);
      return;
    }

    return;
  }
}

function black_screen_overlay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13.agent_type) || var_13.asm.archetype != "soldier_lw_br") {
    return;
  }

  var_14 = isDefined(var_1) && isPlayer(var_1);
  var_15 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_16 = var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE";
  var_17 = var_4 == "MOD_FIRE";

  if(var_14 || var_15) {
    var_18 = var_2;
    var_19 = weaponclass(var_5);
    var_20 = scripts\mp\utility\weapon::getweapongroup(var_5);
    var_21 = scripts\mp\utility\weapon::getequipmenttype(var_5.basename);
    var_22 = var_19 == "throwingknife";

    if(var_16 && var_19 == "grenade") {
      var_2 = var_18 * 2;
    }

    if(var_22) {
      var_2 = var_18 * 2.5;
    }
  }

  if(self.enemy_left_monitor && !self.enemy_mine_proximity_think) {
    var_23 = float(level.ai_event.binoculars_processlosqueuelow) * 0.2;

    if(self.health < var_23) {
      level.ai_event notify("stop_pending_agent_spawns");
      self.enemy_mine_proximity_think = 1;
    }
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

function blade_trigger_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0) + scripts\engine\utility::ter_op(isDefined(var_13), var_13, 0);
  [[self.ref_130DF]](var_1, var_12, var_4, var_15);

  if(self.enemy_left_monitor) {
    objective_show_for_mlg_spectator(var_1);
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

function blank_relic_func(var_0) {
  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_remove(level.ai_event.brclearscoreboardstats, self);

  if(!isDefined(level.ai_event.ref_13BE3[level.ai_event.initoperatorunlocks])) {
    level.ai_event.ref_13BE3[level.ai_event.initoperatorunlocks] = 0;
  }

  level.ai_event.ref_13BE3[level.ai_event.initoperatorunlocks] += 1;
  level.ai_event.ref_13BE2 += 1;
  bombzone_press_use(3);

  if(isDefined(self.squadleaderbeacon_fxent)) {
    objective_delete(self.squadleaderbeacon_fxent);
  }

  if(self.enemy_left_monitor) {
    objective_minimapupdate("br_soa_tower_reward_brute_eliminated");
    scripts\mp\gametypes\br_soa_tower_rewards::ref_12D21("most_brute_damage");
    level.ai_event notify("stop_pending_agent_spawns");
    level.ai_event.ref_14525 = [];

    foreach(var_2 in level.ai_event.ref_12662) {
      var_2 playlocalsound("br_splash_vip_eliminated");
      var_2 playlocalsound("mp_enemy_hvt_killed");
    }

    level.ai_event.enemy_mine_damaged_think = 0;
    bombzone_press_use(level.ai_event.brclearscoreboardstats.size);
    ref_13EEA("wave_active_brute");
  }

  level.ai_event.new_col_map--;
  ref_13EEC();

  if(!isDefined(var_0)) {
    return;
  }

  self.is_correct_wire_color = var_0;
  var_0.agent = self;
  objective_show_for_mlg_spectator(var_0.eattacker);
  var_4 = spawnStruct();
  var_4.eattacker = var_0.eattacker;
  var_4.origin = self.origin;
  var_4.angles = self.angles;

  if(!self.ref_11E90) {
    level.ai_event thread[[self.ref_119EA]]("loot_table_ammo", 1, var_4);
    level.ai_event thread[[self.ref_119EA]]("loot_table_cash", 1, var_4);
    level.ai_event thread[[self.ref_119EA]]("loot_table_gear", 1, var_4);
    level.ai_event thread[[self.ref_119EA]]("loot_table_deployables", 1, var_4);

    if(self.enemy_left_monitor) {
      level.ai_event thread[[self.ref_119EA]]("loot_table_brute", 25, var_4);
      level.ai_event thread[[self.ref_119EA]]("loot_table_deployables", 6, var_4);
      level.ai_event thread[[self.ref_119EA]]("loot_table_brute_legendary_weapon", 1, var_4);
      playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);

      if(getDvar("scr_br_gametype", "") == "bodycount") {
        level.ai_event thread[[self.ref_119EA]]("loot_table_power_grab_revive_token", 1, var_4);
      }
    }

    if(level.ai_event.initoperatorunlocks == 2 && level.ai_event.brclearscoreboardstats.size == 0) {
      playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);
      level.ai_event thread[[self.ref_119EA]]("loot_table_brute_vault_key", 1, var_4);

      if(getDvar("scr_br_gametype", "") == "bodycount") {
        level.ai_event thread[[self.ref_119EA]]("loot_table_power_grab_dog_tags", 2, var_4);
      }
    }
  }

  [[self.ref_130DF]](var_0.eattacker, var_0.shitloc, var_0.smeansofdeath, var_0.idamage);
  [[self.scriptable_carriable_damage]]("takedown");
  [[self.scriptable_carriable_damage]]("assist");
  [[self.scriptable_carriable_damage]]("killing_blow");
}

function bomb_detonator_holder(var_0, var_1, var_2, var_3, var_4) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level.ai_event endon("stop_pending_agent_spawns");
  level endon("game_ended");

  if(isDefined(var_4)) {
    wait var_4;
  }

  for(var_5 = undefined; !isDefined(var_5) || scripts\engine\utility::array_contains_key(level.ai_event.ref_14525, var_5); var_5 = randomint(1000)) {}

  level.ai_event.ref_14525 = scripts\engine\utility::array_add(level.ai_event.ref_14525, var_5);
  var_6 = level.ai_event.helidestroyvehiclestouchtrace;
  var_7 = var_3;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = randomintrange(var_1, var_2);
  var_11 = 0;

  while(var_7 > 0) {
    var_12 = level.ai_event.binoculars_updateheadiconvisibilityforplayer;
    var_13 = level.ai_event.binoculars_targetisvalidmark;
    var_14 = level.ai_event.binoculars_updateprojectiondistance;
    var_15 = level.ai_event.binoculars_updateheadiconvisibility * (level.ai_event.initoperatorunlocks - 1);
    var_16 = clamp(var_13 + var_15, var_14, var_12);

    while(level.ai_event.brclearscoreboardstats.size >= var_16) {
      wait 1;
    }

    if(var_11 >= var_10) {
      var_11 = 0;
    }

    if(var_11 == 0) {
      if(var_6.size == 0) {
        var_6 = level.ai_event.helidestroyvehiclestouchtrace;
      }

      var_8 = int(clamp(randomint(var_6.size), 0, var_6.size));
      var_9 = var_6[var_8];
      var_6 = scripts\engine\utility::array_remove_index(var_6, var_8, 0);
    }

    var_17 = scripts\engine\utility::random(var_0);
    var_18 = bmoovertime(var_17);
    var_19 = scripts\engine\utility::ter_op(1, 1, bomb_detonator_interact(var_17));

    if(issubstr(var_17, "brute")) {
      var_7 = var_19;
    }

    if(var_19 > var_7) {
      var_20 = [];

      foreach(var_22 in var_0) {
        if(var_19 <= var_7) {
          var_20 = var_22;
        }
      }

      if(var_20.size > 0) {
        var_17 = scripts\engine\utility::random(var_20);
      } else {
        var_18 = 0;
      }
    }

    if(var_18) {
      var_24 = undefined;
      var_25 = bootcampmodewatcher(var_9);

      if(isDefined(var_25)) {
        var_24 = bot_arena_think(var_17, var_25);
      }

      if(isDefined(var_24)) {
        var_7 -= var_19;
        var_11++;
      }
    }

    waitframe();

    while(level.ai_event.brclearscoreboardstats.size > 7 || level.ai_event.ref_12662.size == 0) {
      wait 1;
    }
  }

  level.ai_event.ref_14525 = scripts\engine\utility::array_remove(level.ai_event.ref_14525, var_5);
}

function bomb_detonator_interact(var_0) {
  switch (var_0) {
    case "smg":
      return 1;
    case "smg_frag":
      return 2;
    case "smg_gas":
      return 2;
    case "smg_smoke":
      return 2;
    case "smg_molotov":
      return 3;
    case "smg_flash":
      return 3;
    case "assault":
      return 1;
    case "assault_frag":
      return 1;
    case "assault_gas":
      return 2;
    case "assault_smoke":
      return 2;
    case "assault_molotov":
      return 3;
    case "assault_flash":
      return 3;
  }

  if(issubstr(var_0, "brute")) {
    return 10;
  }

  return 1;
}

function bot_add_destination_spot(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_1 < 1) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::random(level.ai_event.helidestroyvehiclestouchtrace);
  }

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = scripts\engine\utility::random(var_2);
    var_7 = bot_allowed_weapons(var_6.origin, var_6.angles, var_0, var_3);

    if(!isDefined(var_7)) {
      return;
    }

    var_4 = scripts\engine\utility::array_add(var_4, var_7);
  }

  return var_4;
}

function bot_arena_think(var_0, var_1, var_2) {
  var_3 = bot_allowed_weapons(var_1.origin, var_1.angles, var_0, var_2);
  return var_3;
}

function bmoovertime(var_0) {
  return scripts\engine\utility::array_contains(level.ai_event.nogroundfoundtime, var_0);
}

function bootcampmodewatcher(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_4 = [];

    foreach(var_6 in var_3.ref_11E34) {
      if(var_6.players.size > 0) {
        var_4 = scripts\engine\utility::array_combine_unique(var_4, var_6.players);
      }
    }

    if(var_4.size == 0) {
      var_1 = var_3;
      continue;
    }

    var_8 = 1;

    foreach(var_10 in var_4) {
      var_11 = distance2d(var_10.origin, var_3.origin);
      var_12 = var_11 <= 500;

      if(var_12) {
        var_8 = 0;
        continue;
      }

      var_13 = scripts\engine\utility::within_fov(var_10.origin, var_10.angles, var_3.origin, cos(45));
      var_14 = scripts\engine\utility::ter_op(var_13, spawnsighttrace(var_3, var_10.origin + (0, 0, 75), var_3.origin + (0, 0, 50)) > 0.2, 0);

      if(var_14) {
        var_8 = 0;
        continue;
      }

      if(var_8) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function blockclasschange(var_0) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");

  for(;;) {
    jumpiffalse(level.ai_event.spawn_points.size == 0 || !isDefined(level.ai_event.ref_12659)) LOC_0000003f;
    wait 0.1;
  }

  for(;;) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1].origin;
      var_3 = (0, 0, 40);
      var_4 = -1;
      var_5 = (0, 1, 0);
      var_6 = 0;
      var_7 = 0;
      var_8 = 3200;
      var_9 = 0;

      foreach(var_11 in level.ai_event.ref_12659) {
        var_12 = distance2d(var_11.origin, var_2);
        var_13 = var_11.origin + (0, 0, 75);
        var_14 = var_12 < 3200;
        var_15 = abs(var_2[2] - var_11.origin[2]) < 200;
        var_9 = scripts\engine\utility::within_fov(var_11.origin, var_11.angles, var_2, cos(45));
        var_16 = scripts\engine\utility::ter_op(var_9, spawnsighttrace(var_0[var_1], var_2, var_13) > 0.2, 0);
        var_17 = var_12 <= 500 && var_15;
        var_18 = var_17 || var_14 && var_15 && var_16 && var_9;

        if(var_18) {
          if(var_12 < var_8) {
            var_8 = var_12;
          }

          var_7 += var_12;
          var_6 += 1;
        }
      }

      var_20 = -1;
      var_21 = 100;

      if(var_6 > 0) {
        var_4 = floor(var_7 / var_6);
        var_20 = (min(var_4, var_8) - 500) / 2700 * 100;
        var_21 = floor(max(var_20, 0));
        var_22 = (1, 0, 0);
        var_23 = (0, 1, 0);
        var_5 = vectorlerp(var_22, var_23, var_20 / 100);
      }

      var_0[var_1].ref_134DA = var_21;
    }

    level.ai_event.ref_135B5 = scripts\engine\utility::array_sort_with_func(var_0, &blockedvariantidsmap);
    wait 0.1;
  }
}

function blockedvariantidsmap(var_0, var_1) {
  return var_0.ref_134DA > var_1.ref_134DA;
}

function blockade_get_bomb_icon_on_cell_phone() {
  var_0 = [];
  var_1 = undefined;
  var_2 = 1050;
  var_3 = 0;

  while(var_0.size != level.ai_event.spawn_points.size) {
    level.ai_event.helidestroyvehiclestouchtrace[var_3] = [];

    foreach(var_5 in level.ai_event.spawn_points) {
      if(!scripts\engine\utility::array_contains(var_0, var_5)) {
        if(!isDefined(var_1)) {
          var_1 = var_5.origin;
        }

        var_6 = distance2d(var_1, var_5.origin);

        if(var_6 <= var_2) {
          var_0 = scripts\engine\utility::array_add(var_0, var_5);
          level.ai_event.helidestroyvehiclestouchtrace[var_3] = scripts\engine\utility::array_add(level.ai_event.helidestroyvehiclestouchtrace[var_3], var_5);
          var_5.helidisabled = var_3;
          var_5.helidisapateextractvfx = var_1;
          var_5.helidrivable = var_2;
          var_7 = 2000;
          var_5.ref_11E34 = [];

          foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
            var_10 = distance2d(var_5.origin, var_9.origin);

            if(var_10 < var_7) {
              var_5.ref_11E34 = scripts\engine\utility::array_add(var_5.ref_11E34, var_9);
            }
          }
        }
      }
    }

    var_1 = undefined;
    var_3++;
    waitframe();
  }
}

function bomb_wires_to_cut() {
  var_0 = [];
  var_1 = ["a", "b", "c"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    for(var_3 = 1; var_3 <= 5; var_3++) {
      var_4 = var_1[var_2] + scripts\engine\utility::string(var_3);
      var_0 = getEnt("vol_garage_" + var_4, "targetname");
      var_0[var_4].ref_12953 = var_4;
      var_0[var_4].players = [];
      level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(var_0[var_4], &ref_13DAB, &ref_13DAC, undefined, undefined, &ref_13DA5);
    }
  }

  return var_0;
}

function ref_13EF3() {
  if(isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  self.boltsinflight = ref_13EE0(&"BR_SOA_EVENT/WAVE_COUNT", -1, 1, (1, 1, 1), 0, 50);
  self.boltunlink = ref_13EE0(&"BR_SOA_EVENT/WAVE_INCOMING", -1, 1, (1, 1, 1), 0, 62);
  self.boltnumber = ref_13EE0(&"BR_SOA_EVENT/WAVE_COMPLETE", -1, 1, (1, 1, 1), 0, 50);
  self.bolt_trytopickup = ref_13EE0(&"BR_SOA_EVENT/WAVE_ENEMIES_REMAINING", -1, 1, (1, 1, 1), 0, 62);
  self.bolt_watchpickup = ref_13EE0(&"BR_SOA_EVENT/AI_EVENT_KILL_THE_BRUTE", undefined, 1, (1, 1, 1), 0, 62);
  self.boltdeleteonnote = ref_13EE1();
  self.boltdeletethread = ref_13EE0(&"BR_SOA_EVENT/AI_EVENT_UNSUBSCRIBING", -1, 1.2, (1, 1, 1), -300, 100);
  ref_13EF5();
  ref_13EF6(level.ai_event.current_state);
}

function ref_13EF4() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  foreach(var_1 in self.boardroomdoorcodeentrysuccess) {
    var_1 scripts\mp\hud_util::destroyelem();
    self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_remove(self.boardroomdoorcodeentrysuccess, var_1);
    var_1 = undefined;
  }

  self.boardroomdoorcodeentrysuccess = undefined;
}

function ref_13EF5() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  foreach(var_1 in self.boardroomdoorcodeentrysuccess) {
    var_1 scripts\mp\hud_util::hideelem();
  }
}

function ref_13EEA(var_0) {
  foreach(var_2 in level.ai_event.ref_12662) {
    ref_13EF6(var_2, var_0);
  }
}

function ref_13EEC() {
  foreach(var_1 in level.ai_event.ref_12662) {
    var_2 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks < 2, level.ai_event.new_col_map, level.ai_event.brclearscoreboardstats.size);
    var_1.bolt_trytopickup setvalue(var_2);
  }
}

function ref_13EE8() {
  foreach(var_1 in level.ai_event.ref_12662) {
    ref_13EF3(var_1);
  }
}

function ref_13EE9() {
  foreach(var_1 in level.ai_event.ref_12662) {
    ref_13EF4(var_1);
  }
}

function ref_13EF6(var_0) {
  ref_13EF5();

  switch (var_0) {
    case "inactive":
      break;
    case "wave_incoming":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();
      self.boltunlink scripts\mp\hud_util::showelem();
      break;
    case "wave_active":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();
      self.bolt_trytopickup setvalue(level.ai_event.new_col_map);
      self.bolt_trytopickup scripts\mp\hud_util::showelem();
      break;
    case "wave_active_brute":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();

      if(level.ai_event.enemy_mine_damaged_think) {
        self.bolt_watchpickup scripts\mp\hud_util::showelem();
      } else {
        ref_13EEC();
        self.bolt_trytopickup scripts\mp\hud_util::showelem();
      }

      break;
    case "wave_complete":
      self.boltnumber setvalue(level.ai_event.initoperatorunlocks);
      self.boltnumber scripts\mp\hud_util::showelem();
      self.boltunlink scripts\mp\hud_util::showelem();
      break;
    case "complete":
      self.boltnumber setvalue(level.ai_event.initoperatorunlocks);
      self.boltnumber scripts\mp\hud_util::showelem();
      break;
  }
}

function ref_13EDF(var_0) {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    self.boardroomdoorcodeentrysuccess = [];
  }

  self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_add(self.boardroomdoorcodeentrysuccess, var_0);
}

function ref_13EE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = "TOPLEFT";
  }

  var_7 = scripts\mp\hud_util::createfontstring("default", var_2);
  var_8 = 40;
  var_9 = (1 - getdvarfloat("hudBounds_adjusted_horizontal", 0)) * var_8;
  var_10 = (1 - getdvarfloat("hudBounds_adjusted_vertical", 0)) * var_8 / 2;
  var_7 scripts\mp\hud_util::setpoint(var_6, var_6, 143 + var_9, var_5 + var_10);
  var_7.color = var_3;
  var_7.label = var_0;

  if(isDefined(var_1)) {
    var_7 setvalue(var_1);
  }

  var_7 scripts\mp\hud_util::setparent(level.uiparent);
  ref_13EDF(var_7);
  return var_7;
}

function ref_13EE1() {
  var_0 = newclienthudelem(self);
  var_0.elemtype = "timer";
  var_0.font = "default";
  var_0.fontscale = 1.25;
  var_0.basefontscale = 1.25;
  var_0.width = 0;
  var_0.height = 10;
  var_0.x = 45;
  var_0.y = 60;
  var_0.xoffset = 0;
  var_0.yoffset = 0;
  var_0.children = [];
  var_0.hidden = 0;
  var_0 scripts\mp\hud_util::setparent(level.uiparent);
  ref_13EDF(var_0);
  return var_0;
}