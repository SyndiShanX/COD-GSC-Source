/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\battlebuddy.gsc
**************************************/

init() {
  if(level.teambased && !isDefined(level.nobuddyspawns)) {
    if(!isDefined(level.var_28CE)) {
      level.var_28CE = [];
    }

    level thread onplayerspawned();
    level thread onplayerconnect();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onbegincarrying();
    var_00 thread ondisconnect();
  }
}

onplayerspawned() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    if(!isai(var_00)) {
      if(isDefined(var_00.isspawningonbattlebuddy)) {
        var_00.isspawningonbattlebuddy = undefined;
        if(isDefined(var_00.battlebuddy) && isalive(var_00.battlebuddy)) {
          if(var_00.battlebuddy getstance() != "stand") {
            var_00 setstance("crouch");
          }
        }
      }

      if(var_00 func_138DE()) {
        if(!var_00 func_8BD4()) {
          var_00.firstspawn = 0;
          var_00 finalkillcam_victim();
        }

        continue;
      }

      var_00 func_AB2B();
    }
  }
}

onbegincarrying() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "battlebuddy_update") {
      var_02 = !func_138DE();
      self setplayerdata("common", "enableBattleBuddy", var_02);
      if(var_02) {
        finalkillcam_victim();
      } else {
        func_AB2B();
      }

      continue;
    }

    if(var_00 == "team_select" && self.hasspawned) {
      var_03 = func_138DE();
      func_AB2B();
      self setplayerdata("common", "enableBattleBuddy", var_03);
    }
  }
}

ondisconnect() {
  self waittill("disconnect");
  func_AB2C();
}

func_136D6() {
  scripts\mp\utility::updatesessionstate("spectator");
  self.missile_createrepulsorent = self.battlebuddy getentitynumber();
  self forcethirdpersonwhenfollowing();
  self setclientomnvar("cam_scene_name", "over_shoulder");
  self setclientomnvar("cam_scene_lead", self.battlebuddy getentitynumber());
  func_136AE();
}

func_13A5F() {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  level endon("game_ended");
  self setclientomnvar("ui_battlebuddy_showButtonPrompt", 1);
  self notifyonplayercommand("respawn_random", "+usereload");
  self notifyonplayercommand("respawn_random", "+activate");
  wait(0.5);
  self waittill("respawn_random");
  self setclientomnvar("ui_battlebuddy_timer_ms", 0);
  self setclientomnvar("ui_battlebuddy_showButtonPrompt", 0);
  func_FAAF();
}

func_FAAF() {
  func_419E();
  self.isspawningonbattlebuddy = undefined;
  self notify("randomSpawnPressed");
  cleanupbuddyspawn();
}

func_136AE() {
  self endon("randomSpawnPressed");
  level endon("game_ended");
  self.isspawningonbattlebuddy = undefined;
  thread func_13A5F();
  if(isDefined(self.var_28CD)) {
    var_00 = 4000 - gettime() - self.var_28CD;
    if(var_00 < 2000) {
      var_00 = 2000;
    }
  } else {
    var_00 = 4000;
  }

  var_01 = checkbuddyspawn();
  if(var_01.status == 0) {
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "incoming");
  } else if(var_01.status == -1 || var_01.status == -3) {
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "err_combat");
  } else {
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "err_pos");
  }

  func_12F43(var_00);
  for(var_01 = checkbuddyspawn(); var_01.status != 0; var_01 = checkbuddyspawn()) {
    if(var_01.status == -1 || var_01.status == -3) {
      self setclientomnvar("ui_battlebuddy_status", "wait_combat");
      self.battlebuddy setclientomnvar("ui_battlebuddy_status", "err_combat");
    } else if(var_01.status == -2) {
      self setclientomnvar("ui_battlebuddy_status", "wait_pos");
      self.battlebuddy setclientomnvar("ui_battlebuddy_status", "err_pos");
    } else if(var_01.status == -4) {
      cleanupbuddyspawn();
      return;
    }

    wait(0.5);
  }

  self.isspawningonbattlebuddy = 1;
  thread func_56D5();
  self playlocalsound("copycat_steal_class");
  self notify("teamSpawnPressed");
}

func_419E() {
  self setclientomnvar("ui_battlebuddy_status", "none");
  self setclientomnvar("ui_battlebuddy_showButtonPrompt", 0);
  if(isDefined(self.battlebuddy)) {
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "none");
  }
}

func_56D6(param_00) {
  scripts\mp\utility::setlowermessage("waiting_info", param_00, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

func_56D5() {
  func_419E();
  if(isDefined(self.battlebuddy)) {
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "on_you");
    wait(1.5);
    self.battlebuddy setclientomnvar("ui_battlebuddy_status", "none");
  }
}

checkbuddyspawn() {
  var_00 = spawnStruct();
  if(!isDefined(self.battlebuddy) || !isalive(self.battlebuddy)) {
    var_00.status = -4;
    return var_00;
  }

  return var_00;
}

cleanupbuddyspawn() {
  thread scripts\mp\spectating::setspectatepermissions();
  self.missile_createrepulsorent = -1;
  scripts\mp\utility::updatesessionstate("dead");
  self disableforcethirdpersonwhenfollowing();
  self setclientomnvar("cam_scene_name", "unknown");
  func_419E();
  self notify("abort_battlebuddy_spawn");
}

func_12F43(param_00) {
  self endon("disconnect");
  self endon("abort_battlebuddy_spawn");
  self endon("teamSpawnPressed");
  var_01 = param_00 * 0.001;
  self setclientomnvar("ui_battlebuddy_timer_ms", param_00 + gettime());
  wait(var_01);
  self setclientomnvar("ui_battlebuddy_timer_ms", 0);
}

func_138DE() {
  return self getplayerdata("common", "enableBattleBuddy");
}

func_8BD4() {
  return isDefined(self.battlebuddy);
}

func_BE8E() {
  return func_138DE() && !func_8BD4();
}

func_9FD1(param_00) {
  return self != param_00 && self.team == param_00.team && param_00 func_BE8E();
}

func_3876() {
  return func_8BD4() && scripts\mp\utility::isreallyalive(self.battlebuddy);
}

func_C88C(param_00) {
  func_E103(param_00);
  self.battlebuddy = param_00;
  param_00.battlebuddy = self;
  self setclientomnvar("ui_battlebuddy_idx", param_00 getentitynumber());
  param_00 setclientomnvar("ui_battlebuddy_idx", self getentitynumber());
}

motionblurhqenable() {
  return level.var_28CE[self.team];
}

func_1848(param_00) {
  if(!isDefined(level.var_28CE[param_00.team])) {
    level.var_28CE[param_00.team] = param_00;
    return;
  }

  if(level.var_28CE[param_00.team] != param_00) {}
}

func_E103(param_00) {
  if(isDefined(param_00.team) && isDefined(level.var_28CE[param_00.team]) && param_00 == level.var_28CE[param_00.team]) {
    level.var_28CE[param_00.team] = undefined;
  }
}

finalkillcam_victim() {
  if(level.onlinegame) {
    self.var_6D95 = self getsixthsensedirection();
    if(self.var_6D95.size >= 1) {
      foreach(var_01 in self.var_6D95) {
        if(func_9FD1(var_01)) {
          func_C88C(var_01);
        }
      }
    }
  }

  if(!func_8BD4()) {
    var_01 = motionblurhqenable();
    if(isDefined(var_01) && func_9FD1(var_01)) {
      func_C88C(var_01);
      return;
    }

    func_1848(self);
    self setclientomnvar("ui_battlebuddy_idx", -1);
  }
}

func_419D() {
  if(!isalive(self)) {
    func_FAAF();
  }

  self setclientomnvar("ui_battlebuddy_idx", -1);
  self.battlebuddy = undefined;
}

func_AB2B() {
  if(func_8BD4()) {
    var_00 = self.battlebuddy;
    func_419D();
    self setplayerdata("common", "enableBattleBuddy", 0);
    var_00 func_419D();
    var_00 finalkillcam_victim();
    return;
  }

  func_E103(self);
  self setclientomnvar("ui_battlebuddy_idx", -1);
}

func_AB2C() {
  if(func_8BD4()) {
    var_00 = self.battlebuddy;
    var_00 func_419D();
    var_00 finalkillcam_victim();
    var_00 func_419E();
    return;
  }

  foreach(var_03, var_02 in level.var_28CE) {
    if(var_02 == self) {
      level.var_28CE[var_03] = undefined;
      break;
    }
  }
}