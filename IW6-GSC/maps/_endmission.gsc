/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_endmission.gsc
*****************************************************/

main() {
  var_0 = [];
  var_0 = createmission();
  var_0 addlevel("prologue", 0, "LEVEL_1", 1, "EXTRA2", undefined);
  var_0 addlevel("deer_hunt", 0, "LEVEL_2", 1, "EXTRA2", undefined);
  var_0 addlevel("nml", 0, "LEVEL_3", 1, "EXTRA2", undefined);
  var_0 addlevel("enemyhq", 0, "LEVEL_4", 1, "EXTRA2", undefined);
  var_0 addlevel("homecoming", 0, "LEVEL_5", 1, "EXTRA2", undefined);
  var_0 addlevel("flood", 0, "LEVEL_6", 1, "EXTRA2", undefined);
  var_0 addlevel("cornered", 0, "LEVEL_7", 1, "EXTRA2", undefined);
  var_0 addlevel("oilrocks", 0, "LEVEL_8", 1, "EXTRA2", undefined);
  var_0 addlevel("jungle_ghosts", 0, "LEVEL_9", 1, "EXTRA2", undefined);
  var_0 addlevel("clockwork", 0, "LEVEL_10", 1, "EXTRA2", undefined);
  var_0 addlevel("black_ice", 0, "LEVEL_11", 1, "EXTRA2", undefined);
  var_0 addlevel("ship_graveyard", 0, "LEVEL_12", 1, "EXTRA2", undefined);
  var_0 addlevel("factory", 0, "LEVEL_13", 1, "EXTRA2", undefined);
  var_0 addlevel("las_vegas", 0, "LEVEL_14", 1, "EXTRA2", undefined);
  var_0 addlevel("carrier", 0, "LEVEL_15", 1, "EXTRA2", undefined);
  var_0 addlevel("satfarm", 1, undefined, 1, "EXTRA2", undefined);
  var_0 addlevel("satfarm_b", 0, "LEVEL_16", 1, "EXTRA2", undefined);
  var_0 addlevel("loki", 0, "LEVEL_17", 1, "EXTRA2", undefined);
  var_0 addlevel("skyway", 0, "LEVEL_18", 1, "EXTRA2", undefined);

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
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
    setdvar("ui_showPopup", "0");
    setdvar("ui_popupString", "");
    setdvar("ui_prev_map", level.script);

    if(level.script == "prologue") {
      level.player setlocalplayerprofiledata("unlockedAliens", 1);
    }

    game["previous_map"] = undefined;
    var_0 = level.missionsettings getlevelindex(level.script);

    if(level.script == "sp_intro" && !getdvarint("prologue_select")) {
      for(var_1 = var_0 + 1; var_1 < level.missionsettings.levels.size - 1; var_1++) {
        if(level.missionsettings.levels[var_1].name == "sp_intro") {
          var_0 = var_1;
          break;
        }
      }
    }

    setdvar("prologue_select", "0");
    maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);

    if(!isDefined(var_0)) {
      missionsuccess(level.script);
      return;
    }

    if(level.script != "skyway") {
      maps\_utility::level_end_save();
    }

    level.missionsettings setlevelcompleted(var_0);
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

    if(level.script == "skyway") {
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
  if(getdvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("highestMission", var_0);
}

_setmissiondiffstringifnotcheating(var_0) {
  if(getdvar("mis_cheat") == "1") {
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