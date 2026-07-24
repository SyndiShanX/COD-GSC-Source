/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2660.gsc
**************************************/

_id_4941(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_D928))
    level._id_D928 = [];

  var_6 = spawnStruct();
  var_6._id_B437 = var_1;
  var_6._id_A017 = var_3;
  var_6._id_A01E = var_4;
  var_6._id_DB03 = var_5;
  var_6._id_D926 = [];

  foreach(var_8 in var_2)
  var_6._id_D926[var_8] = [];

  level._id_D928[var_0] = var_6;
}

_id_16F6(var_0, var_1, var_2) {
  if(_id_FF7D(var_1))
    _id_DB03(var_1);

  if(!_id_37F4(var_0, var_1, var_2)) {
    return;
  }
  _id_E044(var_0, var_1);

  if(_id_FF84(var_1, var_2))
    _id_E063(var_1, var_2);

  _id_16F7(var_0, var_1, var_2);
}

_id_37F4(var_0, var_1, var_2) {
  if(_id_7B3E(var_1, var_2) == _id_7BE1(var_1))
    return 0;

  return 1;
}

_id_E043(var_0, var_1) {
  _id_E044(var_0, var_1);
}

_id_E044(var_0, var_1) {
  foreach(var_4, var_3 in level._id_D928[var_1]._id_D926) {
    if(scripts\engine\utility::array_contains(var_3, var_0)) {
      level._id_D928[var_1]._id_D926[var_4] = scripts\engine\utility::array_remove(var_3, var_0);
      [[_id_7966(var_1)]](var_0);
    }
  }
}

_id_FF84(var_0, var_1) {
  if(_id_9C99(var_0))
    return 1;

  return 0;
}

_id_9C99(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in level._id_D928[var_0]._id_D926)
  var_1 = var_1 + var_3.size;

  return level._id_D928[var_0]._id_B437 == var_1;
}

_id_DB03(var_0) {
  foreach(var_3, var_2 in level._id_D928[var_0]._id_D926)
  level._id_D928[var_0]._id_D926[var_3] = scripts\engine\utility::array_removeundefined(level._id_D928[var_0]._id_D926[var_3]);
}

_id_7B3E(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in level._id_D928[var_0]._id_D926) {
    if(var_5 == var_1) {
      break;
    }

    var_2 = var_2 + level._id_D928[var_0]._id_D926[var_5].size;
  }

  return var_2;
}

_id_E063(var_0, var_1) {
  var_2 = _id_7CDF(var_0, var_1);
  _id_E062(var_0, var_2);
}

_id_7CDF(var_0, var_1) {
  var_2 = undefined;

  foreach(var_1, var_4 in level._id_D928[var_0]._id_D926) {
    if(level._id_D928[var_0]._id_D926[var_1].size > 0)
      var_2 = var_1;
  }

  return var_2;
}

_id_16F7(var_0, var_1, var_2) {
  [[_id_77D1(var_1)]](var_0);
  level._id_D928[var_1]._id_D926[var_2][level._id_D928[var_1]._id_D926[var_2].size] = var_0;
}

_id_E062(var_0, var_1) {
  var_2 = _id_7B49(var_0, var_1);
  [[_id_7966(var_0)]](var_2);
  level._id_D928[var_0]._id_D926[var_1] = scripts\engine\utility::array_remove(level._id_D928[var_0]._id_D926[var_1], var_2);
}

_id_FF7D(var_0) {
  return level._id_D928[var_0]._id_DB03;
}

_id_7B49(var_0, var_1) {
  return level._id_D928[var_0]._id_D926[var_1][0];
}

_id_7BE1(var_0) {
  return level._id_D928[var_0]._id_B437;
}

_id_77D1(var_0) {
  return level._id_D928[var_0]._id_A017;
}

_id_7966(var_0) {
  return level._id_D928[var_0]._id_A01E;
}