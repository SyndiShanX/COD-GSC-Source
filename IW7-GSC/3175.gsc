/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3175.gsc
************************/

func_C97D(param_00, param_01, param_02, param_03) {
  if(self.var_527B != "patrol") {
    return 1;
  }

  return 0;
}

func_C9A0(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  if(isDefined(self.var_10E6D.var_C996) && isDefined(self.var_10E6D.var_C999)) {
    var_04 = self.var_10E6D.var_C996 + "_" + self.var_10E6D.var_C999;
    var_05 = 0;
    if(isDefined(self.var_10E6D.var_C998)) {
      var_06 = self.var_10E6D.var_C998 - self.origin;
      var_06 = vectornormalize((var_06[0], var_06[1], 0));
      var_07 = vectortoangles(var_06);
      self.var_10E6D.var_C99A = var_07[1];
      var_05 = self.angles[1] - var_07[1];
    }

    var_08 = _meth_80DE(var_05);
    if(self.getcsplinepointtargetname != "none") {
      var_04 = var_04 + "_stairs_" + self.getcsplinepointtargetname;
      if(self.asm.footsteps.foot == "left") {
        var_04 = var_04 + "_r";
      } else {
        var_04 = var_04 + "_l";
      }
    }

    var_04 = var_04 + "_" + var_08;
    if(lib_0A1E::func_2348(param_02, var_04)) {
      self.var_10E6D.var_C995 = var_04;
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

func_C9A1(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  return scripts\engine\utility::istrue(self.var_10E6D.var_C994);
}

func_CEBF(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_10E6D.var_C995;
  self.var_10E6D.var_C996 = undefined;
  self.var_10E6D.var_C998 = undefined;
  self.var_10E6D.var_C995 = undefined;
  var_05 = lib_0A1E::func_235B(param_01, var_04);
  if(!isDefined(var_05)) {
    scripts\asm\asm::asm_fireevent(param_01, "end");
    return;
  }

  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_05, 1, param_02, 1);
  lib_0A1E::func_2322(param_00, param_01, ::func_89A1);
  self.var_10E6D.var_C999 = undefined;
}

_meth_80DE(param_00) {
  param_00 = angleclamp180(param_00);
  if(param_00 > 135 || param_00 < -135) {
    var_01 = 2;
  } else if(var_01 < -45) {
    var_01 = 4;
  } else if(var_01 > 45) {
    var_01 = 6;
  } else {
    var_01 = 8;
  }

  return var_01;
}

func_89A1(param_00, param_01, param_02) {
  if(param_01 == "face_goal" && isDefined(self.var_10E6D.var_C99A)) {
    var_03 = self.var_10E6D.var_C99A;
    thread func_6A71(param_00, var_03);
    return 1;
  }

  return 0;
}

func_6A71(param_00, param_01) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(param_00 + "_finished");
  for(;;) {
    var_02 = level.player;
    if(isDefined(self.isnodeoccupied)) {
      var_02 = self.isnodeoccupied;
    }

    if(issentient(var_02) && self getpersstat(var_02)) {
      var_03 = var_02.origin - self.origin;
      var_03 = vectornormalize((var_03[0], var_03[1], 0));
      var_04 = vectortoangles(var_03);
      param_01 = var_04[1];
    }

    var_05 = angleclamp180(param_01 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var_05 * 0.1);
    wait(0.05);
  }
}

func_D4DF(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.a.var_C985 = gettime() + randomfloatrange(5, 30) * 1000;
  self.a.var_C98E = gettime();
  if(isDefined(self.a.var_C98D)) {
    func_D4DE(param_00, param_01, param_02, param_03, self.a.var_C98D);
    return;
  }

  lib_0F3D::func_D4DD(param_00, param_01, param_02, param_03);
}

func_D4DE(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = scripts\asm\asm::asm_getmoveplaybackrate();
  self _meth_84F1(var_05);
  var_06 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_06, param_02);
  if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
    var_07 = lib_0A1E::func_2356("Knobs", "move");
    self _meth_84F2(var_07);
  }

  var_08 = var_06;
  for(;;) {
    if(param_04 != var_08) {
      self _meth_82E7(param_01, param_04, 1, param_02, 1);
    }

    lib_0A1E::func_2369(param_00, param_01, param_04);
    var_08 = param_04;
    lib_0A1E::func_2320(param_00, param_01, param_04, scripts\asm\asm::func_2341(param_00, param_01));
  }
}

func_C99F(param_00, param_01, param_02, param_03) {
  self.a.var_C984 = undefined;
  var_04 = "";
  if(isDefined(param_03)) {
    var_04 = scripts\asm\asm_bb::func_2928(param_03);
  }

  var_05 = lib_0A1E::func_235D(param_02, var_04, 1);
  if(!isDefined(var_05)) {
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

  var_06 = gettime();
  if(var_06 < self.var_10E6D.var_C985) {
    return 0;
  }

  if(var_06 < self.a.var_C985) {
    return 0;
  }

  var_07 = anglesToForward(self.angles);
  var_08 = self.origin + var_07 * self.setomnvar;
  if(distancesquared(self.origin, var_08) < squared(300)) {
    return 0;
  }

  if(vectordot(var_07, self.setocclusionpreset) < 0.99) {
    return 0;
  }

  self.a.var_C984 = scripts\asm\asm::asm_lookupanimfromalias(param_02, var_05);
  return isDefined(self.a.var_C984);
}

func_CEBE(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, self.a.var_C984, 1, param_02, 1);
  lib_0A1E::func_231F(param_00, param_01);
}