/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\zombies\solo_challenges.gsc
**************************************************/

init_solo_challenges() {
  _id_956D();
  _id_97B0();
}

_id_956D() {
  var_0 = getDvar("ui_mapname");
  level.zombie_challenge_table = "cp/zombies/" + var_0 + "_challenges.csv";

  if(!tableexists(level.zombie_challenge_table))
    level.zombie_challenge_table = undefined;

  level.challenge_data = [];

  if(isDefined(level.challenge_registration_func))
    [[level.challenge_registration_func]]();
}

update_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isPlayer(self)) {
    if(!current_challenge_is(var_0)) {
      return;
    }
    var_10 = self.current_challenge;
    self thread[[var_10._id_12E9C]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else {
    if(!var_9 current_challenge_is(var_0)) {
      return;
    }
    var_10 = var_9.current_challenge;
    var_9 thread[[var_10._id_12E9C]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

_id_62C6() {
  if(current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge"))
    deactivate_current_challenge();
}

deactivate_current_challenge(var_0) {
  if(!current_challenge_exist()) {
    return;
  }
  var_1 = var_0.current_challenge;
  var_0 _id_12BF7();

  if(var_1[[var_1._id_9F82]](var_0)) {
    _id_56AD("challenge_success", 0, undefined, var_0);
    var_1[[var_1._id_E4C5]]();
    var_2 = "challenge";

    if(isDefined(level._id_3C24))
      var_2 = level._id_3C24;

    if(_id_9F17(var_1)) {
      if(var_0.vo_prefix == "p5_")
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("challenge_success", "zmb_comment_vo");
    }
  } else {
    _id_56AD("challenge_failed", 0, undefined, var_0);

    if(_id_9F17(var_1)) {
      if(isDefined(level._id_3C2B[var_1.ref]) && _id_9F17(var_1))
        level._id_3C2B[var_1.ref]++;

      if(var_1.ref == "no_laststand" || var_1.ref == "no_bleedout" || var_1.ref == "protect_player")
        scripts\cp\zombies\zombie_analytics::_id_AF64(var_1.ref, level.wave_num, 0, level._id_3C2B[var_1.ref]);
      else
        scripts\cp\zombies\zombie_analytics::_id_AF64(var_1.ref, level.wave_num, var_1.current_progress / var_1.goal * 100, level._id_3C2B[var_1.ref]);

      foreach(var_0 in level.players) {
        if(!scripts\cp\utility::isplayingsolo() && level.players.size > 1) {
          scripts\cp\cp_vo::try_to_play_vo_on_all_players("challenge_fail_team");
          continue;
        }

        var_0 thread scripts\cp\cp_vo::try_to_play_vo("challenge_fail_solo", "zmb_comment_vo");
      }
    }

    var_1[[var_1._id_6AD0]]();
    level._id_1BE8 = 0;
    scripts\cp\cp_persistence::update_lb_aliensession_challenge(0);
    scripts\cp\cp_analytics::update_challenges_status(var_1.ref, 0);
  }

  level notify("challenge_deactivated");
  var_1[[var_1._id_4DDE]](var_0);
}

_id_9F17(var_0) {
  switch (var_0.ref) {
    case "challenge_success":
    case "challenge_failed":
    case "next_challenge":
      return 0;
    default:
      return 1;
  }
}

copy_challenge_struct(var_0) {
  var_1 = level.challenge_data[var_0];
  var_2 = spawnStruct();
  var_2.ref = var_1.ref;
  var_2.goal = var_1.goal;
  var_2.default_success = var_1.default_success;
  var_2._id_9F82 = var_1._id_9F82;
  var_2._id_386E = var_1._id_386E;
  var_2._id_1609 = var_1._id_1609;
  var_2._id_4DDE = var_1._id_4DDE;
  var_2._id_6ACB = var_1._id_6ACB;
  var_2._id_12E9C = var_1._id_12E9C;
  var_2._id_E4C5 = var_1._id_E4C5;
  var_2._id_6AD0 = var_1._id_6AD0;
  return var_2;
}

activate_new_challenge(var_0, var_1) {
  var_1.current_challenge = copy_challenge_struct(var_0);

  if(var_1.current_challenge[[var_1.current_challenge._id_386E]]()) {
    var_2 = _id_7897(var_0);

    if(isDefined(var_2))
      var_1.current_challenge.goal = var_2;
    else
      level.current_challenge_scalar = -1;

    _id_56AD(var_0, 1, var_2, var_1);
    var_1 _id_F31A(var_0);
    var_1 notify("new_challenge_started");
    var_1.current_challenge[[var_1.current_challenge._id_1609]](var_1);
  } else
    var_1.current_challenge[[var_1.current_challenge._id_6ACB]]();
}

_id_7897(var_0) {
  return [[level.challenge_scalar_func]](var_0);
}

_id_56AD(var_0, var_1, var_2, var_3) {
  var_4 = tablelookup(level.zombie_challenge_table, 1, var_0, 0);

  if(var_1) {
    if(var_0 == "next_challenge")
      var_3 playlocalsound("zmb_challenge_config");
    else
      var_3 playlocalsound("zmb_challenge_start");

    var_3 setclientomnvar("zm_show_challenge", -1);
    wait 0.05;

    if(level.script != "cp_disco")
      var_3 setclientomnvar("ui_intel_active_index", -1);

    var_3 setclientomnvar("ui_intel_progress_current", -1);
    wait 0.05;
    var_3 setclientomnvar("ui_intel_progress_max", -1);
    var_3 setclientomnvar("ui_intel_percent", -1);
    wait 0.05;
    var_3 setclientomnvar("ui_intel_target_player", -1);
    var_3 setclientomnvar("ui_intel_prechallenge", 0);
    wait 0.05;
    var_3 setclientomnvar("ui_intel_timer", -1);
    var_3 setclientomnvar("ui_intel_challenge_scalar", -1);
    wait 0.3;

    if(isDefined(var_2)) {
      var_5 = var_2;

      if(isDefined(var_3.kung_fu_progression) && isDefined(var_3.kung_fu_progression.active_discipline))
        var_5 = var_2 - var_3.kung_fu_progression.challenge_progress[var_3.kung_fu_progression.active_discipline];

      var_3 setclientomnvar("ui_intel_challenge_scalar", var_2);
      var_3 setclientomnvar("ui_intel_progress_max", var_2);
      var_3 setclientomnvar("ui_intel_progress_current", var_5);
    } else
      var_3 setclientomnvar("ui_intel_challenge_scalar", -1);

    var_3 setclientomnvar("ui_intel_prechallenge", 1);
    var_3 setclientomnvar("ui_intel_active_index", int(var_4));
    var_3.current_challenge_index = int(var_4);
    var_3 setclientomnvar("ui_intel_timer", -1);
    var_3 setclientomnvar("zm_show_challenge", 4);
    return;
  }

  level thread _id_100CB(var_0, var_4, var_3);
}

_id_100CB(var_0, var_1, var_2) {
  level endon("game_ended");
  var_2 endon("disconnect");
  wait 1;

  if(var_0 == "challenge_failed") {
    var_2 playlocalsound("zmb_challenge_fail");
    var_2 setclientomnvar("zm_show_challenge", 2);
  } else {
    var_2 playlocalsound("zmb_challenge_complete");
    var_2 setclientomnvar("zm_show_challenge", 3);
  }

  if(isDefined(level.show_challenge_outcome_func)) {
    [[level.show_challenge_outcome_func]](var_0, var_1, var_2);
    return;
  }

  wait 3.0;
  var_2 thread reset_omnvars();
  setomnvar("zm_challenge_progress", 0);
}

reset_omnvars() {
  self notify("challenge_complete");
  wait 0.5;

  if(level.script != "cp_disco")
    self setclientomnvar("ui_intel_active_index", -1);

  self setclientomnvar("ui_intel_progress_current", -1);
  self setclientomnvar("ui_intel_progress_max", -1);
  self setclientomnvar("ui_intel_percent", -1);
  self setclientomnvar("ui_intel_target_player", -1);
  self setclientomnvar("ui_intel_prechallenge", 0);
  self setclientomnvar("ui_intel_timer", -1);
  self setclientomnvar("ui_intel_challenge_scalar", -1);
  self setclientomnvar("zm_show_challenge", -1);
}

register_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.ref = var_0;
  var_11.goal = var_1;
  var_11.default_success = var_2;
  var_11._id_9F82 = ::_id_4FFA;

  if(isDefined(var_3))
    var_11._id_9F82 = var_3;

  var_11._id_386E = ::_id_4FDD;

  if(isDefined(var_4))
    var_11._id_386E = var_4;

  var_11._id_1609 = var_5;
  var_11._id_4DDE = var_6;
  var_11._id_6ACB = ::_id_4FED;

  if(isDefined(var_7))
    var_11._id_6ACB = var_7;

  var_11._id_12E9C = var_8;
  var_11._id_E4C5 = ::_id_5011;

  if(isDefined(var_9))
    var_11._id_E4C5 = var_9;

  var_11._id_6AD0 = ::_id_4FEE;

  if(isDefined(var_10))
    var_11._id_6AD0 = var_10;

  level.challenge_data[var_0] = var_11;
}

update_challenge_progress(var_0, var_1) {
  self setclientomnvar("zm_show_challenge", 1);
  self setclientomnvar("ui_intel_progress_current", var_0);
}

_id_4FDD() {
  return 1;
}

_id_4FED() {}

_id_4FFA() {
  if(isDefined(self.success))
    return self.success;
  else
    return 0;
}

default_successfunc() {
  if(isDefined(self.success))
    return self.success;
  else
    return self.default_success;
}

_id_4FEE() {}

default_resetsuccess() {
  self.current_challenge.success = self.current_challenge.default_success;
}

_id_5011() {}

current_challenge_exist() {
  return isDefined(self.current_challenge);
}

current_challenge_is(var_0) {
  return current_challenge_exist() && self.current_player_challenge == var_0;
}

_id_12BF7() {
  self.current_challenge = undefined;
}

_id_F31A(var_0) {
  self.current_player_challenge = var_0;
}

_id_97B0() {
  if(!isDefined(level.zombie_challenge_table)) {
    return;
  }
  var_0 = level.zombie_challenge_table;
  var_1 = 0;
  var_2 = 1;
  var_3 = 99;
  var_4 = 1;
  var_5 = 2;
  var_6 = 6;
  var_7 = 7;
  var_8 = 8;

  for(var_9 = var_2; var_9 <= var_3; var_9++) {
    var_10 = tablelookup(var_0, var_1, var_9, var_4);

    if(var_10 == "") {
      break;
    }

    var_11 = tablelookup(var_0, var_1, var_9, var_5);
    var_12 = tablelookup(var_0, var_1, var_9, var_8);

    if(isDefined(level.challenge_data[var_10])) {
      level.challenge_data[var_10]._id_1C81 = var_11;
      level.challenge_data[var_10]._id_1C8C = int(tablelookup(var_0, var_1, var_9, var_6));
      level.challenge_data[var_10].active_time = strtok(var_12, " ");
    }
  }
}

_id_4FE2(var_0) {
  return 1;
}

update_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::is_true(self.died_poorly)) {
    return;
  }
  var_9 = var_1;

  if(isDefined(var_1.playerowner) && var_1.playerowner scripts\cp\utility::is_valid_player(1))
    var_9 = var_1.playerowner;

  if(!isPlayer(var_9)) {
    return;
  }
  if(!isDefined(var_9.current_challenge)) {
    return;
  }
  var_10 = var_9.current_challenge;

  if(isDefined(level.custom_death_challenge_func)) {
    var_11 = self[[level.custom_death_challenge_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!scripts\engine\utility::is_true(var_11))
      return;
  }
}