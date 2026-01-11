/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_challenge.gsc
***************************************/

init_coop_challenge() {
  func_956D();
  if(!isDefined(level.challenge_scalar_func)) {
    level.challenge_scalar_func = ::func_4FE2;
  }

  func_97B0();
}

func_C9B9() {
  [[level.challenge_pause_func]]();
}

func_956D() {
  scripts\engine\utility::flag_init("pause_challenges");
  var_00 = getdvar("ui_mapname");
  level.zombie_challenge_table = "cp\zombies\" + var_00 + "
  _challenges.csv ";
  if(!tableexists(level.zombie_challenge_table)) {
    level.zombie_challenge_table = undefined;
  }

  level.challenge_data = [];
  if(isDefined(level.challenge_registration_func)) {
    [[level.challenge_registration_func]]();
  }

  level.current_challenge_index = -1;
  level.current_challenge_progress_max = -1;
  level.current_challenge_progress_current = -1;
  level.current_challenge_percent = -1;
  level.current_challenge_target_player = -1;
  level.current_challenge_timer = -1;
  level.current_challenge_scalar = -1;
  level.current_challenge_title = -1;
  level.current_challenge_pre_challenge = 0;
  level.var_1BE8 = 1;
  level.var_D7B7 = 0;
  level.var_C1E1 = 0;
  level.var_110AC = 0;
}

update_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!current_challenge_is(param_00) || !scripts\cp\utility::coop_mode_has("challenge")) {
    return;
  }

  if(level.var_D7B7) {
    return;
  }

  var_0A = level.challenge_data[level.current_challenge];
  var_0A thread[[var_0A.var_12E9C]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_62C6() {
  if(current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge")) {
    deactivate_current_challenge();
  }
}

deactivate_current_challenge() {
  if(!current_challenge_exist()) {
    return;
  }

  var_00 = level.challenge_data[level.current_challenge];
  func_12BF7();
  if(var_00[[var_00.var_9F82]]()) {
    func_56AD("challenge_success", 0);
    var_00[[var_00.var_E4C5]]();
    var_01 = "challenge";
    if(isDefined(level.var_3C24)) {
      var_01 = level.var_3C24;
    }

    scripts\cp\cp_gamescore::update_players_encounter_performance(var_01, "challenge_complete");
    scripts\cp\cp_persistence::update_lb_aliensession_challenge(1);
    scripts\cp\cp_analytics::update_challenges_status(var_00.ref, 1);
    if(func_9F17(var_00)) {
      if(level.current_challenge_timer - level.storechallengetime <= 0.01) {
        scripts\cp\zombies\zombie_analytics::func_AF63(var_00.ref, level.wave_num, level.storechallengetime - level.current_challenge_timer);
      } else {
        scripts\cp\zombies\zombie_analytics::func_AF63(var_00.ref, level.wave_num, level.current_challenge_timer);
      }

      foreach(var_03 in level.players) {
        var_03 thread scripts\cp\cp_vo::try_to_play_vo("challenge_success_generic", "zmb_comment_vo");
      }

      level.var_C1E1++;
    }
  } else {
    func_56AD("challenge_failed", 0);
    if(func_9F17(var_00)) {
      if(isDefined(level.var_3C2B[var_00.ref]) && func_9F17(var_00)) {
        level.var_3C2B[var_00.ref]++;
      }

      if(var_00.ref == "no_laststand" || var_00.ref == "no_bleedout" || var_00.ref == "protect_player") {
        scripts\cp\zombies\zombie_analytics::func_AF64(var_00.ref, level.wave_num, 0, level.var_3C2B[var_00.ref]);
      } else {
        scripts\cp\zombies\zombie_analytics::func_AF64(var_00.ref, level.wave_num, var_00.current_progress / var_00.objective_icon * 100, level.var_3C2B[var_00.ref]);
      }

      foreach(var_03 in level.players) {
        if(!scripts\cp\utility::isplayingsolo() && level.players.size > 1) {
          scripts\cp\cp_vo::try_to_play_vo_on_all_players("challenge_fail_team");
          continue;
        }

        var_03 thread scripts\cp\cp_vo::try_to_play_vo("challenge_fail_solo", "zmb_comment_vo");
      }
    }

    var_00[[var_00.var_6AD0]]();
    level.var_1BE8 = 0;
    scripts\cp\cp_persistence::update_lb_aliensession_challenge(0);
    scripts\cp\cp_analytics::update_challenges_status(var_00.ref, 0);
  }

  level notify("challenge_deactivated");
  var_00[[var_00.var_4DDE]]();
}

func_9F17(param_00) {
  switch (param_00.ref) {
    case "challenge_success":
    case "challenge_failed":
    case "next_challenge":
      return 0;

    default:
      return 1;
  }
}

activate_new_challenge(param_00) {
  var_01 = level.challenge_data[param_00];
  if(!isDefined(level.var_3C2B[param_00]) && param_00 != "next_challenge") {
    level.var_3C2B[param_00] = 0;
  }

  if(var_01[[var_01.var_386E]]()) {
    var_02 = func_7897(param_00);
    if(isDefined(var_02)) {
      level.challenge_data[param_00].objective_icon = var_02;
      level.current_challenge_scalar = var_02;
    } else {
      level.current_challenge_scalar = -1;
    }

    func_56AD(param_00, 1, var_02);
    func_F31A(param_00);
    level.current_challenge_pre_challenge = 0;
    var_01[[var_01.var_1609]]();
    return;
  }

  var_01[[var_01.var_6ACB]]();
}

func_7897(param_00) {
  return [[level.challenge_scalar_func]](param_00);
}

func_3C15() {
  level endon("game_ended");
  var_00 = int(gettime() + 5000);
  foreach(var_02 in level.players) {
    var_02 setclientomnvar("ui_intel_title", 1);
  }

  level.current_challenge_title = 1;
  wait(5);
  foreach(var_02 in level.players) {
    var_02 setclientomnvar("ui_intel_title", -1);
  }

  level.current_challenge_title = -1;
  wait(0.5);
}

func_56AD(param_00, param_01, param_02) {
  var_03 = tablelookup(level.zombie_challenge_table, 1, param_00, 0);
  foreach(var_05 in level.players) {
    if(param_01) {
      if(isDefined(param_02)) {
        var_05 setclientomnvar("ui_intel_challenge_scalar", param_02);
        var_05 setclientomnvar("ui_intel_progress_max", param_02);
      } else {
        var_05 setclientomnvar("ui_intel_challenge_scalar", -1);
      }

      var_05 setclientomnvar("ui_intel_prechallenge", 1);
      var_05 setclientomnvar("ui_intel_active_index", int(var_03));
      level.current_challenge_index = int(var_03);
      level.current_challenge_pre_challenge = 1;
      if(param_00 == "next_challenge") {
        var_05 playlocalsound("zmb_challenge_config");
      } else {
        var_05 playlocalsound("zmb_challenge_start");
      }

      var_05 setclientomnvar("zm_show_challenge", 4);
      level.current_zm_show_challenge = 4;
    }
  }

  if(param_01) {
    return;
  }

  if(level.current_zm_show_challenge != 2 && level.current_zm_show_challenge != 3 && level.current_zm_show_challenge != 4) {
    level thread func_100CB(param_00, var_03);
  }
}

func_100CB(param_00, param_01) {
  level endon("game_ended");
  wait(1);
  foreach(var_03 in level.players) {
    if(param_00 == "challenge_failed") {
      var_03 playlocalsound("zmb_challenge_fail");
      var_03 setclientomnvar("zm_show_challenge", 2);
      level.current_zm_show_challenge = 2;
      continue;
    }

    var_03 playlocalsound("zmb_challenge_complete");
    var_03 setclientomnvar("zm_show_challenge", 3);
    level.current_zm_show_challenge = 3;
  }

  wait(3);
  foreach(var_03 in level.players) {
    var_03 thread reset_omnvars();
  }

  setomnvar("zm_challenge_progress", 0);
  level.current_challenge_index = -1;
  level.current_challenge_progress_max = -1;
  level.current_challenge_progress_current = -1;
  level.current_challenge_percent = -1;
  level.current_challenge_target_player = -1;
  level.current_challenge_timer = -1;
  level.current_challenge_scalar = -1;
  level.current_challenge_pre_challenge = 0;
}

reset_omnvars() {
  wait(0.5);
  self setclientomnvar("ui_intel_active_index", -1);
  self setclientomnvar("ui_intel_progress_current", -1);
  self setclientomnvar("ui_intel_progress_max", -1);
  self setclientomnvar("ui_intel_percent", -1);
  self setclientomnvar("ui_intel_target_player", -1);
  self setclientomnvar("ui_intel_prechallenge", 0);
  self setclientomnvar("ui_intel_timer", -1);
  self setclientomnvar("ui_intel_challenge_scalar", -1);
}

register_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = spawnStruct();
  var_0B.ref = param_00;
  var_0B.objective_icon = param_01;
  var_0B.default_success = param_02;
  var_0B.var_9F82 = ::func_4FFA;
  if(isDefined(param_03)) {
    var_0B.var_9F82 = param_03;
  }

  var_0B.var_386E = ::func_4FDD;
  if(isDefined(param_04)) {
    var_0B.var_386E = param_04;
  }

  var_0B.var_1609 = param_05;
  var_0B.var_4DDE = param_06;
  var_0B.var_6ACB = ::func_4FED;
  if(isDefined(param_07)) {
    var_0B.var_6ACB = param_07;
  }

  var_0B.var_12E9C = param_08;
  var_0B.var_E4C5 = ::func_5011;
  if(isDefined(param_09)) {
    var_0B.var_E4C5 = param_09;
  }

  var_0B.var_6AD0 = ::func_4FEE;
  if(isDefined(param_0A)) {
    var_0B.var_6AD0 = param_0A;
  }

  level.challenge_data[param_00] = var_0B;
}

update_challenge_progress(param_00, param_01) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  foreach(var_03 in level.players) {
    var_03 setclientomnvar("zm_show_challenge", 1);
    var_03 setclientomnvar("ui_intel_progress_current", param_00);
    level.current_zm_show_challenge = 1;
  }

  setomnvar("zm_challenge_progress", param_00 / param_01);
  level.current_challenge_progress_max = param_01;
  level.current_challenge_progress_current = param_00;
}

func_4FDD() {
  return 1;
}

func_4FED() {}

func_4FFA() {
  if(isDefined(self.success)) {
    return self.success;
  }

  return 0;
}

default_successfunc() {
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

func_4FEE() {}

default_resetsuccess() {
  self.success = self.default_success;
}

func_5011() {}

current_challenge_exist() {
  return isDefined(level.current_challenge);
}

current_challenge_is(param_00) {
  return current_challenge_exist() && level.current_challenge == param_00;
}

func_12BF7() {
  level.current_challenge = undefined;
}

func_F31A(param_00) {
  level.current_challenge = param_00;
  scripts\cp\zombies\zombie_analytics::func_AF62(level.current_challenge, level.wave_num);
  level.var_110AC = gettime() / 1000;
}

func_7B31() {
  if(!isDefined(level.var_C1E1)) {
    return 0;
  }

  return level.var_C1E1;
}

func_97B0() {
  if(!isDefined(level.zombie_challenge_table)) {
    return;
  }

  var_00 = level.zombie_challenge_table;
  var_01 = 0;
  var_02 = 1;
  var_03 = 99;
  var_04 = 1;
  var_05 = 2;
  var_06 = 6;
  var_07 = 7;
  var_08 = 8;
  for(var_09 = var_02; var_09 <= var_03; var_09++) {
    var_0A = tablelookup(var_00, var_01, var_09, var_04);
    if(var_0A == "") {
      break;
    }

    var_0B = tablelookup(var_00, var_01, var_09, var_05);
    var_0C = tablelookup(var_00, var_01, var_09, var_08);
    if(isDefined(level.challenge_data[var_0A])) {
      level.challenge_data[var_0A].var_1C81 = var_0B;
      level.challenge_data[var_0A].var_1C8C = int(tablelookup(var_00, var_01, var_09, var_06));
      level.challenge_data[var_0A].active_time = strtok(var_0C, " ");
    }
  }
}

func_4FE2(param_00) {
  return 1;
}

update_death_challenges(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return;
  }

  if(!isDefined(level.current_challenge)) {
    return;
  }

  var_09 = level.current_challenge;
  if(isDefined(level.custom_death_challenge_func)) {
    var_0A = self[[level.custom_death_challenge_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    if(!scripts\engine\utility::istrue(var_0A)) {
      return;
    }
  }
}

update_current_challenge_timer(param_00) {
  level endon("stop_challenge_timer");
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_01 = 0;
  var_02 = level.current_challenge_timer;
  while(level.current_challenge_timer > 0) {
    wait(0.1);
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_04 in level.players) {
        var_04 setclientomnvar("ui_intel_timer", -1);
        var_04 setclientomnvar("zm_show_challenge", 10);
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
      var_06 = int(gettime() + level.current_challenge_timer * 1000);
      foreach(var_04 in level.players) {
        var_04 setclientomnvar("ui_intel_timer", var_06);
        var_04 setclientomnvar("zm_show_challenge", level.current_zm_show_challenge);
      }
    }

    level.current_challenge_timer = level.current_challenge_timer - 0.1;
    if(isDefined(param_00)) {
      update_challenge_progress(int(var_02 - level.current_challenge_timer), int(var_02));
    }
  }
}

default_timer(param_00) {
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_01 = param_00;
  while(var_01 > 0) {
    wait(0.1);
    if(scripts\engine\utility::flag("pause_challenges")) {
      continue;
    }

    var_01 = var_01 - 0.1;
  }

  self.success = self.default_success;
  level thread deactivate_current_challenge();
}