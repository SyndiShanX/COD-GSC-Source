/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3878.gsc
**************************************/

_id_117D3(var_0) {
  var_1 = isDefined(level._id_10E6D._id_117C3) && level._id_10E6D._id_117C3;
  level._id_10E6D._id_117C3 = var_0;
  _id_117D1(var_0);

  if(!var_0 && var_1) {
    level notify("threat_sight_disabled");

    foreach(var_3 in level.players)
    var_3._id_10E6D._id_117DD = undefined;
  } else if(var_0 && !var_1)
    level notify("threat_sight_enabled");

  var_5 = getaiarray();

  foreach(var_7 in var_5) {
    if(isalive(var_7) && isDefined(var_7._id_10E6D) && isDefined(var_7._id_10E6D._id_117DB))
      var_7 _id_117D4(var_7._id_10E6D._id_117DB);
  }
}

_id_117D1(var_0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);

  if(var_0 && (!isDefined(level._id_10E6D._id_117C3) || !level._id_10E6D._id_117C3)) {
    return;
  }
  setsaveddvar("ai_threatsight", var_0);
  level thread _id_117D2(var_0);
}

_id_117D2(var_0) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!var_0)
    wait 1.0;

  setsaveddvar("ai_threatsightDisplay", var_0);
}

_id_117C3() {
  if(!getdvarint("ai_threatsight"))
    return 0;

  if(self == level)
    return isDefined(level._id_10E6D._id_117C3) && level._id_10E6D._id_117C3;

  return isDefined(self.threatsight) && self.threatsight;
}

_id_117D4(var_0) {
  if(isDefined(self._id_10E6D))
    self._id_10E6D._id_117DB = var_0;

  if(!isDefined(level._id_10E6D._id_117C3) || !level._id_10E6D._id_117C3) {
    if(!scripts\engine\utility::is_true(self._id_117C9)) {
      thread _id_117C9();
      self._id_117C9 = 1;
    }

    return;
  } else if(scripts\engine\utility::is_true(self._id_117C9)) {
    self notify("threat_sight_immediate_thread");
    self._id_117C9 = undefined;
  }

  switch (var_0) {
    case "hidden":
      self.threatsight = 1;
      self._id_10E6D._id_117C2 = undefined;
      self._id_10E6D._id_117CA = undefined;
      break;
    case "investigate":
      self.threatsight = 1;
      break;
    case "spotted":
    case "death":
      self.threatsight = 0;
      break;
    default:
      break;
  }

  foreach(var_2 in level.players)
  var_2 _id_117CD(self, var_0);

  _id_117D5(var_0);
}

_id_117D5(var_0) {
  var_1 = 1.0;
  var_2 = 1.0;

  if(!isDefined(var_0))
    var_0 = self._id_10E6D._id_117DB;

  if(isDefined(self._id_10E6D._id_117EB))
    var_1 = var_1 * self._id_10E6D._id_117EB;

  if(isDefined(self._id_10E6D._id_117EA))
    var_1 = var_1 * self._id_10E6D._id_117EA;

  if(isDefined(level._id_10E6D._id_117EB))
    var_2 = var_2 * level._id_10E6D._id_117EB;

  if(isDefined(level._id_10E6D._id_117EA))
    var_2 = var_2 * level._id_10E6D._id_117EA;

  switch (var_0) {
    case "investigate":
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1.5 * var_1;
      self.threatsightratemax = 0.05 * var_1;
      break;
    default:
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 0.5 * var_1;
      self.threatsightratemax = 0.025 * var_1;
      break;
  }
}

_id_117C9() {
  self notify("threat_sight_immediate_thread");
  self endon("threat_sight_immediate_thread");
  self endon("death");
  level endon("threat_sight_enabled");

  for(;;) {
    level scripts\engine\utility::flag_wait("stealth_enabled");
    level scripts\engine\utility::flag_waitopen("stealth_spotted");
    wait(randomfloatrange(0.4, 0.6));

    foreach(var_1 in level.players) {
      if(self cansee(var_1))
        self _meth_84F7("sight", var_1, var_1.origin);
    }
  }
}

_id_117CF() {
  if(!isDefined(self._id_10E6D._id_117C0))
    self._id_10E6D._id_117C0 = [];

  if(!isDefined(self._id_10E6D._id_117DF))
    self._id_10E6D._id_117DF = 0;

  if(!isDefined(self._id_10E6D._id_117BF))
    self._id_10E6D._id_117BF = 0;

  if(!isDefined(self._id_10E6D._id_117DC))
    self._id_10E6D._id_117DC = [];
}

_id_117CD(var_0, var_1) {
  _id_117CF();
  var_2 = var_0 getentitynumber();

  switch (var_1) {
    case "hidden":
      self._id_10E6D._id_117DC[var_2] = undefined;
      break;
    case "investigate":
      if(isDefined(var_0.enemy) && var_0.enemy == self)
        var_0 _meth_84EA(self, 1.0);

      break;
    case "spotted":
      var_0 _meth_84EA(self, 1.0);
      break;
    case "death":
      var_0 _meth_84EA(self, 0.0);
      break;
  }

  switch (var_1) {
    case "death":
      self._id_10E6D._id_117C0[var_2] = undefined;
      self._id_10E6D._id_117DC[var_2] = undefined;
      break;
    default:
      self._id_10E6D._id_117C0[var_2] = var_0;
      break;
  }

  if(!isDefined(self._id_10E6D._id_117DD)) {
    self._id_10E6D._id_117DD = 1;
    thread _id_117CE();
  }
}

_id_117D6(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_1 = self getentitynumber();
  var_0._id_10E6D._id_117DC[var_1] = self;
  self _meth_84F7("sight", var_0, var_0.origin);
  var_2 = _id_0F27::_id_1B24(var_0);

  if(!isDefined(self._id_10E6D._id_117C2))
    self._id_10E6D._id_117C2 = 0;
  else
    self._id_10E6D._id_117C2++;

  var_2 = var_2 * (1.0 / pow(2, self._id_10E6D._id_117C2));
  wait(var_2);
  thread _id_117D7(var_0);
}

_id_117D7(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var_1);
  self endon("threat_sight_sighted_wait_lost_" + var_1);
  self endon("death");
  var_0 endon("disconnect");
  var_2 = self getentitynumber();
  var_0._id_10E6D._id_117DC[var_2] = undefined;

  for(;;) {
    self._id_10E6D._id_117CA = self _meth_84E9(var_0) < 0.75;

    if(self._id_10E6D._id_117CA) {
      return;
    }
    wait 0.05;
  }
}

_id_117C5(var_0, var_1) {
  var_2 = gettime() + int(1000.0 * var_1);
  var_3 = var_0 getentitynumber();

  if(!isDefined(self._id_10E6D._id_729B))
    self._id_10E6D._id_729B = [];

  if(isDefined(self._id_10E6D._id_729B[var_3]))
    self._id_10E6D._id_729B[var_3].end = max(self._id_10E6D._id_729B[var_3].end, var_2);
  else {
    self._id_10E6D._id_729B[var_3] = spawnStruct();
    self._id_10E6D._id_729B[var_3].end = var_2;
  }

  self._id_10E6D._id_729B[var_3].ent = var_0;
  thread _id_117C6();
}

_id_117C6() {
  if(scripts\engine\utility::is_true(self._id_10E6D._id_729C)) {
    return;
  }
  self notify("threat_sight_force_visible_thread");
  self endon("threat_sight_force_visible_thread");
  self endon("death");
  self._id_10E6D._id_729C = 1;
  var_0 = 0.05;
  var_1 = 0;

  while(isDefined(self._id_10E6D._id_729B) && self._id_10E6D._id_729B.size > 0) {
    var_2 = gettime();
    var_3 = [];
    var_4 = getdvarfloat("ai_threatForcedRate") * var_0;

    foreach(var_8, var_6 in self._id_10E6D._id_729B) {
      if(var_2 < var_6.end && issentient(var_6.ent) && !self cansee(var_6.ent)) {
        var_7 = self _meth_84E9(var_6.ent);

        if(isPlayer(var_6.ent))
          var_6.ent thread _id_117D0(1, max(var_6.ent._id_10E6D._id_B4CB, var_7));

        if(var_7 + var_4 < getdvarfloat("ai_threatForcedMax")) {
          var_7 = var_7 + var_4;
          self _meth_84EA(var_6.ent, var_7);

          if(getdvarfloat("ai_threatForcedMax") >= 1.0 && var_7 >= 1.0 && !var_1) {
            self _meth_84F7("sight", var_6.ent, var_6.ent.origin);
            var_1 = 1;
          } else if(var_7 < 0.75 && var_1)
            var_1 = 0;
        }

        continue;
      }

      var_3[var_3.size] = var_8;
    }

    foreach(var_8 in var_3)
    self._id_10E6D._id_729B[var_8] = undefined;

    wait(var_0);
  }

  self._id_10E6D._id_729B = undefined;
  self._id_10E6D._id_729C = undefined;
}

_id_117CE() {
  self endon("death");
  self endon("disconnect");
  level endon("threat_sight_disabled");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = 0;
    self._id_10E6D._id_B4CB = 0.0;
    self._id_10E6D._id_B476 = -1;
    var_3 = self getEye();
    var_4 = cos(90);

    foreach(var_13, var_6 in self._id_10E6D._id_117C0) {
      if(!isalive(var_6)) {
        continue;
      }
      var_7 = var_6 getentitynumber();
      self._id_10E6D._id_B476 = max(self._id_10E6D._id_B476, var_6.alertlevelint);

      if(getdvarint("ai_threatsight", 1)) {
        var_8 = var_6 _meth_84E9(self);
        var_9 = var_6 cansee(self);

        if(var_9)
          var_0 = gettime();

        if(var_8 >= 1.0) {
          if(!isDefined(self._id_10E6D._id_117DC[var_7]) && isDefined(var_6.enemy) && var_6.enemy == self)
            var_6 thread _id_117D6(self);

          var_1 = 1;
        }

        self._id_10E6D._id_B4CB = max(self._id_10E6D._id_B4CB, var_6 _meth_84E9(self));
        var_10 = var_9 && (scripts\engine\utility::is_true(level._id_10E6D._id_5659) || var_6 _id_0F22::_id_9B2C()) && var_8 > 0;

        if(var_10) {
          var_11 = vectorNormalize(var_3 - var_6 getEye());
          var_12 = anglestoright(var_6 gettagangles("j_spineupper"));
          var_10 = vectordot(var_11, var_12) > var_4;
        }

        if(var_10) {
          var_6._id_10E6D._id_B020 = self;
          var_6 _meth_8306(self);
        } else if(isDefined(var_6._id_10E6D._id_B020) && var_6._id_10E6D._id_B020 == self) {
          var_6._id_10E6D._id_B020 = undefined;
          var_6 _meth_8306();
        }
      }

      if(var_6.alertlevel == "combat" || !var_6.threatsight)
        var_2 = 1;
    }

    var_14 = !var_2 && var_0 > 0 && gettime() - var_0 < 250;

    if(getdvarfloat("ai_threatsightFakeThreat") <= 0.0)
      thread _id_117D0(var_14, self._id_10E6D._id_B4CB);

    self._id_10E6D._id_117DF = var_14;
    wait 0.05;
  }
}

_id_117C4(var_0, var_1) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("ai_threatsightFakeThreat", var_1);
  setsaveddvar("ai_threatsightFakeX", var_0[0]);
  setsaveddvar("ai_threatsightFakeY", var_0[1]);
  setsaveddvar("ai_threatsightFakeZ", var_0[2]);

  if(!isDefined(self._id_10E6D._id_B4CB))
    self._id_10E6D._id_B4CB = 0;

  while(var_1 > 0) {
    thread _id_117D0(1, max(self._id_10E6D._id_B4CB, var_1));
    wait 0.05;
  }

  thread _id_117D0(0, max(self._id_10E6D._id_B4CB, var_1));
}

_id_117D0(var_0, var_1, var_2) {
  var_3 = 180.0;
  var_4 = 0.01;
  var_5 = 0.05;
  var_6 = 0.125;
  self endon("disconnect");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  var_7 = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];

  if(!getdvarint("ai_threatsightdisplay", 0))
    var_1 = 0;

  if(!isDefined(self._id_10E6D._id_117D8) && var_0 && var_1 > 0) {
    self._id_10E6D._id_117D8 = [];
    self._id_10E6D._id_117DA = 0.0;
    self._id_10E6D._id_117D9 = 0.0;

    foreach(var_11, var_9 in var_7) {
      var_10 = spawn("script_origin", self.origin);
      var_10 linkTo(self);
      var_10 _meth_8278(0, 0.0);
      var_10._id_9F00 = 0;
      self._id_10E6D._id_117D8[var_9] = var_10;
    }
  }

  if(isDefined(self._id_10E6D._id_117D8)) {
    self._id_10E6D._id_117D9 = self._id_10E6D._id_117D9 - self._id_10E6D._id_117D9 * var_6;
    self._id_10E6D._id_117D9 = self._id_10E6D._id_117D9 + var_1 * var_6;

    if(self._id_10E6D._id_117D9 < 0.0001)
      self._id_10E6D._id_117D9 = 0.0;

    var_1 = self._id_10E6D._id_117D9;
  }

  while(isDefined(self._id_10E6D._id_117D8)) {
    var_11 = 0;
    var_12 = 0;

    if(var_1 > 0) {
      if(var_1 < var_5) {
        var_13 = clamp(var_1, 0, var_5);
        var_14 = var_13 / var_5;
        var_15 = 1.0 - var_4;
        var_16 = var_4 + var_15 * var_14;
        self._id_10E6D._id_117DA = var_16;
      } else
        self._id_10E6D._id_117DA = 1.0;
    } else {
      self._id_10E6D._id_117DA = 0.0;
      self._id_10E6D._id_117D9 = 0.0;
    }

    self._id_10E6D._id_117DA = clamp(self._id_10E6D._id_117DA, 0.0, 1.0);

    foreach(var_9, var_10 in self._id_10E6D._id_117D8) {
      var_18 = 1.0;

      switch (var_11) {
        case 0:
          if(var_1 < 0.75)
            var_18 = cos(var_3 * var_1 * 0.666);
          else
            var_18 = 0.0;

          break;
        case 1:
          if(var_1 < 0.75)
            var_18 = sin(var_3 * var_1 * 0.666);
          else if(var_1 < 1.0)
            var_18 = sin(var_3 * (1 - var_1) * 2.0);
          else
            var_18 = 0.0;

          break;
        case 2:
          if(var_1 < 0.75)
            var_18 = 0.0;
          else
            var_18 = cos(var_3 * (1 - var_1) * 2.0);

          break;
      }

      var_19 = clamp(self._id_10E6D._id_117DA * var_18, 0.0, 1.0);

      if(var_19 > 0) {
        var_12 = 1;

        if(var_10._id_9F00 == 0) {
          var_10 _meth_8278(0, 0.0);
          var_10 scripts\engine\utility::delaycall(0.05, ::playloopsound, var_9);
          var_10._id_9F00 = 1;
        }

        var_10 scripts\engine\utility::delaycall(0.0, ::_meth_8278, var_19, 0.05);
      } else if(var_10._id_9F00 == 1) {
        var_10 _meth_8278(0, 0.05);
        var_10 scripts\engine\utility::delaycall(0.05, ::stoploopsound);
        var_10._id_9F00 = 0;
      }

      var_11++;
    }

    if(!var_12) {
      foreach(var_9, var_10 in self._id_10E6D._id_117D8) {
        var_10 _meth_8278(0, 0.05);
        var_10 stoploopsound();
        var_10 scripts\engine\utility::delaycall(0.05, ::delete);
      }

      self._id_10E6D._id_117D8 = undefined;
      self._id_10E6D._id_117DA = undefined;
      self._id_10E6D._id_117D9 = undefined;
    }

    wait 0.05;
  }
}