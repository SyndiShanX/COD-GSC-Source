/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\door.gsc
**************************************/

_id_1088() {
  self endon("killanimscript");

  if(isDefined(self._id_1089)) {
    return;
  }
  for(;;) {
    var_0 = self getdoorpathnode();

    if(isDefined(var_0)) {
      break;
    }

    wait 0.2;
  }

  var_1 = var_0.type == "Door Interior" || self comparenodedirtopathdir(var_0);

  if(var_1) {
    _id_10A1(var_0);
  } else {
    _id_10A4(var_0);

  }
  for(;;) {
    var_2 = self getdoorpathnode();

    if(!isDefined(var_2) || var_2 != var_0) {
      break;
    }

    wait 0.2;
  }

  thread _id_1088();
}

_id_108A() {
  self endon("killanimscript");
  self._id_108B = 1;
  wait 5;
  self._id_108B = undefined;
}

#using_animtree("generic_human");

_id_108C(var_0) {
  thread _id_108A();

  if(self.grenadeweapon == "flash_grenade") {
    self notify("flashbang_thrown");

  }
  self orientmode("face current");
  var_0._id_108D = gettime() + 5000;
  self._id_108E = gettime() + 100000;
  self notify("move_interrupt");
  self._id_0FC9 = undefined;
  self clearanim( % combatrun, 0.2);
  self.a._id_0D2B = "stop";
  self waittill("done_grenade_throw");
  self orientmode("face default");
  self._id_108E = gettime() + 5000;
  self.grenadeweapon = self._id_108F;
  self._id_108F = undefined;
  animscripts\run::_id_0FE2();
  thread animscripts\move::_id_1090();
  thread animscripts\move::_id_1091(1);
}

_id_1092(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 3;
  var_7 = undefined;
  var_7 = % cqb_stand_grenade_throw;
  var_8 = anglesToForward(var_0.angles);

  if(var_0.type == "Door Interior" && !self comparenodedirtopathdir(var_0)) {
    var_8 = -1 * var_8;

  }
  var_9 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + 64);
  var_10 = var_9;

  if(var_2) {
    var_11 = anglestoright(var_0.angles);
    var_12 = var_0.origin - self.origin;
    var_13 = vectordot(var_11, var_12);

    if(var_13 > 20) {
      var_13 = 20;
    } else if(var_13 < -20) {
      var_13 = -20;

    }
    var_10 = var_9 + var_13 * var_11;
  }

  while(var_6 > 0) {
    if(isDefined(self.grenade) || !isDefined(self.enemy)) {
      return;
    }
    if(_id_10A0(var_0, var_8)) {
      return;
    }
    if(!self seerecently(self.enemy, 0.2) && self.a._id_0D26 == "stand" && _id_109F(self.enemy.origin - var_0.origin, 360000, 16384)) {
      if(isDefined(var_0._id_108D) && var_0._id_108D > gettime()) {
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
      self._id_108F = self.grenadeweapon;
      self.grenadeweapon = var_1;
      animscripts\combat_utility::_id_1093(self.enemy);

      if(!var_5) {
        var_14 = var_9 + var_8 * 100;

        if(!self isgrenadepossafe(self.enemy, var_14, 128)) {
          return;
        }
      }

      var_5 = 1;

      if(animscripts\combat_utility::_id_1095(self.enemy, var_10, var_7, animscripts\combat_utility::_id_1094(var_7), 1, 0, 1)) {
        _id_108C(var_0);
        return;
      }
    }

    var_6--;
    wait(var_4);
    var_15 = self getdoorpathnode();

    if(!isDefined(var_15) || var_15 != var_0) {
      return;
    }
  }
}

_id_1096() {
  self endon("killanimscript");

  if(isDefined(self._id_1089)) {
    return;
  }
  self._id_1097 = 0;

  for(;;) {
    if(self isindoor() && !self.doingambush) {
      _id_1098();
    } else if(!isDefined(self._id_108E) || self._id_108E < gettime()) {
      self._id_108E = undefined;
      _id_109C();
    }

    wait 0.2;
  }
}

_id_1098() {
  if(!isDefined(self._id_1099) && !self.doingambush) {
    self._id_1097 = 1;

    if(!isDefined(self._id_109A) || !self._id_109A) {
      maps\_utility::_id_109B(1);
    }
  }
}

_id_109C() {
  if(!isDefined(self._id_109D)) {
    self._id_1097 = 0;

    if(isDefined(self._id_109A) && self._id_109A) {
      maps\_utility::_id_109E();
    }
  }
}

_id_109F(var_0, var_1, var_2) {
  return var_0[0] * var_0[0] + var_0[1] * var_0[1] < var_1 && var_0[2] * var_0[2] < var_2;
}

_id_10A0(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = var_0.origin - self.enemy.origin;
  return vectordot(var_2, var_1) * vectordot(var_3, var_1) > 0;
}

_id_10A1(var_0) {
  for(;;) {
    if(isDefined(self._id_10A2) && (self._id_10A2 == 0 || self._id_10A2 < randomfloat(1))) {
      break;
    }

    if(_id_109F(self.origin - var_0.origin, 562500, 25600)) {
      _id_1092(var_0, "fraggrenade", 0, 302500, 0.3);
      var_0 = self getdoorpathnode();

      if(!isDefined(var_0)) {
        return;
      }
      break;
    }

    wait 0.1;
  }

  for(;;) {
    if(_id_109F(self.origin - var_0.origin, 36864, 6400)) {
      _id_1098();
      self._id_108E = gettime() + 6000;

      if(isDefined(self._id_10A3) && (self._id_10A3 == 0 || self._id_10A3 < randomfloat(1))) {
        return;
      }
      _id_1092(var_0, "flash_grenade", 1, 4096, 0.2);
      return;
    }

    wait 0.1;
  }
}

_id_10A4(var_0) {
  for(;;) {
    if(!self._id_1097 || distancesquared(self.origin, var_0.origin) < 1024) {
      return;
    }
    wait 0.1;
  }
}