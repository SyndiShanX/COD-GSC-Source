/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2302.gsc
*************************************************/

_id_AF32(var_0, var_1, var_2, var_3) {
  return length(self._id_04DF) > 1;
}

_id_AF3B(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0408) || !isDefined(self._id_0408._id_AF2F) || !isDefined(self._id_0408._id_AF31)) {
    return 0;
  }

  var_4 = 200;

  if(gettime() > self._id_0408._id_AF31 + var_4) {
    return 0;
  }

  if(isDefined(self._id_0408._id_8522)) {
    self _meth_819F(self._id_0408._id_8522.origin);
  }

  return 1;
}

_id_AF35(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0408) || !isDefined(self._id_0192)) {
    return 0;
  }

  if(_id_0009::_id_1C61() == "combat" && self _meth_8067(self._id_0192)) {
    self._id_0408._id_AF2F = "med";
    self._id_0408._id_AF30 = self._id_0192.origin;
    self._id_0408._id_AF31 = gettime();
    return 1;
  }

  return 0;
}

_id_B336(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_B337(var_0, var_1, var_1);
}

_id_B337(var_0, var_1, var_2) {
  self._id_0408._id_2B71 = self._id_0408._id_AF2F;

  if(_id_DB93()) {
    if(distance2dsquared(self.origin, self._id_0408._id_AF30) > 1024) {
      self setlookat(self._id_0408._id_AF30);
    }
  }

  var_3 = self _meth_85C8(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_2, var_3);
  var_5 = 1;

  if(isDefined(self._id_0408._id_C081)) {
    var_6 = 1;
    var_7 = _func_00BB(var_4, "code_move");

    if(var_7.size > 0) {
      var_6 = var_7[0];
    }

    var_8 = _func_0079(var_4) * var_6;
    var_9 = 0.05 + (self._id_0408._id_C081 - gettime()) / 1000;

    if(var_9 < 0.2) {
      var_9 = 0.2;
    }

    var_5 = clamp(var_8 / var_9, 0.8, 1.3);
    self._id_0408._id_C081 = undefined;
  }

  self _meth_85ED(var_2, var_3, var_5);
  self._id_0408._id_AF2F = undefined;
  self._id_0408._id_AF31 = undefined;
  _id_0009::_id_1C4A(var_0, var_1, ::_id_5CBF, undefined, var_2);
}

_id_DB93(var_0, var_1, var_2, var_3) {
  return self._id_0408._id_AF2F == "large" || self._id_0408._id_AF2F == "med" || self._id_0408._id_AF2F == "smed";
}

_id_DB94(var_0, var_1, var_2, var_3) {
  return _id_0009::_id_1C61() == "combat" && !isDefined(self._id_0192) && self[[self._id_5D98]]();
}

_id_DB95(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0192);
}

_id_35B4(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, scripts\engine\utility::_id_EA52(_id_6C20()));
}

_id_35B5(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_EA52(_id_6C20());
  return _id_35B1(var_0, var_1, var_3);
}

_id_6C20() {
  var_0 = 0;

  if(isDefined(self._id_0408._id_AF30)) {
    var_1 = self._id_0408._id_AF30 - self.origin;

    if(_func_0134(var_1) < 36) {
      var_0 = 0;
    } else {
      var_2 = _func_0261(var_1);
      var_0 = self.angles[1] - var_2;
    }
  }

  return _id_6CE5(var_0);
}

_id_6C1F() {
  var_0 = _id_6C20();
  var_1 = self._id_0408._id_AF2F + "_" + var_0;
  return var_1;
}

_id_35B2(var_0, var_1, var_2) {
  var_3 = _id_6C1F();
  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_35B3(var_0, var_1, var_2) {
  var_3 = _id_6C1F();
  return _id_35B1(var_0, var_1, var_3);
}

_id_AF4D(var_0, var_1, var_2) {
  self._id_0408._id_2B71 = undefined;
  self stoplookat();
}

_id_6CE5(var_0) {
  var_0 = _func_000B(var_0);

  if(var_0 > 135 || var_0 < -135) {
    var_1 = 2;
  } else if(var_0 < -45) {
    var_1 = 4;
  } else if(var_0 > 45) {
    var_1 = 6;
  } else {
    var_1 = 8;
  }

  return var_1;
}

_id_7447(var_0, var_1, var_2) {
  if(var_1 == "face_goal" && isDefined(self._id_0408._id_AF30)) {
    var_3 = self._id_0408._id_AF30 - self.origin;
    var_4 = _func_0261(var_3);
    thread _id_5881(var_0, var_4);
    return 1;
  }

  return 0;
}

_id_5881(var_0, var_1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_2 = 1;
    var_3 = self._id_0192;

    if(!isDefined(var_3)) {
      if(isDefined(self._id_0408._id_8501) && isPlayer(self._id_0408._id_8502)) {
        var_3 = self._id_0408._id_8502;
      }
    }

    if(isDefined(var_3) && isPlayer(var_3) && distance(self.origin, var_3.origin) <= 200) {
      var_2 = 0;
    }

    var_4 = 0.25;

    if(isDefined(var_3) && _func_011D(var_3)) {
      if(!var_2 || var_2 && self _meth_8067(var_3)) {
        var_5 = var_3.origin - self.origin;
        var_1 = _func_0261(var_5);
        var_4 = 0.5;
      }
    }

    var_6 = _func_000B(var_1 - self.angles[1]);
    self _meth_8251("face angle", self.angles[1] + var_6 * var_4);
    waitframe();
  }
}

_id_AF16(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_08F1::_id_10800(var_0, var_1, 1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = randomfloatrange(0.8, 1.2);
  self _meth_85ED(var_1, var_3, var_4);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_1, var_3));
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_AEF1() {
  if(isDefined(self._id_0B67._id_7CCD)) {
    return _func_000B(self._id_0B67._id_7CCD.angles[1] - self.angles[1]);
  } else if(isDefined(self._id_AEEC)) {
    return _func_000B(self._id_AEEC - self.angles[1]);
  } else if(isDefined(self._id_0B67._id_24E0)) {
    var_0 = _func_0350(self.origin, 256, 96);

    if(isDefined(var_0)) {
      var_1 = _func_000B(_func_0261(var_0) - self.angles[1]);
      return var_1;
    }
  }

  return undefined;
}

_id_AF36(var_0, var_1, var_2, var_3) {
  var_4 = _id_AEF1();
  var_5 = isDefined(var_4) && abs(var_4) > 10.0;
  self._id_481D = var_4;
  return var_5;
}

_id_AEEB(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._id_481D)) {
    var_3 = self._id_481D;
  }

  if(!isDefined(var_3)) {
    var_4 = "8";
  } else if(var_3 < -135) {
    var_4 = "2r";
  } else if(var_3 > 135) {
    var_4 = "2l";
  } else if(var_3 < -45) {
    var_4 = "6";
  } else if(var_3 > 45) {
    var_4 = "4";
  } else {
    var_4 = "8";
  }

  var_5 = _id_0009::_id_1C7D(var_1, var_4);
  return var_5;
}

_id_AF11(var_0, var_1, var_2) {
  _id_0009::_id_1C81(var_0, var_1, 1);
}

_id_7499(var_0, var_1) {
  if(var_0 == "face_goal" && isDefined(self._id_481D) && isDefined(var_1._id_E75C)) {
    var_2 = _func_00BB(var_1._id_10FD1, "face_goal_end");
    var_3 = undefined;

    if(!isDefined(var_2)) {
      return undefined;
    }

    var_4 = _func_0079(var_1._id_10FD1);

    if(scripts\common\utility::issp()) {
      var_5 = self _meth_8111(var_1._id_10FD1);
    } else {
      var_6 = _func_00BB(var_1._id_10FD1, "face_goal");
      var_5 = var_6[0];
    }

    var_3 = var_2[0] - var_5;
    var_7 = _func_0077(var_1._id_10FD1, 0, 1);
    var_8 = _func_000B(self._id_481D - var_7);
    var_3 = var_3 * var_4;
    thread _id_AF42(var_1._id_E75C, var_8, var_3);
  } else if(var_0 == "end")
    return 0;

  return undefined;
}

_id_AF42(var_0, var_1, var_2) {
  self notify("FaceYawThread");
  self endon("FaceYawThread");
  self endon("death");
  self endon(var_0 + "_finished");
  var_3 = var_2 * (1000 / level._id_01E2);
  var_4 = var_1 / var_3;

  while(var_3 >= 0) {
    self _meth_8251("face angle", _func_000A(self.angles[1] + var_4));
    var_3 = var_3 - 1;
    waitframe();
  }
}

_id_AF14(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_06D7::_id_4979();
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);

  if(scripts\engine\utility::_id_0F78() && isDefined(self._id_0192)) {
    self _meth_8251("face enemy");
  } else {
    self _meth_8251("face angle 3d", self.angles);
  }

  if(isDefined(self._id_02ED)) {
    self _meth_8019("angle deltas");
  } else {
    self _meth_8019("zonly_physics");
  }

  _id_0009::_id_1C8E(var_0, var_1, var_4);
  self._id_E83A = _func_000B(_func_0077(var_4, 0, 1) + self.angles[1]);
  self._id_04C2 = 1;
  var_5 = 1;
  self _meth_85ED(var_1, var_3, var_5);
  var_6 = spawnStruct();
  var_6._id_10FD1 = var_4;
  var_6._id_E75C = var_1;
  _id_0009::_id_1C45(var_0, var_1, ::_id_7499, var_6);
}

_id_AF34(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0408)) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!isDefined(self._id_0408._id_24DD) || !self._id_0408._id_24DD) {
    return 0;
  }

  if(!isDefined(self._id_0408._id_3D77._id_851F)) {
    var_4 = _func_031E(self._id_1C30._id_1A35, var_2);
    self._id_0408._id_3D77._id_851F = var_4[randomint(var_4.size)];
  }

  var_5 = _id_0009::_id_1C7D(var_2, self._id_0408._id_3D77._id_851F);
  var_6 = _id_0009::_id_1C6E(var_2, var_5);
  var_7 = _func_00B0(var_6);
  var_8 = length(var_7);
  var_9 = 12;
  var_10 = 12;
  var_11 = self._id_0280;

  if(var_11 < var_8 - var_10) {
    return 0;
  }

  var_12 = self _meth_8473();

  if(var_12 > var_8 + var_9) {
    return 0;
  }

  if(var_12 < var_8 - var_10) {
    return 0;
  }

  var_13 = self._id_0323 - self.origin;
  var_14 = spawnStruct();
  var_14._id_0052 = 0;
  var_14._id_01BF = vectortoangles(var_13);
  var_14._id_040F = var_5;
  var_14._id_02D4 = var_7;
  var_14._id_0405 = self._id_0323 - rotatevector(var_7, var_14._id_01BF);
  self._id_1C30._id_E906 = var_14;
  return 1;
}

_id_AEEE(var_0, var_1, var_2) {
  if(isDefined(self._id_0408) && isDefined(self._id_0408._id_3D77)) {
    self._id_0408._id_3D77._id_851F = undefined;
  }

  self._id_0408._id_24DD = undefined;
  _id_08F3::_id_5B12(var_0, var_1, var_2);
}

_id_AF01(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0408) && isDefined(self._id_0408._id_24FE) && self._id_0408._id_24FE;
}

_id_AF02(var_0, var_1, var_2, var_3) {
  return !_id_AF01(var_0, var_1, var_2, var_3);
}

_id_AF12(var_0, var_1, var_2) {
  thread _id_AF13(var_1, self._id_0408._id_7CCB);
  _id_0009::_id_1C87(var_0, var_1);
}

_id_AF13(var_0, var_1) {
  self endon(var_0 + "_finished");

  while(isDefined(var_1) && isalive(var_1)) {
    var_2 = self _meth_8204(var_1);
    var_3 = var_2 - self.origin;
    self _meth_8251("face angle", _func_0261(var_3));
    waitframe();
  }
}

_id_AF38(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0408) && isDefined(self._id_0408._id_2523) && self._id_0408._id_2523;
}

_id_AF0D(var_0, var_1, var_2, var_3) {
  return !_id_AF38(var_0, var_1, var_2, var_3);
}

_id_AF39(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0B67._id_24E1) || !self._id_0B67._id_24E1) {
    return 0;
  }

  return !isDefined(self._id_006A) || !self._id_006A;
}

_id_AF3A(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0B67._id_24E1) && self._id_0B67._id_24E1) {
    return 0;
  }

  return isDefined(self._id_006A) && self._id_006A;
}

_id_AF03(var_0, var_1, var_2) {
  if(isDefined(self._id_006A) && self._id_006A) {
    _id_488B();
  }

  if(istrue(self._id_0B67._id_24E1) && !self._id_5CA8) {
    self[[self._id_5DC6]]();
  }
}

_id_AF04(var_0, var_1, var_2) {
  if(istrue(self._id_0B67._id_24E1)) {
    self[[self._id_5DC6]]();
  }
}

_id_35B1(var_0, var_1, var_2) {
  var_3 = var_2;

  if(isDefined(self._id_006A) && self._id_006A) {
    var_3 = "fl_" + var_3;
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_AEF3(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_006A) && self._id_006A;
}

_id_AF0C(var_0, var_1, var_2, var_3) {
  return !_id_AEF3(var_0, var_1, var_2, var_3);
}

_id_AF15(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_08F1::_id_10800(var_0, var_1, 1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self._id_0408._id_5CC0 = _id_0009::_id_1C6E(var_1, var_3);
  var_4 = self._id_A246;

  if(length(self._id_04DF) < 1) {
    var_4 = randomfloatrange(0.8, 1.2);
  }

  self _meth_85ED(var_1, var_3, var_4);
  self _meth_85F5(var_1, var_3, var_4);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_1, var_3));
  var_5 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));

  if(var_5 == "code_move") {
    var_5 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  }
}

_id_5CBC(var_0) {
  if(var_0 == "attach") {
    var_1 = 1;

    if(isDefined(self._id_0408._id_5CC0) && self _meth_8112(self._id_0408._id_5CC0) > 0) {
      var_1 = !_func_0011(self._id_0408._id_5CC0, "flashlight_on");
      self._id_0408._id_5CC0 = undefined;
    }

    _id_1D88(var_1);
  } else if(var_0 == "detach") {
    _id_488B();

    if(_id_0009::_id_1C61() != "patrol" && isDefined(self._id_0B67._id_24E1) && self._id_0B67._id_24E1) {
      self[[self._id_5DC6]]();
    }
  } else if(var_0 == "flashlight_on")
    self[[self._id_5DC6]]();
  else if(var_0 == "flashlight_off") {
    self[[self._id_5DC5]](0);
  }
}

_id_D564(var_0) {
  if(isai(self)) {
    _id_488B();
  }

  self._id_5CB9 = var_0;

  if(isai(self) && istrue(self._id_006A)) {
    _id_1D88(1);
  }
}

_id_6A48() {
  var_0 = "wm_equip_gen_flashlight_00";

  if(isDefined(self._id_5CB9)) {
    var_0 = self._id_5CB9;
  } else if(isDefined(level._id_5CB9)) {
    var_0 = level._id_5CB9;
  }

  return var_0;
}

_id_6A49() {
  var_0 = "tag_accessory_left";

  if(isDefined(self._id_5CBB)) {
    var_0 = self._id_5CBB;
  } else if(isDefined(level._id_5CBB)) {
    var_0 = level._id_5CBB;
  }

  return var_0;
}

_id_1D88(var_0) {
  self[[self._id_5DC5]](0);
  var_1 = _id_6A48();
  var_2 = _id_6A49();
  self attach(var_1, var_2, 1);
  self._id_5CB8 = var_1;
  self._id_5CBA = var_2;
  self._id_006A = 1;
  self._id_5CB3 = "tag_light";

  if(var_0) {
    self[[self._id_5DC6]]();
  }
}

_id_488B() {
  if(!istrue(self._id_006A)) {
    return;
  }
  self[[self._id_5DC5]](0);

  if(isDefined(self._id_5CB8) && isDefined(self._id_5CBA)) {
    self detach(self._id_5CB8, self._id_5CBA);
    self._id_5CB8 = undefined;
    self._id_5CBA = undefined;
  }

  self._id_006A = 0;
  self._id_5CB3 = undefined;
}

_id_5CBF(var_0, var_1, var_2) {
  _id_5CBC(var_1);
  return _id_7447(var_0, var_1);
}

_id_AEFB(var_0, var_1, var_2) {
  if(isDefined(self._id_0408._id_8522)) {
    scripts\common\utility::_id_47A7("alert");
    self._id_0408._id_AF2F = "small";
    self._id_0408._id_AF30 = self._id_0408._id_8522._id_8512;
    self._id_0408._id_AF31 = gettime();
  }
}

_id_AF06(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_1C30._id_5E3A._id_5E36) && self._id_1C30._id_5E3A._id_5E36 == "right") {
    return 0;
  }

  var_4 = self _meth_8473();

  if(var_4 < 96) {
    return 0;
  }

  return 1;
}

_id_AF3C(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0408)) {
    return 0;
  }

  return self[[self._id_5D99]]() || self[[self._id_5D9C]]();
}

_id_AF08(var_0, var_1, var_2, var_3) {
  if(isDefined(_id_06BD::_id_23C6())) {
    return 0;
  }

  if(istrue(self._id_94D7)) {
    return 0;
  }

  var_4 = undefined;

  if(isDefined(self._id_1C30._id_426A._id_1C02)) {
    var_4 = self._id_1C30._id_426A._id_1C02[1];
  } else {
    var_5 = _func_0350(self.origin, 256, 96);

    if(isDefined(var_5)) {
      var_4 = _func_0261(var_5);
    }
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_6 = _func_000B(var_4 - self.angles[1]);

  if(abs(var_6) < 25) {
    return 0;
  }

  self._id_481D = var_6;
  return 1;
}

_id_AF07(var_0, var_1, var_2, var_3) {
  if(_id_0009::_id_1C51(var_0, "sharp_turn")) {
    return 0;
  }

  if(distance2dsquared(self._id_0323, self.origin) < 16) {
    return 0;
  }

  var_4 = anglesToForward(self.angles);
  var_5 = vectordot(self._id_027F, var_4);
  var_6 = 0;

  if(self _meth_8473() > 100) {
    var_6 = -0.707;
  }

  if(vectordot(self._id_027F, var_4) > var_6) {
    return 0;
  }

  var_7 = "left";

  if(_id_0009::_id_1C51(var_0, "pass_left")) {
    var_7 = "left";
  } else if(_id_0009::_id_1C51(var_0, "pass_right")) {
    var_7 = "right";
  } else if(self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_7 = "right";
  }

  var_8 = spawnStruct();
  var_8._id_0053 = 4;
  var_8._id_0052 = 0;
  var_8._id_040F = _id_0009::_id_1C7D(var_2, var_7 + "2");
  var_9 = _id_0009::_id_1C6E(var_2, var_8._id_040F);
  var_8._id_02D4 = _func_00B0(var_9);
  var_10 = rotatevector(var_8._id_02D4, self.angles);
  var_11 = self.origin + var_10;
  var_12 = _func_02A6(self.origin, var_11, self, 1);
  var_13 = var_12["position"];
  var_8._id_0405 = var_13 - var_10;
  var_8._id_01BF = self.angles;
  var_8._id_2C55 = 1;
  var_8._id_427C = var_13;
  self._id_1C30._id_E906 = var_8;
  return 1;
}