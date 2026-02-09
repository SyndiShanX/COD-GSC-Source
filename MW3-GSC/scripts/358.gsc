/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\358.gsc
**************************************/

_id_1FF7() {
  if(getDvar("debug_drones") == "") {
    setDvar("debug_drones", "0");
  }
  if(!isDefined(level._id_1FF8)) {
    level._id_1FF9 = 200;
  }
  if(!isDefined(level._id_1FFA)) {
    level._id_1FFA = [];
  }
  if(!isDefined(level._id_1FFA["allies"])) {
    level._id_1FFA["allies"] = 99999;
  }
  if(!isDefined(level._id_1FFA["axis"])) {
    level._id_1FFA["axis"] = 99999;
  }
  if(!isDefined(level._id_1FFA["team3"])) {
    level._id_1FFA["team3"] = 99999;
  }
  if(!isDefined(level._id_1FFA["neutral"])) {
    level._id_1FFA["neutral"] = 99999;
  }
  if(!isDefined(level._id_1FFB)) {
    level._id_1FFB = [];
  }
  if(!isDefined(level._id_1FFB["allies"])) {
    level._id_1FFB["allies"] = maps\_utility::_id_1FFC();
  }
  if(!isDefined(level._id_1FFB["axis"])) {
    level._id_1FFB["axis"] = maps\_utility::_id_1FFC();
  }
  if(!isDefined(level._id_1FFB["team3"])) {
    level._id_1FFB["team3"] = maps\_utility::_id_1FFC();
  }
  if(!isDefined(level._id_1FFB["neutral"])) {
    level._id_1FFB["neutral"] = maps\_utility::_id_1FFC();
  }
  level._id_1FFD = ::_id_2003;
}

#using_animtree("generic_human");

_id_1FFE() {
  self useanimtree(#animtree);
  self startusingheroonlylighting();

  if(isDefined(self._id_1FFF)) {
    self._id_0FC6 = self._id_1FFF;
  } else {
    self._id_0FC6 = 1;
  }
  if(self.team == "allies") {
    maps\_names::_id_12A4();
    self setlookattext(self.name, &"");
  }

  if(isDefined(level._id_2000)) {
    self thread[[level._id_2000]]();
  }
  if(!isDefined(self._id_2001)) {
    level thread maps\_friendlyfire::_id_1FE4(self);
  }
  if(!isDefined(level._id_2002)) {
    self thermaldrawenable();
  }
}

_id_2003() {
  if(level._id_1FFB[self.team]._id_0C6D.size >= level._id_1FFA[self.team]) {
    self delete();
    return;
  }

  thread _id_2007(self);
  level notify("new_drone");
  self setCanDamage(1);
  _id_1FFE();

  if(isDefined(self._id_2004)) {
    return;
  }
  thread _id_200B();

  if(isDefined(self.target)) {
    if(!isDefined(self._id_2005)) {
      thread _id_2043();
    } else {
      thread _id_203C();
    }
  }

  if(isDefined(self._id_2006) && self._id_2006 == 0) {
    return;
  }
  thread _id_2015();
}

_id_2007(var_0) {
  maps\_utility::_id_2008(level._id_1FFB[var_0.team], var_0);
  var_1 = var_0.team;
  var_0 waittill("death");

  if(isDefined(var_0) && isDefined(var_0._id_13B8)) {
    maps\_utility::_id_2009(level._id_1FFB[var_1], var_0._id_13B8);
  } else {
    maps\_utility::_id_200A(level._id_1FFB[var_1]);
  }
}

_id_200B() {
  _id_2010();

  if(!isDefined(self)) {
    return;
  }
  var_0 = "stand";

  if(isDefined(self._id_200C) && isDefined(level._id_200D[self.team][self._id_200C]) && isDefined(level._id_200D[self.team][self._id_200C]["death"])) {
    var_0 = self._id_200C;
  }
  var_1 = level._id_200D[self.team][var_0]["death"];

  if(isDefined(self._id_0D50)) {
    var_1 = self._id_0D50;
  }
  self notify("death");

  if(isDefined(level._id_200E)) {
    self thread[[level._id_200E]](var_1);
    return;
  }

  if(!(isDefined(self._id_0EC6) && isDefined(self._id_0EC3))) {
    if(isDefined(self._id_0EC6)) {
      _id_2013(var_1, "deathplant");
    } else if(isDefined(self._id_0EC3)) {
      self startragdoll();
      _id_2013(var_1, "deathplant");
    } else {
      _id_2013(var_1, "deathplant");
      self startragdoll();
    }
  }

  self notsolid();
  thread _id_2011(2);

  if(isDefined(self) && isDefined(self._id_200F)) {
    return;
  }
  wait 10;

  while(isDefined(self)) {
    if(!maps\_utility::within_fov(level.player.origin, level.player.angles, self.origin, 0.5)) {
      self delete();
    }
    wait 5;
  }
}

_id_2010() {
  self endon("death");

  while(isDefined(self)) {
    self waittill("damage");

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }
  }
}

_id_2011(var_0) {
  wait(var_0);

  if(isDefined(self)) {
    self thermaldrawdisable();
  }
}

_id_2012(var_0, var_1) {
  self clearanim(%body, 0.2);
  self stopanimscripted();
  self setflaggedanimknoballrestart("drone_anim", var_0, %body, 1, 0.2, var_1);
}

_id_2013(var_0, var_1) {
  self clearanim(%body, 0.2);
  self stopanimscripted();
  var_2 = "normal";

  if(isDefined(var_1)) {
    var_2 = "deathplant";
  }
  var_3 = "drone_anim";
  self animscripted(var_3, self.origin, self.angles, var_0, var_2);
  self waittillmatch("drone_anim", "end");
}

_id_2014() {
  if(!isDefined(self)) {
    return;
  }
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  var_0 = getweaponmodel(self.weapon);
  var_1 = self.weapon;

  if(isDefined(var_0)) {
    self detach(var_0, "tag_weapon_right");
    var_2 = self gettagorigin("tag_weapon_right");
    var_3 = self gettagangles("tag_weapon_right");
    var_4 = spawn("weapon_" + var_1, (0, 0, 0));
    var_4.angles = var_3;
    var_4.origin = var_2;
  }
}

_id_2015(var_0, var_1) {
  if(isDefined(self._id_2016)) {
    [[self._id_2017]]();
  } else if(isDefined(var_0) && isDefined(var_0["script_noteworthy"]) && isDefined(level._id_200D[self.team][var_0["script_noteworthy"]])) {
    thread _id_2036(var_0["script_noteworthy"], var_0, var_1);
  } else {
    if(isDefined(self._id_2018)) {
      _id_2012(self._id_2018, 1);
      return;
    }

    _id_2012(level._id_200D[self.team]["stand"]["idle"], 1);
  }
}

_id_2035(var_0, var_1) {
  var_2 = var_1["script_noteworthy"];

  if(!isDefined(level._id_200D[self.team][var_2]["arrival"])) {
    return var_0;
  }
  var_3 = getmovedelta(level._id_200D[self.team][var_2]["arrival"], 0, 1);
  var_3 = length(var_3);
  var_0 = var_0 - var_3;
  return var_0;
}

_id_2036(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_drone_fighting");
  self._id_200C = var_0;
  self._id_2037 = undefined;
  var_3 = randomintrange(1, 4);

  if(self.team == "axis") {
    if(var_3 == 1) {
      self._id_2037 = "drone_ak47_fire_npc";
    } else if(var_3 == 2) {
      self._id_2037 = "drone_g36c_fire_npc";
    }
    if(var_3 == 3) {
      self._id_2037 = "drone_fnp90_fire_npc";
    }
  } else {
    if(var_3 == 1) {
      self._id_2037 = "drone_m4carbine_fire_npc";
    } else if(var_3 == 2) {
      self._id_2037 = "drone_m16_fire_npc";
    }
    if(var_3 == 3) {
      self._id_2037 = "drone_m249saw_fire_npc";
    }
  }

  self.angles = (0, self.angles[1], self.angles[2]);

  if(var_0 == "coverprone") {
    self moveto(self.origin + (0, 0, 8), 0.05);
  }
  self._id_0EC6 = 1;
  var_4 = level._id_200D[self.team][var_0];
  self._id_0D50 = var_4["death"];

  while(isDefined(self)) {
    _id_2013(var_4["idle"][randomint(var_4["idle"].size)]);

    if(common_scripts\utility::cointoss() && !isDefined(self.ignoreall)) {
      var_5 = 1;

      if(isDefined(var_4["pop_up_chance"])) {
        var_5 = var_4["pop_up_chance"];
      }
      var_5 = var_5 * 100;
      var_6 = 1;

      if(randomfloat(100) > var_5) {
        var_6 = 0;
      }
      if(var_6 == 1) {
        _id_2013(var_4["hide_2_aim"]);
        wait(getanimlength(var_4["hide_2_aim"]) - 0.5);
      }

      if(isDefined(var_4["fire"])) {
        if(var_0 == "coverprone" && var_6 == 1) {
          thread _id_2012(var_4["fire_exposed"], 1);
        } else {
          thread _id_2012(var_4["fire"], 1);
        }
        _id_2038();
      } else {
        _id_2039();
        wait 0.15;
        _id_2039();
        wait 0.15;
        _id_2039();
        wait 0.15;
        _id_2039();
      }

      if(var_6 == 1) {
        _id_2013(var_4["aim_2_hide"]);
      }
      _id_2013(var_4["reload"]);
    }
  }
}

_id_2038() {
  self endon("death");

  if(common_scripts\utility::cointoss()) {
    _id_2039();
    wait 0.1;
    _id_2039();
    wait 0.1;
    _id_2039();

    if(common_scripts\utility::cointoss()) {
      wait 0.1;
      _id_2039();
    }

    if(common_scripts\utility::cointoss()) {
      wait 0.1;
      _id_2039();
      wait 0.1;
      _id_2039();
      wait 0.1;
    }

    if(common_scripts\utility::cointoss()) {
      wait(randomfloatrange(1, 2));
    }
  } else {
    _id_2039();
    wait(randomfloatrange(0.25, 0.75));
    _id_2039();
    wait(randomfloatrange(0.15, 0.75));
    _id_2039();
    wait(randomfloatrange(0.15, 0.75));
    _id_2039();
    wait(randomfloatrange(0.15, 0.75));
  }
}

_id_2039() {
  self endon("death");
  self notify("firing");
  self endon("firing");
  _id_203A();
  var_0 = % exposed_crouch_shoot_auto_v2;
  self setanimknobrestart(var_0, 1, 0.2, 1.0);
  common_scripts\utility::delaycall(0.25, ::clearanim, var_0, 0);
}

_id_203A() {
  var_0 = common_scripts\utility::getfx("ak47_muzzleflash");

  if(self.team == "allies") {
    var_0 = common_scripts\utility::getfx("m16_muzzleflash");
  }
  thread _id_203B(self._id_2037);
  playFXOnTag(var_0, self, "tag_flash");
}

_id_203B(var_0) {
  self playSound(var_0);
}

_id_203C() {
  self endon("death");
  self waittill("move");
  thread _id_2043();
}

_id_203D() {
  if(!isDefined(self.target)) {
    return;
  }
  if(isDefined(level._id_1B42[self.target])) {
    return;
  }
  level._id_1B42[self.target] = 1;
  var_0 = self.target;
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = var_1;

  for(;;) {
    var_1 = var_4;
    var_5 = 0;

    for(;;) {
      if(!isDefined(var_1.target)) {
        break;
      }

      var_6 = common_scripts\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7)) {
        break;
      }

      var_3[var_7.origin + ""] = 1;
      var_2[var_1.targetname] = var_7.origin - var_1.origin;
      var_1.angles = vectortoangles(var_2[var_1.targetname]);
      var_1 = var_7;
      var_5 = 1;
    }

    if(!var_5) {
      break;
    }
  }

  var_0 = self.target;
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_11 = var_1;
  var_3 = [];

  for(;;) {
    var_1 = var_4;
    var_5 = 0;

    for(;;) {
      if(!isDefined(var_1.target)) {
        return;
      }
      if(!isDefined(var_2[var_1.targetname])) {
        return;
      }
      var_6 = common_scripts\utility::getstructarray(var_1.target, "targetname");

      if(var_6.size) {
        break;
      }

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(isDefined(var_3[var_9.origin + ""])) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7)) {
        break;
      }

      if(isDefined(var_1.radius)) {
        var_14 = var_2[var_11.targetname];
        var_15 = var_2[var_1.targetname];
        var_16 = (var_14 + var_15) * 0.5;
        var_1.angles = vectortoangles(var_16);
      }

      var_5 = 1;
      var_11 = var_1;
      var_1 = var_7;
    }

    if(!var_5) {
      break;
    }
  }
}

_id_203E(var_0) {
  var_1 = 170;
  var_2 = 1;
  var_3 = getanimlength(var_0);
  var_4 = getmovedelta(var_0, 0, 1);
  var_5 = length(var_4);

  if(var_3 > 0 && var_5 > 0) {
    var_1 = var_5 / var_3;
    var_2 = 0;
  }

  if(isDefined(self._id_203F)) {
    var_1 = self._id_203F;
  }
  var_6 = spawnStruct();
  var_6._id_2040 = var_2;
  var_6._id_2041 = var_1;
  var_6._id_2042 = var_3;
  return var_6;
}

_id_2043() {
  self endon("death");
  self endon("drone_stop");
  wait 0.05;
  var_0 = _id_204A(self.target, self.origin);
  var_1 = level._id_200D[self.team]["stand"]["run"];

  if(isDefined(self._id_2044)) {
    var_1 = self._id_2044;
  }
  var_2 = _id_203E(var_1);
  var_3 = var_2._id_2041;
  var_4 = var_2._id_2040;

  if(isDefined(self._id_2045)) {
    var_2 = [[self._id_2045]]();

    if(isDefined(var_2)) {
      var_1 = var_2._id_2044;
      var_3 = var_2._id_2041;
      var_4 = var_2._id_2040;
    }

    var_2 = undefined;
  }

  if(!var_4) {
    thread _id_2049(var_3);
  }
  _id_2012(var_1, self._id_0FC6);
  var_5 = 0.5;
  var_6 = 0;
  self._id_2046 = 1;
  self._id_2047 = var_0[var_6];

  for(;;) {
    if(!isDefined(var_0[var_6])) {
      break;
    }

    var_7 = var_0[var_6]["vec"];
    var_8 = self.origin - var_0[var_6]["origin"];
    var_9 = vectordot(vectornormalize(var_7), var_8);

    if(!isDefined(var_0[var_6]["dist"])) {
      break;
    }

    var_10 = var_9 + level._id_1FF9;

    while(var_10 > var_0[var_6]["dist"]) {
      var_10 = var_10 - var_0[var_6]["dist"];
      var_6++;
      self._id_2047 = var_0[var_6];

      if(!isDefined(var_0[var_6]["dist"])) {
        self rotateto(vectortoangles(var_0[var_0.size - 1]["vec"]), var_5);
        var_11 = distance(self.origin, var_0[var_0.size - 1]["origin"]);
        var_12 = var_11 / (var_3 * self._id_0FC6);
        var_13 = var_0[var_0.size - 1]["origin"] + (0, 0, 100);
        var_14 = var_0[var_0.size - 1]["origin"] - (0, 0, 100);
        var_15 = physicstrace(var_13, var_14);

        if(getDvar("debug_drones") == "1") {
          thread common_scripts\utility::draw_line_for_time(var_13, var_14, 1, 1, 1, var_5);
          thread common_scripts\utility::draw_line_for_time(self.origin, var_15, 0, 0, 1, var_5);
        }

        self moveto(var_15, var_12);
        wait(var_12);
        self notify("goal");
        thread _id_204D();
        thread _id_2015(var_0[var_0.size - 1], var_15);
        return;
      }

      if(!isDefined(var_0[var_6])) {
        self notify("goal");
        thread _id_2015();
        return;
      }
    }

    if(isDefined(self._id_2045)) {
      var_2 = [[self._id_2045]]();

      if(isDefined(var_2)) {
        var_1 = var_2._id_2044;

        if(var_2._id_2044 != var_1) {
          var_3 = var_2._id_2041;
          var_4 = var_2._id_2040;

          if(!var_4) {
            thread _id_2049(var_3);
          } else {
            self notify("drone_move_z");
          }
          _id_2012(var_1, self._id_0FC6);
        }
      }
    }

    self._id_2047 = var_0[var_6];
    var_16 = var_0[var_6]["vec"] * var_10;
    var_16 = var_16 + var_0[var_6]["origin"];
    var_17 = var_16;
    var_13 = var_17 + (0, 0, 100);
    var_14 = var_17 - (0, 0, 100);
    var_17 = physicstrace(var_13, var_14);

    if(!var_4) {
      self._id_2048 = var_17;
    }
    if(getDvar("debug_drones") == "1") {
      thread common_scripts\utility::draw_line_for_time(var_13, var_14, 1, 1, 1, var_5);
      thread _id_204C(var_17, 1, 0, 0, 16, var_5);
    }

    var_18 = vectortoangles(var_17 - self.origin);
    self rotateto((0, var_18[1], 0), var_5);
    var_19 = var_3 * var_5 * self._id_0FC6;
    var_20 = vectornormalize(var_17 - self.origin);
    var_16 = var_20 * var_19;
    var_16 = var_16 + self.origin;

    if(getDvar("debug_drones") == "1") {
      thread common_scripts\utility::draw_line_for_time(self.origin, var_16, 0, 0, 1, var_5);
    }
    self moveto(var_16, var_5);
    wait(var_5);
  }

  thread _id_2015();
}

_id_2049(var_0) {
  self endon("death");
  self endon("drone_stop");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;

  for(;;) {
    if(isDefined(self._id_2048) && var_0 > 0) {
      var_2 = self._id_2048[2] - self.origin[2];
      var_3 = distance2d(self._id_2048, self.origin);
      var_4 = var_3 / var_0;

      if(var_4 > 0 && var_2 != 0) {
        var_5 = abs(var_2) / var_4;
        var_6 = var_5 * var_1;

        if(var_2 >= var_5) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_6);
        } else if(var_2 <= var_5 * -1) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_6);
        }
      }
    }

    wait(var_1);
  }
}

_id_204A(var_0, var_1) {
  var_2 = 1;
  var_3 = [];
  var_3[0]["origin"] = var_1;
  var_3[0]["dist"] = 0;
  var_4 = undefined;
  var_4 = var_0;
  var_5["entity"] = maps\_spawner::_id_1411;
  var_5["node"] = maps\_spawner::_id_1410;
  var_5["struct"] = maps\_spawner::_id_140F;
  var_6 = undefined;
  var_7 = [[var_5["entity"]]](var_4);
  var_8 = [[var_5["node"]]](var_4);
  var_9 = [[var_5["struct"]]](var_4);

  if(var_7.size) {
    var_6 = "entity";
  } else if(var_8.size) {
    var_6 = "node";
  } else if(var_9.size) {
    var_6 = "struct";
  }
  for(;;) {
    var_10 = var_3.size;
    var_11 = [[var_5[var_6]]](var_4);
    var_12 = common_scripts\utility::random(var_11);
    var_13 = var_12.origin;

    if(isDefined(var_12.radius)) {
      if(!isDefined(self._id_204B)) {
        self._id_204B = -1 + randomfloat(2);
      }
      if(!isDefined(var_12.angles)) {
        var_12.angles = (0, 0, 0);
      }
      var_14 = anglesToForward(var_12.angles);
      var_15 = anglestoright(var_12.angles);
      var_16 = anglestoup(var_12.angles);
      var_17 = (0, self._id_204B * var_12.radius, 0);
      var_13 = var_13 + var_14 * var_17[0];
      var_13 = var_13 + var_15 * var_17[1];
      var_13 = var_13 + var_16 * var_17[2];
    }

    var_3[var_10]["origin"] = var_13;
    var_3[var_10]["target"] = var_12.target;

    if(isDefined(self._id_164F) && self._id_164F == "use_last_node_angles" && isDefined(var_12.angles)) {
      var_3[var_10]["angles"] = var_12.angles;
    }
    if(isDefined(var_12.script_noteworthy)) {
      var_3[var_10]["script_noteworthy"] = var_12.script_noteworthy;
    }
    var_3[var_10 - 1]["dist"] = distance(var_3[var_10]["origin"], var_3[var_10 - 1]["origin"]);
    var_3[var_10 - 1]["vec"] = vectornormalize(var_3[var_10]["origin"] - var_3[var_10 - 1]["origin"]);

    if(!isDefined(var_3[var_10 - 1]["target"])) {
      var_3[var_10 - 1]["target"] = var_12.targetname;
    }
    if(!isDefined(var_3[var_10 - 1]["script_noteworthy"]) && isDefined(var_12.script_noteworthy)) {
      var_3[var_10 - 1]["script_noteworthy"] = var_12.script_noteworthy;
    }
    if(!isDefined(var_12.target)) {
      break;
    }

    var_4 = var_12.target;
  }

  if(isDefined(self._id_164F) && self._id_164F == "use_last_node_angles" && isDefined(var_3[var_10]["angles"])) {
    var_3[var_10]["vec"] = anglesToForward(var_3[var_10]["angles"]);
  } else {
    var_3[var_10]["vec"] = var_3[var_10 - 1]["vec"];
  }
  var_12 = undefined;
  return var_3;
}

_id_204C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + (var_4, 0, 0);
  var_7 = var_0 - (var_4, 0, 0);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, var_4, 0);
  var_7 = var_0 - (0, var_4, 0);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, 0, var_4);
  var_7 = var_0 - (0, 0, var_4);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
}

_id_204D() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "delete_on_goal":
      self delete();
      break;
    case "die_on_goal":
      self kill();
      break;
  }
}