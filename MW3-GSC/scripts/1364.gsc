/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1364.gsc
**************************************/

_id_410D() {
  var_0 = getEntArray("mortar", "targetname");
  var_1 = -1;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] _id_4146();

  }
  if(!isDefined(level._id_410E)) {
    common_scripts\utility::error("level.mortar not defined. define in level script");

  }
  level waittill("start_mortars");

  for(;;) {
    wait(1 + randomfloat(2));
    var_3 = randomint(var_0.size);

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_4 = (var_2 + var_3) % var_0.size;
      var_5 = distance(level.player getorigin(), var_0[var_4].origin);
      var_6 = undefined;

      if(isDefined(level._id_410F)) {
        var_6 = distance(level._id_410F.origin, var_0[var_4].origin);
      } else {
        var_6 = 360;

      }
      if(var_5 < 1600 && var_5 > 400 && var_6 > 350 && var_4 != var_1) {
        var_0[var_4] _id_414A(400, 300, 25, undefined, undefined, undefined, 0);
        var_1 = var_4;

        if(var_5 < 500) {
          _id_0553::main(4);

        }
        break;
      }
    }
  }
}

_id_4110(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    var_0 = 7;

  }
  if(!isDefined(var_1)) {
    var_1 = 2200;

  }
  if(!isDefined(var_2)) {
    var_2 = 300;

  }
  if(!isDefined(level._id_4111)) {
    level._id_4111 = 0;

  }
  if(!isDefined(var_9)) {
    var_9 = 0;

  }
  var_11 = getEntArray("mortar", "targetname");
  var_12 = -1;

  for(var_13 = 0; var_13 < var_11.size; var_13++) {
    if(isDefined(var_11[var_13].target) && var_9 == 0) {
      var_11[var_13] _id_4146();
    }
  }

  if(!isDefined(level._id_410E)) {
    common_scripts\utility::error("level.mortar not defined. define in level script");

  }
  if(isDefined(level._id_4112)) {
    level waittill(level._id_4112);

  }
  for(;;) {
    if(level._id_4111 != 0) {
      wait 1;

    }
    while(level._id_4111 == 0) {
      if(isDefined(var_10)) {
        wait(var_10 + (randomfloat(var_0) + randomfloat(var_0)));
      } else {
        wait(randomfloat(var_0) + randomfloat(var_0));

      }
      var_14 = randomint(var_11.size);

      for(var_13 = 0; var_13 < var_11.size; var_13++) {
        var_15 = (var_13 + var_14) % var_11.size;
        var_16 = distance(level.player getorigin(), var_11[var_15].origin);

        if(var_16 < var_1 && var_16 > var_2 && var_15 != var_12) {
          var_11[var_15] _id_414A(var_3, var_4, var_5, var_6, var_7, var_8, 0);
          var_12 = var_15;
          break;
        }
      }
    }
  }
}

_id_4113() {
  var_0 = [];
  var_1 = [];
  level._id_4114 = [];
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_4115)) {
      if(!isDefined(level._id_4114[var_2[var_3]._id_4115])) {
        level._id_4114[var_2[var_3]._id_4115] = [];

      }
      var_4 = spawnStruct();
      var_4.origin = var_2[var_3].origin;
      var_4.angles = var_2[var_3].angles;

      if(isDefined(var_2[var_3].targetname)) {
        var_4.targetname = var_2[var_3].targetname;

      }
      if(isDefined(var_2[var_3].target)) {
        var_4.target = var_2[var_3].target;

      }
      level._id_4114[var_2[var_3]._id_4115][level._id_4114[var_2[var_3]._id_4115].size] = var_4;
      var_2[var_3] delete();
    }
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] hide();
    var_0[var_3]._id_4116 = 0;
  }

  if(!isDefined(level._id_410E)) {
    level._id_410E = loadfx("explosions/artilleryExp_dirt_brown");

  }
  var_5 = common_scripts\utility::array_combine(getEntArray("trigger_multiple", "classname"), getEntArray("trigger_radius", "classname"));

  for(var_3 = 0; var_3 < var_5.size; var_3++) {
    if(isDefined(var_5[var_3]._id_4115)) {
      if(!isDefined(level._id_4114[var_5[var_3]._id_4115])) {
        level._id_4114[var_5[var_3]._id_4115] = [];

      }
      var_1[var_1.size] = var_5[var_3];
    }
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3]._id_4117 = 0;
    var_1[var_3] thread _id_411E();
  }

  var_6 = undefined;

  for(;;) {
    level waittill("mortarzone", var_7);

    if(isDefined(var_6)) {
      var_6 notify("wait again");

    }
    level._id_4118 = var_7._id_4115;
    var_7 thread _id_4119();
    var_6 = var_7;
  }
}

_id_4119() {
  var_0 = [];
  var_1 = gettime();
  var_2 = 0;

  if(isDefined(self._id_411A)) {
    level notify("timed barrage");
    var_1 = gettime() + self._id_411A * 1000;
    var_2 = 1;
  }

  if(isDefined(self.script_radius)) {
    var_3 = self.script_radius;
  } else {
    var_3 = 0;

  }
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    var_4 = 1;
  } else {
    var_4 = 0;

  }
  var_5 = 0;
  var_6 = 2;
  var_7 = 4;
  var_8 = 0;

  while(level._id_4114[self._id_4115].size > 0 && level._id_4118 == self._id_4115 || var_2) {
    if(var_4) {
      wait(randomfloat(self.script_delay_max - self.script_delay_min) + self.script_delay_min);
    } else if(var_8) {
      if(var_5 < var_7) {
        wait(randomfloat(0.5));
        var_5++;
      } else {
        var_5 = 0;
        var_7 = 2 + randomint(4);
        var_8 = 0;
        continue;
      }
    } else if(var_5 < var_6) {
      var_9 = randomfloat(2) + 1;
      wait(var_9);
      var_5++;
    } else {
      var_5 = 0;
      var_8 = 1;
      var_6 = randomint(2) + 3;
      continue;
    }

    var_10 = [];
    var_11 = randomint(level._id_4114[self._id_4115].size);

    if(randomint(100) < 75) {
      var_12 = anglesToForward(level.player.angles);
      var_13 = [];

      for(var_14 = 0; var_14 < level._id_4114[self._id_4115].size; var_14++) {
        if(var_3 > 0 && distance(level.player.origin, level._id_4114[self._id_4115][var_14].origin) > var_3) {
          continue;
        }
        if(_id_411B(level._id_4114[self._id_4115][var_14], var_0)) {
          continue;
        }
        var_15 = vectornormalize(level._id_4114[self._id_4115][var_14].origin - level.player.origin);

        if(vectordot(var_12, var_15) > 0.3) {
          var_13[var_13.size] = var_14;
        }
      }

      if(var_13.size > 0) {
        var_11 = var_13[randomint(var_13.size)];
      }
    }

    if(var_0.size > 3) {
      var_0 = [];

    }
    var_0[var_0.size] = level._id_4114[self._id_4115][var_11];
    level._id_4114[self._id_4115][var_11] thread _id_411C();

    if(var_2 && gettime() > var_1) {
      if(isDefined(self.target)) {
        var_16 = getent(self.target, "targetname");

        if(isDefined(var_16)) {
          var_16 notify("trigger");
          level notify("timed barrage finished");
        }
      }

      break;
    }
  }
}

_id_411B(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

_id_411C() {
  if(isDefined(self.targetname) && isDefined(level._id_411D[self.targetname])) {
    level thread[[level._id_411D[self.targetname]]](self);
  } else {
    thread _id_414A(undefined, undefined, undefined, undefined, undefined, undefined, 1);

  }
  self waittill("mortar");

  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isDefined(var_0)) {
      var_0 notify("trigger");
    }
  }
}

_id_411E() {
  for(;;) {
    self waittill("trigger");

    if(isDefined(level._id_4118) && level._id_4118 == self._id_4115) {
      continue;
    }
    level notify("mortarzone", self);
    self waittill("wait again");
  }
}

_id_411F() {
  level._id_4120 = getEntArray("mortartrigger", "targetname");
  level._id_4114 = getEntArray("script_origin", "classname");

  for(var_0 = 0; var_0 < level._id_4114.size; var_0++) {
    if(isDefined(level._id_4114[var_0]._id_4115)) {
      level._id_4114[var_0] _id_4146();
    }
  }

  level._id_4121 = -1;

  if(!isDefined(level._id_410E)) {
    common_scripts\utility::error("level.mortar not defined. define in level script");

  }
  for(var_0 = 0; var_0 < level._id_4120.size; var_0++) {
    thread _id_4122(var_0);
  }
}

_id_4122(var_0) {
  var_1 = getEntArray(level._id_4120[var_0].target, "targetname");

  for(;;) {
    if(level.player istouching(level._id_4120[var_0])) {
      var_2 = randomint(var_1.size);

      while(var_2 == level._id_4121) {
        var_2 = randomint(var_1.size);
        wait 0.1;
      }

      var_1[var_2] _id_414A(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      level._id_4121 = var_2;
    }

    wait(randomfloat(3) + randomfloat(4));
  }
}

_id_4123() {
  var_0 = [];
  var_1 = undefined;
  var_2 = [];
  var_3 = common_scripts\utility::getstructarray("mortar_bunker", "targetname");
  var_4 = getEntArray("mortar_bunker", "targetname");

  if(isDefined(var_4) && var_4.size > 0) {
    var_1 = maps\_utility::_id_1843(var_3, var_4);
  } else {
    var_1 = var_3;

  }
  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(!isDefined(var_1[var_5]._id_4115)) {
      continue;
    }
    var_6 = -1;
    var_7 = int(var_1[var_5]._id_4115);

    for(var_8 = 0; var_8 < var_0.size; var_8++) {
      if(var_7 != var_2[var_8]) {
        continue;
      }
      var_6 = var_8;
      break;
    }

    if(var_6 == -1) {
      var_0[var_0.size] = [];
      var_2[var_2.size] = var_7;
      var_6 = var_0.size - 1;
    }

    var_0[var_6][var_0[var_6].size] = var_1[var_5];
  }

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    thread _id_4124(var_0[var_5], var_3);

  }
  wait 0.05;
  common_scripts\utility::array_thread(getEntArray("mortar_on", "targetname"), ::_id_4144, "on");
  common_scripts\utility::array_thread(getEntArray("mortar_off", "targetname"), ::_id_4144, "off");
}

_id_4124(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(level._id_4125)) {
    var_2 = level._id_4125;
  } else {
    var_2 = 4;

  }
  if(isDefined(level._id_4126)) {
    var_3 = level._id_4126;
  } else {
    var_3 = 6;

  }
  var_4 = int(var_0[0]._id_4115);

  for(;;) {
    level waittill("start_mortars " + var_4);
    thread _id_4127(var_0, var_2, var_3, var_4, var_1);
  }
}

_id_4127(var_0, var_1, var_2, var_3, var_4) {
  level endon("start_mortars " + var_3);
  level endon("stop_mortars " + var_3);

  for(;;) {
    wait 0.05;
    var_5 = maps\_utility::_id_0AE9(level.player.origin, var_4);

    if(!isDefined(level._id_4128)) {
      common_scripts\utility::play_sound_in_space("mortar_incoming_bunker", var_5.origin);

    }
    var_5 = maps\_utility::_id_0AE9(level.player.origin, var_4);
    thread common_scripts\utility::play_sound_in_space("exp_artillery_underground", var_5.origin);
    common_scripts\utility::array_thread(var_0, ::_id_412A);

    if(!isDefined(level._id_4129)) {
      if(common_scripts\utility::cointoss()) {
        earthquake(0.2, 1.5, var_5.origin, 1250);
      } else {
        earthquake(0.35, 2.75, var_5.origin, 1250);
      }
    }

    level notify("mortar_hit");
    wait(randomfloatrange(var_1, var_2));
    var_0 = common_scripts\utility::array_removeundefined(var_0);
  }
}

_id_412A(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level._id_412B) && _id_4138(level._id_412B) == 0) {
    return;
  }
  if(isDefined(level._id_1DBD)) {
    var_2 = level._id_1DBD;
  } else {
    var_2 = 1024;

  }
  var_3 = var_2 * var_2;
  var_4 = distancesquared(level.player.origin, self.origin);

  if(var_4 > var_3) {
    return;
  }
  if(isDefined(self.classname) && self.classname == "trigger_radius") {
    if(!level.player istouching(self) && distance(level.player.origin, self.origin) < level._id_412C) {
      radiusdamage(self.origin, self.radius, 500, 500);
      self delete();
      return;
    }
  } else {
    playFX(level._effect["mortar"][self.script_fxid], self.origin);

    if(var_4 < 262144) {
      thread common_scripts\utility::play_sound_in_space("emt_single_ceiling_debris", self.origin);
    }
  }
}

_id_412D() {
  var_0 = [];
  var_1 = [];
  var_2 = maps\_utility::_id_1BF9("mortar", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3]._id_4115)) {
      continue;
    }
    var_4 = -1;
    var_5 = int(var_2[var_3]._id_4115);

    for(var_6 = 0; var_6 < var_0.size; var_6++) {
      if(var_5 != var_1[var_6]) {
        continue;
      }
      var_4 = var_6;
      break;
    }

    if(var_4 == -1) {
      var_0[var_0.size] = [];
      var_1[var_1.size] = var_5;
      var_4 = var_0.size - 1;
    }

    var_0[var_4][var_0[var_4].size] = var_2[var_3];
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    thread _id_412E(var_0[var_3]);

  }
  wait 0.05;
  common_scripts\utility::array_thread(getEntArray("mortar_on", "targetname"), ::_id_413E, "on");
  common_scripts\utility::array_thread(getEntArray("mortar_off", "targetname"), ::_id_413E, "off");
}

_id_412E(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(level._id_4125)) {
    var_2 = level._id_4125;
  } else {
    var_2 = 0.5;

  }
  if(isDefined(level._id_4126)) {
    var_3 = level._id_4126;
  } else {
    var_3 = 3;

  }
  var_1 = int(var_0[0]._id_4115);

  for(;;) {
    level waittill("start_mortars " + var_1);
    level thread _id_4130(var_0, var_1, var_2, var_3);

    if(isDefined(level._id_412F)) {
      return;
    }
  }
}

_id_4130(var_0, var_1, var_2, var_3) {
  level endon("start_mortars " + var_1);
  level endon("stop_mortars " + var_1);

  if(isDefined(level._id_1DBD)) {
    var_4 = level._id_1DBD;
  } else {
    var_4 = 300;

  }
  var_5 = spawn("trigger_radius", (0, 0, 0), 0, var_4, 256);
  thread _id_4136(var_5, var_1);

  for(;;) {
    for(;;) {
      wait 0.05;
      var_6 = randomint(var_0.size);

      if(isDefined(var_0[var_6]._id_4131)) {
        continue;
      }
      var_7 = distance(level.player.origin, var_0[var_6].origin);

      if(var_7 < var_4) {
        continue;
      }
      if(isDefined(level._id_4132) && level._id_4132.size > 0) {
        var_5.origin = var_0[var_6].origin;

        if(_id_4137(level._id_4132, var_5)) {
          continue;
        }
      }

      if(!isDefined(level._id_4133) && var_7 > 1000) {
        continue;
      }
      if(isDefined(level._id_4134) && var_7 > level._id_4134) {
        continue;
      }
      if(isDefined(level._id_412B) && var_0[var_6] _id_4138(level._id_412B) == 0) {
        continue;
      }
      break;
    }

    if(isDefined(level._id_4135) && level._id_4135 == 1) {
      return;
    }
    var_0[var_6] thread _id_413A();
    wait(var_2 + randomfloat(var_3 - var_2));
  }
}

_id_4136(var_0, var_1) {
  level waittill("stop_mortars " + var_1);
  var_0 delete();
}

_id_4137(var_0, var_1) {
  foreach(var_3 in level._id_4132) {
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_4138(var_0) {
  var_1 = level.player getEye();
  var_2 = (0, 0, 0);

  if(isDefined(level._id_4139)) {
    var_2 = level._id_4139;

  }
  var_3 = maps\_utility::within_fov(var_1, level.player getplayerangles() + var_2, self.origin, var_0);
  return var_3;
}

_id_413A(var_0, var_1) {
  if(!isDefined(level._id_413B)) {
    level._id_413B = 250;

  }
  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  thread _id_413D();

  if(!var_0) {
    common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"]["incomming"]);

  }
  if(isDefined(var_1)) {
    thread common_scripts\utility::play_sound_in_space(var_1);
  } else {
    thread common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"][self.script_fxid]);

  }
  setplayerignoreradiusdamage(1);
  radiusdamage(self.origin, level._id_413B, 150, 50);
  setplayerignoreradiusdamage(0);
  playFX(level._effect["mortar"][self.script_fxid], self.origin);

  if(isDefined(level._id_413C)) {
    earthquake(0.3, 1, level.player.origin, 2000);

  }
  if(getdvarint("bog_camerashake") > 0) {
    if(level.player getcurrentweapon() == "dragunov" && level.player playerads() > 0.8) {
      return;
    }
    earthquake(0.25, 0.75, self.origin, 1250);
  }
}

_id_413D() {
  self._id_4131 = 1;
  wait(3 + randomfloat(2));
  self._id_4131 = undefined;
}

_id_413E(var_0) {
  self waittill("trigger");

  if(var_0 == "on") {
    _id_413F(self._id_4115);
  } else if(var_0 == "off") {
    _id_4140(self._id_4115);
  }
}

_id_413F(var_0) {
  level notify("start_mortars " + var_0);
}

_id_4140(var_0) {
  level notify("stop_mortars " + var_0);
}

_id_4141(var_0) {
  if(!isDefined(level._id_412C)) {
    level._id_412C = 512;

  }
  if(!isDefined(level._id_412B)) {
    level._id_412B = cos(35);

  }
  level notify("start_mortars " + var_0);
}

_id_4142(var_0) {
  level waittill("mortar_hit");
  level notify("stop_mortars " + var_0);
}

_id_4143(var_0) {
  level notify("stop_mortars " + var_0);
}

_id_4144(var_0) {
  self waittill("trigger");

  if(var_0 == "on") {
    _id_4141(self._id_4115);
  } else if(var_0 == "off") {
    _id_4142(self._id_4115);
  }
}

_id_4145() {
  level endon("stop falling mortars");
  _id_4146();
  wait(randomfloat(0.5) + randomfloat(0.5));

  for(;;) {
    if(distance(level.player getorigin(), self.origin) < 600) {
      _id_414A(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      break;
    }

    wait 1;
  }

  wait(7 + randomfloat(20));

  for(;;) {
    if(distance(level.player getorigin(), self.origin) < 1200 && distance(level.player getorigin(), self.origin) > 400) {
      _id_414A(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      wait(3 + randomfloat(14));
    }

    wait 1;
  }
}

_id_4146() {
  self._id_4116 = 0;

  if(isDefined(self.target)) {
    self._id_4147 = getEntArray(self.target, "targetname");
    self._id_4116 = 1;
  } else {}

  if(!isDefined(self._id_4147)) {}

  if(isDefined(self._id_4148)) {
    if(isDefined(self._id_4148)) {
      self._id_4149 = getent(self._id_4148, "targetname");
    } else if(isDefined(self._id_4147) && isDefined(self._id_4147[0].target)) {
      self._id_4149 = getent(self._id_4147[0].target, "targetname");

    }
    if(isDefined(self._id_4149)) {
      self._id_4149 hide();
    }
  } else if(isDefined(self._id_4116)) {
    if(isDefined(self._id_4147) && isDefined(self._id_4147[0].target)) {
      self._id_4149 = getent(self._id_4147[0].target, "targetname");

    }
    if(isDefined(self._id_4149)) {
      self._id_4149 hide();
    }
  }
}

_id_414A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_414F(undefined, var_6);
  level notify("mortar");
  self notify("mortar");

  if(!isDefined(var_0)) {
    var_0 = 256;

  }
  if(!isDefined(var_1)) {
    var_1 = 400;

  }
  if(!isDefined(var_2)) {
    var_2 = 25;

  }
  radiusdamage(self.origin, var_0, var_1, var_2);

  if(isDefined(self._id_4116) && self._id_4116 == 1 && isDefined(self._id_4147)) {
    for(var_7 = 0; var_7 < self._id_4147.size; var_7++) {
      if(isDefined(self._id_4147[var_7])) {
        self._id_4147[var_7] delete();
      }
    }
  }

  if(isDefined(self._id_4149)) {
    self._id_4149 show();

  }
  self._id_4116 = 0;
  _id_414B(self.origin, var_3, var_4, var_5, undefined, var_6);
}

_id_414B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = 0.15;

  }
  if(!isDefined(var_2)) {
    var_2 = 2;

  }
  if(!isDefined(var_3)) {
    var_3 = 850;

  }
  thread _id_414D(var_5);

  if(isDefined(var_4)) {
    playFX(var_4, var_0);
  } else {
    playFX(level._id_410E, var_0);

  }
  earthquake(var_1, var_2, var_0, var_3);

  if(level.script != "burnville") {
    return;
  }
  if(isDefined(level._id_414C)) {
    return;
  }
  if(distance(level.player.origin, var_0) > 300) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }
  level._id_414C = 1;
  level notify("shell shock player", var_2 * 4);
  _id_0553::main(var_2 * 4);
}

_id_414D(var_0) {
  if(!isDefined(level._id_414E)) {
    level._id_414E = -1;

  }
  for(var_1 = randomint(3) + 1; var_1 == level._id_414E; var_1 = randomint(3) + 1) {}

  level._id_414E = var_1;

  if(!var_0) {
    self playSound("mortar_explosion" + var_1);
  } else {
    common_scripts\utility::play_sound_in_space("mortar_explosion" + var_1, self.origin);
  }
}

_id_414F(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(level._id_4150)) {
    level._id_4150 = var_2;
  } else if(var_2 - level._id_4150 < 1000) {
    wait 1;
    return;
  } else {
    level._id_4150 = var_2;

  }
  if(!isDefined(var_0)) {
    var_0 = randomint(3) + 1;

  }
  if(var_0 == 1) {
    if(var_1) {
      thread common_scripts\utility::play_sound_in_space("mortar_incoming1", self.origin);
    } else {
      self playSound("mortar_incoming1");

    }
    wait 0.82;
  } else if(var_0 == 2) {
    if(var_1) {
      thread common_scripts\utility::play_sound_in_space("mortar_incoming2", self.origin);
    } else {
      self playSound("mortar_incoming2");

    }
    wait 0.42;
  } else {
    if(var_1) {
      thread common_scripts\utility::play_sound_in_space("mortar_incoming3", self.origin);
    } else {
      self playSound("mortar_incoming3");

    }
    wait 1.3;
  }
}

_id_4151() {
  level._id_4152 = [];
  level._id_4153 = [];
  level._id_4154 = [];
  level._id_4155 = [];
  level._id_4156 = [];
  level._id_4157 = [];
  level._id_4158 = [];
  level._id_4159 = [];
}

_id_415A(var_0, var_1, var_2) {
  level._id_4153[var_0] = var_1;
  level._id_4152[var_0] = var_2;
}

_id_415B(var_0, var_1, var_2, var_3) {
  level._id_4154[var_0] = var_1;
  level._id_4156[var_0] = var_2;
  level._id_4155[var_0] = var_3;
}

_id_415C(var_0, var_1, var_2, var_3) {
  level._id_4157[var_0] = var_1;
  level._id_4158[var_0] = var_2;
  level._id_4159[var_0] = var_3;
}

_id_415D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = -1;
  var_8 = var_5;
  var_9 = var_4;
  _id_415A(var_0, 300, 2200);

  if(!isDefined(var_1)) {
    var_1 = 7;

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  if(!isDefined(var_3)) {
    var_3 = 0;

  }
  if(!isDefined(var_6)) {
    var_6 = 0;

  }
  if(isDefined(level._id_415E) && isDefined(level._id_415E[var_0])) {
    level endon(level._id_415E[var_0]);

  }
  if(!isDefined(level._id_415F) || !isDefined(level._id_415F[var_0])) {
    level._id_415F[var_0] = 0;

  }
  var_10 = getEntArray(var_0, "targetname");

  for(var_11 = 0; var_11 < var_10.size; var_11++) {
    if(isDefined(var_10[var_11].target) && !var_6) {
      var_10[var_11] _id_4146();
    }
  }

  if(isDefined(level._id_4160) && isDefined(level._id_4160[var_0])) {
    level waittill(level._id_4160[var_0]);

  }
  for(;;) {
    while(!level._id_415F[var_0]) {
      for(var_12 = 0; var_12 < var_2; var_12++) {
        if(!isDefined(var_5)) {
          var_8 = level._id_4152[var_0];

        }
        if(!isDefined(var_4)) {
          var_9 = level._id_4153[var_0];

        }
        var_13 = randomint(var_10.size);

        for(var_11 = 0; var_11 < var_10.size; var_11++) {
          var_14 = (var_11 + var_13) % var_10.size;
          var_15 = distance(level.player getorigin(), var_10[var_14].origin);

          if(var_15 < var_8 && var_15 > var_9 && var_14 != var_7) {
            var_10[var_14]._id_4161 = var_9;
            var_10[var_14] _id_4164(var_0);
            var_7 = var_14;
            break;
          }
        }

        var_7 = -1;

        if(isDefined(level._id_4162) && isDefined(level._id_4162[var_0])) {
          wait(level._id_4162[var_0]);
          continue;
        }

        wait(randomfloat(var_1) + randomfloat(var_1));
      }

      if(isDefined(level._id_4163) && isDefined(level._id_4163[var_0])) {
        wait(level._id_4163[var_0]);
        continue;
      }

      wait(randomfloat(var_3) + randomfloat(var_3));
    }

    wait 0.05;
  }
}

_id_4164(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_415B(var_0, 256, 25, 400);
  _id_415C(var_0, 0.15, 2, 850);

  if(!isDefined(var_1)) {
    var_1 = level._id_4154[var_0];

  }
  if(!isDefined(var_2)) {
    var_2 = level._id_4156[var_0];

  }
  if(!isDefined(var_3)) {
    var_3 = level._id_4155[var_0];

  }
  if(!isDefined(var_4)) {
    var_4 = level._id_4157[var_0];

  }
  if(!isDefined(var_5)) {
    var_5 = level._id_4158[var_0];

  }
  if(!isDefined(var_6)) {
    var_6 = level._id_4159[var_0];

  }
  _id_4169(var_0);
  level notify("explosion", var_0);
  var_7 = 1;
  var_8 = undefined;
  var_9 = self;

  if(isDefined(self._id_4161) && distance(level.player.origin, self.origin) < self._id_4161) {
    var_10 = getEntArray(var_0, "targetname");

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = distance(level.player getorigin(), var_10[var_11].origin);

      if(var_12 > self._id_4161) {
        if(!isDefined(var_8) || var_12 < var_8) {
          var_8 = var_12;
          var_9 = var_10[var_11];
        }
      }
    }

    if(!isDefined(var_8)) {
      var_7 = 0;
    }
  }

  if(var_7) {
    radiusdamage(var_9.origin, var_1, var_3, var_2);

  }
  if(isDefined(var_9._id_4116) && var_9._id_4116 == 1 && isDefined(var_9._id_4147)) {
    for(var_13 = 0; var_13 < var_9._id_4147.size; var_13++) {
      if(isDefined(var_9._id_4147[var_13])) {
        var_9._id_4147[var_13] delete();
      }
    }
  }

  if(isDefined(var_9._id_4149)) {
    var_9._id_4149 show();

  }
  var_9._id_4116 = 0;
  var_9 _id_4165(var_0, var_4, var_5, var_6);
}

_id_4165(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.15;

  }
  if(!isDefined(var_2)) {
    var_2 = 2;

  }
  if(!isDefined(var_3)) {
    var_3 = 850;

  }
  _id_4166(var_0);
  var_4 = self.origin;
  playFX(level._effect[var_0], var_4);
  earthquake(var_1, var_2, var_4, var_3);

  if(distance(level.player.origin, var_4) > 300) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }
  level._id_414C = 1;
  level notify("shell shock player", var_2 * 4);
  _id_0553::main(var_2 * 4);
}

_id_4166(var_0) {
  if(!isDefined(level._id_4167)) {
    level._id_4167 = 0;

  }
  for(var_1 = randomint(3) + 1; var_1 == level._id_4167; var_1 = randomint(3) + 1) {}

  level._id_4167 = var_1;

  if(level._id_4168[var_0] == "mortar") {
    switch (var_1) {
      case 1:
        self playSound("mortar_explosion1");
        break;
      case 2:
        self playSound("mortar_explosion2");
        break;
      case 3:
        self playSound("mortar_explosion3");
        break;
    }
  } else if(level._id_4168[var_0] == "artillery") {
    switch (var_1) {
      case 1:
        self playSound("mortar_explosion4");
        break;
      case 2:
        self playSound("mortar_explosion5");
        break;
      case 3:
        self playSound("mortar_explosion1");
        break;
    }
  } else if(level._id_4168[var_0] == "bomb") {
    switch (var_1) {
      case 1:
        self playSound("mortar_explosion1");
        break;
      case 2:
        self playSound("mortar_explosion4");
        break;
      case 3:
        self playSound("mortar_explosion5");
        break;
    }
  }
}

_id_4169(var_0, var_1) {
  if(!isDefined(level._id_416A)) {
    level._id_416A = -1;

  }
  for(var_1 = randomint(4) + 1; var_1 == level._id_416A; var_1 = randomint(4) + 1) {}

  level._id_416A = var_1;

  if(level._id_4168[var_0] == "mortar") {
    switch (var_1) {
      case 1:
        self playSound("mortar_incoming1");
        wait 0.82;
        break;
      case 2:
        self playSound("mortar_incoming2");
        wait 0.42;
        break;
      case 3:
        self playSound("mortar_incoming3");
        wait 1.3;
        break;
      default:
        wait 1.75;
        break;
    }
  } else if(level._id_4168[var_0] == "artillery") {
    switch (var_1) {
      case 1:
        self playSound("mortar_incoming4");
        wait 0.82;
        break;
      case 2:
        self playSound("mortar_incoming4_new");
        wait 0.42;
        break;
      case 3:
        self playSound("mortar_incoming1_new");
        wait 1.3;
        break;
      default:
        wait 1.75;
        break;
    }
  } else if(level._id_4168[var_0] == "bomb") {
    switch (var_1) {
      case 1:
        self playSound("mortar_incoming2_new");
        wait 1.75;
        break;
      case 2:
        self playSound("mortar_incoming3_new");
        wait 1.75;
        break;
      case 3:
        self playSound("mortar_incoming4_new");
        wait 1.75;
        break;
      default:
        wait 1.75;
        break;
    }
  }
}