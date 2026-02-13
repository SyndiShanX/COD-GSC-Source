/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2052.gsc
*************************************************/

_id_D672(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1B0A()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_6 = _id_0803::_id_6C65(var_1, var_2, var_3, var_4, var_5);

  if(!_id_0803::_id_8A64(var_6)) {
    return;
  }
  _id_0803::_id_D673(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_10FC9(var_0, var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_FCEA(var_6);
}

_id_D674(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1B0A()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  var_6 = [var_1];
  var_6[var_6.size] = var_2;
  var_6[var_6.size] = var_3;
  var_6[var_6.size] = var_4;
  var_6[var_6.size] = var_5;
  var_7 = _id_0803::_id_6C65(var_1, var_2, var_3, var_4, var_5);

  if(!_id_0803::_id_8A64(var_7)) {
    return;
  }
  _id_0803::_id_D673(var_0, var_7, var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_5C48(var_7);
  _id_0803::_id_FCEA(var_7);
}

_id_116A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::_id_CA4B() || !_id_1B0A()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = _id_0803::_id_6C65(var_1, var_2, var_3, var_4, var_5);

  if(!_id_0803::_id_8A64(var_6)) {
    return;
  }
  _id_0803::_id_116B(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_10FC9(self._id_B7E2._id_FF6E[var_6], var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_FCE9(var_6);
}

_id_116C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1B0A()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = _id_0803::_id_6C65(var_1, var_2, var_3, var_4, var_5);

  if(!_id_0803::_id_8A64(var_6)) {
    return;
  }
  _id_0803::_id_116B(var_0, var_6, var_1, var_2, var_3, var_4, var_5);
  _id_0803::_id_5C48(var_6);
  _id_0803::_id_FCEA(var_6);
}

_id_6C64(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1B0A()) {
    return undefined;
  }

  if(isai(self)) {
    return 0;
  }

  var_5 = _id_0803::_id_6C65(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(self._id_B7E2._id_FF6E[var_5])) {
    self._id_B7E2._id_FF6E[var_5] = _id_0803::_id_C0A6(var_0, var_1, var_2, var_3, var_4);
  }

  return self._id_B7E2._id_FF6E[var_5];
}

_id_1B0A() {
  return isDefined(level._id_B7E2) && istrue(level._id_B7E2._id_523F);
}

_id_1B0B() {
  return level._id_B7E2._id_035F > 0;
}

_id_99DB() {
  level._id_B7E2._id_035F++;
}

_id_99DC() {
  level._id_B7E2._id_035F--;
}

_id_9A04(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0803::_id_6C65(var_0, var_1, var_2, var_3, var_4);
  return _id_0803::_id_A00E(var_5, 0);
}

_id_9A05(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0803::_id_6C65(var_0, var_1, var_2, var_3, var_4);
  return _id_0803::_id_A00E(var_5, 1);
}

_id_899F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0803::_id_6C65(var_0, var_1, var_2, var_3, var_4);
  return _id_0803::_id_8A64(var_5);
}

_id_9A02(var_0) {
  _id_0803::_id_A00D(var_0, 0);
}

_id_9A03(var_0) {
  _id_0803::_id_A00D(var_0, 1);
}

_id_C29D(var_0, var_1, var_2) {
  var_3 = level._id_B7E2;
  var_4 = _id_0803::_id_6C65(var_0[0], var_0[1], var_0[2], var_0[3], var_0[4]);
  var_3._id_C04A[var_4] = [];
  var_3._id_C04A[var_4]["numerator"] = var_1;
  var_3._id_C04A[var_4]["denominator"] = var_2;
  var_5 = _id_0803::_id_6C65(var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
  var_6 = _id_0803::_id_6C65(var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);

  if(!isDefined(var_3._id_C049[var_5])) {
    var_3._id_C049[var_5] = [var_0];
  } else {
    var_3._id_C049[var_5][var_3._id_C049[var_5].size] = var_0;
  }

  if(!isDefined(var_3._id_C049[var_6])) {
    var_3._id_C049[var_6] = [var_0];
  } else {
    var_3._id_C049[var_6][var_3._id_C049[var_6].size] = var_0;
  }
}