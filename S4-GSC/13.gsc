/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 13.gsc
*************************************************/

_id_019C(var_0, var_1) {
  if(!isDefined(var_0._id_83A2)) {
    return;
  }
  if(!isDefined(level._id_83A3)) {
    return;
  }
  if(!isDefined(level._id_83A3[var_0._id_83A2])) {
    return;
  }
  thread[[level._id_83A3[var_0._id_83A2]]](var_0, var_1);
}

_id_8397(var_0, var_1) {
  if(!isDefined(level._id_83A3)) {
    level._id_83A3 = [];
    level._id_83A4 = 0;
  }

  if(!isDefined(var_1)) {
    while(isDefined(level._id_83A3[level._id_83A4])) {
      level._id_83A4++;
    }

    var_1 = level._id_83A4;
    level._id_83A4++;
  }

  level._id_83A3[var_1] = var_0;
  return var_1;
}

_id_8398(var_0) {
  self._id_83A2 = var_0;
}

_id_839F() {
  self._id_83A2 = undefined;
}