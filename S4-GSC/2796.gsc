/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2796.gsc
*************************************************/

_id_B32B(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  self._id_1C30._id_426A._id_5792 = undefined;

  if(!isDefined(var_3)) {
    _id_0009::_id_1C53(var_0, "code_move", undefined);
    return;
  }

  _id_B8F8(var_0, var_1, var_3);
  _id_0009::_id_1C53(var_0, "code_move", undefined);
}

_id_35AB(var_0, var_1, var_2) {
  if(!_id_3569()) {
    return undefined;
  }

  var_3 = _id_48B0(var_1);
  return var_3;
}

_id_6D85(var_0) {
  var_1 = [];

  if(_id_0009::_id_1C72(var_0, "1")) {
    var_1[7] = _id_0009::_id_1C7D(var_0, "1");
  }

  if(_id_0009::_id_1C72(var_0, "2")) {
    var_1[0] = _id_0009::_id_1C7D(var_0, "2");
    var_1[8] = var_1[0];
  }

  if(_id_0009::_id_1C72(var_0, "3")) {
    var_1[1] = _id_0009::_id_1C7D(var_0, "3");
  }

  if(_id_0009::_id_1C72(var_0, "4")) {
    var_1[6] = _id_0009::_id_1C7D(var_0, "4");
  }

  if(_id_0009::_id_1C72(var_0, "6")) {
    var_1[2] = _id_0009::_id_1C7D(var_0, "6");
  }

  if(_id_0009::_id_1C72(var_0, "7")) {
    var_1[5] = _id_0009::_id_1C7D(var_0, "7");
  }

  if(_id_0009::_id_1C72(var_0, "8")) {
    var_1[4] = _id_0009::_id_1C7D(var_0, "8");
  }

  if(_id_0009::_id_1C72(var_0, "9")) {
    var_1[3] = _id_0009::_id_1C7D(var_0, "9");
  }

  return var_1;
}

_id_6A1E() {
  var_0 = undefined;

  if(!isDefined(self._id_7656)) {
    var_1 = 400;
  } else {
    var_1 = 4096;
  }

  if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
    var_0 = self._id_02ED;
  } else if(isDefined(self._id_0347) && distancesquared(self.origin, self._id_0347.origin) < var_1) {
    var_0 = self._id_0347;
  }

  if(isDefined(var_0) && isDefined(self._id_7656) && _func_043F(self.angles[1] - var_0.angles[1]) > 30) {
    return undefined;
  }

  return var_0;
}

_id_48B0(var_0) {
  var_1 = self _meth_8161();

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  } else {
    var_2 = self._id_0323;
  }

  var_3 = _id_6A1E();
  var_4 = self._id_027F;
  var_5 = vectortoangles(var_4);

  if(isDefined(var_3)) {
    var_6 = var_3.angles;
  } else {
    var_6 = self.angles;
  }

  var_7 = _func_000B(var_5[1] - self.angles[1]);
  var_8 = self getvelocity();

  if(_func_0134(var_8) > 16) {
    var_9 = vectortoangles(var_8);

    if(abs(_func_000B(var_9[1] - var_5[1])) < 45) {
      return;
    }
  }

  if(distancesquared(var_2, self.origin) < 22500) {
    return;
  }
  if(isDefined(self._id_1C30._id_426A) && isDefined(self._id_1C30._id_426A._id_5792)) {
    var_10 = _id_6D85(self._id_1C30._id_426A._id_5792);
  } else {
    var_10 = _id_6D85(var_0);
  }

  var_11 = _func_0325(var_7);
  var_12 = undefined;
  var_13 = undefined;

  for(var_14 = 0; var_14 < var_11.size; var_14++) {
    var_15 = var_11[var_14];

    if(!isDefined(var_10[var_15])) {
      continue;
    }
    var_12 = self _meth_810C(var_0, var_10[var_15]);
    var_16 = _func_00B0(var_12);
    var_17 = rotatevector(var_16, self.angles) + self.origin;

    if(!_func_02A6(self.origin, var_17, self)) {
      var_13 = var_10[var_15];
      break;
    }
  }

  return var_13;
}

_id_B8F8(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = vectortoangles(self._id_027F);
  var_4 = _func_000B(var_3[1] - self.angles[1]);
  var_5 = self _meth_810C(var_1, var_2);
  var_6 = _func_00BB(var_5, "code_move");
  var_7 = 1;

  if(var_6.size > 0) {
    var_7 = var_6[0];
  }

  var_8 = _func_0078(var_5, 0, var_7);
  self _meth_8019("zonly_physics");
  var_9 = _func_000B(var_3[1] - var_8[1]);
  var_10 = (0, var_9, 0);
  self _meth_8251("face angle", var_10[1]);
  var_11 = _func_0079(var_5) * var_7;
  var_12 = 0.01 + abs(_func_000B(var_4 - var_8[1])) / var_11 / 1000;

  if(var_12 < 0.01) {
    var_12 = 0.01;
  }

  self._id_BC67 = self._id_04A8;
  self._id_04A8 = var_12;
  thread _id_5B1F(var_1 + "_finished");
  _id_06BE::_id_1C89(var_0, var_1, var_2, self._id_A246, "code_move");
  self notify("FinishStartAnim");
}

_id_5B1F(var_0) {
  self endon("death");
  scripts\engine\utility::_id_108B4(var_0, "FinishStartAnim");
  self._id_04A8 = self._id_BC67;
  self._id_BC67 = undefined;

  if(self _meth_85EC()) {
    self _meth_82B9("code_move");
    self _meth_82C1("face motion");
  } else {
    self _meth_8019("normal");
    self _meth_8251("face motion");
  }
}

_id_3569() {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!self._id_01B7) {
    return 0;
  }

  if(isDefined(self._id_0192) && _id_06BD::_id_2419()) {
    return 0;
  }

  if(isDefined(self._id_4AB5) && self._id_4AB5) {
    return 0;
  }

  if(distancesquared(self.origin, self._id_0323) < 10000) {
    return 0;
  }

  return 1;
}

_id_3325(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3[2]) || !_id_06BD::_id_23E6(var_3[2])) {
    return 0;
  }

  return _id_DB40(var_0, var_1, var_2, var_3);
}

_id_DB40(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_A6C1) && self._id_A6C1) {
    return 0;
  }

  if(isDefined(self._id_7D2F) && self._id_7D2F) {
    return 0;
  }

  var_4 = _id_0009::_id_1C60(var_0);
  var_5 = _id_0009::_id_1C65(var_0, "sharp_turn");

  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = 100;
  var_7 = gettime();

  if(var_7 - var_5 > var_6) {
    return 0;
  }

  var_8 = _id_0009::_id_1C64(var_0, "sharp_turn");
  var_9 = var_8[1];
  var_10 = var_8[2];
  var_11 = var_8[3];
  var_12 = var_9 - var_11;

  if(_func_0107(var_3)) {
    var_13 = var_3[0];
  } else {
    var_13 = var_3;
  }

  var_14 = _id_2EF9(var_4, var_2, var_12, var_10);

  if(!isDefined(var_14)) {
    return 0;
  }

  self._id_D9BC = var_14;
  return 1;
}

_id_2EF9(var_0, var_1, var_2, var_3) {
  var_4 = 10;

  if(var_3) {
    var_4 = 30;
  }

  var_5 = vectortoangles(var_2);
  var_6 = _func_000B(var_5[1] - self.angles[1]);

  if(var_3) {
    if(abs(var_6) < 30) {
      return undefined;
    }
  }

  var_7 = _func_0325(var_6, var_4);

  if(istrue(self._id_917B)) {
    var_8 = _id_6D25(var_1, 0);
  } else {
    var_8 = _id_6D25(var_1, 1);
  }

  foreach(var_10 in var_7) {
    if(var_10 > 2 && var_10 < 6) {
      continue;
    }
    if(var_10 < 0 || var_10 > 8) {
      continue;
    }
    var_11 = self _meth_810C(var_1, var_8[var_10]);
    var_12 = _func_0077(var_11);
    var_13 = (0, _func_000B(var_5[1] - var_12), 0);

    if(_id_317F(var_11, var_13, var_10 == 3 || var_10 == 5)) {
      return var_8[var_10];
    }
  }

  return undefined;
}

_id_361F(var_0, var_1, var_2) {
  return self._id_D9BC;
}

_id_B8D4(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  self._id_D9BC = undefined;
  _id_0009::_id_1CA3("gravity");
  _id_0009::_id_1CA6("face current");
  _id_06BE::_id_1C8A(var_0, var_1, var_3, self._id_A246, "code_move");
  _id_0009::_id_1CA3("normal");
  _id_0009::_id_1CA6("face motion");
}

_id_317F(var_0, var_1, var_2) {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(_id_06BD::_id_2419()) {
    return 0;
  }

  var_3 = _func_00BB(var_0, "code_move");

  if(var_3.size == 0) {
    var_3[0] = 1.0;
  }

  var_4 = var_3[0];
  var_5 = _func_00B0(var_0, 0, var_4);
  var_6 = self _meth_8216(var_5);
  var_7 = self._id_0323;
  var_8 = self _meth_8161();

  if(isDefined(var_8)) {
    var_7 = var_8.origin;
  }

  if(isDefined(self._id_1C0F)) {
    if(_func_0219(self._id_1C0F) > distancesquared(var_7, var_6)) {
      return 0;
    }
  } else if(distancesquared(var_7, var_6) < 7056)
    return 0;

  var_5 = _func_00B0(var_0, 0, 1);
  var_9 = self _meth_8216(var_5);
  var_9 = var_6 + vectornormalize(var_9 - var_6) * 20;
  var_10 = _func_02A6(var_6, var_9, self);

  if(var_10) {
    return 0;
  }

  if(isDefined(self._id_5D6B)) {
    return self[[self._id_5D6B]](var_0, var_1, var_2);
  }

  return 1;
}

_id_6D26(var_0, var_1) {
  var_2 = [];
  var_3 = "";

  if(isDefined(var_1) && var_1 && self._id_1C30._id_5E3A._id_5E36 == "right") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  var_2[0] = _id_0009::_id_1C7D(var_0, var_3 + "2");
  var_2[1] = _id_0009::_id_1C7D(var_0, var_3 + "3");
  var_2[2] = _id_0009::_id_1C7D(var_0, var_3 + "6");
  var_2[3] = _id_0009::_id_1C7D(var_0, var_3 + "9");
  var_2[5] = _id_0009::_id_1C7D(var_0, var_3 + "7");
  var_2[6] = _id_0009::_id_1C7D(var_0, var_3 + "4");
  var_2[7] = _id_0009::_id_1C7D(var_0, var_3 + "1");
  var_2[8] = _id_0009::_id_1C7D(var_0, var_3 + "2");
  return var_2;
}

_id_6D25(var_0, var_1) {
  if(isDefined(self._id_6752)) {
    return [[self._id_6752]](var_0, var_1);
  }

  return _id_6D26(var_0, var_1);
}

_id_D9BA(var_0, var_1, var_2) {
  self _meth_85FC();
  self._id_04C2 = 0;
}

_id_B8A1(var_0, var_1, var_2) {
  _id_8238(var_0, var_1, var_2);
  _id_A264(var_0, var_1);
}

_id_8238(var_0, var_1, var_2) {}

_id_A264(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = _id_0009::_id_1C7D(var_1, "f");
  var_3 = _id_0009::_id_1C7D(var_1, "l");
  var_4 = _id_0009::_id_1C7D(var_1, "r");
  var_5 = _id_0009::_id_1C7D(var_1, "b");

  if(self _meth_85EC()) {
    self _meth_82B9("code_move");
  } else {
    self _meth_8019("normal");
  }

  var_6 = -1;
  var_7 = -1;

  for(;;) {
    var_8 = scripts\anim\utility_common::_id_BE97(self _meth_8158());

    if(var_8["back"] == 1.0) {
      var_7 = var_5;
    } else if(var_8["left"] == 1.0) {
      var_7 = var_3;
    } else if(var_8["right"] == 1.0) {
      var_7 = var_4;
    } else {
      var_7 = var_2;
    }

    if(var_7 != var_6) {
      self _meth_82E6(var_1, var_7);
    }

    var_6 = var_7;
    wait 0.25;
  }
}