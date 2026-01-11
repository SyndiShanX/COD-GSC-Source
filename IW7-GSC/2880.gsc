/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2880.gsc
***************************************/

func_DEB8(var_00, var_01) {
  level.func_1DBE[var_00] = var_01;
}

func_7A2D(var_00) {
  if(!isDefined(level.func_1DBE) || !isDefined(level.func_1DBE[var_00])) {
    return undefined;
  }

  return level.func_1DBE[var_00];
}

#using_animtree("generic_human");

func_CC7F(var_00, var_01) {
  self.func_DC6F = 0;

  if(isai(var_00) && !isDefined(var_0.func_9B89)) {
    var_00 animmode("noclip");
  }

  wait 0.1;
  var_00 clearanim( % root, 0.0);

  if(isDefined(var_0.func_9B89)) {
    if(isDefined(var_01) && var_01) {
      thread func_DC82(var_00);
      thread func_DC86(var_00);
    } else {
      thread func_DC81(var_00);
      thread func_DC86(var_00);
    }
  } else if(isDefined(var_01) && var_01) {
    thread func_DC82(var_00);
    thread func_DC85();
  } else {
    thread func_DC81(var_00);
    thread func_DC85();
  }

  self waittill("ambient_idle_scene_end");
}

func_CC80(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  if(isDefined(self.func_1DBC)) {
    self.func_1DBC = scripts\engine\utility::spawn_script_origin();
  }

  var_03 = [];

  foreach(var_05 in var_00) {
    var_5.func_DC6F = 0;

    if(!var_01 && isai(var_05)) {
      var_05 animmode("noclip");
      var_05 _meth_80F1(self.origin, self.angles, 100000.0);
      continue;
    }

    var_5.origin = self.origin;
    var_5.angles = self.angles;
  }

  if(var_02) {
    thread func_DC83(var_00);
    thread func_DC87(var_00);
  } else {
    thread func_DC84(var_00);
    thread func_DC87(var_00);
  }

  self waittill("ambient_idle_scene_end");
}

func_4179() {
  self clearanim( % root, 0.1);
}

func_DC81(var_00) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_01 = 0;
  var_02 = level.func_EC85[var_0.func_1FBB]["idle_anims"].size;
  var_03 = level.func_EC85[var_0.func_1FBB]["idle_base"];
  var_04 = [];
  var_05 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\sp\anim::func_10CBF(var_00, "single anim");
  thread scripts\sp\anim::func_1FCA(var_00, "single anim");

  for(;;) {
    if(var_4.size >= var_02) {
      var_05 = randomint(var_02);
      var_04 = [];
      var_04 = scripts\engine\utility::array_add(var_04, var_05);
    } else {
      var_05 = randomint(var_02);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_04, var_05)) {
          var_05 = randomint(var_02);
          continue;
        }

        var_04 = scripts\engine\utility::array_add(var_04, var_05);
        break;
      }
    }

    if(!isDefined(var_00)) {
      return;
    }
    var_06 = level.func_EC85[var_0.func_1FBB]["idle_anims"][var_05];
    var_07 = _getstartorigin(self.origin, self.angles, var_03);
    var_08 = _getstartangles(self.origin, self.angles, var_03);

    if(isDefined(var_0.func_9B89) || !isai(var_00)) {
      var_0.origin = var_07;
      var_0.angles = var_08;
    } else
      var_00 _meth_80F1(var_07, var_08, 100000.0);

    var_09 = undefined;

    if(isDefined(var_0.func_1ED4)) {
      var_09 = [
        }
        [var_0.func_1ED4]]();

    var_10 = getanimlength(var_03);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);

    if(!isDefined(var_00)) {
      return;
    }
    var_00 animscripted("single anim", self.origin, self.angles, var_03, undefined, undefined, 0.2);
    wait(var_12);

    if(!isDefined(var_00)) {
      return;
    }
    func_13596(var_03, var_6[0], var_00);

    if(!isDefined(var_00)) {
      return;
    }
    var_00 clearanim(var_03, 0.1);
    var_00 animscripted("single anim", self.origin, self.angles, var_6[0], undefined, undefined, 0.2);
    var_13 = getanimlength(var_6[0]);
    wait(var_13);

    if(!isDefined(var_00)) {
      return;
    }
    var_00 clearanim(var_6[0], 0.1);
    var_00 animscripted("single anim", self.origin, self.angles, var_6[1], undefined, undefined, 0.2);
    var_10 = getanimlength(var_6[1]);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);
    wait(var_12);

    if(!isDefined(var_00)) {
      return;
    }
    func_13596(var_6[1], var_6[2], var_00);

    if(!isDefined(var_00)) {
      return;
    }
    var_00 clearanim(var_6[1], 0.1);
    var_00 animscripted("single anim", self.origin, self.angles, var_6[2], undefined, undefined, 0.2);
    var_14 = getanimlength(var_6[2]);
    wait(var_14);

    if(!isDefined(var_00)) {
      return;
    }
    var_00 clearanim(var_6[2], 0.1);
    scripts\engine\utility::waitframe();
  }
}

func_DC84(var_00) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_01 = 0;
  var_02 = level.func_EC85[var_0[0].func_1FBB]["idle_anims"].size;
  var_03 = level.func_EC85[var_0[0].func_1FBB]["idle_base"];
  var_04 = [];
  var_05 = 0;
  self notify("ambient_idle_scene_start");

  foreach(var_07 in var_00) {
    if(!isDefined(var_7.func_1FEC)) {
      var_07 scripts\sp\anim::func_F64A();
    }

    thread scripts\sp\anim::func_10CBF(var_07, "single anim");
    thread scripts\sp\anim::func_1FCA(var_07, "single anim");
  }

  for(;;) {
    if(var_4.size >= var_02) {
      var_05 = randomint(var_02);
      var_04 = [];
      var_04 = scripts\engine\utility::array_add(var_04, var_05);
    } else {
      var_05 = randomint(var_02);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_04, var_05)) {
          var_05 = randomint(var_02);
          continue;
        }

        var_04 = scripts\engine\utility::array_add(var_04, var_05);
        break;
      }
    }

    var_09 = 0;
    var_10 = undefined;

    foreach(var_07 in var_00) {
      var_10 = level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05];
      var_12 = _getstartorigin(self.origin, self.angles, var_03);
      var_13 = _getstartangles(self.origin, self.angles, var_03);
      var_03 = level.func_EC85[var_7.func_1FBB]["idle_base"];

      if(isDefined(var_7.func_9B89) || !isai(var_07)) {
        var_7.origin = var_12;
        var_7.angles = var_13;
      } else
        var_07 _meth_80F1(var_12, var_13, 100000.0);

      var_14 = undefined;

      if(isDefined(var_7.func_1ED4)) {
        var_14 = [
          }
          [var_7.func_1ED4]
      ]();

      var_15 = getanimlength(var_03);
      var_16 = randomintrange(1, 4);
      var_09 = var_15 * float(var_16);
      var_07 animscripted("single anim", self.origin, self.angles, var_03, undefined, undefined, 0.2);
    }

    wait(var_09);
    var_18 = [];

    foreach(var_07 in var_00) {
      var_18 = scripts\engine\utility::array_add(var_18, level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05][0]);
    }

    func_13597(var_03, var_18, var_00);

    foreach(var_07 in var_00) {
      var_03 = level.func_EC85[var_7.func_1FBB]["idle_base"];
      var_10 = level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05];
      var_07 clearanim(var_03, 0.1);
      var_07 animscripted("single anim", self.origin, self.angles, var_10[0], undefined, undefined, 0.2);
    }

    var_23 = getanimlength(var_10[0]);
    wait(var_23);

    foreach(var_07 in var_00) {
      var_10 = level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05];
      var_07 clearanim(var_10[0], 0.1);
      var_07 animscripted("single anim", self.origin, self.angles, var_10[1], undefined, undefined, 0.2);
    }

    var_15 = getanimlength(var_10[1]);
    var_16 = randomintrange(1, 4);
    var_09 = var_15 * float(var_16);
    wait(var_09);
    var_18 = [];

    foreach(var_07 in var_00) {
      var_18 = scripts\engine\utility::array_add(var_18, level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05][2]);
    }

    func_13597(var_10[1], var_18, var_00);

    foreach(var_07 in var_00) {
      var_03 = level.func_EC85[var_7.func_1FBB]["idle_base"];
      var_10 = level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05];
      var_07 clearanim(var_10[1], 0.1);
      var_07 animscripted("single anim", self.origin, self.angles, var_10[2], undefined, undefined, 0.2);
    }

    var_30 = getanimlength(var_10[2]);
    wait(var_30);

    foreach(var_07 in var_00) {
      var_10 = level.func_EC85[var_7.func_1FBB]["idle_anims"][var_05];
      var_07 clearanim(var_10[2], 0.1);
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC85() {
  func_0A1E::func_2386();
  self notify("ambient_idle_scene_end");
}

func_DC88(var_00) {
  foreach(var_02 in var_00) {
    if(_isent(var_02)) {
      var_02 func_0A1E::func_2386();
      var_02 notify("ambient_idle_scene_end");
    }
  }
}

func_DC86(var_00) {
  self endon("death");
  self waittill("ambient_scene_end");

  if(_isent(var_00)) {
    var_00 func_4179();
  }

  self notify("ambient_idle_scene_end");
}

func_DC87(var_00) {
  self endon("death");
  self waittill("ambient_scene_end");

  foreach(var_02 in var_00) {
    if(_isent(var_02)) {
      var_02 givescorefortrophyblocks();
    }
  }

  self notify("ambient_idle_scene_end");
}

func_DC82(var_00) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_01 = level.func_EC85[var_0.func_1FBB]["idle_anims"].size;
  var_02 = level.func_EC85[var_0.func_1FBB]["idle_base"];
  var_03 = [];
  var_04 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\sp\anim::func_10CBF(var_00, "single anim");
  thread scripts\sp\anim::func_1FCA(var_00, "single anim");

  for(;;) {
    if(var_3.size >= var_01) {
      var_04 = randomint(var_01);
      var_03 = [];
      var_03 = scripts\engine\utility::array_add(var_03, var_04);
    } else {
      var_04 = randomint(var_01);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_03, var_04)) {
          var_04 = randomint(var_01);
          continue;
        }

        var_03 = scripts\engine\utility::array_add(var_03, var_04);
        break;
      }
    }

    var_05 = level.func_EC85[var_0.func_1FBB]["idle_anims"][var_04];
    var_06 = _getstartorigin(self.origin, self.angles, var_02);
    var_07 = _getstartangles(self.origin, self.angles, var_02);

    if(isDefined(var_0.func_9B89) || !isai(var_00)) {
      var_0.origin = var_06;
      var_0.angles = var_07;
    } else
      var_00 _meth_80F1(var_06, var_07, 100000.0);

    var_08 = undefined;

    if(isDefined(var_0.func_1ED4)) {
      var_08 = [
        }
        [var_0.func_1ED4]]();

    var_09 = getanimlength(var_02);
    var_10 = randomintrange(1, 4);
    var_11 = var_09 * float(var_10);
    var_00 animscripted("single anim", self.origin, self.angles, var_02, undefined, undefined, 0.2);
    wait(var_11);
    var_00 clearanim(var_02, 0.1);
    var_00 animscripted("single anim", self.origin, self.angles, var_05, undefined, undefined, 0.2);
    var_12 = getanimlength(var_05);
    wait(var_12);
    var_00 clearanim(var_05, 0.1);
    scripts\engine\utility::waitframe();
  }
}

func_DC83(var_00) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_01 = level.func_EC85[var_0[0].func_1FBB]["idle_anims"].size;
  var_02 = [];
  var_03 = 0;
  var_04 = self;
  self notify("ambient_idle_scene_start");

  foreach(var_06 in var_00) {
    var_07 = level.func_EC85[var_6.func_1FBB]["idle_base"];
    var_08 = _getstartorigin(self.origin, self.angles, var_07);
    var_09 = _getstartangles(self.origin, self.angles, var_07);
    var_6.origin = var_08;
    var_6.angles = var_09;
    thread scripts\sp\anim::func_10CBF(var_06, "single anim");
    thread scripts\sp\anim::func_1FCA(var_06, "single anim");
    var_10 = undefined;

    if(isDefined(var_6.func_1ED4)) {
      var_10 = [
        }
        [var_6.func_1ED4]]();

    var_06 animscripted("single anim", self.origin, self.angles, var_07, undefined, var_10, 0.0);
  }

  for(;;) {
    if(var_2.size >= var_01) {
      var_03 = randomint(var_01);
      var_02 = [];
      var_02 = scripts\engine\utility::array_add(var_02, var_03);
    } else {
      var_03 = randomint(var_01);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_02, var_03)) {
          var_03 = randomint(var_01);
          continue;
        }

        var_02 = scripts\engine\utility::array_add(var_02, var_03);
        break;
      }
    }

    var_12 = [];
    var_13 = 0;
    var_14 = randomintrange(1, 4);

    foreach(var_06 in var_00) {
      var_07 = level.func_EC85[var_6.func_1FBB]["idle_base"];
      var_08 = _getstartorigin(self.origin, self.angles, var_07);
      var_09 = _getstartangles(self.origin, self.angles, var_07);
      var_6.origin = var_08;
      var_6.angles = var_09;
      var_10 = undefined;

      if(isDefined(var_6.func_1ED4)) {
        var_10 = [
          }
          [var_6.func_1ED4]
      ]();

      var_16 = getanimlength(var_07);
      var_13 = var_16;
      var_06 animscripted("single anim", self.origin, self.angles, var_07, undefined, var_10, 0.2);
    }

    wait(var_13);
    var_18 = 0;

    foreach(var_21, var_06 in var_00) {
      var_07 = level.func_EC85[var_6.func_1FBB]["idle_base"];
      var_20 = level.func_EC85[var_6.func_1FBB]["idle_anims"][var_03];
      var_08 = _getstartorigin(self.origin, self.angles, var_20);
      var_09 = _getstartangles(self.origin, self.angles, var_20);
      var_6.origin = var_08;
      var_6.angles = var_09;
      var_10 = undefined;

      if(isDefined(var_6.func_1ED4)) {
        var_10 = [
          }
          [var_6.func_1ED4]
      ]();

      var_06 animscripted("single anim", self.origin, self.angles, var_20, undefined, var_10, 0.2);
      var_18 = getanimlength(var_20);
    }

    wait(var_18);
  }
}

func_9B63(var_00) {
  return isDefined(level.func_1DBE) && isDefined(level.func_1DBE[var_00]);
}

func_9B62(var_00) {
  if(isDefined(var_0.script_noteworthy) && func_9B63(var_0.script_noteworthy)) {
    return 1;
  }

  return 0;
}

func_13596(var_00, var_01, var_02) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_02 endon("death");

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = length2d(level.player.origin - var_2.origin);
  var_04 = length2d(level.player.origin - var_02 scripts\anim\utility::func_7DC6(var_01));
  var_05 = float(getdvar("g_speed")) * 0.25;

  for(;;) {
    if(var_03 / var_05 > getanimlength(var_01) && var_04 / var_05 > getanimlength(var_01)) {
      break;
    }
    if(!isDefined(var_02)) {
      return;
    }
    var_03 = length2d(level.player.origin - var_2.origin);
    var_04 = length2d(level.player.origin - var_02 scripts\anim\utility::func_7DC6(var_01));
    var_05 = float(getdvar("g_speed")) * 0.25;
    var_06 = getanimlength(var_00);
    wait(var_06);
  }
}

func_13597(var_00, var_01, var_02) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_03 = undefined;
  var_04 = undefined;
  var_05 = float(getdvar("g_speed")) * 0.25;

  for(;;) {
    var_06 = 0;

    for(var_07 = 0; var_07 < var_2.size; var_7++) {
      var_08 = var_2[var_07];
      var_03 = length2d(level.player.origin - var_8.origin);
      var_04 = length2d(level.player.origin - var_08 scripts\anim\utility::func_7DC6(var_1[var_07]));
      var_05 = float(getdvar("g_speed")) * 0.25;

      if(var_03 / var_05 > getanimlength(var_1[var_07]) && var_04 / var_05 > getanimlength(var_1[var_07])) {
        var_6++;
      }
    }

    if(var_06 >= var_2.size) {
      break;
    }
    var_09 = getanimlength(var_00);
    wait(var_09);
  }
}

func_CDD6(var_00, var_01, var_02) {
  self endon("stop_idles");
  self endon("death");
  var_00 endon("death");
  var_03 = [];
  var_04 = var_02;
  var_05 = undefined;
  var_0.func_DC89 = 1;

  for(;;) {
    scripts\sp\anim::func_1F35(var_00, var_01);

    if(var_4.size < 1) {
      var_04 = var_03;
    }

    var_05 = randomint(var_4.size);
    scripts\sp\anim::func_1F35(var_00, var_4[var_05]);
    var_03 = scripts\engine\utility::array_add(var_03, var_4[var_05]);
    var_04 = scripts\engine\utility::array_remove(var_04, var_4[var_05]);
    scripts\engine\utility::waitframe();
  }
}

func_11036() {
  self notify("stop_idles");
  self.func_DC89 = undefined;
}