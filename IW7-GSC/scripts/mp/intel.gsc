/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\intel.gsc
********************************/

init() {
  scripts\mp\intelchallenges::func_DEF9();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!level.rankedmatch) {
      return;
    }

    if(!var_00 scripts\mp\utility::rankingenabled()) {
      return;
    }

    if(isai(var_00)) {
      continue;
    }

    var_01 = var_00 getplayerdata("mp", "activeMissionTeam");
    var_02 = var_00 getplayerdata("mp", "missionTeams", var_01, "activeSlot");
    var_03 = var_00 getplayerdata("mp", "missionTeams", var_01, "currentMission", var_02);
    setmatchdata("players", var_00.clientid, "activeMissionTeam", var_01);
    setmatchdata("players", var_00.clientid, "missionTeamData_activeSlot", var_02);
    setmatchdata("players", var_00.clientid, "missionTeamData_currentMission", var_03);
    for(var_04 = 0; var_04 < 5; var_04++) {
      var_05 = var_00 getplayerdata("mp", "missionTeams", var_01, "currentMission", var_04);
      setmatchdata("players", var_00.clientid, "missionTeamData_availableMissions", var_04, var_05);
    }

    var_06 = var_00 getplayerdata("mp", "missionTeams", var_01, "level");
    var_07 = var_00 getplayerdata("mp", "missionTeams", var_01, "missionXP");
    setmatchdata("players", var_00.clientid, "missionTeamData_startLevel", var_06);
    setmatchdata("players", var_00.clientid, "missionTeamData_startMissionXP", var_07);
    setmatchdata("players", var_00.clientid, "tierComplete", -1);
    var_00.var_B8D4 = var_01;
    var_00 setwaypoint(var_03, var_01);
  }
}

updatemissionteamperformancestats() {
  foreach(var_01 in level.players) {
    if(!isDefined(var_01) || !var_01 scripts\mp\utility::rankingenabled()) {
      continue;
    }

    if(isai(var_01)) {
      continue;
    }

    var_02 = var_01.var_B8D4;
    var_03 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "matchesPlayed");
    var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "matchesPlayed", var_03 + 1);
    if(isDefined(var_01.var_9978) && isDefined(var_01.var_9978.var_4C0D)) {
      if(var_01.var_9978.var_4C0D > 0) {
        switch (var_01.var_9978.var_4C0D) {
          case 1:
            var_04 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "completed");
            var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "completed", var_04 + 1);
            break;

          case 2:
            var_05 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "bronze");
            var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "bronze", var_05 + 1);
            break;

          case 3:
            var_06 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "silver");
            var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "silver", var_06 + 1);
            break;

          case 4:
            var_07 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "gold");
            var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "gold", var_07 + 1);
            break;
        }

        continue;
      }

      var_08 = var_01 getplayerdata("mp", "missionTeamPerformanceData", var_02, "failed");
      var_01 setplayerdata("mp", "missionTeamPerformanceData", var_02, "failed", var_08 + 1);
    }
  }
}

func_AE1D(param_00) {
  var_01 = func_B02D(param_00);
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_02 = spawnStruct();
  var_02.ref = var_01;
  var_02.var_118A7 = [];
  for(var_03 = 0; var_03 < 4; var_03++) {
    var_04 = func_B02E(param_00, var_03);
    if(!isDefined(var_04)) {
      break;
    }

    var_02.var_118A7[var_03]["target"] = var_04;
  }

  var_02.var_4C0D = 0;
  var_02.progress = 0;
  return var_02;
}

func_B02D(param_00) {
  var_01 = tablelookup("mp\intelChallenges.csv", 0, param_00, 1);
  if(!isDefined(var_01) || var_01 == "") {
    return undefined;
  }

  return var_01;
}

func_B02E(param_00, param_01) {
  var_02 = tablelookup("mp\intelChallenges.csv", 0, param_00, 5 + param_01 * 2);
  if(!isDefined(var_02) || var_02 == "") {
    return undefined;
  }

  return int(var_02);
}

setwaypoint(param_00, param_01) {
  var_02 = self.pers["intelChallengeInfo"];
  if(isDefined(var_02)) {
    var_03 = var_02;
  } else {
    var_03 = func_AE1D(param_01);
    self setplayerdata("mp", "activeMissionComplete", -1);
    var_03.var_B8D4 = param_01;
  }

  if(!isDefined(var_03)) {
    return;
  }

  self.var_9978 = var_03;
  self thread[[level.var_9979[var_03.ref]]](param_00);
  switch (var_03.ref) {
    case "ch_intel_multiple_weapon_one_life":
    case "ch_intel_kills_this_life":
      thread scripts\mp\intelchallenges::func_99B9();
      break;
  }

  thread func_BA09();
  func_9884(param_00);
}

func_F75C() {
  var_00 = self.var_9978;
  if(!isDefined(var_00)) {
    return;
  }

  self setplayerdata("mp", "activeMissionComplete", var_00.var_4C0D);
  setmatchdata("players", self.clientid, "tierComplete", var_00.var_4C0D);
  if(var_00.var_4C0D == 0) {
    var_01 = self getplayerdata("mp", "missionsCompleted");
    self setplayerdata("mp", "missionsCompleted", var_01 + 1);
  }

  if(var_00.var_4C0D == var_00.var_118A7.size - 1) {
    self notify("intel_max_tier_complete");
  }

  thread scripts\mp\hud_message::showsplash("intel_completed_" + var_00.var_4C0D + 1 + "_team_" + var_00.var_B8D4);
  var_00.var_4C0D++;
  func_12EB8(var_00.var_4C0D);
}

func_9E94() {
  if(!isDefined(self.var_9978)) {
    return 0;
  }

  if(self.var_9978.var_4C0D < self.var_9978.var_118A7.size) {
    return 0;
  }

  return 1;
}

func_BA09() {
  level waittill("round_switch");
  if(isDefined(self.var_9978)) {
    self.pers["intelChallengeInfo"] = self.var_9978;
  }
}

func_9884(param_00) {
  if(!func_9E94()) {
    self setclientomnvar("ui_intel_active_index", param_00);
    self setclientomnvar("ui_intel_current_tier", self.var_9978.var_4C0D);
  } else {
    var_01 = self.var_9978.var_118A7.size;
    var_02 = self.var_9978.var_118A7[self.var_9978.var_118A7.size - 1]["target"];
    self setclientomnvar("ui_intel_active_index", param_00);
    self setclientomnvar("ui_intel_progress_current", int(var_02));
    self setclientomnvar("ui_intel_current_tier", var_01);
  }

  self setclientomnvar("ui_intel_progress_current", int(self.var_9978.progress));
}

func_3934() {
  return scripts\mp\utility::isreallyalive(self);
}

func_12EB7(param_00) {
  if(!func_3934()) {
    self.var_9978.var_DB8F = param_00;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_progress_current", int(param_00));
}

func_12EB8(param_00) {
  if(!func_3934()) {
    self.var_9978.var_DB90 = param_00;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_current_tier", param_00);
}

func_12EF9() {
  self endon("disconnect");
  self notify("updateQueuedUIInfoWhenAble()");
  self endon("updateQueuedUIInfoWhenAble()");
  for(;;) {
    if(func_3934()) {
      break;
    }

    wait(0.25);
  }

  if(isDefined(self.var_9978.var_DB8F)) {
    func_12EB7(self.var_9978.var_DB8F);
    self.var_9978.var_DB8F = undefined;
  }

  if(isDefined(self.var_9978.var_DB90)) {
    func_12EB8(self.var_9978.var_DB90);
    self.var_9978.var_DB90 = undefined;
  }
}