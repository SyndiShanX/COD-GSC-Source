/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2755.gsc
***************************************/

init() {
  scripts\mp\intelchallenges::func_DEF9();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!level.rankedmatch) {
      return;
    }
    if(!var_0 scripts\mp\utility\game::rankingenabled()) {
      return;
    }
    if(isai(var_0)) {
      continue;
    }
    var_1 = var_0 getrankedplayerdata("mp", "activeMissionTeam");
    var_2 = var_0 getrankedplayerdata("mp", "missionTeams", var_1, "activeSlot");
    var_3 = var_0 getrankedplayerdata("mp", "missionTeams", var_1, "currentMission", var_2);
    setmatchdata("players", var_0.clientid, "activeMissionTeam", var_1);
    setmatchdata("players", var_0.clientid, "missionTeamData_activeSlot", var_2);
    setmatchdata("players", var_0.clientid, "missionTeamData_currentMission", var_3);

    for(var_4 = 0; var_4 < 5; var_4++) {
      var_5 = var_0 getrankedplayerdata("mp", "missionTeams", var_1, "currentMission", var_4);
      setmatchdata("players", var_0.clientid, "missionTeamData_availableMissions", var_4, var_5);
    }

    var_6 = var_0 getrankedplayerdata("mp", "missionTeams", var_1, "level");
    var_7 = var_0 getrankedplayerdata("mp", "missionTeams", var_1, "missionXP");
    setmatchdata("players", var_0.clientid, "missionTeamData_startLevel", var_6);
    setmatchdata("players", var_0.clientid, "missionTeamData_startMissionXP", var_7);
    setmatchdata("players", var_0.clientid, "tierComplete", -1);
    var_0.var_B8D4 = var_1;
    var_0 setwaypoint(var_3, var_1);
  }
}

updatemissionteamperformancestats() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || !var_1 scripts\mp\utility\game::rankingenabled()) {
      continue;
    }
    if(isai(var_1)) {
      continue;
    }
    var_2 = var_1.var_B8D4;
    var_3 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "matchesPlayed");
    var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "matchesPlayed", var_3 + 1);

    if(isDefined(var_1.var_9978) && isDefined(var_1.var_9978.var_4C0D)) {
      if(var_1.var_9978.var_4C0D > 0) {
        switch (var_1.var_9978.var_4C0D) {
          case 1:
            var_4 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "completed");
            var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "completed", var_4 + 1);
            break;
          case 2:
            var_5 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "bronze");
            var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "bronze", var_5 + 1);
            break;
          case 3:
            var_6 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "silver");
            var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "silver", var_6 + 1);
            break;
          case 4:
            var_7 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "gold");
            var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "gold", var_7 + 1);
            break;
        }

        continue;
      }

      var_8 = var_1 getrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "failed");
      var_1 setrankedplayerdata("mp", "missionTeamPerformanceData", var_2, "failed", var_8 + 1);
    }
  }
}

func_AE1D(var_0) {
  var_1 = func_B02D(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = spawnStruct();
  var_2.ref = var_1;
  var_2.var_118A7 = [];

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = func_B02E(var_0, var_3);

    if(!isDefined(var_4)) {
      break;
    }
    var_2.var_118A7[var_3]["target"] = var_4;
  }

  var_2.var_4C0D = 0;
  var_2.progress = 0;
  return var_2;
}

func_B02D(var_0) {
  var_1 = tablelookup("mp\intelChallenges.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return var_1;
}

func_B02E(var_0, var_1) {
  var_2 = tablelookup("mp\intelChallenges.csv", 0, var_0, 5 + var_1 * 2);

  if(!isDefined(var_2) || var_2 == "") {
    return undefined;
  }

  return int(var_2);
}

setwaypoint(var_0, var_1) {
  var_2 = self.pers["intelChallengeInfo"];

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = func_AE1D(var_0);
    self setrankedplayerdata("mp", "activeMissionComplete", -1);
    var_3.var_B8D4 = var_1;
  }

  if(!isDefined(var_3)) {
    return;
  }
  self.var_9978 = var_3;
  self thread[[level.var_9979[var_3.ref]]](var_0);

  switch (var_3.ref) {
    case "ch_intel_multiple_weapon_one_life":
    case "ch_intel_kills_this_life":
      thread scripts\mp\intelchallenges::func_99B9();
      break;
  }

  thread func_BA09();
  func_9884(var_0);
}

func_F75C() {
  var_0 = self.var_9978;

  if(!isDefined(var_0)) {
    return;
  }
  self setrankedplayerdata("mp", "activeMissionComplete", var_0.var_4C0D);
  setmatchdata("players", self.clientid, "tierComplete", var_0.var_4C0D);

  if(var_0.var_4C0D == 0) {
    var_1 = self getrankedplayerdata("mp", "missionsCompleted");
    self setrankedplayerdata("mp", "missionsCompleted", var_1 + 1);
  }

  if(var_0.var_4C0D == var_0.var_118A7.size - 1) {
    self notify("intel_max_tier_complete");
  }

  thread scripts\mp\hud_message::showsplash("intel_completed_" + (var_0.var_4C0D + 1) + "_team_" + var_0.var_B8D4);
  var_0.var_4C0D++;
  func_12EB8(var_0.var_4C0D);
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

func_9884(var_0) {
  if(!func_9E94()) {
    self setclientomnvar("ui_intel_active_index", var_0);
    self setclientomnvar("ui_intel_current_tier", self.var_9978.var_4C0D);
  } else {
    var_1 = self.var_9978.var_118A7.size;
    var_2 = self.var_9978.var_118A7[self.var_9978.var_118A7.size - 1]["target"];
    self setclientomnvar("ui_intel_active_index", var_0);
    self setclientomnvar("ui_intel_progress_current", int(var_2));
    self setclientomnvar("ui_intel_current_tier", var_1);
  }

  self setclientomnvar("ui_intel_progress_current", int(self.var_9978.progress));
}

func_3934() {
  return scripts\mp\utility\game::isreallyalive(self);
}

func_12EB7(var_0) {
  if(!func_3934()) {
    self.var_9978.var_DB8F = var_0;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_progress_current", int(var_0));
}

func_12EB8(var_0) {
  if(!func_3934()) {
    self.var_9978.var_DB90 = var_0;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_current_tier", var_0);
}

func_12EF9() {
  self endon("disconnect");
  self notify("updateQueuedUIInfoWhenAble()");
  self endon("updateQueuedUIInfoWhenAble()");

  for(;;) {
    if(func_3934()) {
      break;
    }
    wait 0.25;
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