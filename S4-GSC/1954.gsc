/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1954.gsc
*************************************************/

_id_CEF2(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(gettime() - var_0 > var_1) {
    return 1;
  }

  return 0;
}

_id_CEEF(var_0) {
  if(var_0 == "left") {
    return "right";
  }

  return "left";
}

_id_CEF0(var_0) {
  if(issubstr(var_0, "left")) {
    return "left";
  }

  if(issubstr(var_0, "right")) {
    return "right";
  }

  return "none";
}

_id_CEF1(var_0, var_1) {
  return var_0 + "_" + var_1;
}

_id_CEE4() {
  var_0 = _func_000B(self.angles[1]);

  if(self._id_22AF < 0 && var_0 > 0) {
    var_0 = var_0 - 360;
  }

  if(self._id_22AF > 0 && var_0 < 0) {
    var_0 = var_0 + 360;
  }

  var_1 = var_0 - self._id_22AF;
  return abs(var_1);
}

_id_CEE5(var_0) {
  var_1 = int(var_0 / float(10)) * 10;
  var_1 = var_1 + 10;

  if(var_1 < 20) {
    var_1 = 20;
  }

  if(var_1 >= 90) {
    var_1 = 90;
  }

  return var_1;
}

_id_CEE6(var_0, var_1, var_2) {
  var_3 = _id_CEE5(var_2);

  for(var_4 = var_3; var_4 <= 90; var_4 = var_4 + 10) {
    var_5 = _id_CEF1(var_1, var_4);

    if(self _meth_867A(var_0, var_5)) {
      return var_5;
    }
  }

  var_5 = _id_CEF1(var_1, 90);
  return var_5;
}

_id_CEE9() {
  var_0 = self _meth_867D("door", "setup", "scriptable_event_model", "radius");
  self._id_AE09 = var_0 * 0.5;
  self._id_22AF = _func_000B(self.angles[1]);
}

_id_CEF3() {
  self.owner = undefined;
}

_id_CEF4() {
  for(;;) {
    wait 1.0;

    if(!isDefined(self.owner)) {
      return;
    }
    var_0 = scripts\engine\math::_id_FFDB(self.origin, self.angles, self._id_AE09 * 0.5);

    if(distancesquared(self.owner.origin, var_0) > _func_0219(self._id_AE09)) {
      _id_CEF3();
      return;
    }
  }
}

_id_CEDE(var_0) {
  self.owner = var_0;
  thread _id_CEF4();
}

_id_CEDF(var_0, var_1) {
  if(var_1 == "closed") {
    if(isDefined(self.owner)) {
      _id_CEF3();
    }
  } else if(!isDefined(self.owner))
    _id_CEDE(var_0);
}

_id_233C(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0)) {
      var_0 playrumbleonentity("grenade_rumble");
      var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
    }
  }
}

_id_DB06(var_0) {
  if(!isalive(var_0) || isDefined(var_0._id_59E0)) {
    return 0;
  }

  var_1 = anglesToForward(var_0.angles);
  var_2 = scripts\engine\math::_id_FFDB(self.origin, self.angles, self._id_AE09 * 0.5);
  var_2 = var_2 + (0, 0, self._id_AE09);

  if(scripts\engine\utility::_id_10E76(var_0.origin + var_1 * -45.0, var_0.angles, var_2, cos(43))) {
    var_3 = anglestoright(self.angles);
    var_4 = vectornormalize(var_2 - var_0 getEye());
    var_5 = vectordot(var_1, var_4);
    var_6 = vectordot(var_1, var_3);
    var_7 = var_0 getvelocity();
    var_8 = vectordot(vectornormalize(var_7), (0, 0, 1));

    if(length(var_7) >= 200 && abs(var_8) < 0.5 && abs(var_6) > 0.75 && var_5 > 0.75) {
      return 1;
    }
  }

  return 0;
}

_id_CEE8(var_0, var_1) {
  var_2 = "door";

  if(isDefined(self.owner) && var_0 != self.owner) {
    return;
  }
  if(!isDefined(self._id_AE09)) {
    _id_CEE9();
  }

  var_3 = self _meth_8575(var_2);
  var_4 = var_3 == "closed" || var_3 == "setup";
  var_5 = 0;

  if(var_4) {
    if(var_1 == "touch") {
      if(_id_DB06(var_0)) {
        var_5 = 1;
      } else {
        return;
      }
    } else if(istrue(self._id_96EF))
      return;
  }

  var_6 = scripts\engine\math::_id_FFDB(self.origin, self.angles, self._id_AE09);
  var_7 = scripts\engine\math::_id_B9B1(var_0.origin, self.origin, var_6);
  var_8 = _id_CEEF(var_7);
  var_9 = _id_CEF0(var_3);
  var_10 = _id_CEF1(var_8, 90);
  var_11 = "none";

  if(var_4) {
    var_11 = var_10;

    if(!self _meth_867A(var_2, var_11)) {
      var_11 = _id_CEF1(var_7, 90);
    }
  } else if(var_8 != var_9)
    var_11 = "closed";
  else if(var_1 == "touch") {
    var_11 = var_10;
  } else if(!_id_CEF2(self._id_8FEE, 700)) {
    var_12 = _id_CEE4();
    var_11 = _id_CEE6(var_2, var_8, var_12);
  } else
    var_11 = "closed";

  if(var_11 == var_3) {
    return;
  }
  if(!self _meth_867A(var_2, var_11)) {
    return;
  }
  if(var_11 == "closed") {
    self _meth_86CA(1);
  } else {
    self _meth_86CA(0);

    if(var_5) {
      thread _id_233C(var_0);
    }
  }

  _id_CEDF(var_0, var_11);
  thread _id_CEDC(var_2, var_11);
  self setscriptablepartstate(var_2, var_11);
  self._id_8FEE = gettime();
  var_0 notify("use_scriptable_door", self, var_0, var_2, var_11);
}

_id_CEDC(var_0, var_1) {
  if(!isDefined(level._id_CEDD)) {
    return;
  }
  self notify("door_wait_auto_close");
  self endon("door_wait_auto_close");

  if(!isDefined(level._id_CEF5)) {
    level._id_CEF5 = [];
  }

  if(var_1 == "closed") {
    level._id_CEF5[self.index] = undefined;
    return;
  }

  level._id_CEF5[self.index] = self;
  scripts\engine\utility::_id_108F5("scriptable_door_auto_close", level._id_CEDD);
  var_2 = self _meth_8575(var_0);

  if(var_2 == "closed") {
    return;
  }
  self _meth_86CA(1);
  self setscriptablepartstate(var_0, "closed");
  self._id_8FEE = gettime();
  level._id_CEF5[self.index] = undefined;
}

_id_CEEE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 thread _id_CEE8(var_3, "use");

  if(isDefined(var_0.target)) {
    var_6 = _func_03C0(var_0.target, "targetname");

    foreach(var_8 in var_6) {
      if(var_8 _meth_8679("door")) {
        var_8 thread _id_CEE8(var_3, "use");
      }
    }
  }
}

_id_CEED(var_0, var_1, var_2, var_3) {
  if(var_1 == "door") {
    var_0 thread _id_CEE8(var_3, "touch");
  }
}

_id_CEEC() {
  var_0 = _func_03C0(undefined, undefined, undefined, undefined, "door");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 _meth_86CA(1);
    var_3 = anglesToForward(var_2.angles);
    var_4 = var_2.origin + var_3 * 54 * 0.5;
    var_2._id_39D7 = var_4;
    var_2._id_39D6 = var_2.angles;
  }
}

_id_EC4C() {
  if(isDefined(level._id_CEEA)) {
    return;
  }
  _id_07A1::_id_CEC9(::_id_CEEC);
  _id_07A1::_id_CECC("door", ::_id_CEEE);
  _id_07A1::_id_CECA(::_id_CEED);
  level._id_CEEA = 1;
}

_id_CEE2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 20;
  }

  level._id_CEDD = var_0;
}

_id_CEE1() {
  if(!isDefined(level._id_CEDD)) {
    return;
  }
  level._id_CEDD = undefined;

  if(!isDefined(level._id_CEF5)) {
    return;
  }
  foreach(var_1 in level._id_CEF5) {
    var_1 notify("door_wait_auto_close");
  }

  level._id_CEF5 = [];
}

_id_CEE0() {
  if(!isDefined(level._id_CEF5)) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._id_CEF5) {
    var_2 notify("scriptable_door_auto_close");
    var_0++;

    if(var_0 % 20 == 0) {
      var_0 = 0;
      waitframe();
    }
  }
}