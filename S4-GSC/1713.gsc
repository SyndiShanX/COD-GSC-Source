/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1713.gsc
*************************************************/

_id_8285(var_0) {
  if(!isDefined(self._id_0B67._id_CF24)) {
    self._id_0B67._id_CF24 = [];
  }

  if(!isDefined(self._id_0B67._id_CF24[var_0])) {
    self._id_0B67._id_CF24[var_0] = spawnStruct();
    self._id_0B67._id_CF24[var_0]._id_E747 = "normal";
  }
}

_id_D398(var_0, var_1) {
  if(self._id_0B67._id_CF24[var_0]._id_E747 == "dismember") {
    return;
  }
  if(self._id_0B67._id_CF24[var_0]._id_E747 != "normal" && var_1 != "dismember") {
    self._id_0B67._id_CF24[var_0]._id_E747 = self._id_0B67._id_CF24[var_0]._id_E747 + "_both";
  } else {
    self._id_0B67._id_CF24[var_0]._id_E747 = var_1;
  }

  self._id_0B67._id_CF24[var_0]._id_F1E8 = gettime();
}

_id_D399(var_0, var_1, var_2) {
  self endon("entitydeleted");
  _id_D398(var_0, var_1);

  if(isDefined(var_2)) {
    wait(var_2);
  }

  if(isDefined(self._id_CF20)) {
    return 1;
  }

  var_3 = self._id_0B67._id_CF24[var_0]._id_E747;

  if(isDefined(anim._id_4B44[self._id_04B9])) {
    if(var_0 != "head" && var_3 != "dismember") {
      if(_id_FE4B(self._id_04B9)) {
        var_3 = var_3 + "_lite";
      }
    }
  }

  self setscriptablepartstate(var_0, var_3);
}

_id_D514(var_0) {
  var_1 = var_0 + "_dism_fx";
  var_2 = _id_673A(var_0);

  if(var_2 == "normal") {
    var_2 = "undamaged";
  } else if(issubstr(var_2, "_both")) {
    var_2 = "dmg_both";
  }

  if(!isDefined(level._id_7D7F) && isDefined(anim._id_4B44[self._id_04B9])) {
    if(var_0 != "head") {
      if(_id_FE4B(self._id_04B9)) {
        var_2 = var_2 + "_lite";
      }
    }
  }

  self setscriptablepartstate(var_1, var_2);
}

_id_FE4B(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < anim._id_4B44[var_0].size; var_2++) {
    if(gettime() - anim._id_4B44[var_0][var_2] > 1000) {
      continue;
    }
    var_1[var_1.size] = anim._id_4B44[var_0][var_2];
  }

  if(var_1.size < 0) {
    var_1[var_1.size] = gettime();
    anim._id_4B44[var_0] = var_1;
    return 0;
  }

  anim._id_4B44[var_0] = var_1;
  return 1;
}

_id_673A(var_0) {
  if(!isDefined(self._id_0B67._id_CF24)) {
    return "normal";
  }

  if(!isDefined(self._id_0B67._id_CF24[var_0])) {
    return "normal";
  }

  return self._id_0B67._id_CF24[var_0]._id_E747;
}

_id_1912() {
  if(_id_673A("left_leg") == "dismember" || _id_673A("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

_id_292F() {
  if(_id_673A("left_leg") == "dismember" && _id_673A("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

_id_1911() {
  if(_id_673A("left_arm") == "dismember" || _id_673A("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_C85A() {
  if(_id_673A("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_9193() {
  if(_id_673A("left_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_292E() {
  if(_id_673A("left_arm") == "dismember" && _id_673A("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}