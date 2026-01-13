/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2603.gsc
************************/

func_11A90(var_0) {
  func_F724();
  self.asm.var_11AC7 = var_0;
  var_1 = lib_0A1E::func_2356("Knobs", "aim_2");
  var_2 = lib_0A1E::func_2356("Knobs", "aim_4");
  var_3 = lib_0A1E::func_2356("Knobs", "aim_6");
  var_4 = lib_0A1E::func_2356("Knobs", "aim_8");
  func_11AF2(var_1, var_2, var_3, var_4);
  func_11AF8(var_0);
}

func_11AF2(var_0, var_1, var_2, var_3) {
  self.a.var_1A4B = 1;
  self.a.var_1A4D = 1;
  self.a.var_1A4C = 1;
  self.a.var_1A4F = 0;
  self.a.var_1A4E = 0;
  var_4 = spawnStruct();
  var_4.var_1A1E = var_0;
  var_4.var_1A20 = var_1;
  var_4.var_1A23 = var_2;
  var_4.var_1A25 = var_3;
  self.asm.var_11A90 = var_4;
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
  var_0 = getweaponbasename(self.var_394);
  switch (var_0) {
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
      var_0 = self gettagorigin("tag_laser", 1);
      if(isDefined(var_0)) {
        self.bhaslasertag = 1;
        return var_0;
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
  var_0 = getlaserstartpoint();
  self.var_103A9 = spawn("script_model", var_0);
  self.var_103A9 setModel("tag_laser");
  self.var_103A9 _meth_8575(self.var_394);
  self.var_103A9 setotherent(self);
  self.var_103A9.origin = var_0;
  self _meth_857A("interpolate");
  self.var_103A9[[self.var_71BD]]();
  while(isalive(self) && isDefined(self.var_103A9)) {
    if(isDefined(self.var_45E2.var_1A2B)) {
      var_0 = getlaserstartpoint();
      self.var_103A9.origin = var_0;
      var_1 = self.var_45E2.var_1A2B;
      var_2 = vectornormalize(var_1 - var_0);
      var_3 = getlaserdirection();
      var_2 = vectornormalize((var_2[0], var_2[1], 0));
      var_3 = vectornormalize((var_3[0], var_3[1], 0));
      var_4 = vectordot(var_2, var_3);
      if(var_4 < 0.996) {
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

func_E24D(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_45E2)) {
    self.var_45E2 = spawnStruct();
  }

  self.var_45E2.var_103A6 = undefined;
  self.var_45E2.target = var_0.target;
  self.var_45E2.var_45DC = 96;
  if(var_1) {
    self.var_45E2.var_45E1 = 1500;
  } else if(scripts\engine\utility::istrue(var_3)) {
    self.var_45E2.var_45E1 = 1500;
  } else {
    self.var_45E2.var_45E1 = 2000;
  }

  self _meth_857A("interpolate");
  var_4 = scripts\sp\gameskill::func_7C6D(level.var_7683);
  var_5 = level.var_54D0["sniper_converge_scale"][var_4];
  if(isDefined(var_5)) {
    self.var_45E2.var_45E1 = self.var_45E2.var_45E1 * var_5;
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
  if(isDefined(var_0.pos)) {
    var_6 = undefined;
    var_7 = undefined;
    if(isDefined(var_2)) {
      var_6 = var_2;
    } else {
      if(isDefined(var_0.target)) {
        var_8 = var_0.target.origin;
        if(isplayer(var_0.target)) {
          var_7 = var_0.target getvelocity();
          if(var_7 == (0, 0, 0)) {
            var_7 = undefined;
          }
        }
      } else {
        var_8 = var_1.pos - (0, 0, 70);
      }

      var_9 = var_8 - self.origin;
      var_9 = (var_9[0], var_9[1], 0);
      var_0A = vectornormalize(var_9);
      if(scripts\engine\utility::istrue(var_3)) {
        var_6 = var_8;
        var_6 = var_6 + (0, 0, randomfloatrange(12, 36));
      } else {
        var_6 = var_8 - var_0A * randomfloatrange(120, 180);
      }

      var_0B = vectorcross(var_0A, (0, 0, 1));
      var_0C = randomfloatrange(6, 36);
      if(scripts\engine\utility::istrue(var_3)) {
        var_0C = randomfloatrange(12, 24);
      }

      if(isDefined(var_7)) {
        var_0D = vectordot(var_7, var_0B);
        if(var_0D < 0) {
          var_6 = var_6 + var_0B * var_0C;
        } else {
          var_6 = var_6 - var_0B * var_0C;
        }
      } else if(randomintrange(0, 2)) {
        var_6 = var_6 + var_0B * var_0C;
      } else {
        var_6 = var_6 - var_0B * var_0C;
      }
    }

    self.var_45E2.var_45DE = vectornormalize(var_6 - var_0.pos);
    self.var_45E2.var_45DC = distance(var_6, var_0.pos);
  }
}

func_36DA(var_0) {
  if(isDefined(self.var_45E2.var_45DA) && gettime() - self.var_45E2.var_45DA >= 100) {
    var_1 = gettime() - self.var_45E2.var_45DA;
    if(isDefined(var_0.target) && isplayer(var_0.target)) {
      self _meth_857A("lock");
    } else {
      self _meth_857A("interpolate");
    }

    return var_0.pos - (0, 0, 1.3);
  }

  var_2 = vectornormalize(var_1.pos - self.origin);
  var_3 = vectortoangles(var_2);
  if(self.var_45E2.var_45D8 < 0) {
    self _meth_857A("interpolate");
    var_4 = var_1.pos + self.var_45E2.var_45DE * self.var_45E2.var_45DC;
    return var_4;
  }

  var_5 = self.var_45E2.var_45E1 - self.var_45E2.var_45D8 / self.var_45E2.var_45E1;
  if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1) {
    var_5 = 0;
  }

  var_6 = var_5 * self.var_45E2.var_45DC - self.var_45E2.var_45DB + self.var_45E2.var_45DB;
  var_4 = var_2.pos + self.var_45E2.var_45DE * var_6;
  if(isDefined(var_1.target) && isplayer(var_1.target)) {
    self _meth_857A("interpolate");
  }

  return var_6;
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

func_129A4(var_0) {
  self endon("death");
  wait(var_0);
  if(isDefined(self.var_103A9)) {
    self.var_103A9[[self.var_71BD]]();
  }
}

func_45E5(var_0) {
  var_1 = 1;
  var_2 = 0;
  if(isDefined(var_0.target)) {
    var_1 = self getpersstat(var_0.target);
    if(isDefined(self.var_45E2) && isDefined(self.var_45E2.target) && self.var_45E2.target != var_0.target) {
      var_2 = 1;
    }

    if(var_1) {
      var_0.pos = var_0.target getshootatpos();
    }
  }

  if(!isDefined(self.var_45E2) || var_2) {
    func_E24D(var_0, var_2);
  } else if(var_1 && !scripts\engine\utility::istrue(self.var_45E2.var_2AB7)) {
    if(isDefined(self.var_45E2.var_1A2B) && distancesquared(self.var_45E2.var_1A2B, var_0.pos) < 3600) {
      func_E24D(var_0, var_2, undefined, 1);
    } else {
      func_E24D(var_0, var_2);
    }
  } else if(scripts\engine\utility::istrue(self.var_45E2.var_103A6)) {
    self _meth_857A("interpolate");
    self.var_45E2.var_103A6 = undefined;
    if(isDefined(var_0.target) && isplayer(var_0.target) && self getpersstat(var_0.target)) {
      func_E24D(var_0, var_2, undefined, 1);
    }
  }

  self.var_45E2.var_2AB7 = var_1;
  var_3 = 1;
  var_4 = getlaserstartpoint();
  var_5 = func_36DA(var_0);
  var_6 = vectornormalize(var_5 - var_4);
  var_7 = self _meth_853C();
  if(self.var_45E2.var_45D8 < 0) {
    if(!func_9D30()) {
      return 0;
    }

    self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
    var_8 = vectordot(var_6, var_7);
    if(var_8 < 0.984) {
      return 0;
    }

    var_6 = vectornormalize((var_6[0], var_6[1], 0));
    var_7 = vectornormalize((var_7[0], var_7[1], 0));
    var_9 = vectordot(var_6, var_7);
    if(var_9 < 0.996) {
      return 0;
    }

    self.var_45E2.var_45D8 = 0;
  } else {
    self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
    var_8 = vectordot(var_8, var_9);
    if(var_9 < 0.984) {
      var_4 = 0;
    }

    var_7 = vectornormalize((var_7[0], var_7[1], 0));
    var_8 = vectornormalize((var_8[0], var_8[1], 0));
    var_9 = vectordot(var_7, var_8);
    if(var_9 < 0.996) {
      var_3 = 0;
    }
  }

  if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1) {
    if(isDefined(var_0.target)) {
      if(!isDefined(self.var_45E2.var_45DA)) {
        if(var_1) {
          self.var_45E2.var_45DA = gettime();
        }
      } else if(gettime() >= self.var_45E2.var_45DA + 200) {
        if(!var_1) {
          self.var_45E2.var_45DA = undefined;
        }
      }
    }
  }

  return var_3;
}

_meth_811E(var_0) {
  var_1 = spawnStruct();
  if(scripts\anim\utility::func_FFDB()) {
    var_2 = func_11AFB(var_0);
    if(isDefined(var_2)) {
      var_1.var_FECF = var_2;
      var_1.var_2AA9 = 1;
      return var_1;
    }
  }

  var_3 = undefined;
  if(isDefined(self._blackboard.shootparams)) {
    var_3 = self._blackboard.shootparams;
  } else if(isDefined(self.asm.shootparams)) {
    var_3 = self.asm.shootparams;
  }

  if(!scripts\asm\asm_bb::func_2985()) {
    return undefined;
  } else if(isDefined(var_3.ent)) {
    var_1.var_FECF = var_3.ent getshootatpos();
  } else if(isDefined(var_3.pos)) {
    var_1.var_FECF = var_3.pos;
  }

  if(isDefined(var_1.var_FECF)) {
    return var_1;
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

  var_0 = 100;
  var_0 = var_0 * 2;
  var_1 = gettime();
  if(self.asm.var_1A49 + var_0 < var_1) {
    return 1;
  }

  return 0;
}

func_11AF8(var_0) {
  self endon("death");
  self.asm.var_D8C7 = 0;
  self.asm.var_D8BB = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;
  for(;;) {
    func_93E2();
    var_6 = scripts\asm\asm::func_231B(self.asm.var_11AC7, "aim");
    if(!var_6 && scripts\asm\asm::func_231B(self.asm.var_11AC7, "notetrackAim")) {
      var_6 = scripts\asm\asm::func_232B(scripts\asm\asm::asm_getcurrentstate(self.asm.var_11AC7), "start_aim");
    }

    if(!var_6 || !isDefined(self._blackboard.shootparams)) {
      if(!var_6 && isDefined(self.var_45E2)) {
        func_41A1();
      }

      func_11B0B();
      self.asm.var_1A49 = undefined;
    } else if(!isDefined(self.asm.var_1A49)) {
      self.asm.var_1A49 = gettime();
    }

    var_1 = (0, 0, 0);
    if(var_6) {
      var_7 = scripts\anim\shared::_meth_811C();
      var_8 = _meth_811E(var_7);
      var_9 = undefined;
      if(isDefined(var_8)) {
        var_9 = var_8.var_FECF;
      }

      var_0A = self _meth_8164();
      var_0B = isDefined(var_0A);
      if(var_0B) {
        var_0C = var_0A _meth_851F();
        var_0D = anglesToForward(self.angles);
        var_0E = rotatevector(var_0D, var_0C);
        var_9 = var_7 + var_0E * 512;
      } else if(scripts\asm\asm_bb::func_2985() && isDefined(self._blackboard.shootparams.pos)) {
        if(isDefined(self._blackboard.shootparams.var_29AF)) {
          var_0F = func_45E5(self._blackboard.shootparams);
          var_9 = func_36DA(self._blackboard.shootparams);
          self.var_45E2.var_1A2B = var_9;
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

      var_10 = isDefined(var_9);
      var_11 = (0, 0, 0);
      if(var_10) {
        var_11 = var_9;
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
          var_14 = scripts\asm\shared_utility::func_7FF2(var_0, var_16, var_17);
          var_15 = scripts\asm\shared_utility::func_7FF1(var_0, var_16, var_17);
        }
      }

      var_18 = (var_15, var_14, 0);
      if(scripts\engine\utility::func_9DA3() || isDefined(var_8) && isDefined(var_8.var_2AA9) && var_8.var_2AA9) {
        var_1 = self getrunningforwarddeathanim(var_7, var_11, var_10, var_18, var_12, var_13, 0);
      } else {
        var_1 = (0, 0, 0);
      }
    } else if(self.asm.var_D8C7 < 5 && self.asm.var_D8BB < 5) {
      wait(0.05);
      continue;
    }

    var_19 = var_1[0];
    var_1A = var_1[1];
    var_1 = undefined;
    if(var_4 > 0) {
      var_4 = var_4 - 1;
      var_5 = max(10, var_5 - 5);
    } else if(self.line && self.line != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else if(scripts\anim\utility_common::isasniper()) {
      var_5 = 2;
    } else {
      var_5 = 10;
    }

    var_1B = 4;
    var_3 = self.line;
    var_1C = self.synctransients != "stop" || !var_2;
    if(var_1C) {
      var_1D = var_1A - self.asm.var_D8C7;
      if(squared(var_1D) > var_1B) {
        var_1E = var_1D * 0.4;
        var_1A = self.asm.var_D8C7 + clamp(var_1E, -1 * var_5, var_5);
        var_1A = clamp(var_1A, self.setdevdvar, self.setmatchdatadef);
      }

      var_1F = var_19 - self.asm.var_D8BB;
      if(squared(var_1F) > var_1B) {
        var_20 = var_1F * 0.4;
        var_19 = self.asm.var_D8BB + clamp(var_20, -1 * var_5, var_5);
        var_19 = clamp(var_19, self.var_368, self.isbot);
      }
    }

    var_2 = 0;
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

  var_0 = clamp(self.asm.var_D8C7, self.setdevdvar, self.setmatchdatadef);
  var_1 = clamp(self.asm.var_D8BB, self.var_368, self.isbot);
  if(isDefined(self.asm.var_58EC) && self.asm.var_58EC) {
    func_11AFF(var_1, var_0);
    return;
  }

  func_11AFE(var_1, var_0);
}

func_11AFB(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);
  if(isDefined(self.var_4792)) {
    var_1 = self.var_4792 getshootatpos();
    if(isDefined(self.var_4796)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_1) && isDefined(self.var_478F)) {
    var_1 = self.var_478F;
    if(isDefined(self.var_4795)) {
      if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectornormalize(var_1 - var_0), var_2) < 0.643) {
      var_1 = undefined;
    }
  }

  return var_1;
}

func_11AFE(var_0, var_1) {
  var_2 = undefined;
  if(isDefined(self.asm.var_11A90.var_1A1D)) {
    var_3 = self.asm.var_11A90.var_1A1D;
    var_4 = self.asm.var_11A90.var_1A1F;
    var_5 = self.asm.var_11A90.var_1A22;
    var_6 = self.asm.var_11A90.var_1A24;
  } else {
    var_3 = self.asm.var_11A90.var_1A1E;
    var_4 = self.asm.var_11A90.var_1A20;
    var_5 = self.asm.var_11A90.var_1A23;
    var_6 = self.asm.var_11A90.var_1A25;
  }

  if(isDefined(self.asm.var_11A90.var_1A21)) {
    var_2 = self.asm.var_11A90.var_1A21;
  }

  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_0A = 0;
  var_0B = 0;
  if(var_1 < 0) {
    var_0A = var_1 / self.setdevdvar * self.a.var_1A4B;
    var_9 = 1;
  } else if(var_1 > 0) {
    var_8 = var_1 / self.setmatchdatadef * self.a.var_1A4B;
    var_9 = 1;
  }

  if(var_0 < 0) {
    var_0B = var_0 / self.var_368 * self.a.var_1A4B;
    var_9 = 1;
  } else if(var_0 > 0) {
    var_7 = var_0 / self.isbot * self.a.var_1A4B;
    var_9 = 1;
  }

  self _meth_82AC(var_3, var_7, 0.1, 1, 1);
  self _meth_82AC(var_4, var_8, 0.1, 1, 1);
  self _meth_82AC(var_5, var_0A, 0.1, 1, 1);
  self _meth_82AC(var_6, var_0B, 0.1, 1, 1);
  if(isDefined(var_2)) {
    self _meth_82AC(var_2, var_9, 0.1, 1, 1);
  }
}

func_11AFF(var_0, var_1) {
  var_2 = self.asm.var_11A90.var_AD94;
  var_3 = self.asm.var_11A90.var_AD95;
  var_4 = self.asm.var_11A90.var_AD96;
  var_5 = self.asm.var_11A90.var_AD97;
  var_6 = self.asm.var_11A90.var_AD98;
  var_7 = self.asm.var_11A90.var_AD99;
  var_8 = self.asm.var_11A90.var_AD9A;
  var_9 = self.asm.var_11A90.var_AD9B;
  var_0A = [var_6, var_9, var_8, var_7, var_5, var_2, var_3, var_4, var_6];
  var_0B = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_0C = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var_0D = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var_0E = (var_1, var_0, 0);
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

func_F641(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a.var_1A4B = var_0;
    self.a.var_1A4D = var_0;
    self.a.var_1A4C = var_0;
    self.a.var_1A4F = 0;
  } else {
    if(!isDefined(self.a.var_1A4B)) {
      self.a.var_1A4B = 0;
    }

    self.a.var_1A4D = self.a.var_1A4B;
    self.a.var_1A4C = var_0;
    self.a.var_1A4F = int(var_1 * 20);
  }

  self.a.var_1A4E = 0;
}

func_93E2() {
  if(self.a.var_1A4E < self.a.var_1A4F) {
    self.a.var_1A4E++;
    var_0 = 1 * self.a.var_1A4E / self.a.var_1A4F;
    self.a.var_1A4B = self.a.var_1A4D * 1 - var_0 + self.a.var_1A4C * var_0;
  }
}

func_1A3A() {
  if(!isDefined(self._blackboard.shootparams.pos) && !isDefined(self._blackboard.shootparams.ent)) {
    return 1;
  }

  var_0 = self _meth_8164();
  if(isDefined(self._blackboard.shootparams.var_29AF)) {
    if(!isDefined(self.var_45E2)) {
      return 0;
    }

    if(isDefined(self.var_45E2.var_45DA)) {
      var_1 = gettime() - self.var_45E2.var_45DA;
      if(var_1 >= self.var_45E2.var_AED8) {
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

  var_2 = scripts\anim\shared::_meth_811C();
  var_3 = _meth_811E(var_2);
  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = var_3.var_FECF;
  if(scripts\engine\utility::actor_is3d()) {
    var_5 = self _meth_853C();
    var_6 = rotatevectorinverted(var_5, self.angles);
    var_7 = vectortoangles(var_6);
    var_8 = var_4 - var_2;
    var_9 = rotatevectorinverted(var_8, self.angles);
    var_0A = vectortoangles(var_9);
  } else if(isDefined(var_3)) {
    var_0B = var_3 getturrettarget(1);
    return isDefined(var_0B);
  } else {
    var_7 = self getspawnpointdist();
    var_0A = vectortoangles(var_0A - var_4);
  }

  var_0C = level.var_1A52;
  var_0D = level.var_1A51;
  var_0E = level.var_1A44;
  var_0F = scripts\engine\utility::absangleclamp180(var_0A[1] - var_0B[1]);
  if(var_0F > var_0C) {
    if(var_0F > var_0D || distancesquared(self getEye(), var_7) > level.var_1A50) {
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