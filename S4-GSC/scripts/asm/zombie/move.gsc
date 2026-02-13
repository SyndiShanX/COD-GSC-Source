/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\zombie\move.gsc
*************************************************/

_id_B89F(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_8019("normal");
  self _meth_8251("face enemy");
  var_3 = _id_0009::_id_1C7D(var_1, "blank");
  self _meth_85ED(var_1, var_3);
  self _meth_85E3("strafe");
  self._id_1C30._id_4130 = "strafe";
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

  var_4 = self _meth_864B();

  if(self._id_0280 < 90) {
    return 0;
  }

  var_5 = _func_0261(self._id_027F);

  if(vectordot(vectornormalize(self._id_04DF), vectornormalize(self._id_027F)) < 0.9) {
    return 0;
  }

  var_6 = self _meth_85D8(var_0, "sharp_turn", 50);

  if(var_6) {
    var_7 = _func_000B(var_5 - self.angles[1]);
    var_8 = _func_000B(_func_0261(self._id_04DF) - self.angles[1]);

    if(abs(_func_000B(var_8 - var_7)) > 45) {
      return 0;
    }
  } else
    var_8 = _func_000B(var_5 - self.angles[1]);

  var_9 = self _meth_884D();
  var_10 = _id_0AED::getshootposmp(var_9);

  if(self._id_01B7 || self._id_0342 || self _meth_86F0()) {
    var_11 = 0;
  } else if(isDefined(var_10) || self _meth_8659()) {
    if(isDefined(var_10)) {
      var_12 = var_10._id_DA32;
    } else {
      if(_func_011D(self._id_0192) && gettime() - self _meth_8205(self._id_0192) > 2000) {
        return 0;
      }

      var_12 = self _meth_8204(self._id_0192);
    }

    if(distance2dsquared(var_12, self.origin) < 22500) {
      return 0;
    }

    var_13 = var_12 - self _meth_84A6(32);
    var_14 = _func_0261(var_13);

    if(abs(_func_000B(var_14 - self.angles[1])) < 45) {
      return 0;
    }

    var_11 = _func_000B(var_5 - var_14);
  } else if(istrue(self._id_0B67._id_01D3))
    return 0;
  else {
    if(var_6 || self _meth_8473() < 64) {
      return 0;
    }

    var_11 = _func_000B(var_5 - self._id_015D);
  }

  if(abs(_func_000B(var_8 - var_11)) < 45) {
    return 0;
  }

  var_15 = _id_10FE8(var_8);
  var_16 = _id_10FE8(var_11);

  if(var_15 == var_16) {
    return 0;
  }

  var_17 = "fast";

  if(_id_08F1::_id_8825() && _id_08F1::_id_47AA()) {
    var_18 = self _meth_87CE();
    var_17 = _func_03A6(var_18, var_4);

    if(var_17 != "fast" && var_17 != "shuffle" && var_17 != "walk") {
      var_17 = "fast";
    }

    self._id_E9F7 = _func_03A5(var_18, var_17);
  } else
    self._id_E9F7 = undefined;

  var_19 = var_17 + "_" + self._id_1C30._id_E9ED + "_" + var_15 + "_to_" + var_16;

  if(!_id_0009::_id_1C72(var_2, var_19)) {
    if(var_15 == "4" || var_15 == "6") {
      var_19 = var_17 + "_feet_together_" + var_15 + "_to_" + var_16;
    } else {
      var_19 = var_17 + "_foot_l_forward_" + var_15 + "_to_" + var_16;
    }

    if(!_id_0009::_id_1C72(var_2, var_19)) {
      return 0;
    }
  }

  self._id_1C30._id_E9F0 = var_19;
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
    var_18 = _id_0AED::getshootposmp(var_17);
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
  self _meth_8019("zonly_physics");
  self _meth_8251("face current");
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
  self _meth_8019("zonly_physics");
  self _meth_8251("face enemy");
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
  self _meth_8019("zonly_physics");
  self _meth_8251("face current");
  var_3 = 0.4;
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_4);
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

scriptshouldstrafestart(var_0, var_1, var_2, var_3) {
  if(!istrue(self._id_0047)) {
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  return 1;
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
  self _meth_8019("zonly_physics");
  self _meth_8251("face current");
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

_id_5B12(var_0, var_1, var_2) {
  self _meth_85FC();
  self _meth_8616();
}