/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1722.gsc
*************************************************/

_id_F18C(var_0) {
  _id_06BD::_id_23F9(1, self._id_0192);
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  self._id_2C5E._id_82FD[var_0]._id_F224 = gettime() + 4000;
}

_id_F18E(var_0) {
  _id_06BD::_id_23F9(0);
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_F18F(var_0) {
  var_1 = _id_06BD::_id_23CB();

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  if(_id_0009::_id_1C4F("throwgrenade", "start", 0)) {
    self._id_2C5E._id_82FD[var_0]._id_E69C = 1;
    self._id_2C5E._id_82FD[var_0]._id_F224 = self._id_2C5E._id_82FD[var_0]._id_F224 + 10000;
  }

  if(_id_0009::_id_1C4F("throwgrenade", "end")) {
    return anim._id_EACB;
  }

  if(gettime() > self._id_2C5E._id_82FD[var_0]._id_F224) {
    return anim._id_58E3;
  }

  if(!istrue(self._id_2C5E._id_82FD[var_0]._id_E69C)) {
    var_2 = scripts\engine\utility::_id_6EA0(var_1.origin);

    if(abs(var_2) > 90) {
      return anim._id_58E3;
    }
  }

  return anim._id_CA5F;
}

_id_756A(var_0) {
  if(_id_A371() && (gettime() >= 10000 || isDefined(level._id_7D27) && level._id_7D27)) {
    self._id_0DDF._id_A4A4 = gettime() + 500;
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_31F5(var_0) {
  if(isDefined(self._id_0323) || self._id_0063) {
    return anim._id_58E3;
  }

  if(isnullweapon(self._id_020A)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0192) && isDefined(self._id_0192._id_4DA5) && self._id_0192._id_4DA5) {
    return anim._id_58E3;
  }

  if(istrue(self._id_0181)) {
    return anim._id_58E3;
  }

  if(scripts\engine\utility::_id_0F78()) {
    return anim._id_58E3;
  }

  if(scripts\anim\utility_common::_id_FF0F()) {
    return anim._id_58E3;
  }

  if(isDefined(anim._id_F191) && isalive(level.player)) {
    if(_id_7183(level.player, 200)) {
      return anim._id_EACB;
    }
  }

  if(isDefined(self._id_0192) && _id_7183(self._id_0192, self._id_9EFA)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_716F(var_0, var_1) {
  if(isDefined(self._id_7179) && !self _meth_81C3(var_0, var_1, self._id_7179)) {
    return 0;
  } else if(!self _meth_81C3(var_0, var_1)) {
    return 0;
  }

  return 1;
}

_id_7183(var_0, var_1) {
  var_2 = var_0.origin;

  if(!self _meth_8067(var_0)) {
    if(isDefined(self._id_0192) && var_0 == self._id_0192 && isDefined(self._id_DA32)) {
      var_2 = self._id_DA32;
    }

    var_1 = 100;
  } else if(!isDefined(var_1))
    var_1 = 100;

  if(distancesquared(self.origin, var_2) < var_1 * var_1) {
    return 0;
  }

  _id_D45E(var_0);

  if(!_id_715D(var_0)) {
    return 0;
  }

  var_3 = scripts\engine\utility::_id_6EA0(var_2);

  if(abs(var_3) > 60) {
    return 0;
  }

  if(self._id_04F6.basename == "mg42" || self._id_0206 <= 0) {
    return 0;
  }

  if(isDefined(self._id_0192) && var_0 == self._id_0192) {
    if(!_id_3513()) {
      return 0;
    }

    if(!_id_716F(var_0, var_0.origin)) {
      return 0;
    }

    if(scripts\anim\utility_common::_id_31CD()) {
      return 1;
    }

    if(scripts\anim\utility_common::_id_31EB()) {
      return 1;
    }
  }

  return 1;
}

_id_A371() {
  return gettime() >= self._id_0DDF._id_A4A4;
}

_id_3513() {
  var_0 = self._id_0192.origin - self.origin;
  var_1 = _func_0135((var_0[0], var_0[1], 0));

  if(self._id_020A.basename == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

_id_715D(var_0) {
  if(isDefined(self._id_5D92)) {
    return [[self._id_5D92]](var_0);
  }

  if(scripts\engine\utility::_id_B414()) {
    return 0;
  }

  if(isDefined(self._id_CD57) && self._id_CD57 == 1) {
    return 1;
  }

  if(gettime() >= _id_6A7D(self._id_0F43)) {
    return 1;
  }

  if(self._id_0F43._id_89A2 && self._id_0F43._id_F25C == "fraggrenade") {
    return _id_9CCE(var_0);
  }

  return 0;
}

_id_D45E(var_0) {
  self._id_0F43 = spawnStruct();

  if(isPlayer(var_0) && isDefined(var_0._id_7184)) {
    self._id_0F43._id_89A2 = 1;
    self._id_0F43.player = var_0;
    self._id_0F43._id_F25C = self._id_020A.basename;
  } else {
    self._id_0F43._id_89A2 = 0;
    self._id_0F43._id_F25C = "AI_" + self._id_020A.basename;
  }
}

_id_9CCE(var_0) {
  if(scripts\engine\utility::_id_B414()) {
    return 0;
  }

  if(!var_0._id_7235._id_4E95) {
    return 0;
  }

  var_1 = gettime();

  if(var_1 < var_0._id_7184["double_grenade"]) {
    return 0;
  }

  if(var_1 > var_0._id_8FD7 + 3000) {
    return 0;
  }

  if(var_1 < var_0._id_8FD7 + 500) {
    return 0;
  }

  return var_0._id_A788 < 2;
}

_id_6A7D(var_0) {
  if(var_0._id_89A2) {
    return var_0.player._id_7184[var_0._id_F25C];
  } else {
    return anim._id_7184[var_0._id_F25C];
  }
}