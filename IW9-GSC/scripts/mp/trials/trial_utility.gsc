/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_utility.gsc
***********************************************/

trial_is_event() {
  _id_C280D7A702434B56 = getDvar("bg_trial_mission_is_event");

  if(_id_C280D7A702434B56 == "1")
    return 1;

  return 0;
}

trial_fetch_mission_table() {
  if(trial_is_event())
    return "mp/trial_event_mission_table.csv";

  return "mp/trial_mission_table.csv";
}

trial_ui_set_main_score(score) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  setomnvar("ui_trial_main_score", int(score));
}

trial_ui_set_main_time(time) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  time = time - time % 100;
  setomnvar("ui_trial_main_time", int(time));
}

trial_ui_set_subscore(score) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  setomnvar("ui_trial_subscore", int(score));
}

trial_ui_set_subtime(time) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  time = time - time % 100;
  setomnvar("ui_trial_subtime", int(time));
}

trial_ui_set_secondary_timer(end_time) {
  setomnvar("ui_trial_secondary_time", int(end_time));
}

trial_ui_freeze_secondary_timer(_id_732FC0C83CCF0D58) {
  setomnvar("ui_trial_secondary_time_frozen", _id_732FC0C83CCF0D58);
}

trial_ui_hide_secondary_timer() {
  setomnvar("ui_trial_secondary_time", int(-1));
}

trial_ui_set_best_score(score) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  game["trial"]["best_score"] = score;
  setomnvar("ui_trial_best_score", int(score));
}

trial_ui_set_best_time(time) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  time = time - time % 100;
  game["trial"]["best_time"] = time;
  setomnvar("ui_trial_best_time", int(time));
}

trial_ui_set_objective_progress(progress, total) {
  setomnvar("ui_trial_objective_progress", progress);
  setomnvar("ui_trial_objective_total", total);
}

trial_ui_set_wave(_id_A2B11613E4C46ED8, total) {
  setomnvar("ui_trial_wave_progress", _id_A2B11613E4C46ED8);
  setomnvar("ui_trial_wave_total", total);
}

trial_ui_set_lap(lap, total) {
  setomnvar("ui_trial_lap_progress", lap);
  setomnvar("ui_trial_lap_total", total);
}

trial_ui_set_objective_icon_index(icon) {
  setomnvar("ui_trial_objective_icon_index", icon);
}

trial_ui_set_reward_tier(tier) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  setomnvar("ui_trial_reward_tier", int(tier));
}

trial_ui_set_reward_tier_preview(tier) {
  if(istrue(level._id_44F499EB7125DF94)) {
    return;
  }
  setomnvar("ui_trial_reward_tier_preview", tier);
}

trial_ui_decrease_tries_remaining() {
  if(getDvar("bg_trial_mission_is_event") == "1")
    game["trial"]["tries_remaining"] = 2;
  else
    game["trial"]["tries_remaining"]--;

  setomnvar("ui_trial_tries_remaining", game["trial"]["tries_remaining"]);
}

trial_ui_set_tries_remaining(_id_262683DEEA02353A) {
  game["trial"]["tries_remaining"] = _id_262683DEEA02353A;
  setomnvar("ui_trial_tries_remaining", _id_262683DEEA02353A);
}

trial_ui_set_stat_and_bonus_score(_id_CB89110314447B2F, _id_415D8240D8C76BEC, _id_D0F001B1761FBF53, _id_2AD6C5502CBBD27D) {
  if(getomnvar("ui_trial_stats_rows") < _id_CB89110314447B2F)
    setomnvar("ui_trial_stats_rows", int(_id_CB89110314447B2F));

  _id_26A6EDF235BE8500 = tablelookup("mp/trial_stat_lines.csv", 1, _id_415D8240D8C76BEC, 0);
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_stat_index", int(_id_26A6EDF235BE8500));
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_stat", int(_id_D0F001B1761FBF53));
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_bonus_score", int(_id_2AD6C5502CBBD27D));
}

trial_ui_set_stat_and_bonus_time(_id_CB89110314447B2F, _id_415D8240D8C76BEC, _id_D0F001B1761FBF53, _id_946DB8FC856C630C) {
  if(getomnvar("ui_trial_stats_rows") < _id_CB89110314447B2F)
    setomnvar("ui_trial_stats_rows", int(_id_CB89110314447B2F));

  _id_26A6EDF235BE8500 = tablelookup("mp/trial_stat_lines.csv", 1, _id_415D8240D8C76BEC, 0);
  _id_946DB8FC856C630C = _id_946DB8FC856C630C - _id_946DB8FC856C630C % 100;
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_stat_index", int(_id_26A6EDF235BE8500));
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_stat", int(_id_D0F001B1761FBF53));
  setomnvar("ui_trial_stats_row" + int(_id_CB89110314447B2F) + "_bonus_time", int(_id_946DB8FC856C630C));
}

trial_ui_retry_disabled(_id_E3108E412AFB3811) {
  setomnvar("ui_trial_retry_disabled", _id_E3108E412AFB3811);
}

cutscenedone(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete")
    level notify("bink_complete");
}

trial_ui_open_results_screen() {
  level.isinrewardflow = 1;
  level.player playSound("trial_sfx_completed");
  scripts\engine\utility::delaythread(lookupsoundlength("trial_sfx_completed") / 1000, _id_7EED363A9B249F1C::trial_end_score_dialogue);
  wait 0.5;
  level.player freezecontrols(1);
  wait 0.5;

  if(getDvar("bg_trial_mission_is_event") != "1") {
    level.player openmenu("RoundEndTeamHud");
    wait 3;
  } else {
    level.player openmenu("RoundEndTrialEvent");
    wait 3;
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::cutscenedone);
    level.player openmenu("TrialEventMedalBink");
    level waittill("bink_complete");
  }

  level notify("trial_results_screen_opened");
  level.player openmenu("TrialResults");
  level.player freezecontrols(0);
  level.isinrewardflow = 0;
}

trial_ui_set_combo_bar_combo(_id_8BB6B9B919C2C19D) {
  setomnvar("ui_combo_bar_combo", int(_id_8BB6B9B919C2C19D));
}

trial_ui_set_combo_bar_duration(duration) {
  setomnvar("ui_combo_bar_duration", int(duration));
}

trial_ui_waittill_retry() {
  for(;;) {
    level.player waittill("luinotifyserver", msg);

    if(msg == "trial_retry")
      return;
  }
}

trial_ui_return_to_vehicle(active, _id_5659806E75F89695) {
  if(!isDefined(_id_5659806E75F89695))
    _id_5659806E75F89695 = 5000;

  if(active) {
    level.player endon("on_vehicle");
    endtime = gettime() + _id_5659806E75F89695;
    level.player setclientomnvar("ui_out_of_bounds_type", int(3));
    level.player setclientomnvar("ui_out_of_bounds_countdown", int(endtime));

    while(gettime() < endtime)
      waitframe();

    level.player kill();
  } else {
    level.player notify("on_vehicle");
    level.player setclientomnvar("ui_out_of_bounds_type", int(0));
    level.player setclientomnvar("ui_out_of_bounds_countdown", int(0));
  }
}

trial_hitmarker(_id_F182D284B07A828E, _id_B3990D56E2779F79, iscivilian, _id_942B8C491D5D7BD1) {
  if(!isDefined(_id_B3990D56E2779F79))
    _id_B3990D56E2779F79 = 0;

  if(!isDefined(iscivilian))
    iscivilian = 0;

  if(!isDefined(_id_942B8C491D5D7BD1))
    _id_942B8C491D5D7BD1 = 0;

  alias = getDvar("snd_hitmarker_alias");

  if(_id_942B8C491D5D7BD1 && _id_B3990D56E2779F79)
    level.player playlocalsound("mp_kill_alert");
  else if(isDefined(_id_F182D284B07A828E))
    playsoundatpos(_id_F182D284B07A828E.origin, alias);
  else
    self playSound(alias);

  trial_updatehitmarker("standard", _id_B3990D56E2779F79, 0, iscivilian);
}

trial_updatehitmarker(_id_E0EA2C8DF06F13EB, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_DC382B1157307F94) {
  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(!isDefined(_id_D7198CEB7D51DB5B))
    _id_D7198CEB7D51DB5B = 0;

  if(!isDefined(headshot))
    headshot = 0;

  if(!isDefined(_id_C4F1516C772B1C2D))
    _id_C4F1516C772B1C2D = 0;

  priority = trial_gethitmarkerpriority(_id_E0EA2C8DF06F13EB);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !_id_D7198CEB7D51DB5B) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(_id_DC382B1157307F94) && !istrue(_id_D7198CEB7D51DB5B)) {
    self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", _id_E0EA2C8DF06F13EB);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(_id_D7198CEB7D51DB5B)
    self setclientomnvar("damage_feedback_kill", 1);
  else
    self setclientomnvar("damage_feedback_kill", 0);

  if(headshot)
    self setclientomnvar("damage_feedback_headshot", 1);
  else
    self setclientomnvar("damage_feedback_headshot", 0);

  if(_id_C4F1516C772B1C2D)
    self setclientomnvar("damage_feedback_nonplayer", 1);
  else
    self setclientomnvar("damage_feedback_nonplayer", 0);
}

trial_gethitmarkerpriority(_id_B98146816886D3C4) {
  if(!isDefined(level.hitmarkerpriorities[_id_B98146816886D3C4]))
    return 0;

  return level.hitmarkerpriorities[_id_B98146816886D3C4];
}

waittill_player_isDefined() {
  while(!isDefined(level.player))
    waitframe();
}

trial_restart() {
  if(level.trial["missionScript"] == "race") {
    level.trial_spawn_wait = 1;
    level.player kill();
  }

  level.player freezecontrols(1);
  level.player setclientomnvar("ui_total_fade", 1);
  wait 0.5;
  map_restart(1);
}

get_tier_reward_for_total_time() {
  if(level.totaltime <= level.trial["tier3"])
    rewardtier = 3;
  else if(level.totaltime <= level.trial["tier2"])
    rewardtier = 2;
  else if(level.totaltime <= level.trial["tier1"])
    rewardtier = 1;
  else
    rewardtier = 0;

  return rewardtier;
}

_id_1A95518CCBBA458E(_id_0B8B9E9EFD754D14) {
  _id_C85C96521B9FA174 = [];

  switch (_id_0B8B9E9EFD754D14) {
    case "trial_variant_middlerange":
      _id_C85C96521B9FA174 = getEntArray("progression", "targetname");
      break;
    case "trial_variant_cqb":
      _id_C85C96521B9FA174 = getEntArray("progression", "targetname");
      break;
  }

  return _id_C85C96521B9FA174;
}

_id_BB06080B145E3C85(_id_0B8B9E9EFD754D14) {
  _id_F5D4334B9D9F600F = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  _id_6899ABC6E6B6E60E = [];

  foreach(_id_367313041E5F7F95 in _id_F5D4334B9D9F600F) {
    if(isDefined(_id_367313041E5F7F95.script_gameobjectname) && _id_367313041E5F7F95.script_gameobjectname == _id_0B8B9E9EFD754D14)
      _id_6899ABC6E6B6E60E[_id_6899ABC6E6B6E60E.size] = _id_367313041E5F7F95;
  }

  return _id_6899ABC6E6B6E60E;
}

_id_1D8E53696962A7AF() {
  return getdvarint("touch_enabled");
}