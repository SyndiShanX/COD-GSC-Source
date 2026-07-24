/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2578.gsc
**************************************/

_id_C565(var_0) {
  if(isDefined(self._id_C9B4))
    return anim.success;

  return anim.failure;
}

_id_F7B2(var_0) {
  var_1 = self._id_C9B4;

  if(!isDefined(var_1._id_D648) || !isDefined(var_1._id_D642) || !isDefined(var_1._id_1119D))
    return anim.failure;

  if(var_1._id_1119D == "loop") {
    var_1._id_D642 = var_1._id_D642 + 1;

    if(var_1._id_D642 >= var_1._id_D648.size)
      var_1._id_D642 = 0;
  } else if(var_1._id_1119D == "bounce") {
    if(!isDefined(var_1._id_54DA))
      var_1._id_54DA = 1;

    var_1._id_D642 = var_1._id_D642 + var_1._id_54DA;

    if(var_1._id_D642 >= var_1._id_D648.size) {
      var_1._id_D642 = var_1._id_D648.size - 2;
      var_1._id_54DA = -1;
    } else if(var_1._id_D642 < 0) {
      var_1._id_D642 = 1;
      var_1._id_54DA = 1;
    }
  } else {}

  self _meth_82EE(var_1._id_D648[var_1._id_D642]._id_D6A8);
  return anim.success;
}

_id_8471(var_0, var_1) {
  var_2 = self._id_C9B4;
  var_3 = var_2._id_D648[var_2._id_D642];
  var_4 = distancesquared(var_3, self.origin);
  var_5 = var_1;

  if(var_5 < 1)
    var_5 = 1;

  if(var_4 <= var_5 * var_5)
    return anim.success;

  return anim.running;
}

_id_9ED9(var_0, var_1) {
  var_2 = var_1;
  var_3 = self._id_C9B4;
  var_4 = var_3._id_D648[var_3._id_D642];

  if(var_4._id_1119D == var_2)
    return anim.success;
}

_id_D4A0(var_0) {
  var_1 = self._id_C9B4;
  var_2 = var_1._id_D648[var_1._id_D642]._id_92F3;

  if(!isDefined(var_2))
    return anim.failure;

  return anim.running;
}