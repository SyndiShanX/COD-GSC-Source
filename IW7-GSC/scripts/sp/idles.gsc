/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\idles.gsc
*********************************************/

func_DEB8(var_0, var_1) {
  level.var_1DBE[var_0] = var_1;
}

func_7A2D(var_0) {
  if(!isDefined(level.var_1DBE) || !isDefined(level.var_1DBE[var_0])) {
    return undefined;
  }

  return level.var_1DBE[var_0];
}

func_CC7F(var_0, var_1) {
  self.var_DC6F = 0;
  if(isai(var_0) && !isDefined(var_0.var_9B89)) {
    var_0 animmode("noclip");
  }

  wait(0.1);
  var_0 clearanim( % root, 0);
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
      var_5 func_80F1(self.origin, self.angles, 100000);
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
    var_7 = getstartorigin(self.origin, self.angles, var_3);
    var_8 = getstartangles(self.origin, self.angles, var_3);
    if(isDefined(var_0.var_9B89) || !isai(var_0)) {
      var_0.origin = var_7;
      var_0.angles = var_8;
    } else {
      var_0 func_80F1(var_7, var_8, 100000);
    }

    var_9 = undefined;
    if(isDefined(var_0.var_1ED4)) {
      var_9 = [
        [var_0.var_1ED4]
      ]();
    }

    var_0A = getanimlength(var_3);
    var_0B = randomintrange(1, 4);
    var_0C = var_0A * float(var_0B);
    if(!isDefined(var_0)) {
      return;
    }

    var_0 animscripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    wait(var_0C);
    if(!isDefined(var_0)) {
      return;
    }

    func_13596(var_3, var_6[0], var_0);
    if(!isDefined(var_0)) {
      return;
    }

    var_0 clearanim(var_3, 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[0], undefined, undefined, 0.2);
    var_0D = getanimlength(var_6[0]);
    wait(var_0D);
    if(!isDefined(var_0)) {
      return;
    }

    var_0 clearanim(var_6[0], 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[1], undefined, undefined, 0.2);
    var_0A = getanimlength(var_6[1]);
    var_0B = randomintrange(1, 4);
    var_0C = var_0A * float(var_0B);
    wait(var_0C);
    if(!isDefined(var_0)) {
      return;
    }

    func_13596(var_6[1], var_6[2], var_0);
    if(!isDefined(var_0)) {
      return;
    }

    var_0 clearanim(var_6[1], 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_6[2], undefined, undefined, 0.2);
    var_0E = getanimlength(var_6[2]);
    wait(var_0E);
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
    var_0A = undefined;
    foreach(var_7 in var_0) {
      var_0A = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_0C = getstartorigin(self.origin, self.angles, var_3);
      var_0D = getstartangles(self.origin, self.angles, var_3);
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];
      if(isDefined(var_7.var_9B89) || !isai(var_7)) {
        var_7.origin = var_0C;
        var_7.angles = var_0D;
      } else {
        var_7 func_80F1(var_0C, var_0D, 100000);
      }

      var_0E = undefined;
      if(isDefined(var_7.var_1ED4)) {
        var_0E = [[var_7.var_1ED4]]();
      }

      var_0F = getanimlength(var_3);
      var_10 = randomintrange(1, 4);
      var_9 = var_0F * float(var_10);
      var_7 animscripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    }

    wait(var_9);
    var_12 = [];
    foreach(var_7 in var_0) {
      var_12 = scripts\engine\utility::array_add(var_12, level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5][0]);
    }

    func_13597(var_3, var_12, var_0);
    foreach(var_7 in var_0) {
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];
      var_0A = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_3, 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_0A[0], undefined, undefined, 0.2);
    }

    var_17 = getanimlength(var_0A[0]);
    wait(var_17);
    foreach(var_7 in var_0) {
      var_0A = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_0A[0], 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_0A[1], undefined, undefined, 0.2);
    }

    var_0F = getanimlength(var_0A[1]);
    var_10 = randomintrange(1, 4);
    var_9 = var_0F * float(var_10);
    wait(var_9);
    var_12 = [];
    foreach(var_7 in var_0) {
      var_12 = scripts\engine\utility::array_add(var_12, level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5][2]);
    }

    func_13597(var_0A[1], var_12, var_0);
    foreach(var_7 in var_0) {
      var_3 = level.var_EC85[var_7.var_1FBB]["idle_base"];
      var_0A = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_0A[1], 0.1);
      var_7 animscripted("single anim", self.origin, self.angles, var_0A[2], undefined, undefined, 0.2);
    }

    var_1E = getanimlength(var_0A[2]);
    wait(var_1E);
    foreach(var_7 in var_0) {
      var_0A = level.var_EC85[var_7.var_1FBB]["idle_anims"][var_5];
      var_7 clearanim(var_0A[2], 0.1);
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC85() {
  lib_0A1E::func_2386();
  self notify("ambient_idle_scene_end");
}

func_DC88(var_0) {
  foreach(var_2 in var_0) {
    if(isent(var_2)) {
      var_2 lib_0A1E::func_2386();
      var_2 notify("ambient_idle_scene_end");
    }
  }
}

func_DC86(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");
  if(isent(var_0)) {
    var_0 func_4179();
  }

  self notify("ambient_idle_scene_end");
}

func_DC87(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");
  foreach(var_2 in var_0) {
    if(isent(var_2)) {
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
    var_6 = getstartorigin(self.origin, self.angles, var_2);
    var_7 = getstartangles(self.origin, self.angles, var_2);
    if(isDefined(var_0.var_9B89) || !isai(var_0)) {
      var_0.origin = var_6;
      var_0.angles = var_7;
    } else {
      var_0 func_80F1(var_6, var_7, 100000);
    }

    var_8 = undefined;
    if(isDefined(var_0.var_1ED4)) {
      var_8 = [
        [var_0.var_1ED4]
      ]();
    }

    var_9 = getanimlength(var_2);
    var_0A = randomintrange(1, 4);
    var_0B = var_9 * float(var_0A);
    var_0 animscripted("single anim", self.origin, self.angles, var_2, undefined, undefined, 0.2);
    wait(var_0B);
    var_0 clearanim(var_2, 0.1);
    var_0 animscripted("single anim", self.origin, self.angles, var_5, undefined, undefined, 0.2);
    var_0C = getanimlength(var_5);
    wait(var_0C);
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
    var_8 = getstartorigin(self.origin, self.angles, var_7);
    var_9 = getstartangles(self.origin, self.angles, var_7);
    var_6.origin = var_8;
    var_6.angles = var_9;
    thread scripts\sp\anim::func_10CBF(var_6, "single anim");
    thread scripts\sp\anim::func_1FCA(var_6, "single anim");
    var_0A = undefined;
    if(isDefined(var_6.var_1ED4)) {
      var_0A = [
        [var_6.var_1ED4]
      ]();
    }

    var_6 animscripted("single anim", self.origin, self.angles, var_7, undefined, var_0A, 0);
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

    var_0C = [];
    var_0D = 0;
    var_0E = randomintrange(1, 4);
    foreach(var_6 in var_0) {
      var_7 = level.var_EC85[var_6.var_1FBB]["idle_base"];
      var_8 = getstartorigin(self.origin, self.angles, var_7);
      var_9 = getstartangles(self.origin, self.angles, var_7);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_0A = undefined;
      if(isDefined(var_6.var_1ED4)) {
        var_0A = [[var_6.var_1ED4]]();
      }

      var_10 = getanimlength(var_7);
      var_0D = var_10;
      var_6 animscripted("single anim", self.origin, self.angles, var_7, undefined, var_0A, 0.2);
    }

    wait(var_0D);
    var_12 = 0;
    foreach(var_6 in var_0) {
      var_7 = level.var_EC85[var_6.var_1FBB]["idle_base"];
      var_14 = level.var_EC85[var_6.var_1FBB]["idle_anims"][var_3];
      var_8 = getstartorigin(self.origin, self.angles, var_14);
      var_9 = getstartangles(self.origin, self.angles, var_14);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_0A = undefined;
      if(isDefined(var_6.var_1ED4)) {
        var_0A = [[var_6.var_1ED4]]();
      }

      var_6 animscripted("single anim", self.origin, self.angles, var_14, undefined, var_0A, 0.2);
      var_12 = getanimlength(var_14);
    }

    wait(var_12);
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