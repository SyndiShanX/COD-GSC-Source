/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\melee_mp.gsc
*************************************************/

_id_821F(var_0) {
  return anim._id_EACB;
}

meleecharge_updatemp(var_0) {
  if(_id_06B3::_id_9D71()) {
    if(isDefined(self._id_9D39)) {
      self._id_9D39._id_2059 = 1;
    }

    return anim._id_58E3;
  }

  var_1 = self._id_2C5E._id_82FD[var_0];
  var_2 = gettime();
  var_3 = self._id_9D99;

  if(!isDefined(var_3)) {
    var_3 = 4096;
  }

  var_4 = self._id_9D39.target;

  if(isDefined(self._id_9D65) || isDefined(self._id_9D8D)) {
    var_5 = distance2dsquared(var_4.origin, self.origin);
  } else {
    var_5 = distancesquared(var_4.origin, self.origin);
  }

  var_6 = _id_06B3::_id_6B53(var_4) + 24;
  var_7 = var_6 * var_6;

  if(var_5 > var_7) {
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  var_8 = isPlayer(var_4);

  if(var_8) {
    var_9 = _func_02AB(var_4.origin, self);
  } else {
    var_9 = var_4 _meth_84DC();
  }

  var_10 = var_3;
  var_11 = length(self._id_04DF);

  if(var_11 > 1) {
    var_10 = _func_0219(_func_0218(var_3) + var_11 * (level._id_01E2 / 1000));
  }

  if(var_5 <= var_10) {
    if(isPlayer(var_4)) {
      if(var_4 scripts\common\utility::_id_9D8A()) {
        return anim._id_CA5F;
      }
    }

    if(isDefined(self._id_9D64) && var_5 <= self._id_9D64 * self._id_9D64) {
      self._id_9D39._id_242E = 1;
      return anim._id_EACB;
    }

    var_12 = 18;

    if(isDefined(self._id_03FF) && self._id_03FF != "none" && isPlayer(var_4)) {
      var_12 = 32;
    }

    var_13 = self _meth_84DC();

    if(self[[self._id_5D6C]](var_13, var_9)) {
      if(isDefined(self._id_9D8D) || abs(self.origin[2] - var_4.origin[2]) < var_12) {
        self._id_9D39._id_242E = 1;
        return anim._id_EACB;
      }
    }

    if(isDefined(self._id_0323) && distance2dsquared(self.origin, self._id_0323) < 4) {
      _id_06B3::_id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  if(self._id_0084 || var_2 > var_1._id_3534 && !isDefined(self._id_0323) && !istrue(self._id_0324)) {
    _id_06B3::_id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(!istrue(self._id_9D39._id_2505)) {
    if(var_2 >= var_1._id_F224) {
      _id_06B3::_id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  if(!istrue(self._id_9D39._id_2504)) {
    if(isDefined(self._id_9D65)) {
      var_14 = distance2dsquared(var_4.origin, var_1._id_542B);
    } else {
      var_14 = distancesquared(var_4.origin, var_1._id_542B);
    }

    if(var_14 > 16384) {
      _id_06B3::_id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  var_15 = undefined;

  if(isDefined(self._id_0323) && var_2 > var_1._id_3534) {
    var_15 = self _meth_8473();
  }

  if(isDefined(var_1._id_BC53) && isDefined(var_15) && var_15 - var_1._id_BC53 > 72) {
    _id_06B3::_id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(isDefined(var_15)) {
    var_1._id_BC53 = var_15;

    if(!scripts\common\utility::_id_854B("melee_rusher") && var_15 > _id_06B3::getmeleechargemaxpathdist(var_4)) {
      _id_06B3::_id_9D6E(var_4);
      self._id_9D39._id_2059 = 1;
      return anim._id_58E3;
    }
  }

  var_16 = undefined;

  if(isDefined(self._id_0323) && var_2 > var_1._id_3534) {
    var_16 = self._id_027F;
  }

  if(isDefined(var_1._id_BC54) && isDefined(var_16) && vectordot(var_16, var_1._id_BC54) < -0.866) {
    _id_06B3::_id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  if(isDefined(var_16)) {
    var_1._id_BC54 = var_16;
  }

  var_17 = max(_func_0218(var_3) - 24, 0);
  var_18 = vectornormalize(self.origin - var_4.origin);
  var_19 = scripts\engine\utility::ter_op(isPlayer(var_4) && istrue(self._id_9DAA), var_4.origin, var_4.origin + var_18 * var_17);
  var_20 = 36;

  if(isDefined(self._id_9DA9)) {
    var_20 = self._id_9DA9;
  }

  var_21 = 0;

  if(!_id_06B3::_id_9D70(var_0, var_19)) {
    var_22 = _func_02AB(var_19, self);
    var_21 = distance2dsquared(var_19, var_22) > var_20;

    if(!var_21) {
      var_21 = !self[[self._id_5D6C]](var_22, var_9);
    }
  }

  if(var_21 && istrue(self._id_9DAA)) {
    if(isDefined(var_4._id_02ED)) {
      if(scripts\engine\utility::_id_8946(var_4._id_02ED)) {
        var_23 = anglestoleft(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin + var_23 * var_17;
      } else if(scripts\engine\utility::_id_8948(var_4._id_02ED)) {
        var_24 = anglestoright(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin + var_24 * var_17;
      } else {
        var_25 = anglesToForward(var_4._id_02ED.angles);
        var_19 = var_4._id_02ED.origin - var_25 * var_17;
      }

      if(!_id_06B3::_id_9D70(var_0, var_19)) {
        var_22 = _func_02AB(var_19, self);
        var_21 = distance2dsquared(var_19, var_22) > var_20;
      }
    }
  }

  if(var_21) {
    _id_06B3::_id_9D6E(var_4);
    self._id_9D39._id_2059 = 1;
    return anim._id_58E3;
  }

  var_26 = 1;

  if(scripts\common\utility::_id_854B("melee_rusher")) {
    var_26 = 2;
  }

  self _meth_84BC(var_26, var_19);
  self _meth_8600(var_26, 6);
  var_1._id_EEF5 = var_19;
  _id_06BD::_id_23F1(var_4, var_19);
  self._id_A4B0 = 0;
  self._id_8FD2 = undefined;

  if(var_8) {
    self._id_01CF = 1;
  }

  return anim._id_CA5F;
}