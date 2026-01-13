/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3175.gsc
************************/

func_C97D(var_0, var_1, var_2, var_3) {
  if(self.var_527B != "patrol") {
    return 1;
  }

  return 0;
}

func_C9A0(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  if(isDefined(self.var_10E6D.var_C996) && isDefined(self.var_10E6D.var_C999)) {
    var_4 = self.var_10E6D.var_C996 + "_" + self.var_10E6D.var_C999;
    var_5 = 0;
    if(isDefined(self.var_10E6D.var_C998)) {
      var_6 = self.var_10E6D.var_C998 - self.origin;
      var_6 = vectornormalize((var_6[0], var_6[1], 0));
      var_7 = vectortoangles(var_6);
      self.var_10E6D.var_C99A = var_7[1];
      var_5 = self.angles[1] - var_7[1];
    }

    var_8 = _meth_80DE(var_5);
    if(self.getcsplinepointtargetname != "none") {
      var_4 = var_4 + "_stairs_" + self.getcsplinepointtargetname;
      if(self.asm.footsteps.foot == "left") {
        var_4 = var_4 + "_r";
      } else {
        var_4 = var_4 + "_l";
      }
    }

    var_4 = var_4 + "_" + var_8;
    if(lib_0A1E::func_2348(var_2, var_4)) {
      self.var_10E6D.var_C995 = var_4;
      self.var_10E6D.var_C994 = undefined;
      return 1;
    } else {
      self.var_10E6D.var_C996 = undefined;
      self.var_10E6D.var_C998 = undefined;
      self.var_10E6D.var_C995 = undefined;
      self.var_10E6D.var_C994 = undefined;
    }
  }

  return 0;
}

func_C9A1(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  return scripts\engine\utility::istrue(self.var_10E6D.var_C994);
}

func_CEBF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.var_10E6D.var_C995;
  self.var_10E6D.var_C996 = undefined;
  self.var_10E6D.var_C998 = undefined;
  self.var_10E6D.var_C995 = undefined;
  var_5 = lib_0A1E::func_235B(var_1, var_4);
  if(!isDefined(var_5)) {
    scripts\asm\asm::asm_fireevent(var_1, "end");
    return;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2, 1);
  lib_0A1E::func_2322(var_0, var_1, ::func_89A1);
  self.var_10E6D.var_C999 = undefined;
}

_meth_80DE(var_0) {
  var_0 = angleclamp180(var_0);
  if(var_0 > 135 || var_0 < -135) {
    var_1 = 2;
  } else if(var_1 < -45) {
    var_1 = 4;
  } else if(var_1 > 45) {
    var_1 = 6;
  } else {
    var_1 = 8;
  }

  return var_1;
}

func_89A1(var_0, var_1, var_2) {
  if(var_1 == "face_goal" && isDefined(self.var_10E6D.var_C99A)) {
    var_3 = self.var_10E6D.var_C99A;
    thread func_6A71(var_0, var_3);
    return 1;
  }

  return 0;
}

func_6A71(var_0, var_1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var_0 + "_finished");
  for(;;) {
    var_2 = level.player;
    if(isDefined(self.isnodeoccupied)) {
      var_2 = self.isnodeoccupied;
    }

    if(issentient(var_2) && self getpersstat(var_2)) {
      var_3 = var_2.origin - self.origin;
      var_3 = vectornormalize((var_3[0], var_3[1], 0));
      var_4 = vectortoangles(var_3);
      var_1 = var_4[1];
    }

    var_5 = angleclamp180(var_1 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var_5 * 0.1);
    wait(0.05);
  }
}

func_D4DF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.a.var_C985 = gettime() + randomfloatrange(5, 30) * 1000;
  self.a.var_C98E = gettime();
  if(isDefined(self.a.var_C98D)) {
    func_D4DE(var_0, var_1, var_2, var_3, self.a.var_C98D);
    return;
  }

  lib_0F3D::func_D4DD(var_0, var_1, var_2, var_3);
}

func_D4DE(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = scripts\asm\asm::asm_getmoveplaybackrate();
  self _meth_84F1(var_5);
  var_6 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_6, var_2);
  if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
    var_7 = lib_0A1E::func_2356("Knobs", "move");
    self _meth_84F2(var_7);
  }

  var_8 = var_6;
  for(;;) {
    if(var_4 != var_8) {
      self _meth_82E7(var_1, var_4, 1, var_2, 1);
    }

    lib_0A1E::func_2369(var_0, var_1, var_4);
    var_8 = var_4;
    lib_0A1E::func_2320(var_0, var_1, var_4, scripts\asm\asm::func_2341(var_0, var_1));
  }
}

func_C99F(var_0, var_1, var_2, var_3) {
  self.a.var_C984 = undefined;
  var_4 = "";
  if(isDefined(var_3)) {
    var_4 = scripts\asm\asm_bb::func_2928(var_3);
  }

  var_5 = lib_0A1E::func_235D(var_2, var_4, 1);
  if(!isDefined(var_5)) {
    return 0;
  }

  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  if(!isDefined(self.var_10E6D.var_C985)) {
    return 0;
  }

  if(!isDefined(self.a.var_C985)) {
    return 0;
  }

  if(isDefined(self.a.var_C98D)) {
    return 0;
  }

  if(self.getcsplinepointtargetname != "none") {
    return 0;
  }

  var_6 = gettime();
  if(var_6 < self.var_10E6D.var_C985) {
    return 0;
  }

  if(var_6 < self.a.var_C985) {
    return 0;
  }

  var_7 = anglesToForward(self.angles);
  var_8 = self.origin + var_7 * self.setomnvar;
  if(distancesquared(self.origin, var_8) < squared(300)) {
    return 0;
  }

  if(vectordot(var_7, self.setocclusionpreset) < 0.99) {
    return 0;
  }

  self.a.var_C984 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_5);
  return isDefined(self.a.var_C984);
}

func_CEBE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, self.a.var_C984, 1, var_2, 1);
  lib_0A1E::func_231F(var_0, var_1);
}