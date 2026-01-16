/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_endmission.gsc
********************************/

main() {
  var_0 = [];
  var_0 = createmission("DEEP_AND_HARD");
  var_0 addlevel("killhouse", 0, "EARN_A_WINGED_DAGGER", 1, undefined, undefined);
  var_0 addlevel("cargoship", 0, "MAKE_THE_JUMP", 1, "THE_PACKAGE", undefined);
  var_0 addlevel("coup", 0, undefined, 1, undefined, undefined);
  var_0 addlevel("blackout", 0, "DANCING_IN_THE_DARK", 1, "THE_RESCUE", undefined);
  var_0 addlevel("armada", 0, undefined, 1, "THE_SEARCH", undefined);
  var_0 addlevel("bog_a", 0, "SAVE_THE_BACON", 1, "THE_BOG", undefined);
  var_0 addlevel("hunted", 0, undefined, 1, "THE_ESCAPE", undefined);
  var_0 addlevel("ac130", 0, "DEATH_FROM_ABOVE", 1, "THE_ESCAPE", undefined);
  var_0 addlevel("bog_b", 0, undefined, 1, "THE_BOG", undefined);
  var_0 addlevel("airlift", 0, undefined, 1, "THE_FIRST_HORSEMAN", undefined);
  var_0 addlevel("aftermath", 0, undefined, 1, undefined, undefined);
  var_0 addlevel("village_assault", 0, "WRONG_NUMBER", 1, "THE_SECOND_HORSEMAN", undefined);
  var_0 addlevel("scoutsniper", 1, undefined, 1, "THE_SHOT", undefined);
  var_0 addlevel("sniperescape", 0, "PIGGYBACK_RIDE", 1, "THE_SHOT", undefined);
  var_0 addlevel("village_defend", 0, undefined, 1, "THE_THIRD_HORSEMAN", undefined);
  var_0 addlevel("ambush", 0, "DESPERATE_MEASURES", 1, "THE_THIRD_HORSEMAN", undefined);
  var_0 addlevel("icbm", 1, undefined, 1, "THE_ULTIMATUM", undefined);
  var_0 addlevel("launchfacility_a", 1, undefined, 1, "THE_ULTIMATUM", undefined);
  var_0 addlevel("launchfacility_b", 1, undefined, 1, "THE_ULTIMATUM", undefined);
  var_0 addlevel("jeepride", 0, undefined, 1, "THE_FOURTH_HORSEMAN", undefined);
  var_0 addlevel("airplane", 0, undefined, 1, "MILE_HIGH_CLUB", undefined);

  if(isdefined(level.endmission_main_func)) {
    [
      [level.endmission_main_func]
    ]();
    level.endmission_main_func = undefined;
  }

  precachestring(&"campaign_completed_popup");
  level.missionsettings = var_0;
}

debug_test_next_mission() {
  wait 10;

  while (getdvarint("test_next_mission") < 1)
    wait 3;

  _nextmission();
}

_setmissiondvar(var_0, var_1) {
  if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated")) {
    return;
  }
  if(getdvar("mis_cheat") == "1")
    return;
}

_nextmission() {
  level notify("achievements_level_complete");
  level.nextmission = 1;
  level.player enableinvulnerability();

  if(maps\_utility::arcademode()) {
    level.arcademode_success = 1;
    thread maps\_arcademode::arcademode_ends();
    common_scripts\utility::flag_wait("arcademode_ending_complete");
  }

  var_0 = undefined;
  setsaveddvar("ui_nextMission", "1");
  setdvar("ui_showPopup", "0");
  setdvar("ui_popupString", "");
  game["previous_map"] = level.script;
  maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);
  var_0 = level.missionsettings getlevelindex(level.script);

  if(!isdefined(var_0)) {
    return;
  }
  if(level.script != "jeepride" && level.script != "airplane") {
    thread maps\_hud_util::fade_out(1, undefined);
    soundscripts\_snd::snd_message("end_mission_fade_to_black");
    wait 2;
    maps\_utility::level_end_save();
  }

  var_1 = level.missionsettings isallmisioncompleted();
  level.missionsettings setlevelcompleted(var_0);
  updategamerprofile();

  if(level.missionsettings hasachievement(var_0))
    maps\_utility::giveachievement_wrapper(level.missionsettings getachievement(var_0));

  if(level.missionsettings haslevelveteranaward(var_0) && getlevelcompleted(var_0) == 4 && level.missionsettings check_other_haslevelveteranachievement(var_0))
    maps\_utility::giveachievement_wrapper(level.missionsettings getlevelveteranaward(var_0));

  if(level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2)
    maps\_utility::giveachievement_wrapper(level.missionsettings gethardenedaward());

  level.missionsettings checkcampaigncompleted();
  var_2 = level.missionsettings.levels.size;

  if(level.script == "airplane") {
    if(getdvarint("arcademode_full")) {
      level.player luiopenmenu(&"AIRPLANE_CAMPAIGN_COMPLETED");
      level.player waittill("menuresponse");
    }

    setsaveddvar("ui_nextMission", "0");
    changelevel("");
    return;
  } else {
    if(var_1 != level.missionsettings isallmisioncompleted()) {
      level.player luiopenmenu(&"campaign_completed_popup");
      level.player waittill("menuresponse", var_3, var_4);

      if(var_4 == "quit") {
        setsaveddvar("ui_nextMission", "0");
        changelevel("");
        return;
      }
    }

    var_2 = var_0 + 1;
  }

  if(getdvarint("limited_mode")) {
    setsaveddvar("ui_nextMission", "0");
    changelevel("");
  } else {
    if(maps\_utility::arcademode()) {
      if(!getdvarint("arcademode_full")) {
        setsaveddvar("ui_nextMission", "0");
        changelevel("");
        return;
      }

      if(level.script == "cargoship") {
        changelevel("blackout", level.missionsettings getkeepweapons(var_0));
        return;
      } else if(level.script == "airlift") {
        changelevel("village_assault", level.missionsettings getkeepweapons(var_0));
        return;
      } else if(level.script == "jeepride") {
        changelevel("airplane", level.missionsettings getkeepweapons(var_0));
        return;
      }
    }

    if(level.script == "jeepride") {
      setdvar("credits_load", "1");
      changelevel("simplecredits", level.missionsettings getkeepweapons(var_0));
      return;
    }

    if(level.missionsettings skipssuccess(var_0)) {
      changelevel(level.missionsettings getlevelname(var_2), level.missionsettings getkeepweapons(var_0));
      return;
    }

    missionsuccess(level.missionsettings getlevelname(var_2), level.missionsettings getkeepweapons(var_0));
  }
}

updatesppercent() {
  var_0 = int(gettotalpercentcompletesp() * 100);

  if(getdvarint("mis_cheat") == 0)
    level.player setlocalplayerprofiledata("percentCompleteSP", var_0);

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

  for (var_5 = 0; var_5 < level.missionsettings.levels.size; var_5++) {
    if(int(var_1[var_5]) >= var_0)
      var_2++;
  }

  var_6 = var_2 / level.missionsettings.levels.size * 100;
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
  var_3 = level.gameskill;

  if(level.script == "killhouse" || level.script == "coup" || level.script == "aftermath")
    var_3 = 3;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_4 != var_0) {
      var_2 = var_2 + var_1[var_4];
      continue;
    }

    if(var_3 + 1 > int(var_1[var_0])) {
      var_2 = var_2 + (var_3 + 1);
      continue;
    }

    var_2 = var_2 + var_1[var_4];
  }

  var_5 = 0;

  for (var_6 = 0; var_6 < var_2.size; var_6++) {
    if(int(var_2[var_6]) > 0)
      var_5 = var_6;
  }

  _sethighestmissionifnotcheating(var_5);
  _setmissiondiffstringifnotcheating(var_2);
}

_sethighestmissionifnotcheating(var_0) {
  if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated")) {
    return;
  }
  if(getdvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("highestMission", var_0);
}

_setmissiondiffstringifnotcheating(var_0) {
  if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated")) {
    return;
  }
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
  if(var_0 < 9)
    return "mis_0" + (var_0 + 1);
  else
    return "mis_" + (var_0 + 1);
}

getlowestskill() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = 4;

  for (var_2 = 0; var_2 < self.levels.size; var_2++) {
    if(int(var_0[var_2]) < var_1)
      var_1 = int(var_0[var_2]);
  }

  return var_1;
}

isallmisioncompleted() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");

  for (var_1 = 0; var_1 < self.levels.size; var_1++) {
    if(int(var_0[var_1]) == 0)
      return 0;
  }

  return 1;
}

checkcampaigncompleted() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = 1;
  var_2 = 1;

  for (var_3 = 0; var_3 < self.levels.size - 1; var_3++) {
    if(int(var_0[var_3]) == 0)
      var_1 = 0;

    if(int(var_0[var_3]) < 3)
      var_2 = 0;
  }

  if(var_1)
    maps\_utility::giveachievement_wrapper("CAMPAIGN_COMPLETE");

  if(var_2)
    maps\_utility::giveachievement_wrapper("DEEP_AND_HARD");
}

createmission(var_0) {
  var_1 = spawnstruct();
  var_1.levels = [];
  var_1.prereqs = [];
  var_1.hardenedaward = var_0;
  return var_1;
}

addlevel(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self.levels.size;
  self.levels[var_7] = spawnstruct();
  self.levels[var_7].name = var_0;
  self.levels[var_7].keepweapons = var_1;
  self.levels[var_7].achievement = var_2;
  self.levels[var_7].skipssuccess = var_3;
  self.levels[var_7].veteran_achievement = var_4;

  if(isdefined(var_5))
    self.levels[var_7].fade_time = var_5;
}

addprereq(var_0) {
  var_1 = self.prereqs.size;
  self.prereqs[var_1] = var_0;
}

getlevelindex(var_0) {
  foreach(var_3, var_2 in self.levels) {
    if(var_2.name == var_0)
      return var_3;
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
  if(!isdefined(self.levels[var_0].fade_time))
    return undefined;

  return self.levels[var_0].fade_time;
}

haslevelveteranaward(var_0) {
  if(isdefined(self.levels[var_0].veteran_achievement))
    return 1;
  else
    return 0;
}

hasachievement(var_0) {
  if(isdefined(self.levels[var_0].achievement))
    return 1;
  else
    return 0;
}

check_other_haslevelveteranachievement(var_0) {
  for (var_1 = 0; var_1 < self.levels.size; var_1++) {
    if(var_1 == var_0) {
      continue;
    }
    if(!haslevelveteranaward(var_1)) {
      continue;
    }
    if(self.levels[var_1].veteran_achievement == self.levels[var_0].veteran_achievement) {
      if(getlevelcompleted(var_1) < 4)
        return 0;
    }
  }

  return 1;
}

skipssuccess(var_0) {
  if(!isdefined(self.levels[var_0].skipssuccess))
    return 0;

  return self.levels[var_0].skipssuccess;
}

gethardenedaward() {
  return self.hardenedaward;
}

hasmissionhardenedaward() {
  if(isdefined(self.hardenedaward))
    return 1;
  else
    return 0;
}

getnextlevelindex() {
  for (var_0 = 0; var_0 < self.levels.size; var_0++) {
    if(!getlevelskill(var_0))
      return var_0;
  }

  return 0;
}

force_all_complete() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = "";

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
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

end_mission_fade_audio_and_video(var_0) {
  if(!isdefined(var_0) || var_0 == 0) {
    return;
  }
  soundscripts\_snd::snd_message("finish_mission_fade", var_0);
  var_1 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_1.sort = 100;
  var_1 fadeovertime(var_0);
  var_1.alpha = 1;
  wait(var_0);
}