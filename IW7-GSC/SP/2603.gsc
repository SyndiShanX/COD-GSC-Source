/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2603.gsc
************************/

func_11A90(param_00) {
  func_F724();
  self.asm.var_11AC7 = param_00;
  var_01 = lib_0A1E::func_2356("Knobs", "aim_2");
  var_02 = lib_0A1E::func_2356("Knobs", "aim_4");
  var_03 = lib_0A1E::func_2356("Knobs", "aim_6");
  var_04 = lib_0A1E::func_2356("Knobs", "aim_8");
  func_11AF2(var_01, var_02, var_03, var_04);
  func_11AF8(param_00);
}

func_11AF2(param_00, param_01, param_02, param_03) {
  self.a.var_1A4B = 1;
  self.a.var_1A4D = 1;
  self.a.var_1A4C = 1;
  self.a.var_1A4F = 0;
  self.a.var_1A4E = 0;
  var_04 = spawnStruct();
  var_04.var_1A1E = param_00;
  var_04.var_1A20 = param_01;
  var_04.var_1A23 = param_02;
  var_04.var_1A25 = param_03;
  self.asm.var_11A90 = var_04;
}

func_103B3() {
  self endon("stop_sniper");
  self waittill("death");
  if(isDefined(self.var_103A9)) {
    self.var_103A9 delete();
    self.var_103A9 = undefined;
  }
}

func_103BC() {
  if(isDefined(self.var_103A9)) {
    self notify("stop_sniper");
    self.var_103A9[[self.var_71BC]]();
    self.var_103A9 delete();
    self.var_103A9 = undefined;
    self.bhaslasertag = undefined;
    self _meth_857A("none");
  }
}

shoulduselasertag() {
  var_00 = getweaponbasename(self.var_394);
  switch (var_00) {
    case "iw7_m8":
      return 1;

    default:
      break;
  }

  return 0;
}

getlaserstartpoint() {
  if(!isDefined(self.bhaslasertag)) {
    if(shoulduselasertag()) {
      var_00 = self gettagorigin("tag_laser", 1);
      if(isDefined(var_00)) {
        self.bhaslasertag = 1;
        return var_00;
      }
    }

    self.bhaslasertag = 0;
  } else if(scripts\engine\utility::istrue(self.bhaslasertag)) {
    if(!shoulduselasertag()) {
      self.bhaslasertag = 0;
    }
  }

  if(self.bhaslasertag) {
    return self gettagorigin("tag_laser");
  }

  return self getmuzzlepos();
}

getlaserdirection() {
  return self _meth_853C();
}

getlaserangles() {
  return self getspawnpointdist();
}

func_103BB() {
  if(isDefined(self.var_103A9)) {
    return;
  }

  thread func_103B3();
  var_00 = getlaserstartpoint();
  self.var_103A9 = spawn("script_model", var_00);
  self.var_103A9 setModel("tag_laser");
  self.var_103A9 _meth_8575(self.var_394);
  self.var_103A9 setotherent(self);
  self.var_103A9.origin = var_00;
  self _meth_857A("interpolate");
  self.var_103A9[[self.var_71BD]]();
  while(isalive(self) && isDefined(self.var_103A9)) {
    if(isDefined(self.var_45E2.var_1A2B)) {
      var_00 = getlaserstartpoint();
      self.var_103A9.origin = var_00;
      var_01 = self.var_45E2.var_1A2B;
      var_02 = vectornormalize(var_01 - var_00);
      var_03 = getlaserdirection();
      var_02 = vectornormalize((var_02[0], var_02[1], 0));
      var_03 = vectornormalize((var_03[0], var_03[1], 0));
      var_04 = vectordot(var_02, var_03);
      if(var_04 < 0.996) {
        self.var_103A9.angles = getlaserangles();
      } else {
        self.var_103A9.angles = vectortoangles(self.var_45E2.var_1A2B - self.var_103A9.origin);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_11B0B() {
  func_103BC();
}

func_11B0C() {
  if(!isDefined(self.var_103A9)) {
    thread func_103BB();
  }
}

func_41A1() {
  self.var_45E2 = undefined;
}

func_E24D(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_45E2)) {
    self.var_45E2 = spawnStruct();
  }

  self.var_45E2.var_103A6 = undefined;
  self.var_45E2.target = param_00.target;
  self.var_45E2.var_45DC = 96;
  if(param_01) {
    self.var_45E2.var_45E1 = 1500;
  } else if(scripts\engine\utility::istrue(param_03)) {
    self.var_45E2.var_45E1 = 1500;
  } else {
    self.var_45E2.var_45E1 = 2000;
  }

  self _meth_857A("interpolate");
  var_04 = scripts\sp\gameskill::func_7C6D(level.var_7683);
  var_05 = level.var_54D0["sniper_converge_scale"][var_04];
  if(isDefined(var_05)) {
    self.var_45E2.var_45E1 = self.var_45E2.var_45E1 * var_05;
  }

  if(isDefined(level.var_103A4)) {
    self.var_45E2.var_45E1 = self.var_45E2.var_45E1 * level.var_103A4;
  }

  self.var_45E2.var_45DB = 12;
  self.var_45E2.var_AED8 = 750;
  self.var_45E2.var_45DA = undefined;
  if(!isDefined(self.var_103A9)) {
    self.var_45E2.var_45D8 = -1500;
  } else {
    self.var_45E2.var_45D8 = 0;
  }

  self.var_45E2.var_45E0 = self.var_45E2.var_45E1 + 1000;
  self.var_45E2.var_45D9 = self.var_45E2.var_45E0 + 500;
  if(isDefined(param_00.pos)) {
    var_06 = undefined;
    var_07 = undefined;
    if(isDefined(param_02)) {
      var_06 = param_02;
    } else {
      if(isDefined(param_00.target)) {
        var_08 = param_00.target.origin;
        if(isplayer(param_00.target)) {
          var_07 = param_00.target getvelocity();
          if(var_07 == (0, 0, 0)) {
            var_07 = undefined;
          }
        }
      } else {
        var_08 = param_01.pos - (0, 0, 70);
      }

      var_09 = var_08 - self.origin;
      var_09 = (var_09[0], var_09[1], 0);
      var_0A = vectornormalize(var_09);
      if(scripts\engine\utility::istrue(param_03)) {
        var_06 = var_08;
        var_06 = var_06 + (0, 0, randomfloatrange(12, 36));
      } else {
        var_06 = var_08 - var_0A * randomfloatrange(120, 180);
      }

      var_0B = vectorcross(var_0A, (0, 0, 1));
      var_0C = randomfloatrange(6, 36);
      if(scripts\engine\utility::istrue(param_03)) {
        var_0C = randomfloatrange(12, 24);
      }

      if(isDefined(var_07)) {
        var_0D = vectordot(var_07, var_0B);
        if(var_0D < 0) {
          var_06 = var_06 + var_0B * var_0C;
        } else {
          var_06 = var_06 - var_0B * var_0C;
        }
      } else if(randomintrange(0, 2)) {
        var_06 = var_06 + var_0B * var_0C;
      } else {
        var_06 = var_06 - var_0B * var_0C;
      }
    }

    self.var_45E2.var_45DE = vectornormalize(var_06 - param_00.pos);
    self.var_45E2.var_45DC = distance(var_06, param_00.pos);
  }
}

func_36DA(param_00) {
  if(isDefined(self.var_45E2.var_45DA) && gettime() - self.var_45E2.var_45DA >= 100) {
    var_01 = gettime() - self.var_45E2.var_45DA;
    if(isDefined(param_00.target) && isplayer(param_00.target)) {
      self _meth_857A("lock");
    } else {
      self _meth_857A("interpolate");
    }

    return param_00.pos - (0, 0, 1.3);
  }

  var_02 = vectornormalize(var_01.pos - self.origin);
  var_03 = vectortoangles(var_02);
  if(self.var_45E2.var_45D8 < 0) {
    self _meth_857A("interpolate");
    var_04 = var_01.pos + self.var_45E2.var_45DE * self.var_45E2.var_45DC;
    return var_04;
  }

  var_05 = self.var_45E2.var_45E1 - self.var_45E2.var_45D8 / self.var_45E2.var_45E1;
  if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1) {
    var_05 = 0;
  }

  var_06 = var_05 * self.var_45E2.var_45DC - self.var_45E2.var_45DB + self.var_45E2.var_45DB;
  var_04 = var_02.pos + self.var_45E2.var_45DE * var_06;
  if(isDefined(var_01.target) && isplayer(var_01.target)) {
    self _meth_857A("interpolate");
  }

  return var_06;
}

func_C59A() {
  if(isDefined(self.var_45E2) && isDefined(self.var_103A9)) {
    self.var_45E2.var_103A6 = 1;
  }
}

func_C599() {
  if(isDefined(self.var_103A9)) {
    self.var_103A9[[self.var_71BC]]();
    thread func_129A4(0.5);
  }
}

func_129A4(param_00) {
  self endon("death");
  wait(param_00);
  if(isDefined(self.var_103A9)) {
    self.var_103A9[[self.var_71BD]]();
  }
}

func_45E5(param_00) {
  var_01 = 1;
  var_02 = 0;
  if(isDefined(param_00.target)) {
    var_01 = self getpersstat(param_00.target);
    if(isDefined(self.var_45E2) && isDefined(self.var_45E2.target) && self.var_45E2.target != param_00.target) {
      var_02 = 1;
    }

    if(var_01) {
      param_00.pos = param_00.target getshootatpos();
    }
  }

  if(!isDefined(self.var_45E2) || var_02) {
    func_E24D(param_00, var_02);
  } else if(var_01 && !scripts\engine\utility::istrue(self.var_45E2.var_2AB7)) {
    if(isDefined(self.var_45E2.var_1A2B) && distancesquared(self.var_45E2.var_1A2B, param_00.pos) < 3600) {
      func_E24D(param_00, var_02, undefined, 1);
    } else {
      func_E24D(param_00, var_02);
    }
  } else if(scripts\engine\utility::istrue(self.var_45E2.var_103A6)) {
    self _meth_857A("interpolate");
    self.var_45E2.var_103A6 = undefined;
    if(isDefined(param_00.target) && isplayer(param_00.target) && self getpersstat(param_00.target)) {
      func_E24D(param_00, var_02, undefined, 1);
    }
  }

  self.var_45E2.var_2AB7 = var_01;
  var_03 = 1;
  var_04 = getlaserstartpoint();
  var_05 = func_36DA(param_00);
  var_06 = vectornormalize(var_05 - var_04);
  var_07 = self _meth_853C();
  if(self.var_45E2.var_45D8 < 0) {
    if(!func_9D30()) {
      return 0;
    }

    self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
    var_08 = vectordot(var_06, var_07);
    if(var_08 < 0.984) {
      return 0;
    }

    var_06 = vectornormalize((var_06[0], var_06[1], 0));
    var_07 = vectornormalize((var_07[0], var_07[1], 0));
    var_09 = vectordot(var_06, var_07);
    if(var_09 < 0.996) {
      return 0;
    }

    self.var_45E2.var_45D8 = 0;
  } else {
    self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
    var_08 = vectordot(var_08, var_09);
    if(var_09 < 0.984) {
      var_04 = 0;
    }

    var_07 = vectornormalize((var_07[0], var_07[1], 0));
    var_08 = vectornormalize((var_08[0], var_08[1], 0));
    var_09 = vectordot(var_07, var_08);
    if(var_09 < 0.996) {
      var_03 = 0;
    }
  }

  if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1) {
    if(isDefined(param_00.target)) {
      if(!isDefined(self.var_45E2.var_45DA)) {
        if(var_01) {
          self.var_45E2.var_45DA = gettime();
        }
      } else if(gettime() >= self.var_45E2.var_45DA + 200) {
        if(!var_01) {
          self.var_45E2.var_45DA = undefined;
        }
      }
    }
  }

  return var_03;
}

_meth_811E(param_00) {
  var_01 = spawnStruct();
  if(scripts\anim\utility::func_FFDB()) {
    var_02 = func_11AFB(param_00);
    if(isDefined(var_02)) {
      var_01.var_FECF = var_02;
      var_01.var_2AA9 = 1;
      return var_01;
    }
  }

  var_03 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    var_03 = self.var_1198.shootparams;
  } else if(isDefined(self.asm.shootparams)) {
    var_03 = self.asm.shootparams;
  }

  if(!scripts\asm\asm_bb::func_2985()) {
    return undefined;
  } else if(isDefined(var_03.ent)) {
    var_01.var_FECF = var_03.ent getshootatpos();
  } else if(isDefined(var_03.pos)) {
    var_01.var_FECF = var_03.pos;
  }

  if(isDefined(var_01.var_FECF)) {
    return var_01;
  }

  return undefined;
}

func_9F60() {
  if(!isDefined(self.var_45E2)) {
    return 0;
  }

  return 1;
}

func_9F61() {
  if(isDefined(self.var_103A9)) {
    return 1;
  }

  return 0;
}

func_9D30() {
  if(!isDefined(self.asm.var_1A49)) {
    return 0;
  }

  var_00 = 100;
  var_00 = var_00 * 2;
  var_01 = gettime();
  if(self.asm.var_1A49 + var_00 < var_01) {
    return 1;
  }

  return 0;
}

func_11AF8(param_00) {
  self endon("death");
  self.asm.var_D8C7 = 0;
  self.asm.var_D8BB = 0;
  var_01 = (0, 0, 0);
  var_02 = 1;
  var_03 = 0;
  var_04 = 0;
  var_05 = 10;
  for(;;) {
    func_93E2();
    var_06 = scripts\asm\asm::func_231B(self.asm.var_11AC7, "aim");
    if(!var_06 && scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
      var_06 = scripts\asm\asm::func_232B(scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7), "start_aim");
    }

    if(!var_06 || !isDefined(self.var_1198.shootparams)) {
      if(!var_06 && isDefined(self.var_45E2)) {
        func_41A1();
      }

      func_11B0B();
      self.asm.var_1A49 = undefined;
    } else if(!isDefined(self.asm.var_1A49)) {
      self.asm.var_1A49 = gettime();
    }

    var_01 = (0, 0, 0);
    if(var_06) {
      var_07 = scripts\anim\shared::_meth_811C();
      var_08 = _meth_811E(var_07);
      var_09 = undefined;
      if(isDefined(var_08)) {
        var_09 = var_08.var_FECF;
      }

      var_0A = self _meth_8164();
      var_0B = isDefined(var_0A);
      if(var_0B) {
        var_0C = var_0A _meth_851F();
        var_0D = anglesToForward(self.angles);
        var_0E = rotatevector(var_0D, var_0C);
        var_09 = var_07 + var_0E * 512;
      } else if(scripts\asm\asm_bb::func_2985() && isDefined(self.var_1198.shootparams.pos)) {
        if(isDefined(self.var_1198.shootparams.var_29AF)) {
          var_0F = func_45E5(self.var_1198.shootparams);
          var_09 = func_36DA(self.var_1198.shootparams);
          self.var_45E2.var_1A2B = var_09;
          if(var_0F) {
            func_11B0C();
          } else {
            func_11B0B();
          }
        } else {
          func_11B0B();
        }
      } else {
        func_11B0B();
      }

      var_10 = isDefined(var_09);
      var_11 = (0, 0, 0);
      if(var_10) {
        var_11 = var_09;
      }

      var_12 = 0;
      var_13 = isDefined(self.var_10F8C);
      if(var_13) {
        var_12 = self.var_10F8C;
      }

      var_14 = 0;
      var_15 = 0;
      var_16 = scripts\asm\asm_bb::bb_getcovernode();
      if(isDefined(var_16) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed") {
        var_17 = scripts\asm\asm_bb::func_2929();
        if(isDefined(var_17)) {
          var_14 = scripts\asm\shared_utility::func_7FF2(param_00, var_16, var_17);
          var_15 = scripts\asm\shared_utility::func_7FF1(param_00, var_16, var_17);
        }
      }

      var_18 = (var_15, var_14, 0);
      if(scripts\engine\utility::func_9DA3() || isDefined(var_08) && isDefined(var_08.var_2AA9) && var_08.var_2AA9) {
        var_01 = self getrunningforwarddeathanim(var_07, var_11, var_10, var_18, var_12, var_13, 0);
      } else {
        var_01 = (0, 0, 0);
      }
    } else if(self.asm.var_D8C7 < 5 && self.asm.var_D8BB < 5) {
      wait(0.05);
      continue;
    }

    var_19 = var_01[0];
    var_1A = var_01[1];
    var_01 = undefined;
    if(var_04 > 0) {
      var_04 = var_04 - 1;
      var_05 = max(10, var_05 - 5);
    } else if(self.line && self.line != var_03) {
      var_04 = 2;
      var_05 = 30;
    } else if(scripts\anim\utility_common::isasniper()) {
      var_05 = 2;
    } else {
      var_05 = 10;
    }

    var_1B = 4;
    var_03 = self.line;
    var_1C = self.synctransients != "stop" || !var_02;
    if(var_1C) {
      var_1D = var_1A - self.asm.var_D8C7;
      if(squared(var_1D) > var_1B) {
        var_1E = var_1D * 0.4;
        var_1A = self.asm.var_D8C7 + clamp(var_1E, -1 * var_05, var_05);
        var_1A = clamp(var_1A, self.setdevdvar, self.setmatchdatadef);
      }

      var_1F = var_19 - self.asm.var_D8BB;
      if(squared(var_1F) > var_1B) {
        var_20 = var_1F * 0.4;
        var_19 = self.asm.var_D8BB + clamp(var_20, -1 * var_05, var_05);
        var_19 = clamp(var_19, self.var_368, self.isbot);
      }
    }

    var_02 = 0;
    self.asm.var_D8C7 = var_1A;
    self.asm.var_D8BB = var_19;
    if(isDefined(self.asm.var_58EC) && self.asm.var_58EC) {
      func_11AFF(var_19, var_1A);
    } else {
      func_11AFE(var_19, var_1A);
    }

    wait(0.05);
  }
}

func_11AFD() {
  if(!isDefined(self.asm.var_D8C7)) {
    return;
  }

  var_00 = clamp(self.asm.var_D8C7, self.setdevdvar, self.setmatchdatadef);
  var_01 = clamp(self.asm.var_D8BB, self.var_368, self.isbot);
  if(isDefined(self.asm.var_58EC) && self.asm.var_58EC) {
    func_11AFF(var_01, var_00);
    return;
  }

  func_11AFE(var_01, var_00);
}

func_11AFB(param_00) {
  var_01 = undefined;
  var_02 = anglesToForward(self.angles);
  if(isDefined(self.var_4792)) {
    var_01 = self.var_4792 getshootatpos();
    if(isDefined(self.var_4796)) {
      if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.177) {
        var_01 = undefined;
      }
    } else if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.643) {
      var_01 = undefined;
    }
  }

  if(!isDefined(var_01) && isDefined(self.var_478F)) {
    var_01 = self.var_478F;
    if(isDefined(self.var_4795)) {
      if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.177) {
        var_01 = undefined;
      }
    } else if(vectordot(vectornormalize(var_01 - param_00), var_02) < 0.643) {
      var_01 = undefined;
    }
  }

  return var_01;
}

func_11AFE(param_00, param_01) {
  var_02 = undefined;
  if(isDefined(self.asm.var_11A90.var_1A1D)) {
    var_03 = self.asm.var_11A90.var_1A1D;
    var_04 = self.asm.var_11A90.var_1A1F;
    var_05 = self.asm.var_11A90.var_1A22;
    var_06 = self.asm.var_11A90.var_1A24;
  } else {
    var_03 = self.asm.var_11A90.var_1A1E;
    var_04 = self.asm.var_11A90.var_1A20;
    var_05 = self.asm.var_11A90.var_1A23;
    var_06 = self.asm.var_11A90.var_1A25;
  }

  if(isDefined(self.asm.var_11A90.var_1A21)) {
    var_02 = self.asm.var_11A90.var_1A21;
  }

  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 0;
  var_0B = 0;
  if(param_01 < 0) {
    var_0A = param_01 / self.setdevdvar * self.a.var_1A4B;
    var_09 = 1;
  } else if(param_01 > 0) {
    var_08 = param_01 / self.setmatchdatadef * self.a.var_1A4B;
    var_09 = 1;
  }

  if(param_00 < 0) {
    var_0B = param_00 / self.var_368 * self.a.var_1A4B;
    var_09 = 1;
  } else if(param_00 > 0) {
    var_07 = param_00 / self.isbot * self.a.var_1A4B;
    var_09 = 1;
  }

  self _meth_82AC(var_03, var_07, 0.1, 1, 1);
  self _meth_82AC(var_04, var_08, 0.1, 1, 1);
  self _meth_82AC(var_05, var_0A, 0.1, 1, 1);
  self _meth_82AC(var_06, var_0B, 0.1, 1, 1);
  if(isDefined(var_02)) {
    self _meth_82AC(var_02, var_09, 0.1, 1, 1);
  }
}

func_11AFF(param_00, param_01) {
  var_02 = self.asm.var_11A90.var_AD94;
  var_03 = self.asm.var_11A90.var_AD95;
  var_04 = self.asm.var_11A90.var_AD96;
  var_05 = self.asm.var_11A90.var_AD97;
  var_06 = self.asm.var_11A90.var_AD98;
  var_07 = self.asm.var_11A90.var_AD99;
  var_08 = self.asm.var_11A90.var_AD9A;
  var_09 = self.asm.var_11A90.var_AD9B;
  var_0A = [var_06, var_09, var_08, var_07, var_05, var_02, var_03, var_04, var_06];
  var_0B = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_0C = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var_0D = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var_0E = (param_01, param_00, 0);
  var_0F = length2d(var_0E);
  var_10 = vectornormalize(var_0E);
  var_11 = vectortoyaw(var_10);
  var_11 = angleclamp180(var_11);
  for(var_12 = 0; var_11 > var_0B[var_12]; var_12++) {}

  if(var_12 == 0) {
    var_12 = 1;
  }

  for(var_13 = 0; var_13 < var_0A.size; var_13++) {
    if(var_13 == var_12 || var_13 == var_12 - 1) {
      var_14 = clamp(var_0F / var_0D[var_13], 0, 1);
      var_15 = acos(vectordot(var_0C[var_13], var_10));
      var_16 = clamp(1 - var_15 / var_0D[var_13], 0, 1);
      var_17 = self getscoreinfocategory(var_0A[var_13]);
      if(var_17 > 0) {
        var_18 = getanimlength(var_0A[var_13]);
        var_19 = var_14 - var_17 * var_18 / 0.05;
        self _meth_82AC(var_0A[var_13], var_16, 0.05, var_19);
      } else {
        self _meth_82AC(var_0A[var_13], var_16, 0.05, 0);
        self _meth_82B0(var_0A[var_13], var_14);
      }

      continue;
    }

    if(var_0A[var_13] != var_0A[var_12] && var_0A[var_13] != var_0A[var_12 - 1]) {
      self clearanim(var_0A[var_13], 0.05);
    }
  }
}

func_F641(param_00, param_01) {
  if(!isDefined(param_01) || param_01 <= 0) {
    self.a.var_1A4B = param_00;
    self.a.var_1A4D = param_00;
    self.a.var_1A4C = param_00;
    self.a.var_1A4F = 0;
  } else {
    if(!isDefined(self.a.var_1A4B)) {
      self.a.var_1A4B = 0;
    }

    self.a.var_1A4D = self.a.var_1A4B;
    self.a.var_1A4C = param_00;
    self.a.var_1A4F = int(param_01 * 20);
  }

  self.a.var_1A4E = 0;
}

func_93E2() {
  if(self.a.var_1A4E < self.a.var_1A4F) {
    self.a.var_1A4E++;
    var_00 = 1 * self.a.var_1A4E / self.a.var_1A4F;
    self.a.var_1A4B = self.a.var_1A4D * 1 - var_00 + self.a.var_1A4C * var_00;
  }
}

func_1A3A() {
  if(!isDefined(self.var_1198.shootparams.pos) && !isDefined(self.var_1198.shootparams.ent)) {
    return 1;
  }

  var_00 = self _meth_8164();
  if(isDefined(self.var_1198.shootparams.var_29AF)) {
    if(!isDefined(self.var_45E2)) {
      return 0;
    }

    if(isDefined(self.var_45E2.var_45DA)) {
      var_01 = gettime() - self.var_45E2.var_45DA;
      if(var_01 >= self.var_45E2.var_AED8) {
        return 1;
      }
    } else if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E0) {
      return 1;
    }

    return 0;
  }

  if(scripts\asm\asm_bb::func_293E()) {
    return 1;
  }

  var_02 = scripts\anim\shared::_meth_811C();
  var_03 = _meth_811E(var_02);
  if(!isDefined(var_03)) {
    return 0;
  }

  var_04 = var_03.var_FECF;
  if(scripts\engine\utility::actor_is3d()) {
    var_05 = self _meth_853C();
    var_06 = rotatevectorinverted(var_05, self.angles);
    var_07 = vectortoangles(var_06);
    var_08 = var_04 - var_02;
    var_09 = rotatevectorinverted(var_08, self.angles);
    var_0A = vectortoangles(var_09);
  } else if(isDefined(var_03)) {
    var_0B = var_03 getturrettarget(1);
    return isDefined(var_0B);
  } else {
    var_07 = self getspawnpointdist();
    var_0A = vectortoangles(var_0A - var_04);
  }

  var_0C = level.var_1A52;
  var_0D = level.var_1A51;
  var_0E = level.var_1A44;
  var_0F = scripts\engine\utility::absangleclamp180(var_0A[1] - var_0B[1]);
  if(var_0F > var_0C) {
    if(var_0F > var_0D || distancesquared(self getEye(), var_07) > level.var_1A50) {
      return 0;
    }
  }

  var_10 = scripts\engine\utility::absangleclamp180(var_0A[0] - var_0B[0]);
  if(var_10 > var_0E) {
    return 0;
  }

  return 1;
}

func_F724() {
  anim.covercrouchleanpitch = 55;
  anim.var_1A52 = 10;
  anim.var_1A50 = 4096;
  anim.var_1A51 = 45;
  anim.var_1A44 = 20;
  anim.var_C88B = 25;
  anim.var_C889 = level.var_1A50;
  anim.var_C88A = level.var_1A51;
  anim.var_C87D = 30;
  anim.var_B480 = 65;
  anim.var_B47F = 65;
}