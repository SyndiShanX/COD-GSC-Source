/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58311.gsc
***********************************************/

function ref_13d4c() {
  var0 = getDvar("LOQKLRKQMO");

  if(var0 == "1") {
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

function trial_ui_set_main_score(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_main_score", int(var0));
}

function trial_ui_set_main_time(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var0 -= var0 % 100;
  setomnvar("ui_trial_main_time", int(var0));
}

function trial_ui_set_subscore(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_subscore", int(var0));
}

function trial_ui_set_subtime(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var0 -= var0 % 100;
  setomnvar("ui_trial_subtime", int(var0));
}

function trial_ui_set_secondary_timer(var0) {
  setomnvar("ui_trial_secondary_time", int(var0));
}

function trial_ui_freeze_secondary_timer(var0) {
  setomnvar("ui_trial_secondary_time_frozen", var0);
}

function trial_ui_hide_secondary_timer() {
  setomnvar("ui_trial_secondary_time", int(-1));
}

function trial_ui_set_best_score(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  game["trial"]["best_score"] = var0;
  setomnvar("ui_trial_best_score", int(var0));
}

function trial_ui_set_best_time(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  var0 -= var0 % 100;
  game["trial"]["best_time"] = var0;
  setomnvar("ui_trial_best_time", int(var0));
}

function trial_ui_set_objective_progress(var0, var1) {
  setomnvar("ui_trial_objective_progress", var0);
  setomnvar("ui_trial_objective_total", var1);
}

function trial_ui_set_wave(var0, var1) {
  setomnvar("ui_trial_wave_progress", var0);
  setomnvar("ui_trial_wave_total", var1);
}

function ref_13d8d(var0, var1) {
  setomnvar("ui_trial_lap_progress", var0);
  setomnvar("ui_trial_lap_total", var1);
}

function trial_ui_set_objective_icon_index(var0) {
  setomnvar("ui_trial_objective_icon_index", var0);
}

function trial_ui_set_reward_tier(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_reward_tier", int(var0));
}

function trial_ui_set_reward_tier_preview(var0) {
  if(istrue(level.ref_13d2e)) {
    return;
  }

  setomnvar("ui_trial_reward_tier_preview", var0);
}

function ref_13d88() {
  if(getDvar("LOQKLRKQMO") == "1") {
    game["trial"]["tries_remaining"] = 2;
  } else {
    game["trial"]["tries_remaining"]--;
  }

  setomnvar("ui_trial_tries_remaining", game["trial"]["tries_remaining"]);
}

function trial_ui_set_tries_remaining(var0) {
  game["trial"]["tries_remaining"] = var0;
  setomnvar("ui_trial_tries_remaining", var0);
}

function trial_ui_set_stat_and_bonus_score(var0, var1, var2, var3) {
  if(getomnvar("ui_trial_stats_rows") < var0) {
    setomnvar("ui_trial_stats_rows", int(var0));
  }

  var4 = tablelookup("mp/trial_stat_lines.csv", 1, var1, 0);
  setomnvar("ui_trial_stats_row" + int(var0) + "_stat_index", int(var4));
  setomnvar("ui_trial_stats_row" + int(var0) + "_stat", int(var2));
  setomnvar("ui_trial_stats_row" + int(var0) + "_bonus_score", int(var3));
}

function trial_ui_set_stat_and_bonus_time(var0, var1, var2, var3) {
  if(getomnvar("ui_trial_stats_rows") < var0) {
    setomnvar("ui_trial_stats_rows", int(var0));
  }

  var4 = tablelookup("mp/trial_stat_lines.csv", 1, var1, 0);
  var3 -= var3 % 100;
  setomnvar("ui_trial_stats_row" + int(var0) + "_stat_index", int(var4));
  setomnvar("ui_trial_stats_row" + int(var0) + "_stat", int(var2));
  setomnvar("ui_trial_stats_row" + int(var0) + "_bonus_time", int(var3));
}

function ref_13d89(var0) {
  setomnvar("ui_trial_retry_disabled", var0);
}

function intro_techos_deposit_fullcar(var0, var1) {
  if(var0 == "bink_complete") {
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

function ref_13d8b(var0) {
  setomnvar("ui_combo_bar_combo", int(var0));
}

function ref_13d8c(var0) {
  setomnvar("ui_combo_bar_duration", int(var0));
}

function trial_ui_waittill_retry() {
  for(;;) {
    level.player waittill("luinotifyserver", var0);

    if(var0 == "trial_retry") {
      return;
    }
  }
}

function ref_13d8a(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 5000;
  }

  if(var0) {
    level.player endon("on_vehicle");
    var2 = gettime() + var1;
    level.player setclientomnvar("ui_out_of_bounds_type", int(3));
    level.player setclientomnvar("ui_out_of_bounds_countdown", int(var2));

    while(gettime() < var2) {
      waitframe();
    }

    level.player kill();
    return;
  }

  level.player notify("on_vehicle");
  level.player setclientomnvar("ui_out_of_bounds_type", int(0));
  level.player setclientomnvar("ui_out_of_bounds_countdown", int(0));
}

function ref_13d4b(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = getDvar("NSNPRRQTOP");

  if(var3 && var1) {
    level.player playlocalsound("mp_kill_alert");
  } else if(isDefined(var0)) {
    playsoundatpos(var0.origin, var4);
  } else {
    self playSound(var4);
  }

  ref_13d8e("standard", var1, 0, var2);
}

function ref_13d8e(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var5 = ref_13d47(var0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var5 <= self.lasthitmarkerpriority && !var1) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var5;

  if(isDefined(var4) && !istrue(var1)) {
    self setclientomnvar("damage_feedback_icon", var4);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", var0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var1) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var2) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(var3) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function ref_13d47(var0) {
  if(!isDefined(level.hitmarkerpriorities[var0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var0];
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
    var0 = 3;
  } else if(level.totaltime <= level.trial["tier2"]) {
    var0 = 2;
  } else if(level.totaltime <= level.trial["tier1"]) {
    var0 = 1;
  } else {
    var0 = 0;
  }

  return var0;
}