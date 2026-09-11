/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58311.gsc
***********************************************/

function ref_13d4c() {
  var_0 = getDvar("LOQKLRKQMO");

  if(var_0 == "1") {
    return true;
  }

  return false;
}

function ref_13d42() {
  if(ref_13d4c()) {
    return "mp/trial_event_mission_table.csv";
  }

  return "mp/trial_mission_table.csv";
}

function trial_ui_set_main_score(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_main_score", int(var_0));
}

function trial_ui_set_main_time(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var_0 -= var_0 % 100;
  setomnvar("ui_trial_main_time", int(var_0));
}

function trial_ui_set_subscore(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_subscore", int(var_0));
}

function trial_ui_set_subtime(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var_0 -= var_0 % 100;
  setomnvar("ui_trial_subtime", int(var_0));
}

function trial_ui_set_secondary_timer(var_0) {
  setomnvar("ui_trial_secondary_time", int(var_0));
}

function trial_ui_freeze_secondary_timer(var_0) {
  setomnvar("ui_trial_secondary_time_frozen", var_0);
}

function trial_ui_hide_secondary_timer() {
  setomnvar("ui_trial_secondary_time", int(-1));
}

function trial_ui_set_best_score(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  game["trial"]["best_score"] = var_0;
  setomnvar("ui_trial_best_score", int(var_0));
}

function trial_ui_set_best_time(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var_0 -= var_0 % 100;
  game["trial"]["best_time"] = var_0;
  setomnvar("ui_trial_best_time", int(var_0));
}

function trial_ui_set_objective_progress(var_0, var_1) {
  setomnvar("ui_trial_objective_progress", var_0);
  setomnvar("ui_trial_objective_total", var_1);
}

function trial_ui_set_wave(var_0, var_1) {
  setomnvar("ui_trial_wave_progress", var_0);
  setomnvar("ui_trial_wave_total", var_1);
}

function ref_13d8d(var_0, var_1) {
  setomnvar("ui_trial_lap_progress", var_0);
  setomnvar("ui_trial_lap_total", var_1);
}

function trial_ui_set_objective_icon_index(var_0) {
  setomnvar("ui_trial_objective_icon_index", var_0);
}

function trial_ui_set_reward_tier(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_reward_tier", int(var_0));
}

function trial_ui_set_reward_tier_preview(var_0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_reward_tier_preview", var_0);
}

function ref_13d88() {
  if(getDvar("LOQKLRKQMO") == "1") {
    game["trial"]["tries_remaining"] = 2;
  } else {
    game["trial"]["tries_remaining"]--;
  }

  setomnvar("ui_trial_tries_remaining", game["trial"]["tries_remaining"]);
}

function trial_ui_set_tries_remaining(var_0) {
  game["trial"]["tries_remaining"] = var_0;
  setomnvar("ui_trial_tries_remaining", var_0);
}

function trial_ui_set_stat_and_bonus_score(var_0, var_1, var_2, var_3) {
  if(getomnvar("ui_trial_stats_rows") < var_0) {
    setomnvar("ui_trial_stats_rows", int(var_0));
  }

  var_4 = tablelookup("mp/trial_stat_lines.csv", 1, var_1, 0);
  setomnvar("ui_trial_stats_row" + int(var_0) + "_stat_index", int(var_4));
  setomnvar("ui_trial_stats_row" + int(var_0) + "_stat", int(var_2));
  setomnvar("ui_trial_stats_row" + int(var_0) + "_bonus_score", int(var_3));
}

function trial_ui_set_stat_and_bonus_time(var_0, var_1, var_2, var_3) {
  if(getomnvar("ui_trial_stats_rows") < var_0) {
    setomnvar("ui_trial_stats_rows", int(var_0));
  }

  var_4 = tablelookup("mp/trial_stat_lines.csv", 1, var_1, 0);
  var_3 -= var_3 % 100;
  setomnvar("ui_trial_stats_row" + int(var_0) + "_stat_index", int(var_4));
  setomnvar("ui_trial_stats_row" + int(var_0) + "_stat", int(var_2));
  setomnvar("ui_trial_stats_row" + int(var_0) + "_bonus_time", int(var_3));
}

function ref_13d89(var_0) {
  setomnvar("ui_trial_retry_disabled", var_0);
}

function intro_techos_deposit_fullcar(var_0, var_1) {
  if(var_0 == "bink_complete") {
    level notify("bink_complete");
    return;
  }
}

function trial_ui_open_results_screen() {
  level.unset_stay_at_spawn_flag_on_entering_combat = 1;
  level.player playSound("trial_sfx_completed");
  scripts\engine\utility::delaythread(lookupsoundlength("trial_sfx_completed") / 1000, &scripts\mp\gametypes\trial::trial_end_score_dialogue);
  wait 0.5;
  level.player freezecontrols(1);
  wait 0.5;

  if(getDvar("LOQKLRKQMO") != "1") {
    level.player openmenu("RoundEndTeamHud");
    wait 3;
  } else {
    level.player openmenu("RoundEndTrialEvent");
    wait 3;
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&intro_techos_deposit_fullcar);
    level.player openmenu("TrialEventMedalBink");
    level waittill("bink_complete");
  }

  level notify("trial_results_screen_opened");
  level.player openmenu("TrialResults");
  level.player freezecontrols(0);
  level.unset_stay_at_spawn_flag_on_entering_combat = 0;
}

function ref_13d8b(var_0) {
  setomnvar("ui_combo_bar_combo", int(var_0));
}

function ref_13d8c(var_0) {
  setomnvar("ui_combo_bar_duration", int(var_0));
}

function trial_ui_waittill_retry() {
  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "trial_retry") {
      return;
    }
  }
}

function ref_13d8a(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 5000;
  }

  if(var_0) {
    level.player endon("on_vehicle");
    var_2 = gettime() + var_1;
    level.player setclientomnvar("ui_out_of_bounds_type", int(3));
    level.player setclientomnvar("ui_out_of_bounds_countdown", int(var_2));

    while(gettime() < var_2) {
      waitframe();
    }

    level.player kill();
    return;
  }

  level.player notify("on_vehicle");
  level.player setclientomnvar("ui_out_of_bounds_type", int(0));
  level.player setclientomnvar("ui_out_of_bounds_countdown", int(0));
}

function ref_13d4b(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = getDvar("NSNPRRQTOP");

  if(var_3 && var_1) {
    level.player playlocalsound("mp_kill_alert");
  } else if(isDefined(var_0)) {
    playsoundatpos(var_0.origin, var_4);
  } else {
    self playSound(var_4);
  }

  ref_13d8e("standard", var_1, 0, var_2);
}

function ref_13d8e(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = ref_13d47(var_0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var_5 <= self.lasthitmarkerpriority && !var_1) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var_5;

  if(isDefined(var_4) && !istrue(var_1)) {
    self setclientomnvar("damage_feedback_icon", var_4);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var_1) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_2) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(var_3) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function ref_13d47(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var_0];
}

function waittill_player_isDefined() {
  while(!isDefined(level.player)) {
    waitframe();
  }
}

function ref_13d5e() {
  if(level.trial["missionScript"] == "race") {
    level.ref_13d6a = 1;
    level.player kill();
  }

  level.player freezecontrols(1);
  level.player setclientomnvar("ui_total_fade", 1);
  wait 0.5;
  map_restart(1);
}

function recentc4vehiclekillcount() {
  if(level.totaltime <= level.trial["tier3"]) {
    var_0 = 3;
  } else if(level.totaltime <= level.trial["tier2"]) {
    var_0 = 2;
  } else if(level.totaltime <= level.trial["tier1"]) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  return var_0;
}