/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\snowmobile.gsc
**************************************/

main() {
  self.current_event = "none";
  self.shoot_while_driving_thread = undefined;
  snowmobile_geton();

  if(isDefined(self.drivingvehicle))
    main_driver();
  else
    main_passenger();
}

snowmobile_geton() {
  self.grenadeawareness = 0;
  self.a.pose = "crouch";
  maps\_utility::disable_surprise();
  self.allowpain = 0;
  self.flashbangimmunity = 1;
  self.getoffvehiclefunc = ::snowmobile_getoff;
  self.specialdeathfunc = ::snowmobile_normal_death;
  self.disablebulletwhizbyreaction = 1;
}

snowmobile_getoff() {
  self.allowpain = 1;
  self.flashbangimmunity = 0;
  maps\_utility::gun_recall();
  self.onsnowmobile = undefined;
  self.getoffvehiclefunc = undefined;
  self.specialdeathfunc = undefined;
  self.a.specialshootbehavior = undefined;
  self.disablebulletwhizbyreaction = undefined;
}

main_driver() {
  var_0 = self.ridingvehicle.driver_shooting || self.ridingvehicle.riders.size == 1;
  snowmobile_setanim_driver(var_0);

  if(var_0) {
    animscripts\shared::placeweaponon(self.primaryweapon, "left");
    self.rightaimlimit = 90;
    self.leftaimlimit = -90;
    animscripts\track::setanimaimweight(1, 0.2);
    thread snowmobile_trackshootentorpos_driver();
    thread snowmobile_loop_driver_shooting();
  } else {
    animscripts\shared::placeweaponon(self.primaryweapon, "none");
    thread snowmobile_loop_driver();
  }

  snowmobile_handle_events("driver");
}

main_passenger() {
  snowmobile_setanim_passenger(self.ridingvehicle.passenger_shooting);

  if(self.ridingvehicle.passenger_shooting) {
    self.rightaimlimit = 180;
    self.leftaimlimit = -180;
    self.diraimlimit = 1;
    animscripts\track::setanimaimweight(1, 0.2);
    thread snowmobile_trackshootentorpos_passenger();
    thread snowmobile_loop_passenger_shooting();
  } else
    thread snowmobile_loop_passenger();

  snowmobile_handle_events("passenger");
}

#using_animtree("generic_human");

snowmobile_loop_driver() {
  self endon("death");
  self endon("killanimscript");
  var_0 = "left2right";
  var_1 = [];
  var_1["left2right"] = getanimlength(animscripts\utility::animarray("left2right"));
  var_1["right2left"] = getanimlength(animscripts\utility::animarray("right2left"));
  self setanimknoball(%sm_turn, %body, 1, 0);
  self setanim(animscripts\utility::animarray("drive"), 1, 0);
  self setanimknob(animscripts\utility::animarray(var_0), 1, 0);
  self setanimtime(animscripts\utility::animarray(var_0), 0.5);

  for(;;) {
    if(self.ridingvehicle.steering_enable) {
      var_2 = 0.5 * (1 + maps\_vehicle_code::update_steering(self.ridingvehicle));
      var_3 = self getanimtime(animscripts\utility::animarray(var_0));

      if(var_0 == "right2left")
        var_3 = 1 - var_3;

      var_4 = 20 * abs(var_3 - var_2);

      if(var_3 < var_2) {
        var_0 = "left2right";
        var_4 = var_4 * var_1["left2right"];
      } else {
        var_0 = "right2left";
        var_4 = var_4 * var_1["right2left"];
        var_3 = 1 - var_3;
      }
    } else {
      var_0 = "left2right";
      var_4 = 0;
      var_3 = 0.5;
    }

    self setanimknoblimited(animscripts\utility::animarray(var_0), 1, 0.1, var_4);
    self setanimtime(animscripts\utility::animarray(var_0), var_3);
    wait 0.05;
  }
}

snowmobile_loop_passenger() {
  self endon("death");
  self endon("killanimscript");
  self setanimknoball(animscripts\utility::animarray("hide"), %body, 1, 0);
  self setanimknob(animscripts\utility::animarray("drive"), 1, 0);

  for(;;) {
    var_0 = maps\_vehicle_code::update_steering(self.ridingvehicle);
    self setanimlimited(%sm_lean, abs(var_0), 0.05);

    if(var_0 >= 0)
      self setanimknoblimited(animscripts\utility::animarray("lean_right"), 1, 0.05);
    else
      self setanimknoblimited(animscripts\utility::animarray("lean_left"), 1, 0.05);

    wait 0.05;
  }
}

snowmobile_loop_driver_shooting() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  var_1 = 0;
  self setanimknoball(%sm_aiming, %body, 1, 0);
  self setanimknob(animscripts\utility::animarray("idle"), 1, 0);

  for(;;) {
    if(self.current_event != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    var_2 = maps\_vehicle_code::update_steering(self.ridingvehicle);
    var_3 = 1 - abs(var_2);
    var_4 = max(0, 0 - var_2);
    var_5 = max(0, var_2);
    self setanimlimited(animscripts\utility::animarray("straight_level_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("straight_level_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("straight_level_right"), var_5, var_0);

    if(self.bulletsinclip <= 0) {
      animscripts\weaponlist::refillclip();
      var_1 = gettime() + 3000;
    }

    if(var_1 <= gettime())
      snowmobile_start_shooting();

    self setanimknoblimited(animscripts\utility::animarray("add_aim_left_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_left_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_left_right"), var_5, var_0);
    self setanimknoblimited(animscripts\utility::animarray("add_aim_right_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_right_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_right_right"), var_5, var_0);
    thread snowmobile_stop_shooting();
    wait 0.05;
  }
}

snowmobile_loop_passenger_shooting() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  self setanimknoball(%sm_aiming, %body, 1, 0);
  self setanimknob(animscripts\utility::animarray("idle"), 1, 0);

  for(;;) {
    if(self.current_event != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    if(snowmobile_reload()) {
      continue;
    }
    var_1 = maps\_vehicle_code::update_steering(self.ridingvehicle);
    var_2 = 1 - abs(var_1);
    var_3 = max(0, 0 - var_1);
    var_4 = max(0, var_1);
    self setanimlimited(animscripts\utility::animarray("straight_level_center"), var_2, var_0);
    self setanimlimited(animscripts\utility::animarray("straight_level_left"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("straight_level_right"), var_4, var_0);
    snowmobile_start_shooting();
    self setanimlimited(animscripts\utility::animarray("aim_left_center"), var_2, var_0);
    self setanimlimited(animscripts\utility::animarray("aim_left_left"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("aim_left_right"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("aim_right_center"), var_2, var_0);
    self setanimlimited(animscripts\utility::animarray("aim_right_left"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("aim_right_right"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backleft_center"), var_2, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backleft_left"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backleft_right"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backright_center"), var_2, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backright_left"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_backright_right"), var_4, var_0);

    if(isplayer(self.enemy))
      self updateplayersightaccuracy();

    wait 0.05;
    thread snowmobile_stop_shooting();
  }
}

snowmobile_do_event(var_0) {
  self endon("death");
  self.ridingvehicle.steering_enable = 0;
  self setflaggedanimknoblimitedrestart("snowmobile_event", var_0, 1, 0.17);
  animscripts\shared::donotetracks("snowmobile_event", ::snowmobile_waitfor_start_lean);
  self setanimknoblimited(animscripts\utility::animarray("event_restore"), 1, 0.1);
  self.ridingvehicle.steering_enable = 1;
  self.current_event = "none";
  self notify("snowmobile_event_finished");
}

snowmobile_handle_events(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = self.ridingvehicle;

  for(;;) {
    if(var_1.event["jump"][var_0]) {
      var_1.event["jump"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      self.current_event = "jump";
      var_1.steering_enable = 0;
      self setflaggedanimknoblimitedrestart("jump", animscripts\utility::animarray("event_jump"), 1, 0.17);
    }

    if(var_1.event["bump"][var_0]) {
      var_1.event["bump"][var_0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big")
        thread snowmobile_do_event(animscripts\utility::animarray("event_bump"));
    }

    if(var_1.event["bump_big"][var_0]) {
      var_1.event["bump_big"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      self.current_event = "bump_big";
      thread snowmobile_do_event(animscripts\utility::animarray("event_bump_big"));
    }

    if(var_1.event["sway_left"][var_0]) {
      var_1.event["sway_left"][var_0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big")
        thread snowmobile_do_event(animscripts\utility::animarray("event_sway")["left"]);
    }

    if(var_1.event["sway_right"][var_0]) {
      var_1.event["sway_right"][var_0] = 0;
      self notify("snowmobile_event_occurred");

      if(self.current_event != "bump_big")
        thread snowmobile_do_event(animscripts\utility::animarray("event_sway")["right"]);
    }

    wait 0.05;
  }
}

snowmobile_start_shooting() {
  self notify("want_shoot_while_driving");
  self setanim(%sm_add_fire, 1, 0.2);

  if(isDefined(self.shoot_while_driving_thread)) {
    return;
  }
  self.shoot_while_driving_thread = 1;
  thread snowmobile_decide_shoot();
  thread snowmobile_shoot();
}

snowmobile_stop_shooting() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait 0.05;
  self notify("end_shoot_while_driving");
  self.shoot_while_driving_thread = undefined;
  self clearanim(%sm_add_fire, 0.2);
}

snowmobile_decide_shoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a.specialshootbehavior = ::snowmobileshootbehavior;
  snowmobile_decide_shoot_internal();
  self.shoot_while_driving_thread = undefined;
}

snowmobile_decide_shoot_internal() {
  self endon("snowmobile_event_occurred");
  animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

snowmobileshootbehavior() {
  if(!isDefined(self.enemy)) {
    self.shootent = undefined;
    self.shootpos = undefined;
    self.shootstyle = "none";
    return;
  }

  self.shootent = self.enemy;
  self.shootpos = self.enemy getshootatpos();
  var_0 = distancesquared(self.origin, self.enemy.origin);

  if(var_0 < 1000000)
    self.shootstyle = "full";
  else if(var_0 < 4000000)
    self.shootstyle = "burst";
  else
    self.shootstyle = "single";

  if(isDefined(self.enemy.vehicle)) {
    var_1 = 0.5;
    var_2 = self.shootent.vehicle;
    var_3 = self.ridingvehicle;
    var_4 = var_3.origin - var_2.origin;
    var_5 = anglesToForward(var_2.angles);
    var_6 = anglestoright(var_2.angles);
    var_7 = vectordot(var_4, var_5);

    if(var_7 < 0) {
      var_8 = var_2 vehicle_getspeed() * var_1;
      var_8 = var_8 * 17.6;

      if(var_8 > 50) {
        var_9 = vectordot(var_4, var_6);
        var_9 = var_9 / 3;

        if(var_9 > 128)
          var_9 = 128;
        else if(var_9 < -128)
          var_9 = -128;

        if(var_9 > 0)
          var_9 = 128 - var_9;
        else
          var_9 = -128 - var_9;

        self.shootent = undefined;
        self.shootpos = var_2.origin + var_8 * var_5 + var_9 * var_6;
        return;
      }
    }
  }
}

snowmobile_shoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self notify("doing_shootWhileDriving");
  self endon("doing_shootWhileDriving");

  for(;;) {
    if(!self.bulletsinclip) {
      wait 0.5;
      continue;
    }

    animscripts\combat_utility::shootuntilshootbehaviorchange();
  }
}

snowmobile_reload() {
  if(!self.ridingvehicle.steering_enable)
    return 0;

  if(!animscripts\combat_utility::needtoreload(0))
    return 0;

  if(!animscripts\utility::usingriflelikeweapon())
    return 0;

  snowmobile_reload_internal();
  self notify("abort_reload");
  return 1;
}

snowmobile_reload_internal() {
  self endon("snowmobile_event_occurred");
  self.stop_aiming_for_reload = 1;
  self waittill("start_blending_reload");
  self setanim(%sm_aiming, 0, 0.25);
  self setflaggedanimrestart("gun_down", animscripts\utility::animarray("gun_down"), 1, 0.25);
  animscripts\shared::donotetracks("gun_down");
  self clearanim(animscripts\utility::animarray("gun_down"), 0);
  self setflaggedanimknoballrestart("reload_anim", animscripts\utility::animarray("reload"), %body, 1, 0.25);
  animscripts\shared::donotetracks("reload_anim");
  self clearanim(%sm_reload, 0.2);
  self setflaggedanimrestart("gun_up", animscripts\utility::animarray("gun_up"), 1, 0.25);
  self.gun_up_for_reload = 1;
  animscripts\shared::donotetracks("gun_up", ::snowmobile_waitfor_start_aim);
  self.stop_aiming_for_reload = undefined;
  self clearanim(%sm_reload, 0.1);
  self setanim(%sm_aiming, 1, 0.1);

  if(isDefined(self.gun_up_for_reload)) {
    self.gun_up_for_reload = undefined;
    animscripts\shared::donotetracks("gun_up", ::snowmobile_waitfor_end);
    self clearanim(animscripts\utility::animarray("gun_up"), 0);
  }
}

snowmobile_waitfor_start_aim(var_0) {
  if(var_0 == "start_aim")
    return 1;
}

snowmobile_waitfor_end(var_0) {
  if(var_0 == "end")
    return 1;
}

snowmobile_waitfor_start_lean(var_0) {
  if(var_0 == "start_lean")
    return 1;
}

snowmobile_trackshootentorpos_driver() {
  self endon("killanimscript");
  self endon("stop tracking");
  var_0 = 0.05;
  var_1 = 8;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    animscripts\track::incranimaimweight();
    var_5 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_6 = self.shootpos;

    if(isDefined(self.shootent))
      var_6 = self.shootent getshootatpos();

    if(!isDefined(var_6)) {
      var_3 = 0;
      var_7 = self getanglestolikelyenemypath();

      if(isDefined(var_7))
        var_3 = angleclamp180(self.angles[1] - var_7[1]);
    } else {
      var_8 = var_6 - var_5;
      var_9 = vectortoangles(var_8);
      var_3 = self.angles[1] - var_9[1];
      var_3 = angleclamp180(var_3);
    }

    if(var_3 > self.rightaimlimit || var_3 < self.leftaimlimit)
      var_3 = 0;

    if(var_4)
      var_4 = 0;
    else {
      var_10 = var_3 - var_2;

      if(abs(var_10) > var_1)
        var_3 = var_2 + var_1 * common_scripts\utility::sign(var_10);
    }

    var_2 = var_3;
    var_11 = min(max(0 - var_3, 0), 90) / 90 * self.a.aimweight;
    var_12 = min(max(var_3, 0), 90) / 90 * self.a.aimweight;
    self setanimlimited(%sm_aim_4, var_11, var_0);
    self setanimlimited(%sm_aim_6, var_12, var_0);
    wait 0.05;
  }
}

snowmobile_trackshootentorpos_passenger() {
  self endon("killanimscript");
  self endon("stop tracking");
  var_0 = 0.05;
  var_1 = 5;
  var_2 = 20;
  var_3 = 15;
  var_4 = 40;
  var_5 = 30;
  var_6 = 0;
  var_7 = 0;
  var_8 = 1;

  for(;;) {
    animscripts\track::incranimaimweight();
    var_9 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_10 = self.shootpos;

    if(isDefined(self.shootent))
      var_10 = self.shootent getshootatpos();

    if(!isDefined(var_10)) {
      var_7 = 0;
      var_11 = self getanglestolikelyenemypath();

      if(isDefined(var_11))
        var_7 = angleclamp180(self.angles[1] - var_11[1]);
    } else {
      var_12 = var_10 - var_9;
      var_13 = vectortoangles(var_12);
      var_7 = self.angles[1] - var_13[1];
      var_7 = angleclamp180(var_7);
    }

    if(isDefined(self.stop_aiming_for_reload) || var_7 > 0 && (var_7 - self.rightaimlimit) * self.diraimlimit > 0 || var_7 < 0 && (var_7 - self.leftaimlimit) * self.diraimlimit < 0)
      var_7 = 0;

    if(var_8)
      var_8 = 0;
    else {
      if(var_6 < -180 + var_4 && var_7 > 180 - var_5)
        var_7 = -179;

      if(var_6 > 180 - var_4 && var_7 < -180 + var_5)
        var_7 = 179;

      var_14 = var_7 - var_6;
      var_15 = (var_2 - var_1) * abs(var_14) / 180 + var_1;

      if(isDefined(self.stop_aiming_for_reload)) {
        var_15 = var_3;

        if(abs(var_6) < 45)
          self notify("start_blending_reload");
      }

      if(abs(var_14) > var_15)
        var_7 = var_6 + var_15 * common_scripts\utility::sign(var_14);
    }

    var_6 = var_7;
    var_16 = max(-90 - var_7, 0) / 90 * self.a.aimweight;
    var_17 = min(max(0 - var_7, 0), 90) / 90 * self.a.aimweight;
    var_18 = max(90 - abs(var_7), 0) / 90 * self.a.aimweight;
    var_19 = min(max(var_7, 0), 90) / 90 * self.a.aimweight;
    var_20 = max(-90 + var_7, 0) / 90 * self.a.aimweight;
    self setanimlimited(%sm_aim_1, var_16, var_0);
    self setanimlimited(%sm_aim_4_delta, var_17, var_0);
    self setanimlimited(%sm_aim_5_delta, var_18, var_0);
    self setanimlimited(%sm_aim_6_delta, var_19, var_0);
    self setanimlimited(%sm_aim_3, var_20, var_0);
    wait 0.05;
  }
}

snowmobile_get_death_anim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = animscripts\utility::absangleclamp180(var_2 - var_1[var_6]);

    if(!isDefined(var_3) || var_7 < var_5) {
      var_4 = var_3;
      var_3 = var_0[var_6];
      var_5 = var_7;
      continue;
    }

    if(!isDefined(var_4))
      var_4 = var_0[var_6];
  }

  var_8 = var_3;

  if(isDefined(anim.prevsnowmobiledeath) && var_8 == anim.prevsnowmobiledeath && gettime() - anim.prevsnowmobiledeathtime < 500)
    var_8 = var_4;

  anim.prevsnowmobiledeath = var_8;
  anim.prevsnowmobiledeathtime = gettime();
  return var_8;
}

snowmobile_death_launchslide() {
  var_0 = self.ridingvehicle;
  var_1 = var_0.prevframevelocity;
  var_1 = (var_1[0], var_1[1], randomfloatrange(200, 400)) * 0.75;

  if(lengthsquared(var_1) > 1000000)
    var_1 = vectornormalize(var_1) * 1000;

  var_2 = spawn("script_origin", self.origin);
  var_2 moveslide((0, 0, 40), 15, var_1);
  self linkto(var_2);
  var_2 thread deleteshortly();
}

snowmobile_normal_death() {
  var_0 = [];
  var_0[0] = level.scr_anim["snowmobile"]["small"]["death"]["back"];
  var_0[1] = level.scr_anim["snowmobile"]["small"]["death"]["right"];
  var_0[2] = level.scr_anim["snowmobile"]["small"]["death"]["left"];
  var_1 = [];
  var_1[0] = -180;
  var_1[1] = -90;
  var_1[2] = 90;
  var_2 = snowmobile_get_death_anim(var_0, var_1, self.damageyaw);
  animscripts\death::playdeathanim(var_2);
  return 1;
}

snowmobile_collide_death() {
  var_0 = self.ridingvehicle;

  if(!isDefined(var_0))
    return snowmobile_normal_death();

  var_1 = var_0.prevframevelocity;
  snowmobile_death_launchslide();
  var_2 = vectortoangles(var_1);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = [];
  var_4[0] = level.scr_anim["snowmobile"]["big"]["death"]["back"];
  var_4[1] = level.scr_anim["snowmobile"]["big"]["death"]["left"];
  var_4[2] = level.scr_anim["snowmobile"]["big"]["death"]["front"];
  var_4[3] = level.scr_anim["snowmobile"]["big"]["death"]["right"];
  var_5 = [];
  var_5[0] = -180;
  var_5[1] = -90;
  var_5[2] = 0;
  var_5[3] = 90;
  var_6 = snowmobile_get_death_anim(var_4, var_5, var_3);
  animscripts\death::playdeathanim(var_6);
  return 1;
}

deleteshortly() {
  var_0 = self.origin;

  for(var_1 = 0; var_1 < 60; var_1++) {
    wait 0.05;
    var_0 = self.origin;
  }

  wait 3;

  if(isDefined(self))
    self delete();
}

snowmobile_setanim_common(var_0) {
  self.a.array["idle"] = level.scr_anim["snowmobile"][var_0]["idle"];
  self.a.array["drive"] = level.scr_anim["snowmobile"][var_0]["drive"];
  self.a.array["fire"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["single"] = animscripts\utility::array(level.scr_anim["snowmobile"][var_0]["single"]);
  self.a.array["burst2"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["burst3"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["burst4"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["burst5"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["burst6"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["semi2"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["semi3"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["semi4"] = level.scr_anim["snowmobile"][var_0]["fire"];
  self.a.array["semi5"] = level.scr_anim["snowmobile"][var_0]["fire"];
}

snowmobile_setanim_driver(var_0) {
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

  if(var_0) {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["shoot_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["shoot_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["shoot_sway_right"];
    self.a.array["event_restore"] = % sm_aiming;
  } else {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["driver"]["drive_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["driver"]["drive_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["driver"]["drive_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["driver"]["drive_sway_right"];
    self.a.array["event_restore"] = % sm_turn;
  }
}

snowmobile_setanim_passenger(var_0) {
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

  if(var_0) {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["drive_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["drive_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["drive_sway_right"];
    self.a.array["event_restore"] = % sm_aiming;
  } else {
    self.a.array["event_jump"] = level.scr_anim["snowmobile"]["passenger"]["hide_jump"];
    self.a.array["event_bump"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["snowmobile"]["passenger"]["hide_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["snowmobile"]["passenger"]["hide_sway_right"];
    self.a.array["event_restore"] = % sm_turn;
  }
}