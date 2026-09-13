/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_arm_course.gsc
**************************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["arm_course"] = ::init;
}

init() {
  dialog_init();
  setDvar("scr_game_matchstarttime", 1);
  setDvar("scr_localeID", -1);
  level.trial_target_enemy_killed_func = ::score_event_enemy_killed;
  level.trial_target_civilian_killed_func = ::score_event_civilian_killed;
  level.trial_target_headshot_func = ::score_event_headshot;
  level.trial_target_think_func = ::target_fob_think;
  level.trial_target_thread_func = ::target_active_fob_watcher;
  level.trial_turret_kill_func = ::score_event_turret_killed;
  level.trial_turret_thread_func = ::turret_think;
  level.civilian_targets = [];
  level.enemy_targets = [];

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = scripts\mp\trials\trial_target_utility::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.trial_vehicles = scripts\engine\utility::getStructArray("trial_atv_spawn", "targetname");
  score_init();
  analytics_init();
  gw_fobs_init();

  foreach(vehicle in level.trial_vehicles)
  vehicle thread vehicle_fob_think();

  foreach(_id_B8E70FF71A02E32D in level.course_triggers)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_trigger_think();

  foreach(_id_B8E70FF71A02E32D in level.course_targets)
  _id_B8E70FF71A02E32D thread scripts\mp\trials\trial_target_utility::trial_target_think();

  level.targs_done = 1;
  score_calculate(0);
  thread player_parachute_watcher();
  thread progression();
}

gw_fobs_init() {
  _id_3BA4F32E41F63B36::seticonnames();

  if(level.trial["team"] == "allies") {
    level.trial_other_team = "axis";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_neutral = [];
  } else {
    level.trial_other_team = "allies";
    level.startingfobnames_allies = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [];
  }

  level.gw_objstruct = spawnStruct();
  _id_3BA4F32E41F63B36::setupobjectives();

  if(level.trial["team"] == "allies")
    _id_47A3B799C2843055 = level.gw_objstruct.startingfobs_axis;
  else
    _id_47A3B799C2843055 = level.gw_objstruct.startingfobs_allies;

  level.allfobs = [];
  level.allfobtriggers = [];

  foreach(fob in _id_47A3B799C2843055)
  fob thread fob_think();

  thread active_fob_think();
}

fob_think() {
  level.allfobs[level.allfobs.size] = self;
  level.allfobtriggers[level.allfobtriggers.size] = self.trigger;
  self.trigger.fob = self;
  self.activated = 0;

  while(!istrue(level.targs_done))
    waitframe();

  self.targets = getEntArray("fob_target" + self.trigger.objkey, "targetname");

  foreach(_id_B8E70FF71A02E32D in self.targets) {
    if(istrue(_id_B8E70FF71A02E32D.is_civilian))
      self.targets = scripts\engine\utility::array_remove(self.targets, _id_B8E70FF71A02E32D);
  }

  if(self.targets.size == 0) {
    return;
  }
  self.objective = scripts\mp\gameobjects::createobjidobject(self.trigger.origin, "neutral", (0, 0, 100), undefined, "any");
  shader = "waypoint_capture" + self.trigger.objkey;
  scripts\mp\objidpoolmanager::update_objective_icon(self.objective.objidnum, scripts\mp\gameobjects::getwaypointshader(shader));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objective.objidnum, scripts\mp\gameobjects::getwaypointbackgroundtype(shader));
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.trial_other_team);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 1);

  for(;;) {
    if(isDefined(level.trial_active_fob) && self == level.trial_active_fob) {
      objective_state(self.objective.objidnum, "invisible");
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 0);
    } else
      objective_state(self.objective.objidnum, "current");

    _id_BCCC4FA4D67A4CDA = 0;

    foreach(_id_B8E70FF71A02E32D in self.targets) {
      if(_id_B8E70FF71A02E32D.activated && !istrue(_id_B8E70FF71A02E32D.is_civilian)) {
        scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 1);
        _id_BCCC4FA4D67A4CDA++;
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(self.objective.objidnum, _id_BCCC4FA4D67A4CDA / self.targets.size);

    if(_id_BCCC4FA4D67A4CDA >= self.targets.size) {
      break;
    }

    waitframe();
  }

  self.activated = 1;
  scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.trial["team"]);
  wait 1;
  score_event_fob_cleared();
}

active_fob_think() {
  level waittill("course_started");

  for(;;) {
    _id_3EE860014DC5E579 = scripts\engine\utility::getclosest(level.player.origin, level.enemy_targets, 1000);

    if(isDefined(_id_3EE860014DC5E579))
      level.trial_active_fob = _id_3EE860014DC5E579.fob;
    else
      level.trial_active_fob = undefined;

    waitframe();
  }
}

target_active_fob_watcher() {
  for(;;) {
    if(!self.activated && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob) {
      objective = scripts\mp\gameobjects::createobjidobject(self.origin, level.trial_other_team, (0, 0, 0), undefined, "any");
      objective_state(objective.objidnum, "active");
      objective_setplayintro(objective.objidnum, 0);

      if(!istrue(self.is_civilian))
        objective_icon(objective.objidnum, "icon_minimap_enemy");

      objective_setbackground(objective.objidnum, 1);
      objective_setfadedisabled(objective.objidnum, 0);
      objective_setshowoncompass(objective.objidnum, 1);
      objective_setminimapiconsize(objective.objidnum, "icon_regular");
      objective_setshowdistance(objective.objidnum, 0);
      objective_setownerteam(objective.objidnum, level.trial_other_team);

      if(!istrue(self.is_civilian))
        thread target_pity_outline_think();

      while(!self.activated && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob)
        waitframe();

      scripts\mp\objidpoolmanager::returnobjectiveid(objective.objidnum);
    }

    waitframe();
  }
}

target_pity_outline_think() {
  self notify("pity_timer_reset");
  self endon("pity_timer_reset");
  self.pity_timer_end_time = gettime() + 40000;

  while(gettime() < self.pity_timer_end_time)
    waitframe();

  id = scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "outlinefill_nodepth_white", "level_script");

  while(!self.activated && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob)
    waitframe();

  scripts\mp\utility\outline::outlinedisable(id, self.plate);
}

target_fob_think() {
  _id_0B648CBF600682BB = scripts\engine\utility::getclosest(self.origin, level.allfobtriggers, 4096);
  self.targetname = "fob_target" + _id_0B648CBF600682BB.objkey;
  self.fob = _id_0B648CBF600682BB.fob;
}

turret_fob_watcher() {
  while(!isDefined(level.allfobtriggers))
    waitframe();

  _id_0B648CBF600682BB = scripts\engine\utility::getclosest(self.origin, level.allfobtriggers, 4096);
  self.fob = _id_0B648CBF600682BB.fob;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
  self turretfiredisable();

  for(;;) {
    if(isalive(self) && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.minimapid);

      if(isDefined(level.trial_end_time))
        self turretfireenable();

      while(isalive(self) && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob)
        waitframe();

      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
      self turretfiredisable();
    }

    waitframe();
  }
}

vehicle_fob_think() {
  level waittill("course_started");
  _id_0B648CBF600682BB = scripts\engine\utility::getclosest(self.origin, level.allfobtriggers, 4096);

  while(!_id_0B648CBF600682BB.fob.activated)
    waitframe();

  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", self);
  vehicle.fob = _id_0B648CBF600682BB.fob;
  vehicle thread vehicle_outline_watcher();
}

progression() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(1);
  _id_4ED6C6086FB72EC9 = gettime() + 180000 + 500;
  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(_id_4ED6C6086FB72EC9);

  while(!level.player isonground())
    waitframe();

  level notify("course_started");
  level.trial_end_time = gettime() + 180000;
  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(level.trial_end_time);
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(0);
  level.player playSound("trial_sfx_start");
  level.trial_spawn_wait = 1;
  thread restart_watcher();
  thread player_ammo_crate_hint_watcher();
  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  waittill_end_condition_met();
  score_event_time_remaining();
}

player_parachute_watcher() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  scripts\mp\outofbounds::enableoobimmunity(level.player);

  while(!isalive(level.player))
    waitframe();

  while(!level.player isskydiving()) {
    level.player skydive_beginfreefall();
    waitframe();
  }

  while(level.player scripts\mp\outofbounds::istouchingoobtrigger())
    waitframe();

  level.player skydive_deployparachute();
  scripts\mp\outofbounds::disableoobimmunity(level.player);
  level.player skydive_cutparachuteon();
  level.player skydive_cutautodeployon();

  while(!level.player isparachuting())
    waitframe();

  while(!level.player isonground())
    waitframe();
}

waittill_end_condition_met() {
  level.player_died_during_course = 1;
  level.player endon("death");

  while(isalive(level.player)) {
    _id_FC4824F33DF61EA0 = 1;
    _id_F208F3F3E07791E5 = 1;

    foreach(_id_B8E70FF71A02E32D in level.enemy_targets) {
      if(!_id_B8E70FF71A02E32D.activated)
        _id_FC4824F33DF61EA0 = 0;
    }

    if(gettime() < level.trial_end_time)
      _id_F208F3F3E07791E5 = 0;

    if(_id_FC4824F33DF61EA0 || _id_F208F3F3E07791E5) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

restart_watcher() {
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  scripts\mp\trials\trial_utility::trial_restart();
}

turret_think() {
  thread turret_outline_watcher();
  thread turret_fob_watcher();
  thread turret_fob_self_destruct();
}

turret_outline_watcher() {
  self endon("death");

  for(;;) {
    self waittill("bullet_fired");
    id = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outlinefill_nodepth_red", "level_script");

    while(isalive(self) && isDefined(level.trial_active_fob) && self.fob == level.trial_active_fob)
      waitframe();

    scripts\mp\utility\outline::outlinedisable(id, self);
    waitframe();
  }
}

turret_fob_self_destruct() {
  self endon("death");

  while(!isDefined(self.fob))
    waitframe();

  while(!self.fob.activated)
    waitframe();

  while(isalive(self)) {
    self dodamage(99999, self.origin);
    waitframe();
  }
}

vehicle_outline_watcher() {
  id = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outline_nodepth_cyan", "level_script");
  far = 0;

  for(;;) {
    _id_82771518F44B22E5 = distance(level.player.origin, self.origin);

    foreach(fob in level.allfobs) {
      if(fob == self.fob) {
        continue;
      }
      if(distance(level.player.origin, fob.trigger.origin) < _id_82771518F44B22E5) {
        far = 1;
        break;
      }
    }

    if(far) {
      break;
    }

    if(isDefined(level.player.vehicle)) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(id, self);
}

player_ammo_crate_hint_watcher() {
  _id_9577902B42FBD7F6 = scripts\engine\utility::array_removeundefined(level.ammorestocklocs);

  for(;;) {
    for(;;) {
      _id_470E4B042B50D3DD = 0;
      weapons = level.player getweaponslistprimaries();

      foreach(weapon in weapons) {
        if(level.player getweaponammostock(weapon) < weaponclipsize(weapon)) {
          _id_470E4B042B50D3DD = 1;
          break;
        }
      }

      if(_id_470E4B042B50D3DD) {
        break;
      }

      waitframe();
    }

    _id_1C77BA6374F2DBE5 = scripts\engine\utility::getclosest(level.player.origin, _id_9577902B42FBD7F6, 1000);

    if(isDefined(_id_1C77BA6374F2DBE5)) {
      targets = getEntArray(_id_1C77BA6374F2DBE5.target, "targetname");
      _id_5ADB73D50B67B568 = undefined;

      foreach(ent in targets) {
        if(ent.classname == "script_model") {
          _id_5ADB73D50B67B568 = ent;
          break;
        }
      }

      id = scripts\mp\utility\outline::outlineenableforplayer(_id_5ADB73D50B67B568, level.player, "outline_nodepth_cyan", "level_script");

      for(;;) {
        _id_422152C417C74ECB = 0;
        _id_5428BC96B7713BA8 = scripts\engine\utility::getclosest(level.player.origin, _id_9577902B42FBD7F6, 1000);

        if(!isDefined(_id_5428BC96B7713BA8) || _id_5428BC96B7713BA8 != _id_1C77BA6374F2DBE5) {
          break;
        }

        weapons = level.player getweaponslistprimaries();

        foreach(weapon in weapons) {
          if(level.player getweaponammostock(weapon) >= weaponclipsize(weapon)) {
            _id_422152C417C74ECB = 1;
            break;
          }
        }

        if(_id_422152C417C74ECB) {
          break;
        }

        waitframe();
      }

      scripts\mp\utility\outline::outlinedisable(id, _id_5ADB73D50B67B568);
    }

    waitframe();
  }
}

score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["time_remaining"] = 0;
  level.score["enemies_killed"] = 0;
  level.score["civilians_killed"] = 0;
  level.score["headshot"] = 0;
  level.score["fobs_cleared"] = 0;
  level.score["turrets_killed"] = 0;
  level.trial_time_remaining = 180000;
  level.trial_enemies_killed = 0;
  level.trial_civilians_killed = 0;
  level.trial_fobs_cleared = 0;
  level.trial_turrets_killed = 0;
  score_calculate();
}

score_calculate(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  level.score["subtotal"] = level.score["enemies_killed"] + level.score["headshot"] + level.score["fobs_cleared"] + level.score["turrets_killed"];
  level.score["total"] = level.score["subtotal"] + level.score["civilians_killed"] + level.score["time_remaining"];
  _id_6BEF6A7708ECBDA0 = 1;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(_id_6BEF6A7708ECBDA0, "targets_killed_no_ratio", level.trial_enemies_killed, 0);
  _id_6BEF6A7708ECBDA0++;

  while(!istrue(level.sentry_init_done))
    waitframe();

  if(level.trial_sentry_turrets.size) {
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(_id_6BEF6A7708ECBDA0, "turrets_destroyed", level.trial_turrets_killed, 0);
    _id_6BEF6A7708ECBDA0++;
  }

  if(level.civilian_targets.size) {
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(_id_6BEF6A7708ECBDA0, "civilian_targets_hit", level.trial_civilians_killed, level.score["civilians_killed"]);
    _id_6BEF6A7708ECBDA0++;
  }

  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(_id_6BEF6A7708ECBDA0, "fobs_cleared", level.trial_fobs_cleared, 0);
  _id_6BEF6A7708ECBDA0++;

  if(_id_9B106ABAC2185216 && !level.player_died_during_course)
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(_id_6BEF6A7708ECBDA0, "time_remaining", level.trial_time_remaining, level.score["time_remaining"]);

  scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(-1);
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);
    wait 1;

    if(level.score["total"] < 0)
      level.score["total"] = 0;

    scripts\mp\trials\trial_utility::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["kills"] = level.score["enemies_killed"];
      game["trial"]["analytics"]["civilians"] = level.score["civilians_killed"];
      game["trial"]["analytics"]["turrets"] = level.score["turrets_killed"];
      game["trial"]["analytics"]["fobs"] = level.score["fobs_cleared"];
    }

    hud_set_reward_tier(1);
    thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  }
}

hud_set_reward_tier(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  if(_id_9B106ABAC2185216)
    score = level.score["best"];
  else
    score = level.score["subtotal"];

  if(score >= level.trial["tier3"])
    reward_tier = 3;
  else if(score >= level.trial["tier2"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier3"] - level.trial["tier2"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier2"];
    reward_tier = 2 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else if(score >= level.trial["tier1"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier2"] - level.trial["tier1"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier1"];
    reward_tier = 1 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else
    reward_tier = score / level.trial["tier1"];

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(reward_tier);

    if(score >= level.trial["tier3"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
      return;
    }

    if(score >= level.trial["tier2"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
      return;
    }

    if(score >= level.trial["tier1"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
      return;
    }

    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    return;
    return;
    return;
  } else
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(reward_tier);
}

score_event_enemy_killed() {
  level.score["enemies_killed"] = level.score["enemies_killed"] + 50;
  level.trial_enemies_killed++;
  level.player thread scripts\mp\rank::scorepointspopup(50);
  waitframe();
  score_calculate();
}

score_event_civilian_killed() {
  level.score["civilians_killed"] = level.score["civilians_killed"] + -500;
  level.trial_civilians_killed++;
  level.player playSound("trial_sfx_buzzer_bad_1");
  waitframe();
  score_calculate();
}

score_event_headshot() {
  level.score["headshot"] = level.score["headshot"] + 25;
  level.player thread scripts\mp\rank::scorepointspopup(25);
  waitframe();
  score_calculate();
}

score_event_fob_cleared() {
  level.score["fobs_cleared"] = level.score["fobs_cleared"] + 1000;
  level.trial_fobs_cleared++;
  level.player thread scripts\mp\rank::scorepointspopup(1000);
  level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
  waitframe();
  score_calculate();
}

score_event_time_remaining() {
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(1);

  if(!level.player_died_during_course) {
    time_remaining = level.trial_end_time - gettime();
    level.trial_time_remaining = clamp(time_remaining, 0, pow(2, 31) - 2);
    level.score["time_remaining"] = scripts\mp\utility\script::limitdecimalplaces(level.trial_time_remaining / 1000, 1) * 10;
  }

  waitframe();
  score_calculate(1);
}

score_event_turret_killed() {
  level.score["turrets_killed"] = level.score["turrets_killed"] + 100;
  level.trial_turrets_killed++;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
  waitframe();
  score_calculate();
}

dialog_init() {
  game["dialog"]["trial_intro"] = "kh_guncourse_intro_alt";
  game["dialog"]["trial_intro_short"] = "kh_guncourse_intro_short_alt";
  game["dialog"]["trial_end_tier_0"] = "kh_guncourse_star0";
  game["dialog"]["trial_end_tier_1"] = "kh_guncourse_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_guncourse_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_guncourse_star3";
  game["dialog"]["trial_retry"] = "kh_guncourse_retry";
  game["dialog"]["course_start"] = "kh_guncourse_start";
  game["dialog"]["course_nice_shot"] = "kh_guncourse_goodshot";
  game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
  game["dialog"]["course_hurry_up"] = "kh_guncourse_hurryup";
  thread dialog_kill_watcher();
}

dialog_kill_watcher() {
  level waittill("course_started");
  _id_7C7A2963CFDD5A97 = 0;
  _id_D3F5CAE78FA5AD50 = 0;
  _id_69BE3FE091D57F48 = gettime();
  _id_6EAE12D7176B3456 = gettime();
  min_delay = 5000;

  for(;;) {
    if(level.score["civilians_killed"] < level.score["civilians_killed"] && gettime() > _id_6EAE12D7176B3456 + min_delay) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      _id_98D972C56F7E96BC = gettime();
    } else if(level.score["enemies_killed"] > level.score["enemies_killed"] + 1 && gettime() > _id_69BE3FE091D57F48 + min_delay) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
      _id_98D972C56F7E96BC = gettime();
    }

    _id_D3F5CAE78FA5AD50 = level.score["civilians_killed"];
    _id_7C7A2963CFDD5A97 = level.score["enemies_killed"];
    waitframe();
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_arm_course;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["kills"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
    game["trial"]["analytics"]["turrets"] = 0;
    game["trial"]["analytics"]["fobs"] = 0;
  }
}

trial_dlog_arm_course() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  score = getomnvar("ui_trial_best_score");
  kills = int(game["trial"]["analytics"]["kills"]);
  civilians = int(game["trial"]["analytics"]["civilians"]);
  turrets = int(game["trial"]["analytics"]["turrets"]);
  _id_47A3B799C2843055 = int(game["trial"]["analytics"]["fobs"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_arm_course", ["id", id, "tier", tier, "score", score, "kills", kills, "civilians", civilians, "turrets", turrets, "fobs", _id_47A3B799C2843055]);
}