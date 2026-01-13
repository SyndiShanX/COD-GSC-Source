/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\snowmobile.gsc
*********************************************/

main() {
  self.var_4B71 = "none";
  self.var_FE91 = undefined;
  func_103C8();
  if(isDefined(self.var_5BD6)) {
    func_B1C3();
    return;
  }

  func_B213();
}

func_103C8() {
  self.objective_state_nomessage = 0;
  self.a.pose = "crouch";
  scripts\sp\utility::func_558D();
  self.allowpain = 0;
  self.var_6EC4 = 1;
  self.autoboltmissileeffects = ::func_103C7;
  self.var_10957 = ::func_103CF;
  self.disablebulletwhizbyreaction = 1;
}

func_103C7() {
  self.allowpain = 1;
  self.var_6EC4 = 0;
  scripts\sp\utility::func_86E2();
  self.var_C59B = undefined;
  self.autoboltmissileeffects = undefined;
  self.var_10957 = undefined;
  self.a.var_1096D = undefined;
  self.disablebulletwhizbyreaction = undefined;
}

func_B1C3() {
  var_0 = self.var_E500.var_5BCB || self.var_E500.var_E4FB.size == 1;
  func_103D4(var_0);
  if(var_0) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "left");
    self.setdevdvar = -90;
    self.setmatchdatadef = 90;
    scripts\anim\track::func_F641(1, 0.2);
    thread func_103D9();
    thread func_103CB();
  } else {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
    thread func_103CA();
  }

  func_103C9("driver");
}

func_B213() {
  func_103D5(self.var_E500.var_C93B);
  if(self.var_E500.var_C93B) {
    self.setdevdvar = -180;
    self.setmatchdatadef = 180;
    self.var_54DB = 1;
    scripts\anim\track::func_F641(1, 0.2);
    thread func_103DA();
    thread func_103CD();
  } else {
    thread func_103CC();
  }

  func_103C9("passenger");
}

func_103CA() {
  self endon("death");
  self endon("killanimscript");
  var_0 = "left2right";
  var_1 = [];
  var_1["left2right"] = getanimlength(scripts\anim\utility::func_1F64("left2right"));
  var_1["right2left"] = getanimlength(scripts\anim\utility::func_1F64("right2left"));
  self func_82A5( % sm_turn, % body, 1, 0);
  self give_attacker_kill_rewards(scripts\anim\utility::func_1F64("drive"), 1, 0);
  self setanimknob(scripts\anim\utility::func_1F64(var_0), 1, 0);
  self func_82B0(scripts\anim\utility::func_1F64(var_0), 0.5);
  for(;;) {
    if(self.var_E500.var_10F83) {
      var_2 = 0.5 * 1 + scripts\sp\vehicle_code::func_12E33(self.var_E500);
      var_3 = self getscoreinfocategory(scripts\anim\utility::func_1F64(var_0));
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

    self func_82A9(scripts\anim\utility::func_1F64(var_0), 1, 0.1, var_4);
    self func_82B0(scripts\anim\utility::func_1F64(var_0), var_3);
    wait(0.05);
  }
}

func_103CC() {
  self endon("death");
  self endon("killanimscript");
  self func_82A5(scripts\anim\utility::func_1F64("hide"), % body, 1, 0);
  self setanimknob(scripts\anim\utility::func_1F64("drive"), 1, 0);
  for(;;) {
    var_0 = scripts\sp\vehicle_code::func_12E33(self.var_E500);
    self func_82AC( % sm_lean, abs(var_0), 0.05);
    if(var_0 >= 0) {
      self func_82A9(scripts\anim\utility::func_1F64("lean_right"), 1, 0.05);
    } else {
      self func_82A9(scripts\anim\utility::func_1F64("lean_left"), 1, 0.05);
    }

    wait(0.05);
  }
}

func_103CB() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  var_1 = 0;
  self func_82A5( % sm_aiming, % body, 1, 0);
  self setanimknob(scripts\anim\utility::func_1F64("idle"), 1, 0);
  for(;;) {
    if(self.var_4B71 != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    var_2 = scripts\sp\vehicle_code::func_12E33(self.var_E500);
    var_3 = 1 - abs(var_2);
    var_4 = max(0, 0 - var_2);
    var_5 = max(0, var_2);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_center"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_left"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_right"), var_5, var_0);
    if(self.bulletsinclip <= 0) {
      scripts\anim\weaponlist::refillclip();
      var_1 = gettime() + 3000;
    }

    if(var_1 <= gettime()) {
      func_103D7();
    }

    self func_82A9(scripts\anim\utility::func_1F64("add_aim_left_center"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_left_left"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_left_right"), var_5, var_0);
    self func_82A9(scripts\anim\utility::func_1F64("add_aim_right_center"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_right_left"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_right_right"), var_5, var_0);
    thread func_103D8();
    wait(0.05);
  }
}

func_103CD() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  self func_82A5( % sm_aiming, % body, 1, 0);
  self setanimknob(scripts\anim\utility::func_1F64("idle"), 1, 0);
  for(;;) {
    if(self.var_4B71 != "none") {
      self waittill("snowmobile_event_finished");
      continue;
    }

    if(func_103D1()) {
      continue;
    }

    var_1 = scripts\sp\vehicle_code::func_12E33(self.var_E500);
    var_2 = 1 - abs(var_1);
    var_3 = max(0, 0 - var_1);
    var_4 = max(0, var_1);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_center"), var_2, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_left"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level_right"), var_4, var_0);
    func_103D7();
    self func_82AC(scripts\anim\utility::func_1F64("aim_left_center"), var_2, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("aim_left_left"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("aim_left_right"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("aim_right_center"), var_2, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("aim_right_left"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("aim_right_right"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backleft_center"), var_2, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backleft_left"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backleft_right"), var_4, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backright_center"), var_2, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backright_left"), var_3, var_0);
    self func_82AC(scripts\anim\utility::func_1F64("add_aim_backright_right"), var_4, var_0);
    if(isplayer(self.isnodeoccupied)) {
      self func_83CE();
    }

    wait(0.05);
    thread func_103D8();
  }
}

func_103C5(var_0) {
  self endon("death");
  self.var_E500.var_10F83 = 0;
  self func_82E6("snowmobile_event", var_0, 1, 0.17);
  scripts\anim\shared::donotetracks("snowmobile_event", ::func_103DD);
  self func_82A9(scripts\anim\utility::func_1F64("event_restore"), 1, 0.1);
  self.var_E500.var_10F83 = 1;
  self.var_4B71 = "none";
  self notify("snowmobile_event_finished");
}

func_103C9(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = self.var_E500;
  for(;;) {
    if(var_1.var_67E5["jump"][var_0]) {
      var_1.var_67E5["jump"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      self.var_4B71 = "jump";
      var_1.var_10F83 = 0;
      self func_82E6("jump", scripts\anim\utility::func_1F64("event_jump"), 1, 0.17);
    }

    if(var_1.var_67E5["bump"][var_0]) {
      var_1.var_67E5["bump"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      if(self.var_4B71 != "bump_big") {
        thread func_103C5(scripts\anim\utility::func_1F64("event_bump"));
      }
    }

    if(var_1.var_67E5["bump_big"][var_0]) {
      var_1.var_67E5["bump_big"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      self.var_4B71 = "bump_big";
      thread func_103C5(scripts\anim\utility::func_1F64("event_bump_big"));
    }

    if(var_1.var_67E5["sway_left"][var_0]) {
      var_1.var_67E5["sway_left"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      if(self.var_4B71 != "bump_big") {
        thread func_103C5(scripts\anim\utility::func_1F64("event_sway")["left"]);
      }
    }

    if(var_1.var_67E5["sway_right"][var_0]) {
      var_1.var_67E5["sway_right"][var_0] = 0;
      self notify("snowmobile_event_occurred");
      if(self.var_4B71 != "bump_big") {
        thread func_103C5(scripts\anim\utility::func_1F64("event_sway")["right"]);
      }
    }

    wait(0.05);
  }
}

func_103D7() {
  self notify("want_shoot_while_driving");
  self give_attacker_kill_rewards( % sm_add_fire, 1, 0.2);
  if(isDefined(self.var_FE91)) {
    return;
  }

  self.var_FE91 = 1;
  thread func_103C3();
  thread func_103D6();
}

func_103D8() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait(0.05);
  self notify("end_shoot_while_driving");
  self.var_FE91 = undefined;
  self clearanim( % sm_add_fire, 0.2);
}

func_103C3() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a.var_1096D = ::func_103DE;
  func_103C4();
  self.var_FE91 = undefined;
}

func_103C4() {
  self endon("snowmobile_event_occurred");
  scripts\anim\shoot_behavior::func_4F69("normal");
}

func_103DE() {
  if(!isDefined(self.isnodeoccupied)) {
    self.var_FE9E = undefined;
    self.var_FECF = undefined;
    self.var_FED7 = "none";
    return;
  }

  self.var_FE9E = self.isnodeoccupied;
  self.var_FECF = self.isnodeoccupied getshootatpos();
  var_0 = distancesquared(self.origin, self.isnodeoccupied.origin);
  if(var_0 < 1000000) {
    self.var_FED7 = "full";
  } else if(var_0 < 4000000) {
    self.var_FED7 = "burst";
  } else {
    self.var_FED7 = "single";
  }

  if(isDefined(self.isnodeoccupied.vehicle)) {
    var_1 = 0.5;
    var_2 = self.var_FE9E.vehicle;
    var_3 = self.var_E500;
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
        } else if(var_9 < -128) {
          var_9 = -128;
        }

        if(var_9 > 0) {
          var_9 = 128 - var_9;
        } else {
          var_9 = -128 - var_9;
        }

        self.var_FE9E = undefined;
        self.var_FECF = var_2.origin + var_8 * var_5 + var_9 * var_6;
        return;
      }
    }
  }
}

func_103D6() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self notify("doing_shootWhileDriving");
  self endon("doing_shootWhileDriving");
  for(;;) {
    if(!self.bulletsinclip) {
      wait(0.5);
      continue;
    }

    scripts\anim\combat_utility::func_FEDF();
  }
}

func_103D1() {
  if(!self.var_E500.var_10F83) {
    return 0;
  }

  if(!scripts\anim\utility_common::needtoreload(0)) {
    return 0;
  }

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return 0;
  }

  func_103D2();
  self notify("abort_reload");
  return 1;
}

func_103D2() {
  self endon("snowmobile_event_occurred");
  self.var_10FB2 = 1;
  self waittill("start_blending_reload");
  self give_attacker_kill_rewards( % sm_aiming, 0, 0.25);
  self func_82EA("gun_down", scripts\anim\utility::func_1F64("gun_down"), 1, 0.25);
  scripts\anim\shared::donotetracks("gun_down");
  self clearanim(scripts\anim\utility::func_1F64("gun_down"), 0);
  self func_82E4("reload_anim", scripts\anim\utility::func_1F64("reload"), % body, 1, 0.25);
  scripts\anim\shared::donotetracks("reload_anim");
  self clearanim( % sm_reload, 0.2);
  self func_82EA("gun_up", scripts\anim\utility::func_1F64("gun_up"), 1, 0.25);
  self.var_86EC = 1;
  scripts\anim\shared::donotetracks("gun_up", ::func_103DC);
  self.var_10FB2 = undefined;
  self clearanim( % sm_reload, 0.1);
  self give_attacker_kill_rewards( % sm_aiming, 1, 0.1);
  if(isDefined(self.var_86EC)) {
    self.var_86EC = undefined;
    scripts\anim\shared::donotetracks("gun_up", ::func_103DB);
    self clearanim(scripts\anim\utility::func_1F64("gun_up"), 0);
  }
}

func_103DC(var_0) {
  if(var_0 == "start_aim") {
    return 1;
  }
}

func_103DB(var_0) {
  if(var_0 == "end") {
    return 1;
  }
}

func_103DD(var_0) {
  if(var_0 == "start_lean") {
    return 1;
  }
}

func_103D9() {
  self endon("killanimscript");
  self endon("stop tracking");
  var_0 = 0.05;
  var_1 = 8;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;
  for(;;) {
    scripts\anim\track::func_93E2();
    var_5 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_6 = self.var_FECF;
    if(isDefined(self.var_FE9E)) {
      var_6 = self.var_FE9E getshootatpos();
    }

    if(!isDefined(var_6)) {
      var_3 = 0;
      var_7 = self getsafeanimmovedeltapercentage();
      if(isDefined(var_7)) {
        var_3 = angleclamp180(var_7[1] - self.angles[1]);
      }
    } else {
      var_8 = var_6 - var_5;
      var_9 = vectortoangles(var_8);
      var_3 = var_9[1] - self.angles[1];
      var_3 = angleclamp180(var_3);
    }

    if(var_3 < self.setdevdvar || var_3 > self.setmatchdatadef) {
      var_3 = 0;
    }

    if(var_4) {
      var_4 = 0;
    } else {
      var_0A = var_3 - var_2;
      if(abs(var_0A) > var_1) {
        var_3 = var_2 + var_1 * scripts\engine\utility::sign(var_0A);
      }
    }

    var_2 = var_3;
    var_0B = min(max(var_3, 0), 90) / 90 * self.a.var_1A4B;
    var_0C = min(max(0 - var_3, 0), 90) / 90 * self.a.var_1A4B;
    self func_82AC( % sm_aim_4, var_0B, var_0);
    self func_82AC( % sm_aim_6, var_0C, var_0);
    wait(0.05);
  }
}

func_103DA() {
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
    scripts\anim\track::func_93E2();
    var_9 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_0A = self.var_FECF;
    if(isDefined(self.var_FE9E)) {
      var_0A = self.var_FE9E getshootatpos();
    }

    if(!isDefined(var_0A)) {
      var_7 = 0;
      var_0B = self getsafeanimmovedeltapercentage();
      if(isDefined(var_0B)) {
        var_7 = angleclamp180(var_0B[1] - self.angles[1]);
      }
    } else {
      var_0C = var_0A - var_9;
      var_0D = vectortoangles(var_0C);
      var_7 = var_0D[1] - self.angles[1];
      var_7 = angleclamp180(var_7);
    }

    if(isDefined(self.var_10FB2) || var_7 < 0 && var_7 - self.setdevdvar * self.var_54DB > 0 || var_7 > 0 && var_7 - self.setmatchdatadef * self.var_54DB < 0) {
      var_7 = 0;
    }

    if(var_8) {
      var_8 = 0;
    } else {
      if(var_6 < -180 + var_4 && var_7 > 180 - var_5) {
        var_7 = -179;
      }

      if(var_6 > 180 - var_4 && var_7 < -180 + var_5) {
        var_7 = 179;
      }

      var_0E = var_7 - var_6;
      var_0F = var_2 - var_1 * abs(var_0E) / 180 + var_1;
      if(isDefined(self.var_10FB2)) {
        var_0F = var_3;
        if(abs(var_6) < 45) {
          self notify("start_blending_reload");
        }
      }

      if(abs(var_0E) > var_0F) {
        var_7 = var_6 + var_0F * scripts\engine\utility::sign(var_0E);
      }
    }

    var_6 = var_7;
    var_10 = max(-90 + var_7, 0) / 90 * self.a.var_1A4B;
    var_11 = min(max(var_7, 0), 90) / 90 * self.a.var_1A4B;
    var_12 = max(90 - abs(var_7), 0) / 90 * self.a.var_1A4B;
    var_13 = min(max(0 - var_7, 0), 90) / 90 * self.a.var_1A4B;
    var_14 = max(-90 - var_7, 0) / 90 * self.a.var_1A4B;
    self func_82AC( % sm_aim_1, var_10, var_0);
    self func_82AC( % sm_aim_4_delta, var_11, var_0);
    self func_82AC( % sm_aim_5_delta, var_12, var_0);
    self func_82AC( % sm_aim_6_delta, var_13, var_0);
    self func_82AC( % sm_aim_3, var_14, var_0);
    wait(0.05);
  }
}

func_103C6(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = scripts\engine\utility::absangleclamp180(var_2 - var_1[var_6]);
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
  if(isDefined(level.var_D8BF) && var_8 == level.var_D8BF && gettime() - level.var_D8C0 < 500) {
    var_8 = var_4;
  }

  anim.var_D8BF = var_8;
  anim.var_D8C0 = gettime();
  return var_8;
}

func_103C2() {
  var_0 = self.var_E500;
  var_1 = var_0.var_D89A;
  var_1 = (var_1[0], var_1[1], randomfloatrange(200, 400)) * 0.75;
  if(lengthsquared(var_1) > 1000000) {
    var_1 = vectornormalize(var_1) * 1000;
  }

  var_2 = spawn("script_origin", self.origin);
  var_2 moveslide((0, 0, 40), 15, var_1);
  self linkto(var_2);
  var_2 thread func_51D1();
}

func_103CF() {
  var_0 = [];
  var_0[0] = level.var_EC85["snowmobile"]["small"]["death"]["back"];
  var_0[1] = level.var_EC85["snowmobile"]["small"]["death"]["right"];
  var_0[2] = level.var_EC85["snowmobile"]["small"]["death"]["left"];
  var_1 = [];
  var_1[0] = -180;
  var_1[1] = -90;
  var_1[2] = 90;
  var_2 = func_103C6(var_0, var_1, self.var_E3);
  scripts\anim\death::func_CF0E(var_2);
  return 1;
}

func_103C1() {
  var_0 = self.var_E500;
  if(!isDefined(var_0)) {
    return func_103CF();
  }

  var_1 = var_0.var_D89A;
  func_103C2();
  var_2 = vectortoangles(var_1);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = [];
  var_4[0] = level.var_EC85["snowmobile"]["big"]["death"]["back"];
  var_4[1] = level.var_EC85["snowmobile"]["big"]["death"]["left"];
  var_4[2] = level.var_EC85["snowmobile"]["big"]["death"]["front"];
  var_4[3] = level.var_EC85["snowmobile"]["big"]["death"]["right"];
  var_5 = [];
  var_5[0] = -180;
  var_5[1] = -90;
  var_5[2] = 0;
  var_5[3] = 90;
  var_6 = func_103C6(var_4, var_5, var_3);
  scripts\anim\death::func_CF0E(var_6);
  return 1;
}

func_51D1() {
  var_0 = self.origin;
  for(var_1 = 0; var_1 < 60; var_1++) {
    wait(0.05);
    var_0 = self.origin;
  }

  wait(3);
  if(isDefined(self)) {
    self delete();
  }
}

func_103D3(var_0) {
  self.a.var_2274["idle"] = level.var_EC85["snowmobile"][var_0]["idle"];
  self.a.var_2274["drive"] = level.var_EC85["snowmobile"][var_0]["drive"];
  self.a.var_2274["fire"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["single"] = scripts\anim\utility::func_2274(level.var_EC85["snowmobile"][var_0]["single"]);
  self.a.var_2274["burst2"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["burst3"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["burst4"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["burst5"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["burst6"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["semi2"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["semi3"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["semi4"] = level.var_EC85["snowmobile"][var_0]["fire"];
  self.a.var_2274["semi5"] = level.var_EC85["snowmobile"][var_0]["fire"];
}

func_103D4(var_0) {
  self.a.var_2274 = [];
  func_103D3("driver");
  self.a.var_2274["left2right"] = level.var_EC85["snowmobile"]["driver"]["left2right"];
  self.a.var_2274["right2left"] = level.var_EC85["snowmobile"]["driver"]["right2left"];
  self.a.var_2274["straight_level_left"] = level.var_EC85["snowmobile"]["driver"]["straight_level"]["left"];
  self.a.var_2274["straight_level_center"] = level.var_EC85["snowmobile"]["driver"]["straight_level"]["center"];
  self.a.var_2274["straight_level_right"] = level.var_EC85["snowmobile"]["driver"]["straight_level"]["right"];
  self.a.var_2274["add_aim_left_left"] = level.var_EC85["snowmobile"]["driver"]["add_aim_left"]["left"];
  self.a.var_2274["add_aim_left_center"] = level.var_EC85["snowmobile"]["driver"]["add_aim_left"]["center"];
  self.a.var_2274["add_aim_left_right"] = level.var_EC85["snowmobile"]["driver"]["add_aim_left"]["right"];
  self.a.var_2274["add_aim_right_left"] = level.var_EC85["snowmobile"]["driver"]["add_aim_right"]["left"];
  self.a.var_2274["add_aim_right_center"] = level.var_EC85["snowmobile"]["driver"]["add_aim_right"]["center"];
  self.a.var_2274["add_aim_right_right"] = level.var_EC85["snowmobile"]["driver"]["add_aim_right"]["right"];
  if(var_0) {
    self.a.var_2274["event_jump"] = level.var_EC85["snowmobile"]["driver"]["shoot_jump"];
    self.a.var_2274["event_bump"] = level.var_EC85["snowmobile"]["driver"]["shoot_bump"];
    self.a.var_2274["event_bump_big"] = level.var_EC85["snowmobile"]["driver"]["shoot_bump_big"];
    self.a.var_2274["event_sway"] = [];
    self.a.var_2274["event_sway"]["left"] = level.var_EC85["snowmobile"]["driver"]["shoot_sway_left"];
    self.a.var_2274["event_sway"]["right"] = level.var_EC85["snowmobile"]["driver"]["shoot_sway_right"];
    self.a.var_2274["event_restore"] = % sm_aiming;
    return;
  }

  self.a.var_2274["event_jump"] = level.var_EC85["snowmobile"]["driver"]["drive_jump"];
  self.a.var_2274["event_bump"] = level.var_EC85["snowmobile"]["driver"]["drive_bump"];
  self.a.var_2274["event_bump_big"] = level.var_EC85["snowmobile"]["driver"]["drive_bump_big"];
  self.a.var_2274["event_sway"] = [];
  self.a.var_2274["event_sway"]["left"] = level.var_EC85["snowmobile"]["driver"]["drive_sway_left"];
  self.a.var_2274["event_sway"]["right"] = level.var_EC85["snowmobile"]["driver"]["drive_sway_right"];
  self.a.var_2274["event_restore"] = % sm_turn;
}

func_103D5(var_0) {
  self.a.var_2274 = [];
  func_103D3("passenger");
  self.a.var_2274["hide"] = level.var_EC85["snowmobile"]["passenger"]["hide"];
  self.a.var_2274["lean_left"] = level.var_EC85["snowmobile"]["passenger"]["add_lean"]["left"];
  self.a.var_2274["lean_right"] = level.var_EC85["snowmobile"]["passenger"]["add_lean"]["right"];
  self.a.var_2274["reload"] = level.var_EC85["snowmobile"]["passenger"]["reload"];
  self.a.var_2274["gun_up"] = level.var_EC85["snowmobile"]["passenger"]["gun_up"];
  self.a.var_2274["gun_down"] = level.var_EC85["snowmobile"]["passenger"]["gun_down"];
  self.a.var_2274["aim_left_left"] = level.var_EC85["snowmobile"]["passenger"]["aim_left"]["left"];
  self.a.var_2274["aim_left_center"] = level.var_EC85["snowmobile"]["passenger"]["aim_left"]["center"];
  self.a.var_2274["aim_left_right"] = level.var_EC85["snowmobile"]["passenger"]["aim_left"]["right"];
  self.a.var_2274["aim_right_left"] = level.var_EC85["snowmobile"]["passenger"]["aim_right"]["left"];
  self.a.var_2274["aim_right_center"] = level.var_EC85["snowmobile"]["passenger"]["aim_right"]["center"];
  self.a.var_2274["aim_right_right"] = level.var_EC85["snowmobile"]["passenger"]["aim_right"]["right"];
  self.a.var_2274["add_aim_backleft_left"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backleft"]["left"];
  self.a.var_2274["add_aim_backleft_center"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backleft"]["center"];
  self.a.var_2274["add_aim_backleft_right"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backleft"]["right"];
  self.a.var_2274["add_aim_backright_left"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backright"]["left"];
  self.a.var_2274["add_aim_backright_center"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backright"]["center"];
  self.a.var_2274["add_aim_backright_right"] = level.var_EC85["snowmobile"]["passenger"]["add_aim_backright"]["right"];
  self.a.var_2274["straight_level_left"] = level.var_EC85["snowmobile"]["passenger"]["straight_level"]["left"];
  self.a.var_2274["straight_level_center"] = level.var_EC85["snowmobile"]["passenger"]["straight_level"]["center"];
  self.a.var_2274["straight_level_right"] = level.var_EC85["snowmobile"]["passenger"]["straight_level"]["right"];
  if(var_0) {
    self.a.var_2274["event_jump"] = level.var_EC85["snowmobile"]["passenger"]["drive_jump"];
    self.a.var_2274["event_bump"] = level.var_EC85["snowmobile"]["passenger"]["drive_bump"];
    self.a.var_2274["event_bump_big"] = level.var_EC85["snowmobile"]["passenger"]["drive_bump_big"];
    self.a.var_2274["event_sway"] = [];
    self.a.var_2274["event_sway"]["left"] = level.var_EC85["snowmobile"]["passenger"]["drive_sway_left"];
    self.a.var_2274["event_sway"]["right"] = level.var_EC85["snowmobile"]["passenger"]["drive_sway_right"];
    self.a.var_2274["event_restore"] = % sm_aiming;
    return;
  }

  self.a.var_2274["event_jump"] = level.var_EC85["snowmobile"]["passenger"]["hide_jump"];
  self.a.var_2274["event_bump"] = level.var_EC85["snowmobile"]["passenger"]["hide_bump"];
  self.a.var_2274["event_bump_big"] = level.var_EC85["snowmobile"]["passenger"]["hide_bump_big"];
  self.a.var_2274["event_sway"] = [];
  self.a.var_2274["event_sway"]["left"] = level.var_EC85["snowmobile"]["passenger"]["hide_sway_left"];
  self.a.var_2274["event_sway"]["right"] = level.var_EC85["snowmobile"]["passenger"]["hide_sway_right"];
  self.a.var_2274["event_restore"] = % sm_turn;
}