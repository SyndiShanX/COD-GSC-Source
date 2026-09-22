/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1368.gsc
**************************************/

_id_4746(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    _id_050E::_id_534D(var_5);

    if(var_5 _id_055A::_id_905D() && var_5 _id_055A::_id_905C(var_1, var_2)) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size) {
    var_7 = _id_80AF(var_3, var_1, var_2);
  } else {
    if(!isDefined(self._id_9070)) {
      self._id_9070 = spawnStruct();
    }

    var_7 = _id_050E::scragentsetgoalentity(self.team, var_0, self._id_9070);
  }

  return var_7;
}

_id_80AF(var_0, var_1, var_2) {
  var_3 = var_0[0];

  foreach(var_5 in var_0) {
    thermalvisionoff(var_5, var_1, var_2);

    if(!isDefined(var_3) || var_5._id_9AB8 > var_3._id_9AB8) {
      var_3 = var_5;
    }
  }

  return var_3;
}

thermalvisionoff(var_0, var_1, var_2) {
  var_3 = setModel(2.0, ::_id_766A, var_0);
  var_0._id_9AB8 = var_0._id_9AB8 + var_3;
  var_3 = setModel(1.0, ::_id_144B, var_0);
  var_0._id_9AB8 = var_0._id_9AB8 + var_3;
  var_3 = setModel(6.0, ::_id_6025, var_0, var_1, var_2);
  var_0._id_9AB8 = var_0._id_9AB8 + var_3;
}

_id_6025(var_0, var_1, var_2) {
  if(var_0 _id_055A::_id_905C(var_1, var_2)) {
    return 100;
  }

  return 0;
}

_id_766A(var_0) {
  if(!isDefined(var_0._id_AC8A)) {
    return 0;
  }

  if(_id_055A::_id_5780(var_0._id_AC8A)) {
    return 100;
  }

  return 0;
}

_id_144B(var_0) {
  if(isDefined(var_0._id_5BE2)) {
    var_1 = gettime() - var_0._id_5BE2;

    if(var_1 > 30000) {
      return 100;
    }

    return var_1 / 30000 * 100;
  }

  return 100;
}

_id_7665(var_0) {
  if(!isDefined(var_0._id_AC8A)) {
    return 0;
  }

  var_1 = _id_055A::_id_45BF(var_0._id_AC8A);

  if(var_1 == 0) {
    return 0;
  }

  return 100 * (1.0 - var_1 * 0.15);
}

setModel(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = [[var_1]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = [[var_1]](var_2, var_3);
  } else {
    var_5 = [[var_1]](var_2);
  }

  var_5 = clamp(var_5, 0, 100);
  var_5 = var_5 * var_0;
  return var_5;
}