/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3141.gsc
************************/

func_BEA0(param_00, param_01, param_02, param_03) {
  self.var_1198.var_5279 = undefined;
  var_04 = anglesToForward(self.angles);
  var_05 = 0;
  if(var_05) {
    if(isDefined(self.vehicle_getspawnerarray)) {
      if(distancesquared(self.vehicle_getspawnerarray, self.origin) > 144) {
        var_06 = self.setocclusionpreset;
        if(vectordot(var_06, var_04) <= 0.857) {
          self.var_1198.var_5279 = var_06;
          return 1;
        }
      }

      return 0;
    }
  } else if(isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_07 = func_7EAE();
  if(isDefined(var_07) && !isDefined(self.var_595F)) {
    var_08 = vectornormalize(var_07 - self.origin);
    if(vectordot(var_04, var_08) <= 0.5) {
      self.var_1198.var_5279 = var_08;
      return 1;
    }
  }

  if(isDefined(self.physics_querypoint)) {
    var_09 = anglesToForward(self.physics_querypoint.angles);
    if(vectordot(var_09, var_04) <= 0.857) {
      self.var_1198.var_5279 = var_09;
      return 1;
    }

    return 0;
  }

  if(isDefined(self.target_getindexoftarget)) {
    var_09 = anglesToForward(self.target_getindexoftarget.angles);
    if(vectordot(var_09, var_04) <= 0.857) {
      self.var_1198.var_5279 = var_09;
      return 1;
    }

    return 0;
  }

  return 0;
}

func_BEA1(param_00, param_01, param_02, param_03) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    if(distancesquared(self.vehicle_getspawnerarray, self.origin) > 144) {
      var_04 = self.setocclusionpreset;
      var_04 = vectornormalize((var_04[0], var_04[1], 0));
      var_05 = anglesToForward(self.angles);
      if(vectordot(var_04, var_05) <= 0.857) {
        self.var_1198.var_5279 = var_04;
        return 1;
      }
    }
  }

  return 0;
}

func_35DE(param_00, param_01, param_02, param_03) {
  self.var_1198.var_11936 = gettime();
  var_04 = self.var_164D[param_00];
  if(isDefined(var_04.var_10E23)) {
    if(var_04.var_10E23 == "run" || var_04.var_10E23 == "walk" || var_04.var_10E23 == "walk_backward") {
      childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
    }
  }

  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

func_35DF(param_00, param_01, param_02) {
  self.var_1198.var_11936 = undefined;
}

func_7EAE() {
  if(!isDefined(self.var_1198.shootparams)) {
    return undefined;
  }

  var_00 = 0;
  var_01 = (0, 0, 0);
  foreach(var_03 in lib_0C08::func_357A()) {
    var_04 = self.var_1198.shootparams.var_13CC3[var_03];
    if(isDefined(var_04)) {
      if(isDefined(var_04.var_EF76)) {
        foreach(var_06 in var_04.var_EF76) {
          if(isDefined(var_06)) {
            var_01 = var_01 + var_06.origin;
            var_00++;
          }
        }

        continue;
      }

      if(isDefined(var_04.ent)) {
        var_01 = var_01 + var_04.ent.origin;
        var_00++;
        continue;
      }

      if(isDefined(var_04.pos)) {
        var_01 = var_01 + var_04.pos;
        var_00++;
      }
    }
  }

  if(var_00 == 0) {
    return;
  }

  var_09 = var_01 / var_00;
  return var_09;
}

func_B32D(param_00) {
  var_01 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_01[param_00];
}

func_3EA7(param_00, param_01, param_02) {
  var_03 = self.var_1198.var_5279;
  if(!isDefined(var_03)) {
    return undefined;
  }

  var_04 = vectortoangles(var_03);
  var_05 = var_04[1];
  var_06 = self.angles[1];
  var_07 = angleclamp180(var_05 - var_06);
  var_08 = getangleindex(var_07, 15);
  var_09 = func_B32D(var_08);
  if(var_09 == 8) {
    return undefined;
  }

  var_0A = "turn_" + var_09;
  if(var_09 == 2) {
    if(var_08 == 0) {
      var_0A = var_0A + "r";
    } else {
      var_0A = var_0A + "l";
    }
  }

  var_0B = lib_0A1E::func_2356(param_01, var_0A);
  return var_0B;
}

func_CEC3(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  if(!isDefined(var_04)) {
    scripts\asm\asm::asm_fireevent(param_01, "end");
    return;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
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

func_1008C(param_00, param_01, param_02, param_03) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  var_04 = func_7DD5();
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = 128;
  var_06 = var_04 - self.origin;
  var_07 = length(var_06);
  if(var_07 > var_05) {
    return 0;
  }

  var_08 = 1;
  if(var_08) {
    var_09 = gettime() - self.asm.footsteps.time;
    if(var_09 < 250 || var_09 > 400) {
      return 0;
    }

    var_0A = self.objective_playermask_showto;
    if(isDefined(self.target_getindexoftarget) || isDefined(self.physics_querypoint)) {
      var_0A = 0;
    }

    self.asm.var_11068 = func_3722(param_02, var_04, var_0A, 0);
  } else {
    self.asm.var_11068 = lib_0C5D::func_3721(param_00, param_01, param_02, "Exposed", 1);
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3722(param_00, param_01, param_02, param_03) {
  param_01 = func_7DD5();
  var_04 = func_7DD4();
  var_05 = param_01 - self.origin;
  if(param_03) {
    var_06 = 0;
  } else if(length2dsquared(var_06) < 144) {
    var_06 = 4;
  } else {
    var_07 = self.angles[1];
    var_08 = angleclamp180(var_04[1] - var_07);
    var_06 = getangleindex(var_08, 22.5);
  }

  var_09 = lib_0C5D::_meth_8174(param_00, undefined, 1);
  if(!isDefined(var_09[var_06])) {
    return undefined;
  }

  var_0A = getmovedelta(var_09[var_06]);
  var_0B = getangledelta3d(var_09[var_06]);
  var_0C = rotatevector(var_0A, self.angles);
  var_0D = var_0C + self.origin;
  var_0E = 0;
  var_0F = distancesquared(var_0D, param_01);
  if(var_0F > param_02 * param_02) {
    var_10 = distancesquared(var_0D + var_0C, param_01);
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
    var_0C = rotatevector(var_0A, var_04 - var_0B);
    var_13 = param_01 - var_0C;
  } else if(distance2dsquared(var_12, var_0E) > 4) {
    var_0D = rotatevector(var_0B, var_05 - var_0C);
    var_13 = var_12 - var_0D;
  } else {
    var_13 = self.origin;
  }

  var_14 = spawnStruct();
  var_14.getgrenadedamageradius = var_09[var_06];
  var_14.var_3F = var_06;
  var_14.areanynavvolumesloaded = var_13;
  var_14.var_3E = var_0B[1];
  var_14.log = var_04;
  var_14.stricmp = var_0A;
  return var_14;
}

func_3E99(param_00, param_01, param_02) {
  if(self.asm.footsteps.foot == "right") {
    var_03 = "right";
  } else {
    var_03 = "left";
  }

  var_04 = var_03 + "2";
  var_05 = lib_0A1E::func_2356(param_01, var_04);
  return var_05;
}

func_CEAD(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = param_01;
  if(isDefined(self.asm.var_11068)) {
    var_04 = self.asm.var_11068;
    var_05 = var_04.getgrenadedamageradius;
    var_06 = var_04.log;
    var_07 = var_04.areanynavvolumesloaded;
    var_08 = var_04.var_3E;
  } else {
    var_05 = lib_0A1E::asm_getallanimsforstate(var_05, var_06);
    var_09 = getmovedelta(var_08);
    var_08 = getangledelta(var_05);
    var_0A = func_7DD5();
    var_06 = self.angles;
    var_0B = rotatevector(var_09, var_06);
    var_07 = var_0A - var_0B;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_05, 1, param_02, 1);
  var_0C = var_06[1] - var_08;
  if(isDefined(self.asm.var_11068)) {
    self _meth_8396(var_07, var_0C);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  self.a.movement = "stop";
}

func_1008B(param_00, param_01, param_02, param_03) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  var_04 = func_7DD5();
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = 48;
  var_06 = 96;
  var_07 = var_04 - self.origin;
  var_08 = length(var_07);
  if(var_08 > var_06) {
    return 0;
  }

  var_09 = 1;
  if(var_09) {
    var_0A = gettime() - self.asm.footsteps.time;
    if(var_0A > 850 || var_0A < 700) {
      return 0;
    }

    var_0B = self.objective_playermask_showto;
    if(isDefined(self.target_getindexoftarget) || isDefined(self.physics_querypoint)) {
      var_0B = 0;
    }

    self.asm.var_11068 = func_3722(param_02, var_04, var_0B, 1);
  } else {
    if(var_0A < var_07) {
      return 0;
    }

    return 1;
  }

  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3E98(param_00, param_01, param_02) {
  if(self.asm.footsteps.foot == "right") {
    var_03 = "right8";
  } else {
    var_03 = "left8";
  }

  var_04 = lib_0A1E::func_2356(param_01, var_03);
  return var_04;
}

func_10047(param_00, param_01, param_02, param_03) {
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

  self.asm.var_10D84 = lib_0C65::func_53CA(param_02, undefined, 1);
  return isDefined(self.asm.var_10D84);
}

func_10048(param_00, param_01, param_02, param_03) {
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

  var_04 = scripts\asm\asm::asm_getdemeanor();
  if(var_04 != "walk" && var_04 != "casual") {
    return 0;
  }

  return 1;
}

func_3524(param_00, param_01, param_02) {
  var_03 = self.asm.var_10D84;
  self.asm.var_10D84 = undefined;
  return var_03;
}

func_100BE(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  var_04 = scripts\engine\utility::flatten_vector(self.setocclusionpreset);
  var_05 = self.vehicle_getspawnerarray - self.origin;
  if(param_03 && lengthsquared(var_05) < 32400) {
    var_06 = anglesToForward(self.angles);
    if(vectordot(var_06, var_04) > 0) {
      return 0;
    }
  }

  var_07 = lib_0C08::func_7E30();
  if(isDefined(var_07)) {
    var_08 = var_07.origin - self.origin;
    if(lengthsquared(var_08) > self.setthermalbodymaterial * self.setthermalbodymaterial) {
      return 0;
    }

    var_09 = 6;
    if(self.setomnvar < var_09) {
      return 0;
    }

    var_08 = vectornormalize(var_08);
    if(vectordot(var_08, var_04) > -0.342) {
      return 0;
    }

    var_0A = var_07 getlinkedparent();
    if(isDefined(var_0A) && var_0A == self) {
      return 0;
    }

    if(isplayer(var_07) && isDefined(self.var_1198.var_E5FD) && self.var_1198.var_E5FD) {
      return 0;
    }
  } else {
    var_0B = anglesToForward(self.angles);
    if(vectordot(var_04, var_0B) > -0.707) {
      return 0;
    }

    var_0C = lengthsquared(var_05);
    if(var_0C > 65536) {
      return 0;
    }

    var_05 = scripts\engine\utility::flatten_vector(var_05);
    if(vectordot(var_05, var_04) < 0.966) {
      return 0;
    }
  }

  return 1;
}

func_100A2(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 1;
  }

  var_04 = self.objective_playermask_hidefromall - self.origin;
  var_05 = lengthsquared(var_04);
  if(var_05 > 144) {
    var_06 = scripts\engine\utility::flatten_vector(self.setocclusionpreset);
    var_07 = anglesToForward(self.angles);
    var_04 = scripts\engine\utility::flatten_vector(var_04);
    var_08 = lib_0C08::func_7E30(2000);
    if(isDefined(var_08)) {
      var_09 = scripts\engine\utility::flatten_vector(var_08.origin - self.origin);
      if(vectordot(var_09, var_06) > 0.5) {
        return 1;
      }
    } else if(var_05 > 90000) {
      return 1;
    }

    if(vectordot(var_04, var_06) < 0.866) {
      return 1;
    }

    if(vectordot(var_06, var_07) > 0) {
      return 1;
    }
  }

  return 0;
}

func_CEBB(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread lib_0F3D::func_136B4(param_00, param_01, param_03);
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = func_7DD5();
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  childthread func_CEBC();
  lib_0A1E::func_231F(param_00, param_01);
}

func_CEBC() {
  for(;;) {
    if(!isDefined(self.vehicle_getspawnerarray)) {
      break;
    }

    if(distancesquared(self.origin, self.vehicle_getspawnerarray) < 144) {
      break;
    }

    var_00 = self.setocclusionpreset;
    var_01 = -1 * var_00;
    var_02 = vectortoyaw(var_01);
    self orientmode("face angle", var_02);
    wait(0.05);
  }
}

func_CEB6(param_00, param_01, param_02, param_03) {
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  var_05 = -1 * self.setocclusionpreset;
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  var_06 = vectortoyaw(var_05);
  var_07 = lib_0C08::func_7E30();
  if(isDefined(var_07)) {
    var_08 = var_07.origin - self.origin;
    var_09 = vectorcross(var_05, var_08);
    if(var_09[2] < 0) {
      var_06 = var_06 - 10;
    } else {
      var_06 = var_06 + 10;
    }
  }

  self orientmode("face angle", var_06);
  lib_0A1E::func_231F(param_00, param_01);
}

func_CEAC(param_00, param_01, param_02, param_03) {
  self.var_4C7E = ::lib_0F3D::func_22EA;
  self.a.var_22E5 = param_01;
  var_04 = func_100A2(param_00, param_01);
  var_05 = func_7DD5();
  if(isDefined(self.asm.var_11068)) {
    var_06 = self.asm.var_11068;
    var_07 = var_06.getgrenadedamageradius;
    var_08 = var_06.areanynavvolumesloaded;
    var_09 = var_06.stricmp;
  } else {
    var_07 = lib_0A1E::asm_getallanimsforstate(param_03, var_04);
    var_09 = getmovedelta(var_09);
    if(var_04) {
      var_08 = self.origin;
    } else {
      var_08 = var_05 - rotatevector(var_09, self.angles);
    }
  }

  var_0A = var_05 - self.origin;
  var_0B = -1 * var_0A;
  var_0C = vectortoyaw(var_0B);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_07, 1, param_02, 1);
  if(!var_04) {
    self _meth_8396(var_08, self.angles[1]);
  } else {
    var_0D = self.origin + rotatevector(var_09, self.angles);
    if(!self maymovefrompointtopoint(self.origin, var_0D)) {
      self _meth_8396(var_08, self.angles[1]);
    } else {
      self orientmode("face current");
    }
  }

  lib_0A1E::func_231F(param_00, param_01);
  self clearpath();
  self.a.movement = "stop";
}

func_CEAB(param_00, param_01, param_02) {
  self.asm.var_11068 = undefined;
}