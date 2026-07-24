/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2603.gsc
**************************************/

_id_11A90(var_0) {
  _id_F724();
  self.asm._id_11AC7 = var_0;
  var_1 = _id_0A1E::_id_2356("Knobs", "aim_2");
  var_2 = _id_0A1E::_id_2356("Knobs", "aim_4");
  var_3 = _id_0A1E::_id_2356("Knobs", "aim_6");
  var_4 = _id_0A1E::_id_2356("Knobs", "aim_8");
  _id_11AF2(var_1, var_2, var_3, var_4);
  _id_11AF8(var_0);
}

_id_11AF2(var_0, var_1, var_2, var_3) {
  self.a._id_1A4B = 1.0;
  self.a._id_1A4D = 1.0;
  self.a._id_1A4C = 1.0;
  self.a._id_1A4F = 0;
  self.a._id_1A4E = 0;
  var_4 = spawnStruct();
  var_4._id_1A1E = var_0;
  var_4._id_1A20 = var_1;
  var_4._id_1A23 = var_2;
  var_4._id_1A25 = var_3;
  self.asm._id_11A90 = var_4;
}

_id_103B3() {
  self endon("stop_sniper");
  self waittill("death");

  if(isDefined(self._id_103A9)) {
    self._id_103A9 delete();
    self._id_103A9 = undefined;
  }
}

_id_103BC() {
  if(isDefined(self._id_103A9)) {
    self notify("stop_sniper");
    self._id_103A9[[self._id_71BC]]();
    self._id_103A9 delete();
    self._id_103A9 = undefined;
    self.bhaslasertag = undefined;
    self _meth_857A("none");
  }
}

shoulduselasertag() {
  var_0 = getweaponbasename(self.weapon);

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
  } else if(scripts\engine\utility::is_true(self.bhaslasertag)) {
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
  return self getmuzzleangle();
}

_id_103BB() {
  if(isDefined(self._id_103A9)) {
    return;
  }
  thread _id_103B3();
  var_0 = getlaserstartpoint();
  self._id_103A9 = spawn("script_model", var_0);
  self._id_103A9 setModel("tag_laser");
  self._id_103A9 _meth_8575(self.weapon);
  self._id_103A9 setotherent(self);
  self._id_103A9.origin = var_0;
  self _meth_857A("interpolate");
  self._id_103A9[[self._id_71BD]]();

  while(isalive(self) && isDefined(self._id_103A9)) {
    if(isDefined(self._id_45E2._id_1A2B)) {
      var_0 = getlaserstartpoint();
      self._id_103A9.origin = var_0;
      var_1 = self._id_45E2._id_1A2B;
      var_2 = vectorNormalize(var_1 - var_0);
      var_3 = getlaserdirection();
      var_2 = vectorNormalize((var_2[0], var_2[1], 0));
      var_3 = vectorNormalize((var_3[0], var_3[1], 0));
      var_4 = vectordot(var_2, var_3);

      if(var_4 < 0.996) {
        self._id_103A9.angles = getlaserangles();
      } else {
        self._id_103A9.angles = vectortoangles(self._id_45E2._id_1A2B - self._id_103A9.origin);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_11B0B() {
  _id_103BC();
}

_id_11B0C() {
  if(!isDefined(self._id_103A9)) {
    thread _id_103BB();
  }
}

_id_41A1() {
  self._id_45E2 = undefined;
}

_id_E24D(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_45E2)) {
    self._id_45E2 = spawnStruct();
  }

  self._id_45E2._id_103A6 = undefined;
  self._id_45E2.target = var_0.target;
  self._id_45E2._id_45DC = 96;

  if(var_1) {
    self._id_45E2._id_45E1 = 1500;
  } else if(scripts\engine\utility::is_true(var_3)) {
    self._id_45E2._id_45E1 = 1500;
  } else {
    self._id_45E2._id_45E1 = 2000;
  }

  self _meth_857A("interpolate");
  var_4 = scripts\sp\gameskill::_id_7C6D(level._id_7683);
  var_5 = level._id_54D0["sniper_converge_scale"][var_4];

  if(isDefined(var_5)) {
    self._id_45E2._id_45E1 = self._id_45E2._id_45E1 * var_5;
  }

  if(isDefined(level._id_103A4)) {
    self._id_45E2._id_45E1 = self._id_45E2._id_45E1 * level._id_103A4;
  }

  self._id_45E2._id_45DB = 12;
  self._id_45E2._id_AED8 = 750;
  self._id_45E2._id_45DA = undefined;

  if(!isDefined(self._id_103A9)) {
    self._id_45E2._id_45D8 = -1500;
  } else {
    self._id_45E2._id_45D8 = 0;
  }

  self._id_45E2._id_45E0 = self._id_45E2._id_45E1 + 1000;
  self._id_45E2._id_45D9 = self._id_45E2._id_45E0 + 500;

  if(isDefined(var_0.pos)) {
    var_6 = undefined;
    var_7 = undefined;

    if(isDefined(var_2)) {
      var_6 = var_2;
    } else {
      if(isDefined(var_0.target)) {
        var_8 = var_0.target.origin;

        if(isPlayer(var_0.target)) {
          var_7 = var_0.target getvelocity();

          if(var_7 == (0, 0, 0)) {
            var_7 = undefined;
          }
        }
      } else
        var_8 = var_0.pos - (0, 0, 70);

      var_9 = var_8 - self.origin;
      var_9 = (var_9[0], var_9[1], 0);
      var_10 = vectorNormalize(var_9);

      if(scripts\engine\utility::is_true(var_3)) {
        var_6 = var_8;
        var_6 = var_6 + (0, 0, randomfloatrange(12, 36));
      } else
        var_6 = var_8 - var_10 * randomfloatrange(120, 180);

      var_11 = vectorcross(var_10, (0, 0, 1));
      var_12 = randomfloatrange(6, 36);

      if(scripts\engine\utility::is_true(var_3)) {
        var_12 = randomfloatrange(12, 24);
      }

      if(isDefined(var_7)) {
        var_13 = vectordot(var_7, var_11);

        if(var_13 < 0) {
          var_6 = var_6 + var_11 * var_12;
        } else {
          var_6 = var_6 - var_11 * var_12;
        }
      } else if(randomintrange(0, 2))
        var_6 = var_6 + var_11 * var_12;
      else {
        var_6 = var_6 - var_11 * var_12;
      }
    }

    self._id_45E2._id_45DE = vectorNormalize(var_6 - var_0.pos);
    self._id_45E2._id_45DC = distance(var_6, var_0.pos);
  }
}

_id_36DA(var_0) {
  if(isDefined(self._id_45E2._id_45DA) && gettime() - self._id_45E2._id_45DA >= 100) {
    var_1 = gettime() - self._id_45E2._id_45DA;

    if(isDefined(var_0.target) && isPlayer(var_0.target)) {
      self _meth_857A("lock");
    } else {
      self _meth_857A("interpolate");
    }

    return var_0.pos - (0, 0, 1.3);
  }

  var_2 = vectorNormalize(var_0.pos - self.origin);
  var_3 = vectortoangles(var_2);

  if(self._id_45E2._id_45D8 < 0) {
    self _meth_857A("interpolate");
    var_4 = var_0.pos + self._id_45E2._id_45DE * self._id_45E2._id_45DC;
    return var_4;
  }

  var_5 = (self._id_45E2._id_45E1 - self._id_45E2._id_45D8) / self._id_45E2._id_45E1;

  if(self._id_45E2._id_45D8 >= self._id_45E2._id_45E1) {
    var_5 = 0.0;
  }

  var_6 = var_5 * (self._id_45E2._id_45DC - self._id_45E2._id_45DB) + self._id_45E2._id_45DB;
  var_4 = var_0.pos + self._id_45E2._id_45DE * var_6;

  if(isDefined(var_0.target) && isPlayer(var_0.target)) {
    self _meth_857A("interpolate");
  }

  return var_4;
}

_id_C59A() {
  if(isDefined(self._id_45E2) && isDefined(self._id_103A9)) {
    self._id_45E2._id_103A6 = 1;
  }
}

_id_C599() {
  if(isDefined(self._id_103A9)) {
    self._id_103A9[[self._id_71BC]]();
    thread _id_129A4(0.5);
  }
}

_id_129A4(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self._id_103A9)) {
    self._id_103A9[[self._id_71BD]]();
  }
}

_id_45E5(var_0) {
  var_1 = 1;
  var_2 = 0;

  if(isDefined(var_0.target)) {
    var_1 = self cansee(var_0.target);

    if(isDefined(self._id_45E2) && isDefined(self._id_45E2.target) && self._id_45E2.target != var_0.target) {
      var_2 = 1;
    }

    if(var_1) {
      var_0.pos = var_0.target getshootatpos();
    }
  }

  if(!isDefined(self._id_45E2) || var_2) {
    _id_E24D(var_0, var_2);
  } else if(var_1 && !scripts\engine\utility::is_true(self._id_45E2._id_2AB7)) {
    if(isDefined(self._id_45E2._id_1A2B) && distancesquared(self._id_45E2._id_1A2B, var_0.pos) < 3600) {
      _id_E24D(var_0, var_2, undefined, 1);
    } else {
      _id_E24D(var_0, var_2);
    }
  } else if(scripts\engine\utility::is_true(self._id_45E2._id_103A6)) {
    self _meth_857A("interpolate");
    self._id_45E2._id_103A6 = undefined;

    if(isDefined(var_0.target) && isPlayer(var_0.target) && self cansee(var_0.target)) {
      _id_E24D(var_0, var_2, undefined, 1);
    }
  }

  self._id_45E2._id_2AB7 = var_1;
  var_3 = 1;
  var_4 = getlaserstartpoint();
  var_5 = _id_36DA(var_0);
  var_6 = vectorNormalize(var_5 - var_4);
  var_7 = self _meth_853C();

  if(self._id_45E2._id_45D8 < 0) {
    if(!_id_9D30()) {
      return 0;
    }

    self._id_45E2._id_45D8 = self._id_45E2._id_45D8 + 50;
    var_8 = vectordot(var_6, var_7);

    if(var_8 < 0.984) {
      return 0;
    }

    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_7 = vectorNormalize((var_7[0], var_7[1], 0));
    var_9 = vectordot(var_6, var_7);

    if(var_9 < 0.996) {
      return 0;
    }

    self._id_45E2._id_45D8 = 0;
  } else {
    self._id_45E2._id_45D8 = self._id_45E2._id_45D8 + 50;
    var_8 = vectordot(var_6, var_7);

    if(var_8 < 0.984) {
      var_3 = 0;
    }

    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_7 = vectorNormalize((var_7[0], var_7[1], 0));
    var_9 = vectordot(var_6, var_7);

    if(var_9 < 0.996) {
      var_3 = 0;
    }
  }

  if(self._id_45E2._id_45D8 >= self._id_45E2._id_45E1) {
    if(isDefined(var_0.target)) {
      if(!isDefined(self._id_45E2._id_45DA)) {
        if(var_1) {
          self._id_45E2._id_45DA = gettime();
        }
      } else if(gettime() >= self._id_45E2._id_45DA + 200) {
        if(!var_1) {
          self._id_45E2._id_45DA = undefined;
        }
      }
    }
  }

  return var_3;
}

_id_811E(var_0) {
  var_1 = spawnStruct();

  if(scripts\anim\utility::_id_FFDB()) {
    var_2 = _id_11AFB(var_0);

    if(isDefined(var_2)) {
      var_1._id_FECF = var_2;
      var_1._id_2AA9 = 1;
      return var_1;
    }
  }

  var_3 = undefined;

  if(isDefined(self._blackboard.shootparams)) {
    var_3 = self._blackboard.shootparams;
  } else if(isDefined(self.asm.shootparams)) {
    var_3 = self.asm.shootparams;
  }

  if(!scripts\asm\asm_bb::_id_2985()) {
    return undefined;
  } else if(isDefined(var_3.ent)) {
    var_1._id_FECF = var_3.ent getshootatpos();
  } else if(isDefined(var_3.pos)) {
    var_1._id_FECF = var_3.pos;
  }

  if(isDefined(var_1._id_FECF)) {
    return var_1;
  }

  return undefined;
}

_id_9F60() {
  if(!isDefined(self._id_45E2)) {
    return 0;
  }

  return 1;
}

_id_9F61() {
  if(isDefined(self._id_103A9)) {
    return 1;
  }

  return 0;
}

_id_9D30() {
  if(!isDefined(self.asm._id_1A49)) {
    return 0;
  }

  var_0 = 100.0;
  var_0 = var_0 * 2;
  var_1 = gettime();

  if(self.asm._id_1A49 + var_0 < var_1) {
    return 1;
  }

  return 0;
}

_id_11AF8(var_0) {
  self endon("death");
  self.asm._id_D8C7 = 0;
  self.asm._id_D8BB = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;

  for(;;) {
    _id_93E2();
    var_6 = scripts\asm\asm::_id_231B(self.asm._id_11AC7, "aim");

    if(!var_6 && scripts\asm\asm::_id_231B(self.asm._id_11AC7, "notetrackAim")) {
      var_6 = scripts\asm\asm::_id_232B(scripts\asm\asm::asm_getcurrentstate(self.asm._id_11AC7), "start_aim");
    }

    if(!var_6 || !isDefined(self._blackboard.shootparams)) {
      if(!var_6 && isDefined(self._id_45E2)) {
        _id_41A1();
      }

      _id_11B0B();
      self.asm._id_1A49 = undefined;
    } else if(!isDefined(self.asm._id_1A49))
      self.asm._id_1A49 = gettime();

    var_1 = (0, 0, 0);

    if(var_6) {
      var_7 = scripts\anim\shared::_id_811C();
      var_8 = _id_811E(var_7);
      var_9 = undefined;

      if(isDefined(var_8)) {
        var_9 = var_8._id_FECF;
      }

      var_10 = self _meth_8164();
      var_11 = isDefined(var_10);

      if(var_11) {
        var_12 = var_10 _meth_851F();
        var_13 = anglesToForward(self.angles);
        var_14 = rotatevector(var_13, var_12);
        var_9 = var_7 + var_14 * 512.0;
      } else if(scripts\asm\asm_bb::_id_2985() && isDefined(self._blackboard.shootparams.pos)) {
        if(isDefined(self._blackboard.shootparams._id_29AF)) {
          var_15 = _id_45E5(self._blackboard.shootparams);
          var_9 = _id_36DA(self._blackboard.shootparams);
          self._id_45E2._id_1A2B = var_9;

          if(var_15) {
            _id_11B0C();
          } else {
            _id_11B0B();
          }
        } else
          _id_11B0B();
      } else
        _id_11B0B();

      var_16 = isDefined(var_9);
      var_17 = (0, 0, 0);

      if(var_16) {
        var_17 = var_9;
      }

      var_18 = 0;
      var_19 = isDefined(self._id_10F8C);

      if(var_19) {
        var_18 = self._id_10F8C;
      }

      var_20 = 0;
      var_21 = 0;
      var_22 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_22) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed") {
        var_23 = scripts\asm\asm_bb::_id_2929();

        if(isDefined(var_23)) {
          var_20 = scripts\asm\shared\utility::_id_7FF2(var_0, var_22, var_23);
          var_21 = scripts\asm\shared\utility::_id_7FF1(var_0, var_22, var_23);
        }
      }

      var_24 = (var_21, var_20, 0);

      if(scripts\engine\utility::_id_9DA3() || isDefined(var_8) && isDefined(var_8._id_2AA9) && var_8._id_2AA9) {
        var_1 = self _meth_80FA(var_7, var_17, var_16, var_24, var_18, var_19, 0);
      } else {
        var_1 = (0, 0, 0);
      }
    } else if(self.asm._id_D8C7 < 5 && self.asm._id_D8BB < 5) {
      wait 0.05;
      continue;
    }

    var_25 = var_1[0];
    var_26 = var_1[1];
    var_1 = undefined;

    if(var_4 > 0) {
      var_4 = var_4 - 1;
      var_5 = max(10, var_5 - 5);
    } else if(self.relativedir && self.relativedir != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else if(scripts\anim\utility_common::isasniper())
      var_5 = 2;
    else {
      var_5 = 10;
    }

    var_27 = 4;
    var_3 = self.relativedir;
    var_28 = self.movemode != "stop" || !var_2;

    if(var_28) {
      var_29 = var_26 - self.asm._id_D8C7;

      if(squared(var_29) > var_27) {
        var_30 = var_29 * 0.4;
        var_26 = self.asm._id_D8C7 + clamp(var_30, -1 * var_5, var_5);
        var_26 = clamp(var_26, self.rightaimlimit, self.leftaimlimit);
      }

      var_31 = var_25 - self.asm._id_D8BB;

      if(squared(var_31) > var_27) {
        var_32 = var_31 * 0.4;
        var_25 = self.asm._id_D8BB + clamp(var_32, -1 * var_5, var_5);
        var_25 = clamp(var_25, self.upaimlimit, self.downaimlimit);
      }
    }

    var_2 = 0;
    self.asm._id_D8C7 = var_26;
    self.asm._id_D8BB = var_25;

    if(isDefined(self.asm._id_58EC) && self.asm._id_58EC) {
      _id_11AFF(var_25, var_26);
    } else {
      _id_11AFE(var_25, var_26);
    }

    wait 0.05;
  }
}

_id_11AFD() {
  if(!isDefined(self.asm._id_D8C7)) {
    return;
  }
  var_0 = clamp(self.asm._id_D8C7, self.rightaimlimit, self.leftaimlimit);
  var_1 = clamp(self.asm._id_D8BB, self.upaimlimit, self.downaimlimit);

  if(isDefined(self.asm._id_58EC) && self.asm._id_58EC) {
    _id_11AFF(var_1, var_0);
  } else {
    _id_11AFE(var_1, var_0);
  }
}

_id_11AFB(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(self.angles);

  if(isDefined(self._id_4792)) {
    var_1 = self._id_4792 getshootatpos();

    if(isDefined(self._id_4796)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  if(!isDefined(var_1) && isDefined(self._id_478F)) {
    var_1 = self._id_478F;

    if(isDefined(self._id_4795)) {
      if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.177) {
        var_1 = undefined;
      }
    } else if(vectordot(vectorNormalize(var_1 - var_0), var_2) < 0.643)
      var_1 = undefined;
  }

  return var_1;
}

_id_11AFE(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.asm._id_11A90._id_1A1D)) {
    var_3 = self.asm._id_11A90._id_1A1D;
    var_4 = self.asm._id_11A90._id_1A1F;
    var_5 = self.asm._id_11A90._id_1A22;
    var_6 = self.asm._id_11A90._id_1A24;
  } else {
    var_3 = self.asm._id_11A90._id_1A1E;
    var_4 = self.asm._id_11A90._id_1A20;
    var_5 = self.asm._id_11A90._id_1A23;
    var_6 = self.asm._id_11A90._id_1A25;
  }

  if(isDefined(self.asm._id_11A90._id_1A21)) {
    var_2 = self.asm._id_11A90._id_1A21;
  }

  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_1 < 0) {
    var_10 = var_1 / self.rightaimlimit * self.a._id_1A4B;
    var_9 = 1;
  } else if(var_1 > 0) {
    var_8 = var_1 / self.leftaimlimit * self.a._id_1A4B;
    var_9 = 1;
  }

  if(var_0 < 0) {
    var_11 = var_0 / self.upaimlimit * self.a._id_1A4B;
    var_9 = 1;
  } else if(var_0 > 0) {
    var_7 = var_0 / self.downaimlimit * self.a._id_1A4B;
    var_9 = 1;
  }

  self _meth_82AC(var_3, var_7, 0.1, 1, 1);
  self _meth_82AC(var_4, var_8, 0.1, 1, 1);
  self _meth_82AC(var_5, var_10, 0.1, 1, 1);
  self _meth_82AC(var_6, var_11, 0.1, 1, 1);

  if(isDefined(var_2)) {
    self _meth_82AC(var_2, var_9, 0.1, 1, 1);
  }
}

_id_11AFF(var_0, var_1) {
  var_2 = self.asm._id_11A90._id_AD94;
  var_3 = self.asm._id_11A90._id_AD95;
  var_4 = self.asm._id_11A90._id_AD96;
  var_5 = self.asm._id_11A90._id_AD97;
  var_6 = self.asm._id_11A90._id_AD98;
  var_7 = self.asm._id_11A90._id_AD99;
  var_8 = self.asm._id_11A90._id_AD9A;
  var_9 = self.asm._id_11A90._id_AD9B;
  var_10 = [var_6, var_9, var_8, var_7, var_5, var_2, var_3, var_4, var_6];
  var_11 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_12 = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var_13 = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var_14 = (var_1, var_0, 0);
  var_15 = length2d(var_14);
  var_16 = vectorNormalize(var_14);
  var_17 = vectortoyaw(var_16);
  var_17 = angleclamp180(var_17);

  for(var_18 = 0; var_17 > var_11[var_18]; var_18++) {}

  if(var_18 == 0) {
    var_18 = 1;
  }

  for(var_19 = 0; var_19 < var_10.size; var_19++) {
    if(var_19 == var_18 || var_19 == var_18 - 1) {
      var_20 = clamp(var_15 / var_13[var_19], 0.0, 1.0);
      var_21 = acos(vectordot(var_12[var_19], var_16));
      var_22 = clamp(1 - var_21 / var_13[var_19], 0.0, 1.0);
      var_23 = self islegacyagent(var_10[var_19]);

      if(var_23 > 0) {
        var_24 = getanimlength(var_10[var_19]);
        var_25 = (var_20 - var_23) * var_24 / 0.05;
        self _meth_82AC(var_10[var_19], var_22, 0.05, var_25);
      } else {
        self _meth_82AC(var_10[var_19], var_22, 0.05, 0.0);
        self _meth_82B0(var_10[var_19], var_20);
      }

      continue;
    }

    if(var_10[var_19] != var_10[var_18] && var_10[var_19] != var_10[var_18 - 1]) {
      self clearanim(var_10[var_19], 0.05);
    }
  }
}

_id_F641(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self.a._id_1A4B = var_0;
    self.a._id_1A4D = var_0;
    self.a._id_1A4C = var_0;
    self.a._id_1A4F = 0;
  } else {
    if(!isDefined(self.a._id_1A4B)) {
      self.a._id_1A4B = 0;
    }

    self.a._id_1A4D = self.a._id_1A4B;
    self.a._id_1A4C = var_0;
    self.a._id_1A4F = int(var_1 * 20);
  }

  self.a._id_1A4E = 0;
}

_id_93E2() {
  if(self.a._id_1A4E < self.a._id_1A4F) {
    self.a._id_1A4E++;
    var_0 = 1.0 * self.a._id_1A4E / self.a._id_1A4F;
    self.a._id_1A4B = self.a._id_1A4D * (1 - var_0) + self.a._id_1A4C * var_0;
  }
}

_id_1A3A() {
  if(!isDefined(self._blackboard.shootparams.pos) && !isDefined(self._blackboard.shootparams.ent)) {
    return 1;
  }

  var_0 = self _meth_8164();

  if(isDefined(self._blackboard.shootparams._id_29AF)) {
    if(!isDefined(self._id_45E2)) {
      return 0;
    }

    if(isDefined(self._id_45E2._id_45DA)) {
      var_1 = gettime() - self._id_45E2._id_45DA;

      if(var_1 >= self._id_45E2._id_AED8) {
        return 1;
      }
    } else if(self._id_45E2._id_45D8 >= self._id_45E2._id_45E0)
      return 1;

    return 0;
  }

  if(scripts\asm\asm_bb::_id_293E()) {
    return 1;
  }

  var_2 = scripts\anim\shared::_id_811C();
  var_3 = _id_811E(var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = var_3._id_FECF;

  if(scripts\engine\utility::actor_is3d()) {
    var_5 = self _meth_853C();
    var_6 = rotatevectorinverted(var_5, self.angles);
    var_7 = vectortoangles(var_6);
    var_8 = var_4 - var_2;
    var_9 = rotatevectorinverted(var_8, self.angles);
    var_10 = vectortoangles(var_9);
  } else if(isDefined(var_0)) {
    var_11 = var_0 getturrettarget(1);
    return isDefined(var_11);
  } else {
    var_7 = self getmuzzleangle();
    var_10 = vectortoangles(var_4 - var_2);
  }

  var_12 = anim._id_1A52;
  var_13 = anim._id_1A51;
  var_14 = anim._id_1A44;
  var_15 = scripts\engine\utility::absangleclamp180(var_7[1] - var_10[1]);

  if(var_15 > var_12) {
    if(var_15 > var_13 || distancesquared(self getEye(), var_4) > anim._id_1A50) {
      return 0;
    }
  }

  var_16 = scripts\engine\utility::absangleclamp180(var_7[0] - var_10[0]);

  if(var_16 > var_14) {
    return 0;
  }

  return 1;
}

_id_F724() {
  anim.covercrouchleanpitch = 55;
  anim._id_1A52 = 10;
  anim._id_1A50 = 4096;
  anim._id_1A51 = 45;
  anim._id_1A44 = 20;
  anim._id_C88B = 25;
  anim._id_C889 = anim._id_1A50;
  anim._id_C88A = anim._id_1A51;
  anim._id_C87D = 30;
  anim._id_B480 = 65;
  anim._id_B47F = 65;
}