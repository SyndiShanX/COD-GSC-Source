/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\359.gsc
**************************************/

_id_204E(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("damage");
  self endon("end_patrol");
  waittillframeend;

  if(isDefined(self._id_204F)) {
    [[level._id_1C4D["_patrol_endon_spotted_flag"]]]();

  }
  thread _id_206E();
  thread _id_206D();
  self.goalradius = 32;
  self allowedstances("stand");
  self._id_117F = 1;
  self._id_1199 = 1;
  self.allowdeath = 1;
  self._id_2050 = 1;
  maps\_utility::_id_109E();
  _id_2074();
  _id_2068();
  var_1["ent"][1] = ::_id_1411;
  var_1["ent"][0] = common_scripts\utility::get_linked_ents;
  var_1["node"][1] = ::_id_1410;
  var_1["node"][0] = ::_id_2072;
  var_1["struct"][1] = ::_id_140F;
  var_1["struct"][0] = maps\_utility::_id_2051;
  var_2["ent"] = maps\_utility::_id_2052;
  var_2["node"] = maps\_utility::_id_2053;
  var_2["struct"] = maps\_utility::_id_2052;

  if(isDefined(var_0)) {
    self.target = var_0;

  }
  if(isDefined(self.target)) {
    var_3 = 1;
    var_4 = _id_1411();
    var_5 = _id_1410();
    var_6 = _id_140F();

    if(var_4.size) {
      var_7 = common_scripts\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = common_scripts\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = common_scripts\utility::random(var_6);
      var_8 = "struct";
    }
  } else {
    var_3 = 0;
    var_4 = common_scripts\utility::get_linked_ents();
    var_5 = _id_2072();
    var_6 = maps\_utility::_id_2051();

    if(var_4.size) {
      var_7 = common_scripts\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = common_scripts\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = common_scripts\utility::random(var_6);
      var_8 = "struct";
    }
  }

  var_9 = [];
  var_9["pause"] = "patrol_idle_";
  var_9["turn180"] = common_scripts\utility::ter_op(isDefined(self._id_2054), self._id_2054, "patrol_turn180");
  var_9["smoke"] = "patrol_idle_smoke";
  var_9["stretch"] = "patrol_idle_stretch";
  var_9["checkphone"] = "patrol_idle_checkphone";
  var_9["phone"] = "patrol_idle_phone";
  var_10 = var_7;

  for(;;) {
    while(isDefined(var_10._id_2055)) {
      wait 0.05;

    }
    var_7._id_2055 = undefined;
    var_7 = var_10;
    self notify("release_node");
    var_7._id_2055 = 1;
    self._id_2056 = var_7;
    [[var_2[var_8]]](var_7);

    if(isDefined(var_7.radius) && var_7.radius > 0) {
      self.goalradius = var_7.radius;
    } else {
      self.goalradius = 32;

    }
    self waittill("goal");
    var_7 notify("trigger", self);

    if(isDefined(var_7._id_2057)) {
      common_scripts\utility::flag_set(var_7._id_2057);

    }
    if(isDefined(var_7._id_2058)) {
      maps\_utility::_id_13DC(var_7._id_2058);

    }
    if(isDefined(var_7._id_2059)) {
      common_scripts\utility::flag_clear(var_7._id_2059);

    }
    var_11 = var_7[[var_1[var_8][var_3]]]();

    if(!var_11.size) {
      self notify("reached_path_end");
      self notify("_patrol_reached_path_end");

      if(isalive(self._id_205A)) {
        self._id_205A notify("master_reached_patrol_end");
      }
    }

    if(isDefined(var_7._id_1288)) {
      common_scripts\utility::flag_wait(var_7._id_1288);

    }
    var_7 maps\_utility::script_delay();
    var_12 = animscripts\reactions::_id_0F20;
    var_13 = var_7._id_205B;

    if(isDefined(var_13)) {
      if(!isDefined(self._id_205C)) {
        _id_2061(var_13, var_12, var_7);

      }
      if(isDefined(var_7._id_205D)) {
        self orientmode("face angle", var_7.angles[1]);

      }
      self._id_205E = 1;
      var_14 = var_9[var_13];

      if(isDefined(var_14)) {
        if(var_13 == "pause") {
          if(isDefined(self._id_205F) && isDefined(self._id_205F[var_13])) {
            var_14 = self._id_205F[var_13][randomint(self._id_205F[var_13].size)];
          } else {
            var_14 = var_14 + randomintrange(1, 6);
          }
        }

        maps\_anim::_id_11CC(self, "gravity", var_14, undefined, var_12);

        if(var_11.size && var_13 != "turn180") {
          _id_2063(var_13, var_12);
        }
      }

      self._id_205E = undefined;
    }

    if(!var_11.size) {
      if(isDefined(self._id_2060) && !isDefined(var_13)) {
        _id_2061("path_end_idle", var_12, var_7);

        for(;;) {
          var_15 = self._id_2060[randomint(self._id_2060.size)];
          maps\_anim::_id_11CC(self, "gravity", var_15, undefined, var_12);
        }
      }

      break;
    }

    var_10 = common_scripts\utility::random(var_11);
  }
}

_id_2061(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;

  if(isDefined(var_2._id_205D)) {
    var_3 = var_2;
    self._id_0C5E = 1;
    var_4 = 1;
  }

  if(isDefined(self._id_2062) && isDefined(self._id_2062[var_0])) {
    var_3 maps\_anim::_id_11CC(self, "gravity", self._id_2062[var_0], undefined, var_1, var_4);
  } else {
    var_3 maps\_anim::_id_11CC(self, "gravity", "patrol_stop", undefined, var_1, var_4);
  }
}

_id_2063(var_0, var_1) {
  if(isDefined(self._id_2064) && isDefined(self._id_2064[var_0])) {
    maps\_anim::_id_11CC(self, "gravity", self._id_2064[var_0], undefined, var_1);
  } else {
    maps\_anim::_id_11CC(self, "gravity", "patrol_start", undefined, var_1);
  }
}

#using_animtree("generic_human");

_id_2065() {
  if(self.a._id_0D26 == "crouch" && isDefined(self.a._id_0C6D)) {
    var_0 = self.a._id_0C6D["stance_change"];

    if(isDefined(var_0)) {
      self setflaggedanimknoballrestart("stand_up", var_0, % root, 1);
      animscripts\shared::_id_0C51("stand_up");
    }
  }
}

_id_2066() {
  self endon("enemy");
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  _id_2065();
  var_0 = level._id_0C59["generic"]["patrol_radio_in_clear"];
  self setflaggedanimknoballrestart("radio", var_0, % root, 1);
  animscripts\shared::_id_0C51("radio");
  _id_2067();
}

_id_2067() {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }
  var_0 = self.pathgoalpos;
  var_1 = var_0 - self.origin;
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = lengthsquared(var_1);

  if(var_2 < 1) {
    return;
  }
  var_1 = var_1 / sqrt(var_2);
  var_3 = anglesToForward(self.angles);

  if(vectordot(var_3, var_1) < -0.5) {
    self animmode("zonly_physics", 0);
    self orientmode("face current");
    _id_2065();
    var_4 = level._id_0C59["generic"]["patrol_turn180"];
    self setflaggedanimknoballrestart("move", var_4, % root, 1);

    if(animhasnotetrack(var_4, "code_move")) {
      animscripts\shared::_id_0C51("move");
      self orientmode("face motion");
      self animmode("none", 0);
    }

    animscripts\shared::_id_0C51("move");
  }
}

_id_2068() {
  var_0 = "patrol_walk";

  if(isDefined(self._id_2069)) {
    var_0 = self._id_2069;

  }
  var_1 = undefined;

  if(isDefined(self._id_206A)) {
    var_1 = self._id_206A;

  }
  maps\_utility::_id_140A(var_0, var_1);
}

_id_206B() {
  self endon("end_patrol");

  if(isDefined(self._id_206C)) {
    self._id_206C endon("death");

  }
  self waittill("enemy");
}

_id_206D() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self._id_2056)) {
    return;
  }
  self._id_2056._id_2055 = undefined;
}

_id_206E() {
  self endon("death");
  _id_206B();
  var_0 = maps\_utility::_id_133C("_stealth_enabled") && maps\_utility::_id_1008("_stealth_enabled");

  if(!var_0) {
    maps\_utility::_id_140C();
    self allowedstances("stand", "crouch", "prone");
    self._id_117F = 0;
    self._id_1199 = 0;
    self stopanimscripted();
    self notify("stop_animmode");
    self._id_206F = undefined;
    self.goalradius = level._id_2070;
  }

  if(isDefined(self._id_2071)) {
    self.interval = self._id_2071;

  }
  self._id_0FC6 = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self._id_2056)) {
    return;
  }
  self._id_2056._id_2055 = undefined;
}

_id_1411() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = getEntArray(self.target, "targetname");

  }
  return var_0;
}

_id_1410() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = getnodearray(self.target, "targetname");

  }
  return var_0;
}

_id_140F() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  }
  return var_0;
}

_id_2072() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

_id_2073(var_0) {
  self endon("release_node");
}

_id_2074() {
  if(isDefined(self._id_205A)) {
    self._id_205A thread _id_2076();
    return;
  }

  if(!isDefined(self._id_2075)) {
    return;
  }
  waittillframeend;
  var_0 = getaispeciesarray(self.team, "dog");
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2]._id_2075)) {
      continue;
    }
    if(var_0[var_2]._id_2075 != self._id_2075) {
      continue;
    }
    var_1 = var_0[var_2];
    self._id_205A = var_1;
    var_1._id_206C = self;
    break;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread _id_2076();
}

_id_2076() {
  maps\_utility::_id_13AF(self);

  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");

  if(isDefined(self._id_204F)) {
    [[level._id_1C4D["_patrol_endon_spotted_flag"]]]();

  }
  self._id_206C endon("death");
  thread _id_206E();
  self.goalradius = 4;
  self.allowdeath = 1;
  var_0 = _id_2078();
  var_1 = vectornormalize(self.origin - self._id_206C.origin);
  var_2 = anglestoright(self._id_206C.angles);
  var_3 = "left";

  if(vectordot(var_1, var_2) > 0) {
    var_3 = "right";

  }
  wait 1;
  thread _id_207F();
  thread _id_2081();
  self._id_2071 = self.interval;
  self.interval = 70;

  for(;;) {
    if(isDefined(self._id_206C) && !isDefined(self._id_206C._id_205E)) {
      var_0 = _id_207A(var_0);

      if(var_3 == "null") {
        var_3 = "back";

      }
      var_3 = _id_207E(var_0, var_3);
      self._id_2077 = var_0[var_3].origin;
    } else {
      self._id_2077 = self.origin;

    }
    self setgoalpos(self._id_2077);
    wait 0.05;
  }
}

_id_2078() {
  var_0 = [];
  var_1 = spawnStruct();
  var_1._id_2079 = [];
  var_1._id_2079[var_1._id_2079.size] = "right";
  var_1._id_2079[var_1._id_2079.size] = "back_right";
  var_2 = spawnStruct();
  var_2._id_2079 = [];
  var_2._id_2079[var_2._id_2079.size] = "right";
  var_2._id_2079[var_2._id_2079.size] = "back_right";
  var_2._id_2079[var_2._id_2079.size] = "back";
  var_3 = spawnStruct();
  var_3._id_2079 = [];
  var_3._id_2079[var_3._id_2079.size] = "back_right";
  var_3._id_2079[var_3._id_2079.size] = "back_left";
  var_3._id_2079[var_3._id_2079.size] = "back";
  var_4 = spawnStruct();
  var_4._id_2079 = [];
  var_4._id_2079[var_4._id_2079.size] = "left";
  var_4._id_2079[var_4._id_2079.size] = "back_left";
  var_4._id_2079[var_4._id_2079.size] = "back";
  var_5 = spawnStruct();
  var_5._id_2079 = [];
  var_5._id_2079[var_5._id_2079.size] = "left";
  var_5._id_2079[var_5._id_2079.size] = "back_left";
  var_6 = spawnStruct();
  var_0["right"] = var_1;
  var_0["left"] = var_5;
  var_0["back_right"] = var_2;
  var_0["back_left"] = var_4;
  var_0["back"] = var_3;
  var_0["null"] = var_6;
  return var_0;
}

_id_207A(var_0) {
  var_1 = vectortoangles(self._id_206C._id_2056.origin - self._id_206C.origin);
  var_2 = self._id_206C.origin;
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_0["right"].origin = var_2 + var_3 * 40 + var_4 * 30;
  var_0["left"].origin = var_2 + var_3 * -40 + var_4 * 30;
  var_0["back_right"].origin = var_2 + var_3 * 32 + var_4 * -16;
  var_0["back_left"].origin = var_2 + var_3 * -32 + var_4 * -16;
  var_0["back"].origin = var_2 + var_4 * -48;
  var_0["null"].origin = self.origin;
  var_5 = getarraykeys(var_0);

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_0[var_7]._id_207B = 0;
    var_0[var_7]._id_207C = 0;
  }

  return var_0;
}

_id_207D(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "null") {
      continue;
    }
  }
}

_id_207E(var_0, var_1) {
  var_0[var_1]._id_207C = 1;

  for(var_2 = 0; var_2 < var_0[var_1]._id_2079.size; var_2++) {
    var_3 = var_0[var_1]._id_2079[var_2];

    if(var_0[var_3]._id_207B) {
      continue;
    }
    if(self maymovetopoint(var_0[var_3].origin)) {
      return var_3;

    }
    var_0[var_3]._id_207B = 1;
  }

  for(var_2 = 0; var_2 < var_0[var_1]._id_2079.size; var_2++) {
    var_3 = var_0[var_1]._id_2079[var_2];

    if(var_0[var_3]._id_207C) {
      continue;
    }
    var_3 = _id_207E(var_0, var_3);
    return var_3;
  }

  return "null";
}

_id_207F(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self._id_206C endon("death");

  if(isDefined(self._id_206C.script_noteworthy) && self._id_206C.script_noteworthy == "cqb_patrol") {
    maps\_utility::_id_2080();
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 200;

  }
  maps\_utility::_id_2080();

  for(;;) {
    wait 0.1;
    var_1 = self._id_2077;
    var_2 = distancesquared(self.origin, self._id_2077);

    if(var_2 > squared(var_0)) {
      if(self.a._id_0D2B == "run") {
        continue;
      }
      maps\_anim::_id_11CC(self, "gravity", "patrol_dog_start");
      maps\_utility::_id_140C();
      self._id_206F = 1;
      continue;
    }

    if(self.a._id_0D2B != "walk") {
      self notify("stopped_while_patrolling");
      maps\_anim::_id_11CC(self, "gravity", "patrol_dog_stop");
      maps\_utility::_id_2080();
    }
  }
}

_id_2081(var_0, var_1) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self._id_206C endon("death");

  if(isDefined(self._id_206C.script_noteworthy) && self._id_206C.script_noteworthy == "cqb_patrol") {
    for(;;) {
      wait 0.05;
      var_2 = self._id_2077;
      var_3 = distancesquared(self.origin, self._id_2077);

      if(var_3 < squared(16)) {
        if(self._id_0FC6 > 0.4) {
          self._id_0FC6 = self._id_0FC6 - 0.05;

        }
        continue;
      }

      if(var_3 > squared(48)) {
        if(self._id_0FC6 < 1.8) {
          self._id_0FC6 = self._id_0FC6 + 0.05;

        }
        continue;
      }

      self._id_0FC6 = 1;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = 16;

  }
  if(!isDefined(var_1)) {
    var_1 = 48;

  }
  var_4 = var_0 * var_0;
  var_5 = var_1 * var_1;

  for(;;) {
    wait 0.05;
    var_2 = self._id_2077;
    var_3 = distancesquared(self.origin, self._id_2077);

    if(self.a._id_0D2B != "walk") {
      self._id_0FC6 = 1;
      continue;
    }

    if(var_3 < var_4) {
      if(self._id_0FC6 > 0.4) {
        self._id_0FC6 = self._id_0FC6 - 0.05;

      }
      continue;
    }

    if(var_3 > var_5) {
      if(self._id_0FC6 < 0.75) {
        self._id_0FC6 = self._id_0FC6 + 0.05;

      }
      continue;
    }

    self._id_0FC6 = 0.5;
  }
}