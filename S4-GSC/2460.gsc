/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2460.gsc
*************************************************/

_id_807C() {
  level._id_11043 = [];
  level._id_11023 = [];
  level._id_11042 = [];
  level._id_A75A = 0;
  setdvarifuninitialized("#x32ab057d267bb9b88", 0);
}

_id_E636() {
  if(scripts\cp\utility::_id_857B()) {
    return;
  }
  foreach(var_2, var_1 in level._id_11043) {
    level thread _id_E635(var_2);
  }
}

_id_E635(var_0) {
  var_1 = level._id_11043[var_0];
  level._id_11042[var_0] = -1;

  foreach(var_4, var_3 in var_1) {
    level._id_11023[var_0] = var_4;
    [[var_3._id_7F8B]]();

    if(_id_DA8F(var_0, var_4)) {
      [[var_3._id_BEAA]]();
    }

    [[var_3._id_3B10]]();
  }
}

_id_C211(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_11043[var_0])) {
    level._id_11043[var_0] = [];
  }

  if(!isDefined(level._id_11042[var_0])) {
    level._id_11042[var_0] = -1;
  }

  var_6 = spawnStruct();
  var_6._id_7F8B = var_2;
  var_6._id_BEAA = var_3;
  var_6._id_3B10 = var_4;
  var_6._id_442E = var_5;
  level._id_11043[var_0][var_1] = var_6;
}

_id_DA8F(var_0, var_1) {
  return var_1 > level._id_11042[var_0];
}

_id_BEA5(var_0) {
  return isDefined(level._id_11043[var_0]);
}