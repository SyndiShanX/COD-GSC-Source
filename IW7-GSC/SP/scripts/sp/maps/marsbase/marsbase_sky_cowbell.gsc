/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_sky_cowbell.gsc
*************************************************************/

_id_1DF2() {
  var_0 = ["veh_mil_air_un_jackal_d1_s2_p3", "veh_mil_air_un_jackal_d1_s2_p1", "veh_mil_air_un_jackal_d2_s2_p5", "veh_mil_air_un_jackal_d2_s2_p6"];

  foreach(var_2 in var_0) {
    precachemodel(var_2);
  }
}

_id_1DF1() {}

_id_1DC7(var_0, var_1, var_2, var_3) {
  level waittill("poop");

  if(!isDefined(var_0)) {
    var_0 = "ambient_crash_start";
  }

  if(!isDefined(var_1)) {
    var_1 = "stop_ambient_jackals";
  }

  if(!isDefined(var_2)) {
    var_2 = "friendly";
  }

  if(!isDefined(var_3)) {
    var_3 = 4;
  }

  level notify(var_1);
  level endon(var_1);
  wait 0.25;

  switch (var_2) {
    case "friendly":
      _id_A1DE(var_0, var_3);
      break;
    case "enemy":
      _id_A1A0(var_0, var_3);
      break;
    case "friendly_chase_enemy":
      _id_A1DF(var_0, var_3);
      break;
    case "enemy_chase_friendly":
      _id_A1A2(var_0, var_3);
      break;
    default:
      _id_A1DE(var_0, var_3);
      break;
  }
}

_id_A1DF(var_0, var_1) {
  var_2 = [];

  for(;;) {
    var_3 = getcsplineidarray(var_0);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      var_6 = _id_10747("ambient_crashing_jackal");
      wait 0.25;
      var_7 = _id_10747("ambient_crashing_jackal_enemy");

      if(isDefined(var_6) && isDefined(var_7)) {
        var_6 _id_0BDC::_id_19A0(1);
        var_7 _id_0BDC::_id_19A0(1);
        var_6 _meth_8555(0);
        var_7 _meth_8555(0);
        var_8 = getcsplinepointposition(var_5, 0);
        var_7 vehicle_teleport(var_8, var_7.angles);
        var_7._id_1319D = var_6;
        var_9 = _id_F429(250, 500);
        var_7 thread _id_0BDC::_id_A1EF(var_5, var_9, 30);
        var_7 thread _id_A1B9(randomintrange(4, 12));
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        wait(randomfloatrange(0.25, 1));

        if(isDefined(var_6)) {
          var_6 vehicle_teleport(var_8, var_6.angles);
          var_6 thread _id_0BDC::_id_A1EF(var_5, var_9 - 25, 30);
          var_6 thread _id_A1B9(randomintrange(10, 12));

          if(scripts\engine\utility::cointoss()) {
            if(isDefined(var_7) && isDefined(var_6)) {
              var_6 thread _id_A1BF(randomintrange(2, 4), var_7);
            }
          }

          var_2 = scripts\engine\utility::array_add(var_2, var_6);
        }

        wait(randomfloatrange(0.5, 1));
        continue;
      }

      if(isDefined(var_6)) {
        var_6 delete();
      }

      if(isDefined(var_7)) {
        var_7 delete();
      }
    }

    wait(var_1);
  }
}

_id_A1A2(var_0, var_1) {
  var_2 = [];

  for(;;) {
    var_3 = getcsplineidarray(var_0);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      var_6 = _id_10747("ambient_crashing_jackal");
      wait 0.25;
      var_7 = _id_10747("ambient_crashing_jackal_enemy");

      if(isDefined(var_6) && isDefined(var_7)) {
        var_6 _id_0BDC::_id_19A0(1);
        var_7 _id_0BDC::_id_19A0(1);
        var_6 _meth_8555(0);
        var_7 _meth_8555(0);
        var_8 = getcsplinepointposition(var_5, 0);
        var_6 vehicle_teleport(var_8, var_6.angles);
        var_6._id_1319D = var_7;
        var_9 = _id_F429(300, 500);
        var_6 thread _id_0BDC::_id_A1EF(var_5, var_9, 30);
        var_6 thread _id_A1B9(randomintrange(4, 8));
        var_2 = scripts\engine\utility::array_add(var_2, var_6);
        wait(randomfloatrange(0.25, 1));

        if(isDefined(var_7)) {
          var_7 vehicle_teleport(var_8, var_7.angles);
          var_7 thread _id_0BDC::_id_A1EF(var_5, var_9 - 25, 30);
          var_7 thread _id_A1B9(randomintrange(10, 12));

          if(scripts\engine\utility::cointoss()) {
            if(isDefined(var_7) && isDefined(var_6)) {
              var_7 thread _id_A1BF(randomintrange(2, 4), var_6);
            }
          }

          var_2 = scripts\engine\utility::array_add(var_2, var_7);
        }

        wait(randomfloatrange(0.5, 1));
        continue;
      }

      if(isDefined(var_6)) {
        var_6 delete();
      }

      if(isDefined(var_7)) {
        var_7 delete();
      }
    }

    wait(var_1);
  }
}

_id_A1DE(var_0, var_1) {
  var_2 = [];

  for(;;) {
    var_3 = getcsplineidarray(var_0);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      var_6 = _id_10747("ambient_crashing_jackal");

      if(isDefined(var_6)) {
        var_6 _id_0BDC::_id_19A0(1);
        var_6 _meth_8555(0);
        var_7 = getcsplinepointposition(var_5, 0);
        var_6 vehicle_teleport(var_7, var_6.angles);
        var_8 = _id_F429(250, 500);
        var_6 thread _id_0BDC::_id_A1EF(var_5, var_8, 30);
        var_6 thread _id_A1B9(randomintrange(4, 12));
        var_2 = scripts\engine\utility::array_add(var_2, var_6);
        wait(randomfloatrange(0.5, 1));
      }
    }

    wait(var_1);
  }
}

_id_A1A0(var_0, var_1) {
  var_2 = [];

  for(;;) {
    var_3 = getcsplineidarray(var_0);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      var_6 = _id_10747("ambient_crashing_jackal_enemy");

      if(isDefined(var_6)) {
        var_6 _id_0BDC::_id_19A0(1);
        var_6 _meth_8555(0);
        var_7 = getcsplinepointposition(var_5, 0);
        var_6 vehicle_teleport(var_7, var_6.angles);
        var_8 = _id_F429(250, 500);
        var_6 thread _id_0BDC::_id_A1EF(var_5, var_8, 30);
        var_6 thread _id_A1B9(randomintrange(4, 12));
        var_2 = scripts\engine\utility::array_add(var_2, var_6);
        wait(randomfloatrange(0.5, 1));
      }
    }

    wait(var_1);
  }
}

_id_10207(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_8 = getcsplineidarray(var_0);
  var_8 = scripts\engine\utility::array_randomize(var_8);

  foreach(var_10 in var_8) {
    if(var_2 == "allies") {
      var_11 = _id_10747("ambient_crashing_jackal", var_6);
    } else {
      var_11 = _id_10747("ambient_crashing_jackal_enemy", var_6);
    }

    if(isDefined(var_11)) {
      var_11 _id_0BDC::_id_19A0(1);
      var_11 _meth_8555(0);
      var_12 = getcsplinepointposition(var_10, 0);
      var_11 vehicle_teleport(var_12, var_11.angles);
      var_11 notify("notify_stop_thrust_audio");

      if(isDefined(var_3)) {
        var_13 = var_3;
        var_11._id_2715 = 1;
      } else
        var_13 = _id_F429(250, 500);

      var_11 thread _id_0BDC::_id_A1EF(var_10, var_13, 10);

      if(scripts\engine\utility::is_true(var_4)) {
        if(!isDefined(var_5)) {
          var_5 = randomintrange(4, 12);
        }

        var_11 thread _id_A1B9(var_5);
      } else
        var_11 thread _id_A1B9(20);

      var_7 = scripts\engine\utility::array_add(var_7, var_11);

      if(var_8.size > 1 && isDefined(var_1)) {
        wait(var_1);
      }
    }
  }

  return var_7;
}

_id_10747(var_0, var_1) {
  if(!isDefined(level._id_14A3)) {
    level._id_14A3 = [];
  }

  var_2 = undefined;
  level._id_14A3 = scripts\sp\utility::_id_DFEB(level._id_14A3);
  var_3 = _id_135D7(var_0);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(level._id_14A3.size < 15 || scripts\engine\utility::is_true(var_1)) {
    var_2 = scripts\sp\vehicle::_id_1080C(var_0);
  } else {
    var_4 = undefined;
    level._id_14A3 = scripts\sp\utility::_id_DFEB(level._id_14A3);

    foreach(var_2 in level._id_14A3) {
      if(!level.player scripts\sp\utility::_id_3849(var_2.origin, 0)) {
        var_4 = var_2;
        break;
      }
    }

    if(!isDefined(var_4)) {
      var_4 = scripts\engine\utility::random(level._id_14A3);
    }

    var_4 _id_A233();
    _id_135D7(var_0);
    var_2 = scripts\sp\vehicle::_id_1080C(var_0);
  }

  if(isDefined(var_2)) {
    level._id_14A3 = scripts\engine\utility::array_add(level._id_14A3, var_2);
    var_2 setneargoalnotifydist(30);
    var_2.ignoreme = 1;
  }

  return var_2;
}

_id_F429(var_0, var_1) {
  var_2 = randomintrange(var_0, var_1);
  return var_2;
}

_id_135D7(var_0) {
  var_1 = getEnt(var_0, "targetname");

  while(isDefined(var_1) && isDefined(var_1._id_1323B)) {
    scripts\engine\utility::waitframe();
  }

  return var_1;
}

_id_A1B9(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("scripted_explode", var_0);

  if(isDefined(var_1) && var_1 == "timeout") {
    thread _id_A12F();
  } else {
    thread _id_A233();
  }
}

_id_A1BF(var_0, var_1, var_2) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");

  if(isDefined(var_2)) {
    wait(var_2);
  } else {
    wait(randomfloatrange(1, 3));
  }

  if(!isDefined(var_1)) {
    self._id_B835 = scripts\engine\utility::spawn_tag_origin();
    self._id_B835._id_5F27 = 1;
    self._id_B835.origin = self gettagorigin("tag_origin") + anglesToForward(self gettagangles("tag_origin")) * 50000;
  } else
    self._id_B835 = var_1;

  thread _id_0B76::_id_1945(self._id_B835, ["tag_flash_right", "tag_flash_left"], var_0);
}

_id_A136() {
  var_0 = getEnt("crash_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  level endon("stop_ambient_jackals");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(scripts\engine\utility::cointoss() && isDefined(var_1.asmname) && var_1.asmname == "jackal" && !scripts\engine\utility::is_true(var_1._id_2714)) {
      wait(randomfloatrange(1, 3));

      if(isDefined(var_1)) {
        var_1 thread _id_A12F();
      }
    }
  }
}

_id_A12F() {
  if(isDefined(self) && isDefined(self._id_EF4C)) {
    return;
  }
  self._id_EF4C = 1;
  self dodamage(20000, self.origin);
  thread _id_0BDC::_id_1991();
  playFXOnTag(scripts\engine\utility::getfx("dropship_interior_explosion"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pcr_lingering_smoke_rise"), self, "tag_origin");
  wait(randomintrange(0, 3));
  _id_A233();
  level notify("next_ambient_jackal");
}

_id_A233() {
  if(isDefined(self) && isDefined(self.angles)) {
    var_0 = spawn("script_origin", self.origin);
    var_0 linkTo(self);

    if(isDefined(self._id_110CD)) {
      playFX(scripts\engine\utility::getfx(self._id_110CD), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    } else {
      playFX(scripts\engine\utility::getfx("vfx_jackal_explode"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    scripts\engine\utility::waitframe();
    var_0 playSound("jackal_mars_explode", "explodone");

    if(isDefined(self)) {
      self delete();
    }

    var_0 waittill("explodone");
    var_0 delete();
  }
}

_id_10273() {
  level endon("stop_sky_debris");
  level._id_BE27 = 0.5;
  level._id_4E8F = ["veh_mil_air_un_jackal_d1_s2_p3", "veh_mil_air_un_jackal_d1_s2_p1", "veh_mil_air_un_jackal_d2_s2_p5", "veh_mil_air_un_jackal_d2_s2_p6"];
  level._id_4E9C = scripts\engine\utility::getStructArray("sky_debris_small", "targetname");
  level._id_4E9C = scripts\engine\utility::array_randomize(level._id_4E9C);

  for(;;) {
    var_0 = randomint(3);

    if(var_0 == 0) {
      thread _id_10279();
    } else {
      thread _id_1027A();
    }

    wait(level._id_BE27);
  }
}

_id_10276() {
  level endon("stop_sky_debris");
  var_0 = undefined;

  for(;;) {
    var_1 = scripts\engine\utility::random(level._id_4E9C);
    var_2 = var_1.origin - level.player.origin;
    var_2 = scripts\engine\utility::flatten_vector(var_2);
    var_2 = vectorNormalize(var_2);
    var_3 = vectordot(var_2, anglestoright(level.player.angles));

    if(var_3 >= -0.6 && var_3 <= 0.6) {
      return var_1;
    }

    wait 0.1;
  }
}

_id_1027A() {
  level endon("stop_sky_debris");
  var_0 = _id_10276();
  var_1 = var_0.origin;
  var_2 = _id_10272(var_1);
  thread _id_10275(var_1, var_2, scripts\engine\utility::random(level._id_4E8F), var_0.script_noteworthy);
}

_id_10279() {
  level endon("stop_sky_debris");
  var_0 = _id_10276();
  var_1 = var_0.origin;
  var_2 = _id_10272(var_1);
  thread _id_10275(var_1, var_2, scripts\engine\utility::random(level._id_4E8F), var_0.script_noteworthy);
  var_3 = randomintrange(2, 5);

  for(var_4 = 1; var_4 <= var_3; var_4++) {
    wait(randomfloatrange(0.3, 0.75));
    var_5 = _id_10277();
    var_6 = _id_10277();
    var_7 = randomintrange(250, 513) * var_5 + var_1[0];
    var_8 = randomintrange(250, 513) * var_6 + var_1[1];
    var_9 = randomintrange(2500, 2501) * var_5 + var_2[0];
    var_10 = randomintrange(2500, 2501) * var_6 + var_2[1];
    var_11 = (var_7, var_8, var_1[2]);
    var_12 = (var_9, var_10, var_2[2]);
    thread _id_10275(var_11, var_12, scripts\engine\utility::random(level._id_4E8F));
  }
}

_id_10277() {
  if(scripts\engine\utility::cointoss()) {
    return 1;
  } else {
    return -1;
  }
}

_id_10275(var_0, var_1, var_2, var_3) {
  level endon("stop_sky_debris");
  var_4 = spawn("script_model", var_0);
  var_5 = _id_3FFC(var_1);
  thread _id_10278(var_4);
  var_4 setModel(var_2);
  var_4 moveTo(var_5, randomintrange(4, 9));
  playFXOnTag(scripts\engine\utility::getfx("debris_geotrail"), var_4, "tag_origin");
  var_4 scripts\sp\utility::_id_135F1("movedone", 10);
  stopFXOnTag(scripts\engine\utility::getfx("debris_geotrail"), var_4, "tag_origin");
  var_6 = ["vfx_jackal_death_ground", "vfx_ra_finale_expl_sideblast"];

  if(!isDefined(var_3)) {
    var_7 = randomint(4);

    if(var_7 > 0 || var_5[2] >= 0) {
      var_8 = scripts\engine\utility::getfx("vfx_ra_finale_expl_sideblast");
    } else {
      var_8 = scripts\engine\utility::getfx(scripts\engine\utility::random(var_6));
    }

    playFX(var_8, var_5);
    var_4 playSound("mars_explode_dist_debris");
  }

  wait 0.05;
  var_4 delete();
}

_id_10272(var_0) {
  var_1 = (0, 0, 0);
  var_2 = randomintrange(9000, 20000);
  var_3 = var_0[0] + var_2;
  var_2 = randomintrange(9000, 20000);
  var_4 = var_0[1] + var_2;
  var_1 = (var_3, var_4, var_0[2] - randomintrange(100, 1000));
  return var_1;
}

_id_10278(var_0) {
  level endon("stop_sky_debris");
  var_0 endon("delete");
  var_1 = randomint(2);

  if(var_1 == 0) {
    var_2 = randomint(361);
  } else {
    var_2 = -1 * randomint(361);
  }

  if(var_1 == 0) {
    var_3 = randomint(91);
  } else {
    var_3 = -1 * randomint(91);
  }

  if(var_1 == 0) {
    var_4 = randomint(46);
  } else {
    var_4 = -1 * randomint(46);
  }

  var_5 = randomfloatrange(0.5, 1.25);

  for(;;) {
    var_0 rotateby((var_2, var_3, var_4), var_5, 0, 0);
    var_0 waittill("rotatedone");
  }
}

_id_3FFC(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];

  if(var_1 > 80000) {
    var_1 = 80000;
  }

  if(var_1 < -80000) {
    var_1 = -80000;
  }

  if(var_2 > 25000) {
    var_2 = 25000;
  }

  if(var_2 < -115000) {
    var_2 = -115000;
  }

  if(var_3 < -20000) {
    var_3 = -20000;
  }

  if(var_3 > 20000) {
    var_3 = 20000;
  }

  var_0 = (var_1, var_2, var_3);
  return var_0;
}