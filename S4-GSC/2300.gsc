/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2300.gsc
*************************************************/

_id_B32B(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self._id_1C30._id_426A._id_5792 = undefined;

  if(isDefined(self._id_237D) && self._id_237D) {
    var_4 = issubstr(var_1, "cover");
    thread _id_A225(var_4);
  }

  if(!isDefined(var_3)) {
    var_5 = self _meth_8644();
    var_6 = 50.0;

    if(var_6 > var_5) {
      var_6 = 0.5 * var_5;
    }

    self _meth_8649(var_6);
    _id_0009::_id_1C53(var_0, "abort");
    _id_0009::_id_1C53(var_0, "code_move");
    _id_0009::_id_1C53(var_0, "end");
    _id_0009::_id_1C53(var_0, "finish");
    return;
  }

  thread _id_08F1::_id_10800(var_0, var_1, 1);
  var_7 = 0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  _id_B8F8(var_0, var_1, var_3, var_7);

  if(isDefined(self._id_578F) && _id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    self _meth_8649(float(self._id_578F));
  }
}

_id_35AB(var_0, var_1, var_2) {
  if(!_id_3569()) {
    return undefined;
  }

  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_3 = _id_48B0(var_1, var_4);
  return var_3;
}

_id_48A7() {
  var_0 = 70.0;
  var_1 = self _meth_864C(var_0);

  if(self._id_00DD) {
    var_1 = 90;
  }

  return var_1;
}

_id_35AC(var_0, var_1, var_2) {
  var_3 = "";

  if(_id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_4 = _id_48A7();
    var_5 = self _meth_87CE();
    var_3 = _func_03A7(var_5, var_4);
    self._id_578F = _func_03A5(var_5, var_3);
  } else
    self._id_578F = undefined;

  if(!_id_3569()) {
    return undefined;
  }

  var_6 = undefined;
  var_7 = 0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  var_6 = _id_48B0(var_1, var_7, var_3);
  return var_6;
}

_id_6D84(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_4 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  var_5 = var_4[var_2];

  if(!isDefined(var_5)) {
    var_5 = 8;
  }

  if(var_5 == 8) {
    if(var_3 < 0) {
      var_7 = var_5 + "r" + var_1;
    } else {
      var_7 = var_5 + "l" + var_1;
    }
  } else
    var_7 = var_5 + var_1;

  return _id_0009::_id_1C7E(var_0, var_7);
}

_id_6D86() {
  var_0 = _id_0009::_id_1C61();

  if(var_0 == "casual" || var_0 == "casual_gun" || self _meth_8644() <= 60) {
    return 75.0;
  }

  return 100.0;
}

_id_48B0(var_0, var_1, var_2) {
  var_3 = self _meth_8161();

  if(isDefined(var_3)) {
    var_4 = var_3.origin;
  } else {
    var_4 = self._id_0323;
  }

  var_5 = scripts\anim\exit_node::_id_6A1E();

  if(var_1) {
    var_6 = self.origin + self._id_027F * self._id_0280;
    var_7 = var_6;
  } else {
    var_6 = self _meth_84A6(128);
    var_7 = self _meth_84A6(32);
  }

  var_8 = vectortoangles(var_6 - self.origin);
  var_9 = vectortoangles(var_7 - self.origin);

  if(_id_08F1::_id_A57B(var_5) && !var_1) {
    var_10 = var_5.angles;
  } else {
    var_10 = self.angles;
  }

  var_11 = _func_000B(var_8[1] - var_10[1]);
  var_12 = _func_000B(var_9[1] - var_10[1]);
  var_13 = vectortoangles(self._id_027F);
  var_14 = _func_000B(var_13[1] - var_10[1]);

  if(abs(var_14) > 135 && abs(var_11) < 90) {
    return undefined;
  }

  if(_func_0134(self._id_04DF) > 16) {
    var_15 = vectortoangles(self._id_04DF);

    if(abs(_func_000B(var_15[1] - var_8[1])) < 45) {
      return;
    }
  }

  var_16 = _id_6D86();

  if(self _meth_8473(1) < var_16) {
    return;
  }
  var_17 = _func_0325(var_11);
  var_18 = self _meth_84DC();
  var_19 = var_17[0];
  var_20 = undefined;

  if(isDefined(self._id_1C30._id_426A._id_5792)) {
    var_20 = _id_6D84(self._id_1C30._id_426A._id_5792, var_2, var_19, var_12);
  } else {
    var_20 = _id_6D84(var_0, var_2, var_19, var_12);
  }

  if(!isDefined(self._id_1C30._id_426A._id_5792)) {
    var_21 = issubstr(var_0, "cover");
    var_22 = var_10;

    if(var_21 && isDefined(var_5)) {
      var_23 = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
      var_24 = var_23[var_19];

      if(issubstr(var_0, "left") && var_19 == 4) {
        var_24 = var_24 * -1;
      }

      var_22 = (0, _func_000A(var_5.angles[1] + var_24), 0);
    } else {
      var_25 = [180, -135, -90, -45, 0, 45, 90, 135, 180];
      var_24 = var_25[var_19];
      var_22 = (0, _func_000A(self.angles[1] + var_24), 0);
    }

    var_26 = 20.0;
    var_27 = anglesToForward(var_22);
    var_28 = var_27 * self _meth_864B();
    var_29 = vectornormalize(var_27) * 5.0;
    var_30 = self _meth_86F4(var_26, var_28, var_29);

    switch (var_30[0]) {
      case 1:
        var_30[1] = vectornormalize(var_30[1]);
        var_31 = vectortoangles(var_30[1]);
        var_32 = scripts\engine\math::_id_10FA2(-179, 179, _func_000B(var_31[1] - var_10[1]));
        var_33 = _func_0325(var_32, 45);
        var_34 = _func_000B(var_22[1] - var_10[1]);
        var_35 = _func_0325(var_34);
        var_36 = var_33[0];

        for(var_37 = var_33.size - 1; var_37 >= 0; var_37--) {
          var_38 = var_33[var_37];

          if(var_38 == var_35[0]) {
            continue;
          } else if((var_19 == 8 || var_19 == 0) && (var_38 == 8 || var_38 == 0)) {
            continue;
          } else if(var_38 == var_19) {
            continue;
          }
          var_36 = var_38;
          break;
        }

        var_19 = var_36;
        self._id_1C30._id_426A._id_7D25 = 1;
        var_20 = _id_6D84(var_0, var_2, var_19, var_12);
        break;
      case 2:
        var_20 = undefined;
        break;
      default:
        break;
    }
  }

  return var_20;
}

_id_A225(var_0) {
  self endon("death");
  waitframe();
  _id_A261(var_0);
}

_id_F090(var_0, var_1, var_2) {
  self._id_1C30._id_426A._id_7D25 = undefined;
  _id_F09D(var_0, var_1, var_2);
}

_id_F09D(var_0, var_1, var_2) {
  self._id_8840 = 0;
  self _meth_85FC();
}

_id_B8F8(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self _meth_84A6(128);
  var_5 = vectortoangles(var_4 - self.origin);
  var_6 = _func_000B(var_5[1] - self.angles[1]);
  var_7 = _id_0009::_id_1C6E(var_1, var_2);
  var_8 = _func_00BB(var_7, "code_move");
  var_9 = _func_00BB(var_7, "corner");
  var_10 = _func_00BB(var_7, "warp_exit_start");
  var_11 = _func_00BB(var_7, "warp_exit_end");
  var_12 = 1;

  if(var_8.size > 0) {
    thread _id_08F1::_id_107FD(var_0, var_1);
    thread _id_08F1::_id_10826(var_0, var_1);
    var_12 = var_8[0];
  }

  var_13 = _func_0078(var_7, 0, var_12);
  self _meth_8019("zonly_physics", 0);
  childthread _id_08F1::_id_D8CE(var_1, 0.2);
  var_14 = self._id_A246;

  if(_id_08F1::_id_47AA() && _id_08F1::_id_8825()) {
    var_14 = 1;
  }

  if(isDefined(self._id_5775)) {
    var_14 = self._id_5775;
  }

  var_15 = _func_00B0(var_7, 0.0, var_12);
  var_16 = length(var_15);
  var_17 = self _meth_84A6(var_16);

  if(var_16 > 1) {
    var_18 = var_17 - self _meth_84DC();
  } else {
    var_18 = self _meth_84A6(12) - self _meth_84DC();
  }

  var_19 = _func_0261(var_18);
  _id_0009::_id_1C8E(var_0, var_1, var_7);
  self _meth_85ED(var_1, var_2, var_14);
  var_20 = 1;
  var_21 = spawnStruct();
  var_21._id_10FD1 = var_7;

  if(isDefined(self._id_1C30._id_426A._id_7D25)) {} else if(var_9.size > 0) {
    var_22 = _func_00B0(var_7, 0, var_9[0]);
    var_23 = length(var_22);
    var_24 = self _meth_84A6(var_23);
    var_25 = var_17;

    if(var_16 - var_23 < 2) {
      var_25 = self _meth_84A6(var_16 + 6);
    }

    var_26 = var_25 - var_24;
    var_27 = _func_0261(var_26);

    if(var_10.size > 0 && var_10[0] > 0 && var_10[0] < var_9[0]) {
      var_21._id_BA02 = var_24;
      var_21._id_178A = var_27;
      var_21._id_532E = "corner";

      if(var_11.size > 0 && var_11[0] < var_9[0]) {
        var_21._id_5090 = int((var_11[0] - var_10[0]) * _func_0079(var_7) * 1000 / var_14);
      }
    } else
      scripts\engine\utility::_id_A1BC(var_7, var_24, (0, var_27, 0), undefined, "corner", undefined, 0);
  } else if(var_10.size == 0 || var_10[0] == 0) {
    var_28 = undefined;

    if(var_10.size > 0 && var_11.size > 0 && var_11[0] < var_8[0]) {
      var_28 = int((var_11[0] - var_10[0]) * _func_0079(var_7) * 1000);
    }

    scripts\engine\utility::_id_A1BC(var_7, var_17, (0, var_19, 0), undefined, "code_move", var_28, 0);
  }

  if(!isDefined(var_21._id_BA02)) {
    var_21._id_BA02 = var_17;
    var_21._id_178A = var_19;
    var_21._id_532E = "code_move";

    if(var_10.size > 0 && var_11.size > 0) {
      var_21._id_5090 = int((var_11[0] - var_10[0]) * _func_0079(var_7) * 1000 / var_14);
    }
  }

  self._id_8840 = 1;
  var_29 = self _meth_84A5();

  if(isDefined(var_29)) {
    var_21 = _id_A1BB(var_21, var_29);
  }

  _id_0009::_id_1C45(var_0, var_1, ::_id_74B0, var_21, undefined, !var_3);
  self _meth_85FC();

  if(var_3) {
    self _meth_8019("normal", 0);
    self _meth_8251("face motion");
    _id_0009::_id_1C45(var_0, var_1);
  }
}

_id_A1BB(var_0, var_1) {
  var_2 = _func_00FF(var_1.angles);
  var_3 = var_0._id_BA02 - var_1.origin;
  var_4 = rotatevector(var_3, var_2);
  var_0._id_BA02 = var_4;
  var_0._id_178A = _func_0047((0, var_0._id_178A, 0), var_2);
  var_0._id_71AF = var_1;
  return var_0;
}

_id_A1BA(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0._id_71AF;

  if(isDefined(var_3)) {
    var_4 = var_0._id_BA02;
    var_5 = rotatevector(var_4, var_3.angles);
    var_1 = var_5 + var_3.origin;
    var_6 = _func_0047(var_0._id_178A, var_3.angles);
    var_2 = var_6[1];
    return [var_1, var_2];
  } else
    return [var_0._id_BA02, var_0._id_178A];
}

_id_74B0(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(var_0 == "warp_exit_start" && !isDefined(self._id_1C30._id_426A._id_7D25)) {
    var_4 = var_1._id_532E;

    if(!isDefined(var_4)) {
      var_4 = "warp_exit_end";
    }

    var_5 = undefined;

    if(isDefined(var_1._id_5090)) {
      var_5 = var_1._id_5090 - var_1._id_5090 % 50;
    }

    [var_2, var_3] = _id_A1BA(var_1);
    scripts\engine\utility::_id_A1BC(var_1._id_10FD1, var_2, (0, var_3, 0), "warp_exit_start", var_4, var_5, 0);
  }

  if(var_0 == "code_move" || var_0 == "corner") {
    self._id_8840 = 0;
  }
}

_id_3569() {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!self._id_01B7) {
    return 0;
  }

  if(isDefined(self._id_4AB5) && self._id_4AB5) {
    return 0;
  }

  if(self._id_03FF != "none") {
    return 0;
  }

  var_0 = 100;
  var_1 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C61() == "casual" || _id_0009::_id_1C61() == "casual_gun" || self _meth_8644() <= 60) {
    var_0 = 50;

    if(istrue(self._id_4A7F)) {
      var_0 = 25;
    }
  } else if(istrue(self._id_4A7F))
    var_0 = 50;

  if(self _meth_8473() < var_0) {
    return 0;
  }

  return 1;
}

_id_3325(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();

  if(!isDefined(var_3[2]) || var_3[2] != var_4) {
    return 0;
  }

  if(!_id_DB40(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  var_5 = self._id_0DDF._id_D9BE;
  return var_5 < 2 || var_5 > 6;
}

_id_DB3A(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C62(var_4, "turn") != var_3) {
    return 0;
  }

  return _id_DB40(var_0, var_1, var_2, var_3, 1);
}

_id_DB40(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(self._id_A6C1)) {
    return 0;
  }

  var_5 = _id_0009::_id_1C65(var_0, "sharp_turn");

  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = 50;
  var_7 = gettime();

  if(var_7 - var_5 > var_6) {
    return 0;
  }

  var_8 = _id_0009::_id_1C64(var_0, "sharp_turn");
  var_9 = var_8[1];
  var_10 = var_8[2];
  var_11 = var_8[3];
  var_12 = 22500;

  if(var_10 && self _meth_8473() > 90 || _func_0135(self._id_04DF) > var_12) {
    var_13 = 0;
    var_14 = undefined;

    if(!_func_0107(var_3)) {
      var_15 = var_3;
    } else {
      var_15 = var_3[0];

      if(var_3.size > 1 && var_3[1] == 1) {
        var_13 = 1;
      }

      if(var_3.size > 2) {
        var_14 = _id_06BD::_id_23C2(var_3[2]);
      }
    }

    var_16 = "";

    if(!istrue(var_4) && _id_08F1::_id_47AA() && _id_08F1::_id_882F()) {
      var_17 = self _meth_8644();
      var_18 = length(self._id_04DF);
      var_19 = (var_18 + var_17) * 0.5;
      var_20 = self _meth_87CE();
      var_16 = _func_03A6(var_20, var_19);

      if(var_16 == "sprint") {
        var_16 = "run";
      }

      var_20 = self _meth_87CE();
      self._id_F81D = _func_03A5(var_20, var_16);
    } else
      self._id_F81D = undefined;

    var_21 = _id_2EF9(var_0, var_15, var_11, var_9, var_10, var_13, var_14, var_16);

    if(!isDefined(var_21)) {
      return 0;
    }

    if(self._id_0DDF._id_D9BE > 2 && self._id_0DDF._id_D9BE < 6) {
      return 0;
    }

    self._id_0DDF._id_D9BC = var_21;
    self._id_0DDF._id_D9BB = var_11;
    self._id_0DDF._id_D9BD = var_9;
    return 1;
  }

  return 0;
}

_id_2EF9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 22.5;

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  if(!isDefined(var_7)) {
    var_7 = "";
  }

  if(var_5) {
    if(_id_0009::_id_1C51(var_0, "pass_left")) {
      var_9 = var_6 + "left";
    } else if(_id_0009::_id_1C51(var_0, "pass_right")) {
      var_9 = var_6 + "right";
    } else if(self._id_1C30._id_5E3A._id_5E36 == "right") {
      var_9 = var_6 + "right";
    } else {
      var_9 = var_6 + "left";
    }
  } else
    var_9 = var_6;

  [var_11, var_12] = self _meth_856A(var_1, var_2, var_3, var_8, var_9, var_6, var_7);
  self._id_0DDF._id_D9BE = var_12;
  return var_11;
}

_id_361F(var_0, var_1, var_2) {
  return self._id_0DDF._id_D9BC;
}

_id_742D(var_0, var_1) {
  if(var_0 == "corner") {
    self _meth_85FC();

    if(!isDefined(self._id_0323)) {
      return;
    }
    if(self._id_0280 > 4) {
      var_2 = _func_0261(self._id_027F);
    } else {
      return;
    }

    var_3 = var_1;
    var_4 = _func_00BB(var_3, "corner");
    var_5 = _func_00BB(var_3, "code_move");
    var_6 = 1;

    if(var_5.size > 0) {
      var_6 = var_5[0];
    }

    var_7 = (var_6 - var_4[0]) * _func_0079(var_3) * 1000;

    if(var_7 < level._id_01E2) {
      return;
    }
    var_8 = _func_00B0(var_3, var_4[0], var_6);
    var_9 = _func_0077(var_3, var_4[0], var_6);
    var_10 = _func_000B(var_2 - self.angles[1] - var_9);

    if(abs(var_10) > 60) {
      return;
    }
    var_11 = (0, var_2 - var_9, 0);
    var_12 = self.origin + rotatevector(var_8, self.angles);
    var_12 = _func_02AB(var_12, self, 0, 1);
    var_13 = var_12 - rotatevector(var_8, var_11);
    self _meth_85FB(var_13, var_11, var_12, (0, var_2, 0), int(var_7));
  }
}

_id_B8D4(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self._id_0DDF._id_D9BC = undefined;
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_8019("zonly_physics", 0);
  self _meth_8251("face angle", self.angles[1]);
  var_5 = self._id_A246;

  if(isDefined(self._id_F81D) && _id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_6 = self _meth_8644();
    var_7 = length(self._id_04DF);
    var_8 = (var_7 + var_6) * 0.5;
    var_5 = var_8 / self._id_F81D;
  }

  _id_0009::_id_1C8E(var_0, var_1, var_4);
  self _meth_85ED(var_1, var_3, var_5);
  childthread _id_D9B9(var_4, var_5);
  var_9 = _id_0009::_id_1C45(var_0, var_1, ::_id_742D, var_4, undefined, 0);
  self _meth_85FC();
  self _meth_8251("face enemy or motion");
  self _meth_8019("normal", 0);

  if(var_9 == "code_move") {
    thread _id_08F1::_id_107FD(var_0, var_1);
    thread _id_08F1::_id_10826(var_0, var_1);
    var_10 = _func_00BB(var_4, "finish");

    if(var_10.size > 0) {
      _id_0009::_id_1C45(var_0, var_1);
    }
  }
}

_id_D9B9(var_0, var_1) {
  waitframe();

  if(isDefined(self._id_0DDF._id_D9BB) && isDefined(self._id_0DDF._id_D9BD)) {
    var_2 = _func_00BB(var_0, "corner");

    if(var_2.size > 0) {
      var_3 = var_2[0];
      var_4 = _func_0079(var_0);
      var_5 = level._id_01E2 / 1000 / var_4;
      var_6 = _func_00B0(var_0, var_5, var_3);
      var_7 = (0, _func_0077(var_0, var_5, var_3), 0);
      var_8 = var_4 * var_3 / var_1;

      if(var_8 > 0.05) {
        self._id_04C2 = 1;
        self _meth_863C(self._id_0DDF._id_D9BB, self._id_0DDF._id_D9BD, var_6, var_7, var_8);
      }
    }

    self._id_0DDF._id_D9BB = undefined;
    self._id_0DDF._id_D9BD = undefined;
  }
}

_id_D9BA(var_0, var_1, var_2) {
  self _meth_85FC();
  self._id_04C2 = 0;
}

_id_E939(var_0, var_1, var_2) {
  self._id_0380 = 0;
  self._id_CA5E = 0;
  self._id_0381 = gettime() + randomintrange(1000, 1500);
  self _meth_8309();
  self._id_0036 = 0;
  self._id_0086 = 0;
}

_id_CA5D(var_0) {
  self endon(var_0 + "_finished");
  self endon("death");

  for(;;) {
    var_1 = self _meth_864B();

    if(self _meth_8473() < var_1 * 1.3 || gettime() > self._id_0381 - 500) {
      var_2 = self _meth_8107();

      if(abs(var_2[1]) > 90) {
        self._id_CA5E = 1;
        return;
      }
    }

    waitframe();
  }
}

_id_B8CB(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0380 = 1;
  self._id_0377 = -180;
  self._id_0275 = 180;
  self._id_0036 = 360;
  self._id_0381 = gettime() + randomintrange(2500, 3500);
  thread _id_CA5D(var_1);
  _id_B89A(var_0, var_1, var_2);
}

_id_FD48() {
  if(!isDefined(self._id_EA9B) || self._id_EA9B < gettime()) {
    if(randomfloatrange(0, 1) < 0.3) {
      self._id_DBF6 = 1;
      self._id_EA9B = gettime() + 20000.0;
      self._id_EA99 = gettime() + randomfloatrange(0.0, 3000.0);
    }
  }
}

_id_B89A(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C7D(var_1, "blank");
  self _meth_85ED(var_1, var_3);
  thread _id_08F1::_id_107FD(var_0, var_1);
  thread _id_08F1::_id_10826(var_0, var_1);
  thread _id_08F1::_id_10800(var_0, var_1, 0);
  self _meth_85E3("speed");
  _id_FD48();

  for(;;) {
    _id_0009::_id_1C45(var_0, var_1, ::_id_749A);
  }
}

_id_B89F(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C7D(var_1, "blank");
  self _meth_85ED(var_1, var_3);
  self _meth_85E3("strafe");
  childthread _id_08F1::_id_10800(var_0, var_1, 1);
  childthread _id_B8A0();

  for(;;) {
    _id_0009::_id_1C45(var_0, var_1, ::_id_749A);
  }
}

_id_B8A0() {
  for(;;) {
    if(_func_0134(self._id_04DF) > 1) {
      var_0 = self.angles[1];
      var_1 = _func_0261(self._id_04DF);
      var_2 = _func_000B(var_1 - var_0);

      if(self._id_0B67._id_00CF) {
        if(-85 < var_2 && var_2 < 35) {
          self._id_0B67._id_00CF = 0;
        }
      } else if(var_2 < -90 || var_2 > 130)
        self._id_0B67._id_00CF = 1;
    }

    waitframe();
  }
}

_id_E9F6(var_0, var_1, var_2) {
  self _meth_85E3("none");
}

_id_10FE8(var_0) {
  if(var_0 < -135) {
    return "2";
  } else if(var_0 < -45) {
    return "6";
  } else if(var_0 > 135) {
    return "2";
  } else if(var_0 > 45) {
    return "4";
  } else {
    return "8";
  }
}

_id_DBF4(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_1C30._id_E9ED)) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(self _meth_85FD() == "enabled") {
    return 0;
  }

  if(_id_895D()) {
    return 0;
  }

  var_4 = _id_6D7C();
  var_5 = self _meth_8504(var_4);

  if(var_5 != "none") {
    return 0;
  }

  var_6 = self _meth_864B();

  if(self._id_0280 < 90) {
    return 0;
  }

  var_7 = _func_0261(self._id_027F);

  if(vectordot(vectornormalize(self._id_04DF), vectornormalize(self._id_027F)) < 0.9) {
    return 0;
  }

  var_8 = self _meth_85D8(var_0, "sharp_turn", 50);

  if(var_8) {
    var_9 = _func_000B(var_7 - self.angles[1]);
    var_10 = _func_000B(_func_0261(self._id_04DF) - self.angles[1]);

    if(abs(_func_000B(var_10 - var_9)) > 45) {
      return 0;
    }
  } else
    var_10 = _func_000B(var_7 - self.angles[1]);

  var_11 = self _meth_884D();
  var_12 = self _meth_886A(var_11);

  if(self._id_01B7 || self._id_0342 || self _meth_86F0()) {
    var_13 = 0;
  } else if(isDefined(var_12) || self _meth_8659()) {
    if(isDefined(var_12)) {
      var_14 = var_12._id_DA32;
    } else {
      if(_func_011D(self._id_0192) && gettime() - self _meth_8205(self._id_0192) > 2000) {
        return 0;
      }

      var_14 = self _meth_8204(self._id_0192);
    }

    if(distance2dsquared(var_14, self.origin) < 22500) {
      return 0;
    }

    var_15 = var_14 - self _meth_84A6(32);
    var_16 = _func_0261(var_15);

    if(abs(_func_000B(var_16 - self.angles[1])) < 45) {
      return 0;
    }

    var_13 = _func_000B(var_7 - var_16);
  } else if(istrue(self._id_0B67._id_01D3))
    return 0;
  else {
    if(var_8 || self _meth_8473() < 64) {
      return 0;
    }

    var_13 = _func_000B(var_7 - self._id_015D);
  }

  if(abs(_func_000B(var_10 - var_13)) < 45) {
    return 0;
  }

  var_17 = _id_10FE8(var_10);
  var_18 = _id_10FE8(var_13);

  if(var_17 == var_18) {
    return 0;
  }

  var_19 = "fast";

  if(_id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_20 = self _meth_87CE();
    var_19 = _func_03A6(var_20, var_6);

    if(var_19 != "fast" && var_19 != "shuffle" && var_19 != "walk") {
      var_19 = "fast";
    }

    self._id_E9F7 = _func_03A5(var_20, var_19);
  } else
    self._id_E9F7 = undefined;

  var_21 = var_19 + "_" + self._id_1C30._id_E9ED + "_" + var_17 + "_to_" + var_18;

  if(!_id_0009::_id_1C72(var_2, var_21)) {
    if(var_17 == "4" || var_17 == "6") {
      var_21 = var_19 + "_feet_together_" + var_17 + "_to_" + var_18;
    } else {
      var_21 = var_19 + "_foot_l_forward_" + var_17 + "_to_" + var_18;
    }

    if(!_id_0009::_id_1C72(var_2, var_21)) {
      return 0;
    }
  }

  self._id_1C30._id_E9F0 = var_21;
  return 1;
}

_id_DBC9(var_0, var_1, var_2, var_3) {
  if(_id_0009::_id_1C50(var_0, "code_move") && _id_DBF4(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

_id_134A(var_0, var_1, var_2, var_3, var_4) {
  self endon("end_aim_change_orient");
  self._id_1349 = self._id_04A8;
  var_5 = _func_0077(var_0, 0.0, var_2);
  var_6 = var_3 - self.angles[1];
  var_6 = _func_000B(var_6);
  var_7 = _func_000B(var_6 - var_5);

  while(isDefined(self) && isalive(self)) {
    var_8 = self _meth_85F7(var_0);
    var_9 = min(var_8 + level._id_01E2 / 1000.0 / var_4 * var_1, 1.0);
    var_10 = _func_0077(var_0, var_8, var_9);
    var_11 = var_10 / var_5;
    var_12 = var_7 * var_11;
    var_13 = var_10 + var_12;
    var_14 = _func_000A(self.angles[1] + var_13);
    var_15 = _func_000A(self.angles[1] + var_13 * 3);
    self _meth_8251("face angle", var_15);

    if(var_13 != 0.0) {
      var_16 = abs(_func_000B(self.angles[1] - var_14)) / level._id_01E2;

      if(var_16 > 0) {
        self._id_04A8 = var_16;
      }
    }

    waitframe();
  }
}

_id_B33A(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self._id_1C30._id_E9F0 = undefined;
  self._id_03BB = 1;
  var_5 = 1;
  var_6 = undefined;

  if(isDefined(self._id_E9F7) && _id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_7 = self _meth_864B();
    var_5 = var_7 / self._id_E9F7;
    var_6 = var_7;
    var_5 = clamp(var_5, 0.6, 1.4);
  }

  self _meth_85ED(var_1, var_3, var_5);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  var_8 = _func_00BB(var_4, "code_move");
  var_9 = _func_00BB(var_4, "finish");
  var_10 = 1;

  if(var_8.size > 0) {
    var_10 = var_8[0];
  } else if(var_9.size > 0) {
    var_10 = var_9[0];
  }

  var_11 = _func_0079(var_4);
  var_12 = var_11 * var_10;
  var_13 = _func_0261(self._id_027F);
  var_14 = undefined;

  if(!istrue(self._id_01B7) && !istrue(self._id_0342) && !self _meth_86F0()) {
    var_15 = _func_00B0(var_4, 0, var_10);
    var_16 = self _meth_84A6(length(var_15));
    var_17 = self _meth_884D();
    var_18 = self _meth_886A(var_17);
    var_19 = undefined;

    if(isDefined(var_18)) {
      var_19 = var_18._id_DA32;
    } else if(isDefined(self._id_0192)) {
      var_19 = self _meth_8204(self._id_0192);
    }

    if(isDefined(var_19)) {
      var_20 = vectornormalize(var_19 - var_16);
      var_13 = _func_0261(var_20);
      var_14 = var_19;
    }
  }

  thread _id_134A(var_4, var_5, var_10, var_13, var_11);
  var_21 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  self notify("end_aim_change_orient");

  if(isDefined(self._id_1349)) {
    if(self._id_1349 > 0) {
      self._id_04A8 = self._id_1349;
    }

    self._id_1349 = undefined;
  }

  if(var_21 == "code_move") {
    if(isDefined(var_14)) {
      self _meth_8251("face point", var_14);
    } else {
      self _meth_8251("face angle", var_13);
    }

    self _meth_8019("normal");
    _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  }

  if(isDefined(var_6)) {
    self _meth_8649(var_6);
  }
}

_id_35BA(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_1C30._id_E9F0);
}

_id_E9EF(var_0, var_1, var_2) {
  self notify("end_aim_change_orient");

  if(isDefined(self._id_1349)) {
    self._id_04A8 = self._id_1349;
    self._id_1349 = undefined;
  }

  self._id_03BB = 0;
}

_id_749A(var_0) {
  switch (var_0) {
    case "anim_pose = feet_together":
      self._id_1C30._id_E9ED = "feet_together";
      self._id_1C30._id_E9EE = gettime();
      break;
    case "anim_pose = feet_apart":
      self._id_1C30._id_E9ED = "feet_apart";
      self._id_1C30._id_E9EE = gettime();
      break;
    case "anim_pose = foot_l_forward":
      self._id_1C30._id_E9ED = "foot_l_forward";
      self._id_1C30._id_E9EE = gettime();
      break;
    case "anim_pose = foot_r_forward":
      self._id_1C30._id_E9ED = "foot_r_forward";
      self._id_1C30._id_E9EE = gettime();
      break;
  }
}

_id_B33B(var_0, var_1, var_2) {
  self _meth_83D9(self.origin, self.angles[1]);
  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_35BB(var_0, var_1, var_2) {
  if(!isDefined(self._id_1C30._id_E9ED)) {
    return _id_0009::_id_1C6C(var_0, var_1);
  }

  return _id_0009::_id_1C7D(var_1, self._id_1C30._id_E9ED);
}

_id_B340(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  self _meth_85E3("strafe");
  self _meth_8649(self _meth_8644());
  childthread _id_B8A0();

  for(;;) {
    var_4 = _id_0009::_id_1C45(var_0, var_1, ::_id_749A, undefined, undefined, 0);

    if(var_4 == "code_move") {
      self _meth_8019("normal", 0);
    }
  }
}

_id_B33E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0.4;
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_4);
  self _meth_8251("face enemy or motion");
  self _meth_8741(1);
  var_5 = _id_0009::_id_1C45(var_0, var_1, undefined, undefined, undefined, 0);

  if(var_5 == "code_move") {
    self _meth_8019("normal");
    var_5 = _id_0009::_id_1C45(var_0, var_1, undefined, undefined, undefined, 0);
  }

  _id_0009::_id_1C53(var_0, "end");
}

_id_E9F8(var_0, var_1, var_2) {
  self _meth_8741(0);
}

_id_DBF5(var_0, var_1, var_2, var_3) {
  if(!self _meth_884B()) {
    return 0;
  }

  if(self._id_01B7) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(isDefined(self._id_02ED) && isDefined(self._id_02ED.angles)) {
    return 0;
  }

  var_4 = _id_06BD::_id_23C6();

  if(isDefined(var_4)) {
    if(_func_043F(var_4.angles[1] - self.angles[1]) > 15) {
      return 0;
    }
  }

  if(self _meth_85FD() == "enabled" && self._id_0B67._id_035E >= gettime() - 50) {
    return 0;
  }

  var_5 = self._id_0370 - self.origin;
  var_6 = length(var_5);

  if(var_6 > 96) {
    return 0;
  }

  if(var_6 < self _meth_8473() * 0.8) {
    return 0;
  }

  var_7 = _func_0261(var_5);
  var_8 = _func_000B(var_7 - self.angles[1]);
  var_9 = _func_0326(var_8, 22.5);
  var_10 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var_11 = self _meth_87CE();
  var_12 = length(self._id_04DF);
  var_13 = "fast";
  var_14 = _func_03A4(var_11, "shuffle");
  var_15 = _func_03A4(var_11, "fast");

  if(!var_14 && !var_15) {
    var_13 = "walk";
  } else if(var_14 && var_12 < _func_03A8(var_11, "shuffle", "walk", 0.2)) {
    var_13 = "shuffle";
  } else if(var_15) {
    if(var_12 < _func_03A8(var_11, "walk", "fast", 0.2)) {
      var_13 = "walk";
    } else {
      var_13 = "fast";
    }
  } else
    var_13 = "walk";

  var_16 = "l";

  if(self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_16 = "r";
  }

  var_17 = var_13 + var_10[var_9] + var_16;
  var_18 = _id_0009::_id_1C7D(var_2, var_17);
  var_19 = _id_0009::_id_1C6E(var_2, var_18);
  var_20 = _func_00B0(var_19);
  var_21 = length(var_20);

  if(var_21 < 0.75 * var_6 || var_21 > 1.5 * var_6) {
    return 0;
  }

  var_22 = _func_0133(self._id_04DF) * level._id_5F3A;
  var_23 = self _meth_84A6(var_22);

  if(var_21 < length(self._id_0370 - var_23)) {
    return 0;
  }

  var_24 = 0.7;
  var_25 = 1.3;

  if(var_13 == "shuffle") {
    var_24 = 0.9;
  } else if(var_13 == "fast") {
    var_25 = 1.2;
  }

  self._id_1C30._id_E9F2 = var_18;
  self._id_1C30._id_E9F4 = self._id_0370 - rotatevector(var_20, self.angles);
  self._id_1C30._id_E9F5 = clamp(var_12 / _func_03A5(var_11, var_13), var_24, var_25);
  self._id_1C30._id_E9F3 = int(_func_0079(var_19) * self._id_1C30._id_E9F5 * 750);
  return 1;
}

_id_35BC(var_0, var_1, var_2) {
  return self._id_1C30._id_E9F2;
}

_id_B33C(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_85FB(self._id_1C30._id_E9F4, self.angles, self._id_0370, self.angles, self._id_1C30._id_E9F3);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3, self._id_1C30._id_E9F5);
  self _meth_83D9();
  _id_0009::_id_1C45(var_0, var_1);
}

_id_B33D(var_0, var_1, var_2) {
  self _meth_85FC();
  self _meth_8616();
  self._id_1C30._id_E9F4 = undefined;
  self._id_1C30._id_E9F3 = undefined;
  self._id_1C30._id_E9F2 = undefined;
  self._id_1C30._id_E9F5 = undefined;
}

_id_363C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = [];
  var_4[0] = _id_0009::_id_1C7D(var_1, "0");
  var_4[1] = _id_0009::_id_1C7D(var_1, "1");
  var_4[2] = _id_0009::_id_1C7D(var_1, "2");
  var_3._id_005C = var_4;
  var_3._id_5F09 = _id_0009::_id_1C7D(var_1, "forward");
  return var_3;
}

_id_DC0F() {
  return _id_06BD::_id_23E5() && isDefined(self._id_0B67._id_1098D) && self._id_0B67._id_1098D;
}

_id_10992(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    _id_0009::_id_1C45(var_0, var_1);
  }
}

_id_A27E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_08F1::_id_107FD(var_0, var_1);
  thread _id_08F1::_id_10826(var_0, var_1);
  var_3 = _id_0009::_id_1C69();
  _id_0009::_id_1CB4();
  self _meth_851D(var_3);
  _id_0009::_id_1CB4();
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = var_4._id_005C;
  var_6 = var_4._id_5F09;
  self _meth_85EF(_id_0009::_id_1C5E(), 0.2);
  self _meth_8317(var_1, var_6, 1.0, 0.2, 1.0);
  thread _id_10992(var_0, var_1);
  var_7 = 0;
  var_8 = 20;

  for(;;) {
    var_9 = _id_0009::_id_1C50(var_0, "cover_approach");
    var_10 = self _meth_8473();

    if(var_9 && var_10 < 150) {
      var_11 = _id_178F();
      var_12 = 1;

      while(var_12 <= var_8) {
        var_13 = var_12 / var_8;
        var_14 = var_13 * var_13 * (3 - 2 * var_13);
        var_15 = var_11;
        var_16 = var_15 * var_14;
        var_17 = var_15 - var_16;
        var_18 = _id_6E4C(var_17);

        for(var_19 = 0; var_19 < var_18.size; var_19++) {
          self _meth_82D9(var_5[var_19], var_18[var_19], 0.2, 1.0, 1);
        }

        var_12++;
        wait 0.05;
        waittillframeend;
      }

      while(var_9) {
        var_18 = _id_6E4C(0);

        for(var_12 = 0; var_12 < var_18.size; var_12++) {
          if(isDefined(var_5[var_12])) {
            self _meth_82D9(var_5[var_12], var_18[var_12], 0.2, 1.0, 1);
          }
        }

        wait 0.05;
        waittillframeend;
      }

      continue;
    }

    var_11 = _id_178F();
    var_20 = var_7 - var_11;

    if(var_20 < 0) {
      var_20 = var_20 * -1;
    }

    if(var_20 >= 60) {
      var_21 = var_7;
      var_22 = var_7;
      var_12 = 1;

      while(var_12 <= var_8) {
        var_11 = _id_178F();
        var_23 = var_21 - var_11;

        if(var_23 < 0) {
          var_23 = var_23 * -1;
        }

        if(var_23 >= 60) {
          if(var_12 == 1) {
            var_12 = 1;
          } else {
            var_12 = var_12 - 1;
          }

          var_24 = var_21 - var_7;
          var_13 = var_12 / var_8;
          var_14 = var_13 * var_13 * (3 - 2 * var_13);
          var_25 = var_24 * var_14;
          var_22 = var_25 + var_7;
          var_12 = 1;
          var_7 = var_22;
        }

        var_13 = var_12 / var_8;
        var_14 = var_13 * var_13 * (3 - 2 * var_13);
        var_15 = var_11 - var_22;
        var_16 = var_15 * var_14;
        var_17 = var_16 + var_7;
        var_18 = _id_6E4C(var_17);

        for(var_19 = 0; var_19 < var_18.size; var_19++) {
          self _meth_82D9(var_5[var_19], var_18[var_19], 0.2, 1.0, 1);
        }

        var_12++;
        var_21 = var_11;
        wait 0.05;
        waittillframeend;
      }
    } else {
      var_18 = _id_6E4C(var_11);

      for(var_12 = 0; var_12 < var_18.size; var_12++) {
        if(isDefined(var_5[var_12])) {
          self _meth_82D9(var_5[var_12], var_18[var_12], 0.2, 1.0, 1);
        }
      }

      wait 0.05;
      waittillframeend;
    }

    var_7 = var_11;
  }
}

_id_178F() {
  var_0 = self._id_1098E.origin;
  var_1 = self.origin;
  var_2 = var_0 - var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = _func_025B(var_3, var_2);
  var_5 = vectornormalize(var_4);
  var_6 = vectornormalize(var_2);
  var_7 = vectornormalize(var_3);
  var_8 = vectordot(var_6, var_7);

  if(isDefined(self._id_1098C)) {
    var_9 = scripts\engine\math::_id_178B(var_2, var_3);

    if(self._id_1098C == "right") {
      if(var_8 <= -1) {
        return -180;
      }

      return var_9 * -1;
      return;
    }

    if(var_8 >= 1) {
      return 180;
    }

    return var_9;
    return;
  } else {
    if(var_8 >= 1) {
      return 180;
    }

    if(var_8 <= -1) {
      return -180;
    } else {
      var_9 = scripts\engine\math::_id_178B(var_2, var_3);

      if(var_5[2] == -1) {
        var_9 = var_9 * -1;
      }

      return var_9;
    }
  }
}

_id_6E4C(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1[var_2] = 0;
  }

  var_3 = [-180, 0, 180];

  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = (var_0 - var_3[var_4]) / (var_3[var_5] - var_3[var_4]);
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;
  var_1[1] = max(0.01, var_1[1]);
  return var_1;
}

_id_A261(var_0) {
  var_1 = _id_0009::_id_1C61();

  if(var_1 == "frantic" || var_1 == "combat" || var_1 == "sprint") {
    scripts\anim\battlechatter_wrapper::_id_5674(var_0);
  }
}

_id_DBC6(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_23E9()) {
    return 0;
  }

  var_4 = self _meth_87CE();

  if(_id_08F1::_id_8A58(var_4, self _meth_8644())) {
    var_5 = 500;
  } else {
    var_5 = 600;
  }

  var_6 = self _meth_8473();
  return var_5 < var_6;
}

_id_361E(var_0, var_1, var_2) {
  var_3 = "reload";
  var_4 = self _meth_87CE();

  if(_id_08F1::_id_8A58(var_4, self _meth_8644())) {
    var_3 = "cqbreload";
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_B8C8(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_08F1::_id_107FD(var_0, var_1);
  thread _id_08F1::_id_10826(var_0, var_1);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_1, var_3));
  _id_0009::_id_1C45(var_0, var_1);
}

_id_F09C(var_0, var_1, var_2) {
  if(!_id_0009::_id_1C50(var_0, "reload done")) {
    scripts\anim\weaponlist::_id_C194();
  }

  _id_0900::_id_C30F(var_0, var_1, var_2);
}

_id_895D() {
  return isDefined(self._id_0323) && self._id_03FF != "none";
}

_id_6D7C() {
  var_0 = _id_0009::_id_1C61();

  switch (var_0) {
    case "casual":
      return 23;
    case "casual_gun":
      return 17;
    default:
      var_1 = self _meth_87CE();

      if(_id_08F1::_id_8A58(var_1, self _meth_8644())) {
        return 20;
      }

      return 36;
  }
}

_id_DB50(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(_func_0107(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self._id_03FF == var_4) {
    return 1;
  }

  var_5 = _id_6D7C();
  var_6 = self _meth_8504(var_5);

  if(var_6 == var_4) {
    return 1;
  }

  return 0;
}

_id_48A6(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(_func_0107(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(self._id_03FF == var_4) {
    return 1;
  }

  return var_4 == self _meth_8504(0.0);
}

_id_6D7D() {
  var_0 = _id_0009::_id_1C61();

  switch (var_0) {
    case "casual":
      return 13;
    case "casual_gun":
      return 10;
    case "frantic":
    case "combat":
      var_1 = self _meth_87CE();

      if(_id_08F1::_id_8A58(var_1, self _meth_8644())) {
        return 13;
      }

      return 10;
    default:
      return 28;
  }
}

_id_6D7E() {
  var_0 = _id_0009::_id_1C61();

  switch (var_0) {
    case "casual":
      return 24;
    case "casual_gun":
      return 24;
    default:
      var_1 = self _meth_87CE();

      if(_id_08F1::_id_8A58(var_1, self _meth_8644())) {
        return 15;
      }

      return 28;
  }
}

_id_6A7E() {
  var_0 = self _meth_8576();

  if(abs(var_0) > 0.99) {
    return 0;
  }

  var_1 = _func_0002(var_0);
  return var_1;
}

_id_DB77(var_0, var_1, var_2, var_3) {
  return self._id_03FF != "none" && _id_DB54(var_0, var_1, var_2, var_3);
}

_id_DB54(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0B67._id_4AEB) && self._id_0B67._id_4AEB) {
    return 0;
  }

  if(self._id_03FF == "none") {
    return 1;
  }

  var_4 = var_3;

  if(!self _meth_8566()) {
    return 1;
  }

  var_5 = _id_6D7D();

  if(isDefined(var_3) && var_3 == "up") {
    var_5 = _id_6D7E();
  }

  if(self._id_03FF != var_4) {
    return 1;
  }

  var_6 = self _meth_8504(var_5);
  return var_6 != self._id_03FF;
}

_id_35B8(var_0, var_1, var_2) {
  if(self._id_1C30._id_5E3A._id_5E36 == "left") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  var_4 = self _meth_87CE();

  if(_id_08F1::_id_8A58(var_4, self _meth_8644())) {
    var_5 = "cqb" + var_3;

    if(_id_0009::_id_1C72(var_1, var_5)) {
      var_3 = var_5;
    }
  }

  var_6 = _id_0009::_id_1C7D(var_1, var_3);
  return var_6;
}

_id_35B9(var_0, var_1, var_2) {
  var_3 = "8x10";
  var_4 = _id_6A7E();

  if(var_4 < 27.75) {
    var_3 = "8x20";
  }

  if(var_4 >= 27.75 && var_4 < 36.2) {
    var_3 = "8x12";
  }

  if(var_4 >= 36.2 && var_4 < 41.85) {
    var_3 = "8x10";
  }

  if(var_4 >= 41.85) {
    var_3 = "8x8";
  }

  var_5 = self _meth_87CE();

  if(_id_08F1::_id_8A58(var_5, self _meth_8644())) {
    var_6 = "cqb" + var_3;

    if(_id_0009::_id_1C72(var_1, var_6)) {
      var_3 = var_6;
    }
  }

  var_7 = _id_0009::_id_1C7D(var_1, var_3);
  return var_7;
}

_id_B339(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0377 = -90;
  self._id_0275 = 90;
  _id_B89A(var_0, var_1, var_2);
}

_id_E537(var_0, var_1, var_2) {
  self _meth_8309();
}

_id_DDEE(var_0, var_1, var_2) {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self._id_FECA) && self._id_FECA == 1) {
    var_3 = 0;
    var_4 = 0;
    var_5 = (0, 0, 1);
    self endon(var_1 + "_finished");
    var_6 = _id_0009::_id_1C7D(var_1, var_1 + "_knob");
    var_7 = _id_0009::_id_1C6E(var_1, var_6);
    var_8 = _id_0009::_id_1C7D(var_1, var_1 + "_scrub_anim");
    var_9 = _id_0009::_id_1C6E(var_1, var_8);
    self _meth_82D9(var_7, 1.0, 0.1, 0);
    self _meth_82D9(var_9, 1.0, 0.1, 0);

    for(;;) {
      var_10 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 12), self.origin - (0, 0, 999));
      var_11 = var_10["normal"];
      var_11 = _func_025E(var_5, var_11, 0.25);
      var_5 = var_11;
      var_12 = anglestoup(self.angles);
      var_13 = scripts\engine\math::_id_FFDC(var_11, var_12);
      var_14 = self.angles;
      var_15 = anglesToForward(var_14);
      var_16 = scripts\engine\math::_id_178D(var_15, var_13, var_12);
      var_3 = var_16 + 180;
      var_17 = var_11[2];
      var_4 = scripts\engine\math::_id_A5C5(1, 0.707, var_17);
      var_4 = 1 - var_4;
      self _meth_82D9(var_7, var_4, 0.2, 0);
      self _meth_82EA("slopes_scrub_direction", var_3);
      waitframe();
    }
  }
}

_id_DDED(var_0, var_1, var_2) {
  if(isagent(self)) {
    return;
  }
  var_3 = _id_0009::_id_1C7D(var_1, var_1 + "_knob");
  self _meth_8077(_id_0009::_id_1C6E(var_1, var_3), 0.1, "ease_inout_quad");
}

_id_DBF6(var_0, var_1, var_2) {
  if(isDefined(self._id_4AEE) && istrue(self._id_4AEE)) {
    return 0;
  }

  var_3 = self _meth_87CD("default");

  if(var_3 != "rebel" || !isalive(self._id_0192)) {
    return 0;
  }

  if(isDefined(self._id_DE54) && istrue(self._id_DE54._id_EA95)) {
    return 0;
  }

  if(!isDefined(self._id_DBF6) || !self._id_DBF6) {
    return 0;
  }

  if(!isDefined(self._id_EA99) || self._id_EA99 > gettime()) {
    return 0;
  }

  var_4 = _func_03A5(var_3, "jog");
  var_5 = length(self._id_04DF);

  if(var_5 < var_4) {
    return 0;
  }

  var_6 = 280;
  var_7 = 265;
  var_8 = 0.93969;
  var_9 = self _meth_84A6(var_6);
  var_10 = var_9 - self.origin;
  var_11 = anglesToForward(self.angles);
  var_12 = self _meth_8505(var_6);

  if(vectordot(var_11, var_10) < var_8 || length(var_10) < var_7 || var_12) {
    return 0;
  }

  return 1;
}

_id_EA98(var_0, var_1, var_2) {
  var_3 = self _meth_87CE();
  var_4 = _func_03A5(var_3, "run");
  var_5 = _func_03A5(var_3, "sprint");
  var_6 = length(self._id_04DF);
  var_7 = "stumble_jog";

  if(var_6 > var_5) {
    var_7 = "stumble_sprint";
  }

  if(var_6 > var_4) {
    var_7 = "stumble_run";
  }

  return _id_0009::_id_1C38(var_0, var_1, var_7);
}

_id_EA9A(var_0, var_1, var_2) {
  self._id_DBF6 = undefined;
}

_id_B341(var_0, var_1, var_2) {
  thread _id_08F1::_id_107FD(var_0, var_1);
  thread _id_08F1::_id_10826(var_0, var_1);
  thread _id_08F1::_id_10800(var_0, var_1, 0);
  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_DBDB(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_DE54) && istrue(self._id_DE54._id_EA95);
}

_id_41BF(var_0, var_1, var_2, var_3) {
  var_4 = _id_0009::_id_1C61();
  return _id_0009::_id_1C73(var_4, var_3);
}