/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\endmission.gsc
***********************************************/

main() {
  var_0 = createmission();
  level.missionsettings = var_0;
  level.lowestgameskill = getdvarint("TTMRSTRO");
  var_1 = undefined;
  addlevel("proxywar", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("piccadilly", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("safehouse", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("safehouse_finale", 0, var_1, 1, var_1, 10, 100, var_1, ["safehouse_finale_intro_tr"], 0);
  addlevel("townhoused", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 1);
  addlevel("marines", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("embassy", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("highway", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("hometown", 0, var_1, 1, var_1, 0, var_1, var_1, ["hometown_buried_tr"], 0);
  addlevel("tunnels", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("captive", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("stpetersburg", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("estate", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);
  addlevel("lab", 0, var_1, 1, var_1, 10, 100, var_1, var_1, 0);

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
  }
}

debug_test_next_mission() {
  wait 10;

  while(getdvarint("test_next_mission") < 1)
    wait 3;

  nextmission_internal();
}

nextmission_preload_internal(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "full";

  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = level.missionsettings getlevelindex(level.script);
  var_3 = var_2 + 1;
  var_4 = level.missionsettings.levels[var_3].preload_transients;

  if(var_1)
    level thread scripts\engine\sp\utility::nextmission_primeloadbink();

  if(getdvarint("fastload", 1)) {
    var_5 = level.missionsettings getlevelname(var_3);

    switch (var_0) {
      case "full":
        if(isDefined(var_4)) {
          var_6 = scripts\engine\utility::array_add(var_4, var_5);
          preloadzones(var_6);
        } else
          preloadzones(var_5);

        break;
      case "root":
        preloadzones(var_5);
        break;
      case "transients":
        if(isDefined(var_4))
          preloadzones(var_4);

        break;
    }

    while(!ispreloadzonescomplete())
      waitframe();
  }

  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

nextmission_primeloadbink_internal() {
  if(!isDefined(getlevelindex(level.script)) || !isDefined(getlevelindex(level.script) + 1)) {
    return;
  }
  if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed"))
    scripts\engine\utility::flag_init("nextmission_transition_bink_primed");

  var_0 = getlevelindex(level.script) + 1;
  var_1 = getlevelbink(var_0);
  setsaveddvar("LNSNKKLPLL", "0");
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  stopcinematicingame();
  waitframe();

  if(!isDefined(var_1))
    var_1 = "default";

  cinematicingame(var_1, 1, 1, 1, 0, 0, 1);

  while(!iscinematicplaying())
    waitframe();

  scripts\engine\utility::flag_set("nextmission_transition_bink_primed");
}

createmission() {
  var_0 = spawnStruct();
  var_0.levels = [];
  var_0.prereqs = [];
  return var_0;
}

getrestartlevel(var_0) {
  if(!isDefined(level.missionsettings))
    return undefined;

  var_1 = getlevelindex(var_0);

  if(isDefined(level.missionsettings.levels[var_1].restartlevel))
    return level.missionsettings.levels[var_1].restartlevel;
}

level_settle_time_get(var_0) {
  var_1 = getlevelindex(var_0);

  if(!isDefined(var_1))
    return 0;
  else
    return level.missionsettings.levels[var_1].settletime;
}

client_settle_time_get(var_0) {
  var_1 = getlevelindex(var_0);

  if(!isDefined(var_1))
    return 0;
  else
    return level.missionsettings.levels[var_1].clientsettletime;
}

level_settle_time_wait(var_0) {
  if(!isDefined(var_0))
    var_0 = level.script;

  var_1 = level_settle_time_get(var_0);
  var_2 = client_settle_time_get(var_0);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;
  else
    var_2 = var_2 * 0.02;

  var_3 = var_1 + var_2;

  if(isDefined(var_3))
    wait(var_3 * 0.05);

  if(isDefined(var_2) && var_2 <= 0)
    waitframe();
  else if(!isDefined(var_1) || var_1 <= 0)
    waitframe();
}

nextmission_internal(var_0) {
  if(scripts\sp\utility::is_demo()) {
    if(isDefined(level.nextmission_exit_time))
      changelevel("", 0, level.nextmission_exit_time);
    else
      changelevel("", 0);
  } else {
    level notify("nextmission");
    level.nextmission = 1;
    level.player enableinvulnerability();
    var_1 = undefined;
    setDvar("ui_showPopup", "0");
    setDvar("ui_popupString", "");
    setDvar("ui_prev_map", level.script);
    game["previous_map"] = undefined;
    var_1 = getlevelindex(level.script);

    if(!isDefined(var_1)) {
      missionsuccess(level.script);
      return;
    }

    if(level.script != "lab")
      scripts\engine\sp\utility::level_end_save();

    setlevelcompleted(var_1);
    collateraldamageassessment(level.script);
    var_2 = updatesppercent();
    updategamerprofile();

    if(level.missionsettings hasachievement(var_1))
      scripts\sp\utility::giveachievement_wrapper(level.missionsettings getachievement(var_1));

    if(level.missionsettings haslevelveteranaward(var_1) && getlevelcompleted(var_1) == 4 && level.missionsettings check_other_haslevelveteranachievement(var_1))
      scripts\sp\utility::giveachievement_wrapper(level.missionsettings getlevelveteranaward(var_1));

    if(level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2)
      scripts\sp\utility::giveachievement_wrapper(level.missionsettings gethardenedaward());

    scripts\sp\analytics::start_point_update("mission_end", 1);

    if(level.script == "lab") {
      changelevel("", 0);
      return;
    }

    var_3 = var_1 + 1;
    var_4 = getlevelbink(var_3);

    if(isDefined(var_4) && !istrue(level.endmission_bink_skip)) {
      setDvar("last_transition_movie", var_4);

      if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed"))
        scripts\engine\utility::flag_init("nextmission_transition_bink_primed");

      if(!isDefined(var_0))
        setomnvar("ui_hide_hud", 1);

      if(!level.player islinked()) {
        var_5 = level.player scripts\engine\utility::spawn_tag_origin();
        level.player playerlinktoabsolute(var_5);
      }

      level.player freezecontrols(1);

      if(scripts\engine\utility::flag("nextmission_transition_bink_primed")) {
        setsaveddvar("LNSNKKLPLL", "0");
        setsaveddvar("MMRNLMPPLT", "1");
        setsaveddvar("RKMNLRNS", "1");
        pausecinematicingame(0);
      } else {
        setsaveddvar("LNSNKKLPLL", "0");
        setsaveddvar("MMRNLMPPLT", "1");
        setsaveddvar("RKMNLRNS", "1");
        cinematicingame(var_4, 0, 1, 1, 0, 0, 1);
      }
    }

    if(isDefined(var_0)) {
      wait(var_0);
      setomnvar("ui_hide_hud", 1);
    }

    scripts\sp\analytics::analytics_lui_mission_end_dlog();

    if(level.missionsettings getlevelstreamsync(var_3))
      setstreamsynconnextlevel();

    if(isDefined(level.missionsettings getfadetime(var_1))) {
      changelevel(level.missionsettings getlevelname(var_3), level.missionsettings getkeepweapons(var_1), level.missionsettings getfadetime(var_1));
      return;
    }

    changelevel(level.missionsettings getlevelname(var_3), level.missionsettings getkeepweapons(var_1));
  }
}

collateraldamageassessment(var_0) {
  var_1 = getcollateraldamagegrade();
  level.player setplayerprogression("civiliansKilledGrade", var_0, var_1);
  var_2 = level.player getplayerprogression("civiliansKilledGradeBest", var_0);

  if(var_1 > var_2)
    level.player setplayerprogression("civiliansKilledGradeBest", var_0, var_1);
}

getcollateraldamagegrade() {
  var_0 = 4;
  var_1 = int(min(level.friendlyfire["civilians_killed"], var_0));
  var_1 = var_0 - var_1;
  return int(var_1);
}

updatesppercent() {
  var_0 = int(gettotalpercentcompletesp() * 100);

  if(getdvarint("MSSSNONPLS") == 0)
    level.player setlocalplayerprofiledata("percentCompleteSP", var_0);

  return var_0;
}

addlevel(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.missionsettings.levels.size;
  level.missionsettings.levels[var_10] = spawnStruct();
  level.missionsettings.levels[var_10].name = var_0;
  level.missionsettings.levels[var_10].keepweapons = var_1;
  level.missionsettings.levels[var_10].achievement = var_2;
  level.missionsettings.levels[var_10].completion = var_3;
  level.missionsettings.levels[var_10].postloadbink = var_4;
  level.missionsettings.levels[var_10].settletime = var_5;
  level.missionsettings.levels[var_10].clientsettletime = var_6;
  level.missionsettings.levels[var_10].restartlevel = var_7;
  level.missionsettings.levels[var_10].preload_transients = var_8;
  level.missionsettings.levels[var_10].streamsync = var_9;
  level.missionsettings.levels[var_10].fade_time = 0;
  var_11 = tablelookup("sp/levels.csv", 1, var_0, 3);

  if(var_11 != "")
    level.missionsettings.levels[var_10].bink = var_11;
}

addprereq(var_0) {
  var_1 = level.missionsettings.prereqs.size;
  level.missionsettings.prereqs[var_1] = var_0;
}

getlevelindex(var_0) {
  if(!isDefined(level.missionsettings) || !isDefined(level.missionsettings.levels))
    return undefined;

  foreach(var_3, var_2 in level.missionsettings.levels) {
    if(var_2.name == var_0)
      return var_3;
  }

  return undefined;
}

getlevelbink(var_0) {
  var_1 = undefined;

  if(var_0 < level.missionsettings.levels.size)
    var_1 = level.missionsettings.levels[var_0].bink;

  return var_1;
}

getpostloadbink(var_0) {
  var_1 = getlevelindex(var_0);

  if(isDefined(var_1)) {
    if(isDefined(level.missionsettings.levels[var_1].postloadbink))
      return level.missionsettings.levels[var_1].postloadbink;
  }

  return "none";
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

getlevelstreamsync(var_0) {
  return self.levels[var_0].streamsync;
}

setfadetime(var_0, var_1) {
  level.missionsettings.levels[var_0].fade_time = var_1;
}

getfadetime(var_0) {
  if(!isDefined(self.levels[var_0].fade_time))
    return undefined;

  return self.levels[var_0].fade_time;
}

haslevelveteranaward(var_0) {
  if(isDefined(self.levels[var_0].veteran_achievement))
    return 1;
  else
    return 0;
}

hasachievement(var_0) {
  if(isDefined(self.levels[var_0].achievement))
    return 1;
  else
    return 0;
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
      if(getlevelcompleted(var_1) < 4)
        return 0;
    }
  }

  return 1;
}

gethardenedaward() {
  return self.hardenedaward;
}

hasmissionhardenedaward() {
  if(isDefined(self.hardenedaward))
    return 1;
  else
    return 0;
}

gettotalpercentcompletesp() {
  var_0 = max(getstat_progression(1), getstat_progression(2));
  var_1 = 0.5;
  var_2 = getstat_progression(3);
  var_3 = 0.25;
  var_4 = getstat_progression(4);
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
    if(int(var_1[var_5]) >= var_0)
      var_2++;
  }

  var_6 = var_2 / (level.missionsettings.levels.size - 1) * 100;
  return var_6;
}

getstat_intel() {
  return level.player getlocalplayerprofiledata("cheatPoints") / 45 * 100;
}

getlevelcompleted(var_0) {
  return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[var_0]);
}

setlevelcompleted(var_0) {
  levelprogressioncomplete(var_0);
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_2 = "";

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_3 != var_0) {
      var_2 = var_2 + var_1[var_3];
      continue;
    }

    if(level.lowestgameskill + 1 > int(var_1[var_0])) {
      var_2 = var_2 + (level.lowestgameskill + 1);
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

  mission_diffstring_ifnotcheating_set(var_4);
}

levelprogressioncomplete(var_0) {
  var_1 = level.missionsettings.levels[var_0].name;
  level.player setplayerprogression("missionStateData", var_1, "complete");
  var_0++;

  if(level.missionsettings.levels.size > var_0) {
    var_2 = level.missionsettings.levels[var_0].name;
    scripts\sp\autosave::startsavedprogression(var_2);
  }
}

highestmission_ifnotcheating_set(var_0) {
  if(getDvar("MSSSNONPLS") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("highestMission", var_0);
}

mission_diffstring_ifnotcheating_set(var_0) {
  if(getDvar("MSSSNONPLS") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("missionHighestDifficulty", var_0);
  var_1 = 1;

  for(var_2 = 0; var_2 < 14; var_2++) {
    if(var_0[var_2] != "4" && var_0[var_2] != "5") {
      var_1 = undefined;
      break;
    }
  }

  if(istrue(var_1))
    level thread scripts\sp\utility::giveachievement_wrapper("vetfinish", 1);
}

getlevelskill(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  return int(var_1[var_0]);
}

getlowestskill() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = 4;

  for(var_2 = 0; var_2 < self.levels.size; var_2++) {
    if(int(var_0[var_2]) < var_1)
      var_1 = int(var_0[var_2]);
  }

  return var_1;
}

getnextlevelindex() {
  for(var_0 = 0; var_0 < self.levels.size; var_0++) {
    if(!getlevelskill(var_0))
      return var_0;
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