/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2880.gsc
**************************************/

func_DEB8(var_0, var_1) {
  level.var_1DBE[var_0] = var_1;
}

func_7A2D(var_0) {
  if(!isDefined(level.var_1DBE) || !isDefined(level.var_1DBE[var_0])) {
    return undefined;
  }

  return level.var_1DBE[var_0];
}

#using_animtree("generic_human");

func_CC7F(var_0, var_1) {
  self.var_DC6F = 0;

  if(isai(var_0) && !isDefined(var_0.var_9B89)) {
    var_0 animmode("noclip");
  }

  wait 0.1;
  var_0 clearanim( % root, 0.0);

  if(isDefined(var_0.var_9B89)) {
    if(isDefined(var_1) && var_1) {
      thread func_DC82(var_0);
      thread func_DC86(var_0);
    } else {
      thread func_DC81(var_0);
      thread func_DC86(var_0);
    }
  } else if(isDefined(var_1) && var_1) {
    thread func_DC82(var_0);
    thread func_DC85();
  } else {
    thread func_DC81(var_0);
    thread func_DC85();
  }

  self waittill("ambient_idle_scene_end");
}

func_CC80(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(isDefined(self.var_1DBC)) {
    self.var_1DBC = scripts\engine\utility::spawn_script_origin();
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.var_DC6F = 0;

    if(!var_1 && isai(var_5)) {
      var_5 animmode("noclip");
      var_5 func_80F1(self.origin, self.angles, 100000.0);
      continue;
    }

    var_5.origin = self.origin;
    var_5.angles = self.angles;
  }

  if(var_2) {
    thread func_DC83(var_0);
    thread func_DC87(var_0);
  } else {
    thread func_DC84(var_0);
    thread func_DC87(var_0);
  }

  self waittill("ambient_idle_scene_end");
}

func_4179() {
  self clearanim( % root, 0.1);
}

func_DC81(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level.var_EC85[var_0.var_1FBB]["idle_anims"].size;
  var_3 = level.var_EC85[var_0.var_1FBB]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\sp\anim::func_10CBF(var_0, "single anim");
  thread scripts\sp\anim::func_1FCA(var_0, "single anim");

  for(;;) {
    if(var_4.size >= var_2) {
      var_5 = randomint(var_2);
      var_4 = [];
      var_4 = scripts\engine\utility::array_add(var_4, var_5);
    } else {
      var_5 = randomint(var_2);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_4, var_5)) {
          var_5 = randomint(var_2);
          continue;
        }

        var_4 = scripts\engine\utility::array_add(var_4, var_5);
        break;
      }
    }

    if(!isDefined(var_0)) {
      return;
    }
    var_6 = level.var_EC85[var_0.var_1FBB]["idle_anims"][var_5];
    var_7 = _getstartorigin(self.origin, self.angles, var_3);
    var_8 = _getstartangles(self.origin, self.angles, var_3);

    if(isDefined(var_0.var_9B89) || !isai(var_0)) {
      var_0.origin = var_7;
      var_0.angles = var_8;
    } else {
      var_0 func_80F1(var_7, var_8, 100000.0);
    }

    var_9 = undefined;

    if(isDefined(var_0.var_1ED4)) {
      var_9 = [
        }
        [var_0.var_1ED4]]();

    var_10 = getanimlength(var_3);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 animscripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    wait(var_12);

    if(!isDefined(var_0)) {
      return;
    }
    func_13596(var_3, var_6[0], var_0);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_3, 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[0], undefined, undefined, 0.2);
    var_13 = getanimlength(var_6[0]);
    wait(var_13);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[0], 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[1], undefined, undefined, 0.2);
    var_10 = getanimlength(var_6[1]);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);
    wait(var_12);

    if(!isDefined(var_0)) {
      return;
    }
    func_13596(var_6[1], var_6[2], var_0);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[1], 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[2], undefined, undefined, 0.2);
    var_14 = getanimlength(var_6[2]);
    wait(var_14);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[2], 0.1);
    scripts\engine\utility::waitframe();
  }
}

func_DC84(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level.var_EC85[var_0[0].var_1FBB]["idle_anims"].size;
  var_3 = level.var_EC85[var_0[0].var_1FBB]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");

  foreach(var_7 in var_0) {
    if(!isDefined(var_7.var_1FEC)) {
      var_7 scripts\sp\anim::func_F64A();
    }

    thread scripts\sp\anim::func_10CBF(var_7, "single anim");
    thread scripts\sp\anim::func_1FCA(var_7, "single anim");
  }

  for(;;) {
    if(var_4.size >= var_2) {
      var_5 = randomint(var_2);
      var_4 = [];
      var_4 = scripts\engine\utility::array_add(var_4, var_5);
    } else {
      var_5 = randomint(var_2);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_4, var_5)) {
          var_5 = randomint(var_2);
          continue;
        }

        var_4 = scripts\engine\utility::array_add(var_4, var_5);
        break;
      }
    }

    var_9 = 0;
    var_10 = undefined;

    foreach(var_7 in var_0) {
      var_10 = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_12 = _getstartorigin(self.origin, self.angles, var_3);
      var_13 = _getstartangles(self.origin, self.angles, var_3);
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];

      if(isDefined(var_7.var_9B89) || !isai(var_7)) {
        var_7.origin = var_12;
        var_7.angles = var_13;
      } else {
        var_7 func_80F1(var_12, var_13, 100000.0);
      }

      var_14 = undefined;

      if(isDefined(var_7.var_1ED4)) {
        var_14 = [
          }
          [var_7.var_1ED4]
      ]();

      var_15 = getanimlength(var_3);
      var_16 = randomintrange(1, 4);
      var_9 = var_15 * float(var_16);
      var_7 animscripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    }

    wait(var_9);
    var_18 = [];

    foreach(var_7 in var_0) {
      var_18 = scripts\engine\utility::array_add(var_18, level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5][0]);
    }

    func_13597(var_3, var_18, var_0);

    foreach(var_7 in var_0) {
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];
      var_10 = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_3, 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_10[0], undefined, undefined, 0.2);
    }

    var_23 = getanimlength(var_10[0]);
    wait(var_23);

    foreach(var_7 in var_0) {
      var_10 = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_10[0], 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_10[1], undefined, undefined, 0.2);
    }

    var_15 = getanimlength(var_10[1]);
    var_16 = randomintrange(1, 4);
    var_9 = var_15 * float(var_16);
    wait(var_9);
    var_18 = [];

    foreach(var_7 in var_0) {
      var_18 = scripts\engine\utility::array_add(var_18, level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5][2]);
    }

    func_13597(var_10[1], var_18, var_0);

    foreach(var_7 in var_0) {
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];
      var_10 = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_10[1], 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_10[2], undefined, undefined, 0.2);
    }

    var_30 = getanimlength(var_10[2]);
    wait(var_30);

    foreach(var_7 in var_0) {
      var_10 = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_10[2], 0.1);
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC85() {
  func_0A1E::func_2386();
  self notify("ambient_idle_scene_end");
}

func_DC88(var_0) {
  foreach(var_2 in var_0) {
    if(_isent(var_2)) {
      var_2 func_0A1E::func_2386();
      var_2 notify("ambient_idle_scene_end");
    }
  }
}

func_DC86(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  if(_isent(var_0)) {
    var_0 func_4179();
  }

  self notify("ambient_idle_scene_end");
}

func_DC87(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  foreach(var_2 in var_0) {
    if(_isent(var_2)) {
      var_2 givescorefortrophyblocks();
    }
  }

  self notify("ambient_idle_scene_end");
}

func_DC82(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level.var_EC85[var_0.var_1FBB]["idle_anims"].size;
  var_2 = level.var_EC85[var_0.var_1FBB]["idle_base"];
  var_3 = [];
  var_4 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\sp\anim::func_10CBF(var_0, "single anim");
  thread scripts\sp\anim::func_1FCA(var_0, "single anim");

  for(;;) {
    if(var_3.size >= var_1) {
      var_4 = randomint(var_1);
      var_3 = [];
      var_3 = scripts\engine\utility::array_add(var_3, var_4);
    } else {
      var_4 = randomint(var_1);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_3, var_4)) {
          var_4 = randomint(var_1);
          continue;
        }

        var_3 = scripts\engine\utility::array_add(var_3, var_4);
        break;
      }
    }

    var_5 = level.var_EC85[var_0.var_1FBB]["idle_anims"][var_4];
    var_6 = _getstartorigin(self.origin, self.angles, var_2);
    var_7 = _getstartangles(self.origin, self.angles, var_2);

    if(isDefined(var_0.var_9B89) || !isai(var_0)) {
      var_0.origin = var_6;
      var_0.angles = var_7;
    } else {
      var_0 func_80F1(var_6, var_7, 100000.0);
    }

    var_8 = undefined;

    if(isDefined(var_0.var_1ED4)) {
      var_8 = [
        }
        [var_0.var_1ED4]]();

    var_9 = getanimlength(var_2);
    var_10 = randomintrange(1, 4);
    var_11 = var_9 * float(var_10);
    var_0 animscripted("single anim", self.origin, self.angles, var_2, undefined, undefined, 0.2);
    wait(var_11);
    var_0 clearanim(var_2, 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_5, undefined, undefined, 0.2);
    var_12 = getanimlength(var_5);
    wait(var_12);
    var_0 clearanim(var_5, 0.1);
    scripts\engine\utility::waitframe();
  }
}

func_DC83(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level.var_EC85[var_0[0].var_1FBB]["idle_anims"].size;
  var_2 = [];
  var_3 = 0;
  var_4 = self;
  self notify("ambient_idle_scene_start");

  foreach(var_6 in var_0) {
    var_7 = level.var_EC85[var_6.var_1FBB]["idle_base"];
    var_8 = _getstartorigin(self.origin, self.angles, var_7);
    var_9 = _getstartangles(self.origin, self.angles, var_7);
    var_6.origin = var_8;
    var_6.angles = var_9;
    thread scripts\sp\anim::func_10CBF(var_6, "single anim");
    thread scripts\sp\anim::func_1FCA(var_6, "single anim");
    var_10 = undefined;

    if(isDefined(var_6.var_1ED4)) {
      var_10 = [
        }
        [var_6.var_1ED4]]();

    var_6 animscripted("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.0);
  }

  for(;;) {
    if(var_2.size >= var_1) {
      var_3 = randomint(var_1);
      var_2 = [];
      var_2 = scripts\engine\utility::array_add(var_2, var_3);
    } else {
      var_3 = randomint(var_1);

      for(;;) {
        if(scripts\engine\utility::array_contains(var_2, var_3)) {
          var_3 = randomint(var_1);
          continue;
        }

        var_2 = scripts\engine\utility::array_add(var_2, var_3);
        break;
      }
    }

    var_12 = [];
    var_13 = 0;
    var_14 = randomintrange(1, 4);

    foreach(var_6 in var_0) {
      var_7 = level.var_EC85[var_6.var_1FBB]["idle_base"];
      var_8 = _getstartorigin(self.origin, self.angles, var_7);
      var_9 = _getstartangles(self.origin, self.angles, var_7);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_10 = undefined;

      if(isDefined(var_6.var_1ED4)) {
        var_10 = [
          }
          [var_6.var_1ED4]
      ]();

      var_16 = getanimlength(var_7);
      var_13 = var_16;
      var_6 animscripted("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.2);
    }

    wait(var_13);
    var_18 = 0;

    foreach(var_21, var_6 in var_0) {
      var_7 = level.var_EC85[var_6.var_1FBB]["idle_base"];
      var_20 = level.var_EC85[var_6.var_1FBB]["idle_anims"][var_3];
      var_8 = _getstartorigin(self.origin, self.angles, var_20);
      var_9 = _getstartangles(self.origin, self.angles, var_20);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_10 = undefined;

      if(isDefined(var_6.var_1ED4)) {
        var_10 = [
          }
          [var_6.var_1ED4]
      ]();

      var_6 animscripted("single anim", self.origin, self.angles, var_20, undefined, var_10, 0.2);
      var_18 = getanimlength(var_20);
    }

    wait(var_18);
  }
}

func_9B63(var_0) {
  return isDefined(level.var_1DBE) && isDefined(level.var_1DBE[var_0]);
}

func_9B62(var_0) {
  if(isDefined(var_0.script_noteworthy) && func_9B63(var_0.script_noteworthy)) {
    return 1;
  }

  return 0;
}

func_13596(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_2 endon("death");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = length2d(level.player.origin - var_2.origin);
  var_4 = length2d(level.player.origin - var_2 scripts\anim\utility::func_7DC6(var_1));
  var_5 = float(getdvar("g_speed")) * 0.25;

  for(;;) {
    if(var_3 / var_5 > getanimlength(var_1) && var_4 / var_5 > getanimlength(var_1)) {
      break;
    }
    if(!isDefined(var_2)) {
      return;
    }
    var_3 = length2d(level.player.origin - var_2.origin);
    var_4 = length2d(level.player.origin - var_2 scripts\anim\utility::func_7DC6(var_1));
    var_5 = float(getdvar("g_speed")) * 0.25;
    var_6 = getanimlength(var_0);
    wait(var_6);
  }
}

func_13597(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = float(getdvar("g_speed")) * 0.25;

  for(;;) {
    var_6 = 0;

    for(var_7 = 0; var_7 < var_2.size; var_7++) {
      var_8 = var_2[var_7];
      var_3 = length2d(level.player.origin - var_8.origin);
      var_4 = length2d(level.player.origin - var_8 scripts\anim\utility::func_7DC6(var_1[var_7]));
      var_5 = float(getdvar("g_speed")) * 0.25;

      if(var_3 / var_5 > getanimlength(var_1[var_7]) && var_4 / var_5 > getanimlength(var_1[var_7])) {
        var_6++;
      }
    }

    if(var_6 >= var_2.size) {
      break;
    }
    var_9 = getanimlength(var_0);
    wait(var_9);
  }
}

func_CDD6(var_0, var_1, var_2) {
  self endon("stop_idles");
  self endon("death");
  var_0 endon("death");
  var_3 = [];
  var_4 = var_2;
  var_5 = undefined;
  var_0.var_DC89 = 1;

  for(;;) {
    scripts\sp\anim::func_1F35(var_0, var_1);

    if(var_4.size < 1) {
      var_4 = var_3;
    }

    var_5 = randomint(var_4.size);
    scripts\sp\anim::func_1F35(var_0, var_4[var_5]);
    var_3 = scripts\engine\utility::array_add(var_3, var_4[var_5]);
    var_4 = scripts\engine\utility::array_remove(var_4, var_4[var_5]);
    scripts\engine\utility::waitframe();
  }
}

func_11036() {
  self notify("stop_idles");
  self.var_DC89 = undefined;
}