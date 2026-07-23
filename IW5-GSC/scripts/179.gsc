/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\179.gsc
**************************************/

setup_xp() {
  wait 0.05;
  maps\_rank::xp_init();
}

register_level_unlock(var_0, var_1) {
  var_2 = int(tablelookup("sp/specOpsTable.csv", 1, var_0, 5));
  var_3 = tablelookup("sp/specOpsTable.csv", 1, var_0, 6);
  var_4 = 1;
  unlock_register(var_0, var_2, var_3, "", "", var_1, var_4);
}

register_survival_unlock() {
  register_level_unlock("so_survival_2", "survival");
  register_level_unlock("so_survival_3", "survival");
  register_level_unlock("so_survival_4", "survival");
  register_survival_armory_unlock(100, 120, "weaponupgrade");
  register_survival_armory_unlock(0, 64, "weapon");
  register_survival_armory_unlock(1000, 1020, "equipment");
  register_survival_armory_unlock(10000, 10020, "airsupport");
}

register_survival_armory_unlock(var_0, var_1, var_2) {
  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = tablelookup("sp/survival_armories.csv", 0, var_3, 1);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = var_3;
    var_6 = var_4;
    var_7 = var_2;
    var_8 = tablelookup("sp/survival_armories.csv", 1, var_4, 4);
    var_9 = tablelookup("sp/survival_armories.csv", 1, var_4, 5);
    var_10 = int(tablelookup("sp/survival_armories.csv", 1, var_4, 7));

    if(var_10 > 0) {
      var_11 = "weapon_missing_image";

      if(var_7 == "airsupport") {
        var_11 = "specops_ui_airsupport";
      }
      if(var_7 == "equipment") {
        var_11 = "specops_ui_equipmentstore";
      }
      if(var_7 == "weapon" || var_7 == "weaponupgrade") {
        var_11 = "specops_ui_weaponstore";
      }
      var_12 = 0;
      unlock_register(var_6, var_10, var_8, var_9, var_11, "survival", var_12);
    }
  }
}

unlock_register(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.ref = var_0;
  var_7.name = var_2;
  var_7.desc = var_3;
  var_7.icon = var_4;
  var_7.unlocklvl = var_1;
  var_7.mode = var_5;
  var_7.feature = var_6;

  if(!isDefined(level.unlock_array)) {
    level.unlock_array = [];
  }
  if(!isDefined(level.unlock_array[var_1])) {
    level.unlock_array[var_1] = [];
  }
  level.unlock_array[var_1][level.unlock_array[var_1].size] = var_7;
}

pick_starting_location_so(var_0) {
  if(isDefined(var_0) && var_0) {
    if(isDefined(level.skip_playersetstreamorigin) && level.skip_playersetstreamorigin) {
      return undefined;
    }
  }

  if(isDefined(level.pmc_match) && level.pmc_match) {
    return pick_starting_location_pmc(var_0);
  }
  var_1 = getEntArray("info_player_start_so", "classname");

  if(var_1.size <= 0) {
    var_1 = getEntArray("info_player_start", "classname");
  }
  var_2 = common_scripts\utility::random(var_1);

  if(isDefined(var_0) && var_0) {
    return var_2.origin;
  }
  place_player_at_start_point(level.player, var_2);

  if(maps\_utility::is_coop()) {
    var_3 = getEntArray("info_player_start_soPlayer2", "classname");

    if(var_3.size > 0) {
      var_4 = maps\_utility::getclosest(var_2.origin, var_3);
      place_player_at_start_point(level.player2, var_4);
    } else {
      place_player2_near_player1();
    }
  }
}

isdefendmatch() {
  return level.pmc_gametype == "mode_defend";
}

pick_starting_location_pmc(var_0) {
  if(isdefendmatch()) {
    var_1 = getEntArray("info_player_start_pmcDefend", "classname");
  } else {
    var_1 = getEntArray("info_player_start_pmc", "classname");
  }
  var_2 = [];
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(!var_2.size) {
      var_3 = common_scripts\utility::random(var_1);
    } else {
      var_3 = maps\_utility::get_closest_exclude(var_3.origin, var_1, var_2);
    }
    if(isDefined(var_0) && var_0) {
      return var_3.origin;
    }
    var_5 setOrigin(var_3.origin);
    var_5 setplayerangles(var_3.angles);
    var_2[var_2.size] = var_3;
  }
}

place_player_at_start_point(var_0, var_1) {
  var_0 setOrigin(var_1.origin);

  if(isDefined(var_1.angles)) {
    var_0 setplayerangles(var_1.angles);
  }
}

place_player2_near_player1() {
  level.player2 setplayerangles(level.player.angles + (0, -25, 0));
  level.player2 setOrigin(level.player.origin);
  var_0 = spawnStruct();
  var_0.entity = level.player2;
  var_0.right = -20.0;
  var_0.forward = -50.0;
  var_0 maps\_utility::flashbanggettimeleftsec();
  level.player2 setOrigin(level.player2.origin);
}

specialops_remove_entity_check(var_0) {
  if(so_hud_can_toggle(var_0)) {
    return 1;
  }
  if(specialops_remove_name_check(var_0)) {
    return 1;
  }
  return 0;
}

so_hud_can_toggle(var_0) {
  if(!isDefined(self.script_specialops)) {
    return 0;
  }
  if(self.script_specialops == var_0) {
    return 0;
  }
  return 1;
}

specialops_remove_name_check(var_0) {
  if(!isDefined(self.script_specialopsname)) {
    return 0;
  }
  if(var_0 == 0) {
    return 1;
  }
  var_1 = strtok(self.script_specialopsname, ":;, ");
  var_2 = 1;

  foreach(var_4 in var_1) {
    if(var_4 == level.script) {
      var_2 = 0;
      break;
    }
  }

  return var_2;
}

so_create_hud_item_delay_draw(var_0) {
  var_0.alpha = 0;

  while(!so_hud_can_show()) {
    wait 0.5;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(validate_timer(var_0)) {
    switch (self.so_infohud_toggle_state) {
      case "on":
      case "none":
        var_0 maps\_hud_util::fade_over_time(1, 0.5);
        break;
      case "off":
        var_0 maps\_hud_util::fade_over_time(0, 0.5);
        break;
      default:
    }
  } else {
    var_0 maps\_hud_util::fade_over_time(1, 0.5);
  }
  if(!maps\_utility::ent_flag("so_hud_can_toggle")) {
    maps\_utility::ent_flag_set("so_hud_can_toggle");
  }
}

so_hud_can_show() {
  if(isDefined(level.so_waiting_for_players) && level.so_waiting_for_players) {
    return 0;
  }
  if(isDefined(level.challenge_time_force_on) && level.challenge_time_force_on) {
    return 1;
  }
  if(!isDefined(self.so_hud_show_time)) {
    return 1;
  }
  return gettime() > self.so_hud_show_time;
}

validate_timer(var_0) {
  if(!isDefined(var_0.so_can_toggle) || !var_0.so_can_toggle) {
    return 0;
  }
  if(!isDefined(self.so_infohud_toggle_state)) {
    return 0;
  }
  return 1;
}

challenge_timer_player_setup(var_0, var_1, var_2, var_3) {
  level endon("challenge_timer_expired");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");
  var_4 = undefined;

  if(isDefined(var_3) && var_3) {
    var_4 = 1;
  }
  var_5 = maps\_specialops::so_hud_ypos();
  self.hud_so_timer_msg = maps\_specialops::so_create_hud_item(1, var_5, var_2, self, var_4);

  if(isDefined(level.challenge_time_limit)) {
    self.hud_so_timer_time = maps\_specialops::so_create_hud_item(1, var_5, undefined, self, var_4);
    self.hud_so_timer_time settenthstimerstatic(level.challenge_time_limit);
  } else {
    self.hud_so_timer_time = maps\_specialops::so_create_hud_item(1, var_5, &"SPECIAL_OPS_TIME_NULL", self, var_4);
  }
  self.hud_so_timer_time.alignx = "left";

  if(!isDefined(var_3) || var_3 == 0) {
    thread maps\_specialops::info_hud_wait_for_player();
    thread maps\_specialops::info_hud_handle_fade(self.hud_so_timer_msg);
    thread maps\_specialops::info_hud_handle_fade(self.hud_so_timer_time);
  } else {
    self.so_infohud_toggle_state = "none";
    self.hud_so_timer_msg.alpha = 0;
    self.hud_so_timer_time.alpha = 0;
  }

  challenge_timer_wait_start(self.hud_so_timer_msg, self.hud_so_timer_time, var_0);

  if(isDefined(level.challenge_time_limit)) {
    level.so_challenge_time_left = level.challenge_time_limit;
    thread challenge_timer_show_nudge(self.hud_so_timer_msg, self.hud_so_timer_time);
    thread challenge_timer_show_hurry(self.hud_so_timer_msg, self.hud_so_timer_time);
    thread challenge_timer_show_failed(self.hud_so_timer_msg, self.hud_so_timer_time);
    thread challenge_timer_destroy_prematurely(self.hud_so_timer_msg, self.hud_so_timer_time);
  }

  thread challenge_timer_wait_passed(self.hud_so_timer_msg, self.hud_so_timer_time, var_1);
}

challenge_timer_detect_3quarter() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_3quarter")) {
    common_scripts\utility::flag_init("so_challenge_is_3quarter");
  }
  common_scripts\utility::flag_wait("so_challenge_is_3quarter");
  maps\_specialops::so_dialog_progress_update(3, 4);
}

challenge_timer_detect_halfway() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_halfway")) {
    common_scripts\utility::flag_init("so_challenge_is_halfway");
  }
  common_scripts\utility::flag_wait("so_challenge_is_halfway");
  maps\_specialops::so_dialog_progress_update(2, 4);
}

challenge_timer_detect_quarter() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_quarter")) {
    common_scripts\utility::flag_init("so_challenge_is_quarter");
  }
  common_scripts\utility::flag_wait("so_challenge_is_quarter");
  maps\_specialops::so_dialog_progress_update(1, 4);
}

challenge_timer_wait_start(var_0, var_1, var_2) {
  level endon("special_op_terminated");

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }
  foreach(var_4 in level.players) {
    if(!var_4 so_hud_can_show()) {
      var_4.so_hud_show_time = gettime();
    }
  }

  if(!isDefined(level.challenge_start_time)) {
    if(challenge_timer_should_play_alarm()) {
      level.player playSound("arcademode_zerodeaths");
    }
    level.challenge_start_time = gettime();
  } else {
    level.challenge_start_time_last = gettime();
  }
  var_1.label = "";

  if(isDefined(level.challenge_time_limit)) {
    var_1 settenthstimer(level.challenge_time_limit);
  } else {
    var_1 settenthstimerup(0.0);
  }
}

challenge_timer_should_play_alarm() {
  if(isDefined(level.challenge_time_limit)) {
    return 1;
  }
  foreach(var_1 in level.players) {
    if(var_1.so_infohud_toggle_state != "off") {
      return 1;
    }
  }

  return 0;
}

challenge_timer_show_nudge(var_0, var_1) {
  if(!validate_timer(level.challenge_time_nudge)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");

  while(level.so_challenge_time_left > level.challenge_time_nudge) {
    wait 0.1;
  }
  var_0 set_hudelem_yellow();
  var_1 set_hudelem_yellow();

  if(!challenge_timer_be_silent()) {
    thread maps\_specialops::so_dialog_time_low_normal();
  }
}

challenge_timer_show_hurry(var_0, var_1) {
  if(!validate_timer(level.challenge_time_hurry)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");

  while(level.so_challenge_time_left > level.challenge_time_hurry) {
    wait 0.1;
  }
  var_0 set_hudelem_red();
  var_1 set_hudelem_red();

  if(!challenge_timer_be_silent()) {
    thread maps\_specialops::so_dialog_time_low_hurry();
  }
}

challenge_timer_be_silent() {
  if(self != level.player) {
    return 1;
  }
  if(!isDefined(level.challenge_time_silent)) {
    return 0;
  }
  return level.challenge_time_silent;
}

challenge_timer_thread() {
  level endon("special_op_terminated");
  level notify("stop_challenge_timer_thread");
  level endon("stop_challenge_timer_thread");

  while(level.so_challenge_time_left > 0) {
    wait 0.05;
    level.so_challenge_time_left = level.so_challenge_time_left - 0.05;
    thread challenge_timer_give_alert();
  }

  level notify("challenge_timer_failed");
}

challenge_timer_give_alert() {
  if(challenge_timer_should_pulse()) {
    foreach(var_1 in level.players) {
      var_1.hud_so_timer_msg thread maps\_specialops::so_hud_pulse_create();
      var_1.hud_so_timer_time thread maps\_specialops::so_hud_pulse_create();
    }

    if(level.so_challenge_time_beep < 0) {
      level.player playSound("arcademode_kill_streak_lost");
    } else {
      level.player playSound("so_countdown_beep");
    }
  }
}

challenge_timer_should_pulse() {
  if(level.so_challenge_time_left > level.so_challenge_time_beep) {
    return 0;
  }
  for(var_0 = 0; var_0 <= level.challenge_time_beep_start; var_0++) {
    if(level.so_challenge_time_left > var_0) {
      if(level.so_challenge_time_beep < var_0) {
        level.so_challenge_time_beep = var_0 + 1;
      }
      continue;
    }

    level.so_challenge_time_beep = var_0 - 1;
    return 1;
  }

  return 0;
}

challenge_timer_show_failed(var_0, var_1) {
  if(!validate_timer(level.challenge_time_limit)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");
  thread challenge_timer_thread();
  level waittill("challenge_timer_failed");
  common_scripts\utility::flag_set("challenge_timer_expired");
  challenge_timer_destroy(var_0, var_1);

  if(self == level.player) {
    thread maps\_specialops::so_dialog_mission_failed_time();
  }
  var_2 = "@SPECIAL_OPS_FAILURE_HINT_TIME";

  if(isDefined(level.so_deadquote_time)) {
    var_2 = level.so_deadquote_time;
  }
  maps\_specialops::so_force_deadquote(var_2, "ui_time_failure");

  if(self == level.player) {
    maps\_utility::missionfailedwrapper();
  }
}

challenge_timer_wait_passed(var_0, var_1, var_2) {
  level endon("challenge_timer_expired");
  level endon("new_challenge_timer");

  if(common_scripts\utility::flag_exist("individual_timers") && common_scripts\utility::flag("individual_timers")) {
    maps\_utility::ent_flag_wait(var_2);
  } else {
    common_scripts\utility::flag_wait(var_2);
  }
  common_scripts\utility::flag_set("challenge_timer_passed");
  level.challenge_end_time = gettime();
  var_3 = common_scripts\utility::ter_op(isDefined(level.challenge_start_time_last), level.challenge_start_time_last, level.challenge_start_time);
  var_4 = maps\_utility::round_millisec_on_sec(level.challenge_end_time - var_3, 1, 0);
  var_5 = var_4 / 1000;

  if(isDefined(level.challenge_time_limit)) {
    var_5 = level.challenge_time_limit - var_5;
  }
  if(var_5 <= 0) {
    var_5 = 0.1;
  }
  var_1 settenthstimerstatic(var_5);

  if(!common_scripts\utility::flag_exist("individual_timers")) {
    return;
  }
  if(common_scripts\utility::flag("individual_timers")) {
    return;
  }
  challenge_timer_destroy(var_0, var_1);
}

challenge_timer_destroy_prematurely(var_0, var_1) {
  level waittill("new_challenge_timer");
  challenge_timer_destroy(var_0, var_1, 1);
}

challenge_timer_destroy(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 thread maps\_specialops::so_remove_hud_item(var_2);
  }
  if(isDefined(var_1)) {
    var_1 thread maps\_specialops::so_remove_hud_item(var_2);
  }
}

validate_timer(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 <= 0) {
    return 0;
  }
  return 1;
}

failure_summary_display() {
  if(getdvarint("so_nofail")) {
    return;
  }
  thread maps\_specialops::so_dialog_mission_failed_generic();
  missionfailed();
  maps\_endmission::so_eog_summary_calculate(0);
  specialops_mission_over_setup(0);
  level notify("so_generate_deathquote");
  maps\_endmission::so_eog_summary_display();
}

specialops_mission_over_setup(var_0) {
  setDvar("ui_opensummary", 1);

  if(var_0) {
    setDvar("ui_mission_success", 1);
  } else {
    setDvar("ui_mission_success", 0);
  }
  if(common_scripts\utility::flag("special_op_terminated")) {}

  if(!isDefined(level.challenge_start_time)) {
    level.challenge_start_time = gettime();
  }
  if(!isDefined(level.challenge_end_time)) {
    level.challenge_end_time = gettime();
  }
  common_scripts\utility::flag_set("special_op_terminated");
  level notify("stop_music");
  thread maps\_utility_code::mission_recon(var_0);
  var_1 = undefined;

  if(isDefined(level.pmc_game) && level.pmc_game) {
    var_1 = pick_starting_location_pmc(1);
  } else {
    var_1 = pick_starting_location_so(1);
  }
  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {}
    var_3 playersetstreamorigin(var_1);
  }

  ambientstop(2);
  maps\_utility::music_stop(1);

  if(var_0) {
    thread specialops_mission_over_setup_success();
  } else {
    thread specialops_mission_over_setup_failure();
  }
  foreach(var_3 in level.players) {
    var_3 allowjump(0);
    var_3 disableweapons();
    var_3 disableusability();
    var_3 enableinvulnerability();
    var_3.ignoreme = 1;
  }

  thread specialops_blur_player_screen();

  if(var_0) {
    wait 0.5;

    foreach(var_3 in level.players) {}
    var_3 setup_leaderboard_data();

    wait 2.5;

    foreach(var_3 in level.players) {}
    var_3 uploadleaderboards();
  } else {
    wait 3;
  }
  thread specialops_mission_over_remove_ai();

  if(!common_scripts\utility::flag("special_op_no_unlink")) {
    foreach(var_3 in level.players) {}
    var_3 unlink();
  }

  foreach(var_3 in level.players) {}
  var_3 freezecontrols(1);

  specialops_mission_over_stats(var_0);
}

setup_leaderboard_data() {
  if(maps\_utility::is_coop() && level.players.size == 2) {
    self setplayerdata("round", "xuidTeammate", maps\_utility::get_other_player(self) getxuid());
  }
  self setplayerdata("round", "timePlayed", self.so_eog_summary_data["time"]);
  self setplayerdata("round", "kills", self.so_eog_summary_data["kills"]);
  var_0 = 0;

  if(maps\_utility::is_survival()) {
    self setplayerdata("round", "score", self.so_eog_summary_data["score"]);
    self setplayerdata("round", "wave", self.so_eog_summary_data["wave"]);
    var_1 = 0;
    var_2 = 0;

    if(self.stats["weapon"].size > 0) {
      foreach(var_4 in self.stats["weapon"]) {
        var_1 = var_1 + var_4.shots_fired;
        var_2 = var_2 + var_4.shots_hit;
      }
    }

    self setplayerdata("round", "bulletsFired", var_1);
    self setplayerdata("round", "bulletsHit", var_2);
    self setplayerdata("round", "headshots", self.game_performance["headshot"]);
    self setplayerdata("round", "revives", self.game_performance["revives"]);
    self setplayerdata("round", "credits", self.game_performance["credits"]);
    self setplayerdata("round", "totalXp", self.game_performance["credits"]);
  } else {
    var_6 = level.specops_reward_gameskill;

    if(isDefined(self.forcedgameskill)) {
      var_6 = self.forcedgameskill;
    }
    self setplayerdata("round", "difficulty", var_6);
    self setplayerdata("round", "score", self.so_eog_summary_data["score"]);
  }
}

specialops_blur_player_screen() {
  foreach(var_1 in level.players) {
    wait 0.1;
    var_1 setblurforplayer(6, 1);
  }
}

specialops_mission_over_remove_ai() {
  wait 0.25;
  var_0 = getaiarray();
  var_0 = maps\_utility::array_merge(var_0, getaispeciesarray("axis", "dog"));

  foreach(var_2 in var_0) {
    if(isDefined(var_2.so_no_mission_over_delete) && var_2.so_no_mission_over_delete == 1) {
      continue;
    }
    if(isDefined(var_2.magic_bullet_shield)) {
      var_2 maps\_utility::stop_magic_bullet_shield();
    }
    var_2 delete();
  }
}

specialops_mission_over_setup_success() {
  common_scripts\utility::flag_set("special_op_succeeded");

  foreach(var_1 in level.players) {
    var_2 = maps\_hud_util::create_client_overlay("white", 0, var_1);
    var_2.color = (0.7, 0.7, 1);
    var_2 thread maps\_hud_util::fade_over_time(0.25, 2);
  }

  if(isDefined(level.suppress_challenge_success_print)) {
    return;
  }
  var_4 = maps\_specialops::so_create_hud_item(3, 0, &"SPECIAL_OPS_CHALLENGE_SUCCESS");
  var_4.alignx = "center";
  var_4.horzalign = "center";
  var_4 set_hudelem_blue();
  var_4 setpulsefx(60, 2500, 500);
  wait 1.5;
  var_5 = level.so_campaign;

  if(var_5 == "hijack" || var_5 == "fso") {
    var_5 = "delta";
  }
  maps\_utility::music_play("so_victory_" + var_5, undefined, 0, 1);
}

specialops_mission_over_setup_failure() {
  common_scripts\utility::flag_set("special_op_failed");
  var_0 = maps\_specialops::so_create_hud_item(3, 0, &"SPECIAL_OPS_CHALLENGE_FAILURE");
  var_0.hidewhendead = 0;
  var_0.alignx = "center";
  var_0.horzalign = "center";
  var_0 set_hudelem_red();
  var_0 setpulsefx(60, 2500, 500);

  foreach(var_2 in level.players) {
    var_3 = maps\_hud_util::create_client_overlay("white", 0, var_2);
    var_3.color = (1, 0.4, 0.4);
    var_3 thread maps\_hud_util::fade_over_time(0.25, 2);
  }

  wait 1.5;
  var_5 = level.so_campaign;

  if(var_5 == "hijack" || var_5 == "fso") {
    var_5 = "delta";
  }
  maps\_utility::music_play("so_defeat_" + var_5, undefined, 0, 1);
}

is_current_level_locked() {
  var_0 = tablelookup("sp/specOpsTable.csv", 1, level.script, 13);
  var_1 = int(tablelookup("sp/specOpsTable.csv", 1, var_0, 5));
  var_2 = maps\_rank::getrank();
  return var_2 < var_1;
}

is_so_player_signed_in() {
  return 1;
}

can_save_to_profile() {
  return is_so_player_signed_in() && !is_current_level_locked();
}

specialops_achievement_by_stars(var_0) {
  if(maps\_utility::is_survival()) {
    return;
  }
  return;
}

get_total_mode_stars(var_0, var_1, var_2) {
  var_3 = 0;

  for(var_4 = var_1; var_4 < var_2; var_4++) {
    var_3 = var_3 + int(max(0, int(var_0[var_4]) - 1));
  }
  return var_3;
}

get_num_of_levels_with_star(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 > level.specopssettings.levels.size) {
    var_2 = level.specopssettings.levels.size;
  }
  var_3 = 0;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(max(0, int(var_0[var_4]) - 1) >= var_1) {
      var_3++;
    }
  }

  return var_3;
}

specialops_mission_over_stats(var_0) {
  if(!isDefined(var_0) || !var_0) {
    return;
  }
  foreach(var_2 in level.players) {
    if(!var_2 can_save_to_profile()) {
      var_2.eog_noreward = 1;
    }
  }

  if(issplitscreen() && level.ps3) {
    level.player2.eog_noreward = 0;
  }
  var_4 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(isDefined(var_4) && var_4 != "") {
    foreach(var_2 in level.players) {
      if(isDefined(var_2.eog_noreward) && var_2.eog_noreward) {
        continue;
      }
      var_6 = var_2 getlocalplayerprofiledata(var_4);

      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = var_6 == 0;
      level.never_played = 0;

      if(var_7) {
        level.never_played = 1;
      }
      var_8 = var_2.so_eog_summary_data["score"];

      if(var_7 || var_8 > var_6) {
        var_2 setlocalplayerprofiledata(var_4, var_8);
      }
      if(!var_7 && var_8 > var_6) {
        var_2.eog_bestscore = 1;
        var_2.eog_bestscore_value = var_8;
      }
    }
  }

  var_10 = level.specopssettings maps\_endmission::getlevelindex(level.script);

  if(!isDefined(var_10)) {
    missionsuccess(level.script);
    return;
  }

  level.specopssettings maps\_endmission::setsolevelcompleted(var_10);

  foreach(var_2 in level.players) {
    if(isDefined(var_2.eog_noreward) && var_2.eog_noreward) {
      continue;
    }
    var_12 = var_2 getlocalplayerprofiledata("missionSOHighestDifficulty");

    if(!isDefined(var_12)) {
      continue;
    }
    var_13 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));
    var_14 = int(tablelookup("sp/specopstable.csv", 0, "mission_count", 1));
    var_15 = 0;
    var_16 = 0;

    if(maps\_utility::is_survival()) {
      var_15 = get_total_mode_stars(var_12, 0, var_13);
      var_17 = 100 * (var_15 / (var_13 * 3));
    } else {
      var_15 = get_total_mode_stars(var_12, var_13, var_13 + var_14);
      var_17 = 100 * (var_15 / (var_14 * 3));
    }

    if(int(var_17 * 100) % 100 >= 0.5) {
      var_16 = int(var_17) + 1;
    } else {
      var_16 = int(var_17);
    }
    var_2 thread maps\_specialops::so_achievement_update("BRAG_RAGS");
    var_2 thread maps\_specialops::so_achievement_update("TACTICIAN");
    var_2 thread maps\_specialops::so_achievement_update("OVERACHIEVER");
    var_22 = var_2 getlocalplayerprofiledata("percentCompleteSO");
    var_23 = int(var_22 / 100);
    var_24 = var_2 maps\_rank::getrank();

    if(maps\_utility::is_survival()) {
      var_25 = var_24 + var_23 * 100;
    } else {
      var_25 = var_24 + var_15 * 100;
    }
    var_2 setlocalplayerprofiledata("percentCompleteSO", var_25);
  }

  updategamerprofileall();
}

wait_all_players_are_touching(var_0) {
  for(;;) {
    var_0 waittill("trigger");

    if(!maps\_utility::is_coop()) {
      return;
    }
    level.player thread waiting_message_hide();
    level.player2 thread waiting_message_hide();

    if(!level.player istouching(var_0)) {
      level.player2 thread display_waiting_message();
      continue;
    }

    if(!level.player2 istouching(var_0)) {
      level.player thread display_waiting_message();
      continue;
    }

    break;
  }
}

wait_all_players_have_touched(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger");

    if(!maps\_utility::is_coop()) {
      return;
    }
    level.player thread waiting_message_hide();
    level.player2 thread waiting_message_hide();

    if(level.player istouching(var_0)) {
      var_2 = 1;

      if(!var_3 && !level.player2 istouching(var_0)) {
        thread determine_waiting_message(level.player, var_1);
        continue;
      }
    }

    if(level.player2 istouching(var_0)) {
      var_3 = 1;

      if(!var_2 && !level.player istouching(var_0)) {
        thread determine_waiting_message(level.player2, var_1);
        continue;
      }
    }

    break;
  }
}

disable_mission_end_trigger(var_0) {
  level waittill("special_op_terminated");
  var_0 common_scripts\utility::trigger_off();
}

determine_waiting_message(var_0, var_1) {
  switch (var_1) {
    case "all":
      var_0 display_waiting_message();
      break;
    case "any":
      var_0 display_waiting_message();
      break;
    case "freeze":
      var_0 display_frozen_message();
      break;
  }
}

display_waiting_message() {
  self endon("death");
  level endon("challenge_timer_passed");
  level endon("challenge_timer_expired");
  level endon("special_op_terminated");
  level notify("players_touching_hint");
  level endon("players_touching_hint");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.waiting_hud)) {
    self.waiting_hud = create_waiting_message(self);
  } else {
    self.waiting_hud.alpha = 1;
  }
  wait 0.05;
  self.waiting_hud fadeovertime(0.25);
  self.waiting_hud.alpha = 0;
}

display_frozen_message() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.frozen_and_waiting) && self.frozen_and_waiting) {
    return;
  }
  self.frozen_and_waiting = 1;
  self enableinvulnerability();
  self freezecontrols(1);
  self.ignoreme = 1;
  self setblurforplayer(6, 1);
  self.waiting_hud = create_waiting_message(self);
}

create_waiting_message(var_0) {
  self notify("rebuilding_waiting_hud");
  self endon("rebuilding_waiting_hud");
  var_1 = maps\_specialops::so_create_hud_item(3, 0, &"SPECIAL_OPS_WAITING_OTHER_PLAYER", var_0);
  var_1.alignx = "center";
  var_1.horzalign = "center";
  var_1 set_hudelem_blue();
  thread waiting_message_delete_on_so_end(var_1);
  return var_1;
}

waiting_message_hide() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.waiting_hud)) {
    return;
  }
  if(isDefined(self.frozen_and_waiting) && self.frozen_and_waiting) {
    return;
  }
  self.waiting_hud fadeovertime(0.25);
  self.waiting_hud.alpha = 0;
}

waiting_message_delete_on_so_end(var_0) {
  self endon("rebuilding_waiting_hud");
  level waittill("special_op_terminated");

  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

disable_saving() {
  common_scripts\utility::flag_set("disable_autosaves");

  for(;;) {
    common_scripts\utility::flag_wait("can_save");
    common_scripts\utility::flag_clear("can_save");
  }
}

disable_escape_warning() {
  if(common_scripts\utility::flag("player_has_escaped")) {
    return 1;
  }
  if(is_touching_escape_trigger()) {
    return 0;
  }
  return 1;
}

is_touching_escape_trigger() {
  if(!isDefined(level.escape_warning_triggers)) {
    return 0;
  }
  foreach(var_1 in level.escape_warning_triggers) {
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

ping_escape_warning() {
  if(isDefined(self.ping_escape_splash)) {
    return;
  }
  self endon("death");
  self.ping_escape_splash = maps\_specialops::so_create_hud_item(3.5, 0, &"SPECIAL_OPS_ESCAPE_WARNING", self);
  self.ping_escape_splash.alignx = "center";
  self.ping_escape_splash.horzalign = "center";

  while(ping_escape_warning_valid()) {
    self.ping_escape_splash.alpha = 1;
    self.ping_escape_splash fadeovertime(1);
    self.ping_escape_splash.alpha = 0.5;
    self.ping_escape_splash.fontscale = 1.5;
    self.ping_escape_splash changefontscaleovertime(1);
    self.ping_escape_splash.fontscale = 1;
    wait 1;
  }

  self.ping_escape_splash.alpha = 0.5;
  self.ping_escape_splash fadeovertime(0.25);
  self.ping_escape_splash.alpha = 0;
  wait 0.25;
  self.escape_hint_active = undefined;

  if(isDefined(self.ping_escape_splash)) {
    self.ping_escape_splash destroy();
  }
}

ping_escape_warning_valid() {
  if(common_scripts\utility::flag("special_op_terminated")) {
    return 0;
  }
  if(!is_touching_escape_trigger()) {
    return 0;
  }
  return 1;
}

enable_escape_failure_auto() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(isDefined(var_0.so_ignore_escape_failure) && var_0.so_ignore_escape_failure) {
      continue;
    }
    break;
  }

  maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_LEFT_PLAY_AREA");
  maps\_utility::missionfailedwrapper();
}

enable_escape_warning_auto_init() {
  if(common_scripts\utility::flag_exist("so_escape_warning") && common_scripts\utility::flag("so_escape_warning")) {
    return;
  }
  common_scripts\utility::flag_init("so_escape_warning");

  foreach(var_1 in level.players) {}
  var_1 maps\_utility::ent_flag_init("so_escape_hint_active");
}

enable_escape_warning_auto() {
  level endon("special_op_terminated");
  enable_escape_warning_auto_init();

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(isDefined(var_0.so_ignore_escape_failure) && var_0.so_ignore_escape_failure) {
      continue;
    }
    var_0 thread show_escape_warning_auto(self);
  }
}

show_escape_warning_auto(var_0) {
  if(maps\_utility::ent_flag("so_escape_hint_active")) {
    return;
  }
  maps\_utility::ent_flag_set("so_escape_hint_active");
  thread ping_escape_warning_auto(var_0);
}

ping_escape_warning_auto(var_0) {
  self notify("so_escape_hint_ping");
  self endon("so_escape_hint_ping");
  thread remove_escape_warning_auto(var_0);

  if(!isDefined(self.ping_escape_splash_auto)) {
    self.ping_escape_splash_auto = maps\_specialops::so_create_hud_item(3.5, 0, &"SPECIAL_OPS_ESCAPE_WARNING", self);
    self.ping_escape_splash_auto.alignx = "center";
    self.ping_escape_splash_auto.horzalign = "center";

    if(isDefined(level.so_escape_warning_colorfunc)) {
      self.ping_escape_splash_auto thread[[level.so_escape_warning_colorfunc]]();
    }
  }

  while(ping_escape_warning_auto_valid()) {
    self.ping_escape_splash_auto.alpha = 1;
    self.ping_escape_splash_auto fadeovertime(1);
    self.ping_escape_splash_auto.alpha = 0.5;
    self.ping_escape_splash_auto.fontscale = 1.5;
    self.ping_escape_splash_auto changefontscaleovertime(1);
    self.ping_escape_splash_auto.fontscale = 1;
    wait 1;
  }

  self.ping_escape_splash_auto.alpha = 0.5;
  self.ping_escape_splash_auto fadeovertime(0.25);
  self.ping_escape_splash_auto.alpha = 0;
  wait 0.25;
  self.ping_escape_splash_auto destroy();
}

remove_escape_warning_auto(var_0) {
  while(self istouching(var_0)) {
    wait 0.05;
  }
  maps\_utility::ent_flag_clear("so_escape_hint_active");
}

ping_escape_warning_auto_valid() {
  if(!isalive(self)) {
    return 0;
  }
  if(common_scripts\utility::flag("special_op_terminated")) {
    return 0;
  }
  return maps\_utility::ent_flag("so_escape_hint_active");
}

so_dialog_play(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  if(isDefined(var_2) && var_2) {
    maps\_utility::radio_dialogue_stop();
  }
  maps\_utility::radio_dialogue(var_0);
}

specialops_dialog_init() {
  level.scr_radio["so_tf_1_plyr_prep"] = "so_tf_1_plyr_prep";
  level.scr_radio["so_tf_1_success_generic"] = "so_tf_1_success_generic";
  level.scr_radio["so_tf_1_success_jerk"] = "so_tf_1_success_jerk";
  level.scr_radio["so_tf_1_success_best"] = "so_tf_1_success_best";
  level.scr_radio["so_tf_1_fail_generic"] = "so_tf_1_fail_generic";
  level.scr_radio["so_tf_1_fail_generic_jerk"] = "so_tf_1_fail_generic_jerk";
  level.scr_radio["so_tf_1_fail_time"] = "so_tf_1_fail_time";
  level.scr_radio["so_tf_1_fail_bleedout"] = "so_tf_1_fail_bleedout";
  level.scr_radio["so_tf_1_time_generic"] = "so_tf_1_time_generic";
  level.scr_radio["so_tf_1_time_hurry"] = "so_tf_1_time_hurry";
  level.scr_radio["so_tf_1_civ_kill_warning"] = "so_tf_1_civ_kill_warning";
  level.scr_radio["so_tf_1_progress_5more"] = "so_tf_1_progress_5more";
  level.scr_radio["so_tf_1_progress_4more"] = "so_tf_1_progress_4more";
  level.scr_radio["so_tf_1_progress_3more"] = "so_tf_1_progress_3more";
  level.scr_radio["so_tf_1_progress_2more"] = "so_tf_1_progress_2more";
  level.scr_radio["so_tf_1_progress_1more"] = "so_tf_1_progress_1more";
  level.scr_radio["so_tf_1_time_status_late"] = "so_tf_1_time_status_late";
  level.scr_radio["so_tf_1_time_status_good"] = "so_tf_1_time_status_good";
  level.scr_radio["so_tf_1_progress_3quarter"] = "so_tf_1_progress_3quarter";
  level.scr_radio["so_tf_1_progress_half"] = "so_tf_1_progress_half";
  level.scr_radio["so_tf_1_progress_quarter"] = "so_tf_1_progress_quarter";
}

set_hudelem_white() {
  maps\_specialops::set_hud_white();
}

set_hudelem_blue() {
  maps\_specialops::set_hud_blue();
}

set_hudelem_green() {
  maps\_specialops::set_hud_green();
}

set_hudelem_yellow() {
  maps\_specialops::set_hud_yellow();
}

set_hudelem_red() {
  maps\_specialops::set_hud_red();
}

set_hudelem_grey() {
  maps\_specialops::set_hud_grey();
}

so_hud_pulse_single(var_0, var_1, var_2) {
  self endon("update_hud_pulse");
  self endon("destroying");
  self endon("death");
  self.fontscale = var_0;
  self changefontscaleovertime(var_2);
  self.fontscale = var_1;
  wait(var_2);
}

so_hud_pulse_loop() {
  self endon("update_hud_pulse");
  self endon("destroying");
  self endon("death");

  if(self.pulse_start_big) {
    so_hud_pulse_single(self.pulse_scale_big, self.pulse_scale_loop_normal, self.pulse_time);
  }
  while(isDefined(self.pulse_loop) && self.pulse_loop) {
    so_hud_pulse_single(self.pulse_scale_loop_normal, self.pulse_scale_loop_big, self.pulse_time_loop);
    so_hud_pulse_single(self.pulse_scale_loop_big, self.pulse_scale_loop_normal, self.pulse_time_loop);
  }
}

so_hud_pulse_init() {
  if(!isDefined(self)) {
    return 0;
  }
  if(!isDefined(self.pulse_time)) {
    self.pulse_time = 0.5;
  }
  if(!isDefined(self.pulse_scale_normal)) {
    self.pulse_scale_normal = 1.0;
  }
  if(!isDefined(self.pulse_scale_big)) {
    self.pulse_scale_big = 1.6;
  }
  if(!isDefined(self.pulse_loop)) {
    self.pulse_loop = 0;
  }
  if(!isDefined(self.pulse_time_loop)) {
    self.pulse_time_loop = 1.0;
  }
  if(!isDefined(self.pulse_scale_loop_normal)) {
    self.pulse_scale_loop_normal = 1.0;
  }
  if(!isDefined(self.pulse_scale_loop_big)) {
    self.pulse_scale_loop_big = 1.15;
  }
  if(!isDefined(self.pulse_start_big)) {
    self.pulse_start_big = 1;
  }
  return 1;
}

specialops_detect_death() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_init("so_player_death_nofail");
  common_scripts\utility::array_thread(level.players, ::specialops_detect_player_death);
  level waittill("so_player_has_died");

  if(common_scripts\utility::flag("so_player_death_nofail")) {
    return;
  }
  maps\_utility::missionfailedwrapper();
}

specialops_detect_player_death() {
  level endon("special_op_terminated");
  self waittill("death");
  level notify("so_player_has_died");
}

so_special_failure_hint_reset_dvars(var_0) {
  setDvar("ui_dog_death", 0);
  setDvar("ui_vehicle_death", 0);
  setDvar("ui_destructible_death", 0);
  setDvar("ui_barrel_death", 0);
  setDvar("ui_grenade_death", 0);
  setDvar("ui_time_failure", 0);
  setDvar("ui_ff_death", 0);
  setDvar("ui_juggernaut_death", 0);
  setDvar("ui_bled_out", 0);
  setDvar("ui_icon_partner", 0);
  setDvar("ui_icon_obj", 0);
  setDvar("ui_icon_obj_offscreen", 0);
  setDvar("ui_icon_stars", 0);
  setDvar("ui_icon_claymore", 0);
  setDvar("ui_icon_stealth_stance", 0);

  if(isDefined(var_0)) {
    setDvar(var_0, 1);
  }
}

so_special_failure_hint() {
  so_special_failure_hint_reset_dvars();

  foreach(var_1 in level.players) {
    var_1 thread maps\_load::player_throwgrenade_timer();
    var_1 thread so_special_death_hint_tracker();
  }

  level waittill("so_generate_deathquote");
  maps\_quotes::setdeadquote_so();
}

so_special_death_hint_tracker() {
  level endon("so_special_failure_hint_set");
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(self.coop_death_reason)) {
    var_0 = self.coop_death_reason["attacker"];
    var_1 = self.coop_death_reason["cause"];
    var_2 = self.coop_death_reason["weapon_name"];
  }

  if(so_claymore_death(var_1, var_2)) {
    return;
  }
  if(so_friendly_fire_death(var_0)) {
    return;
  }
  if(so_radiation_death(var_0)) {
    return;
  }
  if(so_dog_death(var_0)) {
    return;
  }
  if(so_juggernaut_death(var_0)) {
    return;
  }
  if(so_grenade_suicide_death(var_1)) {
    return;
  }
  if(so_destructible_death(var_0, var_1)) {
    return;
  }
  if(so_exploding_barrel_death(var_1)) {
    return;
  }
  if(so_grenade_regular_death(var_1)) {
    return;
  }
  if(so_vehicle_death(var_0, var_1)) {
    return;
  }
}

so_claymore_death(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "claymore") {
    return 0;
  }
  return 1;
}

so_friendly_fire_death(var_0) {
  if(!maps\_utility::is_coop()) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  var_1 = maps\_utility::get_other_player(self);

  if(var_1 != var_0) {
    return 0;
  }
  so_special_failure_hint_set("@DEADQUOTE_SO_FRIENDLY_FIRE_KILL", "ui_ff_death");
  return 1;
}

so_radiation_death(var_0) {
  if(!isDefined(var_0) || var_0.classname != "worldspawn") {
    return 0;
  }
  if(!isDefined(self.radiationdeath) || !self.radiationdeath) {
    return 0;
  }
  so_special_failure_hint_set("@SCRIPT_RADIATION_DEATH");
  return 1;
}

so_dog_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.weapon)) {
    return 0;
  }
  if(var_0.weapon != "dog_bite") {
    return 0;
  }
  common_scripts\utility::flag_set("special_op_no_unlink");
  so_special_failure_hint_set(level.so_dog_death_quote, "ui_dog_death");
  return 1;
}

so_juggernaut_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.juggernaut)) {
    return 0;
  }
  var_1 = [];
  var_1[0] = "@DEADQUOTE_JUGGERNAUT_FLASHBANGS";
  var_1[1] = "@DEADQUOTE_JUGGERNAUT_HEADSHOTS";
  var_1[2] = "@DEADQUOTE_JUGGERNAUT_EXPLOSIVES";
  var_1[3] = "@DEADQUOTE_JUGGERNAUT_CORNERED";
  so_special_failure_hint_set_array(var_1, "ui_juggernaut_death");
  return 1;
}

so_destructible_death(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_1 != "MOD_EXPLOSIVE") {
    return 0;
  }
  if(!isDefined(var_0.destructible_type)) {
    return 0;
  }
  if(issubstr(var_0.destructible_type, "vehicle")) {
    so_special_failure_hint_set("@SCRIPT_EXPLODING_VEHICLE_DEATH", "ui_vehicle_death");
  } else {
    so_special_failure_hint_set("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH", "ui_destructible_death");
  }
  return 1;
}

so_exploding_barrel_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_EXPLOSIVE") {
    return 0;
  }
  if(!isDefined(level.lastexplodingbarrel)) {
    return 0;
  }
  if(gettime() != level.lastexplodingbarrel["time"]) {
    return 0;
  }
  var_1 = distance(self.origin, level.lastexplodingbarrel["origin"]);

  if(var_1 > level.lastexplodingbarrel["radius"]) {
    return 0;
  }
  so_special_failure_hint_set("@SCRIPT_EXPLODING_BARREL_DEATH", "ui_barrel_death");
  return 1;
}

so_grenade_suicide_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_SUICIDE") {
    return 0;
  }
  if(self.lastgrenadetime - gettime() > 3500.0) {
    return 0;
  }
  so_special_failure_hint_set("@SCRIPT_GRENADE_SUICIDE_COMBINED");
  return 1;
}

so_grenade_regular_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_GRENADE" && var_0 != "MOD_GRENADE_SPLASH") {
    return 0;
  }
  so_special_failure_hint_set("@SCRIPT_GRENADE_DEATH", "ui_grenade_death");
  return 1;
}

so_vehicle_death(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_1 != "MOD_CRUSH") {
    return 0;
  }
  if(var_0.code_classname != "script_vehicle") {
    return 0;
  }
  so_special_failure_hint_set("@DEADQUOTE_SO_RUN_OVER_BY_VEHICLE");
  return 1;
}

so_special_failure_hint_set(var_0, var_1) {
  maps\_specialops::so_force_deadquote(var_0, var_1);
  level notify("so_special_failure_hint_set");
}

so_special_failure_hint_set_array(var_0, var_1) {
  maps\_specialops::so_force_deadquote_array(var_0, var_1);
  level notify("so_special_failure_hint_set");
}

so_ai_flashed_damage_feedback() {
  self endon("death");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);

    if(!maps\_utility::is_damagefeedback_enabled()) {
      continue;
    }
    if(isDefined(var_3) && isPlayer(var_3)) {
      var_3 maps\_damagefeedback::updatedamagefeedback(self);
    }
  }
}

so_mission_complete_achivements() {
  if(!maps\_utility::is_survival() && level.players.size == 2 && level.players[0].so_eog_summary_data["kills"] > 0 && level.players[0].so_eog_summary_data["kills"] == level.players[1].so_eog_summary_data["kills"]) {
    level.players[0] maps\_utility::player_giveachievement_wrapper("FIFTY_FIFTY");
    level.players[1] maps\_utility::player_giveachievement_wrapper("FIFTY_FIFTY");
  }

  if(level.players.size >= 2 && level.specops_reward_gameskill >= 2) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.laststand_down_count) && var_2.laststand_down_count > 0) {
        var_0 = 1;
      }
      if(var_2 maps\_utility::get_player_gameskill() < 2) {
        var_0 = 1;
      }
    }

    if(!var_0) {
      foreach(var_2 in level.players) {}
      var_2 maps\_utility::player_giveachievement_wrapper("NO_ASSISTANCE_REQUIRED");
    }
  }
}