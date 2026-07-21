/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scriptedsniper.gsc
***********************************************/

spawn_scripted_sniper(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [["script_control", ::script_control_enter], ["seek_target", ::sniper_seek_target_enter], ["tracking_target", ::sniper_tracking_target_enter, ::sniper_tracking_target_update, ::sniper_tracking_target_exit], ["lost_target", ::sniper_lost_target_enter, ::sniper_lost_target_update], ["shoot_target", ::sniper_shoot_target_enter], ["reload", ::sniper_reload_enter, ::sniper_reload_update], ["exit_nest", ::sniper_exit_nest], ["death", ::sniper_death_enter]];
  self.moveinterval = 0.2;
  self.aquireplayertime = 0.25;
  self.reloadtime = 2;
  self.wobblemagnitude = 2;
  self.mintracktime = 0.75;
  self.maxtracktime = 2;
  self.trackmindistancethreshold = 300;
  self.trackmaxdistancethreshold = 800;
  self.minshotinterval = 6;
  self.maxshotinterval = 8;
  self.pullbackoffset = 300;
  self.timetolosetarget = 4;
  self.losttargettime = 0;
  self.currenttarget = undefined;
  self.currenttargettag = "J_Spine4";
  self.lastknownposition = undefined;
  self.targetposition = undefined;
  self.lastframetargetposition = undefined;
  self.nextshotinterval = self.minshotinterval;
  self.deathflag = var_4;
  self.targetingplayerflag = var_3;
  self.targetinpronefoliage = 0;
  self.targetincrouchfoliage = 0;
  self.targetinstandfoliage = 0;
  self.contentoverride = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
  self.holdbeforeshoottime = 0.6;

  switch (scripts\common\utility::getdifficulty()) {
    case "easy":
      self.holdbeforeshoottime = 1.5;
      break;
    case "hard":
      self.holdbeforeshoottime = 0.65;
      break;
    case "fu":
      self.holdbeforeshoottime = 0.65;
      break;
  }

  self.targetmodifier = 1;
  self.lastshottime = gettime();
  self.checkgroup = [];
  self.currentcheckgroup = [];
  self.ignoreallies = 1;
  self.slowreactweapons = [];
  self.pullbackstruct = var_2;
  self.covershootpoints = [];
  self.ignorevolumes = getEntArray("sniper_max_angle_ignore", "targetname");
  self.laser = spawn("script_model", self.origin);
  self.laser setModel("tag_laser");
  self.laser laserforceon();
  self.laser setmoverlaserweapon("iw8_emplaced_sniper");
  self.snipermodel = getEnt(var_1, "targetname");
  self.snipermodel linkTo(self);
  self.aimgroup = [];
  self.aimgroup = scripts\engine\utility::getStructArray("sniper_cover_aim_1", "targetname");
  self.nextaimtarget = self.aimgroup[0];
  self.aimtarget = scripts\engine\utility::spawn_script_origin(self.nextaimtarget.origin, self.nextaimtarget.angles);
  self.desiredaimpos = (0, 0, 0);
  self.lostlocktime = 0;
  self.usedtargets = [];
  var_7 = getEntArray("sniper_cover_group", "targetname");

  foreach(var_9 in var_7)
  var_9 thread sniper_cover_group_trigger();

  var_11 = getEntArray("sniper_target", "targetname");

  foreach(var_13 in var_11)
  var_13 thread sniper_shot_target(self);

  scripts\sp\statemachine::set_permanent_notify_handlers([["kill_sniper", ::sniper_handle_death], ["exit_nest", ::sniper_handle_exit_nest], ["script_control", ::sniper_handle_script_control]]);
  var_15 = getEntArray("sniper_in_foliage", "targetname");

  foreach(var_9 in var_15)
  var_9 thread sniper_in_prone_foliage_trigger(self);

  var_18 = getEntArray("sniper_in_high_foliage", "targetname");

  foreach(var_9 in var_18)
  var_9 thread sniper_in_crouch_foliage_trigger(self);

  var_21 = getEntArray("sniper_in_full_foliage", "targetname");

  foreach(var_9 in var_21)
  var_9 thread sniper_in_standing_foliage_trigger(self);

  thread sniper_setup_destruction_notify();
  thread update_facing_angles();

  if(!isDefined(var_5))
    var_5 = "seek_target";

  scripts\sp\statemachine::begin_fsm(var_6, var_5);
  level notify("scripted_sniper_spawned");
  thread scripts\engine\sp\utility::add_extra_autosave_check("scriptedSniper", ::scripted_sniper_can_save, "Scripted sniper targeting player.");
}

scripted_sniper_can_save() {
  if(!isDefined(level.fakesniper))
    return 1;

  if(!isDefined(level.fakesniper.currenttarget))
    return 1;

  if(level.fakesniper.currenttarget != level.player)
    return 1;

  return 0;
}

script_control_enter() {
  self waittill("end_script_control");
  scripts\sp\statemachine::goto_state("seek_target");
}

sniper_seek_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", ::sniper_handle_shot_target]]);
  self.aimtargetoriginalposition = self.aimtarget.origin;
  self.pulsesinx = 0;
  self.pulsesinxrate = 5;
  var_0 = gettime();
  childthread sweep_aim_points();

  for(;;) {
    if(sniper_check_for_target(level.player)) {
      if((gettime() - self.losttargettime) / 1000 >= self.aquireplayertime)
        scripts\sp\statemachine::goto_state("tracking_target");
    } else
      self.losttargettime = gettime();

    if(!self.ignoreallies && self.checkgroup.size > 0) {
      self.currentcheckgroup = scripts\engine\utility::array_removedead_or_dying(self.currentcheckgroup);

      if(self.currentcheckgroup.size > 0) {
        if(isDefined(self.currentcheckgroup[0])) {
          if(sniper_check_for_target(self.currentcheckgroup[0])) {
            if(scripts\engine\sp\utility::within_fov_of_players(self.currentcheckgroup[0] get_tagorigin("J_Spine4"), 0.64279))
              scripts\sp\statemachine::goto_state("tracking_target");
          }
        }

        self.currentcheckgroup = scripts\engine\utility::array_remove(self.currentcheckgroup, self.currentcheckgroup[0]);
      } else {
        self.checkgroup = scripts\engine\utility::array_removedead_or_dying(self.checkgroup);
        self.currentcheckgroup = self.checkgroup;
      }
    }

    var_1 = (gettime() - self.lastshottime) / 1000;

    if(var_1 > self.nextshotinterval)
      sniper_fire_shot(self.aimtarget.origin, 0);

    waitframe();
  }
}

sweep_aim_points() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    self.nextaimtarget = self.aimgroup[var_1];
    var_2 = distance(self.nextaimtarget.origin, self.aimtarget.origin) / 60;

    if(var_2 > 0) {
      self.aimtarget moveTo(self.nextaimtarget.origin, var_2, var_2 / 10, var_2 / 10);
      wait(var_2);
    }

    if(var_0) {
      var_1--;

      if(var_1 < 0) {
        var_1 = 1;
        var_0 = 0;
      }

      continue;
    }

    var_1++;

    if(var_1 > self.aimgroup.size - 1) {
      var_1 = self.aimgroup.size - 2;
      var_0 = 1;
    }
  }
}

sniper_tracking_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", ::sniper_handle_shot_target_tracking]]);

  if(self.currenttarget == level.player) {
    if(isDefined(self.targetingplayerflag))
      scripts\engine\utility::flag_set(self.targetingplayerflag);
  }

  self.lastframetargetposition = self.currenttarget.origin;
  self.lockedtotarget = 0;
  var_0 = gettime();
  var_1 = 0;
  self.projectedtargetpos = self.currenttarget get_tagorigin(self.currenttargettag);
  var_2 = 0;

  if(self.currenttarget == level.player) {
    foreach(var_4 in self.slowreactweapons) {
      if(getweaponbasename(level.player.currentweapon) == var_4)
        var_2 = 1;
    }

    self.projectedtargetpos = self.projectedtargetpos + level.player getvelocity() * self.maxtracktime;
  }

  var_6 = distance(self.aimtarget.origin, self.projectedtargetpos);
  var_7 = distance(self.projectedtargetpos, self.origin);
  var_8 = distance(self.aimtarget.origin, self.origin);

  if(var_8 > var_7) {
    var_9 = var_6 + self.pullbackoffset;

    if(var_9 > var_8 - self.pullbackoffset)
      var_9 = var_8 - self.pullbackoffset;

    var_10 = self.origin - self.aimtarget.origin;
    self.aimtarget.origin = self.aimtarget.origin + vectorNormalize(var_10) * var_9;
  }

  var_11 = scripts\engine\math::normalize_value(self.trackmindistancethreshold, self.trackmaxdistancethreshold, var_6);
  var_12 = scripts\engine\math::factor_value(self.mintracktime, self.maxtracktime, var_11);
  var_13 = 0;

  if(var_2) {
    var_12 = var_12 + var_12 * 0.2;
    var_13 = 0.75;
  }

  while(var_1 < var_12) {
    var_1 = (gettime() - var_0) / 1000;
    var_14 = var_12 - var_1;

    if(var_14 <= 0) {
      break;
    }

    self.projectedtargetpos = self.currenttarget get_tagorigin(self.currenttargettag);

    if(self.currenttarget == level.player)
      self.projectedtargetpos = self.projectedtargetpos + level.player getvelocity() * var_14;

    var_6 = distance(self.aimtarget.origin, self.projectedtargetpos);
    var_15 = var_6 / var_14 * self.moveinterval;
    var_16 = vectorNormalize(self.projectedtargetpos - self.aimtarget.origin);
    self.desiredaimpos = self.aimtarget.origin + var_16 * var_15;

    if(var_15 > distance(self.aimtarget.origin, self.projectedtargetpos)) {
      break;
    }

    self.aimtarget moveTo(self.desiredaimpos, self.moveinterval);
    wait(self.moveinterval);
  }

  self.lockedtotarget = 1;
  self.lostlocktime = gettime();

  for(;;) {
    self.desiredaimpos = sniper_locked_laser_to_target();
    self.aimtarget moveTo(self.desiredaimpos, 0.1);

    if((gettime() - self.lostlocktime) / 1000 > self.holdbeforeshoottime + var_13) {
      self.targetmodifier = 0;
      var_17 = vectortoangles(self.origin - self.currenttarget.origin);
      var_18 = anglesToForward(var_17);

      if(self.currenttarget == level.player)
        var_19 = vectorNormalize(self.currenttarget getvelocity());
      else {
        var_19 = vectorNormalize(self.lastframetargetposition - self.currenttarget.origin);
        self.lastframetargetposition = self.currenttarget.origin;
      }

      var_20 = vectordot(var_18, var_19);

      if(self.currenttarget == level.player)
        var_21 = length2dsquared(self.currenttarget getvelocity()) / 50000;
      else
        var_21 = length2dsquared(self.lastframetargetposition - self.currenttarget.origin) / 50000;

      if(var_20 < 0.5 && var_21 > 0.3)
        self.targetmodifier = 24;

      if(self.currenttarget == level.player) {
        if(level.player issprintsliding())
          self.targetmodifier = 24;
      }

      if(self.targetmodifier > 0) {
        var_22 = randomfloat(100);

        if(var_22 < 50)
          var_22 = -1;
        else
          var_22 = 1;

        var_23 = randomfloat(100);

        if(var_23 < 50)
          var_23 = -1;
        else
          var_23 = 1;

        var_24 = (self.targetmodifier * var_22, self.targetmodifier * var_23, self.targetmodifier);
        sniper_fire_shot(self.aimtarget.origin + var_24, 0);
      } else
        sniper_fire_shot(self.aimtarget.origin, 1);
    }

    wait 0.1;
  }
}

sniper_tracking_target_update() {
  level endon("sniper_killed");
  self endon("death");

  if(self.currenttarget != level.player) {
    if(sniper_check_for_target(level.player)) {
      if((gettime() - self.losttargettime) / 1000 >= self.aquireplayertime)
        scripts\sp\statemachine::goto_state("tracking_target");
    }
  }

  if(!sniper_check_for_target(self.currenttarget)) {
    if(isDefined(self.currenttarget))
      self.lastknownposition = self.currenttarget get_tagorigin(self.currenttargettag);

    scripts\sp\statemachine::goto_state("lost_target");
  } else if(isDefined(self.currenttarget))
    self.lastknownposition = self.currenttarget get_tagorigin(self.currenttargettag);
}

sniper_tracking_target_exit() {
  if(isDefined(self.targetingplayerflag))
    scripts\engine\utility::flag_clear(self.targetingplayerflag);

  self.lockedtotarget = 0;
}

sniper_lost_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", ::sniper_handle_shot_target_tracking]]);
  self.currenttarget = undefined;
  self.donelosttargetshot = 0;
  self.aimtargetoriginalposition = self.aimtarget.origin;
  self.pulsesinx = 0;
  self.pulsesinxrate = 5;
  self.losttargettime = gettime();
}

sniper_lost_target_update() {
  level endon("sniper_killed");
  self endon("death");

  if(sniper_check_for_target(self.currenttarget))
    scripts\sp\statemachine::goto_state("tracking_target");

  self.pulsesin = sin(self.pulsesinx);
  self.pulsesinx = scripts\engine\math::wrap(0, 360, self.pulsesinx + self.pulsesinxrate);
  var_0 = (self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude);
  self.aimtarget.origin = self.aimtargetoriginalposition + var_0;
  var_1 = (gettime() - self.lastshottime) / 1000;

  if(var_1 > self.nextshotinterval)
    sniper_fire_shot(self.aimtarget.origin + (0, 0, 8), 0);

  if(var_1 >= self.timetolosetarget)
    scripts\sp\statemachine::goto_state("seek_target");
}

sniper_shoot_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  var_0 = distance(self.desiredaimpos, self.aimtarget.origin);
  var_1 = 1;

  if(var_0 > 1000)
    var_1 = var_1 + (var_0 - 1000) / 1000;

  self.aimtarget moveTo(self.desiredaimpos, var_1);
  wait(var_1);
  wait 0.5;
  sniper_fire_shot(self.aimtarget.origin);
}

sniper_reload_enter() {
  level endon("sniper_killed");
  self endon("death");
  self.laser laserforceoff();
  wait(self.reloadtime);
  self.laser laserforceon();

  if(isDefined(self.currenttarget))
    scripts\sp\statemachine::goto_state("tracking_target");
  else
    scripts\sp\statemachine::goto_state("seek_target");
}

sniper_reload_update() {
  if(!sniper_check_for_target(self.currenttarget))
    self.currenttarget = undefined;
}

sniper_death_enter() {
  level notify("end_sniper_checks");
  self notify("death");
  self.laser laserforceoff();
  self.snipermodel delete();

  if(isDefined(self.targetingplayerflag))
    scripts\engine\utility::flag_clear(self.targetingplayerflag);

  if(isDefined(self.deathflag))
    scripts\engine\utility::flag_set(self.deathflag);

  self delete();
}

sniper_exit_nest() {
  level notify("end_sniper_checks");
  self notify("death");

  if(isDefined(self.targetingplayerflag))
    scripts\engine\utility::flag_clear(self.targetingplayerflag);

  self.laser laserforceoff();
  var_0 = scripts\engine\utility::getStruct("fake_sniper", "targetname");
  var_1 = scripts\engine\utility::getStruct(self.pullbackstruct, "targetname");
  self moveTo(var_0.origin, 0.5, 0.2, 0.2);
  self rotateTo(var_0.angles, 0.5, 0.2, 0.2);
  wait 0.5;
  self moveTo(var_1.origin, 2, 1, 0.5);
  self rotateTo(var_1.angles, 2, 1, 0.5);
  wait 2;
  self.snipermodel delete();
  self delete();
}

update_facing_angles() {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  self endon("death");

  for(;;) {
    self.laser.angles = vectortoangles(vectorNormalize(self.aimtarget.origin - self.origin));
    self.angles = vectortoangles(vectorNormalize(self.aimtarget.origin - self.origin));
    waitframe();
  }
}

sniper_handle_death(var_0) {
  scripts\sp\statemachine::goto_state("death");
}

sniper_handle_shot_target(var_0) {
  self.currentshottarget = var_0[0];
  var_1 = scripts\engine\utility::getStructArray(var_0[0], "targetname");

  if(var_1.size > 1) {
    var_2 = get_unused_struct_from_array(var_1);
    self.desiredaimpos = var_2.origin;
  } else
    self.desiredaimpos = var_1[0].origin;

  scripts\sp\statemachine::goto_state("shoot_target");
}

sniper_handle_shot_target_tracking(var_0) {
  if(isDefined(self.currenttarget) && self.currenttarget != level.player) {
    var_1 = scripts\engine\utility::getStructArray(var_0[0], "targetname");

    if(var_1.size > 1) {
      var_2 = get_unused_struct_from_array(var_1);
      self.desiredaimpos = var_2.origin;
    } else
      self.desiredaimpos = var_1[0].origin;
  }

  scripts\sp\statemachine::goto_state("shoot_target");
}

get_unused_struct_from_array(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::array_contains(self.usedtargets, var_4.origin)) {
      var_2[var_2.size] = var_4.origin;
      continue;
    } else {
      var_1 = var_4;
      break;
    }
  }

  if(!isDefined(var_1)) {
    self.usedtargets = scripts\engine\utility::array_remove_array(self.usedtargets, var_2);
    var_1 = scripts\engine\utility::random(var_0);
  }

  self.usedtargets[self.usedtargets.size] = var_1.origin;
  return var_1;
}

sniper_handle_exit_nest() {
  scripts\sp\statemachine::goto_state("exit_nest");
}

sniper_handle_script_control() {
  scripts\sp\statemachine::goto_state("script_control");
}

sniper_check_for_target(var_0) {
  if(isDefined(var_0)) {
    var_1 = vectortoangles(var_0.origin - self.origin);
    var_2 = anglesToForward(var_1);
    var_3 = anglesToForward(self.angles);
    var_4 = vectordot(var_2, var_3);

    if(var_4 < 0.3)
      return 0;

    foreach(var_6 in self.ignorevolumes) {
      if(var_6 istouching(var_0))
        return 0;
    }

    if(var_0 == level.player) {
      if(self.targetinpronefoliage) {
        if(level.player getstance() == "prone")
          return 0;
      } else if(self.targetincrouchfoliage) {
        if(level.player getstance() == "prone" || level.player getstance() == "crouch")
          return 0;
      } else if(self.targetinstandfoliage)
        return 0;
    }

    var_8 = var_0 get_tagorigin("J_Spine4");

    if(scripts\engine\trace::ray_trace_passed(self.origin, var_8, var_0, self.contentoverride)) {
      self notify("new_target", var_0, "J_Spine4", var_8);
      self.currenttarget = var_0;
      self.currenttargettag = "J_Spine4";
      self.targetposition = var_8;
      return 1;
    } else {
      var_8 = var_0 get_tagorigin("j_head");

      if(scripts\engine\trace::ray_trace_passed(self.origin, var_8, var_0, self.contentoverride)) {
        self notify("new_target", var_0, "j_head", var_8);
        self.currenttarget = var_0;
        self.currenttargettag = "j_head";
        self.targetposition = var_8;
        return 1;
      }
    }
  }

  return 0;
}

sniper_fire_shot(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    var_0 = sniper_fire_perfect_shot();

  magicbullet("iw8_sn_scripted", self.origin, var_0, undefined);
  self.lastshottime = gettime();

  if(isDefined(self.currentshottarget) && self.currentshottarget != "") {
    level notify(self.currentshottarget);
    self.currentshottarget = "";
  }

  self.nextshotinterval = randomfloatrange(self.minshotinterval, self.maxshotinterval);
  level notify("sniper_fired");
  scripts\sp\statemachine::goto_state("reload");
}

sniper_locked_laser_to_target() {
  if(self.currenttarget == level.player)
    return self.currenttarget get_tagorigin(self.currenttargettag) + level.player getvelocity() / 3;
  else
    return self.currenttarget get_tagorigin(self.currenttargettag);
}

sniper_fire_perfect_shot() {
  return self.currenttarget get_tagorigin(self.currenttargettag);
}

sniper_track_allies() {
  level notify("stop_tracking_allies");
  level endon("stop_tracking_allies");
  level endon("sniper_killed");

  if(isDefined(level.fakesniper)) {
    level.fakesniper.ignoreallies = 0;
    wait 6;

    if(isDefined(level.fakesniper))
      level.fakesniper.ignoreallies = 1;
  }
}

sniper_shot_target(var_0) {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  level endon(self.target);

  for(;;) {
    self waittill("trigger");
    var_0 notify("request_shot_target", [self.target]);
    wait 3;
  }

  self delete();
}

sniper_cover_group_trigger() {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  self.targets = scripts\engine\utility::getStructArray(self.script_parameters, "targetname");

  for(;;) {
    self waittill("trigger");
    level.fakesniper.aimgroup = self.targets;
  }
}

sniper_setup_destruction_notify() {
  level endon("sniper_killed");

  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("sniper_nest", "targetname");

  if(!isDefined(var_0[0])) {
    return;
  }
  level.snipernest = var_0[0];
  level.snipernest waittillmatch("scriptableNotification", "sniper_dead");

  if(isDefined(self.deathflag) && !scripts\engine\utility::flag(self.deathflag))
    self notify("kill_sniper");
}

sniper_in_prone_foliage_trigger(var_0) {
  if(isDefined(var_0.deathflag))
    level endon(var_0.deathflag);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_0.targetinpronefoliage = 1;
      waitframe();
    }

    var_0.targetinpronefoliage = 0;
    waitframe();
  }
}

sniper_in_crouch_foliage_trigger(var_0) {
  if(isDefined(var_0.deathflag))
    level endon(var_0.deathflag);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_0.targetincrouchfoliage = 1;
      waitframe();
    }

    var_0.targetincrouchfoliage = 0;
    waitframe();
  }
}

sniper_in_standing_foliage_trigger(var_0) {
  if(isDefined(var_0.deathflag))
    level endon(var_0.deathflag);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_0.targetinstandfoliage = 1;
      waitframe();
    }

    var_0.targetinstandfoliage = 0;
    waitframe();
  }
}

get_tagorigin(var_0) {
  if(isPlayer(self)) {
    if(var_0 == "j_head")
      return level.player getEye();
    else {
      var_1 = level.player getstance();

      switch (var_1) {
        case "stand":
          var_2 = (0, 0, 12);
          break;
        case "crouch":
          var_2 = (0, 0, 10);
          break;
        default:
          var_2 = (0, 0, 2);
          break;
      }

      return level.player getEye() - var_2;
    }
  } else
    return self gettagorigin(var_0);
}