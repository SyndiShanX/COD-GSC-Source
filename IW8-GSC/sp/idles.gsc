/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\idles.gsc
***********************************************/

register_idle_scene(var_0, var_1) {
  level.ambient_idle_scenes[var_0] = var_1;
}

get_idle_scene(var_0) {
  if(!isDefined(level.ambient_idle_scenes) || !isDefined(level.ambient_idle_scenes[var_0]))
    return undefined;

  return level.ambient_idle_scenes[var_0];
}

#using_animtree("generic_human");

play_ambient_idle_scene(var_0, var_1) {
  self.random_ambient_idle_playing = 0;

  if(isai(var_0) && !isDefined(var_0.is_cheap))
    var_0 animmode("noclip");

  wait 0.1;
  var_0 clearanim(%root, 0.0);

  if(isDefined(var_0.is_cheap)) {
    if(isDefined(var_1) && var_1) {
      thread random_idle_scene_controller_simple(var_0);
      thread random_idle_scene_end_cheap(var_0);
    } else {
      thread random_idle_scene_controller(var_0);
      thread random_idle_scene_end_cheap(var_0);
    }
  } else if(isDefined(var_1) && var_1) {
    thread random_idle_scene_controller_simple(var_0);
    thread random_idle_scene_end();
  } else {
    thread random_idle_scene_controller(var_0);
    thread random_idle_scene_end();
  }

  self waittill("ambient_idle_scene_end");
}

play_ambient_idle_scene_single(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(isDefined(self.ambient_idle_anim_node))
    self.ambient_idle_anim_node = scripts\engine\utility::spawn_script_origin();

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.random_ambient_idle_playing = 0;

    if(!var_1 && isai(var_5)) {
      var_5 animmode("noclip");
      var_5 forceteleport(self.origin, self.angles, 100000.0);
      continue;
    }

    var_5.origin = self.origin;
    var_5.angles = self.angles;
  }

  if(var_2) {
    thread random_idle_scene_controller_simple_single(var_0);
    thread random_idle_scene_end_cheap_single(var_0);
  } else {
    thread random_idle_scene_controller_single(var_0);
    thread random_idle_scene_end_cheap_single(var_0);
  }

  self waittill("ambient_idle_scene_end");
}

clear_root() {
  self clearanim(%root, 0.1);
}

random_idle_scene_controller(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level.scr_anim[var_0.animname]["idle_anims"].size;
  var_3 = level.scr_anim[var_0.animname]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\common\notetrack::start_notetrack_wait(var_0, "single anim");
  thread scripts\sp\anim::animscriptdonotetracksthread(var_0, "single anim");

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
    var_6 = level.scr_anim[var_0.animname]["idle_anims"][var_5];
    var_7 = getstartorigin(self.origin, self.angles, var_3);
    var_8 = getstartangles(self.origin, self.angles, var_3);

    if(isDefined(var_0.is_cheap) || !isai(var_0)) {
      var_0.origin = var_7;
      var_0.angles = var_8;
    } else
      var_0 forceteleport(var_7, var_8, 100000.0);

    var_9 = undefined;

    if(isDefined(var_0.anim_getrootfunc))
      var_9 = [[var_0.anim_getrootfunc]]();

    var_10 = getanimlength(var_3);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 animScripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    wait(var_12);

    if(!isDefined(var_0)) {
      return;
    }
    wait_check_player_anim_interference(var_3, var_6[0], var_0);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_3, 0.1);
    var_0 animScripted("single anim", self.origin, self.angles, var_6[0], undefined, undefined, 0.2);
    var_13 = getanimlength(var_6[0]);
    wait(var_13);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[0], 0.1);
    var_0 animScripted("single anim", self.origin, self.angles, var_6[1], undefined, undefined, 0.2);
    var_10 = getanimlength(var_6[1]);
    var_11 = randomintrange(1, 4);
    var_12 = var_10 * float(var_11);
    wait(var_12);

    if(!isDefined(var_0)) {
      return;
    }
    wait_check_player_anim_interference(var_6[1], var_6[2], var_0);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[1], 0.1);
    var_0 animScripted("single anim", self.origin, self.angles, var_6[2], undefined, undefined, 0.2);
    var_14 = getanimlength(var_6[2]);
    wait(var_14);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 clearanim(var_6[2], 0.1);
    waitframe();
  }
}

random_idle_scene_controller_single(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level.scr_anim[var_0[0].animname]["idle_anims"].size;
  var_3 = level.scr_anim[var_0[0].animname]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");

  foreach(var_7 in var_0) {
    if(!isDefined(var_7.animtree))
      var_7 scripts\common\anim::setanimtree();

    thread scripts\common\notetrack::start_notetrack_wait(var_7, "single anim");
    thread scripts\sp\anim::animscriptdonotetracksthread(var_7, "single anim");
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
      var_10 = level.scr_anim[var_7.animname]["idle_anims"][var_5];
      var_12 = getstartorigin(self.origin, self.angles, var_3);
      var_13 = getstartangles(self.origin, self.angles, var_3);
      var_3 = level.scr_anim[var_7.animname]["idle_base"];

      if(isDefined(var_7.is_cheap) || !isai(var_7)) {
        var_7.origin = var_12;
        var_7.angles = var_13;
      } else
        var_7 forceteleport(var_12, var_13, 100000.0);

      var_14 = undefined;

      if(isDefined(var_7.anim_getrootfunc))
        var_14 = [[var_7.anim_getrootfunc]]();

      var_15 = getanimlength(var_3);
      var_16 = randomintrange(1, 4);
      var_9 = var_15 * float(var_16);
      var_7 animScripted("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
    }

    wait(var_9);
    var_18 = [];

    foreach(var_7 in var_0)
    var_18 = scripts\engine\utility::array_add(var_18, level.scr_anim[var_7.animname]["idle_anims"][var_5][0]);

    wait_check_player_anim_interference_group(var_3, var_18, var_0);

    foreach(var_7 in var_0) {
      var_3 = level.scr_anim[var_7.animname]["idle_base"];
      var_10 = level.scr_anim[var_7.animname]["idle_anims"][var_5];
      var_7 clearanim(var_3, 0.1);
      var_7 animScripted("single anim", self.origin, self.angles, var_10[0], undefined, undefined, 0.2);
    }

    var_23 = getanimlength(var_10[0]);
    wait(var_23);

    foreach(var_7 in var_0) {
      var_10 = level.scr_anim[var_7.animname]["idle_anims"][var_5];
      var_7 clearanim(var_10[0], 0.1);
      var_7 animScripted("single anim", self.origin, self.angles, var_10[1], undefined, undefined, 0.2);
    }

    var_15 = getanimlength(var_10[1]);
    var_16 = randomintrange(1, 4);
    var_9 = var_15 * float(var_16);
    wait(var_9);
    var_18 = [];

    foreach(var_7 in var_0)
    var_18 = scripts\engine\utility::array_add(var_18, level.scr_anim[var_7.animname]["idle_anims"][var_5][2]);

    wait_check_player_anim_interference_group(var_10[1], var_18, var_0);

    foreach(var_7 in var_0) {
      var_3 = level.scr_anim[var_7.animname]["idle_base"];
      var_10 = level.scr_anim[var_7.animname]["idle_anims"][var_5];
      var_7 clearanim(var_10[1], 0.1);
      var_7 animScripted("single anim", self.origin, self.angles, var_10[2], undefined, undefined, 0.2);
    }

    var_30 = getanimlength(var_10[2]);
    wait(var_30);

    foreach(var_7 in var_0) {
      var_10 = level.scr_anim[var_7.animname]["idle_anims"][var_5];
      var_7 clearanim(var_10[2], 0.1);
    }

    waitframe();
  }
}

random_idle_scene_end() {
  scripts\asm\asm_sp::asm_stopanimScripted();
  self notify("ambient_idle_scene_end");
}

random_idle_scene_end_single(var_0) {
  foreach(var_2 in var_0) {
    if(isent(var_2)) {
      var_2 scripts\asm\asm_sp::asm_stopanimScripted();
      var_2 notify("ambient_idle_scene_end");
    }
  }
}

random_idle_scene_end_cheap(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  if(isent(var_0))
    var_0 clear_root();

  self notify("ambient_idle_scene_end");
}

random_idle_scene_end_cheap_single(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  foreach(var_2 in var_0) {
    if(isent(var_2))
      var_2 stopanimScripted();
  }

  self notify("ambient_idle_scene_end");
}

random_idle_scene_controller_simple(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level.scr_anim[var_0.animname]["idle_anims"].size;
  var_2 = level.scr_anim[var_0.animname]["idle_base"];
  var_3 = [];
  var_4 = 0;
  self notify("ambient_idle_scene_start");
  thread scripts\common\notetrack::start_notetrack_wait(var_0, "single anim");
  thread scripts\sp\anim::animscriptdonotetracksthread(var_0, "single anim");

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

    var_5 = level.scr_anim[var_0.animname]["idle_anims"][var_4];
    var_6 = getstartorigin(self.origin, self.angles, var_2);
    var_7 = getstartangles(self.origin, self.angles, var_2);

    if(isDefined(var_0.is_cheap) || !isai(var_0)) {
      var_0.origin = var_6;
      var_0.angles = var_7;
    } else
      var_0 forceteleport(var_6, var_7, 100000.0);

    var_8 = undefined;

    if(isDefined(var_0.anim_getrootfunc))
      var_8 = [[var_0.anim_getrootfunc]]();

    var_9 = getanimlength(var_2);
    var_10 = randomintrange(1, 4);
    var_11 = var_9 * float(var_10);
    var_0 animScripted("single anim", self.origin, self.angles, var_2, undefined, undefined, 0.2);
    wait(var_11);
    var_0 clearanim(var_2, 0.1);
    var_0 animScripted("single anim", self.origin, self.angles, var_5, undefined, undefined, 0.2);
    var_12 = getanimlength(var_5);
    wait(var_12);
    var_0 clearanim(var_5, 0.1);
    waitframe();
  }
}

random_idle_scene_controller_simple_single(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level.scr_anim[var_0[0].animname]["idle_anims"].size;
  var_2 = [];
  var_3 = 0;
  var_4 = self;
  self notify("ambient_idle_scene_start");

  foreach(var_6 in var_0) {
    var_7 = level.scr_anim[var_6.animname]["idle_base"];
    var_8 = getstartorigin(self.origin, self.angles, var_7);
    var_9 = getstartangles(self.origin, self.angles, var_7);
    var_6.origin = var_8;
    var_6.angles = var_9;
    thread scripts\common\notetrack::start_notetrack_wait(var_6, "single anim");
    thread scripts\sp\anim::animscriptdonotetracksthread(var_6, "single anim");
    var_10 = undefined;

    if(isDefined(var_6.anim_getrootfunc))
      var_10 = [[var_6.anim_getrootfunc]]();

    var_6 animScripted("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.0);
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
      var_7 = level.scr_anim[var_6.animname]["idle_base"];
      var_8 = getstartorigin(self.origin, self.angles, var_7);
      var_9 = getstartangles(self.origin, self.angles, var_7);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_10 = undefined;

      if(isDefined(var_6.anim_getrootfunc))
        var_10 = [[var_6.anim_getrootfunc]]();

      var_16 = getanimlength(var_7);
      var_13 = var_16;
      var_6 animScripted("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.2);
    }

    wait(var_13);
    var_18 = 0;

    foreach(var_21, var_6 in var_0) {
      var_7 = level.scr_anim[var_6.animname]["idle_base"];
      var_20 = level.scr_anim[var_6.animname]["idle_anims"][var_3];
      var_8 = getstartorigin(self.origin, self.angles, var_20);
      var_9 = getstartangles(self.origin, self.angles, var_20);
      var_6.origin = var_8;
      var_6.angles = var_9;
      var_10 = undefined;

      if(isDefined(var_6.anim_getrootfunc))
        var_10 = [[var_6.anim_getrootfunc]]();

      var_6 animScripted("single anim", self.origin, self.angles, var_20, undefined, var_10, 0.2);
      var_18 = getanimlength(var_20);
    }

    wait(var_18);
  }
}

is_ambient_scene(var_0) {
  return isDefined(level.ambient_idle_scenes) && isDefined(level.ambient_idle_scenes[var_0]);
}

is_ambient_idle_struct(var_0) {
  if(isDefined(var_0.script_noteworthy) && is_ambient_scene(var_0.script_noteworthy))
    return 1;

  return 0;
}

wait_check_player_anim_interference(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_2 endon("death");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = length2d(level.player.origin - var_2.origin);
  var_4 = length2d(level.player.origin - var_2 scripts\anim\utility.gsc::getanimendpos(var_1));
  var_5 = float(getDvar("NSRPQNLSNK")) * 0.25;

  for(;;) {
    if(var_3 / var_5 > getanimlength(var_1) && var_4 / var_5 > getanimlength(var_1)) {
      break;
    }

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = length2d(level.player.origin - var_2.origin);
    var_4 = length2d(level.player.origin - var_2 scripts\anim\utility.gsc::getanimendpos(var_1));
    var_5 = float(getDvar("NSRPQNLSNK")) * 0.25;
    var_6 = getanimlength(var_0);
    wait(var_6);
  }
}

wait_check_player_anim_interference_group(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = float(getDvar("NSRPQNLSNK")) * 0.25;

  for(;;) {
    var_6 = 0;

    for(var_7 = 0; var_7 < var_2.size; var_7++) {
      var_8 = var_2[var_7];
      var_3 = length2d(level.player.origin - var_8.origin);
      var_4 = length2d(level.player.origin - var_8 scripts\anim\utility.gsc::getanimendpos(var_1[var_7]));
      var_5 = float(getDvar("NSRPQNLSNK")) * 0.25;

      if(var_3 / var_5 > getanimlength(var_1[var_7]) && var_4 / var_5 > getanimlength(var_1[var_7]))
        var_6++;
    }

    if(var_6 >= var_2.size) {
      break;
    }

    var_9 = getanimlength(var_0);
    wait(var_9);
  }
}

play_random_idles(var_0, var_1, var_2) {
  self endon("stop_idles");
  self endon("death");
  var_0 endon("death");
  var_3 = [];
  var_4 = var_2;
  var_5 = undefined;
  var_0.random_idles = 1;

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, var_1);

    if(var_4.size < 1)
      var_4 = var_3;

    var_5 = randomint(var_4.size);
    scripts\common\anim::anim_single_solo(var_0, var_4[var_5]);
    var_3 = scripts\engine\utility::array_add(var_3, var_4[var_5]);
    var_4 = scripts\engine\utility::array_remove(var_4, var_4[var_5]);
    waitframe();
  }
}

stop_random_idles() {
  self notify("stop_idles");
  self.random_idles = undefined;
}