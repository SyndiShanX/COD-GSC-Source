/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3492.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("high_value_target", ::func_128E9);
  level.func_9264["axis"] = 0;
  level.func_9264["allies"] = 0;
  game["dialog"]["hvt_gone"] = "hvt_gone";
}

func_128E9(var_00, var_01) {
  return usehighvaluetarget(self, var_00);
}

func_DD18() {
  if(level.teambased)
    return level.func_9264[self.team] >= 4;
  else if(isDefined(self.func_9264))
    return self.func_9264 >= 2;

  return 0;
}

usehighvaluetarget(var_00, var_01) {
  if(!scripts\mp\utility\game::isreallyalive(var_00))
    return 0;

  if(var_0.team == "spectator")
    return 0;

  if(func_DD18() || isDefined(var_0.func_9264) && var_0.func_9264 >= 2) {
    self iprintlnbold(&"KILLSTREAKS_HVT_MAX");
    return 0;
  }

  var_00 thread func_F745();
  level thread scripts\mp\utility\game::teamplayercardsplash("used_hvt", var_00, var_0.team);
  return 1;
}

func_F745() {
  level endon("game_ended");
  self endon("disconnect");
  var_00 = self.team;
  func_93F0();
  thread func_13AA6(var_00);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(10);

  if(level.teambased)
    scripts\mp\utility\game::leaderdialog("hvt_gone", var_00);
  else
    scripts\mp\utility\game::leaderdialogonplayer("hvt_gone");

  if(level.teambased)
    level func_4FBA(var_00);
  else
    func_4FBA();
}

func_93F0() {
  var_00 = 0;

  if(level.teambased) {
    level.func_9264[self.team]++;
    var_00 = level.func_9264[self.team];
    var_01 = self.team;
  } else {
    if(!isDefined(self.func_9264))
      self.func_9264 = 1;
    else
      self.func_9264++;

    var_00 = self.func_9264;
    var_01 = self getentitynumber();
  }

  var_02 = 1 + var_00 * 0.5;
  level.func_115F3[var_01] = clamp(var_02, 1, 4);
}

func_4FBA(var_00) {
  var_01 = 0;

  if(level.teambased) {
    if(level.func_9264[var_00] > 0)
      level.func_9264[var_00]--;

    var_01 = level.func_9264[var_00];
    var_02 = var_00;
  } else {
    if(self.func_9264 > 0)
      self.func_9264--;

    var_01 = self.func_9264;
    var_02 = self getentitynumber();
  }

  var_03 = 1 + var_01 * 0.5;
  level.func_115F3[var_02] = clamp(var_03, 1, 4);
}

func_13AA6(var_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::waittill_any_return("disconnect", "joined_team", "joined_spectators");

  if(level.teambased)
    level func_4FBA(var_00);
  else if(isDefined(self) && var_01 != "disconnect")
    func_4FBA();
}