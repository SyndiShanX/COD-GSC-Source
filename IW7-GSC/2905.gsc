/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2905.gsc
***************************************/

func_C97C(var_00) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("damage");
  self endon("end_patrol");
  self endon("dog_attacks_ai");
  waittillframeend;

  if(isDefined(self.func_EED1))
    [[level._meth_83D2["_patrol_endon_spotted_flag"]]]();

  thread func_13749();
  thread func_13759();
  self.goalradius = 32;
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.func_55ED = 1;
  self.allowdeath = 1;
  self.func_EE7E = 1;
  self.func_C3E8 = self.combatmode;
  self.combatmode = "no_cover";
  scripts\sp\utility::func_5514();

  if(isDefined(self.func_EE2C)) {
    self.func_C3FA = self.moveplaybackrate;
    self.moveplaybackrate = self.func_EE2C;
  }

  func_AD3A();
  func_F4C7();
  var_1["ent"][1] = ::func_7CD9;
  var_1["ent"][0] = scripts\sp\utility::func_7A8F;
  var_1["node"][1] = ::func_7CDB;
  var_1["node"][0] = ::func_7A92;
  var_1["struct"][1] = ::func_7CE0;
  var_1["struct"][0] = scripts\sp\utility::func_7A97;
  var_2["ent"] = scripts\sp\utility::func_F3D3;
  var_2["node"] = scripts\sp\utility::func_F3D9;
  var_2["struct"] = scripts\sp\utility::func_F3D3;

  if(isDefined(var_00))
    self.target = var_00;

  if(isDefined(self.target)) {
    var_03 = 1;
    var_04 = func_7CD9();
    var_05 = func_7CDB();
    var_06 = func_7CE0();

    if(var_4.size) {
      var_07 = scripts\engine\utility::random(var_04);
      var_08 = "ent";
    } else if(var_5.size) {
      var_07 = scripts\engine\utility::random(var_05);
      var_08 = "node";
    } else {
      var_07 = scripts\engine\utility::random(var_06);
      var_08 = "struct";
    }
  } else {
    var_03 = 0;
    var_04 = scripts\sp\utility::func_7A8F();
    var_05 = func_7A92();
    var_06 = scripts\sp\utility::func_7A97();

    if(var_4.size) {
      var_07 = scripts\engine\utility::random(var_04);
      var_08 = "ent";
    } else if(var_5.size) {
      var_07 = scripts\engine\utility::random(var_05);
      var_08 = "node";
    } else {
      var_07 = scripts\engine\utility::random(var_06);
      var_08 = "struct";
    }
  }

  var_09 = [];
  var_9["pause"] = "patrol_idle_";
  var_9["turn180"] = scripts\engine\utility::ter_op(isDefined(self.func_C97E), self.func_C97E, "patrol_turn180");
  var_9["smoke"] = "patrol_idle_smoke";
  var_9["stretch"] = "patrol_idle_stretch";
  var_9["checkphone"] = "patrol_idle_checkphone";
  var_9["phone"] = "patrol_idle_phone";
  var_10 = var_07;

  for(;;) {
    while(isDefined(var_10.func_C97F))
      wait 0.05;

    var_7.func_C97F = undefined;
    var_07 = var_10;
    self notify("release_node");
    var_7.func_C97F = 1;
    self.func_A8F4 = var_07;
    [[var_2[var_08]]](var_07);

    if(isDefined(var_7.radius) && var_7.radius > 0)
      self.goalradius = var_7.radius;
    else
      self.goalradius = 32;

    self waittill("goal");
    var_07 notify("trigger", self);

    if(isDefined(var_7.func_ED9E))
      scripts\engine\utility::flag_set(var_7.func_ED9E);

    if(isDefined(var_7.func_ED80))
      scripts\sp\utility::func_65E1(var_7.func_ED80);

    if(isDefined(var_7.func_ED9B))
      scripts\engine\utility::flag_clear(var_7.func_ED9B);

    var_11 = var_07[[var_1[var_08][var_03]]]();

    if(!var_11.size) {
      if(isDefined(var_7.func_ED88))
        self orientmode("face angle", var_7.angles[1]);

      self notify("reached_path_end");
      self notify("_patrol_reached_path_end");

      if(isalive(self.func_C991))
        self.func_C991 notify("master_reached_patrol_end");
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
              self.func_C9AB = undefined;
              self.func_C9AC = undefined;
              self.func_C987 = undefined;
            }

            func_F4C7();
        }
      }
    }

    if(isDefined(var_7.func_EE2C))
      self.moveplaybackrate = var_7.func_EE2C;

    if(var_07 func_8BA5() && var_07 func_ED4E() || isDefined(var_13) || isDefined(var_7.func_EDA0) && !scripts\engine\utility::flag(var_7.func_EDA0)) {
      if(!isDefined(self.func_C98F) && var_14)
        func_C981(var_13, var_12, var_07);

      if(isDefined(var_7.func_EDA0) && !scripts\engine\utility::flag(var_7.func_EDA0))
        scripts\engine\utility::flag_wait(var_7.func_EDA0);

      var_07 scripts\sp\utility::script_delay();

      if(isDefined(var_13)) {
        if(isDefined(var_7.func_ED88))
          self orientmode("face angle", var_7.angles[1]);

        self.func_C99C = 1;
        var_18 = var_9[var_13];

        if(!isDefined(var_18)) {
          if(isDefined(level.func_C99E))
            var_18 = level.func_C99E[var_13];
        }

        if(isDefined(var_18)) {
          if(var_13 == "pause") {
            if(isDefined(self.func_C99D) && isDefined(self.func_C99D[var_13]))
              var_18 = self.func_C99D[var_13][randomint(self.func_C99D[var_13].size)];
            else
              var_18 = var_18 + randomintrange(1, 6);
          }

          if(var_15) {
            var_07 scripts\sp\anim::func_1ECE(self, var_18);
            var_07 scripts\sp\anim::func_1EC8(self, "gravity", var_18, undefined, var_12);
          } else
            scripts\sp\anim::func_1EC8(self, "gravity", var_18, undefined, var_12);
        }

        self.func_C99C = undefined;
      }

      if(var_11.size && (!isDefined(var_13) || var_13 != "turn180") && var_14 && (!isDefined(self.func_1025F) || !self.func_1025F))
        func_C980(var_13, var_12);
    }

    if(!var_11.size) {
      if(isDefined(self.func_C982) && !isDefined(var_13)) {
        func_C981("path_end_idle", var_12, var_07);

        for(;;) {
          var_19 = self.func_C982[randomint(self.func_C982.size)];
          scripts\sp\anim::func_1EC8(self, "gravity", var_19, undefined, var_12);
        }
      }

      break;
    }

    var_10 = scripts\engine\utility::random(var_11);
  }
}

func_C981(var_00, var_01, var_02) {
  var_03 = self;
  var_04 = 0;

  if(isDefined(var_2.func_ED88)) {
    var_03 = var_02;
    self.func_C0C1 = 1;
    var_04 = 1;
  }

  if(isDefined(self.func_C9A7) && isDefined(self.func_C9A7[var_00]))
    var_03 scripts\sp\anim::func_1EC8(self, "gravity", self.func_C9A7[var_00], undefined, var_01, var_04);
  else if(isDefined(self.script_animation) && isDefined(level.func_EC85["generic"]["patrol_stop_" + self.script_animation]))
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop_" + self.script_animation, undefined, var_01);
  else
    var_03 scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop", undefined, var_01, var_04);
}

func_C980(var_00, var_01) {
  if(isDefined(self.func_C9A3) && isDefined(self.func_C9A3[var_00]))
    scripts\sp\anim::func_1EC8(self, "gravity", self.func_C9A3[var_00], undefined, var_01);
  else if(isDefined(self.script_animation) && isDefined(level.func_EC85["generic"]["patrol_start_" + self.script_animation]))
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start_" + self.script_animation, undefined, var_01);
  else
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start", undefined, var_01);
}

#using_animtree("generic_human");

func_10B63() {
  if(self.a.pose == "crouch" && isDefined(self.a.func_2274)) {
    var_00 = self.a.func_2274["stance_change"];

    if(isDefined(var_00)) {
      self _meth_82E4("stand_up", var_00, % root, 1);
      scripts\anim\shared::donotetracks("stand_up");
    }
  }
}

func_C99B() {
  self endon("enemy");
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  func_10B63();
  var_00 = level.func_EC85["generic"]["patrol_radio_in_clear"];
  self _meth_82E4("radio", var_00, % root, 1);
  scripts\anim\shared::donotetracks("radio");
  func_12942();
}

func_12942() {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }
  var_00 = self.pathgoalpos;
  var_01 = var_00 - self.origin;
  var_01 = (var_1[0], var_1[1], 0);
  var_02 = lengthsquared(var_01);

  if(var_02 < 1) {
    return;
  }
  var_01 = var_01 / sqrt(var_02);
  var_03 = anglesToForward(self.angles);

  if(vectordot(var_03, var_01) < -0.5) {
    self animmode("zonly_physics", 0);
    self orientmode("face current");
    func_10B63();
    var_04 = level.func_EC85["generic"]["patrol_turn180"];
    self _meth_82E4("move", var_04, % root, 1);

    if(animhasnotetrack(var_04, "code_move")) {
      scripts\anim\shared::donotetracks("move");
      self orientmode("face motion");
      self animmode("none", 0);
    }

    scripts\anim\shared::donotetracks("move");
  }
}

func_F4C7() {
  if(isDefined(self.script_animation)) {
    if(isDefined(level.func_EC85["generic"]["patrol_walk_" + self.script_animation]))
      self.func_C9AB = "patrol_walk_" + self.script_animation;

    if(isDefined(level.func_EC85["generic"]["patrol_walk_weights_" + self.script_animation]))
      self.func_C9AC = "patrol_walk_weights_" + self.script_animation;

    if(isDefined(level.func_EC85["generic"]["patrol_idle_" + self.script_animation]))
      self.func_C987 = "patrol_idle_" + self.script_animation;
  }

  var_00 = "patrol_walk";

  if(isDefined(self.func_C9AB))
    var_00 = self.func_C9AB;

  var_01 = undefined;

  if(isDefined(self.func_C9AC))
    var_01 = self.func_C9AC;

  if(isDefined(self.script_animation)) {
    if(isDefined(level.func_EC85["generic"]["patrol_idle_" + self.script_animation]))
      scripts\sp\utility::func_F3C8("patrol_idle_" + self.script_animation);
  }

  scripts\sp\utility::func_F3CC(var_00, var_01);
}

func_1374A() {
  self endon("end_patrol");

  if(isDefined(self.func_C98C))
    self.func_C98C endon("death");

  self waittill("enemy");
}

func_13759() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.func_A8F4)) {
    return;
  }
  self.func_A8F4.func_C97F = undefined;
}

func_13749() {
  self endon("death");
  func_1374A();
  var_00 = scripts\sp\utility::func_65DF("_stealth_enabled") && scripts\sp\utility::func_65DB("_stealth_enabled");
  self.func_EE7E = 0;

  if(isDefined(self.func_C3E8))
    self.combatmode = self.func_C3E8;

  if(!var_00) {
    scripts\sp\utility::func_4154();
    self.combatmode = self.func_C3E8;
    scripts\sp\utility::func_417A();
    self allowedstances("stand", "crouch", "prone");
    self.disablearrivals = 0;
    self.func_55ED = 0;
    self givescorefortrophyblocks();
    self notify("stop_animmode");
    self.func_EE56 = undefined;
    self.goalradius = level.func_4FF6;
  }

  if(isDefined(self.func_C3C3))
    self.interval = self.func_C3C3;

  self.moveplaybackrate = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.func_A8F4)) {
    return;
  }
  self.func_A8F4.func_C97F = undefined;
}

func_7CD9() {
  var_00 = [];

  if(isDefined(self.target))
    var_00 = getEntArray(self.target, "targetname");

  return var_00;
}

func_7CDB() {
  var_00 = [];

  if(isDefined(self.target))
    var_00 = getnodearray(self.target, "targetname");

  return var_00;
}

func_7CE0() {
  var_00 = [];

  if(isDefined(self.target))
    var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");

  return var_00;
}

func_7A92() {
  var_00 = [];

  if(isDefined(self.script_linkto)) {
    var_01 = strtok(self.script_linkto, " ");

    for(var_02 = 0; var_02 < var_1.size; var_2++) {
      var_03 = getnode(var_1[var_02], "script_linkname");

      if(isDefined(var_03))
        var_0[var_0.size] = var_03;
    }
  }

  return var_00;
}

func_10118(var_00) {
  self endon("release_node");
}

func_AD3A() {
  if(isDefined(self.func_C991)) {
    self.func_C991 thread func_CA83();
    return;
  }

  if(!isDefined(self.func_EE81)) {
    return;
  }
  waittillframeend;
  var_00 = _getaispeciesarray(self.team, "dog");
  var_01 = undefined;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_02].func_EE81)) {
      continue;
    }
    if(var_0[var_02].func_EE81 != self.func_EE81) {
      continue;
    }
    var_01 = var_0[var_02];
    self.func_C991 = var_01;
    var_1.func_C98C = self;
    break;
  }

  if(!isDefined(var_01)) {
    return;
  }
  var_01 thread func_CA83();
}

func_CA83() {
  scripts\sp\utility::func_106ED(self);

  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");

  if(isDefined(self.func_EED1))
    [[level._meth_83D2["_patrol_endon_spotted_flag"]]]();

  self.func_C98C endon("death");
  thread func_13749();
  self.goalradius = 4;
  self.allowdeath = 1;
  var_00 = func_CA84();
  var_01 = vectornormalize(self.origin - self.func_C98C.origin);
  var_02 = anglestoright(self.func_C98C.angles);
  var_03 = "left";

  if(vectordot(var_01, var_02) > 0)
    var_03 = "right";

  wait 1;
  thread func_CA86();
  thread func_CA87();
  self.func_C3C3 = self.interval;
  self.interval = 70;

  for(;;) {
    if(isDefined(self.func_C98C) && !isDefined(self.func_C98C.func_C99C)) {
      var_00 = func_CA88(var_00);

      if(var_03 == "null")
        var_03 = "back";

      var_03 = func_CA85(var_00, var_03);
      self.func_C986 = var_0[var_03].origin;
    } else
      self.func_C986 = self.origin;

    self give_mp_super_weapon(self.func_C986);
    wait 0.05;
  }
}

func_CA84() {
  var_00 = [];
  var_01 = spawnStruct();
  var_1.options = [];
  var_1.options[var_1.options.size] = "right";
  var_1.options[var_1.options.size] = "back_right";
  var_02 = spawnStruct();
  var_2.options = [];
  var_2.options[var_2.options.size] = "right";
  var_2.options[var_2.options.size] = "back_right";
  var_2.options[var_2.options.size] = "back";
  var_03 = spawnStruct();
  var_3.options = [];
  var_3.options[var_3.options.size] = "back_right";
  var_3.options[var_3.options.size] = "back_left";
  var_3.options[var_3.options.size] = "back";
  var_04 = spawnStruct();
  var_4.options = [];
  var_4.options[var_4.options.size] = "left";
  var_4.options[var_4.options.size] = "back_left";
  var_4.options[var_4.options.size] = "back";
  var_05 = spawnStruct();
  var_5.options = [];
  var_5.options[var_5.options.size] = "left";
  var_5.options[var_5.options.size] = "back_left";
  var_06 = spawnStruct();
  var_0["right"] = var_01;
  var_0["left"] = var_05;
  var_0["back_right"] = var_02;
  var_0["back_left"] = var_04;
  var_0["back"] = var_03;
  var_0["null"] = var_06;
  return var_00;
}

func_CA88(var_00) {
  var_01 = vectortoangles(self.func_C98C.func_A8F4.origin - self.func_C98C.origin);
  var_02 = self.func_C98C.origin;
  var_03 = anglestoright(var_01);
  var_04 = anglesToForward(var_01);
  var_0["right"].origin = var_02 + var_03 * 40 + var_04 * 30;
  var_0["left"].origin = var_02 + var_03 * -40 + var_04 * 30;
  var_0["back_right"].origin = var_02 + var_03 * 32 + var_04 * -16;
  var_0["back_left"].origin = var_02 + var_03 * -32 + var_04 * -16;
  var_0["back"].origin = var_02 + var_04 * -48;
  var_0["null"].origin = self.origin;
  var_05 = getarraykeys(var_00);

  for(var_06 = 0; var_06 < var_5.size; var_6++) {
    var_07 = var_5[var_06];
    var_0[var_07].checked = 0;
    var_0[var_07].func_DE05 = 0;
  }

  return var_00;
}

func_CA82(var_00) {
  var_01 = getarraykeys(var_00);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = var_1[var_02];

    if(var_03 == "null")
      continue;
  }
}

func_CA85(var_00, var_01) {
  var_0[var_01].func_DE05 = 1;

  for(var_02 = 0; var_02 < var_0[var_01].options.size; var_2++) {
    var_03 = var_0[var_01].options[var_02];

    if(var_0[var_03].checked) {
      continue;
    }
    if(self maymovetopoint(var_0[var_03].origin))
      return var_03;

    var_0[var_03].checked = 1;
  }

  for(var_02 = 0; var_02 < var_0[var_01].options.size; var_2++) {
    var_03 = var_0[var_01].options[var_02];

    if(var_0[var_03].func_DE05) {
      continue;
    }
    var_03 = func_CA85(var_00, var_03);
    return var_03;
  }

  return "null";
}

func_CA86(var_00) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.func_C98C endon("death");

  if(isDefined(self.func_C98C.script_noteworthy) && self.func_C98C.script_noteworthy == "cqb_patrol") {
    scripts\sp\utility::func_F35F();
    return;
  }

  if(!isDefined(var_00))
    var_00 = 200;

  scripts\sp\utility::func_F35F();

  for(;;) {
    wait 0.1;
    var_01 = self.func_C986;
    var_02 = distancesquared(self.origin, self.func_C986);

    if(var_02 > squared(var_00)) {
      if(self.a.movement == "run") {
        continue;
      }
      scripts\sp\anim::func_1EC8(self, "gravity", "patrol_dog_start");
      scripts\sp\utility::func_417A();
      self.func_EE56 = 1;
      continue;
    }

    if(self.a.movement != "walk") {
      self notify("stopped_while_patrolling");
      scripts\sp\anim::func_1EC8(self, "gravity", "patrol_dog_stop");
      scripts\sp\utility::func_F35F();
    }
  }
}

func_CA87(var_00, var_01) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.func_C98C endon("death");

  if(isDefined(self.func_C98C.script_noteworthy) && self.func_C98C.script_noteworthy == "cqb_patrol") {
    for(;;) {
      wait 0.05;
      var_02 = self.func_C986;
      var_03 = distancesquared(self.origin, self.func_C986);

      if(var_03 < squared(16)) {
        if(self.moveplaybackrate > 0.4)
          self.moveplaybackrate = self.moveplaybackrate - 0.05;

        continue;
      }

      if(var_03 > squared(48)) {
        if(self.moveplaybackrate < 1.8)
          self.moveplaybackrate = self.moveplaybackrate + 0.05;

        continue;
      }

      self.moveplaybackrate = 1;
    }
  }

  if(!isDefined(var_00))
    var_00 = 16;

  if(!isDefined(var_01))
    var_01 = 48;

  var_04 = var_00 * var_00;
  var_05 = var_01 * var_01;

  for(;;) {
    wait 0.05;
    var_02 = self.func_C986;
    var_03 = distancesquared(self.origin, self.func_C986);

    if(self.a.movement != "walk") {
      self.moveplaybackrate = 1;
      continue;
    }

    if(var_03 < var_04) {
      if(self.moveplaybackrate > 0.4)
        self.moveplaybackrate = self.moveplaybackrate - 0.05;

      continue;
    }

    if(var_03 > var_05) {
      if(self.moveplaybackrate < 0.75)
        self.moveplaybackrate = self.moveplaybackrate + 0.05;

      continue;
    }

    self.moveplaybackrate = 0.5;
  }
}

func_8BA5() {
  if(isDefined(self.script_delay) || isDefined(self.script_delay_min))
    return 1;

  return 0;
}

func_ED4E() {
  if(isDefined(self.script_delay))
    return self.script_delay > 0.5;

  if(isDefined(self.script_delay_min))
    return self.script_delay_min > 0.5;

  return 0;
}