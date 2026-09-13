/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_gun_course.gsc
**************************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  if(isDefined(level.trial["triggeredTrialName"]))
    level.trial_missionscript_init_funcs["gun"] = ::_id_2F54C2DD6F10DBB1;
  else
    level.trial_missionscript_init_funcs["gun"] = ::init;
}

init() {
  level.trial_target_thread_func = ::hint_outline_target_think;
  level.trial_target_civilian_killed_func = ::civvies_killed_calculate;
  level.trial_target_enemy_killed_func = ::targets_missed_calculate;
  level.trial_trigger_activated_func = ::trigger_smoke_grenades;
  analytics_init();
  dialog_init();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = scripts\mp\trials\trial_target_utility::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.impact_vfx = loadfx("vfx/iw8_mp/trials/speedball/vfx_trials_imp_clay.vfx");

  foreach(_id_B8E70FF71A02E32D in level.course_triggers)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_trigger_think();

  foreach(_id_B8E70FF71A02E32D in level.course_targets)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_target_think();

  thread game_start();
  thread game_end();
  _id_6EF691985B8B5903 = getEntArray("trial_ammocrate", "targetname");
  scripts\engine\utility::array_thread(_id_6EF691985B8B5903, ::ammo_crate_trial_think);
  level.trial_turret_thread_func = ::turret_guncourse_think;
}

_id_2F54C2DD6F10DBB1(_id_0B8B9E9EFD754D14) {
  level.trial_target_thread_func = ::hint_outline_target_think;
  level.trial_target_civilian_killed_func = ::civvies_killed_calculate;
  level.trial_target_enemy_killed_func = ::targets_missed_calculate;
  level.trial_trigger_activated_func = ::trigger_smoke_grenades;
  analytics_init();
  dialog_init();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_triggers = scripts\mp\trials\trial_utility::_id_1A95518CCBBA458E(_id_0B8B9E9EFD754D14);
  level.course_targets = scripts\mp\trials\trial_target_utility::_id_2316292E9CF2A251(_id_0B8B9E9EFD754D14);
  level notify("targets_initialized");
  level.course_movers = scripts\mp\trials\trial_utility::_id_BB06080B145E3C85(_id_0B8B9E9EFD754D14);
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.impact_vfx = loadfx("vfx/iw8_mp/trials/speedball/vfx_trials_imp_clay.vfx");

  foreach(_id_B8E70FF71A02E32D in level.course_triggers)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_trigger_think();

  foreach(_id_B8E70FF71A02E32D in level.course_targets)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_target_think();

  thread _id_B6AD40A9339A8091(_id_0B8B9E9EFD754D14);
  thread _id_F8C25A8E85E0CBC0(_id_0B8B9E9EFD754D14);
  _id_6EF691985B8B5903 = getEntArray("trial_ammocrate", "targetname");
  scripts\engine\utility::array_thread(_id_6EF691985B8B5903, ::ammo_crate_trial_think);
  level.trial_turret_thread_func = ::turret_guncourse_think;
}

game_start() {
  thread start_waypoint();
  _id_261D73DEE9F7F35C = getEntArray("start", "script_noteworthy");

  for(;;) {
    level.trial_spawn_wait = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
    level.trial_stat_row = 1;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_stat_row, "accuracy", 0, 0);
    level.trial_stat_row++;

    if(level.trial["missionScript"] != "gun_nonlinear") {
      level.targets_killed_stat_row = level.trial_stat_row;
      level.trial_stat_row++;
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.targets_killed_stat_row, "enemy_targets_hit_ratio", 0, 0);
    }

    if(level.civilian_targets.size) {
      level.civilians_killed_stat_row = level.trial_stat_row;
      level.trial_stat_row++;
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.civilians_killed_stat_row, "civilian_targets_hit", 0, 0);
    }

    scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(0, level.enemy_targets.size);
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);

    for(;;) {
      started = 0;

      foreach(trig in _id_261D73DEE9F7F35C) {
        if(trig.activated) {
          started = 1;
          break;
        }
      }

      if(started) {
        break;
      }

      waitframe();
    }

    level notify("course_started");
    level.player playSound("trial_sfx_start");
    thread tierfailure_countdown_think();
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
    level.trial_spawn_wait = 1;
    thread accuracy_think();
    thread time_think();
    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  }
}

_id_B6AD40A9339A8091(_id_0B8B9E9EFD754D14) {
  thread start_waypoint();

  for(;;) {
    level.trial_spawn_wait = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
    level.trial_stat_row = 1;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_stat_row, "accuracy", 0, 0);
    level.trial_stat_row++;

    if(level.trial["missionScript"] != "gun_nonlinear") {
      level.targets_killed_stat_row = level.trial_stat_row;
      level.trial_stat_row++;
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.targets_killed_stat_row, "enemy_targets_hit_ratio", 0, 0);
    }

    if(level.civilian_targets.size) {
      level.civilians_killed_stat_row = level.trial_stat_row;
      level.trial_stat_row++;
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.civilians_killed_stat_row, "civilian_targets_hit", 0, 0);
    }

    scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(0, level.enemy_targets.size);
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);

    if(level.trial["triggeredTrialName"] == "trial_variant_cqb") {
      for(;;) {
        started = 0;

        foreach(trig in level.course_triggers) {
          if(trig.activated) {
            started = 1;
            break;
          }
        }

        if(started) {
          break;
        }

        waitframe();
      }
    }

    level notify("course_started");
    level.player playSound("trial_sfx_start");
    thread tierfailure_countdown_think();
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
    level.trial_spawn_wait = 1;
    thread accuracy_think();
    thread time_think();
    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  }
}

game_end(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  if(game["trial"]["best_time"] == -1)
    level.player_best_time = 0;
  else
    level.player_best_time = game["trial"]["best_time"];

  trig = getEnt("end", "script_noteworthy");

  for(;;) {
    if(istrue(_id_9B106ABAC2185216))
      level.player_died_during_course = 0;
    else {
      level waittill("course_started");

      switch (level.trial["missionScript"]) {
        case "gun":
          trig waittill_trigger_activated_or_player_death();
          break;
        case "gun_nonlinear":
          waittill_all_targets_activated_or_player_death();
          thread restart_watcher();
          break;
        default:
          break;
      }
    }

    level notify("course_ended");
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);

    if(!level.player_died_during_course && (!level.player_best_time || level.player_best_time > level.trial_main_time)) {
      level.player_best_time = level.trial_main_time;
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
      game["trial"]["analytics"]["accuracy"] = level.course_accuracy;
      game["trial"]["analytics"]["missed"] = level.enemies_missed;
      game["trial"]["analytics"]["civilians"] = level.civs_killed;
    }

    level.score["total"] = level.trial_main_time;
    level.player_best_time = level.player_best_time - level.player_best_time % 100;
    scripts\mp\trials\trial_utility::trial_ui_set_best_time(level.player_best_time);

    if(level.player_best_time == 0 || level.player_best_time > level.trial["tier1"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(0);
      _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    } else if(level.player_best_time <= level.trial["tier3"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(3);
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    } else if(level.player_best_time <= level.trial["tier2"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(2);
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
    } else {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(1);
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
    }

    foreach(_id_22321E2BA6A9DABE in level.course_triggers)
    _id_22321E2BA6A9DABE.activated = 0;

    foreach(_id_2E5D752AF4F4A05C in level.course_targets) {
      _id_2E5D752AF4F4A05C.activated = 0;
      _id_2E5D752AF4F4A05C thread scripts\mp\trials\trial_target_utility::trial_target_flip("down");
    }

    setomnvar("ui_trial_failed", 0);

    if(level.player_died_during_course) {
      setomnvar("ui_trial_failed", 1);
      _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
      level.player stoplocalsound("deaths_door_in");
      level.player clearsoundsubmix("deaths_door_mp");
      thread restart_watcher();
    }

    if(istrue(level.trial_special_end))
      wait 3;

    scripts\mp\trials\trial_utility::trial_ui_open_results_screen();

    if(istrue(_id_9B106ABAC2185216)) {
      break;
    }
  }
}

_id_F8C25A8E85E0CBC0(_id_0B8B9E9EFD754D14) {
  if(game["trial"]["best_time"] == -1)
    level.player_best_time = 0;
  else
    level.player_best_time = game["trial"]["best_time"];

  trig = getEnt("end", "script_noteworthy");

  for(;;) {
    level waittill("course_started");

    switch (level.trial["missionScript"]) {
      case "gun":
        trig waittill_trigger_activated_or_player_death();
        break;
      case "gun_nonlinear":
        waittill_all_targets_activated_or_player_death();
        thread restart_watcher();
        break;
      default:
        break;
    }

    level notify("course_ended");
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);

    if(!level.player_died_during_course && (!level.player_best_time || level.player_best_time > level.trial_main_time)) {
      level.player_best_time = level.trial_main_time;
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
      game["trial"]["analytics"]["accuracy"] = level.course_accuracy;
      game["trial"]["analytics"]["missed"] = level.enemies_missed;
      game["trial"]["analytics"]["civilians"] = level.civs_killed;
    }

    level.score["total"] = level.trial_main_time;
    level.player_best_time = level.player_best_time - level.player_best_time % 100;
    scripts\mp\trials\trial_utility::trial_ui_set_best_time(level.player_best_time);

    if(level.player_best_time == 0 || level.player_best_time > level.trial["tier1"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(0);
      _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    } else if(level.player_best_time <= level.trial["tier3"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(3);
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    } else if(level.player_best_time <= level.trial["tier2"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(2);
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
    } else {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(1);
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
    }

    foreach(_id_22321E2BA6A9DABE in level.course_triggers)
    _id_22321E2BA6A9DABE.activated = 0;

    foreach(_id_2E5D752AF4F4A05C in level.course_targets) {
      _id_2E5D752AF4F4A05C.activated = 0;
      _id_2E5D752AF4F4A05C thread scripts\mp\trials\trial_target_utility::trial_target_flip("down");
    }

    setomnvar("ui_trial_failed", 0);

    if(level.player_died_during_course) {
      setomnvar("ui_trial_failed", 1);
      _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
      level.player stoplocalsound("deaths_door_in");
      level.player clearsoundsubmix("deaths_door_mp");
      thread restart_watcher();
    }

    if(istrue(level.trial_special_end))
      wait 3;

    scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  }
}

waittill_trigger_activated_or_player_death() {
  level.player_died_during_course = 1;
  level.player endon("death");

  while(isDefined(self.activated) && !self.activated)
    waitframe();

  level.player_died_during_course = 0;
}

waittill_all_targets_activated_or_player_death() {
  level.player_died_during_course = 1;
  level.player endon("death");

  for(;;) {
    _id_FC4824F33DF61EA0 = 1;

    foreach(_id_B8E70FF71A02E32D in level.enemy_targets) {
      if(!_id_B8E70FF71A02E32D.activated)
        _id_FC4824F33DF61EA0 = 0;
    }

    if(_id_FC4824F33DF61EA0) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

restart_watcher() {
  level.trial_restarting = 1;
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  scripts\mp\trials\trial_utility::trial_restart();
}

start_waypoint() {
  struct = scripts\engine\utility::getStruct("gun_course_start_icon", "targetname");

  if(!isDefined(struct)) {
    return;
  }
  _id_9DE6C466DA32F978 = spawn("script_model", struct.origin);
  _id_9DE6C466DA32F978 setModel("tag_origin");
  waypoint = createheadicon(_id_9DE6C466DA32F978);
  setheadiconimage(waypoint, "icon_waypoint_marker");
  setheadicondrawthroughgeo(waypoint, 1);
  setheadiconmaxdistance(waypoint, 0);
  setheadiconsnaptoedges(waypoint, 1);
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  for(;;) {
    addclienttoheadiconmask(waypoint, level.player);
    level waittill("course_started");
    removeclientfromheadiconmask(waypoint, level.player);
    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  }
}

hint_outline_target_think() {
  if(self.is_civilian || level.trial["missionScript"] != "gun_nonlinear") {
    return;
  }
  while(!isDefined(level.enemies_killed))
    waitframe();

  while(level.enemies_killed < level.enemy_targets.size - 10)
    waitframe();

  while(level.trial_subtime <= level.trial["tier2"])
    waitframe();

  scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "outlinefill_trial_target_nodepth", "level_script");
}

trigger_smoke_grenades() {
  if(!isDefined(self.target)) {
    return;
  }
  _id_CE126B8C53B9993F = scripts\engine\utility::getStructArray("trigger_smoke_origin", "script_noteworthy");
  _id_837178326DAF8AB5 = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_00B8C613BAC2D72F = scripts\engine\utility::array_intersection(_id_CE126B8C53B9993F, _id_837178326DAF8AB5);

  foreach(struct in _id_00B8C613BAC2D72F)
  magicgrenademanual("smoke_grenade_mp", struct.origin, (0, 0, -1), 0.05);
}

time_think() {
  level endon("course_ended");
  level.start_time = gettime();
  level.civs_killed = 0;
  level.enemies_killed = 0;
  level.enemies_missed = level.enemy_targets.size;
  level.civ_time_penalty = 0;
  level.missed_time_penalty = 0;
  level.trial_accuracy_bonus = 0;
  targets_missed_calculate();
  civvies_killed_calculate(1);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  for(;;) {
    time_calculate();
    waitframe();
  }
}

civvies_killed_calculate(_id_0FB91F9023CC02E0) {
  if(!level.civilian_targets.size) {
    return;
  }
  level.civs_killed = 0;

  foreach(_id_B8E70FF71A02E32D in level.civilian_targets) {
    if(_id_B8E70FF71A02E32D.activated)
      level.civs_killed++;
  }

  level.civ_time_penalty = level.civs_killed * 5000;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.civilians_killed_stat_row, "civilian_targets_hit", level.civs_killed, level.civ_time_penalty);

  if(!istrue(_id_0FB91F9023CC02E0)) {
    level.player thread scripts\mp\rank::scoreeventpopup("stat_930B4906CF0D62F7");
    self playSound("trial_sfx_buzzer_bad_1");
  }
}

targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(_id_B8E70FF71A02E32D in level.enemy_targets) {
    if(!_id_B8E70FF71A02E32D.activated)
      level.enemies_missed++;
  }

  level.enemies_killed = level.enemy_targets.size - level.enemies_missed;
  level.missed_time_penalty = level.enemies_missed * 5000;
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  if(level.trial["missionScript"] != "gun_nonlinear")
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.targets_killed_stat_row, "enemy_targets_hit_ratio", level.enemy_targets.size - level.enemies_missed, level.missed_time_penalty);
}

time_calculate() {
  level.trial_subtime = gettime() - level.start_time;
  level.trial_main_time = level.trial_subtime + level.civ_time_penalty + level.missed_time_penalty + level.trial_accuracy_bonus;
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.trial_subtime);
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.trial_main_time);

  if(!isDefined(level.reward_tier))
    level.reward_tier = 3;

  _id_EB54B63FA5690F56 = level.reward_tier;

  if(level.trial_subtime <= level.trial["tier3"]) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);
    level.reward_tier = 3;
  } else if(level.trial_subtime <= level.trial["tier2"]) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(2);
    level.reward_tier = 2;
  } else if(level.trial_subtime <= level.trial["tier1"]) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(1);
    level.reward_tier = 1;
  } else {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
    level.reward_tier = 0;
  }

  if(level.reward_tier < _id_EB54B63FA5690F56)
    level.player playSound("trial_sfx_failure");
}

tierfailure_countdown_think(current_time, _id_EBE3A98228F5E0F7) {
  self endon("course_ended");
  _id_72408207126E9282 = [];
  _id_72408207126E9282[0] = undefined;
  _id_72408207126E9282[1] = level.trial["tier1"] / 1000;
  _id_72408207126E9282[2] = level.trial["tier2"] / 1000;
  _id_72408207126E9282[3] = level.trial["tier3"] / 1000;
  wait 1;

  for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    attempttier = _id_AC0E594AC96AA3A8;

    if(isDefined(_id_72408207126E9282[_id_AC0E594AC96AA3A8])) {
      while(level.trial_subtime / 1000 < _id_72408207126E9282[_id_AC0E594AC96AA3A8] - 5)
        wait 0.05;

      for(t = 5; t > 2; t--) {
        level.player playSound("trial_sfx_failure_countdown");
        wait 1;
      }

      for(t = 2; t > 0; t--) {
        level.player playSound("trial_sfx_failure_countdown_ms");
        wait 1;
      }
    }
  }
}

accuracy_think() {
  level endon("course_ended");
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "accuracy", 0, 0);
  level.shots_fired = 0;
  level.course_accuracy = 0;

  for(;;) {
    level.player scripts\engine\utility::waittill_any_2("weapon_fired", "fake_weapon_fired");
    level.shots_fired++;
    level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / clamp(level.shots_fired, 1, 99999);
    _id_0CA9930310366321 = -1 * level.course_accuracy * 5000;
    level.trial_accuracy_bonus = _id_0CA9930310366321 - _id_0CA9930310366321 % 100;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "accuracy", 100 * level.course_accuracy, level.trial_accuracy_bonus);
  }
}

dialog_init() {
  if(level.trial["missionScript"] != "gun_nonlinear") {
    game["dialog"]["trial_intro"] = "kh_guncourse_intro";
    game["dialog"]["trial_intro_short"] = "kh_guncourse_intro_short";
    game["dialog"]["trial_end_tier_0"] = "kh_guncourse_star0";
    game["dialog"]["trial_end_tier_1"] = "kh_guncourse_star1";
    game["dialog"]["trial_end_tier_2"] = "kh_guncourse_star2";
    game["dialog"]["trial_end_tier_3"] = "kh_guncourse_star3";
    game["dialog"]["trial_retry"] = "kh_guncourse_retry";
    game["dialog"]["course_start"] = "kh_guncourse_start";
    game["dialog"]["course_nice_shot"] = "kh_guncourse_goodshot";
    game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
    game["dialog"]["course_hurry_up"] = "kh_guncourse_hurryup";
  } else {
    game["dialog"]["trial_intro"] = "mp_m_speedball_intro";
    game["dialog"]["trial_intro_short"] = "mp_m_speedball_intro_short";
    game["dialog"]["trial_end_tier_0"] = "mp_m_speedball_end_0star";
    game["dialog"]["trial_end_tier_1"] = "mp_m_speedball_end_1star";
    game["dialog"]["trial_end_tier_2"] = "mp_m_speedball_end_2star";
    game["dialog"]["trial_end_tier_3"] = "mp_m_speedball_end_3star";
    game["dialog"]["trial_retry"] = "mp_m_speedball_obj_fail";
    game["dialog"]["course_start"] = "mp_m_speedball_obj_nag_start";
    game["dialog"]["course_nice_shot"] = "mp_m_speedball_obj_nag_nice";
    game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
    game["dialog"]["course_hurry_up"] = "mp_m_speedball_obj_nag_hurry";
  }

  thread dialog_hurry_up_watcher();
  thread dialog_kill_watcher();
}

dialog_hurry_up_watcher() {
  for(;;) {
    level waittill("trigger_activated");
    thread dialog_hurry_up_thread();
  }
}

dialog_hurry_up_thread() {
  level endon("trigger_activated");
  level endon("course_ended");
  wait 9;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("course_hurry_up");
}

dialog_kill_watcher() {
  level waittill("course_started");
  _id_7C7A2963CFDD5A97 = 0;
  _id_D3F5CAE78FA5AD50 = 0;
  _id_69BE3FE091D57F48 = gettime();
  _id_6EAE12D7176B3456 = gettime();
  min_delay = 5000;

  for(;;) {
    if(level.civs_killed > _id_D3F5CAE78FA5AD50 && gettime() > _id_6EAE12D7176B3456 + min_delay) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      _id_6EAE12D7176B3456 = gettime();
    } else if(level.enemies_killed > _id_7C7A2963CFDD5A97 + 1 && gettime() > _id_69BE3FE091D57F48 + min_delay) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
      _id_69BE3FE091D57F48 = gettime();
    }

    _id_D3F5CAE78FA5AD50 = level.civs_killed;
    _id_7C7A2963CFDD5A97 = level.enemies_killed;
    waitframe();
  }
}

ammo_crate_trial_think() {
  self.headicon = createheadicon(self);
  setheadiconimage(self.headicon, "cp_crate_icon_ammo");
  setheadiconnaturaldistance(self.headicon, 800);
  setheadiconzoffset(self.headicon, 50);
  interact = spawn("script_model", self.origin);
  interact linkTo(self, "tag_origin", (0, 0, 50), (0, 0, 0));
  interact setModel("tag_origin");

  for(;;) {
    interact makeusable();
    interact setHintString(&"MP_INGAME_ONLY/REFILL_AMMO");
    interact setCursorHint("hint_button");
    interact sethintdisplayrange(200);
    interact sethintdisplayfov(65);
    interact setuserange(80);
    interact setusefov(120);
    interact sethintonobstruction("show");
    interact setuseholdduration("duration_short");
    interact waittill("trigger");
    weapon = level.player getcurrentweapon();
    _id_495F85FD1D5EF643 = level.player getcurrentweaponclipammo();
    level.player setweaponammoclip(weapon, _id_495F85FD1D5EF643);

    if(level.trial["variant"] == "pickup") {
      _id_9EABBD13591B6DFB = level.player getweaponammostock(weapon) + 1;
      _id_6F89268F7DDF91D0 = 1;
    } else {
      _id_9EABBD13591B6DFB = weaponclipsize(weapon) - _id_495F85FD1D5EF643;
      _id_6F89268F7DDF91D0 = 5;
    }

    level.player setweaponammostock(weapon, _id_9EABBD13591B6DFB);
    interact makeunusable();
    hideheadiconfromplayersinmask(self.headicon);
    wait(_id_6F89268F7DDF91D0);
    showheadicontoplayersinmask(self.headicon);
  }
}

turret_guncourse_think() {
  self endon("death");
  level waittill("course_started");
  id = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "spotter_target_killstreak", "level_script");
  thread turret_guncourse_explode_on_end();

  while(isalive(self))
    waitframe();

  scripts\mp\utility\outline::outlinedisable(id, self);
}

turret_guncourse_explode_on_end() {
  self endon("death");
  level waittill("course_ended");

  if(isalive(self))
    self notify("death");
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_gun;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["weapon1"] = "DNF";
    game["trial"]["analytics"]["weapon2"] = "DNF";
    game["trial"]["analytics"]["accuracy"] = 0;
    game["trial"]["analytics"]["missed"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
  }
}

trial_dlog_gun() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  time = getomnvar("ui_trial_best_time");
  _id_A7756ABFED842C14 = "" + game["trial"]["analytics"]["weapon1"];
  _id_A7756DBFED8432AD = "" + game["trial"]["analytics"]["weapon2"];
  accuracy = float(game["trial"]["analytics"]["accuracy"]);
  _id_58AA9AEA25E648A4 = int(game["trial"]["analytics"]["missed"]);
  civilians = int(game["trial"]["analytics"]["civilians"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_gun", ["id", id, "tier", tier, "time", time, "weapon1", _id_A7756ABFED842C14, "weapon2", _id_A7756DBFED8432AD, "accuracy", accuracy, "missed", _id_58AA9AEA25E648A4, "civilians", civilians]);
}