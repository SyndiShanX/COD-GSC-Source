/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2604.gsc
*************************************************/

_id_81DD() {
  _id_81E9();
}

_id_B69F() {}

_id_B694() {}

_id_B7B2() {}

_id_D8E1(var_0, var_1, var_2) {}

_id_C53D(var_0) {
  if(isDefined(level._id_B04B) && isDefined(level._id_B04B["dofScripting"])) {
    self _meth_865D(level._id_B04B["dofScripting"]);
  }
}

_id_FEC4(var_0) {}

_id_81E9() {
  level._id_CC1B = [];
  setdvarifuninitialized("#x336c78767661ca92f", 0);
}

_id_3FFB(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4._id_01D7 = anglesToForward((0, var_1, 0));
  var_4.streakname = var_2;
  var_4.team = var_3;
  level._id_CC1B[level._id_CC1B.size] = var_4;
}

_id_9A2E(var_0, var_1) {
  wait(level._id_CC1C[var_1]);
  var_6 = 0;
  var_7 = [];

  for(var_8 = 0; var_8 < level._id_CC1B.size; var_8++) {
    if(!var_6 && level._id_CC1B[var_8].origin == var_0) {
      var_6 = 1;
      continue;
    }

    var_7[var_7.size] = level._id_CC1B[var_8];
  }

  level._id_CC1B = var_7;
}

_id_6D12(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_CC1B.size; var_2++) {
    var_3 = level._id_CC1B[var_2].origin;
    var_4 = level._id_CC1B[var_2]._id_01D7;
    var_5 = level._id_CC1B[var_2].streakname;
    var_1 = var_1 + _id_6D2B(var_0, var_3, var_4, var_5);
  }

  return var_1;
}

_id_6D2B(var_0, var_1, var_2, var_3) {
  if(level._id_CC1D[var_3] != 0) {
    var_4 = var_1 + level._id_CC1D[var_3] * level._id_CC1E[var_3] * var_2;
    var_5 = var_0 - var_4;
    var_5 = (var_5[0], var_5[1], 0);
    var_6 = vectordot(var_5, var_2) * var_2;
    var_7 = var_5 - var_6;
    var_8 = var_7 + var_6 / level._id_CC20[var_3];
  } else {
    var_8 = var_0 - var_1;
    var_8 = (var_8[0], var_8[1], 0);
  }

  var_9 = _func_0135(var_8);

  if(var_9 > level._id_CC1E[var_3] * level._id_CC1E[var_3]) {
    return 0;
  }

  if(var_9 < level._id_CC1F[var_3] * level._id_CC1F[var_3]) {
    return 1;
  }

  var_10 = _func_0218(var_9);
  var_11 = (var_10 - level._id_CC1F[var_3]) / (level._id_CC1E[var_3] - level._id_CC1F[var_3]);
  return 1 - var_11;
}