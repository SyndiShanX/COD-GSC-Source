/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2307.gsc
*************************************************/

_id_B90A(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_06C2::_id_356A(var_1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self._id_4812 = "crouch";
  scripts\anim\utility::_id_FC00();
  self endon("killanimscript");
  self _meth_8019("noclip");
  var_5 = self _meth_8161();
  self _meth_8251("face angle", var_5.angles[1]);
  var_5._id_F4DA = var_5.origin[2] + var_5._id_F4DB;
  var_6 = var_5._id_F4DA - var_5.origin[2];
  thread _id_08F1::_id_F040(var_6 - var_2);
  var_7 = 0.15;
  self _meth_85ED(var_1, var_3);
  var_8 = 0.2;
  var_9 = 0.2;
  thread _id_F4D7(var_0, var_1);

  if(!_func_0011(var_4, "gravity on")) {
    var_10 = 1.23;
    wait(var_10 - var_8);
    self _meth_8019("gravity");
    wait(var_8);
  } else {
    self waittillmatch("traverse", "gravity on");
    self _meth_8019("gravity");

    if(!_func_0011(var_4, "blend")) {
      wait(var_8);
    } else {
      self waittillmatch("traverse", "blend");
    }
  }

  _id_F09F(var_0, var_1);
}

_id_B909(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  _id_06C2::_id_356A(var_1);
  self _meth_8019("noclip");
  var_4 = self _meth_8161();
  self _meth_8251("face angle", var_4.angles[1]);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C45(var_0, var_1);
  _id_F09F(var_0, var_1);
}

_id_B90B(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = getdvarint("#x3c559397e82f6a45e", 0);

  if(var_3 != 3 && var_3 != 4) {
    _id_06C2::_id_356A(var_1);
  }

  self._id_BF4E = 1;
  var_4 = self _meth_8161();
  var_5 = self _meth_8160();
  var_4._id_F4DA = var_4.origin[2] + var_4._id_F4DB - 44;
  var_6 = [];

  if(var_4._id_F4DA > var_5[2]) {
    var_7 = (var_4.origin[0] + var_5[0]) * 0.5;
    var_8 = (var_4.origin[1] + var_5[1]) * 0.5;
    var_6[var_6.size] = (var_7, var_8, var_4._id_F4DA);
  }

  var_6[var_6.size] = var_5;
  var_10 = spawn("script_model", var_4.origin);
  var_10 setModel("tag_origin");
  var_10.angles = var_4.angles;
  thread scripts\engine\utility::_id_472E(var_10);
  self _meth_8251("face angle", var_4.angles[1]);
  var_11 = 1.63;
  self linkto(var_10);
  var_12 = _id_0009::_id_1C5C(var_0, var_1);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_12));
  self _meth_85ED(var_1, var_12);
  thread _id_F4D7(var_0, var_1);

  foreach(var_14 in var_6) {
    var_15 = var_11 / var_6.size;
    var_10 moveto(var_14, var_15);
    var_10 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self._id_BF4E = undefined;
  var_10 delete();
  thread _id_F09F(var_0, var_1);
}

_id_F4D8(var_0, var_1, var_2) {
  self unlink();
  self._id_BF4E = undefined;
}

_id_F4D7(var_0, var_1) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self endon("double_jumped");
  _id_0009::_id_1C45(var_0, var_1);
}

_id_6A25(var_0) {
  return level._id_CC48[var_0];
}

_id_B90C(var_0, var_1, var_2) {
  _id_06C2::_id_B90F(var_0, var_1);
}

_id_3637(var_0, var_1, var_2) {
  var_3 = self _meth_8161();
  var_4 = var_3._id_005D;
  var_5 = _id_6A25(var_4);
  return var_5;
}

_id_B38C(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_8019("noclip");
  self _meth_8251("face angle", self.angles[1]);
  self._id_04C2 = 1;
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1);
  thread _id_F09F(var_0, var_1);
}

_id_69F3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0009::_id_1C38(var_0, var_1);
  var_6 = _id_0009::_id_1C6E(var_1, var_5);
  var_7 = _func_00BB(var_6, var_4);
  var_8 = var_7[0];
  var_9 = _func_00B0(var_6, 0, var_8);
  var_10 = _func_0077(var_6, 0, var_8);
  return _id_08F4::_id_2EB1(var_2, var_3[1], var_9, var_10);
}

_id_4EA4(var_0, var_1, var_2, var_3) {
  var_4 = var_3[2] - var_2.origin[2];

  if(var_4 < 0) {
    return 0;
  }

  if(isDefined(var_2._id_8C96) && getdvarint("#x3c559397e82f6a45e", 0) != 2) {
    var_5 = var_2._id_8C96;
    var_6 = var_2.angles - var_2._id_E6FC;

    if(var_6 != (0, 0, 0)) {
      var_5 = rotatevector(var_5, var_6);
    }

    var_7 = var_2.origin + var_5;
    var_8 = var_7[2];
    var_8 = var_8 - 44;

    if(var_3[2] < var_8) {
      return 0;
    }
  }

  var_9 = var_3 - var_2.origin;
  var_9 = (var_9[0], var_9[1], 0);
  var_10 = vectortoangles(var_9);
  var_11 = _id_69F3(var_0, var_1, var_3, var_10, "footstep_left_small");
  var_12 = var_11 - var_2.origin;

  if(vectordot(var_12, var_9) < 0) {
    return 0;
  }

  return 1;
}

_id_34F6(var_0, var_1, var_2, var_3) {
  var_4 = _id_6DF9();

  if(!isDefined(var_4)) {
    thread _id_F09F(var_0, "double_jump");
    return 0;
  }

  var_5 = _id_6DF8();

  if(!_id_4EA4(var_0, var_2, var_4, var_5)) {
    thread _id_F09F(var_0, "double_jump");
    return 0;
  }

  return 1;
}

_id_6DF9() {
  if(isDefined(self._id_F4C9)) {
    return self._id_F4C9;
  }

  return self _meth_8161();
}

_id_6DF8() {
  if(isDefined(self._id_F4C7)) {
    return self._id_F4C7;
  }

  return self _meth_8160();
}

_id_B38E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_6DF9();
  var_4 = var_3._id_4EA3;
  var_5 = var_4 - var_3.origin;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = vectortoangles(var_5);
  var_7 = _id_0009::_id_1C5C(var_0, var_1);
  var_8 = var_1 + "_finish";
  var_9 = _id_69F3(var_0, var_8, var_4, var_6, "mantle_align");
  var_9 = (var_9[0], var_9[1], var_9[2] + var_2);
  _id_B8CF(var_0, var_1, var_7, var_9, var_6, 1, 0, 1);
}

_id_B38D(var_0, var_1, var_2) {
  _id_B38E(var_0, var_1, -8);
}

_id_B390(var_0, var_1, var_2) {
  _id_B38E(var_0, var_1, -42);
}

_id_4EA5(var_0, var_1, var_2) {
  self._id_04C2 = 0;
  self._id_8C97 = undefined;
  self._id_F4C9 = undefined;
  self._id_F4C7 = undefined;
}

_id_4EA0(var_0, var_1, var_2) {
  if(!_id_0009::_id_1C50(var_0, "end")) {
    _id_4EA5(var_0, var_1, var_2);
  }
}

_id_880C(var_0, var_1, var_2, var_3) {
  return _id_0009::_id_1C50(var_0, "end");
}

_id_B38F(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_6DF9();
  var_4 = _id_6DF8();

  if(!isDefined(var_3._id_E6FC)) {
    var_3._id_E6FC = var_3.angles;
  }

  var_5 = var_3.angles - var_3._id_E6FC;

  if(var_5 != (0, 0, 0)) {
    var_4 = rotatevector(var_4, var_5);
  }

  var_6 = undefined;
  var_7 = getdvarint("#x3c559397e82f6a45e", 0);

  if(var_7 != 2) {
    if(isDefined(var_3._id_8C96)) {
      var_8 = var_3._id_8C96;

      if(var_5 != (0, 0, 0)) {
        var_8 = rotatevector(var_8, var_5);
      }

      var_6 = var_3.origin + var_8;
      var_9 = var_6[2];
      var_9 = var_9 - 44;

      if(var_9 > var_4[2]) {
        var_10 = (var_3.origin[0] + var_4[0]) * 0.5;
        var_11 = (var_3.origin[1] + var_4[1]) * 0.5;
        var_6 = (var_10, var_11, var_6[2]);
      } else
        var_6 = undefined;
    }
  }

  var_12 = _id_0009::_id_1C5C(var_0, var_1);
  self._id_8C97 = var_6;
  var_13 = var_1 + "_finish";

  if(_id_4EA4(var_0, var_13, var_3, var_4)) {
    var_14 = var_4 - var_3.origin;
    var_14 = (var_14[0], var_14[1], 0);
    var_15 = vectortoangles(var_14);
    var_13 = var_1 + "_finish";
    var_16 = _id_69F3(var_0, var_13, var_4, var_15, "footstep_left_small");
    var_4 = var_16;
  }

  var_14 = var_4 - var_3.origin;
  var_17 = 0;
  var_18 = 1.0;

  if(var_14[2] < 0) {
    var_17 = 1;
    var_19 = _func_00BB(_id_0009::_id_1C6E(var_1, var_12), "gravity on");

    if(isDefined(var_19) && var_19.size > 0) {
      var_18 = var_19[0];
    }
  }

  var_14 = (var_14[0], var_14[1], 0);
  var_15 = vectortoangles(var_14);
  _id_B8CF(var_0, var_1, var_12, var_4, var_15, var_18, var_17, 1);
}

_id_35F2(var_0, var_1, var_2) {
  var_3 = _id_6DF8();
  var_4 = "double_jump_up";

  if(isDefined(var_2)) {
    var_4 = "double_jump_" + var_2;
  } else if(var_3[2] < self.origin[2]) {
    var_4 = "double_jump_down";
  }

  if(self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_5 = "right_";
  } else {
    var_5 = "left_";
  }

  var_4 = var_5 + var_4;
  var_6 = _id_0009::_id_1C7D(var_1, var_4);
  return var_6;
}

_id_6E4E(var_0, var_1) {
  var_2 = var_0.angles - var_0._id_109A0._id_E6FC;

  if(var_2 != (0, 0, 0)) {
    var_3 = rotatevector(var_0._id_109A0._id_A576[var_1], var_2);
    var_4 = var_0.origin + var_3;
  } else
    var_4 = var_0.origin + var_0._id_109A0._id_A576[var_1];

  return var_4;
}

_id_DC10(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  var_4 = self._id_0192.origin;
  var_5 = self._id_F4C9;
  var_6 = _id_6E4E(var_5, self._id_109A3);
  var_7 = _id_6E4E(var_5, self._id_109A3 + 1);
  var_7 = (var_7[0], var_7[1], var_6[2]);
  var_4 = (var_4[0], var_4[1], var_6[2]);
  var_8 = vectornormalize(var_7 - var_6);
  var_9 = vectornormalize(var_4 - var_6);
  var_10 = vectordot(var_8, var_9);

  if(var_10 < 0.2588) {
    return 0;
  }

  return 1;
}

_id_363E(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C7D(var_1, self._id_109A4);
  return var_3;
}

_id_6D33(var_0) {
  return var_0 * var_0 * (3 - 2 * var_0);
}

_id_F037(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_0 + "_finished");

  if(var_1 > 0) {
    wait(var_1);
  }

  var_6 = var_2 / var_3;
  var_7 = self.origin[2];
  var_8 = var_7 + var_2[2];
  var_9 = self.origin[2];
  self _meth_82E8(var_4, var_5);

  for(var_10 = 0; var_10 < var_3; var_10++) {
    var_11 = 1;

    if(var_11) {
      var_12 = var_10 / (var_3 - 1);
      var_13 = _id_6D33(var_12);
      var_14 = var_8 * var_13 + var_7 * (1 - var_13);
      var_15 = var_14 - var_9;
      var_6 = (var_6[0], var_6[1], var_15);
      var_9 = var_14;
    }

    var_16 = self.origin + var_6;
    self _meth_80F9(var_16);

    if(var_10 + 1 < var_3) {
      waitframe();
    }
  }

  self _meth_82E8(var_4, 1);
}

_id_109BF(var_0, var_1) {
  if(var_0 == "start_jump") {
    thread _id_7463(var_1);
  } else if(var_0 == "end_mantle") {
    self _meth_8019("gravity");
  }
}

_id_7463(var_0, var_1, var_2) {
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = var_0[4];
  var_8 = var_0[5];
  var_9 = var_0[6];
  self endon(var_3 + "_finished");
  var_10 = _func_0079(var_4);

  if(!isDefined(var_1)) {
    var_1 = (gettime() - var_6) * 0.001;
  }

  var_11 = var_1 / var_10;
  var_12 = _func_00BB(var_4, "end_jump");
  var_13 = _func_00BB(var_4, "end_double_jump");

  if(var_13.size > 0) {
    self._id_109A5 = 1;
    var_12 = var_13;
  } else
    self._id_109A5 = 0;

  if(isDefined(self._id_8C97)) {
    var_7 = (var_12[0] - var_11) / 2 + var_11;
    var_12[0] = var_7;
    var_5 = self._id_8C97;
  }

  var_14 = _func_00B0(var_4, var_11, var_7);
  var_15 = self _meth_8216(var_14);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_9) {
    var_16 = distance(self.origin, var_15);
    var_17 = distance(self.origin, var_5);
    var_2 = var_16 / var_17;

    if(var_2 < 0.7) {
      var_2 = 0.7;
    } else if(var_2 > 1.3) {
      var_2 = 1.3;
    }
  }

  var_19 = var_5 - var_15;
  var_20 = var_12[0] * var_10;
  var_21 = var_20 - var_11 * var_10;
  var_21 = var_21 * (1 / var_2);
  var_22 = var_21 * 20;
  var_22 = _func_0037(var_22);
  var_23 = gettime();
  _id_F037(var_3, 0, var_19, var_22, var_4, var_2);

  if(isDefined(self._id_8C97)) {
    var_24 = (gettime() - var_23) * var_2;
    var_25 = var_1 + var_24 * 0.001;
    self._id_8C97 = undefined;
    var_0[6] = 0;
    _id_7463(var_0, var_25, var_2);
  }
}

_id_6E54(var_0) {
  var_1 = _id_6E4E(var_0, 1) - _id_6E4E(var_0, 0);
  var_2 = vectortoangles(var_1);
  return var_2[1];
}

_id_6E50(var_0) {
  self._id_109A3 = 0;
  var_1 = _id_6E4E(var_0, 1) - _id_6E4E(var_0, 0);
  var_2 = vectortoangles(var_1);
  self._id_109A6 = var_2[1];
  var_3 = _id_6E4E(var_0, self._id_109A3);
  var_4 = anglestoright(var_2);
  var_5 = var_3 - var_0.origin;
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0) {
    return "right";
  }

  return "left";
}

_id_D8C4() {
  if(isDefined(self._id_109A4)) {
    return;
  }
  if(!isDefined(self._id_F4C9)) {
    self._id_F4C9 = self _meth_8161();
    self._id_F4C7 = self _meth_8160();
  }

  var_0 = self._id_F4C9;
  self._id_109A4 = _id_6E50(var_0);
}

_id_6E4F() {
  _id_D8C4();
  return self._id_109A4;
}

_id_109C0(var_0, var_1, var_2) {
  self._id_109A3 = undefined;
  self._id_109A4 = undefined;
  self._id_109A5 = undefined;
  self._id_109A6 = undefined;
  self._id_109A2 = undefined;
  self _meth_8309();
  self._id_04C2 = 0;
  self._id_8C97 = undefined;
  self._id_F4C9 = undefined;
  self._id_F4C7 = undefined;
}

_id_F4D0(var_0, var_1, var_2) {
  if(!_id_0009::_id_1C50(var_0, "end") && !_id_0009::_id_1C50(var_0, "code_move")) {
    _id_38A6(var_0, var_1, var_2);
  }
}

_id_B91F(var_0, var_1, var_2) {
  self _meth_8019("noclip");
  self _meth_8251("face angle", self.angles[1]);
  self._id_04C2 = 1;

  if(isDefined(var_2) && var_2 == "shoot") {
    _id_D8C3();
  }

  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = _func_00BB(var_4, "wall_contact");
  var_6 = var_5[0];
  var_7 = _func_0077(var_4, 0, var_6);
  var_8 = self._id_109A6 - var_7;
  var_9 = (0, var_8, 0);
  self _meth_80F9(self.origin, var_9);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  var_10 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_6E4D(var_0) {
  var_1 = _id_363D(var_0, "wall_run_attach");
  var_2 = _func_00BB(var_1, "wall_contact");
  var_3 = var_2[0];
  var_4 = _func_00B0(var_1, 0, var_3);
  var_5 = _func_0077(var_1, 0, var_3);
  return _id_08F4::_id_2EB1(_id_6E4E(self._id_F4C9, 0), self._id_109A6, var_4, var_5);
}

_id_B922(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = self._id_F4C9;
  self._id_109A3 = 0;
  var_6 = _id_6E4E(var_5, 0);
  var_7 = var_6 - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectortoangles(var_7);
  var_9 = _id_6E4D();
  self _meth_8251("face angle", var_8[1]);
  var_10 = 1.0;
  var_11 = _func_00BB(var_4, "code_move");

  if(isDefined(var_11) && var_11.size > 0) {
    var_10 = var_11[0];
  }

  _id_B8CF(var_0, var_1, var_3, var_9, var_8, var_10, 0, 1);
  self _meth_80F9(var_9, var_8);
}

_id_B8CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon(var_1 + "_finished");

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  self _meth_80F9(self.origin, var_4);
  self _meth_8019("noclip");
  self _meth_8251("face angle", var_4[1]);
  var_8 = _id_0009::_id_1C6E(var_1, var_2);
  var_9 = _func_0079(var_8);
  var_10 = int(var_9 * 1000);
  self _meth_85BB(gettime() + var_10 - 1000);
  self._id_04C2 = 1;
  self _meth_85ED(var_1, var_2);
  _id_0009::_id_1C8E(var_0, var_1, var_8);
  var_11 = [var_1, var_8, var_3, gettime(), var_5, var_6, var_7];
  _id_0009::_id_1C45(var_0, var_1, ::_id_109BF, var_11);
}

_id_363D(var_0, var_1, var_2) {
  if(isDefined(self._id_109A2)) {
    return self._id_109A2;
  }

  var_3 = self._id_109A4;
  var_4 = _func_000B(self._id_109A6 - self.angles[1]);
  var_4 = abs(var_4);

  if(var_4 >= 22.5) {
    if(var_4 > 67.5) {
      var_3 = var_3 + "_90";
    } else {
      var_3 = var_3 + "_45";
    }
  }

  self._id_109A2 = _id_0009::_id_1C7D(var_1, var_3);
  return self._id_109A2;
}

_id_363F(var_0, var_1, var_2) {
  _id_D8C4();
  var_3 = self._id_109A4;
  var_4 = self._id_F4C9;
  var_5 = _id_6E4E(var_4, 0);
  var_6 = var_5[2] - self.origin[2];
  var_7 = 0;

  if(var_6 >= 0) {
    if(var_6 > 120) {
      var_7 = 1;
    }
  } else if(0 - var_6 > 240)
    var_7 = 1;

  if(var_7 == 0) {
    var_8 = distancesquared(self.origin, var_5);

    if(var_8 > 40000) {
      var_7 = 1;
    }
  }

  var_9 = "left_";

  if(self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_9 = "right_";
  }

  if(var_7) {
    var_3 = var_9 + "double_jump";
  } else {
    var_3 = var_9 + "single_jump";
  }

  var_10 = _id_0009::_id_1C7D(var_1, var_3);
  return var_10;
}

_id_D0BD(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  wait(var_2);
  _id_0009::_id_1C53(var_0, var_3);

  if(var_4) {
    self notify(var_3);
  }
}

_id_7537(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_109A3)) {
    return 0;
  }

  var_4 = self._id_F4C9;

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self._id_109A3 + 2;

  if(var_4._id_109A0._id_A576.size <= var_5) {
    return 0;
  }

  return 1;
}

_id_B920(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self._id_F4C9;
  _id_08F1::_id_D13B();
  self._id_109A3 = self._id_109A3 + 2;
  var_4 = _id_6E4E(var_3, self._id_109A3);
  var_5 = self.angles;

  if(self._id_109A4 == "left") {
    self._id_109A4 = "right";
  } else {
    self._id_109A4 = "left";
  }

  var_6 = _id_0009::_id_1C5C(var_0, var_1);
  _id_B8CF(var_0, var_1, var_6, var_4, var_5);
}

_id_6E52(var_0) {
  var_1 = var_0.angles - var_0._id_109A0._id_E6FC;

  if(var_1 == (0, 0, 0)) {
    return var_0.origin + var_0._id_109A0._id_9A55;
  }

  var_2 = rotatevector(var_0._id_109A0._id_9A55, var_1);
  return var_0.origin + var_2;
}

_id_6E51(var_0) {
  if(!isDefined(var_0._id_109A0._id_9A52)) {
    return undefined;
  }

  var_1 = var_0.angles[1] - var_0._id_109A0._id_E6FC[1];

  if(var_1 == 0) {
    return var_0._id_109A0._id_9A52;
  }

  return (0, _func_000B(var_0._id_109A0._id_9A52[1] + var_1), 0);
}

_id_6E53() {
  var_0 = self._id_F4C9;

  if(!isDefined(var_0._id_109A0._id_9A55)) {
    return "none";
  }

  var_1 = _id_6E52(var_0);

  if(var_1[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

_id_DC11(var_0, var_1, var_2, var_3) {
  var_4 = self._id_F4C9;

  if(!isDefined(var_4._id_109A0._id_2DE8)) {
    return 0;
  }

  return var_4._id_109A0._id_2DE8;
}

_id_B924(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self._id_F4C9;
  _id_D8C3();
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  var_6 = _func_00B0(var_5);
  var_7 = _func_0133(var_6);

  if(!isDefined(var_3._id_109A0._id_9A55) && self._id_109A3 == var_3._id_109A0._id_A576.size - 2) {
    var_8 = _id_0009::_id_1C5C(var_0, "wall_run_exit");
    var_9 = _id_0009::_id_1C6E("wall_run_exit", var_8);
    var_10 = _func_00BB(var_9, "start_jump");
    var_11 = _func_0079(var_9);
    var_12 = _func_00B0(var_9, 0, var_10[0]);
    var_13 = _func_0133(var_12);
  } else
    var_13 = 0;

  var_14 = _id_6E4E(var_3, self._id_109A3 + 1) - self.origin;
  var_15 = length(var_14);
  var_15 = var_15 - var_13;

  if(var_15 < 0) {
    var_15 = 0;
  }

  var_16 = var_15 / var_7;
  var_17 = _func_0079(var_5);
  var_18 = var_17 * var_16;
  thread _id_D0BD(var_0, var_1, var_18, "wall_run_loop_done", 1);
  var_19 = vectornormalize(var_14);
  self _meth_8251("face direction", var_19);
  thread _id_B921(var_1);
  self _meth_8019("noclip");
  self _meth_85ED(var_1, var_4);
  _id_0009::_id_1C8E(var_0, var_1, var_5);
  _id_0009::_id_1C45(var_0, var_1);
}

_id_B921(var_0) {
  self endon("death");

  if(_func_0205("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

_id_3640(var_0, var_1, var_2) {
  var_3 = self._id_109A4;
  var_4 = self._id_F4C7;
  var_5 = var_4[2] - self.origin[2];
  var_6 = 0;

  if(var_5 >= 0) {
    if(var_5 > 120) {
      var_6 = 1;
    }
  } else if(0 - var_5 > 240)
    var_6 = 1;

  if(var_6 == 0) {
    var_7 = distancesquared(self.origin, var_4);

    if(var_7 > 46225) {
      var_6 = 1;
    }
  }

  if(var_6) {
    var_3 = var_3 + "_double";
  }

  var_4 = self._id_F4C7;
  var_8 = self._id_F4C9;
  var_9 = self._id_F4C7 - _id_6E4E(var_8, var_8._id_109A0._id_A576.size - 1);
  var_9 = (var_9[0], var_9[1], 0);
  var_9 = vectornormalize(var_9);
  var_10 = vectortoangles(var_9);
  var_11 = _func_000B(var_10[1] - self.angles[1]);
  var_11 = abs(var_11);

  if(var_11 >= 22.5) {
    if(var_11 > 67.5) {
      var_3 = var_3 + "_90";
    } else {
      var_3 = var_3 + "_45";
    }
  }

  var_12 = _id_0009::_id_1C7D(var_1, var_3);
  return var_12;
}

_id_B923(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self._id_F4C9;
  var_4 = self._id_F4C7;
  var_5 = self.angles;
  var_6 = 1.0;
  var_7 = _id_0009::_id_1C5C(var_0, var_1);
  var_8 = _func_00BB(var_7, "ground");
  _id_08F1::_id_D13B();

  if(isDefined(var_8) && var_8.size > 0) {
    var_6 = var_8[0];
  } else {
    var_9 = _func_00BB(var_7, "end_double_jump");

    if(isDefined(var_9) && var_9.size > 0) {
      var_6 = var_9[0];
    } else {
      var_10 = _func_00BB(var_7, "end_jump");

      if(isDefined(var_10) && var_10.size > 0) {
        var_6 = var_10[0];
      }
    }
  }

  if(_func_0205("wallrun_end_npc")) {
    self playSound("wallrun_end_npc");
  }

  _id_B8CF(var_0, var_1, var_7, var_4, var_5, var_6, 1, 1);
  thread _id_F0A1(var_0, var_1);
}

_id_8951(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_F4C9)) {
    return 0;
  }

  return 1;
}

_id_F0A1(var_0, var_1) {
  self._id_109A3 = undefined;
  self._id_109A4 = undefined;
  self._id_109A5 = undefined;
  self._id_109A6 = undefined;
  self._id_109A2 = undefined;
  self _meth_8309();
  _id_F09F(var_0, var_1);
}

_id_B925(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self._id_F4C9;
  var_4 = self._id_F4C7;
  var_5 = _id_6E52(var_3);

  if(isDefined(var_3._id_109A0._id_2DE8) || _id_6E53() == "high") {
    var_6 = _id_6E51(var_3);

    if(!isDefined(var_6)) {
      var_7 = var_4 - var_5;
      var_7 = (var_7[0], var_7[1], 0);
      var_6 = vectortoangles(var_7);
    }
  } else {
    var_7 = var_5 - self.origin;
    var_7 = (var_7[0], var_7[1], 0);
    var_6 = vectortoangles(var_7);
  }

  var_8 = _id_0009::_id_1C5C(var_0, var_1);
  var_9 = _func_0079(var_8);
  var_10 = _func_00BB(var_8, "start_mantle");
  var_11 = var_10[0];
  var_12 = _func_00BB(var_8, "end_mantle");
  var_13 = var_12[0];
  var_14 = _func_00B0(var_8, var_11, var_13);
  self _meth_80F9(self.origin, var_6);
  var_15 = self _meth_8216(var_14);
  var_16 = var_15 - self.origin;
  var_17 = var_5 - var_16;
  _id_B8CF(var_0, var_1, var_8, var_17, var_6, var_11, 0, 1);
  thread _id_F0A1(var_0, var_1);
}

_id_B908(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);

  if(!isDefined(var_3)) {
    _id_0009::_id_1C53(var_0, "code_move");
    return;
  }

  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = 1.0;
  var_6 = undefined;

  if(getdvarint("#x3537642f87e9ab8eb", 1) == 1) {
    var_6 = _func_00BB(var_4, "align");
  }

  if(!isDefined(var_6) || var_6.size == 0) {
    var_6 = _func_00BB(var_4, "code_move");
  }

  if(isDefined(var_6) && var_6.size > 0) {
    var_5 = var_6[0];
  }

  var_7 = _func_00B0(var_4, 0, var_5);
  var_8 = _func_0077(var_4, 0, var_5);
  var_9 = self._id_F4C9;
  var_10 = _func_0079(var_4) * var_5;
  var_11 = int(_func_0037(var_10 * 20));

  if(self._id_F4C9._id_005D == "wall_run") {
    var_12 = _id_6E4E(self._id_F4C9, 0) - self.origin;
    var_13 = vectortoangles(var_12);
    var_14 = var_13[1];
  } else {
    var_15 = self._id_F4C7 - self._id_F4C9.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_16 = vectortoangles(var_15);
    var_14 = var_16[1];
  }

  var_17 = _id_08F4::_id_2EB1(var_9.origin, var_14, var_7, var_8);
  var_18 = var_14 - var_8;
  self._id_0DDF._id_1C03 = var_1;
  self._id_04C2 = 1;
  self _meth_83D9(var_17, var_18, var_11);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
}

_id_3641(var_0, var_1, var_2) {
  return _id_08FC::_id_361F(var_0, var_1, var_2);
}

_id_3636(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_3);

  if(self._id_F4C9._id_005D == "wall_run") {
    var_5 = vectortoangles(_id_6E4E(self._id_F4C9, 0) - self.origin);
  } else {
    var_6 = self._id_F4C7 - self._id_F4C9.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_5 = vectortoangles(var_6);
  }

  var_7 = var_5[1];
  var_8 = _func_000B(var_7 - var_4[1]);
  var_9 = _func_0326(var_8, 22.5);
  var_10 = _id_08F3::_id_6D90(var_0, var_1, undefined, 1);

  if(!isDefined(var_10[var_9])) {
    return undefined;
  }

  return var_10[var_9];
}

_id_38A6(var_0, var_1, var_2, var_3) {
  self._id_F4C9 = undefined;
  self._id_F4C7 = undefined;
  self._id_109A4 = undefined;
  return 0;
}

_id_DAF5(var_0, var_1, var_2, var_3) {
  var_4 = distance2dsquared(self.origin, _id_6E4E(self._id_F4C9, 1));

  if(var_4 < 144) {
    return 1;
  }

  return 0;
}

_id_DB48(var_0, var_1, var_2, var_3) {
  if(_id_8951(var_0, var_1, var_2, var_3)) {
    _id_06C2::_id_D8BC(var_0, var_1, var_2, var_3);

    if(!isDefined(self._id_F4C9)) {
      return 0;
    }

    if(self._id_F4C9._id_005D != "wall_run") {
      return 0;
    }

    var_4 = self._id_F4C9;
    var_5 = vectornormalize(_id_6E4E(var_4, 0) - self.origin);
    var_6 = _id_08FC::_id_2EF9(var_0, var_1, var_2, var_5, 0, 1);

    if(!isDefined(var_6)) {
      return 0;
    }

    self._id_0DDF._id_D9BC = var_6;
    self._id_109A4 = _id_6E50(self._id_F4C9);
    return 1;
  }

  return 0;
}

_id_DBFE(var_0, var_1, var_2, var_3) {
  if(var_2 == self._id_F4C9._id_005D) {
    return 1;
  }

  return 0;
}

_id_8AAD(var_0) {
  switch (var_0) {
    case "rail_hop_double_jump_down":
    case "wall_run":
    case "double_jump_vault":
    case "double_jump":
    case "double_jump_mantle":
      return 1;
  }

  return 0;
}

_id_DB47(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_F4C9)) {
    return 0;
  }

  if(!_id_8AAD(self._id_F4C9._id_005D)) {
    return 0;
  }

  if(!self._id_01B7) {
    return 0;
  }

  var_4 = undefined;

  if(self._id_F4C9._id_005D == "wall_run") {
    var_4 = _id_6E50(self._id_F4C9);
    var_5 = _id_6E4E(self._id_F4C9, 0) - self.origin;
    var_6 = vectortoangles(var_5);
  } else {
    var_5 = self._id_F4C7 - self._id_F4C9.origin;
    var_5 = (var_5[0], var_5[1], 0);
    var_4 = vectornormalize(var_5);
    var_6 = vectortoangles(var_4);
  }

  var_7 = var_6[1];
  var_8 = anglesToForward(self.angles);
  var_9 = vectortoangles(var_8);
  var_10 = _func_000B(var_7 - var_9[1]);
  var_11 = _func_0326(var_10, 22.5);
  var_12 = _id_08F3::_id_6D90(var_0, var_2, undefined, 1);
  var_13 = var_12[var_11];

  if(!isDefined(var_13)) {
    return 0;
  }

  var_14 = 1.0;
  var_15 = undefined;

  if(getdvarint("#x3537642f87e9ab8eb", 1) == 1) {
    var_15 = _func_00BB(var_13, "align");
  }

  if(!isDefined(var_15) || var_15.size == 0) {
    var_15 = _func_00BB(var_13, "code_move");
  }

  if(isDefined(var_15) && var_15.size > 0) {
    var_14 = var_15[0];
  }

  var_16 = _func_00B0(var_13, 0, var_14);
  var_17 = _func_0077(var_13, 0, var_14);
  var_18 = distance2d(self.origin, self._id_F4C9.origin);
  var_19 = length(var_16);
  var_20 = var_18 - var_19;

  if(var_20 < 0) {
    var_21 = anglesToForward(var_6);
    var_22 = vectordot(var_8, var_21);

    if(var_22 > 0.707) {
      if(abs(var_20) > 10) {
        return 0;
      }
    } else if(abs(var_20) > 64)
      return 0;
  } else if(var_20 > 10)
    return 0;

  if(self._id_F4C9._id_005D == "wall_run") {
    self._id_109A4 = var_4;
  }

  return 1;
}

_id_74AB(var_0) {
  if(var_0 == "wall_contact") {
    if(_func_0205("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
    }
  }
}

_id_D8C3() {
  self._id_04BE = -45;
  self._id_0185 = 45;
  self._id_0377 = -90;
  self._id_0275 = 90;
}

_id_B90D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self _meth_8161();
  var_4 = self _meth_8160();
  self _meth_8019("noclip", 0);
  self _meth_8251("face angle", var_3.angles[1]);
  var_5 = var_4 - var_3.origin;
  var_6 = _id_0009::_id_1C61();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(var_5[2] > 0) {
    var_10 = "off_" + var_6;
    var_9 = _id_0009::_id_1C7E(var_1, var_10);

    if(!isDefined(var_9)) {
      var_9 = _id_0009::_id_1C7D(var_1, "off");
    }

    var_7 = _id_0009::_id_1C7D(var_1, "up");
  } else {
    var_11 = "on_" + var_6;
    var_9 = _id_0009::_id_1C7E(var_1, var_11);

    if(!isDefined(var_9)) {
      var_8 = _id_0009::_id_1C7D(var_1, "on");
    }

    var_7 = _id_0009::_id_1C7D(var_1, "down");
  }

  var_12 = 1;

  if(isDefined(self._id_A246)) {
    var_12 = self._id_A246;
  }

  if(isDefined(var_8)) {
    self _meth_85ED(var_1, var_8, var_12);
    _id_0009::_id_1C45(var_0, var_1);
  }

  var_13 = var_4;

  if(isDefined(var_9)) {
    var_14 = _id_0009::_id_1C6E(var_1, var_9);
    var_15 = _func_00B0(var_14);
    var_13 = var_4 - var_15 + (0, 0, 1);
  }

  var_16 = var_13 - self.origin;

  if(var_16[2] * var_5[2] > 0) {
    var_17 = _id_0009::_id_1C6E(var_1, var_7);
    var_18 = _func_00B0(var_17);
    var_19 = var_18[2] * var_12 / _func_0079(var_17);
    var_20 = var_16[2] / var_19;
    self _meth_85ED(var_1, var_7, var_12);
    _id_0009::_id_1C46(var_0, var_1, var_20);
  }

  if(isDefined(var_9)) {
    self _meth_85ED(var_1, var_9, var_12);
    _id_0009::_id_1C45(var_0, var_1);
  }

  _id_F09F(var_0, var_1);
}

_id_F087(var_0, var_1, var_2) {
  self._id_A588 = !isalive(self);
}

_id_F4D4(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_8019("noclip", 0);
  var_4 = self _meth_8161();
  self _meth_8251("face angle", var_4.angles[1]);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  _id_F09F(var_0, var_1);
}

_id_F09F(var_0, var_1) {
  self._id_04C2 = 0;
  self._id_8AAE = 0;
  self._id_8C97 = undefined;
  self._id_F4C9 = undefined;
  self._id_F4C7 = undefined;
  _id_0009::_id_1C53(var_0, "traverse_end");
  self _meth_85F9();
  self _meth_85FC();
}