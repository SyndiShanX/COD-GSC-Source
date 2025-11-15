/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_analytics.gsc
***************************************/

start_game_type(param_00, param_01, param_02) {
  init(param_02);
  init_matchdata(param_00, param_01);
}

init_matchdata(param_00, param_01) {
  setmatchdatadef(param_00);
  setclientmatchdatadef(param_01);
  setmatchdata("commonMatchData", "map", level.script);
  setmatchdata("commonMatchData", "gametype", getdvar("ui_gametype"));
  setmatchdata("commonMatchData", "buildVersion", getbuildversion());
  setmatchdata("commonMatchData", "buildNumber", getbuildnumber());
  setmatchdata("commonMatchData", "utcStartTimeSeconds", getsystemtime());
  setmatchdata("commonMatchData", "isPrivateMatch", getdvarint("xblive_privatematch"));
  setmatchdata("commonMatchData", "isRankedMatch", 1);
  setmatchdataid();
  level thread wait_set_initial_player_count();
}

init(param_00) {
  var_01 = spawnStruct();
  var_02 = [];
  var_01.single_value_stats = var_02;
  var_03 = [];
  var_01.challenge_results = var_03;
  level.var_13F0B = var_01;
  init_analytics(param_00);
  level.player_count = 0;
  level.player_count_left = 0;
}

wait_set_initial_player_count() {
  level endon("gameEnded");
  level waittill("prematch_done");
  setmatchdata("commonMatchData", "playerCountStart", validate_byte(level.players.size));
}

on_player_connect() {
  player_init();
  set_player_count();
  set_split_screen();
  set_join_in_progress();
  setmatchdata("players", self.clientid, "playerID", "xuid", scripts\cp\utility::getuniqueid());
  setmatchdata("players", self.clientid, "gamertag", self.name);
  setmatchdata("players", self.clientid, "waveStart", level.wave_num);
  setmatchdata("players", self.clientid, "quit", 0);
  level.player_count = level.player_count + 1;
}

on_player_disconnect(param_00) {
  setmatchdata("players", self.clientid, "disconnectReason", param_00);
  setmatchdata("players", self.clientid, "quit", param_00 == "EXE_DISCONNECTED");
  set_custom_stats();
  level.player_count_left = level.player_count_left + 1;
}

player_init() {
  var_00 = spawnStruct();
  var_01 = [];
  var_01["cashSpentOnWeapon"] = get_single_value_struct(0, "int");
  var_01["cashSpentOnAbility"] = get_single_value_struct(0, "int");
  var_01["cashSpentOnTrap"] = get_single_value_struct(0, "int");
  var_00.single_value_stats = var_01;
  var_02 = [];
  var_02["timesDowned"] = [];
  var_02["timesRevived"] = [];
  var_02["timesBledOut"] = [];
  var_00.laststand_record = var_02;
  self.var_13F0B = var_00;
}

set_player_count() {
  if(!isDefined(level.max_concurrent_player_count)) {
    level.max_concurrent_player_count = 0;
  }

  if(level.players.size >= level.max_concurrent_player_count) {
    level.max_concurrent_player_count = level.players.size + 1;
  }
}

set_split_screen() {
  setmatchdata("players", self.clientid, "isSplitscreen", self issplitscreenplayer());
}

set_join_in_progress() {
  if(prematch_over()) {
    setmatchdata("players", self.clientid, "joinInProgress", 1);
  }
}

prematch_over() {
  if(scripts\engine\utility::flag_exist("introscreen_over") && scripts\engine\utility::flag("introscreen_over")) {
    return 1;
  }

  return 0;
}

update_challenges_status(param_00, param_01) {
  if(level.var_13F0B.challenge_results.size > 25) {
    return;
  }

  var_02 = spawnStruct();
  var_02.challenge_name = param_00;
  var_02.println = param_01;
  level.var_13F0B.challenge_results[level.var_13F0B.challenge_results.size] = var_02;
}

inc_downed_counts() {
  inc_laststand_record("timesDowned");
}

inc_revived_counts() {
  inc_laststand_record("timesRevived");
}

inc_bleedout_counts() {
  inc_laststand_record("timesBledOut");
}

inc_laststand_record(param_00) {
  if(!isDefined(self.var_13F0B.laststand_record[param_00][level.wave_num])) {
    self.var_13F0B.laststand_record[param_00][level.wave_num] = 0;
  }

  self.var_13F0B.laststand_record[param_00][level.wave_num]++;
}

update_spending_type(param_00, param_01) {
  switch (param_01) {
    case "weapon":
      self.var_13F0B.single_value_stats["cashSpentOnWeapon"].value = self.var_13F0B.single_value_stats["cashSpentOnWeapon"].value + param_00;
      break;

    case "ability":
      self.var_13F0B.single_value_stats["cashSpentOnAbility"].value = self.var_13F0B.single_value_stats["cashSpentOnAbility"].value + param_00;
      break;

    case "trap":
      self.var_13F0B.single_value_stats["cashSpentOnTrap"].value = self.var_13F0B.single_value_stats["cashSpentOnTrap"].value + param_00;
      break;

    default:
      break;
  }
}

endgame(param_00, param_01) {
  set_game_data(param_00, param_01);
  write_global_clientmatchdata();
  log_matchdata_at_game_end();
  foreach(var_04, var_03 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var_03);
    scripts\cp\cp_persistence::increment_player_career_total_score(var_03);
    var_03 set_player_data(param_01);
    var_03 set_player_game_data();
    var_03 write_clientmatchdata_for_player(var_03, var_04);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  sendmatchdata();
  sendclientmatchdata();
}

set_player_data(param_00) {
  var_01 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_02 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_01 = var_01 + param_00 / 1000;
  var_02 = var_02 + 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var_01));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var_02));
}

set_game_data(param_00, param_01) {
  var_02 = "challengesCompleted";
  var_03 = level.var_13F0B;
  foreach(var_05 in var_03.single_value_stats) {
    var_06 = validate_value(var_05.value, var_05.value_type);
  }

  foreach(var_09 in var_03.challenge_results) {}

  setmatchdata("commonMatchData", "playerCountEnd", level.players.size);
  setmatchdata("commonMatchData", "utcEndTimeSeconds", getsystemtime());
  setmatchdata("commonMatchData", "playerCount", validate_byte(level.player_count));
  setmatchdata("commonMatchData", "playerCountLeft", validate_byte(level.player_count_left));
  setmatchdata("playerCountMaxConcurrent", validate_byte(level.max_concurrent_player_count));
}

set_player_game_data() {
  copy_from_playerdata();
  set_laststand_stats();
  set_single_value_stats();
  set_custom_stats();
}

get_player_matchdata(param_00, param_01) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][param_00])) {
    return level.matchdata["player"][self.clientid][param_00];
  }

  return param_01;
}

set_custom_stats() {
  var_00 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_01 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var_02 = self getplayerdata("cp", "progression", "playerLevel", "rank");
  var_03 = self getplayerdata("cp", "progression", "playerLevel", "prestige");
  if(isDefined(self.wave_num_when_joined)) {
    setmatchdata("players", self.clientid, "waveEnd", level.wave_num - self.wave_num_when_joined);
  } else {
    setmatchdata("players", self.clientid, "waveEnd", level.wave_num);
  }

  setmatchdata("players", self.clientid, "doorsOpened", get_player_matchdata("opening_the_doors", 0));
  setmatchdata("players", self.clientid, "moneyEarned", int(get_player_matchdata("currency_earned", 0)));
  setmatchdata("players", self.clientid, "kills", get_player_matchdata("zombie_death", 0));
  setmatchdata("players", self.clientid, "downs", get_player_matchdata("dropped_to_last_stand", 0));
  setmatchdata("players", self.clientid, "revives", get_player_matchdata("revived_another_player", 0));
  setmatchdata("players", self.clientid, "headShots", self.total_match_headshots);
  setmatchdata("players", self.clientid, "shots", self.accuracy_shots_fired);
  setmatchdata("players", self.clientid, "hits", self.accuracy_shots_on_target);
  setmatchdata("players", self.clientid, "rank", validate_byte(var_02));
  setmatchdata("players", self.clientid, "prestige", validate_byte(var_03));
  setmatchdata("players", self.clientid, "totalGameplayTime", validate_int(var_00));
  setmatchdata("players", self.clientid, "gamesPlayed", validate_int(var_01));
}

copy_from_playerdata() {}

set_laststand_stats() {}

set_single_value_stats() {}

validate_value(param_00, param_01) {
  switch (param_01) {
    case "byte":
      return validate_byte(param_00);

    case "short":
      return validate_short(param_00);

    case "int":
      return validate_int(param_00);

    default:
      break;
  }
}

validate_byte(param_00) {
  return int(min(param_00, 127));
}

validate_short(param_00) {
  return int(min(param_00, 32767));
}

validate_int(param_00) {
  return int(min(param_00, 2147483647));
}

get_single_value_struct(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.value = param_00;
  var_02.value_type = param_01;
  return var_02;
}

init_analytics(param_00) {
  var_01 = 0;
  var_02 = 1;
  var_03 = 2;
  var_04 = 1;
  var_05 = 2;
  var_06 = 3;
  var_07 = 4;
  var_08 = 5;
  var_09 = 6;
  var_0A = 1;
  var_0B = 100;
  var_0C = 101;
  var_0D = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];
  for(var_0E = var_0C; var_0E <= var_0D; var_0E++) {
    var_0F = tablelookup(param_00, var_01, var_0E, var_04);
    if(var_0F == "") {
      continue;
    }

    var_10 = tablelookup(param_00, var_01, var_0E, var_05);
    if(var_10 != "") {
      level.blackbox_data_type[var_0F] = var_10;
    }

    var_11 = tablelookup(param_00, var_01, var_0E, var_06);
    if(var_11 != "") {
      level.matchdata_data_type[var_0F] = var_11;
    }

    var_12 = tablelookup(param_00, var_01, var_0E, var_07);
    if(var_12 != "") {
      level.matchdata_struct[var_0F] = [];
      level.matchdata[var_0F] = [];
    }

    var_13 = tablelookup(param_00, var_01, var_0E, var_08);
    if(var_13 != "") {
      level.clientmatchdata_data_type[var_0F] = var_13;
    }

    var_14 = tablelookup(param_00, var_01, var_0E, var_09);
    if(var_14 != "") {
      level.clientmatchdata_struct[var_0F] = [];
      level.clientmatchdata[var_0F] = [];
    }
  }

  level.analytics_event = [];
  for(var_0E = var_0A; var_0E <= var_0B; var_0E++) {
    var_15 = tablelookup(param_00, var_01, var_0E, var_02);
    if(var_15 == "") {
      break;
    }

    var_16 = tablelookup(param_00, var_01, var_0E, var_03);
    level.analytics_event[var_15] = var_16;
    var_17 = strtok(var_16, " ");
    foreach(var_19 in var_17) {
      if(isDefined(level.matchdata_struct[var_19])) {
        level.matchdata_struct[var_19][var_15] = 0;
      }

      if(isDefined(level.clientmatchdata_struct[var_19]) && isDefined(level.clientmatchdata_data_type[var_15])) {
        level.clientmatchdata_struct[var_19][var_15] = 0;
      }
    }
  }
}

func_AF6A(param_00, param_01, param_02, param_03, param_04) {
  var_05 = get_data_to_update(param_00);
  log_matchdata(param_00, var_05, param_01, param_03);
  func_AF65(param_00, var_05, param_01, param_04);
}

log_matchdata_at_game_end() {
  foreach(var_08, var_01 in level.matchdata) {
    foreach(var_07, var_03 in var_01) {
      foreach(var_06, var_05 in var_03) {
        if(var_08 == "match") {
          setmatchdata("matchData", var_06, int(var_05));
          continue;
        }

        setmatchdata("players", int(var_07), var_06, int(var_05));
      }
    }
  }
}

func_AF60(param_00, param_01, param_02) {
  var_03 = get_bb_string(param_01);
  var_04 = "analytics_cp_";
  switch (param_02.size) {
    case 1:
      bbprint(var_04 + param_00, var_03, param_02[0]);
      break;

    case 2:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1]);
      break;

    case 3:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2]);
      break;

    case 4:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3]);
      break;

    case 5:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4]);
      break;

    case 6:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4], param_02[5]);
      break;

    case 7:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4], param_02[5], param_02[6]);
      break;

    case 8:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4], param_02[5], param_02[6], param_02[7]);
      break;

    case 9:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4], param_02[5], param_02[6], param_02[7], param_02[8]);
      break;

    case 10:
      bbprint(var_04 + param_00, var_03, param_02[0], param_02[1], param_02[2], param_02[3], param_02[4], param_02[5], param_02[6], param_02[7], param_02[8], param_02[9]);
      break;
  }
}

get_bb_string(param_00) {
  var_01 = "";
  foreach(var_04, var_03 in param_00) {
    var_01 = var_01 + var_03 + " " + level.blackbox_data_type[var_03];
    if(var_04 != param_00.size - 1) {
      var_01 = var_01 + " ";
    }
  }

  return var_01;
}

get_data_to_update(param_00) {
  var_01 = level.analytics_event[param_00];
  return strtok(var_01, " ");
}

log_matchdata(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  foreach(var_06 in param_01) {
    if(is_matchdata_struct(var_06)) {
      var_07 = param_03[var_04];
      if(!isDefined(level.matchdata[var_06][var_07])) {
        level.matchdata[var_06][var_07] = level.matchdata_struct[var_06];
      }

      level.matchdata[var_06][var_07][param_00] = level.matchdata[var_06][var_07][param_00] + param_02;
      var_04++;
    }
  }
}

func_AF65(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    return;
  }

  var_04 = 0;
  if(is_clientmatchdata_data(param_00)) {
    foreach(var_06 in param_01) {
      if(is_clientmatchdata_struct(var_06)) {
        var_07 = param_03[var_04];
        if(!isDefined(level.clientmatchdata[var_06][var_07])) {
          level.clientmatchdata[var_06][var_07] = level.clientmatchdata_struct[var_06];
        }

        level.clientmatchdata[var_06][var_07][param_00] = level.clientmatchdata[var_06][var_07][param_00] + param_02;
        var_04++;
      }
    }
  }
}

is_matchdata_struct(param_00) {
  return isDefined(level.matchdata_struct[param_00]);
}

is_clientmatchdata_struct(param_00) {
  return isDefined(level.clientmatchdata_struct[param_00]);
}

is_clientmatchdata_data(param_00) {
  return isDefined(level.clientmatchdata_data_type[param_00]);
}

write_global_clientmatchdata() {
  setclientmatchdata("waves_survived", level.wave_num);
  setclientmatchdata("time_survived", level.time_survived);
  setclientmatchdata("scoreboardPlayerCount", level.players.size);
  setclientmatchdata("map", level.script);
  if(isDefined(level.write_global_clientmatchdata_func)) {
    [[level.write_global_clientmatchdata_func]]();
  }
}

write_clientmatchdata_for_player(param_00, param_01) {
  setclientmatchdata("player", param_01, "username", param_00.name);
  setclientmatchdata("player", param_01, "rank", param_00 scripts\cp\cp_persistence::get_player_rank());
  if(!isDefined(param_00.player_character_index)) {
    return;
  }

  setclientmatchdata("player", param_01, "characterIndex", param_00.player_character_index);
  var_02 = level.clientmatchdata["player"][param_00.clientid];
  if(isDefined(var_02)) {
    foreach(var_05, var_04 in var_02) {
      setclientmatchdata("player", param_01, var_05, int(var_04));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](param_00, param_01);
  }
}