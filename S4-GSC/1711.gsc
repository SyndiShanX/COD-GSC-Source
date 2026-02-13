/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1711.gsc
*************************************************/

_id_C79E(var_0, var_1) {
  if(var_1 == 1) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_8AF4(var_0, var_1) {
  if(isDefined(var_1)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_D8C1(var_0) {
  self._id_2C5E._id_82FD[var_0] = [];
  self._id_2C5E._id_82FD[var_0]["waitStartTime"] = gettime();
}

_id_4EAA(var_0, var_1) {
  var_2 = self._id_2C5E._id_82FD[var_0]["waitStartTime"];

  if(gettime() - var_2 < var_1) {
    return anim._id_CA5F;
  }

  return anim._id_EACB;
}

_id_7581(var_0, var_1) {
  var_2 = var_1;

  if(self _meth_8067(var_2)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_FF6F(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];

  if(var_3 <= var_2 && var_2 <= var_4) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_BFD3(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];

  if(randomint(var_2) < var_3) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

cointoss(var_0) {
  if(randomint(100) < 50) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_7CFB(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self;
  }

  return isalive(var_2);
}

_id_7CFC(var_0) {
  if(_id_06BD::_id_23DB()) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}