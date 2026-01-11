/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\atv.gsc
*****************************************************/

main() {
  self.current_event = "none";
  self.shoot_while_driving_thread = undefined;
  atv_geton();
  main_driver();
}

atv_geton() {
  self.grenadeawareness = 0;
  self.a.pose = "crouch";
  maps\_utility::disable_surprise();
  self.allowpain = 0;
  self.flashbangimmunity = 1;
  self.getoffvehiclefunc = ::atv_getoff;
  self.specialdeathfunc = ::atv_normal_death;
  self.disablebulletwhizbyreaction = 1;
}

atv_getoff() {
  self.allowpain = 1;
  self.flashbangimmunity = 0;
  maps\_utility::gun_recall();
  self.onatv = undefined;
  self.custom_animscript["combat"] = undefined;
  self.custom_animscript["stop"] = undefined;
  self.getoffvehiclefunc = undefined;
  self.specialdeathfunc = undefined;
  self.a.specialshootbehavior = undefined;
  self.disablebulletwhizbyreaction = undefined;
}

main_driver() {
  var_0 = self.ridingvehicle.driver_shooting || self.ridingvehicle.riders.size == 1;
  atv_setanim_driver(var_0);

  if(var_0) {
    animscripts\shared::placeweaponon(self.primaryweapon, "left");
    self.rightaimlimit = 90;
    self.leftaimlimit = -90;
    animscripts\track::setanimaimweight(1, 0.2);
    thread atv_trackshootentorpos_driver();
    thread atv_loop_driver_shooting();
  } else {
    animscripts\shared::placeweaponon(self.primaryweapon, "none");
    thread atv_loop_driver();
  }

  atv_handle_events("driver");
}

#using_animtree("generic_human");

atv_loop_driver() {
  self endon("death");
  self endon("killanimscript");
  var_0 = "left2right";
  var_1 = [];
  var_1["left2right"] = getanimlength(animscripts\utility::animarray("left2right"));
  var_1["right2left"] = getanimlength(animscripts\utility::animarray("right2left"));
  self setanimknoball( % atv_turn, % body, 1, 0);
  self setanim(animscripts\utility::animarray("drive"), 1, 0);
  self setanimknob(animscripts\utility::animarray(var_0), 1, 0);
  self setanimtime(animscripts\utility::animarray(var_0), 0.5);

  for(;;) {
    if(self.ridingvehicle.steering_enable) {
      var_2 = 0.5 * (1 + maps\_vehicle_code::update_steering(self.ridingvehicle));
      var_3 = self getanimtime(animscripts\utility::animarray(var_0));

      if(var_0 == "right2left") {
        var_3 = 1 - var_3;
      }

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

atv_loop_driver_shooting() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  var_1 = 0;
  self setanimknoball( % atv_aiming, % body, 1, 0);
  self setanimknob(animscripts\utility::animarray("idle"), 1, 0);

  for(;;) {
    if(self.current_event != "none") {
      self waittill("atv_event_finished");
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

    if(var_1 <= gettime()) {
      atv_start_shooting();
    }

    self setanimknoblimited(animscripts\utility::animarray("add_aim_left_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_left_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_left_right"), var_5, var_0);
    self setanimknoblimited(animscripts\utility::animarray("add_aim_right_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_right_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::animarray("add_aim_right_right"), var_5, var_0);
    thread atv_stop_shooting();
    wait 0.05;
  }
}

atv_do_event(var_0) {
  self endon("death");
  self.ridingvehicle.steering_enable = 0;
  self setflaggedanimknoblimitedrestart("atv_event", var_0, 1, 0.17);
  animscripts\shared::donotetracks("atv_event", ::atv_waitfor_start_lean);
  self setanimknoblimited(animscripts\utility::animarray("event_restore"), 1, 0.1);
  self.ridingvehicle.steering_enable = 1;
  self.current_event = "none";
  self notify("atv_event_finished");
}

atv_handle_events(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = self.ridingvehicle;

  for(;;) {
    if(var_1.event["jump"][var_0]) {
      var_1.event["jump"][var_0] = 0;
      self notify("atv_event_occurred");
      self.current_event = "jump";
      var_1.steering_enable = 0;
      self setflaggedanimknoblimitedrestart("jump", animscripts\utility::animarray("event_jump"), 1, 0.17);
    }

    if(var_1.event["bump"][var_0]) {
      var_1.event["bump"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self.current_event != "bump_big") {
        thread atv_do_event(animscripts\utility::animarray("event_bump"));
      }
    }

    if(var_1.event["bump_big"][var_0]) {
      var_1.event["bump_big"][var_0] = 0;
      self notify("atv_event_occurred");
      self.current_event = "bump_big";
      thread atv_do_event(animscripts\utility::animarray("event_bump_big"));
    }

    if(var_1.event["sway_left"][var_0]) {
      var_1.event["sway_left"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self.current_event != "bump_big") {
        thread atv_do_event(animscripts\utility::animarray("event_sway")["left"]);
      }
    }

    if(var_1.event["sway_right"][var_0]) {
      var_1.event["sway_right"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self.current_event != "bump_big") {
        thread atv_do_event(animscripts\utility::animarray("event_sway")["right"]);
      }
    }

    wait 0.05;
  }
}

atv_start_shooting() {
  self notify("want_shoot_while_driving");
  self setanim( % atv_add_fire, 1, 0.2);

  if(isDefined(self.shoot_while_driving_thread)) {
    return;
  }
  self.shoot_while_driving_thread = 1;
  thread atv_decide_shoot();
  thread atv_shoot();
}

atv_stop_shooting() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait 0.05;
  self notify("end_shoot_while_driving");
  self.shoot_while_driving_thread = undefined;
  self clearanim( % atv_add_fire, 0.2);
}

atv_decide_shoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a.specialshootbehavior = ::atvshootbehavior;
  atv_decide_shoot_internal();
  self.shoot_while_driving_thread = undefined;
}

atv_decide_shoot_internal() {
  self endon("atv_event_occurred");
  animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

atvshootbehavior() {
  if(!isDefined(self.enemy)) {
    self.shootent = undefined;
    self.shootpos = undefined;
    self.shootstyle = "none";
    return;
  }

  self.shootent = self.enemy;
  self.shootpos = self.enemy getshootatpos();
  var_0 = distancesquared(self.origin, self.enemy.origin);

  if(var_0 < 1000000) {
    self.shootstyle = "full";
  }
  else if(var_0 < 4000000) {
    self.shootstyle = "burst";
  }
  else {
    self.shootstyle = "single";
  }

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

        if(var_9 > 128) {
          var_9 = 128;
        }
        else if(var_9 < -128) {
          var_9 = -128;
        }

        if(var_9 > 0) {
          var_9 = 128 - var_9;
        }
        else {
          var_9 = -128 - var_9;
        }

        self.shootent = undefined;
        self.shootpos = var_2.origin + var_8 * var_5 + var_9 * var_6;
        return;
      }
    }
  }
}

atv_shoot() {
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

atv_reload() {
  if(!self.ridingvehicle.steering_enable) {
    return 0;
  }

  if(!animscripts\combat_utility::needtoreload(0)) {
    return 0;
  }

  if(!animscripts\utility::usingriflelikeweapon()) {
    return 0;
  }

  atv_reload_internal();
  self notify("abort_reload");
  return 1;
}

atv_reload_internal() {
  self endon("atv_event_occurred");
  self.stop_aiming_for_reload = 1;
  self waittill("start_blending_reload");
  self setanim( % atv_aiming, 0, 0.25);
  self setflaggedanimrestart("gun_down", animscripts\utility::animarray("gun_down"), 1, 0.25);
  animscripts\shared::donotetracks("gun_down");
  self clearanim(animscripts\utility::animarray("gun_down"), 0);
  self setflaggedanimknoballrestart("reload_anim", animscripts\utility::animarray("reload"), % body, 1, 0.25);
  animscripts\shared::donotetracks("reload_anim");
  self clearanim( % atv_reload, 0.2);
  self setflaggedanimrestart("gun_up", animscripts\utility::animarray("gun_up"), 1, 0.25);
  self.gun_up_for_reload = 1;
  animscripts\shared::donotetracks("gun_up", ::atv_waitfor_start_aim);
  self.stop_aiming_for_reload = undefined;
  self clearanim( % atv_reload, 0.1);
  self setanim( % atv_aiming, 1, 0.1);

  if(isDefined(self.gun_up_for_reload)) {
    self.gun_up_for_reload = undefined;
    animscripts\shared::donotetracks("gun_up", ::atv_waitfor_end);
    self clearanim(animscripts\utility::animarray("gun_up"), 0);
  }
}

atv_waitfor_start_aim(var_0) {
  if(var_0 == "start_aim") {
    return 1;
  }
}

atv_waitfor_end(var_0) {
  if(var_0 == "end") {
    return 1;
  }
}

atv_waitfor_start_lean(var_0) {
  if(var_0 == "start_lean") {
    return 1;
  }
}

atv_trackshootentorpos_driver() {
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

    if(isDefined(self.shootent)) {
      var_6 = self.shootent getshootatpos();
    }

    if(!isDefined(var_6)) {
      var_3 = 0;
      var_7 = self getanglestolikelyenemypath();

      if(isDefined(var_7)) {
        var_3 = angleclamp180(self.angles[1] - var_7[1]);
      }
    } else {
      var_8 = var_6 - var_5;
      var_9 = vectortoangles(var_8);
      var_3 = self.angles[1] - var_9[1];
      var_3 = angleclamp180(var_3);
    }

    if(var_3 > self.rightaimlimit || var_3 < self.leftaimlimit) {
      var_3 = 0;
    }

    if(var_4) {
      var_4 = 0;
    }
    else {
      var_10 = var_3 - var_2;

      if(abs(var_10) > var_1) {
        var_3 = var_2 + var_1 * common_scripts\utility::sign(var_10);
      }
    }

    var_2 = var_3;
    var_11 = min(max(0 - var_3, 0), 90) / 90 * self.a.aimweight;
    var_12 = min(max(var_3, 0), 90) / 90 * self.a.aimweight;
    self setanimlimited( % atv_aim_4, var_11, var_0);
    self setanimlimited( % atv_aim_6, var_12, var_0);
    wait 0.05;
  }
}

atv_get_death_anim(var_0, var_1, var_2) {
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

    if(!isDefined(var_4)) {
      var_4 = var_0[var_6];
    }
  }

  var_8 = var_3;

  if(isDefined(anim.prevatvdeath) && var_8 == anim.prevatvdeath && gettime() - anim.prevatvdeathtime < 500) {
    var_8 = var_4;
  }

  anim.prevatvdeath = var_8;
  anim.prevatvdeathtime = gettime();
  return var_8;
}

atv_death_launchslide() {
  var_0 = self.ridingvehicle;
  var_1 = var_0.prevframevelocity;
  var_1 = (var_1[0], var_1[1], randomfloatrange(200, 400)) * 0.75;

  if(lengthsquared(var_1) > 1000000) {
    var_1 = vectornormalize(var_1) * 1000;
  }

  var_2 = spawn("script_origin", self.origin);
  var_2 moveslide((0, 0, 40), 15, var_1);
  self linkto(var_2);
  var_2 thread deleteshortly();
}

atv_normal_death() {
  var_0 = [];
  var_0[0] = level.scr_anim["atv"]["small"]["death"]["back"];
  var_0[1] = level.scr_anim["atv"]["small"]["death"]["right"];
  var_0[2] = level.scr_anim["atv"]["small"]["death"]["left"];
  var_1 = [];
  var_1[0] = -180;
  var_1[1] = -90;
  var_1[2] = 90;
  var_2 = atv_get_death_anim(var_0, var_1, self.damageyaw);
  animscripts\death::playdeathanim(var_2);
  return 1;
}

atv_collide_death() {
  var_0 = self.ridingvehicle;

  if(!isDefined(var_0)) {
    return atv_normal_death();
  }

  var_1 = var_0.prevframevelocity;
  atv_death_launchslide();
  var_2 = vectortoangles(var_1);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = [];
  var_4[0] = level.scr_anim["atv"]["big"]["death"]["back"];
  var_4[1] = level.scr_anim["atv"]["big"]["death"]["left"];
  var_4[2] = level.scr_anim["atv"]["big"]["death"]["front"];
  var_4[3] = level.scr_anim["atv"]["big"]["death"]["right"];
  var_5 = [];
  var_5[0] = -180;
  var_5[1] = -90;
  var_5[2] = 0;
  var_5[3] = 90;
  var_6 = atv_get_death_anim(var_4, var_5, var_3);
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

  if(isDefined(self)) {
    self delete();
  }
}

atv_setanim_common(var_0) {
  self.a.array["idle"] = level.scr_anim["atv"][var_0]["idle"];
  self.a.array["drive"] = level.scr_anim["atv"][var_0]["drive"];
  self.a.array["fire"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["single"] = animscripts\utility::array(level.scr_anim["atv"][var_0]["single"]);
  self.a.array["burst2"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["burst3"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["burst4"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["burst5"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["burst6"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["semi2"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["semi3"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["semi4"] = level.scr_anim["atv"][var_0]["fire"];
  self.a.array["semi5"] = level.scr_anim["atv"][var_0]["fire"];
}

atv_setanim_driver(var_0) {
  self.a.array = [];
  atv_setanim_common("driver");
  self.a.array["left2right"] = level.scr_anim["atv"]["driver"]["left2right"];
  self.a.array["right2left"] = level.scr_anim["atv"]["driver"]["right2left"];
  self.a.array["straight_level_left"] = level.scr_anim["atv"]["driver"]["straight_level"]["left"];
  self.a.array["straight_level_center"] = level.scr_anim["atv"]["driver"]["straight_level"]["center"];
  self.a.array["straight_level_right"] = level.scr_anim["atv"]["driver"]["straight_level"]["right"];
  self.a.array["add_aim_left_left"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["left"];
  self.a.array["add_aim_left_center"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["center"];
  self.a.array["add_aim_left_right"] = level.scr_anim["atv"]["driver"]["add_aim_left"]["right"];
  self.a.array["add_aim_right_left"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["left"];
  self.a.array["add_aim_right_center"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["center"];
  self.a.array["add_aim_right_right"] = level.scr_anim["atv"]["driver"]["add_aim_right"]["right"];

  if(var_0) {
    self.a.array["event_jump"] = level.scr_anim["atv"]["driver"]["shoot_jump"];
    self.a.array["event_bump"] = level.scr_anim["atv"]["driver"]["shoot_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["atv"]["driver"]["shoot_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["atv"]["driver"]["shoot_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["atv"]["driver"]["shoot_sway_right"];
    self.a.array["event_restore"] = % atv_aiming;
  } else {
    self.a.array["event_jump"] = level.scr_anim["atv"]["driver"]["drive_jump"];
    self.a.array["event_bump"] = level.scr_anim["atv"]["driver"]["drive_bump"];
    self.a.array["event_bump_big"] = level.scr_anim["atv"]["driver"]["drive_bump_big"];
    self.a.array["event_sway"] = [];
    self.a.array["event_sway"]["left"] = level.scr_anim["atv"]["driver"]["drive_sway_left"];
    self.a.array["event_sway"]["right"] = level.scr_anim["atv"]["driver"]["drive_sway_right"];
    self.a.array["event_restore"] = % atv_turn;
  }
}