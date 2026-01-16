/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_highvaluetarget.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("high_value_target", ::func_128E9);
  level.var_9264["axis"] = 0;
  level.var_9264["allies"] = 0;
  game["dialog"]["hvt_gone"] = "hvt_gone";
}

func_128E9(var_0, var_1) {
  return usehighvaluetarget(self, var_0);
}

func_DD18() {
  if(level.teambased) {
    return level.var_9264[self.team] >= 4;
  } else if(isDefined(self.var_9264)) {
    return self.var_9264 >= 2;
  }

  return 0;
}

usehighvaluetarget(var_0, var_1) {
  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return 0;
  }

  if(var_0.team == "spectator") {
    return 0;
  }

  if(func_DD18() || isDefined(var_0.var_9264) && var_0.var_9264 >= 2) {
    self iprintlnbold(&"KILLSTREAKS_HVT_MAX");
    return 0;
  }

  var_0 thread func_F745();
  level thread scripts\mp\utility::teamplayercardsplash("used_hvt", var_0, var_0.team);
  return 1;
}

func_F745() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self.team;
  func_93F0();
  thread func_13AA6(var_0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(10);
  if(level.teambased) {
    scripts\mp\utility::leaderdialog("hvt_gone", var_0);
  } else {
    scripts\mp\utility::leaderdialogonplayer("hvt_gone");
  }

  if(level.teambased) {
    level func_4FBA(var_0);
    return;
  }

  func_4FBA();
}

func_93F0() {
  var_0 = 0;
  if(level.teambased) {
    level.var_9264[self.team]++;
    var_0 = level.var_9264[self.team];
    var_1 = self.team;
  } else {
    if(!isDefined(self.var_9264)) {
      self.var_9264 = 1;
    } else {
      self.var_9264++;
    }

    var_1 = self.var_9264;
    var_1 = self getentitynumber();
  }

  var_2 = 1 + var_0 * 0.5;
  level.var_115F3[var_1] = clamp(var_2, 1, 4);
}

func_4FBA(var_0) {
  var_1 = 0;
  if(level.teambased) {
    if(level.var_9264[var_0] > 0) {
      level.var_9264[var_0]--;
    }

    var_1 = level.var_9264[var_0];
    var_2 = var_0;
  } else {
    if(self.var_9264 > 0) {
      self.var_9264--;
    }

    var_2 = self.var_9264;
    var_2 = self getentitynumber();
  }

  var_3 = 1 + var_1 * 0.5;
  level.var_115F3[var_2] = clamp(var_3, 1, 4);
}

func_13AA6(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::waittill_any_return("disconnect", "joined_team", "joined_spectators");
  if(level.teambased) {
    level func_4FBA(var_0);
    return;
  }

  if(isDefined(self) && var_1 != "disconnect") {
    func_4FBA();
  }
}