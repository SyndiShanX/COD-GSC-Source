/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_highvaluetarget.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("high_value_target", ::func_128E9);
  level.var_9264["axis"] = 0;
  level.var_9264["allies"] = 0;
  game["dialog"]["hvt_gone"] = "hvt_gone";
}

func_128E9(param_00, param_01) {
  return usehighvaluetarget(self, param_00);
}

func_DD18() {
  if(level.teambased) {
    return level.var_9264[self.team] >= 4;
  } else if(isDefined(self.var_9264)) {
    return self.var_9264 >= 2;
  }

  return 0;
}

usehighvaluetarget(param_00, param_01) {
  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(param_00.team == "spectator") {
    return 0;
  }

  if(func_DD18() || isDefined(param_00.var_9264) && param_00.var_9264 >= 2) {
    self iprintlnbold( & "KILLSTREAKS_HVT_MAX");
    return 0;
  }

  param_00 thread func_F745();
  level thread scripts\mp\utility::teamplayercardsplash("used_hvt", param_00, param_00.team);
  return 1;
}

func_F745() {
  level endon("game_ended");
  self endon("disconnect");
  var_00 = self.team;
  func_93F0();
  thread func_13AA6(var_00);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(10);
  if(level.teambased) {
    scripts\mp\utility::leaderdialog("hvt_gone", var_00);
  } else {
    scripts\mp\utility::leaderdialogonplayer("hvt_gone");
  }

  if(level.teambased) {
    level func_4FBA(var_00);
    return;
  }

  func_4FBA();
}

func_93F0() {
  var_00 = 0;
  if(level.teambased) {
    level.var_9264[self.team]++;
    var_00 = level.var_9264[self.team];
    var_01 = self.team;
  } else {
    if(!isDefined(self.var_9264)) {
      self.var_9264 = 1;
    } else {
      self.var_9264++;
    }

    var_01 = self.var_9264;
    var_01 = self getentitynumber();
  }

  var_02 = 1 + var_00 * 0.5;
  level.var_115F3[var_01] = clamp(var_02, 1, 4);
}

func_4FBA(param_00) {
  var_01 = 0;
  if(level.teambased) {
    if(level.var_9264[param_00] > 0) {
      level.var_9264[param_00]--;
    }

    var_01 = level.var_9264[param_00];
    var_02 = param_00;
  } else {
    if(self.var_9264 > 0) {
      self.var_9264--;
    }

    var_02 = self.var_9264;
    var_02 = self getentitynumber();
  }

  var_03 = 1 + var_01 * 0.5;
  level.var_115F3[var_02] = clamp(var_03, 1, 4);
}

func_13AA6(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::waittill_any_return("disconnect", "joined_team", "joined_spectators");
  if(level.teambased) {
    level func_4FBA(param_00);
    return;
  }

  if(isDefined(self) && var_01 != "disconnect") {
    func_4FBA();
  }
}