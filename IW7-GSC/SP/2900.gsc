/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2900.gsc
**************************************/

main() {}

_id_91F3() {
  var_0 = getEntArray("mortar", "targetname");
  var_1 = -1;

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] _id_F9E2();

  if(!isDefined(level._id_BB53))
    scripts\engine\utility::error("level.mortar not defined. define in level script");

  level waittill("start_mortars");

  for(;;) {
    wait(1 + randomfloat(2));
    var_3 = randomint(var_0.size);

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_4 = (var_2 + var_3) % var_0.size;
      var_5 = distance(level.player getorigin(), var_0[var_4].origin);
      var_6 = undefined;

      if(isDefined(level._id_721B))
        var_6 = distance(level._id_721B.origin, var_0[var_4].origin);
      else
        var_6 = 360;

      if(var_5 < 1600 && var_5 > 400 && var_6 > 350 && var_4 != var_1) {
        var_0[var_4] _id_15D3(400, 300, 25, undefined, undefined, undefined, 0);
        var_1 = var_4;

        if(var_5 < 500)
          scripts\sp\shellshock::main(4);

        break;
      }
    }
  }
}

_id_DC2D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0))
    var_0 = 7;

  if(!isDefined(var_1))
    var_1 = 2200;

  if(!isDefined(var_2))
    var_2 = 300;

  if(!isDefined(level._id_9FAD))
    level._id_9FAD = 0;

  if(!isDefined(var_9))
    var_9 = 0;

  var_11 = getEntArray("mortar", "targetname");
  var_12 = -1;

  for(var_13 = 0; var_13 < var_11.size; var_13++) {
    if(isDefined(var_11[var_13].target) && var_9 == 0)
      var_11[var_13] _id_F9E2();
  }

  if(!isDefined(level._id_BB53))
    scripts\engine\utility::error("level.mortar not defined. define in level script");

  if(isDefined(level._id_BB5B))
    level waittill(level._id_BB5B);

  for(;;) {
    if(level._id_9FAD != 0)
      wait 1;

    while(level._id_9FAD == 0) {
      if(isDefined(var_10))
        wait(var_10 + (randomfloat(var_0) + randomfloat(var_0)));
      else
        wait(randomfloat(var_0) + randomfloat(var_0));

      var_14 = randomint(var_11.size);

      for(var_13 = 0; var_13 < var_11.size; var_13++) {
        var_15 = (var_13 + var_14) % var_11.size;
        var_16 = distance(level.player getorigin(), var_11[var_15].origin);

        if(var_16 < var_1 && var_16 > var_2 && var_15 != var_12) {
          var_11[var_15] _id_15D3(var_3, var_4, var_5, var_6, var_7, var_8, 0);
          var_12 = var_15;
          break;
        }
      }
    }
  }
}

_id_EE2A() {
  var_0 = [];
  var_1 = [];
  level._id_BB99 = [];
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_EE26)) {
      if(!isDefined(level._id_BB99[var_2[var_3]._id_EE26]))
        level._id_BB99[var_2[var_3]._id_EE26] = [];

      var_4 = spawnStruct();
      var_4.origin = var_2[var_3].origin;
      var_4.angles = var_2[var_3].angles;

      if(isDefined(var_2[var_3].targetname))
        var_4.targetname = var_2[var_3].targetname;

      if(isDefined(var_2[var_3].target))
        var_4.target = var_2[var_3].target;

      level._id_BB99[var_2[var_3]._id_EE26][level._id_BB99[var_2[var_3]._id_EE26].size] = var_4;
      var_2[var_3] delete();
    }
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] hide();
    var_0[var_3]._id_8BB4 = 0;
  }

  if(!isDefined(level._id_BB53))
    level._id_BB53 = loadfx("vfx/core/expl/artilleryExp_dirt_brown");

  var_5 = scripts\engine\utility::array_combine(getEntArray("trigger_multiple", "classname"), getEntArray("trigger_radius", "classname"));

  for(var_3 = 0; var_3 < var_5.size; var_3++) {
    if(isDefined(var_5[var_3]._id_EE26)) {
      if(!isDefined(level._id_BB99[var_5[var_3]._id_EE26]))
        level._id_BB99[var_5[var_3]._id_EE26] = [];

      var_1[var_1.size] = var_5[var_3];
    }
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3]._id_BB6A = 0;
    var_1[var_3] thread _id_EE28();
  }

  var_6 = undefined;

  for(;;) {
    level waittill("mortarzone", var_7);

    if(isDefined(var_6))
      var_6 notify("wait again");

    level._id_BBA1 = var_7._id_EE26;
    var_7 thread _id_EE29();
    var_6 = var_7;
  }
}

_id_EE29() {
  var_0 = [];
  var_1 = gettime();
  var_2 = 0;

  if(isDefined(self._id_EEE5)) {
    level notify("timed barrage");
    var_1 = gettime() + self._id_EEE5 * 1000;
    var_2 = 1;
  }

  if(isDefined(self.script_radius))
    var_3 = self.script_radius;
  else
    var_3 = 0;

  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max))
    var_4 = 1;
  else
    var_4 = 0;

  var_5 = 0;
  var_6 = 2;
  var_7 = 4;
  var_8 = 0;

  while(level._id_BB99[self._id_EE26].size > 0 && level._id_BBA1 == self._id_EE26 || var_2) {
    if(var_4)
      wait(randomfloat(self.script_delay_max - self.script_delay_min) + self.script_delay_min);
    else if(var_8) {
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
    var_11 = randomint(level._id_BB99[self._id_EE26].size);

    if(randomint(100) < 75) {
      var_12 = anglesToForward(level.player.angles);
      var_13 = [];

      for(var_14 = 0; var_14 < level._id_BB99[self._id_EE26].size; var_14++) {
        if(var_3 > 0 && distance(level.player.origin, level._id_BB99[self._id_EE26][var_14].origin) > var_3) {
          continue;
        }
        if(_id_9C31(level._id_BB99[self._id_EE26][var_14], var_0)) {
          continue;
        }
        var_15 = vectorNormalize(level._id_BB99[self._id_EE26][var_14].origin - level.player.origin);

        if(vectordot(var_12, var_15) > 0.3)
          var_13[var_13.size] = var_14;
      }

      if(var_13.size > 0)
        var_11 = var_13[randomint(var_13.size)];
    }

    if(var_0.size > 3)
      var_0 = [];

    var_0[var_0.size] = level._id_BB99[self._id_EE26][var_11];
    level._id_BB99[self._id_EE26][var_11] thread _id_EE27();

    if(var_2 && gettime() > var_1) {
      if(isDefined(self.target)) {
        var_16 = getEnt(self.target, "targetname");

        if(isDefined(var_16)) {
          var_16 notify("trigger");
          level notify("timed barrage finished");
        }
      }

      break;
    }
  }
}

_id_9C31(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2])
      return 1;
  }

  return 0;
}

_id_EE27() {
  if(isDefined(self.targetname) && isDefined(level._id_BB9E[self.targetname]))
    level thread[[level._id_BB9E[self.targetname]]](self);
  else
    thread _id_15D3(undefined, undefined, undefined, undefined, undefined, undefined, 1);

  self waittill("mortar");

  if(isDefined(self.target)) {
    var_0 = getEnt(self.target, "targetname");

    if(isDefined(var_0))
      var_0 notify("trigger");
  }
}

_id_EE28() {
  for(;;) {
    self waittill("trigger");

    if(isDefined(level._id_BBA1) && level._id_BBA1 == self._id_EE26) {
      continue;
    }
    level notify("mortarzone", self);
    self waittill("wait again");
  }
}

_id_127A1() {
  level._id_BB9F = getEntArray("mortartrigger", "targetname");
  level._id_BB99 = getEntArray("script_origin", "classname");

  for(var_0 = 0; var_0 < level._id_BB99.size; var_0++) {
    if(isDefined(level._id_BB99[var_0]._id_EE26))
      level._id_BB99[var_0] _id_F9E2();
  }

  level._id_A9BE = -1;

  if(!isDefined(level._id_BB53))
    scripts\engine\utility::error("level.mortar not defined. define in level script");

  for(var_0 = 0; var_0 < level._id_BB9F.size; var_0++)
    thread _id_127A2(var_0);
}

_id_127A2(var_0) {
  var_1 = getEntArray(level._id_BB9F[var_0].target, "targetname");

  for(;;) {
    if(level.player istouching(level._id_BB9F[var_0])) {
      var_2 = randomint(var_1.size);

      while(var_2 == level._id_A9BE) {
        var_2 = randomint(var_1.size);
        wait 0.1;
      }

      var_1[var_2] _id_15D3(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      level._id_A9BE = var_2;
    }

    wait(randomfloat(3) + randomfloat(4));
  }
}

_id_3279() {
  var_0 = [];
  var_1 = undefined;
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray("mortar_bunker", "targetname");
  var_4 = getEntArray("mortar_bunker", "targetname");

  if(isDefined(var_4) && var_4.size > 0)
    var_1 = scripts\sp\utility::_id_22A2(var_3, var_4);
  else
    var_1 = var_3;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(!isDefined(var_1[var_5]._id_EE26)) {
      continue;
    }
    var_6 = -1;
    var_7 = int(var_1[var_5]._id_EE26);

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

  for(var_5 = 0; var_5 < var_0.size; var_5++)
    thread _id_327F(var_0[var_5], var_3);

  wait 0.05;
  scripts\engine\utility::array_thread(getEntArray("mortar_on", "targetname"), ::_id_3280, "on");
  scripts\engine\utility::array_thread(getEntArray("mortar_off", "targetname"), ::_id_3280, "off");
}

_id_327F(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(level._id_BB6D))
    var_2 = level._id_BB6D;
  else
    var_2 = 4;

  if(isDefined(level._id_BB6C))
    var_3 = level._id_BB6C;
  else
    var_3 = 6;

  var_4 = int(var_0[0]._id_EE26);

  for(;;) {
    level waittill("start_mortars " + var_4);
    thread _id_327A(var_0, var_2, var_3, var_4, var_1);
  }
}

_id_327A(var_0, var_1, var_2, var_3, var_4) {
  level endon("start_mortars " + var_3);
  level endon("stop_mortars " + var_3);

  for(;;) {
    wait 0.05;
    var_5 = scripts\engine\utility::getclosest(level.player.origin, var_4);

    if(!isDefined(level._id_BB96))
      scripts\engine\utility::play_sound_in_space("mortar_incoming_bunker", var_5.origin);

    var_5 = scripts\engine\utility::getclosest(level.player.origin, var_4);
    playworldsound("exp_artillery_underground", var_5.origin);
    scripts\engine\utility::array_thread(var_0, ::_id_327B);

    if(!isDefined(level._id_BB97)) {
      if(scripts\engine\utility::cointoss())
        earthquake(0.2, 1.5, var_5.origin, 1250);
      else
        earthquake(0.35, 2.75, var_5.origin, 1250);
    }

    level notify("mortar_hit");
    wait(randomfloatrange(var_1, var_2));
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
  }
}

_id_327B(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level._id_BBA0) && _id_BB63(level._id_BBA0) == 0) {
    return;
  }
  if(isDefined(level._id_BB5A))
    var_2 = level._id_BB5A;
  else
    var_2 = 1024;

  var_3 = var_2 * var_2;
  var_4 = distancesquared(level.player.origin, self.origin);

  if(var_4 > var_3) {
    return;
  }
  if(isDefined(self.classname) && self.classname == "trigger_radius") {
    if(!level.player istouching(self) && distance(level.player.origin, self.origin) < level._id_BB66) {
      radiusdamage(self.origin, self.radius, 500, 500);
      self delete();
      return;
    }
  } else {
    playFX(level._effect["mortar"][self.script_fxid], self.origin);

    if(var_4 < 262144)
      playworldsound("emt_single_ceiling_debris", self.origin);
  }
}

_id_2C1A() {
  var_0 = [];
  var_1 = scripts\sp\utility::_id_8181("mortar", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_EE26)) {
      continue;
    }
    var_4 = var_3._id_EE26;

    if(!isDefined(var_0[var_4]))
      var_0[var_4] = [];

    var_0[var_4][var_0[var_4].size] = var_3;
  }

  foreach(var_7 in var_0)
  thread _id_2C21(var_7);

  wait 0.05;
  scripts\engine\utility::array_thread(getEntArray("mortar_on", "targetname"), ::_id_2C22, "on");
  scripts\engine\utility::array_thread(getEntArray("mortar_off", "targetname"), ::_id_2C22, "off");
}

_id_2C21(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(level._id_BB6D))
    var_1 = level._id_BB6D;
  else
    var_1 = 0.5;

  if(isDefined(level._id_BB6C))
    var_2 = level._id_BB6C;
  else
    var_2 = 3;

  var_3 = var_0[0]._id_EE26;

  for(;;) {
    level waittill("start_mortars_" + var_3);
    level thread _id_2C1B(var_0, var_3, var_1, var_2);

    if(isDefined(level._id_2C24))
      return;
  }
}

_id_2C1B(var_0, var_1, var_2, var_3) {
  level endon("start_mortars_" + var_1);
  level endon("stop_mortars_" + var_1);

  if(isDefined(level._id_BB5A))
    var_4 = level._id_BB5A;
  else
    var_4 = 300;

  var_5 = spawn("trigger_radius", (0, 0, 0), 0, var_4, 256);
  thread _id_2C1C(var_5, var_1);

  for(;;) {
    for(;;) {
      wait 0.05;

      if(isDefined(level._id_BB5A) && level._id_BB5A != var_4) {
        var_4 = level._id_BB5A;
        var_5 delete();
        var_5 = spawn("trigger_radius", (0, 0, 0), 0, var_4, 256);
        thread _id_2C1C(var_5, var_1);
      }

      var_6 = randomint(var_0.size);

      if(isDefined(var_0[var_6].cooldown)) {
        continue;
      }
      var_7 = distance(level.player.origin, var_0[var_6].origin);

      if(var_7 < var_4) {
        continue;
      }
      if(isDefined(level._id_BB69) && level._id_BB69.size > 0) {
        var_5.origin = var_0[var_6].origin;

        if(_id_BB9A(level._id_BB69, var_5))
          continue;
      }

      if(isDefined(level._id_BB9D)) {
        var_5.origin = var_0[var_6].origin;
        var_8 = getaiunittypearray(level._id_BB9D, "all");

        if(_id_BB9A(var_8, var_5))
          continue;
      }

      if(!isDefined(level._id_C06F) && var_7 > 1000) {
        continue;
      }
      if(isDefined(level._id_BB59) && var_7 > level._id_BB59) {
        continue;
      }
      if(isDefined(level._id_BBA0) && var_0[var_6] _id_BB63(level._id_BBA0) == 0) {
        continue;
      }
      break;
    }

    if(isDefined(level._id_C071) && level._id_C071 == 1) {
      return;
    }
    var_0[var_6] thread _id_2C1E();
    wait(var_2 + randomfloat(var_3 - var_2));
  }
}

_id_2C1C(var_0, var_1) {
  var_0 endon("entitydeleted");
  level waittill("stop_mortars_" + var_1);
  var_0 delete();
}

_id_BB9A(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 istouching(var_1))
      return 1;
  }

  return 0;
}

_id_BB63(var_0) {
  var_1 = level.player getEye();
  var_2 = (0, 0, 0);

  if(isDefined(level._id_D3DB))
    var_2 = level._id_D3DB;

  var_3 = scripts\engine\utility::within_fov(var_1, level.player getplayerangles() + var_2, self.origin, var_0);
  return var_3;
}

_id_2C1E(var_0, var_1) {
  if(!isDefined(level._id_BB65))
    level._id_BB65 = 250;

  if(!isDefined(level._id_BB67))
    level._id_BB67 = 1250;

  if(!isDefined(var_0))
    var_0 = 0;

  thread _id_2C1D();

  if(!var_0) {
    if(isDefined(level._id_BB57) && !isDefined(level._id_10257))
      playFX(scripts\engine\utility::getfx(level._id_BB57), self.origin);

    if(isDefined(level._id_93D3)) {
      thread scripts\engine\utility::play_sound_in_space(level.scr_sound["mortar"]["incomming"], self.origin);
      wait(level._id_93D3);
    } else
      thread scripts\engine\utility::play_sound_in_space(level.scr_sound["mortar"]["incomming"]);
  }

  if(isDefined(var_1))
    thread scripts\engine\utility::play_sound_in_space(var_1, self.origin);
  else
    thread scripts\engine\utility::play_sound_in_space(level.scr_sound["mortar"][self.script_fxid], self.origin);

  setplayerignoreradiusdamage(1);
  radiusdamage(self.origin, level._id_BB65, 150, 50);
  setplayerignoreradiusdamage(0);

  if(!isDefined(level._id_10257))
    playFX(scripts\engine\utility::getfx(self.script_fxid), self.origin);

  var_2 = 0.3;

  if(isDefined(level._id_BB9B))
    var_3 = level._id_BB9B;

  if(isDefined(level._id_1D61))
    earthquake(var_2, 1, level.player.origin, level._id_BB67);
  else
    earthquake(var_2, 1, self.origin, level._id_BB67);
}

_id_2C1D() {
  self.cooldown = 1;
  wait(3 + randomfloat(2));
  self.cooldown = undefined;
}

_id_2C22(var_0) {
  self waittill("trigger");

  if(var_0 == "on")
    _id_2C20(self._id_EE26);
  else if(var_0 == "off")
    _id_2C1F(self._id_EE26);
}

_id_2C20(var_0) {
  level notify("start_mortars_" + var_0);
}

_id_2C1F(var_0) {
  level notify("stop_mortars_" + var_0);
}

_id_327E(var_0) {
  if(!isDefined(level._id_BB66))
    level._id_BB66 = 512;

  if(!isDefined(level._id_BBA0))
    level._id_BBA0 = cos(35);

  level notify("start_mortars " + var_0);
}

_id_327C(var_0) {
  level waittill("mortar_hit");
  level notify("stop_mortars " + var_0);
}

_id_327D(var_0) {
  level notify("stop_mortars " + var_0);
}

_id_3280(var_0) {
  self waittill("trigger");

  if(var_0 == "on")
    _id_327E(self._id_EE26);
  else if(var_0 == "off")
    _id_327C(self._id_EE26);
}

_id_32A7() {
  level endon("stop falling mortars");
  _id_F9E2();
  wait(randomfloat(0.5) + randomfloat(0.5));

  for(;;) {
    if(distance(level.player getorigin(), self.origin) < 600) {
      _id_15D3(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      break;
    }

    wait 1;
  }

  wait(7 + randomfloat(20));

  for(;;) {
    if(distance(level.player getorigin(), self.origin) < 1200 && distance(level.player getorigin(), self.origin) > 400) {
      _id_15D3(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      wait(3 + randomfloat(14));
    }

    wait 1;
  }
}

_id_F9E2() {
  self._id_8BB4 = 0;

  if(isDefined(self.target)) {
    self._id_1170F = getEntArray(self.target, "targetname");
    self._id_8BB4 = 1;
  } else {}

  if(!isDefined(self._id_1170F)) {}

  if(isDefined(self._id_EDDB)) {
    if(isDefined(self._id_EDDB))
      self._id_8E69 = getEnt(self._id_EDDB, "targetname");
    else if(isDefined(self._id_1170F) && isDefined(self._id_1170F[0].target))
      self._id_8E69 = getEnt(self._id_1170F[0].target, "targetname");

    if(isDefined(self._id_8E69))
      self._id_8E69 hide();
  } else if(isDefined(self._id_8BB4)) {
    if(isDefined(self._id_1170F) && isDefined(self._id_1170F[0].target))
      self._id_8E69 = getEnt(self._id_1170F[0].target, "targetname");

    if(isDefined(self._id_8E69))
      self._id_8E69 hide();
  }
}

_id_15D3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_93D5(undefined, var_6);
  level notify("mortar");
  self notify("mortar");

  if(!isDefined(var_0))
    var_0 = 256;

  if(!isDefined(var_1))
    var_1 = 400;

  if(!isDefined(var_2))
    var_2 = 25;

  radiusdamage(self.origin, var_0, var_1, var_2);

  if(isDefined(self._id_8BB4) && self._id_8BB4 == 1 && isDefined(self._id_1170F)) {
    for(var_7 = 0; var_7 < self._id_1170F.size; var_7++) {
      if(isDefined(self._id_1170F[var_7]))
        self._id_1170F[var_7] delete();
    }
  }

  if(isDefined(self._id_8E69))
    self._id_8E69 show();

  self._id_8BB4 = 0;
  _id_BB54(self.origin, var_3, var_4, var_5, undefined, var_6);
}

_id_BB54(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = 0.15;

  if(!isDefined(var_2))
    var_2 = 2;

  if(!isDefined(var_3))
    var_3 = 850;

  thread _id_BB5E(var_5);

  if(isDefined(var_4))
    playFX(var_4, var_0);
  else
    playFX(level._id_BB53, var_0);

  earthquake(var_1, var_2, var_0, var_3);

  if(isDefined(level._id_D3DA)) {
    return;
  }
  if(distance(level.player.origin, var_0) > 300) {
    return;
  }
  level._id_D3DA = 1;
  level notify("shell shock player", var_2 * 4);
  scripts\sp\shellshock::main(var_2 * 4);
}

_id_BB5E(var_0) {
  if(!isDefined(level._id_BB58))
    level._id_BB58 = -1;

  for(var_1 = randomint(3) + 1; var_1 == level._id_BB58; var_1 = randomint(3) + 1) {}

  level._id_BB58 = var_1;

  if(!var_0)
    self playSound("mortar_explosion" + var_1);
  else
    scripts\engine\utility::play_sound_in_space("mortar_explosion" + var_1, self.origin);
}

_id_93D5(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(level._id_A9BF))
    level._id_A9BF = var_2;
  else if(var_2 - level._id_A9BF < 1000) {
    wait 1;
    return;
  } else
    level._id_A9BF = var_2;

  if(!isDefined(var_0))
    var_0 = randomint(3) + 1;

  if(var_0 == 1) {
    if(var_1)
      thread scripts\engine\utility::play_sound_in_space("mortar_incoming1", self.origin);
    else
      self playSound("mortar_incoming1");

    wait 0.82;
  } else if(var_0 == 2) {
    if(var_1)
      thread scripts\engine\utility::play_sound_in_space("mortar_incoming2", self.origin);
    else
      self playSound("mortar_incoming2");

    wait 0.42;
  } else {
    if(var_1)
      thread scripts\engine\utility::play_sound_in_space("mortar_incoming3", self.origin);
    else
      self playSound("mortar_incoming3");

    wait 1.3;
  }
}

_id_7773() {
  level._id_1278 = [];
  level._id_1279 = [];
  level._id_1275 = [];
  level._id_1276 = [];
  level._id_1277 = [];
  level._id_1274 = [];
  level._id_127B = [];
  level._id_127A = [];
}

_id_7776(var_0, var_1, var_2) {
  level._id_1279[var_0] = var_1;
  level._id_1278[var_0] = var_2;
}

_id_7774(var_0, var_1, var_2, var_3) {
  level._id_1275[var_0] = var_1;
  level._id_1277[var_0] = var_2;
  level._id_1276[var_0] = var_3;
}

_id_7775(var_0, var_1, var_2, var_3) {
  level._id_1274[var_0] = var_1;
  level._id_127B[var_0] = var_2;
  level._id_127A[var_0] = var_3;
}

_id_7772(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = -1;
  var_8 = var_5;
  var_9 = var_4;
  _id_7776(var_0, 300, 2200);

  if(!isDefined(var_1))
    var_1 = 7;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_6))
    var_6 = 0;

  if(isDefined(level._id_69EB) && isDefined(level._id_69EB[var_0]))
    level endon(level._id_69EB[var_0]);

  if(!isDefined(level._id_3130) || !isDefined(level._id_3130[var_0]))
    level._id_3130[var_0] = 0;

  var_10 = getEntArray(var_0, "targetname");

  for(var_11 = 0; var_11 < var_10.size; var_11++) {
    if(isDefined(var_10[var_11].target) && !var_6)
      var_10[var_11] _id_F9E2();
  }

  if(isDefined(level._id_69EA) && isDefined(level._id_69EA[var_0]))
    level waittill(level._id_69EA[var_0]);

  for(;;) {
    while(!level._id_3130[var_0]) {
      for(var_12 = 0; var_12 < var_2; var_12++) {
        if(!isDefined(var_5))
          var_8 = level._id_1278[var_0];

        if(!isDefined(var_4))
          var_9 = level._id_1279[var_0];

        var_13 = randomint(var_10.size);

        for(var_11 = 0; var_11 < var_10.size; var_11++) {
          var_14 = (var_11 + var_13) % var_10.size;
          var_15 = distance(level.player getorigin(), var_10[var_14].origin);

          if(var_15 < var_8 && var_15 > var_9 && var_14 != var_7) {
            var_10[var_14]._id_933A = var_9;
            var_10[var_14] _id_69DC(var_0);
            var_7 = var_14;
            break;
          }
        }

        var_7 = -1;

        if(isDefined(level._id_69E3) && isDefined(level._id_69E3[var_0])) {
          wait(level._id_69E3[var_0]);
          continue;
        }

        wait(randomfloat(var_1) + randomfloat(var_1));
      }

      if(isDefined(level._id_69DD) && isDefined(level._id_69DD[var_0])) {
        wait(level._id_69DD[var_0]);
        continue;
      }

      wait(randomfloat(var_3) + randomfloat(var_3));
    }

    wait 0.05;
  }
}

_id_69DC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_7774(var_0, 256, 25, 400);
  _id_7775(var_0, 0.15, 2, 850);

  if(!isDefined(var_1))
    var_1 = level._id_1275[var_0];

  if(!isDefined(var_2))
    var_2 = level._id_1277[var_0];

  if(!isDefined(var_3))
    var_3 = level._id_1276[var_0];

  if(!isDefined(var_4))
    var_4 = level._id_1274[var_0];

  if(!isDefined(var_5))
    var_5 = level._id_127B[var_0];

  if(!isDefined(var_6))
    var_6 = level._id_127A[var_0];

  _id_69E7(var_0);
  level notify("explosion", var_0);
  var_7 = 1;
  var_8 = undefined;
  var_9 = self;

  if(isDefined(self._id_933A) && distance(level.player.origin, self.origin) < self._id_933A) {
    var_10 = getEntArray(var_0, "targetname");

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = distance(level.player getorigin(), var_10[var_11].origin);

      if(var_12 > self._id_933A) {
        if(!isDefined(var_8) || var_12 < var_8) {
          var_8 = var_12;
          var_9 = var_10[var_11];
        }
      }
    }

    if(!isDefined(var_8))
      var_7 = 0;
  }

  if(var_7)
    radiusdamage(var_9.origin, var_1, var_3, var_2);

  if(isDefined(var_9._id_8BB4) && var_9._id_8BB4 == 1 && isDefined(var_9._id_1170F)) {
    for(var_13 = 0; var_13 < var_9._id_1170F.size; var_13++) {
      if(isDefined(var_9._id_1170F[var_13]))
        var_9._id_1170F[var_13] delete();
    }
  }

  if(isDefined(var_9._id_8E69))
    var_9._id_8E69 show();

  var_9._id_8BB4 = 0;
  var_9 _id_69DE(var_0, var_4, var_5, var_6);
}

_id_69DE(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.15;

  if(!isDefined(var_2))
    var_2 = 2;

  if(!isDefined(var_3))
    var_3 = 850;

  _id_69E9(var_0);
  var_4 = self.origin;
  playFX(level._effect[var_0], var_4);
  earthquake(var_1, var_2, var_4, var_3);

  if(distance(level.player.origin, var_4) > 300) {
    return;
  }
  level._id_D3DA = 1;
  level notify("shell shock player", var_2 * 4);
  scripts\sp\shellshock::main(var_2 * 4);
}

_id_69E9(var_0) {
  if(!isDefined(level._id_127D))
    level._id_127D = 0;

  for(var_1 = randomint(3) + 1; var_1 == level._id_127D; var_1 = randomint(3) + 1) {}

  level._id_127D = var_1;

  if(level._id_1249[var_0] == "mortar") {
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
  } else if(level._id_1249[var_0] == "artillery") {
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
  } else if(level._id_1249[var_0] == "bomb") {
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

_id_69E7(var_0, var_1) {
  if(!isDefined(level._id_127C))
    level._id_127C = -1;

  for(var_1 = randomint(4) + 1; var_1 == level._id_127C; var_1 = randomint(4) + 1) {}

  level._id_127C = var_1;

  if(level._id_1249[var_0] == "mortar") {
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
  } else if(level._id_1249[var_0] == "artillery") {
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
  } else if(level._id_1249[var_0] == "bomb") {
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