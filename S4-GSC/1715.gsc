/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1715.gsc
*************************************************/

_id_9D81(var_0) {
  self endon("melee_finished");
  self waittill("terminate_ai_threads");
  _id_06BD::_id_23B1();
}

_id_9D4C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_0192;
  }

  if(isDefined(self._id_9D39)) {
    _id_9D43();
  }

  _id_06BD::_id_2409(var_1);

  if(scripts\common\utility::_id_854B("melee_rusher") && isDefined(self._id_9D39)) {
    self._id_9D39._id_2505 = 1;
    self._id_9D39._id_2504 = 1;
  }

  self._id_9D39._id_EF2C = var_0;
  var_1._id_9D39._id_EF2C = var_0;
  _id_06BD::_id_23B5();
  _id_06BD::_id_23EE(0);
  return anim._id_EACB;
}

_id_9D43() {
  self _meth_84C0(1);

  if(isDefined(self._id_9D39)) {
    if(isDefined(self._id_9D39.target)) {
      self._id_9D39.target._id_9D39 = undefined;
    }

    self._id_9D39 = undefined;
  }
}

_id_31E5(var_0) {
  if(isDefined(self._id_9D39)) {
    return 0;
  }

  if(!isDefined(self._id_9D6D) || !self._id_9D6D) {
    return 0;
  }

  if(!isDefined(var_0._id_9D39)) {
    return 0;
  }

  var_1 = var_0._id_9D39._id_AE83;

  if(!isDefined(var_1) || !isDefined(var_1._id_9D39)) {
    return 0;
  }

  if(isDefined(var_1._id_9D39._id_242E)) {
    return 0;
  }

  var_2 = distance(var_0.origin, self.origin);
  var_3 = distance(var_0.origin, var_1.origin);

  if(var_2 + 48 > var_3) {
    return 0;
  }

  return 1;
}

_id_8924(var_0) {
  var_1 = self._id_0192;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(istrue(self._id_4DA7)) {
    return 0;
  }

  if(isDefined(self._id_2C5E._id_31A2)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_1._id_4DA7)) {
    return 0;
  }

  if(isDefined(self._id_0D88) && !_id_3196()) {
    return 0;
  }

  if(_id_8817(var_1)) {
    if(!_id_31E5(var_1)) {
      return 0;
    }
  }

  if(!_id_06BC::_id_10D67()) {
    return 0;
  }

  return 1;
}

_id_DB84(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_0192;
  }

  if(!_id_8924(var_1)) {
    return anim._id_58E3;
  }

  if(![[self._id_5D9D]](var_1, 1)) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_821D(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  self._id_2C5E._id_82FD[var_0]._id_F224 = gettime();
  self._id_2C5E._id_82FD[var_0]._id_2C5A = 0;

  if(isPlayer(self._id_9D39.target)) {
    self._id_2C5E._id_82FD[var_0]._id_0207 = self._id_0207;
    self._id_0207 = 0;
  }

  _id_06BD::_id_23F0(self._id_9D39.target);

  if(isDefined(self._id_5DA3)) {
    self[[self._id_5DA3]]();
  }

  if(!isDefined(self._id_9D65) && isPlayer(self._id_9D39.target) && !self._id_9D39.target isonground()) {
    self._id_9D39._id_2059 = 1;
  }

  self _meth_8474();

  if(isai(self._id_9D39.target)) {
    self._id_9D39.target _meth_8474();
  }

  var_1 = self _meth_85FD();

  if(var_1 != "disabled") {
    self _meth_85FE();
  }
}

_id_4D16(var_0) {
  if(!isDefined(self._id_9D39)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_9D39._id_2059)) {
    return anim._id_58E3;
  }

  if(_id_0009::_id_1C4F("melee_attack", "end")) {
    return anim._id_EACB;
  }

  if(_id_0009::_id_1C4F("melee_rusher_charge_attack", "end")) {
    return anim._id_EACB;
  }

  if(_id_0009::_id_1C4F("melee_attack", "begin", 0)) {
    self._id_2C5E._id_82FD[var_0]._id_2C5A = 1;
    self._id_2C5E._id_82FD[var_0]._id_F224 = gettime() + 10000;
  }

  if(_id_0009::_id_1C4F("melee_rusher_charge_attack", "begin", 0)) {
    self._id_2C5E._id_82FD[var_0]._id_2C5A = 1;
    self._id_2C5E._id_82FD[var_0]._id_F224 = gettime() + 10000;
  }

  if(!self._id_2C5E._id_82FD[var_0]._id_2C5A) {
    if(!isDefined(self._id_9D39.target) || !isalive(self._id_9D39.target)) {
      return anim._id_58E3;
    }
  }

  if(gettime() > self._id_2C5E._id_82FD[var_0]._id_F224 + 2000) {
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(isDefined(self._id_9D39.target) && isalive(self._id_9D39.target) && !isPlayer(self._id_9D39.target) && self._id_9D39.target _id_06BD::_id_23CE()) {
    return anim._id_58E3;
  }

  return anim._id_CA5F;
}

_id_395C(var_0) {
  _id_06BD::_id_23AF();

  if(isDefined(self._id_9D39) && !isDefined(self._id_9D39._id_2C5A)) {
    if(isDefined(self._id_9D39.target)) {
      self._id_9D39.target._id_9D39 = undefined;
    }

    self._id_9D39 = undefined;
  }

  if(isDefined(self._id_2C5E._id_82FD[var_0])) {
    if(isDefined(self._id_2C5E._id_82FD[var_0]._id_0207)) {
      self._id_0207 = self._id_2C5E._id_82FD[var_0]._id_0207;
    }

    self._id_2C5E._id_82FD[var_0] = undefined;
  }
}

_id_9D5A(var_0) {
  if(isDefined(self._id_0192) && isDefined(self._id_0192._id_9D39)) {
    if(isDefined(self._id_0192._id_9D39._id_AE83)) {
      self._id_0192._id_9D39._id_AE83 _id_9D43();
    } else {
      self._id_0192 _id_9D43();
    }
  }

  return anim._id_EACB;
}

_id_9DAC(var_0) {
  _id_9D4C(var_0);

  if(isDefined(self._id_5DA6)) {
    self[[self._id_5DA6]](var_0);
  }

  thread _id_9D81(self._id_0192);
}

_id_9DAD(var_0) {
  _id_06BD::_id_23AF();
  _id_9D43();

  if(isDefined(self._id_5DA7)) {
    self[[self._id_5DA7]](var_0);
  }
}

_id_9DAE(var_0) {
  if(!isDefined(self._id_9D39.target) || !isalive(self._id_9D39.target)) {
    return anim._id_58E3;
  }

  if(_id_0009::_id_1C4F("melee_attack", "end")) {
    return anim._id_EACB;
  }

  _id_06BD::_id_23F0(self._id_9D39.target);
  return anim._id_CA5F;
}

_id_9D54(var_0, var_1) {
  if(!isDefined(anim)) {
    return;
  }
  if(!isDefined(anim._id_9D75)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(isPlayer(self._id_9D39.target) && isDefined(anim._id_9D76[self._id_04B9])) {
    anim._id_9D77[self._id_04B9] = gettime() + anim._id_9D76[self._id_04B9] * var_1;
  } else if(isDefined(anim._id_9D75[self._id_04B9])) {
    anim._id_9D78[self._id_04B9] = gettime() + anim._id_9D75[self._id_04B9] * var_1;
  }
}

_id_9D6F(var_0) {
  self._id_9D39._id_3413 = 1;

  if(isDefined(self._id_5DA4)) {
    self[[self._id_5DA4]](var_0);
  }

  _id_9D54(self._id_04B9, 3);
  var_1 = spawnStruct();
  var_1._id_3534 = gettime() + 500;
  var_1._id_F224 = gettime() + 4000;
  var_1._id_542B = self._id_0192.origin;
  self._id_2C5E._id_82FD[var_0] = var_1;
  var_1._id_0207 = self._id_0207;
  self._id_0207 = 0;
  self._id_02A2 = 64;
}

_id_9D72(var_0) {
  if(isDefined(self._id_9D39)) {
    _id_9D54(self._id_04B9, 0);
  }

  if(isDefined(self._id_9D39) && (isDefined(self._id_9D39._id_2059) || !isDefined(self._id_9D39._id_242E))) {
    _id_9D43();
  }

  self _meth_84C0(1);
  self._id_02A2 = 0;

  if(isDefined(self._id_2C5E._id_82FD[var_0]._id_0207)) {
    self._id_0207 = self._id_2C5E._id_82FD[var_0]._id_0207;
  }

  _id_06BD::_id_23AE();

  if(isDefined(self._id_5DA5)) {
    self[[self._id_5DA5]](var_0);
  }

  self._id_2C5E._id_82FD[var_0] = undefined;

  if(isDefined(self._id_1210) && self._id_1210 == "actor_s4_mp_krampus") {
    _id_395C(var_0);
  }
}

_id_6B53(var_0) {
  if(isPlayer(var_0)) {
    var_1 = self._id_02A4;
  } else {
    var_1 = self._id_02A3;
  }

  if(!_id_06AC::_id_7534()) {
    var_1 = var_1 * self._id_9D74;
  }

  return var_1;
}

getmeleechargemaxpathdist(var_0) {
  var_1 = _id_6B53(var_0);
  return var_1 * 1.1;
}

_id_9D56() {
  if(istrue(self.krampusdisablemovebehavior)) {
    return 1;
  }

  if(!isDefined(self._id_9D39)) {
    return 1;
  }

  var_0 = self._id_9D39.target;

  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isalive(var_0)) {
    return 1;
  }

  if(!isPlayer(var_0) && (var_0 _id_06BD::_id_23CE() || var_0._id_017C)) {
    return 1;
  }

  return 0;
}

_id_9D71() {
  if(_id_9D56()) {
    return 1;
  }

  if(isDefined(self._id_2C5E._id_31A2)) {
    return 1;
  }

  if(isDefined(self._id_9D39._id_2059)) {
    return 1;
  }

  var_0 = self._id_9D39.target;

  if(!isalive(var_0)) {
    return 1;
  }

  if(isDefined(var_0._id_A951) && var_0._id_A951._id_0026) {
    if(isai(var_0) || !isDefined(self._id_9D66) || !self._id_9D66) {
      return 1;
    }
  }

  if(!isDefined(self._id_0192) || var_0 != self._id_0192) {
    return 1;
  }

  if(_id_0009::_id_1C4F("melee_charge_state", "end")) {
    return 1;
  }

  if(_id_0009::_id_1C4F("melee_rusher_charge_state", "end")) {
    return 1;
  }

  return 0;
}

_id_9D6E(var_0) {
  self._id_A4B0 = gettime() + 1500;
  self._id_8FD2 = var_0;
}

_id_9D70(var_0, var_1) {
  var_2 = self._id_2C5E._id_82FD[var_0]._id_EEF5;

  if(!isDefined(var_2)) {
    return 0;
  }

  if(isDefined(self._id_0323) && distance2dsquared(self._id_0323, self.origin) > 16) {
    return 0;
  }

  return distancesquared(var_2, var_1) < 4;
}

_id_9D73(var_0) {
  if(_id_9D71()) {
    if(isDefined(self._id_9D39)) {
      self._id_9D39._id_2059 = 1;
    }

    return anim._id_58E3;
  }

  var_1 = self._id_2C5E._id_82FD[var_0];
  var_2 = gettime();
  var_3 = self._id_9D99;

  if(!isDefined(var_3)) {
    var_3 = 4096;
  }

  var_4 = self._id_9D39.target;

  if(isDefined(self._id_9D65) || isDefined(self._id_9D8D)) {
    var_5 = distance2dsquared(var_4.origin, self.origin);
  } else {
    var_5 = distancesquared(var_4.origin, self.origin);
  }

  var_6 = _id_6B53(var_4) + 24;
  var_7 = var_6 * var_6;

  if(var_5 > var_7) {
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  var_8 = isPlayer(var_4);

  if(var_8) {
    var_9 = _func_02AB(var_4.origin, self);
  } else {
    var_9 = var_4 _meth_84DC();
  }

  var_10 = var_3;
  var_11 = length(self._id_04DF);

  if(var_11 > 1) {
    var_10 = _func_0219(_func_0218(var_3) + var_11 * (level._id_01E2 / 1000));
  }

  if(var_5 <= var_10) {
    if(isPlayer(var_4)) {
      if(var_4 scripts\common\utility::_id_9D8A()) {
        return anim._id_CA5F;
      }
    }

    if(isDefined(self._id_9D64) && var_5 <= self._id_9D64 * self._id_9D64) {
      self._id_9D39._id_242E = 1;
      return anim._id_EACB;
    }

    var_12 = 18;

    if(isDefined(self._id_03FF) && self._id_03FF != "none" && isPlayer(var_4)) {
      var_12 = 32;
    }

    var_13 = self _meth_84DC();

    if(self[[self._id_5D6C]](var_13, var_9)) {
      if(isDefined(self._id_9D8D) || abs(self.origin[2] - var_4.origin[2]) < var_12) {
        self._id_9D39._id_242E = 1;
        return anim._id_EACB;
      }
    } else {
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }

    if(isDefined(self._id_0323) && distance2dsquared(self.origin, self._id_0323) < 4) {
      _id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  if(self._id_0084 || var_2 > var_1._id_3534 && !isDefined(self._id_0323) && !istrue(self._id_0324)) {
    _id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(!istrue(self._id_9D39._id_2505)) {
    if(var_2 >= var_1._id_F224) {
      _id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  if(!istrue(self._id_9D39._id_2504)) {
    if(isDefined(self._id_9D65)) {
      var_14 = distance2dsquared(var_4.origin, var_1._id_542B);
    } else {
      var_14 = distancesquared(var_4.origin, var_1._id_542B);
    }

    if(var_14 > 16384) {
      _id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  var_15 = undefined;

  if(isDefined(self._id_0323) && var_2 > var_1._id_3534) {
    var_15 = self _meth_8473();
  }

  if(isDefined(var_1._id_BC53) && isDefined(var_15) && var_15 - var_1._id_BC53 > 72) {
    _id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(isDefined(var_15)) {
    var_1._id_BC53 = var_15;

    if(!scripts\common\utility::_id_854B("melee_rusher") && var_15 > getmeleechargemaxpathdist(var_4)) {
      _id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  var_16 = undefined;

  if(isDefined(self._id_0323) && var_2 > var_1._id_3534) {
    var_16 = self._id_027F;
  }

  if(isDefined(var_1._id_BC54) && isDefined(var_16) && vectordot(var_16, var_1._id_BC54) < -0.866) {
    _id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(isDefined(var_16)) {
    var_1._id_BC54 = var_16;
  }

  var_17 = max(_func_0218(var_3) - 24, 0);
  var_18 = vectornormalize(self.origin - var_4.origin);
  var_19 = scripts\engine\utility::ter_op(isPlayer(var_4) && istrue(self._id_9DAA), var_4.origin, var_4.origin + var_18 * var_17);
  var_20 = 36;

  if(isDefined(self._id_9DA9)) {
    var_20 = self._id_9DA9;
  }

  var_21 = 0;

  if(!_id_9D70(var_0, var_19)) {
    var_22 = _func_02AB(var_19, self);
    var_21 = distance2dsquared(var_19, var_22) > var_20;

    if(!var_21) {
      var_21 = !self[[self._id_5D6C]](var_22, var_9);
    }
  }

  if(var_21 && istrue(self._id_9DAA)) {
    if(isDefined(var_4._id_02ED)) {
      if(scripts\engine\utility::_id_8946(var_4._id_02ED)) {
        var_23 = anglestoleft(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin + var_23 * var_17;
      } else if(scripts\engine\utility::_id_8948(var_4._id_02ED)) {
        var_24 = anglestoright(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin + var_24 * var_17;
      } else {
        var_25 = anglesToForward(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin - var_25 * var_17;
      }

      if(!_id_9D70(var_0, var_19)) {
        var_22 = _func_02AB(var_19, self);
        var_21 = distance2dsquared(var_19, var_22) > var_20;
      }
    }
  }

  if(var_21) {
    _id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  var_26 = 1;

  if(scripts\common\utility::_id_854B("melee_rusher")) {
    var_26 = 2;
  }

  self _meth_84BC(var_26, var_19);
  self _meth_8600(var_26, 6);
  var_1._id_EEF5 = var_19;
  _id_06BD::_id_23F1(var_4, var_19);
  self._id_A4B0 = 0;
  self._id_8FD2 = undefined;

  if(var_8) {
    self._id_01CF = 1;
  }

  if(isDefined(self._id_1210) && self._id_1210 == "actor_s4_mp_krampus") {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_6DBC(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.origin - self.origin;
  var_2 = vectornormalize(var_2);
  var_1 = var_1 - var_2 * self._id_9D64;
  var_3 = _func_02AB(var_1, self);

  if(abs(var_1[2] - var_3[2]) > self._id_9CC3) {
    return undefined;
  }

  var_4 = _func_02A6(self.origin, var_3, self, 1);
  var_5 = var_4["fraction"];

  if(var_5 < self._id_0E4A) {
    return undefined;
  }

  return var_3;
}

_id_3196() {
  if(isDefined(self._id_546E) && isDefined(self._id_546E["_stealth_enabled"]) && self._id_546E["_stealth_enabled"]) {
    if(isDefined(self._id_546E["_stealth_attack"]) && !self._id_546E["_stealth_attack"]) {
      return 0;
    }
  }

  return anim._id_EACB;
}

_id_8817(var_0) {
  var_1 = self._id_0192;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(isDefined(self._id_9D39)) {
    return 1;
  }

  if(isDefined(var_1._id_9D39)) {
    if(!isDefined(var_1._id_9D39._id_AE83)) {
      if(isPlayer(var_1)) {
        var_1._id_9D39 = undefined;
      } else {}
    }

    if(isDefined(var_1._id_9D39)) {
      return 1;
    }
  }

  return 0;
}

_id_892A(var_0) {
  if(abs(var_0.origin[2] - self.origin[2]) > self._id_02A7) {
    return 0;
  }

  var_1 = _id_6B53(var_0);
  var_2 = var_1 * var_1;
  var_3 = distancesquared(self.origin, var_0.origin);
  return var_3 <= var_2;
}

_id_892C(var_0, var_1) {
  if(istrue(self._id_4DA7)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_4DA7)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  return 1;
}

_id_892B(var_0, var_1) {
  if(!_id_892C(var_0, var_1)) {
    return 0;
  }

  if(var_1) {
    if(isDefined(self._id_0DDF._id_AA76) || self._id_0131 == "prone") {
      return 0;
    }

    if(!_id_08F1::_id_9D3F(self._id_04B9, 1)) {
      return 0;
    }

    if(isDefined(self._id_0323) && self._id_01B7 && _func_0135(self._id_04DF) > 1) {
      var_2 = var_0.origin - self.origin;
      var_3 = length(var_2);

      if(var_3 > 60) {
        var_2 = var_2 / var_3;
        var_4 = self _meth_84A6(30);
        var_5 = vectornormalize(var_4 - self.origin);

        if(vectordot(var_5, var_2) < -0.5) {
          return 0;
        }
      }
    }
  }

  if(isDefined(self._id_0203) && self._id_01EF == 1) {
    return 0;
  }

  if(isDefined(self._id_8FD2) && self._id_0192 == self._id_8FD2 && gettime() <= self._id_A4B0) {
    return 0;
  }

  if(istrue(var_0._id_017F) || istrue(var_0.ignoreme) || istrue(var_0._id_4DA8)) {
    return 0;
  }

  if(!isai(var_0) && !isPlayer(var_0)) {
    return 0;
  }

  if(isDefined(self._id_9D68) && isDefined(var_0._id_9D68)) {
    return 0;
  }

  if(isDefined(self._id_9D68) && isDefined(var_0._id_992D) || isDefined(var_0._id_9D68) && isDefined(self._id_992D)) {
    return 0;
  }

  var_6 = 0;

  if(isagent(var_0)) {
    if(istrue(self._id_2C57)) {
      var_6 = 1;
    }
  } else if(!isbot(var_0))
    var_6 = isai(var_0);

  if(var_6) {
    if(var_0 _meth_81C7()) {
      return 0;
    }

    if(var_0._id_017C || var_0._id_015A) {
      return 0;
    }

    if(self._id_03FF != "none" || var_0._id_03FF != "none") {
      return 0;
    }

    if(var_0._id_04B9 != "soldier" && var_0._id_04B9 != "civilian" && var_0._id_04B9 != "juggernaut") {
      return 0;
    }
  }

  if(!isDefined(self._id_9D8E) || !self._id_9D8E || !isPlayer(var_0)) {
    if(isPlayer(var_0)) {
      var_7 = var_0 getstance();
    } else {
      var_7 = var_0._id_0131;
    }

    if(var_7 != "stand" && var_7 != "crouch") {
      return 0;
    }
  }

  if(isDefined(self._id_992D) && isDefined(var_0._id_992D)) {
    return 0;
  }

  if(isDefined(var_0._id_0203)) {
    return 0;
  }

  if(isDefined(var_0._id_98B9) && isDefined(var_0._id_F940)) {
    return 0;
  }

  if(!scripts\common\utility::_id_854B("melee_rusher")) {
    var_8 = self _meth_847B(self.origin, var_0.origin, 0, 0, 1);

    if(isDefined(var_8)) {
      var_9 = 0;

      for(var_10 = 0; var_10 < var_8.size - 1; var_10++) {
        var_9 = var_9 + distance(var_8[var_10], var_8[var_10 + 1]);
      }

      if(var_9 > getmeleechargemaxpathdist(var_0)) {
        _id_9D6E(var_0);
        return 0;
      }
    }
  }

  return 1;
}