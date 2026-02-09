/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\atv.gsc
**************************************/

main() {
  self._id_0EE8 = "none";
  self._id_0EE9 = undefined;
  _id_24CB();
  _id_0EF0();
}

_id_24CB() {
  self.grenadeawareness = 0;
  self.a._id_0D26 = "crouch";
  maps\_utility::_id_0EEC();
  self.allowpain = 0;
  self._id_0EED = ::_id_24CC;
  self._id_0D4B = ::_id_24E1;
  self._id_0EEE = 1;
}

_id_24CC() {
  self.allowpain = 1;
  self._id_0EED = undefined;
  self._id_0D4B = undefined;
  self.a._id_0CE6 = undefined;
  self._id_0EEE = undefined;
}

_id_0EF0() {
  var_0 = self._id_0EF1._id_0EF2 || self._id_0EF1._id_0A39.size == 1;
  _id_24E4(var_0);

  if(var_0) {
    animscripts\shared::_id_0C9B(self.primaryweapon, "left");
    self.rightaimlimit = 90;
    self.leftaimlimit = -90;
    animscripts\track::_id_0CC4(1, 0.2);
    thread _id_24DC();
    thread _id_24CE();
  } else {
    animscripts\shared::_id_0C9B(self.primaryweapon, "none");
    thread _id_24CD();
  }

  _id_24D0("driver");
}

#using_animtree("generic_human");

_id_24CD() {
  self endon("death");
  self endon("killanimscript");
  var_0 = "left2right";
  var_1 = [];
  var_1["left2right"] = getanimlength(animscripts\utility::_id_0D4D("left2right"));
  var_1["right2left"] = getanimlength(animscripts\utility::_id_0D4D("right2left"));
  self setanimknoball(%atv_turn, %body, 1, 0);
  self setanim(animscripts\utility::_id_0D4D("drive"), 1, 0);
  self setanimknob(animscripts\utility::_id_0D4D(var_0), 1, 0);
  self setanimtime(animscripts\utility::_id_0D4D(var_0), 0.5);

  for(;;) {
    if(self._id_0EF1._id_0EF7) {
      var_2 = 0.5 * (1 + maps\_vehicle::_id_0EF8(self._id_0EF1));
      var_3 = self getanimtime(animscripts\utility::_id_0D4D(var_0));

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

    self setanimknoblimited(animscripts\utility::_id_0D4D(var_0), 1, 0.1, var_4);
    self setanimtime(animscripts\utility::_id_0D4D(var_0), var_3);
    wait 0.05;
  }
}

_id_24CE() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  var_1 = 0;
  self setanimknoball(%atv_aiming, %body, 1, 0);
  self setanimknob(animscripts\utility::_id_0D4D("idle"), 1, 0);

  for(;;) {
    if(self._id_0EE8 != "none") {
      self waittill("atv_event_finished");
      continue;
    }

    var_2 = maps\_vehicle::_id_0EF8(self._id_0EF1);
    var_3 = 1 - abs(var_2);
    var_4 = max(0, 0 - var_2);
    var_5 = max(0, var_2);
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("straight_level_right"), var_5, var_0);

    if(self._id_0CD1 <= 0) {
      animscripts\weaponlist::_id_0CD0();
      var_1 = gettime() + 3000;
    }

    if(var_1 <= gettime()) {
      _id_24D1();
    }
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_left_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("add_aim_left_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("add_aim_left_right"), var_5, var_0);
    self setanimknoblimited(animscripts\utility::_id_0D4D("add_aim_right_center"), var_3, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("add_aim_right_left"), var_4, var_0);
    self setanimlimited(animscripts\utility::_id_0D4D("add_aim_right_right"), var_5, var_0);
    thread _id_24D2();
    wait 0.05;
  }
}

_id_24CF(var_0) {
  self endon("death");
  self._id_0EF1._id_0EF7 = 0;
  self setflaggedanimknoblimitedrestart("atv_event", var_0, 1, 0.17);
  animscripts\shared::_id_0C51("atv_event", ::_id_24DB);
  self setanimknoblimited(animscripts\utility::_id_0D4D("event_restore"), 1, 0.1);
  self._id_0EF1._id_0EF7 = 1;
  self._id_0EE8 = "none";
  self notify("atv_event_finished");
}

_id_24D0(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = self._id_0EF1;

  for(;;) {
    if(var_1._id_0EFE["jump"][var_0]) {
      var_1._id_0EFE["jump"][var_0] = 0;
      self notify("atv_event_occurred");
      self._id_0EE8 = "jump";
      var_1._id_0EF7 = 0;
      self setflaggedanimknoblimitedrestart("jump", animscripts\utility::_id_0D4D("event_jump"), 1, 0.17);
    }

    if(var_1._id_0EFE["bump"][var_0]) {
      var_1._id_0EFE["bump"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_0EE8 != "bump_big") {
        thread _id_24CF(animscripts\utility::_id_0D4D("event_bump"));
      }
    }

    if(var_1._id_0EFE["bump_big"][var_0]) {
      var_1._id_0EFE["bump_big"][var_0] = 0;
      self notify("atv_event_occurred");
      self._id_0EE8 = "bump_big";
      thread _id_24CF(animscripts\utility::_id_0D4D("event_bump_big"));
    }

    if(var_1._id_0EFE["sway_left"][var_0]) {
      var_1._id_0EFE["sway_left"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_0EE8 != "bump_big") {
        thread _id_24CF(animscripts\utility::_id_0D4D("event_sway")["left"]);
      }
    }

    if(var_1._id_0EFE["sway_right"][var_0]) {
      var_1._id_0EFE["sway_right"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_0EE8 != "bump_big") {
        thread _id_24CF(animscripts\utility::_id_0D4D("event_sway")["right"]);
      }
    }

    wait 0.05;
  }
}

_id_24D1() {
  self notify("want_shoot_while_driving");
  self setanim(%atv_add_fire, 1, 0.2);

  if(isDefined(self._id_0EE9)) {
    return;
  }
  self._id_0EE9 = 1;
  thread _id_24D3();
  thread _id_24D6();
}

_id_24D2() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait 0.05;
  self notify("end_shoot_while_driving");
  self._id_0EE9 = undefined;
  self clearanim(%atv_add_fire, 0.2);
}

_id_24D3() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a._id_0CE6 = ::_id_24D5;
  _id_24D4();
  self._id_0EE9 = undefined;
}

_id_24D4() {
  self endon("atv_event_occurred");
  animscripts\shoot_behavior::_id_0CD7("normal");
}

_id_24D5() {
  if(!isDefined(self.enemy)) {
    self._id_0CAB = undefined;
    self._id_0CB1 = undefined;
    self._id_0CDA = "none";
    return;
  }

  self._id_0CAB = self.enemy;
  self._id_0CB1 = self.enemy getshootatpos();
  var_0 = distancesquared(self.origin, self.enemy.origin);

  if(var_0 < 1000000) {
    self._id_0CDA = "full";
  } else if(var_0 < 4000000) {
    self._id_0CDA = "burst";
  } else {
    self._id_0CDA = "single";
  }
  if(isDefined(self.enemy.vehicle)) {
    var_1 = 0.5;
    var_2 = self._id_0CAB.vehicle;
    var_3 = self._id_0EF1;
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
        self._id_0CAB = undefined;
        self._id_0CB1 = var_2.origin + var_8 * var_5 + var_9 * var_6;
        return;
      }
    }
  }
}

_id_24D6() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self notify("doing_shootWhileDriving");
  self endon("doing_shootWhileDriving");

  for(;;) {
    if(!self._id_0CD1) {
      wait 0.5;
      continue;
    }

    animscripts\combat_utility::_id_0F06();
  }
}

_id_24D7() {
  if(!self._id_0EF1._id_0EF7) {
    return 0;
  }
  if(!animscripts\combat_utility::_id_0F08(0)) {
    return 0;
  }
  if(!animscripts\utility::_id_0EE3()) {
    return 0;
  }
  _id_24D8();
  self notify("abort_reload");
  return 1;
}

_id_24D8() {
  self endon("atv_event_occurred");
  self._id_0F0A = 1;
  self waittill("start_blending_reload");
  self setanim(%atv_aiming, 0, 0.25);
  self setflaggedanimrestart("gun_down", animscripts\utility::_id_0D4D("gun_down"), 1, 0.25);
  animscripts\shared::_id_0C51("gun_down");
  self clearanim(animscripts\utility::_id_0D4D("gun_down"), 0);
  self setflaggedanimknoballrestart("reload_anim", animscripts\utility::_id_0D4D("reload"), %body, 1, 0.25);
  animscripts\shared::_id_0C51("reload_anim");
  self clearanim(%atv_reload, 0.2);
  self setflaggedanimrestart("gun_up", animscripts\utility::_id_0D4D("gun_up"), 1, 0.25);
  self._id_0F0B = 1;
  animscripts\shared::_id_0C51("gun_up", ::_id_24D9);
  self._id_0F0A = undefined;
  self clearanim(%atv_reload, 0.1);
  self setanim(%atv_aiming, 1, 0.1);

  if(isDefined(self._id_0F0B)) {
    self._id_0F0B = undefined;
    animscripts\shared::_id_0C51("gun_up", ::_id_24DA);
    self clearanim(animscripts\utility::_id_0D4D("gun_up"), 0);
  }
}

_id_24D9(var_0) {
  if(var_0 == "start_aim") {
    return 1;
  }
}

_id_24DA(var_0) {
  if(var_0 == "end") {
    return 1;
  }
}

_id_24DB(var_0) {
  if(var_0 == "start_lean") {
    return 1;
  }
}

_id_24DC() {
  self endon("killanimscript");
  self endon("stop tracking");
  var_0 = 0.05;
  var_1 = 8;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    animscripts\track::_id_0CC9();
    var_5 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_6 = self._id_0CB1;

    if(isDefined(self._id_0CAB)) {
      var_6 = self._id_0CAB getshootatpos();
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
    } else {
      var_10 = var_3 - var_2;

      if(abs(var_10) > var_1) {
        var_3 = var_2 + var_1 * common_scripts\utility::sign(var_10);
      }
    }

    var_2 = var_3;
    var_11 = min(max(0 - var_3, 0), 90) / 90 * self.a._id_0CC3;
    var_12 = min(max(var_3, 0), 90) / 90 * self.a._id_0CC3;
    self setanimlimited(%atv_aim_4, var_11, var_0);
    self setanimlimited(%atv_aim_6, var_12, var_0);
    wait 0.05;
  }
}

_id_24DD(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = animscripts\utility::_id_0D61(var_2 - var_1[var_6]);

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

  if(isDefined(anim._id_24DE) && var_8 == anim._id_24DE && gettime() - anim._id_24DF < 500) {
    var_8 = var_4;
  }
  anim._id_24DE = var_8;
  anim._id_24DF = gettime();
  return var_8;
}

_id_24E0() {
  var_0 = self._id_0EF1;
  var_1 = var_0._id_0F15;
  var_1 = (var_1[0], var_1[1], randomfloatrange(200, 400)) * 0.75;

  if(lengthsquared(var_1) > 1000000) {
    var_1 = vectornormalize(var_1) * 1000;
  }
  var_2 = spawn("script_origin", self.origin);
  var_2 moveslide((0, 0, 40), 15, var_1);
  self linkto(var_2);
  var_2 thread _id_0F18();
}

_id_24E1() {
  var_0 = [];
  var_0[0] = level._id_0C59["atv"]["small"]["death"]["back"];
  var_0[1] = level._id_0C59["atv"]["small"]["death"]["right"];
  var_0[2] = level._id_0C59["atv"]["small"]["death"]["left"];
  var_1 = [];
  var_1[0] = -180;
  var_1[1] = -90;
  var_1[2] = 90;
  var_2 = _id_24DD(var_0, var_1, self.damageyaw);
  animscripts\death::_id_0D56(var_2);
  return 1;
}

_id_24E2() {
  var_0 = self._id_0EF1;

  if(!isDefined(var_0)) {
    return _id_24E1();
  }
  var_1 = var_0._id_0F15;
  _id_24E0();
  var_2 = vectortoangles(var_1);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = [];
  var_4[0] = level._id_0C59["atv"]["big"]["death"]["back"];
  var_4[1] = level._id_0C59["atv"]["big"]["death"]["left"];
  var_4[2] = level._id_0C59["atv"]["big"]["death"]["front"];
  var_4[3] = level._id_0C59["atv"]["big"]["death"]["right"];
  var_5 = [];
  var_5[0] = -180;
  var_5[1] = -90;
  var_5[2] = 0;
  var_5[3] = 90;
  var_6 = _id_24DD(var_4, var_5, var_3);
  animscripts\death::_id_0D56(var_6);
  return 1;
}

_id_0F18() {
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

_id_24E3(var_0) {
  self.a._id_0C6D["idle"] = level._id_0C59["atv"][var_0]["idle"];
  self.a._id_0C6D["drive"] = level._id_0C59["atv"][var_0]["drive"];
  self.a._id_0C6D["fire"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["single"] = animscripts\utility::_id_0C6D(level._id_0C59["atv"][var_0]["single"]);
  self.a._id_0C6D["burst2"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["burst3"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["burst4"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["burst5"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["burst6"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["semi2"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["semi3"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["semi4"] = level._id_0C59["atv"][var_0]["fire"];
  self.a._id_0C6D["semi5"] = level._id_0C59["atv"][var_0]["fire"];
}

_id_24E4(var_0) {
  self.a._id_0C6D = [];
  _id_24E3("driver");
  self.a._id_0C6D["left2right"] = level._id_0C59["atv"]["driver"]["left2right"];
  self.a._id_0C6D["right2left"] = level._id_0C59["atv"]["driver"]["right2left"];
  self.a._id_0C6D["straight_level_left"] = level._id_0C59["atv"]["driver"]["straight_level"]["left"];
  self.a._id_0C6D["straight_level_center"] = level._id_0C59["atv"]["driver"]["straight_level"]["center"];
  self.a._id_0C6D["straight_level_right"] = level._id_0C59["atv"]["driver"]["straight_level"]["right"];
  self.a._id_0C6D["add_aim_left_left"] = level._id_0C59["atv"]["driver"]["add_aim_left"]["left"];
  self.a._id_0C6D["add_aim_left_center"] = level._id_0C59["atv"]["driver"]["add_aim_left"]["center"];
  self.a._id_0C6D["add_aim_left_right"] = level._id_0C59["atv"]["driver"]["add_aim_left"]["right"];
  self.a._id_0C6D["add_aim_right_left"] = level._id_0C59["atv"]["driver"]["add_aim_right"]["left"];
  self.a._id_0C6D["add_aim_right_center"] = level._id_0C59["atv"]["driver"]["add_aim_right"]["center"];
  self.a._id_0C6D["add_aim_right_right"] = level._id_0C59["atv"]["driver"]["add_aim_right"]["right"];

  if(var_0) {
    self.a._id_0C6D["event_jump"] = level._id_0C59["atv"]["driver"]["shoot_jump"];
    self.a._id_0C6D["event_bump"] = level._id_0C59["atv"]["driver"]["shoot_bump"];
    self.a._id_0C6D["event_bump_big"] = level._id_0C59["atv"]["driver"]["shoot_bump_big"];
    self.a._id_0C6D["event_sway"] = [];
    self.a._id_0C6D["event_sway"]["left"] = level._id_0C59["atv"]["driver"]["shoot_sway_left"];
    self.a._id_0C6D["event_sway"]["right"] = level._id_0C59["atv"]["driver"]["shoot_sway_right"];
    self.a._id_0C6D["event_restore"] = % atv_aiming;
  } else {
    self.a._id_0C6D["event_jump"] = level._id_0C59["atv"]["driver"]["drive_jump"];
    self.a._id_0C6D["event_bump"] = level._id_0C59["atv"]["driver"]["drive_bump"];
    self.a._id_0C6D["event_bump_big"] = level._id_0C59["atv"]["driver"]["drive_bump_big"];
    self.a._id_0C6D["event_sway"] = [];
    self.a._id_0C6D["event_sway"]["left"] = level._id_0C59["atv"]["driver"]["drive_sway_left"];
    self.a._id_0C6D["event_sway"]["right"] = level._id_0C59["atv"]["driver"]["drive_sway_right"];
    self.a._id_0C6D["event_restore"] = % atv_turn;
  }
}