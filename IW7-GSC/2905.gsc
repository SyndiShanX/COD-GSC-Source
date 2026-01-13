/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2905.gsc
**************************************/

func_C97C(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("damage");
  self endon("end_patrol");
  self endon("dog_attacks_ai");
  waittillframeend;

  if(isDefined(self.var_EED1)) {
    [[level._meth_83D2["_patrol_endon_spotted_flag"]]]();
  }

  thread func_13749();
  thread func_13759();
  self.goalradius = 32;
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.var_55ED = 1;
  self.allowdeath = 1;
  self.var_EE7E = 1;
  self.var_C3E8 = self.combatmode;
  self.combatmode = "no_cover";
  scripts\sp\utility::func_5514();

  if(isDefined(self.var_EE2C)) {
    self.var_C3FA = self.moveplaybackrate;
    self.moveplaybackrate = self.var_EE2C;
  }

  func_AD3A();
  func_F4C7();
  var_1["ent"][1] = ::func_7CD9;
  var_1["ent"][0] = ::scripts\sp\utility::func_7A8F;
  var_1["node"][1] = ::func_7CDB;
  var_1["node"][0] = ::func_7A92;
  var_1["struct"][1] = ::func_7CE0;
  var_1["struct"][0] = ::scripts\sp\utility::func_7A97;
  var_2["ent"] = ::scripts\sp\utility::func_F3D3;
  var_2["node"] = ::scripts\sp\utility::func_F3D9;
  var_2["struct"] = ::scripts\sp\utility::func_F3D3;

  if(isDefined(var_0)) {
    self.target = var_0;
  }

  if(isDefined(self.target)) {
    var_3 = 1;
    var_4 = func_7CD9();
    var_5 = func_7CDB();
    var_6 = func_7CE0();

    if(var_4.size) {
      var_7 = scripts\engine\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = scripts\engine\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = scripts\engine\utility::random(var_6);
      var_8 = "struct";
    }
  } else {
    var_3 = 0;
    var_4 = scripts\sp\utility::func_7A8F();
    var_5 = func_7A92();
    var_6 = scripts\sp\utility::func_7A97();

    if(var_4.size) {
      var_7 = scripts\engine\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = scripts\engine\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = scripts\engine\utility::random(var_6);
      var_8 = "struct";
    }
  }

  var_9 = [];
  var_9["pause"] = "patrol_idle_";
  var_9["turn180"] = ::scripts\engine\utility::ter_op(isDefined(self.var_C97E), self.var_C97E, "patrol_turn180");
  var_9["smoke"] = "patrol_idle_smoke";
  var_9["stretch"] = "patrol_idle_stretch";
  var_9["checkphone"] = "patrol_idle_checkphone";
  var_9["phone"] = "patrol_idle_phone";
  var_10 = var_7;

  for(;;) {
    while(isDefined(var_10.var_C97F)) {
      wait 0.05;
    }

    var_7.var_C97F = undefined;
    var_7 = var_10;
    self notify("release_node");
    var_7.var_C97F = 1;
    self.var_A8F4 = var_7;
    [[var_2[var_8]]](var_7);

    if(isDefined(var_7.radius) && var_7.radius > 0) {
      self.goalradius = var_7.radius;
    } else {
      self.goalradius = 32;
    }

    self waittill("goal");
    var_7 notify("trigger", self);

    if(isDefined(var_7.var_ED9E)) {
      scripts\engine\utility::flag_set(var_7.var_ED9E);
    }

    if(isDefined(var_7.var_ED80)) {
      scripts\sp\utility::func_65E1(var_7.var_ED80);
    }

    if(isDefined(var_7.var_ED9B)) {
      scripts\engine\utility::flag_clear(var_7.var_ED9B);
    }

    var_11 = var_7[[var_1[var_8][var_3]]]();

    if(!var_11.size) {
      if(isDefined(var_7.var_ED88)) {
        self orientmode("face angle", var_7.angles[1]);
      }

      self notify("reached_path_end");
      self notify("_patrol_reached_path_end");

      if(isalive(self.var_C991)) {
        self.var_C991 notify("master_reached_patrol_end");
      }
    }

    var_12 = scripts\anim\reactions::func_DD51;
    var_13 = var_7.script_animation;
    var_14 = 1;
    var_15 = 0;

    if(isDefined(var_7.script_parameters)) {
      var_16 = strtok(var_7.script_parameters, " ");

      for(var_17 = 0; var_17 < var_16.size; var_17++) {
        switch (var_16[var_17]) {
          case "keep_running":
            var_14 = 0;
            break;
          case "use_node":
            var_15 = 1;
            break;
          case "animset":
            var_17 = var_17 + 1;
            self.script_animation = var_16[var_17];

            if(self.script_animation == "default") {
              self.script_animation = undefined;
              self.var_C9AB = undefined;
              self.var_C9AC = undefined;
              self.var_C987 = undefined;
            }

            func_F4C7();
        }
      }
    }

    if(isDefined(var_7.var_EE2C)) {
      self.moveplaybackrate = var_7.var_EE2C;
    }

    if(var_7 func_8BA5() && var_7 func_ED4E() || isDefined(var_13) || isDefined(var_7.var_EDA0) && !scripts\engine\utility::flag(var_7.var_EDA0)) {
      if(!isDefined(self.var_C98F) && var_14) {
        func_C981(var_13, var_12, var_7);
      }

      if(isDefined(var_7.var_EDA0) && !scripts\engine\utility::flag(var_7.var_EDA0)) {
        scripts\engine\utility::flag_wait(var_7.var_EDA0);
      }

      var_7 scripts\sp\utility::script_delay();

      if(isDefined(var_13)) {
        if(isDefined(var_7.var_ED88)) {
          self orientmode("face angle", var_7.angles[1]);
        }

        self.var_C99C = 1;
        var_18 = var_9[var_13];

        if(!isDefined(var_18)) {
          if(isDefined(level.var_C99E)) {
            var_18 = level.var_C99E[var_13];
          }
        }

        if(isDefined(var_18)) {
          if(var_13 == "pause") {
            if(isDefined(self.var_C99D) && isDefined(self.var_C99D[var_13])) {
              var_18 = self.var_C99D[var_13][randomint(self.var_C99D[var_13].size)];
            } else {
              var_18 = var_18 + randomintrange(1, 6);
            }
          }

          if(var_15) {
            var_7 scripts\sp\anim::func_1ECE(self, var_18);
            var_7 scripts\sp\anim::func_1EC8(self, "gravity", var_18, undefined, var_12);
          } else
            scripts\sp\anim::func_1EC8(self, "gravity", var_18, undefined, var_12);
        }

        self.var_C99C = undefined;
      }

      if(var_11.size && (!isDefined(var_13) || var_13 != "turn180") && var_14 && (!isDefined(self.var_1025F) || !self.var_1025F)) {
        func_C980(var_13, var_12);
      }
    }

    if(!var_11.size) {
      if(isDefined(self.var_C982) && !isDefined(var_13)) {
        func_C981("path_end_idle", var_12, var_7);

        for(;;) {
          var_19 = self.var_C982[randomint(self.var_C982.size)];
          scripts\sp\anim::func_1EC8(self, "gravity", var_19, undefined, var_12);
        }
      }

      break;
    }

    var_10 = scripts\engine\utility::random(var_11);
  }
}

func_C981(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;

  if(isDefined(var_2.var_ED88)) {
    var_3 = var_2;
    self.var_C0C1 = 1;
    var_4 = 1;
  }

  if(isDefined(self.var_C9A7) && isDefined(self.var_C9A7[var_0])) {
    var_3 scripts\sp\anim::func_1EC8(self, "gravity", self.var_C9A7[var_0], undefined, var_1, var_4);
  } else if(isDefined(self.script_animation) && isDefined(level.var_EC85["generic"]["patrol_stop_" + self.script_animation])) {
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop_" + self.script_animation, undefined, var_1);
  } else {
    var_3 scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop", undefined, var_1, var_4);
  }
}

func_C980(var_0, var_1) {
  if(isDefined(self.var_C9A3) && isDefined(self.var_C9A3[var_0])) {
    scripts\sp\anim::func_1EC8(self, "gravity", self.var_C9A3[var_0], undefined, var_1);
  } else if(isDefined(self.script_animation) && isDefined(level.var_EC85["generic"]["patrol_start_" + self.script_animation])) {
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start_" + self.script_animation, undefined, var_1);
  } else {
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start", undefined, var_1);
  }
}

#using_animtree("generic_human");

func_10B63() {
  if(self.a.pose == "crouch" && isDefined(self.a.var_2274)) {
    var_0 = self.a.var_2274["stance_change"];

    if(isDefined(var_0)) {
      self _meth_82E4("stand_up", var_0, % root, 1);
      scripts\anim\shared::donotetracks("stand_up");
    }
  }
}

func_C99B() {
  self endon("enemy");
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  func_10B63();
  var_0 = level.var_EC85["generic"]["patrol_radio_in_clear"];
  self _meth_82E4("radio", var_0, % root, 1);
  scripts\anim\shared::donotetracks("radio");
  func_12942();
}

func_12942() {
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
    func_10B63();
    var_4 = level.var_EC85["generic"]["patrol_turn180"];
    self _meth_82E4("move", var_4, % root, 1);

    if(animhasnotetrack(var_4, "code_move")) {
      scripts\anim\shared::donotetracks("move");
      self orientmode("face motion");
      self animmode("none", 0);
    }

    scripts\anim\shared::donotetracks("move");
  }
}

func_F4C7() {
  if(isDefined(self.script_animation)) {
    if(isDefined(level.var_EC85["generic"]["patrol_walk_" + self.script_animation])) {
      self.var_C9AB = "patrol_walk_" + self.script_animation;
    }

    if(isDefined(level.var_EC85["generic"]["patrol_walk_weights_" + self.script_animation])) {
      self.var_C9AC = "patrol_walk_weights_" + self.script_animation;
    }

    if(isDefined(level.var_EC85["generic"]["patrol_idle_" + self.script_animation])) {
      self.var_C987 = "patrol_idle_" + self.script_animation;
    }
  }

  var_0 = "patrol_walk";

  if(isDefined(self.var_C9AB)) {
    var_0 = self.var_C9AB;
  }

  var_1 = undefined;

  if(isDefined(self.var_C9AC)) {
    var_1 = self.var_C9AC;
  }

  if(isDefined(self.script_animation)) {
    if(isDefined(level.var_EC85["generic"]["patrol_idle_" + self.script_animation])) {
      scripts\sp\utility::func_F3C8("patrol_idle_" + self.script_animation);
    }
  }

  scripts\sp\utility::func_F3CC(var_0, var_1);
}

func_1374A() {
  self endon("end_patrol");

  if(isDefined(self.var_C98C)) {
    self.var_C98C endon("death");
  }

  self waittill("enemy");
}

func_13759() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.var_A8F4)) {
    return;
  }
  self.var_A8F4.var_C97F = undefined;
}

func_13749() {
  self endon("death");
  func_1374A();
  var_0 = scripts\sp\utility::func_65DF("_stealth_enabled") && scripts\sp\utility::func_65DB("_stealth_enabled");
  self.var_EE7E = 0;

  if(isDefined(self.var_C3E8)) {
    self.combatmode = self.var_C3E8;
  }

  if(!var_0) {
    scripts\sp\utility::func_4154();
    self.combatmode = self.var_C3E8;
    scripts\sp\utility::func_417A();
    self allowedstances("stand", "crouch", "prone");
    self.disablearrivals = 0;
    self.var_55ED = 0;
    self givescorefortrophyblocks();
    self notify("stop_animmode");
    self.var_EE56 = undefined;
    self.goalradius = level.var_4FF6;
  }

  if(isDefined(self.var_C3C3)) {
    self.interval = self.var_C3C3;
  }

  self.moveplaybackrate = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.var_A8F4)) {
    return;
  }
  self.var_A8F4.var_C97F = undefined;
}

func_7CD9() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = getEntArray(self.target, "targetname");
  }

  return var_0;
}

func_7CDB() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = getnodearray(self.target, "targetname");
  }

  return var_0;
}

func_7CE0() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
  }

  return var_0;
}

func_7A92() {
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

func_10118(var_0) {
  self endon("release_node");
}

func_AD3A() {
  if(isDefined(self.var_C991)) {
    self.var_C991 thread func_CA83();
    return;
  }

  if(!isDefined(self.var_EE81)) {
    return;
  }
  waittillframeend;
  var_0 = _getaispeciesarray(self.team, "dog");
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2].var_EE81)) {
      continue;
    }
    if(var_0[var_2].var_EE81 != self.var_EE81) {
      continue;
    }
    var_1 = var_0[var_2];
    self.var_C991 = var_1;
    var_1.var_C98C = self;
    break;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread func_CA83();
}

func_CA83() {
  scripts\sp\utility::func_106ED(self);

  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");

  if(isDefined(self.var_EED1)) {
    [[level._meth_83D2["_patrol_endon_spotted_flag"]]]();
  }

  self.var_C98C endon("death");
  thread func_13749();
  self.goalradius = 4;
  self.allowdeath = 1;
  var_0 = func_CA84();
  var_1 = vectornormalize(self.origin - self.var_C98C.origin);
  var_2 = anglestoright(self.var_C98C.angles);
  var_3 = "left";

  if(vectordot(var_1, var_2) > 0) {
    var_3 = "right";
  }

  wait 1;
  thread func_CA86();
  thread func_CA87();
  self.var_C3C3 = self.interval;
  self.interval = 70;

  for(;;) {
    if(isDefined(self.var_C98C) && !isDefined(self.var_C98C.var_C99C)) {
      var_0 = func_CA88(var_0);

      if(var_3 == "null") {
        var_3 = "back";
      }

      var_3 = func_CA85(var_0, var_3);
      self.var_C986 = var_0[var_3].origin;
    } else
      self.var_C986 = self.origin;

    self give_mp_super_weapon(self.var_C986);
    wait 0.05;
  }
}

func_CA84() {
  var_0 = [];
  var_1 = spawnStruct();
  var_1.options = [];
  var_1.options[var_1.options.size] = "right";
  var_1.options[var_1.options.size] = "back_right";
  var_2 = spawnStruct();
  var_2.options = [];
  var_2.options[var_2.options.size] = "right";
  var_2.options[var_2.options.size] = "back_right";
  var_2.options[var_2.options.size] = "back";
  var_3 = spawnStruct();
  var_3.options = [];
  var_3.options[var_3.options.size] = "back_right";
  var_3.options[var_3.options.size] = "back_left";
  var_3.options[var_3.options.size] = "back";
  var_4 = spawnStruct();
  var_4.options = [];
  var_4.options[var_4.options.size] = "left";
  var_4.options[var_4.options.size] = "back_left";
  var_4.options[var_4.options.size] = "back";
  var_5 = spawnStruct();
  var_5.options = [];
  var_5.options[var_5.options.size] = "left";
  var_5.options[var_5.options.size] = "back_left";
  var_6 = spawnStruct();
  var_0["right"] = var_1;
  var_0["left"] = var_5;
  var_0["back_right"] = var_2;
  var_0["back_left"] = var_4;
  var_0["back"] = var_3;
  var_0["null"] = var_6;
  return var_0;
}

func_CA88(var_0) {
  var_1 = vectortoangles(self.var_C98C.var_A8F4.origin - self.var_C98C.origin);
  var_2 = self.var_C98C.origin;
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
    var_0[var_7].checked = 0;
    var_0[var_7].var_DE05 = 0;
  }

  return var_0;
}

func_CA82(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "null") {
      continue;
    }
  }
}

func_CA85(var_0, var_1) {
  var_0[var_1].var_DE05 = 1;

  for(var_2 = 0; var_2 < var_0[var_1].options.size; var_2++) {
    var_3 = var_0[var_1].options[var_2];

    if(var_0[var_3].checked) {
      continue;
    }
    if(self maymovetopoint(var_0[var_3].origin)) {
      return var_3;
    }

    var_0[var_3].checked = 1;
  }

  for(var_2 = 0; var_2 < var_0[var_1].options.size; var_2++) {
    var_3 = var_0[var_1].options[var_2];

    if(var_0[var_3].var_DE05) {
      continue;
    }
    var_3 = func_CA85(var_0, var_3);
    return var_3;
  }

  return "null";
}

func_CA86(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.var_C98C endon("death");

  if(isDefined(self.var_C98C.script_noteworthy) && self.var_C98C.script_noteworthy == "cqb_patrol") {
    scripts\sp\utility::func_F35F();
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 200;
  }

  scripts\sp\utility::func_F35F();

  for(;;) {
    wait 0.1;
    var_1 = self.var_C986;
    var_2 = distancesquared(self.origin, self.var_C986);

    if(var_2 > squared(var_0)) {
      if(self.a.movement == "run") {
        continue;
      }
      scripts\sp\anim::func_1EC8(self, "gravity", "patrol_dog_start");
      scripts\sp\utility::func_417A();
      self.var_EE56 = 1;
      continue;
    }

    if(self.a.movement != "walk") {
      self notify("stopped_while_patrolling");
      scripts\sp\anim::func_1EC8(self, "gravity", "patrol_dog_stop");
      scripts\sp\utility::func_F35F();
    }
  }
}

func_CA87(var_0, var_1) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.var_C98C endon("death");

  if(isDefined(self.var_C98C.script_noteworthy) && self.var_C98C.script_noteworthy == "cqb_patrol") {
    for(;;) {
      wait 0.05;
      var_2 = self.var_C986;
      var_3 = distancesquared(self.origin, self.var_C986);

      if(var_3 < squared(16)) {
        if(self.moveplaybackrate > 0.4) {
          self.moveplaybackrate = self.moveplaybackrate - 0.05;
        }

        continue;
      }

      if(var_3 > squared(48)) {
        if(self.moveplaybackrate < 1.8) {
          self.moveplaybackrate = self.moveplaybackrate + 0.05;
        }

        continue;
      }

      self.moveplaybackrate = 1;
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
    var_2 = self.var_C986;
    var_3 = distancesquared(self.origin, self.var_C986);

    if(self.a.movement != "walk") {
      self.moveplaybackrate = 1;
      continue;
    }

    if(var_3 < var_4) {
      if(self.moveplaybackrate > 0.4) {
        self.moveplaybackrate = self.moveplaybackrate - 0.05;
      }

      continue;
    }

    if(var_3 > var_5) {
      if(self.moveplaybackrate < 0.75) {
        self.moveplaybackrate = self.moveplaybackrate + 0.05;
      }

      continue;
    }

    self.moveplaybackrate = 0.5;
  }
}

func_8BA5() {
  if(isDefined(self.script_delay) || isDefined(self.script_delay_min)) {
    return 1;
  }

  return 0;
}

func_ED4E() {
  if(isDefined(self.script_delay)) {
    return self.script_delay > 0.5;
  }

  if(isDefined(self.script_delay_min)) {
    return self.script_delay_min > 0.5;
  }

  return 0;
}