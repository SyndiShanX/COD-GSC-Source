/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2081.gsc
*************************************************/

init_koth_dlog_data() {
  level.esports_initialize_player_pers_data = ::initialize_player_koth_pers_data;
  level.esports_initialize_player_round_data = ::initialize_player_koth_round_data;
  level.esports_objective_info_gametype = spawnStruct();
  level.esports_objective_info_gametype.dlog_name = "dlog_event_esports_objective_info_koth";
  level.esports_objective_state_changed_gametype = spawnStruct();
  level.esports_objective_state_changed_gametype.dlog_name = "dlog_event_esports_objective_state_changed_koth";
  level.esports_objective_state_changed_gametype.data_function = ::add_objective_state_changed_koth_data;
  level.esports_player_interval_gametype = spawnStruct();
  level.esports_player_interval_gametype.dlog_name = "dlog_event_esports_player_interval_info_koth";
  level.esports_player_interval_gametype.data_function = ::add_player_interval_koth_data;
  level.esports_player_match_end_gametype = spawnStruct();
  level.esports_player_match_end_gametype.dlog_name = "dlog_event_esports_player_match_end_koth";
  level.esports_player_match_end_gametype.data_function = ::add_player_koth_match_end_data;
  level.esports_player_round_end_gametype = spawnStruct();
  level.esports_player_round_end_gametype.dlog_name = "dlog_event_esports_player_round_end_koth";
  level.esports_player_round_end_gametype.data_function = ::add_player_koth_round_end_data;
  level.esports_player_death_gametype = spawnStruct();
  level.esports_player_death_gametype.data_function = ::add_player_death_koth_data;
}

init_sd_dlog_data() {
  level.esports_initialize_player_pers_data = ::initialize_player_sd_pers_data;
  level.esports_initialize_player_round_data = ::initialize_player_sd_round_data;
  level.esports_objective_info_gametype = spawnStruct();
  level.esports_objective_info_gametype.dlog_name = "dlog_event_esports_objective_info_sd";
  level.esports_objective_state_changed_gametype = spawnStruct();
  level.esports_objective_state_changed_gametype.dlog_name = "dlog_event_esports_objective_state_changed_sd";
  level.esports_objective_state_changed_gametype.data_function = ::add_objective_state_changed_sd_data;
  level.esports_player_death_gametype = spawnStruct();
  level.esports_player_death_gametype.data_function = ::add_player_death_sd_data;
  level.esports_player_match_end_gametype = spawnStruct();
  level.esports_player_match_end_gametype.dlog_name = "dlog_event_esports_player_match_end_sd";
  level.esports_player_match_end_gametype.data_function = ::add_player_sd_match_end_data;
  level.esports_player_round_end_gametype = spawnStruct();
  level.esports_player_round_end_gametype.dlog_name = "dlog_event_esports_player_round_end_sd";
  level.esports_player_round_end_gametype.data_function = ::add_player_sd_round_end_data;
}

init_control_dlog_data() {
  level.esports_initialize_player_pers_data = ::initialize_player_control_pers_data;
  level.esports_initialize_player_round_data = ::initialize_player_control_round_data;
  level.esports_match_interval_gametype = spawnStruct();
  level.esports_match_interval_gametype.dlog_name = "dlog_event_esports_match_interval_info_control";
  level.esports_match_interval_gametype.data_function = ::add_match_interval_control_data;
  level.esports_objective_info_gametype = spawnStruct();
  level.esports_objective_info_gametype.dlog_name = "dlog_event_esports_objective_info_control";
  level.esports_objective_info_gametype.data_function = ::add_objective_info_control_data;
  level.esports_objective_state_changed_gametype = spawnStruct();
  level.esports_objective_state_changed_gametype.dlog_name = "dlog_event_esports_objective_state_changed_control";
  level.esports_objective_state_changed_gametype.data_function = ::add_objective_state_changed_control_data;
  level.esports_player_interval_gametype = spawnStruct();
  level.esports_player_interval_gametype.dlog_name = "dlog_event_esports_player_interval_info_control";
  level.esports_player_interval_gametype.data_function = ::add_player_interval_control_data;
  level.esports_player_match_end_gametype = spawnStruct();
  level.esports_player_match_end_gametype.dlog_name = "dlog_event_esports_player_match_end_control";
  level.esports_player_match_end_gametype.data_function = ::add_player_control_match_end_data;
  level.esports_player_round_end_gametype = spawnStruct();
  level.esports_player_round_end_gametype.dlog_name = "dlog_event_esports_player_round_end_control";
  level.esports_player_round_end_gametype.data_function = ::add_player_control_round_end_data;
  level.esports_player_death_gametype = spawnStruct();
  level.esports_player_death_gametype.data_function = ::add_player_death_default_data;
}

init_default_dlog_data() {
  level.esports_player_death_gametype = spawnStruct();
  level.esports_player_death_gametype.data_function = ::add_player_death_default_data;
}

init() {
  if(getdvarint("#x37e47a9fed6331575", 0) > 0) {
    wait(getdvarint("#x37e47a9fed6331575", 0));
  }

  if(!_func_0496() && getdvarint("#x3f2eeaf6448a8f3fb", 0) == 0) {
    return;
  }
  level._id_5631 = spawnStruct();
  level._id_5631._id_EFA0 = [];
  level._id_5631.players = [];
  level._id_5631.telemetry_on_interval_time = getdvarint("#x36a50ec7a2ee086d3", 5);
  _id_06E2::_id_1029("callback_server_start", ::send_server_start_telemetry);
  _id_06E2::_id_1029("callback_match_start", ::_id_AA57);
  _id_06E2::_id_1029("callback_match_end", ::send_match_end_telemetry);
  _id_06E2::_id_1029("callback_round_start", ::_id_AA61);
  _id_06E2::_id_1029("callback_round_end", ::send_round_end_telemetry);

  if(getdvarint("#x362e3e8111efda548", 0) < 2) {
    _id_06E2::_id_1029("callback_objective_state_changed", ::send_objective_state_changed_telemetry);
  }

  if(getdvarint("#x362e3e8111efda548", 0) < 1) {
    _id_06E2::_id_1029("callback_player_loadout_changed", ::send_player_loadout_changed_telemetry);
    _id_06E2::_id_1029("callback_on_player_disconnect", ::_id_AA5E);
  }

  _id_06E2::_id_1029("callback_player_death", ::on_player_death);
  _id_06E2::_id_1029("callback_on_player_first_connect", ::on_player_first_connect);
  _id_06E2::_id_1029("callback_on_player_connect", ::_id_AA5D);
  _id_06E2::_id_1029("callback_player_match_end", ::send_player_match_end_telemetry);
  _id_06E2::_id_1029("callback_player_round_end", ::send_player_round_end_telemetry);
  _id_06E2::_id_1029("callback_on_player_spawned", ::send_player_spawned_telemetry);

  switch (level.gametype) {
    case "koth":
      init_koth_dlog_data();
      break;
    case "sd":
      init_sd_dlog_data();
      break;
    case "control":
      init_control_dlog_data();
      break;
    default:
      init_default_dlog_data();
      break;
  }

  level notify("telemetry_init");
}

start_on_interval() {
  self endon("death");
  level endon("game_ended");
  var_0 = level._id_5631.telemetry_on_interval_time;
  level.esportsintervalcount = 0;

  for(;;) {
    level.esportsintervalcount++;

    if(getdvarint("#x362e3e8111efda548", 0) < 2) {
      send_match_interval_telemetry();
      send_players_interval_telemetry();
    }

    update_player_ping();
    wait(var_0);
  }
}

vector_to_array(var_0) {
  return [var_0[0], var_0[1], var_0[2]];
}

_id_6488(var_0) {
  if(!isDefined(level._id_5631._id_EFA0[var_0])) {
    var_1 = _func_0488(var_0);
    level._id_5631._id_EFA0[var_0] = ::scripts\engine\utility::ter_op(isDefined(var_1), var_1, var_0);
  }

  return level._id_5631._id_EFA0[var_0];
}

_id_6866(var_0) {
  if(var_0 == "none") {
    return "draw";
  }

  return _id_6488(var_0);
}

get_esports_player_name(var_0) {
  if(!isDefined(var_0._id_0509)) {
    return var_0 _meth_8872();
  }

  if(!isDefined(level._id_5631.players[var_0._id_0509])) {
    level._id_5631.players[var_0._id_0509] = var_0 _meth_8872();
  }

  return level._id_5631.players[var_0._id_0509];
}

_id_6585() {
  return _id_07EE::_id_6DE4(gettime());
}

_id_6712(var_0) {
  var_1 = game["end_reason"];
  var_2 = getarraykeys(var_1);

  foreach(var_4 in var_2) {
    var_5 = var_1[var_4];

    if(var_5 == var_0) {
      return var_4;
    }
  }

  return "unknown";
}

_id_6715(var_0) {
  var_1 = spawnStruct();

  if(var_0 == game["attackers"]) {
    var_1._id_DD12 = "attack";
    var_1._id_10E22 = var_0;
    var_1._id_98A3 = game["defenders"];
  } else if(var_0 == game["defenders"]) {
    var_1._id_DD12 = "defense";
    var_1._id_10E22 = var_0;
    var_1._id_98A3 = game["attackers"];
  } else {
    var_1._id_DD12 = "none";
    var_1._id_10E22 = "none";
    var_1._id_98A3 = "none";
  }

  return var_1;
}

_id_67C4() {
  var_0 = spawnStruct();

  if(scripts\mp\utility\game::isroundbased()) {
    if(game["attackers"] == "allies") {
      var_0._id_EF3E = "attack";
      var_0._id_EF3F = "defense";
    } else {
      var_0._id_EF3E = "defense";
      var_0._id_EF3F = "attack";
    }
  } else {
    var_0._id_EF3E = "none";
    var_0._id_EF3F = "none";
  }

  return var_0;
}

get_number_of_rounds(var_0) {
  var_1 = 1;

  if(!scripts\mp\utility\game::isroundbased()) {
    return var_1;
  }

  var_1 = game["roundsPlayed"];

  if(isDefined(var_0) && (var_0 == "MOD_GAME_ENDED" || var_0 == "MOD_ROUND_ENDED")) {
    var_1--;

    if(var_1 < 1) {
      var_1 = 1;
    }
  }

  return var_1;
}

get_objective_timer() {
  var_0 = level._id_110E4;

  if(isDefined(level._id_463F)) {
    var_0 = level._id_463F;
  }

  if(isDefined(var_0)) {
    var_1 = gettime();
    return scripts\engine\utility::ter_op(var_1 < var_0, var_0 - var_1, 0);
  }

  return 0;
}

is_ace_kill(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::_id_6A59(var_1.team, 0).size;
  return var_0.pers["kills"] - var_0.round_start_data._id_0267 == var_2;
}

is_rotation_time() {
  return !level.waitingfirstzone && level._id_110E4 - gettime() <= 15000;
}

get_objective_name_koth() {
  var_0 = level._id_110CF._id_A8E1;
  return "point" + var_0;
}

get_objective_name_sd() {
  var_0 = self._id_A8E1;

  if(isDefined(var_0) && (var_0 == "_a" || var_0 == "_b")) {
    return "point" + var_0;
  }

  return "bomb";
}

get_objective_name_control() {
  return "point" + self._id_A8E1;
}

get_objective_info(var_0) {
  var_1 = ["obj_name", "point" + var_0._id_A8E1, "origin", vector_to_array(var_0._id_4140)];
  return var_1;
}

get_lives_for_team(var_0) {
  var_1 = level._id_EF6A[var_0]["controlUILivesCount"];

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0, "livesCount");
  var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "aliveCount");
  return var_2 + var_3;
}

is_interacting_objective() {
  var_0 = istrue(self._id_8783);
  var_1 = isDefined(self._id_F398) && self._id_F398.size > 0;
  return var_0 || var_1;
}

initialize_player_koth_pers_data() {
  if(!isDefined(self.pers["obj1Time"])) {
    scripts\mp\utility\stats::_id_8257("obj1Time");
  }

  if(!isDefined(self.pers["obj2Time"])) {
    scripts\mp\utility\stats::_id_8257("obj2Time");
  }

  if(!isDefined(self.pers["obj3Time"])) {
    scripts\mp\utility\stats::_id_8257("obj3Time");
  }

  if(!isDefined(self.pers["obj4Time"])) {
    scripts\mp\utility\stats::_id_8257("obj4Time");
  }

  if(!isDefined(self.pers["obj5Time"])) {
    scripts\mp\utility\stats::_id_8257("obj5Time");
  }
}

initialize_player_control_pers_data() {
  if(!isDefined(self.pers["objective_tiers_contributed"])) {
    scripts\mp\utility\stats::_id_8257("objective_tiers_contributed");
  }
}

initialize_player_sd_pers_data() {
  if(!isDefined(self.pers["sneakDefuses"])) {
    scripts\mp\utility\stats::_id_8257("sneakDefuses");
  }
}

initialize_player_pers_data() {
  if(!isDefined(self.pers["total_time_alive"])) {
    scripts\mp\utility\stats::_id_8257("total_time_alive");
  }

  if(!isDefined(self.pers["shotsHitHead"])) {
    scripts\mp\utility\stats::_id_8257("shotsHitHead");
  }

  if(!isDefined(self.pers["totalMultikills"])) {
    scripts\mp\utility\stats::_id_8257("totalMultikills");
  }

  if(!isDefined(self.pers["highestMultikill"])) {
    scripts\mp\utility\stats::_id_8257("highestMultikill");
  }

  if(!isDefined(self.pers["soloKills"])) {
    scripts\mp\utility\stats::_id_8257("soloKills");
  }

  if(!isDefined(self.pers["deadSilenceKills"])) {
    scripts\mp\utility\stats::_id_8257("deadSilenceKills");
  }

  if(!isDefined(self.pers["deadSilenceTime"])) {
    scripts\mp\utility\stats::_id_8257("deadSilenceTime");
  }

  if(!isDefined(self.pers["damageHealed"])) {
    scripts\mp\utility\stats::_id_8257("damageHealed");
  }

  if(!isDefined(self.pers["untradedDeaths"])) {
    scripts\mp\utility\stats::_id_8257("untradedDeaths");
  }

  if(!isDefined(self.pers["tradedKills"])) {
    scripts\mp\utility\stats::_id_8257("tradedKills");
  }

  if(!isDefined(self.pers["tradedDeaths"])) {
    scripts\mp\utility\stats::_id_8257("tradedDeaths");
  }

  if(!isDefined(self.pers["inapplicableTradedKills"])) {
    scripts\mp\utility\stats::_id_8257("inapplicableTradedKills");
  }

  if(!isDefined(self.pers["inapplicableTradedDeaths"])) {
    scripts\mp\utility\stats::_id_8257("inapplicableTradedDeaths");
  }

  if(!isDefined(self.pers["friendlyDamageDone"])) {
    scripts\mp\utility\stats::_id_8257("friendlyDamageDone");
  }

  if(!isDefined(self.pers["tacticalsUsed"])) {
    scripts\mp\utility\stats::_id_8257("tacticalsUsed");
  }

  if(!isDefined(self.pers["lethalsUsed"])) {
    scripts\mp\utility\stats::_id_8257("lethalsUsed");
  }

  if(!isDefined(self.pers["avgPing"])) {
    scripts\mp\utility\stats::_id_8257("avgPing");
  }

  if(!isDefined(self.pers["minPing"])) {
    scripts\mp\utility\stats::_id_8257("minPing");
    self.pers["minPing"] = 2147483647;
  }

  if(!isDefined(self.pers["maxPing"])) {
    scripts\mp\utility\stats::_id_8257("maxPing");
  }

  if(isDefined(level.esports_initialize_player_pers_data)) {
    self[[level.esports_initialize_player_pers_data]]();
  }
}

initialize_player_koth_round_data(var_0, var_1) {
  var_0.objtime = var_1["objTime"];
  var_0.obj1time = var_1["obj1Time"];
  var_0.obj2time = var_1["obj2Time"];
  var_0.obj3time = var_1["obj3Time"];
  var_0.obj4time = var_1["obj4Time"];
  var_0.obj5time = var_1["obj5Time"];
}

initialize_player_sd_round_data(var_0, var_1) {
  var_0.bombs_planted = var_1["plants"];
  var_0.bombs_defused = var_1["defuses"];
  var_0.sneak_defuses = var_1["sneakDefuses"];
}

initialize_player_control_round_data(var_0, var_1) {
  var_0.tiers_captured = var_1["objective_tiers_contributed"];
}

initialize_player_round_data() {
  var_0 = spawnStruct();
  var_1 = self.pers;
  var_2 = _id_07BF::getlocalcodcasterclientstat(0);
  var_3 = _id_07BF::getlocalcodcasterclientstat(1);
  var_4 = _id_07BF::_id_6979(1);
  var_0._id_0267 = var_1["kills"];
  var_0._id_0157 = var_1["deaths"];
  var_0._id_006F = var_1["assists"];
  var_0.damage_dealt = var_4;
  var_0.highest_streak = 0;
  var_0.time_alive = var_1["total_time_alive"];
  var_0._id_038F = var_1["score"];
  var_0._id_DA63 = var_2;
  var_0._id_DA65 = var_3;
  var_0.shots_head = var_1["shotsHitHead"];

  if(isDefined(level.esports_initialize_player_round_data)) {
    self[[level.esports_initialize_player_round_data]](var_0, var_1);
  }

  self.round_start_data = var_0;
}

update_player_death_data() {
  var_0 = _id_6585();
  var_1 = var_0 - _id_07EE::_id_6DE4(self._id_E393);
  scripts\mp\utility\stats::_id_7DAE("total_time_alive", var_1);
  var_2 = self.pers["cur_kill_streak"];
  var_3 = self.round_start_data;

  if(var_3.highest_streak < var_2) {
    var_3.highest_streak = var_2;
  }
}

update_player_round_end_data() {
  if(isalive(self)) {
    var_0 = _id_6585();
    var_1 = var_0 - _id_07EE::_id_6DE4(self._id_E393);
    scripts\mp\utility\stats::_id_7DAE("total_time_alive", var_1);
  }
}

get_player_movement_data() {
  var_0 = self;
  var_1 = spawnStruct();
  var_2 = var_0._id_D02F;

  if(isDefined(var_2) && var_2["movementUpdateCount"] >= 30) {
    var_1.time_spent_moving = int(var_2["movingTotal"] / (var_2["movementUpdateCount"] / 5));
    var_1.average_speed_during_match = float(var_2["distanceTotal"] / var_2["movementUpdateCount"]);
    return var_1;
  }

  var_1.time_spent_moving = 0;
  var_1.average_speed_during_match = 0.0;
  return var_1;
}

get_kill_player_info(var_0) {
  var_1 = self;
  var_2 = var_0._id_04F6;
  var_3 = "none";

  if(isDefined(var_2)) {
    var_3 = var_2.basename;
  }

  return ["name", get_esports_player_name(var_1), "team", _id_6488(var_1.sessionteam), "origin", vector_to_array(var_0.origin), "viewangles", vector_to_array(var_0.angles), "weapon", var_3, "weapon_attachments", scripts\mp\utility\weapon::_id_6E69(var_2)];
}

get_player_status_effects() {
  var_0 = self;
  return ["is_ads", var_0 scripts\mp\utility\player::_id_8989(), "is_flashed", istrue(var_0._id_5C96), "is_interacting_objective", var_0 is_interacting_objective()];
}

update_player_ping() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.pingtotal)) {
      var_1.pingtotal = 0;
    }

    var_2 = var_1 _meth_8887();

    if(!isDefined(var_1.pers["minPing"]) || var_1.pers["minPing"] > var_2) {
      var_1.pers["minPing"] = var_2;
    }

    if(!isDefined(var_1.pers["maxPing"]) || var_1.pers["maxPing"] < var_2) {
      var_1.pers["maxPing"] = var_2;
    }

    var_1.pingtotal = var_1.pingtotal + var_2;
    var_1.pers["avgPing"] = var_1.pingtotal / level.esportsintervalcount;
  }
}

_id_AA57() {
  send_match_start_telemetry();
  send_objective_info_telemetry();
}

_id_AA61() {
  level thread start_on_interval();
  send_round_start_telemetry();
}

on_player_first_connect(var_0) {
  if(var_0 _meth_81D3()) {
    return;
  }
  var_0 initialize_player_pers_data();
}

_id_AA5D(var_0) {
  if(var_0 _meth_81D3()) {
    return;
  }
  if(!isDefined(var_0.sent_telemetry)) {
    var_0.sent_telemetry = spawnStruct();
  }

  if(!isDefined(var_0.round_start_data)) {
    var_0 initialize_player_round_data();
  }
}

on_player_death(var_0) {
  if(!isDefined(var_0.attacker)) {
    return;
  }
  var_0._id_103C2 update_player_death_data();
  send_player_death_telemetry(var_0);
}

_id_AA5E(var_0) {
  var_1 = var_0.player;

  if(var_1 _meth_81D3() || !_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  var_2 = var_1.sent_telemetry;

  if(!istrue(var_2.round_end)) {
    send_player_round_end_telemetry(var_0);
  }

  if(!istrue(var_2.match_end)) {
    send_player_match_end_telemetry(var_0);
  }

  send_player_disconnect_telemetry(var_0);
}

send_server_start_telemetry() {
  var_0 = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", _id_6488("allies"), "team2_name", _id_6488("axis")];
  _func_03BF("dlog_event_esports_server_start", var_0);
}

send_match_start_telemetry() {
  var_0 = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", _id_6488("allies"), "team2_name", _id_6488("axis")];
  _func_03BF("dlog_event_esports_match_start", var_0);
}

send_match_end_telemetry(var_0) {
  var_1 = ["match_time", _id_6585(), "rounds_played", game["roundsPlayed"], "team1_name", _id_6488("allies"), "team1_score", _func_00DB("allies"), "team2_name", _id_6488("axis"), "team2_score", _func_00DB("axis"), "win_team", _id_6866(var_0._id_10E53), "game_type", level.gametype, "map_name", level.mapname];
  _func_03BF("dlog_event_esports_match_end", var_1);
}

add_match_interval_control_data(var_0) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["team1_lives_remaining", get_lives_for_team("axis"), "team2_lives_remaining", get_lives_for_team("allies")]);
  return var_0;
}

send_match_interval_telemetry() {
  var_0 = ["game_timer", int(scripts\mp\gamelogic::_id_6DE8() / 1000), "objective_timer", int(get_objective_timer() / 1000), "team1_score", _func_00DB("allies"), "team2_score", _func_00DB("axis")];
  var_1 = "dlog_event_esports_match_interval_info";

  if(isDefined(level.esports_match_interval_gametype)) {
    var_1 = level.esports_match_interval_gametype.dlog_name;
    var_0 = self[[level.esports_match_interval_gametype.data_function]](var_0);
  }

  _func_03BF(var_1, var_0);
}

send_round_start_telemetry() {
  var_0 = _id_67C4();
  var_1 = ["team1_side", var_0._id_EF3E, "team2_side", var_0._id_EF3F];
  _func_03BF("dlog_event_esports_round_start", var_1);
}

send_round_end_telemetry(var_0) {
  var_1 = _id_6715(var_0._id_10E53);
  var_2 = ["result", _id_6712(var_0._id_52BF), "win_side", var_1._id_DD12, "match_time", _id_6585(), "game_type", level.gametype, "map_name", level.mapname, "win_team", _id_6488(var_1._id_10E22), "loss_team", _id_6488(var_1._id_98A3)];
  _func_03BF("dlog_event_esports_round_end", var_2);
}

add_objective_info_control_data(var_0) {
  var_1 = ["team1_lives", get_lives_for_team("axis"), "team2_lives", get_lives_for_team("allies")];
  var_0 = scripts\engine\utility::array_combine(var_0, ["control_info", var_1]);
  return var_0;
}

send_objective_info_telemetry() {
  var_0 = [];
  var_1 = level._id_A8E8;
  var_2 = 1;

  foreach(var_4 in var_1) {
    var_5 = "objective" + var_2 + "_info";
    var_0 = scripts\engine\utility::array_add(var_0, var_5);
    var_0 = scripts\engine\utility::array_add(var_0, get_objective_info(var_4));
    var_2++;
  }

  var_7 = "dlog_event_esports_objective_info";

  if(isDefined(level.esports_objective_info_gametype)) {
    var_7 = level.esports_objective_info_gametype.dlog_name;

    if(isDefined(level.esports_objective_info_gametype.data_function)) {
      var_0 = self[[level.esports_objective_info_gametype.data_function]](var_0);
    }
  }

  _func_03BF(var_7, var_0);
}

add_objective_state_changed_koth_data(var_0, var_1) {
  var_2 = var_1.obj_team;
  var_0 = scripts\engine\utility::array_combine(var_0, ["obj_name", get_objective_name_koth(), "is_captured", var_2 != "none", "is_contested", self._id_E57B]);
  return var_0;
}

add_objective_state_changed_sd_data(var_0, var_1) {
  var_2 = var_1.credit_player;
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2._id_8783;
  }

  var_0 = scripts\engine\utility::array_combine(var_0, ["obj_name", get_objective_name_sd(), "is_bomb_picked_up", var_3, "is_bomb_planted", level._id_2663, "is_bomb_defused", level._id_2635]);
  return var_0;
}

add_objective_state_changed_control_data(var_0, var_1) {
  var_2 = var_1.obj_team;
  var_3 = 0;

  if(isDefined(self._id_D030)) {
    var_3 = self._id_D030;
  }

  var_0 = scripts\engine\utility::array_combine(var_0, ["obj_name", get_objective_name_control(), "is_captured", var_2 != "none", "is_contested", self._id_E57B, "tiers_captured", var_3, "team1_remaining_lives", get_lives_for_team("axis"), "team2_remaining_lives", get_lives_for_team("allies")]);
  return var_0;
}

send_objective_state_changed_telemetry(var_0) {
  if(!isDefined(self._id_A908)) {
    return;
  }
  var_1 = var_0.credit_player;
  var_2 = var_0.objective_entity;
  var_3 = "none";
  var_4 = "none";

  if(isDefined(var_1)) {
    var_3 = get_esports_player_name(var_1);
    var_4 = _id_6488(var_1.sessionteam);
  }

  var_5 = ["player_name", var_3, "obj_pos", vector_to_array(self._id_4140), "obj_team", var_4, "match_time", _id_6585()];
  var_6 = "dlog_event_esports_objective_state_changed";

  if(isDefined(level.esports_objective_state_changed_gametype)) {
    var_7 = spawnStruct();
    var_7.credit_player = var_1;
    var_7.obj_team = var_4;
    var_6 = level.esports_objective_state_changed_gametype.dlog_name;
    var_5 = self[[level.esports_objective_state_changed_gametype.data_function]](var_5, var_7);
  }

  _func_03BF(var_6, var_5);
}

send_player_disconnect_telemetry(var_0) {
  var_1 = var_0.player;
  var_2 = ["player_name", get_esports_player_name(var_1)];
  var_1 _meth_870F("dlog_event_esports_player_disconnect", var_2);
}

send_player_spawned_telemetry(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0 getplayerangles();
  var_3 = ["player_name", get_esports_player_name(var_0), "player_team", _id_6488(var_0.sessionteam), "match_time", _id_6585(), "origin", vector_to_array(var_1), "viewangles", vector_to_array(var_2)];
  var_0 _meth_870F("dlog_event_esports_player_spawned", var_3);
}

add_player_death_koth_data(var_0, var_1) {
  var_0[11] = ::scripts\engine\utility::array_combine(var_0[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", is_rotation_time()]);
  return var_0;
}

add_player_death_sd_data(var_0, var_1) {
  var_2 = var_1.attacker;

  if(!isDefined(var_2)) {
    return add_player_death_default_data(var_0, var_1);
  }

  var_3 = var_1._id_103C2;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2._id_9FFB), var_2._id_9FFB, []);
  var_0[11] = ::scripts\engine\utility::array_combine(var_0[11], ["is_planter_kill", istrue(var_4["killed_planter"]), "is_defuser_kill", istrue(var_4["killed_defuser"]), "is_ace_kill", is_ace_kill(var_2, var_3), "is_rotation_kill", 0]);
  return var_0;
}

add_player_death_default_data(var_0, var_1) {
  var_0[11] = ::scripts\engine\utility::array_combine(var_0[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", 0]);
  return var_0;
}

send_player_death_telemetry(var_0) {
  var_1 = var_0._id_103C2;
  var_2 = var_1._id_8FBB;
  var_3 = var_1._id_8FB8;
  var_4 = var_0.attacker;

  if(isPlayer(var_4)) {
    var_5 = var_4.origin;
    var_6 = var_4 getplayerangles();
    var_7 = var_0.objweapon;
    var_8 = scripts\engine\utility::ter_op(isDefined(var_4._id_9FFB), var_4._id_9FFB, []);
    var_9 = spawnStruct();
    var_9.origin = var_5;
    var_9.angles = var_6;
    var_9._id_04F6 = var_7;
    var_10 = var_4 get_kill_player_info(var_9);
    var_11 = var_4 get_player_status_effects();
    var_12 = scripts\engine\utility::_id_10E76(var_2, var_3, var_5, 0.4226);
    var_13 = scripts\engine\utility::_id_10E76(var_5, var_6, var_2, 0.4226);
    var_14 = ["is_longshot_kill", istrue(var_8["longshot"]), "is_pointblank_kill", istrue(var_8["pointblank"]), "is_first_blood", istrue(var_8["firstblood"]), "is_revenge_kill", istrue(var_8["revenge"]), "is_wallbang", istrue(var_8["bulletpen"]), "attacker_in_victim_fov", var_12, "victim_in_attacker_fov", var_13];
    var_15 = distance(var_5, var_2);
  } else {
    var_10 = [];
    var_11 = [];
    var_14 = [];
    var_15 = 0.0;
  }

  var_16 = var_1._id_90CE;
  var_17 = spawnStruct();
  var_17.origin = var_2;
  var_17.angles = var_3;
  var_17._id_04F6 = var_16;
  var_18 = var_1 get_kill_player_info(var_17);
  var_19 = var_1 get_player_status_effects();
  var_20 = ["match_time", _id_6585(), "means_of_death", var_0._id_9CD6, "players_distance", var_15];
  var_21 = ["info", var_20, "attacker", var_10, "attacker_status", var_11, "victim", var_18, "victim_status", var_19, "kill_context", var_14];
  var_22 = "dlog_event_esports_player_killed";

  if(isDefined(level.esports_player_death_gametype)) {
    var_21 = self[[level.esports_player_death_gametype.data_function]](var_21, var_0);
  }

  var_1 _meth_870F(var_22, var_21);
}

add_player_koth_match_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["objective1_time", var_1["obj1Time"], "objective2_time", var_1["obj2Time"], "objective3_time", var_1["obj3Time"], "objective4_time", var_1["obj4Time"], "objective5_time", var_1["obj5Time"]]);
  return var_0;
}

add_player_sd_match_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["bombs_planted", var_1["plants"], "bombs_defused", var_1["defuses"], "sneak_defuses", var_1["sneakDefuses"]]);
  return var_0;
}

add_player_control_match_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["total_objectives_captured", var_1["captures"], "objective_tiers_contributed", var_1["objective_tiers_contributed"]]);
  return var_0;
}

send_player_match_end_telemetry(var_0) {
  var_1 = var_0.player;

  if(var_1 _meth_81D3()) {
    return;
  }
  var_2 = get_player_movement_data();
  var_3 = var_1.pers;
  var_4 = var_1 _id_07BF::getlocalcodcasterclientstat(0);
  var_5 = var_1 _id_07BF::getlocalcodcasterclientstat(1);
  var_6 = var_1 _id_07BF::_id_6979(1);
  var_7 = 0.0;

  if(isDefined(var_3["totalDistTraveled"])) {
    var_7 = float(var_3["totalDistTraveled"]);
  }

  var_8 = ["total_score", var_3["score"], "total_assists", var_3["assists"], "total_kills", var_3["kills"], "highest_streak", var_3["longestStreak"], "total_deaths", var_3["deaths"], "total_headshots", var_3["headshots"], "total_time_alive", scripts\engine\utility::ter_op(var_3["total_time_alive"] == 0, _id_6585(), var_3["total_time_alive"]), "total_damage_dealt", var_6, "total_distance_traveled", var_7, "average_speed_during_match", var_2.average_speed_during_match, "time_spent_moving", var_2.time_spent_moving, "total_suicides", var_3["suicides"], "total_shots_fired", var_4, "total_shots_hit", var_5, "total_shots_head", var_3["shotsHitHead"], "total_solokills", var_3["soloKills"], "total_multikills", var_3["totalMultikills"], "highest_multikill", var_3["highestMultikill"], "rounds_played", var_1 get_number_of_rounds(var_0._id_9CD6), "player_name", get_esports_player_name(var_1), "game_type", level.gametype, "untraded_kills", var_1 _id_07BF::_id_6979(20), "untraded_deaths", var_3["untradedDeaths"], "traded_kills", var_3["tradedKills"], "traded_deaths", var_3["tradedDeaths"], "inapplicable_traded_kills", var_3["inapplicableTradedKills"], "inapplicable_traded_deaths", var_3["inapplicableTradedDeaths"], "dead_silence_kills", var_3["deadSilenceKills"], "dead_silence_time", int(var_3["deadSilenceTime"] / 1000), "damage_taken", var_3["damageTaken"], "damage_healed", var_3["damageHealed"], "friend_damage", var_3["friendlyDamageDone"], "tacticals_used", var_3["tacticalsUsed"], "lethals_used", var_3["lethalsUsed"], "avg_ping", var_3["avgPing"], "min_ping", var_3["minPing"], "max_ping", var_3["maxPing"]];
  var_9 = "dlog_event_esports_player_match_end";

  if(isDefined(level.esports_player_match_end_gametype)) {
    var_9 = level.esports_player_match_end_gametype.dlog_name;
    var_8 = self[[level.esports_player_match_end_gametype.data_function]](var_8, var_3, var_1.round_start_data);
  }

  var_1 _meth_870F(var_9, var_8);
  var_1.sent_telemetry.match_end = 1;
}

add_player_interval_koth_data(var_0) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["objective_kills", _id_07BF::_id_6979(13), "average_hill_kills", int(_id_07BF::_id_6979(15)), "average_hill_damage", int(_id_07BF::_id_6979(16)), "average_hill_time", int(_id_07BF::_id_6979(3)), "contested_hill_time", _id_07BF::_id_6979(14)]);
  return var_0;
}

add_player_interval_control_data(var_0) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["objective_kills", _id_07BF::_id_6979(13)]);
  return var_0;
}

send_players_interval_telemetry() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!isDefined(var_2) || var_2 _meth_81D3()) {
      continue;
    }
    var_3 = var_2.pers;
    var_4 = var_2 _id_07BF::getlocalcodcasterclientstat(0);
    var_5 = var_2 _id_07BF::getlocalcodcasterclientstat(1);
    var_6 = var_2 _id_07BF::_id_6979(1);
    var_7 = var_2 _meth_8887();
    var_8 = ["player_name", get_esports_player_name(var_2), "origin", vector_to_array(var_2.origin), "damage_dealt", var_6, "assists", var_3["assists"], "deaths", var_3["deaths"], "kills", var_3["kills"], "current_killstreak", var_3["cur_kill_streak"], "highest_killstreak", var_3["longestStreak"], "multikills", var_3["totalMultikills"], "highest_multikill", var_3["highestMultikill"], "score", var_3["score"], "shots_fired", var_4, "shots_hit", var_5, "shots_head", var_3["shotsHitHead"], "objective_time", var_3["objTime"], "ping", var_7];

    if(isDefined(level.esports_player_interval_gametype)) {
      var_8 = var_2[[level.esports_player_interval_gametype.data_function]](var_8);
    }

    var_9 = spawnStruct();
    var_9.player = var_2;
    var_9._id_5689 = var_8;
    var_0 = scripts\engine\utility::array_add(var_0, var_9);
  }

  var_11 = "dlog_event_esports_player_interval_info";

  if(isDefined(level.esports_player_interval_gametype)) {
    var_11 = level.esports_player_interval_gametype.dlog_name;
  }

  foreach(var_9 in var_0) {
    var_2 = var_9.player;

    if(!isDefined(var_2)) {
      continue;
    }
    var_2 _meth_870F(var_11, var_9._id_5689);
    waitframe();
  }
}

add_player_koth_round_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["objective1_time", var_1["obj1Time"] - var_2.obj1time, "objective2_time", var_1["obj2Time"] - var_2.obj2time, "objective3_time", var_1["obj3Time"] - var_2.obj3time, "objective4_time", var_1["obj4Time"] - var_2.obj4time, "objective5_time", var_1["obj5Time"] - var_2.obj5time]);
  return var_0;
}

add_player_sd_round_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["bombs_planted", var_1["plants"] - var_2.bombs_planted, "bombs_defused", var_1["defuses"] - var_2.bombs_defused, "sneak_defuses", var_1["sneakDefuses"] - var_2.sneak_defuses]);
  return var_0;
}

add_player_control_round_end_data(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_combine(var_0, ["tiers_captured", var_2.tiers_captured]);
  return var_0;
}

send_player_round_end_telemetry(var_0) {
  var_1 = var_0.player;

  if(var_1 _meth_81D3()) {
    return;
  }
  var_1 update_player_round_end_data();
  var_2 = var_1.pers;
  var_3 = var_1.round_start_data;
  var_4 = var_1 _id_07BF::getlocalcodcasterclientstat(0);
  var_5 = var_1 _id_07BF::getlocalcodcasterclientstat(1);
  var_6 = var_1 _id_07BF::_id_6979(1);
  var_7 = var_3.highest_streak;
  var_8 = var_2["cur_kill_streak"];
  var_9 = ["kills", var_2["kills"] - var_3._id_0267, "assists", var_2["assists"] - var_3._id_006F, "deaths", var_2["deaths"] - var_3._id_0157, "damage_dealt", var_6 - var_3.damage_dealt, "highest_streak", scripts\engine\utility::ter_op(var_7 < var_8, var_8, var_7), "time_alive", var_2["total_time_alive"] - var_3.time_alive, "rounds_played", var_1 get_number_of_rounds(), "rounds_won", scripts\mp\utility\game::_id_6CFE(var_1.sessionteam), "score", var_2["score"] - var_3._id_038F, "shots_fired", var_4 - var_3._id_DA63, "shots_hit", var_5 - var_3._id_DA65, "shots_head", var_2["shotsHitHead"] - var_3.shots_head, "player_name", get_esports_player_name(var_1), "game_type", level.gametype];
  var_10 = "dlog_event_esports_player_round_end";

  if(isDefined(level.esports_player_round_end_gametype)) {
    var_10 = level.esports_player_round_end_gametype.dlog_name;
    var_9 = self[[level.esports_player_round_end_gametype.data_function]](var_9, var_2, var_3);
  }

  var_1 _meth_870F(var_10, var_9);
  var_1.sent_telemetry.round_end = 1;
}

send_player_loadout_changed_telemetry(var_0) {
  var_1 = var_0.player;

  if(var_1 _meth_81D3()) {
    return;
  }
  var_2 = var_0._id_EA6A;
  var_3 = var_0._id_704A;
  var_4 = [var_2._id_9679, var_2._id_967A, var_2._id_967B];
  var_5 = [var_3._id_9674, var_3._id_9675];
  var_6 = ["none"];

  if(isDefined(var_2._id_9685) && var_2._id_9685.size > 0) {
    var_6 = var_2._id_9685;
  }

  var_7 = ["none"];

  if(isDefined(var_2._id_9694) && var_2._id_9694.size > 0) {
    var_7 = var_2._id_9694;
  }

  var_8 = ["player_name", get_esports_player_name(var_1), "primary_weapon", var_2._id_9683, "primary_weapon_attachments", var_6, "secondary_weapon", var_2._id_9692, "secondary_weapon_attachments", var_7, "primary_grenade", var_2._id_966A, "secondary_grenade", var_2._id_966B, "field_upgrades", var_5, "streaks", var_4, "perks", scripts\engine\utility::array_combine(var_2._id_967F, var_2._id_9670), "match_time", _id_6585()];
  var_1 _meth_870F("dlog_event_esports_player_loadout_changed", var_8);
}