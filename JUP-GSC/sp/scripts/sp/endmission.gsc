/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\endmission.gsc
***********************************************/

#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\utility;
#namespace endmission;

function main() {
  missionsettings = createmission();
  level.missionsettings = missionsettings;
  level.lowestgameskill = getdvarint(@ "g_gameskill");
  nil = undefined;
  var_e55705af85d11cb9 = function_91d6763e1921a524();

  foreach(mapinfo in var_e55705af85d11cb9) {
    var_f9e628cf36da6985 = undefined;

    if(isDefined(mapinfo.var_f9e628cf36da6985)) {
      var_f9e628cf36da6985 = strtok(mapinfo.var_f9e628cf36da6985, ", ");
    }

    settletime = default_to(mapinfo.settletime, 10);
    clientsettletime = default_to(mapinfo.clientsettletime, 100);
    loadbink = mapinfo.var_dd5f1ceda1154582;
    addlevel(mapinfo.mapname, 0, nil, 1, nil, settletime, clientsettletime, nil, var_f9e628cf36da6985, 0, loadbink);
  }

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
  }

  thread function_b47ee5b0dae14294();

  thread debug_test_next_mission();
}

function debug_test_next_mission() {
  version = getbuildversion();

  if(version == "SHIP") {
    return;
  }

  setdvarifuninitialized(@ "test_next_mission", 0);
  wait 10;

  while(getdvarint(@ "test_next_mission") < 1) {
    wait 3;
  }

  setDvar(@ "test_next_mission", 0);
  nextmission_internal();
}

function nextmission_preload_internal(type, var_740cf07d74dba935) {
  if(!isDefined(type)) {
    type = "full";
  }

  if(!isDefined(var_740cf07d74dba935)) {
    var_740cf07d74dba935 = 1;
  }

  levelindex = level.missionsettings getlevelindex(level.script);
  nextlevelindex = levelindex + 1;
  preload_transients = level.missionsettings.levels[nextlevelindex].preload_transients;

  if(var_740cf07d74dba935) {
    level thread nextmission_primeloadbink();
  }

  if(getdvarint(@ "fastload", 1)) {
    levelname = level.missionsettings getlevelname(nextlevelindex);

    switch (type) {
      case #"hash_af9a1714fe58109c":
        if(isDefined(preload_transients)) {
          array = array_combine([levelname], preload_transients);
          preloadzones(array);
        } else {
          preloadzones(levelname);
        }

        break;
      case #"hash_4d3e1f9017db6ba5":
        preloadzones(levelname);
        break;
      case #"hash_ce8bfbd622fff22a":
        if(isDefined(preload_transients)) {
          preloadzones(preload_transients);
        }

        break;
    }

    while(!ispreloadzonescomplete()) {
      waitframe();
    }
  }

  flag_set("nextmission_preload_complete");
}

function nextmission_primeloadbink_internal() {
  if(!isDefined(getlevelindex(level.script)) || !isDefined(getlevelindex(level.script) + 1)) {
    return;
  }

  if(!flag_exist("nextmission_transition_bink_primed")) {
    flag_init("nextmission_transition_bink_primed");
  }

  nextlevelindex = getlevelindex(level.script) + 1;
  var_1b5061c6c41a4d30 = getlevelbink(nextlevelindex);
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  stopcinematicingame();
  waitframe();

  if(!isDefined(var_1b5061c6c41a4d30)) {
    iprintlnbold("<dev string:x1c>");

    var_1b5061c6c41a4d30 = "default";
  }

  cinematicingame(var_1b5061c6c41a4d30, 1, 1, 1, 0, 0, 1);

  while(!iscinematicplaying()) {
    waitframe();
  }

  println("<dev string:x84>" + var_1b5061c6c41a4d30);
  flag_set("nextmission_transition_bink_primed");
}

function getrestartlevel(levelname) {
  if(!isDefined(level.missionsettings)) {
    return undefined;
  }

  index = getlevelindex(levelname);

  if(isDefined(level.missionsettings.levels[index].restartlevel)) {
    return level.missionsettings.levels[index].restartlevel;
  }
}

function level_settle_time_get(levelname) {
  assert(isDefined(levelname));
  index = getlevelindex(levelname);

  if(!isDefined(index)) {
    return 0;
  }

  return level.missionsettings.levels[index].settletime;
}

function client_settle_time_get(levelname) {
  assert(isDefined(levelname));
  index = getlevelindex(levelname);

  if(!isDefined(index)) {
    return 0;
  }

  return level.missionsettings.levels[index].clientsettletime;
}

function level_settle_time_wait(levelname) {
  if(!isDefined(levelname)) {
    levelname = level.script;
  }

  settletime = level_settle_time_get(levelname);
  clientsettletime = client_settle_time_get(levelname);

  if(!isDefined(settletime)) {
    settletime = 0;
  }

  if(!isDefined(clientsettletime)) {
    clientsettletime = 0;
  } else {
    clientsettletime *= 0.02;
  }

  var_814a0605452d6c7 = settletime + clientsettletime;

  if(isDefined(var_814a0605452d6c7)) {
    wait var_814a0605452d6c7 * 0.05;
  }

  if(isDefined(clientsettletime) && clientsettletime <= 0) {
    waitframe();
    return;
  }

  if(!isDefined(settletime) || settletime <= 0) {
    waitframe();
  }
}

function function_65085d2b5d1f245c() {
  difficultystring = "";
  difficultyarray = level.player function_ff103db8e0d75209();

  for(index = 0; index < difficultyarray.size; index++) {
    difficultystring += string(difficultyarray[index]);
  }

  return difficultystring;
}

function nextmission_internal() {
  if(getdvarint(@ "hash_bb95f621f8f2a810")) {
    iprintlnbold("<dev string:x95>");
    return;
  }

  if(utility::is_demo()) {
    if(isDefined(level.nextmission_exit_time)) {
      changelevel("", 0, level.nextmission_exit_time);
      return;
    }

    changelevel("", 0);
    return;
  }

  scripts\sp\analytics::analytics_upload_during_nextmission();
  level notify("nextmission");
  level.nextmission = 1;
  level.player enableinvulnerability();
  levelindex = undefined;
  setDvar(@ "hash_8c684d38f4200b12", "0");
  setDvar(@ "hash_b5229012ccf8e014", "");
  setDvar(@ "hash_3e810e7dcf052f5d", level.script);
  game["previous_map"] = undefined;
  levelindex = getlevelindex(level.script);

  if(!isDefined(levelindex)) {
    missionsuccess(level.script);
    return;
  }

  if(!is_lastlevel()) {
    scripts\engine\sp\utility::level_end_save();
  } else {
    var_5963a57373cba5b4 = "none";
    level.player setplayerprogression("currentMission", var_5963a57373cba5b4);
  }

  setlevelcompleted(levelindex);
  collateraldamageassessment(level.script);
  println("<dev string:xb5>");
  completion_percentage = updatesppercent();

  if(getdvarint(@ "hash_bc76f1b9a1f7ba07") != 0) {
    highestmission_ifnotcheating_set(getdvarint(@ "hash_b50de240594f8df4"));
    level.missionsettings setlevelcompleted(max(0, getdvarint(@ "hash_b50de240594f8df4") - 1));
    setDvar(@ "hash_bc76f1b9a1f7ba07", "<dev string:xe3>");
  }

  if(completion_percentage < level.player getplayerprogression("<dev string:xe4>")) {
    println("<dev string:xf6>" + completion_percentage + "<dev string:x118>" + level.player getplayerprogression("<dev string:xe4>") + "<dev string:x121>");
  }

  println("<dev string:x126>" + getdvarint(@ "hash_bc76f1b9a1f7ba07") + "<dev string:x143>" + getdvarint(@ "hash_1adbe88f794c0245") + "<dev string:x14e>");
  println("<dev string:x151>" + function_65085d2b5d1f245c() + "<dev string:x16d>");
  println("<dev string:x16f>" + completion_percentage / 100 + "<dev string:x18e>");
  println("<dev string:x191>" + levelindex + "<dev string:x16d>");
  println("<dev string:x1a8>" + level.script + "<dev string:x16d>");
  println("<dev string:x1bf>" + level.missionsettings.levels.size + "<dev string:x16d>");

  updategamerprofile();

  if(level.missionsettings hasachievement(levelindex)) {
    scripts\sp\utility::giveachievement_wrapper(level.missionsettings getachievement(levelindex));
  }

  if(level.missionsettings haslevelveteranaward(levelindex) && getlevelcompleted(levelindex) == 4 && level.missionsettings check_other_haslevelveteranachievement(levelindex)) {
    scripts\sp\utility::giveachievement_wrapper(level.missionsettings getlevelveteranaward(levelindex));
  }

  if(level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2) {
    giveachievement_wrapper(level.missionsettings gethardenedaward());
  }

  scripts\sp\analytics::start_point_update("mission_end", 1);

  if(function_8f7452209f2fa982()) {
    if(isDefined(level.var_483eedd411ddb20e) && level.script != "gunship_compound") {
      stopactivity(level.var_483eedd411ddb20e, "completed");
    }
  }

  if(is_lastlevel()) {
    changelevel("", 0);
    return;
  }

  nextlevelindex = levelindex + 1;
  assert(nextlevelindex < level.missionsettings.levels.size);
  var_1b5061c6c41a4d30 = getlevelbink(nextlevelindex);
  var_b02ce1c02cd503c9 = level.missionsettings getlevelname(nextlevelindex);
  var_7291ff60dd218210 = function_b146e0d2e5d91eef(var_b02ce1c02cd503c9);

  println("<dev string:x1d6>" + var_b02ce1c02cd503c9 + "<dev string:x16d>");
  println("<dev string:x1ed>" + var_7291ff60dd218210.var_60699f6be12aea0d + "<dev string:x16d>");

  if(isDefined(var_1b5061c6c41a4d30) && !istrue(level.endmission_bink_skip)) {
    println("<dev string:x20a>" + var_1b5061c6c41a4d30 + "<dev string:x16d>");
    setDvar(@ "hash_4967b5f5316f16af", var_1b5061c6c41a4d30);

    if(!flag_exist("nextmission_transition_bink_primed")) {
      flag_init("nextmission_transition_bink_primed");
    }

    setomnvar("ui_hide_hud", 1);

    if(!level.player islinked()) {
      tag = level.player spawn_tag_origin();
      level.player playerlinktoabsolute(tag);
    }

    level.player freezecontrols(1);

    if(flag("nextmission_transition_bink_primed")) {
      print("<dev string:x223>");

      setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
      setsaveddvar(@ "hash_b9ff37d084074df3", "1");
      pausecinematicingame(0);
    } else {
      print("<dev string:x246>");

      setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
      setsaveddvar(@ "hash_b9ff37d084074df3", "1");
      flags = 128 | 2048 | 8192;

      if(var_7291ff60dd218210.var_60699f6be12aea0d) {
        flags |= 33554432;
      }

      cinematicingame(var_1b5061c6c41a4d30, flags);
    }
  }

  scripts\sp\analytics::analytics_lui_mission_end_dlog();

  if(level.missionsettings getlevelstreamsync(nextlevelindex)) {
    setstreamsynconnextlevel();
  }

  if(var_7291ff60dd218210.var_60699f6be12aea0d) {
    wait 1;
    function_bb63844d1b8da6ae(var_b02ce1c02cd503c9);
    return;
  }

  if(isDefined(level.missionsettings getfadetime(levelindex))) {
    changelevel(var_b02ce1c02cd503c9, level.missionsettings getkeepweapons(levelindex), level.missionsettings getfadetime(levelindex));
    return;
  }

  changelevel(var_b02ce1c02cd503c9, level.missionsettings getkeepweapons(levelindex));
}

function collateraldamageassessment(levelname) {
  grade = getcollateraldamagegrade();
  level.player setplayerprogression("civiliansKilledGrade", levelname, grade);
  best = level.player getplayerprogression("civiliansKilledGradeBest", levelname);

  if(grade > best) {
    level.player setplayerprogression("civiliansKilledGradeBest", levelname, grade);
  }
}

function getcollateraldamagegrade() {
  var_d40d6d92361e9a2 = 4;
  grade = int(min(level.friendlyfire["civilians_killed"], var_d40d6d92361e9a2));
  grade = var_d40d6d92361e9a2 - grade;
  return int(grade);
}

function updatesppercent() {
  completion_percentage = int(gettotalpercentcompletesp() * 100);

  if(getdvarint(@ "hash_b8b8e25bb75b206d") == 0) {
    assertex(completion_percentage >= 0 && completion_percentage <= 10000, "SP's Completion percentage [ " + completion_percentage + "% ] is outside of 0 to 100 range!");
    level.player setplayerprogression("percentCompleteSP", completion_percentage);
  }

  return completion_percentage;
}

function addprereq(missionindex) {
  var_82b6d1fbefcc5fae = level.missionsettings.prereqs.size;
  level.missionsettings.prereqs[var_82b6d1fbefcc5fae] = missionindex;
}

function getpostloadbink(levelname) {
  assert(isDefined(levelname));
  index = getlevelindex(levelname);

  if(isDefined(index)) {
    if(isDefined(level.missionsettings.levels[index].postloadbink)) {
      return level.missionsettings.levels[index].postloadbink;
    }
  }

  return "none";
}

function getlevelname(levelindex) {
  return self.levels[levelindex].name;
}

function function_823f915153b5fcd8() {
  if(level.missionsettings.levels.size == 0) {
    return level.script;
  }

  return level.missionsettings.levels[level.missionsettings.levels.size - 1].name;
}

function getkeepweapons(levelindex) {
  return self.levels[levelindex].keepweapons;
}

function getachievement(levelindex) {
  return self.levels[levelindex].achievement;
}

function getlevelveteranaward(levelindex) {
  return self.levels[levelindex].veteran_achievement;
}

function getlevelstreamsync(levelindex) {
  return self.levels[levelindex].streamsync;
}

function setfadetime(index, time) {
  level.missionsettings.levels[index].fade_time = time;
}

function getfadetime(index) {
  if(!isDefined(self.levels[index].fade_time)) {
    return undefined;
  }

  return self.levels[index].fade_time;
}

function haslevelveteranaward(levelindex) {
  if(isDefined(self.levels[levelindex].veteran_achievement)) {
    return 1;
  }

  return 0;
}

function hasachievement(levelindex) {
  if(isDefined(self.levels[levelindex].achievement)) {
    return 1;
  }

  return 0;
}

function check_other_haslevelveteranachievement(levelindex) {
  for(i = 0; i < self.levels.size; i++) {
    if(i == levelindex) {
      continue;
    }

    if(!haslevelveteranaward(i)) {
      continue;
    }

    if(self.levels[i].veteran_achievement == self.levels[levelindex].veteran_achievement) {
      if(getlevelcompleted(i) < 4) {
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
  stat_progression = max(getstat_progression(1), getstat_progression(2));
  var_870ca0c572d3b097 = 0.5;
  println("<dev string:x26d>" + stat_progression + "<dev string:x282>" + "<dev string:x284>" + var_870ca0c572d3b097 * 100 + "<dev string:x286>");
  var_44a90f29ee2b00ff = getstat_progression(3);
  var_be0978ec6507b6f3 = 0.25;
  println("<dev string:x289>" + var_44a90f29ee2b00ff + "<dev string:x282>" + "<dev string:x284>" + var_be0978ec6507b6f3 * 100 + "<dev string:x286>");
  stat_veteran = getstat_progression(4);
  var_286fdc6f7b7f3ef7 = 0.1;
  println("<dev string:x29f>" + stat_veteran + "<dev string:x282>" + "<dev string:x284>" + var_286fdc6f7b7f3ef7 * 100 + "<dev string:x286>");
  stat_intel = getstat_intel();
  var_64951e461b04a4c0 = 0.15;
  println("<dev string:x2b4>" + stat_intel + "<dev string:x282>" + "<dev string:x284>" + var_64951e461b04a4c0 * 100 + "<dev string:x286>");
  assertex(var_870ca0c572d3b097 + var_be0978ec6507b6f3 + var_286fdc6f7b7f3ef7 + var_64951e461b04a4c0 <= 1, "Total sum of SP progress breakdown contributes to more than 100%!");
  total_progress = 0;
  total_progress += var_870ca0c572d3b097 * stat_progression;
  total_progress += var_be0978ec6507b6f3 * var_44a90f29ee2b00ff;
  total_progress += var_286fdc6f7b7f3ef7 * stat_veteran;
  total_progress += var_64951e461b04a4c0 * stat_intel;
  assertex(total_progress <= 100, "Total Percentage calculation is out of bound, larger then 100%");
  println("<dev string:x2c7>" + total_progress + "<dev string:x282>");
  return total_progress;
}

function getstat_progression(difficulty) {
  assert(isDefined(level.missionsettings));
  assert(isDefined(level.script));
  difficulty_array = level.player function_ff103db8e0d75209();
  levels = 0;
  var_c51133d2565044c9 = [];
  skipped = 0;
  missioncount = min(difficulty_array.size, level.missionsettings.levels.size - 1);

  for(i = 0; i < missioncount; i++) {
    if(difficulty_array[i] >= difficulty) {
      levels++;
    }
  }

  completion = levels / (level.missionsettings.levels.size - 1) * 100;
  return completion;
}

function getstat_intel() {
  return level.player getplayerprogression("cheatPoints") / 45 * 100;
}

function getlevelcompleted(levelindex) {
  return level.player function_b3bf603811212474(levelindex);
}

function setlevelcompleted(levelindex) {
  levelprogressioncomplete(levelindex);
  var_a22f6f453396a4f0 = level.player function_b3bf603811212474(levelindex);

  if(level.lowestgameskill + 1 > var_a22f6f453396a4f0) {
    level.player function_4b0cd7f9ce03cf8(levelindex, level.lowestgameskill + 1);
  }

  function_d46d93b0a99a612d();
}

function highestmission_ifnotcheating_set(mission) {
  if(getDvar(@ "hash_b8b8e25bb75b206d") == "1") {
    return;
  }
}

function function_d46d93b0a99a612d() {
  if(getDvar(@ "hash_b8b8e25bb75b206d") == "1") {
    return;
  }

  var_64820f36de0a7e54 = level.player function_ff103db8e0d75209();

  if(var_64820f36de0a7e54.size >= level.missionsettings.levels.size) {
    var_f6fef0a5f712672b = 1;

    for(i = 0; i < level.missionsettings.levels.size; i++) {
      if(var_64820f36de0a7e54[i] != 4 && var_64820f36de0a7e54[i] != 5) {
        var_f6fef0a5f712672b = undefined;
        break;
      }
    }
  }
}

function getlevelskill(levelindex) {
  return level.player function_b3bf603811212474(levelindex);
}

function getlowestskill() {
  missionarray = level.player function_ff103db8e0d75209();
  lowestskill = 4;
  var_5b5a922bcf1c5c9f = min(missionarray.size, self.levels.size);

  for(index = 0; index < var_5b5a922bcf1c5c9f; index++) {
    if(missionarray[index] < lowestskill) {
      lowestskill = missionarray[index];
    }
  }

  return lowestskill;
}

function getnextlevelindex() {
  for(index = 0; index < self.levels.size; index++) {
    if(!getlevelskill(index)) {
      return index;
    }
  }

  return 0;
}

function function_b47ee5b0dae14294() {
  for(;;) {
    if(getdvarint(@ "hash_1adbe88f794c0245")) {
      clearall();
      level.player setplayerprogression("<dev string:xe4>", 0);
      setDvar(@ "hash_1adbe88f794c0245", "<dev string:xe3>");
    }

    wait 0.05;
  }
}

function clearall() {
  missionarray = [];
  arraycount = level.player function_2d447b52456ea3b8();

  for(index = 0; index < arraycount; index++) {
    missionarray[index] = 0;
  }

  level.player function_a320e75d6ec43bb5(missionarray);
}