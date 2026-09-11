/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\idles.gsc
***********************************************/

function register_idle_scene(var0, var1) {
  level.ambient_idle_scenes[var0] = var1;
}

function get_idle_scene(var0) {
  if(!isDefined(level.ambient_idle_scenes) || !isDefined(level.ambient_idle_scenes[var0])) {
    return undefined;
  }

  return level.ambient_idle_scenes[var0];
}

#using_animtree("generic_human");

function play_ambient_idle_scene(var0, var1) {
  self.random_ambient_idle_playing = 0;

  if(isai(var0) && !isDefined(var0.is_cheap)) {
    var0 animmode("noclip");
  }

  wait 0.1;
  var0 clearanim(%root, 0);

  if(isDefined(var0.is_cheap)) {
    if(isDefined(var1) && var1) {
      thread random_idle_scene_controller_simple(var0);
      thread random_idle_scene_end_cheap(var0);
    } else {
      thread random_idle_scene_controller(var0);
      thread random_idle_scene_end_cheap(var0);
    }
  } else if(isDefined(var1) && var1) {
    thread random_idle_scene_controller_simple(var0);
    thread random_idle_scene_end();
  } else {
    thread random_idle_scene_controller(var0);
    thread random_idle_scene_end();
  }

  self waittill("ambient_idle_scene_end");
}

function play_ambient_idle_scene_single(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(isDefined(self.ambient_idle_anim_node)) {
    self.ambient_idle_anim_node = scripts\engine\utility::spawn_script_origin();
  }

  var3 = [];

  foreach(var5 in var0) {
    var5.random_ambient_idle_playing = 0;

    if(!var1 && isai(var5)) {
      var5 animmode("noclip");
      var5 forceteleport(self.origin, self.angles, 100000);
      continue;
    }

    var5.origin = self.origin;
    var5.angles = self.angles;
  }

  if(var2) {
    thread random_idle_scene_controller_simple_single(var0);
    thread random_idle_scene_end_cheap_single(var0);
  } else {
    thread random_idle_scene_controller_single(var0);
    thread random_idle_scene_end_cheap_single(var0);
  }

  self waittill("ambient_idle_scene_end");
}

#using_animtree("");

function clear_root() {
  self clearanim(%root, 0.1);
}

function random_idle_scene_controller(var0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var1 = 0;
  var2 = level.scr_anim[var0.animname]["idle_anims"].size;
  var3 = level.scr_anim[var0.animname]["idle_base"];
  var4 = [];
  var5 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\common\notetrack::start_notetrack_wait(var0, "single anim");
  thread scripts\sp\anim::animscriptdonotetracksthread(var0, "single anim");

  for(;;) {
    if(var4.size >= var2) {
      var5 = randomint(var2);
      var4 = [];
      var4 = scripts\engine\utility::array_add(var4, var5);
    } else {
      var5 = randomint(var2);

      for(;;) {
        if(scripts\engine\utility::array_contains(var4, var5)) {
          var5 = randomint(var2);
          continue;
        }

        var4 = scripts\engine\utility::array_add(var4, var5);
        break;
      }
    }

    if(!isDefined(var0)) {
      return;
    }

    var6 = level.scr_anim[var0.animname]["idle_anims"][var5];
    var7 = getstartorigin(self.origin, self.angles, var3);
    var8 = getstartangles(self.origin, self.angles, var3);

    if(isDefined(var0.is_cheap) || !isai(var0)) {
      var0.origin = var7;
      var0.angles = var8;
    } else {
      var0 forceteleport(var7, var8, 100000);
    }

    var9 = undefined;

    if(isDefined(var0.anim_getrootfunc)) {
      var9 = [[var0.anim_getrootfunc]]();
    }

    var10 = getanimlength(var3);
    var11 = randomintrange(1, 4);
    var12 = var10 * float(var11);

    if(!isDefined(var0)) {
      return;
    }

    var0 animScripted("single anim", self.origin, self.angles, var3, undefined, undefined, 0.2);
    wait var12;

    if(!isDefined(var0)) {
      return;
    }

    wait_check_player_anim_interference(var3, var6[0], var0);

    if(!isDefined(var0)) {
      return;
    }

    var0 clearanim(var3, 0.1);
    var0 animScripted("single anim", self.origin, self.angles, var6[0], undefined, undefined, 0.2);
    var13 = getanimlength(var6[0]);
    wait var13;

    if(!isDefined(var0)) {
      return;
    }

    var0 clearanim(var6[0], 0.1);
    var0 animScripted("single anim", self.origin, self.angles, var6[1], undefined, undefined, 0.2);
    var10 = getanimlength(var6[1]);
    var11 = randomintrange(1, 4);
    var12 = var10 * float(var11);
    wait var12;

    if(!isDefined(var0)) {
      return;
    }

    wait_check_player_anim_interference(var6[1], var6[2], var0);

    if(!isDefined(var0)) {
      return;
    }

    var0 clearanim(var6[1], 0.1);
    var0 animScripted("single anim", self.origin, self.angles, var6[2], undefined, undefined, 0.2);
    var14 = getanimlength(var6[2]);
    wait var14;

    if(!isDefined(var0)) {
      return;
    }

    var0 clearanim(var6[2], 0.1);
    waitframe();
  }
}

function random_idle_scene_controller_single(var0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var1 = 0;
  var2 = level.scr_anim[var0[0].animname]["idle_anims"].size;
  var3 = level.scr_anim[var0[0].animname]["idle_base"];
  var4 = [];
  var5 = 0;
  self notify("ambient_idle_scene_start");

  foreach(var7 in var0) {
    if(!isDefined(var7.animtree)) {
      var7 scripts\common\anim::setanimtree();
    }

    thread scripts\common\notetrack::start_notetrack_wait(var7, "single anim");
    thread scripts\sp\anim::animscriptdonotetracksthread(var7, "single anim");
  }

  for(;;) {
    if(var4.size >= var2) {
      var5 = randomint(var2);
      var4 = [];
      var4 = scripts\engine\utility::array_add(var4, var5);
    } else {
      var5 = randomint(var2);

      for(;;) {
        if(scripts\engine\utility::array_contains(var4, var5)) {
          var5 = randomint(var2);
          continue;
        }

        var4 = scripts\engine\utility::array_add(var4, var5);
        break;
      }
    }

    var9 = 0;
    var10 = undefined;

    foreach(var7 in var0) {
      var10 = level.scr_anim[var7.animname]["idle_anims"][var5];
      var12 = getstartorigin(self.origin, self.angles, var3);
      var13 = getstartangles(self.origin, self.angles, var3);
      var3 = level.scr_anim[var7.animname]["idle_base"];

      if(isDefined(var7.is_cheap) || !isai(var7)) {
        var7.origin = var12;
        var7.angles = var13;
      } else {
        var7 forceteleport(var12, var13, 100000);
      }

      var14 = undefined;

      if(isDefined(var7.anim_getrootfunc)) {
        var14 = [[var7.anim_getrootfunc]]();
      }

      var15 = getanimlength(var3);
      var16 = randomintrange(1, 4);
      var9 = var15 * float(var16);
      var7 animScripted("single anim", self.origin, self.angles, var3, undefined, undefined, 0.2);
    }

    wait var9;
    var18 = [];

    foreach(var7 in var0) {
      var18 = scripts\engine\utility::array_add(var18, level.scr_anim[var7.animname]["idle_anims"][var5][0]);
    }

    wait_check_player_anim_interference_group(var3, var18, var0);

    foreach(var7 in var0) {
      var3 = level.scr_anim[var7.animname]["idle_base"];
      var10 = level.scr_anim[var7.animname]["idle_anims"][var5];
      var7 clearanim(var3, 0.1);
      var7 animScripted("single anim", self.origin, self.angles, var10[0], undefined, undefined, 0.2);
    }

    var23 = getanimlength(var10[0]);
    wait var23;

    foreach(var7 in var0) {
      var10 = level.scr_anim[var7.animname]["idle_anims"][var5];
      var7 clearanim(var10[0], 0.1);
      var7 animScripted("single anim", self.origin, self.angles, var10[1], undefined, undefined, 0.2);
    }

    var15 = getanimlength(var10[1]);
    var16 = randomintrange(1, 4);
    var9 = var15 * float(var16);
    wait var9;
    var18 = [];

    foreach(var7 in var0) {
      var18 = scripts\engine\utility::array_add(var18, level.scr_anim[var7.animname]["idle_anims"][var5][2]);
    }

    wait_check_player_anim_interference_group(var10[1], var18, var0);

    foreach(var7 in var0) {
      var3 = level.scr_anim[var7.animname]["idle_base"];
      var10 = level.scr_anim[var7.animname]["idle_anims"][var5];
      var7 clearanim(var10[1], 0.1);
      var7 animScripted("single anim", self.origin, self.angles, var10[2], undefined, undefined, 0.2);
    }

    var30 = getanimlength(var10[2]);
    wait var30;

    foreach(var7 in var0) {
      var10 = level.scr_anim[var7.animname]["idle_anims"][var5];
      var7 clearanim(var10[2], 0.1);
    }

    waitframe();
  }
}

function random_idle_scene_end() {
  scripts\asm\asm_sp::asm_stopanimScripted();
  self notify("ambient_idle_scene_end");
}

function random_idle_scene_end_single(var0) {
  foreach(var2 in var0) {
    if(isent(var2)) {
      var2 scripts\asm\asm_sp::asm_stopanimScripted();
      var2 notify("ambient_idle_scene_end");
    }
  }
}

function random_idle_scene_end_cheap(var0) {
  self endon("death");
  self waittill("ambient_scene_end");

  if(isent(var0)) {
    clear_root(var0);
  }

  self notify("ambient_idle_scene_end");
}

function random_idle_scene_end_cheap_single(var0) {
  self endon("death");
  self waittill("ambient_scene_end");

  foreach(var2 in var0) {
    if(isent(var2)) {
      var2 stopanimScripted();
    }
  }

  self notify("ambient_idle_scene_end");
}

function random_idle_scene_controller_simple(var0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var1 = level.scr_anim[var0.animname]["idle_anims"].size;
  var2 = level.scr_anim[var0.animname]["idle_base"];
  var3 = [];
  var4 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\common\notetrack::start_notetrack_wait(var0, "single anim");
  thread scripts\sp\anim::animscriptdonotetracksthread(var0, "single anim");

  for(;;) {
    if(var3.size >= var1) {
      var4 = randomint(var1);
      var3 = [];
      var3 = scripts\engine\utility::array_add(var3, var4);
    } else {
      var4 = randomint(var1);

      for(;;) {
        if(scripts\engine\utility::array_contains(var3, var4)) {
          var4 = randomint(var1);
          continue;
        }

        var3 = scripts\engine\utility::array_add(var3, var4);
        break;
      }
    }

    var5 = level.scr_anim[var0.animname]["idle_anims"][var4];
    var6 = getstartorigin(self.origin, self.angles, var2);
    var7 = getstartangles(self.origin, self.angles, var2);

    if(isDefined(var0.is_cheap) || !isai(var0)) {
      var0.origin = var6;
      var0.angles = var7;
    } else {
      var0 forceteleport(var6, var7, 100000);
    }

    var8 = undefined;

    if(isDefined(var0.anim_getrootfunc)) {
      var8 = [[var0.anim_getrootfunc]]();
    }

    var9 = getanimlength(var2);
    var10 = randomintrange(1, 4);
    var11 = var9 * float(var10);
    var0 animScripted("single anim", self.origin, self.angles, var2, undefined, undefined, 0.2);
    wait var11;
    var0 clearanim(var2, 0.1);
    var0 animScripted("single anim", self.origin, self.angles, var5, undefined, undefined, 0.2);
    var12 = getanimlength(var5);
    wait var12;
    var0 clearanim(var5, 0.1);
    waitframe();
  }
}

function random_idle_scene_controller_simple_single(var0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var1 = level.scr_anim[var0[0].animname]["idle_anims"].size;
  var2 = [];
  var3 = 0;
  var4 = self;
  self notify("ambient_idle_scene_start");

  foreach(var6 in var0) {
    var7 = level.scr_anim[var6.animname]["idle_base"];
    var8 = getstartorigin(self.origin, self.angles, var7);
    var9 = getstartangles(self.origin, self.angles, var7);
    var6.origin = var8;
    var6.angles = var9;
    thread scripts\common\notetrack::start_notetrack_wait(var6, "single anim");
    thread scripts\sp\anim::animscriptdonotetracksthread(var6, "single anim");
    var10 = undefined;

    if(isDefined(var6.anim_getrootfunc)) {
      var10 = [[var6.anim_getrootfunc]]();
    }

    var6 animScripted("single anim", self.origin, self.angles, var7, undefined, var10, 0);
  }

  for(;;) {
    if(var2.size >= var1) {
      var3 = randomint(var1);
      var2 = [];
      var2 = scripts\engine\utility::array_add(var2, var3);
    } else {
      var3 = randomint(var1);

      for(;;) {
        if(scripts\engine\utility::array_contains(var2, var3)) {
          var3 = randomint(var1);
          continue;
        }

        var2 = scripts\engine\utility::array_add(var2, var3);
        break;
      }
    }

    var12 = [];
    var13 = 0;
    var14 = randomintrange(1, 4);

    foreach(var6 in var0) {
      var7 = level.scr_anim[var6.animname]["idle_base"];
      var8 = getstartorigin(self.origin, self.angles, var7);
      var9 = getstartangles(self.origin, self.angles, var7);
      var6.origin = var8;
      var6.angles = var9;
      var10 = undefined;

      if(isDefined(var6.anim_getrootfunc)) {
        var10 = [[var6.anim_getrootfunc]]();
      }

      var16 = getanimlength(var7);
      var13 = var16;
      var6 animScripted("single anim", self.origin, self.angles, var7, undefined, var10, 0.2);
    }

    wait var13;
    var18 = 0;

    foreach(var6 in var0) {
      var7 = level.scr_anim[var6.animname]["idle_base"];
      var20 = level.scr_anim[var6.animname]["idle_anims"][var3];
      var8 = getstartorigin(self.origin, self.angles, var20);
      var9 = getstartangles(self.origin, self.angles, var20);
      var6.origin = var8;
      var6.angles = var9;
      var10 = undefined;

      if(isDefined(var6.anim_getrootfunc)) {
        var10 = [[var6.anim_getrootfunc]]();
      }

      var6 animScripted("single anim", self.origin, self.angles, var20, undefined, var10, 0.2);
      var18 = getanimlength(var20);
    }

    wait var18;
  }
}

function is_ambient_scene(var0) {
  return isDefined(level.ambient_idle_scenes) && isDefined(level.ambient_idle_scenes[var0]);
}

function is_ambient_idle_struct(var0) {
  if(isDefined(var0.script_noteworthy) && is_ambient_scene(var0.script_noteworthy)) {
    return true;
  }

  return false;
}

function wait_check_player_anim_interference(var0, var1, var2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var2 endon("death");

  if(!isDefined(var2)) {
    return;
  }

  var3 = length2d(level.player.origin - var2.origin);
  var4 = length2d(level.player.origin - var2 scripts\anim\utility::getanimendpos(var1));
  var5 = float(getDvar("NSRPQNLSNK")) * 0.25;

  for(;;) {
    if(var3 / var5 > getanimlength(var1) && var4 / var5 > getanimlength(var1)) {
      break;
    }

    if(!isDefined(var2)) {
      return;
    }

    var3 = length2d(level.player.origin - var2.origin);
    var4 = length2d(level.player.origin - var2 scripts\anim\utility::getanimendpos(var1));
    var5 = float(getDvar("NSRPQNLSNK")) * 0.25;
    var6 = getanimlength(var0);
    wait var6;
  }
}

function wait_check_player_anim_interference_group(var0, var1, var2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var3 = undefined;
  var4 = undefined;
  var5 = float(getDvar("NSRPQNLSNK")) * 0.25;

  for(;;) {
    var6 = 0;

    for(var7 = 0; var7 < var2.size; var7++) {
      var8 = var2[var7];
      var3 = length2d(level.player.origin - var8.origin);
      var4 = length2d(level.player.origin - var8 scripts\anim\utility::getanimendpos(var1[var7]));
      var5 = float(getDvar("NSRPQNLSNK")) * 0.25;

      if(var3 / var5 > getanimlength(var1[var7]) && var4 / var5 > getanimlength(var1[var7])) {
        var6++;
      }
    }

    if(var6 >= var2.size) {
      break;
    }

    var9 = getanimlength(var0);
    wait var9;
  }
}

function play_random_idles(var0, var1, var2) {
  self endon("stop_idles");
  self endon("death");
  var0 endon("death");
  var3 = [];
  var4 = var2;
  var5 = undefined;
  var0.random_idles = 1;

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, var1);

    if(var4.size < 1) {
      var4 = var3;
    }

    var5 = randomint(var4.size);
    scripts\common\anim::anim_single_solo(var0, var4[var5]);
    var3 = scripts\engine\utility::array_add(var3, var4[var5]);
    var4 = scripts\engine\utility::array_remove(var4, var4[var5]);
    waitframe();
  }
}

function stop_random_idles() {
  self notify("stop_idles");
  self.random_idles = undefined;
}