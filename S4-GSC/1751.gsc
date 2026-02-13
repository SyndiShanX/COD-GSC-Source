/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1751.gsc
*************************************************/

_id_675A(var_0) {
  if(scripts\common\utility::issp()) {
    var_0 = var_0 + 1;
  }

  return level._id_498D[var_0];
}

_id_19B6(var_0) {
  self._id_01F2 = _id_644D("missTimeConstant", var_0);
  self._id_01F3 = _id_644D("missTimeDistanceFactor", var_0);
  self._id_7235._id_4E95 = _id_644D("double_grenades_allowed", var_0);
}

_id_644D(var_0, var_1) {
  return _id_644C(var_0) * var_1;
}

_id_644C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_60E6;
  }

  return level._id_498A[var_0][_id_675A(var_1)];
}

_id_644E(var_0) {
  return level._id_498A[var_0][_id_675A(level._id_60E6)];
}

_id_1655() {
  return 0;
}

_id_ADDA() {
  if(!_id_ADDB()) {
    return 0;
  }

  return randomint(100) > 25;
}

_id_ADDB() {
  if(!isalive(self._id_0192)) {
    return 0;
  }

  if(!isPlayer(self._id_0192)) {
    return 0;
  }

  if(!isalive(level._id_ADE2) || level._id_ADE2.script != "pain") {
    level._id_ADE2 = self;
  }

  if(self == level._id_ADE2) {
    return 0;
  }

  var_0 = self.damageweapon;

  if(!isnullweapon(var_0) && var_0._id_0248) {
    return 0;
  }

  return 1;
}

_id_D12E() {
  if(scripts\anim\utility_common::_id_8766() && isalive(self._id_0192)) {
    _id_D6D0();
    return;
  }

  if(isPlayer(self._id_0192)) {
    _id_C620();

    if(self._id_02B6 > gettime()) {
      self._id_001D = 0;
      return;
    }
  }

  if(isDefined(self.script) && self.script == "move") {
    if(scripts\engine\utility::_id_0F78() && isDefined(self._id_0B67._id_90B5) && (self._id_0B67._id_90B5.type == "Exposed 3D" || self._id_0B67._id_90B5.type == "Path 3D")) {
      self._id_001D = self._id_0087;
    } else if(scripts\anim\utility::_id_87D6()) {
      self._id_001D = anim._id_1098A * self._id_0087;
    } else {
      self._id_001D = anim._id_C9A3 * self._id_0087;
    }

    return;
  }

  self._id_001D = self._id_0087;

  if(isDefined(self._id_89DA) && isDefined(self._id_BFCA)) {
    self._id_001D = self._id_001D * self._id_BFCA;
  }
}

_id_D6D0() {
  if(!isDefined(self._id_DFBD)) {
    self._id_DFBD = 0;
    self._id_DFB3 = 0;
  }

  if(!isDefined(self._id_DFA6)) {
    self._id_DFA6 = 1;
    var_0 = _id_675A(level._id_60E6);
    var_1 = level._id_498A["sniperAccuDiffScale"][var_0];
    self._id_0087 = self._id_001D * var_1;
  }

  self._id_DFBD++;
  var_2 = level._id_60E6;

  if(isPlayer(self._id_0192)) {
    var_2 = self._id_0192._id_60E6;
  }

  if(_id_DB5E()) {
    self._id_001D = 0;

    if(var_2 > 0 || self._id_DFBD > 1) {
      self._id_9015 = self._id_0192;
    }

    return;
  }

  if(self._id_001D <= 10) {
    self._id_001D = (1 + 1 * self._id_DFB3) * self._id_0087;
  }

  self._id_DFB3++;

  if(var_2 < 1 && self._id_DFB3 == 1) {
    self._id_9015 = undefined;
  }
}

_id_DB5E() {
  if(isDefined(self._id_A43E) && self._id_A43E) {
    return 0;
  }

  if(self.team == "allies") {
    return 0;
  }

  if(isDefined(self._id_9015) && self._id_0192 == self._id_9015) {
    return 0;
  }

  if(distancesquared(self.origin, self._id_0192.origin) > 250000) {
    return 0;
  }

  return 1;
}

_id_4979() {
  self._id_02B7 = 0;
}

_id_C620() {
  self._id_02B7 = gettime() + 3000;
}

_id_4567() {
  if(self.team == "allies") {
    self._id_4E3E = 0.6;
  }

  if(self _meth_81BA()) {
    if(level._id_60E6 >= 2) {
      self._id_4E3E = 0.8;
    } else {
      self._id_4E3E = 0.6;
    }
  }
}

_id_0207() {
  if(self.team == "allies") {
    self._id_0207 = 0.9;
    self._id_0209 = 0.9;
    return;
  }

  if(self _meth_81BA()) {
    self._id_0207 = 1;
    self._id_0209 = 0.2;
  }
}

_id_9AA3() {
  if(!isDefined(level._id_50E0)) {
    return 1;
  }

  if(isDefined(level._id_50E0[level.script])) {
    return level._id_50E0[level.script];
  }

  return 0;
}

_id_D1E9() {
  level._id_50E0 = [];
}