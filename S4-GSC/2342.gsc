/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2342.gsc
*************************************************/

_id_770B() {
  level._effect["smoke_trail"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli.vfx");
  level._effect["aerial_explosion"] = loadfx("vfx/core/expl/aerial_explosion.vfx");
  level._effect["aerial_explosion_large"] = loadfx("vfx/core/expl/aerial_explosion_heli_large.vfx");
  level._effect["chopper_sparks"] = loadfx("vfx/iw8_cp/level/cp_stk_faridah/vfx_chopper_sparks.vfx");
  level._effect["blima_rocket_flash"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_rocket_pod_launch.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

_id_76EF(var_0, var_1, var_2, var_3) {
  var_4 = "tag_flash";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  var_7 = self gettagorigin(var_4);

  if(!isDefined(var_1)) {
    var_1 = "sentry_minigun_mp";
  }

  if(isDefined(level._id_76F0)) {
    var_1 = level._id_76F0;
  }

  self._id_9F00 = spawnturret("misc_turret", var_7, var_1);
  self._id_9F00.angles = self gettagangles(var_4);

  if(isDefined(var_0)) {
    self._id_9F00 setModel(var_0);
  } else {
    self._id_9F00 setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self._id_9F00 setmode("manual");
  self._id_9F00 setdefaultdroppitch(0);
  self._id_9F00 _meth_8331(360);
  self._id_9F00 _meth_8372(360);
  self._id_9F00 _meth_8395(5);
  self._id_9F00 _meth_82F0(90);
  self._id_9F00 _meth_8302(0.05, "yaw");
  self._id_9F00 _meth_8302(0.05, "pitch");
  self._id_9F00 linkto(self, var_4, var_5, (0, 0, 0));
  self._id_9F00 _meth_83A0("axis");
  self._id_9F00._id_3643 = self;
  thread scripts\engine\utility::_id_472E(self._id_9F00);
}

_id_76A8() {
  self endon("death");
  playFXOnTag(level._effect["smoke_trail"], self, "tag_origin");
  var_0 = 0;

  for(;;) {
    wait(randomfloatrange(0.2, 3));
    playFX(level._effect["chopper_sparks"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

_id_7751(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("leave_area");

  if(isDefined(var_2)) {
    var_1 = scripts\engine\utility::getStructArray(var_2, "script_noteworthy")[0].origin[2];
  } else if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  }

  var_0._id_3658 = var_1;
  var_0 thread _id_C997();
  level thread _id_5687(var_0);
  var_0._id_9F00 setmode("manual");
  var_0._id_A49E = gettime() + 2000;
  var_3 = 0;
  var_4 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0._id_A406) {
      var_0 notify("evade");
      var_0 waittill("evasive_action_done");
      var_0._id_3736 = 0;
      var_0._id_A406 = 0;
    }

    var_5 = var_0 _id_76C7(undefined, 0);

    if(!isDefined(var_5)) {
      wait 1;
      var_3 = var_3 + 1;

      if(var_3 > var_4) {
        var_0 _id_76CB(undefined, undefined, var_2);
        var_5 = var_0._id_24CE;
        var_3 = 0;
      } else
        continue;
    }

    if(var_0 _id_DAB7(var_0._id_9F00, var_5)) {
      var_0 _id_76F6(var_5);
    }

    if(istrue(var_0._id_A545)) {
      var_0 thread _id_5452(var_5);
    } else {
      var_0 thread _id_5451(var_5, var_1);
    }

    var_0 scripts\engine\utility::_id_108A8(60, "target_engaged", "needs_to_evade");
    var_0._id_A545 = 0;
  }
}

_id_7716(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  var_0._id_750E = 1;
  var_0._id_3658 = var_1;
  var_0 thread _id_C997();

  if(!isDefined(var_0._id_5660)) {
    var_0._id_5660 = 2000;
  }

  var_0._id_C8B9 = 1;
  level thread _id_5687(var_0);

  if(isDefined(var_0._id_9F00)) {
    var_0._id_9F00 setmode("manual");
  }

  var_0._id_A49E = gettime() + 2000;
  var_2 = 0;
  var_3 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0._id_A406) {
      var_0 notify("evade");
      var_0 waittill("evasive_action_done");
      var_0._id_3736 = 0;
      var_0._id_A406 = 0;
    }

    if(istrue(var_0._id_5E6A)) {
      var_0 _id_76CB();
      var_4 = var_0._id_24CE;
      var_2 = 0;
    } else {
      var_4 = var_0 _id_76C7(undefined, 0);

      if(!isDefined(var_4)) {
        wait 1;
        var_2 = var_2 + 1;

        if(var_2 > var_3) {
          var_0 _id_76CB();
          var_4 = var_0._id_24CE;
          var_2 = 0;
        } else
          continue;
      }
    }

    if(var_0 _id_DAB7(var_0, var_4)) {
      var_0 _id_76F6(var_4);
    }

    if(istrue(var_0._id_A545)) {
      var_0 thread _id_5452(var_4);
    } else {
      var_0 thread _id_5451(var_4, var_1);
    }

    var_0 scripts\engine\utility::waittill_any_2("target_engaged", "needs_to_evade");
  }
}

_id_76F6(var_0) {
  self endon("death");
  self _meth_8087();
  self _meth_807D();
  self setlookatent(var_0);
  var_1 = (self._id_7105[0], self._id_7105[1], self._id_3658);

  if(distance2dsquared(self.origin, var_1) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(var_1, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(var_1, 0);
  }

  scripts\engine\utility::_id_108A9(15, "goal", "goal_reached", "near_goal");
}

_id_5451(var_0, var_1) {
  self endon("needs_to_evade");
  self endon("death");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  thread _id_3721(var_0, var_1);
  self setlookatent(var_0);

  if(isDefined(self._id_9F00)) {
    self._id_9F00 _meth_8389(var_0, (0, 0, 40));
  }

  var_2 = undefined;

  while(istrue(self._id_3736)) {
    var_3 = _id_767F(var_0, (0, 0, 60));

    if(!var_3) {
      self _meth_807E();

      if(isDefined(self._id_C8B8)) {
        var_4 = self gettagorigin("tag_rocket_left");
      } else {
        var_4 = self._id_9F00 gettagorigin("tag_flash");
      }

      var_2 = _id_3592(var_4);

      if(!isDefined(var_2)) {
        self notify("stop_circling");
        waitframe();
        self notify("target_engaged");
        return;
      } else {
        var_3 = 1;

        if(isDefined(self._id_9F00)) {
          self._id_9F00 _meth_8389(var_2);
        }

        self setlookatent(var_2);
      }
    }

    if(isDefined(self._id_9F00)) {
      var_5 = scripts\engine\utility::_id_1088B(2, self._id_9F00, "turret_on_target");

      if(var_5 != "turret_on_target") {
        continue;
      }
    }

    if(istrue(self._id_750E)) {
      if(istrue(self._id_C8B9)) {
        if(isDefined(var_2)) {
          _id_7AD5(var_2);
        } else {
          _id_7AD5(var_0);
        }
      }

      continue;
    }

    if(isDefined(var_2)) {
      _id_D9F5(var_2);
    } else {
      _id_D9F5(var_0);
    }

    wait(randomintrange(2, 4));
  }

  self notify("target_engaged");
}

_id_5452(var_0) {
  self endon("death");
  self sethoverparams(150, 35, 35);

  if(!istrue(self._id_750E)) {
    self._id_9F00 _meth_8389(var_0, (0, 0, 40));
    var_1 = scripts\engine\utility::_id_1088B(3, self._id_9F00, "turret_on_target");
  } else
    wait 2;

  if(istrue(self._id_750E)) {
    if(istrue(self._id_C8B9)) {
      _id_7AD5(var_0);
    }
  } else
    _id_D9F5(var_0);

  self notify("target_engaged");
  self sethoverparams(0, 0, 0);
}

_id_3592(var_0) {
  var_1 = 3500;

  if(isDefined(self._id_A452)) {
    var_1 = self._id_A452;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::_id_8708() || distance2dsquared(var_0, var_4.origin) > var_2) {
      continue;
    }
    if(!_id_767F(var_4)) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

_id_D9F5(var_0) {
  var_1 = randomintrange(20, 30);
  self._id_9F00 _meth_83D8();
  wait 2;

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  var_2 = makeweapon("apache_turret_cp");
  var_3 = weaponfiretime(var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    self._id_9F00 _meth_83C1();
    wait(var_3);
  }

  self._id_9F00 _meth_83ED();
  wait 2;
}

_id_DA13(var_0) {
  self endon("death");
  self endon("needs_to_evade");
  thread _id_C8AC(5);
  var_1 = 100;

  for(var_2 = 0; var_2 < 1; var_2++) {
    var_3 = var_0.origin;
    var_4 = self gettagorigin("tag_rocket_right");
    var_5 = self gettagangles("tag_rocket_right");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 = var_3 + var_6;

    if(scripts\engine\utility::_id_10E76(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_right");
      var_9 = anglesToForward(var_5);
      var_9 = var_9 * var_1;
      var_4 = var_4 + var_9;
      var_10 = "iw8_la_rpapa7_heli_cp";
      var_11 = _func_0143(var_10, var_4, var_3);

      if(isDefined(var_11)) {
        var_11.owner = self;
      }
    }

    wait 0.25;
    var_4 = self gettagorigin("tag_rocket_left");
    var_5 = self gettagangles("tag_rocket_left");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 = var_3 + var_6;

    if(scripts\engine\utility::_id_10E76(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_left");
      var_9 = anglesToForward(var_5);
      var_9 = var_9 * var_1;
      var_4 = var_4 + var_9;
      var_10 = "iw8_la_rpapa7_heli_cp";
      var_11 = _func_0143(var_10, var_4, var_3);

      if(isDefined(var_11)) {
        var_11.owner = self;
      }
    }

    wait 0.5;
  }

  wait 2;
}

_id_C8AC(var_0) {
  level endon("game_ended");
  self endon("death");
  self._id_C8B9 = 0;
  wait(var_0);
  self._id_C8B9 = 1;
}

_id_7AD5(var_0) {
  self endon("needs_to_evade");
  self notify("stop_circling");
  self._id_7AD9 = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  _id_DA13(var_0);
  self._id_7AD9 = 0;
}

_id_76C7(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_2 = undefined;
  var_3 = scripts\engine\utility::_id_6369(var_0, level.players, undefined, undefined);

  foreach(var_5 in var_3) {
    if(!var_5 scripts\cp\utility::_id_8708(undefined, 0) || istrue(var_5 _meth_86B7()) || istrue(var_5 isskydiving()) || istrue(var_5 _meth_86B8())) {
      continue;
    }
    var_0 = (var_5.origin[0], var_5.origin[1], self._id_3658);

    if(isDefined(var_5.vehicle)) {
      var_6 = [self, var_5, var_5.vehicle];
    } else {
      var_6 = [self, var_5];
    }

    if(!istrue(self._id_750E)) {
      if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
        var_2 = var_5;
        self._id_7105 = var_0;
      }
    }

    if(!isDefined(var_2)) {
      var_7 = anglestoright(var_5.angles);
      var_8 = anglestoleft(var_5.angles);
      var_9 = anglesToForward(var_5.angles);
      var_10 = var_9 * -1;
      var_11 = [var_7, var_8, var_9, var_10];

      foreach(var_13 in var_11) {
        var_0 = (var_5.origin[0], var_5.origin[1], 0) + (var_13[0], var_13[1], 0) * 1800 + (0, 0, self._id_3658);

        if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
          var_2 = var_5;
          self._id_7105 = var_0;
          self._id_A545 = 1;
          return var_2;
        }
      }
    }

    if(isDefined(var_2)) {
      break;
    }
  }

  return var_2;
}

_id_767F(var_0, var_1) {
  var_2 = 3500;

  if(isDefined(self._id_7680)) {
    var_2 = self._id_7680;
  }

  if(!var_0 scripts\cp\utility::_id_8708() || distance2d(self.origin, var_0.origin) > var_2) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = self._id_9F00 gettagorigin("tag_flash");
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 0, 0, 0, 1, 0, 1);
  var_5 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!scripts\engine\trace::ray_trace_passed(var_3 + var_1, var_5[var_6], self, var_4)) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_76CB(var_0, var_1, var_2) {
  self endon("death");
  self endon("heli_alerted");

  if(isDefined(var_0)) {
    var_3 = var_0;
  } else if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::_id_6969(self.origin, scripts\engine\utility::getStructArray(var_2, "script_noteworthy"));
  } else {
    var_3 = scripts\engine\utility::_id_6969(self.origin, scripts\engine\utility::getStructArray("heli_search", "script_noteworthy"));
  }

  self _meth_807E();
  self _meth_8087();
  self _meth_807D();

  if(isDefined(self._id_9F00)) {
    self._id_9F00 _meth_8086();
  }

  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  self setvehgoalpos(var_3.origin, 0);
  thread _id_7682();
  scripts\engine\utility::_id_108A8(15, "goal", "goal_reached");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  for(;;) {
    self setvehgoalpos(var_4.origin, 0);
    scripts\engine\utility::_id_108A8(15, "goal", "goal_reached");
    var_4 = scripts\engine\utility::getstruct(var_4.target, "targetname");
  }
}

_id_7682() {
  self endon("death");
  self endon("heli_alerted");
  self endon("evade");
  self._id_24CE = undefined;

  for(;;) {
    var_0 = _id_76C7(undefined, 0);

    if(!isDefined(var_0)) {
      wait 1;
      continue;
    } else
      break;
  }

  self vehicle_setspeed(50, 30);
  self._id_24CE = var_0;
  self notify("heli_alerted");
}

_id_5687(var_0) {
  var_0 endon("death");

  if(!isDefined(var_0._id_A406)) {
    var_0._id_A406 = 0;
  }

  while(var_0._id_7632 > 0) {
    var_0 waittill("evade", var_1);
    var_0._id_3736 = 0;
    var_0 thread _id_76AE((var_0.origin[0], var_0.origin[1], var_0._id_3658));
    var_0 waittill("evasive_action_done");
  }
}

_id_DAB7(var_0, var_1) {
  var_2 = 3400;

  if(isDefined(self._id_DAB8)) {
    var_2 = self._id_DAB8;
  }

  if(istrue(self._id_8E9C)) {
    self._id_8E9C = undefined;
    return 1;
  }

  if(distance2d(var_0.origin, var_1.origin) > var_2 || isDefined(self._id_7105) && distance(var_0.origin, self._id_7105) > var_2) {
    return 1;
  }

  return 0;
}

_id_C997() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

_id_3721(var_0, var_1) {
  self endon("evade");
  self endon("death");
  self endon("stop_circling");
  self._id_3736 = 1;
  var_2 = 1500;

  if(isDefined(self._id_3723)) {
    var_2 = self._id_3723;
  }

  var_3 = (var_0.origin[0], var_0.origin[1], var_1);
  var_4 = _id_3F61(var_3, 6, var_2);
  var_5 = 0;
  var_6 = var_4[0];
  var_7 = distance2dsquared(self.origin, var_4[0].origin);

  foreach(var_11, var_9 in var_4) {
    var_10 = distance2dsquared(self.origin, var_9.origin);

    if(var_10 < var_7) {
      var_7 = var_10;
      var_6 = var_9;
      var_5 = var_11;
    }
  }

  self._id_FFE8 = var_4[var_5].origin;
  self setvehgoalpos(var_4[var_5].origin);
  self setneargoalnotifydist(30);
  self vehicle_setspeed(12, 10, 10);
  self._id_FFF1 = (12, 10, 10);
  self._id_30EC = 1;
  var_12 = 0;
  var_11 = var_5 + 1;

  while(var_12 < var_4.size - 1) {
    while(istrue(self._id_7AD9)) {
      wait 0.1;
    }

    if(var_11 >= var_4.size) {
      var_11 = 0;
    }

    if(!isalive(var_0)) {
      break;
    }

    var_13 = var_0.origin + (0, 0, 60);

    if(!_func_0202(var_4[var_11].origin, var_13, 0, undefined)) {
      wait 0.1;
      var_12++;
      var_11++;
      continue;
    }

    self._id_FFE8 = var_4[var_11].origin;
    self setvehgoalpos(var_4[var_11].origin, 1);
    scripts\engine\utility::_id_108F5("near_goal", 60);
    var_12++;
    var_11++;
  }

  self._id_30EC = 0;
  self._id_3736 = 0;
}

_id_3F61(var_0, var_1, var_2) {
  var_3 = 360 / var_1;
  var_4 = [];
  var_5 = (1, 0, 0);

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + var_3) {
    var_7 = var_5 * var_2;
    var_8 = (cos(var_6) * var_7[0] - sin(var_6) * var_7[1], sin(var_6) * var_7[0] + cos(var_6) * var_7[1], var_7[2]);
    var_9 = var_0 + var_8;
    var_10 = spawnStruct();
    var_10.origin = var_9;
    var_4[var_4.size] = var_10;
  }

  return var_4;
}

_id_76AE(var_0) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  var_1 = 5000;

  if(isDefined(self._id_5660)) {
    var_1 = self._id_5660;
  }

  if(_id_75C9(self)) {
    _id_4BE7(self);
    var_0 = (self.origin[0], self.origin[1], self._id_3658);
  }

  var_2 = _id_3F61(var_0, 8, var_1);
  var_3 = 0;
  var_4 = var_2[0];
  self _meth_807D();
  self _meth_8087();
  self _meth_807E();

  foreach(var_7, var_6 in var_2) {
    if(scripts\engine\utility::_id_10E76(self.origin, self.angles, var_6.origin, cos(25))) {
      var_4 = var_6;
      var_3 = var_7;
      break;
    }
  }

  self setvehgoalpos(var_2[var_3].origin, 0);
  var_8 = 1500;
  var_8 = var_8 * (var_1 / 5000);
  var_9 = 100;
  var_9 = var_9 * (var_1 / 5000);
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  var_10 = 0;
  var_7 = var_3 + 1;
  var_11 = randomint(4);

  while(var_10 < var_2.size - 1) {
    if(var_7 >= var_2.size) {
      var_7 = 0;
    }

    self setvehgoalpos(var_2[var_7].origin, 0);
    scripts\engine\utility::_id_108F5("near_goal", 15);
    var_10++;
    var_7++;

    if(var_10 == var_11) {
      break;
    }
  }

  self notify("evasive_action_done");
}

_id_4BE7(var_0) {
  var_1 = undefined;
  var_2 = _id_6489(var_0);

  if(var_2.size > 0) {
    var_1 = scripts\engine\utility::_id_6969(var_0.origin, var_2);
  } else {
    var_1 = scripts\engine\utility::_id_6969(var_0.origin, scripts\engine\utility::getStructArray(var_0._id_5664, "targetname"));
  }

  var_0 setneargoalnotifydist(250);
  var_0 vehicle_setspeed(100, 50, 50);
  var_0 setvehgoalpos(var_1.origin, 0);
  var_0 scripts\engine\utility::_id_108F5("near_goal", 15);
}

_id_75C9(var_0) {
  if(!isDefined(var_0._id_5664)) {
    return 0;
  }

  var_1 = scripts\engine\utility::getStructArray(var_0._id_5664, "targetname");

  if(var_1.size == 0) {
    return 0;
  }

  return 1;
}

_id_6489(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0._id_5664, "targetname");
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in var_2) {
    var_6 = vectornormalize(var_5.origin - var_0.origin);

    if(vectordot(var_6, var_3) > 0) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

_id_D7FC(var_0, var_1, var_2, var_3) {
  var_4 = "tag_pilot";

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  if(!self tagexists(var_4) && self tagexists("tag_pilot1")) {
    var_4 = "tag_pilot1";
  }

  if(!self tagexists(var_4)) {
    return;
  }
  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_6 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  var_7 = spawn("script_model", self gettagorigin(var_4));
  var_7 setModel("aq_pilot_fullbody_1");
  var_7 linkto(self, var_4, var_5, var_6);
  var_7 _meth_82CB("vh_mindia8_pilot_idle");
  self._id_B0CB = var_7;

  if(istrue(var_0)) {
    thread _id_769B();
  }

  return var_7;
}

_id_769B(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  self.health = 1000000;
  self._id_4230 = 1;

  if(!isDefined(var_1)) {
    var_1 = 2500;
  }

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }
    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }
    if(isDefined(var_4) && isDefined(self._id_9F00) && var_4 == self._id_9F00) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4.owner) && var_4.owner scripts\cp\utility::_id_8708()) {
      var_4 = var_4.owner;
    }

    if(_id_86BC(var_4, var_6, var_12)) {
      var_2++;

      if(var_2 == 1) {
        var_4 _id_06FA::_id_6F7B();
        var_4 thread _id_0709::_id_6FB9("kill_ss_chopper_support");
        var_4 _id_074E::_id_6F28(500, "large");
        thread _id_4BFF(var_4);
        return;
      }

      var_4._id_8FF0 = undefined;
      var_4 _id_071B::_id_FC47("hitcritical", 1);
      self._id_A406 = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!_func_010F(var_7)) {
      var_4._id_8FF0 = undefined;
      var_4 _id_071B::_id_FC47("hitarmorheavy");
    } else {
      var_4._id_8FF0 = undefined;
      var_4 _id_071B::_id_FC47("hitcritical");

      if(isDefined(var_12) && isDefined(var_12.basename)) {
        switch (var_12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700)
        var_3 = 700;

      if(isDefined(var_0) && scripts\engine\utility::_id_5C0C(var_0) && !scripts\engine\utility::_id_5C00(var_0)) {
        scripts\engine\utility::_id_5C1B(var_0);
      } else {
        if(!istrue(self._id_A406)) {
          self._id_A406 = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(var_12) && isDefined(var_12.basename)) {
      switch (var_12.basename) {
        case "cruise_proj_mp":
          var_3 = self._id_7632;
          break;
        case "iw8_la_gromeo_mp":
          var_3 = int(var_1 * 0.5);
          break;
      }
    }

    if(self._id_7632 <= var_1 * 0.75) {
      if(isDefined(var_0) && scripts\engine\utility::_id_5C0C(var_0) && !scripts\engine\utility::_id_5C00(var_0)) {
        scripts\engine\utility::_id_5C1B(var_0);
      }
    }

    self._id_7632 = self._id_7632 - var_3;

    if(self._id_7632 <= var_1 * 0.25 && !isDefined(self._id_43E8)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self._id_43E8 = 1;
    } else if(self._id_7632 <= var_1 * 0.5 && !isDefined(self._id_43E9)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self._id_43E9 = 1;
    } else if(self._id_7632 <= var_1 * 0.75 && !isDefined(self._id_43EA)) {
      self setscriptablepartstate("body_damage_light", "on");
      self._id_43EA = 1;
    }

    if(self._id_7632 <= 0) {
      if(isDefined(self._id_75E9)) {
        _func_0354(self._id_75E9);
      }

      level._id_1DC2 = undefined;
      self._id_75E9 = undefined;

      if(isDefined(var_12) && issubstr(var_12.basename, "molotov")) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 thread _id_06FA::_id_6F7D();
        }
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread _id_0709::_id_6FB9("kill_ss_chopper_support");
        var_4 _id_074E::_id_6F28(500, "large");
      }

      level._id_147A = scripts\engine\utility::array_remove(level._id_147A, self);
      var_4 _id_071B::_id_FC47("hitcritical", 1);
      playFX(level._effect["vfx_blima_explosion"], self.origin);

      if(istrue(self._id_A548)) {
        thread _id_9E84(var_4);
      } else {
        thread _id_4BFF(var_4);
      }

      return;
    }
  }
}

_id_4BFF(var_0) {
  if(isDefined(self._id_75E9)) {
    _func_0354(self._id_75E9);
    self._id_75E9 = undefined;
  }

  self._id_3E63 = 150;
  thread _id_3E5C();
  self notify("death", var_0, "MOD_EXPLOSIVE", undefined, self.origin);
}

_id_9E84(var_0) {
  playFX(level._effect["helidown_rpghit"], self.origin);

  if(isDefined(self._id_B0CB)) {
    self._id_B0CB delete();
  }

  self delete();
}

_id_3E5C() {
  self waittill("vehicle_deathComplete", var_0);
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
  self stoploopsound();
  wait 0.15;
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  earthquake(0.45, 3, var_0 + (0, 0, -100), 1024);
  _func_01BA(var_0 + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self._id_B0CB)) {
    self._id_B0CB delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_86BC(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "sniper";

  if(!_id_89BC(self, var_1) || !var_3) {
    return 0;
  }

  return 1;
}

_id_89BC(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20) {
    return 1;
  } else if(distance(var_1, var_5) <= 20) {
    return 1;
  } else if(distance(var_1, var_6) <= 20) {
    return 1;
  } else {
    return 0;
  }
}