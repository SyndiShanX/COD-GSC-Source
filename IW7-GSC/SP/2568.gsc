/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2568.gsc
**************************************/

_id_97EC(var_0) {
  self._id_71A8 = ::_id_7FD3;
  self._id_71AE = ::isaimedataimtarget;
  self._id_71CA = ::resetmisstime_code;
  self._id_71A9 = ::_id_811D;
  self._id_71AA = ::_id_81E3;
  self._id_71A0 = ::_id_4F67;
  self._id_71AB = ::_id_81F4;
  self._id_71A6 = ::_id_7EFC;
  self._id_7196 = ::_id_2542;
  self._id_71BD = ::_id_129AD;
  self._id_71BC = ::_id_129AA;
  self._id_71CB = ::saygenericdialogue;
  self._id_71D5 = ::_id_12E93;
  self._id_71C7 = scripts\sp\utility::_id_D022;
  return anim.success;
}

_id_103F5(var_0) {
  if(isDefined(self._id_4D5D)) {
    _id_0A15::setupdestructibledoors();
    thread _id_0A1E::_id_111A9();
    self._id_719D = ::_id_103F3;
    self._id_8E1E = 1;
  }

  return anim.success;
}

resetmisstime_code() {
  scripts\sp\gameskill::resetmisstime_code();
}

_id_7FD3() {
  if(isDefined(self._id_10AB7) && self._id_10AB7) {
    return "sprint";
  }

  if(scripts\anim\utility::_id_FFDB()) {
    return "cqb";
  }

  if(isDefined(self._id_527B)) {
    return self._id_527B;
  }

  var_0 = scripts\aitypes\bt_util::bt_getdemeanor();
  return var_0;
}

isaimedataimtarget() {
  return _id_0A2B::_id_1A3A();
}

_id_129AD() {
  self _meth_81D6();
}

_id_129AA() {
  self _meth_81D5();
}

saygenericdialogue(var_0) {
  scripts\anim\face::saygenericdialogue(var_0);
}

_id_811D() {
  return scripts\anim\shared::_id_811C();
}

_id_81E3(var_0) {
  return var_0 _meth_851F();
}

_id_4F67() {
  return scripts\anim\shared::_id_4F66();
}

_id_7EFC() {
  var_0 = undefined;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;

  if(isDefined(self.node) && scripts\asm\shared\utility::isatcovernode()) {
    var_1 = self.node doesnodeallowstance("stand");
    var_2 = self.node doesnodeallowstance("crouch");
    var_3 = self.node doesnodeallowstance("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = distancesquared(self.origin, self._blackboard.shootparams.pos);

    if(var_4 > 262144 && self _meth_81BF("crouch") && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm()) {
      if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams.pos, 0, undefined)) {
        return "crouch";
      }
    }
  }

  for(;;) {
    if(self _meth_81BF("stand") && var_1) {
      return "stand";
    }

    if(self _meth_81BF("crouch") && var_2) {
      return "crouch";
    }

    if(self _meth_81BF("prone") && var_3) {
      return "prone";
    }

    if(!var_1 || !var_2 || !var_3) {
      var_1 = 1;
      var_2 = 1;
      var_3 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

_id_3DE5() {
  if(!isDefined(level._id_A936[self.team])) {
    return 0;
  }

  if(scripts\aitypes\combat::_id_10026()) {
    return 1;
  }

  if(gettime() - level._id_A936[self.team] < level._id_18D7) {
    return 0;
  }

  if(!issentient(self.enemy)) {
    return 0;
  }

  if(level._id_18D5[self.team]) {
    level._id_18D5[self.team] = 0;
  }

  var_0 = isDefined(self._id_18CC) && self._id_18CC;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return 0;
  }

  return 1;
}

_id_2543() {
  if(!self _meth_81A5(self.enemy.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return 0;
  }

  if(!_id_3DE5()) {
    return 0;
  }

  self _meth_80E6(0);

  if(self _meth_8254()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;

    if(level._id_18D5[self.team] == 0) {
      level._id_A936[self.team] = gettime();
      level._id_A933[self.team] = self;
    }

    level._id_A935[self.team] = self.origin;
    level._id_A934[self.team] = self.enemy.origin;
    level._id_18D5[self.team]++;
    return 1;
  }

  return 0;
}

_id_2542(var_0) {
  if(!scripts\aitypes\combat::_id_FFC2()) {
    return anim.failure;
  }

  switch (self.bt.instancedata[var_0]) {
    case 0:
      if(self _meth_8255(32)) {
        return anim.success;
      }

      break;
    case 3:
      if(self _meth_8255(64)) {
        return anim.success;
      }

      break;
    case 7:
      if(self _meth_8255(96)) {
        return anim.success;
      }

      break;
    case 11:
      if(_id_2543()) {
        return anim.success;
      }

      break;
    case 15:
      self _meth_80EC();
      break;
  }

  self.bt.instancedata[var_0]++;

  if(self.bt.instancedata[var_0] > 60) {
    self.bt.instancedata[var_0] = 0;
  }

  return anim.running;
}

_id_81F4() {
  return self _meth_8164();
}

_id_12E93() {
  if(self.unittype == "c6i" || scripts\engine\utility::actor_is3d() || self.team == "neutral") {
    return anim.success;
  }

  var_0 = gettime();

  if(!isDefined(self._blackboard._id_7362) || self._blackboard._id_7362 > var_0) {
    var_1 = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var_2 = 0;
    var_3 = 10000;
    var_4 = 4194304;
    var_5 = 5;
    self._blackboard._id_7362 = var_0 + 10000;
    self._blackboard._id_7366 = "combat";

    foreach(var_7 in var_1) {
      var_8 = distancesquared(self lastknownpos(var_7), self.origin);

      if(var_8 > var_4) {
        continue;
      }
      var_9 = gettime() - self lastknowntime(var_7);

      if(var_9 > var_3) {
        continue;
      }
      var_2++;

      if(var_7.unittype == "c8" || var_7.unittype == "c12") {
        self._blackboard._id_7366 = "frantic";
        break;
      }

      if(var_2 >= 3) {
        self._blackboard._id_7366 = "frantic";
        break;
      }
    }
  }

  return anim.success;
}

_id_103F3(var_0) {
  switch (var_0.partname) {
    case "helmet":
      if(isDefined(self._id_C065) && self._id_C065) {}

      if(isDefined(self._id_C554) && self._id_C554) {}

      _id_0C60::_id_8E17();
      break;
  }
}