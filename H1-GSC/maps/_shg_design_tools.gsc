/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_shg_design_tools.gsc
********************************/

anim_simple(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
      var_1 = var_3.animation;
      var_3 thread identify_and_play_anim(var_1, self);
    }
  } else {
    if(!isdefined(var_1))
      var_1 = var_0.animation;

    var_0 identify_and_play_anim(var_1, self);
  }
}

identify_and_play_anim(var_0, var_1) {
  self endon("death");

  if(!isdefined(self)) {
    return;
  }
  if(isanimloop(var_0)) {
    if(isalive(self) && self._id_5680 == "generic")
      var_1 maps\_anim::anim_generic_loop(self, var_0, "stop_loop");
    else if(isalive(self))
      var_1 maps\_anim::anim_loop_solo(self, var_0, "stop_loop");
  } else if(isalive(self) && isdefined(self.animname) && self.animname != "generic")
    var_1 maps\_anim::anim_single_solo(self, var_0);
  else if(isalive(self))
    var_1 maps\_anim::anim_generic(self, var_0);

  self notify("anim_simple_done", var_0);
}

isanimloop(var_0) {
  if(isanimloop_animname(var_0, "generic"))
    return 1;
  else if(isdefined(self.animname) && isanimloop_animname(var_0, self.animname))
    return 1;

  return 0;
}

isanimloop_animname(var_0, var_1) {
  if(isarray(level.scr_anim[var_1])) {
    if(isarray(level.scr_anim[var_1][var_0])) {
      if(isdefined(level.scr_anim[var_1][var_0][0])) {
        self._id_5680 = var_1;
        return 1;
      }
    }
  }

  return 0;
}

notify_on_death(var_0, var_1) {
  if(!isdefined(var_0)) {
    level notify(var_1);
    return;
  }

  if(isarray(var_0)) {
    while (isdefined(var_0) && var_0.size > 0) {
      var_0 = maps\_utility::array_removedead_or_dying(var_0);
      var_0 = common_scripts\utility::array_removeundefined(var_0);
      waitframe();
    }
  } else
    var_0 waittill("death");

  level notify(var_1);
}

gravity_drop(var_0, var_1, var_2) {
  var_3 = gettime() * 0.001;

  while (self.origin[2] > var_1[2]) {
    var_4 = var_2 * 0.5;
    var_5 = 1 * var_4 / 2;
    var_6 = gettime() * 0.001 - var_3;
    self.origin = self.origin + (0, 0, var_5 * var_6 - 0.5 * var_4 * squared(var_6));
    waitframe();
  }
}

gravity_point(var_0, var_1, var_2) {
  var_3 = var_2 * 0.5;
  var_4 = 1;
  var_5 = gettime() * 0.001 - var_0;
  var_6 = var_4 * var_5 - 0.5 * var_3 * squared(var_5);
  return (0, 0, var_6);
}

gravity_arc(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = gettime() * 0.001;

  if(isdefined(self) && !isdefined(self.apex))
    self.apex = 0;

  while (isdefined(self) && gettime() * 0.001 <= var_5 + var_2) {
    self.last_z = self.origin[2];
    self.origin = arc_point(var_5, var_0, var_1, var_2, var_3, var_4);

    if(self.origin[2] < self.last_z)
      self.apex = 1;

    wait 0.05;
  }

  self notify("item_landed");
}

arc_point(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_4))
    var_4 = 386;

  if(!isdefined(var_5))
    var_5 = 386;

  var_7 = var_4;

  if(self.apex)
    var_7 = var_5;

  var_8 = var_7 * 0.5;
  var_6 = var_3 * var_8 / 2;
  var_9 = gettime() * 0.001 - var_0;
  var_10 = var_6 * var_9 - 0.5 * var_8 * squared(var_9);
  var_11 = maps\_utility::linear_interpolate(var_9 / var_3, var_1, var_2) + (0, 0, var_10);
  return var_11;
}

anim_stop(var_0, var_1, var_2) {
  if(isdefined(var_0))
    var_0 maps\_utility::anim_stopanimscripted();

  maps\_utility::anim_stopanimscripted();

  if(isdefined(var_0))
    var_0 notify("stop_first_frame");

  self notify("stop_first_frame");

  if(isdefined(var_2) && var_2 && isdefined(var_0))
    var_0 delete();
}

end_anim_loop(var_0) {
  if(!isdefined(var_0))
    var_0 = [self];

  foreach(var_2 in var_0) {
    if(isdefined(var_2.loops) && var_2.loops > 0)
      var_2.loops = 0;

    if(isdefined(var_2.loopanims) && var_2.loopanims.size > 0)
      var_2.loopanims = [];
  }
}

remove_hint() {
  if(isdefined(level.current_hint))
    level.current_hint destroy();
}

hide_display_hint() {
  if(isdefined(level.current_hint))
    level.current_hint.alpha = 0;
}

anim_simple_notify(var_0, var_1, var_2) {
  level waittill(var_2);

  if(isdefined(var_0.animname) && var_0.animname != "generic")
    var_0 maps\_anim::setanimtree();

  anim_simple(var_0, var_1);
}

isvehiclealive(var_0) {
  if(!isdefined(var_0))
    return 0;

  if(var_0.health < 1)
    return 0;

  return 1;
}

white_out(var_0, var_1, var_2) {
  var_3 = self;

  if(!isplayer(var_3))
    var_3 = level.player;

  if(!isdefined(var_2))
    var_2 = 1;

  var_4 = newclienthudelem(var_3);
  var_4 setshader("white", 1280, 720);
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = var_2;
  wait(var_0);
  var_4 fadeovertime(var_1);
  var_4.alpha = 0;
}

fade_to_black(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isplayer(var_4))
    var_4 = level.player;

  var_4.auxillary_hud = newclienthudelem(var_4);
  var_4.auxillary_hud setshader("black", 1280, 720);
  var_4.auxillary_hud.horzalign = "fullscreen";
  var_4.auxillary_hud.vertalign = "fullscreen";
  var_4.auxillary_hud.alpha = var_2;
  wait(var_0);
  var_4.auxillary_hud fadeovertime(var_1);
  var_4.auxillary_hud.alpha = var_3;
}

create_pulsing_text(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(issplitscreen())
    var_0 = var_0 + 2;

  var_7 = undefined;

  if(isdefined(var_3))
    var_7 = get_pulsing_hud(-60, undefined, var_3, 1, var_4, var_5);
  else
    var_7 = get_pulsing_hud(-60, undefined, undefined, 1, var_4, var_5);

  var_8 = var_7 huddata(var_0, var_1);
  var_8.label = var_2;
  return var_8;
}

get_pulsing_hud(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_6 = undefined;

  if(!level.console)
    var_6 = -250;
  else if(!isdefined(var_0))
    var_6 = -225;
  else
    var_6 = var_0;

  if(var_3)
    var_6 = var_0;

  if(!isdefined(var_1))
    var_7 = 100;
  else
    var_7 = var_1;

  if(isdefined(var_2))
    var_8 = newclienthudelem(var_2);
  else
    var_8 = newhudelem();

  if(!isdefined(var_4))
    var_4 = (0.8, 1, 0.8);

  if(!isdefined(var_5))
    var_5 = (0.3, 0.6, 0.3);

  var_8.alignx = "left";
  var_8.aligny = "middle";
  var_8.horzalign = "right";
  var_8.vertalign = "top";
  var_8.x = var_6;
  var_8.y = var_7;
  var_8.fontscale = 1.6;
  var_8.color = var_4;
  var_8.font = "objective";
  var_8.glowcolor = var_5;
  var_8.glowalpha = 1;
  var_8.foreground = 1;
  var_8.hidewheninmenu = 0;
  var_8.hidewhendead = 1;
  return var_8;
}

huddata(var_0, var_1) {
  self.alignx = "center";
  self.aligny = "top";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.x = var_1;
  self.y = -160 + 15 * var_0;
  self.font = "objective";
  self.foreground = 1;
  self.hidewheninmenu = 1;
  self.hidewhendead = 1;
  self.sort = 2;
  self.fontscale = 1.15;
  return self;
}

spawn_tag_origin_monitor(var_0) {
  if(!isdefined(level.monitored_tag_origins))
    level.monitored_tag_origins = [];

  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 angles_and_origin(self);

  if(isdefined(var_0))
    var_1.tag_idx = var_0;

  level.monitored_tag_origins[level.monitored_tag_origins.size] = var_1;
  level.monitored_tag_origins = common_scripts\utility::array_removeundefined(level.monitored_tag_origins);
  iprintln(level.monitored_tag_origins.size);
  return var_1;
}

remove_monitored_tags(var_0) {
  if(isdefined(level.monitored_tag_origins)) {
    var_1 = 0;

    foreach(var_3 in level.monitored_tag_origins) {
      if(isdefined(var_3.tag_idx) && var_3.tag_idx == var_0) {
        var_3 delete();
        var_1++;
      }
    }

    iprintln(var_1);
  }
}

angles_and_origin(var_0) {
  if(isdefined(var_0.origin))
    self.origin = var_0.origin;

  if(isdefined(var_0.angles))
    self.angles = var_0.angles;
}

array_combine_multiple(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = common_scripts\utility::array_combine(var_0, var_1);

  if(isdefined(var_2))
    var_9 = common_scripts\utility::array_combine(var_9, var_2);

  if(isdefined(var_3))
    var_9 = common_scripts\utility::array_combine(var_9, var_3);

  if(isdefined(var_4))
    var_9 = common_scripts\utility::array_combine(var_9, var_4);

  if(isdefined(var_5))
    var_9 = common_scripts\utility::array_combine(var_9, var_5);

  if(isdefined(var_6))
    var_9 = common_scripts\utility::array_combine(var_9, var_6);

  if(isdefined(var_7))
    var_9 = common_scripts\utility::array_combine(var_9, var_7);

  if(isdefined(var_8))
    var_9 = common_scripts\utility::array_combine(var_9, var_8);

  return var_9;
}

lerp_to_position(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = distance(var_0, self.origin);
  var_5 = 0;
  var_6 = self.origin;

  while (var_5 < var_4) {
    var_7 = getlerpfraction(self.origin, var_0, var_1, var_2);

    if(var_7 == 0) {
      break;
    }

    self.origin = vectorlerp(self.origin, var_0, var_7);

    if(isdefined(var_3))
      self.angles = self.angles + var_3;

    var_5 = distance(self.origin, var_6);
    waitframe();
  }

  self notify("lerp_complete");
}

getlerpfraction(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0, var_1);

  if(var_2 == 0 || var_4 == 0)
    return 0;

  var_5 = var_2 / var_4 * 0.05;

  if(var_5 > 0)
    return var_5;
  else
    return 0;
}

getperlinovertime(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_3))
    var_3 = 1;

  if(!isdefined(var_4)) {
    var_5 = 10;
    var_6 = 20;
    var_7 = 30;
  } else {
    var_5 = var_4;
    var_6 = var_4 + 10;
    var_7 = var_4 + 20;
  }

  var_8 = (perlinnoise2d(gettime() * 0.001 * 0.05, var_5, var_0, var_1, var_2) * var_3, perlinnoise2d(gettime() * 0.001 * 0.05, var_6, var_0, var_1, var_2) * var_3, perlinnoise2d(gettime() * 0.001 * 0.05, var_7, var_0, var_1, var_2) * var_3);
  return var_8;
}

angles_origin(var_0) {
  if(isdefined(var_0.origin))
    self.origin = var_0.origin;

  if(isdefined(var_0.angles))
    self.angles = var_0.angles;
}

delete_at_goal() {
  self waittill("goal");
  self delete();
}

delete_auto() {
  if(!isdefined(self)) {
    return;
  }
  self delete();
}

percentchance(var_0) {
  if(randomint(100) <= var_0)
    return 1;

  return 0;
}

actual_spawn(var_0) {
  if(!isdefined(self.count) || self.count < 1)
    self.count = 1;

  var_1 = maps\_utility::spawn_ai(1);
  maps\_utility::spawn_failed(var_1);

  if(isdefined(var_0)) {
    while (!isdefined(var_1)) {
      self.count = 1;
      var_1 = maps\_utility::spawn_ai(1);
      maps\_utility::spawn_failed(var_1);
      waitframe();
    }
  }

  return var_1;
}

spawn_enemy_group(var_0, var_1, var_2) {
  if(isarray(var_1))
    var_3 = var_1;
  else
    var_3[0] = var_1;

  var_4 = [];

  for (var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = common_scripts\utility::random(var_3);
    var_7 = var_6 actual_spawn();

    if(!isdefined(var_7)) {
      continue;
    }
    if(isdefined(var_2))
      var_7 setgoalvolumeauto(var_2);

    var_4[var_4.size] = var_7;
    wait 0.1;
  }

  return var_4;
}

trigger_to_notify(var_0, var_1) {
  waittill_trigger_with_name(var_0);

  if(!isdefined(var_1))
    var_1 = var_0;

  level notify(var_1);
}

stopfxonnotify(var_0, var_1, var_2, var_3) {
  self waittill(var_3);

  if(isdefined(var_1))
    stopfxontag(var_0, var_1, var_2);
}

stopfxontagdelay(var_0, var_1, var_2, var_3) {
  wait(var_3);

  if(isdefined(var_1))
    stopfxontag(var_0, var_1, var_2);
}

waittill_trigger_with_name(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isdefined(var_1))
    var_1 = getent(var_0, "script_noteworthy");

  if(!isdefined(var_1)) {
    return;
  }
  var_1 waittill("trigger");
}

impulse_wave(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 300;

  var_4 = [];

  foreach(var_6 in var_0) {
    if(distance(var_6.origin, var_2) < var_1)
      var_4[var_4.size] = var_6;
  }

  if(var_4.size <= 0) {
    return;
  }
  var_4 = sortbydistance(var_4, var_2);
  var_8 = var_2;

  foreach(var_6 in var_4) {
    if(!isdefined(var_6)) {
      continue;
    }
    if(var_6 maps\_vehicle::isvehicle()) {
      var_6 dodamage(var_6.health * 2, var_2);
      continue;
    }

    var_10 = distance(var_8, var_6.origin);
    var_11 = var_10 / var_3 * 0.05;
    wait(var_11);
    var_8 = var_6.origin;
    var_12 = vectornormalize(var_6 gettagorigin("tag_eye") - var_2);
    var_12 = vectornormalize(var_12 + (0, 0, 0.2));
    var_6 startragdollfromimpact("torso_lower", var_12 * 7000);
    var_6 thread common_scripts\utility::delaycall(2, ::kill);
  }
}

sortbydistanceauto(var_0, var_1) {
  return sortbydistance(var_0, var_1, 0, 1);
}

set_entflag_on_notify(var_0) {
  if(!maps\_utility::ent_flag_exist(var_0))
    maps\_utility::ent_flag_init(var_0);

  self waittill(var_0);
  maps\_utility::ent_flag(var_0);
}

trigger_to_flag(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_1))
    common_scripts\utility::flag_init(var_1);

  var_2 = getentarray(var_0, "targetname");
  var_2[0] waittill("trigger");
  common_scripts\utility::flag_set(var_1);
}

flag_wait_either_timeout(var_0, var_1) {
  var_2 = randomfloat(1000.0);
  var_3 = "flag_or_timeout" + var_2;
  level endon(var_3);
  level thread maps\_utility::notify_delay(var_3, var_1);
  common_scripts\utility::flag_wait(var_0);
}

killonbadpath() {
  self endon("death");
  self waittill("bad_path");

  if(!isdefined(self.deletable_magic_bullet_shield) || !self.deletable_magic_bullet_shield)
    self kill();
}

offset_position_from_tag(var_0, var_1, var_2) {
  var_3 = self gettagangles(var_1);
  var_4 = self gettagorigin(var_1);

  if(var_0 == "up")
    return var_4 + anglestoup(var_3) * var_2;

  if(var_0 == "down")
    return var_4 + anglestoup(var_3) * (var_2 * -1);

  if(var_0 == "right")
    return var_4 + anglestoright(var_3) * var_2;

  if(var_0 == "left")
    return var_4 + anglestoright(var_3) * (var_2 * -1);

  if(var_0 == "forward")
    return var_4 + anglestoforward(var_3) * var_2;

  if(var_0 == "backward")
    return var_4 + anglestoforward(var_3) * (var_2 * -1);

  if(var_0 == "backwardright") {
    var_4 = var_4 + anglestoright(var_3) * var_2;
    return var_4 + anglestoforward(var_3) * (var_2 * -1);
  }

  if(var_0 == "backwardleft") {
    var_4 = var_4 + anglestoright(var_3) * (var_2 * -1);
    return var_4 + anglestoforward(var_3) * (var_2 * -1);
  }

  if(var_0 == "forwardright") {
    var_4 = var_4 + anglestoright(var_3) * (var_2 * 1);
    return var_4 + anglestoforward(var_3) * var_2;
  }

  if(var_0 == "forwardleft") {
    var_4 = var_4 + anglestoright(var_3) * (var_2 * -1);
    return var_4 + anglestoforward(var_3) * var_2;
  }
}

getclosestauto(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 500000;

  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!isdefined(var_5)) {
      continue;
    }
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

getthing(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  var_2 = common_scripts\utility::getstruct(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  var_2 = getnode(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  var_2 = getvehiclenode(var_0, var_1);

  if(isdefined(var_2))
    return var_2;
}

getthingarray(var_0, var_1) {
  var_2 = getentarray(var_0, var_1);

  if(var_2.size > 0)
    return var_2;

  var_2 = common_scripts\utility::getstructarray(var_0, var_1);

  if(var_2.size > 0)
    return var_2;

  var_2 = getnodearray(var_0, var_1);

  if(var_2.size > 0)
    return var_2;

  var_2 = getvehiclenodearray(var_0, var_1);

  if(var_2.size > 0)
    return var_2;
}

make_deaddrone(var_0) {
  var_1 = maps\_spawner::spawner_dronespawn(var_0);
  var_1.animname = "generic";
  var_1 maps\_utility::gun_remove();
  return var_1;
}

iprintlnsubtitles(var_0, var_1) {
  if(!isdefined(level.player.subtitles)) {
    level.player.subtitles = [];
    level.subtitle_entry_num = 0;
  }

  var_2 = newclienthudelem(level.player);
  var_2.x = 320;
  var_2.y = 325;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.fontscale = 1.5;
  var_2 settext(var_0);
  var_2.alpha = 0;
  var_2.color = (1, 1, 1);
  var_2.glowcolor = (0.6, 0.6, 0.9);
  var_2.glowalpha = 0.4;
  var_2.sort = -10;
  var_2.font = "objective";
  level.player.subtitles[level.player.subtitles.size] = var_2;
  level notify("new_subtitle_created");
  level.player thread delete_subtitle_in(10, var_2, level.subtitle_entry_num);
  level.player thread show_subtitles(var_2, level.subtitle_entry_num);
  level.subtitle_entry_num = (level.subtitle_entry_num + 1) % 10;

  if(isdefined(var_1))
    wait(var_1);
}

show_subtitles(var_0, var_1) {
  var_2 = "delete_subtitle_hud" + var_1;
  var_3 = 0;
  var_4 = 19;
  var_0 fadeovertime(0.5);
  var_0.alpha = 1;
  level endon(var_2);

  while (isdefined(var_0)) {
    level waittill("new_subtitle_created");
    var_3++;

    if(!isdefined(var_0)) {
      break;
    }

    var_0 moveovertime(0.35);
    var_0.y = 325 + var_3 * var_4;
    var_0.color = (1, 1, 1);
    var_0.glowalpha = 0;
    var_0.alpha = 0.9 - var_3 / 5;
    waitframe();
  }
}

delete_subtitle_in(var_0, var_1, var_2) {
  var_3 = "delete_subtitle_hud" + var_2;
  level thread maps\_utility::notify_delay(var_3, var_0);
  level waittill(var_3);
  self.subtitles = common_scripts\utility::array_remove(self.subtitles, var_1);
  var_1 destroy();
}

convert_8bit_color(var_0) {
  return var_0 / 255;
}

get_standard_glow_text(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_0;
  var_11 = var_5 * var_2 + var_1;

  if(!isdefined(var_6))
    var_6 = (0.8, 1, 0.8);

  if(!isdefined(var_7))
    var_7 = (var_6[0] / 2, var_6[1] / 2, var_6[2] / 2);

  if(!isdefined(var_3))
    var_3 = "center";

  if(!isdefined(var_4))
    var_4 = "middle";

  if(!isdefined(var_8))
    var_8 = "center";

  if(!isdefined(var_9))
    var_9 = "middle";

  var_12 = newclienthudelem(level.player);
  var_12.alignx = var_3;
  var_12.aligny = var_4;
  var_12.horzalign = var_8;
  var_12.vertalign = var_9;
  var_12.x = var_10;
  var_12.y = var_11;
  var_12.fontscale = 1.6;
  var_12.color = var_6;
  var_12.font = "objective";
  var_12.glowcolor = var_7;
  var_12.glowalpha = 1;
  var_12.foreground = 1;
  var_12.hidewheninmenu = 1;
  var_12.hidewhendead = 1;
  return var_12;
}

notify_relay(var_0, var_1, var_2, var_3) {
  var_0 waittill(var_1);
  var_2 notify(var_3);
}