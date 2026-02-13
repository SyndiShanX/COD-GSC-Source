/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2289.gsc
*************************************************/

_id_D1B4(var_0) {
  if(isDefined(var_0)) {
    self _meth_8309(var_0);
  } else {
    self _meth_8309();
  }

  if(scripts\engine\utility::_id_0F78()) {
    self._id_04BE = -65;
    self._id_0185 = 65;
    self._id_0377 = -56;
    self._id_0275 = 56;
  }
}

_id_D13B() {
  _id_D1B4();

  if(self._id_0131 == "stand" && !scripts\engine\utility::_id_0F78()) {
    self._id_04BE = -45;
    self._id_0185 = 80;

    if(self._id_04B9 == "juggernaut") {
      self._id_04BE = -80;
    }
  } else if(self._id_0131 == "prone") {
    self._id_0377 = -45;
    self._id_0275 = 45;
  }

  self._id_04A9 = self._id_45CB;
  self._id_B143 = self._id_45BF;
}

_id_35CF(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = self._id_0B67._id_DA37 + "_" + var_3;

  if(isDefined(self._id_0B67._id_DA37) && _id_0009::_id_1C72(var_1, var_4)) {
    return _id_0009::_id_1C7D(var_1, var_4);
  }

  return _id_0009::_id_1C7D(var_1, var_2);
}

_id_35E3(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C73(var_3, var_2)) {
    var_4 = _id_0009::_id_1C62(var_3, var_2);

    if(_func_0107(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!_id_0009::_id_1C72(var_1, var_3)) {
    return _id_0009::_id_1C7D(var_1, "default");
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_35E4(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C73(var_3, var_2)) {
    var_4 = _id_0009::_id_1C62(var_3, var_2);

    if(_func_0107(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!_id_0009::_id_1C72(var_1, var_3)) {
    var_5 = [];
    var_5[0] = _id_0009::_id_1C7D(var_1, "trans_to_one_hand_run");
    var_5[1] = _id_0009::_id_1C7D(var_1, "one_hand_run");
    var_5[2] = _id_0009::_id_1C7D(var_1, "trans_to_two_hand_run");
    var_5[3] = _id_0009::_id_1C7D(var_1, "two_hand_run");
    return var_5;
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_35AD(var_0, var_1, var_2) {
  var_2 = "";

  if(isDefined(self._id_02ED) && self._id_02ED.type == "Cover Stand") {
    if(!self._id_02ED scripts\engine\utility::_id_8AE7("over")) {
      var_2 = var_2 + "_high";
    }
  }

  return _id_35C2(var_0, var_1, var_2);
}

_id_35C3(var_0, var_1, var_2) {
  if(weaponclass(self._id_04F6) == "rocketlauncher" && _id_0009::_id_1C72(var_1, "drop_rpg")) {
    return _id_0009::_id_1C7D(var_1, "drop_rpg");
  }

  var_3 = _id_06BD::_id_23C9();

  if(!_id_0009::_id_1C72(var_1, var_3)) {
    var_3 = "rifle";
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_8A58(var_0, var_1) {
  if(!_func_03A4(var_0, "fast") || !_func_03A4(var_0, "jog")) {
    return 0;
  }

  return var_1 < _func_03A8(var_0, "fast", "jog", 0.1);
}

_id_8A59(var_0, var_1) {
  return var_1 > _func_03A8(var_0, "run", "sprint", 0.1);
}

_id_8A56(var_0, var_1) {
  if(_func_03A4(var_0, "fast") && _func_03A4(var_0, "jog") && var_1 < _func_03A8(var_0, "fast", "jog", 0.9)) {
    return 0;
  }

  if(_func_03A4(var_0, "run") && _func_03A4(var_0, "sprint") && var_1 > _func_03A8(var_0, "run", "sprint", 0.1)) {
    return 0;
  }

  return 1;
}

_id_8A57(var_0, var_1) {
  if(_func_03A4(var_0, "fast") && _func_03A4(var_0, "jog") && var_1 < _func_03A8(var_0, "fast", "jog", 0.8)) {
    return 0;
  }

  if(_func_03A4(var_0, "run") && _func_03A4(var_0, "sprint") && var_1 > _func_03A8(var_0, "run", "sprint", 0.3)) {
    return 0;
  }

  return 1;
}

_id_A27B(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();
  return var_4 != "casual" && var_4 != "casual_gun";
}

_id_6B9E(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "Cover Left":
        if(var_1 == "crouch") {
          return "Cover Left Crouch";
        }

        break;
      case "Cover Right":
        if(var_1 == "crouch") {
          return "Cover Right Crouch";
        }

        break;
      case "Conceal Crouch":
      case "Cover Crouch Window":
        return "Cover Crouch";
      case "Conceal Stand":
        return "Cover Stand";
    }
  }

  return undefined;
}

_id_AD4B(var_0) {
  if(var_0.type == "Cover Crouch" && isDefined(self._id_0B67._id_012D)) {
    return self._id_0B67._id_012D;
  }

  return var_0.type;
}

_id_6BA3(var_0, var_1, var_2) {
  var_3 = self._id_0131;

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(_func_02E1(var_0) && !var_0 _meth_80B9(var_3)) {
    var_3 = var_0 _meth_813B();
  }

  var_4 = _id_6B9E(var_1, var_3);
  return var_4;
}

_id_6BA5(var_0, var_1, var_2) {
  var_3 = self._id_0131;

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(_func_02E1(var_1) && !var_1 _meth_80B9(var_3)) {
    var_3 = var_1 _meth_813B();
  }

  var_4 = _id_AD4B(var_1);
  var_5 = _id_6B9E(var_4, var_3);

  if(isDefined(var_5) && isDefined(var_0[var_5])) {
    return var_0[var_5];
  }

  if(isDefined(var_0[var_4])) {
    return var_0[var_4];
  }

  return undefined;
}

_id_15C0() {
  if(isDefined(self.allowlmgmounttime)) {
    if(gettime() < self.allowlmgmounttime) {
      return 0;
    } else {
      self._id_4AC3 = 0;
    }
  }

  if(istrue(self._id_4AC3)) {
    return 0;
  }

  var_0 = weaponclass(self._id_04F6) == "mg";

  if(var_0) {
    if(!isDefined(self._id_02ED) || self._id_02ED _meth_8678()) {
      return 1;
    }

    return 0;
  }

  if(isDefined(self._id_0B67._id_015C) && isDefined(self._id_02ED) && self._id_02ED == self._id_0B67._id_015C && self._id_02ED _meth_8678()) {
    return 1;
  }

  return 0;
}

_id_6BA6(var_0, var_1, var_2) {
  if(_func_02DE(var_0) || !isDefined(var_0.type)) {
    return 0;
  }

  if(istrue(self._id_0B67._id_82C7) || istrue(self._id_1C30._id_FF05)) {
    return 0;
  }

  var_3 = _id_AD4B(var_0);
  var_4 = self _meth_85E5(var_0, var_3, var_1, var_2);
  return var_4;
}

_id_6B9D(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_6BA6(var_0, var_1, var_2);
  return var_0.angles[1] + var_3;
}

_id_6B9C(var_0, var_1) {
  var_2 = _id_6BA6(var_0, var_1, 1);
  return _func_0047(var_0.angles, (0, var_2, 0));
}

_id_6BA1(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = var_0.type;
  }

  var_3 = _id_6BA3(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    return self _meth_85E9(var_3);
  } else {
    return self _meth_85E9(var_1);
  }
}

_id_6B98(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_2 == "exposed") {
    var_3 = anim._id_A56A[var_0];
  } else if(var_2 == "lean" || var_2 == "leanover") {
    var_3 = anim._id_A574[var_0];
  } else if(var_2 == "overlean") {
    var_3 = anim._id_A577[var_0];
  }

  if(isDefined(var_3)) {
    var_4 = _id_6BA5(var_3, var_1, undefined);

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return 0;
}

_id_6B99(var_0, var_1, var_2) {
  if(var_2 == "lean") {
    var_3 = _id_AD4B(var_1);
    return self _meth_85E8(var_1, var_3);
  }

  return 0;
}

_id_A571(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    return !_id_A570(var_0);
  }

  return 0;
}

_id_A570(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    if(isDefined(var_0._id_CE18) && var_0._id_CE18 == "exposed") {
      return 1;
    }
  }

  return 0;
}

_id_6BA4(var_0) {
  if(isDefined(var_0)) {
    if(_id_A570(var_0)) {
      return "Cover Exposed 3D";
    } else {
      return var_0.type;
    }
  }

  return "undefined";
}

_id_3633(var_0, var_1, var_2) {
  var_3 = undefined;

  if(abs(self._id_0150) > 150) {
    if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_3 = "legs";
    } else if(self._id_0148 == "torso_lower") {
      var_3 = "torso_lower";
    } else {
      var_3 = "default";
    }
  } else if(self._id_0150 < 0)
    var_3 = "right";
  else {
    var_3 = "left";
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_876A() {
  return isDefined(_id_06BD::_id_23BC());
}

_id_D8CE(var_0, var_1) {
  self endon(var_0 + "_finished");
  self._id_04C2 = 1;
  thread _id_D8CF(var_0);

  if(var_1 > 0) {
    wait(var_1);
  }

  self._id_04C2 = 0;
  self notify("StopUseAnimGoalWeight");
}

_id_D8CF(var_0) {
  self notify("StopUseAnimGoalWeight");
  self endon("StopUseAnimGoalWeight");
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0 + "_finished");
  self._id_04C2 = 0;
}

_id_DB7D(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23CE()) {
    return 0;
  }

  var_4 = var_3;

  if(var_4) {
    if(self._id_0DDF._id_A235 == "stop") {
      return 0;
    }

    if(!_id_06BD::_id_23E5()) {
      return 0;
    }
  } else if(_id_06BD::_id_23E5() && self._id_0DDF._id_A235 != "stop")
    return 0;

  return 1;
}

_id_CF6B(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(self._id_0DDF._id_3DEC == var_4) {
    self._id_0DDF._id_3DEC = undefined;
    return 1;
  }

  return 0;
}

_id_CF6C(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0DDF._id_3DEC);
}

_id_18CB(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0DDF._id_A235 = "run";
  self._id_0213 = "disable";
  var_3 = _id_0009::_id_1C7D(var_1, "blank");
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_C00D(var_0, var_1, var_2, var_3) {
  var_4 = anim._id_1C30[var_0]._id_E75E[var_2];

  if(isDefined(var_4._id_F49D)) {
    if(var_4._id_F49D.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var_5 = var_4._id_F49D[0];
        var_4._id_F49D[0] = var_4._id_F49D[1];
        var_4._id_F49D[1] = var_5;
      }
    } else
      var_4._id_F49D = scripts\engine\utility::array_randomize(var_4._id_F49D);
  }

  return 1;
}

_id_A57B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.angles)) {
    return 1;
  }

  if(_func_02DE(var_0)) {
    return 0;
  }

  return isDefined(var_0.type) && var_0.type != "Path" && !scripts\engine\utility::_id_8949(var_0);
}

_id_35E0(var_0, var_1) {
  return int(var_1.origin[0] + var_1.origin[1] + var_1.origin[2] + var_0 getentitynumber()) % 2;
}

_id_35E1(var_0, var_1) {
  return int(abs(var_1[0] + var_1[1] + var_1[2] + var_0 getentitynumber())) % 2;
}

_id_68D8() {
  if(istrue(self._id_0272)) {
    return undefined;
  }

  if(isDefined(self._id_03B1) && !self _meth_84C1()) {
    return self._id_03B1;
  }

  if(isDefined(self._id_02ED)) {
    return self._id_02ED;
  }

  if(isDefined(self._id_0347) && isDefined(self._id_0323) && distance2dsquared(self._id_0347.origin, self._id_0323) < 36) {
    return self._id_0347;
  }

  if(isDefined(self._id_8F58)) {
    return self._id_8F58;
  }

  return self._id_8F57;
}

_id_8765(var_0, var_1) {
  if(isDefined(self._id_1C30._id_426A._id_1C10)) {
    return var_1 == "Custom";
  }

  if(_id_06BD::_id_2413()) {
    return var_1 == "Exposed";
  }

  var_2 = _id_68D8();

  if(isDefined(var_2) && _func_02E1(var_2) && var_2 _meth_80BB()) {
    var_3 = scripts\engine\utility::_id_690C(var_2);

    if(isDefined(var_3)) {
      var_2 _meth_80BA(var_3);
    }
  }

  if(!isDefined(var_2) || !isDefined(var_2.type) || var_2.type == "struct" || self._id_010D == "no_cover") {
    return var_1 == "Exposed";
  }

  if(isDefined(var_2) && var_2.type == "Cover Crouch") {
    var_4 = getDvar("#x3657f39fbcd013f07");

    if(var_4 != "") {
      return var_1 == var_4;
    }

    if(isDefined(self._id_0B67._id_012D)) {
      return var_1 == self._id_0B67._id_012D;
    } else if(isDefined(var_2._id_3DD8)) {
      return var_1 == var_2._id_3DD8;
    }
  }

  var_5 = _id_0009::_id_1C61();
  var_6 = (!_func_02E1(var_2) || var_2 _meth_80B9("stand")) && self _meth_81E8("stand");
  var_7 = (!_func_02E1(var_2) || var_2 _meth_80B9("crouch")) && self _meth_81E8("crouch") && var_5 != "casual" && var_5 != "casual_gun";

  switch (var_1) {
    case "Exposed":
      if(var_2.type != "Path" && var_2.type != "Exposed") {
        return 0;
      }

      if(var_7 && _id_35E0(self, var_2)) {
        return 0;
      }

      return var_6;
    case "Exposed Crouch":
      if(var_2.type != "Path" && var_2.type != "Exposed") {
        return 0;
      }

      if(var_6 && !_id_35E0(self, var_2)) {
        return 0;
      }

      return var_7;
    case "Cover Crouch":
      return var_2.type == "Cover Crouch" || var_2.type == "Conceal Crouch" || var_2.type == "Cover Crouch Window" || var_2.type == "Cover Stand" || var_2.type == "Conceal Stand" || var_2.type == "Cover Prone" || var_2.type == "Conceal Prone";
    case "Cover Left":
      return var_2.type == "Cover Left";
    case "Cover Right":
      return var_2.type == "Cover Right";
    case "Exposed Moving":
      return var_2.type == "Exposed Moving";
  }

  return var_1 == var_2.type;
}

_id_8764(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(isDefined(self._id_1C30._id_426A._id_1C10)) {
    return var_4 == "Custom";
  }

  if(_id_06BD::_id_2413()) {
    return var_4 == "Exposed";
  }

  var_5 = _id_68D8();

  if(isDefined(var_5) && _func_02E1(var_5) && var_5 _meth_80BB()) {
    var_6 = scripts\engine\utility::_id_690C(var_5);

    if(isDefined(var_6) && var_5.type != var_6 && var_4 == var_6) {
      var_5 _meth_80BA(var_6);
    }
  }

  if(!isDefined(var_5) || !isDefined(var_5.type) || var_5.type == "struct" || self._id_010D == "no_cover") {
    if(scripts\engine\utility::_id_0F78()) {
      return var_4 == "Exposed 3D";
    } else {
      return var_4 == "Exposed";
    }
  }

  var_7 = _id_15C0();

  if(isDefined(var_5) && var_5.type == "Cover Crouch" && !var_7) {
    var_8 = getDvar("#x3657f39fbcd013f07");

    if(var_8 != "") {
      return var_4 == var_8;
    }

    if(isDefined(self._id_0B67._id_012D)) {
      return var_4 == self._id_0B67._id_012D;
    } else if(isDefined(var_5._id_3DD8)) {
      return var_4 == var_5._id_3DD8;
    }
  }

  var_9 = _id_0009::_id_1C61();
  var_10 = (!_func_02E1(var_5) || var_5 _meth_80B9("stand")) && self _meth_81E8("stand");
  var_11 = (!_func_02E1(var_5) || var_5 _meth_80B9("crouch")) && self _meth_81E8("crouch") && var_9 != "casual" && var_9 != "casual_gun";

  if(var_0 == "zero_gravity_space") {
    switch (var_4) {
      case "Exposed 3D":
        return scripts\engine\utility::_id_8949(var_5) && var_10;
      case "Cover 3D":
        return var_5.type == "Cover 3D";
      case "Cover Stand 3D":
        return _id_A571(var_5);
      case "Cover Exposed 3D":
        return _id_A570(var_5);
      case "Path":
      case "Exposed":
      case "Exposed Crouch":
      case "Cover Prone":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
      case "Cover Crouch":
        break;
    }
  } else if(var_0 == "zero_gravity") {
    switch (var_4) {
      case "Exposed":
        return (var_5.type == "Path" || var_5.type == "Exposed") && var_10;
      case "Exposed Crouch":
        return (var_5.type == "Path" || var_5.type == "Exposed") && var_11;
      case "Cover Crouch":
        return var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch";
      case "Cover Stand":
        return var_5.type == "Cover Stand" || var_5.type == "Conceal Stand";
      case "Cover Prone":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
        break;
    }
  } else {
    switch (var_4) {
      case "Exposed":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_11 && _id_35E0(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Exposed Crouch":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_10 && !_id_35E0(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Crouch":
        return var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch" || var_5.type == "Cover Crouch Window";
      case "Cover Stand":
        return var_5.type == "Cover Stand" || var_5.type == "Conceal Stand";
      case "Cover Prone":
        return var_5.type == "Cover Prone" || var_5.type == "Conceal Prone";
      case "Cover Left":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_11 && _id_35E0(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Cover Left Crouch":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_10 && !_id_35E0(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Right":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_11 && _id_35E0(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Cover Right Crouch":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_10 && !_id_35E0(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Crouch LMG":
        return (var_5.type == "Cover Crouch" || var_5.type == "Cover Prone") && _id_15C0();
      case "Cover Stand LMG":
        return var_5.type == "Cover Stand" && _id_15C0();
      case "Exposed Moving":
        return var_5.type == "Exposed Moving";
    }
  }

  return var_4 == var_5.type;
}

_id_B899(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_107FD(var_0, var_1);
  thread _id_10826(var_0, var_1);
  thread _id_10800(var_0, var_1, 0);
  var_3 = 1.0;
  _id_0009::_id_1CB4();
  _id_0009::_id_1C81(var_0, var_1, var_3, 1);
  _id_0009::_id_1CB4();
}

_id_B89C(var_0, var_1, var_2) {
  _id_B899(var_0, var_1, var_2);
}

_id_B35B(var_0, var_1, var_2) {
  thread _id_10800(var_0, var_1, 1);
  _id_B31C(var_0, var_1, var_2);
}

_id_107FD(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    self._id_036E = 1;
    self waittill("cover_approach", var_2);
    _id_0009::_id_1C53(var_0, "cover_approach", var_2);
    self._id_0DDF._id_19FC = var_2;
  }
}

_id_10826(var_0, var_1) {
  self endon(var_1 + "_finished");
  self waittill("path_changed", var_2, var_3, var_4, var_5, var_6);
  var_7 = [var_2, var_3, var_4, var_5, var_6];
  _id_0009::_id_1C53(var_0, "sharp_turn", var_7);
  thread _id_10826(var_0, var_1);
}

_id_B89D(var_0, var_1, var_2) {}

setdoortoopen(var_0) {
  self notify("stop_door_deletion_watch");
  self._id_0B67.doortoopen = var_0;
  self._id_0B67._id_7557 = isDefined(var_0);

  if(isDefined(var_0) && !_func_02DE(var_0)) {
    thread ondoordeletioncleanup(var_0);
  }
}

ondoordeletioncleanup(var_0) {
  self endon("entitydeleted");
  self endon("death");
  self endon("stop_door_deletion_watch");
  var_0 waittill("entitydeleted");
  setdoortoopen(undefined);
}

_id_2EB6() {
  if(scripts\common\utility::iscp()) {
    return 0.8;
  }

  var_0 = 0.75;
  var_1 = length(self._id_04DF);

  if(var_1 > 0) {
    var_0 = 24 / var_1;
  }

  if(var_0 < 0.15) {
    var_0 = 0.15;
  } else if(var_0 > 1) {
    var_0 = 1;
  }

  return var_0;
}

_id_AC29() {
  var_0 = self._id_0B67.doortoopen;
  var_1 = self._id_5D79;

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  self._id_0B67._id_4E03 = 1;
  self endon("death");
  var_0 endon("death");
  self endon("path_has_door");
  var_2 = self[[self._id_5D89]](var_0);
  var_3 = distance2dsquared(var_2, self.origin);
  var_4 = 4096;

  if(scripts\common\utility::iscp()) {
    var_5 = 0.8 * length(self._id_04DF);
    var_5 = var_5 * 0.9;
    var_4 = max(var_5 * var_5, var_4);
  }

  while(var_3 > var_4) {
    if(isDefined(self._id_0B67.doortoopen) && var_0 != self._id_0B67.doortoopen) {
      return;
    }
    var_3 = distance2dsquared(var_2, self.origin);
    waitframe();
  }

  var_6 = _id_2EB6();
  self notify("opening_door");
  self thread[[var_1]](var_0, var_6);
  return var_6;
}

_id_AC2A(var_0) {
  self endon("opening_door_done");
  self waittill(var_0 + "_finished");

  if(!isalive(self)) {
    return;
  }
  setdoortoopen(undefined);
  self._id_8968 = undefined;
  self notify("opening_door_done");
}

_id_39D9(var_0) {
  if(self[[self._id_5D78]](var_0)) {
    self[[self._id_5D76]](var_0);
  }
}

_id_10800(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  waitframe();

  for(;;) {
    if(isDefined(self._id_0B67.doortoopen)) {
      var_3 = 0;

      if(self[[self._id_5D75]](self._id_0B67.doortoopen)) {
        var_3 = 1;
      }

      if(!var_3 && !isent(self._id_0B67.doortoopen)) {
        if(istrue(self._id_0B67.doortoopen.runtime_scriptable)) {
          var_4 = 250;
        } else {
          var_4 = 200;
        }

        if(!isDefined(self _meth_857B("door", var_4))) {
          var_3 = 1;
        }
      }

      if(var_3) {
        setdoortoopen(undefined);
        waitframe();
        continue;
      }

      if(!self._id_01B7) {
        var_5 = self._id_027F;
        var_5 = vectornormalize((var_5[0], var_5[1], 0));
        var_6 = anglesToForward(self.angles);

        if(vectordot(var_5, var_6) < 0.966) {
          self._id_8968 = 1;
          var_7 = _id_AC29();

          if(isDefined(var_7)) {
            thread _id_AC2A(var_1);
            wait(var_7);
          }

          self notify("opening_door_done");
          setdoortoopen(undefined);
          self._id_8968 = undefined;
          continue;
        }
      }

      var_8 = self._id_0B67.doortoopen;
      self._id_0B67._id_4E03 = undefined;
      var_9 = 1;
      var_10 = 160;
      var_11 = 2;
      var_12 = _func_0133(self._id_04DF);

      if(!istrue(var_2)) {
        var_13 = var_1;
        var_14 = _id_0009::_id_1C7E(var_1, "2");

        if(!isDefined(var_14)) {
          var_12 = self _meth_864B();
          var_15 = _func_03A6(self._id_0088, var_12);

          if(isDefined(var_15)) {
            var_16 = var_15 + "2";
            var_14 = _id_0009::_id_1C7E(var_1, var_16);

            if(!isDefined(var_14)) {
              var_13 = "door_open";
              var_14 = _id_0009::_id_1C7E("door_open", var_16);
            }
          }
        }

        if(!isDefined(var_14)) {
          var_14 = _id_0009::_id_1C7E("door_open", "2");
        }

        if(isDefined(var_14)) {
          var_17 = _id_0009::_id_1C6E(var_13, var_14);
          var_18 = _func_00BB(var_17, "door_touch");
          var_19 = (var_18[0] * _func_0079(var_17) + 2 * level._id_5F3A) * var_12;
          var_10 = var_19 + 24;
        }
      }

      var_20 = var_9 + var_10 + var_11;
      var_21 = self[[self._id_5D89]](var_8);
      var_22 = distance2d(var_21, self.origin);

      if(var_22 < var_20) {
        self._id_8968 = 1;
        thread _id_39D9(var_8);
        var_23 = self._id_04B9 == "dog";

        if(var_23 || istrue(var_2) || var_22 < var_20 - var_12 * 2 * level._id_5F3A) {
          var_7 = _id_AC29();

          if(isDefined(var_7)) {
            thread _id_AC2A(var_1);
            wait(var_7);
          }

          self notify("opening_door_done");
          setdoortoopen(undefined);
          self._id_8968 = undefined;
        } else {
          self _meth_86E6(var_8, var_20, _id_69F1());
          thread _id_7438(var_0, var_1);
          thread _id_7439(var_0, var_1);
          self waittill("opening_door_done");
        }
      }
    }

    waitframe();
  }
}

_id_7438(var_0, var_1) {
  self endon(var_1 + "_finished");
  self endon("opening_door_done");

  for(;;) {
    self waittill("door_open", var_2);

    if(!_func_0107(var_2)) {
      var_2 = [var_2];
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] == "door_open") {
        if(isDefined(self._id_5D79) && isDefined(self._id_0B67.doortoopen)) {
          self notify("opening_door");
          var_4 = _id_2EB6();
          self thread[[self._id_5D79]](self._id_0B67.doortoopen, var_4);
          self._id_0B67._id_4E03 = 1;
        } else {}

        continue;
      }

      if(var_2[var_3] == "end") {
        setdoortoopen(undefined);
        self._id_8968 = undefined;
        self _meth_86E7();
        self notify("opening_door_done");
      }
    }

    waitframe();
  }
}

_id_7439(var_0, var_1) {
  self endon("opening_door_done");
  self waittill(var_1 + "_finished");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!istrue(self._id_0B67._id_4E03)) {
    thread _id_AC29();
  }

  setdoortoopen(undefined);
  self._id_8968 = undefined;
  self _meth_86E7();
}

_id_DC0C(var_0) {
  if(_func_0011(var_0, "warp_up_start")) {
    return 1;
  }

  if(_func_0011(var_0, "warp_across_start")) {
    return 1;
  }

  if(_func_0011(var_0, "warp_down_start")) {
    return 1;
  }

  return 0;
}

_id_74A7(var_0) {
  if(var_0 == "traverse_death") {
    return _id_74A3();
  } else if(var_0 == "warp_arrival_start") {
    return _id_74AD();
  } else if(var_0 == "warp_up_start") {
    return _id_74B1();
  } else if(var_0 == "warp_up_end") {
    return handlewarpupendnotetrack();
  } else if(var_0 == "warp_up_apex") {
    return handlewarpupapexnotetrack();
  } else if(var_0 == "warp_across_start") {
    return _id_74AC();
  } else if(var_0 == "warp_down_start") {
    return _id_74AF();
  } else if(var_0 == "warp_down_end") {
    return _id_74AE();
  } else if(var_0 == "early_end") {
    return handlewarpearlyendnotetrack();
  }
}

_id_74A5(var_0) {
  if(var_0 == "traverse_death") {
    return _id_74A3();
  } else if(var_0 == "traverse_align") {
    return _id_74A1();
  } else if(var_0 == "traverse_drop") {
    return _id_74A4();
  }
}

_id_74A1() {
  self _meth_8019("noclip");

  if(isDefined(self._id_F4EA) && isDefined(self._id_F4F1._id_F4DA)) {
    var_0 = self._id_F4F1._id_F4DA - self._id_F4F3;
    thread _id_F040(var_0 - self._id_F4EA);
  }
}

_id_F040(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self _meth_80F9(self.origin + var_2);
    waitframe();
  }
}

_id_74A4() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = _func_0198(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self _meth_85F7(self._id_F4F6);
  var_5 = _func_00B0(self._id_F4F6, var_4, 1.0);
  var_6 = _func_0079(self._id_F4F6);
  var_7 = var_4 * var_6;
  var_8 = 0 - var_5[2];
  var_9 = var_8 - var_3;

  if(var_8 < var_3) {
    var_10 = var_8 / var_3;
  } else {
    var_10 = 1;
  }

  var_11 = (var_6 - var_4) / 3.0;
  var_12 = (var_6 - var_7) / 3.0;
  var_13 = _func_0037(var_12 * 20);
  thread _id_F041(var_9, 0, var_13, var_10);
  thread _id_5B20(var_1[2]);
}

_id_5B20(var_0) {
  self endon("killanimscript");
  self endon("death");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self _meth_8019("gravity");
      break;
    }

    waitframe();
  }
}

_id_F041(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0) {
    wait(var_1);
  }

  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0) {
    self _meth_85F5(self._id_F4F6, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self _meth_80F9(self.origin + var_4);
    waitframe();
  }

  if(isDefined(var_3) && var_3 < 1.0) {
    self _meth_85F5(self._id_F4F6, 1.0);
  }
}

_id_74A3() {
  if(isDefined(self._id_F4E5)) {
    var_0 = self._id_F4E5[self._id_F4E6];
    self._id_43D3 = var_0[randomint(var_0.size)];
    self._id_F4E6++;
  }
}

_id_74AD() {
  if(isai(self)) {
    self _meth_8019("noclip");
  }

  var_0 = _id_6890(self._id_F4F1);
  var_1 = self._id_F4F1.angles;
  scripts\engine\utility::_id_A1BC(self._id_F4F6, var_0, var_1, "warp_arrival_start", "warp_arrival_end");
}

_id_74B1() {
  if(isai(self)) {
    self _meth_8019("noclip");
  }

  var_0 = self._id_F4F1.origin + self._id_F4F1._id_19AE;
  var_1 = self._id_F4F1.angles;

  if(_func_0011(self._id_F4F6, "warp_up_apex")) {
    var_2 = _func_00BB(self._id_F4F6, "warp_up_start")[0];
    var_3 = _func_00BB(self._id_F4F6, "warp_up_end")[0];
    var_4 = _func_0079(self._id_F4F6);
    var_5 = int((var_3 - var_2) * var_4 * 1000);
    scripts\engine\utility::_id_A1BC(self._id_F4F6, var_0, var_1, "warp_up_start", "warp_up_apex", var_5);
  } else
    scripts\engine\utility::_id_A1BC(self._id_F4F6, var_0, var_1, "warp_up_start", "warp_up_end");
}

resetanimrate() {
  if(isai(self)) {
    self _meth_85F5(self._id_F4F6, 1);
  } else {
    self _meth_82E8(self._id_F4F6, 1);
  }
}

handlewarpupendnotetrack() {
  if(_func_0011(self._id_F4F6, "warp_up_apex") || _func_0011(self._id_F4F6, "warp_down_start")) {
    return;
  }
  resetanimrate();
}

handlewarpupapexnotetrack() {
  if(_func_0011(self._id_F4F6, "warp_down_start")) {
    return;
  }
  resetanimrate();
}

_id_74AC() {
  if(isai(self)) {
    self _meth_8019("noclip");
  }

  var_0 = self._id_F4E7;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.angles = self._id_F4F1.angles;
  }

  var_1 = _id_688F(var_0);
  var_2 = self._id_F4F1.origin + self._id_F4F1._id_19AE + self._id_F4F1._id_0E83 + var_1;
  var_3 = var_0.angles;
  scripts\engine\utility::_id_A1BC(self._id_F4F6, var_2, var_3, "warp_across_start", "warp_across_end");
}

_id_74AF() {
  if(isai(self)) {
    self _meth_8019("noclip");
  }

  var_0 = self._id_F4E7;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.angles = self._id_F4F1.angles;
    var_0.origin = self _meth_8160();
  }

  var_1 = _func_00BB(self._id_F4F6, "warp_down_start")[0];
  var_2 = _func_00BB(self._id_F4F6, "warp_down_end")[0];
  var_3 = _func_00B0(self._id_F4F6, var_1, var_2);
  var_3 = rotatevector(var_3, var_0.angles);
  var_4 = 512;
  var_5 = _id_688F(var_0);
  var_6 = (self.origin[0] + var_3[0] + var_5[0], self.origin[1] + var_3[1] + var_5[1], self.origin[2]);
  var_7 = getgroundposition(var_6, 10, var_4, 12);
  var_9 = 0.05;
  var_10 = 30;
  var_11 = abs(var_7[2] - self.origin[2]);

  if(var_11 < var_9 * abs(var_3[2]) || var_11 > var_10) {
    var_7 = var_0.origin + var_5;
  }

  if(isai(self)) {
    var_12 = self _meth_8602();
  } else {
    var_12 = undefined;
  }

  var_13 = var_0.angles;

  if(!isDefined(var_0.origin)) {
    var_0.origin = self._id_F4F1._id_52B1;
  }

  if(isDefined(var_12)) {
    var_14 = _func_0261(var_12 - var_0.origin);
    var_15 = clamp(_func_000B(var_14 - self.angles[1]), -30.0, 30.0);
    var_14 = _func_000B(self.angles[1] + var_15);
    var_13 = (0, var_14, 0);
  }

  scripts\engine\utility::_id_A1BC(self._id_F4F6, var_7, var_13, "warp_down_start", "warp_down_end");
}

_id_74AE() {
  if(!isagent(self)) {
    self _meth_82E8(self._id_F4F6, 1);
  }

  if(isai(self)) {
    self _meth_8019("gravity");
  }
}

handlewarpearlyendnotetrack() {
  var_0 = 900;

  if(isDefined(self._id_0323) && distancesquared(self._id_0323, self.origin) < var_0) {
    _id_0009::_id_1C53(self._id_1CB8, "code_move");
    _id_0009::_id_1C53(self._id_1CB8, "finish");
    return "code_move";
  }
}

_id_69F1() {
  if(self._id_1C30._id_1A35 == "civilian_panic") {
    return "civilian_panic";
  } else if(self._id_04B9 == "civilian") {
    return "civilian";
  } else if(self._id_1C30._id_1A35 == "juggernaut") {
    return "juggernaut";
  } else {
    return "soldier";
  }
}

_id_B31C(var_0, var_1, var_2) {
  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_B35C(var_0, var_1, var_2) {
  self playSound(var_2);
  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_982D(var_0, var_1, var_2) {
  _id_0009::_id_1C81(var_0, var_1, 1.0);
}

_id_35C8(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C73(var_3, "idle")) {
    var_4 = _id_0009::_id_1C62(var_3, "idle");

    if(_func_0107(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(isDefined(self._id_02ED) && self._id_02ED.type == "Cover Stand") {
    if(!self._id_02ED scripts\engine\utility::_id_8AE7("over")) {
      var_2 = var_2 + "_high";
    }
  }

  return _id_35C2(var_0, var_1, var_2);
}

_id_35C2(var_0, var_1, var_2) {
  var_3 = weaponclass(self._id_04F6);
  var_4 = undefined;

  if(!isDefined(var_2)) {
    return _id_0009::_id_1C6C(var_0, var_1);
  } else {
    var_4 = var_2;
  }

  if(!_id_0009::_id_1C72(var_1, var_3 + var_4)) {
    var_3 = "rifle";
  }

  return _id_0009::_id_1C7D(var_1, var_3 + var_4);
}

_id_DBF3(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23E5() && !self._id_01B7 && self._id_0047;
}

_id_DAF4(var_0, var_1, var_2, var_3) {
  if(!_id_DBF3(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  if(!_id_06BD::_id_23E6("combat")) {
    return 1;
  }

  if(_id_06BD::_id_23E0()) {
    return 1;
  }

  return 0;
}

_id_35CE(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C61();

  if(!_id_0009::_id_1C72(var_1, var_3)) {
    return _id_0009::_id_1C38(var_0, var_1, var_2);
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_F48C(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::_id_8862();
}

_id_F48B(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0B67._id_8796) && !istrue(self._id_014C);
}

_id_87EF(var_0, var_1, var_2, var_3) {
  var_4 = self._id_014E;

  if(isDefined(self._id_ADE7)) {
    var_4 = self._id_ADE7;
  }

  if(scripts\common\utility::_id_87EC(makeweapon("iw7_sonic")) && self.damagemod != "MOD_MELEE" && var_4 >= 75) {
    return 1;
  }

  return 0;
}

_id_8A55(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_DBC0(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_949A) && self._id_949A >= gettime() - 1000) {
    var_4 = self _meth_87CE();

    if(_id_8A58(var_4, self _meth_8644())) {
      return 1;
    }
  }

  return 0;
}

_id_3603(var_0, var_1, var_2) {
  var_3 = "center";

  if(!isDefined(self._id_9499)) {
    return _id_0009::_id_1C7D(var_1, var_3);
  }

  if(isDefined(self._id_011F)) {
    var_4 = anglestoright(self._id_011F.angles);
    var_5 = anglesToForward(self._id_011F.angles);
    var_6 = vectornormalize(self._id_9499 - self.origin);
  } else {
    var_4 = anglestoright(self.angles);
    var_5 = anglesToForward(self.angles);
    var_6 = vectornormalize(self._id_9499 - self.origin);
  }

  var_7 = vectordot(var_4, var_6) >= 0;
  var_8 = vectordot(var_5, var_6);

  if(var_8 >= 0.866) {
    var_3 = "center";
  } else if(var_7) {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_8A2C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    return 0;
  }

  if(scripts\common\utility::_id_87EC(makeweapon("emp"))) {
    return 1;
  }

  if(self._id_04B9 == "c6" || self._id_04B9 == "c8") {
    if(scripts\common\utility::_id_87EC(makeweapon("iw7_sonic")) && scripts\common\utility::_id_8B04(self.damageweapon)) {
      return 1;
    }
  }

  if(scripts\common\utility::_id_87EC(makeweapon("iw7_atomizer")) && self.damagemod != "MOD_MELEE" && self.health <= 0) {
    return 1;
  }

  return 0;
}

_id_69BE() {
  var_0 = -1 * self._id_0147;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 > 0.707) {
    return "front";
  } else if(var_2 < -0.707) {
    return "back";
  } else {
    var_3 = _func_025B(var_1, var_0);

    if(var_3[2] > 0) {
      return "left";
    } else {
      return "right";
    }
  }
}

_id_6AAB() {
  var_0 = -1 * self._id_0147;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.5) {
    return 1;
  }

  return 0;
}

_id_B34F(var_0, var_1, var_2) {
  childthread _id_D8CE(var_1, 0.2);
  _id_0009::_id_1C87(var_0, var_1);
}

_id_18CD(var_0, var_1, var_2) {
  self _meth_8251("face angle 3d", self.angles);
  self._id_0213 = undefined;

  if(isDefined(self._id_97EB)) {
    var_3 = _id_0009::_id_1C67();

    if(isDefined(var_3)) {
      self _meth_8077(var_3, 0.2, self._id_97EB);
      self._id_97EB = undefined;
    }
  }
}

_id_18E4(var_0, var_1, var_2) {
  if(isDefined(self._id_97EB)) {
    var_3 = _id_0009::_id_1C67();

    if(isDefined(var_3)) {
      self _meth_8077(var_3, 0.2, self._id_97EB);
      self._id_97EB = undefined;
    }
  }
}

_id_3870() {
  self._id_7B24 = undefined;
  scripts\common\utility::_id_97EE();
}

_id_18CF(var_0, var_1, var_2) {
  self._id_7B24 = undefined;
  self stoplookat();
}

_id_18CE(var_0, var_1, var_2) {
  _id_3870();
}

_id_18CC(var_0, var_1, var_2) {
  _id_3870();
}

_id_4A99(var_0) {
  if(!isDefined(self._id_75FC)) {
    self._id_75FC = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "head"));
  }

  if(!isDefined(var_0) || var_0) {
    _id_D556("animscripted");

    if(isai(self)) {
      self _meth_86D8("none");
    } else {
      _id_D555("none");
    }
  } else
    _id_393F("animscripted");
}

_id_D555(var_0) {
  var_1 = [];
  var_1["none"] = 0;
  var_1["idle"] = 1;
  var_1["aim"] = 2;
  var_1["run"] = 3;
  var_1["pain"] = 4;
  var_1["death"] = 5;
  var_1["talk"] = 6;
  var_1["happy"] = 7;
  var_1["cheer"] = 8;
  var_1["scared"] = 9;
  var_1["angry"] = 10;
  var_1["gas_death"] = 11;
  self _meth_82EA("animtime", self getentitynumber());
  self _meth_86D9("facialindex", var_1[var_0]);
  var_2 = _id_0009::_id_1C7D("knobs", "head");

  if(var_0 == "none") {
    self _meth_8077(_id_0009::_id_1C6E("knobs", var_2), 0.2);
  } else {
    self _meth_82D9(_id_0009::_id_1C6E("knobs", var_2), 1, 0.2, 1);
  }
}

_id_D556(var_0) {
  self._id_5891 = var_0;
}

_id_393F(var_0) {
  self._id_5891 = "asm";

  if(!isDefined(self._id_5915) || !self._id_5915) {
    _id_0009::_id_1C9A();
  }
}

_id_8848(var_0) {
  if(!isai(self) && (!isDefined(self._id_5915) || !self._id_5915)) {
    return 0;
  }

  if(!isDefined(self._id_5891)) {
    self._id_5891 = "asm";
  }

  var_1 = [];
  var_1["asm"] = 0;
  var_1["filler"] = 1;
  var_1["animscripted"] = 2;

  if(var_1[var_0] >= var_1[self._id_5891]) {
    return 1;
  }

  return 0;
}

_id_4555() {
  if(self._id_00CC) {
    self._id_00CC--;
  }
}

_id_716B() {
  return randomfloatrange(5, 8);
}

_id_DA58() {
  if(scripts\anim\utility_common::_id_10D12()) {
    return 1.0;
  }

  if(scripts\anim\weaponlist::_id_FF06()) {
    return scripts\anim\weaponlist::_id_1F7E() * 0.7;
  }

  return 0.4;
}

_id_6D38() {
  if(isPlayer(self._id_0192)) {
    return randomfloatrange(self._id_0192._id_7235._id_9EA6, self._id_0192._id_7235._id_9C34);
  } else {
    return randomfloatrange(anim._id_9EA6, anim._id_9C34);
  }
}

_id_9D3F(var_0, var_1) {
  if(isDefined(self._id_9D8F) && self._id_9D8F) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    if(!isDefined(anim._id_9D77)) {
      return 1;
    }

    if(!isDefined(anim._id_9D77[var_0])) {
      return 1;
    }

    return gettime() > anim._id_9D77[var_0];
  } else {
    if(!isDefined(anim._id_9D78)) {
      return 1;
    }

    if(!isDefined(anim._id_9D78[var_0])) {
      return 1;
    }

    return gettime() > anim._id_9D78[var_0];
  }
}

_id_D818() {
  self._id_029F = 180;
}

_id_D8B2() {
  self._id_0DDF = spawnStruct();
  self._id_026D = 0;
  self._id_034C = self._id_04F6;
  self._id_0131 = "stand";
  self._id_0DDF._id_A235 = "stop";
  self._id_0DDF._id_E3B7 = "none";
  self._id_0DDF._id_72AF = "none";
  self._id_0188 = 1;
  self._id_9EFA = 750;
  self._id_0DDF._id_A411 = 0;
  self._id_0DDF._id_3AAE = gettime();
  self._id_0DDF._id_8FCE = gettime();
  self._id_0DDF._id_EBAF = 0;
  self._id_0DDF._id_4AC4 = !self _meth_81BA();
  self._id_0DDF._id_ADFA = 0;
  self._id_0DDF._id_9041 = 0;
  self._id_0DDF._id_8FE0 = 0;
  self._id_0DDF._id_A4A4 = 0;
  self._id_0DDF._id_C09A = 0.8;
  self._id_0B37 = 0;
  self._id_0C47 = 0;
  self._id_0087 = 1;
  self._id_0DDF._id_A567 = 0;
  self._id_02B6 = 0;
  self._id_02B7 = 0;
  self._id_0DDF._id_4AD8 = 0;
  self._id_0E61 = 1;
  self._id_2359 = spawnStruct();
  self._id_341F = 0;
  self._id_DD3A = 0;
  self._id_DD39 = 1;
  self._id_A404 = 1;
  self._id_45CB = 55;
  _id_D556("asm");
  self._id_420C = "gun_down";
  self._id_97DE = 120;
  self._id_3ACC = 0;
  self.speedscalemult = 0.95 + randomfloat(0.15);

  if(!isDefined(self._id_CD57)) {
    self._id_CD57 = 0;
  }

  self._id_8FCD = 0;
  self._id_3ACB = 0;
  self._id_EBA8 = 0;
  self._id_EBAD = 0;

  if(self.team == "allies") {
    self._id_EBC0 = 0.5;
  } else {
    self._id_EBC0 = 0.0;
  }

  if(self.team == "allies") {
    self._id_BFFA = 0;
  } else {
    self._id_BFFA = 256;
  }

  self._id_1713 = 8000;
  self._id_1714 = 0;
  _id_D818();
}

_id_6D6C(var_0, var_1, var_2) {
  var_3 = length(self._id_04DF);

  if(var_3 < 1) {
    return 1;
  }

  var_4 = length(_func_00B0(var_0, var_1, var_2));

  if(var_4 < 1) {
    return 1;
  }

  var_5 = _func_0079(var_0) * (var_2 - var_1);
  var_6 = var_4 / var_5;
  return var_3 / var_6;
}

_id_8825() {
  return self._id_04B9 == "soldier" || self._id_04B9 == "juggernaut";
}

_id_882F() {
  return self._id_1CB8 != "suicidebomber" && self._id_1CB8 != "suicidebomber_cp";
}

_id_47AA() {
  var_0 = _id_0009::_id_1C61();
  return var_0 == "combat";
}

_id_885F() {
  if(self._id_01C2 && !isDefined(self._id_02ED) && isDefined(self._id_3A70) && self _meth_86D5(self._id_3A70) && self._id_3A70 _meth_80B9("crouch")) {
    return 1;
  }

  return 0;
}

_id_6A9A() {
  var_0 = undefined;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;

  if(isDefined(self._id_02ED) && _id_876A()) {
    var_1 = self._id_02ED _meth_80B9("stand");
    var_2 = self._id_02ED _meth_80B9("crouch");
    var_3 = self._id_02ED _meth_80B9("prone");
  } else if(!_id_06BD::_id_23E5() && istrue(self._id_0B67._id_03CE) && isDefined(self._id_0B67._id_03C8)) {
    var_4 = self _meth_81E8("crouch");

    if(var_4 && _id_885F()) {
      return "crouch";
    }

    var_5 = distancesquared(self.origin, self._id_0B67._id_03C8);

    if(var_5 > 262144 && var_4 && !scripts\engine\utility::_id_0F78() && !scripts\anim\utility_common::_id_8AD4()) {
      var_4 = 1;

      if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < 16 && !self._id_02ED _meth_80B9("crouch")) {
        var_4 = abs(_func_000B(self._id_02ED.angles[1] - self.angles[1])) > 90;
      }

      if(var_4) {
        if(_func_0202(self.origin + (0, 0, 32), self._id_0B67._id_03C8, 0, undefined)) {
          return "crouch";
        }
      }
    }
  }

  for(;;) {
    if(self _meth_81E8("stand") && var_1) {
      return "stand";
    }

    if(self _meth_81E8("crouch") && var_2) {
      return "crouch";
    }

    if(self _meth_81E8("prone") && var_3) {
      return "prone";
    }

    if(!var_1 || !var_2 || !var_3) {
      var_1 = 1;
      var_2 = 1;
      var_3 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

_id_48AC() {
  var_0 = _id_6A9A();
  var_1 = _id_06BD::_id_23C7();
  var_2 = [];
  var_2["prone"] = 0;
  var_2["crouch"] = 1;
  var_2["stand"] = 2;
  var_3 = self _meth_84AB();

  if(isDefined(self._id_0323) && distance2dsquared(self._id_0323, self.origin) > 1) {
    var_1 = "stand";
  }

  if(self._id_0B67._id_0093) {
    var_1 = "stand";
  }

  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  if(var_3 == "casual" || var_3 == "casual_gun") {
    var_1 = "stand";
  } else if(var_0 == "prone" && self._id_04B9 == "c6") {
    var_1 = "crouch";
  } else if(var_2[var_0] < var_2[var_1]) {
    var_1 = var_0;
  } else if(var_1 == "prone" && var_0 != var_1) {
    var_1 = var_0;
  } else if(var_1 == "crouch" && var_2[var_0] > var_2["crouch"]) {
    if(_id_06BD::_id_23D4()) {
      var_1 = "stand";
    }
  }

  return var_1;
}

_id_9AA5(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

_id_F2CA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_0) {
    if(!isDefined(self._id_B99C)) {
      _id_B99F(var_1, var_2, var_3, var_4, var_5, var_6);
      thread _id_B9A3();
      _id_06C5::_id_D23C("disable");
    }
  } else {
    self notify("poiauto_disable");
    self._id_B99C = undefined;
    self._id_033C = 0;
    _id_06C5::_id_D23C("automatic");
    self stoplookat();
  }
}

_id_D35A(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_B99C._id_A9D8)) {
    self._id_B99C._id_A9D8 = self._id_B99C._id_10FE9;
  }

  if(!isDefined(self._id_B99C._id_A9D9)) {
    self._id_B99C._id_A9D9 = self._id_B99C._id_10FEA;
  }

  if(!isDefined(self._id_B99C._id_A9A3)) {
    self._id_B99C._id_A9A3 = self._id_B99C._id_B140;
  }

  if(!isDefined(self._id_B99C._id_A9A2)) {
    self._id_B99C._id_A9A2 = self._id_B99C._id_B13F;
  }

  self._id_B99C._id_10FE9 = var_0;
  self._id_B99C._id_10FEA = var_1;
  self._id_B99C._id_B140 = var_2;
  self._id_B99C._id_B13F = var_3;
}

_id_C5DD() {
  self._id_B99C._id_10FE9 = self._id_B99C._id_A9D8;
  self._id_B99C._id_10FEA = self._id_B99C._id_A9D9;
  self._id_B99C._id_B140 = self._id_B99C._id_A9A3;
  self._id_B99C._id_B13F = self._id_B99C._id_A9A2;
}

_id_F2C9(var_0, var_1, var_2, var_3) {
  self._id_41E4 = undefined;
  self._id_A4C4 = undefined;
  self._id_017D = var_0;
  self._id_50B8 = undefined;
  self._id_F1EF = undefined;
  self._id_4AC9 = var_0;

  if(isDefined(self._id_3E32)) {
    self._id_3E32 = undefined;
    self _meth_8866(0);
  }

  if(!var_0) {
    level._id_B993 = scripts\engine\utility::array_remove(level._id_B993, self);
    self._id_04A8 = scripts\engine\utility::ter_op(isDefined(self._id_B99B), self._id_B99B, self._id_04A8);
    self._id_72A7 = undefined;
    self._id_4AC9 = undefined;
    self._id_0B67._id_01D3 = 0;
    self._id_0212 = undefined;
    self stoplookat();
  } else {
    var_4 = self _meth_8644();
    var_5 = self _meth_87CE();
    var_6 = _func_03A5(var_5, "fast");
    self _meth_85E2(min(var_4, var_6));

    if(!isDefined(level._id_B993)) {
      level._id_B993 = [];
    }

    level._id_B993[level._id_B993.size] = self;

    if(isDefined(var_3)) {
      self._id_50B8 = var_3;
    }

    if(isDefined(var_2)) {
      self._id_F1EF = var_2 * 1000;
    }

    if(isDefined(level._id_5D83) && !istrue(level._id_1644)) {
      level thread[[level._id_5D83]]();
      level._id_1644 = 1;
    }

    self._id_B99B = self._id_04A8;
    self._id_04A8 = 0.25;
    self._id_0275 = 90;
    self._id_0377 = -90;
    self._id_B999 = var_1;
    self._id_0212 = "disable";
  }
}

_id_03D3(var_0) {
  if(0) {
    if(!isDefined(var_0)) {
      var_0 = self._id_02ED;
    }

    if(isDefined(self._id_0B67._id_03D5)) {
      return 0;
    }

    if(isDefined(_id_06BD::_id_23BC())) {
      return 0;
    }

    if(isDefined(var_0) && (var_0.type == "Conceal Stand" || var_0.type == "Conceal Crouch")) {
      var_1 = vectornormalize(var_0.origin - self.origin);
      var_2 = _func_030A(var_1, self.angles);
      var_3 = var_0.angles[1];
      var_4 = _func_000B(var_3 - var_2[1]);
      var_5 = _func_0326(var_4, 22.5);

      if(var_5 == 0 || var_5 == 1 || var_5 == 7 || var_5 == 8) {
        self._id_0B67._id_03D3 = 1;
        return 1;
      }
    }

    if(isDefined(self._id_0192) && distancesquared(self.origin, self._id_0192.origin) < 302500 && self._id_00CC > 0) {
      if(!isPlayer(self._id_0192) && !isai(self._id_0192)) {
        return 0;
      }

      if(isDefined(self._id_0B67._id_DB75) && self._id_0B67._id_DB75 > gettime()) {
        return self._id_0B67._id_03D3;
      }

      if(isai(self._id_0192) && !isbot(self._id_0192)) {
        var_6 = self._id_0192 _meth_86A9();
      } else {
        var_6 = self._id_0192 getEye();
      }

      var_7 = undefined;

      if(isDefined(var_0)) {
        var_7 = var_0.origin + (0, 0, 56);
        self._id_0B67._id_03D3 = _func_0202(var_7, var_6, 0, undefined);
      } else if(istrue(self._id_159A)) {
        var_8 = 0;

        if(isDefined(self._id_0323)) {
          if(_func_011D(self._id_0192)) {
            var_8 = _func_0402(self._id_0323, self._id_0192);
          } else {
            var_8 = _func_0402(self._id_0323, self._id_0192.origin);
          }
        } else if(_func_011D(self._id_0192))
          var_8 = self _meth_861A(self._id_0192);
        else {
          var_8 = _func_0402(self.origin, self._id_0192.origin);
        }

        self._id_0B67._id_03D3 = var_8;
      } else
        return 0;

      self._id_0B67._id_DB75 = gettime() + 1000;
      return self._id_0B67._id_03D3;
    }

    self._id_0B67._id_03D3 = 0;
  }

  return 0;
}

_id_3DC5(var_0, var_1) {
  if(!isPlayer(self._id_0192) && !isai(self._id_0192)) {
    return 1;
  }

  if(_id_3DC6()) {
    return _id_3DC7();
  }

  if(!isDefined(var_1)) {
    var_1 = self._id_011F;
  }

  if(!isDefined(var_1)) {
    var_1 = self._id_02ED;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = _id_6A9A();
  var_3 = 56;

  if(var_2 != "stand") {
    var_3 = 32;
  }

  var_4 = var_1.origin + (0, 0, var_3);

  if(!isDefined(var_0)) {
    if(isai(self._id_0192) && !isbot(self._id_0192)) {
      var_0 = self._id_0192 _meth_86A9();
    } else {
      var_0 = self._id_0192 getEye();
    }
  }

  var_5 = 1000;
  self._id_0B67._id_3144 = _func_0202(var_4, var_0, 0, undefined);
  self._id_0B67._id_3145 = gettime() + var_5;
  return self._id_0B67._id_3144;
}

_id_3DC6() {
  return isDefined(self._id_0B67._id_3145) && self._id_0B67._id_3145 > gettime();
}

_id_3DC7() {
  return self._id_0B67._id_3144;
}

_id_87C8(var_0) {
  if(!isDefined(var_0)) {
    var_1 = _id_87D2();
  } else {
    var_1 = _id_87CD(var_0);
  }

  return !var_1 && !_id_5BEE(var_0) && _id_3DC5(undefined, var_0);
}

_id_5BEE(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self._id_02ED;
  }

  if(!self._id_01C2) {
    return 0;
  }

  if(isDefined(self._id_0192._id_02ED) && !_func_0158(var_0, self._id_0192._id_02ED)) {
    return 1;
  }

  if(!self _meth_82CE(self._id_0192, 8)) {
    return 1;
  }

  if(scripts\engine\utility::_id_0F78()) {
    return 1;
  }

  if(distancesquared(var_0.origin, self._id_0192.origin) > 4096.0) {
    if(!isDefined(self._id_0B67._id_5BF1) || self._id_0B67._id_5BF1 < gettime()) {
      var_1 = (0, 0, 50);
      var_2 = vectornormalize(self._id_0192.origin - var_0.origin);
      var_3 = var_0.origin + var_1;
      var_4 = var_3 + var_2 * 64.0;
      self._id_0B67._id_5BF1 = gettime() + 1050;
      self._id_0B67._id_5BF0 = !scripts\engine\trace::_bullet_trace_passed(var_3, var_4, 0, self);
    }

    return self._id_0B67._id_5BF0;
  }

  return 0;
}

_id_87CD(var_0) {
  return istrue(self._id_7D1D) || self _meth_81BB(var_0);
}

_id_87D2() {
  return istrue(self._id_7D1D) || self _meth_81BB();
}

_id_B99F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = 15;
  }

  if(!isDefined(var_1)) {
    var_1 = 35;
  }

  if(!isDefined(var_2)) {
    var_2 = -20;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.8;
  }

  if(!isDefined(var_5)) {
    var_5 = 1.8;
  }

  self._id_B99C = spawnStruct();
  self._id_B99C._id_10FE9 = var_1;
  self._id_B99C._id_10FEA = var_0;
  self._id_B99C._id_B140 = var_2;
  self._id_B99C._id_B13F = var_3;
  self._id_B99C._id_9F42 = var_4;
  self._id_B99C._id_9CB2 = var_5;
  self._id_033C = 1;
}

_id_B9A3() {
  self endon("poiauto_disable");
  self endon("death");
  var_0 = 500;
  var_1 = 0;
  var_2 = 0;
  var_3 = gettime() + 30000;

  if(!isDefined(self._id_B99C)) {
    _id_B99F();
  }

  for(;;) {
    var_4 = 0;

    if(var_3 <= gettime()) {
      self._id_0338 = (0, 0, 0);

      if(var_3 == var_1) {
        var_4 = 1;
      }
    }

    if(var_1 <= gettime()) {
      var_3 = gettime() + int(randomfloatrange(self._id_B99C._id_9F42, self._id_B99C._id_9CB2) * 1000);
      var_2 = gettime();
      _id_B9A2(var_4);
      var_5 = var_0 - gettime();
      var_6 = var_3 - gettime();

      if(abs(var_6 - var_5) >= 550 && scripts\engine\utility::cointoss()) {
        var_1 = var_3;
      } else if(var_5 > 3000) {
        var_1 = gettime() + randomintrange(2000, 3000);
      } else {
        var_1 = gettime() + var_5 + 550 + randomintrange(1000, 2000);
      }
    }

    waitframe();
  }
}

_id_B9A1(var_0) {
  var_1 = anglesToForward(var_0);
  var_2 = rotatevector(var_1, self.angles);
  var_3 = self _meth_86A9();
  var_4 = var_3 + var_2 * 128.0;
  return var_4;
}

_id_B99E() {
  var_0 = randomfloatrange(-45, 45);
  var_1 = randomfloatrange(-20, 20);
  var_2 = _id_B9A1((var_1, var_0, 0));
  self._id_0339 = 1;
  thread _id_B99D();
  self _meth_819F(var_2);
}

_id_B99D() {
  self notify("poiauto_glanceend");
  self endon("poiauto_glanceend");
  wait 0.55;
  self._id_0339 = 0;
}

_id_B9A0() {
  return istrue(self._id_0339);
}

_id_B9A2(var_0) {
  if(var_0) {
    var_1 = randomfloatrange(self._id_0338[1] + 5, self._id_0338[1] + 10);
    var_2 = randomfloatrange(5, 10);

    if(scripts\engine\utility::cointoss()) {
      var_2 = var_2 * -1;
    }

    var_2 = self._id_0338[0] + var_2;
  } else {
    var_3 = self._id_B99C;
    var_1 = randomfloatrange(var_3._id_10FEA, var_3._id_10FE9);
    var_2 = randomfloatrange(var_3._id_B140, var_3._id_B13F);
  }

  if(scripts\engine\utility::cointoss()) {
    var_1 = var_1 * -1;
  }

  self._id_033B = (var_2, var_1, 0);
  self._id_033A = randomintrange(100, 300) + gettime();
}

_id_BC1C(var_0, var_1, var_2) {
  var_3 = self._id_1C30._id_1A35;

  if(isDefined(self._id_189C)) {
    var_3 = self._id_189C;
  }

  if(!isDefined(anim._id_C0F2)) {
    anim._id_C0F2 = [];
  }

  var_4 = gettime();
  var_5 = 1000;
  var_6 = 2;
  var_7 = 0;
  var_8 = 1;
  var_9 = var_3 + var_0;

  if(isDefined(anim._id_C0F2[var_9])) {
    var_10 = anim._id_C0F2[var_9][var_2];

    if(var_4 - var_10[var_7] <= var_5 && var_10[var_8] >= var_6) {
      var_11 = _id_0009::_id_1C57(var_0, var_1);
      var_12 = var_11[0];
      var_13 = var_11[var_11.size - 1];

      for(var_14 = 1; var_14 < var_11.size; var_14++) {
        var_15 = scripts\engine\math::_id_10FA2(var_12, var_13 - 1, var_2 + var_14);

        if(anim._id_C0F2[var_9][var_15][var_8] < var_6) {
          var_2 = var_15;
          var_10 = anim._id_C0F2[var_9][var_2];
          break;
        }
      }
    }

    if(var_4 - var_10[var_7] > var_5) {
      var_10[var_7] = var_4;
      var_10[var_8] = 1;
    } else
      var_10[var_8] = var_10[var_8] + 1;

    anim._id_C0F2[var_9][var_2] = var_10;
  } else {
    anim._id_C0F2[var_9] = [];
    var_16 = _id_0009::_id_1C5A(var_0);

    for(var_14 = 0; var_14 < var_16.size; var_14++) {
      anim._id_C0F2[var_9][var_14] = [0, 0];
    }

    anim._id_C0F2[var_9][var_2][var_7] = var_4;
    anim._id_C0F2[var_9][var_2][var_8] = 1;
  }

  return var_2;
}

_id_823F(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 90;
  var_1["Cover Left Crouch"] = 90;
  var_1["Cover Right"] = -90;
  var_1["Cover Right Crouch"] = -90;
  var_1["Cover Crouch"] = -90;
  var_1["Cover Stand"] = -90;
  var_1["Cover Stand 3D"] = -90;
  anim._id_A57D[var_0] = var_1;
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim._id_5F44[var_0] = var_1;
  var_2 = [];
  var_2["Aim Down"] = 45;
  anim._id_A56A[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Right Crouch"] = 0;
  var_1["Cover Left"] = 0;
  anim._id_A575[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim._id_A574[var_0] = var_2;
  var_2 = [];
  var_2["Cover Left Crouch"] = 45;
  var_2["Cover Right Crouch"] = 45;
  anim._id_A577[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim._id_5F43[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim._id_5F42[var_0] = var_1;
}

_id_F887() {
  var_0 = self _meth_8182();

  if(isDefined(var_0)) {
    var_1 = var_0 _meth_87E9(0);

    if(isDefined(var_1)) {
      return var_1;
    }

    var_2 = var_0 _meth_87E8();

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  return undefined;
}

_id_F889(var_0, var_1) {
  var_2 = _id_F888(var_0, var_1);

  if(isDefined(var_2)) {
    return 1;
  } else {
    return 0;
  }
}

_id_F888(var_0, var_1) {
  var_2 = 1;
  var_3 = self _meth_8182();
  var_4 = !var_3 _meth_8812();

  if(isDefined(var_3) && isDefined(var_0)) {
    if(isent(var_0)) {
      if(istrue(var_1) && (var_0.maxhealth > 0 && var_0.health <= 0)) {
        return undefined;
      }

      var_5 = var_0 _meth_8176();

      if(istrue(var_2) && !var_3 _meth_8564(var_5, var_4)) {
        return undefined;
      }

      return var_5;
    } else {
      if(istrue(var_2) && !var_3 _meth_8564(var_0, var_4)) {
        return undefined;
      }

      return var_0;
    }
  }

  return undefined;
}

_id_8743(var_0, var_1, var_2, var_3) {
  if(scripts\common\utility::_id_854B(var_3)) {
    return 1;
  }

  return 0;
}

_id_6890(var_0) {
  var_1 = var_0.origin;

  if(isDefined(self._id_F4F2) && self._id_F4F2 != 0) {
    var_1 = var_1 + self._id_F4F2 * anglesToForward(var_0.angles);
  }

  return var_1;
}

_id_688F(var_0) {
  if(isDefined(self._id_F4E8) && self._id_F4E8 != 0) {
    return self._id_F4E8 * anglesToForward(var_0.angles);
  }

  return (0, 0, 0);
}