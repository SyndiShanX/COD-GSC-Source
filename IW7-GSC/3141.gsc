/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3141.gsc
*********************************************/

func_BEA0(var_0, var_1, var_2, var_3) {
  self._blackboard.var_5279 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = 0;
  if(var_5) {
    if(isDefined(self.vehicle_getspawnerarray)) {
      if(distancesquared(self.vehicle_getspawnerarray, self.origin) > 144) {
        var_6 = self.setocclusionpreset;
        if(vectordot(var_6, var_4) <= 0.857) {
          self._blackboard.var_5279 = var_6;
          return 1;
        }
      }

      return 0;
    }
  } else if(isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_7 = func_7EAE();
  if(isDefined(var_7) && !isDefined(self.var_595F)) {
    var_8 = vectornormalize(var_7 - self.origin);
    if(vectordot(var_4, var_8) <= 0.5) {
      self._blackboard.var_5279 = var_8;
      return 1;
    }
  }

  if(isDefined(self.physics_querypoint)) {
    var_9 = anglesToForward(self.physics_querypoint.angles);
    if(vectordot(var_9, var_4) <= 0.857) {
      self._blackboard.var_5279 = var_9;
      return 1;
    }

    return 0;
  }

  if(isDefined(self.target_getindexoftarget)) {
    var_9 = anglesToForward(self.target_getindexoftarget.angles);
    if(vectordot(var_9, var_4) <= 0.857) {
      self._blackboard.var_5279 = var_9;
      return 1;
    }

    return 0;
  }

  return 0;
}

func_BEA1(var_0, var_1, var_2, var_3) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    if(distancesquared(self.vehicle_getspawnerarray, self.origin) > 144) {
      var_4 = self.setocclusionpreset;
      var_4 = vectornormalize((var_4[0], var_4[1], 0));
      var_5 = anglesToForward(self.angles);
      if(vectordot(var_4, var_5) <= 0.857) {
        self._blackboard.var_5279 = var_4;
        return 1;
      }
    }
  }

  return 0;
}

func_35DE(var_0, var_1, var_2, var_3) {
  self._blackboard.var_11936 = gettime();
  var_4 = self.var_164D[var_0];
  if(isDefined(var_4.var_10E23)) {
    if(var_4.var_10E23 == "run" || var_4.var_10E23 == "walk" || var_4.var_10E23 == "walk_backward") {
      childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
    }
  }

  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

func_35DF(var_0, var_1, var_2) {
  self._blackboard.var_11936 = undefined;
}

func_7EAE() {
  if(!isDefined(self._blackboard.shootparams)) {
    return undefined;
  }

  var_0 = 0;
  var_1 = (0, 0, 0);
  foreach(var_3 in lib_0C08::func_357A()) {
    var_4 = self._blackboard.shootparams.var_13CC3[var_3];
    if(isDefined(var_4)) {
      if(isDefined(var_4.var_EF76)) {
        foreach(var_6 in var_4.var_EF76) {
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

func_B32D(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

func_3EA7(var_0, var_1, var_2) {
  var_3 = self._blackboard.var_5279;
  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = vectortoangles(var_3);
  var_5 = var_4[1];
  var_6 = self.angles[1];
  var_7 = angleclamp180(var_5 - var_6);
  var_8 = getangleindex(var_7, 15);
  var_9 = func_B32D(var_8);
  if(var_9 == 8) {
    return undefined;
  }

  var_0A = "turn_" + var_9;
  if(var_9 == 2) {
    if(var_8 == 0) {
      var_0A = var_0A + "r";
    } else {
      var_0A = var_0A + "l";
    }
  }

  var_0B = lib_0A1E::func_2356(var_1, var_0A);
  return var_0B;
}

func_CEC3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_1, "end");
    return;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_7DD5() {
  if(isDefined(self.physics_querypoint)) {
    return self.physics_querypoint.origin;
  }

  if(isDefined(self.target_getindexoftarget)) {
    return self.target_getindexoftarget.origin;
  }

  return self.objective_playermask_hidefromall;
}

func_7DD4() {
  if(isDefined(self.physics_querypoint)) {
    return self.physics_querypoint.angles;
  }

  if(isDefined(self.target_getindexoftarget)) {
    return self.target_getindexoftarget.angles;
  }

  return self.angles;
}

func_1008C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = func_7DD5();
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

    var_0A = self.objective_playermask_showto;
    if(isDefined(self.target_getindexoftarget) || isDefined(self.physics_querypoint)) {
      var_0A = 0;
    }

    self.asm.var_11068 = func_3722(var_2, var_4, var_0A, 0);
  } else {
    self.asm.var_11068 = lib_0C5D::func_3721(var_0, var_1, var_2, "Exposed", 1);
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3722(var_0, var_1, var_2, var_3) {
  var_1 = func_7DD5();
  var_4 = func_7DD4();
  var_5 = var_1 - self.origin;
  if(var_3) {
    var_6 = 0;
  } else if(length2dsquared(var_6) < 144) {
    var_6 = 4;
  } else {
    var_7 = self.angles[1];
    var_8 = angleclamp180(var_4[1] - var_7);
    var_6 = getangleindex(var_8, 22.5);
  }

  var_9 = lib_0C5D::_meth_8174(var_0, undefined, 1);
  if(!isDefined(var_9[var_6])) {
    return undefined;
  }

  var_0A = getmovedelta(var_9[var_6]);
  var_0B = getangledelta3d(var_9[var_6]);
  var_0C = rotatevector(var_0A, self.angles);
  var_0D = var_0C + self.origin;
  var_0E = 0;
  var_0F = distancesquared(var_0D, var_1);
  if(var_0F > var_2 * var_2) {
    var_10 = distancesquared(var_0D + var_0C, var_1);
    if(var_10 < var_0F) {
      return undefined;
    }

    var_0E = 1;
  }

  var_11 = getclosestpointonnavmesh(var_0D, self);
  var_12 = self _meth_84AC();
  if(!navisstraightlinereachable(var_12, var_11, self)) {
    return undefined;
  }

  if(var_0E) {
    var_0C = rotatevector(var_0A, var_4 - var_0B);
    var_13 = var_1 - var_0C;
  } else if(distance2dsquared(var_12, var_0E) > 4) {
    var_0D = rotatevector(var_0B, var_5 - var_0C);
    var_13 = var_12 - var_0D;
  } else {
    var_13 = self.origin;
  }

  var_14 = spawnStruct();
  var_14.getgrenadedamageradius = var_9[var_6];
  var_14.var_3F = var_6;
  var_14.areanynavvolumesloaded = var_13;
  var_14.var_3E = var_0B[1];
  var_14.log = var_4;
  var_14.stricmp = var_0A;
  return var_14;
}

func_3E99(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right") {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  var_4 = var_3 + "2";
  var_5 = lib_0A1E::func_2356(var_1, var_4);
  return var_5;
}

func_CEAD(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = var_1;
  if(isDefined(self.asm.var_11068)) {
    var_4 = self.asm.var_11068;
    var_5 = var_4.getgrenadedamageradius;
    var_6 = var_4.log;
    var_7 = var_4.areanynavvolumesloaded;
    var_8 = var_4.var_3E;
  } else {
    var_5 = lib_0A1E::asm_getallanimsforstate(var_5, var_6);
    var_9 = getmovedelta(var_8);
    var_8 = getangledelta(var_5);
    var_0A = func_7DD5();
    var_6 = self.angles;
    var_0B = rotatevector(var_9, var_6);
    var_7 = var_0A - var_0B;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  var_0C = var_6[1] - var_8;
  if(isDefined(self.asm.var_11068)) {
    self _meth_8396(var_7, var_0C);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  self.a.movement = "stop";
}

func_1008B(var_0, var_1, var_2, var_3) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = func_7DD5();
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
    var_0A = gettime() - self.asm.footsteps.time;
    if(var_0A > 850 || var_0A < 700) {
      return 0;
    }

    var_0B = self.objective_playermask_showto;
    if(isDefined(self.target_getindexoftarget) || isDefined(self.physics_querypoint)) {
      var_0B = 0;
    }

    self.asm.var_11068 = func_3722(var_2, var_4, var_0B, 1);
  } else {
    if(var_0A < var_7) {
      return 0;
    }

    return 1;
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3E98(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right") {
    var_3 = "right8";
  } else {
    var_3 = "left8";
  }

  var_4 = lib_0A1E::func_2356(var_1, var_3);
  return var_4;
}

func_10047(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_55ED) && self.var_55ED) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 10000) {
    return 0;
  }

  if(lengthsquared(self.var_381) > 1) {
    return 0;
  }

  if(self.var_36A) {
    return 0;
  }

  self.asm.var_10D84 = lib_0C65::func_53CA(var_2, undefined, 1);
  return isDefined(self.asm.var_10D84);
}

func_10048(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_55ED) && self.var_55ED) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 10000) {
    return 0;
  }

  if(lengthsquared(self.var_381) > 1) {
    return 0;
  }

  if(self.var_36A) {
    return 0;
  }

  var_4 = scripts\asm\asm::asm_getdemeanor();
  if(var_4 != "walk" && var_4 != "casual") {
    return 0;
  }

  return 1;
}

func_3524(var_0, var_1, var_2) {
  var_3 = self.asm.var_10D84;
  self.asm.var_10D84 = undefined;
  return var_3;
}

func_100BE(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = scripts\engine\utility::flatten_vector(self.setocclusionpreset);
  var_5 = self.vehicle_getspawnerarray - self.origin;
  if(var_3 && lengthsquared(var_5) < 32400) {
    var_6 = anglesToForward(self.angles);
    if(vectordot(var_6, var_4) > 0) {
      return 0;
    }
  }

  var_7 = lib_0C08::func_7E30();
  if(isDefined(var_7)) {
    var_8 = var_7.origin - self.origin;
    if(lengthsquared(var_8) > self.setthermalbodymaterial * self.setthermalbodymaterial) {
      return 0;
    }

    var_9 = 6;
    if(self.setomnvar < var_9) {
      return 0;
    }

    var_8 = vectornormalize(var_8);
    if(vectordot(var_8, var_4) > -0.342) {
      return 0;
    }

    var_0A = var_7 getlinkedparent();
    if(isDefined(var_0A) && var_0A == self) {
      return 0;
    }

    if(isplayer(var_7) && isDefined(self._blackboard.var_E5FD) && self._blackboard.var_E5FD) {
      return 0;
    }
  } else {
    var_0B = anglesToForward(self.angles);
    if(vectordot(var_4, var_0B) > -0.707) {
      return 0;
    }

    var_0C = lengthsquared(var_5);
    if(var_0C > 65536) {
      return 0;
    }

    var_5 = scripts\engine\utility::flatten_vector(var_5);
    if(vectordot(var_5, var_4) < 0.966) {
      return 0;
    }
  }

  return 1;
}

func_100A2(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 1;
  }

  var_4 = self.objective_playermask_hidefromall - self.origin;
  var_5 = lengthsquared(var_4);
  if(var_5 > 144) {
    var_6 = scripts\engine\utility::flatten_vector(self.setocclusionpreset);
    var_7 = anglesToForward(self.angles);
    var_4 = scripts\engine\utility::flatten_vector(var_4);
    var_8 = lib_0C08::func_7E30(2000);
    if(isDefined(var_8)) {
      var_9 = scripts\engine\utility::flatten_vector(var_8.origin - self.origin);
      if(vectordot(var_9, var_6) > 0.5) {
        return 1;
      }
    } else if(var_5 > 90000) {
      return 1;
    }

    if(vectordot(var_4, var_6) < 0.866) {
      return 1;
    }

    if(vectordot(var_6, var_7) > 0) {
      return 1;
    }
  }

  return 0;
}

func_CEBB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread lib_0F3D::func_136B4(var_0, var_1, var_3);
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = func_7DD5();
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  childthread func_CEBC();
  lib_0A1E::func_231F(var_0, var_1);
}

func_CEBC() {
  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      break;
    }

    if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 144) {
      break;
    }

    var_0 = self.setocclusionpreset;
    var_1 = -1 * var_0;
    var_2 = vectortoyaw(var_1);
    self orientmode("face angle", var_2);
    wait(0.05);
  }
}

func_CEB6(var_0, var_1, var_2, var_3) {
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_5 = -1 * self.setocclusionpreset;
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  var_6 = vectortoyaw(var_5);
  var_7 = lib_0C08::func_7E30();
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
  lib_0A1E::func_231F(var_0, var_1);
}

func_CEAC(var_0, var_1, var_2, var_3) {
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = var_1;
  var_4 = func_100A2(var_0, var_1);
  var_5 = func_7DD5();
  if(isDefined(self.asm.var_11068)) {
    var_6 = self.asm.var_11068;
    var_7 = var_6.getgrenadedamageradius;
    var_8 = var_6.areanynavvolumesloaded;
    var_9 = var_6.stricmp;
  } else {
    var_7 = lib_0A1E::asm_getallanimsforstate(var_3, var_4);
    var_9 = getmovedelta(var_9);
    if(var_4) {
      var_8 = self.origin;
    } else {
      var_8 = var_5 - rotatevector(var_9, self.angles);
    }
  }

  var_0A = var_5 - self.origin;
  var_0B = -1 * var_0A;
  var_0C = vectortoyaw(var_0B);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_7, 1, var_2, 1);
  if(!var_4) {
    self _meth_8396(var_8, self.angles[1]);
  } else {
    var_0D = self.origin + rotatevector(var_9, self.angles);
    if(!self maymovefrompointtopoint(self.origin, var_0D)) {
      self _meth_8396(var_8, self.angles[1]);
    } else {
      self orientmode("face current");
    }
  }

  lib_0A1E::func_231F(var_0, var_1);
  self clearpath();
  self.a.movement = "stop";
}

func_CEAB(var_0, var_1, var_2) {
  self.asm.var_11068 = undefined;
}