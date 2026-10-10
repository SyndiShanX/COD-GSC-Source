/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_575fda2758b0a36e.gsc
*************************************************/

#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace level_progression;

function createmission() {
  mission = spawnStruct();
  mission.levels = [];
  mission.prereqs = [];
  return mission;
}

function addlevel(levelname, keepweapons, achievement, completion, postloadbink, settletime, clientsettletime, restartlevel, preload_transients, streamsync, loadbink) {
  if(scripts\engine\utility::default_to(loadbink, "") == "") {
    loadbink = undefined;
  }

  count = level.missionsettings.levels.size;
  level.missionsettings.levels[count] = spawnStruct();
  level.missionsettings.levels[count].name = levelname;
  level.missionsettings.levels[count].keepweapons = keepweapons;
  level.missionsettings.levels[count].achievement = achievement;
  level.missionsettings.levels[count].completion = completion;
  level.missionsettings.levels[count].postloadbink = postloadbink;
  level.missionsettings.levels[count].settletime = settletime;
  level.missionsettings.levels[count].clientsettletime = clientsettletime;
  level.missionsettings.levels[count].restartlevel = restartlevel;
  level.missionsettings.levels[count].preload_transients = preload_transients;
  level.missionsettings.levels[count].streamsync = streamsync;
  level.missionsettings.levels[count].fade_time = 0;
  level.missionsettings.levels[count].bink = loadbink;
}

function startsavedprogression(levelname) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  if(scripts\common\utility::iscp() && getsubstr(levelname, 0, 3) == "cp_") {
    levelname = function_f3bb4f4911a1beb2("game", "convertsbmissionnametoddl", levelname);
  }

  if(isprogressionlevel(levelname)) {
    if(scripts\common\utility::iscp() && getsubstr(levelname, 0, 3) == "cp_") {
      scripts\engine\utility::function_f3bb4f4911a1beb2("checkpoint", "timestamp");

      if(!getdvarint(@ "hash_f004b2ccc04fdc8d", 0)) {
        scripts\engine\utility::function_f3bb4f4911a1beb2("checkpoint", "reset");
      }

      checkpoint_map = level.player scripts\engine\utility::function_f3bb4f4911a1beb2("checkpoint", "get_checkpoint_map");

      if(isDefined(checkpoint_map) && isstring(checkpoint_map) && checkpoint_map != levelname) {
        scripts\engine\utility::function_f3bb4f4911a1beb2("checkpoint", "reset");
      }
    }

    if(isprogressionmismatch(levelname)) {
      function_dba9f60ce6c9c5a();
      return;
    }

    if(getdvarint(@ "hash_b8b8e25bb75b206d") == 0) {
      if(scripts\common\utility::iscp()) {
        level.player function_f3bb4f4911a1beb2("game", "setProgressionData", "spData", "currentMission", levelname);
      } else {
        level.player function_f3bb4f4911a1beb2("game", "setPlayerProgression", "currentMission", levelname);
      }

      if(scripts\common\utility::iscp()) {
        state = level.player function_f3bb4f4911a1beb2("game", "getProgressionData", "spData", "missionStateData", levelname);
      } else {
        state = level.player function_f3bb4f4911a1beb2("game", "getPlayerProgression", "missionStateData", levelname);
      }

      if(state == "locked") {
        if(scripts\common\utility::iscp()) {
          level.player function_f3bb4f4911a1beb2("game", "setProgressionData", "spData", "missionStateData", levelname, "incomplete");
          return;
        }

        level.player function_f3bb4f4911a1beb2("game", "setPlayerProgression", "missionStateData", levelname, "incomplete");
      }
    }
  }
}

function function_dba9f60ce6c9c5a(levelname) {
  setomnvar("progression_invalid", 1);
}

function isprogressionlevel(levelname) {
  levelindex = getlevelindex(levelname);
  return isDefined(levelindex);
}

function isprogressionmismatch(levelname) {
  levelindex = getlevelindex(levelname);

  if(previouslevelcompleted(levelindex) || isdevbuild() || getdvarint(@ "fpstool_run")) {
    return false;
  } else {
    return true;
  }

  return false;
}

function previouslevelcompleted(levelindex) {
  if(levelindex == 0) {
    return 1;
  }

  levelindex--;
  var_dafc1e855ded43aa = level.missionsettings.levels[levelindex].name;

  if(scripts\common\utility::iscp()) {
    var_15cfc62c61f4117f = level.player function_f3bb4f4911a1beb2("game", "getProgressionData", "spData", "missionStateData", var_dafc1e855ded43aa);
  } else {
    var_15cfc62c61f4117f = level.player function_f3bb4f4911a1beb2("game", "getPlayerProgression", "missionStateData", var_dafc1e855ded43aa);
  }

  if(var_15cfc62c61f4117f != "complete") {
    return 0;
  }

  return 1;
}

function isdevbuild() {
  devbuild = 0;
  setdvarifuninitialized(@ "hash_b3fcf6e357e30812", 0);

  if(!getdvarint(@ "hash_b3fcf6e357e30812")) {
    devbuild = 1;
  }

  return devbuild;
}

function getlevelindex(levelname) {
  if(scripts\common\utility::iscp() && getsubstr(levelname, 0, 3) == "cp_") {
    levelname = function_f3bb4f4911a1beb2("game", "convertsbmissionnametoddl", levelname);
  }

  if(!isDefined(level.missionsettings) || !isDefined(level.missionsettings.levels)) {
    return undefined;
  }

  foreach(so_level in level.missionsettings.levels) {
    if(so_level.name == levelname) {
      return levelindex;
    }
  }

  return undefined;
}

function getlevelbink(levelindex) {
  bink = undefined;

  if(levelindex < level.missionsettings.levels.size) {
    bink = level.missionsettings.levels[levelindex].bink;
  }

  return bink;
}

function levelprogressioncomplete(levelindex) {
  var_6e0eeacbd0c484e7 = level.missionsettings.levels[levelindex].name;

  if(scripts\common\utility::iscp()) {
    level.player function_f3bb4f4911a1beb2("game", "setProgressionData", "spData", "missionStateData", var_6e0eeacbd0c484e7, "complete");
    level.player function_f3bb4f4911a1beb2("game", "setProgressionData", "spData", "currentGameskill", level.player.gameskill + 1);
  } else {
    level.player function_f3bb4f4911a1beb2("game", "setPlayerProgression", "missionStateData", var_6e0eeacbd0c484e7, "complete");
    level.player function_f3bb4f4911a1beb2("game", "setPlayerProgression", "currentGameskill", level.player.gameskill + 1);
  }

  level.player setprogressiondata("JupMissionDifficulties", "JupMissionDifficulty", levelindex, level.lowestgameskill + 1);
  var_80f827abc3d76099 = [];

  for(i = 0; i < level.missionsettings.levels.size; i++) {
    var_80f827abc3d76099[i] = level.player getprogressiondata("JupMissionDifficulties", "JupMissionDifficulty", i);
  }

  var_45c1c6bb65ecb9b = 1;

  if(var_80f827abc3d76099.size > 0) {
    for(i = 0; i < var_80f827abc3d76099.size; i++) {
      if(var_80f827abc3d76099[i] != 4) {
        var_45c1c6bb65ecb9b = 0;
        break;
      }
    }
  }

  if(istrue(var_45c1c6bb65ecb9b)) {
    level.player function_6a369480dbaf1090("jup_sp_141ready");
  }

  levelindex++;

  if(level.missionsettings.levels.size > levelindex) {
    var_b02ce1c02cd503c9 = level.missionsettings.levels[levelindex].name;
    namespace_d6cca25f4b0ab62::startsavedprogression(var_b02ce1c02cd503c9);
  }
}