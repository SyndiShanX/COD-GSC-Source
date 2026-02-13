/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1724.gsc
*************************************************/

_id_FD86(var_0) {
  if(isDefined(anim._id_10DDB) && isDefined(self._id_5E99)) {
    _id_06BD::_id_23B7();
    self[[anim._id_10DDB]]();
    return anim._id_EACB;
  }

  if(istrue(self._id_0380) || isDefined(self._id_04F6) && self._id_04F6.basename == "s4_pi_wecho") {
    if(!_id_06AC::_id_753C(0.2)) {
      _id_06AC::_id_C30E();
    }
  }

  return anim._id_58E3;
}

_id_82BB() {
  self.weapons = [];

  if(!isnullweapon(self._id_034C)) {
    self.weapons[self.weapons.size] = self._id_034C;
  }

  if(!isnullweapon(self._id_03B5)) {
    self.weapons[self.weapons.size] = self._id_03B5;
  }

  if(!isnullweapon(self._id_03D6)) {
    self.weapons[self.weapons.size] = self._id_03D6;
  }
}

_id_35D5() {
  if(istrue(self._id_01D1)) {
    return "pistol";
  }

  if(istrue(self._id_0B67._id_0187)) {
    return "pistol";
  }

  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in self.weapons) {
    var_4 = weaponclass(var_3);
    var_5 = _id_567F(var_4, var_3);

    if(var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_6D2A() {
  var_0 = scripts\anim\utility_common::_id_8AD4();
  var_1 = 409;
  var_2 = scripts\anim\utility_common::_id_8766(0);

  if(var_2) {
    var_1 = 512;
  }

  if(var_0) {
    var_1 = var_1 + 36;
  }

  return var_1;
}

_id_10E82() {
  if(isDefined(self._id_0192) && isDefined(self._id_03D6) && !isnullweapon(self._id_03D6) && !istrue(self._id_0168)) {
    var_0 = _id_6D2A();
    var_1 = distancesquared(self.origin, self._id_0192.origin);
    return var_1 < var_0 * var_0;
  }

  return 0;
}

_id_567F(var_0, var_1) {
  if(var_0 == "pistol") {
    if(weaponclass(self._id_04F6) == "rocketlauncher" && self._id_037B <= 0) {
      return 1000;
    }

    if(_id_31EC(undefined) != anim._id_EACB) {
      return 0;
    }

    var_2 = _id_06BD::_id_23BC();

    if(scripts\anim\utility_common::_id_FF0F() && isDefined(var_2) && !self _meth_81BB(var_2)) {
      return 1000;
    }

    if(_id_34EC(undefined) != anim._id_EACB) {
      return 0;
    }

    var_3 = _id_10E82();
    var_4 = scripts\anim\utility_common::_id_8766(0);

    if(var_3) {
      var_5 = distancesquared(self.origin, self._id_0192.origin);

      if(var_4) {
        return 1000;
      }

      if(scripts\anim\utility_common::_id_FF0F() && var_5 < 16384) {
        return 1000;
      }

      if(scripts\anim\utility_common::_id_8ACD() && _id_06AC::_id_753C(0.1)) {
        return 10;
      }

      return 1000;
    }

    return 0;
  } else if(var_0 == "rocketlauncher") {
    if(self._id_037B <= 0) {
      return 0;
    }

    return 100;
  } else
    return 100;

  return 100;
}

_id_8A41(var_0) {
  if(scripts\anim\utility_common::_id_8766()) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_FF1D(var_0) {
  if(self._id_04F6 == self._id_03D6 && !isnullweapon(self._id_04F6)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_DBF7(var_0) {
  if(_id_FF1D(var_0) == anim._id_EACB) {
    return anim._id_58E3;
  }

  if(istrue(self._id_01D1)) {
    return anim._id_EACB;
  }

  if(_id_31EC(var_0) != anim._id_EACB) {
    return anim._id_58E3;
  }

  if(_id_34EC(var_0) != anim._id_EACB) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_31EC(var_0) {
  if(istrue(self._id_0168)) {
    return anim._id_58E3;
  }

  if(_id_06BD::_id_23E5() && isDefined(self._id_0323) && _func_0134(self._id_04DF) > 1) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_9D39)) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_34EC(var_0) {
  var_1 = _id_06BD::_id_23BC();

  if(isDefined(var_1) && distance(self.origin, var_1.origin) < 16) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_10D67() {
  if(isDefined(self._id_03D6) && isDefined(self._id_04F6) && self._id_04F6 == self._id_03D6 && (istrue(self._id_01D1) || istrue(self._id_0B67._id_0187))) {
    return 0;
  }

  return 1;
}