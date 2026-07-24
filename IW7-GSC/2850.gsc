/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2850.gsc
**************************************/

_id_980E() {
  if(getDvar("debug_drones") == "") {
    setDvar("debug_drones", "0");
  }

  if(!isDefined(level._id_AFFC)) {
    level._id_5C43 = 200;
  }

  if(!isDefined(level._id_B431)) {
    level._id_B431 = [];
  }

  if(!isDefined(level._id_B431["allies"])) {
    level._id_B431["allies"] = 99999;
  }

  if(!isDefined(level._id_B431["axis"])) {
    level._id_B431["axis"] = 99999;
  }

  if(!isDefined(level._id_B431["team3"])) {
    level._id_B431["team3"] = 99999;
  }

  if(!isDefined(level._id_B431["neutral"])) {
    level._id_B431["neutral"] = 99999;
  }

  if(!isDefined(level._id_5CC3)) {
    level._id_5CC3 = [];
  }

  if(!isDefined(level._id_5CC3["allies"])) {
    level._id_5CC3["allies"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_5CC3["axis"])) {
    level._id_5CC3["axis"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_5CC3["team3"])) {
    level._id_5CC3["team3"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_5CC3["neutral"])) {
    level._id_5CC3["neutral"] = ::scripts\sp\utility::_id_1115A();
  }

  level._id_5C7C = ::_id_5C39;
}

_id_5C39() {
  if(level._id_5CC3[self.team]._id_2274.size >= level._id_B431[self.team]) {
    self delete();
    return;
  }

  thread _id_5BE0(self);
  level notify("new_drone");
  self setCanDamage(1);
  _id_0B24::_id_5C21();

  if(isDefined(self._id_ED6F)) {
    return;
  }
  thread _id_5BF1();

  if(isDefined(self.target)) {
    if(!isDefined(self._id_EE2B)) {
      thread _id_5C4C();
    } else {
      thread _id_5CA3();
    }
  }

  if(isDefined(self._id_EE06) && self._id_EE06 == 0) {
    return;
  }
  thread _id_5C33();
}

_id_5BE0(var_0) {
  scripts\sp\utility::_id_11161(level._id_5CC3[var_0.team], var_0);
  var_1 = var_0.team;
  var_0 waittill("death");

  if(isDefined(var_0) && isDefined(var_0._id_11159)) {
    scripts\sp\utility::_id_11163(level._id_5CC3[var_1], var_0._id_11159);
  } else {
    scripts\sp\utility::_id_11164(level._id_5CC3[var_1]);
  }
}

_id_5BF1() {
  _id_5CA2();

  if(!isDefined(self)) {
    return;
  }
  var_0 = "stand";

  if(isDefined(self._id_1FD0) && isDefined(level._id_5BDF[self.team][self._id_1FD0]) && isDefined(level._id_5BDF[self.team][self._id_1FD0]["death"])) {
    var_0 = self._id_1FD0;
  }

  var_1 = level._id_5BDF[self.team][var_0]["death"];

  if(isDefined(self._id_4E2A)) {
    var_1 = self._id_4E2A;
  }

  self notify("death");

  if(isDefined(level._id_5BEF)) {
    self thread[[level._id_5BEF]](var_1);
    return;
  }

  if(!(isDefined(self.noragdoll) && isDefined(self._id_10265))) {
    if(isDefined(self.noragdoll)) {
      _id_5C65(var_1, "deathplant");
    } else if(isDefined(self._id_10265)) {
      self startragdoll();
      _id_5C65(var_1, "deathplant");
    } else {
      _id_5C65(var_1, "deathplant");
      self startragdoll();
    }
  }

  self notsolid();
  thread _id_5C8C(2);

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }
  wait 10;

  while(isDefined(self)) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, 0.5)) {
      self delete();
    }

    wait 5;
  }
}

_id_5CA2() {
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

_id_5C8C(var_0) {
  wait(var_0);

  if(isDefined(self)) {
    self _meth_83BB();
  }
}

#using_animtree("generic_human");

_id_5C64(var_0, var_1) {
  if(isDefined(self._id_5C45)) {
    self[[self._id_5C46]](var_0, var_1);
  } else {
    self clearanim(%body, 0.2);
    self _meth_83A1();
    self _meth_82E4("drone_anim", var_0, %body, 1, 0.2, var_1);
    self._id_5CA5 = var_0;
  }
}

_id_5C65(var_0, var_1) {
  if(self.type == "human") {
    self clearanim(%body, 0.2);
  }

  self _meth_83A1();
  var_2 = "normal";

  if(isDefined(var_1)) {
    var_2 = "deathplant";
  }

  var_3 = "drone_anim";
  self animScripted(var_3, self.origin, self.angles, var_0, var_2);
  self waittillmatch("drone_anim", "end");
}

_id_5BFF() {
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

_id_5C33(var_0, var_1) {
  if(isDefined(self._id_5C34)) {
    [[self._id_5C35]]();
  } else if(isDefined(var_0) && isDefined(var_0["script_noteworthy"]) && isDefined(level._id_5BDF[self.team][var_0["script_noteworthy"]])) {
    thread _id_5C0E(var_0["script_noteworthy"], var_0, var_1);
  } else {
    if(isDefined(self._id_92F3)) {
      _id_5C64(self._id_92F3, 1);
      return;
    }

    _id_5C64(level._id_5BDF[self.team]["stand"]["idle"], 1);
  }
}

_id_5C1D(var_0, var_1) {
  var_2 = var_1["script_noteworthy"];

  if(!isDefined(level._id_5BDF[self.team][var_2]["arrival"])) {
    return var_0;
  }

  var_3 = getmovedelta(level._id_5BDF[self.team][var_2]["arrival"], 0, 1);
  var_3 = length(var_3);
  var_0 = var_0 - var_3;
  return var_0;
}

_id_5C0E(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_drone_fighting");
  self._id_1FD0 = var_0;
  self._id_13CCD = undefined;
  var_3 = randomintrange(1, 4);

  if(self.team == "axis") {
    if(var_3 == 1) {
      self._id_13CCD = "drone_ak12_fire_npc";
    } else if(var_3 == 2) {
      self._id_13CCD = "drone_cz805_fire_npc";
    }

    if(var_3 == 3) {
      self._id_13CCD = "drone_cbjms_fire_npc";
    }
  } else {
    if(var_3 == 1) {
      self._id_13CCD = "drone_r5rgp_fire_npc";
    } else if(var_3 == 2) {
      self._id_13CCD = "drone_fad_fire_npc";
    }

    if(var_3 == 3) {
      self._id_13CCD = "drone_m27_fire_npc";
    }
  }

  self.angles = (0, self.angles[1], self.angles[2]);

  if(var_0 == "coverprone") {
    self moveTo(self.origin + (0, 0, 8), 0.05);
  }

  self.noragdoll = 1;
  var_4 = level._id_5BDF[self.team][var_0];
  self._id_4E2A = var_4["death"];

  while(isDefined(self)) {
    _id_5C65(var_4["idle"][randomint(var_4["idle"].size)]);

    if(scripts\engine\utility::cointoss() && !isDefined(self.ignoreall)) {
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
        _id_5C65(var_4["hide_2_aim"]);
        wait(getanimlength(var_4["hide_2_aim"]) - 0.5);
      }

      if(isDefined(var_4["fire"])) {
        if(var_0 == "coverprone" && var_6 == 1) {
          thread _id_5C64(var_4["fire_exposed"], 1);
        } else {
          thread _id_5C64(var_4["fire"], 1);
        }

        _id_5C17();
      } else {
        _id_5C74();
        wait 0.15;
        _id_5C74();
        wait 0.15;
        _id_5C74();
        wait 0.15;
        _id_5C74();
      }

      if(var_6 == 1) {
        _id_5C65(var_4["aim_2_hide"]);
      }

      _id_5C65(var_4["reload"]);
    }
  }
}

_id_5C17() {
  self endon("death");

  if(scripts\engine\utility::cointoss()) {
    _id_5C74();
    wait 0.1;
    _id_5C74();
    wait 0.1;
    _id_5C74();

    if(scripts\engine\utility::cointoss()) {
      wait 0.1;
      _id_5C74();
    }

    if(scripts\engine\utility::cointoss()) {
      wait 0.1;
      _id_5C74();
      wait 0.1;
      _id_5C74();
      wait 0.1;
    }

    if(scripts\engine\utility::cointoss()) {
      wait(randomfloatrange(1, 2));
    }
  } else {
    _id_5C74();
    wait(randomfloatrange(0.25, 0.75));
    _id_5C74();
    wait(randomfloatrange(0.15, 0.75));
    _id_5C74();
    wait(randomfloatrange(0.15, 0.75));
    _id_5C74();
    wait(randomfloatrange(0.15, 0.75));
  }
}

_id_5C74() {
  self endon("death");
  self notify("firing");
  self endon("firing");
  _id_5C75();
  var_0 = % exposed_crouch_shoot_auto_v2;
  self _meth_82AB(var_0, 1, 0.2, 1.0);
  scripts\engine\utility::delaycall(0.25, ::clearanim, var_0, 0);
}

_id_5C75() {
  var_0 = scripts\engine\utility::getfx("ak47_muzzleflash");

  if(self.team == "allies") {
    var_0 = scripts\engine\utility::getfx("m16_muzzleflash");
  }

  if(isDefined(self._id_BE04)) {
    var_0 = scripts\engine\utility::getfx(self._id_BE04);
  }

  if(!isDefined(self._id_C05B)) {
    thread _id_5C66(self._id_13CCD);
  }

  playFXOnTag(var_0, self, "tag_flash");
}

_id_5C66(var_0) {
  self playSound(var_0);
}

_id_5CA3() {
  self endon("death");
  self waittill("move");
  thread _id_5C4C();
}

_id_7816(var_0) {
  var_1 = 170;
  var_2 = 1;
  var_3 = getanimlength(var_0);
  var_4 = getmovedelta(var_0, 0, 1);
  var_5 = length(var_4);

  if(var_3 > 0 && var_5 > 0) {
    var_1 = var_5 / var_3;
    var_2 = 0;
  }

  if(isDefined(self._id_5C71)) {
    var_1 = self._id_5C71;
  }

  var_6 = spawnStruct();
  var_6._id_1F1D = var_2;
  var_6._id_E81C = var_1;
  var_6._id_1F5A = var_3;
  return var_6;
}

_id_5C4C() {
  self endon("death");
  self endon("drone_stop");
  wait 0.05;
  var_0 = getpatharray(self.target, self.origin);
  var_1 = level._id_5BDF[self.team]["stand"]["run"];

  if(isDefined(self._id_E833)) {
    var_1 = self._id_E833;
  }

  var_2 = _id_7816(var_1);
  var_3 = var_2._id_E81C;
  var_4 = var_2._id_1F1D;

  if(isDefined(self._id_5C4E)) {
    var_2 = [[self._id_5C4E]]();

    if(isDefined(var_2)) {
      var_1 = var_2._id_E833;
      var_3 = var_2._id_E81C;
      var_4 = var_2._id_1F1D;
    }

    var_2 = undefined;
  }

  if(!var_4) {
    thread _id_5C50(var_3);
  }

  _id_5C64(var_1, self.moveplaybackrate);
  var_5 = 0.5;
  var_6 = 0;
  self._id_10D91 = 1;
  self._id_4B13 = var_0[var_6];
  var_7 = 0;
  var_8 = undefined;

  for(;;) {
    if(!isDefined(var_0[var_6])) {
      break;
    }

    var_9 = var_0[var_6]["vec"];
    var_10 = self.origin - var_0[var_6]["origin"];
    var_11 = vectordot(vectorNormalize(var_9), var_10);

    if(!isDefined(var_0[var_6]["dist"])) {
      break;
    }

    var_12 = var_11 + level._id_5C43;

    while(var_12 > var_0[var_6]["dist"]) {
      var_12 = var_12 - var_0[var_6]["dist"];
      var_6++;
      self._id_4B13 = var_0[var_6];

      if(isDefined(var_8)) {
        if(var_6 == 0) {}

        if(!isDefined(self._id_2A50)) {
          self._id_2A50 = self._id_5CA5;
        }

        var_13 = level._id_5BDF[self.team]["stairs"][var_8];
        _id_5C64(var_13, self.moveplaybackrate);
        var_7 = 1;
      }

      if(!isDefined(var_0[var_6]["dist"])) {
        self rotateTo(vectortoangles(var_0[var_0.size - 1]["vec"]), var_5);
        var_14 = distance(self.origin, var_0[var_0.size - 1]["origin"]);
        var_15 = var_14 / (var_3 * self.moveplaybackrate);
        var_16 = var_0[var_0.size - 1]["origin"] + (0, 0, 100);
        var_17 = var_0[var_0.size - 1]["origin"] - (0, 0, 100);
        var_18 = physicstrace(var_16, var_17);

        if(getDvar("debug_drones") == "1") {
          thread scripts\engine\utility::draw_line_for_time(var_16, var_17, 1, 1, 1, var_5);
          thread scripts\engine\utility::draw_line_for_time(self.origin, var_18, 0, 0, 1, var_5);
        }

        self moveTo(var_18, var_15);
        wait(var_15);
        self notify("goal");
        thread _id_3D67();
        thread _id_5C33(var_0[var_0.size - 1], var_18);
        return;
      }

      if(!isDefined(var_0[var_6])) {
        self notify("goal");
        thread _id_5C33();
        return;
      }
    }

    if(isDefined(self._id_5C4E)) {
      var_2 = [[self._id_5C4E]]();

      if(isDefined(var_2)) {
        if(var_2._id_E833 != var_1) {
          var_1 = var_2._id_E833;
          var_3 = var_2._id_E81C;
          var_4 = var_2._id_1F1D;

          if(!var_4) {
            thread _id_5C50(var_3);
          } else {
            self notify("drone_move_z");
          }

          _id_5C64(var_1, self.moveplaybackrate);
        }
      }
    }

    self._id_4B13 = var_0[var_6];
    var_19 = var_0[var_6]["vec"] * var_12;
    var_19 = var_19 + var_0[var_6]["origin"];
    var_20 = var_19;
    var_16 = var_20 + (0, 0, 100);
    var_17 = var_20 - (0, 0, 100);
    var_20 = physicstrace(var_16, var_17);

    if(!var_4) {
      self._id_5C42 = var_20;
    }

    if(getDvar("debug_drones") == "1") {
      thread scripts\engine\utility::draw_line_for_time(var_16, var_17, 1, 1, 1, var_5);
      thread _id_5B59(var_20, 1, 0, 0, 16, var_5);
    }

    var_21 = vectortoangles(var_20 - self.origin);
    self rotateTo((0, var_21[1], 0), var_5);
    var_22 = var_3 * var_5 * self.moveplaybackrate;
    var_23 = vectorNormalize(var_20 - self.origin);
    var_19 = var_23 * var_22;
    var_19 = var_19 + self.origin;

    if(getDvar("debug_drones") == "1") {
      thread scripts\engine\utility::draw_line_for_time(self.origin, var_19, 0, 0, 1, var_5);
    }

    self moveTo(var_19, var_5);
    wait(var_5);

    if(isDefined(self._id_4B13["script_noteworthy"]) && (self._id_4B13["script_noteworthy"] == "stairs_start_up" || self._id_4B13["script_noteworthy"] == "stairs_start_down")) {
      var_24 = strtok(self._id_4B13["script_noteworthy"], "_");
      var_8 = var_24[2];
      continue;
    }

    if(var_7 == 1) {
      if(isDefined(self._id_4B13["script_noteworthy"]) && self._id_4B13["script_noteworthy"] == "stairs_end") {
        var_25 = self._id_2A50;
        _id_5C64(var_25, self.moveplaybackrate);
        var_7 = 0;
        var_8 = undefined;
      }
    }
  }

  thread _id_5C33();
}

_id_5C50(var_0) {
  self endon("death");
  self endon("drone_stop");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;

  for(;;) {
    if(isDefined(self._id_5C42) && var_0 > 0) {
      var_2 = self._id_5C42[2] - self.origin[2];
      var_3 = distance2d(self._id_5C42, self.origin);
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

getpatharray(var_0, var_1) {
  var_2 = 1;
  var_3 = [];
  var_3[0]["origin"] = var_1;
  var_3[0]["dist"] = 0;
  var_4 = undefined;
  var_4 = var_0;

  for(;;) {
    var_5 = var_3.size;
    var_6 = _id_0B77::_id_7CDA(var_4);
    var_7 = scripts\engine\utility::random(var_6);
    var_8 = var_7.origin;

    if(isDefined(var_7.radius)) {
      if(!isDefined(self._id_5CC2)) {
        self._id_5CC2 = -1 + randomfloat(2);
      }

      if(!isDefined(var_7.angles)) {
        var_7.angles = (0, 0, 0);
      }

      var_9 = anglesToForward(var_7.angles);
      var_10 = anglestoright(var_7.angles);
      var_11 = anglestoup(var_7.angles);
      var_12 = (0, self._id_5CC2 * var_7.radius, 0);
      var_8 = var_8 + var_9 * var_12[0];
      var_8 = var_8 + var_10 * var_12[1];
      var_8 = var_8 + var_11 * var_12[2];
    }

    var_3[var_5]["origin"] = var_8;
    var_3[var_5]["target"] = var_7.target;

    if(isDefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isDefined(var_7.angles)) {
      var_3[var_5]["angles"] = var_7.angles;
    }

    if(isDefined(var_7.script_noteworthy)) {
      var_3[var_5]["script_noteworthy"] = var_7.script_noteworthy;
    }

    if(isDefined(var_7.script_linkname)) {
      var_3[var_5]["script_linkname"] = var_7.script_linkname;
    }

    var_3[var_5 - 1]["dist"] = distance(var_3[var_5]["origin"], var_3[var_5 - 1]["origin"]);
    var_3[var_5 - 1]["vec"] = vectorNormalize(var_3[var_5]["origin"] - var_3[var_5 - 1]["origin"]);

    if(!isDefined(var_3[var_5 - 1]["target"])) {
      var_3[var_5 - 1]["target"] = var_7.targetname;
    }

    if(!isDefined(var_3[var_5 - 1]["script_noteworthy"]) && isDefined(var_7.script_noteworthy)) {
      var_3[var_5 - 1]["script_noteworthy"] = var_7.script_noteworthy;
    }

    if(!isDefined(var_3[var_5 - 1]["script_linkname"]) && isDefined(var_7.script_linkname)) {
      var_3[var_5 - 1]["script_linkname"] = var_7.script_linkname;
    }

    if(!isDefined(var_7.target)) {
      break;
    }

    var_4 = var_7.target;
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isDefined(var_3[var_5]["angles"])) {
    var_3[var_5]["vec"] = anglesToForward(var_3[var_5]["angles"]);
  } else {
    var_3[var_5]["vec"] = var_3[var_5 - 1]["vec"];
  }

  var_7 = undefined;
  return var_3;
}

_id_5B59(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + (var_4, 0, 0);
  var_7 = var_0 - (var_4, 0, 0);
  thread scripts\engine\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, var_4, 0);
  var_7 = var_0 - (0, var_4, 0);
  thread scripts\engine\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, 0, var_4);
  var_7 = var_0 - (0, 0, var_4);
  thread scripts\engine\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
}

_id_3D67() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self._id_B14F)) {
        scripts\sp\utility::_id_1101B();
      }

      self delete();
      break;
    case "die_on_goal":
      self _meth_81D0();
      break;
  }
}