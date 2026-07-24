/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3141.gsc
**************************************/

_id_BEA0(var_0, var_1, var_2, var_3) {
  self._blackboard._id_5279 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = 0;

  if(var_5) {
    if(isDefined(self.pathgoalpos)) {
      if(distancesquared(self.pathgoalpos, self.origin) > 144) {
        var_6 = self.lookaheaddir;

        if(vectordot(var_6, var_4) <= 0.857) {
          self._blackboard._id_5279 = var_6;
          return 1;
        }
      }

      return 0;
    }
  } else if(isDefined(self.pathgoalpos))
    return 0;

  var_7 = _id_7EAE();

  if(isDefined(var_7) && !isDefined(self._id_595F)) {
    var_8 = vectorNormalize(var_7 - self.origin);

    if(vectordot(var_4, var_8) <= 0.5) {
      self._blackboard._id_5279 = var_8;
      return 1;
    }
  }

  if(isDefined(self.scriptedarrivalent)) {
    var_9 = anglesToForward(self.scriptedarrivalent.angles);

    if(vectordot(var_9, var_4) <= 0.857) {
      self._blackboard._id_5279 = var_9;
      return 1;
    }

    return 0;
  }

  if(isDefined(self.node)) {
    var_9 = anglesToForward(self.node.angles);

    if(vectordot(var_9, var_4) <= 0.857) {
      self._blackboard._id_5279 = var_9;
      return 1;
    }

    return 0;
  }

  return 0;
}

_id_BEA1(var_0, var_1, var_2, var_3) {
  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > 144) {
      var_4 = self.lookaheaddir;
      var_4 = vectorNormalize((var_4[0], var_4[1], 0));
      var_5 = anglesToForward(self.angles);

      if(vectordot(var_4, var_5) <= 0.857) {
        self._blackboard._id_5279 = var_4;
        return 1;
      }
    }
  }

  return 0;
}

_id_35DE(var_0, var_1, var_2, var_3) {
  self._blackboard._id_11936 = gettime();
  var_4 = self._id_164D[var_0];

  if(isDefined(var_4._id_10E23)) {
    if(var_4._id_10E23 == "run" || var_4._id_10E23 == "walk" || var_4._id_10E23 == "walk_backward") {
      childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
    }
  }

  _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
}

_id_35DF(var_0, var_1, var_2) {
  self._blackboard._id_11936 = undefined;
}

_id_7EAE() {
  if(!isDefined(self._blackboard.shootparams)) {
    return undefined;
  }

  var_0 = 0;
  var_1 = (0, 0, 0);

  foreach(var_3 in _id_0C08::_id_357A()) {
    var_4 = self._blackboard.shootparams._id_13CC3[var_3];

    if(isDefined(var_4)) {
      if(isDefined(var_4._id_EF76)) {
        foreach(var_6 in var_4._id_EF76) {
          if(isDefined(var_6)) {
            var_1 = var_1 + var_6.origin;
            var_0++;
          }
        }

        continue;
      }

      if(isDefined(var_4.ent)) {
        var_1 = var_1 + var_4.ent.origin;
        var_0++;
        continue;
      }

      if(isDefined(var_4.pos)) {
        var_1 = var_1 + var_4.pos;
        var_0++;
      }
    }
  }

  if(var_0 == 0) {
    return;
  }
  var_9 = var_1 / var_0;
  return var_9;
}

_id_B32D(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

_id_3EA7(var_0, var_1, var_2) {
  var_3 = self._blackboard._id_5279;

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = vectortoangles(var_3);
  var_5 = var_4[1];
  var_6 = self.angles[1];
  var_7 = angleclamp180(var_5 - var_6);
  var_8 = getangleindex(var_7, 15);
  var_9 = _id_B32D(var_8);

  if(var_9 == 8) {
    return undefined;
  }

  var_10 = "turn_" + var_9;

  if(var_9 == 2) {
    if(var_8 == 0) {
      var_10 = var_10 + "r";
    } else {
      var_10 = var_10 + "l";
    }
  }

  var_11 = _id_0A1E::_id_2356(var_1, var_10);
  return var_11;
}

_id_CEC3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "end");
    return;
  }

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_7DD5() {
  if(isDefined(self.scriptedarrivalent)) {
    return self.scriptedarrivalent.origin;
  }

  if(isDefined(self.node)) {
    return self.node.origin;
  }

  return self.goalpos;
}

_id_7DD4() {
  if(isDefined(self.scriptedarrivalent)) {
    return self.scriptedarrivalent.angles;
  }

  if(isDefined(self.node)) {
    return self.node.angles;
  }

  return self.angles;
}

_id_1008C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(!scripts\asm\asm::_id_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = _id_7DD5();

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = 128;
  var_6 = var_4 - self.origin;
  var_7 = length(var_6);

  if(var_7 > var_5) {
    return 0;
  }

  var_8 = 1;

  if(var_8) {
    var_9 = gettime() - self.asm.footsteps.time;

    if(var_9 < 250 || var_9 > 400) {
      return 0;
    }

    var_10 = self.goalradius;

    if(isDefined(self.node) || isDefined(self.scriptedarrivalent)) {
      var_10 = 0;
    }

    self.asm._id_11068 = _id_3722(var_2, var_4, var_10, 0);
  } else
    self.asm._id_11068 = _id_0C5D::_id_3721(var_0, var_1, var_2, "Exposed", 1);

  if(!isDefined(self.asm._id_11068)) {
    return 0;
  }

  return 1;
}

_id_3722(var_0, var_1, var_2, var_3) {
  var_1 = _id_7DD5();
  var_4 = _id_7DD4();
  var_5 = var_1 - self.origin;

  if(var_3) {
    var_6 = 0;
  } else if(length2dsquared(var_5) < 144) {
    var_6 = 4;
  } else {
    var_7 = self.angles[1];
    var_8 = angleclamp180(var_4[1] - var_7);
    var_6 = getangleindex(var_8, 22.5);
  }

  var_9 = _id_0C5D::_id_8174(var_0, undefined, 1);

  if(!isDefined(var_9[var_6])) {
    return undefined;
  }

  var_10 = getmovedelta(var_9[var_6]);
  var_11 = getangledelta3d(var_9[var_6]);
  var_12 = rotatevector(var_10, self.angles);
  var_13 = var_12 + self.origin;
  var_14 = 0;
  var_15 = distancesquared(var_13, var_1);

  if(var_15 > var_2 * var_2) {
    var_16 = distancesquared(var_13 + var_12, var_1);

    if(var_16 < var_15) {
      return undefined;
    }

    var_14 = 1;
  }

  var_17 = getclosestpointonnavmesh(var_13, self);
  var_18 = self _meth_84AC();

  if(!_func_2AC(var_18, var_17, self)) {
    return undefined;
  }

  if(var_14) {
    var_12 = rotatevector(var_10, var_4 - var_11);
    var_19 = var_1 - var_12;
  } else if(distance2dsquared(var_17, var_13) > 4) {
    var_12 = rotatevector(var_10, var_4 - var_11);
    var_19 = var_17 - var_12;
  } else
    var_19 = self.origin;

  var_20 = spawnStruct();
  var_20._id_02C9 = var_9[var_6];
  var_20.angleindex = var_6;
  var_20.startpos = var_19;
  var_20.angledelta = var_11[1];
  var_20._id_0130 = var_4;
  var_20._id_01F3 = var_10;
  return var_20;
}

_id_3E99(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  var_4 = var_3 + "2";
  var_5 = _id_0A1E::_id_2356(var_1, var_4);
  return var_5;
}

_id_CEAD(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;

  if(isDefined(self.asm._id_11068)) {
    var_4 = self.asm._id_11068;
    var_5 = var_4._id_02C9;
    var_6 = var_4._id_0130;
    var_7 = var_4.startpos;
    var_8 = var_4.angledelta;
  } else {
    var_5 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
    var_9 = getmovedelta(var_5);
    var_8 = getangledelta(var_5);
    var_10 = _id_7DD5();
    var_6 = self.angles;
    var_11 = rotatevector(var_9, var_6);
    var_7 = var_10 - var_11;
  }

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  var_12 = var_6[1] - var_8;

  if(isDefined(self.asm._id_11068)) {
    self _meth_8396(var_7, var_12);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
  self.a.movement = "stop";
}

_id_1008B(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(!scripts\asm\asm::_id_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = _id_7DD5();

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = 48;
  var_6 = 96;
  var_7 = var_4 - self.origin;
  var_8 = length(var_7);

  if(var_8 > var_6) {
    return 0;
  }

  var_9 = 1;

  if(var_9) {
    var_10 = gettime() - self.asm.footsteps.time;

    if(var_10 > 850 || var_10 < 700) {
      return 0;
    }

    var_11 = self.goalradius;

    if(isDefined(self.node) || isDefined(self.scriptedarrivalent)) {
      var_11 = 0;
    }

    self.asm._id_11068 = _id_3722(var_2, var_4, var_11, 1);
  } else {
    if(var_8 < var_5) {
      return 0;
    }

    return 1;
  }

  if(!isDefined(self.asm._id_11068)) {
    return 0;
  }

  return 1;
}

_id_3E98(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right") {
    var_3 = "right8";
  } else {
    var_3 = "left8";
  }

  var_4 = _id_0A1E::_id_2356(var_1, var_3);
  return var_4;
}

_id_10047(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_55ED) && self._id_55ED) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(distancesquared(self.origin, self.pathgoalpos) < 10000) {
    return 0;
  }

  if(lengthsquared(self.velocity) > 1) {
    return 0;
  }

  if(self.useanimgoalweight) {
    return 0;
  }

  self.asm._id_10D84 = _id_0C65::_id_53CA(var_2, undefined, 1);
  return isDefined(self.asm._id_10D84);
}

_id_10048(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_55ED) && self._id_55ED) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(distancesquared(self.origin, self.pathgoalpos) < 10000) {
    return 0;
  }

  if(lengthsquared(self.velocity) > 1) {
    return 0;
  }

  if(self.useanimgoalweight) {
    return 0;
  }

  var_4 = scripts\asm\asm::asm_getdemeanor();

  if(var_4 != "walk" && var_4 != "casual") {
    return 0;
  }

  return 1;
}

_id_3524(var_0, var_1, var_2) {
  var_3 = self.asm._id_10D84;
  self.asm._id_10D84 = undefined;
  return var_3;
}

_id_100BE(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = scripts\engine\utility::flatten_vector(self.lookaheaddir);
  var_5 = self.pathgoalpos - self.origin;

  if(var_3 && lengthsquared(var_5) < 32400) {
    var_6 = anglesToForward(self.angles);

    if(vectordot(var_6, var_4) > 0) {
      return 0;
    }
  }

  var_7 = _id_0C08::_id_7E30();

  if(isDefined(var_7)) {
    var_8 = var_7.origin - self.origin;

    if(lengthsquared(var_8) > self.maxfaceenemydist * self.maxfaceenemydist) {
      return 0;
    }

    var_9 = 6;

    if(self.lookaheaddist < var_9) {
      return 0;
    }

    var_8 = vectorNormalize(var_8);

    if(vectordot(var_8, var_4) > -0.342) {
      return 0;
    }

    var_10 = var_7 getlinkedparent();

    if(isDefined(var_10) && var_10 == self) {
      return 0;
    }

    if(isPlayer(var_7) && isDefined(self._blackboard._id_E5FD) && self._blackboard._id_E5FD) {
      return 0;
    }
  } else {
    var_11 = anglesToForward(self.angles);

    if(vectordot(var_4, var_11) > -0.707) {
      return 0;
    }

    var_12 = lengthsquared(var_5);

    if(var_12 > 65536) {
      return 0;
    }

    var_5 = scripts\engine\utility::flatten_vector(var_5);

    if(vectordot(var_5, var_4) < 0.966) {
      return 0;
    }
  }

  return 1;
}

_id_100A2(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos)) {
    return 1;
  }

  var_4 = self.goalpos - self.origin;
  var_5 = lengthsquared(var_4);

  if(var_5 > 144) {
    var_6 = scripts\engine\utility::flatten_vector(self.lookaheaddir);
    var_7 = anglesToForward(self.angles);
    var_4 = scripts\engine\utility::flatten_vector(var_4);
    var_8 = _id_0C08::_id_7E30(2000);

    if(isDefined(var_8)) {
      var_9 = scripts\engine\utility::flatten_vector(var_8.origin - self.origin);

      if(vectordot(var_9, var_6) > 0.5) {
        return 1;
      }
    } else if(var_5 > 90000)
      return 1;

    if(vectordot(var_4, var_6) < 0.866) {
      return 1;
    }

    if(vectordot(var_6, var_7) > 0) {
      return 1;
    }
  }

  return 0;
}

_id_CEBB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread _id_0F3D::_id_136B4(var_0, var_1, var_3);
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = _id_7DD5();
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  childthread _id_CEBC();

  for(;;) {
    _id_0A1E::_id_231F(var_0, var_1);
  }
}

_id_CEBC() {
  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    if(distancesquared(self.origin, self.pathgoalpos) < 144) {
      break;
    }

    var_0 = self.lookaheaddir;
    var_1 = -1 * var_0;
    var_2 = vectortoyaw(var_1);
    self orientmode("face angle", var_2);
    wait 0.05;
  }
}

_id_CEB6(var_0, var_1, var_2, var_3) {
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = -1 * self.lookaheaddir;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  var_6 = vectortoyaw(var_5);
  var_7 = _id_0C08::_id_7E30();

  if(isDefined(var_7)) {
    var_8 = var_7.origin - self.origin;
    var_9 = vectorcross(var_5, var_8);

    if(var_9[2] < 0) {
      var_6 = var_6 - 10;
    } else {
      var_6 = var_6 + 10;
    }
  }

  self orientmode("face angle", var_6);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_CEAC(var_0, var_1, var_2, var_3) {
  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  var_4 = _id_100A2(var_0, var_1);
  var_5 = _id_7DD5();

  if(isDefined(self.asm._id_11068)) {
    var_6 = self.asm._id_11068;
    var_7 = var_6._id_02C9;
    var_8 = var_6.startpos;
    var_9 = var_6._id_01F3;
  } else {
    var_7 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
    var_9 = getmovedelta(var_7);

    if(var_4) {
      var_8 = self.origin;
    } else {
      var_8 = var_5 - rotatevector(var_9, self.angles);
    }
  }

  var_10 = var_5 - self.origin;
  var_11 = -1 * var_10;
  var_12 = vectortoyaw(var_11);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_7, 1, var_2, 1);

  if(!var_4) {
    self _meth_8396(var_8, self.angles[1]);
  } else {
    var_13 = self.origin + rotatevector(var_9, self.angles);

    if(!self maymovefrompointtopoint(self.origin, var_13)) {
      self _meth_8396(var_8, self.angles[1]);
    } else {
      self orientmode("face current");
    }
  }

  _id_0A1E::_id_231F(var_0, var_1);
  self clearpath();
  self.a.movement = "stop";
}

_id_CEAB(var_0, var_1, var_2) {
  self.asm._id_11068 = undefined;
}