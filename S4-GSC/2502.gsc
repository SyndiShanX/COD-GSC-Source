/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2502.gsc
*************************************************/

registersharedfunc(var_0, var_1, var_2) {
  if(!isDefined(level._id_D9B7)) {
    level._id_D9B7 = [];
  }

  if(!isDefined(level._id_D9B7[var_0])) {
    level._id_D9B7[var_0] = [];
  }

  level._id_D9B7[var_0][var_1] = var_2;
}

issharedfuncdefined(var_0, var_1, var_2) {
  if(!isDefined(level._id_D9B7)) {
    return 0;
  }

  if(!isDefined(level._id_D9B7[var_0])) {
    return 0;
  }

  var_3 = level._id_D9B7[var_0][var_1];

  if(!isDefined(var_3)) {
    if(istrue(var_2)) {}

    return 0;
  }

  return 1;
}

getsharedfunc(var_0, var_1) {
  return level._id_D9B7[var_0][var_1];
}