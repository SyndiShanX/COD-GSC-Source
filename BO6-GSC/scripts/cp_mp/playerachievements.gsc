/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\playerachievements.gsc
************************************************/

#namespace playerachievements;

function private initachievement(player, achievementid) {
  if(!isDefined(player.achievements)) {
    player.achievements = [];
  }

  if(!isDefined(player.achievements[achievementid])) {
    player.achievements[achievementid] = {
      #progressvalues: [], #dataready: 0
    };
  }
}

function getstate(player, achievementid) {
  println("<dev string:x24>" + player.name + "<dev string:x45>" + achievementid);

  if(player iscodcaster()) {
    return;
  }

  initachievement(player, achievementid);
  player function_fdf029c4be6546a3(achievementid);
}

function function_a550b9c75bcbee5e(progressname) {
  if(!isDefined(level.var_ff13eadad931c15a)) {
    level.var_ff13eadad931c15a = [];
  }

  progressid = level.var_ff13eadad931c15a[progressname];

  if(!isDefined(progressid)) {
    progressid = int(tablelookup("ae/ae_progress_target_ids.csv", 0, progressname, 1));
    level.var_ff13eadad931c15a[progressname] = progressid;
  }

  return progressid;
}

function function_6c2806c796cd19b2(progressid) {
  return tablelookup("ae/ae_progress_target_ids.csv", 1, progressid, 0);
}

function function_ce48098d17912e1f(player, achievementid, progressname, defaultvalue) {
  progressid = function_a550b9c75bcbee5e(progressname);
  return function_1792b9eb4905bb29(player, achievementid, progressid, defaultvalue);
}

function function_1792b9eb4905bb29(player, achievementid, progressid, defaultvalue) {
  initachievement(player, achievementid);
  progressvalue = defaultvalue;

  if(isDefined(player.achievements[achievementid].progressvalues[progressid])) {
    progressvalue = player.achievements[achievementid].progressvalues[progressid];
  }

  return progressvalue;
}

function challenge_progress(player, achievementid, progression) {
  println("<dev string:x66>" + player.name + "<dev string:x91>" + achievementid);
  initachievement(player, achievementid);

  for(index = 0; index < progression.progress_values.size; index++) {
    progress_id = progression.progress_values[index].progress_id;
    progress_value = progression.progress_values[index].progress;
    player.achievements[achievementid].progressvalues[progress_id] = progress_value;
  }

  player notify("challengeProgress", achievementid);
}