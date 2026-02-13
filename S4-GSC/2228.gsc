/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2228.gsc
*************************************************/

_id_F151(var_0) {
  var_1 = isDefined(level._id_0408._id_F145) && level._id_0408._id_F145;
  level._id_0408._id_F145 = var_0;
  _id_F14F(var_0);

  if(!var_0 && var_1) {
    level notify("threat_sight_disabled");

    foreach(var_3 in level.players) {
      var_3._id_0408._id_F15C = undefined;
    }
  } else if(var_0 && !var_1)
    level notify("threat_sight_enabled");

  var_5 = _func_0070();

  foreach(var_7 in var_5) {
    if(isalive(var_7) && isDefined(var_7._id_0408) && isDefined(var_7._id_0408._id_F159)) {
      var_7 _id_F152(var_7._id_0408._id_F159);
    }
  }
}

_id_F14F(var_0) {
  setdvarifuninitialized("#x33652dbb6515e1cc0", 0.4);
  setdvarifuninitialized("#x329176a694c9087b4", 0.5);

  if(var_0 && (!isDefined(level._id_0408._id_F145) || !level._id_0408._id_F145)) {
    return;
  }
  setsaveddvar("#x3626563b2a3403c", var_0);
  level thread _id_F150(var_0);
}

_id_F150(var_0) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!var_0) {
    wait 1.0;
  }

  if(getdvarint("#x343d9aa76ad6e640c", 0)) {
    setsaveddvar("#x39899f58984254e82", var_0);
  }

  setDvar("#x356e6e6e82bc09635", var_0);
}

_id_F145() {
  if(!getdvarint("#x3626563b2a3403c")) {
    return 0;
  }

  if(self == level) {
    return isDefined(level._id_0408._id_F145) && level._id_0408._id_F145;
  }

  return isDefined(self._id_048C) && self._id_048C;
}

_id_F152(var_0) {
  if(isDefined(self._id_0408)) {
    self._id_0408._id_F159 = var_0;
  }

  if(!isDefined(level._id_0408._id_F145) || !level._id_0408._id_F145) {
    if(!istrue(self._id_F149)) {
      thread _id_F149();
      self._id_F149 = 1;
    }

    return;
  } else if(istrue(self._id_F149)) {
    self notify("threat_sight_immediate_thread");
    self._id_F149 = undefined;
  }

  switch (var_0) {
    case "hidden":
      self._id_048C = 1;
      self._id_0408._id_F144 = undefined;
      self._id_0408._id_F14A = undefined;
      break;
    case "investigate":
      self._id_048C = 1;
      break;
    case "flashlight_in_dark":
    case "combat_hunt":
      self._id_048C = 1;
      break;
    case "blind":
    case "spotted":
    case "death":
      self._id_048C = 0;
      break;
    default:
      break;
  }

  foreach(var_2 in level.players) {
    var_2 _id_F14B(self, var_0);
  }

  _id_F153(var_0);
}

_id_F153(var_0) {
  self[[level._id_0408._id_5DCC]](var_0);
}

_id_F149() {
  self notify("threat_sight_immediate_thread");
  self endon("threat_sight_immediate_thread");
  self endon("death");
  level endon("threat_sight_enabled");

  for(;;) {
    level scripts\engine\utility::_id_5C24("stealth_enabled");
    level scripts\engine\utility::_id_5C30("stealth_spotted");
    wait(randomfloatrange(0.4, 0.6));

    foreach(var_1 in level.players) {
      if(isDefined(var_1._id_7D10)) {
        continue;
      }
      if(var_1.ignoreme) {
        continue;
      }
      if(self _meth_8067(var_1)) {
        self _meth_8523("sight", var_1, var_1.origin);
      }
    }
  }
}

_id_F14D() {
  if(!isDefined(self._id_0408._id_F142)) {
    self._id_0408._id_F142 = [];
  }

  if(!isDefined(self._id_0408._id_F15E)) {
    self._id_0408._id_F15E = 0;
  }

  if(!isDefined(self._id_0408._id_F141)) {
    self._id_0408._id_F141 = 0;
  }

  if(!isDefined(self._id_0408._id_F15A)) {
    self._id_0408._id_F15A = [];
  }
}

_id_F14B(var_0, var_1) {
  _id_F14D();
  var_2 = var_0 getentitynumber();

  switch (var_1) {
    case "hidden":
      self._id_0408._id_F15A[var_2] = undefined;
      break;
    case "combat_hunt":
      var_0 _meth_8516(self, 0.0);
      break;
    case "investigate":
      if(isDefined(var_0._id_0192) && var_0._id_0192 == self) {
        var_0 _meth_8516(self, 1.0);
      }

      break;
    case "death":
      var_0 _meth_8516(self, 0.0);
      break;
  }

  switch (var_1) {
    case "death":
      self._id_0408._id_F142[var_2] = undefined;
      self._id_0408._id_F15A[var_2] = undefined;
      break;
    default:
      self._id_0408._id_F142[var_2] = var_0;
      break;
  }

  if(!isDefined(self._id_0408._id_F15C)) {
    self._id_0408._id_F15C = 1;
    thread _id_F14C();
  }
}

_id_F154(var_0) {
  self endon("death");
  self endon("stealth_idle");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = self getentitynumber();

  if(self[[self._id_5D99]]()) {
    self _meth_812E(var_0);
    self _meth_8523("combat", var_0, var_0.origin);
    return;
  }

  var_0._id_0408._id_F15A[var_1] = self;
  self _meth_8523("sight", var_0, var_0.origin);
  var_2 = var_0 getentitynumber();

  if(!isDefined(self._id_0408._id_F144)) {
    self._id_0408._id_F144 = [];
  }

  if(!isDefined(self._id_0408._id_F144[var_2])) {
    self._id_0408._id_F144[var_2] = 0;
  } else {
    self._id_0408._id_F144[var_2]++;
  }

  var_3 = _id_08B5::_id_1425(var_0);
  var_3 = var_3 / _func_01A6(2, self._id_0408._id_F144[var_2]);
  var_3 = var_3 * 1000;
  var_4 = gettime();

  if(scripts\common\utility::issp()) {
    self._id_0408._id_C081 = var_4 + var_3;
  }

  var_5 = var_4;
  var_6 = var_4 + var_3;

  while(gettime() < var_6) {
    if(istrue(self._id_0408._id_2572) || !isDefined(self._id_0408._id_F144) || !isDefined(self._id_0408._id_F144[var_2])) {
      break;
    }

    var_3 = _id_08B5::_id_1425(var_0);
    var_3 = var_3 / _func_01A6(2, self._id_0408._id_F144[var_2]);
    var_3 = var_3 * 1000;

    if(var_5 + var_3 < var_6) {
      var_6 = var_5 + var_3;
    }

    waitframe();
  }

  thread _id_F155(var_0);
}

_id_F155(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var_1);
  self endon("threat_sight_sighted_wait_lost_" + var_1);
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_2 = self getentitynumber();
  var_0._id_0408._id_F15A[var_2] = undefined;

  for(;;) {
    self._id_0408._id_F14A[var_1] = self _meth_8515(var_0) < 0.75;

    if(self._id_0408._id_F14A[var_1]) {
      return;
    }
    wait 0.05;
  }
}

_id_F147(var_0, var_1) {
  var_2 = gettime() + int(1000.0 * var_1);
  var_3 = var_0 getentitynumber();

  if(!isDefined(self._id_0408._id_5E71)) {
    self._id_0408._id_5E71 = [];
  }

  if(isDefined(self._id_0408._id_5E71[var_3])) {
    self._id_0408._id_5E71[var_3]._id_5284 = max(self._id_0408._id_5E71[var_3]._id_5284, var_2);
  } else {
    self._id_0408._id_5E71[var_3] = spawnStruct();
    self._id_0408._id_5E71[var_3]._id_5284 = var_2;
  }

  self._id_0408._id_5E71[var_3]._id_5469 = var_0;
  thread _id_F148();
}

_id_F148() {
  if(istrue(self._id_0408._id_5E72)) {
    return;
  }
  self notify("threat_sight_force_visible_thread");
  self endon("threat_sight_force_visible_thread");
  self endon("death");
  self._id_0408._id_5E72 = 1;
  var_0 = 0.05;
  var_1 = 0;

  while(isDefined(self._id_0408._id_5E71) && self._id_0408._id_5E71.size > 0) {
    var_2 = gettime();
    var_3 = [];
    var_4 = getdvarfloat("#x33652dbb6515e1cc0") * var_0;

    foreach(var_8, var_6 in self._id_0408._id_5E71) {
      if(var_2 < var_6._id_5284 && _func_011D(var_6._id_5469) && !self _meth_8067(var_6._id_5469)) {
        var_7 = self _meth_8515(var_6._id_5469);

        if(isPlayer(var_6._id_5469)) {
          var_6._id_5469 thread _id_F14E(1, max(var_6._id_5469._id_0408._id_9CAF, var_7));
        }

        if(var_7 + var_4 < getdvarfloat("#x329176a694c9087b4")) {
          var_7 = var_7 + var_4;
          self _meth_8516(var_6._id_5469, var_7);

          if(getdvarfloat("#x329176a694c9087b4") >= 1.0 && var_7 >= 1.0 && !var_1) {
            self _meth_8523("sight", var_6._id_5469, var_6._id_5469.origin);
            var_1 = 1;
          } else if(var_7 < 0.75 && var_1)
            var_1 = 0;
        }

        continue;
      }

      var_3[var_3.size] = var_8;
    }

    foreach(var_8 in var_3) {
      self._id_0408._id_5E71[var_8] = undefined;
    }

    wait(var_0);
  }

  self._id_0408._id_5E71 = undefined;
  self._id_0408._id_5E72 = undefined;
}

_id_F14C() {
  self endon("death");
  self endon("disconnect");
  self endon("death");
  level endon("threat_sight_disabled");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = 0;
    self._id_0408._id_9CAF = 0.0;
    self._id_0408._id_9C4F = -1;
    var_3 = self getEye();
    var_4 = cos(75);

    foreach(var_11, var_6 in self._id_0408._id_F142) {
      if(!isalive(var_6)) {
        continue;
      }
      var_7 = var_6 getentitynumber();
      self._id_0408._id_9C4F = max(self._id_0408._id_9C4F, var_6._id_0039);

      if(getdvarint("#x3626563b2a3403c", 1)) {
        if(var_6[[var_6._id_5D98]]()) {
          continue;
        }
        var_8 = var_6 _meth_8515(self);
        var_9 = var_6 _meth_8067(self);

        if(var_9) {
          var_0 = gettime();
        }

        if(var_9 && isPlayer(self) && var_8 > 0.09 && _id_B51A(var_6)) {
          var_6 _meth_8523("sight", self, self.origin);
          var_1 = 1;
        } else if(var_8 >= 1.0) {
          if(!isDefined(self._id_0408._id_F15A[var_7])) {
            var_6 thread _id_F154(self);
          }

          var_1 = 1;
        }

        var_10 = self._id_0408._id_9CAF;
        self._id_0408._id_9CAF = max(self._id_0408._id_9CAF, var_6 _meth_8515(self));

        if(self._id_0408._id_9CAF > 0.05) {
          if(!isDefined(self._id_0408._id_9CB0) || self._id_0408._id_9CAF != var_10) {
            self._id_0408._id_9CB0 = var_6;
          }
        }
      }

      if(var_6._id_0038 == "combat" || !var_6._id_048C) {
        var_2 = 1;
      }
    }

    var_12 = !var_2 && var_0 > 0 && gettime() - var_0 < 250;

    if(getdvarfloat("#x3113c50dea14159a1") <= 0.0) {
      thread _id_F14E(var_12, self._id_0408._id_9CAF);
    }

    self._id_0408._id_F15E = var_12;
    wait 0.05;
  }
}

_id_B51A(var_0) {
  return self issprinting() && scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0.origin, cos(20));
}

_id_F146(var_0, var_1) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("#x3113c50dea14159a1", var_1);
  setsaveddvar("#x32a2b9536ea20ffc7", var_0[0]);
  setsaveddvar("#x32a2b9436ea20fd94", var_0[1]);
  setsaveddvar("#x32a2b9736ea21042d", var_0[2]);

  if(!isDefined(self._id_0408._id_9CAF)) {
    self._id_0408._id_9CAF = 0;
  }

  while(var_1 > 0) {
    thread _id_F14E(1, max(self._id_0408._id_9CAF, var_1));
    wait 0.05;
  }

  thread _id_F14E(0, max(self._id_0408._id_9CAF, var_1));
}

_id_F14E(var_0, var_1, var_2) {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_5DCB)) {
    self thread[[level._id_0408._id_5DCB]](var_0, var_1, var_2);
  }
}