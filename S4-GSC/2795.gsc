/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2795.gsc
*************************************************/

_id_DB24() {
  if(isDefined(self._id_4A7F) && self._id_4A7F) {
    return 0;
  }

  if(isDefined(self._id_0192) && _id_06BD::_id_2419()) {
    return 0;
  }

  return 1;
}

_id_A6BD(var_0, var_1, var_2, var_3) {
  return !_id_DBE3(var_0, var_1, var_3);
}

_id_6B38(var_0) {
  return 256.0;
}

_id_DBE3(var_0, var_1, var_2, var_3) {
  if(!_id_DB24()) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!_id_0009::_id_1C50(var_0, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self._id_19FC)) {
    return 0;
  }

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

  if(!_id_08F1::_id_8764(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = 0;

  if(isDefined(var_3) && _func_0107(var_3) && var_3.size >= 2 && var_3[1]) {
    var_5 = 1;
  }

  self._id_1C30._id_5F3F = _id_06BD::_id_23D1();
  self._id_1C30._id_E906 = _id_2EFD(var_0, var_2, var_4, var_5);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_DB12(var_0, var_1, var_2, var_3) {
  if(!_id_DB24()) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!_id_0009::_id_1C50(var_0, "cover_approach")) {
    return 0;
  }

  return 1;
}

_id_DBEA(var_0, var_1, var_2, var_3) {
  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_DBEC(var_0, var_1, var_2, var_3) {
  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_DBE8(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23D5()) {
    return 0;
  }

  return _id_DBE3(var_0, var_1, var_2, var_3);
}

_id_35A5(var_0, var_1, var_2) {
  return self._id_1C30._id_E906;
}

_id_2EFD(var_0, var_1, var_2, var_3) {
  var_4 = _id_08F1::_id_68D8();

  if(isDefined(var_4)) {
    var_5 = var_4.origin;
  } else {
    var_5 = self._id_0323;
  }

  var_6 = _id_69B5();
  var_7 = self._id_19FC;
  var_8 = vectortoangles(var_7);

  if(isDefined(var_6)) {
    var_9 = _func_000B(var_6[1] - var_8[1]);
  } else if(isDefined(var_4) && var_4.type != "Path") {
    var_9 = _func_000B(var_4.angles[1] - var_8[1]);
  } else {
    var_10 = var_5 - self.origin;
    var_11 = vectortoangles(var_10);
    var_9 = _func_000B(var_11[1] - var_8[1]);
  }

  var_12 = _func_0326(var_9, 22.5);
  var_13 = var_1;

  if(var_2 == "Custom") {
    var_14 = _id_6D90(var_0, self._id_1C30._id_426A._id_1C10, undefined, self._id_1C30._id_426A._id_1C15);
    var_13 = self._id_1C30._id_426A._id_1C10;
  } else
    var_14 = _id_6D90(var_0, var_1, undefined, var_3);

  var_15 = _id_6D92();
  var_16 = var_5 - self.origin;
  var_17 = _func_0135(var_16);
  var_18 = var_14[var_12];

  if(!isDefined(var_18)) {
    return undefined;
  }

  var_19 = self _meth_810C(var_13, var_18);
  var_20 = _func_00B0(var_19);
  var_21 = _func_0077(var_19);
  var_22 = length(self getvelocity());
  var_23 = var_22 * 0.053;
  var_24 = length(var_16);
  var_25 = length(var_20);

  if(abs(var_24 - var_25) > var_23) {
    return undefined;
  }

  if(var_17 < _func_0135(var_20)) {
    return undefined;
  }

  var_26 = _id_2EB1(var_15._id_B9FE, var_15._id_01BF[1], var_20, var_21);
  var_27 = _func_02AB(var_15._id_B9FE, self);
  var_28 = _id_2EB1(var_27, var_15._id_01BF[1], var_20, var_21);
  var_29 = self _meth_84DC();
  var_30 = var_2 == "Cover Left" || var_2 == "Cover Right" || var_2 == "Cover Left Crouch" || var_2 == "Cover Right Crouch";

  if(var_30 && (var_12 == 0 || var_12 == 8 || var_12 == 7 || var_12 == 1)) {
    var_31 = undefined;
    var_32 = undefined;
    var_33 = _func_00BB(var_19, "corner");

    if(var_33.size > 0) {
      var_31 = _func_00B0(var_19, 0, var_33[0]);
      var_32 = var_33[0];
    } else {
      var_34 = undefined;
      var_35 = undefined;

      if(var_2 == "Cover Left" || var_2 == "Cover Left Crouch") {
        var_34 = "left";

        if(var_12 == 7) {
          var_35 = "7";
        } else if(var_12 == 0 || var_12 == 8) {
          var_35 = "8";
        }
      } else if(var_2 == "Cover Right" || var_2 == "Cover Right Crouch") {
        var_34 = "right";

        if(var_12 == 0 || var_12 == 8) {
          var_35 = "8";
        } else if(var_12 == 1) {
          var_35 = "9";
        }
      }

      if(isDefined(var_34) && isDefined(var_35)) {
        var_31 = _id_6E0D(var_0, var_1, var_35, var_3);
        var_32 = _id_6D70(var_0, var_1, var_35, var_3);
      }
    }

    if(isDefined(var_31)) {
      var_31 = rotatevector(var_31, (0, var_15._id_01BF[1] - var_21, 0));
      var_31 = var_28 + var_31;
      var_36 = _func_02A6(var_29, var_31, self, 1);

      if(var_36["fraction"] >= 0.9 || _func_02A8(var_29, var_31, self)) {
        var_37 = spawnStruct();
        var_37._id_E8FC = var_18;
        var_37._id_0053 = var_12;
        var_37._id_0405 = var_26;
        var_37._id_0052 = var_21;
        var_37.angles = var_15.angles;
        var_37._id_01BF = var_15._id_01BF;
        var_37._id_02D4 = var_20;
        var_37._id_04A7 = var_31;
        var_37._id_03F9 = var_32;
        return var_37;
      }
    }
  } else {
    var_36 = _func_02A6(var_29, var_27, self, 1);
    var_38 = var_36["fraction"] >= 0.9 || _func_02A8(var_29, var_27, self);

    if(!var_38) {
      var_39 = self _meth_8473();
      var_38 = var_39 < distance(var_29, var_27) + 8.0;
    }

    if(var_38) {
      var_37 = spawnStruct();
      var_37._id_E8FC = var_18;
      var_37._id_0053 = var_12;
      var_37._id_0405 = var_26;
      var_37._id_0052 = var_21;
      var_37.angles = var_15.angles;
      var_37._id_01BF = var_15._id_01BF;
      var_37._id_E907 = var_20;
      var_37._id_1C0B = var_5;
      return var_37;
    }
  }

  return undefined;
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

_id_B31D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_08F1::_id_68D8();
  var_4 = _id_06BE::_id_1C5D(var_0, var_1);

  if(!isDefined(var_4)) {
    _id_0009::_id_1C53(var_0, "abort", undefined);
    return;
  }

  var_5 = _id_0009::_id_1C69();

  if(!isDefined(var_5)) {
    var_5 = 1.0;
  }

  var_6 = var_4._id_01BF;
  var_7 = var_4._id_0053;
  var_8 = (0, var_6[1] - var_4._id_0052, 0);
  var_9 = self _meth_810C(var_1, var_4._id_E8FC);
  var_10 = _func_0079(var_9);
  var_10 = var_10 * (1 / var_5);
  self _meth_83D9(var_4._id_0405, var_8[1], var_10);
  _id_06BE::_id_1C88(var_0, var_1, var_4._id_E8FC, var_5);
}

_id_1C09() {
  self endon("killanimscript");
  self waittill(self._id_1C03 + "_finished");
}

_id_69B5() {
  if(isDefined(self._id_1C30._id_426A._id_1C02)) {
    return self._id_1C30._id_426A._id_1C02;
  }

  return undefined;
}

_id_6D92() {
  var_0 = spawnStruct();
  var_1 = _id_08F1::_id_68D8();

  if(isDefined(var_1) && var_1.type != "Path") {
    var_0._id_B9FE = var_1.origin;
    var_0.angles = var_1.angles;
    var_0._id_01BF = (0, _id_08F1::_id_6B9D(var_1), 0);
  } else {
    var_0._id_B9FE = self._id_0323;
    var_2 = self getvelocity();
    var_3 = self._id_027F;

    if(_func_0135(var_2) > 1) {
      var_0.angles = vectortoangles(var_0._id_B9FE - self.origin);
    } else {
      var_0.angles = vectortoangles(var_3);
    }

    var_0._id_01BF = var_0.angles;
  }

  var_4 = _id_69B5();

  if(isDefined(var_4)) {
    var_0.angles = var_4;
    var_0._id_01BF = var_0.angles;
  }

  return var_0;
}

_id_2EB1(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

_id_6D90(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[5] = _id_0009::_id_1C7F(1, var_0, var_1, var_3);
  var_4[4] = _id_0009::_id_1C7F(2, var_0, var_1, var_3);
  var_4[3] = _id_0009::_id_1C7F(3, var_0, var_1, var_3);
  var_4[6] = _id_0009::_id_1C7F(4, var_0, var_1, var_3);
  var_4[2] = _id_0009::_id_1C7F(6, var_0, var_1, var_3);
  var_4[7] = _id_0009::_id_1C7F(7, var_0, var_1, var_3);
  var_4[0] = _id_0009::_id_1C7F(8, var_0, var_1, var_3);
  var_4[1] = _id_0009::_id_1C7F(9, var_0, var_1, var_3);
  var_4[8] = var_4[0];
  return var_4;
}

_id_6D70(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["cover_left_arrival"]["7"] = 0.369369;
  var_4["cover_left_crouch_arrival"]["7"] = 0.321321;
  var_4["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
  var_4["cqb_cover_left_arrival"]["7"] = 0.275275;
  var_4["cover_left_arrival"]["8"] = 0.525526;
  var_4["cover_left_crouch_arrival"]["8"] = 0.448448;
  var_4["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
  var_4["cqb_cover_left_arrival"]["8"] = 0.335335;
  var_4["cover_right_arrival"]["8"] = 0.472472;
  var_4["cover_right_crouch_arrival"]["8"] = 0.248248;
  var_4["cqb_cover_right_arrival"]["8"] = 0.345345;
  var_4["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
  var_4["cover_right_arrival"]["9"] = 0.551552;
  var_4["cover_right_crouch_arrival"]["9"] = 0.2002;
  var_4["cqb_cover_right_arrival"]["9"] = 0.3003;
  var_4["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
  return var_4[var_1][var_2];
}

_id_6E0D(var_0, var_1, var_2, var_3) {
  return undefined;
}

_id_DBE4(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_19FC)) {
    return 0;
  }

  var_4 = undefined;

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

  if(!_id_08F1::_id_8764(var_0, var_1, var_2, var_4)) {
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

  self._id_1C30._id_5F3F = _id_06BD::_id_23D1();
  self._id_1C30._id_E906 = _id_2EFD(var_0, var_2, var_4, var_7);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}