/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1480.gsc
**************************************/

_id_3AD6() {
  if(isDefined(level._id_3AD7)) {
    return;
  }
  level._id_3AD7 = 1;
  level._effect["riot_shield_dmg"] = loadfx("misc/riot_shield_dmg");

  if(maps\_utility::_id_0A36()) {
    var_0 = [];

    if(!maps\_utility::_id_12DC()) {
      var_0[var_0.size] = "@DEADQUOTE_RIOTSHIELD_USE_EXPLOSIVE";

    }
    var_0[var_0.size] = "@DEADQUOTE_RIOTSHIELD_OUT_FLANK";
    var_0[var_0.size] = "@DEADQUOTE_RIOTSHIELD_DONT_CHARGE";
    maps\_specialops::_id_1842(var_0);
  }

  if(!isDefined(level._id_2106)) {
    level._id_2106 = [];

  }
  level._id_2106["riotshield"] = ::_id_3AD8;
  animscripts\riotshield\riotshield::_id_3AB4();
}

_id_3AD8() {
  animscripts\riotshield\riotshield::_id_3AB8();
}

_id_3ACC() {
  animscripts\riotshield\riotshield::_id_3ACC();
}

_id_3ACD() {
  animscripts\riotshield\riotshield::_id_3ACD();
}

_id_3ACE() {
  animscripts\riotshield\riotshield::_id_3ACE();
}

_id_3ACF() {
  animscripts\riotshield\riotshield::_id_3ACF();
}

_id_3AD9() {
  if(self.subclass != "riotshield") {
    return;
  }
  self.combatmode = "cover";
  self.goalradius = 2048;
  animscripts\riotshield\riotshield::_id_3AD1();
  var_0 = self findbestcovernode();

  if(isDefined(var_0)) {
    self usecovernode(var_0);
  }
}

_id_3ADA(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_5.combatmode != "no_cover") {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_7 = spawnStruct();

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_1124) && isDefined(var_5._id_1124._id_1F41)) {
      var_5._id_1124._id_1F41 = common_scripts\utility::array_remove(var_5._id_1124._id_1F41, var_5);

    }
    var_5._id_1124 = var_7;
  }

  var_7._id_1F41 = var_3;
  var_7._id_3ADB = 1;
  var_7._id_3ADC = 50;
  var_7 thread _id_3AE1();
  return var_7;
}

_id_3ADD(var_0, var_1) {
  self._id_1F41 = maps\_utility::_id_1361(self._id_1F41);
  self.forward = var_0;

  if(isDefined(var_1)) {
    self._id_3ADC = var_1;

  }
  foreach(var_3 in self._id_1F41) {
    var_3.goalradius = 25;
    var_3.pathenemyfightdist = 128;
    var_3.pathenemylookahead = 128;
  }

  _id_3AE0();
  thread _id_3AE5();
}

_id_3ADE() {
  self endon("break_group");

  if(self._id_1F41.size == 0) {
    return;
  }
  while(self._id_1F41.size) {
    maps\_utility::_id_2635(self._id_1F41, 1);

    if(self._id_3ADF != "stopped") {
      self waittill("goal");

    }
    self._id_1F41 = maps\_utility::_id_1361(self._id_1F41);
    _id_3AE0();
  }
}

_id_3AE0(var_0) {
  if(self._id_1F41.size == 0) {
    return;
  }
  if(isDefined(var_0)) {
    self.forward = var_0;
  } else {
    var_0 = self.forward;

  }
  var_1 = _id_3AED();
  var_2 = (self.forward[1], -1 * self.forward[0], 0);
  var_3 = var_2 * self._id_3ADC;
  var_4 = _id_3AE2(var_1, var_3);
  var_5 = [];

  for(var_6 = 0; var_6 < self._id_1F41.size; var_6++) {
    if(isDefined(self._id_1F41[var_6])) {
      var_5[var_6] = vectordot(var_4 - self._id_1F41[var_6].origin, var_2);
      continue;
    }

    var_5[var_6] = 0;
  }

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_8 = self._id_1F41[var_6];

    for(var_9 = var_6 - 1; var_9 >= 0; var_9--) {
      if(var_7 < var_5[var_9]) {
        break;
      }

      var_5[var_9 + 1] = var_5[var_9];
      self._id_1F41[var_9 + 1] = self._id_1F41[var_9];
    }

    var_5[var_9 + 1] = var_7;
    self._id_1F41[var_9 + 1] = var_8;
  }
}

_id_3AE1() {
  for(;;) {
    if(self._id_3ADB > 0) {
      self._id_1F41 = maps\_utility::_id_1361(self._id_1F41);

      if(self._id_1F41.size <= self._id_3ADB) {
        foreach(var_1 in self._id_1F41) {}
        var_1 _id_3AD9();

        self notify("break_group");
        break;
      }
    }

    wait 1;
  }
}

_id_3AE2(var_0, var_1) {
  return var_0 - (self._id_1F41.size - 1) / 2 * var_1;
}

_id_3AE3(var_0, var_1) {
  self notify("new_goal_set");
  self._id_3ADF = "moving";

  if(isDefined(var_1)) {
    self.forward = var_1;
  } else {
    var_1 = self.forward;

  }
  var_2 = (var_1[1], -1 * var_1[0], 0);
  var_3 = var_2 * self._id_3ADC;
  var_4 = _id_3AE2(var_0, var_3);

  for(var_5 = 0; var_5 < self._id_1F41.size; var_5++) {
    var_6 = self._id_1F41[var_5];

    if(isDefined(var_6)) {
      var_6 setgoalpos(var_4);

    }
    var_4 = var_4 + var_3;
  }

  thread _id_3AE4();
}

_id_3AE4() {
  self endon("new_goal_set");

  for(;;) {
    wait 0.5;
    var_0 = 0;

    foreach(var_2 in self._id_1F41) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_0++;
      }
    }

    var_4 = 0;

    for(var_5 = 0; var_5 < self._id_1F41.size; var_5++) {
      var_2 = self._id_1F41[var_5];

      if(isDefined(var_2)) {
        var_6 = max(45, var_2.goalradius);

        if(distancesquared(var_2.origin, var_2.goalpos) < squared(var_6)) {
          var_4++;
        }
      }
    }

    if(var_4 == var_0) {
      self notify("goal");
      self._id_3ADF = "stopped";
    }
  }
}

_id_3AE5() {
  self endon("break_group");

  for(;;) {
    wait 0.5;
    var_0 = 0;

    foreach(var_2 in self._id_1F41) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_0++;
      }
    }

    var_4 = 0;
    var_5 = vectortoyaw(self.forward);

    for(var_6 = 0; var_6 < self._id_1F41.size; var_6++) {
      var_2 = self._id_1F41[var_6];

      if(isDefined(var_2)) {
        if(abs(var_2.angles[1] - var_5) < 45) {
          var_4++;
        }
      }
    }

    if(var_4 == var_0) {
      self notify("goal_yaw");
    }
  }
}

_id_3AE6() {
  foreach(var_1 in self._id_1F41) {
    if(isalive(var_1)) {
      var_1 _id_3ACC();
    }
  }
}

_id_3AE7() {
  foreach(var_1 in self._id_1F41) {
    if(isalive(var_1)) {
      var_1 _id_3ACD();
    }
  }
}

_id_3AE8() {
  foreach(var_1 in self._id_1F41) {
    if(isalive(var_1)) {
      var_1 _id_3ACE();
    }
  }
}

_id_3AE9() {
  foreach(var_1 in self._id_1F41) {
    if(isalive(var_1)) {
      var_1 _id_3ACF();
    }
  }
}

_id_3AEA(var_0) {
  self.forward = var_0;
  var_1 = vectortoyaw(var_0);

  foreach(var_3 in self._id_1F41) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.enemy) && distancesquared(var_3.origin, var_3.enemy.origin) < squared(var_3.pathenemyfightdist)) {
      continue;
    }
    var_3 orientmode("face angle", var_1);
    var_3.lockorientation = 1;
  }

  wait 0.1;
}

_id_3AEB() {
  foreach(var_1 in self._id_1F41) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 orientmode("face default");
    var_1.lockorientation = 0;
  }
}

_id_3AEC() {
  _id_3AEB();

  foreach(var_1 in self._id_1F41) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1.goalradius = 2048;
    var_1.pathenemyfightdist = 400;
    var_1.pathenemylookahead = 400;
  }
}

_id_3AED() {
  var_0 = (0, 0, 0);
  var_1 = 0;

  foreach(var_3 in self._id_1F41) {
    if(isDefined(var_3)) {
      var_0 = var_0 + var_3.origin;
      var_1++;
    }
  }

  if(var_1) {
    var_0 = 1 / var_1 * var_0;

  }
  return var_0;
}