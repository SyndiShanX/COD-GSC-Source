/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2635.gsc
**************************************/

start_game_type(var_0, var_1, var_2) {
  init(var_2);
  init_matchdata(var_0, var_1);
}

init_matchdata(var_0, var_1) {
  setmatchdatadef(var_0);
  setclientmatchdatadef(var_1);
  setmatchdata("commonMatchData", "map", level.script);
  setmatchdata("commonMatchData", "gametype", getDvar("ui_gametype"));
  setmatchdata("commonMatchData", "buildVersion", getbuildversion());
  setmatchdata("commonMatchData", "buildNumber", getbuildnumber());
  setmatchdata("commonMatchData", "utcStartTimeSeconds", getsystemtime());
  setmatchdata("commonMatchData", "isPrivateMatch", getdvarint("xblive_privatematch"));
  setmatchdata("commonMatchData", "isRankedMatch", 1);
  setmatchdataid();
  level thread wait_set_initial_player_count();
}

init(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  var_1.single_value_stats = var_2;
  var_3 = [];
  var_1.challenge_results = var_3;
  level.var_13F0B = var_1;
  init_analytics(var_0);
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

on_player_disconnect(var_0) {
  setmatchdata("players", self.clientid, "disconnectReason", var_0);
  setmatchdata("players", self.clientid, "quit", var_0 == "EXE_DISCONNECTED");
  set_custom_stats();
  level.player_count_left = level.player_count_left + 1;
}

player_init() {
  var_0 = spawnStruct();
  var_1 = [];
  var_1["cashSpentOnWeapon"] = get_single_value_struct(0, "int");
  var_1["cashSpentOnAbility"] = get_single_value_struct(0, "int");
  var_1["cashSpentOnTrap"] = get_single_value_struct(0, "int");
  var_0.single_value_stats = var_1;
  var_2 = [];
  var_2["timesDowned"] = [];
  var_2["timesRevived"] = [];
  var_2["timesBledOut"] = [];
  var_0.laststand_record = var_2;
  self.var_13F0B = var_0;
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

update_challenges_status(var_0, var_1) {
  if(level.var_13F0B.challenge_results.size > 25) {
    return;
  }
  var_2 = spawnStruct();
  var_2.challenge_name = var_0;
  var_2.result = var_1;
  level.var_13F0B.challenge_results[level.var_13F0B.challenge_results.size] = var_2;
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

inc_laststand_record(var_0) {
  if(!isDefined(self.var_13F0B.laststand_record[var_0][level.wave_num])) {
    self.var_13F0B.laststand_record[var_0][level.wave_num] = 0;
  }

  self.var_13F0B.laststand_record[var_0][level.wave_num]++;
}

update_spending_type(var_0, var_1) {
  switch (var_1) {
    case "weapon":
      self.var_13F0B.single_value_stats["cashSpentOnWeapon"].value = self.var_13F0B.single_value_stats["cashSpentOnWeapon"].value + var_0;
      break;
    case "ability":
      self.var_13F0B.single_value_stats["cashSpentOnAbility"].value = self.var_13F0B.single_value_stats["cashSpentOnAbility"].value + var_0;
      break;
    case "trap":
      self.var_13F0B.single_value_stats["cashSpentOnTrap"].value = self.var_13F0B.single_value_stats["cashSpentOnTrap"].value + var_0;
      break;
    default:
      break;
  }
}

endgame(var_0, var_1) {
  set_game_data(var_0, var_1);
  write_global_clientmatchdata();
  log_matchdata_at_game_end();

  foreach(var_4, var_3 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var_3);
    scripts\cp\cp_persistence::increment_player_career_total_score(var_3);
    var_3 set_player_data(var_1);
    var_3 set_player_game_data();
    var_3 write_clientmatchdata_for_player(var_3, var_4);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  sendmatchdata();
  sendclientmatchdata();
}

set_player_data(var_0) {
  var_1 = self getrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_2 = self getrankedplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 = var_1 + var_0 / 1000;
  var_2 = var_2 + 1;
  self setrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var_1));
  self setrankedplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var_2));
}

set_game_data(var_0, var_1) {
  var_2 = "challengesCompleted";
  var_3 = level.var_13F0B;

  foreach(var_7, var_5 in var_3.single_value_stats) {
    var_6 = validate_value(var_5.value, var_5.value_type);
  }

  foreach(var_10, var_9 in var_3.challenge_results) {}

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

get_player_matchdata(var_0, var_1) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][var_0])) {
    return level.matchdata["player"][self.clientid][var_0];
  }

  return var_1;
}

set_custom_stats() {
  var_0 = self getrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_1 = self getrankedplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var_2 = self getrankedplayerdata("cp", "progression", "playerLevel", "rank");
  var_3 = self getrankedplayerdata("cp", "progression", "playerLevel", "prestige");

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
  setmatchdata("players", self.clientid, "rank", validate_byte(var_2));
  setmatchdata("players", self.clientid, "prestige", validate_byte(var_3));
  setmatchdata("players", self.clientid, "totalGameplayTime", validate_int(var_0));
  setmatchdata("players", self.clientid, "gamesPlayed", validate_int(var_1));
}

copy_from_playerdata() {}

set_laststand_stats() {}

set_single_value_stats() {}

validate_value(var_0, var_1) {
  switch (var_1) {
    case "byte":
      return validate_byte(var_0);
    case "short":
      return validate_short(var_0);
    case "int":
      return validate_int(var_0);
    default:
  }
}

validate_byte(var_0) {
  return int(min(var_0, 127));
}

validate_short(var_0) {
  return int(min(var_0, 32767));
}

validate_int(var_0) {
  return int(min(var_0, 2147483647));
}

get_single_value_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.value = var_0;
  var_2.value_type = var_1;
  return var_2;
}

init_analytics(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 1;
  var_5 = 2;
  var_6 = 3;
  var_7 = 4;
  var_8 = 5;
  var_9 = 6;
  var_10 = 1;
  var_11 = 100;
  var_12 = 101;
  var_13 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(var_14 = var_12; var_14 <= var_13; var_14++) {
    var_15 = tablelookup(var_0, var_1, var_14, var_4);

    if(var_15 == "") {
      continue;
    }
    var_16 = tablelookup(var_0, var_1, var_14, var_5);

    if(var_16 != "") {
      level.blackbox_data_type[var_15] = var_16;
    }

    var_17 = tablelookup(var_0, var_1, var_14, var_6);

    if(var_17 != "") {
      level.matchdata_data_type[var_15] = var_17;
    }

    var_18 = tablelookup(var_0, var_1, var_14, var_7);

    if(var_18 != "") {
      level.matchdata_struct[var_15] = [];
      level.matchdata[var_15] = [];
    }

    var_19 = tablelookup(var_0, var_1, var_14, var_8);

    if(var_19 != "") {
      level.clientmatchdata_data_type[var_15] = var_19;
    }

    var_20 = tablelookup(var_0, var_1, var_14, var_9);

    if(var_20 != "") {
      level.clientmatchdata_struct[var_15] = [];
      level.clientmatchdata[var_15] = [];
    }
  }

  level.analytics_event = [];

  for(var_14 = var_10; var_14 <= var_11; var_14++) {
    var_21 = tablelookup(var_0, var_1, var_14, var_2);

    if(var_21 == "") {
      break;
    }
    var_22 = tablelookup(var_0, var_1, var_14, var_3);
    level.analytics_event[var_21] = var_22;
    var_23 = strtok(var_22, " ");

    foreach(var_25 in var_23) {
      if(isDefined(level.matchdata_struct[var_25])) {
        level.matchdata_struct[var_25][var_21] = 0;
      }

      if(isDefined(level.clientmatchdata_struct[var_25]) && isDefined(level.clientmatchdata_data_type[var_21])) {
        level.clientmatchdata_struct[var_25][var_21] = 0;
      }
    }
  }
}

func_AF6A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_data_to_update(var_0);
  func_AF60(var_0, var_5, var_2);
  log_matchdata(var_0, var_5, var_1, var_3);
  func_AF65(var_0, var_5, var_1, var_4);
}

log_matchdata_at_game_end() {
  foreach(var_8, var_1 in level.matchdata) {
    foreach(var_7, var_3 in var_1) {
      foreach(var_6, var_5 in var_3) {
        if(var_8 == "match") {
          setmatchdata("matchData", var_6, int(var_5));
          continue;
        }

        setmatchdata("players", int(var_7), var_6, int(var_5));
      }
    }
  }
}

func_AF60(var_0, var_1, var_2) {
  var_3 = get_bb_string(var_1);
  var_4 = "analytics_cp_";

  switch (var_2.size) {
    case 1:
      bbprint(var_4 + var_0, var_3, var_2[0]);
      break;
    case 2:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1]);
      break;
    case 3:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    case 9:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7], var_2[8]);
      break;
    case 10:
      bbprint(var_4 + var_0, var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7], var_2[8], var_2[9]);
      break;
  }
}

get_bb_string(var_0) {
  var_1 = "";

  foreach(var_4, var_3 in var_0) {
    var_1 = var_1 + (var_3 + " " + level.blackbox_data_type[var_3]);

    if(var_4 != var_0.size - 1) {
      var_1 = var_1 + " ";
    }
  }

  return var_1;
}

get_data_to_update(var_0) {
  var_1 = level.analytics_event[var_0];
  return strtok(var_1, " ");
}

log_matchdata(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(is_matchdata_struct(var_6)) {
      var_7 = var_3[var_4];

      if(!isDefined(level.matchdata[var_6][var_7])) {
        level.matchdata[var_6][var_7] = level.matchdata_struct[var_6];
      }

      level.matchdata[var_6][var_7][var_0] = level.matchdata[var_6][var_7][var_0] + var_2;
      var_4++;
    }
  }
}

func_AF65(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = 0;

  if(is_clientmatchdata_data(var_0)) {
    foreach(var_6 in var_1) {
      if(is_clientmatchdata_struct(var_6)) {
        var_7 = var_3[var_4];

        if(!isDefined(level.clientmatchdata[var_6][var_7])) {
          level.clientmatchdata[var_6][var_7] = level.clientmatchdata_struct[var_6];
        }

        level.clientmatchdata[var_6][var_7][var_0] = level.clientmatchdata[var_6][var_7][var_0] + var_2;
        var_4++;
      }
    }
  }
}

is_matchdata_struct(var_0) {
  return isDefined(level.matchdata_struct[var_0]);
}

is_clientmatchdata_struct(var_0) {
  return isDefined(level.clientmatchdata_struct[var_0]);
}

is_clientmatchdata_data(var_0) {
  return isDefined(level.clientmatchdata_data_type[var_0]);
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

write_clientmatchdata_for_player(var_0, var_1) {
  setclientmatchdata("player", var_1, "username", var_0.name);
  setclientmatchdata("player", var_1, "rank", var_0 scripts\cp\cp_persistence::get_player_rank());

  if(!isDefined(var_0.player_character_index)) {
    return;
  }
  setclientmatchdata("player", var_1, "characterIndex", var_0.player_character_index);
  var_2 = level.clientmatchdata["player"][var_0.clientid];

  if(isDefined(var_2)) {
    foreach(var_5, var_4 in var_2) {
      setclientmatchdata("player", var_1, var_5, int(var_4));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](var_0, var_1);
  }
}