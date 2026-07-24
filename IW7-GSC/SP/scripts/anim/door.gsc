/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\door.gsc
**************************************/

_id_5A09() {
  self endon("killanimscript");

  if(isDefined(self._id_55DA)) {
    return;
  }
  for(;;) {
    var_0 = self _meth_811E();

    if(isDefined(var_0)) {
      break;
    }

    wait 0.2;
  }

  var_1 = var_0.type == "Door Interior" || self _meth_808A(var_0);

  if(var_1)
    _id_5A06(var_0);
  else
    _id_5A0A(var_0);

  for(;;) {
    var_2 = self _meth_811E();

    if(!isDefined(var_2) || var_2 != var_0) {
      break;
    }

    wait 0.2;
  }

  thread _id_5A09();
}

_id_115CD() {
  self endon("killanimscript");
  self._id_115CE = 1;
  wait 5;
  self._id_115CE = undefined;
}

#using_animtree("generic_human");

_id_5817(var_0) {
  thread _id_115CD();

  if(self.grenadeweapon == "flash_grenade")
    self notify("flashbang_thrown");

  self orientmode("face current");
  var_0._id_BF7D = gettime() + 5000;
  self._id_B7B5 = gettime() + 100000;
  self notify("move_interrupt");
  self._id_12DEF = undefined;
  self clearanim(%combatrun, 0.2);
  self.a.movement = "stop";
  self waittill("done_grenade_throw");
  self orientmode("face default");
  self._id_B7B5 = gettime() + 5000;
  self.grenadeweapon = self._id_C3F2;
  self._id_C3F2 = undefined;
  scripts\anim\run::_id_6318();
  thread scripts\anim\move::_id_C968();
  thread scripts\anim\move::_id_E2B4(1);
}

_id_5A08(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 3;
  var_7 = undefined;
  var_8 = anglesToForward(var_0.angles);

  if(var_0.type == "Door Interior" && !self _meth_808A(var_0))
    var_8 = -1 * var_8;

  var_9 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + 64);
  var_10 = var_9;

  if(var_2) {
    var_11 = anglestoright(var_0.angles);
    var_12 = var_0.origin - self.origin;
    var_13 = vectordot(var_11, var_12);

    if(var_13 > 20)
      var_13 = 20;
    else if(var_13 < -20)
      var_13 = -20;

    var_10 = var_9 + var_13 * var_11;
  }

  while(var_6 > 0) {
    if(isDefined(self.grenade) || !isDefined(self.enemy)) {
      return;
    }
    if(_id_C586(var_0, var_8)) {
      return;
    }
    if(!self seerecently(self.enemy, 0.2) && self.a.pose == "stand" && _id_56F2(self.enemy.origin - var_0.origin, 360000, 16384)) {
      if(isDefined(var_0._id_BF7D) && var_0._id_BF7D > gettime()) {
        return;
      }
      if(self canshootenemy()) {
        return;
      }
      var_12 = var_0.origin - self.origin;

      if(lengthsquared(var_12) < var_3) {
        return;
      }
      if(vectordot(var_12, var_8) < 0) {
        return;
      }
      self._id_C3F2 = self.grenadeweapon;
      self.grenadeweapon = var_1;
      scripts\anim\combat_utility::_id_F62B(self.enemy);

      if(!var_5) {
        var_14 = var_9 + var_8 * 100;

        if(!self _meth_81A2(self.enemy, var_14, 128))
          return;
      }

      var_5 = 1;

      if(scripts\anim\combat_utility::trygrenadethrow(self.enemy, var_10, var_7, scripts\anim\combat_utility::_id_7EE8(var_7), 1, 0, 1)) {
        _id_5817(var_0);
        return;
      }
    }

    var_6--;
    wait(var_4);
    var_15 = self _meth_811E();

    if(!isDefined(var_15) || var_15 != var_0)
      return;
  }
}

_id_940A() {
  self endon("killanimscript");

  if(isDefined(self._id_55DA)) {
    return;
  }
  self._id_9E45 = 0;

  for(;;) {
    if(self _meth_81A4() && !self.doingambush)
      _id_5A07();
    else if(!isDefined(self._id_B7B5) || self._id_B7B5 < gettime()) {
      self._id_B7B5 = undefined;
      _id_5A0B();
    }

    wait 0.2;
  }
}

_id_5A07() {
  if(!isDefined(self._id_BEF7) && !self.doingambush) {
    self._id_9E45 = 1;

    if(!scripts\anim\utility::_id_9D9B())
      scripts\sp\utility::_id_61E7(1);
  }
}

_id_5A0B() {
  if(!isDefined(self._id_4797)) {
    self._id_9E45 = 0;

    if(scripts\anim\utility::_id_9D9B())
      scripts\sp\utility::_id_5514();
  }
}

_id_56F2(var_0, var_1, var_2) {
  return var_0[0] * var_0[0] + var_0[1] * var_0[1] < var_1 && var_0[2] * var_0[2] < var_2;
}

_id_C586(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = var_0.origin - self.enemy.origin;
  return vectordot(var_2, var_1) * vectordot(var_3, var_1) > 0;
}

_id_5A06(var_0) {
  for(;;) {
    if(isDefined(self._id_5A0F) && (self._id_5A0F == 0 || self._id_5A0F < randomfloat(1))) {
      break;
    }

    if(_id_56F2(self.origin - var_0.origin, 562500, 25600)) {
      _id_5A08(var_0, "fraggrenade", 0, 302500, 0.3);
      var_0 = self _meth_811E();

      if(!isDefined(var_0)) {
        return;
      }
      break;
    }

    wait 0.1;
  }

  for(;;) {
    if(_id_56F2(self.origin - var_0.origin, 36864, 6400)) {
      _id_5A07();
      self._id_B7B5 = gettime() + 6000;

      if(isDefined(self._id_5A0E) && (self._id_5A0E == 0 || self._id_5A0E < randomfloat(1))) {
        return;
      }
      _id_5A08(var_0, "flash_grenade", 1, 4096, 0.2);
      return;
    }

    wait 0.1;
  }
}

_id_5A0A(var_0) {
  for(;;) {
    if(!self._id_9E45 || distancesquared(self.origin, var_0.origin) < 1024) {
      return;
    }
    wait 0.1;
  }
}