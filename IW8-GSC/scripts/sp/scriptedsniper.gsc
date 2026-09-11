/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\scriptedsniper.gsc
***********************************************/

function spawn_scripted_sniper(var0, var1, var2, var3, var4, var5) {
  var6 = [["script_control", &script_control_enter], ["seek_target", &sniper_seek_target_enter], ["tracking_target", &sniper_tracking_target_enter, &sniper_tracking_target_update, &sniper_tracking_target_exit], ["lost_target", &sniper_lost_target_enter, &sniper_lost_target_update], ["shoot_target", &sniper_shoot_target_enter], ["reload", &sniper_reload_enter, &sniper_reload_update], ["exit_nest", &sniper_exit_nest], ["death", &sniper_death_enter]];
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
  self.deathflag = var4;
  self.targetingplayerflag = var3;
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
  self.pullbackstruct = var2;
  self.covershootpoints = [];
  self.ignorevolumes = getEntArray("sniper_max_angle_ignore", "targetname");
  self.laser = spawn("script_model", self.origin);
  self.laser setModel("tag_laser");
  self.laser laserforceon();
  self.laser setmoverlaserweapon("iw8_emplaced_sniper");
  self.snipermodel = getEnt(var1, "targetname");
  self.snipermodel linkTo(self);
  self.aimgroup = [];
  self.aimgroup = scripts\engine\utility::getStructArray("sniper_cover_aim_1", "targetname");
  self.nextaimtarget = self.aimgroup[0];
  self.aimtarget = scripts\engine\utility::spawn_script_origin(self.nextaimtarget.origin, self.nextaimtarget.angles);
  self.desiredaimpos = (0, 0, 0);
  self.lostlocktime = 0;
  self.usedtargets = [];
  var7 = getEntArray("sniper_cover_group", "targetname");

  foreach(var9 in var7) {
    thread sniper_cover_group_trigger();
  }

  var11 = getEntArray("sniper_target", "targetname");

  foreach(var13 in var11) {
    thread sniper_shot_target(var13);
  }

  scripts\sp\statemachine::set_permanent_notify_handlers([["kill_sniper", &sniper_handle_death], ["exit_nest", &sniper_handle_exit_nest], ["script_control", &sniper_handle_script_control]]);
  var15 = getEntArray("sniper_in_foliage", "targetname");

  foreach(var9 in var15) {
    thread sniper_in_prone_foliage_trigger(var9);
  }

  var18 = getEntArray("sniper_in_high_foliage", "targetname");

  foreach(var9 in var18) {
    thread sniper_in_crouch_foliage_trigger(var9);
  }

  var21 = getEntArray("sniper_in_full_foliage", "targetname");

  foreach(var9 in var21) {
    thread sniper_in_standing_foliage_trigger(var9);
  }

  thread sniper_setup_destruction_notify();
  thread update_facing_angles();

  if(!isDefined(var5)) {
    var5 = "seek_target";
  }

  scripts\sp\statemachine::begin_fsm(var6, var5);
  level notify("scripted_sniper_spawned");
  thread scripts\engine\sp\utility::add_extra_autosave_check("scriptedSniper", &scripted_sniper_can_save, "Scripted sniper targeting player.");
}

function scripted_sniper_can_save() {
  if(!isDefined(level.fakesniper)) {
    return true;
  }

  if(!isDefined(level.fakesniper.currenttarget)) {
    return true;
  }

  if(level.fakesniper.currenttarget != level.player) {
    return true;
  }

  return false;
}

function script_control_enter() {
  self waittill("end_script_control");
  scripts\sp\statemachine::goto_state("seek_target");
}

function sniper_seek_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", &sniper_handle_shot_target]]);
  self.aimtargetoriginalposition = self.aimtarget.origin;
  self.pulsesinx = 0;
  self.pulsesinxrate = 5;
  var0 = gettime();
  GscBinSkip4(0x35);
}

function sweep_aim_points() {
  var0 = 0;
  var1 = 0;

  for(;;) {
    self.nextaimtarget = self.aimgroup[var1];
    var2 = distance(self.nextaimtarget.origin, self.aimtarget.origin) / 60;

    if(var2 > 0) {
      self.aimtarget moveTo(self.nextaimtarget.origin, var2, var2 / 10, var2 / 10);
      wait var2;
    }

    if(var0) {
      var1--;

      if(var1 < 0) {
        var1 = 1;
        var0 = 0;
      }

      continue;
    }

    var1++;

    if(var1 > self.aimgroup.size - 1) {
      var1 = self.aimgroup.size - 2;
      var0 = 1;
    }
  }
}

function sniper_tracking_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", &sniper_handle_shot_target_tracking]]);

  if(self.currenttarget == level.player) {
    if(isDefined(self.targetingplayerflag)) {
      scripts\engine\utility::flag_set(self.targetingplayerflag);
    }
  }

  self.lastframetargetposition = self.currenttarget.origin;
  self.lockedtotarget = 0;
  var0 = gettime();
  var1 = 0;
  self.projectedtargetpos = get_tagorigin(self.currenttarget, self.currenttargettag);
  var2 = 0;

  if(self.currenttarget == level.player) {
    foreach(var4 in self.slowreactweapons) {
      if(getweaponbasename(level.player.currentweapon) == var4) {
        var2 = 1;
      }
    }

    self.projectedtargetpos += level.player getvelocity() * self.maxtracktime;
  }

  var6 = distance(self.aimtarget.origin, self.projectedtargetpos);
  var7 = distance(self.projectedtargetpos, self.origin);
  var8 = distance(self.aimtarget.origin, self.origin);

  if(var8 > var7) {
    var9 = var6 + self.pullbackoffset;

    if(var9 > var8 - self.pullbackoffset) {
      var9 = var8 - self.pullbackoffset;
    }

    var10 = self.origin - self.aimtarget.origin;
    self.aimtarget.origin += vectorNormalize(var10) * var9;
  }

  var11 = scripts\engine\math::normalize_value(self.trackmindistancethreshold, self.trackmaxdistancethreshold, var6);
  var12 = scripts\engine\math::factor_value(self.mintracktime, self.maxtracktime, var11);
  var13 = 0;
  jumpiffalse(var2) LOC_000001b2;
  var12 += var12 * 0.2;
  var13 = 0.75;

  while(var1 < var12) {
    var1 = (gettime() - var0) / 1000;
    var14 = var12 - var1;

    if(var14 <= 0) {
      break;
    }

    self.projectedtargetpos = get_tagorigin(self.currenttarget, self.currenttargettag);

    if(self.currenttarget == level.player) {
      self.projectedtargetpos += level.player getvelocity() * var14;
    }

    var6 = distance(self.aimtarget.origin, self.projectedtargetpos);
    var15 = var6 / var14 * self.moveinterval;
    var16 = vectorNormalize(self.projectedtargetpos - self.aimtarget.origin);
    self.desiredaimpos = self.aimtarget.origin + var16 * var15;

    if(var15 > distance(self.aimtarget.origin, self.projectedtargetpos)) {
      break;
    }

    self.aimtarget moveTo(self.desiredaimpos, self.moveinterval);
    wait self.moveinterval;
  }

  self.lockedtotarget = 1;
  self.lostlocktime = gettime();

  for(;;) {
    self.desiredaimpos = sniper_locked_laser_to_target();
    self.aimtarget moveTo(self.desiredaimpos, 0.1);

    if((gettime() - self.lostlocktime) / 1000 > self.holdbeforeshoottime + var13) {
      self.targetmodifier = 0;
      var17 = vectortoangles(self.origin - self.currenttarget.origin);
      var18 = anglesToForward(var17);

      if(self.currenttarget == level.player) {
        var19 = vectorNormalize(self.currenttarget getvelocity());
      } else {
        var19 = vectorNormalize(self.lastframetargetposition - self.currenttarget.origin);
        self.lastframetargetposition = self.currenttarget.origin;
      }

      var20 = vectordot(var19, var19);

      if(self.currenttarget == level.player) {
        var21 = length2dsquared(self.currenttarget getvelocity()) / 50000;
      } else {
        var21 = length2dsquared(self.lastframetargetposition - self.currenttarget.origin) / 50000;
      }

      if(var21 < 0.5 && var21 > 0.3) {
        self.targetmodifier = 24;
      }

      if(self.currenttarget == level.player) {
        if(level.player issprintsliding()) {
          self.targetmodifier = 24;
        }
      }

      if(self.targetmodifier > 0) {
        var22 = randomfloat(100);

        if(var22 < 50) {
          var22 = -1;
        } else {
          var22 = 1;
        }

        var23 = randomfloat(100);

        if(var23 < 50) {
          var23 = -1;
        } else {
          var23 = 1;
        }

        var24 = (self.targetmodifier * var22, self.targetmodifier * var23, self.targetmodifier);
        sniper_fire_shot(self.aimtarget.origin + var24, 0);
      } else {
        sniper_fire_shot(self.aimtarget.origin, 1);
      }
    }

    wait 0.1;
  }
}

function sniper_tracking_target_update() {
  level endon("sniper_killed");
  self endon("death");

  if(self.currenttarget != level.player) {
    if(sniper_check_for_target(level.player)) {
      if((gettime() - self.losttargettime) / 1000 >= self.aquireplayertime) {
        scripts\sp\statemachine::goto_state("tracking_target");
      }
    }
  }

  if(!sniper_check_for_target(self.currenttarget)) {
    if(isDefined(self.currenttarget)) {
      self.lastknownposition = get_tagorigin(self.currenttarget, self.currenttargettag);
    }

    scripts\sp\statemachine::goto_state("lost_target");
    return;
  }

  if(isDefined(self.currenttarget)) {
    self.lastknownposition = get_tagorigin(self.currenttarget, self.currenttargettag);
    return;
  }
}

function sniper_tracking_target_exit() {
  if(isDefined(self.targetingplayerflag)) {
    scripts\engine\utility::flag_clear(self.targetingplayerflag);
  }

  self.lockedtotarget = 0;
}

function sniper_lost_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["request_shot_target", &sniper_handle_shot_target_tracking]]);
  self.currenttarget = undefined;
  self.donelosttargetshot = 0;
  self.aimtargetoriginalposition = self.aimtarget.origin;
  self.pulsesinx = 0;
  self.pulsesinxrate = 5;
  self.losttargettime = gettime();
}

function sniper_lost_target_update() {
  level endon("sniper_killed");
  self endon("death");

  if(sniper_check_for_target(self.currenttarget)) {
    scripts\sp\statemachine::goto_state("tracking_target");
  }

  self.pulsesin = sin(self.pulsesinx);
  self.pulsesinx = scripts\engine\math::wrap(0, 360, self.pulsesinx + self.pulsesinxrate);
  var0 = (self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude);
  self.aimtarget.origin = self.aimtargetoriginalposition + var0;
  var1 = (gettime() - self.lastshottime) / 1000;

  if(var1 > self.nextshotinterval) {
    sniper_fire_shot(self.aimtarget.origin + (0, 0, 8), 0);
  }

  if(var1 >= self.timetolosetarget) {
    scripts\sp\statemachine::goto_state("seek_target");
    return;
  }
}

function sniper_shoot_target_enter() {
  level endon("sniper_killed");
  self endon("death");
  self endon("changed_state");
  var0 = distance(self.desiredaimpos, self.aimtarget.origin);
  var1 = 1;

  if(var0 > 1000) {
    var1 += (var0 - 1000) / 1000;
  }

  self.aimtarget moveTo(self.desiredaimpos, var1);
  wait var1;
  wait 0.5;
  sniper_fire_shot(self.aimtarget.origin);
}

function sniper_reload_enter() {
  level endon("sniper_killed");
  self endon("death");
  self.laser laserforceoff();
  wait self.reloadtime;
  self.laser laserforceon();

  if(isDefined(self.currenttarget)) {
    scripts\sp\statemachine::goto_state("tracking_target");
    return;
  }

  scripts\sp\statemachine::goto_state("seek_target");
}

function sniper_reload_update() {
  if(!sniper_check_for_target(self.currenttarget)) {
    self.currenttarget = undefined;
    return;
  }
}

function sniper_death_enter() {
  level notify("end_sniper_checks");
  self notify("death");
  self.laser laserforceoff();
  self.snipermodel delete();

  if(isDefined(self.targetingplayerflag)) {
    scripts\engine\utility::flag_clear(self.targetingplayerflag);
  }

  if(isDefined(self.deathflag)) {
    scripts\engine\utility::flag_set(self.deathflag);
  }

  self delete();
}

function sniper_exit_nest() {
  level notify("end_sniper_checks");
  self notify("death");

  if(isDefined(self.targetingplayerflag)) {
    scripts\engine\utility::flag_clear(self.targetingplayerflag);
  }

  self.laser laserforceoff();
  var0 = scripts\engine\utility::getStruct("fake_sniper", "targetname");
  var1 = scripts\engine\utility::getStruct(self.pullbackstruct, "targetname");
  self moveTo(var0.origin, 0.5, 0.2, 0.2);
  self rotateTo(var0.angles, 0.5, 0.2, 0.2);
  wait 0.5;
  self moveTo(var1.origin, 2, 1, 0.5);
  self rotateTo(var1.angles, 2, 1, 0.5);
  wait 2;
  self.snipermodel delete();
  self delete();
}

function update_facing_angles() {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  self endon("death");

  for(;;) {
    self.laser.angles = vectortoangles(vectorNormalize(self.aimtarget.origin - self.origin));
    self.angles = vectortoangles(vectorNormalize(self.aimtarget.origin - self.origin));
    waitframe();
  }
}

function sniper_handle_death(var0) {
  scripts\sp\statemachine::goto_state("death");
}

function sniper_handle_shot_target(var0) {
  self.currentshottarget = var0[0];
  var1 = scripts\engine\utility::getStructArray(var0[0], "targetname");

  if(var1.size > 1) {
    var2 = get_unused_struct_from_array(var1);
    self.desiredaimpos = var2.origin;
  } else {
    self.desiredaimpos = var1[0].origin;
  }

  scripts\sp\statemachine::goto_state("shoot_target");
}

function sniper_handle_shot_target_tracking(var0) {
  if(isDefined(self.currenttarget) && self.currenttarget != level.player) {
    var1 = scripts\engine\utility::getStructArray(var0[0], "targetname");

    if(var1.size > 1) {
      var2 = get_unused_struct_from_array(var1);
      self.desiredaimpos = var2.origin;
    } else {
      self.desiredaimpos = var1[0].origin;
    }
  }

  scripts\sp\statemachine::goto_state("shoot_target");
}

function get_unused_struct_from_array(var0) {
  var1 = undefined;
  var2 = [];

  foreach(var4 in var0) {
    if(scripts\engine\utility::array_contains(self.usedtargets, var4.origin)) {
      var2 = var4.origin;
      continue;
    }

    var1 = var4;
    break;
  }

  if(!isDefined(var1)) {
    self.usedtargets = scripts\engine\utility::array_remove_array(self.usedtargets, var2);
    var1 = scripts\engine\utility::random(var0);
  }

  self.usedtargets[self.usedtargets.size] = var1.origin;
  return var1;
}

function sniper_handle_exit_nest() {
  scripts\sp\statemachine::goto_state("exit_nest");
}

function sniper_handle_script_control() {
  scripts\sp\statemachine::goto_state("script_control");
}

function sniper_check_for_target(var0) {
  if(isDefined(var0)) {
    var1 = vectortoangles(var0.origin - self.origin);
    var2 = anglesToForward(var1);
    var3 = anglesToForward(self.angles);
    var4 = vectordot(var2, var3);

    if(var4 < 0.3) {
      return false;
    }

    foreach(var6 in self.ignorevolumes) {
      if(var6 istouching(var0)) {
        return false;
      }
    }

    if(var0 == level.player) {
      if(self.targetinpronefoliage) {
        if(level.player getstance() == "prone") {
          return false;
        }
      } else if(self.targetincrouchfoliage) {
        if(level.player getstance() == "prone" || level.player getstance() == "crouch") {
          return false;
        }
      } else if(self.targetinstandfoliage) {
        return false;
      }
    }

    var8 = get_tagorigin(var0, "J_Spine4");

    if(scripts\engine\trace::ray_trace_passed(self.origin, var8, var0, self.contentoverride)) {
      self notify("new_target", var0, "J_Spine4", var8);
      self.currenttarget = var0;
      self.currenttargettag = "J_Spine4";
      self.targetposition = var8;
      return true;
    } else {
      var8 = get_tagorigin(var0, "j_head");

      if(scripts\engine\trace::ray_trace_passed(self.origin, var8, var0, self.contentoverride)) {
        self notify("new_target", var0, "j_head", var8);
        self.currenttarget = var0;
        self.currenttargettag = "j_head";
        self.targetposition = var8;
        return true;
      }
    }
  }

  return false;
}

function sniper_fire_shot(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    var0 = sniper_fire_perfect_shot();
  }

  magicbullet("iw8_sn_scripted", self.origin, var0, undefined);
  self.lastshottime = gettime();

  if(isDefined(self.currentshottarget) && self.currentshottarget != "") {
    level notify(self.currentshottarget);
    self.currentshottarget = "";
  }

  self.nextshotinterval = randomfloatrange(self.minshotinterval, self.maxshotinterval);
  level notify("sniper_fired");
  scripts\sp\statemachine::goto_state("reload");
}

function sniper_locked_laser_to_target() {
  if(self.currenttarget == level.player) {
    return (get_tagorigin(self.currenttarget, self.currenttargettag) + level.player getvelocity() / 3);
  }

  return get_tagorigin(self.currenttarget, self.currenttargettag);
}

function sniper_fire_perfect_shot() {
  return get_tagorigin(self.currenttarget, self.currenttargettag);
}

function sniper_track_allies() {
  level notify("stop_tracking_allies");
  level endon("stop_tracking_allies");
  level endon("sniper_killed");

  if(isDefined(level.fakesniper)) {
    level.fakesniper.ignoreallies = 0;
    wait 6;

    if(isDefined(level.fakesniper)) {
      level.fakesniper.ignoreallies = 1;
      return;
    }

    return;
  }
}

function sniper_shot_target(var0) {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  level endon(self.target);

  for(;;) {
    self waittill("trigger");
    var0 notify("request_shot_target", [self.target]);
    wait 3;
  }

  self delete();
}

function sniper_cover_group_trigger() {
  level endon("sniper_killed");
  level endon("end_sniper_checks");
  self.targets = scripts\engine\utility::getStructArray(self.script_parameters, "targetname");

  for(;;) {
    self waittill("trigger");
    level.fakesniper.aimgroup = self.targets;
  }
}

function sniper_setup_destruction_notify() {
  level endon("sniper_killed");

  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("sniper_nest", "targetname");

  if(!isDefined(var0[0])) {
    return;
  }

  level.snipernest = var0[0];
  level.snipernest waittillmatch("scriptableNotification", "sniper_dead");

  if(isDefined(self.deathflag) && !scripts\engine\utility::flag(self.deathflag)) {
    self notify("kill_sniper");
    return;
  }
}

function sniper_in_prone_foliage_trigger(var0) {
  if(isDefined(var0.deathflag)) {
    level endon(var0.deathflag);
  }

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var0.targetinpronefoliage = 1;
      waitframe();
    }

    var0.targetinpronefoliage = 0;
    waitframe();
  }
}

function sniper_in_crouch_foliage_trigger(var0) {
  if(isDefined(var0.deathflag)) {
    level endon(var0.deathflag);
  }

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var0.targetincrouchfoliage = 1;
      waitframe();
    }

    var0.targetincrouchfoliage = 0;
    waitframe();
  }
}

function sniper_in_standing_foliage_trigger(var0) {
  if(isDefined(var0.deathflag)) {
    level endon(var0.deathflag);
  }

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var0.targetinstandfoliage = 1;
      waitframe();
    }

    var0.targetinstandfoliage = 0;
    waitframe();
  }
}

function get_tagorigin(var0) {
  if(isPlayer(self)) {
    if(var0 == "j_head") {
      return level.player getEye();
    }

    var1 = level.player getstance();

    switch (var1) {
      case "stand":
        var2 = (0, 0, 12);
        break;
      case "crouch":
        var2 = (0, 0, 10);
        break;
      default:
        var2 = (0, 0, 2);
        break;
    }

    return (level.player getEye() - var2);
  }

  return self gettagorigin(var2);
}