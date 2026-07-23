/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\181.gsc
**************************************/

main() {
  var_0 = [];
  var_0 = createmission("THE_BEST_OF_THE_BEST");
  var_0 addlevel("sp_intro", 0, "BACK_IN_THE_FIGHT", 1, "THE_BIG_APPLE", 0.1);
  var_0 addlevel("sp_ny_manhattan", 0, "TOO_BIG_TO_FAIL", 1, "THE_BIG_APPLE", undefined);
  var_0 addlevel("sp_ny_harbor", 0, "WET_WORK", 1, "THE_BIG_APPLE", undefined);
  var_0 addlevel("sp_intro", 0, "CARPE_DIEM", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 addlevel("hijack", 0, "FREQUENT_FLIER", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 addlevel("sp_warlord", 0, "UP_TO_NO_GOOD", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 addlevel("london", 1, undefined, 1, "EUROPEAN_VACATION", 1);
  var_0 addlevel("innocent", 0, "ONE_WAY_TICKET", 1, "EUROPEAN_VACATION", 0.1);
  var_0 addlevel("hamburg", 0, "WELCOME_TO_WW3", 1, "EUROPEAN_VACATION", undefined);
  var_0 addlevel("sp_payback", 0, "SANDSTORM", 1, "EUROPEAN_VACATION", undefined);
  var_0 addlevel("sp_paris_a", 1, undefined, 1, "CITY_OF_LIGHTS", undefined);
  var_0 addlevel("sp_paris_b", 0, "BACK_SEAT_DRIVER", 1, "CITY_OF_LIGHTS", undefined);
  var_0 addlevel("paris_ac130", 0, "WELL_ALWAYS_HAVE_PARIS", 1, "CITY_OF_LIGHTS", undefined);
  var_0 addlevel("sp_prague", 0, "VIVE_LA_REVOLUTION", 1, "THE_DARKEST_HOUR", undefined);
  var_0 addlevel("prague_escape", 0, "REQUIEM", 1, "THE_DARKEST_HOUR", undefined);
  var_0 addlevel("castle", 0, "STORM_THE_CASTLE", 1, "THE_DARKEST_HOUR", undefined);
  var_0 addlevel("sp_berlin", 0, "BAD_FIRST_DATE", 1, "THIS_IS_THE_END", undefined);
  var_0 addlevel("rescue_2", 0, "DIAMOND_IN_THE_ROUGH", 1, "THIS_IS_THE_END", undefined);
  var_0 addlevel("sp_dubai", 0, "WHO_DARES_WINS", 1, "THIS_IS_THE_END", undefined);

  if(maps\_utility::is_specialop()) {
    level.specopsgroups = [];

    for(var_1 = 0; var_1 < 100; var_1++) {
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        setupsogroup(var_2);
        continue;
      }

      break;
    }

    var_3 = createmission("SPECIAL_OPS");
    var_4 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));

    for(var_1 = 100; var_1 < 200; var_1++) {
      var_5 = var_1 - 100;
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        var_3 addspecoplevel(var_2, var_5);
        continue;
      }

      break;
    }

    for(var_1 = 200; var_1 < 300; var_1++) {
      var_5 = var_1 - 200 + var_4;
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        var_3 addspecoplevel(var_2, var_5);
        continue;
      }

      break;
    }

    level.specopssettings = var_3;
  }

  level.missionsettings = var_0;
}

debug_test_next_mission() {
  wait 10;

  while(getdvarint("test_next_mission") < 1) {
    wait 3;
  }
  _nextmission();
}

setupsogroup(var_0) {
  level.specopsgroups[var_0] = spawnStruct();
  level.specopsgroups[var_0].ref = var_0;
  level.specopsgroups[var_0].unlock = int(tablelookup("sp/specopstable.csv", 1, var_0, 5));
}

_nextmission() {
  if(maps\_utility::is_demo()) {
    setsaveddvar("ui_nextMission", "0");

    if(isDefined(level.nextmission_exit_time)) {
      changelevel("", 0, level.nextmission_exit_time);
    } else {
      changelevel("", 0);
    }
  } else {
    level notify("nextmission");
    level.nextmission = 1;
    level.player enableinvulnerability();
    var_0 = undefined;
    setsaveddvar("ui_nextMission", "1");
    setDvar("ui_showPopup", "0");
    setDvar("ui_popupString", "");
    setDvar("ui_prev_map", level.script);

    if(level.script == "london") {
      game["previous_map"] = "london";
    } else {
      game["previous_map"] = undefined;
    }
    var_0 = level.missionsettings getlevelindex(level.script);

    if(level.script == "sp_intro" && !getdvarint("prologue_select")) {
      for(var_1 = var_0 + 1; var_1 < level.missionsettings.levels.size - 1; var_1++) {
        if(level.missionsettings.levels[var_1].name == "sp_intro") {
          var_0 = var_1;
          break;
        }
      }
    }

    setDvar("prologue_select", "0");
    maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);

    if(!isDefined(var_0)) {
      missionsuccess(level.script);
      return;
    }

    if(level.script != "sp_dubai") {
      maps\_utility::level_end_save();
    }
    level.missionsettings setlevelcompleted(var_0);

    if(level.player getlocalplayerprofiledata("highestMission") < var_0 + 1 && level.script == "sp_dubai" && getdvarint("mis_cheat") == 0) {
      setDvar("ui_sp_unlock", "0");
      setDvar("ui_sp_unlock", "1");
    }

    var_2 = updatesppercent();
    updategamerprofile();

    if(level.missionsettings hasachievement(var_0)) {
      maps\_utility::giveachievement_wrapper(level.missionsettings getachievement(var_0));
    }
    if(level.missionsettings haslevelveteranaward(var_0) && getlevelcompleted(var_0) == 4 && level.missionsettings check_other_haslevelveteranachievement(var_0)) {
      maps\_utility::giveachievement_wrapper(level.missionsettings getlevelveteranaward(var_0));
    }
    if(level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2) {
      maps\_utility::giveachievement_wrapper(level.missionsettings gethardenedaward());
    }
    if(level.script == "sp_dubai") {
      return;
    }
    var_3 = var_0 + 1;

    if(maps\_utility::arcademode()) {
      if(!getdvarint("arcademode_full")) {
        setsaveddvar("ui_nextMission", "0");
        missionsuccess(level.script);
        return;
      }
    }

    if(level.missionsettings skipssuccess(var_0)) {
      if(isDefined(level.missionsettings getfadetime(var_0))) {
        changelevel(level.missionsettings getlevelname(var_3), level.missionsettings getkeepweapons(var_0), level.missionsettings getfadetime(var_0));
        return;
      }

      changelevel(level.missionsettings getlevelname(var_3), level.missionsettings getkeepweapons(var_0));
      return;
      return;
    }

    missionsuccess(level.missionsettings getlevelname(var_3), level.missionsettings getkeepweapons(var_0));
  }
}

updatesppercent() {
  var_0 = int(gettotalpercentcompletesp() * 100);

  if(getdvarint("mis_cheat") == 0) {
    level.player setlocalplayerprofiledata("percentCompleteSP", var_0);
  }
  return var_0;
}

gettotalpercentcompletesp() {
  var_0 = max(getstat_easy(), getstat_regular());
  var_1 = 0.5;
  var_2 = getstat_hardened();
  var_3 = 0.25;
  var_4 = getstat_veteran();
  var_5 = 0.1;
  var_6 = getstat_intel();
  var_7 = 0.15;
  var_8 = 0.0;
  var_8 = var_8 + var_1 * var_0;
  var_8 = var_8 + var_3 * var_2;
  var_8 = var_8 + var_5 * var_4;
  var_8 = var_8 + var_7 * var_6;
  return var_8;
}

getstat_progression(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < level.missionsettings.levels.size - 1; var_5++) {
    if(int(var_1[var_5]) >= var_0) {
      var_2++;
    }
  }

  var_6 = var_2 / (level.missionsettings.levels.size - 1) * 100;
  return var_6;
}

getstat_easy() {
  var_0 = 1;
  return getstat_progression(var_0);
}

getstat_regular() {
  var_0 = 2;
  return getstat_progression(var_0);
}

getstat_hardened() {
  var_0 = 3;
  return getstat_progression(var_0);
}

getstat_veteran() {
  var_0 = 4;
  return getstat_progression(var_0);
}

getstat_intel() {
  var_0 = 45;
  var_1 = level.player getlocalplayerprofiledata("cheatPoints") / var_0 * 100;
  return var_1;
}

getlevelcompleted(var_0) {
  return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[var_0]);
}

getsolevelcompleted(var_0) {
  return int(level.player getlocalplayerprofiledata("missionSOHighestDifficulty")[var_0]);
}

setsolevelcompleted(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.eog_noreward) && var_2.eog_noreward) {
      continue;
    }
    var_3 = var_2 getlocalplayerprofiledata("missionSOHighestDifficulty");

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_2.award_no_stars)) {
      continue;
    }
    var_4 = 0;

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4 = var_4 + max(0, int(var_3[var_5]) - 1);
    }
    if(var_3.size == 0) {
      var_3 = "00000000000000000000000000000000000000000000000000";
    }
    while(var_0 >= var_3.size) {
      var_3 = var_3 + "0";
    }
    var_6 = 0;

    if(maps\_utility::is_survival()) {
      var_6 = 0;
    } else {
      var_6 = level.specops_reward_gameskill;

      if(isDefined(var_2.forcedgameskill)) {
        var_6 = var_2.forcedgameskill;
      }
    }

    if(int(var_3[var_0]) > var_6) {
      continue;
    }
    var_7 = "";

    for(var_8 = 0; var_8 < var_3.size; var_8++) {
      if(var_8 != var_0) {
        var_7 = var_7 + var_3[var_8];
        continue;
      }

      var_7 = var_7 + (var_6 + 1);
    }

    var_9 = 0;

    for(var_5 = 0; var_5 < var_7.size; var_5++) {
      var_9 = var_9 + max(0, int(var_7[var_5]) - 1);
    }
    var_10 = var_9 - var_4;

    if(var_10 > 0) {
      var_2.eog_firststar = is_first_difficulty_star(var_7);
      var_2.eog_newstar = 1;
      var_2.eog_newstar_value = var_10;

      foreach(var_12 in level.specopsgroups) {
        if(var_12.unlock == 0) {
          continue;
        }
        if(level.ps3 && issplitscreen() && isDefined(level.player2) && var_2 == level.player2) {
          continue;
        }
        if(var_4 < var_12.unlock && var_9 >= var_12.unlock) {
          var_2.eog_unlock = 1;
          var_2.eog_unlock_value = var_12.ref;
        }
      }

      if(var_9 >= 48) {
        var_2.eog_unlock = 1;
        var_2.eog_unlock_value = "so_completed";
        maps\_utility::music_stop(1);
      }
    }

    if(var_2 maps\_specialops_code::can_save_to_profile() || issplitscreen() && level.ps3 && isDefined(level.player2) && var_2 == level.player2) {
      var_2 setlocalplayerprofiledata("missionSOHighestDifficulty", var_7);
    }
  }
}

is_first_difficulty_star(var_0) {
  if(!maps\_utility::is_survival()) {
    if(int(tablelookup("sp/specOpsTable.csv", 1, level.script, 14)) == 0) {
      return 0;
    }
  }

  var_1 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));
  var_2 = int(tablelookup("sp/specopstable.csv", 0, "mission_count", 1));
  var_3 = var_1 + var_2;
  var_4 = 0;

  if(maps\_utility::is_survival()) {
    for(var_5 = 0; var_5 < var_1; var_5++) {
      var_4 = var_4 + int(max(0, int(var_0[var_5]) - 1));
    }
  } else {
    for(var_5 = var_1; var_5 < var_3; var_5++) {
      var_4 = var_4 + int(max(0, int(var_0[var_5]) - 1));
    }
  }

  return var_4 == 1;
}

setlevelcompleted(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_2 = "";

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_3 != var_0) {
      var_2 = var_2 + var_1[var_3];
      continue;
    }

    if(level.gameskill + 1 > int(var_1[var_0])) {
      var_2 = var_2 + (level.gameskill + 1);
      continue;
    }

    var_2 = var_2 + var_1[var_3];
  }

  var_4 = "";
  var_5 = 0;
  var_6 = 0;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    if(int(var_2[var_7]) == 0 || var_5) {
      var_4 = var_4 + "0";
      var_5 = 1;
      continue;
    }

    var_4 = var_4 + var_2[var_7];
    var_6++;
  }

  _sethighestmissionifnotcheating(var_6);
  _setmissiondiffstringifnotcheating(var_4);
}

_sethighestmissionifnotcheating(var_0) {
  if(getDvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("highestMission", var_0);
}

_setmissiondiffstringifnotcheating(var_0) {
  if(getDvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("missionHighestDifficulty", var_0);
}

getlevelskill(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  return int(var_1[var_0]);
}

getmissiondvarstring(var_0) {
  if(var_0 < 9) {
    return "mis_0" + (var_0 + 1);
  } else {
    return "mis_" + (var_0 + 1);
  }
}

getlowestskill() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = 4;

  for(var_2 = 0; var_2 < self.levels.size; var_2++) {
    if(int(var_0[var_2]) < var_1) {
      var_1 = int(var_0[var_2]);
    }
  }

  return var_1;
}

createmission(var_0) {
  var_1 = spawnStruct();
  var_1.levels = [];
  var_1.prereqs = [];
  var_1.hardenedaward = var_0;
  return var_1;
}

addlevel(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self.levels.size;
  self.levels[var_7] = spawnStruct();
  self.levels[var_7].name = var_0;
  self.levels[var_7].keepweapons = var_1;
  self.levels[var_7].achievement = var_2;
  self.levels[var_7].skipssuccess = var_3;
  self.levels[var_7].veteran_achievement = var_4;

  if(isDefined(var_5)) {
    self.levels[var_7].fade_time = var_5;
  }
}

addspecoplevel(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self.levels.size;
  }
  self.levels[var_2] = spawnStruct();
  self.levels[var_2].name = var_0;
  var_3 = tablelookup("sp/specopstable.csv", 1, var_0, 13);

  if(var_3 == "") {
    return;
  }
  if(!isDefined(level.specopsgroups[var_3].group_members)) {
    level.specopsgroups[var_3].group_members = [];
  }
  var_4 = level.specopsgroups[var_3].group_members.size;
  level.specopsgroups[var_3].group_members[var_4] = var_0;
}

addprereq(var_0) {
  var_1 = self.prereqs.size;
  self.prereqs[var_1] = var_0;
}

getlevelindex(var_0) {
  foreach(var_3, var_2 in self.levels) {
    if(var_2.name == var_0) {
      return var_3;
    }
  }

  return undefined;
}

getlevelname(var_0) {
  return self.levels[var_0].name;
}

getkeepweapons(var_0) {
  return self.levels[var_0].keepweapons;
}

getachievement(var_0) {
  return self.levels[var_0].achievement;
}

getlevelveteranaward(var_0) {
  return self.levels[var_0].veteran_achievement;
}

getfadetime(var_0) {
  if(!isDefined(self.levels[var_0].fade_time)) {
    return undefined;
  }
  return self.levels[var_0].fade_time;
}

haslevelveteranaward(var_0) {
  if(isDefined(self.levels[var_0].veteran_achievement)) {
    return 1;
  } else {
    return 0;
  }
}

hasachievement(var_0) {
  if(isDefined(self.levels[var_0].achievement)) {
    return 1;
  } else {
    return 0;
  }
}

check_other_haslevelveteranachievement(var_0) {
  for(var_1 = 0; var_1 < self.levels.size; var_1++) {
    if(var_1 == var_0) {
      continue;
    }
    if(!haslevelveteranaward(var_1)) {
      continue;
    }
    if(self.levels[var_1].veteran_achievement == self.levels[var_0].veteran_achievement) {
      if(getlevelcompleted(var_1) < 4) {
        return 0;
      }
    }
  }

  return 1;
}

skipssuccess(var_0) {
  if(!isDefined(self.levels[var_0].skipssuccess)) {
    return 0;
  }
  return 1;
}

gethardenedaward() {
  return self.hardenedaward;
}

hasmissionhardenedaward() {
  if(isDefined(self.hardenedaward)) {
    return 1;
  } else {
    return 0;
  }
}

getnextlevelindex() {
  for(var_0 = 0; var_0 < self.levels.size; var_0++) {
    if(!getlevelskill(var_0)) {
      return var_0;
    }
  }

  return 0;
}

force_all_complete() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 < 20) {
      var_1 = var_1 + 2;
      continue;
    }

    var_1 = var_1 + 0;
  }

  level.player setlocalplayerprofiledata("missionHighestDifficulty", var_1);
  level.player setlocalplayerprofiledata("highestMission", 20);
}

clearall() {
  level.player setlocalplayerprofiledata("missionHighestDifficulty", "00000000000000000000000000000000000000000000000000");
  level.player setlocalplayerprofiledata("highestMission", 1);
}

credits_end() {
  changelevel("airplane", 0);
}

so_eog_summary_calculate(var_0) {
  if(!isDefined(self.so_eog_summary_data)) {
    self.so_eog_summary_data = [];
  }
  if(!isDefined(level.challenge_start_time)) {
    level.challenge_start_time = 0;
    level.challenge_end_time = 0;
  }

  var_1 = min(level.challenge_end_time - level.challenge_start_time, 86400000);
  var_1 = maps\_utility::round_millisec_on_sec(var_1, 1, 0);

  foreach(var_3 in level.players) {
    var_3.so_eog_summary_data["time"] = var_1;
    var_3.so_eog_summary_data["name"] = var_3.playername;
    var_3.so_eog_summary_data["difficulty"] = var_3 maps\_utility::get_player_gameskill();

    if(isDefined(var_3.forcedgameskill)) {
      var_3.so_eog_summary_data["difficulty"] = var_3.forcedgameskill;
    }
  }

  level.session_score = 0;

  if(maps\_utility::is_survival()) {
    foreach(var_3 in level.players) {
      var_3.so_eog_summary_data["score"] = [[level.so_survival_score_func]]();
      var_3.so_eog_summary_data["wave"] = [[level.so_survival_wave_func]]();
      var_3.so_eog_summary_data["kills"] = var_3.game_performance["kill"];
    }

    level.session_score = [[level.so_survival_score_func]]();
  } else {
    var_7 = 300000;

    if(isDefined(level.so_mission_worst_time)) {
      var_7 = level.so_mission_worst_time;
    }
    var_8 = 0;

    if(var_1 < var_7) {
      var_8 = int((var_7 - var_1) / var_7 * 10000);
    }
    level.session_score = int(level.specops_reward_gameskill * 10000) + var_8;

    foreach(var_3 in level.players) {
      var_3.so_eog_summary_data["kills"] = var_3.stats["kills"];
      var_3.so_eog_summary_data["score"] = level.session_score;
    }
  }

  if(!isDefined(level.custom_eog_no_defaults) || !level.custom_eog_no_defaults) {
    foreach(var_3 in level.players) {
      if(maps\_utility::is_coop()) {
        var_3.eog_line = 4;
        continue;
      }

      var_3.eog_line = 3;
    }
  }

  if(isDefined(level.eog_summary_callback)) {
    [[level.eog_summary_callback]]();
  }
  if(var_0) {
    common_scripts\utility::flag_set("special_op_final_xp_given");

    foreach(var_3 in level.players) {
      var_14 = calculate_xp(var_3.so_eog_summary_data["score"]);
      var_15 = 0;

      if(isDefined(level.never_played) && level.never_played) {
        var_3 thread maps\_utility::givexp("completion_xp");
        var_15 = maps\_rank::getscoreinfovalue("completion_xp");
      } else {
        var_16 = undefined;
        var_17 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

        if(isDefined(var_17) && var_17 != "") {
          var_16 = var_3 getlocalplayerprofiledata(var_17);
        }
        if(isDefined(var_16) && var_16 == 0 && !maps\_utility::is_survival()) {
          var_3 thread maps\_utility::givexp("completion_xp");
          var_15 = maps\_rank::getscoreinfovalue("completion_xp");
        }
      }

      if(!maps\_utility::is_survival()) {
        var_18 = var_15 + var_14;

        if(var_3.summary["rankxp"] < level.maxxp) {
          if(var_15 != 0) {
            var_3 thread maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_XP_COMPLETION_FRIST_TIME", "^8+" + var_15, "@SPECIAL_OPS_UI_XP_COMPLETION", "^8+" + var_18);
          } else {
            var_3 thread maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_XP_COMPLETION", "", "^8+" + var_18);
          }
        }

        var_3 thread maps\_utility::givexp("final_score_xp", var_14);
      }
    }
  }

  if(!isDefined(level.custom_eog_no_defaults) || !level.custom_eog_no_defaults) {
    add_eog_default_stats();
  }
}

calculate_xp(var_0) {
  return int(var_0 / 10);
}

so_eog_summary_display() {
  if(isDefined(level.eog_summary_delay) && level.eog_summary_delay > 0) {
    wait(level.eog_summary_delay);
  }
  thread maps\_ambient::use_eq_settings("specialop_fadeout", level.eq_mix_track);
  thread maps\_ambient::blend_to_eq_track(level.eq_mix_track, 10);
  reset_eog_popup_dvars();

  if(isDefined(level.player.eog_firststar) && level.player.eog_firststar) {
    setDvar("ui_first_star_player1", level.player.eog_firststar);
  }
  if(isDefined(level.player.eog_newstar) && level.player.eog_newstar) {
    setDvar("ui_eog_player1_stars", level.player.eog_newstar_value);
  }
  if(isDefined(level.player.eog_unlock) && level.player.eog_unlock) {
    setDvar("ui_eog_player1_unlock", level.player.eog_unlock_value);
  }
  if(isDefined(level.player.eog_bestscore) && level.player.eog_bestscore) {
    setDvar("ui_eog_player1_bestscore", level.player.eog_bestscore_value);
  }
  if(maps\_utility::is_coop()) {
    if(isDefined(level.player.eog_noreward) && level.player.eog_noreward) {
      setDvar("ui_eog_player1_noreward", level.player.eog_noreward);
    }
    if(isDefined(level.player2.eog_firststar) && level.player2.eog_firststar) {
      setDvar("ui_first_star_player2", level.player2.eog_firststar);
    }
    if(isDefined(level.player2.eog_newstar) && level.player2.eog_newstar) {
      setDvar("ui_eog_player2_stars", level.player2.eog_newstar_value);
    }
    if(isDefined(level.player2.eog_unlock) && level.player2.eog_unlock) {
      setDvar("ui_eog_player2_unlock", level.player2.eog_unlock_value);
    }
    if(isDefined(level.player2.eog_noreward) && level.player2.eog_noreward) {
      setDvar("ui_eog_player2_noreward", level.player2.eog_noreward);
    }
    if(isDefined(level.player2.eog_bestscore) && level.player2.eog_bestscore) {
      setDvar("ui_eog_player2_bestscore", level.player2.eog_bestscore_value);
    }
    wait 0.05;
    level.player openpopupmenu("coop_eog_summary");
    level.player2 openpopupmenu("coop_eog_summary2");
  } else {
    wait 0.05;
    level.player openpopupmenu("sp_eog_summary");
  }
}

reset_eog_popup_dvars() {
  setDvar("ui_eog_player1_stars", "");
  setDvar("ui_eog_player1_unlock", "");
  setDvar("ui_eog_player1_besttime", "");
  setDvar("ui_eog_player1_bestscore", "");
  setDvar("ui_eog_player1_noreward", "");
  setDvar("ui_eog_player2_stars", "");
  setDvar("ui_eog_player2_unlock", "");
  setDvar("ui_eog_player2_besttime", "");
  setDvar("ui_eog_player2_bestscore", "");
  setDvar("ui_eog_player2_noreward", "");
}

add_eog_default_stats() {
  foreach(var_1 in level.players) {
    var_1 so_eog_default_playerlabel();
    var_1 so_eog_default_kills();
    var_1 so_eog_default_time();
    var_1 so_eog_default_difficulty();

    if(!level.missionfailed) {
      var_1 so_eog_default_score();
    }
  }
}

so_eog_default_playerlabel() {
  if(maps\_utility::is_coop()) {
    maps\_utility::add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER", undefined, 1);
  }
}

so_eog_default_kills() {
  var_0 = self.so_eog_summary_data["kills"];

  if(maps\_utility::is_coop()) {
    var_1 = maps\_utility::get_other_player(self).so_eog_summary_data["kills"];
    maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_0, var_1, undefined, 2);
  } else {
    maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_0, undefined, undefined, 1);
  }
}

so_eog_default_difficulty() {
  var_0[0] = "@MENU_RECRUIT";
  var_0[1] = "@MENU_REGULAR";
  var_0[2] = "@MENU_HARDENED";
  var_0[3] = "@MENU_VETERAN";
  var_1 = maps\_utility::get_player_gameskill();
  maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_1, undefined, undefined, 2 + int(maps\_utility::is_coop()));
}

so_eog_default_time() {
  var_0 = self.so_eog_summary_data["time"] * 0.001;
  var_1 = maps\_utility::convert_to_time_string(var_0, 1);
  maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_1, undefined, undefined, 3 + int(maps\_utility::is_coop()));
}

so_eog_default_score() {
  if(maps\_utility::is_coop()) {
    var_0 = "@SPECIAL_OPS_UI_TEAM_SCORE";
  } else {
    var_0 = "@SPECIAL_OPS_UI_SCORE";
  }
  var_1 = self.so_eog_summary_data["score"];
  maps\_utility::add_custom_eog_summary_line(var_0, var_1);
}