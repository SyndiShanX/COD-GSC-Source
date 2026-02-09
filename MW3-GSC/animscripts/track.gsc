/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\track.gsc
**************************************/

#using_animtree("generic_human");

_id_0CA9() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  _id_0CAA(%aim_2, %aim_4, %aim_6, %aim_8);
}

_id_0CAA(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = (0, 0, 0);
  var_7 = 1;
  var_8 = 0;
  var_9 = 0;
  var_10 = 10;
  var_11 = (0, 0, 0);

  if(self.type == "dog") {
    var_12 = 0;
    self._id_0CAB = self.enemy;
  } else {
    var_12 = 1;
    var_13 = 0;
    var_14 = 0;

    if(isDefined(self._id_0CAC)) {
      var_13 = anim._id_0CAD;
    }
    if((self.script == "cover_left" || self.script == "cover_right") && isDefined(self.a._id_0CAE) && self.a._id_0CAE == "lean") {
      var_14 = self._id_0CAF.angles[1] - self.angles[1];
    }
    var_11 = (var_13, var_14, 0);
  }

  for(;;) {
    _id_0CC9();
    var_15 = animscripts\shared::_id_0CB0();
    var_16 = self._id_0CB1;

    if(isDefined(self._id_0CAB)) {
      var_16 = self._id_0CAB getshootatpos();
    }
    if(!isDefined(var_16) && animscripts\utility::_id_0CB2()) {
      var_16 = _id_0CB6(var_15);
    }
    var_17 = isDefined(self._id_0CB3) || isDefined(self._id_0CB4);
    var_18 = isDefined(var_16);
    var_19 = (0, 0, 0);

    if(var_18) {
      var_19 = var_16;
    }
    var_20 = 0;
    var_21 = isDefined(self._id_0CB5);

    if(var_21) {
      var_20 = self._id_0CB5;
    }
    var_6 = self getaimangle(var_15, var_19, var_18, var_11, var_20, var_21, var_17);
    var_22 = var_6[0];
    var_23 = var_6[1];
    var_6 = undefined;

    if(var_9 > 0) {
      var_9 = var_9 - 1;
      var_10 = max(10, var_10 - 5);
    } else if(self.relativedir && self.relativedir != var_8) {
      var_9 = 2;
      var_10 = 30;
    } else {
      var_10 = 10;
    }
    var_24 = squared(var_10);
    var_8 = self.relativedir;
    var_25 = self.movemode != "stop" || !var_7;

    if(var_25) {
      var_26 = var_23 - var_4;

      if(squared(var_26) > var_24) {
        var_23 = var_4 + clamp(var_26, -1 * var_10, var_10);
        var_23 = clamp(var_23, self.leftaimlimit, self.rightaimlimit);
      }

      var_27 = var_22 - var_5;

      if(squared(var_27) > var_24) {
        var_22 = var_5 + clamp(var_27, -1 * var_10, var_10);
        var_22 = clamp(var_22, self.downaimlimit, self.upaimlimit);
      }
    }

    var_7 = 0;
    var_4 = var_23;
    var_5 = var_22;
    _id_0CC2(var_0, var_1, var_2, var_3, var_22, var_23);
    wait 0.05;
  }
}

_id_0CB6(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);

  if(isDefined(self._id_0CB7)) {
    var_1 = self._id_0CB7 getshootatpos();

    if(isDefined(self._id_0CB8)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_1) && isDefined(self._id_0CB9)) {
    var_1 = self._id_0CB9;

    if(isDefined(self._id_0CBA)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  return var_1;
}

_id_0CBB(var_0, var_1) {
  if(animscripts\utility::_id_0CBC()) {
    var_2 = self.enemy getshootatpos() - self.enemy.origin;
    var_3 = self lastknownpos(self.enemy) + var_2;
    return _id_0CBE(var_3 - var_0, var_1);
  }

  var_4 = 0;
  var_5 = 0;

  if(isDefined(self.node) && isDefined(anim._id_0CBD[self.node.type]) && distancesquared(self.origin, self.node.origin) < 16) {
    var_5 = angleclamp180(self.angles[1] - self.node.angles[1]);
  } else {
    var_6 = self getanglestolikelyenemypath();

    if(isDefined(var_6)) {
      var_5 = angleclamp180(self.angles[1] - var_6[1]);
      var_4 = angleclamp180(360 - var_6[0]);
    }
  }

  return (var_4, var_5, 0);
}

_id_0CBE(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  var_3 = 0;
  var_4 = 0;

  if(self.stairsstate == "up") {
    var_3 = -40;
  } else if(self.stairsstate == "down") {
    var_3 = 40;
    var_4 = 12;
  }

  var_5 = 360 - var_2[0];
  var_5 = angleclamp180(var_5 + var_1[0] + var_3);

  if(isDefined(self._id_0CB5)) {
    var_6 = self._id_0CB5 - var_2[1];
  } else {
    var_7 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
    var_6 = var_7 + self.angles[1] - var_2[1];
  }

  var_6 = angleclamp180(var_6 + var_1[1] + var_4);
  return (var_5, var_6, 0);
}

_id_0CBF(var_0, var_1, var_2) {
  if(isDefined(self._id_0CB3) || isDefined(self._id_0CB4)) {
    if(var_1 > self.rightaimlimit || var_1 < self.leftaimlimit) {
      var_1 = 0;
    }
    if(var_0 > self.upaimlimit || var_0 < self.downaimlimit) {
      var_0 = 0;
    }
  } else if(var_2 && (abs(var_1) > anim._id_0CC0 || abs(var_0) > anim._id_0CC1)) {
    var_1 = 0;
    var_0 = 0;
  } else {
    if(self.gunblockedbywall) {
      var_1 = clamp(var_1, -10, 10);
    } else {
      var_1 = clamp(var_1, self.leftaimlimit, self.rightaimlimit);
    }
    var_0 = clamp(var_0, self.downaimlimit, self.upaimlimit);
  }

  return (var_0, var_1, 0);
}

_id_0CC2(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5 > 0) {
    var_6 = var_5 / self.rightaimlimit * self.a._id_0CC3;
    self setanimlimited(var_1, 0, 0.1, 1, 1);
    self setanimlimited(var_2, var_6, 0.1, 1, 1);
  } else if(var_5 < 0) {
    var_6 = var_5 / self.leftaimlimit * self.a._id_0CC3;
    self setanimlimited(var_2, 0, 0.1, 1, 1);
    self setanimlimited(var_1, var_6, 0.1, 1, 1);
  }

  if(var_4 > 0) {
    var_6 = var_4 / self.upaimlimit * self.a._id_0CC3;
    self setanimlimited(var_0, 0, 0.1, 1, 1);
    self setanimlimited(var_3, var_6, 0.1, 1, 1);
  } else if(var_4 < 0) {
    var_6 = var_4 / self.downaimlimit * self.a._id_0CC3;
    self setanimlimited(var_3, 0, 0.1, 1, 1);
    self setanimlimited(var_0, var_6, 0.1, 1, 1);
  }
}

_id_0CC4(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a._id_0CC3 = var_0;
    self.a._id_0CC5 = var_0;
    self.a._id_0CC6 = var_0;
    self.a._id_0CC7 = 0;
  } else {
    if(!isDefined(self.a._id_0CC3)) {
      self.a._id_0CC3 = 0;
    }
    self.a._id_0CC5 = self.a._id_0CC3;
    self.a._id_0CC6 = var_0;
    self.a._id_0CC7 = int(var_1 * 20);
  }

  self.a._id_0CC8 = 0;
}

_id_0CC9() {
  if(self.a._id_0CC8 < self.a._id_0CC7) {
    self.a._id_0CC8++;
    var_0 = 1.0 * self.a._id_0CC8 / self.a._id_0CC7;
    self.a._id_0CC3 = self.a._id_0CC5 * (1 - var_0) + self.a._id_0CC6 * var_0;
  }
}