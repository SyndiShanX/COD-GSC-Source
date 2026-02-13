/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2466.gsc
*************************************************/

_id_80B6() {
  if(!isDefined(level._id_E0FB)) {
    level._id_E0FB = 250000;
  }
}

_id_CBEA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = [[var_1]](var_2, var_3);
  } else {
    var_4 = [[var_1]](var_2);
  }

  var_4 = clamp(var_4, 0, 100);
  var_4 = var_4 * var_0;
  var_2._id_F37D = var_2._id_F37D + 100 * var_0;
  var_2._id_903B[self.team] = var_2._id_903B[self.team] + var_4;
  return var_4;
}

_id_408A(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

_id_1FA3(var_0) {
  foreach(var_2 in level._id_326E) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

_id_1FAE(var_0) {
  foreach(var_2 in level._id_7177) {
    if(!isDefined(var_2) || !var_2 _id_8843(self)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

_id_1FB2(var_0) {
  var_1 = level._id_9EE2;

  if(isDefined(level._id_B15C)) {
    var_1 = scripts\engine\utility::array_combine(level._id_9EE2, level._id_B15C);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 _id_8843(self)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

_id_8843(var_0) {
  if(!level.teambased || level._id_5FA5 || !isDefined(var_0.team)) {
    return 1;
  } else {
    var_1 = undefined;

    if(isDefined(self.owner)) {
      if(var_0 == self.owner) {
        return 1;
      }

      var_1 = self.owner.team;
    }

    if(isDefined(var_1)) {
      return var_1 != var_0.team;
    } else {
      return 1;
    }
  }
}

_id_1FBD(var_0) {
  if(isDefined(self._id_15DC)) {
    return 100;
  }

  if(isDefined(var_0._id_15DC)) {
    return 100;
  }

  if(_func_01A5(var_0.origin)) {
    return 0;
  }

  return 100;
}

_id_1FBA(var_0) {
  if(isDefined(self._id_904C) && self._id_904C == var_0) {
    return 0;
  }

  return 100;
}

_id_C017(var_0) {
  return randomintrange(0, 99);
}

_id_9C94(var_0) {
  return 3240000;
}