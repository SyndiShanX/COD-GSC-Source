/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1721.gsc
*************************************************/

_id_82A0() {
  self._id_5DBF = ::_id_D6F1;
  self._id_5D9A = ::_id_88B2;
  self._id_5D9C = ::_id_88D8;
  self._id_5D99 = ::_id_88AF;
  self._id_5D98 = ::_id_87B6;
  self._id_5D9B = ::_id_88B4;
  self._id_5DCA = ::_id_FD81;
  self._id_5DC8 = ::_id_88B3;
  self._id_5D6F = ::_id_3984;
  self._id_5D52 = ::_id_0F00;
  self._id_5DC4 = _id_08FE::_id_488B;
}

_id_7CFA(var_0) {
  if(!isDefined(self._id_0408)) {
    return anim._id_58E3;
  }

  if(self.team == "allies") {
    return anim._id_58E3;
  }

  if(self._id_0408._id_2C56 == 3) {
    return anim._id_58E3;
  }

  if(scripts\engine\utility::_id_5472("stealth_enabled") && !scripts\engine\utility::_id_546E("stealth_enabled")) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_88B4() {
  return isDefined(self._id_0408) && self._id_0408._id_2C56 == 0 && isDefined(self._id_0B67._id_7CCD);
}

_id_88B2() {
  return isDefined(self._id_0408) && self._id_0408._id_2C56 == 0;
}

_id_88D8() {
  return isDefined(self._id_0408) && self._id_0408._id_2C56 == 1;
}

_id_88AF() {
  return isDefined(self._id_0408) && self._id_0408._id_2C56 == 2;
}

_id_87B6() {
  return isDefined(self._id_0408) && self._id_0408._id_2C56 == 3;
}

_id_E7DA(var_0) {
  if(self.team == "allies") {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_E7B1(var_0) {
  _id_08AE::main();
  return anim._id_EACB;
}

_id_E7EA(var_0) {
  self._id_0408 = undefined;
}

_id_E7DD(var_0) {
  if(self.team == "neutral") {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_E7B3(var_0) {
  _id_08B2::main();
  return anim._id_EACB;
}

_id_88C9(var_0) {
  if(!isDefined(var_0)) {
    return !istrue(level._id_8596);
  }

  return var_0 >= 0.5;
}

_id_FD81() {}

_id_5EA4() {
  if(isDefined(self._id_5CA8) && self._id_5CA8) {
    var_0 = 0.1;

    foreach(var_2 in level.players) {
      if(isDefined(var_2._id_A7A0) && isDefined(var_2._id_A7A0._id_9490) && var_2._id_A7A0._id_9490 > var_0 && isDefined(var_2._id_A7A0._id_BC4B) && var_2._id_A7A0._id_9490 - var_2._id_A7A0._id_BC4B > 0.01) {
        if(self _meth_861D(var_2.origin) && !self _meth_8067(var_2)) {
          self _meth_8067(var_2, 0);
        }
      }
    }
  }
}

_id_E7A8(var_0) {
  switch (self._id_0408._id_2C56) {
    case 0:
      return "Stealth_Idle";
    case 1:
      if(isDefined(self._id_0408._id_8521) && gettime() >= self._id_0408._id_8521) {
        _id_D6F1("idle");
        return "Stealth_Idle";
      }

      return "Stealth_Investigate";
    case 2:
      return "Stealth_Hunt";
    case 3:
      return "Stealth_Combat";
  }
}

_id_E7D9(var_0) {
  _id_08AC::_id_BDCB();
  return anim._id_EACB;
}

_id_E7A9(var_0) {
  var_1 = scripts\engine\utility::_id_5472("react_to_dynolights") && scripts\engine\utility::_id_546E("react_to_dynolights");

  if(var_1 && !isDefined(self._id_9490)) {
    _id_08B5::_id_FB7D();
    var_1 = 0;
  }

  _id_FCA9(self._id_0408._id_2C56, 0.5);

  if(var_1) {
    var_2 = self getentitynumber();
    var_3 = level._id_01E2;

    if(gettime() / var_3 % 5 == var_2 % 5) {
      _id_08B5::_id_FB7D();
    }
  }

  _id_5EA4();
  return _id_E7D9(var_0);
}

_id_E7BE(var_0) {
  return _id_E7D9(var_0);
}

_id_54E7(var_0) {
  _id_5794(self._id_0408._id_2C56);
  self._id_0408._id_2C56 = var_0;

  switch (var_0) {
    case 1:
      _id_8507();
      break;
    case 2:
      _id_7BAF();
      break;
    case 3:
      _id_3A99();
      break;
  }
}

_id_5794(var_0) {
  switch (var_0) {
    case 1:
      _id_851B();
      break;
    case 2:
      _id_7BC6();
      break;
    case 3:
      _id_3AA8();
      break;
  }
}

_id_880B(var_0) {
  var_1 = gettime();

  if(var_1 > var_0._id_E72D + 500 && (!isDefined(self._id_0323) || distance2dsquared(self._id_0323, self.origin) < 4) && !self._id_0063 && !isDefined(self._id_0B67.doortoopen)) {
    if(!isDefined(var_0._id_0200)) {
      return 1;
    }

    if(distance2dsquared(self.origin, var_0._id_0200) < 3600 && _func_0219(var_0._id_0200[2] - self.origin[2]) < 5184) {
      return 1;
    }

    var_0._id_A781++;
    var_0._id_E72D = var_1;

    if(var_0._id_A781 >= 10) {
      return 1;
    }
  }

  return 0;
}

_id_FCA9(var_0, var_1) {
  if(self _meth_81C7()) {
    return;
  }
  if(gettime() == self._id_E72D) {
    return;
  }
  var_2 = self._id_9490;

  if(isDefined(self._id_0B67._id_24E1)) {
    var_3 = self._id_0B67._id_24E1;
  } else {
    var_3 = 0;
  }

  if(isDefined(self._id_5CBE)) {
    self._id_0B67._id_24E1 = self._id_5CBE;
  } else if(istrue(self._id_A584)) {
    self._id_0B67._id_24E1 = 0;
  } else if(isDefined(var_2)) {
    var_4 = 0.1;

    if(istrue(self._id_0B67._id_24E1)) {
      if(var_2 > var_1 + var_4) {
        self._id_0B67._id_24E1 = 0;
      }
    } else
      self._id_0B67._id_24E1 = var_2 < var_1;
  } else if(istrue(level._id_8596))
    self._id_0B67._id_24E1 = 1;
  else {
    self._id_0B67._id_24E1 = 0;
  }

  if(var_3 != self._id_0B67._id_24E1) {
    if(_id_0009::_id_1C61() != "patrol" && (!isDefined(self._id_006A) || !self._id_006A)) {
      if(self._id_0B67._id_24E1) {
        self[[self._id_5DC6]]();
      } else {
        self[[self._id_5DC5]]();
      }
    }
  }
}

_id_7CC7(var_0) {
  _id_08AC::_id_D645();
  var_0._id_A4E0 = gettime() + randomintrange(500, 2000);

  if(isDefined(self._id_0408._id_AF05)) {
    self._id_A246 = self._id_0408._id_AF05;
  } else {
    self._id_A246 = 1;
  }
}

_id_88B3() {
  return isDefined(self._id_0408._id_24FE) && self._id_0408._id_24FE;
}

_id_7CC5(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_5 = self _meth_8515(var_4);

    if(!isDefined(var_1) || var_5 > var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  var_5 = var_2;
  var_7 = 0.25;

  if(self._id_0408._id_24FE) {
    var_8 = 2000;

    if(var_5 >= var_7) {
      var_0._id_413C = gettime();
    }

    if(gettime() > var_0._id_413C + var_8) {
      if(var_5 < var_7 * 0.9) {
        self._id_0408._id_24FE = 0;
        self._id_0408._id_7CCB = undefined;

        if(!isDefined(self._id_0323) && isDefined(var_0._id_7CCD)) {
          self._id_0B67._id_7CCD = var_0._id_7CCD;
          return;
        }

        return;
      }

      return;
    }
  } else if(var_5 >= var_7) {
    var_9 = _id_08B5::_id_666E();

    if(isDefined(var_9) && !self _meth_8067(var_1)) {
      var_1 = var_9;
    }

    self._id_0408._id_24FE = 1;
    self._id_0408._id_7CCB = var_1;
    var_0._id_413C = gettime();
    var_0._id_7CCD = self._id_0B67._id_7CCD;
    self._id_0B67._id_7CCD = undefined;
    _id_08B5::_id_D2E7(var_1.origin, "small");
  }
}

_id_FD2A(var_0) {
  if(scripts\engine\utility::_id_5C00("stealth_spotted")) {
    var_0 = "hunt";
  }

  var_1 = !isDefined(self._id_0408._id_F159);

  if(!var_1) {
    switch (self._id_0408._id_F159) {
      case "combat_hunt":
        var_1 = var_0 != "hunt" && var_0 != "combat_hunt";
        break;
      case "spotted":
        var_1 = var_0 != "combat" && var_0 != "spotted";
        break;
      case "hidden":
        var_1 = var_0 != "idle" && var_0 != "unaware" && var_0 != "hidden";
        break;
      default:
        var_1 = self._id_0408._id_F159 != var_0;
        break;
    }
  }

  if(var_1) {
    _id_08AC::_id_D3A0(var_0);
  }
}

_id_7CBB(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  self._id_01BD = undefined;
  self._id_017F = 1;
  self._id_03D1 = undefined;
  self._id_0DDF._id_4AC4 = 1;
  self._id_0408._id_C06F = 0;
  thread _id_08AA::_id_3D7B();
  _id_7CC7(self._id_2C5E._id_82FD[var_0]);
  self._id_010D = "no_cover";

  foreach(var_2 in level.players) {
    if(!isDefined(var_2._id_0408)) {
      continue;
    }
    if(!isDefined(var_2._id_0408._id_E439)) {
      continue;
    }
    var_2._id_0408._id_E439[self._id_F94F] = undefined;
  }

  self._id_0162 = 1;
  self _meth_8079();
  self._id_0408._id_24FE = 0;
  self._id_2C5E._id_82FD[var_0]._id_413C = -1;
  thread _id_08AC::_id_D13D("reset");
  _id_08AD::_id_5696();

  if(isDefined(self._id_0408._id_6035["hidden"])) {
    _id_08A8::_id_E79D("hidden");
  }

  if(isDefined(self.target)) {
    self._id_0201 = 32;

    if(isDefined(self._id_5DC7)) {
      self thread[[self._id_5DC7]](undefined, undefined, undefined);
    }
  }

  self._id_0213 = "gun_down";
}

_id_7CC4(var_0) {
  _id_08AA::_id_3D83();

  if(istrue(self._id_0408._id_2572)) {
    _id_FD2A("blind");
  } else {
    _id_FD2A("hidden");
  }

  if(isDefined(self._id_0408._id_0F2D)) {
    foreach(var_2 in self._id_0408._id_0F2D) {
      self[[var_2]]();
    }
  }

  var_4 = gettime();

  if(var_4 >= self._id_2C5E._id_82FD[var_0]._id_A4E0) {
    _id_7CC7(self._id_2C5E._id_82FD[var_0]);
  }

  if(istrue(self._id_0408._id_25B3)) {
    _id_97FE();
  }

  _id_7CC5(self._id_2C5E._id_82FD[var_0]);
  _id_7CC6();
  return anim._id_CA5F;
}

_id_7CC1(var_0) {
  self._id_0162 = 0;
  self._id_0DDF._id_4AC4 = 0;
  self._id_0408._id_24FE = undefined;
  self._id_0408._id_7CCB = undefined;
  self._id_0B67._id_7CCD = undefined;

  if(self._id_0408._id_2C56 != 1) {
    self.cqb_target_pos = undefined;
  }

  _id_08B5::_id_CB38();
  self._id_8F58 = undefined;
  self._id_8F57 = undefined;
  self._id_A246 = 1;
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_7CC6() {
  if(!isDefined(self._id_0B67._id_24E1) || !self._id_0B67._id_24E1) {
    self.cqb_target_pos = undefined;
  } else {
    if(self._id_0408._id_24FE && isDefined(self._id_0408._id_7CCB)) {
      self.cqb_target_pos = self _meth_8204(self._id_0408._id_7CCB);
      return;
    }

    var_0 = 0;

    foreach(var_2 in level.players) {
      if(self _meth_8515(var_2) > 0.1) {
        self.cqb_target_pos = self _meth_8204(var_2);
        var_0 = 1;
        break;
      }
    }

    if(!var_0) {
      if(isDefined(self._id_0408._id_5E91)) {
        self.cqb_target_ent = self._id_0408._id_5E91;
      } else {
        var_4 = anglesToForward(self.angles);
        self.cqb_target_pos = self.origin + var_4 * 128;
      }
    }
  }
}

_id_E7DC(var_0) {
  if(self._id_0408._id_2C56 == 1) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_5AE6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = _func_034B(var_3, var_1, var_2, var_0._id_FE54, 48);

    if(isDefined(var_7) && isDefined(var_6) && var_6 && !_id_8513(var_1, var_7)) {
      return undefined;
    }

    return var_7;
  } else if(var_5 > 64 && isDefined(var_4)) {
    var_7 = _func_034F(var_4, var_5, var_1, var_2, var_0._id_FE54, 48);

    if(isDefined(var_7) && isDefined(var_6) && var_6 && !_id_8513(var_1, var_7)) {
      return undefined;
    }

    return var_7;
  }

  return _func_02A9(var_1, 200, self);
}

_id_8513(var_0, var_1) {
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = var_1 - self.origin;
  var_4 = length(var_3);

  if(var_4 > 256) {
    var_3 = var_3 / var_4;

    if(vectordot(var_3, var_2) < -0.5) {
      return 0;
    }
  }

  return 1;
}

_id_8504(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = var_0 - vectornormalize(var_1) * 32;
  var_2 = _func_02AB(var_2, self);
  return var_2;
}

_id_8505() {
  var_0 = 1;
  var_1 = self._id_0408._id_8522;

  if(isDefined(self._id_0408._id_8511)) {
    var_2 = _func_02AB(var_1._id_8512, self);
    var_3 = vectornormalize(self._id_0200 - self.origin);
    var_4 = anglesToForward(self.angles);
    var_5 = vectornormalize(var_2 - self.origin);

    if(isPlayer(var_1._id_019B) && !isPlayer(self._id_0408._id_8502)) {
      var_0 = 1;
    } else if(vectordot(var_3, var_5) < 0 && vectordot(var_4, var_5) < 0) {
      var_0 = 1;
    } else if(var_1._id_F8E4 == "saw_corpse") {
      var_0 = 1;
    } else if(var_0 && distancesquared(self._id_0200, var_2) < _func_0219(300)) {
      var_0 = 0;
    }
  }

  if(var_0) {
    var_6 = level._id_0408._id_851E[self._id_CE6E];
    var_7 = _id_08AF::_id_6A80(self._id_CE6E);
    var_8 = _id_08AF::_id_7208(var_7, self);

    if(!isDefined(var_8)) {
      return self.origin;
    }

    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_8._id_8526) && var_8._id_8526 == self || var_8._id_9DB5[0] == self) {
      var_9 = 1;
    } else if(distancesquared(self.origin, var_1._id_8512) < 16384) {
      var_11 = 1;
    } else if(var_8._id_9DB5.size > 1 && var_8._id_9DB5[1] == self) {
      var_10 = 1;
    }

    if(!isDefined(var_8._id_FE54)) {
      var_8._id_FE54 = [];
      var_8._id_FE55 = [];
    }

    var_12 = undefined;

    if(var_9) {
      if(var_1._id_F8E4 == "saw_corpse" || distance2dsquared(self.origin, var_1._id_8512) < 4096) {
        var_12 = var_1._id_8512;

        if(var_1._id_F8E4 == "saw_corpse") {
          var_12 = _id_8504(var_12);
        }

        if(isDefined(var_6)) {
          var_13 = self _meth_861B(var_12, var_6);

          if(isDefined(var_13)) {
            var_12 = var_13;
          }
        }
      }

      if(!isDefined(var_12)) {
        var_12 = _id_5AE6(var_8, var_1._id_8512, var_1._id_8512, var_6, self._id_03B2, self._id_0201, 1);

        if(!isDefined(var_12)) {
          if(isDefined(var_6)) {
            var_12 = self _meth_861B(var_1._id_8512, var_6);
          }

          if(!isDefined(var_12)) {
            var_12 = _id_5AE6(var_8, var_1._id_8512, self.origin, var_6, self._id_03B2, self._id_0201, 1);
          }

          if(!isDefined(var_12)) {
            var_12 = self.origin;
          }
        }
      }
    } else if(var_10) {
      var_14 = randomfloatrange(0.7, 0.85);
      var_12 = _func_025E(self.origin, var_1._id_8512, var_14);
      var_12 = _id_5AE6(var_8, var_12, var_12, var_6, self._id_03B2, self._id_0201);
    } else if(!var_11)
      var_12 = _id_5AE6(var_8, var_1._id_8512, self.origin, var_6, self._id_03B2, self._id_0201);

    if(isDefined(var_12) && !_id_8513(var_1._id_8512, var_12)) {
      var_12 = undefined;
    }

    if(!isDefined(var_12)) {
      var_12 = _id_8506();
    } else {
      _id_08AF::_id_B980(var_8, var_12);
    }

    return var_12;
  }
}

_id_8506() {
  var_0 = _id_08AF::_id_6A80(self._id_CE6E);
  var_1 = _id_08AF::_id_7208(var_0, self);

  if(isDefined(var_1._id_8526) && var_1._id_8526 == self) {
    var_2 = undefined;

    if(isDefined(var_1._id_106A1)) {
      var_2 = self _meth_861B(var_1.origin, var_1._id_106A1);
    }

    if(!isDefined(var_2)) {
      var_2 = _func_02AB(var_1.origin, self);
    }

    var_1._id_8526 = undefined;
  } else
    var_2 = _id_08AF::_id_7213(self);

  return var_2;
}

_id_D5C0() {
  var_0 = 15;
  var_1 = 20;

  if(isDefined(self._id_0408._id_8525)) {
    var_0 = self._id_0408._id_8525;
  }

  if(isDefined(self._id_0408._id_8524)) {
    var_1 = self._id_0408._id_8524;
  }

  self._id_0408._id_8521 = gettime() + randomintrange(var_0, var_1) * 1000;
}

_id_5AEE(var_0) {
  if(_id_06BD::_id_2413() && isDefined(self._id_1C30._id_426A._id_1C02)) {
    return self._id_1C30._id_426A._id_1C02;
  }

  if(istrue(self._id_94D7)) {
    return vectortoangles(var_0 - self.origin);
  }

  var_1 = _func_0350(var_0, 256, 96);

  if(isDefined(var_1)) {
    return vectortoangles(var_1);
  }
}

_id_8517() {
  return !istrue(self._id_94D7);
}

_id_8507() {
  var_0 = self._id_0408._id_8522;
  self._id_0408._id_8516 = var_0.type;
  self._id_0408._id_8502 = var_0._id_019B;
  self._id_CD56 = 0;
  _id_FD2A("investigate");
  self._id_0162 = 1;
  self._id_0DDF._id_4AC4 = 1;

  if(_id_8517()) {
    self._id_0B67._id_24E0 = 1;
  }

  _id_8514(var_0);
  self._id_0408._id_250D = 1;

  if(!self _meth_81C7()) {
    if(istrue(self._id_E7F6)) {
      self._id_0213 = "gun_down";
    } else {
      self._id_0213 = "ready";
    }
  }
}

_id_8514(var_0) {
  var_1 = "small";

  if(var_0._id_F8E4 == "bulletwhizby" || var_0._id_F8E4 == "grenade danger") {
    var_1 = "med";
  } else if(var_0._id_F8E4 == "footstep_sprint") {
    if(isDefined(var_0._id_019B) && isPlayer(var_0._id_019B) && var_0._id_019B _id_08B4::_id_B51A(self)) {
      var_1 = "med";
    }
  }

  _id_08B5::_id_D2E7(var_0._id_8512, var_1);
}

_id_851C(var_0) {
  _id_08AA::_id_3D83();

  if(isDefined(self._id_0192)) {
    self _meth_8079();
  }

  _id_FD2A("investigate");

  if(istrue(self._id_0408._id_25B3)) {
    _id_97FE();
  }

  if(isDefined(self._id_0408._id_0F2D)) {
    foreach(var_2 in self._id_0408._id_0F2D) {
      self[[var_2]]();
    }
  }

  return anim._id_EACB;
}

_id_8515(var_0, var_1, var_2) {
  _id_08B5::_id_D2E8("combat", var_2, var_1, "med");
  var_0._id_A4DD = gettime() + 100;
  var_0._id_A4DE = 256;
  var_0._id_A4DF = 100;
  self._id_1C30._id_426A._id_1C02 = undefined;
}

_id_850C(var_0) {
  self._id_01DE = self._id_0039 <= 2;
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2._id_E72D = var_1;
  var_2._id_3E39 = var_1 + randomintrange(2000, 4000);
  self._id_2C5E._id_82FD[var_0] = var_2;
  var_3 = self._id_0408._id_8522._id_F8E4;

  if(var_3 == "saw_corpse") {
    if(isDefined(self._id_0408._id_3D77._id_5469)) {
      var_2._id_A497 = var_1 + 200;
    }
  } else if(var_3 == "grenade danger") {
    self._id_0207 = 1.0;
    self._id_0209 = 0;
    _id_08B5::_id_D2E8("alert");
    return;
  }

  var_4 = _id_08AF::_id_6A80(self._id_CE6E);
  var_5 = _id_08AF::_id_7208(var_4, self);

  if(self._id_0408._id_250D) {
    var_6 = _id_8505();
  } else {
    var_6 = _id_8506();
  }

  if(isDefined(var_5._id_A416)) {
    var_5._id_A416 = scripts\engine\utility::array_remove(var_5._id_A416, self);
  }

  if(isDefined(var_5._id_8526) && var_5._id_8526 == self) {
    var_5._id_8526 = undefined;
  }

  if(isDefined(var_6)) {
    self._id_0408._id_8511 = var_6;
    self _meth_84BC(0, var_6);
    self _meth_8600(0, 24);
    var_2._id_0200 = var_6;
    var_2._id_A781 = 0;

    if(self._id_0408._id_250D) {
      if(var_3 == "saw_corpse" || var_3 == "found_corpse") {
        _id_8515(self._id_2C5E._id_82FD[var_0], var_6, 1);
      } else if(var_3 == "bulletwhizby") {
        _id_08B5::_id_D2E8("cqb");
        self._id_1C30._id_426A._id_1C02 = _id_5AEE(var_6);
      } else {
        _id_08B5::_id_D2E8("alert");
        var_7 = self._id_0408._id_8522._id_97DB;

        if(!isDefined(var_7)) {
          var_7 = self._id_0408._id_8522._id_8512;
        }

        _id_850D(var_2, var_7, var_3);
        self._id_1C30._id_426A._id_1C02 = _id_5AEE(var_6);
      }
    } else {
      _id_08B5::_id_D2E8("alert");
      self._id_A246 = 1;
      self._id_1C30._id_426A._id_1C02 = _id_5AEE(var_6);
    }

    if(distance2dsquared(self.origin, var_6) < 1 && self._id_0408._id_250D || !_id_8517()) {
      self._id_0B67._id_24E0 = undefined;
    } else {
      self._id_0B67._id_24E0 = 1;
    }
  }

  self._id_4AC9 = 1;
  var_2._id_5259 = var_1 + 2000;
}

_id_850D(var_0, var_1, var_2) {
  var_3 = 5000;

  if(isDefined(var_2)) {
    switch (var_2) {
      case "sight":
        var_3 = 1000;
        break;
      case "glass_destroyed":
      case "light_killed":
        var_3 = 3000;
        break;
    }
  }

  self.cqb_target_pos = var_1;
  var_0._id_3E38 = gettime() + var_3;
}

_id_D8A8(var_0) {
  var_1 = 400;
  var_0._id_3E3D = 1;
  var_0._id_3E3C = gettime() + var_1;
  var_0._id_3E3E = 0;

  if(scripts\engine\utility::cointoss()) {
    var_0._id_3E3B = 1;
  } else {
    var_0._id_3E3B = -1;
  }
}

_id_C60E(var_0) {
  var_0._id_3E39 = gettime() + randomintrange(2000, 4000);
  var_0._id_3E3D = undefined;
  var_0._id_3E3C = undefined;
  var_0._id_3E3E = undefined;
  var_0._id_3E3B = undefined;
}

_id_FD0B(var_0, var_1) {
  var_2 = 400;
  var_3 = 1000;
  var_4 = 20;
  var_5 = anglesToForward(self.angles);
  var_6 = gettime();

  switch (var_0._id_3E3E) {
    case 0:
      var_7 = (var_0._id_3E3C - var_6) / var_2;

      if(var_7 > 0) {
        var_8 = var_4 * (1 - sin(var_7 * 90)) * var_0._id_3E3B;
        self.cqb_target_pos = self.origin + rotatevector(var_5, (0, var_8, 0)) * var_1;
        break;
      } else {
        var_0._id_3E3C = var_6 + var_3;
        var_0._id_3E3E++;
      }
    case 1:
      if(var_6 < var_0._id_3E3C) {
        self.cqb_target_pos = self.origin + rotatevector(var_5, (0, var_4 * var_0._id_3E3B, 0)) * var_1;
        break;
      } else {
        var_0._id_3E3C = var_6 + var_2;
        var_0._id_3E3E++;
      }
    case 2:
      var_7 = (var_0._id_3E3C - var_6) / var_2;

      if(var_7 > 0) {
        var_8 = var_4 * sin(var_7 * 90) * var_0._id_3E3B;
        self.cqb_target_pos = self.origin + rotatevector(var_5, (0, var_8, 0)) * var_1;
      } else
        _id_C60E(var_0);

      break;
  }
}

_id_850F(var_0) {
  var_1 = gettime();

  if(isDefined(var_0._id_3E38)) {
    if(isDefined(self.cqb_target_pos)) {
      var_2 = self.cqb_target_pos - self.origin;
      var_3 = isDefined(self._id_0408._id_AF2F) || isDefined(self._id_0408._id_2B71);

      if(var_1 > var_0._id_3E38 || !var_3 && abs(self.angles[1], _func_0261(var_2)) > 50) {
        self.cqb_target_pos = undefined;
        var_0._id_3E38 = undefined;
        var_0._id_3E39 = var_1 + randomintrange(2000, 4000);
      }
    } else {
      var_0._id_3E38 = undefined;
      var_0._id_3E39 = var_1 + randomintrange(2000, 4000);
    }
  }

  if(!isDefined(var_0._id_3E38)) {
    var_4 = anglesToForward(self.angles);
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(self _meth_8515(var_7) > 0) {
        var_5 = 1;
        _id_C60E(var_0);
        self.cqb_target_pos = self _meth_8204(var_7);
        break;
      }
    }

    if(!var_5) {
      var_9 = 400;
      var_10 = 1000;
      var_11 = 20;

      if(isDefined(var_0._id_3E3D)) {
        _id_FD0B(var_0, 78);
      } else if(isDefined(var_0._id_3E39) && var_1 > var_0._id_3E39) {
        var_0._id_3E3D = 1;
        var_0._id_3E3C = var_1 + var_9;
        var_0._id_3E3E = 0;

        if(scripts\engine\utility::cointoss()) {
          var_0._id_3E3B = 1;
        } else {
          var_0._id_3E3B = -1;
        }

        _id_FD0B(var_0, 78);
      } else
        self.cqb_target_pos = self.origin + var_4 * 78;
    }
  }
}

_id_850B(var_0) {
  if(self _meth_81CC()) {
    return anim._id_EACB;
  }

  if(self._id_0408._id_8522._id_F8E4 == "grenade danger") {
    return anim._id_EACB;
  }

  var_1 = gettime();
  var_2 = self._id_2C5E._id_82FD[var_0];
  var_3 = _id_08AF::_id_6A80(self._id_CE6E);
  var_4 = _id_08AF::_id_7208(var_3, self);
  var_5 = _id_06BD::_id_2413();

  if(self._id_0063 && var_5 && distancesquared(self._id_0200, self.origin) < 225) {
    _id_06BD::_id_23F4();
  }

  if(isDefined(var_4) && isDefined(var_4._id_A416) && scripts\engine\utility::array_contains(var_4._id_A416, self)) {
    var_6 = _id_8506();
    var_4._id_A416 = scripts\engine\utility::array_remove(var_4._id_A416, self);
    self _meth_84BC(0, var_6);
    var_7 = self._id_0408._id_8522._id_F8E4;

    if(var_7 == "saw_corpse" || var_7 == "found_corpse") {
      _id_8515(var_2, var_6, 0);
    } else {
      var_8 = gettime() > var_2._id_E72D;
      var_9 = "alert";
      var_10 = "small";

      if(var_7 == "bulletwhizby" || _id_0009::_id_1C61() == "combat") {
        var_9 = "cqb";
        var_10 = "med";
      }

      if(istrue(self._id_0408._id_250D) && isDefined(self._id_0323) && distancesquared(self._id_0323, var_6) < 576) {
        var_8 = 0;
      }

      _id_08B5::_id_D2E8(var_9, var_8, var_6, var_10);
      var_11 = self._id_0408._id_8522._id_97DB;

      if(!isDefined(var_11)) {
        var_11 = self._id_0408._id_8522._id_8512;
      }

      _id_850D(var_2, var_11, var_7);
      self._id_1C30._id_426A._id_1C02 = _id_5AEE(var_6);
      var_2._id_A497 = undefined;
    }
  }

  if(isDefined(var_2._id_A497) && var_1 > var_2._id_A497) {
    if(isDefined(self._id_0408._id_3D77._id_5469)) {
      var_12 = self._id_0408._id_3D77._id_5469 _id_08B5::_id_6987();
      var_12 = _id_8504(var_12);
      self _meth_84BC(0, var_12);
      var_2._id_A497 = var_1 + 200;
    } else
      var_2._id_A497 = undefined;
  }

  if(isDefined(var_2._id_5259) && var_1 > var_2._id_5259) {
    self._id_4AC9 = undefined;
    var_2._id_5259 = undefined;
  }

  var_13 = level.player;

  if(self _meth_8067(var_13)) {
    _id_850D(var_2, self _meth_8204(var_13) + (0, 0, 32), "sight");
  }

  _id_850F(var_2);

  if(_id_880B(var_2)) {
    return anim._id_EACB;
  }

  if(isDefined(var_2._id_A4DD) && var_1 >= var_2._id_A4DD) {
    var_14 = 512;

    if(isDefined(var_2._id_A4DE)) {
      var_14 = var_2._id_A4DE;
    }

    if(self _meth_8473() > var_14) {
      var_15 = 1000;

      if(isDefined(var_2._id_A4DF)) {
        var_15 = var_2._id_A4DF;
      }

      var_2._id_A4DD = var_1 + var_15;
    } else {
      _id_08B5::_id_D2E8("alert");
      var_2._id_A4DD = undefined;
    }
  }

  return anim._id_CA5F;
}

_id_850E(var_0) {
  self._id_01DE = 0;
  self._id_0408._id_250D = 0;
  self._id_2C5E._id_82FD[var_0] = undefined;
  self.cqb_target_pos = undefined;
  self._id_4AC9 = undefined;
  self._id_0408._id_24DD = undefined;
  _id_08AA::_id_3D7B();
}

_id_8509(var_0) {
  var_1 = spawnStruct();
  var_1._id_58DF = gettime() + 8000;

  if(isDefined(self._id_0408._id_CF75)) {
    var_1._id_81C3 = gettime() + self._id_0408._id_CF75 * 1000;
    self._id_0408._id_CF75 = undefined;
  }

  self._id_2C5E._id_82FD[var_0] = var_1;
  self _meth_84BC(0, self _meth_84DC());
  _id_08B5::_id_D2E8("alert");
  self._id_0408._id_2523 = 1;

  if(!self._id_0408._id_250D && !isDefined(self._id_0408._id_8521)) {
    _id_D5C0();
  }
}

_id_8508(var_0) {
  if(gettime() > self._id_2C5E._id_82FD[var_0]._id_58DF) {
    return anim._id_EACB;
  }

  if(self._id_0408._id_250D) {
    if(isDefined(self._id_2C5E._id_82FD[var_0]._id_81C3) && gettime() < self._id_2C5E._id_82FD[var_0]._id_81C3) {
      return anim._id_CA5F;
    }

    return anim._id_EACB;
  }

  var_1 = _id_08AF::_id_6A80(self._id_CE6E);
  var_2 = _id_08AF::_id_7208(var_1, self);

  if(isDefined(var_2) && isDefined(var_2._id_A416) && scripts\engine\utility::array_contains(var_2._id_A416, self)) {
    var_2._id_A416 = scripts\engine\utility::array_remove(var_2._id_A416, self);
    return anim._id_EACB;
  }

  if(_id_0009::_id_1C4F("investigate_look", "end")) {
    return anim._id_EACB;
  }

  foreach(var_4 in level.players) {
    if(self _meth_8515(var_4) > 0.05) {
      return anim._id_58E3;
    }
  }

  return anim._id_CA5F;
}

_id_850A(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0408._id_2523 = 0;
}

_id_851A(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(self _meth_8515(var_3) > 0.05) {
      self.cqb_target_pos = self _meth_8204(var_3);
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    return anim._id_CA5F;
  }

  var_5 = _id_08AF::_id_6A80(self._id_CE6E);
  var_6 = _id_08AF::_id_7208(var_5, self);
  var_6 _id_08AF::_id_B990(self, self.cqb_target_pos);
  return anim._id_EACB;
}

_id_851B() {
  self _meth_84C0(0);
  self._id_0162 = 0;
  self._id_0DDF._id_4AC4 = 0;
  self._id_0408._id_8511 = undefined;
  self._id_0408._id_8516 = undefined;
  self._id_0408._id_8502 = undefined;
  self._id_0408._id_8523 = undefined;
  self._id_0408._id_8522 = undefined;
  self._id_0408._id_250D = undefined;
  self._id_0408._id_2524 = undefined;
  self._id_0408._id_8521 = undefined;
  self._id_0B67._id_24E0 = undefined;
  self._id_1C30._id_426A._id_1C02 = undefined;
  self._id_A246 = 1;
  self.cqb_target_pos = undefined;
  _id_0843::_id_397B(_id_06BD::_id_23C6());
  _id_08AA::_id_3D7B();
}

_id_E7DB(var_0) {
  if(self._id_0408._id_2C56 == 2) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_7BC2(var_0, var_1) {
  foreach(var_3 in level._id_0408._id_7225._id_722F) {
    foreach(var_5 in var_3._id_B992) {
      if(var_5 == var_0) {
        continue;
      }
      if(var_5._id_E747 == 2 && isDefined(var_5._id_26C4) && distance2dsquared(var_0.origin, var_5.origin) < 576) {
        var_0._id_26C4 = 1;
        return 0;
      }
    }
  }

  return var_0 _id_08AF::_id_B985(var_0.origin) == var_1;
}

_id_7BC9() {
  if(!isDefined(self._id_0408._id_3936) || !isDefined(self._id_0408._id_3936._id_414A)) {
    if(!isDefined(self._id_CE6D) || !isDefined(level._id_0408._id_7BC5[self._id_CE6D]) || level._id_0408._id_7BC5[self._id_CE6D].size == 0) {
      return;
    }
    var_0 = _id_08A9::_id_6CE8(self.origin);

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(self._id_0408._id_3936)) {
      self._id_0408._id_3936 = spawnStruct();
    }

    var_1 = self._id_0408._id_3936;
    var_1._id_BC5B = [];
    var_1._id_BC5B[0] = var_0;
    var_1._id_BC5B[1] = var_0;
    var_1._id_88CD = 0;
    _id_08A9::_id_7BCC(var_0);
    var_1._id_420E = _id_08A9::_id_5AE8(self.origin, var_0._id_C94F);
    var_1._id_2C2B = 1;
  }
}

_id_7BA2() {
  if(isDefined(self._id_0408._id_3936)) {
    if(isDefined(self._id_0408._id_3936._id_414A)) {
      _id_08A9::_id_7BCE(self._id_0408._id_3936._id_414A);
    }

    self._id_0408._id_3936 = undefined;
  }
}

_id_7BA4(var_0, var_1) {
  foreach(var_3 in var_0._id_C1C0) {
    if(var_3._id_C1BF == var_1) {
      var_4 = var_3._id_F48F.origin;

      for(var_5 = 0; var_5 < var_1._id_C94F.size; var_5++) {
        if(distancesquared(var_1._id_C94F[var_5].origin, var_4) < 4) {
          return var_5;
        }
      }
    }
  }
}

_id_7BA5() {
  var_0 = self._id_0408._id_3936;
  var_1 = undefined;
  var_2 = 0;

  while(var_2 < 2) {
    var_3 = _id_08A9::_id_5AFC(self.origin, var_0._id_414A, var_0._id_420E, var_0._id_2C2B);

    if(isDefined(var_3)) {
      var_1 = var_3[0];
      var_0._id_420E = var_3[1];
      break;
    } else {
      if(var_2 == 1) {
        break;
      }

      var_4 = var_0._id_414A;
      _id_08A9::_id_7BD9();
      var_0._id_420E = 0;
      var_0._id_2C2B = 1;

      if(var_4 != var_0._id_414A) {
        var_5 = _id_7BA4(var_4, var_0._id_414A);

        if(isDefined(var_5)) {
          var_0._id_420E = var_5;
        } else {
          var_0._id_420E = _id_08A9::_id_5AE8(self.origin, var_0._id_414A._id_C94F);
        }

        if(var_0._id_420E > var_0._id_414A._id_C94F.size * 0.5) {
          var_0._id_2C2B = 0;
        }
      }

      var_2++;
    }
  }

  if(isDefined(var_1)) {
    self._id_1C30._id_426A._id_1C02 = var_1.angles;
    _id_0843::_id_D6CD(var_1);
    return var_1.origin;
  }

  var_6 = 0;
  var_7 = 1;
  var_8 = var_0._id_414A._id_C94F.size;

  if(var_0._id_420E > var_8 * 0.5) {
    var_6 = var_8 - 1;
    var_7 = var_6 - 1;
  }

  if(var_0._id_2C2B) {
    var_0._id_420E = var_0._id_414A._id_C94F.size;
  } else {
    var_0._id_420E = -1;
  }

  if(var_7 >= 0 && var_7 < var_8) {
    self._id_1C30._id_426A._id_1C02 = vectortoangles(var_0._id_414A._id_C94F[var_7].origin - var_0._id_414A._id_C94F[var_6].origin);
  }

  return var_0._id_414A._id_C94F[var_6].origin;
}

_id_7BA6() {
  var_0 = _id_08AF::_id_6A80(self._id_CE6E);
  var_1 = _id_08AF::_id_7208(var_0, self);
  var_2 = undefined;

  if(isDefined(self._id_0408._id_CDED)) {
    var_2 = self._id_0408._id_CDED;
    self._id_0408._id_CDED = undefined;
    _id_7BA2();
  }

  if(scripts\common\utility::_id_74CF()) {
    var_3 = scripts\common\utility::_id_6306();
    var_2 = var_3.origin;
    self._id_0408._id_7BCB = 1;
    _id_7BA2();
  }

  if(!isDefined(var_2) && isDefined(var_1.origin) && !isDefined(var_1._id_26C4)) {
    if(_id_7BC2(var_1, self)) {
      var_2 = var_1.origin;
      var_1._id_26C4 = 1;
      _id_7BA2();
    }
  }

  if(!isDefined(var_2)) {
    _id_7BC9();

    if(isDefined(self._id_0408._id_3936)) {
      var_2 = _id_7BA5();
    } else {
      var_2 = _id_08AF::_id_7213(self, level._id_0408._id_7BCA[self._id_CE6E]);
    }
  }

  return var_2;
}

_id_7BAF() {
  self._id_010D = "no_cover";
  _id_08AC::_id_D3A0("hunt");
  _id_08AC::_id_D13D("combat_hunt");

  if(isDefined(self._id_5DC6)) {
    self[[self._id_5DC6]]();
  }

  self._id_0408._id_250C = 1;
  self._id_0162 = 1;
  self._id_0DDF._id_4AC4 = 1;
  self._id_15DD = 1;
  self._id_8F58 = undefined;
  self._id_8F57 = undefined;
  _id_7BC0();

  if(!self _meth_81C7()) {
    if(istrue(self._id_E7F6)) {
      self._id_0213 = "gun_down";
    } else {
      self._id_0213 = "ready";
    }
  }
}

_id_7BC0() {
  var_0 = _id_08AF::_id_6A80(self._id_CE6E);
  var_1 = _id_08AF::_id_7208(var_0, self);

  if(isDefined(var_1._id_26C5) && !var_1._id_26C5) {
    self _meth_84BF(0, level._id_0408._id_7BCA[self._id_CE6E]);

    if(isDefined(self._id_CCE8)) {
      self._id_010D = self._id_CCE8;
    } else {
      self._id_010D = "cover";
    }
  }
}

_id_7BC8(var_0) {
  return anim._id_EACB;
}

_id_7BB1(var_0) {
  self._id_2C5E._id_82FD[var_0] = gettime() + randomintrange(500, 1500);
}

_id_7BB0(var_0) {
  if(!isDefined(self._id_0408._id_250C) || isDefined(_id_06BD::_id_23BC()) || gettime() >= self._id_2C5E._id_82FD[var_0]) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_7BB2(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_7BA3(var_0) {
  var_1 = _id_08AF::_id_6A80(self._id_CE6E);
  var_2 = _id_08AF::_id_7208(var_1, self);

  if(isDefined(var_2) && isDefined(var_2.target)) {
    var_3 = gettime();

    if(self _meth_8067(var_2.target) || self _meth_8515(var_2.target) > 0.1) {
      self.cqb_target_pos = var_2.target.origin;
      var_0._id_3E3A = var_3;
      return 1;
    } else if(_func_011D(var_2.target) && (isDefined(self._id_0408._id_2C66) || isDefined(var_0._id_3E3A) && var_3 - var_0._id_3E3A < 2000)) {
      self.cqb_target_pos = self _meth_8204(var_2.target);
      return 1;
    }
  }

  var_4 = anglesToForward(self.angles);
  self.cqb_target_pos = self.origin + var_4 * 384;
  return 0;
}

_id_7BC1(var_0) {
  var_1 = _id_08AF::_id_6A80(self._id_CE6E);
  var_2 = _id_08AF::_id_7208(var_1, self);

  if(isDefined(var_2) && istrue(var_2._id_24FD)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_7BAC(var_0) {
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2._id_A498 = var_1 + randomintrange(4000, 6000);
  self._id_2C5E._id_82FD[var_0] = var_2;
  self._id_0408._id_7BDA = var_1;
  _id_7BBF("cqb");
  var_3 = _id_08AF::_id_6A80(self._id_CE6E);
  var_4 = _id_08AF::_id_7208(var_3, self);
  var_5 = self _meth_80EC(undefined, 0, var_4.origin);

  if(isDefined(var_5)) {
    if(!isDefined(self._id_02ED) || self._id_02ED != var_5) {
      self._id_025E = 0;
      self._id_0260 = 0;
      self _meth_8423(var_5);
    }
  }
}

_id_7BA8(var_0) {
  var_1 = gettime();

  if(var_1 > self._id_2C5E._id_82FD[var_0]._id_A498) {
    var_2 = _id_08AF::_id_6A80(self._id_CE6E);
    var_3 = _id_08AF::_id_7208(var_2, self);
    var_4 = randomint(3) < 1;
    var_5 = self _meth_80EC("cover_hunt_hunker", var_4, var_3.origin);

    if(isDefined(var_5)) {
      var_6 = 0;

      if(!isDefined(self._id_02ED) || self._id_02ED != var_5) {
        self._id_025E = 0;
        self._id_0260 = 0;
        var_6 = !self _meth_8423(var_5);
      }

      if(var_6) {
        self._id_2C5E._id_82FD[var_0]._id_A498 = var_1 + 500;
      } else {
        self._id_2C5E._id_82FD[var_0]._id_A498 = var_1 + randomintrange(4000, 6000);
      }
    } else
      self._id_2C5E._id_82FD[var_0]._id_A498 = var_1 + randomintrange(2000, 4000);
  }

  _id_7BA3(self._id_2C5E._id_82FD[var_0]);
  return anim._id_CA5F;
}

_id_7BAE(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_7BAD(var_0) {
  var_1 = 5000;

  if(!_id_88C9(self._id_9490)) {
    var_1 = 3000;
  }

  if(gettime() > self._id_0408._id_7BDA + var_1) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_7BAA(var_0) {
  var_1 = spawnStruct();
  var_1._id_534E = gettime() + 4000;
  var_1._id_A4C8 = 0;
  var_1._id_A4C6 = 0;
  self._id_2C5E._id_82FD[var_0] = var_1;
  _id_06BD::_id_23ED("exposed");

  if(scripts\engine\utility::_id_8946(self._id_02ED) || scripts\engine\utility::_id_8948(self._id_02ED)) {
    _id_06BD::_id_23EB("B");
  } else {
    _id_06BD::_id_23EB("exposed");
  }

  self._id_0408._id_2C66 = 1;
}

_id_7BA9(var_0) {
  var_1 = gettime();
  var_2 = self._id_2C5E._id_82FD[var_0];

  if(var_1 > var_2._id_534E) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_7BAB(var_0) {
  self.cqb_target_pos = undefined;
  self._id_2C5E._id_82FD[var_0] = undefined;
  _id_06BD::_id_23ED("hide");
  self._id_0408._id_2C66 = undefined;
  self._id_0408._id_7BDA = gettime();
}

_id_7BB3(var_0) {
  if(!isDefined(self._id_02ED)) {
    return anim._id_58E3;
  }

  var_1 = 16;

  if(isDefined(self._id_0323)) {
    if(distancesquared(self._id_0323, self.origin) > var_1) {
      return anim._id_58E3;
    }
  } else if(self._id_0260)
    var_1 = 3600;
  else {
    var_1 = 225;
  }

  if(distance2dsquared(self._id_02ED.origin, self.origin) > var_1) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_7BA1(var_0) {
  _id_0843::_id_397B(_id_06BD::_id_23C6());
}

_id_7BB9(var_0) {
  var_1 = gettime();
  var_2 = spawnStruct();
  self._id_2C5E._id_82FD[var_0] = var_2;
  var_2._id_E72D = var_1;
  var_3 = _id_7BA6();
  self _meth_84BC(0, var_3);
  var_2._id_0200 = var_3;
  var_2._id_A781 = 0;
  var_4 = _id_06BD::_id_23C6();

  if(isDefined(var_4)) {
    _id_0843::_id_D4F8(var_4);
    self _meth_8600(0, 12);
  } else {
    if(!isDefined(self._id_1C30._id_426A._id_1C02)) {
      self._id_1C30._id_426A._id_1C02 = _id_5AEE(var_3);
    }

    self _meth_8600(0, 36);
  }

  _id_7BBF("cqb");
  self._id_4AC9 = 1;
  var_2._id_5259 = var_1 + 2000;
}

_id_7BBF(var_0) {
  if(scripts\common\utility::_id_8549()) {
    _id_08B5::_id_D2E8("sprint");
  } else {
    _id_08B5::_id_D2E8(var_0);
  }
}

_id_7BC3(var_0) {
  var_1 = 36;
  var_2 = 36;
  var_3 = 36;
  var_4 = gettime();
  var_5 = 2000;

  if(isDefined(var_0._id_3D6F) && var_4 >= var_0._id_3D70 + var_5) {
    var_0._id_3D6F = undefined;
    var_0._id_3D70 = undefined;
    self._id_0B67._id_01D3 = 0;
    self._id_0B67._id_01D4 = undefined;
    _id_08B5::_id_D2E8("cqb");
    self._id_4AC9 = undefined;
  }

  if(!isDefined(var_0._id_3D6F) && !self._id_0063 && self._id_0280 > 32 && self _meth_8473() > 128) {
    var_6 = self _meth_84A6(var_1);
    var_7 = anglesToForward(self.angles);
    var_8 = _func_00B4(var_6, var_3, 0, 60, "Cover");

    if(var_8.size > 0) {
      foreach(var_10 in var_8) {
        if(!var_10 _meth_80B9("stand")) {
          continue;
        }
        var_11 = var_10.origin - self.origin;

        if(vectordot(var_11, var_7) < 0) {
          continue;
        }
        var_12 = _func_000B(var_10.angles[1] - self.angles[1]);

        if(var_12 > 0 && var_10.type != "Cover Right") {
          continue;
        } else if(var_12 < 0 && var_10.type != "Cover Left") {
          continue;
        }
        var_13 = anglesToForward(var_10.angles);
        var_14 = vectordot(var_13, var_7);

        if(var_14 > 0.5 || var_14 < -0.5) {
          continue;
        }
        if(abs(_func_000B(self.angles[1] - var_10.angles[1])) < 45) {
          continue;
        }
        if(vectordot(self._id_027F, var_11) > 32) {
          continue;
        }
        var_0._id_3D6F = var_10;
        var_0._id_3D70 = var_4;
        break;
      }
    }
  }

  if(isDefined(var_0._id_3D6F)) {
    var_17 = var_0._id_3D6F;
    var_18 = undefined;
    var_19 = anglestoaxis(var_17.angles);
    var_20 = var_19["right"];

    if(var_17.type == "Cover Left") {
      var_20 = -1 * var_20;
    }

    var_21 = 20;
    var_22 = var_17.origin + var_21 * var_19["forward"] + var_21 * var_20;
    var_23 = self.origin - var_17.origin;

    if(vectordot(var_23, var_20) < var_21) {
      var_18 = var_22;
    } else {
      var_18 = self.origin + rotatevector((128, 0, 0), var_17.angles);
    }

    self._id_0B67._id_01D3 = 1;
    self._id_0B67._id_01D4 = var_18;
    scripts\engine\utility::set_movement_speed(30);
    self._id_4AC9 = 1;
  }
}

_id_7BB8(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];
  var_2 = gettime();
  var_3 = _id_06BD::_id_2413();
  var_4 = 225;

  if(self._id_0063 && var_3 && distancesquared(self._id_0200, self.origin) < var_4) {
    _id_06BD::_id_23F4();
  }

  if(_id_880B(var_1)) {
    return anim._id_EACB;
  }

  if(scripts\common\utility::_id_74CF()) {
    if(!istrue(self._id_0408._id_7BCB)) {
      return anim._id_EACB;
    }

    if(scripts\common\utility::_id_854A()) {
      var_5 = scripts\common\utility::_id_6306();

      if(distancesquared(self._id_0200, var_5.origin) > var_4) {
        return anim._id_EACB;
      }
    }
  }

  if(_id_0009::_id_1C4F("hunt", "knownpos") && (!isDefined(self._id_0408._id_8FCF) || var_2 > self._id_0408._id_8FCF)) {
    if(var_3) {
      _id_0843::_id_397B(_id_06BD::_id_23C6());
    }

    return anim._id_EACB;
  }

  if(_id_7BC1() == anim._id_EACB) {
    if(var_3) {
      _id_0843::_id_397B(_id_06BD::_id_23C6());
    }

    return anim._id_EACB;
  }

  if(isDefined(var_1._id_5259) && var_2 > var_1._id_5259) {
    self._id_4AC9 = undefined;
    var_1._id_5259 = undefined;
  }

  if(isDefined(self._id_0323) && (self._id_0062 || !self._id_01B7) && var_3 && self _meth_8473() < 56) {
    self._id_0B67._id_01D3 = 1;
    var_6 = _id_06BD::_id_23C6();
    self._id_0B67._id_01D4 = var_6.origin + rotatevector((128, 0, 0), var_6.angles);
  } else
    _id_7BC3(var_1);

  if(isDefined(self._id_0408._id_3936) && isDefined(self._id_0408._id_3936._id_414A)) {
    _id_08A9::_id_7BDF(self._id_0408._id_3936._id_414A);
  }

  _id_7BA3(var_1);
  return anim._id_CA5F;
}

_id_7BBA(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;

  if(isDefined(self._id_0408._id_2B71)) {
    self._id_0408._id_250C = 1;
  } else {
    self._id_0408._id_250C = undefined;
  }

  self.cqb_target_pos = undefined;
  self._id_1C30._id_426A._id_1C02 = undefined;
  self._id_1C30._id_426A._id_1C10 = undefined;
  self._id_1C30._id_426A._id_1C15 = undefined;
  self._id_4AC9 = undefined;
  self._id_0B67._id_01D3 = 0;
  self._id_0B67._id_01D4 = undefined;
}

_id_7BB5(var_0) {
  var_1 = 8000;
  var_2 = spawnStruct();
  var_2._id_534E = gettime() + var_1;

  if(isDefined(self._id_0408._id_CD85)) {
    var_2._id_534E = gettime() + self._id_0408._id_CD85;
  }

  self._id_2C5E._id_82FD[var_0] = var_2;
  self _meth_84BC(0, self _meth_84DC());
  self _meth_8600(0, 36);

  if(istrue(self._id_0408._id_CE44)) {
    if(isDefined(self._id_0408._id_CD85)) {
      self._id_0408._id_2523 = 0;
    }
  } else
    self._id_0408._id_2523 = 1;
}

_id_7BB4(var_0) {
  if(isDefined(self._id_0408._id_250C)) {
    return anim._id_EACB;
  }

  if(scripts\common\utility::_id_74CF()) {
    return anim._id_EACB;
  }

  if(gettime() > self._id_2C5E._id_82FD[var_0]._id_534E) {
    return anim._id_EACB;
  }

  if(_id_0009::_id_1C4F("hunt", "knownpos") || _id_0009::_id_1C4F("investigate_look", "end") || !isDefined(self._id_0408._id_2523)) {
    self._id_0408._id_8FCF = gettime();
    return anim._id_EACB;
  }

  var_1 = isDefined(self.cqb_target_pos) || isDefined(self.cqb_target_ent);
  var_2 = _id_7BA3(self._id_2C5E._id_82FD[var_0]);

  if(!var_1 && (isDefined(self.cqb_target_pos) || isDefined(self.cqb_target_ent)) && var_2) {
    self._id_0408._id_2523 = undefined;

    if(isDefined(self.cqb_target_pos)) {
      var_3 = self.cqb_target_pos;
    } else {
      var_3 = self.cqb_target_ent.origin;
    }

    _id_08B5::_id_D2E7(var_3, "small");
  }

  return anim._id_CA5F;
}

_id_7BB6(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  self._id_0408._id_2523 = undefined;
}

_id_7BC6() {
  self._id_0408._id_250C = undefined;
  self._id_0408._id_7BDA = undefined;
  self._id_0162 = 0;
  self._id_0DDF._id_4AC4 = 0;
  self._id_A246 = 1;
  self._id_15DD = undefined;
  self._id_1C30._id_426A._id_1C02 = undefined;
  self._id_1C30._id_426A._id_1C10 = undefined;
  self._id_1C30._id_426A._id_1C15 = undefined;
  self._id_0408._id_7BCB = undefined;
  _id_7BA2();
  self.cqb_target_pos = undefined;
  self _meth_84C0(0);
}

_id_3A99() {
  self._id_017F = 0;
  self._id_0162 = 0;
  self._id_0DDF._id_4AC4 = 0;
  self._id_0095 = 1;
  self._id_00A3 = 1;
  _id_08AD::_id_5696();

  if(isDefined(self._id_CCE8)) {
    self._id_010D = self._id_CCE8;
  } else {
    self._id_010D = "cover";
  }

  _id_08AC::_id_D3A0("combat");
  var_0 = self.origin;

  if(istrue(self._id_0B67._id_24E1)) {
    if(isDefined(self._id_5DC6)) {
      self[[self._id_5DC6]]();
    }
  }

  var_1 = level._id_0408._id_3AAA[self._id_CE6E];

  if(isDefined(var_1)) {
    self _meth_84BF(0, var_1);
  } else if(isDefined(level._id_0408._id_3A97) && isDefined(level._id_0408._id_3A97[self._id_CE6E])) {
    self _meth_84BC(0, self._id_03B2);
    self _meth_8600(0, level._id_0408._id_3A97[self._id_CE6E]);
  }

  self _meth_862C();

  if(isDefined(self._id_0408._id_6035["spotted"])) {
    _id_08A8::_id_E79D("spotted");
  }

  _id_06D7::_id_0207();
  self._id_0B67._id_03BF = 0;
  self._id_0B67._id_D9FF = 1;
  thread combat_standstillandshoot(4);
  self._id_0213 = undefined;
}

_id_3AA8() {
  combat_standstillandshootcleanup();
  self._id_00A3 = 0;
  self _meth_84C0(0);
}

combat_standstillandshoot(var_0) {
  self endon("death");
  self endon("Combat_StandStillAndShootEnd");

  if(!istrue(self._id_0181)) {
    var_1 = gettime() + var_0 * 1000;

    while(gettime() < var_1 && isalive(level.player) && self _meth_8067(level.player) && self _meth_8068(level.player getEye())) {
      if(!isDefined(self.combatmodeprestandstill)) {
        self.combatmodeprestandstill = self._id_010D;
      }

      self._id_010D = "no_cover";
      wait 0.25;
    }
  }

  _id_06B0::_id_C56C(0, 0, undefined);
  combat_standstillandshootcleanup();
}

combat_standstillandshootcleanup() {
  if(isDefined(self.combatmodeprestandstill)) {
    self._id_010D = self.combatmodeprestandstill;
    self.combatmodeprestandstill = undefined;
  }

  self notify("Combat_StandStillAndShootEnd");
}

_id_3984() {
  if(isDefined(level._id_0408._id_3AAA[self._id_CE6E]) && _id_87B6() || isDefined(level._id_0408._id_7BCA[self._id_CE6E]) && _id_88AF()) {
    self _meth_84C0(0);
  }
}

_id_0F00() {
  if(isDefined(level._id_0408._id_3AAA[self._id_CE6E]) && _id_87B6()) {
    self _meth_84BF(0, level._id_0408._id_3AAA[self._id_CE6E]);
    self _meth_862C();
  } else if(isDefined(level._id_0408._id_7BCA[self._id_CE6E]) && _id_88AF())
    _id_7BC0();
}

_id_97FE() {
  if(isDefined(level._id_0408._id_5DA2)) {
    self[[level._id_0408._id_5DA2]]();
  }
}

_id_D6F1(var_0, var_1) {
  if(!scripts\engine\utility::_id_546E("stealth_enabled") || !isDefined(self._id_0408)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  switch (var_0) {
    case "idle":
      self._id_017F = 1;
      self._id_0162 = 1;

      if(istrue(self._id_0408._id_2572)) {
        _id_08AC::_id_D3A0("blind");
      } else {
        _id_08AC::_id_D3A0("hidden");
      }

      var_2 = _id_08AF::_id_6A80(self._id_CE6E);
      _id_08AF::_id_7219(var_2, self);
      _id_54E7(0);
      self notify("stealth_idle");
      break;
    case "investigate":
      if(var_1.type == "cover_blown") {
        self._id_0408._id_243B = 1;
      }

      if(self._id_0408._id_2C56 == 1) {
        if(isPlayer(self._id_0408._id_8502) && !isPlayer(var_1._id_019B) && var_1._id_F8E4 != "saw_corpse") {
          break;
        }

        if(isDefined(self._id_0408._id_8516)) {
          if(self._id_0408._id_8522._id_F8E4 == "saw_corpse" && var_1._id_F8E4 == "found_corpse" && var_1._id_019B == self._id_0408._id_8502) {
            break;
          }

          var_3 = _id_08AD::_id_56A9(self._id_0408._id_8516, var_1.type);

          if(var_3 >= 0) {
            self._id_0408._id_8516 = var_1.type;
            self._id_0408._id_8502 = var_1._id_019B;
            self._id_0408._id_8522 = var_1;
          }

          var_4 = gettime();
          var_5 = var_3 > 0 || var_4 > self._id_0408._id_8523 || distancesquared(var_1._id_8512, self.origin) < distancesquared(self._id_0408._id_8522._id_8512, self.origin);

          if(var_5) {
            var_2 = _id_08AF::_id_6A80(self._id_CE6E);
            var_6 = _id_08AF::_id_7208(var_2, self);
            var_7 = _id_08AF::_id_721D(var_2, var_6, 1, self, var_1._id_8512);

            if(isDefined(var_7)) {
              var_6 = var_7;
            }

            var_6 _id_08AF::_id_B990(self, var_1._id_8512);
            self._id_0408._id_8523 = var_4;
          }

          self._id_0408._id_8521 = undefined;
        }
      } else {
        if(var_1.type == "cover_blown") {
          _id_08AF::_id_7204(self._id_CE6E, self, var_1);
        } else {
          _id_08AF::_id_7206(self._id_CE6E, self, var_1);
        }

        self._id_0408._id_8522 = var_1;
        self._id_0408._id_8523 = gettime();
        _id_54E7(1);
        self notify("stealth_investigate");
      }

      break;
    case "hunt":
      self._id_0408._id_243B = 1;
      _id_08AF::_id_7205(self._id_CE6E, self);
      _id_54E7(2);
      self notify("stealth_hunt");
      break;
    case "combat":
      if(self._id_0408._id_2C56 != 3) {
        var_8 = isDefined(var_1) && var_1._id_F8E4 == "damage" && self._id_0043 && self._id_0044 && !self _meth_81C7();

        if(isDefined(var_1) && !var_8) {
          var_9 = "small";

          switch (var_1._id_F8E4) {
            case "proximity":
              var_9 = "smed";
              break;
            case "ally_killed":
            case "ally_damaged":
            case "gunshot":
            case "projectile_impact":
            case "bulletwhizby":
              var_9 = "med";
              break;
            case "grenade danger":
            case "explode":
              var_9 = "large";
              break;
            case "light_killed":
            case "attack":
            case "combat":
              if(distancesquared(var_1._id_8512, self.origin) < 40000) {
                var_9 = "med";
              }

              break;
          }

          var_10 = self._id_0192;

          if(!isDefined(var_10) && isDefined(var_1._id_019B) && _func_011D(var_1._id_019B)) {
            var_10 = var_1._id_019B;
          }

          if(var_9 == "small" && isDefined(var_10)) {
            if(self _meth_8067(var_10)) {
              var_9 = "med";
            } else if(var_1._id_F8E4 == "sight") {
              var_9 = "smed";
            }
          }

          _id_08B5::_id_D2E8("combat", 1, var_1._id_8512, var_9);
        } else
          _id_08B5::_id_D2E8("combat");

        if(isDefined(var_1) && var_8 && istrue(self._id_006A)) {
          _id_08FE::_id_488B();
        }
      }

      self._id_0408._id_243B = 1;
      var_10 = undefined;

      if(isDefined(var_1) && isDefined(var_1._id_019B)) {
        if(_func_011D(var_1._id_019B) && var_1._id_019B.team == self.team) {
          if(isDefined(var_1._id_019B._id_0192) && _func_011D(var_1._id_019B._id_0192)) {
            self _meth_861C(var_1._id_019B);
          }
        } else
          var_10 = var_1._id_019B;
      }

      _id_08AF::_id_7203(self._id_CE6E, self, var_10);
      _id_54E7(3);
      self notify("stealth_combat");
      break;
  }
}