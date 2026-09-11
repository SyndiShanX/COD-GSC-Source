/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\endmission.gsc
***********************************************/

function main() {
  var0 = createmission();
  level.missionsettings = var0;
  level.lowestgameskill = getdvarint("TTMRSTRO");
  var1 = undefined;
  addlevel("proxywar", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("piccadilly", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("safehouse", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("safehouse_finale", 0, var1, 1, var1, 10, 100, var1, ["safehouse_finale_intro_tr"], 0);
  addlevel("townhoused", 0, var1, 1, var1, 10, 100, var1, var1, 1);
  addlevel("marines", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("embassy", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("highway", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("hometown", 0, var1, 1, var1, 0, var1, var1, ["hometown_buried_tr"], 0);
  addlevel("tunnels", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("captive", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("stpetersburg", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("estate", 0, var1, 1, var1, 10, 100, var1, var1, 0);
  addlevel("lab", 0, var1, 1, var1, 10, 100, var1, var1, 0);

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
    return;
  }
}

function debug_test_next_mission() {
  wait 10;

  while(getdvarint("test_next_mission") < 1) {
    wait 3;
  }

  nextmission_internal();
}

function nextmission_preload_internal(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "full";
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = getlevelindex(level.missionsettings, level.script);
  var3 = var2 + 1;
  var4 = level.missionsettings.levels[var3].preload_transients;

  if(var1) {
    level thread scripts\engine\sp\utility::nextmission_primeloadbink();
  }

  if(getdvarint("fastload", 1)) {
    var5 = getlevelname(level.missionsettings, var3);

    switch (var0) {
      case "full":
        if(isDefined(var4)) {
          var6 = scripts\engine\utility::array_add(var4, var5);
          preloadzones(var6);
        } else {
          preloadzones(var5);
        }

        break;
      case "root":
        preloadzones(var5);
        break;
      case "transients":
        if(isDefined(var4)) {
          preloadzones(var4);
        }

        break;
    }

    while(!ispreloadzonescomplete()) {
      waitframe();
    }
  }

  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

function nextmission_primeloadbink_internal() {
  if(!isDefined(getlevelindex(level.script)) || !isDefined(getlevelindex(level.script) + 1)) {
    return;
  }

  if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
    scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
  }

  var0 = getlevelindex(level.script) + 1;
  var1 = getlevelbink(var0);
  setsaveddvar("LNSNKKLPLL", "0");
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  stopcinematicingame();
  waitframe();

  if(!isDefined(var1)) {
    var1 = "default";
  }

  cinematicingame(var1, 1, 1, 1, 0, 0, 1);

  while(!iscinematicplaying()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("nextmission_transition_bink_primed");
}

function createmission() {
  var0 = spawnStruct();
  var0.levels = [];
  var0.prereqs = [];
  return var0;
}

function getrestartlevel(var0) {
  if(!isDefined(level.missionsettings)) {
    return undefined;
  }

  var1 = getlevelindex(var0);

  if(isDefined(level.missionsettings.levels[var1].restartlevel)) {
    return level.missionsettings.levels[var1].restartlevel;
  }
}

function level_settle_time_get(var0) {
  var1 = getlevelindex(var0);

  if(!isDefined(var1)) {
    return 0;
  }

  return level.missionsettings.levels[var1].settletime;
}

function client_settle_time_get(var0) {
  var1 = getlevelindex(var0);

  if(!isDefined(var1)) {
    return 0;
  }

  return level.missionsettings.levels[var1].clientsettletime;
}

function level_settle_time_wait(var0) {
  if(!isDefined(var0)) {
    var0 = level.script;
  }

  var1 = level_settle_time_get(var0);
  var2 = client_settle_time_get(var0);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  } else {
    var2 *= 0.02;
  }

  var3 = var1 + var2;

  if(isDefined(var3)) {
    wait var3 * 0.05;
  }

  if(isDefined(var2) && var2 <= 0) {
    waitframe();
    return;
  }

  if(!isDefined(var1) || var1 <= 0) {
    waitframe();
    return;
  }
}

function nextmission_internal(var0) {
  if(scripts\sp\utility::is_demo()) {
    if(isDefined(level.nextmission_exit_time)) {
      changelevel("", 0, level.nextmission_exit_time);
      return;
    }

    changelevel("", 0);
    return;
  }

  level notify("nextmission");
  level.nextmission = 1;
  level.player enableinvulnerability();
  var1 = undefined;
  setDvar("ui_showPopup", "0");
  setDvar("ui_popupString", "");
  setDvar("ui_prev_map", level.script);
  game["previous_map"] = undefined;
  var1 = getlevelindex(level.script);

  if(!isDefined(var1)) {
    missionsuccess(level.script);
    return;
  }

  if(level.script != "lab") {
    scripts\engine\sp\utility::level_end_save();
  }

  setlevelcompleted(var1);
  collateraldamageassessment(level.script);
  var2 = updatesppercent();
  updategamerprofile();

  if(hasachievement(level.missionsettings, var1)) {
    scripts\sp\utility::giveachievement_wrapper(getachievement(level.missionsettings, var1));
  }

  if(haslevelveteranaward(level.missionsettings, var1) && getlevelcompleted(var1) == 4 && check_other_haslevelveteranachievement(level.missionsettings, var1)) {
    scripts\sp\utility::giveachievement_wrapper(getlevelveteranaward(level.missionsettings, var1));
  }

  if(hasmissionhardenedaward(level.missionsettings) && getlowestskill(level.missionsettings) > 2) {
    scripts\sp\utility::giveachievement_wrapper(gethardenedaward(level.missionsettings));
  }

  scripts\sp\analytics::start_point_update("mission_end", 1);

  if(level.script == "lab") {
    changelevel("", 0);
    return;
  }

  var3 = var1 + 1;
  var4 = getlevelbink(var3);

  if(isDefined(var4) && !istrue(level.endmission_bink_skip)) {
    setDvar("last_transition_movie", var4);

    if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
      scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
    }

    if(!isDefined(var0)) {
      setomnvar("ui_hide_hud", 1);
    }

    if(!level.player islinked()) {
      var5 = level.player scripts\engine\utility::spawn_tag_origin();
      level.player playerlinktoabsolute(var5);
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
      cinematicingame(var4, 0, 1, 1, 0, 0, 1);
    }
  }

  if(isDefined(var0)) {
    wait var0;
    setomnvar("ui_hide_hud", 1);
  }

  scripts\sp\analytics::analytics_lui_mission_end_dlog();

  if(getlevelstreamsync(level.missionsettings, var3)) {
    setstreamsynconnextlevel();
  }

  if(isDefined(getfadetime(level.missionsettings, var1))) {
    changelevel(getlevelname(level.missionsettings, var3), getkeepweapons(level.missionsettings, var1), getfadetime(level.missionsettings, var1));
    return;
  }

  changelevel(getlevelname(level.missionsettings, var3), getkeepweapons(level.missionsettings, var1));
}

function collateraldamageassessment(var0) {
  var1 = getcollateraldamagegrade();
  level.player setplayerprogression("civiliansKilledGrade", var0, var1);
  var2 = level.player getplayerprogression("civiliansKilledGradeBest", var0);

  if(var1 > var2) {
    level.player setplayerprogression("civiliansKilledGradeBest", var0, var1);
    return;
  }
}

function getcollateraldamagegrade() {
  var0 = 4;
  var1 = int(min(level.friendlyfire["civilians_killed"], var0));
  var1 = var0 - var1;
  return int(var1);
}

function updatesppercent() {
  var0 = int(gettotalpercentcompletesp() * 100);

  if(getdvarint("MSSSNONPLS") == 0) {
    level.player setlocalplayerprofiledata("percentCompleteSP", var0);
  }

  return var0;
}

function addlevel(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = level.missionsettings.levels.size;
  level.missionsettings.levels[var10] = spawnStruct();
  level.missionsettings.levels[var10].name = var0;
  level.missionsettings.levels[var10].keepweapons = var1;
  level.missionsettings.levels[var10].achievement = var2;
  level.missionsettings.levels[var10].completion = var3;
  level.missionsettings.levels[var10].postloadbink = var4;
  level.missionsettings.levels[var10].settletime = var5;
  level.missionsettings.levels[var10].clientsettletime = var6;
  level.missionsettings.levels[var10].restartlevel = var7;
  level.missionsettings.levels[var10].preload_transients = var8;
  level.missionsettings.levels[var10].streamsync = var9;
  level.missionsettings.levels[var10].fade_time = 0;
  var11 = tablelookup("sp/levels.csv", 1, var0, 3);

  if(var11 != "") {
    level.missionsettings.levels[var10].bink = var11;
    return;
  }
}

function addprereq(var0) {
  var1 = level.missionsettings.prereqs.size;
  level.missionsettings.prereqs[var1] = var0;
}

function getlevelindex(var0) {
  if(!isDefined(level.missionsettings) || !isDefined(level.missionsettings.levels)) {
    return undefined;
  }

  foreach(var2 in level.missionsettings.levels) {
    if(var2.name == var0) {
      return var3;
    }
  }

  return undefined;
}

function getlevelbink(var0) {
  var1 = undefined;

  if(var0 < level.missionsettings.levels.size) {
    var1 = level.missionsettings.levels[var0].bink;
  }

  return var1;
}

function getpostloadbink(var0) {
  var1 = getlevelindex(var0);

  if(isDefined(var1)) {
    if(isDefined(level.missionsettings.levels[var1].postloadbink)) {
      return level.missionsettings.levels[var1].postloadbink;
    }
  }

  return "none";
}

function getlevelname(var0) {
  return self.levels[var0].name;
}

function getkeepweapons(var0) {
  return self.levels[var0].keepweapons;
}

function getachievement(var0) {
  return self.levels[var0].achievement;
}

function getlevelveteranaward(var0) {
  return self.levels[var0].veteran_achievement;
}

function getlevelstreamsync(var0) {
  return self.levels[var0].streamsync;
}

function setfadetime(var0, var1) {
  level.missionsettings.levels[var0].fade_time = var1;
}

function getfadetime(var0) {
  if(!isDefined(self.levels[var0].fade_time)) {
    return undefined;
  }

  return self.levels[var0].fade_time;
}

function haslevelveteranaward(var0) {
  if(isDefined(self.levels[var0].veteran_achievement)) {
    return 1;
  }

  return 0;
}

function hasachievement(var0) {
  if(isDefined(self.levels[var0].achievement)) {
    return 1;
  }

  return 0;
}

function check_other_haslevelveteranachievement(var0) {
  for(var1 = 0; var1 < self.levels.size; var1++) {
    if(var1 == var0) {
      continue;
    }

    if(!haslevelveteranaward(var1)) {
      continue;
    }

    if(self.levels[var1].veteran_achievement == self.levels[var0].veteran_achievement) {
      if(getlevelcompleted(var1) < 4) {
        return false;
      }
    }
  }

  return true;
}

function gethardenedaward() {
  return self.hardenedaward;
}

function hasmissionhardenedaward() {
  if(isDefined(self.hardenedaward)) {
    return 1;
  }

  return 0;
}

function gettotalpercentcompletesp() {
  var0 = max(getstat_progression(1), getstat_progression(2));
  var1 = 0.5;
  var2 = getstat_progression(3);
  var3 = 0.25;
  var4 = getstat_progression(4);
  var5 = 0.1;
  var6 = getstat_intel();
  var7 = 0.15;
  var8 = 0;
  var8 += var1 * var0;
  var8 += var3 * var2;
  var8 += var5 * var4;
  var8 += var7 * var6;
  return var8;
}

function getstat_progression(var0) {
  var1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var2 = 0;
  var3 = [];
  var4 = 0;

  for(var5 = 0; var5 < level.missionsettings.levels.size - 1; var5++) {
    if(int(var1[var5]) >= var0) {
      var2++;
    }
  }

  var6 = var2 / (level.missionsettings.levels.size - 1) * 100;
  return var6;
}

function getstat_intel() {
  return level.player getlocalplayerprofiledata("cheatPoints") / 45 * 100;
}

function getlevelcompleted(var0) {
  return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[var0]);
}

function setlevelcompleted(var0) {
  levelprogressioncomplete(var0);
  var1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var2 = "";

  for(var3 = 0; var3 < var1.size; var3++) {
    if(var3 != var0) {
      var2 += var1[var3];
      continue;
    }

    if(level.lowestgameskill + 1 > int(var1[var0])) {
      var2 += level.lowestgameskill + 1;
      continue;
    }

    var2 += var1[var3];
  }

  var4 = "";
  var5 = 0;
  var6 = 0;

  for(var7 = 0; var7 < var2.size; var7++) {
    if(int(var2[var7]) == 0 || var5) {
      var4 += "0";
      var5 = 1;
      continue;
    }

    var4 += var2[var7];
    var6++;
  }

  mission_diffstring_ifnotcheating_set(var4);
}

function levelprogressioncomplete(var0) {
  var1 = level.missionsettings.levels[var0].name;
  level.player setplayerprogression("missionStateData", var1, "complete");
  var0++;

  if(level.missionsettings.levels.size > var0) {
    var2 = level.missionsettings.levels[var0].name;
    scripts\sp\autosave::startsavedprogression(var2);
    return;
  }
}

function highestmission_ifnotcheating_set(var0) {
  if(getDvar("MSSSNONPLS") == "1") {
    return;
  }

  level.player setlocalplayerprofiledata("highestMission", var0);
}

function mission_diffstring_ifnotcheating_set(var0) {
  if(getDvar("MSSSNONPLS") == "1") {
    return;
  }

  level.player setlocalplayerprofiledata("missionHighestDifficulty", var0);
  var1 = 1;

  for(var2 = 0; var2 < 14; var2++) {
    if(var0[var2] != "4" && var0[var2] != "5") {
      var1 = undefined;
      break;
    }
  }

  if(istrue(var1)) {
    level thread scripts\sp\utility::giveachievement_wrapper("vetfinish", 1);
    return;
  }
}

function getlevelskill(var0) {
  var1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  return int(var1[var0]);
}

function getlowestskill() {
  var0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var1 = 4;

  for(var2 = 0; var2 < self.levels.size; var2++) {
    if(int(var0[var2]) < var1) {
      var1 = int(var0[var2]);
    }
  }

  return var1;
}

function getnextlevelindex() {
  for(var0 = 0; var0 < self.levels.size; var0++) {
    if(!getlevelskill(var0)) {
      return var0;
    }
  }

  return 0;
}

function force_all_complete() {
  var0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var1 = "";

  for(var2 = 0; var2 < var0.size; var2++) {
    if(var2 < 20) {
      var1 += 2;
      continue;
    }

    var1 += 0;
  }

  level.player setlocalplayerprofiledata("missionHighestDifficulty", var1);
  level.player setlocalplayerprofiledata("highestMission", 20);
}

function clearall() {
  level.player setlocalplayerprofiledata("missionHighestDifficulty", "00000000000000000000000000000000000000000000000000");
  level.player setlocalplayerprofiledata("highestMission", 1);
}