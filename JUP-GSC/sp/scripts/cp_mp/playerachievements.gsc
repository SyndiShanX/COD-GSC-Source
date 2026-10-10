/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\playerachievements.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace playerachievements;

function private initachievement(player, achievementid) {
  if(!isDefined(player.achievements)) {
    player.achievements = [];
  }

  if(!isDefined(player.achievements[achievementid])) {
    player.achievements[achievementid] = spawnStruct();
    player.achievements[achievementid].dataready = 0;
    player.achievements[achievementid].progressvalues = [];
  }
}

function getstate(player, achievementid) {
  println("<dev string:x1c>" + player.name + "<dev string:x3a>" + achievementid);

  if(player iscodcaster()) {
    return;
  }

  initachievement(player, achievementid);
  player function_86af48e06c94360a(achievementid);
}

function function_691880160b33d133(progressname) {
  return int(tablelookup("ae/ae_progress_target_ids.csv", 0, progressname, 1));
}

function function_ec4c795c2898be52(player, achievementid, progressname, defaultvalue) {
  initachievement(player, achievementid);
  progressid = function_691880160b33d133(progressname);
  progressvalue = defaultvalue;

  if(isDefined(player.achievements[achievementid].progressvalues[progressid])) {
    progressvalue = player.achievements[achievementid].progressvalues[progressid];
  }

  return progressvalue;
}

function challenge_progress(player, achievementid, progression) {
  println("<dev string:x58>" + player.name + "<dev string:x80>" + achievementid);
  initachievement(player, achievementid);

  for(index = 0; index < progression.progress_values.size; index++) {
    progress_id = progression.progress_values[index].progress_id;
    progress_value = progression.progress_values[index].progress;
    player.achievements[achievementid].progressvalues[progress_id] = progress_value;
  }

  player notify("challengeProgress", achievementid);
}