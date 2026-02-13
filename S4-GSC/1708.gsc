/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1708.gsc
*************************************************/

_id_E003() {
  level thread _id_98B2();

  if(getdvarint("#x3406ec6dcd8b93898") && self.team == "axis") {
    thread axis_damage_shield_watcher();
  }
}

_id_FC5C(var_0) {
  _id_06BD::_id_23FC(weaponclass(self._id_034C));
  var_1 = _id_0009::_id_1C63("ai_notify", "bulletwhizby");

  if(isDefined(var_1)) {
    if(!isDefined(self._id_4A83)) {
      var_2 = var_1[0];
      var_3 = isDefined(var_2) && distancesquared(self.origin, var_2.origin) < 160000;

      if(var_3 || scripts\engine\utility::cointoss()) {
        var_4 = spawnStruct();
        var_4._id_60EC = gettime() - 50;
        var_4._id_AE4A = var_1;
        _id_06BD::_id_23FD(var_4);
      }
    }
  } else {
    var_5 = 100;
    var_1 = _id_06BD::_id_23CA();

    if(!isDefined(var_1) || gettime() > var_1._id_60EC + var_5) {
      _id_06BD::_id_23FD(undefined);
    }
  }

  self._id_0285 = undefined;
  return anim._id_EACB;
}

_id_DB08() {
  if(isDefined(self._id_5F3F)) {
    return self._id_5F3F;
  }

  return 0;
}

_id_FC5A(var_0) {
  if(!istrue(self _meth_884C())) {
    return anim._id_58E3;
  }

  if(self._id_0281) {
    var_1 = self _meth_841A();
    _id_08F1::setdoortoopen(var_1);
  }

  return anim._id_EACB;
}

_id_FD92(var_0) {
  var_1 = _id_0009::_id_1C63("ai_notify", "bulletwhizby");

  if(isDefined(var_1) && isDefined(self._id_0DDF)) {
    if(randomfloat(1) < self._id_0DDF._id_C09A) {
      var_2 = spawnStruct();
      var_2._id_60EC = gettime() - 50;
      var_2._id_AE4A = var_1;
      _id_06BD::_id_23FD(var_2);
    }
  } else {
    var_3 = 100;
    var_1 = _id_06BD::_id_23CA();

    if(!isDefined(var_1) || gettime() > var_1._id_60EC + var_3) {
      _id_06BD::_id_23FD(undefined);
    }
  }

  return anim._id_EACB;
}

_id_7534() {
  var_0 = _id_6E2B();

  if(isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(self._id_04F6)) {
    return 0;
  }

  if(self._id_00CC > 0 || istrue(self._id_016A)) {
    return 1;
  }

  return 0;
}

_id_891B(var_0, var_1) {
  if(scripts\anim\utility_common::_id_A418(var_1)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_10E7C(var_0, var_1) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(distancesquared(self.origin, self._id_0192.origin) <= var_1 * var_1) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_87C6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  if(_id_06BD::_id_23C5() != "exposed") {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0B67._id_0238)) {
    if(gettime() - self._id_0B67._id_0238 > var_1) {
      if(self _meth_8867(0)) {
        return anim._id_EACB;
      }
    }
  }

  return anim._id_58E3;
}

_id_9CCB(var_0) {
  if(!isDefined(self._id_04F6)) {
    return anim._id_58E3;
  }

  var_1 = _id_DBCC();

  if(var_1) {
    var_1 = _id_2EBA();
  } else {
    self._id_70E0 = undefined;
  }

  if(!var_1) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_FCB2(var_0) {
  if(!isDefined(self._id_0285) || self._id_0285 != self._id_0192) {
    self._id_0285 = self._id_0192;
  }

  return anim._id_EACB;
}

_id_D9F8() {
  self._id_0B67._id_03C0 = 0;
}

_id_D9FD() {
  self._id_0B67._id_03C0 = 1;
}

_id_DA07(var_0, var_1) {
  self._id_2C5E._id_9921 = 0;
  self._id_0285 = var_1;
  self._id_2420 = var_1;
  _id_06BD::_id_23AC(var_0);

  if(scripts\anim\utility_common::_id_8766()) {
    _id_D9FD();
    self._id_DFBD = 0;
    self._id_DFB3 = 0;
  }
}

_id_DA06(var_0) {
  _id_DA07(var_0, self._id_0192);
}

_id_DA19(var_0) {
  if(istrue(self._id_0B67._id_03CE) && self._id_0B67._id_03CD == var_0) {
    _id_06BD::_id_23B5();
    _id_D9F8();
  }

  self._id_2C5E._id_9921 = 0;
  self._id_2420 = undefined;
  _id_06BD::_id_23EE(0);
}

_id_8738(var_0) {
  return self _meth_8869(var_0);
}

_id_753C(var_0) {
  if(isnullweapon(self._id_04F6)) {
    return 0;
  }

  return self._id_00CC >= weaponclipsize(self._id_04F6) * var_0;
}

_id_C30E() {
  var_0 = weaponclipsize(self._id_04F6);
  self._id_00CC = int(var_0 * 0.5);
  self._id_00CC = int(clamp(self._id_00CC, 0, var_0));
}

_id_3623() {
  var_0 = 62500;
  var_1 = 810000;
  var_2 = 2560000;
  var_3 = weaponclass(self._id_04F6);
  var_4 = _id_6E2B();
  var_5 = isDefined(var_4);

  if(isDefined(self._id_03D2)) {
    var_6 = 0;

    if(isDefined(self._id_2C5E._id_DA39)) {
      var_6 = self._id_2C5E._id_DA39;
    }

    return _id_D6C8(self._id_03D2, var_6);
  }

  if(var_3 == "mg" || var_5) {
    return _id_D6C8("mg", 0);
  }

  if(isDefined(self._id_0B67._id_03C3) && isDefined(self._id_0B67._id_03C3._id_0192) && isDefined(self._id_0B67._id_03C3._id_0192._id_0426)) {
    return _id_D6C8("single", 0);
  }

  if(scripts\anim\utility_common::_id_8766()) {
    return _id_D6C8("single", 0);
  }

  if(var_3 == "rocketlauncher" || var_3 == "pistol") {
    return _id_D6C8("single", 0);
  }

  if(scripts\anim\utility_common::_id_8A2E(self._id_04F6)) {
    if(scripts\anim\utility_common::_id_10D12()) {
      return _id_D6C8("single", 0);
    } else {
      return _id_D6C8("semi", 0);
    }
  }

  if(var_3 == "grenade") {
    return _id_D6C8("single", 0);
  }

  if(weaponburstcount(self._id_04F6) > 0) {
    return _id_D6C8("burst", 0);
  }

  var_7 = distancesquared(self _meth_8176(), self._id_0B67._id_03C8);

  if(var_7 < var_0) {
    if(isDefined(self._id_0B67._id_03C3) && isDefined(self._id_0B67._id_03C3._id_992D)) {
      return _id_D6C8("single", 0);
    } else {
      return _id_D6C8("full", 0);
    }
  } else if(var_7 < var_1 || _id_DB07()) {
    if(weaponissemiauto(self._id_04F6) || _id_DB3E(var_7)) {
      return _id_D6C8("semi", 1);
    } else {
      return _id_D6C8("burst", 1);
    }
  } else if(self._id_0352 || var_7 < var_2) {
    if(_id_DB3E(var_7)) {
      return _id_D6C8("semi", 0);
    } else {
      return _id_D6C8("burst", 0);
    }
  } else if(_id_DB3E(var_7))
    return _id_D6C8("semi", 0);
  else {
    return _id_D6C8("single", 0);
  }
}

_id_D6C8(var_0, var_1) {
  self._id_0B67._id_03CC = var_0;
  self._id_0B67._id_03C4 = var_1;
}

_id_DB07() {
  if(!isDefined(level._id_60E6)) {
    return 0;
  }

  return level._id_60E6 == 3 && isPlayer(self._id_0192);
}

_id_DB3E(var_0) {
  var_1 = randomfloat(1);
  var_2 = _id_DB3F(var_0);
  return var_1 <= var_2;
}

_id_DB3F(var_0) {
  if(var_0 < 2560000.0) {
    return -1;
  }

  return -0.0000000465839 * var_0 - -0.119255 + 0.5;
}

_id_6E2B() {
  if(isDefined(self._id_5D90)) {
    return [[self._id_5D90]]();
  }
}

_id_DBCC() {
  var_0 = 0;

  if(isDefined(self _meth_8182())) {
    var_1 = self _meth_8182();
    var_2 = var_1 _meth_8157();

    if(var_2 == "manual" || var_2 == "manual_ai") {
      return 0;
    }

    var_3 = _id_08F1::_id_F887();

    if(isDefined(var_3) && _id_08F1::_id_F889(var_3, 1)) {
      var_0 = 1;
    } else if(!var_1 _meth_81C1() || var_1 _meth_8811() == 0) {
      return 0;
    }
  }

  if(!var_0 && !self _meth_8603()) {
    return 0;
  }

  if(istrue(self._id_0B67._id_AE7B)) {
    return 0;
  }

  if(isDefined(self._id_0323)) {
    if(_func_0278(self._id_04F6)) {
      return 0;
    }

    if(distance2dsquared(self._id_0323, self.origin) > 16 && !_id_06C1::_id_3112()) {
      return 0;
    }
  }

  return 1;
}

_id_2EBA() {
  var_0 = self _meth_8182();

  if(isDefined(var_0)) {
    var_1 = _id_08F1::_id_F887();

    if(isDefined(var_1)) {
      var_2 = _id_08F1::_id_F888(var_1, 1);

      if(isDefined(var_2)) {
        self._id_70E0 = var_2;
        return 1;
      }

      if(!var_0 _meth_81C1() || var_0 _meth_8811() == 0) {
        return 0;
      }
    }
  }

  if(isDefined(self._id_03D1)) {
    self._id_70E0 = self._id_03D1;
    return 1;
  }

  if(isDefined(self._id_0192) && self _meth_8067(self._id_0192)) {
    if(self _meth_8069()) {
      scripts\anim\utility_common::_id_4DA4();
      self._id_70E0 = self._id_0192 _meth_8176();
      return 1;
    }
  }

  var_3 = scripts\anim\utility_common::_id_31EA();
  return var_3;
}

_id_C076() {
  if(!isDefined(level._id_8F88) || !isDefined(level._id_8F88[self.team])) {
    return 0;
  }

  if(_id_DB6F()) {
    return 1;
  }

  if(level._id_8F88[self.team] > 0 && gettime() - level._id_8F88[self.team] < level._id_11DC) {
    return 0;
  }

  if(!_func_011D(self._id_0192)) {
    return 0;
  }

  if(level._id_11DA[self.team]) {
    level._id_11DA[self.team] = 0;
  }

  var_0 = isDefined(self._id_11C5) && self._id_11C5;

  if(!var_0 && _func_0072(self.team) < _func_0072(self._id_0192.team)) {
    return 0;
  }

  return 1;
}

_id_DB6F() {
  if(level._id_11DA[self.team] > 0 && level._id_11DA[self.team] < level._id_11DB) {
    if(gettime() - level._id_8F88[self.team] > 4000) {
      return 0;
    }

    var_0 = level._id_8F85[self.team];

    if(var_0 == self) {
      return 0;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level._id_8F87[self.team]) < 65536) && (!isDefined(self._id_0192) || distancesquared(self._id_0192.origin, level._id_8F86[self.team]) < 262144)) {
      return 1;
    }
  }

  return 0;
}

_id_DB04() {
  return _id_DB02();
}

_id_DB02() {
  if(self._id_01C2) {
    return 0;
  }

  if(scripts\engine\utility::_id_0F78()) {
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(_id_06B7::_id_88D3()) {
    return 0;
  }

  if(weaponclass(self._id_04F6) == "mg") {
    return 0;
  }

  if(self._id_010D == "ambush" || self._id_010D == "ambush_nodes_only") {
    return 0;
  }

  if(self _meth_8067(self._id_0192) && self _meth_8069()) {
    return 0;
  }

  return 1;
}

_id_C078(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
}

_id_C07A(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0B67._id_C07B = undefined;
}

_id_C075(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0B67._id_C07B = undefined;
}

_id_C077(var_0) {
  self _meth_85FE();
}

_id_C079(var_0, var_1) {
  var_2 = self._id_2C5E._id_82FD[var_0];

  if(!istrue(var_2._id_250B)) {
    if(istrue(self._id_002F)) {
      return anim._id_58E3;
    }

    var_2._id_250B = 1;
    self._id_0B67._id_035E = gettime();

    if(self _meth_828A(var_1)) {
      return anim._id_CA5F;
    }

    return anim._id_58E3;
  }

  var_3 = self _meth_85FD();
  self._id_0B67._id_035E = gettime();

  if(var_3 == "reacquired") {
    if(!isDefined(self._id_0B67._id_C07B)) {
      self._id_0B67._id_C07B = gettime() + 5000;
    }

    if(!istrue(var_2._id_98C1) && (!isDefined(self._id_0192) || _func_011D(self._id_0192) && !self _meth_82CE(self._id_0192, 2))) {
      self._id_0B67._id_C07B = self._id_0B67._id_C07B - 3000;
      var_2._id_98C1 = 1;
    }

    if(gettime() > self._id_0B67._id_C07B) {
      self _meth_85FE();
      return anim._id_EACB;
    }

    return anim._id_CA5F;
  } else if(var_3 == "enabled") {
    if(istrue(var_2._id_29F0)) {
      return anim._id_58E3;
    }

    if(!self._id_0063 && !isDefined(self._id_0323) && !istrue(self._id_0324)) {
      var_2._id_29F0 = 1;
    }

    return anim._id_CA5F;
  }

  self _meth_85FE();
  return anim._id_EACB;
}

_id_C073() {
  if(!self _meth_81C6(self._id_0192.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::_id_8917()) {
    return 0;
  }

  self _meth_80EF(0);

  if(self _meth_8289()) {
    self._id_0260 = 0;
    self._id_025E = 0;

    if(level._id_11DA[self.team] == 0) {
      level._id_8F88[self.team] = gettime();
      level._id_8F85[self.team] = self;
    }

    level._id_8F87[self.team] = self.origin;
    level._id_8F86[self.team] = self._id_0192.origin;
    level._id_11DA[self.team]++;
    return 1;
  }

  return 0;
}

_id_C074(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];

  if(!istrue(var_1._id_250B)) {
    if(!_id_DB04()) {
      return anim._id_58E3;
    }

    var_1._id_250B = 1;

    if(!_id_C076()) {
      return anim._id_EACB;
    }

    if(_id_C073()) {
      return anim._id_CA5F;
    }

    return anim._id_58E3;
  }

  var_2 = self _meth_85FD();
  self._id_0B67._id_035E = gettime();

  if(var_2 == "reacquired") {
    if(!isDefined(self._id_0B67._id_C07B)) {
      self._id_0B67._id_C07B = gettime() + 5000;
    }

    if(!istrue(var_1._id_98C1) && (!isDefined(self._id_0192) || _func_011D(self._id_0192) && !self _meth_82CE(self._id_0192, 2))) {
      self._id_0B67._id_C07B = self._id_0B67._id_C07B - 3000;
      var_1._id_98C1 = 1;
    }

    if(gettime() > self._id_0B67._id_C07B) {
      self _meth_85FE();
      return anim._id_EACB;
    }

    return anim._id_CA5F;
  } else if(var_2 == "enabled") {
    if(self _meth_81C6(self.origin)) {
      return anim._id_58E3;
    }

    self _meth_80EF(0);
    return anim._id_CA5F;
  }

  return anim._id_58E3;
}

_id_20F2(var_0) {
  if(_id_06BD::_id_23E5()) {
    return anim._id_58E3;
  }

  var_1 = self _meth_8559(128.0);

  if(isDefined(var_1)) {
    self _meth_84BC(2, var_1);
    self._id_0B67._id_20F3 = gettime();
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_10982(var_0) {
  var_1 = gettime();

  if(var_1 > self._id_0B67._id_20F3 + 100 && !isDefined(self._id_0323) && !istrue(self._id_0324)) {
    return anim._id_58E3;
  }

  if(var_1 > self._id_0B67._id_20F3 + 5000) {
    return anim._id_58E3;
  }

  return anim._id_CA5F;
}

_id_20F6(var_0) {
  self _meth_84C0(2);
  self._id_0B67._id_20F3 = undefined;
}

_id_8820(var_0) {
  if(!isDefined(self._id_0192) || !_func_011D(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192._id_98B9)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192._id_F940)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_9D39)) {
    return anim._id_58E3;
  }

  var_1 = self _meth_8204(self._id_0192);
  var_2 = 0;

  if(istrue(self._id_1225)) {
    var_3 = distancesquared(self.origin, var_1);
    var_4 = 3600;

    if(isDefined(self._id_1224)) {
      var_4 = self._id_1224 * self._id_1224;
    }

    if(var_3 < var_4) {
      var_2 = 1;
    } else if(distancesquared(self.origin, self._id_0192.origin) < var_4) {
      var_2 = 1;
    }
  }

  if(!var_2) {
    var_5 = self _meth_8205(self._id_0192);

    if(var_5 <= gettime() - 5000) {
      return anim._id_58E3;
    }

    if(!_func_011A(var_1, self._id_0192._id_98B9)) {
      return anim._id_58E3;
    }
  }

  var_6 = self._id_0192._id_98B9 scripts\engine\utility::_id_6557();

  if(var_6.size == 0) {
    return anim._id_58E3;
  }

  var_6 = _func_0204(var_6, var_1);

  foreach(var_8 in var_6) {
    if(isDefined(_func_03D1(var_8)) && _func_03D1(var_8) != self) {
      continue;
    }
    self _meth_84BE(1, var_8);
    self _meth_8600(1, 12);
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_5418(var_0) {
  var_1 = self _meth_8204(self._id_0192);
  var_2 = spawnStruct();
  var_2._id_0192 = self._id_0192;
  var_2._id_1069A = self._id_0192._id_98B9;
  var_2._id_9004 = var_1;
  self._id_2C5E._id_82FD[var_0] = var_2;
  self._id_4DA3 = 1;
  self._id_EBA6 = 1;
  var_3 = scripts\anim\utility_common::_id_69FC();
  self._id_0270 = var_1 + (0, 0, var_3[2] - self._id_0192.origin[2]);
  self._id_24CB = 1;
  self notify("enemyInLowCover", var_2._id_1069A);
}

_id_541A(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];

  if(!isDefined(var_1._id_0192) || !isalive(var_1._id_0192)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192) || self._id_0192 != var_1._id_0192) {
    return anim._id_58E3;
  }

  var_2 = gettime();
  var_3 = self _meth_8204(self._id_0192);

  if(distancesquared(var_1._id_9004, var_3) > 1 && !_func_011A(var_3, var_1._id_1069A)) {
    return anim._id_58E3;
  }

  var_4 = isDefined(self._id_0192._id_F940) && _func_011A(self._id_0192.origin, var_1._id_1069A);

  if(var_4) {
    var_1._id_F20E = undefined;
  } else if(!isDefined(var_1._id_F20E)) {
    var_1._id_F20E = var_2;
  }

  if(isDefined(var_1._id_F20E) && var_2 > var_1._id_F20E + 5000) {
    return anim._id_58E3;
  }

  self._id_0270 = _func_025E(self._id_0270, scripts\anim\utility_common::_id_69FC(), 0.1);
  return anim._id_CA5F;
}

_id_5419(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_4DA3 = undefined;
  self._id_EBA6 = 0;
  self._id_24CB = undefined;
  self _meth_84C0(1);
  self notify("enemyLeftLowCover");
}

_id_FF32(var_0) {
  switch (var_0) {
    case "w2":
    case "w1":
    case "w0":
    case "5":
    case "4":
    case "3":
    case "1":
    case "slt":
    case "omr":
    case "2":
    case "0":
      return 1;
  }

  return 0;
}

_id_F896(var_0) {
  if(isDefined(_id_06BD::_id_23C8())) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_6C6A() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self _meth_8067(var_2)) {
      continue;
    }
    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return var_2;
  }

  return undefined;
}

_id_FD2E(var_0) {
  if(self.team != "axis") {
    return anim._id_EACB;
  }

  if(isDefined(self._id_4A4E) && self._id_4A4E) {
    return anim._id_EACB;
  }

  if(!scripts\anim\utility_common::_id_8766()) {
    return anim._id_EACB;
  }

  var_1 = getcompleteweaponname(self._id_04F6);

  if(self.weaponinfo[var_1]._id_033E == "none") {
    return anim._id_EACB;
  }

  var_2 = level._id_60A1["sniper_glint"];

  if(!isDefined(var_2)) {
    return anim._id_EACB;
  }

  if(!isDefined(self._id_A480)) {
    self._id_A480 = gettime() + randomintrange(3000, 5000);
  }

  if(!isDefined(self._id_0192) || !isalive(self._id_0192)) {
    return anim._id_EACB;
  }

  if(gettime() < self._id_A480) {
    return anim._id_EACB;
  }

  self._id_A480 = gettime() + 200;

  if(self._id_04F6 != self._id_034C) {
    return anim._id_EACB;
  }

  var_3 = _id_6C6A();

  if(!isDefined(var_3)) {
    return anim._id_EACB;
  }

  if(distancesquared(self.origin, var_3.origin) < 65536) {
    return anim._id_EACB;
  }

  if(_id_06BD::_id_240F() && isDefined(self._id_0B67._id_03C8)) {
    var_4 = self _meth_8561();
    var_5 = vectornormalize(self._id_0B67._id_03C8 - self getEye());
    var_6 = vectordot(var_4, var_5);

    if(var_6 < 0.906) {
      self._id_A480 = undefined;
      return anim._id_EACB;
    }
  } else {
    self._id_A480 = undefined;
    return anim._id_EACB;
  }

  playFXOnTag(var_2, self, "tag_flash");
  self._id_A480 = gettime() + randomintrange(3000, 5000);
  return anim._id_EACB;
}

_id_7CFD(var_0) {
  var_1 = _id_06BD::_id_23C6();

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_4AE6)) {
    return anim._id_58E3;
  }

  var_2 = self.origin[2] - var_1.origin[2];

  if(var_2 * var_2 > 5184) {
    return anim._id_58E3;
  }

  if(distance2dsquared(self.origin, var_1.origin) > 225) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_4E78(var_0) {
  _id_06BD::_id_23F4();

  if(isDefined(self._id_1C30._id_426A._id_1C02)) {
    self._id_1C30._id_426A._id_1C02 = undefined;
  }

  self._id_2C5E._id_82FD[var_0] = self._id_0166;
  self._id_0166 = 1;
}

_id_4E77(var_0) {
  if(self _meth_85D7("smartobject", "finished")) {
    var_1 = _id_06BD::_id_23C6();
    var_1 _id_0843::_id_DE1F();
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_4E79(var_0) {
  _id_0843::_id_397B(_id_06BD::_id_23C6());
  self._id_0166 = self._id_2C5E._id_82FD[var_0];
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_98B2() {
  if(istrue(level._id_98B3)) {
    return;
  }
  level._id_98B3 = 1;

  for(;;) {
    var_0 = getEntArray("low_cover_area", "targetname");

    foreach(var_2 in level.players) {
      var_3 = undefined;

      foreach(var_5 in var_0) {
        if(_func_011A(var_2.origin, var_5)) {
          var_3 = var_5;
          break;
        }
      }

      if(isDefined(var_2._id_98B9) && (!isDefined(var_3) || var_2._id_98B9 != var_3)) {
        var_2 notify("left_low_cover");
        var_2._id_F940 = undefined;
      }

      if(isDefined(var_3) && (!isDefined(var_2._id_98B9) || var_3 != var_2._id_98B9)) {
        var_2 thread _id_F465(var_3);
        var_2 thread _id_B613(var_3);
      }

      var_2._id_98B9 = var_3;
    }

    waitframe();
  }
}

_id_B613(var_0) {
  self endon("left_low_cover");
  self endon("death");
  var_1 = 1;

  if(isDefined(var_0._id_03A2) && var_0._id_03A2 == 0) {
    var_1 = 0;
  }

  for(;;) {
    if(var_1 && !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 60), self)) {
      self._id_F940 = 1;
    } else if(!var_1 && _func_011A(self.origin, var_0)) {
      self._id_F940 = 1;
    } else {
      self._id_F940 = undefined;
    }

    wait 0.15;
  }
}

_id_F465(var_0) {
  self endon("left_low_cover");
  self endon("death");
  var_1 = var_0 scripts\engine\utility::_id_6556()[0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = 1;

  while(isDefined(var_1)) {
    var_1 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 == self) {
      continue;
    }
    if(!self istouching(var_1)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_7, "MOD_MELEE")) {
      continue;
    }
    if(issubstr(var_7, "BULLET")) {
      var_13 = anglesToForward(var_4 gettagangles("tag_flash"));
      var_14 = vectornormalize(self getEye() - var_4 gettagorigin("tag_flash"));

      if(vectordot(var_13, var_14) < 0.9) {
        continue;
      }
      if(var_2) {
        var_2 = 0;
        wait 2;
        continue;
      }
    }

    self dodamage(var_3, var_4.origin, var_4, var_4, var_7, var_4._id_04F6);
  }
}

axis_damage_shield_watcher() {
  self endon("arrested");
  self endon("death");
  level.player endon("death");
  setdvarifuninitialized("#x3a299fa58d08f55ec", 0);
  var_0 = getdvarfloat("#x3a2167ed935d94407", 0.0);
  var_1 = getdvarfloat("#x3badc5e055de8208d", 0.0);
  waitframe();
  var_2 = self;
  var_3 = level.player;

  for(;;) {
    var_4 = var_2._id_12AC.axis_damage_shield_watcher_frame_time;
    var_5 = int(var_4 * 20);
    wait(var_4);

    if(var_2.team != "axis") {
      break;
    }

    if(isDefined(var_2._id_992D) && var_2._id_992D) {
      continue;
    }
    var_6 = var_1;
    var_7 = var_2 getEye();
    var_8 = var_3 getEye();
    var_9 = vectornormalize(var_7 - var_8);
    var_10 = anglesToForward(var_3 getplayerangles());
    var_11 = vectordot(var_9, var_10);
    var_12 = 0.819;
    var_13 = 0.642;

    if(var_11 > var_12) {
      var_6 = var_0;
    } else if(var_11 > var_13) {
      var_14 = 1 - abs((var_11 - var_13) / (var_12 - var_13));
      var_6 = var_0 + (var_1 - var_0) * var_14;
    }

    if(var_6 > 0.99) {
      var_6 = 0.99;
    }

    var_2._id_014D = var_6;
  }
}

_id_970D(var_0) {
  if(self._id_12AC._id_85F1) {
    return anim._id_58E3;
  }

  var_1 = gettime();
  var_2 = self._id_12AC._id_3A9C;

  if(var_1 - var_2 >= self._id_12AC._id_3AAB * getdvarint("#x3529041bf43ef47ec", 1)) {
    self._id_12AC._id_3A9C = var_1;
    return anim._id_58E3;
  } else
    return anim._id_EACB;
}

_id_970E(var_0) {
  if(self._id_12AC._id_85F1) {
    return anim._id_EACB;
  }

  var_1 = gettime();
  var_2 = self._id_12AC._id_3A9C;

  if(var_1 - var_2 >= self._id_12AC._id_3AAB * getdvarint("#x3529041bf43ef47ec", 1)) {
    self._id_12AC._id_3A9C = var_1;
    return anim._id_EACB;
  } else
    return anim._id_58E3;
}

_id_2C6F(var_0) {
  return anim._id_58E3;
}

_id_2C70(var_0) {
  return anim._id_EACB;
}