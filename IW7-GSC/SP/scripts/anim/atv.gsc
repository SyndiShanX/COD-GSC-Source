/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\atv.gsc
**************************************/

main() {
  self._id_4B71 = "none";
  self._id_FE91 = undefined;
  _id_255B();
  _id_B1C3();
}

_id_255B() {
  self.grenadeawareness = 0;
  self.a.pose = "crouch";
  scripts\sp\utility::_id_558D();
  self.allowpain = 0;
  self._id_6EC4 = 1;
  self._id_8020 = ::_id_255A;
  self._id_10957 = ::_id_255F;
  self.disablebulletwhizbyreaction = 1;
}

_id_255A() {
  self.allowpain = 1;
  self._id_6EC4 = 0;
  scripts\sp\utility::_id_86E2();
  self.onatv = undefined;
  self._id_4C37["combat"] = undefined;
  self._id_4C37["stop"] = undefined;
  self._id_8020 = undefined;
  self._id_10957 = undefined;
  self.a._id_1096D = undefined;
  self.disablebulletwhizbyreaction = undefined;
}

_id_B1C3() {
  var_0 = self._id_E500._id_5BCB || self._id_E500._id_E4FB.size == 1;
  _id_2565(var_0);

  if(var_0) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "left");
    self.rightaimlimit = -90;
    self.leftaimlimit = 90;
    scripts\anim\track::_id_F641(1, 0.2);
    thread _id_256A();
    thread _id_255E();
  } else {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
    thread _id_255D();
  }

  _id_255C("driver");
}

#using_animtree("generic_human");

_id_255D() {
  self endon("death");
  self endon("killanimscript");
  var_0 = "left2right";
  var_1 = [];
  var_1["left2right"] = getanimlength(scripts\anim\utility::_id_1F64("left2right"));
  var_1["right2left"] = getanimlength(scripts\anim\utility::_id_1F64("right2left"));
  self _meth_82A5(%atv_turn, %body, 1, 0);
  self _meth_82A2(scripts\anim\utility::_id_1F64("drive"), 1, 0);
  self setanimknob(scripts\anim\utility::_id_1F64(var_0), 1, 0);
  self _meth_82B0(scripts\anim\utility::_id_1F64(var_0), 0.5);

  for(;;) {
    if(self._id_E500._id_10F83) {
      var_2 = 0.5 * (1 + scripts\sp\vehicle_code::_id_12E33(self._id_E500));
      var_3 = self islegacyagent(scripts\anim\utility::_id_1F64(var_0));

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

    self _meth_82A9(scripts\anim\utility::_id_1F64(var_0), 1, 0.1, var_4);
    self _meth_82B0(scripts\anim\utility::_id_1F64(var_0), var_3);
    wait 0.05;
  }
}

_id_255E() {
  self endon("death");
  self endon("killanimscript");
  var_0 = 0.05;
  var_1 = 0;
  self _meth_82A5(%atv_aiming, %body, 1, 0);
  self setanimknob(scripts\anim\utility::_id_1F64("idle"), 1, 0);

  for(;;) {
    if(self._id_4B71 != "none") {
      self waittill("atv_event_finished");
      continue;
    }

    var_2 = scripts\sp\vehicle_code::_id_12E33(self._id_E500);
    var_3 = 1 - abs(var_2);
    var_4 = max(0, 0 - var_2);
    var_5 = max(0, var_2);
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level_center"), var_3, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level_left"), var_4, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("straight_level_right"), var_5, var_0);

    if(self.bulletsinclip <= 0) {
      scripts\anim\weaponlist::refillclip();
      var_1 = gettime() + 3000;
    }

    if(var_1 <= gettime())
      _id_2568();

    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_left_center"), var_3, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("add_aim_left_left"), var_4, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("add_aim_left_right"), var_5, var_0);
    self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_right_center"), var_3, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("add_aim_right_left"), var_4, var_0);
    self _meth_82AC(scripts\anim\utility::_id_1F64("add_aim_right_right"), var_5, var_0);
    thread _id_2569();
    wait 0.05;
  }
}

_id_2558(var_0) {
  self endon("death");
  self._id_E500._id_10F83 = 0;
  self _meth_82E6("atv_event", var_0, 1, 0.17);
  scripts\anim\shared::donotetracks("atv_event", ::_id_256F);
  self _meth_82A9(scripts\anim\utility::_id_1F64("event_restore"), 1, 0.1);
  self._id_E500._id_10F83 = 1;
  self._id_4B71 = "none";
  self notify("atv_event_finished");
}

_id_255C(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = self._id_E500;

  for(;;) {
    if(var_1._id_67E5["jump"][var_0]) {
      var_1._id_67E5["jump"][var_0] = 0;
      self notify("atv_event_occurred");
      self._id_4B71 = "jump";
      var_1._id_10F83 = 0;
      self _meth_82E6("jump", scripts\anim\utility::_id_1F64("event_jump"), 1, 0.17);
    }

    if(var_1._id_67E5["bump"][var_0]) {
      var_1._id_67E5["bump"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_4B71 != "bump_big")
        thread _id_2558(scripts\anim\utility::_id_1F64("event_bump"));
    }

    if(var_1._id_67E5["bump_big"][var_0]) {
      var_1._id_67E5["bump_big"][var_0] = 0;
      self notify("atv_event_occurred");
      self._id_4B71 = "bump_big";
      thread _id_2558(scripts\anim\utility::_id_1F64("event_bump_big"));
    }

    if(var_1._id_67E5["sway_left"][var_0]) {
      var_1._id_67E5["sway_left"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_4B71 != "bump_big")
        thread _id_2558(scripts\anim\utility::_id_1F64("event_sway")["left"]);
    }

    if(var_1._id_67E5["sway_right"][var_0]) {
      var_1._id_67E5["sway_right"][var_0] = 0;
      self notify("atv_event_occurred");

      if(self._id_4B71 != "bump_big")
        thread _id_2558(scripts\anim\utility::_id_1F64("event_sway")["right"]);
    }

    wait 0.05;
  }
}

_id_2568() {
  self notify("want_shoot_while_driving");
  self _meth_82A2(%atv_add_fire, 1, 0.2);

  if(isDefined(self._id_FE91)) {
    return;
  }
  self._id_FE91 = 1;
  thread _id_2556();
  thread _id_2566();
}

_id_2569() {
  self endon("killanimscript");
  self endon("want_shoot_while_driving");
  wait 0.05;
  self notify("end_shoot_while_driving");
  self._id_FE91 = undefined;
  self clearanim(%atv_add_fire, 0.2);
}

_id_2556() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self.a._id_1096D = ::_id_2570;
  _id_2557();
  self._id_FE91 = undefined;
}

_id_2557() {
  self endon("atv_event_occurred");
  scripts\anim\shoot_behavior::_id_4F69("normal");
}

_id_2570() {
  if(!isDefined(self.enemy)) {
    self._id_FE9E = undefined;
    self._id_FECF = undefined;
    self._id_FED7 = "none";
    return;
  }

  self._id_FE9E = self.enemy;
  self._id_FECF = self.enemy getshootatpos();
  var_0 = distancesquared(self.origin, self.enemy.origin);

  if(var_0 < 1000000)
    self._id_FED7 = "full";
  else if(var_0 < 4000000)
    self._id_FED7 = "burst";
  else
    self._id_FED7 = "single";

  if(isDefined(self.enemy.vehicle)) {
    var_1 = 0.5;
    var_2 = self._id_FE9E.vehicle;
    var_3 = self._id_E500;
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

        self._id_FE9E = undefined;
        self._id_FECF = var_2.origin + var_8 * var_5 + var_9 * var_6;
        return;
      }
    }
  }
}

_id_2566() {
  self endon("killanimscript");
  self endon("end_shoot_while_driving");
  self notify("doing_shootWhileDriving");
  self endon("doing_shootWhileDriving");

  for(;;) {
    if(!self.bulletsinclip) {
      wait 0.5;
      continue;
    }

    scripts\anim\combat_utility::_id_FEDF();
  }
}

_id_2560() {
  if(!self._id_E500._id_10F83)
    return 0;

  if(!scripts\anim\utility_common::needtoreload(0))
    return 0;

  if(!scripts\anim\utility_common::usingriflelikeweapon())
    return 0;

  _id_2561();
  self notify("abort_reload");
  return 1;
}

_id_2561() {
  self endon("atv_event_occurred");
  self._id_10FB2 = 1;
  self waittill("start_blending_reload");
  self _meth_82A2(%atv_aiming, 0, 0.25);
  self _meth_82EA("gun_down", scripts\anim\utility::_id_1F64("gun_down"), 1, 0.25);
  scripts\anim\shared::donotetracks("gun_down");
  self clearanim(scripts\anim\utility::_id_1F64("gun_down"), 0);
  self _meth_82E4("reload_anim", scripts\anim\utility::_id_1F64("reload"), %body, 1, 0.25);
  scripts\anim\shared::donotetracks("reload_anim");
  self clearanim(%atv_reload, 0.2);
  self _meth_82EA("gun_up", scripts\anim\utility::_id_1F64("gun_up"), 1, 0.25);
  self._id_86EC = 1;
  scripts\anim\shared::donotetracks("gun_up", ::_id_256E);
  self._id_10FB2 = undefined;
  self clearanim(%atv_reload, 0.1);
  self _meth_82A2(%atv_aiming, 1, 0.1);

  if(isDefined(self._id_86EC)) {
    self._id_86EC = undefined;
    scripts\anim\shared::donotetracks("gun_up", ::_id_256D);
    self clearanim(scripts\anim\utility::_id_1F64("gun_up"), 0);
  }
}

_id_256E(var_0) {
  if(var_0 == "start_aim")
    return 1;
}

_id_256D(var_0) {
  if(var_0 == "end")
    return 1;
}

_id_256F(var_0) {
  if(var_0 == "start_lean")
    return 1;
}

_id_256A() {
  self endon("killanimscript");
  self endon("stop tracking");
  var_0 = 0.05;
  var_1 = 8;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    scripts\anim\track::_id_93E2();
    var_5 = (self.origin[0], self.origin[1], self getEye()[2]);
    var_6 = self._id_FECF;

    if(isDefined(self._id_FE9E))
      var_6 = self._id_FE9E getshootatpos();

    if(!isDefined(var_6)) {
      var_3 = 0;
      var_7 = self _meth_80FC();

      if(isDefined(var_7))
        var_3 = angleclamp180(self.angles[1] - var_7[1]);
    } else {
      var_8 = var_6 - var_5;
      var_9 = vectortoangles(var_8);
      var_3 = self.angles[1] - var_9[1];
      var_3 = angleclamp180(var_3);
    }

    if(var_3 < self.rightaimlimit || var_3 > self.leftaimlimit)
      var_3 = 0;

    if(var_4)
      var_4 = 0;
    else {
      var_10 = var_3 - var_2;

      if(abs(var_10) > var_1)
        var_3 = var_2 + var_1 * scripts\engine\utility::sign(var_10);
    }

    var_2 = var_3;
    var_11 = min(max(0 - var_3, 0), 90) / 90 * self.a._id_1A4B;
    var_12 = min(max(var_3, 0), 90) / 90 * self.a._id_1A4B;
    self _meth_82AC(%atv_aim_4, var_11, var_0);
    self _meth_82AC(%atv_aim_6, var_12, var_0);
    wait 0.05;
  }
}

_id_2559(var_0, var_1, var_2) {
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

    if(!isDefined(var_4))
      var_4 = var_0[var_6];
  }

  var_8 = var_3;

  if(isDefined(anim._id_D893) && var_8 == anim._id_D893 && gettime() - anim._id_D894 < 500)
    var_8 = var_4;

  anim._id_D893 = var_8;
  anim._id_D894 = gettime();
  return var_8;
}

_id_2555() {
  var_0 = self._id_E500;
  var_1 = var_0._id_D89A;
  var_1 = (var_1[0], var_1[1], randomfloatrange(200, 400)) * 0.75;

  if(lengthsquared(var_1) > 1000000)
    var_1 = vectorNormalize(var_1) * 1000;

  var_2 = spawn("script_origin", self.origin);
  var_2 moveslide((0, 0, 40), 15, var_1);
  self linkTo(var_2);
  var_2 thread _id_51D1();
}

_id_255F() {
  var_0 = [];
  var_0[0] = level._id_EC85["atv"]["small"]["death"]["back"];
  var_0[1] = level._id_EC85["atv"]["small"]["death"]["right"];
  var_0[2] = level._id_EC85["atv"]["small"]["death"]["left"];
  var_1 = [];
  var_1[0] = -180;
  var_1[1] = -90;
  var_1[2] = 90;
  var_2 = _id_2559(var_0, var_1, self.damageyaw);
  scripts\anim\death::_id_CF0E(var_2);
  return 1;
}

_id_2554() {
  var_0 = self._id_E500;

  if(!isDefined(var_0))
    return _id_255F();

  var_1 = var_0._id_D89A;
  _id_2555();
  var_2 = vectortoangles(var_1);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = [];
  var_4[0] = level._id_EC85["atv"]["big"]["death"]["back"];
  var_4[1] = level._id_EC85["atv"]["big"]["death"]["left"];
  var_4[2] = level._id_EC85["atv"]["big"]["death"]["front"];
  var_4[3] = level._id_EC85["atv"]["big"]["death"]["right"];
  var_5 = [];
  var_5[0] = -180;
  var_5[1] = -90;
  var_5[2] = 0;
  var_5[3] = 90;
  var_6 = _id_2559(var_4, var_5, var_3);
  scripts\anim\death::_id_CF0E(var_6);
  return 1;
}

_id_51D1() {
  var_0 = self.origin;

  for(var_1 = 0; var_1 < 60; var_1++) {
    wait 0.05;
    var_0 = self.origin;
  }

  wait 3;

  if(isDefined(self))
    self delete();
}

_id_2564(var_0) {
  self.a._id_2274["idle"] = level._id_EC85["atv"][var_0]["idle"];
  self.a._id_2274["drive"] = level._id_EC85["atv"][var_0]["drive"];
  self.a._id_2274["fire"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["single"] = scripts\anim\utility::_id_2274(level._id_EC85["atv"][var_0]["single"]);
  self.a._id_2274["burst2"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["burst3"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["burst4"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["burst5"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["burst6"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["semi2"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["semi3"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["semi4"] = level._id_EC85["atv"][var_0]["fire"];
  self.a._id_2274["semi5"] = level._id_EC85["atv"][var_0]["fire"];
}

_id_2565(var_0) {
  self.a._id_2274 = [];
  _id_2564("driver");
  self.a._id_2274["left2right"] = level._id_EC85["atv"]["driver"]["left2right"];
  self.a._id_2274["right2left"] = level._id_EC85["atv"]["driver"]["right2left"];
  self.a._id_2274["straight_level_left"] = level._id_EC85["atv"]["driver"]["straight_level"]["left"];
  self.a._id_2274["straight_level_center"] = level._id_EC85["atv"]["driver"]["straight_level"]["center"];
  self.a._id_2274["straight_level_right"] = level._id_EC85["atv"]["driver"]["straight_level"]["right"];
  self.a._id_2274["add_aim_left_left"] = level._id_EC85["atv"]["driver"]["add_aim_left"]["left"];
  self.a._id_2274["add_aim_left_center"] = level._id_EC85["atv"]["driver"]["add_aim_left"]["center"];
  self.a._id_2274["add_aim_left_right"] = level._id_EC85["atv"]["driver"]["add_aim_left"]["right"];
  self.a._id_2274["add_aim_right_left"] = level._id_EC85["atv"]["driver"]["add_aim_right"]["left"];
  self.a._id_2274["add_aim_right_center"] = level._id_EC85["atv"]["driver"]["add_aim_right"]["center"];
  self.a._id_2274["add_aim_right_right"] = level._id_EC85["atv"]["driver"]["add_aim_right"]["right"];

  if(var_0) {
    self.a._id_2274["event_jump"] = level._id_EC85["atv"]["driver"]["shoot_jump"];
    self.a._id_2274["event_bump"] = level._id_EC85["atv"]["driver"]["shoot_bump"];
    self.a._id_2274["event_bump_big"] = level._id_EC85["atv"]["driver"]["shoot_bump_big"];
    self.a._id_2274["event_sway"] = [];
    self.a._id_2274["event_sway"]["left"] = level._id_EC85["atv"]["driver"]["shoot_sway_left"];
    self.a._id_2274["event_sway"]["right"] = level._id_EC85["atv"]["driver"]["shoot_sway_right"];
    self.a._id_2274["event_restore"] = % atv_aiming;
  } else {
    self.a._id_2274["event_jump"] = level._id_EC85["atv"]["driver"]["drive_jump"];
    self.a._id_2274["event_bump"] = level._id_EC85["atv"]["driver"]["drive_bump"];
    self.a._id_2274["event_bump_big"] = level._id_EC85["atv"]["driver"]["drive_bump_big"];
    self.a._id_2274["event_sway"] = [];
    self.a._id_2274["event_sway"]["left"] = level._id_EC85["atv"]["driver"]["drive_sway_left"];
    self.a._id_2274["event_sway"]["right"] = level._id_EC85["atv"]["driver"]["drive_sway_right"];
    self.a._id_2274["event_restore"] = % atv_turn;
  }
}