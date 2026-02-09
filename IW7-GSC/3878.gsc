/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3878.gsc
*********************************************/

func_117D3(var_0) {
  var_1 = isDefined(level.var_10E6D.var_117C3) && level.var_10E6D.var_117C3;
  level.var_10E6D.var_117C3 = var_0;
  func_117D1(var_0);
  if(!var_0 && var_1) {
    level notify("threat_sight_disabled");
    foreach(var_3 in level.players) {
      var_3.var_10E6D.var_117DD = undefined;
    }
  } else if(var_0 && !var_1) {
    level notify("threat_sight_enabled");
  }

  var_5 = getaiarray();
  foreach(var_7 in var_5) {
    if(isalive(var_7) && isDefined(var_7.var_10E6D) && isDefined(var_7.var_10E6D.var_117DB)) {
      var_7 func_117D4(var_7.var_10E6D.var_117DB);
    }
  }
}

func_117D1(var_0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);
  if(var_0 && !isDefined(level.var_10E6D.var_117C3) || !level.var_10E6D.var_117C3) {
    return;
  }

  setsaveddvar("ai_threatsight", var_0);
  level thread func_117D2(var_0);
}

func_117D2(var_0) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");
  if(!var_0) {
    wait(1);
  }

  setsaveddvar("ai_threatsightDisplay", var_0);
}

func_117C3() {
  if(!getdvarint("ai_threatsight")) {
    return 0;
  }

  if(self == level) {
    return isDefined(level.var_10E6D.var_117C3) && level.var_10E6D.var_117C3;
  }

  return isDefined(self.var_341) && self.var_341;
}

func_117D4(var_0) {
  if(isDefined(self.var_10E6D)) {
    self.var_10E6D.var_117DB = var_0;
  }

  if(!isDefined(level.var_10E6D.var_117C3) || !level.var_10E6D.var_117C3) {
    if(!scripts\engine\utility::istrue(self.var_117C9)) {
      thread func_117C9();
      self.var_117C9 = 1;
    }

    return;
  } else if(scripts\engine\utility::istrue(self.var_117C9)) {
    self notify("threat_sight_immediate_thread");
    self.var_117C9 = undefined;
  }

  switch (var_0) {
    case "hidden":
      self.var_341 = 1;
      self.var_10E6D.var_117C2 = undefined;
      self.var_10E6D.var_117CA = undefined;
      break;

    case "investigate":
      self.var_341 = 1;
      break;

    case "spotted":
    case "death":
      self.var_341 = 0;
      break;

    default:
      break;
  }

  foreach(var_2 in level.players) {
    var_2 func_117CD(self, var_0);
  }

  func_117D5(var_0);
}

func_117D5(var_0) {
  var_1 = 1;
  var_2 = 1;
  if(!isDefined(var_0)) {
    var_0 = self.var_10E6D.var_117DB;
  }

  if(isDefined(self.var_10E6D.var_117EB)) {
    var_1 = var_1 * self.var_10E6D.var_117EB;
  }

  if(isDefined(self.var_10E6D.var_117EA)) {
    var_1 = var_1 * self.var_10E6D.var_117EA;
  }

  if(isDefined(level.var_10E6D.var_117EB)) {
    var_2 = var_2 * level.var_10E6D.var_117EB;
  }

  if(isDefined(level.var_10E6D.var_117EA)) {
    var_2 = var_2 * level.var_10E6D.var_117EA;
  }

  switch (var_0) {
    case "investigate":
      self.var_343 = 256 * var_2;
      self.var_342 = 1024 * var_2;
      self.var_345 = 1.5 * var_1;
      self.var_344 = 0.05 * var_1;
      break;

    default:
      self.var_343 = 256 * var_2;
      self.var_342 = 1024 * var_2;
      self.var_345 = 0.5 * var_1;
      self.var_344 = 0.025 * var_1;
      break;
  }
}

func_117C9() {
  self notify("threat_sight_immediate_thread");
  self endon("threat_sight_immediate_thread");
  self endon("death");
  level endon("threat_sight_enabled");
  for(;;) {
    level scripts\engine\utility::flag_wait("stealth_enabled");
    level scripts\engine\utility::flag_waitopen("stealth_spotted");
    wait(randomfloatrange(0.4, 0.6));
    foreach(var_1 in level.players) {
      if(self cansee(var_1)) {
        self func_84F7("sight", var_1, var_1.origin);
      }
    }
  }
}

func_117CF() {
  if(!isDefined(self.var_10E6D.var_117C0)) {
    self.var_10E6D.var_117C0 = [];
  }

  if(!isDefined(self.var_10E6D.var_117DF)) {
    self.var_10E6D.var_117DF = 0;
  }

  if(!isDefined(self.var_10E6D.var_117BF)) {
    self.var_10E6D.var_117BF = 0;
  }

  if(!isDefined(self.var_10E6D.var_117DC)) {
    self.var_10E6D.var_117DC = [];
  }
}

func_117CD(var_0, var_1) {
  func_117CF();
  var_2 = var_0 getentitynumber();
  switch (var_1) {
    case "hidden":
      self.var_10E6D.var_117DC[var_2] = undefined;
      break;

    case "investigate":
      if(isDefined(var_0.enemy) && var_0.enemy == self) {
        var_0 func_84EA(self, 1);
      }
      break;

    case "spotted":
      var_0 func_84EA(self, 1);
      break;

    case "death":
      var_0 func_84EA(self, 0);
      break;
  }

  switch (var_1) {
    case "death":
      self.var_10E6D.var_117C0[var_2] = undefined;
      self.var_10E6D.var_117DC[var_2] = undefined;
      break;

    default:
      self.var_10E6D.var_117C0[var_2] = var_0;
      break;
  }

  if(!isDefined(self.var_10E6D.var_117DD)) {
    self.var_10E6D.var_117DD = 1;
    thread func_117CE();
  }
}

func_117D6(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_1 = self getentitynumber();
  var_0.var_10E6D.var_117DC[var_1] = self;
  self func_84F7("sight", var_0, var_0.origin);
  var_2 = lib_0F27::func_1B24(var_0);
  if(!isDefined(self.var_10E6D.var_117C2)) {
    self.var_10E6D.var_117C2 = 0;
  } else {
    self.var_10E6D.var_117C2++;
  }

  var_2 = var_2 * 1 / pow(2, self.var_10E6D.var_117C2);
  wait(var_2);
  thread func_117D7(var_0);
}

func_117D7(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var_1);
  self endon("threat_sight_sighted_wait_lost_" + var_1);
  self endon("death");
  var_0 endon("disconnect");
  var_2 = self getentitynumber();
  var_0.var_10E6D.var_117DC[var_2] = undefined;
  for(;;) {
    self.var_10E6D.var_117CA = self func_84E9(var_0) < 0.75;
    if(self.var_10E6D.var_117CA) {
      return;
    }

    wait(0.05);
  }
}

func_117C5(var_0, var_1) {
  var_2 = gettime() + int(1000 * var_1);
  var_3 = var_0 getentitynumber();
  if(!isDefined(self.var_10E6D.var_729B)) {
    self.var_10E6D.var_729B = [];
  }

  if(isDefined(self.var_10E6D.var_729B[var_3])) {
    self.var_10E6D.var_729B[var_3].end = max(self.var_10E6D.var_729B[var_3].end, var_2);
  } else {
    self.var_10E6D.var_729B[var_3] = spawnStruct();
    self.var_10E6D.var_729B[var_3].end = var_2;
  }

  self.var_10E6D.var_729B[var_3].ent = var_0;
  thread func_117C6();
}

func_117C6() {
  if(scripts\engine\utility::istrue(self.var_10E6D.var_729C)) {
    return;
  }

  self notify("threat_sight_force_visible_thread");
  self endon("threat_sight_force_visible_thread");
  self endon("death");
  self.var_10E6D.var_729C = 1;
  var_0 = 0.05;
  var_1 = 0;
  while(isDefined(self.var_10E6D.var_729B) && self.var_10E6D.var_729B.size > 0) {
    var_2 = gettime();
    var_3 = [];
    var_4 = getdvarfloat("ai_threatForcedRate") * var_0;
    foreach(var_8, var_6 in self.var_10E6D.var_729B) {
      if(var_2 < var_6.end && issentient(var_6.ent) && !self cansee(var_6.ent)) {
        var_7 = self func_84E9(var_6.ent);
        if(isPlayer(var_6.ent)) {
          var_6.ent thread func_117D0(1, max(var_6.ent.var_10E6D.var_B4CB, var_7));
        }

        if(var_7 + var_4 < getdvarfloat("ai_threatForcedMax")) {
          var_7 = var_7 + var_4;
          self func_84EA(var_6.ent, var_7);
          if(getdvarfloat("ai_threatForcedMax") >= 1 && var_7 >= 1 && !var_1) {
            self func_84F7("sight", var_6.ent, var_6.ent.origin);
            var_1 = 1;
          } else if(var_7 < 0.75 && var_1) {
            var_1 = 0;
          }
        }

        continue;
      }

      var_3[var_3.size] = var_8;
    }

    foreach(var_8 in var_3) {
      self.var_10E6D.var_729B[var_8] = undefined;
    }

    wait(var_0);
  }

  self.var_10E6D.var_729B = undefined;
  self.var_10E6D.var_729C = undefined;
}

func_117CE() {
  self endon("death");
  self endon("disconnect");
  level endon("threat_sight_disabled");
  var_0 = 0;
  for(;;) {
    var_1 = 0;
    var_2 = 0;
    self.var_10E6D.var_B4CB = 0;
    self.var_10E6D.var_B476 = -1;
    var_3 = self getEye();
    var_4 = cos(90);
    foreach(var_6 in self.var_10E6D.var_117C0) {
      if(!isalive(var_6)) {
        continue;
      }

      var_7 = var_6 getentitynumber();
      self.var_10E6D.var_B476 = max(self.var_10E6D.var_B476, var_6.var_29);
      if(getdvarint("ai_threatsight", 1)) {
        var_8 = var_6 func_84E9(self);
        var_9 = var_6 cansee(self);
        if(var_9) {
          var_0 = gettime();
        }

        if(var_8 >= 1) {
          if(!isDefined(self.var_10E6D.var_117DC[var_7]) && isDefined(var_6.enemy) && var_6.enemy == self) {
            var_6 thread func_117D6(self);
          }

          var_1 = 1;
        }

        self.var_10E6D.var_B4CB = max(self.var_10E6D.var_B4CB, var_6 func_84E9(self));
        var_10 = var_9 && scripts\engine\utility::istrue(level.var_10E6D.var_5659) || var_6 lib_0F22::func_9B2C() && var_8 > 0;
        if(var_10) {
          var_11 = vectornormalize(var_3 - var_6 getEye());
          var_12 = anglestoright(var_6 gettagangles("j_spineupper"));
          var_10 = vectordot(var_11, var_12) > var_4;
        }

        if(var_10) {
          var_6.var_10E6D.var_B020 = self;
          var_6 func_8306(self);
        } else if(isDefined(var_6.var_10E6D.var_B020) && var_6.var_10E6D.var_B020 == self) {
          var_6.var_10E6D.var_B020 = undefined;
          var_6 func_8306();
        }
      }

      if(var_6.var_28 == "combat" || !var_6.var_341) {
        var_2 = 1;
      }
    }

    var_14 = !var_2 && var_0 > 0 && gettime() - var_0 < 250;
    if(getdvarfloat("ai_threatsightFakeThreat") <= 0) {
      thread func_117D0(var_14, self.var_10E6D.var_B4CB);
    }

    self.var_10E6D.var_117DF = var_14;
    wait(0.05);
  }
}

func_117C4(var_0, var_1) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("ai_threatsightFakeThreat", var_1);
  setsaveddvar("ai_threatsightFakeX", var_0[0]);
  setsaveddvar("ai_threatsightFakeY", var_0[1]);
  setsaveddvar("ai_threatsightFakeZ", var_0[2]);
  if(!isDefined(self.var_10E6D.var_B4CB)) {
    self.var_10E6D.var_B4CB = 0;
  }

  while(var_1 > 0) {
    thread func_117D0(1, max(self.var_10E6D.var_B4CB, var_1));
    wait(0.05);
  }

  thread func_117D0(0, max(self.var_10E6D.var_B4CB, var_1));
}

func_117D0(var_0, var_1, var_2) {
  var_3 = 180;
  var_4 = 0.01;
  var_5 = 0.05;
  var_6 = 0.125;
  self endon("disconnect");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  var_7 = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
  if(!getdvarint("ai_threatsightdisplay", 0)) {
    var_1 = 0;
  }

  if(!isDefined(self.var_10E6D.var_117D8) && var_0 && var_1 > 0) {
    self.var_10E6D.var_117D8 = [];
    self.var_10E6D.var_117DA = 0;
    self.var_10E6D.var_117D9 = 0;
    foreach(var_9 in var_7) {
      var_10 = spawn("script_origin", self.origin);
      var_10 linkto(self);
      var_10 ghostattack(0, 0);
      var_10.var_9F00 = 0;
      self.var_10E6D.var_117D8[var_9] = var_10;
    }
  }

  if(isDefined(self.var_10E6D.var_117D8)) {
    self.var_10E6D.var_117D9 = self.var_10E6D.var_117D9 - self.var_10E6D.var_117D9 * var_6;
    self.var_10E6D.var_117D9 = self.var_10E6D.var_117D9 + var_1 * var_6;
    if(self.var_10E6D.var_117D9 < 0.0001) {
      self.var_10E6D.var_117D9 = 0;
    }

    var_1 = self.var_10E6D.var_117D9;
  }

  while(isDefined(self.var_10E6D.var_117D8)) {
    var_11 = 0;
    var_12 = 0;
    if(var_1 > 0) {
      if(var_1 < var_5) {
        var_13 = clamp(var_1, 0, var_5);
        var_14 = var_13 / var_5;
        var_15 = 1 - var_4;
        var_10 = var_4 + var_15 * var_14;
        self.var_10E6D.var_117DA = var_10;
      } else {
        self.var_10E6D.var_117DA = 1;
      }
    } else {
      self.var_10E6D.var_117DA = 0;
      self.var_10E6D.var_117D9 = 0;
    }

    self.var_10E6D.var_117DA = clamp(self.var_10E6D.var_117DA, 0, 1);
    foreach(var_9, var_10 in self.var_10E6D.var_117D8) {
      var_12 = 1;
      switch (var_11) {
        case 0:
          if(var_1 < 0.75) {
            var_12 = cos(var_3 * var_1 * 0.666);
          } else {
            var_12 = 0;
          }
          break;

        case 1:
          if(var_1 < 0.75) {
            var_12 = sin(var_3 * var_1 * 0.666);
          } else if(var_1 < 1) {
            var_12 = sin(var_3 * 1 - var_1 * 2);
          } else {
            var_12 = 0;
          }
          break;

        case 2:
          if(var_1 < 0.75) {
            var_12 = 0;
          } else {
            var_12 = cos(var_3 * 1 - var_1 * 2);
          }
          break;
      }

      var_13 = clamp(self.var_10E6D.var_117DA * var_12, 0, 1);
      if(var_13 > 0) {
        var_12 = 1;
        if(var_10.var_9F00 == 0) {
          var_10 ghostattack(0, 0);
          var_10 scripts\engine\utility::delaycall(0.05, ::playloopsound, var_9);
          var_10.var_9F00 = 1;
        }

        var_10 scripts\engine\utility::delaycall(0, ::ghostattack, var_13, 0.05);
      } else if(var_10.var_9F00 == 1) {
        var_10 ghostattack(0, 0.05);
        var_10 scripts\engine\utility::delaycall(0.05, ::stoploopsound);
        var_10.var_9F00 = 0;
      }

      var_11++;
    }

    if(!var_12) {
      foreach(var_10 in self.var_10E6D.var_117D8) {
        var_10 ghostattack(0, 0.05);
        var_10 stoploopsound();
        var_10 scripts\engine\utility::delaycall(0.05, ::delete);
      }

      self.var_10E6D.var_117D8 = undefined;
      self.var_10E6D.var_117DA = undefined;
      self.var_10E6D.var_117D9 = undefined;
    }

    wait(0.05);
  }
}