/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2635.gsc
***************************************/

start_game_type(var_00, var_01, var_02) {
  init(var_02);
  init_matchdata(var_00, var_01);
}

init_matchdata(var_00, var_01) {
  setmatchdatadef(var_00);
  setclientmatchdatadef(var_01);
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

init(var_00) {
  var_01 = spawnStruct();
  var_02 = [];
  var_1.single_value_stats = var_02;
  var_03 = [];
  var_1.challenge_results = var_03;
  level.func_13F0B = var_01;
  init_analytics(var_00);
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

on_player_disconnect(var_00) {
  setmatchdata("players", self.clientid, "disconnectReason", var_00);
  setmatchdata("players", self.clientid, "quit", var_00 == "EXE_DISCONNECTED");
  set_custom_stats();
  level.player_count_left = level.player_count_left + 1;
}

player_init() {
  var_00 = spawnStruct();
  var_01 = [];
  var_1["cashSpentOnWeapon"] = get_single_value_struct(0, "int");
  var_1["cashSpentOnAbility"] = get_single_value_struct(0, "int");
  var_1["cashSpentOnTrap"] = get_single_value_struct(0, "int");
  var_0.single_value_stats = var_01;
  var_02 = [];
  var_2["timesDowned"] = [];
  var_2["timesRevived"] = [];
  var_2["timesBledOut"] = [];
  var_0.laststand_record = var_02;
  self.func_13F0B = var_00;
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

update_challenges_status(var_00, var_01) {
  if(level.func_13F0B.challenge_results.size > 25) {
    return;
  }
  var_02 = spawnStruct();
  var_2.challenge_name = var_00;
  var_2.result = var_01;
  level.func_13F0B.challenge_results[level.func_13F0B.challenge_results.size] = var_02;
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

inc_laststand_record(var_00) {
  if(!isDefined(self.func_13F0B.laststand_record[var_00][level.wave_num])) {
    self.func_13F0B.laststand_record[var_00][level.wave_num] = 0;
  }

  self.func_13F0B.laststand_record[var_00][level.wave_num]++;
}

update_spending_type(var_00, var_01) {
  switch (var_01) {
    case "weapon":
      self.func_13F0B.single_value_stats["cashSpentOnWeapon"].value = self.func_13F0B.single_value_stats["cashSpentOnWeapon"].value + var_00;
      break;
    case "ability":
      self.func_13F0B.single_value_stats["cashSpentOnAbility"].value = self.func_13F0B.single_value_stats["cashSpentOnAbility"].value + var_00;
      break;
    case "trap":
      self.func_13F0B.single_value_stats["cashSpentOnTrap"].value = self.func_13F0B.single_value_stats["cashSpentOnTrap"].value + var_00;
      break;
    default:
      break;
  }
}

endgame(var_00, var_01) {
  set_game_data(var_00, var_01);
  write_global_clientmatchdata();
  log_matchdata_at_game_end();

  foreach(var_04, var_03 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var_03);
    scripts\cp\cp_persistence::increment_player_career_total_score(var_03);
    var_03 set_player_data(var_01);
    var_03 set_player_game_data();
    var_03 write_clientmatchdata_for_player(var_03, var_04);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  sendmatchdata();
  sendclientmatchdata();
}

set_player_data(var_00) {
  var_01 = self getrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_02 = self getrankedplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_01 = var_01 + var_00 / 1000;
  var_02 = var_02 + 1;
  self setrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var_01));
  self setrankedplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var_02));
}

set_game_data(var_00, var_01) {
  var_02 = "challengesCompleted";
  var_03 = level.func_13F0B;

  foreach(var_07, var_05 in var_3.single_value_stats) {
  var_06 = validate_value(var_5.value, var_5.value_type);
  }

  foreach(var_10, var_09 in var_3.challenge_results) {}

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

get_player_matchdata(var_00, var_01) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][var_00])) {
    return level.matchdata["player"][self.clientid][var_00];
  }

  return var_01;
}

set_custom_stats() {
  var_00 = self getrankedplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_01 = self getrankedplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var_02 = self getrankedplayerdata("cp", "progression", "playerLevel", "rank");
  var_03 = self getrankedplayerdata("cp", "progression", "playerLevel", "prestige");

  if(isDefined(self.wave_num_when_joined)) {
    setmatchdata("players", self.clientid, "waveEnd", level.wave_num - self.wave_num_when_joined);
  }
  else {
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

validate_value(var_00, var_01) {
  switch (var_01) {
    case "byte":
      return validate_byte(var_00);
    case "short":
      return validate_short(var_00);
    case "int":
      return validate_int(var_00);
    default:
  }
}

validate_byte(var_00) {
  return int(min(var_00, 127));
}

validate_short(var_00) {
  return int(min(var_00, 32767));
}

validate_int(var_00) {
  return int(min(var_00, 2147483647));
}

get_single_value_struct(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.value = var_00;
  var_2.value_type = var_01;
  return var_02;
}

init_analytics(var_00) {
  var_01 = 0;
  var_02 = 1;
  var_03 = 2;
  var_04 = 1;
  var_05 = 2;
  var_06 = 3;
  var_07 = 4;
  var_08 = 5;
  var_09 = 6;
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
    var_15 = tablelookup(var_00, var_01, var_14, var_04);

    if(var_15 == "") {
      continue;
    }
    var_16 = tablelookup(var_00, var_01, var_14, var_05);

    if(var_16 != "") {
      level.blackbox_data_type[var_15] = var_16;
    }

    var_17 = tablelookup(var_00, var_01, var_14, var_06);

    if(var_17 != "") {
      level.matchdata_data_type[var_15] = var_17;
    }

    var_18 = tablelookup(var_00, var_01, var_14, var_07);

    if(var_18 != "") {
      level.matchdata_struct[var_15] = [];
      level.matchdata[var_15] = [];
    }

    var_19 = tablelookup(var_00, var_01, var_14, var_08);

    if(var_19 != "") {
      level.clientmatchdata_data_type[var_15] = var_19;
    }

    var_20 = tablelookup(var_00, var_01, var_14, var_09);

    if(var_20 != "") {
      level.clientmatchdata_struct[var_15] = [];
      level.clientmatchdata[var_15] = [];
    }
  }

  level.analytics_event = [];

  for(var_14 = var_10; var_14 <= var_11; var_14++) {
    var_21 = tablelookup(var_00, var_01, var_14, var_02);

    if(var_21 == "") {
      break;
    }
    var_22 = tablelookup(var_00, var_01, var_14, var_03);
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

func_AF6A(var_00, var_01, var_02, var_03, var_04) {
  var_05 = get_data_to_update(var_00);
  func_AF60(var_00, var_05, var_02);
  log_matchdata(var_00, var_05, var_01, var_03);
  func_AF65(var_00, var_05, var_01, var_04);
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

func_AF60(var_00, var_01, var_02) {
  var_03 = get_bb_string(var_01);
  var_04 = "analytics_cp_";

  switch (var_2.size) {
    case 1:
      bbprint(var_04 + var_00, var_03, var_2[0]);
      break;
    case 2:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1]);
      break;
    case 3:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    case 9:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7], var_2[8]);
      break;
    case 10:
      bbprint(var_04 + var_00, var_03, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7], var_2[8], var_2[9]);
      break;
  }
}

get_bb_string(var_00) {
  var_01 = "";

  foreach(var_04, var_03 in var_00) {
    var_01 = var_01 + (var_03 + " " + level.blackbox_data_type[var_03]);

    if(var_04 != var_0.size - 1) {
      var_01 = var_01 + " ";
    }
  }

  return var_01;
}

get_data_to_update(var_00) {
  var_01 = level.analytics_event[var_00];
  return strtok(var_01, " ");
}

log_matchdata(var_00, var_01, var_02, var_03) {
  var_04 = 0;

  foreach(var_06 in var_01) {
    if(is_matchdata_struct(var_06)) {
      var_07 = var_3[var_04];

      if(!isDefined(level.matchdata[var_06][var_07])) {
        level.matchdata[var_06][var_07] = level.matchdata_struct[var_06];
      }

      level.matchdata[var_06][var_07][var_00] = level.matchdata[var_06][var_07][var_00] + var_02;
      var_4++;
    }
  }
}

func_AF65(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03)) {
    return;
  }
  var_04 = 0;

  if(is_clientmatchdata_data(var_00)) {
    foreach(var_06 in var_01) {
      if(is_clientmatchdata_struct(var_06)) {
        var_07 = var_3[var_04];

        if(!isDefined(level.clientmatchdata[var_06][var_07])) {
          level.clientmatchdata[var_06][var_07] = level.clientmatchdata_struct[var_06];
        }

        level.clientmatchdata[var_06][var_07][var_00] = level.clientmatchdata[var_06][var_07][var_00] + var_02;
        var_4++;
      }
    }
  }
}

is_matchdata_struct(var_00) {
  return isDefined(level.matchdata_struct[var_00]);
}

is_clientmatchdata_struct(var_00) {
  return isDefined(level.clientmatchdata_struct[var_00]);
}

is_clientmatchdata_data(var_00) {
  return isDefined(level.clientmatchdata_data_type[var_00]);
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

write_clientmatchdata_for_player(var_00, var_01) {
  setclientmatchdata("player", var_01, "username", var_0.name);
  setclientmatchdata("player", var_01, "rank", var_00 scripts\cp\cp_persistence::get_player_rank());

  if(!isDefined(var_0.player_character_index)) {
    return;
  }
  setclientmatchdata("player", var_01, "characterIndex", var_0.player_character_index);
  var_02 = level.clientmatchdata["player"][var_0.clientid];

  if(isDefined(var_02)) {
    foreach(var_05, var_04 in var_02) {
    setclientmatchdata("player", var_01, var_05, int(var_04));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](var_00, var_01);
  }
}