/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1953.gsc
*************************************************/

_id_CF14(var_0) {
  if(!isDefined(level._id_CF06)) {
    level._id_CF06 = [];
  }

  level._id_CF06 = scripts\engine\utility::array_add(level._id_CF06, var_0);
}

_id_CEF7() {
  if(isDefined(level._id_CF06)) {
    foreach(var_1 in level._id_CF06)[[var_1]]();
  }
}

_id_CEC9(var_0) {
  if(!isDefined(level._id_CF12)) {
    level._id_CF12 = [];
  }

  level._id_CF12 = scripts\engine\utility::array_add(level._id_CF12, var_0);
}

_id_CEF9() {
  if(isDefined(level._id_CF12)) {
    foreach(var_1 in level._id_CF12)[[var_1]]();
  }
}

_id_CECB(var_0) {
  if(!isDefined(level._id_CF1B)) {
    level._id_CF1B = [];
  }

  level._id_CF1B = scripts\engine\utility::array_add(level._id_CF1B, var_0);
}

_id_CECC(var_0, var_1) {
  if(!isDefined(level._id_CF1A)) {
    level._id_CF1A = [];
  }

  if(!isDefined(level._id_CF1A[var_0])) {
    level._id_CF1A[var_0] = [];
  }

  level._id_CF1A[var_0][level._id_CF1A[var_0].size] = var_1;
}

_id_CEC6(var_0) {
  if(!isDefined(level._id_CECE)) {
    level._id_CECE = [];
  }

  level._id_CECE = scripts\engine\utility::array_add(level._id_CECE, var_0);
}

_id_CEFB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_4)) {
    if(isDefined(level._id_CECE)) {
      foreach(var_7 in level._id_CECE)[[var_7]](var_0, var_1, var_2, var_3, 1, var_5);
    }
  } else {
    if(isDefined(level._id_CF1B)) {
      foreach(var_7 in level._id_CF1B)[[var_7]](var_0, var_1, var_2, var_3, 0, var_5);
    }

    if(isDefined(level._id_CF1A) && isDefined(level._id_CF1A[var_1])) {
      foreach(var_7 in level._id_CF1A[var_1])[[var_7]](var_0, var_1, var_2, var_3, 1, var_5);
    }
  }
}

_id_CECA(var_0) {
  if(!isDefined(level._id_CF18)) {
    level._id_CF18 = [];
  }

  level._id_CF18 = scripts\engine\utility::array_add(level._id_CF18, var_0);
}

_id_CEFA(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_CF18)) {
    foreach(var_5 in level._id_CF18)[[var_5]](var_0, var_1, var_2, var_3);
  }
}

_id_CEC8(var_0, var_1) {
  if(!isDefined(level._id_CF0D)) {
    level._id_CF0D = [];
  }

  if(!isDefined(level._id_CF0D[var_0])) {
    level._id_CF0D[var_0] = [];
  }

  level._id_CF0D[var_0][level._id_CF0D.size] = var_1;
}

_id_CEF8(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(level._id_CF0D)) {
    return;
  }
  var_4 = level._id_CF0D[var_3];

  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  foreach(var_6 in var_4) {
    if(isDefined(var_2)) {
      var_2[[var_6]](var_0, var_1);
      continue;
    }

    level[[var_6]](var_0, var_1);
  }
}

_id_CEC7(var_0) {
  if(!isDefined(level._id_CED8)) {
    level._id_CED8 = [];
  }

  level._id_CED8 = scripts\engine\utility::array_add(level._id_CED8, var_0);
}

scriptable_removedamagecallback(var_0) {
  if(!isDefined(level._id_CED8)) {
    return;
  }
  level._id_CED8 = scripts\engine\utility::array_remove(level._id_CED8, var_0);
}

_id_CEF6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(level._id_CED8)) {
    if(isDefined(var_7) || isDefined(var_11) && !isvector(var_11) || isDefined(var_10) && !isweapon(var_10)) {
      var_14 = var_11;
      var_13 = undefined;
      var_12 = var_10;
      var_11 = var_9;
      var_10 = var_8;
      var_9 = var_7;
      var_8 = var_6;
      var_7 = undefined;
      var_6 = undefined;
    }

    foreach(var_16 in level._id_CED8) {
      level[[var_16]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    }
  }
}