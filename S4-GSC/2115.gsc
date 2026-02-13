/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2115.gsc
*************************************************/

_id_80AE() {
  if(isDefined(anim._id_DE29)) {
    return;
  }
  anim._id_DE29 = [];
}

_id_FF35() {
  if(!isDefined(anim._id_DE28)) {
    return;
  }
  foreach(var_1 in anim._id_DE28) {}
}

_id_101A(var_0, var_1, var_2) {
  _id_80AE();
  var_3 = spawnStruct();
  var_3._id_5D8C = var_1;
  var_3._id_5DD1 = var_2;
  anim._id_DE29[var_0] = var_3;
}

_id_404C() {
  var_0 = spawnStruct();
  var_0._id_18AD = [];
  return var_0;
}

_id_112B(var_0, var_1) {
  if(!isDefined(self._id_18AD[var_0])) {
    self._id_18AD[var_0] = [];
  }

  self._id_18AD[var_0] = var_1;
}

_id_112F(var_0) {
  _id_112B("smartobject_intro", var_0);
  self._id_7578 = 1;
}

_id_112A(var_0) {
  _id_112B("smartobject_logic", var_0);
}

_id_1132(var_0) {
  if(isDefined(var_0)) {
    _id_112B("smartobject_react", var_0);
  }

  self._id_759E = 1;
}

_id_1130(var_0) {
  _id_112B("smartobject_outro", var_0);
  self._id_758F = 1;
}

_id_112C() {
  self._id_753B = 1;
}

_id_112E() {
  self._id_755F = 1;
}

_id_1131(var_0) {
  if(isDefined(var_0)) {
    _id_112B("smartobject_pain", var_0);
  }

  self._id_7591 = 1;
}

_id_112D(var_0) {
  if(isDefined(var_0)) {
    _id_112B("smartobject_death", var_0);
  }

  self._id_7551 = 1;
}

_id_6D32(var_0) {
  return anim._id_DE29[var_0];
}

_id_DE1F() {
  var_0 = _id_6D32(self._id_CE48);
  var_1 = self[[var_0._id_5D8C]]();

  if(isDefined(var_1._id_FE9A)) {
    self._id_A444 = 1;
    return;
  }

  var_2 = gettime() + var_1._id_A4E7 * 1000;
  self._id_A4E7 = var_2;

  if(isDefined(self._id_950A)) {
    foreach(var_4 in self._id_950A) {
      if(isDefined(var_4._id_A4E7)) {
        var_4._id_A4E7 = max(var_4._id_A4E7, var_2);
        continue;
      }

      var_4._id_A4E7 = var_2;
    }
  }
}

_id_37F5(var_0) {
  var_0._id_37F2 = self;
}

_id_F936(var_0) {
  var_0._id_37F2 = undefined;
}

_id_3168(var_0) {
  return !isDefined(var_0._id_37F2);
}

_id_3209(var_0) {
  if(istrue(var_0._id_4D75)) {
    return 0;
  }

  if(isDefined(var_0._id_A444)) {
    return 0;
  }

  if(isDefined(var_0._id_A4E7) && gettime() < var_0._id_A4E7) {
    return 0;
  }

  var_1 = _id_6D32(var_0._id_CE48);
  var_2 = [[var_1._id_5DD1]](var_0);
  return var_2;
}

_id_6916(var_0, var_1, var_2) {
  if(!isDefined(anim._id_DE28)) {
    return undefined;
  }

  var_3 = var_2 * var_2;
  var_4 = _func_0204(anim._id_DE28, var_0);
  var_5 = var_4.size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];

    if(distancesquared(var_7.origin, var_0) > var_3) {
      break;
    }

    if(!_id_3168(var_7)) {
      continue;
    }
    if(!_id_3209(var_7)) {
      continue;
    }
    if(!_id_8A3E(var_7, var_0, var_1)) {
      continue;
    }
    var_8 = _id_6D32(var_7._id_CE48);

    if([[var_8._id_5DD1]](var_7)) {
      return var_7;
    }
  }

  return undefined;
}

_id_8997(var_0) {
  var_1 = 1600;
  var_2 = 4096;

  foreach(var_4 in level.players) {
    if(distance2dsquared(var_0.origin, var_4.origin) < var_1 && _func_0219(var_0.origin[2] - var_4.origin[2]) < var_2) {
      var_5 = _func_0261(var_4.origin - var_0.origin);

      if(abs(_func_000B(var_5 - var_0.angles[1])) < 90) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6917(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(anim._id_DE28)) {
    return;
  }
  var_7 = 60;
  var_8 = 60;
  var_9 = 5184;
  var_10 = 48;

  if(isDefined(var_2._id_106A1._id_03A0)) {
    var_10 = var_2._id_106A1._id_03A0;
  }

  var_11 = 128;

  if(isDefined(var_2._id_106A1._id_CDB3)) {
    var_11 = var_2._id_106A1._id_CDB3;
  }

  var_12 = var_1 - var_0;
  var_13 = length(var_12);
  var_14 = var_12 / var_13;
  var_15 = vectornormalize((var_14[1], -1 * var_14[0], 0));
  var_16 = 0;
  var_17 = undefined;
  var_18 = 60;
  var_19 = 5;
  var_20 = 0.33;
  var_21 = 1.5;
  var_22 = 300000;
  var_23 = 0.001;
  var_24 = undefined;
  var_25 = -9999;

  foreach(var_27 in var_2._id_DE15) {
    if(distancesquared(var_27.origin, self.origin) < var_9) {
      continue;
    }
    if(!_id_3168(var_27)) {
      continue;
    }
    if(!istrue(var_6) && !_id_3209(var_27)) {
      continue;
    }
    var_28 = var_27.origin - var_0;
    var_29 = vectordot(var_14, var_28);

    if(var_29 < var_4) {
      continue;
    }
    if(var_29 > var_13 + var_7) {
      continue;
    }
    var_30 = abs(vectordot(var_15, var_28));
    var_31 = _id_6D31(var_27);

    if(var_30 * var_30 > var_31) {
      continue;
    }
    var_32 = var_11;

    if(var_13 - var_30 < 60) {
      var_32 = var_32 * 0.5;
    }

    if(var_30 > var_32) {
      continue;
    }
    if(isDefined(var_3) && !_func_011A(var_27.origin, var_3)) {
      continue;
    }
    var_33 = _id_6D32(var_27._id_CE48);
    var_34 = var_13 - var_4;
    var_35 = var_29 - var_4;
    var_36 = var_5 - var_4;

    if(var_35 < var_36) {
      var_37 = var_19 + var_18 * (1 - (var_36 - var_35) / var_36);
    } else {
      var_34 = var_13 - var_5 + var_7;
      var_35 = var_29 - var_5;
      var_37 = var_19 + var_18 * (var_34 - var_35) / var_34;
    }

    if(var_30 > var_10) {
      var_38 = var_30 - var_10;
      var_37 = var_37 * (var_20 + (1 - var_38 / (var_32 - var_10)) * (1 - var_20));
    }

    if(_id_8997(var_27)) {
      var_37 = var_37 * var_21;
    }

    var_39 = var_27[[var_33._id_5D8C]]();

    if(isDefined(var_39._id_5D8E)) {
      var_37 = var_37 * self[[var_39._id_5D8E]](var_27);
    }

    if(isDefined(var_27._id_90BE)) {
      if(gettime() - var_27._id_90BE < var_22) {
        var_37 = var_37 * var_23;
      } else {
        var_27._id_90BE = undefined;
      }
    }

    if(var_37 > var_25) {
      var_25 = var_37;
      var_24 = var_27;
    }
  }

  return var_24;
}

_id_6D31(var_0) {
  if(isDefined(var_0._id_0359)) {
    return var_0._id_0359 * var_0._id_0359;
  }

  var_1 = anim._id_DE29[var_0._id_CE48];
  var_2 = [[var_1._id_5D8C]]();

  if(isDefined(var_2._id_0359)) {
    return var_2._id_0359 * var_2._id_0359;
  }

  return var_2._id_BF44;
}

_id_8A3E(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = self.origin;
  }

  var_4 = distancesquared(var_3, var_0.origin);

  if(isDefined(var_0._id_0359)) {
    if(var_4 > _func_0219(var_0._id_0359)) {
      return 0;
    }
  } else {
    var_5 = anim._id_DE29[var_0._id_CE48];
    var_6 = [[var_5._id_5D8C]]();

    if(var_4 > var_6._id_BF44) {
      return 0;
    }
  }

  if(isDefined(var_2) && !_func_011A(var_0.origin, var_2)) {
    return 0;
  }

  return 1;
}

_id_D4F8(var_0) {
  var_1 = _id_6D32(var_0._id_CE48);
  var_2 = [[var_1._id_5D8C]]();

  if(!istrue(var_2._id_753B)) {
    return;
  }
  self._id_1C30._id_426A._id_1C02 = var_0.angles;
  self._id_1C30._id_426A._id_1C10 = var_2._id_18E5;
  self._id_1C30._id_426A._id_1C15 = 1;
  self._id_1C30._id_426A._id_1C0A = "arrival";
}

_id_D6CD(var_0) {
  var_1 = _id_06BD::_id_23C6();

  if(isDefined(var_1)) {
    _id_397B(var_1);
  }

  _id_37F5(var_0);
  _id_06BD::_id_23F6(var_0);
}

_id_397B(var_0) {
  if(isDefined(var_0)) {
    _id_F936(var_0);
  }

  _id_06BD::_id_23B6();
}

_id_320B(var_0) {
  if(!isDefined(self._id_CE6E)) {
    return 0;
  }

  if(![[self._id_5D9C]]() && ![[self._id_5D99]]()) {
    return 0;
  }

  if(isDefined(self._id_0192)) {
    return 0;
  }

  return 1;
}

_id_320A(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(var_0.origin - self.origin);

  if(vectordot(var_1, var_2) >= cos(60)) {
    var_3 = 64;
  } else {
    var_3 = 100;
  }

  if(distancesquared(self.origin, var_0.origin) <= var_3 * var_3) {
    return 0;
  }

  var_1 = anglesToForward(var_0.angles);

  if(vectordot(var_1, var_2) < cos(45)) {
    return 0;
  }

  return 1;
}