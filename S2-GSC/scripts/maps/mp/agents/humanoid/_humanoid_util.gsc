/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid_util.gsc
**************************************************************/

_id_1F51(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  var_6 = 1;

  if(isDefined(self._id_64AB))
    var_6 = 0;

  return _func_293(var_4, self.radius, self._id_00BD - var_2, self, var_6, 0, 0, var_5);
}

_id_45C6() {
  return 8;
}

_id_457C() {
  return 360.0 / _id_45C6();
}

_id_60F4(var_0, var_1, var_2) {
  var_3 = var_1 * _id_457C() - 180.0;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

_id_4582(var_0) {
  return self._id_60F3[var_0];
}

_id_A275(var_0) {
  if(!isDefined(self._id_60F3))
    self._id_60F3 = [];

  if(!isDefined(self._id_60F3[var_0])) {
    self._id_60F3[var_0] = [];

    for(var_1 = 0; var_1 < _id_45C6(); var_1++) {
      self._id_60F3[var_0][var_1] = spawnStruct();
      self._id_60F3[var_0][var_1]._id_9A18 = 0;
      self._id_60F3[var_0][var_1]._id_230B = undefined;
      self._id_60F3[var_0][var_1].origin = undefined;
      self._id_60F3[var_0][var_1]._id_686A = var_1;
    }
  }
}

_id_45DC(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0._id_4883)) {
    var_1 = var_0._id_4883;

    if(isDefined(self._id_3043) && var_0 == self._id_3043 && _id_4B59()) {
      var_2 = _id_459E();

      if(isDefined(var_2))
        var_1 = var_2.origin;
    }
  } else if(isPlayer(var_0) && (var_0 _meth_83B8() || var_0 _meth_83B9())) {
    if(!isDefined(var_0._id_73F1))
      var_0._id_73F1 = 0;

    if(gettime() > var_0._id_73F1) {
      var_0._id_73F0 = _func_082(var_0.origin, 15);
      var_0._id_73F1 = gettime();
    }

    if(isDefined(var_0._id_73F0))
      var_1 = var_0._id_73F0;
  }

  return var_1;
}

_id_4BA3(var_0, var_1) {
  for(var_2 = 0; var_2 < _id_45C6(); var_2++) {
    var_3 = var_0 _id_4582(var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin))
      return 1;
  }

  return 0;
}

_id_1E52() {
  var_0 = self _meth_838A();

  if(isDefined(var_0)) {
    var_1 = _func_2B7(var_0);

    if(!isDefined(self._id_3043._id_663C))
      self._id_3043._id_663C = [];

    var_2 = 0;
    var_3 = 500;
    var_4 = undefined;

    for(var_5 = undefined; !isDefined(var_4) && var_3 <= 1500; var_3 = var_3 + 500) {
      var_6 = [];

      if(isDefined(level._id_663D))
        var_6 = _func_0B9(self._id_3043._id_4883, var_3, var_2, level._id_663D);
      else
        var_6 = _func_0B9(self._id_3043._id_4883, var_3, var_2);

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(_func_2B7(var_9) == var_1) {
          if(!isDefined(var_7) || _func_1F4(var_9, var_7, 1)) {
            var_4 = var_9;
            break;
          } else if(!isDefined(var_5))
            var_5 = var_9;
        }
      }

      var_2 = var_3;
    }

    if(isDefined(var_4))
      self._id_3043._id_663C[var_1] = var_4;
    else if(isDefined(var_5))
      self._id_3043._id_663C[var_1] = var_5;
    else
      self._id_3043._id_663C[var_1] = 0;
  }
}

_id_4B59() {
  var_0 = self _meth_838A();

  if(isDefined(var_0) && isDefined(self._id_3043._id_663C)) {
    var_1 = self._id_3043._id_663C[_func_2B7(var_0)];

    if(isDefined(var_1))
      return 1;
  }

  return 0;
}

_id_459E() {
  var_0 = self _meth_838A();
  var_1 = self._id_3043._id_663C[_func_2B7(var_0)];

  if(!_func_2A2(var_1))
    return var_1;
  else
    return undefined;
}

_id_8BAE() {
  if(_id_4B59()) {
    var_0 = _id_459E();

    if(!isDefined(var_0))
      return 0;
  }

  return 1;
}

_id_56DE(var_0) {
  if(isDefined(self._id_3043) && var_0 == self._id_3043) {
    if(self._id_3044 > 5)
      return 1;
  }

  return 0;
}

_id_4583(var_0, var_1) {
  var_0 _id_A275(self._id_60F5);
  var_2 = var_0 _id_4582(self._id_60F5);
  var_4 = var_1;
  var_5 = self.origin - var_4;
  var_6 = _func_0E5(var_5);

  if(var_6 < 256) {
    var_7 = -1;

    for(var_8 = 0; var_8 < _id_45C6(); var_8++) {
      var_9 = var_2[var_8];

      if(isDefined(var_9._id_230B) && var_9._id_230B == self)
        var_7 = var_9._id_686A;
    }

    if(var_7 < 0)
      var_7 = self getentitynumber() % _id_45C6();

    var_10 = var_7;
  } else {
    var_11 = _func_0DD(_func_109(var_5)) + 180.0;
    var_10 = var_11 / _id_457C();
    var_7 = int(var_10 + 0.5);
  }

  var_12 = undefined;
  var_13 = -1;
  var_14 = 3;
  var_15 = 2;

  if(var_10 > var_7) {
    var_13 = var_13 * -1;
    var_14 = var_14 * -1;
    var_15 = var_15 * -1;
  }

  var_16 = _id_45C6();

  for(var_17 = 0; var_17 < var_16 / 2 + 1; var_17++) {
    for(var_18 = var_13; var_18 != var_14; var_18 = var_18 + var_15) {
      var_19 = var_7 + var_17 * var_18;

      if(var_19 >= var_16)
        var_19 = var_19 - var_16;
      else if(var_19 < 0)
        var_19 = var_19 + var_16;

      var_9 = var_2[var_19];

      if(!isDefined(var_12) && gettime() - var_9._id_9A18 >= self._id_60F6) {
        if(isDefined(level._id_9E16) && isDefined(level._id_9E16[self._id_0A4B]))
          [[level._id_9E16[self._id_0A4B]]](var_9, var_4, self._id_11AB, self.radius);
        else
          _id_9E16(var_9, var_4, self._id_11AB, self.radius);
      }

      if(!isDefined(var_12) && isDefined(var_9.origin)) {
        var_20 = 0;

        if(isDefined(var_9._id_230B) && var_9._id_230B != self) {
          var_21 = vectorNormalize(var_4 - var_9._id_230B.origin) * self.radius * 2;
          var_20 = distancesquared(var_9._id_230B.origin + var_21, var_4);
        }

        if(!isalive(var_9._id_230B) || !isDefined(var_9._id_230B._id_28D2) || var_9._id_230B._id_28D2 != var_0 || var_9._id_230B == self || var_6 < var_20) {
          if(isDefined(var_9._id_230B) && var_9._id_230B != self) {
            var_9._id_230B notify("lostSectorClaim");
            var_9._id_230B._id_836C = undefined;
          }

          if(isDefined(self._id_836C) && self._id_836C != var_9)
            self._id_836C._id_230B = undefined;

          self._id_836C = var_9;
          var_9._id_230B = self;
          var_12 = var_9.origin;
          thread _id_63DD(var_9);
        }
      }

      if(var_17 == 0) {
        break;
      }
    }
  }

  return var_12;
}

_id_63DD(var_0) {
  level endon("game_ended");
  self notify("monitorSectorClaim");
  self endon("monitorSectorClaim");
  self endon("lostSectorClaim");
  common_scripts\utility::_id_A70A("death", "disconnect");
  var_0._id_230B = undefined;
}

_id_9E16(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0._id_9A18 >= 50) {
    var_0.origin = _id_60F4(var_1, var_0._id_686A, var_2);
    var_0.origin = _id_34AB(var_0.origin, var_3, self._id_00BD - 5);
    var_0._id_9A18 = gettime();
  }
}

_id_34AB(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 18;

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self _meth_83EB(var_4, var_5, var_1, var_2, 1);

  if(_func_0AE(var_6[2] - var_4[2]) < 0.1)
    return undefined;

  if(_func_0AE(var_6[2] - var_5[2]) < 0.1)
    return undefined;

  return var_6;
}

_id_56BC() {
  return isDefined(self._id_2FDA) && self._id_2FDA;
}

_id_4580() {
  if(!isDefined(self._id_5F4C) || self._id_5F4C)
    return self._id_60EF;
  else
    return self._id_60F0;
}

_id_4581() {
  if(!isDefined(self._id_5F4C) || self._id_5F4C)
    return self._id_60F2;
  else
    return self._id_60F1;
}

_id_5F4E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self._id_5F46 = var_0 * 1000.0;
  self._id_5F47 = var_4;
  self._id_5F45 = var_3;
  self._id_5F44 = isDefined(var_5) && var_5;
  self._id_5F49 = var_6;
  self._id_5F4F = var_2;
  self._id_5F50 = _func_0DA(self._id_5F4F);
  _id_0547::_id_86C7(var_1);
}

_id_5F4B() {
  if(isDefined(self._id_2F7D) && self._id_2F7D > 0) {
    self._id_2F7D--;

    if(self._id_2F7D > 0)
      return;
  }

  self._id_5F4C = 1;
}

_id_5F4A() {
  if(!isDefined(self._id_2F7D))
    self._id_2F7D = 0;

  self._id_2F7D++;
  self._id_5F4C = 0;
}

_id_3141(var_0, var_1, var_2, var_3) {
  self._id_313B = var_0 * 1000.0;
  self._id_313A = var_1;
  self._id_3139 = var_2;
  self._id_3137 = ["back", "right", "left"];
  self._id_3138 = [];

  foreach(var_6, var_5 in self._id_3137)
  self._id_3138[var_6] = level._effect[var_3 + var_5];
}

_id_313D() {
  if(isDefined(self._id_2F77) && self._id_2F77 > 0) {
    self._id_2F77--;

    if(self._id_2F77 > 0)
      return;
  }

  self._id_313E = 1;
}

_id_313C() {
  if(!isDefined(self._id_2F77))
    self._id_2F77 = 0;

  self._id_2F77++;
  self._id_313E = 0;
}

_id_5C5B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self._id_5C50 = var_0 * 1000.0;
  self._id_5C4F = var_1 * 1000.0;
  self._id_5C4E = var_2;
  self._id_5C57 = var_3;
  self._id_5C58 = _func_0DA(self._id_5C57);
  self._id_5C59 = var_4;
  self._id_5C5A = _func_0DA(self._id_5C59);
  self._id_5C54 = var_6;
  self._id_5C4D = var_5;
  self._id_5C55 = 0;
  self._id_5C56 = 0;
}

_id_5C52() {
  if(isDefined(self._id_2F7C) && self._id_2F7C > 0) {
    self._id_2F7C--;

    if(self._id_2F7C > 0)
      return;
  }

  self._id_5C53 = 1;
}

_id_5C51() {
  if(!isDefined(self._id_2F7C))
    self._id_2F7C = 0;

  self._id_2F7C++;
  self._id_5C53 = 0;
}

_id_20C3(var_0, var_1) {
  self endon("death");
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ChangeAnimClass");
  self._id_5381 = 1;
  self _meth_839B("face angle abs", (0, self.angles[1], 0));
  self _meth_839C("anim deltas");
  self _meth_839A(1, 1);
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_2, var_3, "change_anim_class");
  self _meth_83D5(var_0);
  _id_A18C();
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ChangeAnimClass");
  self._id_5381 = 0;
  self _meth_83A2(0);
}

_id_20C4(var_0) {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ChangeAnimClass");
  self._id_5381 = 0;
  self _meth_83A2(0);
  self _meth_83D5(var_0);
  _id_A18C();
  var_1 = "idle_noncombat";
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_2);
}

_id_A18C() {
  if(maps\mp\_utility::_id_585F()) {
    switch (self _meth_85A5()) {
      case "zombie_crawl_animclass":
      case "zombie_missing_left_leg_animclass":
      case "zombie_missing_right_leg_animclass":
        self _meth_85A1("zombie_crawler");
        break;
      default:
        self _meth_85A1("zombie");
    }
  } else {
    switch (self _meth_85A5()) {
      case "mp_zombie_crawl_animclass":
      case "mp_zombie_missing_left_leg_animclass":
      case "mp_zombie_missing_right_leg_animclass":
        self _meth_85A1("zombie_crawler");
        break;
      default:
        self _meth_85A1("zombie");
    }
  }
}

_id_8318(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self endon("death");
  self endon("ScriptedAnimationInterrupt");

  if(!isDefined(var_6))
    var_6 = 0;

  var_11 = [];

  if(!isDefined(var_7))
    var_7 = 0;

  if(var_7) {
    if(!_id_0547::_id_5816(var_8))
      var_11 = common_scripts\utility::_id_0F73(var_11, [level, var_8]);

    if(!_id_0547::_id_5816(var_9))
      var_11 = common_scripts\utility::_id_0F73(var_11, [self, var_9]);
  }

  var_12 = self _meth_83DB(var_2);
  var_4 = isDefined(var_4) && var_4;

  if(isDefined(var_12) && var_12 > 0) {
    self _meth_83A2(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");

    if(var_4)
      self._id_53D9 = 1;

    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", var_1);
    self _meth_839A(1, 1);
    var_13 = "noclip";

    if(isDefined(var_10) && isDefined(var_10["physMode"]))
      var_13 = var_10["physMode"];

    self _meth_839D(var_13);
    var_14 = undefined;

    if(!isDefined(var_3))
      var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    else if(isDefined(var_10) && isDefined(var_10["timeOffset"]))
      var_14 = _func_0AD(var_10["timeOffset"]);

    if(!var_6)
      _id_5CA6(var_2, var_3);

    self.origin = var_0;
    self.angles = var_1;

    if(var_7) {
      maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_2, var_3, 1, var_14);
      common_scripts\utility::_id_8133(common_scripts\utility::_id_A70E, var_11);
    } else {
      var_15 = "end";

      if(isDefined(var_10) && isDefined(var_10["end_notetrack"]))
        var_15 = var_10["end_notetrack"];

      maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_2, var_3, "scripted_anim", var_15, var_5, var_14);
    }

    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimation");

    if(var_4) {
      self._id_53D9 = undefined;
      _id_0547::_id_84CB();
    }

    self _meth_83A2(0);
  }
}

_id_5429() {
  self notify("ScriptedAnimationInterrupt");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimationInterrupt");
  self _meth_83A2(0);
}

_id_5CA6(var_0, var_1) {
  var_2 = 2;
  var_3 = self _meth_83D8(var_0, var_1);
  var_4 = _id_4552(var_3);
  var_5 = _id_462E(var_3, var_4);
  var_6 = _id_4718(var_3);
  var_5 = var_5 + (0, 0, var_6 + var_2);
  thread _id_6F54(var_5, var_4);
}

_id_4718(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = _func_083(var_0);
  var_4 = _func_112(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self _meth_83EB(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

_id_462E(var_0, var_1) {
  var_2 = _func_065(var_0);
  var_3 = var_1 / var_2;
  var_4 = _func_083(var_0, 0, var_3);
  var_5 = _func_112(var_4, self.angles);
  return self.origin + var_5;
}

_id_4552(var_0) {
  var_1 = 0.2;
  var_2 = _func_065(var_0);
  return _func_0AF(var_1, var_2);
}

_id_6F54(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");
  level endon("game_ended");
  self _meth_83A4(self.origin, var_0, var_1);
  wait(var_1);
  self _meth_839C("anim deltas");
}

_id_45F8(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0)
      var_2 = randomint(var_4);
    else
      var_2 = var_3 + randomint(var_4);
  }

  return var_2;
}

_id_56DD(var_0) {
  var_1 = self.origin[2] + self._id_00BD;

  if(var_0.origin[2] < var_1)
    return 0;

  var_2 = self.origin[2] + self._id_00BD + 2 * self.radius;

  if(var_0.origin[2] > var_2)
    return 0;

  if(isPlayer(var_0)) {
    var_3 = var_0 _meth_833D()[2];

    if(_func_0AE(var_3) > 12)
      return 0;
  }

  var_4 = 15.0;

  if(isDefined(var_0.radius))
    var_4 = var_0.radius;

  var_5 = self.radius + var_4;
  var_5 = var_5 * var_5;

  if(_func_211(self.origin, var_0.origin) > var_5)
    return 0;

  return 1;
}

_id_867E(var_0) {
  self._id_0094 = var_0;
  self _meth_8548(var_0);
}

_id_29CB(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectorNormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

_id_362B() {
  if(isDefined(self._id_2F79) && self._id_2F79 > 0) {
    self._id_2F79--;

    if(self._id_2F79 > 0)
      return;
  }

  self._id_4B6F = 1;
  _id_362D();
  _id_8859();
  _id_362C();
}

_id_2F43() {
  if(!isDefined(self._id_2F79))
    self._id_2F79 = 0;

  self._id_2F79++;
  _id_2F44();
  _id_2F45();
}

_id_4B31() {
  return common_scripts\utility::_id_562E(self._id_4B6F);
}

_id_362D() {
  self _meth_8538(1);
}

_id_2F45() {
  self _meth_8538(0);
}

_id_8859() {
  var_0 = clamp(level._id_A980 / 20, 0.0, 1.0);
  var_1 = _func_2CA(0.35, 0.55, var_0);
  var_2 = _func_2CA(0.06, 0.12, var_0);
  _id_5F4E(5.0, self._id_60F0 * 2, self._id_60F0 * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  _id_3141(5.0, var_1, "dodge_boost", "boost_dodge_");
  _id_5C5B(10.0, 2.0, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

_id_362C() {
  _id_5F4B();
  _id_313D();
  _id_5C52();
}

_id_2F44() {
  _id_5F4A();
  _id_313C();
  _id_5C51();
}

_id_70C9(var_0) {
  if(!isDefined(self._id_1919)) {
    return;
  }
  if(self._id_1919 != "no_boost_fx")
    _func_147(var_0, self, self._id_1919);
}

_id_3B85(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(_id_0547::_id_577E(var_3))
      var_1[var_1.size] = var_3;
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(_id_0547::_id_6719(var_7)) {
      continue;
    }
    var_8 = 0;

    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  return var_5;
}

_id_AA51(var_0) {
  if(!isDefined(var_0))
    var_0 = self._id_28D2;

  if(_id_4580() == self._id_60F0)
    return _id_AA52(var_0);

  var_1 = distancesquared(self.origin, var_0.origin) <= _id_4581();
  return var_1;
}

_id_AA52(var_0) {
  if(!isDefined(var_0))
    var_0 = self._id_28D2;

  var_1 = distancesquared(self.origin, var_0.origin) <= self._id_60F1;

  if(!var_1 && (isPlayer(var_0) || _func_1EF(var_0))) {
    var_2 = var_0 _meth_8551();

    if(isDefined(var_2) && isDefined(var_2.targetname) && var_2.targetname == "care_package")
      var_1 = distancesquared(self.origin, var_0.origin) <= self._id_60F1 * 4;
  }

  if(!var_1 && isPlayer(var_0) && common_scripts\utility::_id_562E(var_0._id_571F)) {
    if(length(self _meth_833D()) < 5)
      var_1 = distancesquared(self.origin, var_0.origin) <= self._id_60F1 * 4;
  }

  return var_1;
}