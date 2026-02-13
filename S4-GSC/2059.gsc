/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2059.gsc
*************************************************/

_id_8A09(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

_id_C87D() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(_id_8A09(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

_id_C87C() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(_id_8A09(var_3)) {
      var_0++;
    }

    if(var_0 == 2) {
      break;
    }
  }

  return var_0 == 2;
}

_id_C875(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self._id_C887 = var_1;
    var_2 = "j_shield_ri";
  } else {
    self._id_C888 = var_1;
    var_2 = "tag_shield_back";
  }

  self _meth_8021(var_1, var_2);
  self._id_75A5 = _id_C87D();
}

_id_C878(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self._id_C887;
    var_2 = "j_shield_ri";
  } else {
    var_1 = self._id_C888;
    var_2 = "tag_shield_back";
  }

  self _meth_809F(var_1, var_2);

  if(var_0) {
    self._id_C887 = undefined;
  } else {
    self._id_C888 = undefined;
  }

  self._id_75A5 = _id_C87D();
}

_id_C880(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self._id_C887;
    var_1 = "j_shield_ri";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self._id_C888;
    var_1 = "tag_shield_back";
    var_2 = "j_shield_ri";
  }

  self _meth_823A(var_3, var_1, var_2);

  if(var_0) {
    self._id_C888 = var_3;
    self._id_C887 = undefined;
  } else {
    self._id_C887 = var_3;
    self._id_C888 = undefined;
  }
}

_id_C877() {
  self._id_75A5 = 0;
  self._id_C888 = undefined;
  self._id_C887 = undefined;
}

_id_C87A() {
  return "wm_shield_00";
}

_id_D5B0() {
  self._id_7D32 = 1;
}

_id_3945() {
  self._id_7D32 = undefined;
}