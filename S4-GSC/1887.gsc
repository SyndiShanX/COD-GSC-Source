/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1887.gsc
*************************************************/

_id_408A(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 1000);
  return var_2;
}

_id_1FAE(var_0) {
  foreach(var_2 in level._id_7177) {
    if(!isDefined(var_2) || !var_2 _id_8843(self)) {
      continue;
    } else if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
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

  return 1000;
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
    return 1000;
  } else if(isDefined(var_0._id_15DC)) {
    return 1000;
  } else if(_func_01A5(var_0.origin)) {
    return 0;
  } else {
    return 1000;
  }
}

_id_E1C4(var_0) {
  if(distancesquared(scripts\cp\utility::_id_63BD(level.players), var_0.origin) >= 16777216) {
    return 0;
  } else {
    return 1000;
  }
}