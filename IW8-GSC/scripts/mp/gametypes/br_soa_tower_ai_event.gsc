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
  level.ai_event.ref_11c20 = getdvarfloat("scr_arms_deal_agent_minimap_ping_lifetime", 0.5);
  level.ai_event.ref_11c1f = getdvarfloat("scr_arms_deal_agent_minimap_ping_interval", 2.5);
}

function object_is_valid() {
  scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
  level.agent_funcs["actor_enemy_lw_br"]["on_damaged"] = &black_screen_overlay;
  level.agent_funcs["actor_enemy_lw_br_brute"]["on_damaged"] = &black_screen_overlay;
  level.agent_funcs["actor_enemy_lw_br"]["gametype_on_damage_finished"] = &blade_trigger_think;
  level.agent_funcs["actor_enemy_lw_br_brute"]["gametype_on_damage_finished"] = &blade_trigger_think;
  level.disable_oob_immunity_on_riders = 1;
  level.playerentersafearea = &ref_1320f;

  if(!isDefined(level.ai_event)) {
    level.ai_event = spawnStruct();
  }

  level.ai_event.inited = 0;
  level.ai_event.states = ["inactive", "wave_incoming", "wave_active", "wave_active_brute", "wave_complete", "complete"];
  level.ai_event.current_state = "inactive";
  level.ai_event.ref_13b97 = -1;
  level.ai_event.spawn_points = scripts\engine\utility::getStructArray("agent_spawn_point_team_200", "targetname");
  level.ai_event.ref_135b5 = [];
  level.ai_event.helidestroyvehiclestouchtrace = [];
  level.ai_event.select_hostage_room_three_spawners = bomb_wires_to_cut();
  level.ai_event.select_hostage_room_two_spawners = [];
  level.ai_event.occupied_rpg_trig = getEnt("br_soa_tower_ai_event_vol", "targetname");
  level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(level.ai_event.occupied_rpg_trig, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
  level.ai_event.ref_12659 = [];
  level.ai_event.ref_12662 = [];
  level.ai_event.ref_12663 = [];
  level.ai_event.ref_12660 = [];
  level.ai_event.brclearscoreboardstats = [];
  level.ai_event.ref_13be2 = 0;
  level.ai_event.ref_13be3 = [];
  level.ai_event.ref_13be4 = 0;
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
  var0 = scripts\engine\utility::getStruct("arms_deal_start_button", "targetname");
  var1 = 0;
  var2 = scripts\engine\utility::ter_op(var1, (8, 17, 3), (0, 0, 0));
  var3 = scripts\mp\gameobjects::createhintobject(var0.origin + var2, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/AI_EVENT_INTERACT");
  thread objectivespawner();
  var3 waittill("trigger");
  var3 notify("kill_interact_fx");
  var3 delete();
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
  ref_13ee8();
  objectivelocations(level.ai_event);
}

function objective_hide_for_mlg_spectator() {
  if(!level.ai_event.pour) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, 1, ["brute_danny_the_firecracker", "brute_johnny_the_detonator", "brute_tommy_the_toxic", "brute_gary_the_blinder", "brute_anthony_fogwalker"]);
}

function objectivelocations() {
  obj_room_fire_06(level.ai_event);
  objective_hide_for_mlg_spectator(level.ai_event);
  var0 = level.ai_event.nolandingdamage[level.ai_event.initoperatorunlocks];

  switch (level.ai_event.initoperatorunlocks) {
    case 1:
      thread bomb_detonator_holder(level.ai_event, var0, 4, 7);
      break;
    case 2:
      thread bomb_detonator_holder(level.ai_event, level.ai_event.ref_13005, 3, 5);
      thread bomb_detonator_holder(level.ai_event, var0, 4, 7, level.ai_event.binoculars_settargetmarkerstate[2]);
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
  ref_13eea("wave_incoming");
  var0 = 0;
  var1 = gettime() / 1000;
  var2 = gettime() / 1000;
  var3 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks == 1, 1, 10);

  for(;;) {
    var4 = gettime() / 1000;
    var0 = var3 - var4 - var1;

    foreach(var6 in level.ai_event.ref_12662) {
      if(isDefined(var6.boardroomdoorcodeentrysuccess)) {
        var6.boltunlink setvalue(ceil(var0));

        if(var4 - var2 > 1) {
          var7 = objloc(var0);
          var6 playlocalsound(var7);
          var2 = gettime() / 1000;
        }
      }
    }

    if(var0 <= 0) {
      break;
    }

    waitframe();
  }

  if(level.ai_event.initoperatorunlocks > 1) {
    foreach(var6 in level.ai_event.ref_12662) {
      var6 playlocalsound("iw8_games_splash_silver");
    }
  }

  level.ai_event.ref_13b97 = gettime();
  level.ai_event.current_state = "wave_active";
  level.ai_event.new_col_map = level.ai_event.binoculars_settargetmarkerstate[level.ai_event.initoperatorunlocks];
  ref_13eea("wave_active");
}

function obj_room_fire_11() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  var0 = gettime() / 1000;
  var1 = 0;
  var2 = undefined;

  for(;;) {
    var3 = gettime() / 1000;
    var1 = floor(var3 - var0);

    if(var1 >= level.ai_event.bodyonly_guy_in_car_damage_monitor && level.ai_event.ref_12662.size == 0) {
      level.ai_event.initoperatorunlocks -= 1;
      var2 = "timeout";
      break;
    }

    if(level.ai_event.brclearscoreboardstats.size <= 0 && level.ai_event.ref_14525.size == 0) {
      var2 = "success";
      break;
    }

    wait 0.1;
  }

  obj_room_fire_10(var2);
}

function obj_room_fire_10(var0) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");

  switch (var0) {
    case "success":
      level.ai_event.current_state = "wave_complete";
      ref_13eea("wave_complete");

      if(level.ai_event.initoperatorunlocks < 2) {
        objective_minimapupdate("br_soa_tower_ai_event_wave_cleared", int(level.ai_event.initoperatorunlocks));
        wait 0.1;
        thread obj_room_fire_05();
      } else {
        objective_minimapupdate("br_soa_tower_event_arms_deal_complete_full_splash");
        level.ai_event.current_state = "complete";
        ref_13eea("complete");
        scripts\mp\gametypes\br_soa_tower_rewards::ref_12d21("most_agent_kills");

        foreach(var2 in level.ai_event.ref_12662) {
          if(getdvarint("MLNNMOPQOP", 0) == 6) {
            var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
          }
        }

        objectiveloc();
      }

      break;
    case "timeout":
      objective_minimapupdate("br_soa_tower_ai_event_timer_expired");

      foreach(var5 in level.ai_event.brclearscoreboardstats) {
        var5.ref_11e90 = 1;
        var5[[var5.isinlaststand]]();
        var5 kill();
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
  level.ai_event.ref_13b97 = -1;
  level.ai_event.initoperatorunlocks = 0;
  level.ai_event.current_state = "inactive";
  level.ai_event.new_col_map = -1;
  level.ai_event.ref_14525 = [];
  ref_13ee9();

  foreach(var1 in level.ai_event.ref_12660) {
    var1.boardroomopen = 0;
    var1.body0 = 0;
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
    var0 = scripts\engine\utility::array_combine_unique(level.ai_event.ref_12659, level.ai_event.ref_12662);

    foreach(var2 in var0) {
      var3 = objective_set_hot(var2);

      if(!var3 && objectiveids(var2)) {
        objective_timers_reset_both(var2);
      } else if(isalive(var2)) {
        objectiveicon(var2);
      } else {
        objectivedescription(var2);
      }

      var4 = gettime() / 1000;

      foreach(var2 in level.ai_event.ref_12663) {
        var6 = gettime() / 1000 - var2.boltunlinkonnote / 1000;
        var7 = var2.boltdeletethread;

        if(isDefined(var7)) {
          if(var7.hidden) {
            var7 scripts\mp\hud_util::showelem();
          }

          var7 setvalue(ceil(10 - var6));
        }

        if(objectiveids(var2)) {
          objective_timers_reset_both(var2);

          if(isDefined(var7)) {
            var7 scripts\mp\hud_util::hideelem();
          }

          continue;
        }

        if(var6 >= 10) {
          objectivedescription(var2);
          objective_locations_logic(var2, "br_soa_tower_ai_event_unsubscribe");
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
    ref_13ef3();

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
    ref_13ef4();
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

  var0 = 150;
  var1 = abs(self.origin[2] - level.ai_event.occupied_rpg_trig.origin[2] - var0) < 100;

  if(scripts\engine\utility::array_contains(level.ai_event.ref_12659, self) && var1) {
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

function objectives_amount(var0) {
  foreach(var2 in level.ai_event.brclearscoreboardstats) {
    if(isDefined(var2.squadleaderbeacon_fxent)) {
      if(var0) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2.squadleaderbeacon_fxent, self);
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var2.squadleaderbeacon_fxent, self);
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

function objloc(var0) {
  return "ui_mp_timer_countdown_10";
}

function ref_13dab(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(issubstr(var1.targetname, "event")) {
    if(isPlayer(var0) && !scripts\engine\utility::array_contains(level.ai_event.ref_12659, var0)) {
      level.ai_event.ref_12659 = scripts\engine\utility::array_add(level.ai_event.ref_12659, var0);
      objectives_amount(var0, 1);
    }
  }

  if(issubstr(var1.targetname, "garage")) {
    var2 = getsubstr(var1.targetname, 11);

    if(isDefined(var0.waittill_any_timeout_5)) {
      if(isPlayer(var0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players, var0)) {
        level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players, var0);
      }
    }

    if(isPlayer(var0) && !scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var2].players, var0)) {
      level.ai_event.select_hostage_room_three_spawners[var2].players = scripts\engine\utility::array_add(level.ai_event.select_hostage_room_three_spawners[var2].players, var0);
      var0.waittill_any_timeout_5 = var2;
      return;
    }

    return;
  }
}

function ref_13dac(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(issubstr(var1.targetname, "event")) {
    if(isPlayer(var0) && scripts\engine\utility::array_contains(level.ai_event.ref_12659, var0)) {
      level.ai_event.ref_12659 = scripts\engine\utility::array_remove(level.ai_event.ref_12659, var0);
      objectives_amount(var0, 0);

      if(isDefined(var0.waittill_any_timeout_5)) {
        if(isPlayer(var0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players, var0)) {
          level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var0.waittill_any_timeout_5].players, var0);
        }
      }
    }
  }

  if(issubstr(var1.targetname, "garage")) {
    waitframe();
    var2 = getsubstr(var1.targetname, 11);
    var3 = var2 != var0.waittill_any_timeout_5;

    if(isPlayer(var0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var2].players, var0) && var3) {
      level.ai_event.select_hostage_room_three_spawners[var2].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var2].players, var0);
      return;
    }

    return;
  }
}

function ref_13da5(var0, var1) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isPlayer(var0)) {
    return true;
  }

  return false;
}

function objective_minimapupdate(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = spawnStruct();
    var2.intvar = var1;
  }

  foreach(var4 in level.ai_event.ref_12662) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var4, var0, var2);
  }
}

function objective_locations_logic(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
}

function ref_1320f() {
  if(scripts\mp\utility\game::getgametype() != "brtdm") {
    return;
  }

  if(!isDefined(level.teamnamelist) || !scripts\engine\utility::array_contains(level.teamnamelist, "team_two_hundred")) {
    return;
  }

  scripts\mp\utility\teams::setteamdata("team_two_hundred", "teamCount", 999);
}

function bot_allowed_weapons(var0, var1, var2, var3) {
  var4 = issubstr(var2, "brute");
  var5 = scripts\mp\mp_agent::spawnnewagent(scripts\engine\utility::ter_op(var4, "actor_enemy_lw_br_brute", "actor_enemy_lw_br"), "team_two_hundred", var0, var1);

  if(!isDefined(var5)) {
    return;
  }

  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_add(level.ai_event.brclearscoreboardstats, var5);
  thread bomber_death_thread();
  var5.type = var2;
  var5.enemy_left_monitor = var4;
  var5 scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("frag_grenade_mp", 1);
  bomb_detonator_bomb_type(var5);
  bomber(var5);
  thread bomber_delay_thread();
  var5.guid = var5 getguid();
  var5.name = var5.guid;
  var5.agentname = &"BR_SOA_EVENT/HENCHMAN";
  boss_one_minion_watcher(var5);
  bomb_detonator_waiting_for_pick_up(var5);
  boss_two_minion_watcher(var5, var2);
  boss_fight_combat_forest(var5, var3);

  if(var4) {
    boss_fight_combat_laser_trap(var5);

    foreach(var7 in level.ai_event.ref_12662) {
      var7 playlocalsound("ui_splash_zxp_juggspawn");
    }

    if(level.ai_event.initoperatorunlocks == 2) {
      level.ai_event.enemy_mine_damaged_think = 1;
      ref_13eea("wave_active_brute");
    }
  }

  thread bonuskillscharge();
  thread bot_choose_attack_zone();
  return var5;
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
  self.ref_1407d = 0;
}

function boss_one_minion_watcher() {
  self.maxhealth = level.ai_event.binoculars_registertargetstate;
  self.health = level.ai_event.binoculars_registertargetstate;
  self.health_remaining = level.ai_event.binoculars_registertargetstate;
  self.showseasonalcontent = level.ai_event.binoculars_registertargetstate;
  self.showsplashtoall = level.ai_event.binoculars_registertargetstate;
  self.meleedamageoverride = level.ai_event.binoculars_removeheadicon;
  self.sound_events = 0;
  self.ref_12d29 = undefined;
  self.ref_12d2a = undefined;
  self.ref_12d25 = 0;
  var0 = level.ai_event.binoculars_onstateunmarkedexit;
  var1 = level.ai_event.binoculars_onstatemarkpendingupdate;
  var2 = level.ai_event.binoculars_onstateunmarkedupdate;
  var3 = level.ai_event.binoculars_onstateunmarkedenter;
  var4 = var1 + var3 * (level.ai_event.initoperatorunlocks - 1);
  var5 = clamp(var4, var2, var0);
  self.baseaccuracy = var5;
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  self.isinlaststand = &blank_relic_func;
  self.ref_119ea = &scripts\mp\gametypes\br_soa_tower_rewards::ref_119f7;
  self.ref_130df = &scripts\mp\gametypes\br_soa_tower_rewards::ref_12d28;
  self.scriptable_carriable_damage = &scripts\mp\gametypes\br_soa_tower_rewards::ref_12d22;
  self.ref_11e90 = scripts\mp\utility\game::getgametype() == "brtdm";
  self.enemy_mine_proximity_think = 0;
  self.ignoreall = getdvarint("scr_br_arms_ai_diable_agent_fire", 0);
}

function bomber_death_thread() {
  self endon("death");
  level endon("game_ended");
  var0 = randomfloatrange(1.25, 2.75);
  wait var0;
  scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest(self);
  scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent("move", "movecombat", anim.player);
}

function bomb_detonator_waiting_for_pick_up(var0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!isDefined(var0)) {
      var1 = level.ai_event.binoculars_ontake;
      var2 = level.ai_event.binoculars_processlosqueue;
      var0 = var1 + clamp(level.ai_event.initoperatorunlocks - 1, 0, 10) * var2;
    }

    scripts\mp\gametypes\br_armor::teamfriendlyto();
    scripts\mp\gametypes\br_armor::searchcirclesize();
    boss_fight_combat_cave(var0);
    return;
  }
}

function boss_fight_combat_cave(var0) {
  if(!isDefined(var0) || var0 < 0) {
    return;
  }

  self.br_maxarmorhealth = var0;
  self.br_armorhealth = var0;
  var1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", var1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    return;
  }
}

function boss_two_minion_watcher(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(issubstr(var0, "assault")) {
    bomb_hostage_play_anim("iw8_ar_akilo47");
    self.goalradius = randomintrange(100, 200);
  }

  if(issubstr(var0, "smg")) {
    bomb_hostage_play_anim("iw8_sm_mpapa5");
    self.goalradius = randomintrange(50, 100);
  }

  var1 = undefined;

  if(issubstr(var0, "frag")) {
    var1 = "frag_grenade_mp";
  }

  if(issubstr(var0, "molotov")) {
    var1 = "molotov_mp";
  }

  if(issubstr(var0, "flash")) {
    var1 = "flash_grenade_mp";
  }

  if(issubstr(var0, "gas")) {
    var1 = "gas_grenade_mp";
  }

  if(issubstr(var0, "smoke")) {
    var1 = "smoke_grenade_mp";
  }

  if(isDefined(var1)) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f(var1, 2);
  }

  if(self.enemy_left_monitor) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("frag_grenade_mp", 10);
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

    switch (var0) {
      case "brute_danny_the_firecracker":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("molotov_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mike4", 30);
        boss_wave(10);
        self.agentname = &"BR_SOA_EVENT/BRUTE_DANNY";
        break;
      case "brute_johnny_the_detonator":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("frag_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mike4", 32);
        boss_wave(11);
        self.agentname = &"BR_SOA_EVENT/BRUTE_JOHNNY";
        break;
      case "brute_tommy_the_toxic":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("gas_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_mcharlie", 24);
        boss_wave(12);
        self.agentname = &"BR_SOA_EVENT/BRUTE_TOMMY";
        break;
      case "brute_gary_the_blinder":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("flash_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_akilo47", 20);
        boss_wave(13);
        self.agentname = &"BR_SOA_EVENT/BRUTE_GARY";
        break;
      case "brute_anthony_fogwalker":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("smoke_grenade_mp", 99);
        bomb_hostage_play_anim("iw8_ar_anovember94", 3);
        boss_wave(14);
        self.agentname = &"BR_SOA_EVENT/BRUTE_ANTHONY";
        break;
    }

    return;
  }

  boss_wave(level.ai_event.initoperatorunlocks);
}

function boss_fight_combat_forest(var0) {
  var1 = scripts\engine\utility::ter_op(isDefined(var0), var0, scripts\engine\utility::random(level.ai_event.select_hostage_room_three_spawners));
  self setgoalvolumeauto(var1);
}

function bomb_hostage_play_anim(var0, var1) {
  self.weapon = scripts\mp\class::buildweapon(var0, ["laserrange", "none", "none", "none", "none", "none"], "none", "none", var1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

function bombzone_press_use(var0) {
  if(level.ai_event.brclearscoreboardstats.size <= var0 && level.ai_event.ref_14525.size == 0) {
    foreach(var2 in level.ai_event.brclearscoreboardstats) {
      if(!isDefined(var2.squadleaderbeacon_fxent)) {
        boss_fight_combat_laser_trap(var2);
      } else {
        continue;
      }

      var3 = scripts\engine\utility::array_randomize(level.ai_event.select_hostage_room_three_spawners);
      var4 = scripts\engine\utility::random(var3);

      foreach(var6 in var3) {
        if(var6.players.size > var4.players.size) {
          var4 = var6;
        }
      }

      var2 setgoalvolumeauto(var4);
    }

    return;
  }
}

function boss_fight_combat_laser_trap() {
  var0 = undefined;
  var1 = undefined;

  if(self.enemy_left_monitor) {
    var1 = "icon_waypoint_jugg";
    var0 = "BR_SOA_EVENT/BRUTE_";
    var2 = undefined;

    switch (self.type) {
      case "brute_danny_the_firecracker":
        var2 = "DANNY";
        break;
      case "brute_johnny_the_detonator":
        var2 = "JOHNNY";
        break;
      case "brute_tommy_the_toxic":
        var2 = "TOMMY";
        break;
      case "brute_gary_the_blinder":
        var2 = "GARY";
        break;
      case "brute_anthony_fogwalker":
        var2 = "ANTHONY";
        break;
    }

    if(isDefined(var2)) {
      var0 += var2;
    }
  } else {
    var1 = "icon_waypoint_generic";
  }

  var3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.squadleaderbeacon_fxent = var3;
  objective_state(self.squadleaderbeacon_fxent, "current");
  objective_position(self.squadleaderbeacon_fxent, self.origin + (0, 0, 100));
  objective_setplayintro(self.squadleaderbeacon_fxent, self.enemy_left_monitor);
  objective_setshowoncompass(self.squadleaderbeacon_fxent, 0);
  objective_setshowdistance(self.squadleaderbeacon_fxent, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(self.squadleaderbeacon_fxent, var1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.squadleaderbeacon_fxent, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.squadleaderbeacon_fxent, 80);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.squadleaderbeacon_fxent, self);

  if(isDefined(var0)) {
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.squadleaderbeacon_fxent, var0);
  }

  if(self.enemy_left_monitor) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(self.squadleaderbeacon_fxent, 1);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.squadleaderbeacon_fxent);

  foreach(var5 in level.ai_event.ref_12662) {
    objectives_amount(var5, 1);
  }
}

function boss_wave(var0) {
  if(!isDefined(var0)) {
    var0 = level.ai_event.initoperatorunlocks;
  }

  var1 = [];

  switch (var0) {
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

  if(var1.size > 0) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134b1(var1);
    return;
  }
}

function bot_choose_attack_zone() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var0, var1, var2, var3);

    if(!scripts\mp\utility\weapon::grenadethrown(var0)) {
      continue;
    }

    scripts\mp\weapons::grenadeinitialize(var0, var1, var2, var3);
    self notify("grenade_throw");

    if(!isDefined(var0)) {
      return;
    }

    if(!isDefined(var0.weapon_name)) {
      return;
    }

    var0.spawnpos = var0.origin;

    switch (var0.weapon_name) {
      case "molotov_mp":
        thread scripts\mp\equipment\molotov::molotov_used(var0);
        break;
      case "gas_grenade_mp":
        thread scripts\mp\equipment\gas_grenade::gas_used(var0);
        break;
    }
  }
}

function bonuskillscharge() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  self endon("terminate_ai_threads");
  self endon("death");
  var0 = gettime() / 1000;

  for(;;) {
    var1 = self getgoalvolume();
    var2 = distance2d(self.origin, var1.origin);
    var3 = var2 < 600;
    self.ref_145d4 = var3;

    if(var3) {
      var4 = gettime() / 1000;
      var5 = var4 - var0;
      self.ref_13b6b = var5;
      var6 = level.ai_event.binoculars_targetisvalid;
      self.ref_13b6c = var6 - var5;

      if(var4 - var0 >= var6) {
        var7 = [];

        foreach(var9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var9.players.size > 0 && var9 != var1) {
            var7 = var9;
          }
        }

        if(var7.size > 0) {
          var11 = scripts\engine\utility::random(var7);
          self setgoalvolumeauto(var11);
        }

        var0 = gettime() / 1000;
      }
    } else {
      var0 = gettime() / 1000;
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
    wait level.ai_event.ref_11c20;
    self unsetperk("specialty_radarblip", 1);
    wait level.ai_event.ref_11c1f;
  }
}

function bomb_detonator_bomb_type() {
  if(!ispointonnavmesh(self.origin, self, 1)) {
    var0 = getclosestpointonnavmesh(self.origin, self);

    if(isDefined(var0)) {
      self forceteleport(var0, self.angles);
      return;
    }

    return;
  }
}

function black_screen_overlay(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = self;

  if(!isDefined(var13.agent_type) || var13.asm.archetype != "soldier_lw_br") {
    return;
  }

  var14 = isDefined(var1) && isPlayer(var1);
  var15 = isDefined(var1.owner) && isPlayer(var1.owner);
  var16 = var4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var8) && var8 == "none" || var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE" || var4 == "MOD_PROJECTILE_SPLASH" || var4 == "MOD_GRENADE";
  var17 = var4 == "MOD_FIRE";

  if(var14 || var15) {
    var18 = var2;
    var19 = weaponclass(var5);
    var20 = scripts\mp\utility\weapon::getweapongroup(var5);
    var21 = scripts\mp\utility\weapon::getequipmenttype(var5.basename);
    var22 = var19 == "throwingknife";

    if(var16 && var19 == "grenade") {
      var2 = var18 * 2;
    }

    if(var22) {
      var2 = var18 * 2.5;
    }
  }

  if(self.enemy_left_monitor && !self.enemy_mine_proximity_think) {
    var23 = float(level.ai_event.binoculars_processlosqueuelow) * 0.2;

    if(self.health < var23) {
      level.ai_event notify("stop_pending_agent_spawns");
      self.enemy_mine_proximity_think = 1;
    }
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
}

function blade_trigger_think(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  var15 = scripts\engine\utility::ter_op(isDefined(var2), var2, 0) + scripts\engine\utility::ter_op(isDefined(var13), var13, 0);
  [[self.ref_130df]](var1, var12, var4, var15);

  if(self.enemy_left_monitor) {
    objective_show_for_mlg_spectator(var1);
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
}

function blank_relic_func(var0) {
  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_remove(level.ai_event.brclearscoreboardstats, self);

  if(!isDefined(level.ai_event.ref_13be3[level.ai_event.initoperatorunlocks])) {
    level.ai_event.ref_13be3[level.ai_event.initoperatorunlocks] = 0;
  }

  level.ai_event.ref_13be3[level.ai_event.initoperatorunlocks] += 1;
  level.ai_event.ref_13be2 += 1;
  bombzone_press_use(3);

  if(isDefined(self.squadleaderbeacon_fxent)) {
    objective_delete(self.squadleaderbeacon_fxent);
  }

  if(self.enemy_left_monitor) {
    objective_minimapupdate("br_soa_tower_reward_brute_eliminated");
    scripts\mp\gametypes\br_soa_tower_rewards::ref_12d21("most_brute_damage");
    level.ai_event notify("stop_pending_agent_spawns");
    level.ai_event.ref_14525 = [];

    foreach(var2 in level.ai_event.ref_12662) {
      var2 playlocalsound("br_splash_vip_eliminated");
      var2 playlocalsound("mp_enemy_hvt_killed");
    }

    level.ai_event.enemy_mine_damaged_think = 0;
    bombzone_press_use(level.ai_event.brclearscoreboardstats.size);
    ref_13eea("wave_active_brute");
  }

  level.ai_event.new_col_map--;
  ref_13eec();

  if(!isDefined(var0)) {
    return;
  }

  self.is_correct_wire_color = var0;
  var0.agent = self;
  objective_show_for_mlg_spectator(var0.eattacker);
  var4 = spawnStruct();
  var4.eattacker = var0.eattacker;
  var4.origin = self.origin;
  var4.angles = self.angles;

  if(!self.ref_11e90) {
    level.ai_event thread[[self.ref_119ea]]("loot_table_ammo", 1, var4);
    level.ai_event thread[[self.ref_119ea]]("loot_table_cash", 1, var4);
    level.ai_event thread[[self.ref_119ea]]("loot_table_gear", 1, var4);
    level.ai_event thread[[self.ref_119ea]]("loot_table_deployables", 1, var4);

    if(self.enemy_left_monitor) {
      level.ai_event thread[[self.ref_119ea]]("loot_table_brute", 25, var4);
      level.ai_event thread[[self.ref_119ea]]("loot_table_deployables", 6, var4);
      level.ai_event thread[[self.ref_119ea]]("loot_table_brute_legendary_weapon", 1, var4);
      playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);

      if(getDvar("scr_br_gametype", "") == "bodycount") {
        level.ai_event thread[[self.ref_119ea]]("loot_table_power_grab_revive_token", 1, var4);
      }
    }

    if(level.ai_event.initoperatorunlocks == 2 && level.ai_event.brclearscoreboardstats.size == 0) {
      playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);
      level.ai_event thread[[self.ref_119ea]]("loot_table_brute_vault_key", 1, var4);

      if(getDvar("scr_br_gametype", "") == "bodycount") {
        level.ai_event thread[[self.ref_119ea]]("loot_table_power_grab_dog_tags", 2, var4);
      }
    }
  }

  [[self.ref_130df]](var0.eattacker, var0.shitloc, var0.smeansofdeath, var0.idamage);
  [[self.scriptable_carriable_damage]]("takedown");
  [[self.scriptable_carriable_damage]]("assist");
  [[self.scriptable_carriable_damage]]("killing_blow");
}

function bomb_detonator_holder(var0, var1, var2, var3, var4) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level.ai_event endon("stop_pending_agent_spawns");
  level endon("game_ended");

  if(isDefined(var4)) {
    wait var4;
  }

  for(var5 = undefined; !isDefined(var5) || scripts\engine\utility::array_contains_key(level.ai_event.ref_14525, var5); var5 = randomint(1000)) {}

  level.ai_event.ref_14525 = scripts\engine\utility::array_add(level.ai_event.ref_14525, var5);
  var6 = level.ai_event.helidestroyvehiclestouchtrace;
  var7 = var3;
  var8 = undefined;
  var9 = undefined;
  var10 = randomintrange(var1, var2);
  var11 = 0;

  while(var7 > 0) {
    var12 = level.ai_event.binoculars_updateheadiconvisibilityforplayer;
    var13 = level.ai_event.binoculars_targetisvalidmark;
    var14 = level.ai_event.binoculars_updateprojectiondistance;
    var15 = level.ai_event.binoculars_updateheadiconvisibility * (level.ai_event.initoperatorunlocks - 1);
    var16 = clamp(var13 + var15, var14, var12);

    while(level.ai_event.brclearscoreboardstats.size >= var16) {
      wait 1;
    }

    if(var11 >= var10) {
      var11 = 0;
    }

    if(var11 == 0) {
      if(var6.size == 0) {
        var6 = level.ai_event.helidestroyvehiclestouchtrace;
      }

      var8 = int(clamp(randomint(var6.size), 0, var6.size));
      var9 = var6[var8];
      var6 = scripts\engine\utility::array_remove_index(var6, var8, 0);
    }

    var17 = scripts\engine\utility::random(var0);
    var18 = bmoovertime(var17);
    var19 = scripts\engine\utility::ter_op(1, 1, bomb_detonator_interact(var17));

    if(issubstr(var17, "brute")) {
      var7 = var19;
    }

    if(var19 > var7) {
      var20 = [];

      foreach(var22 in var0) {
        if(var19 <= var7) {
          var20 = var22;
        }
      }

      if(var20.size > 0) {
        var17 = scripts\engine\utility::random(var20);
      } else {
        var18 = 0;
      }
    }

    if(var18) {
      var24 = undefined;
      var25 = bootcampmodewatcher(var9);

      if(isDefined(var25)) {
        var24 = bot_arena_think(var17, var25);
      }

      if(isDefined(var24)) {
        var7 -= var19;
        var11++;
      }
    }

    waitframe();

    while(level.ai_event.brclearscoreboardstats.size > 7 || level.ai_event.ref_12662.size == 0) {
      wait 1;
    }
  }

  level.ai_event.ref_14525 = scripts\engine\utility::array_remove(level.ai_event.ref_14525, var5);
}

function bomb_detonator_interact(var0) {
  switch (var0) {
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

  if(issubstr(var0, "brute")) {
    return 10;
  }

  return 1;
}

function bot_add_destination_spot(var0, var1, var2, var3) {
  var4 = [];

  if(var1 < 1) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::random(level.ai_event.helidestroyvehiclestouchtrace);
  }

  for(var5 = 0; var5 < var1; var5++) {
    var6 = scripts\engine\utility::random(var2);
    var7 = bot_allowed_weapons(var6.origin, var6.angles, var0, var3);

    if(!isDefined(var7)) {
      return;
    }

    var4 = scripts\engine\utility::array_add(var4, var7);
  }

  return var4;
}

function bot_arena_think(var0, var1, var2) {
  var3 = bot_allowed_weapons(var1.origin, var1.angles, var0, var2);
  return var3;
}

function bmoovertime(var0) {
  return scripts\engine\utility::array_contains(level.ai_event.nogroundfoundtime, var0);
}

function bootcampmodewatcher(var0) {
  var1 = undefined;

  if(!isDefined(var0)) {
    return undefined;
  }

  var0 = scripts\engine\utility::array_randomize(var0);

  foreach(var3 in var0) {
    var4 = [];

    foreach(var6 in var3.ref_11e34) {
      if(var6.players.size > 0) {
        var4 = scripts\engine\utility::array_combine_unique(var4, var6.players);
      }
    }

    if(var4.size == 0) {
      var1 = var3;
      continue;
    }

    var8 = 1;

    foreach(var10 in var4) {
      var11 = distance2d(var10.origin, var3.origin);
      var12 = var11 <= 500;

      if(var12) {
        var8 = 0;
        continue;
      }

      var13 = scripts\engine\utility::within_fov(var10.origin, var10.angles, var3.origin, cos(45));
      var14 = scripts\engine\utility::ter_op(var13, spawnsighttrace(var3, var10.origin + (0, 0, 75), var3.origin + (0, 0, 50)) > 0.2, 0);

      if(var14) {
        var8 = 0;
        continue;
      }

      if(var8) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function blockclasschange(var0) {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");

  for(;;) {
    jumpiffalse(level.ai_event.spawn_points.size == 0 || !isDefined(level.ai_event.ref_12659)) LOC_0000003f;
    wait 0.1;
  }

  for(;;) {
    for(var1 = 0; var1 < var0.size; var1++) {
      var2 = var0[var1].origin;
      var3 = (0, 0, 40);
      var4 = -1;
      var5 = (0, 1, 0);
      var6 = 0;
      var7 = 0;
      var8 = 3200;
      var9 = 0;

      foreach(var11 in level.ai_event.ref_12659) {
        var12 = distance2d(var11.origin, var2);
        var13 = var11.origin + (0, 0, 75);
        var14 = var12 < 3200;
        var15 = abs(var2[2] - var11.origin[2]) < 200;
        var9 = scripts\engine\utility::within_fov(var11.origin, var11.angles, var2, cos(45));
        var16 = scripts\engine\utility::ter_op(var9, spawnsighttrace(var0[var1], var2, var13) > 0.2, 0);
        var17 = var12 <= 500 && var15;
        var18 = var17 || var14 && var15 && var16 && var9;

        if(var18) {
          if(var12 < var8) {
            var8 = var12;
          }

          var7 += var12;
          var6 += 1;
        }
      }

      var20 = -1;
      var21 = 100;

      if(var6 > 0) {
        var4 = floor(var7 / var6);
        var20 = (min(var4, var8) - 500) / 2700 * 100;
        var21 = floor(max(var20, 0));
        var22 = (1, 0, 0);
        var23 = (0, 1, 0);
        var5 = vectorlerp(var22, var23, var20 / 100);
      }

      var0[var1].ref_134da = var21;
    }

    level.ai_event.ref_135b5 = scripts\engine\utility::array_sort_with_func(var0, &blockedvariantidsmap);
    wait 0.1;
  }
}

function blockedvariantidsmap(var0, var1) {
  return var0.ref_134da > var1.ref_134da;
}

function blockade_get_bomb_icon_on_cell_phone() {
  var0 = [];
  var1 = undefined;
  var2 = 1050;
  var3 = 0;

  while(var0.size != level.ai_event.spawn_points.size) {
    level.ai_event.helidestroyvehiclestouchtrace[var3] = [];

    foreach(var5 in level.ai_event.spawn_points) {
      if(!scripts\engine\utility::array_contains(var0, var5)) {
        if(!isDefined(var1)) {
          var1 = var5.origin;
        }

        var6 = distance2d(var1, var5.origin);

        if(var6 <= var2) {
          var0 = scripts\engine\utility::array_add(var0, var5);
          level.ai_event.helidestroyvehiclestouchtrace[var3] = scripts\engine\utility::array_add(level.ai_event.helidestroyvehiclestouchtrace[var3], var5);
          var5.helidisabled = var3;
          var5.helidisapateextractvfx = var1;
          var5.helidrivable = var2;
          var7 = 2000;
          var5.ref_11e34 = [];

          foreach(var9 in level.ai_event.select_hostage_room_three_spawners) {
            var10 = distance2d(var5.origin, var9.origin);

            if(var10 < var7) {
              var5.ref_11e34 = scripts\engine\utility::array_add(var5.ref_11e34, var9);
            }
          }
        }
      }
    }

    var1 = undefined;
    var3++;
    waitframe();
  }
}

function bomb_wires_to_cut() {
  var0 = [];
  var1 = ["a", "b", "c"];

  for(var2 = 0; var2 < var1.size; var2++) {
    for(var3 = 1; var3 <= 5; var3++) {
      var4 = var1[var2] + scripts\engine\utility::string(var3);
      var0 = getEnt("vol_garage_" + var4, "targetname");
      var0[var4].ref_12953 = var4;
      var0[var4].players = [];
      level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(var0[var4], &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
    }
  }

  return var0;
}

function ref_13ef3() {
  if(isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  self.boltsinflight = ref_13ee0(&"BR_SOA_EVENT/WAVE_COUNT", -1, 1, (1, 1, 1), 0, 50);
  self.boltunlink = ref_13ee0(&"BR_SOA_EVENT/WAVE_INCOMING", -1, 1, (1, 1, 1), 0, 62);
  self.boltnumber = ref_13ee0(&"BR_SOA_EVENT/WAVE_COMPLETE", -1, 1, (1, 1, 1), 0, 50);
  self.bolt_trytopickup = ref_13ee0(&"BR_SOA_EVENT/WAVE_ENEMIES_REMAINING", -1, 1, (1, 1, 1), 0, 62);
  self.bolt_watchpickup = ref_13ee0(&"BR_SOA_EVENT/AI_EVENT_KILL_THE_BRUTE", undefined, 1, (1, 1, 1), 0, 62);
  self.boltdeleteonnote = ref_13ee1();
  self.boltdeletethread = ref_13ee0(&"BR_SOA_EVENT/AI_EVENT_UNSUBSCRIBING", -1, 1.2, (1, 1, 1), -300, 100);
  ref_13ef5();
  ref_13ef6(level.ai_event.current_state);
}

function ref_13ef4() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  foreach(var1 in self.boardroomdoorcodeentrysuccess) {
    var1 scripts\mp\hud_util::destroyelem();
    self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_remove(self.boardroomdoorcodeentrysuccess, var1);
    var1 = undefined;
  }

  self.boardroomdoorcodeentrysuccess = undefined;
}

function ref_13ef5() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }

  foreach(var1 in self.boardroomdoorcodeentrysuccess) {
    var1 scripts\mp\hud_util::hideelem();
  }
}

function ref_13eea(var0) {
  foreach(var2 in level.ai_event.ref_12662) {
    ref_13ef6(var2, var0);
  }
}

function ref_13eec() {
  foreach(var1 in level.ai_event.ref_12662) {
    var2 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks < 2, level.ai_event.new_col_map, level.ai_event.brclearscoreboardstats.size);
    var1.bolt_trytopickup setvalue(var2);
  }
}

function ref_13ee8() {
  foreach(var1 in level.ai_event.ref_12662) {
    ref_13ef3(var1);
  }
}

function ref_13ee9() {
  foreach(var1 in level.ai_event.ref_12662) {
    ref_13ef4(var1);
  }
}

function ref_13ef6(var0) {
  ref_13ef5();

  switch (var0) {
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
        ref_13eec();
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

function ref_13edf(var0) {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    self.boardroomdoorcodeentrysuccess = [];
  }

  self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_add(self.boardroomdoorcodeentrysuccess, var0);
}

function ref_13ee0(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var6)) {
    var6 = "TOPLEFT";
  }

  var7 = scripts\mp\hud_util::createfontstring("default", var2);
  var8 = 40;
  var9 = (1 - getdvarfloat("LQORTPMNLL", 0)) * var8;
  var10 = (1 - getdvarfloat("NPLKLQMNPL", 0)) * var8 / 2;
  var7 scripts\mp\hud_util::setpoint(var6, var6, 143 + var9, var5 + var10);
  var7.color = var3;
  var7.label = var0;

  if(isDefined(var1)) {
    var7 setvalue(var1);
  }

  var7 scripts\mp\hud_util::setparent(level.uiparent);
  ref_13edf(var7);
  return var7;
}

function ref_13ee1() {
  var0 = newclienthudelem(self);
  var0.elemtype = "timer";
  var0.font = "default";
  var0.fontscale = 1.25;
  var0.basefontscale = 1.25;
  var0.width = 0;
  var0.height = 10;
  var0.x = 45;
  var0.y = 60;
  var0.xoffset = 0;
  var0.yoffset = 0;
  var0.children = [];
  var0.hidden = 0;
  var0 scripts\mp\hud_util::setparent(level.uiparent);
  ref_13edf(var0);
  return var0;
}