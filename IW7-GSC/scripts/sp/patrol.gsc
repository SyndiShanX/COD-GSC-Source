/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\patrol.gsc
*********************************/

func_C97C(param_00) {
  if(isDefined(self.isnodeoccupied)) {
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
  self.objective_playermask_showto = 32;
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.var_55ED = 1;
  self.var_30 = 1;
  self.var_EE7E = 1;
  self.var_C3E8 = self.var_BC;
  self.var_BC = "no_cover";
  scripts\sp\utility::func_5514();
  if(isDefined(self.var_EE2C)) {
    self.var_C3FA = self.moveplaybackrate;
    self.moveplaybackrate = self.var_EE2C;
  }

  func_AD3A();
  func_F4C7();
  var_01["ent"][1] = ::func_7CD9;
  var_01["ent"][0] = ::scripts\sp\utility::func_7A8F;
  var_01["node"][1] = ::func_7CDB;
  var_01["node"][0] = ::func_7A92;
  var_01["struct"][1] = ::func_7CE0;
  var_01["struct"][0] = ::scripts\sp\utility::func_7A97;
  var_02["ent"] = ::scripts\sp\utility::func_F3D3;
  var_02["node"] = ::scripts\sp\utility::func_F3D9;
  var_02["struct"] = ::scripts\sp\utility::func_F3D3;
  if(isDefined(param_00)) {
    self.target = param_00;
  }

  if(isDefined(self.target)) {
    var_03 = 1;
    var_04 = func_7CD9();
    var_05 = func_7CDB();
    var_06 = func_7CE0();
    if(var_04.size) {
      var_07 = scripts\engine\utility::random(var_04);
      var_08 = "ent";
    } else if(var_07.size) {
      var_07 = scripts\engine\utility::random(var_07);
      var_08 = "node";
    } else {
      var_07 = scripts\engine\utility::random(var_08);
      var_08 = "struct";
    }
  } else {
    var_03 = 0;
    var_04 = scripts\sp\utility::func_7A8F();
    var_05 = func_7A92();
    var_06 = scripts\sp\utility::func_7A97();
    if(var_06.size) {
      var_07 = scripts\engine\utility::random(var_06);
      var_08 = "ent";
    } else if(var_07.size) {
      var_07 = scripts\engine\utility::random(var_07);
      var_08 = "node";
    } else {
      var_07 = scripts\engine\utility::random(var_08);
      var_08 = "struct";
    }
  }

  var_09 = [];
  var_09["pause"] = "patrol_idle_";
  var_09["turn180"] = scripts\engine\utility::ter_op(isDefined(self.var_C97E), self.var_C97E, "patrol_turn180");
  var_09["smoke"] = "patrol_idle_smoke";
  var_09["stretch"] = "patrol_idle_stretch";
  var_09["checkphone"] = "patrol_idle_checkphone";
  var_09["phone"] = "patrol_idle_phone";
  var_0A = var_07;
  for(;;) {
    while(isDefined(var_0A.var_C97F)) {
      wait(0.05);
    }

    var_07.var_C97F = undefined;
    var_07 = var_0A;
    self notify("release_node");
    var_07.var_C97F = 1;
    self.var_A8F4 = var_07;
    [[var_02[var_08]]](var_07);
    if(isDefined(var_07.fgetarg) && var_07.fgetarg > 0) {
      self.objective_playermask_showto = var_07.fgetarg;
    } else {
      self.objective_playermask_showto = 32;
    }

    self waittill("goal");
    var_07 notify("trigger", self);
    if(isDefined(var_07.var_ED9E)) {
      scripts\engine\utility::flag_set(var_07.var_ED9E);
    }

    if(isDefined(var_07.var_ED80)) {
      scripts\sp\utility::func_65E1(var_07.var_ED80);
    }

    if(isDefined(var_07.var_ED9B)) {
      scripts\engine\utility::flag_clear(var_07.var_ED9B);
    }

    var_0B = var_07[[var_01[var_08][var_03]]]();
    if(!var_0B.size) {
      if(isDefined(var_07.var_ED88)) {
        self orientmode("face angle", var_07.angles[1]);
      }

      self notify("reached_path_end");
      self notify("_patrol_reached_path_end");
      if(isalive(self.var_C991)) {
        self.var_C991 notify("master_reached_patrol_end");
      }
    }

    var_0C = ::scripts\anim\reactions::func_DD51;
    var_0D = var_07.script_animation;
    var_0E = 1;
    var_0F = 0;
    if(isDefined(var_07.script_parameters)) {
      var_10 = strtok(var_07.script_parameters, " ");
      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        switch (var_10[var_11]) {
          case "keep_running":
            var_0E = 0;
            break;

          case "use_node":
            var_0F = 1;
            break;

          case "animset":
            var_11 = var_11 + 1;
            self.script_animation = var_10[var_11];
            if(self.script_animation == "default") {
              self.script_animation = undefined;
              self.var_C9AB = undefined;
              self.var_C9AC = undefined;
              self.var_C987 = undefined;
            }
            func_F4C7();
            break;
        }
      }
    }

    if(isDefined(var_07.var_EE2C)) {
      self.moveplaybackrate = var_07.var_EE2C;
    }

    if((var_07 func_8BA5() && var_07 func_ED4E()) || isDefined(var_0D) || isDefined(var_07.var_EDA0) && !scripts\engine\utility::flag(var_07.var_EDA0)) {
      if(!isDefined(self.var_C98F) && var_0E) {
        func_C981(var_0D, var_0C, var_07);
      }

      if(isDefined(var_07.var_EDA0) && !scripts\engine\utility::flag(var_07.var_EDA0)) {
        scripts\engine\utility::flag_wait(var_07.var_EDA0);
      }

      var_07 scripts\sp\utility::script_delay();
      if(isDefined(var_0D)) {
        if(isDefined(var_07.var_ED88)) {
          self orientmode("face angle", var_07.angles[1]);
        }

        self.var_C99C = 1;
        var_12 = var_09[var_0D];
        if(!isDefined(var_12)) {
          if(isDefined(level.var_C99E)) {
            var_12 = level.var_C99E[var_0D];
          }
        }

        if(isDefined(var_12)) {
          if(var_0D == "pause") {
            if(isDefined(self.var_C99D) && isDefined(self.var_C99D[var_0D])) {
              var_12 = self.var_C99D[var_0D][randomint(self.var_C99D[var_0D].size)];
            } else {
              var_12 = var_12 + randomintrange(1, 6);
            }
          }

          if(var_0F) {
            var_07 scripts\sp\anim::func_1ECE(self, var_12);
            var_07 scripts\sp\anim::func_1EC8(self, "gravity", var_12, undefined, var_0C);
          } else {
            scripts\sp\anim::func_1EC8(self, "gravity", var_12, undefined, var_0C);
          }
        }

        self.var_C99C = undefined;
      }

      if(var_0B.size && !isDefined(var_0D) || var_0D != "turn180" && var_0E && !isDefined(self.var_1025F) || !self.var_1025F) {
        func_C980(var_0D, var_0C);
      }
    }

    if(!var_0B.size) {
      if(isDefined(self.var_C982) && !isDefined(var_0D)) {
        func_C981("path_end_idle", var_0C, var_07);
        for(;;) {
          var_13 = self.var_C982[randomint(self.var_C982.size)];
          scripts\sp\anim::func_1EC8(self, "gravity", var_13, undefined, var_0C);
        }
      }

      break;
    }

    var_0A = scripts\engine\utility::random(var_0B);
  }
}

func_C981(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = 0;
  if(isDefined(param_02.var_ED88)) {
    var_03 = param_02;
    self.var_C0C1 = 1;
    var_04 = 1;
  }

  if(isDefined(self.var_C9A7) && isDefined(self.var_C9A7[param_00])) {
    var_03 scripts\sp\anim::func_1EC8(self, "gravity", self.var_C9A7[param_00], undefined, param_01, var_04);
    return;
  }

  if(isDefined(self.script_animation) && isDefined(level.var_EC85["generic"]["patrol_stop_" + self.script_animation])) {
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop_" + self.script_animation, undefined, param_01);
    return;
  }

  var_03 scripts\sp\anim::func_1EC8(self, "gravity", "patrol_stop", undefined, param_01, var_04);
}

func_C980(param_00, param_01) {
  if(isDefined(self.var_C9A3) && isDefined(self.var_C9A3[param_00])) {
    scripts\sp\anim::func_1EC8(self, "gravity", self.var_C9A3[param_00], undefined, param_01);
    return;
  }

  if(isDefined(self.script_animation) && isDefined(level.var_EC85["generic"]["patrol_start_" + self.script_animation])) {
    scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start_" + self.script_animation, undefined, param_01);
    return;
  }

  scripts\sp\anim::func_1EC8(self, "gravity", "patrol_start", undefined, param_01);
}

func_10B63() {
  if(self.a.pose == "crouch" && isDefined(self.a.var_2274)) {
    var_00 = self.a.var_2274["stance_change"];
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
  var_00 = level.var_EC85["generic"]["patrol_radio_in_clear"];
  self _meth_82E4("radio", var_00, % root, 1);
  scripts\anim\shared::donotetracks("radio");
  func_12942();
}

func_12942() {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return;
  }

  var_00 = self.vehicle_getspawnerarray;
  var_01 = var_00 - self.origin;
  var_01 = (var_01[0], var_01[1], 0);
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
    var_04 = level.var_EC85["generic"]["patrol_turn180"];
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

  var_00 = "patrol_walk";
  if(isDefined(self.var_C9AB)) {
    var_00 = self.var_C9AB;
  }

  var_01 = undefined;
  if(isDefined(self.var_C9AC)) {
    var_01 = self.var_C9AC;
  }

  if(isDefined(self.script_animation)) {
    if(isDefined(level.var_EC85["generic"]["patrol_idle_" + self.script_animation])) {
      scripts\sp\utility::func_F3C8("patrol_idle_" + self.script_animation);
    }
  }

  scripts\sp\utility::func_F3CC(var_00, var_01);
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
  var_00 = scripts\sp\utility::func_65DF("_stealth_enabled") && scripts\sp\utility::func_65DB("_stealth_enabled");
  self.var_EE7E = 0;
  if(isDefined(self.var_C3E8)) {
    self.var_BC = self.var_C3E8;
  }

  if(!var_00) {
    scripts\sp\utility::func_4154();
    self.var_BC = self.var_C3E8;
    scripts\sp\utility::func_417A();
    self allowedstances("stand", "crouch", "prone");
    self.disablearrivals = 0;
    self.var_55ED = 0;
    self givescorefortrophyblocks();
    self notify("stop_animmode");
    self.var_EE56 = undefined;
    self.objective_playermask_showto = level.var_4FF6;
  }

  if(isDefined(self.var_C3C3)) {
    self.queuedialog = self.var_C3C3;
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
  var_00 = [];
  if(isDefined(self.target)) {
    var_00 = getEntArray(self.target, "targetname");
  }

  return var_00;
}

func_7CDB() {
  var_00 = [];
  if(isDefined(self.target)) {
    var_00 = getnodearray(self.target, "targetname");
  }

  return var_00;
}

func_7CE0() {
  var_00 = [];
  if(isDefined(self.target)) {
    var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  }

  return var_00;
}

func_7A92() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = strtok(self.script_linkto, " ");
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = getnode(var_01[var_02], "script_linkname");
      if(isDefined(var_03)) {
        var_00[var_00.size] = var_03;
      }
    }
  }

  return var_00;
}

func_10118(param_00) {
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
  var_00 = getaispeciesarray(self.team, "dog");
  var_01 = undefined;
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(!isDefined(var_00[var_02].var_EE81)) {
      continue;
    }

    if(var_00[var_02].var_EE81 != self.var_EE81) {
      continue;
    }

    var_01 = var_00[var_02];
    self.var_C991 = var_01;
    var_01.var_C98C = self;
    break;
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_01 thread func_CA83();
}

func_CA83() {
  scripts\sp\utility::func_106ED(self);
  if(isDefined(self.isnodeoccupied)) {
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
  self.objective_playermask_showto = 4;
  self.var_30 = 1;
  var_00 = func_CA84();
  var_01 = vectornormalize(self.origin - self.var_C98C.origin);
  var_02 = anglestoright(self.var_C98C.angles);
  var_03 = "left";
  if(vectordot(var_01, var_02) > 0) {
    var_03 = "right";
  }

  wait(1);
  thread func_CA86();
  thread func_CA87();
  self.var_C3C3 = self.queuedialog;
  self.queuedialog = 70;
  for(;;) {
    if(isDefined(self.var_C98C) && !isDefined(self.var_C98C.var_C99C)) {
      var_00 = func_CA88(var_00);
      if(var_03 == "null") {
        var_03 = "back";
      }

      var_03 = func_CA85(var_00, var_03);
      self.var_C986 = var_00[var_03].origin;
    } else {
      self.var_C986 = self.origin;
    }

    self give_mp_super_weapon(self.var_C986);
    wait(0.05);
  }
}

func_CA84() {
  var_00 = [];
  var_01 = spawnStruct();
  var_01.options = [];
  var_01.options[var_01.options.size] = "right";
  var_01.options[var_01.options.size] = "back_right";
  var_02 = spawnStruct();
  var_02.options = [];
  var_02.options[var_02.options.size] = "right";
  var_02.options[var_02.options.size] = "back_right";
  var_02.options[var_02.options.size] = "back";
  var_03 = spawnStruct();
  var_03.options = [];
  var_03.options[var_03.options.size] = "back_right";
  var_03.options[var_03.options.size] = "back_left";
  var_03.options[var_03.options.size] = "back";
  var_04 = spawnStruct();
  var_04.options = [];
  var_04.options[var_04.options.size] = "left";
  var_04.options[var_04.options.size] = "back_left";
  var_04.options[var_04.options.size] = "back";
  var_05 = spawnStruct();
  var_05.options = [];
  var_05.options[var_05.options.size] = "left";
  var_05.options[var_05.options.size] = "back_left";
  var_06 = spawnStruct();
  var_00["right"] = var_01;
  var_00["left"] = var_05;
  var_00["back_right"] = var_02;
  var_00["back_left"] = var_04;
  var_00["back"] = var_03;
  var_00["null"] = var_06;
  return var_00;
}

func_CA88(param_00) {
  var_01 = vectortoangles(self.var_C98C.var_A8F4.origin - self.var_C98C.origin);
  var_02 = self.var_C98C.origin;
  var_03 = anglestoright(var_01);
  var_04 = anglesToForward(var_01);
  param_00["right"].origin = var_02 + var_03 * 40 + var_04 * 30;
  param_00["left"].origin = var_02 + var_03 * -40 + var_04 * 30;
  param_00["back_right"].origin = var_02 + var_03 * 32 + var_04 * -16;
  param_00["back_left"].origin = var_02 + var_03 * -32 + var_04 * -16;
  param_00["back"].origin = var_02 + var_04 * -48;
  param_00["null"].origin = self.origin;
  var_05 = getarraykeys(param_00);
  for(var_06 = 0; var_06 < var_05.size; var_06++) {
    var_07 = var_05[var_06];
    param_00[var_07].checked = 0;
    param_00[var_07].var_DE05 = 0;
  }

  return param_00;
}

func_CA82(param_00) {
  var_01 = getarraykeys(param_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(var_03 == "null") {
      continue;
    }
  }
}

func_CA85(param_00, param_01) {
  param_00[param_01].var_DE05 = 1;
  for(var_02 = 0; var_02 < param_00[param_01].options.size; var_02++) {
    var_03 = param_00[param_01].options[var_02];
    if(param_00[var_03].checked) {
      continue;
    }

    if(self maymovetopoint(param_00[var_03].origin)) {
      return var_03;
    }

    param_00[var_03].checked = 1;
  }

  for(var_02 = 0; var_02 < param_00[param_01].options.size; var_02++) {
    var_03 = param_00[param_01].options[var_02];
    if(param_00[var_03].var_DE05) {
      continue;
    }

    var_03 = func_CA85(param_00, var_03);
    return var_03;
  }

  return "null";
}

func_CA86(param_00) {
  if(isDefined(self.isnodeoccupied)) {
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

  if(!isDefined(param_00)) {
    param_00 = 200;
  }

  scripts\sp\utility::func_F35F();
  for(;;) {
    wait(0.1);
    var_01 = self.var_C986;
    var_02 = distancesquared(self.origin, self.var_C986);
    if(var_02 > squared(param_00)) {
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

func_CA87(param_00, param_01) {
  if(isDefined(self.isnodeoccupied)) {
    return;
  }

  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.var_C98C endon("death");
  if(isDefined(self.var_C98C.script_noteworthy) && self.var_C98C.script_noteworthy == "cqb_patrol") {
    for(;;) {
      wait(0.05);
      var_02 = self.var_C986;
      var_03 = distancesquared(self.origin, self.var_C986);
      if(var_03 < squared(16)) {
        if(self.moveplaybackrate > 0.4) {
          self.moveplaybackrate = self.moveplaybackrate - 0.05;
        }

        continue;
      }

      if(var_03 > squared(48)) {
        if(self.moveplaybackrate < 1.8) {
          self.moveplaybackrate = self.moveplaybackrate + 0.05;
        }

        continue;
      }

      self.moveplaybackrate = 1;
    }
  }

  if(!isDefined(param_00)) {
    param_00 = 16;
  }

  if(!isDefined(param_01)) {
    param_01 = 48;
  }

  var_04 = param_00 * param_00;
  var_05 = param_01 * param_01;
  for(;;) {
    wait(0.05);
    var_02 = self.var_C986;
    var_03 = distancesquared(self.origin, self.var_C986);
    if(self.a.movement != "walk") {
      self.moveplaybackrate = 1;
      continue;
    }

    if(var_03 < var_04) {
      if(self.moveplaybackrate > 0.4) {
        self.moveplaybackrate = self.moveplaybackrate - 0.05;
      }

      continue;
    }

    if(var_03 > var_05) {
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