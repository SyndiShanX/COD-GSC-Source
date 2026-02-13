/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2291.gsc
*************************************************/

_id_A6BD(var_0, var_1, var_2, var_3) {
  return !_id_DBE3(var_0, var_1, var_3);
}

_id_6B38(var_0) {
  return 256.0;
}

_id_DBE3(var_0, var_1, var_2, var_3) {
  if(!self _meth_884B()) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  var_4 = _id_08F1::_id_68D8();

  if(!_id_0009::_id_1C50(var_0, "cover_approach")) {
    return 0;
  }

  if(isDefined(var_3)) {
    if(!_func_0107(var_3)) {
      var_5 = var_3;
    } else if(var_3.size < 1) {
      var_5 = "Exposed";
    } else {
      var_5 = var_3[0];
    }
  } else
    var_5 = "Exposed";

  if(!_id_08F1::_id_8764(var_0, var_1, var_2, var_5)) {
    return 0;
  }

  var_6 = distance(self.origin, self._id_0323);
  var_7 = _id_6B38(var_5);

  if(var_6 > var_7) {
    return 0;
  }

  var_8 = 0;

  if(isDefined(var_3) && var_3.size > 1) {
    var_8 = int(var_3[1]);
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_5 == "Exposed Moving") {
    var_11 = "code_move";
  }

  var_12 = _id_0009::_id_1C61();

  if(var_12 == "casual" || var_12 == "casual_gun" || var_12 == "patrol") {
    var_13 = 0.053;

    if(self _meth_8473() < 25.0) {
      var_13 = 2.0;
    }

    self._id_1C30._id_E906 = _id_2EFD(var_0, var_1, var_2, var_5, var_8, undefined, var_9, var_13, undefined, var_10, var_11);
  } else
    self._id_1C30._id_E906 = _id_2EFD(var_0, var_1, var_2, var_5, var_8, undefined, var_9, undefined, undefined, var_10, var_11);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_DBEB(var_0, var_1, var_2, var_3) {
  if(!_id_0009::_id_1C50(var_0, "code_move")) {
    return 0;
  }

  return _id_DBEA(var_0, var_1, var_2, var_3);
}

_id_DBEA(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();

  if(!isDefined(var_3) || var_4 != var_3[2]) {
    return 0;
  }

  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_DBED(var_0, var_1, var_2, var_3) {
  if(!_id_0009::_id_1C50(var_0, "code_move")) {
    return 0;
  }

  return _id_DBEC(var_0, var_1, var_2, var_3);
}

_id_DBEC(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();

  if(!isDefined(var_3) || var_4 != var_3[2]) {
    return 0;
  }

  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_AF4F() {
  var_0 = _id_08F1::_id_68D8();

  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0._id_AF43)) {
    return 1;
  }

  return var_0._id_AF43;
}

_id_DBE8(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23D5()) {
    return 0;
  }

  if(!_id_AF4F()) {
    return 0;
  }

  if(isDefined(self._id_0B67.doortoopen)) {
    return 0;
  }

  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_35A5(var_0, var_1, var_2) {
  return self._id_1C30._id_E906;
}

calculatefootprefix(var_0, var_1, var_2) {
  var_3 = "";

  if(var_1) {
    var_4 = "left";

    if(_id_0009::_id_1C51(var_0, "pass_left")) {
      var_4 = "left";
    } else if(_id_0009::_id_1C51(var_0, "pass_right")) {
      var_4 = "right";
    } else if(self._id_1C30._id_5E3A._id_5E36 == "right") {
      var_4 = "right";
    }

    if(isDefined(var_2)) {
      var_3 = var_2 + var_4;
    } else {
      var_3 = var_4;
    }
  } else
    var_3 = var_2;

  return var_3;
}

_id_2EFD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _id_08F1::_id_68D8();

  if(isDefined(var_12) && !self _meth_84C1() && isDefined(self._id_03B1) && self._id_03B1 == var_12) {
    if(distance2dsquared(self._id_03B1.origin, self._id_0323) > 4096) {
      if(!isDefined(self._id_03B1._id_2EFE) || self._id_03B1._id_2EFE < gettime() - level._id_01E2) {
        self._id_03B1._id_2EFE = gettime();
      } else {
        self._id_03B1 delete();
        self._id_03B1 = undefined;
        var_12 = _id_08F1::_id_68D8();
      }
    }
  }

  var_13 = undefined;

  if(isDefined(var_12)) {
    var_13 = var_12.origin;
  } else {
    var_13 = self._id_0323;
  }

  var_14 = var_13 - self.origin;
  var_14 = vectornormalize((var_14[0], var_14[1], 0));
  var_15 = vectordot(var_14, anglesToForward(self.angles));

  if(var_15 < 0) {
    return undefined;
  } else if(var_15 < 0.707) {
    if(!isDefined(var_7)) {
      var_7 = 0.106;
    }

    if(!isDefined(var_8)) {
      var_8 = 0.7;
    }
  }

  if(var_3 == "Custom") {
    var_2 = self._id_1C30._id_426A._id_1C10;
    var_4 = self._id_1C30._id_426A._id_1C15;
  }

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  var_17 = calculatefootprefix(var_0, var_4, var_6);
  var_18 = _id_08F1::_id_A57B(var_12);
  var_19 = undefined;
  var_20 = undefined;

  if((var_3 == "Exposed" || var_3 == "Exposed Crouch") && (scripts\anim\utility_common::_id_C0F9() || _id_08F1::_id_03D3() || isDefined(self._id_0192))) {
    if(!_id_06BD::_id_240F() && !isDefined(self._id_03DC)) {
      if(isDefined(var_12) && isDefined(var_12.angles)) {
        var_19 = var_12.angles[1];
        var_20 = var_12.angles;
        var_18 = 1;
      } else
        var_18 = 0;
    } else {
      var_21 = _id_0900::_id_6E0B();
      var_20 = (0, self.angles[1] + var_21, 0);
      var_19 = var_20[1];
      var_18 = 1;
    }
  } else if(var_18) {
    var_19 = _id_08F1::_id_6B9D(var_12, undefined, 0);
    var_20 = var_12.angles;
  }

  var_22 = self _meth_856B(var_13, var_20, _id_69B5(), var_5, var_18, var_2, var_19, var_17, var_6, var_7, var_8, var_3, var_9, var_10, var_11);
  return var_22;
}

calculatesuppressionstopdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self._id_0B67._id_015F;
  var_13 = var_12 - self.origin;
  var_14 = getdvarfloat("#x318a57b1ef000923b") + 1;
  var_15 = var_14 * var_14;

  if(_func_0135(var_13) > var_15) {
    return undefined;
  }

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  var_16 = calculatefootprefix(var_0, var_4, var_6);
  var_17 = 0;
  var_18 = undefined;
  var_19 = undefined;
  var_8 = 0;
  var_20 = self _meth_856B(var_12, var_18, undefined, var_5, var_17, var_2, var_19, var_16, var_6, var_7, var_8, var_3, var_9, var_10, var_11);

  if(isDefined(var_20)) {
    var_20._id_427C = var_12;
  }

  return var_20;
}

_id_B349(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");
  self waittill("path_set");
  _id_0009::_id_1C53(var_0, "abort");
}

_id_B348(var_0, var_1) {
  self endon("runto_arrived");
  self endon(var_1 + "_finished");

  for(;;) {
    if(!isDefined(self._id_0323)) {
      break;
    }

    wait 0.05;
  }

  _id_0009::_id_1C53(var_0, "abort");
}

_id_1C13(var_0, var_1, var_2) {
  self _meth_85FC();
  self _meth_8616();

  if(_id_AF4F()) {
    var_3 = _id_08F1::_id_68D8();
    var_4 = self;

    if(_id_08F1::_id_A57B(var_3)) {
      var_4 = var_3;
    }

    self _meth_8251("face angle", var_4.angles[1]);
  }
}

_id_1C14(var_0) {
  self endon("death");
  self._id_1C30._id_0063 = var_0;
  self waittill(var_0 + "_finished");
  self._id_1C30._id_0063 = undefined;
}

_id_5B12(var_0, var_1, var_2) {
  self _meth_85FC();
  self _meth_8616();
}

_id_B31F(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_1C30._id_1C12 = 0;
  var_4 = _func_00B0(var_2, 0.0, 1.0);
  var_5 = _func_0079(var_2);
  var_6 = 0.05 / var_5;

  for(var_7 = 1.0 - var_6; var_7 > 0.0; var_7 = var_7 - var_6) {
    var_8 = _func_00B0(var_2, 0.0, var_7);

    if(_func_0135(var_4 - var_8) >= 64) {
      break;
    }
  }

  var_9 = var_7 * var_5 / var_3;
  wait(var_9);
  self._id_1C30._id_1C12 = 1;
}

_id_C79A(var_0) {
  if(var_0 == "corner") {
    return 1;
  }
}

_id_C79B(var_0) {
  if(var_0 == "warp_arrival_start") {
    return 1;
  }
}

_id_2EDD(var_0, var_1) {
  var_2 = 64;
  var_3 = 110;

  if(var_1 >= var_2 && var_1 <= var_3) {
    var_4 = (var_1 - var_2) / (var_3 - var_2);
    var_5 = self _meth_864B();
    return (1 - var_4) * var_5 + var_4 * var_0;
  }

  return var_0;
}

_id_B31D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 1.0;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  self._id_1C30._id_1C03 = var_1;
  self._id_0DDF._id_1C03 = var_1;
  thread _id_1C14(var_1);
  var_4 = _id_0009::_id_1C5C(var_0, var_1);

  if(!isDefined(var_4)) {
    self _meth_8251("face motion");
    _id_0009::_id_1C53(var_0, "abort", undefined);
    return;
  }

  self _meth_8251("face angle", self.angles[1]);
  var_5 = var_4._id_01BF;
  var_6 = var_4._id_0053;
  var_7 = (0, var_5[1] - var_4._id_0052, 0);
  var_8 = var_4._id_0405;
  var_9 = var_7[1];

  if(isDefined(var_4._id_0319) && isDefined(var_4._id_0316)) {
    var_10 = var_4._id_0405 - var_4._id_0319;
    var_10 = _func_01C8(var_10, var_4._id_0316);
    var_11 = _func_00FF(var_4._id_0316);
    var_12 = _func_0047(var_7, var_11);
    var_13 = self _meth_84AA();
    var_10 = rotatevector(var_10, var_13.angles);
    var_8 = var_10 + var_13.origin;
    var_14 = _func_0047(var_12, var_13.angles);
    var_9 = var_14[1];
  }

  var_15 = var_1;

  if(isDefined(self._id_1C30._id_426A) && isDefined(self._id_1C30._id_426A._id_1C10)) {
    var_15 = self._id_1C30._id_426A._id_1C10;
  }

  var_16 = var_4._id_040F;
  var_17 = _id_0009::_id_1C6E(var_15, var_16);
  var_18 = _id_08F1::_id_68D8();

  if(isDefined(var_4._id_427C)) {
    var_19 = var_4._id_427C;
  } else if(isDefined(var_18)) {
    var_19 = var_18.origin;
  } else {
    var_19 = self._id_0323;
  }

  if(!istrue(var_4._id_2C55)) {
    self _meth_83D9();
  }

  if(_func_0011(var_17, "code_move")) {
    self _meth_8019("zonly_physics", 0);
    var_20 = scripts\engine\utility::_id_A1BC(var_17, var_19, var_4._id_01BF, undefined, "corner", undefined);
    self _meth_85ED(var_15, var_16, var_20);
    _id_0009::_id_1C45(var_0, var_1, ::_id_C79A, undefined, var_15);
    self _meth_85ED(var_15, var_16, 1);
    _id_0009::_id_1C45(var_0, var_1, undefined, undefined, var_15);
    return;
  }

  if(isDefined(self._id_1C30._id_426A._id_4223)) {
    var_21 = self._id_1C30._id_426A._id_4223;
    self _meth_8019(var_21);
  } else
    self _meth_8019("zonly_physics", 0);

  _id_0009::_id_1C8E(var_0, var_1, var_17);
  var_22 = 1.0;

  if(isDefined(var_19)) {
    var_23 = length(var_4._id_02D4);
    var_24 = length(self.origin - var_19);

    if(var_24 > 1.0) {
      var_22 = var_23 / length(self.origin - var_19);
    }

    var_22 = clamp(var_22, 0.8, 1.3);
  }

  var_25 = var_3 * var_22;

  if(isDefined(self._id_1C0C)) {
    var_25 = var_25 * self._id_1C0C;
  }

  if(isDefined(self._id_1C0D) && isDefined(self._id_1C06) && _id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_25 = self._id_1C06 / self._id_1C0D;
    self._id_1C06 = undefined;
    var_26 = 0.8;
    var_25 = max(var_26, var_25);
  }

  thread _id_B31F(var_0, var_1, var_17, var_25);
  self _meth_85ED(var_15, var_16, var_25);
  var_27 = 1.0;

  if(_func_0011(var_17, "warp_arrival_start")) {
    var_28 = _func_00BB(var_17, "warp_arrival_start");
    var_29 = _func_00BB(var_17, "warp_arrival_end");

    if(var_28[0] > 0.0) {
      _id_0009::_id_1C45(var_0, var_1, ::_id_C79B, undefined, var_15, 0);
    }

    var_30 = _func_0079(var_17);
    var_31 = var_28[0];

    if(var_31 > 0) {
      var_31 = var_28[0] * var_30 * 1000;
      var_31 = var_31 - scripts\engine\utility::_id_9FC4(int(var_31), level._id_01E2);
      var_31 = var_31 / var_30 / 1000;
    }

    var_27 = var_29[0];
    var_32 = int((var_27 - var_31) * var_30 / var_25 * 1000.0);
    var_32 = var_32 + (level._id_01E2 - scripts\engine\utility::_id_9FC4(var_32, level._id_01E2));
    scripts\engine\utility::_id_A1BD(var_17, var_19, var_4._id_01BF, var_31, 1.0, var_32, 0);
  } else {
    var_33 = 500;

    if(_func_0011(var_17, "start_aim")) {
      var_27 = _func_00BB(var_17, "start_aim")[0];
      var_34 = _func_0079(var_17);
      var_33 = int(var_27 * var_34 / var_25 * 1000);

      if(var_33 < 300 && var_34 / var_25 >= 0.15) {
        var_33 = 300;
      }
    }

    self _meth_85FB(var_8, var_7, var_19, var_4._id_01BF, var_33);
  }

  if(!isagent(self)) {
    var_35 = _id_0009::_id_1C7E(var_1, "conceal_add");

    if(isDefined(var_35) && isDefined(var_18) && isDefined(var_18.type) && (var_18.type == "Conceal Crouch" || var_18.type == "Conceal Stand")) {
      var_36 = _id_0009::_id_1C6E(var_1, var_35);
      var_30 = _func_0079(var_17);
      var_37 = var_30 * var_27 * 0.3;
      thread _id_08F4::_id_E5BF(var_1, var_36, var_37);
    }
  }

  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1), undefined, var_15);
  self._id_0DDF._id_A235 = "stop";
}

_id_69B5() {
  if(isDefined(self._id_1C30._id_426A._id_1C02)) {
    return self._id_1C30._id_426A._id_1C02;
  }

  return undefined;
}

_id_6D90(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[5] = _id_0009::_id_1C7F(1, var_0, var_1, var_3, var_4);
  var_5[4] = _id_0009::_id_1C7F(2, var_0, var_1, var_3, var_4);
  var_5[3] = _id_0009::_id_1C7F(3, var_0, var_1, var_3, var_4);
  var_5[6] = _id_0009::_id_1C7F(4, var_0, var_1, var_3, var_4);
  var_5[2] = _id_0009::_id_1C7F(6, var_0, var_1, var_3, var_4);
  var_5[7] = _id_0009::_id_1C7F(7, var_0, var_1, var_3, var_4);
  var_5[0] = _id_0009::_id_1C7F(8, var_0, var_1, var_3, var_4);
  var_5[1] = _id_0009::_id_1C7F(9, var_0, var_1, var_3, var_4);
  var_5[8] = var_5[0];
  return var_5;
}

_id_DBE7(var_0, var_1, var_2, var_3) {
  var_4 = "Custom";
  var_5 = distance(self.origin, self._id_0323);
  var_6 = _id_6B38(var_4);

  if(var_5 > var_6) {
    return 0;
  }

  var_7 = 0;

  if(isDefined(self._id_1C30._id_426A._id_1C15)) {
    var_7 = self._id_1C30._id_426A._id_1C15;
  }

  var_8 = _id_0009::_id_1C64(var_0, "cover_approach");
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = "";
  var_13 = undefined;

  if(isDefined(self._id_1C30._id_426A._id_1C0A)) {
    var_13 = self._id_1C30._id_426A._id_1C0A;
  }

  self._id_1C30._id_E906 = _id_2EFD(var_0, var_1, self._id_1C30._id_426A._id_1C10, var_4, var_7, var_8, var_13, var_11, undefined, var_9, var_10, var_12);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_DBE6(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(!_func_0107(var_3)) {
      var_4 = var_3;
    } else if(var_3.size < 1) {
      var_4 = "Exposed";
    } else {
      var_4 = var_3[0];
    }
  } else
    var_4 = "Exposed";

  var_5 = self _meth_871F();

  if(!isDefined(var_5)) {
    return 0;
  }

  if(isDefined(var_5["desiredspeed"])) {
    self._id_1C06 = var_5["desiredspeed"];
  }

  if(isDefined(var_5["targetspeed"])) {
    self._id_1C0D = var_5["targetspeed"];
  } else {
    self._id_1C0D = undefined;
  }

  var_6 = "";

  if(isDefined(var_5["speed"])) {
    var_6 = var_5["speed"];
  }

  var_7 = 0;

  if(isDefined(var_3) && _func_0107(var_3) && var_3.size >= 2) {
    var_7 = 1;
  }

  var_8 = _id_0009::_id_1C64(var_0, "cover_approach");
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_4 == "Exposed Moving") {
    var_10 = "code_move";
    var_11 = 0.07;
  }

  self._id_1C30._id_E906 = _id_2EFD(var_0, var_1, var_2, var_4, var_7, var_8, undefined, var_11, undefined, var_9, var_10, var_6);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_DBE4(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_DBE5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || var_3.size < 1) {
    var_4 = "Exposed";
  } else {
    var_4 = var_3[0];
  }

  if(!_id_08F1::_id_8765(var_0, var_4)) {
    return 0;
  }

  var_5 = distance(self.origin, self._id_0323);
  var_6 = _id_6B38(var_4);

  if(var_5 > var_6) {
    return 0;
  }

  var_7 = 0;

  if(isDefined(var_3) && var_3.size >= 2) {
    var_7 = 1;
  }

  var_8 = _id_0009::_id_1C64(var_0, "cover_approach");
  var_9 = "";
  var_10 = _id_06BD::_id_23BA();

  if(var_10 == "panic" || var_10 == "stealth" || var_10 == "casual") {
    var_11 = length(self._id_04DF);
    var_12 = self _meth_87CE();
    var_9 = _func_03A6(var_12, var_11);
    self._id_1C0D = _func_03A5(var_12, var_9);
  } else
    self._id_1C0D = undefined;

  var_13 = 0.053;

  if(self _meth_8473() < 25.0) {
    var_13 = 2.0;
  }

  self._id_1C30._id_E906 = _id_2EFD(var_0, var_1, var_2, var_4, var_7, var_8, undefined, var_13, 0.3, undefined, undefined, var_9);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

calcsuppressionarrivaltype(var_0, var_1, var_2) {
  var_3 = randomfloat(1);

  if(var_3 < 0.75) {
    self.suppressionarrivaltype = "Exposed Crouch";
  } else {
    self.suppressionarrivaltype = "Exposed";
  }
}

shoulddosuppressionstoparrival(var_0, var_1, var_2, var_3) {
  return self _meth_81D5();
}

shouldstartsuppressionstoparrival(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_4 = "Exposed Crouch";
  } else {
    var_4 = var_3;
  }

  if(self.suppressionarrivaltype != var_4) {
    return 0;
  }

  var_5 = 1;
  var_6 = "";
  var_7 = self _meth_8644();
  var_8 = self _meth_87CE();
  var_6 = _func_03A6(var_8, var_7);
  self._id_1C0D = _func_03A5(var_8, var_6);
  var_9 = undefined;
  self._id_1C30._id_E906 = calculatesuppressionstopdata(var_0, var_1, var_2, var_4, var_5, undefined, undefined, var_9, 0.3, undefined, undefined, var_6);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_F486(var_0, var_1, var_2, var_3) {
  return self._id_1C30._id_1C12;
}

_id_35C4(var_0, var_1, var_2) {
  var_3 = "left";

  if(_id_0009::_id_1C51(var_0, "pass_left")) {
    var_3 = "left";
  } else if(_id_0009::_id_1C51(var_0, "pass_right")) {
    var_3 = "right";
  } else if(self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_3 = "right";
  }

  var_4 = "shuffle";
  var_5 = 0;
  var_6 = _id_08F1::_id_68D8();
  var_7 = _id_08F1::_id_A57B(var_6);
  var_8 = 6400.0;

  if(scripts\anim\utility_common::_id_C0F9() || !isDefined(self._id_0192)) {
    var_5 = _id_0900::_id_6E0B();
  } else if(var_7 && _func_0134(var_6.origin - self.origin) < var_8) {
    var_5 = _id_08F1::_id_6B9D(var_6) - self.angles[1];
  } else if(istrue(self._id_159A)) {
    var_9 = 0;

    if(_func_011D(self._id_0192)) {
      var_9 = self _meth_861A(self._id_0192);
    } else {
      var_9 = _func_0402(self.origin, self._id_0192.origin);
    }

    if(var_9) {
      var_5 = _func_0261(self._id_0192.origin - self.origin);
    }
  }

  var_5 = _func_000B(var_5);

  if(_id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_10 = self _meth_864B();
    var_11 = self _meth_87CE();
    var_4 = _func_03A6(var_11, var_10);
  }

  var_12 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var_13 = _func_0326(var_5, 22.5);
  var_14 = var_3 + var_12[var_13] + var_4;
  return _id_0009::_id_1C7D(var_1, var_14);
}

_id_B34B(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_8762();
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = 1.0;
  self _meth_85ED(var_1, var_3, var_5);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  self _meth_8474();
}

_id_B34C(var_0, var_1, var_2) {
  self _meth_8763();
}

_id_2EB2(var_0, var_1, var_2) {
  self._id_0B67._id_0382 = _id_68D9();
}

_id_68D9() {
  if(isDefined(self._id_1C30._id_426A._id_1C10)) {
    return "Custom";
  }

  if(_id_06BD::_id_2413()) {
    return "Exposed";
  }

  var_0 = _id_08F1::_id_68D8();

  if(isDefined(var_0) && isDefined(self._id_03B1) && isDefined(self._id_03B1.type) && var_0 == self._id_03B1) {
    return self._id_03B1.type;
  }

  if(!isDefined(var_0) || !_func_02E1(var_0) || !isDefined(var_0.type) || var_0.type == "struct" || self._id_010D == "no_cover") {
    var_1 = self _meth_875D();

    if(isDefined(var_1)) {
      var_2 = _id_0009::_id_1C61();
      var_3 = self _meth_81E8("crouch") && var_2 == "combat";

      if(var_3 && _id_08F1::_id_35E1(self, var_1)) {
        return "Exposed Crouch";
      }

      return "Exposed";
    }

    if(_id_06BD::_id_23C7() == "crouch" || _id_08F1::_id_885F() && self _meth_81E8("crouch")) {
      return "Exposed Crouch";
    }

    return "Exposed";
  }

  if(isDefined(self._id_0192) && _id_08F1::_id_87C8(var_0) || _id_08F1::_id_03D3(var_0)) {
    if(var_0 _meth_80B9("stand") && self _meth_81E8("stand")) {
      return "Exposed";
    } else if(var_0 _meth_80B9("crouch") && self _meth_81E8("crouch")) {
      return "Exposed Crouch";
    } else {
      return "Cover Prone";
    }
  }

  if(_func_02E1(var_0) && var_0 _meth_80BB()) {
    var_4 = scripts\engine\utility::_id_690C(var_0);

    if(isDefined(var_4) && var_4 != var_0.type) {
      var_0 _meth_80BA(var_4);
    }
  }

  var_5 = var_0.type;
  var_6 = _id_08F1::_id_15C0();

  if(var_6) {
    var_7 = 1;

    if(isDefined(self._id_0192)) {
      var_7 = enemyiswithinmountedlmgaimcone(var_0);
    }

    if(var_7) {
      switch (var_5) {
        case "Cover Prone":
        case "Cover Crouch":
          return "Cover Crouch LMG";
        case "Cover Stand":
          return "Cover Stand LMG";
      }
    }
  }

  if(isDefined(self._id_0B67._id_012D) && !var_6) {
    return self._id_0B67._id_012D;
  }

  return self _meth_86AB(var_0, var_5);
}

enemyiswithinmountedlmgaimcone(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self _meth_884D();
    var_2 = self _meth_815B();
  } else {
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  }

  var_3 = self _meth_886A(var_1);

  if(isDefined(var_3)) {
    var_4 = vectortoangles(var_3._id_DA32 - var_1);
    var_5 = _func_043F(var_2[1] - var_4[1]);

    if(var_5 > anim._id_135D) {
      return 0;
    }
  }

  return 1;
}