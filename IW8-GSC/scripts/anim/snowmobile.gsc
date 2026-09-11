/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\snowmobile.gsc
***********************************************/

function main() {
  self.current_event = "none";
  self.shoot_while_driving_thread = undefined;
  snowmobile_geton();

  if(isDefined(self.drivingvehicle)) {
    main_driver();
    return;
  }

  main_passenger();
}

function snowmobile_geton() {
  self.grenadeawareness = 0;
  self.currentpose = "crouch";
  scripts\engine\sp\utility::disable_surprise();
  self.allowpain = 0;
  self.flashbangimmunity = 1;
  self.getoffvehiclefunc = &snowmobile_getoff;
  self.specialdeathfunc = &snowmobile_normal_death;
  self.disablebulletwhizbyreaction = 1;
}

function snowmobile_getoff() {
  self.allowpain = 1;
  self.flashbangimmunity = 0;
  scripts\common\ai::gun_recall();
  self.onsnowmobile = undefined;
  self.getoffvehiclefunc = undefined;
  self.specialdeathfunc = undefined;
  self.a.specialshootbehavior = undefined;
  self.disablebulletwhizbyreaction = undefined;
}

function main_driver() {
  var0 = self.ridingvehicle.driver_shooting || self.ridingvehicle.riders.size == 1;
  snowmobile_setanim_driver(var0);

  if(var0) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "left");
    self.rightaimlimit = -90;
    self.leftaimlimit = 90;
    scripts\anim\track::setanimaimweight(1, 0.2);
    thread snowmobile_trackshootentorpos_driver();
    thread snowmobile_loop_driver_shooting();
  } else {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
    thread snowmobile_loop_driver();
  }

  snowmobile_handle_events("driver");
}

function main_passenger() {
  snowmobile_setanim_passenger(self.ridingvehicle.passenger_shooting);

  if(self.ridingvehicle.passenger_shooting) {
    self.rightaimlimit = -180;
    self.leftaimlimit = 180;
    self.diraimlimit = 1;
    scripts\anim\track::setanimaimweight(1, 0.2);
    thread snowmobile_trackshootentorpos_passenger();
    thread snowmobile_loop_passenger_shooting();
  } else {
    thread snowmobile_loop_passenger();
  }

  snowmobile_handle_events("passenger");
}

function snowmobile_loop_driver() {
  self endon("death");
  self endon("killanimscript");
  var0 = "left2right";
  var1 = [];
  GscBinSkip0(0x2e, "left2right", getanimlength(scripts\anim\utility::animarray("left2right")));
}

#using_animtree("");

function snowmobile_loop_passenger() {
  self endon("death");
  self endon("killanimscript");
  self setanimknoball(scripts\anim\utility::animarray("hide"), %body, 1, 0);
  self setanimknob(scripts\anim\utility::animarray("drive"), 1, 0);

  for(;;) {
    var0 = scripts\common\vehicle_code::update_steering(self.ridingvehicle);
    self setanimlimited(%sm_lean, abs(var0), 0.05);

    if(var0 >= 0) {
      self setanimknoblimited(scripts\anim\utility::animarray("lean_right"), 1, 0.05);
    } else {
      self setanimknoblimited(scripts\anim\utility::animarray("lean_left"), 1, 0.05);
    }

    wait 0.05;
  }
}

function snowmobile_loop_driver_shooting() {
  self endon("death");
  self endon("killanimscript");
  var0 = 0.05;
  var1 = 0;
  self setanimknoball(%sm_aiming, %body, 1, 0);
  self setanimknob(scripts\anim\utility::animarray("idle"), 1, 0);

  for(;;) {
    if(self.current_event != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    var2 = scripts\common\vehicle_code::update_steering(self.ridingvehicle);
    var3 = 1 - abs(var2);
    var4 = max(0, 0 - var2);
    var5 = max(0, var2);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_center"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_left"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_right"), var5, var0);

    if(self.bulletsinclip <= 0) {
      scripts\anim\weaponlist::refillclip();
      var1 = gettime() + 3000;
    }

    if(var1 <= gettime()) {
      snowmobile_start_shooting();
    }

    self setanimknoblimited(scripts\anim\utility::animarray("add_aim_left_center"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_left_left"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_left_right"), var5, var0);
    self setanimknoblimited(scripts\anim\utility::animarray("add_aim_right_center"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_right_left"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_right_right"), var5, var0);
    thread snowmobile_stop_shooting();
    wait 0.05;
  }
}

function snowmobile_loop_passenger_shooting() {
  self endon("death");
  self endon("killanimscript");
  var0 = 0.05;
  self setanimknoball(%sm_aiming, %body, 1, 0);
  self setanimknob(scripts\anim\utility::animarray("idle"), 1, 0);

  for(;;) {
    if(self.current_event != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    if(snowmobile_reload()) {
      continue;
    }

    var1 = scripts\common\vehicle_code::update_steering(self.ridingvehicle);
    var2 = 1 - abs(var1);
    var3 = max(0, 0 - var1);
    var4 = max(0, var1);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_center"), var2, var0);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_left"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("straight_level_right"), var4, var0);
    snowmobile_start_shooting();
    self setanimlimited(scripts\anim\utility::animarray("aim_left_center"), var2, var0);
    self setanimlimited(scripts\anim\utility::animarray("aim_left_left"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("aim_left_right"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("aim_right_center"), var2, var0);
    self setanimlimited(scripts\anim\utility::animarray("aim_right_left"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("aim_right_right"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backleft_center"), var2, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backleft_left"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backleft_right"), var4, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backright_center"), var2, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backright_left"), var3, var0);
    self setanimlimited(scripts\anim\utility::animarray("add_aim_backright_right"), var4, var0);

    if(isPlayer(self.enemy)) {
      self updateplayersightaccuracy();
    }

    wait 0.05;
    thread snowmobile_stop_shooting();
  }
}

function snowmobile_do_event(var0) {
  self endon("death");
  self.ridingvehicle.steering_enable = 0;
  self setflaggedanimknoblimitedrestart("snowmobile_event", var0, 1, 0.17);
  scripts\anim\notetracks::donotetracks("snowmobile_event", &snowmobile_waitfor_start_lean);
  self setanimknoblimited(scripts\anim\utility::animarray("event_restore"), 1, 0.1);
  self.ridingvehicle.steering_enable = 1;
  self.current_event = "none";
  self notify("snowmobile_event_finished");
}

function snowmobile_handle_events(var0) {
  self endon("death");
  self endon("killanimscript");
  var1 = self.ridingvehicle;

  for(;;) {
    if(var1.event["jump"][var0]) {
      var1.event["jump"][var0] = 0;
      self notify("snowmobile_event_occurred");
      self.current_event = "jump";
      var1.steering_enable = 0;
      self setflaggedanimknoblimitedrestart("jump", scripts\anim\utility::animarray("event_jump"), 1, 0.17);
    }

    if(var1.event["bump"][var0]) {
      var1.event["bump"][var0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big") {
        thread snowmobile_do_event(scripts\anim\utility::animarray("event_bump"));
      }
    }

    if(var1.event["bump_big"][var0]) {
      var1.event["bump_big"][var0] = 0;
      self notify("snowmobile_event_occurred");
      self.current_event = "bump_big";
      thread snowmobile_do_event(scripts\anim\utility::animarray("event_bump_big"));
    }

    if(var1.event["sway_left"][var0]) {
      var1.event["sway_left"][var0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big") {
        thread snowmobile_do_event(scripts\anim\utility::animarray("event_sway")["left"]);
      }
    }

    if(var1.event["sway_right"][var0]) {
      var1.event["sway_right"][var0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big") {
        thread snowmobile_do_event(scripts\anim\utility::animarray("event_sway")["right"]);
      }
    }

    wait 0.05;
  }
}

function snowmobile_start_shooting() {
  self notify("want_shoot_while_driving");
  self setanim(%sm_add_fire, 1, 0.2);

  if(isDefined(self.shoot_while_driving_thread)) {
    return;
  }

  self.shoot_while_driving_thread = 1;
  thread snowmobile_decide_shoot();
  thread snowmobile_shoot();
}

function snowmobile_stop_shooting() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait 0.05;
  self notify("end_shoot_while_driving");
  self.shoot_while_driving_thread = undefined;
  self clearanim(%sm_add_fire, 0.2);
}

function snowmobile_decide_shoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a.specialshootbehavior = &snowmobileshootbehavior;
  snowmobile_decide_shoot_internal();
  self.shoot_while_driving_thread = undefined;
}

function snowmobile_decide_shoot_internal() {
  self endon("snowmobile_event_occurred");
  scripts\anim\shoot_behavior::decidewhatandhowtoshoot("normal");
}

function snowmobileshootbehavior() {
  if(!isDefined(self.enemy)) {
    self.shootent = undefined;
    self.shootpos = undefined;
    self.shootstyle = "none";
    return;
  }

  self.shootent = self.enemy;
  self.shootpos = self.enemy getshootatpos();
  var0 = distancesquared(self.origin, self.enemy.origin);

  if(var0 < 1000000) {
    self.shootstyle = "full";
  } else if(var0 < 4000000) {
    self.shootstyle = "burst";
  } else {
    self.shootstyle = "single";
  }

  if(isDefined(self.enemy.vehicle)) {
    var1 = 0.5;
    var2 = self.shootent.vehicle;
    var3 = self.ridingvehicle;
    var4 = var3.origin - var2.origin;
    var5 = anglesToForward(var2.angles);
    var6 = anglestoright(var2.angles);
    var7 = vectordot(var4, var5);

    if(var7 < 0) {
      var8 = var2 vehicle_getspeed() * var1;
      var8 *= 17.6;

      if(var8 > 50) {
        var9 = vectordot(var4, var6);
        var9 /= 3;

        if(var9 > 128) {
          var9 = 128;
        } else if(var9 < -128) {
          var9 = -128;
        }

        if(var9 > 0) {
          var9 = 128 - var9;
        } else {
          var9 = -128 - var9;
        }

        self.shootent = undefined;
        self.shootpos = var2.origin + var8 * var5 + var9 * var6;
        return;
      }

      return;
    }

    return;
  }
}

function snowmobile_shoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self notify("doing_shootWhileDriving");
  self endon("doing_shootWhileDriving");

  for(;;) {
    if(!self.bulletsinclip) {
      wait 0.5;
      continue;
    }

    scripts\anim\combat_utility::shootuntilshootbehaviorchange();
  }
}

function snowmobile_reload() {
  if(!self.ridingvehicle.steering_enable) {
    return false;
  }

  if(!scripts\anim\utility_common::needtoreload(0)) {
    return false;
  }

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return false;
  }

  snowmobile_reload_internal();
  self notify("abort_reload");
  return true;
}

function snowmobile_reload_internal() {
  self endon("snowmobile_event_occurred");
  self.stop_aiming_for_reload = 1;
  self waittill("start_blending_reload");
  self setanim(%sm_aiming, 0, 0.25);
  self setflaggedanimrestart("gun_down", scripts\anim\utility::animarray("gun_down"), 1, 0.25);
  scripts\anim\notetracks::donotetracks("gun_down");
  self clearanim(scripts\anim\utility::animarray("gun_down"), 0);
  self setflaggedanimknoballrestart("reload_anim", scripts\anim\utility::animarray("reload"), %body, 1, 0.25);
  scripts\anim\notetracks::donotetracks("reload_anim");
  self clearanim(%sm_reload, 0.2);
  self setflaggedanimrestart("gun_up", scripts\anim\utility::animarray("gun_up"), 1, 0.25);
  self.gun_up_for_reload = 1;
  scripts\anim\notetracks::donotetracks("gun_up", &snowmobile_waitfor_start_aim);
  self.stop_aiming_for_reload = undefined;
  self clearanim(%sm_reload, 0.1);
  self setanim(%sm_aiming, 1, 0.1);

  if(isDefined(self.gun_up_for_reload)) {
    self.gun_up_for_reload = undefined;
    scripts\anim\notetracks::donotetracks("gun_up", &snowmobile_waitfor_end);
    self clearanim(scripts\anim\utility::animarray("gun_up"), 0);
    return;
  }
}

function snowmobile_waitfor_start_aim(var0) {
  if(var0 == "start_aim") {
    return 1;
  }
}

function snowmobile_waitfor_end(var0) {
  if(var0 == "end") {
    return 1;
  }
}

function snowmobile_waitfor_start_lean(var0) {
  if(var0 == "start_lean") {
    return 1;
  }
}

function snowmobile_trackshootentorpos_driver() {
  self endon("killanimscript");
  self endon("stop tracking");
  var0 = 0.05;
  var1 = 8;
  var2 = 0;
  var3 = 0;
  var4 = 1;

  for(;;) {
    scripts\anim\track::incranimaimweight();
    var5 = (self.origin[0], self.origin[1], self getEye()[2]);
    var6 = self.shootpos;

    if(isDefined(self.shootent)) {
      var6 = self.shootent getshootatpos();
    }

    if(!isDefined(var6)) {
      var3 = 0;
      var7 = self getanglestolikelyenemypath();

      if(isDefined(var7)) {
        var3 = angleclamp180(var7[1] - self.angles[1]);
      }
    } else {
      var8 = var6 - var5;
      var9 = vectortoangles(var8);
      var3 = var9[1] - self.angles[1];
      var3 = angleclamp180(var3);
    }

    if(var3 < self.rightaimlimit || var3 > self.leftaimlimit) {
      var3 = 0;
    }

    if(var4) {
      var4 = 0;
    } else {
      var10 = var3 - var2;

      if(abs(var10) > var1) {
        var3 = var2 + var1 * scripts\engine\utility::sign(var10);
      }
    }

    var2 = var3;
    var11 = min(max(var3, 0), 90) / 90 * self.a.aimweight;
    var12 = min(max(0 - var3, 0), 90) / 90 * self.a.aimweight;
    self setanimlimited(%sm_aim_4, var11, var0);
    self setanimlimited(%sm_aim_6, var12, var0);
    wait 0.05;
  }
}

function snowmobile_trackshootentorpos_passenger() {
  self endon("killanimscript");
  self endon("stop tracking");
  var0 = 0.05;
  var1 = 5;
  var2 = 20;
  var3 = 15;
  var4 = 40;
  var5 = 30;
  var6 = 0;
  var7 = 0;
  var8 = 1;

  for(;;) {
    scripts\anim\track::incranimaimweight();
    var9 = (self.origin[0], self.origin[1], self getEye()[2]);
    var10 = self.shootpos;

    if(isDefined(self.shootent)) {
      var10 = self.shootent getshootatpos();
    }

    if(!isDefined(var10)) {
      var7 = 0;
      var11 = self getanglestolikelyenemypath();

      if(isDefined(var11)) {
        var7 = angleclamp180(var11[1] - self.angles[1]);
      }
    } else {
      var12 = var10 - var9;
      var13 = vectortoangles(var12);
      var7 = var13[1] - self.angles[1];
      var7 = angleclamp180(var7);
    }

    if(isDefined(self.stop_aiming_for_reload) || var7 < 0 && (var7 - self.rightaimlimit) * self.diraimlimit > 0 || var7 > 0 && (var7 - self.leftaimlimit) * self.diraimlimit < 0) {
      var7 = 0;
    }

    if(var8) {
      var8 = 0;
    } else {
      if(var6 < -180 + var4 && var7 > 180 - var5) {
        var7 = -179;
      }

      if(var6 > 180 - var4 && var7 < -180 + var5) {
        var7 = 179;
      }

      var14 = var7 - var6;
      var15 = (var2 - var1) * abs(var14) / 180 + var1;

      if(isDefined(self.stop_aiming_for_reload)) {
        var15 = var3;

        if(abs(var6) < 45) {
          self notify("start_blending_reload");
        }
      }

      if(abs(var14) > var15) {
        var7 = var6 + var15 * scripts\engine\utility::sign(var14);
      }
    }

    var6 = var7;
    var16 = max(-90 + var7, 0) / 90 * self.a.aimweight;
    var17 = min(max(var7, 0), 90) / 90 * self.a.aimweight;
    var18 = max(90 - abs(var7), 0) / 90 * self.a.aimweight;
    var19 = min(max(0 - var7, 0), 90) / 90 * self.a.aimweight;
    var20 = max(-90 - var7, 0) / 90 * self.a.aimweight;
    self setanimlimited(%sm_aim_1, var16, var0);
    self setanimlimited(%sm_aim_4_delta, var17, var0);
    self setanimlimited(%sm_aim_5_delta, var18, var0);
    self setanimlimited(%sm_aim_6_delta, var19, var0);
    self setanimlimited(%sm_aim_3, var20, var0);
    wait 0.05;
  }
}

function snowmobile_get_death_anim(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = 0;

  for(var6 = 0; var6 < var0.size; var6++) {
    var7 = scripts\engine\utility::absangleclamp180(var2 - var1[var6]);

    if(!isDefined(var3) || var7 < var5) {
      var4 = var3;
      var3 = var0[var6];
      var5 = var7;
      continue;
    }

    if(!isDefined(var4)) {
      var4 = var0[var6];
    }
  }

  var8 = var3;

  if(isDefined(anim.prevsnowmobiledeath) && var8 == anim.prevsnowmobiledeath && gettime() - anim.prevsnowmobiledeathtime < 500) {
    var8 = var4;
  }

  anim.prevsnowmobiledeath = var8;
  anim.prevsnowmobiledeathtime = gettime();
  return var8;
}

function snowmobile_death_launchslide() {
  var0 = self.ridingvehicle;
  var1 = var0.prevframevelocity;
  var1 = (var1[0], var1[1], randomfloatrange(200, 400)) * 0.75;

  if(lengthsquared(var1) > 1000000) {
    var1 = vectorNormalize(var1) * 1000;
  }

  var2 = spawn("script_origin", self.origin);
  var2 moveslide((0, 0, 40), 15, var1);
  self linkTo(var2);
  thread deleteshortly();
}

function snowmobile_normal_death() {
  var0 = [];
  GscBinSkip0(0x2e, 0, level.scr_anim["snowmobile"]["small"]["death"]["back"]);
}

function snowmobile_collide_death() {
  var0 = self.ridingvehicle;

  if(!isDefined(var0)) {
    return snowmobile_normal_death();
  }

  var1 = var0.prevframevelocity;
  snowmobile_death_launchslide();
  var2 = vectortoangles(var1);
  var3 = angleclamp180(var2[1] - self.angles[1]);
  var4 = [];
  GscBinSkip0(0x2e, 0, level.scr_anim["snowmobile"]["big"]["death"]["back"]);
}

function deleteshortly() {
  var0 = self.origin;

  for(var1 = 0; var1 < 60; var1++) {
    wait 0.05;
    var0 = self.origin;
  }

  wait 3;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function snowmobile_setanim_common(var0) {
  self.a.array["idle"] = level.scr_anim["snowmobile"][var0]["idle"];
  self.a.array["drive"] = level.scr_anim["snowmobile"][var0]["drive"];
  self.a.array["fire"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["single"] = scripts\anim\utility::array(level.scr_anim["snowmobile"][var0]["single"]);
  self.a.array["burst2"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["burst3"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["burst4"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["burst5"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["burst6"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["semi2"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["semi3"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["semi4"] = level.scr_anim["snowmobile"][var0]["fire"];
  self.a.array["semi5"] = level.scr_anim["snowmobile"][var0]["fire"];
}

function snowmobile_setanim_driver(var0) {
  self.a.array = [];
  snowmobile_setanim_common("driver");
  self.a.array["left2right"] = level.scr_anim["snowmobile"]["driver"]["left2right"];
  self.a.array["right2left"] = level.scr_anim["snowmobile"]["driver"]["right2left"];
  self.a.array["straight_level_left"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["left"];
  self.a.array["straight_level_center"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["center"];
  self.a.array["straight_level_right"] = level.scr_anim["snowmobile"]["driver"]["straight_level"]["right"];
  self.a.array["add_aim_left_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["left"];
  self.a.array["add_aim_left_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["center"];
  self.a.array["add_aim_left_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["right"];
  self.a.array["add_aim_right_left"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["left"];
  self.a.array["add_aim_right_center"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["center"];
  self.a.array["add_aim_right_right"] = level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["right"];

  if(var0) {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["shoot_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_right"];
    self.a.array["event_restore"] = % sm_aiming;
    return;
  }

  self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["drive_jump"];
  self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["drive_bump"];
  self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["drive_bump_big"];
  self.a.array["event_sway"] = [];
  self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_left"];
  self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_right"];
  self.a.array["event_restore"] = % sm_turn;
}

function snowmobile_setanim_passenger(var0) {
  self.a.array = [];
  snowmobile_setanim_common("passenger");
  self.a.array["hide"] = level.scr_anim["snowmobile"]["passenger"]["hide"];
  self.a.array["lean_left"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["left"];
  self.a.array["lean_right"] = level.scr_anim["snowmobile"]["passenger"]["add_lean"]["right"];
  self.a.array["reload"] = level.scr_anim["snowmobile"]["passenger"]["reload"];
  self.a.array["gun_up"] = level.scr_anim["snowmobile"]["passenger"]["gun_up"];
  self.a.array["gun_down"] = level.scr_anim["snowmobile"]["passenger"]["gun_down"];
  self.a.array["aim_left_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["left"];
  self.a.array["aim_left_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["center"];
  self.a.array["aim_left_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_left"]["right"];
  self.a.array["aim_right_left"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["left"];
  self.a.array["aim_right_center"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["center"];
  self.a.array["aim_right_right"] = level.scr_anim["snowmobile"]["passenger"]["aim_right"]["right"];
  self.a.array["add_aim_backleft_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["left"];
  self.a.array["add_aim_backleft_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["center"];
  self.a.array["add_aim_backleft_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["right"];
  self.a.array["add_aim_backright_left"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["left"];
  self.a.array["add_aim_backright_center"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["center"];
  self.a.array["add_aim_backright_right"] = level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["right"];
  self.a.array["straight_level_left"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["left"];
  self.a.array["straight_level_center"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["center"];
  self.a.array["straight_level_right"] = level.scr_anim["snowmobile"]["passenger"]["straight_level"]["right"];

  if(var0) {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["drive_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_right"];
    self.a.array["event_restore"] = % sm_aiming;
    return;
  }

  self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["hide_jump"];
  self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump"];
  self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump_big"];
  self.a.array["event_sway"] = [];
  self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_left"];
  self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_right"];
  self.a.array["event_restore"] = % sm_turn;
}