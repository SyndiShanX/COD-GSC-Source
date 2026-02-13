/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2703.gsc
*************************************************/

_id_509C(var_0, var_1, var_2, var_3) {
  var_0 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarint(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

_id_509A(var_0, var_1, var_2, var_3) {
  var_0 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarfloat(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

_id_C2CB(var_0, var_1) {
  var_2 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);

  if(getdvarint(var_2, -1) == -1) {
    setDvar(var_2, var_1);
  }

  level._id_10AD4[var_2] = spawnStruct();
  level._id_10AD4[var_2]._id_04CB = getdvarint(var_2, var_1);
  level._id_10AD4[var_2].type = "int";
  level._id_10AD4[var_2]._id_A6B5 = "update_" + var_0;
}

_id_C2CA(var_0, var_1) {
  var_2 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);

  if(getdvarfloat(var_2, -1) == -1) {
    setDvar(var_2, var_1);
  }

  level._id_10AD4[var_2] = spawnStruct();
  level._id_10AD4[var_2]._id_04CB = getdvarfloat(var_2, var_1);
  level._id_10AD4[var_2].type = "float";
  level._id_10AD4[var_2]._id_A6B5 = "update_" + var_0;
}

_id_C2C9(var_0, var_1) {
  var_2 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);

  if(getDvar(var_2, "") == "") {
    setDvar(var_2, var_1);
  }

  level._id_10AD4[var_2] = spawnStruct();
  level._id_10AD4[var_2]._id_04CB = getDvar(var_2, var_1);
  level._id_10AD4[var_2].type = "string";
  level._id_10AD4[var_2]._id_A6B5 = "update_" + var_0;
}

_id_D633(var_0, var_1) {
  var_0 = _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);
  level._id_AD6A[var_0] = var_1;
}

getwatcheddvar(var_0) {
  var_0 = _id_6E56(var_0);

  if(isDefined(level._id_AD6A) && isDefined(level._id_AD6A[var_0])) {
    return level._id_AD6A[var_0];
  } else if(isDefined(level._id_10AD4) && isDefined(level._id_10AD4[var_0]) && isDefined(level._id_10AD4[var_0]._id_04CB)) {
    return level._id_10AD4[var_0]._id_04CB;
  } else {
    return undefined;
  }
}

_id_6E56(var_0) {
  return _func_0483("#x3ecead486797add6d", level.gametype, "_", var_0);
}

_id_FD84() {
  var_0 = getarraykeys(level._id_10AD4);

  foreach(var_2 in var_0) {
    if(level._id_10AD4[var_2].type == "string") {
      var_3 = _id_6C91(var_2, level._id_10AD4[var_2]._id_04CB);
    } else if(level._id_10AD4[var_2].type == "float") {
      var_3 = _id_6A4F(var_2, level._id_10AD4[var_2]._id_04CB);
    } else {
      var_3 = _id_6AC8(var_2, level._id_10AD4[var_2]._id_04CB);
    }

    if(var_3 != level._id_10AD4[var_2]._id_04CB) {
      level._id_10AD4[var_2]._id_04CB = var_3;
      level notify(level._id_10AD4[var_2]._id_A6B5, var_3);
    }
  }
}

_id_FD83() {
  while(game["state"] == "playing") {
    _id_FD84();
    wait 1.0;
  }
}

_id_6C91(var_0, var_1) {
  var_2 = var_1;
  var_2 = getDvar(var_0, var_1);
  return var_2;
}

_id_6AC8(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

_id_6A4F(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

_id_6BFD(var_0, var_1) {
  return getdvarint(var_0, getdvarint(var_1));
}

_id_6BFB(var_0, var_1) {
  return getdvarfloat(var_0, getdvarfloat(var_1));
}

_id_6BF9(var_0, var_1) {
  return getDvar(var_0, getDvar(var_1));
}