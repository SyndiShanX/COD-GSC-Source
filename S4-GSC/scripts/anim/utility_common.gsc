/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
*************************************************/

_id_BCEE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    wait 0.05;
  }
}

_id_BCED(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100.0;
  var_6 = 0;
  var_0 = var_0 + scripts\engine\utility::_id_C019(30);

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_6 = var_6 + 0.5;
    wait 0.05;
  }
}

_id_409F(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

_id_CAE6(var_0, var_1) {
  var_2 = int(var_0) % var_1;
  var_2 = var_2 + var_1;
  return var_2 % var_1;
}

_id_BE97(var_0) {
  var_1 = cos(var_0);
  var_2 = sin(var_0);
  var_3["front"] = 0;
  var_3["right"] = 0;
  var_3["back"] = 0;
  var_3["left"] = 0;

  if(isDefined(self._id_165A)) {
    var_3["front"] = 1;
    return var_3;
  }

  if(var_1 > 0) {
    if(var_2 > var_1) {
      var_3["left"] = 1;
    } else if(var_2 < -1 * var_1) {
      var_3["right"] = 1;
    } else {
      var_3["front"] = 1;
    }
  } else {
    var_4 = -1 * var_1;

    if(var_2 > var_4) {
      var_3["left"] = 1;
    } else if(var_2 < var_1) {
      var_3["right"] = 1;
    } else {
      var_3["back"] = 1;
    }
  }

  return var_3;
}

_id_6C93(var_0) {
  var_0 = _func_000A(var_0);

  if(var_0 < 45 || var_0 > 315) {
    var_1 = "front";
  } else if(var_0 < 135) {
    var_1 = "left";
  } else if(var_0 < 225) {
    var_1 = "back";
  } else {
    var_1 = "right";
  }

  return var_1;
}

_id_88D0(var_0, var_1) {
  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

_id_10CF9() {
  return !isnullweapon(self._id_04F6) && weaponclass(self._id_04F6) == "grenade";
}

_id_10D12() {
  return !isnullweapon(self._id_04F6) && _func_0278(self._id_04F6) && weaponclass(self._id_04F6) == "spread";
}

_id_8A2E(var_0) {
  return weaponclass(var_0) == "spread";
}

_id_8A44(var_0) {
  return weaponclass(var_0) == "sniper";
}

_id_8A2F() {
  return _id_8A2E(self._id_034C);
}

_id_8766(var_0) {
  if(istrue(self._id_016F)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!_id_8A44(self._id_034C)) {
    return 0;
  }

  if(var_0) {
    if(self._id_034C != self._id_04F6) {
      return _id_8A44(self._id_04F6);
    }
  }

  return 1;
}

_id_8917() {
  return _id_8766() || _id_FF1B();
}

_id_FF15() {
  return weaponclass(self._id_04F6) == "pistol";
}

_id_FF1B() {
  return weaponclass(self._id_04F6) == "rocketlauncher";
}

_id_FF0F() {
  return weaponclass(self._id_04F6) == "mg";
}

_id_8AD3() {
  return weaponclass(self._id_04F6) == "spread";
}

_id_FF1A() {
  var_0 = weaponclass(self._id_04F6);

  switch (var_0) {
    case "sniper":
    case "spread":
    case "rifle":
    case "mg":
    case "smg":
      return 1;
  }

  return 0;
}

_id_C551(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_3 = var_0.basename;

  if(!isDefined(var_3) || var_3 != "iw7_repeater") {
    return;
  }
  if(!isDefined(var_2._id_0148)) {
    return;
  }
  if(var_2._id_0148 != "head" && var_2._id_0148 != "helmet") {
    return;
  }
  var_4 = weaponclipsize(var_0);
  var_5 = var_4 * 1.0;
  var_6 = var_1 getweaponammoclip(var_0);
  var_7 = min(var_6 + var_5, var_4);
  var_1 setweaponammoclip(var_0, int(var_7));
}

_id_A418(var_0) {
  if(isnullweapon(self._id_04F6)) {
    return 0;
  }

  if(istrue(self._id_016A)) {
    if(self._id_00CC < weaponclipsize(self._id_04F6) * 0.5) {
      self._id_00CC = int(weaponclipsize(self._id_04F6) * 0.5);
    }

    if(self._id_00CC <= 0) {
      self._id_00CC = 0;
    }

    return 0;
  }

  if(self._id_00CC <= weaponclipsize(self._id_04F6) * var_0) {
    if(var_0 == 0) {
      if(_id_3425()) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_3425() {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(self._id_01D5) {
    return 1;
  }

  if(self.team != "allies") {
    if(!isPlayer(self._id_0192)) {
      return 0;
    }
  }

  if(_id_8AD4() || _id_FF1B()) {
    return 0;
  }

  if(gettime() - self._id_1714 < self._id_1713) {
    return 0;
  }

  if(!self _meth_8067(self._id_0192) && distancesquared(self.origin, self._id_0192.origin) > 65536) {
    return 0;
  }

  self._id_00CC = int(weaponclipsize(self._id_04F6) / 2);

  if(self._id_00CC > weaponclipsize(self._id_04F6)) {
    self._id_00CC = weaponclipsize(self._id_04F6);
  }

  self._id_1714 = gettime();
  return 1;
}

_id_8ACD() {
  return self._id_04F6 == self._id_034C && !isnullweapon(self._id_04F6);
}

_id_8AD2() {
  return self._id_04F6 == self._id_03B5 && !isnullweapon(self._id_04F6);
}

_id_8AD4() {
  return self._id_04F6 == self._id_03D6 && !isnullweapon(self._id_04F6);
}

_id_695E() {
  return self._id_02ED;
}

_id_DA26(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  [[anim._id_DA27]](var_0);
}

_id_6BA8(var_0) {
  if(isDefined(self._id_02ED)) {
    var_1 = self._id_02ED.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  } else {
    var_1 = self.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  }

  var_1 = _func_000B(var_1);
  return var_1;
}

_id_6BA7() {
  var_0 = undefined;

  if(isDefined(self._id_0192)) {
    var_0 = self._id_0192.origin;
  } else {
    if(isDefined(self._id_02ED)) {
      var_1 = anglesToForward(self._id_02ED.angles);
    } else {
      var_1 = anglesToForward(self.angles);
    }

    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  if(isDefined(self._id_02ED)) {
    var_2 = self._id_02ED.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  } else {
    var_2 = self.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  }

  var_2 = _func_000B(var_2);
  return var_2;
}

_id_6E9E() {
  var_0 = undefined;

  if(isDefined(self._id_0192)) {
    var_0 = self._id_0192.origin;
  } else {
    var_1 = anglesToForward(self.angles);
    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  var_2 = self.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  var_2 = _func_000B(var_2);
  return var_2;
}

_id_6E9C(var_0) {
  var_1 = vectortoangles((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var_1[1];
}

_id_0E15() {
  var_0 = self.angles[1] - scripts\engine\utility::_id_6E9B(self._id_0192.origin);
  var_0 = _func_000B(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

_id_0E16() {
  var_0 = self.angles[1] - _id_6E9C(self._id_0192.origin);
  var_0 = _func_000B(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

_id_0E17(var_0) {
  var_1 = self.angles[1] - scripts\engine\utility::_id_6E9B(var_0);
  var_1 = _func_000B(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  return var_1;
}

_id_0E14(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = _func_000B(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  return var_1;
}

_id_6E9D(var_0, var_1) {
  var_2 = vectortoangles(var_0 - var_1);
  return var_2[1];
}

_id_6A7B() {
  return getweaponmodel(self._id_020A);
}

_id_69FC() {
  if(isDefined(self._id_0192)) {
    self._id_0DDF._id_8FCA = self._id_0192 _meth_8176();
    self._id_0DDF._id_8FCE = gettime();
    return self._id_0DDF._id_8FCA;
  } else if(isDefined(self._id_0DDF._id_8FCE) && isDefined(self._id_0DDF._id_8FCA) && self._id_0DDF._id_8FCE + 3000 < gettime())
    return self._id_0DDF._id_8FCA;
  else {
    var_0 = self _meth_8176();
    var_0 = var_0 + 196 * self._id_0282;
    return var_0;
  }
}

_id_6E08(var_0) {
  if(!isDefined(var_0)) {
    return (0, 0, 0);
  }

  if(!isDefined(var_0._id_CC9B)) {
    return var_0.angles;
  }

  var_1 = var_0.angles;
  var_2 = _func_000B(var_1[0] + var_0._id_CC9B[0]);
  var_3 = var_1[1];
  var_4 = _func_000B(var_1[2] + var_0._id_CC9B[2]);
  return (var_2, var_3, var_4);
}

_id_6E9F(var_0) {
  if(isDefined(self.type) && scripts\engine\utility::_id_8942(self)) {
    var_1 = _id_6E08(self);
    var_2 = anglesToForward(var_1);
    var_3 = _func_01C6(var_2, var_0 - self.origin, var_1[2] * -1);
    var_3 = var_3 + self.origin;
    var_4 = scripts\engine\utility::_id_6E9B(var_3) - var_1[1];
    var_4 = _func_000B(var_4);
    return var_4;
  }

  var_4 = scripts\engine\utility::_id_6E9B(var_0) - self.angles[1];
  var_4 = _func_000B(var_4);
  return var_4;
}

_id_31CF(var_0, var_1) {
  var_2 = var_1 _id_6E9F(var_0);

  if(var_2 > 60 || var_2 < -60) {
    return 0;
  }

  if(scripts\engine\utility::_id_8946(var_1) && var_2 < -14) {
    return 0;
  }

  if(scripts\engine\utility::_id_8948(var_1) && var_2 > 12) {
    return 0;
  }

  return 1;
}

_id_6BA2(var_0) {
  if(isDefined(var_0._id_A97D)) {
    return var_0._id_A97D;
  }

  var_1 = (-26, 0.4, 36);
  var_2 = (-32, 7, 63);
  var_3 = (43.5, 11, 36);
  var_4 = (36, 8.3, 63);
  var_5 = (3.5, -12.5, 45);
  var_6 = (-3.7, -22, 63);
  var_7 = (0, 30, 13);
  var_8 = 0;
  var_9 = (0, 0, 0);
  var_10 = anglestoaxis(var_0.angles);
  var_11 = var_10["right"];
  var_12 = var_10["forward"];
  var_13 = var_10["up"];
  var_14 = var_0.type;

  switch (var_14) {
    case "Cover Left":
      var_15 = var_0 _meth_813B();

      if(!isDefined(var_15) || var_15 == "crouch") {
        var_9 = _id_2EEF(var_11, var_12, var_13, var_1);
      } else {
        var_9 = _id_2EEF(var_11, var_12, var_13, var_2);
      }

      break;
    case "Cover Right":
      var_15 = var_0 _meth_813B();

      if(!isDefined(var_15) || var_15 == "crouch") {
        var_9 = _id_2EEF(var_11, var_12, var_13, var_3);
      } else {
        var_9 = _id_2EEF(var_11, var_12, var_13, var_4);
      }

      break;
    case "Turret":
    case "Conceal Stand":
    case "Cover Stand 3D":
    case "Cover Stand":
      var_9 = _id_2EEF(var_11, var_12, var_13, var_6);
      break;
    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      var_9 = _id_2EEF(var_11, var_12, var_13, var_5);
      break;
    case "Cover 3D":
      var_9 = _id_698C(var_0);
      break;
    case "Cover Prone":
      var_9 = _id_2EEF(var_11, var_12, var_13, var_7);
      break;
  }

  var_0._id_A97D = var_9;
  return var_0._id_A97D;
}

_id_698C(var_0, var_1) {
  var_2 = (2, -10, 35);
  var_3 = (-19, -10, 32);
  var_4 = (16, -10, 32);
  var_5 = anglestoright(var_0.angles);
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = var_2;

  if(isDefined(var_1)) {
    if(var_1 == "left") {
      var_8 = var_3;
    } else if(var_1 == "right") {
      var_8 = var_4;
    } else {}
  }

  return _id_2EEF(var_5, var_6, var_7, var_8);
}

_id_2EEF(var_0, var_1, var_2, var_3) {
  return var_0 * var_3[0] + var_1 * var_3[1] + var_2 * var_3[2];
}

_id_31D0(var_0, var_1) {
  if(scripts\engine\utility::_id_8946(var_1) || scripts\engine\utility::_id_8948(var_1)) {
    if(!_id_31CF(var_0, var_1)) {
      return 0;
    }
  }

  var_2 = _id_6BA2(var_1);
  var_3 = var_1.origin + var_2;

  if(!_id_3536(var_3, var_0, var_1)) {
    return 0;
  }

  if(!_func_0202(var_3, var_0, 0, self._id_0192)) {
    if(scripts\engine\utility::_id_8944(var_1)) {
      var_3 = (0, 0, 64) + var_1.origin;
      return _func_0202(var_3, var_0, 0, self._id_0192);
    }

    return 0;
  }

  return 1;
}

_id_B016(var_0, var_1) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");

  for(;;) {
    wait 0.05;
  }
}

_id_31CD() {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  var_0 = _id_69FC();

  if(!isDefined(self._id_02ED)) {
    var_1 = self _meth_8067(self._id_0192);
  } else if(scripts\engine\utility::_id_0F78() && scripts\engine\utility::_id_8942(self._id_02ED)) {
    var_1 = _id_31D0(var_0, self._id_02ED);

    if(!var_1) {
      var_0 = (self._id_0192.origin + var_0) / 2;
      var_1 = _id_31D0(var_0, self._id_02ED);
    }
  } else
    var_1 = _id_31D0(var_0, self._id_02ED);

  if(var_1) {
    _id_4DA4();
  } else {}

  return var_1;
}

_id_3536(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return 0;
  }

  var_3 = self._id_04BE - anim._id_1351;
  var_4 = self._id_0185 + anim._id_1351;
  var_5 = var_1 - var_0;

  if(scripts\engine\utility::_id_0F78()) {
    if(isDefined(var_2) && scripts\engine\utility::_id_8942(var_2)) {
      var_6 = var_2.angles;
    } else {
      var_6 = self.angles;
    }

    var_5 = _func_01C8(var_5, var_6);
  }

  var_7 = _func_000B(_func_0304(var_5));

  if(var_7 < var_3) {
    return 0;
  }

  if(var_7 > var_4) {
    if(isDefined(var_2) && !scripts\engine\utility::_id_8944(var_2)) {
      return 0;
    }

    if(var_7 > anim._id_3DD7 + var_4) {
      return 0;
    }
  }

  return 1;
}

_id_4DA4() {
  self._id_0DDF._id_DBC8 = 1;
}

_id_31EA() {
  if(!_id_75B9() || self._id_017B) {
    self._id_70E0 = undefined;
    return 0;
  }

  if(!isPlayer(self._id_0192)) {
    return _id_13E9();
  }

  if(!_id_3536(self getEye(), self._id_0270)) {
    return 0;
  }

  var_0 = self _meth_86A9();
  return _id_5AEF(var_0);
}

_id_FC80() {
  if(!isDefined(self._id_0DDF._id_DBC8)) {
    self._id_0DDF._id_DBC8 = 1;
  }

  if(self._id_0DDF._id_DBC8) {
    self._id_0DDF._id_7004 = gettime() + randomintrange(15000, 30000);
    self._id_0DDF._id_DBC8 = 0;
  }
}

_id_75B9() {
  if(self._id_01D5) {
    return 1;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(!isDefined(self._id_0270)) {
    return 0;
  }

  if(!istrue(self._id_4DA3)) {
    _id_FC80();

    if(gettime() > self._id_0DDF._id_7004) {
      return 0;
    }
  }

  if(!isDefined(self._id_70E0) && !_id_A405()) {
    return 0;
  }

  return 1;
}

_id_13E9() {
  if(!self _meth_8061() && !istrue(self._id_5ECE)) {
    return 0;
  }

  var_0 = undefined;

  if(isDefined(self._id_0192._id_011F)) {
    var_1 = _id_6BA2(self._id_0192._id_011F);
    var_0 = self._id_0192._id_011F.origin + var_1;
  } else
    var_0 = self._id_0192 _meth_8176();

  if(!self _meth_8068(var_0) && !istrue(self._id_5ECE)) {
    return 0;
  }

  self._id_70E0 = var_0;
  return 1;
}

_id_31C9(var_0) {
  if(isDefined(self._id_0DDF._id_10DC1) && _func_0376(self._id_0DDF._id_10DC1["right"])) {
    return 0;
  }

  if(!_func_0202(self _meth_8176(), var_0, 0, undefined)) {
    return 0;
  }

  var_1 = self _meth_86A9();
  return _func_0202(var_1, var_0, 0, undefined);
}

_id_A405() {
  if(isDefined(self._id_70E0) && !_id_31C9(self._id_70E0)) {
    return 1;
  }

  return !isDefined(self._id_8FCB) || distancesquared(self._id_8FCB, self._id_0270) > 256 || distancesquared(self._id_8FCC, self.origin) > 1024;
}

_id_5AEF(var_0) {
  var_1 = min(self._id_0192._id_02A1, 1024);

  if(isDefined(self._id_0192) && distancesquared(self.origin, self._id_0192.origin) > _func_0219(var_1 + 768.0)) {
    self._id_70E0 = undefined;
    return 0;
  }

  if(_id_A405()) {
    self._id_8FCC = self.origin;
    self._id_8FCB = self._id_0270;

    if(istrue(self._id_EBA6)) {
      self._id_70E0 = self._id_0270;
      return 1;
    }

    var_2 = _id_69FC();
    self._id_70E0 = self _meth_873B(var_0, var_2, self._id_EBA3);
    return isDefined(self._id_70E0);
  } else if(isDefined(self._id_70E0) && isDefined(self._id_0323) && distancesquared(self.origin, self._id_70E0) < 1024)
    self._id_70E0 = undefined;

  return isDefined(self._id_70E0);
}

_id_31EB() {
  if(self._id_017B) {
    return 0;
  }

  if(!_id_75B9()) {
    return 0;
  }

  if(!isPlayer(self._id_0192)) {
    return _id_13E9();
  }

  if(isDefined(self._id_02ED)) {
    if(scripts\engine\utility::_id_8946(self._id_02ED) || scripts\engine\utility::_id_8948(self._id_02ED)) {
      if(!_id_31CF(_id_69FC(), self._id_02ED)) {
        return 0;
      }
    }

    var_0 = _id_6BA2(self._id_02ED);
    var_1 = self._id_02ED.origin + var_0;
  } else
    var_1 = self _meth_86A9();

  if(!_id_3536(var_1, self._id_0270)) {
    return 0;
  }

  return _id_5AEF(var_1);
}

_id_31CC(var_0) {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(isDefined(var_0) && self _meth_8067(self._id_0192, var_0) || self _meth_8067(self._id_0192)) {
    if(!_id_3536(self getEye(), self._id_0192 _meth_8176())) {
      return 0;
    }

    _id_4DA4();
    return 1;
  }

  return 0;
}

_id_C0F9() {
  return isDefined(self._id_0192) && self _meth_82CE(self._id_0192, 5);
}

_id_8A82() {
  if(isDefined(self._id_5ECF)) {
    return self._id_5ECF;
  }

  if(self._id_041F <= self._id_EBC0) {
    return 0;
  }

  return self _meth_81E9();
}

_id_541C() {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(self._id_0192 scripts\engine\utility::_id_8862()) {
    return 1;
  }

  if(isPlayer(self._id_0192)) {
    if(isDefined(self._id_0192.health) && self._id_0192.health < self._id_0192.maxhealth) {
      return 1;
    }
  } else if(isai(self._id_0192) && self._id_0192 _id_8A82())
    return 1;

  if(isDefined(self._id_0192._id_89F8) && self._id_0192._id_89F8) {
    return 1;
  }

  return 0;
}

_id_DBCE() {
  if(!_id_31CC()) {
    return 0;
  }

  if(!self _meth_8069()) {
    return 0;
  }

  return 1;
}

_id_E029(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_10DF4 <= 0) {
      continue;
    }
    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      if(var_3._id_10DF4 < var_1[var_4]._id_10DF4) {
        for(var_5 = var_1.size; var_5 > var_4; var_5--) {
          var_1[var_5] = var_1[var_5 - 1];
        }

        break;
      }
    }

    var_1[var_4] = var_3;
  }

  return var_1;
}

_id_B3D2(var_0, var_1, var_2, var_3) {
  var_4 = gettime();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = 0.766;

  if(isDefined(var_3)) {
    var_5 = cos(var_3);
  }

  if(isDefined(var_1._id_B797) && var_1._id_B797 + var_2 >= var_4) {
    return var_1._id_B796;
  }

  var_1._id_B797 = var_4;

  if(!scripts\engine\utility::_id_10E76(var_0.origin, var_0.angles, var_1.origin, var_5)) {
    var_1._id_B796 = 0;
    return 0;
  }

  var_6 = var_0 getEye();
  var_7 = var_1.origin;

  if(_func_0202(var_6, var_7, 1, var_0, var_1)) {
    var_1._id_B796 = 1;
    return 1;
  }

  var_8 = var_1 _meth_86A9();

  if(_func_0202(var_6, var_8, 1, var_0, var_1)) {
    var_1._id_B796 = 1;
    return 1;
  }

  var_9 = (var_8 + var_7) * 0.5;

  if(_func_0202(var_6, var_9, 1, var_0, var_1)) {
    var_1._id_B796 = 1;
    return 1;
  }

  var_1._id_B796 = 0;
  return 0;
}