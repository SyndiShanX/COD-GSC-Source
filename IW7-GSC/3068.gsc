/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3068.gsc
**************************************/

_id_340B(var_0) {
  self.combatmode = "no_cover";
  self.grenadeawareness = 0;
  self.pathenemylookahead = 0;
  self._id_290A = 1;
  self.bt._id_F200 = 0.5;
  self.bt._id_71CC = _id_0BFE::_id_F1F1;
  self.fnismeleevalid = _id_0A10::_id_3381;
  self.fncanmovefrompointtopoint = _id_0A10::canmovefrompointtopoint;
  self._id_B651 = 1;
  self._id_B5E4 = 1;
  self._id_2A8F = 1;
  self._id_B5DB = 1;
  self._id_B5DC = 1;
  self._id_B622 = 1;
  return anim.success;
}

_id_9F06(var_0) {
  if(_id_0C3B::_id_808E() <= 0) {
    return anim.success;
  }

  return anim.failure;
}

_id_9D5B(var_0) {
  if(self._id_290A) {
    return anim.success;
  }

  return anim.failure;
}

_id_F795(var_0) {
  if(isDefined(self.melee)) {
    return anim.success;
  }

  var_1 = self.origin;
  var_2 = self.enemy.origin - self.origin;
  var_3 = length(var_2);
  var_4 = self.meleechargedist;

  if(isPlayer(self.enemy)) {
    var_4 = self.meleechargedistvsplayer;
  }

  var_5 = 60;

  if(var_3 > var_4 - var_5) {
    var_2 = var_2 / var_3;
    var_1 = self.origin + var_2 * (var_3 - var_4 + var_5);
    var_1 = (var_1[0], var_1[1], self.enemy.origin[2]);
    var_1 = getclosestpointonnavmesh(var_1, self);

    if(abs(var_1[2] - self.enemy.origin[2]) > 80) {
      var_1 = self.enemy.origin;
    }
  }

  self _meth_8481(var_1);
  self.btgoalradius = var_5;
  return anim.success;
}

_id_340C(var_0, var_1) {
  if(isai(var_0) && _id_0A0B::_id_203F()) {
    return 0;
  }

  return _id_0A10::_id_3381(var_0, var_1);
}

_id_340D(var_0) {
  if(isDefined(self.melee) && isDefined(self.melee.target) && isai(self.melee.target) && _id_0A0B::_id_203F()) {
    self.melee._id_2720 = 1;
  }

  return anim.success;
}

_id_340E(var_0) {
  if(isDefined(self.melee) && isDefined(self.melee.target) && isPlayer(self.melee.target) && self.melee.target getstance() == "prone") {
    _id_0BFE::_id_F6C7();
    self.melee._id_2720 = 1;
  }

  return anim.success;
}

_id_A665(var_0) {
  if(_id_0C3B::_id_808E() <= 0) {
    self _meth_81D0();
    return anim.success;
  }

  return anim.failure;
}