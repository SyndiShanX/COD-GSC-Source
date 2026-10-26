/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_firingrange.gsc
**************************************************/

init_firingrange() {
  var_0 = spawnStruct();
  var_0.fr_start = _getEnt("firingrange_start", "targetname");
  var_0._id_0C3A = firing_range_setup_targets();
  var_0._id_0BDC = firing_range_setup_env();
  var_0.transitionmeshes = [];
  var_0.transitionmeshesrev = [];
  var_0._id_0C3B = firing_range_setup_triggers();
  var_0._id_0C39 = firing_range_setup_min_range();
  var_0._id_0C38 = firing_range_setup_max_range();
  var_0._id_0BDA = firing_range_setup_booth_displays();
  var_0._id_0C37 = firing_range_setup_target_logic();
  var_0._id_0BE1 = firing_range_setup_floor_panels();
  var_0._id_0C3C = firing_range_setup_env_vfx();
  var_0._id_0BD8 = firing_range_setup_3dui_screens();
  var_0.audio_buzzer_struct = common_scripts\utility::getstruct("audio_buzzer_org", "targetname");
  var_0.soundents = [];
  var_0.last_target = undefined;
  var_0.target_move_dist = 32;
  var_0.target_units_per_second = 256;
  var_0.pressedup = 0;
  var_0.presseddown = 0;
  var_0.roundnumber = undefined;
  var_0.minpoint = undefined;
  var_0.minpointmodpos = undefined;
  var_0.maxpoint = undefined;
  var_0.buttontimertotal = 0.55;
  var_0.buttontimer = 0;
  var_0.gracedisance = 24;
  var_0.damagedone = 0;
  var_0.rangeinmeters = 0;
  var_0.shotsfired = 0;
  var_0.shotshit = 0;
  var_0.percent = 0;
  var_0.shouldupdateluadisplay = 0;
  var_0.round_target_unit_per_second = 176;
  var_0.time = 0;
  var_0.groupdevider = 5;
  var_0.roundactive = 0;
  var_0.isshuttingdown = 0;
  var_0.vfxtargetspawn = loadfx("vfx/props/holo_target_red_spawn_in");
  var_0.vfxtargetspawnout = loadfx("vfx/props/holo_target_red_spawn_out");
  var_0.vfxholoedge = loadfx("vfx/beam/firing_range_edge_glow");
  common_scripts\utility::_id_0FB2(var_0._id_0C3B, ::trigger_setup);
  level.target_center_off = (1.3, 0, 25);
  level.target_radius = 12;
  level.hit_off = 18;
  level.firingrange = var_0;
}

firing_range_setup_floor_panels() {
  var_0 = getEntArray("holo_emitter_floor", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_position = var_2.origin;
    var_2.up_position = var_2.origin + (0, 0, 4);
  }

  return var_0;
}

firing_range_setup_3dui_screens() {
  var_0 = getEntArray("display_3dui_mesh", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  return var_0;
}

firing_range_setup_min_range() {
  var_0 = common_scripts\utility::getstructarray("target_track_min", "targetname");
  return var_0;
}

firing_range_setup_max_range() {
  var_0 = common_scripts\utility::getstructarray("target_track_max", "targetname");
  return var_0;
}

firing_range_setup_booth_displays() {
  var_0 = common_scripts\utility::getstructarray("booth_display_01", "targetname");
  var_1 = common_scripts\utility::getstructarray("booth_display_02", "targetname");
  var_2 = common_scripts\utility::getstructarray("booth_display_03", "targetname");
  var_3 = common_scripts\utility::getstructarray("booth_display_04", "targetname");
  var_4 = common_scripts\utility::getstructarray("booth_display_05", "targetname");
  var_5 = common_scripts\utility::getstructarray("booth_display_06", "targetname");
  var_6 = [var_0, var_1, var_2, var_3, var_4, var_5];
  return var_6;
}

trigger_setup() {
  var_0 = self;
  var_0 thread _id_0478::triggertouchthink(::player_enter_round_trigger, ::player_leave_round_trigger);
}

player_enter_round_trigger(var_0) {
  level endon("shutdown_hologram");

  while(level.firingrange.isshuttingdown == 1) {
    wait 0.1;
  }

  var_1 = self;

  if(!isDefined(var_0.setmovespeedscale)) {
    return;
  }
  var_2 = int(var_0.setmovespeedscale);
  level.firingrange.roundnumber = var_2;

  if(!isDefined(level.firingrange._id_0BDC[var_2])) {
    return;
  }
  var_1 thread startround(var_2);
}

player_leave_round_trigger(var_0) {
  var_1 = self;

  if(!isDefined(var_0.setmovespeedscale)) {
    return;
  }
  var_2 = int(var_0.setmovespeedscale);
  level.firingrange.roundnumber = var_2;

  if(!isDefined(level.firingrange._id_0BDC[var_2])) {
    return;
  }
  var_1 thread _id_72DE(var_2);
}

_id_72DE(var_0) {
  level endon("shutdown_hologram");
  var_1 = _getEnt("firing_range_round_trigger_end", "targetname");
  var_1 waittill("trigger");
  level.firingrange.inuse = 0;
  thread shutdownround(var_0, self);
}

_id_8DA3(var_0, var_1, var_2, var_3) {
  _id_046C::snd_play_linked(var_0, var_1, var_2, var_3);
}

targetspreadshooting(var_0) {
  level endon("shutdown_hologram");
  var_1 = self;
  var_2 = level.firingrange._id_0C3A[var_0][0][0];
  var_2._id_0BC0 = 1;
  var_2 spawntarget();
  var_2 show();
  var_2 solid();
  var_2 setCanDamage(1);
  var_2 setdamagecallbackon(1);
  var_2.damagecallback = ::monitordamagecallback;
  var_2.health = 9999;
  var_2.maxhealth = 9999;

  foreach(var_4 in level.firingrange._id_0C39) {
    if(var_4.setmovespeedscale == level.firingrange.roundnumber) {
      level.firingrange.minpoint = var_4;
      break;
    }
  }

  foreach(var_4 in level.firingrange._id_0C38) {
    if(var_4.setmovespeedscale == level.firingrange.roundnumber) {
      level.firingrange.maxpoint = var_4;
      break;
    }
  }

  if(!isDefined(level.firingrange.minpoint) || !isDefined(level.firingrange.maxpoint)) {
    thread shutdownround(var_0, var_1);
    return;
  }

  level.firingrange.minpointmodpos = level.firingrange.minpoint.origin + anglesToForward(level.firingrange.minpoint.angles) * -64;
  var_2 thread monitordistance(var_1, var_2, level.firingrange.minpoint);
  thread monitorshotsfired(var_1);
  thread monitorgrenades(var_1);
  thread monitorhitpercent(var_1);
  thread displayboothholo(var_1, var_0);
  var_1 thread notifytracker(var_2);
}

monitordistance(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  self endon("death");
  var_3 = 0.0254;

  for(;;) {
    if(!isDefined(var_1) || !isDefined(var_2)) {
      level.firingrange.rangeinmeters = 0;
      var_0 setclientomnvar("ui_vlobby_round_distance", level.firingrange.rangeinmeters);
    } else {
      var_4 = _distance2d(var_1.origin, var_2.origin);
      var_5 = int(common_scripts\utility::_id_7F03(var_3 * var_4, 0));

      if(var_5 != level.firingrange.rangeinmeters) {
        if(var_5 > 100) {
          var_5 = 100;
        } else if(var_5 < 0) {
          var_5 = 0;
        }

        level.firingrange.rangeinmeters = var_5;
        var_0 setclientomnvar("ui_vlobby_round_distance", level.firingrange.rangeinmeters);
      }
    }

    waitframe();
  }
}

notifytracker(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  self notifyonplayercommand("toggled_up_pressed", "+actionslot 1");
  self notifyonplayercommand("toggled_up_released", "-actionslot 1");
  self notifyonplayercommand("toggled_down_pressed", "+actionslot 2");
  self notifyonplayercommand("toggled_down_released", "-actionslot 2");
  thread monitoruppressed(var_0);
  thread monitorupreleased(var_0);
  thread monitordownpressed(var_0);
  thread monitordownreleased(var_0);
  thread movestopper(var_0, self);
}

monitoruppressed(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_up_pressed");
    level.firingrange.buttontimer = level.firingrange.buttontimertotal;

    if(level.firingrange.pressedup == 0) {
      level.firingrange.pressedup = 1;
      level.firingrange.presseddown = 0;
      thread movelogic(level.firingrange.maxpoint.origin, var_0, self);
    }
  }
}

monitorupreleased(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_up_released");
    var_1 = _distance2d(level.firingrange.maxpoint.origin, var_0.origin);

    if(var_1 <= 1) {
      var_0 moveTo(var_0.origin, 0.05);
    } else {
      var_2 = var_0.origin + anglesToForward(level.firingrange._id_0C38[0].angles) * level.firingrange.gracedisance * -1;
      var_1 = _distance2d(var_2, var_0.origin);
      var_3 = var_1 / level.firingrange.target_units_per_second;

      if(var_3 < 0.05) {
        var_3 = 0.05;
      }

      level.firingrange.buttontimer = var_3 + 0.05;
      thread movelogic(var_2, var_0, self);
    }

    var_0 waittill("movedone");
    level.firingrange.pressedup = 0;
  }
}

monitordownpressed(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_down_pressed");
    level.firingrange.buttontimer = level.firingrange.buttontimertotal;

    if(level.firingrange.presseddown == 0) {
      level.firingrange.presseddown = 1;
      level.firingrange.pressedup = 0;
      thread movelogic(level.firingrange.minpointmodpos, var_0, self);
    }
  }
}

monitordownreleased(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_down_released");
    var_1 = _distance2d(level.firingrange.minpointmodpos, var_0.origin);

    if(var_1 <= 1) {
      var_0 moveTo(var_0.origin, 0.05);
    } else {
      var_2 = var_0.origin + anglesToForward(level.firingrange._id_0C38[0].angles) * level.firingrange.gracedisance;
      var_1 = _distance2d(var_2, var_0.origin);
      var_3 = var_1 / level.firingrange.target_units_per_second;

      if(var_3 < 0.05) {
        var_3 = 0.05;
      }

      level.firingrange.buttontimer = var_3 + 0.05;
      thread movelogic(var_2, var_0, self);
    }

    var_0 waittill("movedone");
    level.firingrange.presseddown = 0;
  }
}

movelogic(var_0, var_1, var_2) {
  var_3 = _distance2d(var_0, var_1.origin);

  if(var_3 <= 1) {
    var_1 notify("movedone");
    return;
  } else {
    var_4 = var_3 / level.firingrange.target_units_per_second;

    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    var_1 moveTo(var_0, var_4);
  }
}

movestopper(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    waitframe();

    if(level.firingrange.presseddown == 1 || level.firingrange.pressedup == 1) {
      if(level.firingrange.buttontimer > 0) {
        level.firingrange.buttontimer = level.firingrange.buttontimer - 0.05;
        continue;
      }

      var_0 moveTo(var_0.origin, 0.05);
      level.firingrange.presseddown = 0;
      level.firingrange.pressedup = 0;
    }
  }
}

monitordamage(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  var_1 = undefined;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(level.firingrange.roundnumber == 7) {
      self.health = self.maxhealth;
    }

    var_11 = self gettagorigin("tag_chest");
    var_0 playlocalsound("mp_hit_default");
    var_12 = getmodifier(var_10, var_8, var_0);
    var_1 = common_scripts\utility::_id_7F03(_float(var_1) * var_12, 0);
    var_1 = int(var_1);

    if(var_1 > 999) {
      var_1 = 999;
    }

    if(var_1 < 0) {
      var_1 = 0;
    }

    level.firingrange.damagedone = var_1;
    var_13 = level.firingrange.shotshit + 1;

    if(var_13 > 9999) {
      level.firingrange.shotshit = 0;
    } else if(var_13 < 0) {
      level.firingrange.shotshit = 0;
    } else {
      level.firingrange.shotshit = var_13;
    }

    level.firingrange.shouldupdateluadisplay = 1;
  }
}

monitordamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self)) {
    return;
  }
  if(level.firingrange.roundnumber == 7) {
    self.health = self.maxhealth;
  }

  var_12 = self gettagorigin("tag_chest");
  var_1 playlocalsound("mp_hit_default");
  var_13 = 1;

  if(isDefined(var_1)) {
    var_13 = getmodifier(var_5, var_11, var_1);
  }

  var_2 = common_scripts\utility::_id_7F03(_float(var_2) * var_13, 0);
  var_2 = int(var_2);

  if(var_2 > 999) {
    var_2 = 999;
  }

  if(var_2 < 0) {
    var_2 = 0;
  }

  level.firingrange.damagedone = var_2;

  if(isDefined(var_1)) {
    if(isDefined(var_0) && var_0 != var_1) {
      if(!isDefined(var_0.damage_counted)) {
        var_0.damage_counted = 1;
        var_14 = level.firingrange.shotshit + 1;

        if(var_14 > 9999) {
          level.firingrange.shotshit = 0;
        } else if(var_14 < 0) {
          level.firingrange.shotshit = 0;
        } else {
          level.firingrange.shotshit = var_14;
        }

        level.firingrange.shouldupdateluadisplay = 1;
      }
    } else
      var_1 thread countdamagingshots();
  }

  level.firingrange.shouldupdateluadisplay = 1;
}

countdamagingshots() {
  level endon("shutdown_hologram");
  self endon("disconnect");

  if(!isDefined(self.damagingshot)) {
    self.damagingshot = 1;
  } else {
    self.damagingshot++;
  }
}

getmodifier(var_0, var_1, var_2) {
  var_3 = "none";
  var_4 = 1;
  var_5 = strtok(var_0, "_");
  var_6 = var_5[0];

  if(var_0 != "specialty_null" && var_0 != "none" && var_0 != "combatknife_mp") {
    if(maps\mp\gametypes\_class::isvalidprimary(var_6) || maps\mp\gametypes\_class::isvalidsecondary(var_6, 0)) {
      if(var_1 == "tag_head") {
        var_3 = "head";
      } else if(var_1 == "tag_chest") {
        var_3 = "torso_upper";
      } else if(var_1 == "tag_arms") {
        var_3 = "right_arm_upper";
      } else if(var_1 == "tag_legs") {
        var_3 = "torso_lower";
      } else {
        var_3 = "none";
      }

      var_4 = var_2 getweapondamagelocationmultiplier(var_6 + "_mp", var_3);
      return var_4;
    } else
      return var_4;
  } else
    return var_4;
}

waitforweaponfired() {
  self endon("disconnect");
  self endon("reload");
  self endon("weapon_change");
  var_0 = 0;
  var_1 = self getcurrentweaponclipammo("right");
  var_2 = self getcurrentweaponclipammo("left");
  self waittill("weapon_fired");
  var_0 = 1;
  var_3 = self getcurrentweaponclipammo("right");
  var_4 = self getcurrentweaponclipammo("left");
  var_5 = var_1 - var_3 + (var_2 - var_4);

  if(var_5 > 0) {
    var_0 = var_5;
  }

  return var_0;
}

monitorshotsfired(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    var_0.damagingshot = 0;
    var_1 = var_0 waitforweaponfired();

    if(isDefined(var_1)) {
      var_2 = level.firingrange.shotsfired + var_1;

      if(var_2 > 9999) {
        level.firingrange.shotsfired = 0;
        level.firingrange.shotshit = 0;
        level.firingrange.percent = 0;
        var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
        var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
        var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      } else if(var_2 < 0) {
        level.firingrange.shotsfired = 0;
        level.firingrange.shotshit = 0;
        level.firingrange.percent = 0;
        var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
        var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
        var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      } else {
        level.firingrange.shouldupdateluadisplay = 1;
        level.firingrange.shotsfired = var_2;
      }

      if(isDefined(var_0.damagingshot)) {
        var_3 = var_0.damagingshot;

        if(var_1 < var_0.damagingshot) {
          var_3 = var_1;
        }

        var_4 = level.firingrange.shotshit + var_3;

        if(var_4 > 9999) {
          level.firingrange.shotshit = 0;
        } else if(var_4 < 0) {
          level.firingrange.shotshit = 0;
        } else {
          level.firingrange.shotshit = var_4;
        }

        var_0.damagingshot = 0;
      }
    }
  }
}

monitorgrenades(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    var_0 waittill("grenade_fire", var_1);

    if(isDefined(var_1)) {
      waittillframeend;

      if(isDefined(var_1.recall) && var_1.recall) {
        continue;
      }
      var_2 = level.firingrange.shotsfired + 1;

      if(var_2 > 9999) {
        level.firingrange.shotsfired = 0;
        level.firingrange.shotshit = 0;
        level.firingrange.percent = 0;
        var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
        var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
        var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      } else if(var_2 < 0) {
        level.firingrange.shotsfired = 0;
        level.firingrange.shotshit = 0;
        level.firingrange.percent = 0;
        var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
        var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
        var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      } else {
        level.firingrange.shouldupdateluadisplay = 1;
        level.firingrange.shotsfired = var_2;
      }
    }
  }
}

monitorhitpercent(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    if(level.firingrange.shotsfired > 0) {
      var_1 = level.firingrange.shotshit / level.firingrange.shotsfired * 100;
      var_1 = common_scripts\utility::_id_7F03(var_1, 0);

      if(var_1 != level.firingrange.percent) {
        if(var_1 > 999) {
          var_1 = 999;
        } else if(var_1 < 0) {
          var_1 = 0;
        }

        level.firingrange.percent = int(var_1);
        level.firingrange.shouldupdateluadisplay = 1;
      }
    }

    waitframe();
  }
}

displayboothholo(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  var_2 = finddisplay(level.firingrange._id_0BD8, var_1);

  if(isDefined(var_2)) {
    var_2 show();
  }

  for(;;) {
    if(level.firingrange.shouldupdateluadisplay == 1) {
      var_0 setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);
      var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
      var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
      var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      level.firingrange.shouldupdateluadisplay = 0;
    }

    wait 0.2;
  }
}

finddisplay(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.setmovespeedscale) && var_3.setmovespeedscale == var_1) {
      return var_3;
    }
  }
}

startround(var_0) {
  level endon("shutdown_hologram");
  level notify("start_round");
  level.firingrange.damagedone = 0;
  level.firingrange.rangeinmeters = 0;
  level.firingrange.time = 0;
  level.firingrange.roundactive = 1;
  level.firingrange.shouldupdateluadisplay = 1;
  self setclientomnvar("ui_vlobby_round_distance", level.firingrange.rangeinmeters);
  self setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);
  self setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
  self setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
  self setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);

  foreach(var_2 in level.firingrange._id_0C3A[var_0]) {
    foreach(var_4 in var_2) {
      var_4.origin = var_4.original_position;
      var_4.angles = var_4.original_orientation;
    }
  }

  if(level._id_010B) {
    _id_8C14(var_0);
  } else {
    var_7 = showtransition_cg(var_0);
    wait 0.1;
    flickertransmeshes(level.firingrange._id_0BDC[var_0]);
    flickertransmeshes(level.firingrange._id_0BDC[var_0]);
    wait 0.1;
    flickertransmeshes(level.firingrange._id_0BDC[var_0]);
    wait 0.1;
    hidetransitionmeshes_cg(var_0, var_7);
    wait 0.1;
    _id_8C14(var_0);
  }

  if(var_0 == 7) {
    self setclientomnvar("ui_vlobby_round_state", 3);
    thread targetspreadshooting(var_0);
  } else {
    self setclientomnvar("ui_vlobby_round_state", 1);
    thread _id_089E(var_0);
  }
}

_id_8C14(var_0) {
  level endon("shutdown_hologram");
  var_1 = common_scripts\utility::_id_7F03(level.firingrange._id_0BDC[var_0].size / level.firingrange.groupdevider, 0, "up");
  var_2 = 0;

  foreach(var_4 in level.firingrange._id_0BDC[var_0]) {
    var_4 show();
    var_4 solid();
  }
}

showtransitionrev(var_0) {
  level endon("shutdown_hologram");
  level.firingrange.transitionmeshesrev = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_isremovedentity(var_2) && isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(isDefined(var_2.model) && issubstr(var_2.model, "_trans")) {
        var_3 = var_2.model + "_rev";
        var_4 = spawn("script_model", var_2.origin);
        level.firingrange.transitionmeshesrev[level.firingrange.transitionmeshesrev.size] = var_4;

        if(isDefined(var_2.angles)) {
          var_4.angles = var_2.angles;
        } else {
          var_4.angles = (0, 0, 0);
        }

        var_4 setModel(var_3);
        var_4 notsolid();
      }
    }
  }
}

showtransition(var_0) {
  level endon("shutdown_hologram");
  level.firingrange.transitionmeshes = [];

  foreach(var_2 in level.firingrange._id_0BDC[var_0]) {
    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(isDefined(var_2.model) && issubstr(var_2.model, "rec_holo_range")) {
        var_3 = var_2.model + "_trans";
        var_4 = spawn("script_model", var_2.origin);
        level.firingrange.transitionmeshes[level.firingrange.transitionmeshes.size] = var_4;

        if(isDefined(var_2.angles)) {
          var_4.angles = var_2.angles;
        } else {
          var_4.angles = (0, 0, 0);
        }

        var_4 setModel(var_3);
        var_4 notsolid();
      }
    }
  }
}

flickertransmeshes(var_0) {
  level endon("shutdown_hologram");

  if(isDefined(var_0) && _isarray(var_0)) {
    hidemodels(var_0);
    waitframe();
    showmodels(var_0);
    waitframe();
  }
}

showmodels(var_0) {
  level endon("shutdown_hologram");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_isremovedentity(var_2)) {
      var_2 show();
      var_2 notsolid();
    }
  }
}

hidemodels(var_0) {
  level endon("shutdown_hologram");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_isremovedentity(var_2)) {
      var_2 hide();
      var_2 notsolid();
    }
  }
}

hidetransitionmeshes() {
  if(_isarray(level.firingrange.transitionmeshes)) {
    level.firingrange.transitionmeshes = common_scripts\utility::_id_0F97(level.firingrange.transitionmeshes);

    foreach(var_1 in level.firingrange.transitionmeshes) {
      if(isDefined(var_1) && !_isremovedentity(var_1)) {
        var_1 hide();
        var_1 notsolid();
      }
    }
  }
}

deletetransrevmeshes() {
  if(_isarray(level.firingrange.transitionmeshesrev)) {
    level.firingrange.transitionmeshesrev = common_scripts\utility::_id_0F97(level.firingrange.transitionmeshesrev);

    foreach(var_1 in level.firingrange.transitionmeshesrev) {
      if(isDefined(var_1) && !_isremovedentity(var_1)) {
        var_1 delete();
      }
    }
  }

  level.firingrange.transitionmeshesrev = [];
}

removetransitionmeshes() {
  if(_isarray(level.firingrange.transitionmeshes)) {
    var_0 = common_scripts\utility::_id_0F97(level.firingrange.transitionmeshes);
    flickertransmeshes(var_0);
    flickertransmeshes(var_0);
    wait 0.1;
    flickertransmeshes(var_0);
    wait 0.1;
    flickertransmeshes(var_0);

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && !_isremovedentity(var_2)) {
        var_2 delete();
      }
    }
  }
}

removerevnmeshes() {
  if(_isarray(level.firingrange.setstablemissile)) {
    level.firingrange.setstablemissile = common_scripts\utility::_id_0F97(level.firingrange.setstablemissile);

    foreach(var_1 in level.firingrange.setstablemissile) {
      if(isDefined(var_1) && !_isremovedentity(var_1)) {
        var_1 delete();
      }
    }
  }
}

movefloorpanelup() {
  level endon("shutdown_hologram");
  var_0 = _randomfloatrange(0.0, 1);
  wait(var_0);
  self setModel("rec_holo_emitter_floor_on");
  self moveTo(self.up_position, 0.25, 0.1, 0.1);
}

movefloorpaneldown() {
  level endon("start_round");
  self setModel("rec_holo_emitter_floor_off");
  var_0 = _randomfloatrange(0.0, 1);
  wait(var_0);
  self moveTo(self.og_position, 0.25, 0.1, 0.1);
}

shutdownround(var_0, var_1) {
  level notify("shutdown_hologram");
  level.firingrange.isshuttingdown = 1;
  var_1 setclientomnvar("ui_vlobby_round_state", 0);
  var_1 setclientomnvar("ui_vlobby_round_timer", 0);
  var_1 setclientomnvar("ui_vlobby_round_damage", 0);
  var_1 setclientomnvar("ui_vlobby_round_distance", 0);
  var_1 setclientomnvar("ui_vlobby_round_hits", 0);
  var_1 setclientomnvar("ui_vlobby_round_fired", 0);
  var_1 setclientomnvar("ui_vlobby_round_accuracy", 0);
  var_1 thread grenadecleanup(1);

  foreach(var_3 in level.firingrange._id_0BDC[var_0]) {
    var_3 hide();
    var_3 notsolid();
  }

  if(level._id_010B) {
    thread maps\mp\_utility::lerp_spot_intensity_array("lt_shootingrange", 0.25, 6000);
  }

  thread maps\mp\_utility::lerp_spot_intensity("lt_shootingrange_bounce", 0.25, 3000);
  thread maps\mp\_utility::lerp_spot_intensity("lt_hologram_blue", 0.25, 0.01);

  foreach(var_6 in level.firingrange._id_0C3A[var_0]) {
    foreach(var_8 in var_6) {
      if(var_8._id_0BC0 == 1) {
        var_9 = var_8.origin;
        var_10 = var_8.angles;
        thread particlespawn(level.firingrange.vfxtargetspawnout, var_9, var_10, 3);
      }

      var_8 dontinterpolate();
      var_8._id_0B6E disableaimassist();
      var_8.origin = var_8.original_position;
      var_8.angles = var_8.original_orientation;
      var_8._id_0B6E hide();
      var_8._id_0B6E notsolid();
      var_8 hide();
      var_8 notsolid();
      var_8._id_A580 hide();
      var_8._id_A580 notsolid();
      var_8._id_0BC0 = 0;
    }
  }

  foreach(var_14 in level.firingrange._id_0BD8) {
    var_14 hide();
  }

  level.firingrange.minpoint = undefined;
  level.firingrange.maxpoint = undefined;
  level.firingrange.minpointmodpos = undefined;
  level.firingrange.presseddown = 0;
  level.firingrange.pressedup = 0;
  level.firingrange.damagedone = 0;
  level.firingrange.rangeinmeters = 0;
  level.firingrange.shotsfired = 0;
  level.firingrange.shotshit = 0;
  level.firingrange.percent = 0;
  level.firingrange.roundactive = 0;
  level.firingrange.shouldupdateluadisplay = 1;
  var_1 setclientomnvar("ui_vlobby_round_distance", level.firingrange.rangeinmeters);
  var_1 setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);
  var_1 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
  var_1 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
  var_1 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
  level.firingrange.isshuttingdown = 0;
}

spawntarget() {
  level endon("shutdown_hologram");
  var_0 = self.origin;
  var_1 = self.angles;
  thread particlespawn(level.firingrange.vfxtargetspawn, var_0, var_1, 3);
  waitframe();
  self solid();
  self._id_A580 show();
}

stopignoringspotlight() {
  level notify("ScaleSoundsOnExit");
  level endon("ScaleSoundsOnExit");

  if(isDefined(self.in_firingrange)) {
    for(;;) {
      waitframe();

      if(self.in_firingrange == 1 || getdvarint("2454", 0) == 1) {
        continue;
      } else {
        level.firingrange.soundents = common_scripts\utility::_id_0F97(level.firingrange.soundents);

        foreach(var_1 in level.firingrange.soundents) {
          var_1 scalevolume(0, 0.5);
        }
      }
    }
  }
}

enter_firingrange(var_0) {
  var_0.in_firingrange = 1;
  thread wait_start_firingrange(0.4, var_0);
}

wait_start_firingrange(var_0, var_1) {
  var_1 endon("enter_lobby");

  if(!level._id_A220) {
    wait(var_0);
  }

  var_1 setclientomnvar("ui_vlobby_round_state", 0);
  var_1 setclientomnvar("ui_vlobby_round_timer", 0);
  var_1 setclientomnvar("ui_vlobby_round_damage", 0);
  var_1 setclientomnvar("ui_vlobby_round_distance", 0);
  var_1 setclientomnvar("ui_vlobby_round_hits", 0);
  var_1 setclientomnvar("ui_vlobby_round_fired", 0);
  var_1 setclientomnvar("ui_vlobby_round_accuracy", 0);

  if(!level._id_A220) {
    var_1 unlink();
    var_1 cameraunlink();
  }

  var_2 = _getgroundposition(level.firingrange.fr_start.origin, 20, 512, 120);
  var_1 dontinterpolate();
  var_1 setOrigin(var_2);
  var_1 setplayerangles(level.firingrange.fr_start.angles);
  var_1 setclientdvar("cg_fovScale", "1.0");
  level.firingrange.isshuttingdown = 0;
  maps\mp\hub_vl_camera::virtual_lobby_set_class(var_1.avatar.ownerid, "lobby" + (var_1.currentselectedclass + 1), 1, 1);
  maps\mp\_utility::updatesessionstate("playing");
  var_1 visionsetnakedforplayer("mp_vlobby_room_fr", 0);
  var_1 thread maps\mp\hub_vl_base::enable_player_controls();
  level.firingrange.soundents = [];
  var_1 thread stopignoringspotlight();

  if(maps\mp\gametypes\_class::isvalidequipment(maps\mp\_utility::_id_44CD(var_1._id_5DF5), 0) && !maps\mp\gametypes\_class::_id_5682(var_1._id_5DF5.guid)) {
    var_1 thread _id_6311(maps\mp\_utility::_id_44CD(var_1._id_5DF5), 0);
  }

  if(maps\mp\gametypes\_class::isvalidequipment(maps\mp\_utility::_id_44CD(var_1._id_5DF8), 0) && !maps\mp\gametypes\_class::_id_5682(var_1._id_5DF8.guid)) {
    var_1 thread _id_6311(maps\mp\_utility::_id_44CD(var_1._id_5DF8), 1);
  }

  if(var_1.primaryweapon != "specialty_null" && var_1.primaryweapon != "none" && var_1.primaryweapon != "combatknife_mp" && !issubstr(var_1.primaryweapon, "em1") && !issubstr(var_1.primaryweapon, "epm3") && !issubstr(var_1.primaryweapon, "dlcgun1_mp") && !issubstr(var_1.primaryweapon, "dlcgun1loot")) {
    var_1 thread monitor_weapon_ammo_count(var_1.primaryweapon);

    if(issubstr(var_1.primaryweapon, "_gl")) {
      var_1 thread monitor_weapon_ammo_count("alt_" + var_1.primaryweapon);
    }
  }

  if(var_1.botclearscriptenemy != "specialty_null" && var_1.botclearscriptenemy != "none" && var_1.botclearscriptenemy != "combatknife_mp" && !issubstr(var_1.botclearscriptenemy, "em1") && !issubstr(var_1.botclearscriptenemy, "epm3") && !issubstr(var_1.primaryweapon, "dlcgun1_mp") && !issubstr(var_1.primaryweapon, "dlcgun1loot")) {
    var_1 thread monitor_weapon_ammo_count(var_1.botclearscriptenemy);

    if(issubstr(var_1.botclearscriptenemy, "_gl")) {
      var_1 thread monitor_weapon_ammo_count("alt_" + var_1.botclearscriptenemy);
    }
  }
}

giveplayerconroldelayed() {
  self endon("enter_lobby");
  wait 2;
  var_0 = getdvarint("2454", 0);

  if(var_0 == 1 && self.in_firingrange == 1) {
    self allowfire(1);
  }
}

_id_089E(var_0) {
  level endon("shutdown_hologram");
  var_1 = self;
  level.firingrange.last_target = undefined;
  thread monitortime(var_1);
  thread monitorshotsfired(var_1);
  thread monitorhitpercent(var_1);

  foreach(var_3 in level.firingrange._id_0C3A[var_0]) {
    foreach(var_5 in var_3) {
      var_5 thread monitordamage(var_1);
    }
  }

  thread displayboothholo(var_1, var_0);
  var_8 = level.firingrange._id_0C3A[var_0].size;
  var_9 = level.firingrange._id_0C3A[var_0];

  for(var_10 = 0; var_10 < var_8; var_10++) {
    thread startwave(var_9[var_10], var_1);
    level waittill("wave_done");
    waitframe();
  }

  level notify("round_done");
  level.firingrange.roundactive = 0;
  var_1 setclientomnvar("ui_vlobby_round_state", 2);
}

monitortime(var_0) {
  level endon("shutdown_hologram");
  level endon("round_done");
  var_1 = maps\mp\_utility::gettimepassed();

  for(;;) {
    var_2 = maps\mp\_utility::gettimepassed();
    var_3 = var_2 - var_1;
    var_4 = common_scripts\utility::_id_7F03(var_3 / 1000, 1);

    if(var_4 > 9999.9) {
      level.firingrange.time = 0;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
      var_0 setclientomnvar("ui_vlobby_round_state", 0);
      thread shutdownround(level.firingrange.roundnumber, var_0);
      return;
    } else if(var_4 < 0) {
      level.firingrange.time = 0;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
      var_0 setclientomnvar("ui_vlobby_round_state", 0);
      thread shutdownround(level.firingrange.roundnumber, var_0);
      return;
    } else {
      level.firingrange.time = var_4;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
    }

    waitframe();
  }
}

startwave(var_0, var_1) {
  level endon("shutdown_hologram");

  if(getdvarint("scr_target_bots", 0) > 0) {
    level._id_8C7A = 1;
    level._id_0A41["player"]["think"] = ::_id_3765;
    level._id_0A41["player"]["on_damaged_finished"] = ::_id_3764;
  }

  var_2 = 0;

  foreach(var_4 in var_0) {
    if(getdvarint("scr_target_bots", 0) > 0) {
      var_4 thread _id_9800(var_1);
      continue;
    }

    var_4 thread target_lifetime(var_1);
  }

  for(;;) {
    level waittill("target_died");
    var_2++;

    if(var_2 == var_0.size) {
      level notify("wave_done");
      return;
    }
  }
}

target_lifetime(var_0) {
  level endon("shutdown_hologram");
  self.original_position = self.origin;
  self.original_orientation = self.angles;
  self._id_0BC0 = 1;
  spawntarget();
  thread target_handler(var_0);
  thread target_logic();
  thread target_handle_death();
  thread target_handle_stop();
}

_id_9800(var_0) {
  level endon("shutdown_hologram");
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_2 = _id_9000(var_1.origin, var_1.angles, var_0);

  if(isDefined(var_2)) {
    var_2 thread _id_9801();
    var_2 thread _id_9802();
  }
}

_id_9000(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_agents::_id_0933("player", game["defenders"], undefined, var_0, var_1, undefined, undefined, 0, undefined, undefined);

  if(isDefined(var_3)) {
    var_4 = 1;
    var_3 setagentcostumeindex(var_4, maps\mp\_utility::getotherteam(var_2.team));
    var_3 setclothtype("cloth");
    var_3 playsoundonmovingent(var_4, maps\mp\_utility::getotherteam(var_2.team));
  }

  return var_3;
}

playsoundonmovingent(var_0, var_1) {
  for(var_2 = 0; var_2 < level.costumecategories.size; var_2++) {
    if(var_1 == "allies") {
      var_3 = 0;
    } else {
      var_3 = 6;
    }

    var_4 = _tablelookupbyrow("mp/agentcostumetable.csv", var_2 + var_3, var_0);
    self.costume[var_2] = int(tablelookup("mp/costumeIdTable.csv", 7, var_4, 4));
  }
}

_id_3765() {
  self endon("death");
  level endon("game_ended");
  self botsetflag("no_enemy_search", 1);
  self botsetflag("disable_movement", 1);
  self botsetflag("disable_rotation", 1);
  self botsetflag("disable_attack", 1);
}

_id_3764(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_1)) {
    var_11 = length(self.origin - var_1.origin);
  } else {
    var_11 = 0;
  }

  _iprintln(self.name + " " + var_8 + " has been hit for " + var_2 + " at " + var_11);
  return maps\mp\agents\_agents::_id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

particlespawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_5 = _spawnfx(var_0, var_1, anglesToForward(var_2), anglestoup(var_2));

  if(isDefined(var_4)) {
    setfxkillondelete(var_5, var_4);
  }

  _triggerfx(var_5);

  if(isDefined(var_3)) {
    wait(var_3);

    if(isDefined(var_5) && !_isremovedentity(var_5)) {
      var_5 delete();
    }
  } else {
    level waittill("shutdown_hologram");

    if(isDefined(var_5) && !_isremovedentity(var_5)) {
      var_5 delete();
    }
  }
}

target_logic() {
  level endon("shutdown_hologram");
  self endon("death");

  if(isDefined(self.setlookatent)) {
    var_0 = self.setlookatent;
    movetargettodest();

    switch (var_0) {
      case "stand":
        break;
      case "cover":
        thread popinpopout();
        break;
      case "move":
        thread movebackforth();
        break;
    }
  }
}

movetargettodest() {
  level endon("shutdown_hologram");
  self endon("death");

  if(!isDefined(level.firingrange.roundnumber)) {
    return;
  }
  var_0 = level.firingrange.roundnumber;

  if(!isDefined(level.firingrange._id_0C37[var_0])) {
    return;
  }
  var_1 = common_scripts\utility::getclosest(self.origin, level.firingrange._id_0C37[var_0]);
  self.current_ent = var_1;
  self.last_ent = self.current_ent;

  for(;;) {
    if(isDefined(self)) {
      var_2 = distance(self.current_ent.origin, self.origin);
      var_3 = var_2 / level.firingrange.round_target_unit_per_second;

      if(var_3 < 0.5) {
        var_3 = 0.5;
      }

      if(isDefined(self.current_ent._id_0165) && self.current_ent._id_0165 == "jump") {
        self moveTo(self.current_ent.origin, var_3 * 0.5, 0, 0.1);
      } else if(isDefined(self.last_ent._id_0165) && self.last_ent._id_0165 == "jump") {
        self moveTo(self.current_ent.origin, var_3 * 0.5, 0.1, 0);
      } else {
        self moveTo(self.current_ent.origin, var_3);
      }

      self waittill("movedone");

      if(isDefined(self.current_ent.target)) {
        var_4 = _getEnt(self.current_ent.target, "targetname");
        self.last_ent = self.current_ent;
        self.current_ent = var_4;
      } else
        return;
    } else
      return;
  }
}

popinpopout() {
  level endon("shutdown_hologram");
  self endon("death");
  var_0 = 4;
  var_1 = 1;
  var_2 = self.current_ent.origin;
  var_3 = self.last_ent.origin;

  if(self.current_ent == self.last_ent) {
    var_3 = self.original_position;
  }

  wait(var_0);

  for(;;) {
    if(isDefined(self)) {
      var_4 = distance(var_3, var_2);
      var_5 = var_4 / level.firingrange.round_target_unit_per_second;
      self moveTo(var_3, var_5);
      self waittill("movedone");
      wait(var_1);
      var_4 = distance(var_3, var_2);
      var_5 = var_4 / level.firingrange.round_target_unit_per_second;
      self moveTo(var_2, var_5);
      self waittill("movedone");
      wait(var_0);
    }
  }
}

movebackforth() {
  level endon("shutdown_hologram");
  self endon("death");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self.last_ent._id_0165) && self.last_ent._id_0165 == "jump") {
    var_0 = self.last_ent;
    var_1 = var_0.origin;
    self.last_ent = _getEnt(var_0.targetname, "target");
  }

  var_2 = self.current_ent.origin;
  var_3 = self.last_ent.origin;

  if(self.current_ent == self.last_ent) {
    var_3 = self.original_position;
  }

  for(;;) {
    if(isDefined(self)) {
      if(isDefined(var_1)) {
        wait 2;
        var_4 = distance(var_1, var_2);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_1, var_5 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_4 = distance(var_1, var_3);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_3, var_5 * 0.5, 0.1, 0);
        self waittill("movedone");
        wait 2;
        var_4 = distance(var_1, var_3);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_1, var_5 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_4 = distance(var_1, var_2);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_2, var_5 * 0.5, 0.1, 0);
        self waittill("movedone");
      } else {
        var_4 = distance(var_3, var_2);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_3, var_5);
        self waittill("movedone");
        var_4 = distance(var_2, var_3);
        var_5 = var_4 / level.firingrange.round_target_unit_per_second;
        self moveTo(var_2, var_5);
        self waittill("movedone");
      }
    }
  }
}

laseroff() {
  level endon("shutdown_hologram");

  for(;;) {
    var_0 = [];

    for(var_1 = 0; var_1 < self.hits.size; var_1++) {
      self.hits[var_1].time = self.hits[var_1].time - 1;

      if(self.hits[var_1].time > 0) {
        var_0[var_0.size] = self.hits[var_1];
      }
    }

    self.hits = var_0;

    foreach(var_3 in self.hits) {}

    waitframe();
  }
}

target_handler(var_0) {
  level endon("shutdown_hologram");
  self.hits = [];
  self._id_0B6E.health = 9999;
  self._id_0B6E.maxhealth = 9999;
  self.maxhealth = 9999;
  self.health = self.maxhealth;
  self.fakehealth = 100;
  self setCanDamage(1);
  self._id_0B6E show();
  self._id_0B6E solid();
  self._id_0B6E enableaimassist();
  self._id_A580 show();

  while(self.health > 0) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = getmodifier(var_10, var_8, var_0);
    var_12 = self gettagorigin("tag_head");
    var_13 = self gettagorigin("tag_chest");
    self.health = self.maxhealth;
    var_14 = self.fakehealth;
    var_14 = _float(var_14) - _float(var_1) * var_11;
    var_14 = common_scripts\utility::_id_7F03(var_14, 0);
    self.fakehealth = int(var_14);

    if(self.fakehealth <= 0) {
      thread targetplaydeath(var_13);
      self.health = 0;

      if(isDefined(var_2)) {
        if(isDefined(var_8)) {
          if(var_8 == "tag_head") {
            var_2 _id_04C7::updatedamagefeedback("killshot_headshot");
          } else if(var_8 == "tag_chest") {
            var_2 _id_04C7::updatedamagefeedback("mp_hit_kill");
          }
        }
      }

      self notify("death");
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_8) && var_8 == "tag_head") {
        var_2 _id_04C7::updatedamagefeedback("headshot");
        continue;
      }

      var_2 _id_04C7::updatedamagefeedback("standard");
    }
  }
}

_id_9803() {
  level endon("shutdown_hologram");
  self.hits = [];

  while(isDefined(self) && self.health > 0) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

targetplaydeath(var_0) {
  playFX(level._effect["recovery_scoring_target_shutter_enemy"], var_0);
}

deactivate_targets() {
  level notify("shutdown_hologram");
}

firing_range_setup_triggers() {
  var_0 = getEntArray("firing_range_round_trigger", "targetname");
  return var_0;
}

firing_range_setup_target_logic() {
  var_0 = getEntArray("target_logic_point", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.setmovespeedscale)) {
      var_4 = int(var_3.setmovespeedscale);

      if(!_isarray(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
      } else
        var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

firing_range_setup_env() {
  var_0 = getEntArray("round_environment", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3 hide();
    var_3 notsolid();
    var_4 = undefined;

    if(isDefined(var_3.setmovespeedscale)) {
      var_4 = int(var_3.setmovespeedscale);
    }

    if(isDefined(var_4)) {
      if(!_isarray(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
        continue;
      }

      var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

firing_range_setup_env_vfx() {
  var_0 = common_scripts\utility::getstructarray("round_environment", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = undefined;

    if(isDefined(var_3.setmovespeedscale)) {
      var_4 = int(var_3.setmovespeedscale);
    }

    if(isDefined(var_4)) {
      if(!_isarray(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
        continue;
      }

      var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

firing_range_setup_targets() {
  var_0 = getEntArray("target_enemy", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_0BC0 = 0;
    var_3.pers["team"] = "axis";
    var_3.team = "axis";
    var_3.origin_ent = _getEnt(var_3.target, "targetname");
    var_3._id_0B6E = _getEnt(var_3.origin_ent.target, "targetname");
    var_3._id_0B6E linktosynchronizedparent(var_3);
    var_3._id_0B6E.pers["team"] = "axis";
    var_3._id_0B6E.team = "axis";

    if(isDefined(var_3._id_0B6E.target)) {
      var_3._id_A580 = _getEnt(var_3._id_0B6E.target, "targetname");
      var_3._id_A580 linktosynchronizedparent(var_3);
    } else
      var_3._id_A580 = var_3;

    var_3.original_position = var_3.origin;
    var_3.original_orientation = var_3.angles;
    var_3._id_0B6E hide();
    var_3._id_0B6E notsolid();
    var_3 hide();
    var_3 notsolid();
    var_3._id_A580 hide();
    var_3._id_A580 notsolid();

    if(isDefined(var_3.setmovespeedscale)) {
      var_4 = int(var_3.setmovespeedscale);

      if(!_isarray(var_1[var_4])) {
        var_5 = [];
        var_1[var_4] = var_5;
      }

      if(isDefined(var_3.throwgrenade)) {
        var_6 = int(var_3.throwgrenade);

        if(!_isarray(var_1[var_4][var_6])) {
          var_7 = [var_3];
          var_1[var_4][var_6] = var_7;
        } else
          var_1[var_4][var_6] = common_scripts\utility::_id_0972(var_1[var_4][var_6], var_3);
      }
    }
  }

  return var_1;
}

target_handle_death() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
  target_reset();
}

_id_9801() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
}

target_handle_stop() {
  self endon("death");
  level waittill("shutdown_hologram");
  target_reset();
}

_id_9802() {
  self endon("death");
  level waittill("shutdown_hologram");
  maps\mp\agents\_agent_utility::killagent(self);
}

target_reset() {
  self setCanDamage(0);
  self hide();
  self notsolid();
  self._id_0BC0 = 0;

  if(isDefined(self._id_0B6E)) {
    self._id_0B6E disableaimassist();
  }

  if(isDefined(self._id_A580)) {
    self._id_A580 hide();
  }
}

monitor_weapon_ammo_count(var_0) {
  self endon("enter_lobby");

  while(self.in_firingrange == 1) {
    var_1 = self getfractionmaxammo(var_0);

    if(var_1 <= 0.25) {
      self givemaxammo(var_0);
      continue;
    }

    wait 0.5;
  }
}

grenadecleanup(var_0) {
  if(isDefined(level.grenades) && _isarray(level.grenades)) {
    foreach(var_2 in level.grenades) {
      if(isDefined(var_2) && !_isremovedentity(var_2)) {
        if(!isDefined(self) || !isDefined(var_2._id_0117) || _isremovedentity(var_2._id_0117)) {
          if(!isDefined(var_2.weaponname)) {
            continue;
          } else {
            var_2 notify("death");
            var_2 thread delaydelete();
          }

          continue;
        }

        if(var_2._id_0117 == self) {
          if(!isDefined(var_2.weaponname)) {
            continue;
          } else {
            var_2 notify("death");
            var_2 thread delaydelete();
          }
        }
      }
    }
  }
}

delaydelete() {
  waitframe();

  if(isDefined(self) && !_isremovedentity(self)) {
    self delete();
  }
}

_id_6311(var_0, var_1) {
  self endon("enter_lobby");

  while(level.in_firingrange == 1) {
    wait 1.5;
    var_2 = self getammocount(var_0);

    if(var_2 == 0) {
      maps\mp\gametypes\_class::_id_479F(var_0);
      continue;
    }

    wait 0.5;
  }
}

showtransition_cg(var_0) {
  level endon("shutdown_hologram");
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in level.firingrange._id_0BDC[var_0]) {
    if(isDefined(var_4.classname) && var_4.classname == "script_model") {
      if(isDefined(var_4.model) && issubstr(var_4.model, "rec_holo_range")) {
        var_2[var_1] = var_4.model;

        if(!issubstr(var_4.model, "trans")) {
          var_5 = var_4.model + "_trans";
          var_4 setModel(var_5);
        }

        var_4 show();
      } else
        var_2[var_1] = undefined;
    }

    var_1++;
  }

  return var_2;
}

hidetransitionmeshes_cg(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.firingrange._id_0BDC[var_0]) {
    if(isDefined(var_4.classname) && var_4.classname == "script_model") {
      if(isDefined(var_4.model) && issubstr(var_4.model, "rec_holo_range")) {
        if(_isstring(var_1[var_2])) {
          var_4 hide();
          var_4 setModel(var_1[var_2]);
        }
      }
    }

    var_2++;
  }
}