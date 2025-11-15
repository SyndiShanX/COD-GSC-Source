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
    level waittill("connected", var_00);

    if(!level.rankedmatch) {
      return;
    }
    if(!var_00 scripts\mp\utility\game::rankingenabled()) {
      return;
    }
    if(isai(var_00)) {
      continue;
    }
    var_01 = var_00 getrankedplayerdata("mp", "activeMissionTeam");
    var_02 = var_00 getrankedplayerdata("mp", "missionTeams", var_01, "activeSlot");
    var_03 = var_00 getrankedplayerdata("mp", "missionTeams", var_01, "currentMission", var_02);
    setmatchdata("players", var_0.clientid, "activeMissionTeam", var_01);
    setmatchdata("players", var_0.clientid, "missionTeamData_activeSlot", var_02);
    setmatchdata("players", var_0.clientid, "missionTeamData_currentMission", var_03);

    for(var_04 = 0; var_04 < 5; var_4++) {
      var_05 = var_00 getrankedplayerdata("mp", "missionTeams", var_01, "currentMission", var_04);
      setmatchdata("players", var_0.clientid, "missionTeamData_availableMissions", var_04, var_05);
    }

    var_06 = var_00 getrankedplayerdata("mp", "missionTeams", var_01, "level");
    var_07 = var_00 getrankedplayerdata("mp", "missionTeams", var_01, "missionXP");
    setmatchdata("players", var_0.clientid, "missionTeamData_startLevel", var_06);
    setmatchdata("players", var_0.clientid, "missionTeamData_startMissionXP", var_07);
    setmatchdata("players", var_0.clientid, "tierComplete", -1);
    var_0.func_B8D4 = var_01;
    var_00 setwaypoint(var_03, var_01);
  }
}

updatemissionteamperformancestats() {
  foreach(var_01 in level.players) {
    if(!isDefined(var_01) || !var_01 scripts\mp\utility\game::rankingenabled()) {
      continue;
    }
    if(isai(var_01)) {
      continue;
    }
    var_02 = var_1.func_B8D4;
    var_03 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "matchesPlayed");
    var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "matchesPlayed", var_03 + 1);

    if(isDefined(var_1.func_9978) && isDefined(var_1.func_9978.func_4C0D)) {
      if(var_1.func_9978.func_4C0D > 0) {
        switch (var_1.func_9978.func_4C0D) {
          case 1:
            var_04 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "completed");
            var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "completed", var_04 + 1);
            break;
          case 2:
            var_05 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "bronze");
            var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "bronze", var_05 + 1);
            break;
          case 3:
            var_06 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "silver");
            var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "silver", var_06 + 1);
            break;
          case 4:
            var_07 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "gold");
            var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "gold", var_07 + 1);
            break;
        }

        continue;
      }

      var_08 = var_01 getrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "failed");
      var_01 setrankedplayerdata("mp", "missionTeamPerformanceData", var_02, "failed", var_08 + 1);
    }
  }
}

func_AE1D(var_00) {
  var_01 = func_B02D(var_00);

  if(!isDefined(var_01))
    return undefined;

  var_02 = spawnStruct();
  var_2.ref = var_01;
  var_2.func_118A7 = [];

  for(var_03 = 0; var_03 < 4; var_3++) {
    var_04 = func_B02E(var_00, var_03);

    if(!isDefined(var_04)) {
      break;
    }
    var_2.func_118A7[var_03]["target"] = var_04;
  }

  var_2.func_4C0D = 0;
  var_2.progress = 0;
  return var_02;
}

func_B02D(var_00) {
  var_01 = tablelookup("mp\intelChallenges.csv", 0, var_00, 1);

  if(!isDefined(var_01) || var_01 == "")
    return undefined;

  return var_01;
}

func_B02E(var_00, var_01) {
  var_02 = tablelookup("mp\intelChallenges.csv", 0, var_00, 5 + var_01 * 2);

  if(!isDefined(var_02) || var_02 == "")
    return undefined;

  return int(var_02);
}

setwaypoint(var_00, var_01) {
  var_02 = self.pers["intelChallengeInfo"];

  if(isDefined(var_02))
    var_03 = var_02;
  else {
    var_03 = func_AE1D(var_00);
    self setrankedplayerdata("mp", "activeMissionComplete", -1);
    var_3.func_B8D4 = var_01;
  }

  if(!isDefined(var_03)) {
    return;
  }
  self.func_9978 = var_03;
  self thread[[level.func_9979[var_3.ref]]](var_00);

  switch (var_3.ref) {
    case "ch_intel_multiple_weapon_one_life":
    case "ch_intel_kills_this_life":
      thread scripts\mp\intelchallenges::func_99B9();
      break;
  }

  thread func_BA09();
  func_9884(var_00);
}

func_F75C() {
  var_00 = self.func_9978;

  if(!isDefined(var_00)) {
    return;
  }
  self setrankedplayerdata("mp", "activeMissionComplete", var_0.func_4C0D);
  setmatchdata("players", self.clientid, "tierComplete", var_0.func_4C0D);

  if(var_0.func_4C0D == 0) {
    var_01 = self getrankedplayerdata("mp", "missionsCompleted");
    self setrankedplayerdata("mp", "missionsCompleted", var_01 + 1);
  }

  if(var_0.func_4C0D == var_0.func_118A7.size - 1)
    self notify("intel_max_tier_complete");

  thread scripts\mp\hud_message::showsplash("intel_completed_" + (var_0.func_4C0D + 1) + "_team_" + var_0.func_B8D4);
  var_0.func_4C0D++;
  func_12EB8(var_0.func_4C0D);
}

func_9E94() {
  if(!isDefined(self.func_9978))
    return 0;

  if(self.func_9978.func_4C0D < self.func_9978.func_118A7.size)
    return 0;

  return 1;
}

func_BA09() {
  level waittill("round_switch");

  if(isDefined(self.func_9978))
    self.pers["intelChallengeInfo"] = self.func_9978;
}

func_9884(var_00) {
  if(!func_9E94()) {
    self setclientomnvar("ui_intel_active_index", var_00);
    self setclientomnvar("ui_intel_current_tier", self.func_9978.func_4C0D);
  } else {
    var_01 = self.func_9978.func_118A7.size;
    var_02 = self.func_9978.func_118A7[self.func_9978.func_118A7.size - 1]["target"];
    self setclientomnvar("ui_intel_active_index", var_00);
    self setclientomnvar("ui_intel_progress_current", int(var_02));
    self setclientomnvar("ui_intel_current_tier", var_01);
  }

  self setclientomnvar("ui_intel_progress_current", int(self.func_9978.progress));
}

func_3934() {
  return scripts\mp\utility\game::isreallyalive(self);
}

func_12EB7(var_00) {
  if(!func_3934()) {
    self.func_9978.func_DB8F = var_00;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_progress_current", int(var_00));
}

func_12EB8(var_00) {
  if(!func_3934()) {
    self.func_9978.func_DB90 = var_00;
    thread func_12EF9();
    return;
  }

  self setclientomnvar("ui_intel_current_tier", var_00);
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

  if(isDefined(self.func_9978.func_DB8F)) {
    func_12EB7(self.func_9978.func_DB8F);
    self.func_9978.func_DB8F = undefined;
  }

  if(isDefined(self.func_9978.func_DB90)) {
    func_12EB8(self.func_9978.func_DB90);
    self.func_9978.func_DB90 = undefined;
  }
}