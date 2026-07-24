/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3138.gsc
**************************************/

_id_35A6(var_0, var_1, var_2, var_3) {
  if(!isDefined(anim._id_362A)) {
    _id_0C41::_id_3629();
  }

  self.allowpain = 0;
  self.asm._id_7360 = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.combatmode = "no_cover";
  self.grenadeawareness = 0;
  self.maxfaceenemydist = 1024;
  self.sharpturnlookaheaddist = 164;
  scripts\asm\asm::_id_237B(1);
  self._id_1A48 = 1;
  self._blackboard.movetype = "combat";
  self._blackboard._id_A983 = 0;
  self._blackboard.timeoff = -99999;
  self.turnrate = 0.1;
  self.dropweapon = 0;
  self._id_27F7 = 1;

  if(isDefined(self._id_13CC3)) {
    self._id_13C83 = [];

    foreach(var_6, var_5 in self._id_13CC3) {
      self._id_13C83[var_6] = 1;
      self.bt._id_13C83[var_6] = 1;
    }
  }

  thread _id_0C46::_id_3535();
  thread _id_0C46::_id_3620();
  thread _id_352E();
}

_id_352E() {
  self endon("death");

  for(;;) {
    if(!isDefined(level.player._id_4759)) {
      wait 1;
      continue;
    }

    if(isDefined(level.player._id_4759.active) && level.player._id_4759.active.size) {
      foreach(var_1 in level.player._id_4759.active) {
        if(distance2dsquared(self.origin, var_1.origin) <= squared(180)) {
          scripts\sp\coverwall::_id_475C(var_1, 1);
          wait 0.05;
        }
      }

      wait 0.5;
    }

    wait 0.25;
  }
}

_id_6C00() {}

draw_axis(var_0, var_1) {
  var_2 = 25;
  var_3 = anglesToForward(var_1) * var_2;
  var_4 = anglestoright(var_1) * var_2;
  var_5 = anglestoup(var_1) * var_2;
  _id_1215(var_0, var_0 + var_3, (1, 0, 0));
  _id_1215(var_0, var_0 + var_5, (0, 1, 0));
  _id_1215(var_0, var_0 + var_4, (0, 0, 1));
}

_id_1215(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_1 - var_0);
  var_4 = length(var_1 - var_0);
  var_5 = anglesToForward(var_3);
  var_6 = var_5 * var_4;
  var_7 = 5;
  var_8 = var_5 * (var_4 - var_7);
  var_9 = anglestoright(var_3);
  var_10 = var_9 * (var_7 * -1);
  var_11 = var_9 * var_7;
}

_id_E75A(var_0, var_1) {
  return (_id_E756(var_0[0], var_1), _id_E756(var_0[1], var_1), _id_E756(var_0[2], var_1));
}

_id_E756(var_0, var_1) {
  return int(var_0 * var_1) / var_1;
}

_id_35E3(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "_left")) {
    self._id_164D[var_0].slot = "left";
  } else if(issubstr(var_0, "_right")) {
    self._id_164D[var_0].slot = "right";
  } else {}
}

_id_3514(var_0, var_1, var_2, var_3) {
  var_4 = self._id_164D[var_0].slot;

  if(!isDefined(var_4)) {
    return 0;
  }

  if(!isDefined(self._id_13CC3[var_4])) {
    return 0;
  }

  return self._id_13CC3[var_4] == var_3;
}

_id_3518(var_0) {
  var_1 = self._blackboard.shootparams;

  if(!isDefined(var_1)) {
    return 0;
  }

  foreach(var_4, var_3 in self._id_13CC3) {
    if(var_4 == var_0) {
      return isDefined(var_1._id_13CC3[var_4]);
    }
  }

  return 0;
}

_id_3519(var_0, var_1, var_2, var_3) {
  return !_id_351A(var_0, var_1, var_2, var_3);
}

_id_351A(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self._id_164D[var_0].slot;

  if(var_5 == "left") {
    var_6 = "left_arm";
  } else {
    var_6 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_6)) {
    return 0;
  }

  if(!isDefined(self._id_13CC3[var_5]) || self._id_13CC3[var_5] != var_3) {
    return 0;
  }

  return _id_0C08::_id_10079(var_5);
}

_id_3515(var_0, var_1, var_2, var_3) {
  return !_id_3516(var_0, var_1, var_2, var_3);
}

_id_3516(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self._id_164D[var_0].slot;

  if(var_5 == "left") {
    var_6 = "left_arm";
  } else {
    var_6 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_6)) {
    return 0;
  }

  if(!isDefined(self._id_13CC3[var_5]) || self._id_13CC3[var_5] != var_3) {
    return 0;
  }

  return _id_0C08::_id_A004(var_5);
}

_id_3517(var_0, var_1, var_2, var_3) {
  var_4 = self._id_164D[var_0]._id_4C1A;
  return !isDefined(var_4) || isDefined(var_4._id_2720);
}

_id_35AE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::ispartdismembered(var_3);
}