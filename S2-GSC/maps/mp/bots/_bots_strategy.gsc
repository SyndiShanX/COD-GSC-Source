/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_strategy.gsc
*********************************************/

func_19A0() {
  var_00 = func_199F(self.var_28C8);
  if(isDefined(var_00) && var_00.size > 0) {
    return common_scripts\utility::func_7A33(var_00).var_0116;
  }

  return undefined;
}

func_199F(param_00, param_01) {
  if(isDefined(self.var_2C16)) {
    return maps\mp\bots\_bots_util::func_19F1(param_00, self.var_2C16, param_01);
  }

  return [];
}

func_19ED(param_00, param_01, param_02) {
  if(self botgetdifficultysetting("allowGrenades") == 0) {
    return undefined;
  }

  var_03 = [];
  var_03[var_03.size] = param_00;
  if(isDefined(param_01)) {
    var_03[var_03.size] = param_01;
  }

  if(isDefined(param_01)) {
    var_03[var_03.size] = param_02;
  }

  if(var_03.size == 0) {
    return undefined;
  }

  var_04 = self getweaponslistitems();
  var_05 = [];
  foreach(var_07 in var_04) {
    if(self getweaponammoclip(var_07) > 0 || self getweaponammostock(var_07) > 0) {
      var_05[var_05.size] = var_07;
    }
  }

  if(var_05.size <= 0) {
    return undefined;
  }

  foreach(var_0E, var_0A in var_03) {
    foreach(var_07 in var_05) {
      if(maps\mp\bots\_bots_util::func_1A3A(var_0A, var_07)) {
        param_01["purpose"] = var_0A;
        if(function_01DA(var_06) || function_027E(var_06)) {
          var_0E["item_action"] = "throw";
        } else {
          var_0E["item_action"] = "attack";
        }

        var_0E["weap_name"] = var_06;
        return var_0E;
      }
    }
  }
}

func_1AD0(param_00, param_01, param_02, param_03, param_04) {
  self notify("bot_set_ambush_trap");
  self endon("bot_set_ambush_trap");
  if(!isDefined(param_00)) {
    return 0;
  }

  var_05 = undefined;
  if(!isDefined(param_04) && isDefined(param_01) && param_01.size > 0) {
    if(!isDefined(param_02)) {
      return 0;
    }

    var_06 = [];
    var_07 = undefined;
    if(isDefined(param_03)) {
      var_07 = anglesToForward((0, param_03, 0));
    }

    foreach(var_09 in param_01) {
      if(!isDefined(var_07)) {
        var_06[var_06.size] = var_09;
        continue;
      }

      if(distancesquared(var_09.var_0116, param_02.var_0116) > 90000) {
        if(vectordot(var_07, vectornormalize(var_09.var_0116 - param_02.var_0116)) < 0.4) {
          var_06[var_06.size] = var_09;
        }
      }
    }

    if(var_06.size > 0) {
      var_05 = common_scripts\utility::func_7A33(var_06);
      var_0B = getnodesinradius(var_05.var_0116, 300, 50);
      var_0C = [];
      foreach(var_0E in var_0B) {
        if(!isDefined(var_0E.var_1938)) {
          var_0C[var_0C.size] = var_0E;
        }
      }

      var_0B = var_0C;
      param_04 = self method_8366(var_0B, min(var_0B.size, 3), "node_trap", param_02, var_05);
    }
  }

  if(isDefined(param_04)) {
    var_10 = undefined;
    if(param_00["purpose"] == "trap_directional" && isDefined(var_05)) {
      var_11 = vectortoangles(var_05.var_0116 - param_04.var_0116);
      var_10 = var_11[1];
    }

    if(self method_8367() && self method_835F() != "critical" && self method_835F() != "tactical") {
      self method_8358();
    }

    var_12 = self botsetscriptgoalnode(param_04, "guard", var_10);
    if(var_12) {
      var_13 = maps\mp\bots\_bots_util::func_1B21();
      if(var_13 == "goal") {
        thread maps\mp\bots\_bots_util::func_19D4("stand", 4);
        if(!isDefined(self.var_0088) || !self method_8371(self.var_0088)) {
          thread maps\mp\bots\_bots_util::func_19AF(4);
          var_14 = (0, 0, 0);
          if(param_00["weap_name"] == "h1_claymore_mp") {
            var_14 = (0, 0, 55);
          }

          if(isDefined(var_10)) {
            self botlookatpoint(var_05.var_0116 + var_14, 3, "script_forced");
          } else {
            self botlookatpoint(self.var_0116 + var_14 + anglesToForward(self getangles()) * 50, 3, "script_forced");
          }

          self switchtoweapon(param_00["weap_name"]);
          while(self getcurrentweapon() != param_00["weap_name"]) {
            wait 0.05;
          }

          func_1B0B(param_00["item_action"]);
          self.var_0D8F = undefined;
          thread func_1AD1("grenade_fire");
          thread func_1AD1("missile_fire");
          var_15 = common_scripts\utility::func_98E7(param_00["purpose"] == "tacticalinsertion", 6, 3);
          common_scripts\utility::func_A71A(var_15, "missile_fire", "grenade_fire");
          wait 0.05;
          self notify("ambush_trap_ent");
          if(isDefined(self.var_0D8F) && param_00["purpose"] == "c4") {
            thread func_1B26(self.var_0D8F, 300);
          }

          self.var_0D8F = undefined;
          wait(randomfloat(0.25));
          self notify("bot_force_stance_for_time");
          self botsetstance("none");
          self switchtoweapon("none");
          self notify("bot_disable_movement_for_time");
          self botsetflag("disable_movement", 0);
          self botlookatpoint(undefined);
        }
      }

      return 1;
    }
  }

  return 0;
}

func_1B0B(param_00) {
  self endon("grenade_pullback");
  for(;;) {
    self botpressbutton(param_00);
    wait(0.5);
  }
}

func_1AD1(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("bot_set_ambush_trap");
  self endon("ambush_trap_ent");
  level endon("game_ended");
  self waittill(param_00, var_01);
  self.var_0D8F = var_01;
}

func_1B26(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  var_02 = param_01 * param_01;
  for(;;) {
    if(distancesquared(self.var_0116, param_00.var_0116) > var_02) {
      var_03 = self getclosestenemysqdist(param_00.var_0116, 1);
      if(var_03 < var_02) {
        self botpressbutton("use", 0.25);
        wait(0.5);
        self botpressbutton("use", 0.25);
        return;
      }
    }

    wait(randomfloatrange(0.25, 1));
  }
}

func_196A(param_00, param_01, param_02) {
  thread func_19A4(param_00, param_01, "capture", param_02);
}

func_196B(param_00, param_01, param_02, param_03) {
  param_03["capture_trigger"] = param_02;
  thread func_19A4(param_00, param_01, "capture_zone", param_03);
}

func_1AA6(param_00, param_01, param_02) {
  if(!isDefined(param_02) || !isDefined(param_02["min_goal_time"])) {
    param_02["min_goal_time"] = 12;
  }

  if(!isDefined(param_02) || !isDefined(param_02["max_goal_time"])) {
    param_02["max_goal_time"] = 18;
  }

  thread func_19A4(param_00, param_01, "protect", param_02);
}

func_1AA7(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03) || !isDefined(param_03["min_goal_time"])) {
    param_03["min_goal_time"] = 12;
  }

  if(!isDefined(param_03) || !isDefined(param_03["max_goal_time"])) {
    param_03["max_goal_time"] = 18;
  }

  if(!isDefined(param_03) || !isDefined(param_03["random_stance"])) {
    param_03["random_stance"] = 1;
  }

  param_03["uniqueID"] = param_02;
  thread func_19A4(param_01, param_00, "protect_zone", param_03);
}

func_1A8D(param_00, param_01, param_02) {
  if(!isDefined(param_02) || !isDefined(param_02["min_goal_time"])) {
    param_02["min_goal_time"] = 0;
  }

  if(!isDefined(param_02) || !isDefined(param_02["max_goal_time"])) {
    param_02["max_goal_time"] = 0.01;
  }

  thread func_19A4(param_00, param_01, "patrol", param_02);
}

func_1A0C(param_00, param_01, param_02) {
  if(!isDefined(param_02) || !isDefined(param_02["min_goal_time"])) {
    param_02["min_goal_time"] = 15;
  }

  if(!isDefined(param_02) || !isDefined(param_02["max_goal_time"])) {
    param_02["max_goal_time"] = 20;
  }

  thread func_19A4(param_00, param_01, "bodyguard", param_02);
}

func_19A2(param_00) {
  if(param_00 == "protect_zone") {
    return 0;
  }

  return 1;
}

func_19A4(param_00, param_01, param_02, param_03) {
  self notify("started_bot_defend_think");
  self endon("started_bot_defend_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("defend_stop");
  thread func_2C83();
  if(isDefined(self.var_19A6) || self method_835F() == "camp") {
    self method_8358();
  }

  self.var_19A6 = 1;
  self.var_19AC = param_02;
  if(param_02 == "capture_zone") {
    self.var_19AA = undefined;
    self.var_19A8 = param_01;
    self.var_19AB = param_03["capture_trigger"];
  } else if(param_02 == "protect_zone") {
    self.var_19AA = undefined;
    self.var_19A8 = param_01;
    self.var_19AD = param_03["uniqueID"];
  } else {
    self.var_19AA = param_01;
    self.var_19A8 = undefined;
    self.var_19AB = undefined;
  }

  if(maps\mp\_utility::func_56FF(param_00)) {
    self.var_19A1 = param_00;
    childthread func_62FD();
  } else {
    self.var_19A1 = undefined;
    self.var_19A7 = param_00;
  }

  self botsetstance("none");
  var_04 = undefined;
  var_05 = 6;
  var_06 = 10;
  self.var_2C89 = [];
  if(isDefined(param_03)) {
    self.var_2C16 = param_03["entrance_points_index"];
    self.var_19A9 = param_03["override_origin_node"];
    if(isDefined(param_03["score_flags"])) {
      if(isarray(param_03["score_flags"])) {
        self.var_2C89 = param_03["score_flags"];
      } else {
        self.var_2C89[0] = param_03["score_flags"];
      }
    }

    if(isDefined(param_03["override_goal_type"])) {
      var_04 = param_03["override_goal_type"];
    }

    if(isDefined(param_03["min_goal_time"])) {
      var_05 = param_03["min_goal_time"];
    }

    if(isDefined(param_03["max_goal_time"])) {
      var_06 = param_03["max_goal_time"];
    }

    if(isDefined(param_03["override_watch_nodes"]) && param_03["override_watch_nodes"].size > 0) {
      self.var_2C88 = param_03["override_watch_nodes"];
    }

    self.var_2C36 = param_03["objective_radius"];
  }

  if(!isDefined(self.var_19A1) && func_19A2(param_02)) {
    var_07 = undefined;
    if(isDefined(param_03) && isDefined(param_03["nearest_node_to_center"])) {
      var_07 = param_03["nearest_node_to_center"];
    }

    if(!isDefined(var_07) && isDefined(self.var_19A9)) {
      var_07 = self.var_19A9;
    }

    if(!isDefined(var_07) && isDefined(self.var_19AB) && isDefined(self.var_19AB.var_6638)) {
      var_07 = self.var_19AB.var_6638;
    }

    if(!isDefined(var_07)) {
      var_07 = function_00BA(maps\mp\bots\_bots_util::func_2C6C());
    }

    if(!isDefined(var_07)) {
      var_08 = maps\mp\bots\_bots_util::func_2C6C();
      var_09 = getnodesinradiussorted(var_08, 256, 0);
      for(var_0A = 0; var_0A < var_09.size; var_0A++) {
        var_0B = vectornormalize(var_09[var_0A].var_0116 - var_08);
        var_0C = var_08 + var_0B * 15;
        if(sighttracepassed(var_0C, var_09[var_0A].var_0116, 0, undefined)) {
          var_07 = var_09[var_0A];
          break;
        }

        wait 0.05;
        if(sighttracepassed(var_0C + (0, 0, 55), var_09[var_0A].var_0116 + (0, 0, 55), 0, undefined)) {
          var_07 = var_09[var_0A];
          break;
        }

        wait 0.05;
      }
    }

    self.var_6709 = var_07;
  } else if(isDefined(param_03) && isDefined(param_03["nearest_node_to_center"])) {
    self.var_6709 = param_03["nearest_node_to_center"];
  }

  var_0D = level.var_19CA[param_02];
  if(!isDefined(var_04)) {
    var_04 = "guard";
    if(param_02 == "capture" || param_02 == "capture_zone") {
      var_04 = "objective";
    }
  }

  var_0E = 0;
  var_0F = 0;
  if(maps\mp\bots\_bots_util::func_1A28()) {
    var_0E = 1;
    var_0F = isDefined(param_03) && isDefined(param_03["entrance_points_index"]) && isarray(param_03["entrance_points_index"]);
  } else if(isDefined(param_03) && common_scripts\utility::func_562E(param_03["random_stance"])) {
    var_0E = 1;
    var_0F = 1;
  }

  var_10 = 1;
  if(isDefined(param_03) && common_scripts\utility::func_562E(param_03["dont_leave_goal_during_combat"])) {
    var_10 = 0;
  }

  if(param_02 == "protect") {
    childthread func_7792();
  }

  for(;;) {
    self.var_76BA = self.var_28C6;
    self.var_28C6 = undefined;
    self.var_28C5 = undefined;
    self.var_28C7 = undefined;
    self.var_28C8 = func_1E44(var_0E, var_0F);
    var_11 = self method_835F();
    var_12 = maps\mp\bots\_bots_util::func_1A0B(var_04, var_11);
    if(!var_12) {
      wait(0.25);
      continue;
    }

    var_13 = var_05;
    var_14 = var_06;
    var_15 = 1;
    if(isDefined(self.var_2C87)) {
      self.var_28C7 = self.var_2C87;
      self.var_2C87 = undefined;
      var_15 = 0;
      var_13 = 1;
      var_14 = 2;
    } else if(isDefined(self.var_2C85)) {
      self.var_28C6 = self.var_2C85;
      self.var_2C85 = undefined;
    } else {
      if(isDefined(level.var_0A2C) && level.var_0A2C[self.var_01A7]) {
        if(!common_scripts\utility::func_0F79(self.var_2C89, "avoid_aerial_enemies")) {
          self.var_2C89[self.var_2C89.size] = "avoid_aerial_enemies";
        }
      }

      self[[var_0D]]();
    }

    self method_8358();
    var_16 = "";
    if(isDefined(self.var_28C6) || isDefined(self.var_28C7)) {
      if(var_15 && maps\mp\bots\_bots_util::func_1A33() && !isPlayer(param_00) && isDefined(self.var_2C16)) {
        var_17 = func_19ED("trap_directional", "trap", "c4");
        if(isDefined(var_17)) {
          var_18 = maps\mp\bots\_bots_util::func_19F1(undefined, self.var_2C16);
          func_1AD0(var_17, var_18, self.var_6709);
        }
      }

      if(isDefined(self.var_28C7)) {
        var_19 = undefined;
        if(isDefined(self.var_28C5)) {
          var_19 = self.var_28C5[1];
        }

        self botsetscriptgoal(self.var_28C7, 0, var_04, var_19, self.var_2C36);
      } else if(!isDefined(self.var_28C5)) {
        self botsetscriptgoalnode(self.var_28C6, var_04, undefined, self.var_2C36);
      } else {
        self botsetscriptgoalnode(self.var_28C6, var_04, self.var_28C5[1], self.var_2C36);
      }

      if(var_0E) {
        if(!isDefined(self.var_76BA) || !isDefined(self.var_28C6) || self.var_76BA != self.var_28C6) {
          self botsetstance("none");
        }
      }

      var_1A = self method_835C();
      self notify("new_defend_goal");
      maps\mp\bots\_bots_util::func_A8CB();
      if(var_04 == "objective") {
        func_2C82();
        self botsetawareness(1);
        self botsetflag("cautious", 0);
      }

      if(self method_8367()) {
        var_1B = self method_835C();
        if(maps\mp\bots\_bots_util::func_1B1C(var_1B, var_1A)) {
          var_16 = maps\mp\bots\_bots_util::func_1B21(20, "defend_force_node_recalculation");
        }
      }

      if(var_16 == "goal") {
        if(var_0E) {
          self botsetstance(self.var_28C8);
        }

        childthread func_2C8D();
        if(var_15 && maps\mp\bots\_bots_util::func_1A33() && !isPlayer(param_00) && isDefined(self.var_2C16)) {
          maps\mp\bots\_bots_personality::func_1B0A();
        }
      }
    }

    if(var_16 != "goal") {
      var_1C = 0.25;
      if(var_16 == "no_path" && isDefined(self.var_2C6E)) {
        var_1C = self.var_2C6E;
      }

      wait(var_1C);
      continue;
    }

    var_1D = randomfloatrange(var_13, var_14);
    var_16 = common_scripts\utility::func_A71A(var_1D, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path");
    if((var_16 == "node_relinquished" || var_16 == "bad_path" || var_16 == "goal_changed" || var_16 == "script_goal_changed") && self.var_28C8 == "crouch" || self.var_28C8 == "prone") {
      self botsetstance("none");
    }

    if(var_16 == "timeout" && !var_10) {
      maps\mp\bots\_bots_util::func_1B22();
    }
  }
}

func_1E44(param_00, param_01) {
  var_02 = "stand";
  if(param_00) {
    var_03 = 100;
    var_04 = 0;
    var_05 = 0;
    var_06 = self botgetdifficultysetting("strategyLevel");
    if(var_06 == 1) {
      var_03 = 20;
      var_04 = 25;
      var_05 = 55;
    } else if(var_06 >= 2) {
      var_03 = 10;
      var_04 = 20;
      var_05 = 70;
    }

    var_07 = randomint(100);
    if(var_07 < var_04) {
      var_02 = "crouch";
    } else if(var_07 < var_04 + var_05) {
      var_02 = "prone";
    }

    var_08 = !isDefined(param_01) || !param_01;
    if(var_08 && var_02 == "prone") {
      var_09 = func_199F("prone");
      var_0A = func_2C1D("prone");
      if(var_0A.size >= var_09.size) {
        var_02 = "crouch";
      }
    }

    if(var_08 && var_02 == "crouch") {
      var_0B = func_199F("crouch");
      var_0C = func_2C1D("crouch");
      if(var_0C.size >= var_0B.size) {
        var_02 = "stand";
      }
    }
  }

  return var_07;
}

func_8B7A(param_00) {
  var_01 = 1250;
  var_02 = var_01 * var_01;
  if(param_00) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      return 0;
    }

    if(self.var_19AC == "capture_zone" && self istouching(self.var_19AB)) {
      return 0;
    }

    return distancesquared(self.var_0116, self.var_19A7) > var_02 * 0.75 * 0.75;
  }

  if(self method_8377() && distancesquared(self.var_0116, self.var_19A7) < var_02) {
    var_03 = self method_837E();
    return 0 <= var_03 && var_03 <= var_01;
  }

  return 0;
}

func_8868(param_00, param_01) {
  var_02 = spawnStruct();
  if(isDefined(param_01)) {
    var_02.var_0116 = param_01;
  } else {
    var_02.var_0116 = param_00.var_0116;
  }

  var_02.var_010D = param_00;
  var_02.var_3E73 = 0;
  return var_02;
}

func_2C82() {
  self notify("defense_cautious_approach");
  self endon("defense_cautious_approach");
  level endon("game_ended");
  self endon("defend_force_node_recalculation");
  self endon("death");
  self endon("disconnect");
  self endon("defend_stop");
  self endon("started_bot_defend_think");
  if(![[level.var_19D5["should_start_cautious_approach"]]](1)) {
    return;
  }

  var_00 = self method_835C();
  var_01 = self method_8378();
  var_02 = 1;
  var_03 = 0.2;
  var_04 = 0;
  while(var_02) {
    wait(0.25);
    var_04 = var_04 + 0.25;
    if(!self method_8367()) {
      return;
    }

    var_05 = self method_835C();
    if(!maps\mp\bots\_bots_util::func_1B1C(var_00, var_05)) {
      return;
    }

    if(var_04 >= 1) {
      var_06 = self method_8372();
      if(var_06.size == 0) {
        self method_8358();
        return;
      }
    }

    var_03 = var_03 + 0.25;
    if(var_03 >= 0.5) {
      var_03 = 0;
      if([[level.var_19D5["should_start_cautious_approach"]]](0)) {
        var_02 = 0;
      }
    }
  }

  self botsetawareness(1.8);
  self botsetflag("cautious", 1);
  var_07 = self method_8372();
  if(!isDefined(var_07) || var_07.size <= 2) {
    return;
  }

  self.var_5E5F = [];
  var_08 = 1000;
  if(isDefined(level.var_7790)) {
    var_08 = level.var_7790;
  }

  var_09 = var_08 * var_08;
  var_0A = getnodesinradius(self.var_19A7, var_08, 0, 500);
  if(var_0A.size <= 0) {
    return;
  }

  var_0B = 5 + self botgetdifficultysetting("strategyLevel") * 2;
  var_0C = int(min(var_0B, var_0A.size));
  var_0D = self botnodepickmultiple(var_0A, 15, var_0C, "node_protect", maps\mp\bots\_bots_util::func_2C6C(), "ignore_occupancy");
  for(var_0E = 0; var_0E < var_0D.size; var_0E++) {
    var_0F = func_8868(var_0D[var_0E]);
    self.var_5E5F = common_scripts\utility::func_0F6F(self.var_5E5F, var_0F);
  }

  var_10 = botgetmemoryevents(0, gettime() - -5536, 1, "death", 0, self);
  foreach(var_12 in var_10) {
    if(distancesquared(var_12, self.var_19A7) < var_09) {
      var_13 = function_00BA(var_12);
      if(isDefined(var_13)) {
        var_0F = func_8868(var_13, var_12);
        self.var_5E5F = common_scripts\utility::func_0F6F(self.var_5E5F, var_0F);
      }
    }
  }

  if(isDefined(self.var_2C16)) {
    var_15 = maps\mp\bots\_bots_util::func_19F1("stand", self.var_2C16);
    for(var_0E = 0; var_0E < var_15.size; var_0E++) {
      var_0F = func_8868(var_15[var_0E]);
      self.var_5E5F = common_scripts\utility::func_0F6F(self.var_5E5F, var_0F);
    }
  }

  if(self.var_5E5F.size == 0) {
    return;
  }

  childthread func_62F2();
  var_16 = self method_835F();
  var_17 = self method_835D();
  var_18 = self method_835E();
  wait 0.05;
  for(var_19 = 1; var_19 < var_07.size - 2; var_19++) {
    maps\mp\bots\_bots_util::func_1B22();
    var_1A = function_0204(var_07[var_19]);
    if(var_1A.size == 0) {
      continue;
    }

    var_1B = [];
    for(var_0E = 0; var_0E < var_1A.size; var_0E++) {
      if(!common_scripts\utility::func_AA4A(self.var_0116, self getangles(), var_1A[var_0E].var_0116, 0)) {
        continue;
      }

      for(var_1C = 0; var_1C < self.var_5E5F.size; var_1C++) {
        var_12 = self.var_5E5F[var_1C];
        if(function_01F4(var_12.var_010D, var_1A[var_0E], 1)) {
          var_1B = common_scripts\utility::func_0F6F(var_1B, var_1A[var_0E]);
          var_1C = self.var_5E5F.size;
        }
      }
    }

    if(var_1B.size == 0) {
      continue;
    }

    var_1D = self method_8366(var_1B, 1 + var_1B.size * 0.15, "node_hide");
    if(isDefined(var_1D)) {
      var_1E = [];
      for(var_0E = 0; var_0E < self.var_5E5F.size; var_0E++) {
        if(function_01F4(self.var_5E5F[var_0E].var_010D, var_1D, 1)) {
          if(distance2dsquared(self.var_5E5F[var_0E].var_0116, var_1D.var_0116) > 3600) {
            var_1E = common_scripts\utility::func_0F6F(var_1E, self.var_5E5F[var_0E]);
          }
        }
      }

      self method_8358();
      self botsetscriptgoalnode(var_1D, "critical");
      childthread func_62F3();
      var_1F = maps\mp\bots\_bots_util::func_1B21(undefined, "cautious_approach_early_out");
      self notify("stop_cautious_approach_early_out_monitor");
      if(var_1F == "cautious_approach_early_out") {
        break;
      }

      if(var_1F == "goal") {
        for(var_0E = 0; var_0E < var_1E.size; var_0E++) {
          if(distance2dsquared(self.var_0116, var_1E[var_0E].var_0116) < 1600) {
            continue;
          }

          var_04 = 0;
          while(var_1E[var_0E].var_3E73 < 18 && var_04 < 3.6) {
            self botlookatpoint(var_1E[var_0E].var_0116 + (0, 0, self getviewheight()), 0.25, "script_search");
            wait(0.25);
            var_04 = var_04 + 0.25;
          }
        }
      }
    }

    wait 0.05;
  }

  self notify("stop_location_monitoring");
  self method_8358();
  if(isDefined(var_01)) {
    self botsetscriptgoalnode(var_01, var_16, var_18);
    return;
  }

  self botsetscriptgoal(self.var_28C7, var_17, var_16, var_18);
}

func_62F3() {
  self endon("cautious_approach_early_out");
  self endon("stop_cautious_approach_early_out_monitor");
  var_00 = undefined;
  if(isDefined(self.var_19AA)) {
    var_00 = self.var_19AA * self.var_19AA;
  } else if(isDefined(self.var_19A8)) {
    var_01 = func_196C();
    var_00 = var_01 * var_01;
  }

  wait 0.05;
  for(;;) {
    if(distancesquared(self.var_0116, self.var_19A7) < var_00) {
      self notify("cautious_approach_early_out");
    }

    wait 0.05;
  }
}

func_62F2() {
  self endon("stop_location_monitoring");
  var_00 = 10000;
  for(;;) {
    var_01 = self getnearestnode();
    if(isDefined(var_01)) {
      var_02 = self method_8375();
      for(var_03 = 0; var_03 < self.var_5E5F.size; var_03++) {
        if(function_01F4(var_01, self.var_5E5F[var_03].var_010D, 1)) {
          var_04 = common_scripts\utility::func_AA4A(self.var_0116, self getangles(), self.var_5E5F[var_03].var_0116, var_02);
          var_05 = !var_04 || self.var_5E5F[var_03].var_3E73 < 17;
          if(var_05 && distancesquared(self.var_0116, self.var_5E5F[var_03].var_0116) < var_00) {
            var_04 = 1;
            self.var_5E5F[var_03].var_3E73 = 18;
          }

          if(var_04) {
            self.var_5E5F[var_03].var_3E73++;
            if(self.var_5E5F[var_03].var_3E73 >= 18) {
              self.var_5E5F[var_03] = self.var_5E5F[self.var_5E5F.size - 1];
              self.var_5E5F[self.var_5E5F.size - 1] = undefined;
              var_03--;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

func_7792() {
  self notify("protect_watch_allies");
  self endon("protect_watch_allies");
  var_00 = [];
  var_01 = 1050;
  var_02 = var_01 * var_01;
  var_03 = 900;
  if(isDefined(level.var_7790)) {
    var_03 = level.var_7790;
  }

  for(;;) {
    var_04 = gettime();
    var_05 = func_1A06(self.var_19A7, var_03);
    foreach(var_07 in var_05) {
      var_08 = var_07.var_37CD;
      if(!isDefined(var_08)) {
        var_08 = var_07 getentitynumber();
      }

      if(!isDefined(var_00[var_08])) {
        var_00[var_08] = var_04 - 1;
      }

      if(!isDefined(var_07.var_5B2C)) {
        var_07.var_5B2C = var_04 - 10001;
      }

      if(var_07.var_00BC == 0 && isDefined(var_07.var_2AB8) && var_04 - var_07.var_2AB8 < 5000) {
        if(var_04 - var_07.var_5B2C > 10000 && var_04 > var_00[var_08]) {
          if(isDefined(var_07.var_00E6) && isDefined(var_07.var_00E6.var_01A7) && var_07.var_00E6.var_01A7 == common_scripts\utility::func_416F(self.var_01A7)) {
            if(distancesquared(var_07.var_18A8.var_0116, self.var_0116) < var_02) {
              self method_8379(var_07.var_00E6, var_07.var_18A8.var_0116);
              var_09 = function_00BA(var_07.var_18A8.var_0116);
              if(isDefined(var_09)) {
                self.var_2C87 = var_09.var_0116;
                self notify("defend_force_node_recalculation");
              }

              var_07.var_5B2C = var_04;
            }

            var_00[var_08] = var_04 + 10000;
          }
        }
      }
    }

    wait(randomint(5) + 1 * 0.05);
  }
}

func_2C86() {
  if(isDefined(self.var_2C88)) {
    return self.var_2C88;
  }

  if(maps\mp\bots\_bots_util::func_1A28()) {
    return func_199F(self.var_28C8, 1);
  }

  if(maps\mp\bots\_bots_util::func_1A33() || maps\mp\bots\_bots_util::func_1A27()) {
    var_00 = findentrances(self.var_0116);
    return var_00;
  }
}

func_2C8D() {
  self notify("defense_watch_entrances_at_goal");
  self endon("defense_watch_entrances_at_goal");
  self endon("new_defend_goal");
  self endon("script_goal_changed");
  var_00 = self getnearestnode();
  var_01 = undefined;
  if(maps\mp\bots\_bots_util::func_1A28()) {
    var_02 = func_2C86();
    var_01 = [];
    if(isDefined(var_00)) {
      foreach(var_04 in var_02) {
        if(function_01F4(var_00, var_04, 1)) {
          var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
        }
      }
    }

    if(var_01.size == 0) {
      var_01 = findentrances(self.var_0116);
    }
  } else if(maps\mp\bots\_bots_util::func_1A33() || maps\mp\bots\_bots_util::func_1A27()) {
    var_01 = func_2C86();
    if(isDefined(var_00) && !issubstr(self getcurrentweapon(), "riotshield") && isDefined(self.var_6709)) {
      if(function_01F4(var_00, self.var_6709, 1)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, self.var_6709);
      }
    }
  }

  if(isDefined(var_01)) {
    childthread maps\mp\bots\_bots_util::func_1B2A(var_01);
    if(maps\mp\bots\_bots_util::func_1A27()) {
      childthread func_1A83();
      return;
    }

    if(isDefined(level.var_19D5["bot_entrance_update"])) {
      self childthread[[level.var_19D5["bot_entrance_update"]]]();
      return;
    }

    childthread func_1A82();
    return;
  }
}

func_1A82() {
  self notify("bot_monitor_watch_entrances_at_goal");
  self endon("bot_monitor_watch_entrances_at_goal");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  while(!isDefined(self.var_A8C9)) {
    wait 0.05;
  }

  var_00 = level.var_19D5["get_watch_node_chance"];
  for(;;) {
    var_01 = 0.8;
    var_02 = 1;
    if(common_scripts\utility::func_0F79(self.var_2C89, "strict_los")) {
      var_01 = 1;
      var_02 = 0.5;
    }

    if(isDefined(self.var_6709)) {
      foreach(var_04 in self.var_A8C9) {
        if(var_04 == self.var_6709) {
          var_04.var_A8C7[self.var_37CD] = var_04.var_A8C6[self.var_37CD] * var_01;
          continue;
        }

        var_04.var_A8C7[self.var_37CD] = var_04.var_A8C6[self.var_37CD] * var_02;
      }
    }

    var_06 = isDefined(var_00);
    if(!var_06) {
      func_7733(0.5);
    }

    foreach(var_04 in self.var_A8C9) {
      if(var_06) {
        var_08 = self[[var_00]](var_04);
        var_04.var_A8C7[self.var_37CD] = var_04.var_A8C7[self.var_37CD] * var_08;
      }

      if(func_37E0(var_04)) {
        var_04.var_A8C7[self.var_37CD] = var_04.var_A8C7[self.var_37CD] * 0.5;
      }
    }

    wait(randomfloatrange(0.5, 0.75));
  }
}

func_1A83() {
  self notify("bot_monitor_watch_entrances_bodyguard");
  self endon("bot_monitor_watch_entrances_bodyguard");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  while(!isDefined(self.var_A8C9)) {
    wait 0.05;
  }

  for(;;) {
    var_00 = anglesToForward(self.var_19A1 getangles()) * (1, 1, 0);
    var_00 = vectornormalize(var_00);
    foreach(var_02 in self.var_A8C9) {
      var_02.var_A8C7[self.var_37CD] = var_02.var_A8C6[self.var_37CD];
      var_03 = var_02.var_0116 - self.var_19A1.var_0116;
      var_03 = vectornormalize(var_03);
      var_04 = vectordot(var_00, var_03);
      if(var_04 > 0.6) {
        var_02.var_A8C7[self.var_37CD] = var_02.var_A8C7[self.var_37CD] * 0.33;
      } else if(var_04 > 0) {
        var_02.var_A8C7[self.var_37CD] = var_02.var_A8C7[self.var_37CD] * 0.66;
      }

      if(!func_37DE(var_02)) {
        var_02.var_A8C7[self.var_37CD] = var_02.var_A8C7[self.var_37CD] * 0.5;
      }
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

func_37DE(param_00) {
  var_01 = getnodezone(param_00);
  var_02 = vectornormalize(param_00.var_0116 - self.var_0116);
  for(var_03 = 0; var_03 < level.var_AC9C; var_03++) {
    if(botzonegetcount(var_03, self.var_01A7, "enemy_predict") > 0) {
      if(isDefined(var_01) && var_03 == var_01) {
        return 1;
      } else {
        var_04 = vectornormalize(getzoneorigin(var_03) - self.var_0116);
        var_05 = vectordot(var_02, var_04);
        if(var_05 > 0.2) {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_7733(param_00) {
  if(self.var_A8C9.size <= 0) {
    return;
  }

  var_01 = self.var_A8C9;
  for(var_02 = 0; var_02 < level.var_AC9C; var_02++) {
    if(botzonegetcount(var_02, self.var_01A7, "enemy_predict") <= 0) {
      continue;
    }

    if(var_01.size == 0) {
      break;
    }

    var_03 = vectornormalize(getzoneorigin(var_02) - self.var_0116);
    for(var_04 = 0; var_04 < var_01.size; var_04++) {
      var_05 = getnodezone(var_01[var_04]);
      var_06 = 0;
      if(isDefined(var_05) && var_02 == var_05) {
        var_06 = 1;
      } else {
        var_07 = vectornormalize(var_01[var_04].var_0116 - self.var_0116);
        var_08 = vectordot(var_07, var_03);
        if(var_08 > 0.2) {
          var_06 = 1;
        }
      }

      if(var_06) {
        var_01[var_04].var_A8C7[self.var_37CD] = var_01[var_04].var_A8C7[self.var_37CD] * param_00;
        var_01[var_04] = var_01[var_01.size - 1];
        var_01[var_01.size - 1] = undefined;
        var_04--;
      }
    }
  }
}

func_37E0(param_00) {
  if(self.var_19AC == "protect_zone") {
    var_01 = func_1A05(self.var_19AD);
  } else {
    var_01 = func_1A04(self.var_19A7);
  }

  foreach(var_03 in var_01) {
    if(func_37E1(var_03, param_00)) {
      return 1;
    }
  }

  return 0;
}

func_37E1(param_00, param_01) {
  var_02 = anglesToForward(param_00 getangles());
  var_03 = vectornormalize(param_01.var_0116 - param_00.var_0116);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > 0.6) {
    return 1;
  }

  return 0;
}

func_1A05(param_00) {
  var_01 = [];
  var_02 = func_1A06(self.var_0116, 1000);
  foreach(var_04 in var_02) {
    if(!isai(var_04) || var_04 maps\mp\bots\_bots_util::func_1A2D() && var_04.var_19AD == param_00) {
      var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
    }
  }

  return var_01;
}

func_1A04(param_00, param_01) {
  if(!isDefined(param_01)) {
    if(isDefined(level.var_7790)) {
      param_01 = level.var_7790;
    } else {
      param_01 = 900;
    }
  }

  var_02 = [];
  var_03 = func_1A06(param_00, param_01);
  foreach(var_05 in var_03) {
    if(!isai(var_05) || var_05 maps\mp\bots\_bots_util::func_1A2E(param_00)) {
      var_02 = common_scripts\utility::func_0F6F(var_02, var_05);
    }
  }

  return var_02;
}

func_1A06(param_00, param_01) {
  var_02 = param_01 * param_01;
  var_03 = [];
  for(var_04 = 0; var_04 < level.var_6E97.size; var_04++) {
    var_05 = level.var_6E97[var_04];
    if(var_05 != self && isDefined(var_05.var_01A7) && var_05.var_01A7 == self.var_01A7 && maps\mp\_utility::func_5800(var_05)) {
      if(distancesquared(param_00, var_05.var_0116) < var_02) {
        var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
      }
    }
  }

  return var_03;
}

func_2C83() {
  level endon("game_ended");
  self endon("started_bot_defend_think");
  self endon("defend_stop");
  self endon("disconnect");
  self waittill("death");
  if(isDefined(self)) {
    thread func_19A3();
  }
}

func_19A3() {
  self notify("defend_stop");
  self.var_19A6 = undefined;
  self.var_19A7 = undefined;
  self.var_19AA = undefined;
  self.var_19A8 = undefined;
  self.var_19AC = undefined;
  self.var_19AB = undefined;
  self.var_19A9 = undefined;
  self.var_19A1 = undefined;
  self.var_19AD = undefined;
  self.var_2C89 = undefined;
  self.var_6709 = undefined;
  self.var_2C87 = undefined;
  self.var_2C85 = undefined;
  self.var_2C36 = undefined;
  self.var_76BA = undefined;
  self.var_28C6 = undefined;
  self.var_28C5 = undefined;
  self.var_28C7 = undefined;
  self.var_2C16 = undefined;
  self.var_2C88 = undefined;
  self method_8358();
  self botsetstance("none");
}

func_2C1D(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_6E97) {
    if(!isDefined(var_03.var_01A7)) {
      continue;
    }

    if(var_03.var_01A7 == self.var_01A7 && var_03 != self && isai(var_03) && var_03 maps\mp\bots\_bots_util::func_1A2D() && isDefined(var_03.var_28C8) && var_03.var_28C8 == param_00) {
      if(var_03.var_19AC == self.var_19AC && maps\mp\bots\_bots_util::func_1A2E(var_03.var_19A7)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_03);
      }
    }
  }

  return var_01;
}

func_62FD() {
  var_00 = 0;
  var_01 = 175;
  var_02 = self.var_19A1.var_0116;
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    if(!isDefined(self.var_19A1)) {
      thread func_19A3();
    }

    self.var_19A7 = self.var_19A1.var_0116;
    self.var_6709 = self.var_19A1 getnearestnode();
    if(!isDefined(self.var_6709)) {
      self.var_6709 = self getnearestnode();
    }

    if(self method_835F() != "none") {
      var_05 = self method_835C();
      var_06 = self.var_19A1 getvelocity();
      var_07 = lengthsquared(var_06);
      if(var_07 > 100) {
        var_00 = 0;
        if(distancesquared(var_02, self.var_19A1.var_0116) > var_01 * var_01) {
          var_02 = self.var_19A1.var_0116;
          var_04 = 1;
          var_08 = vectornormalize(var_05 - self.var_19A1.var_0116);
          var_09 = vectornormalize(var_06);
          if(vectordot(var_08, var_09) < 0.1) {
            self notify("defend_force_node_recalculation");
            wait(0.25);
          }
        }
      } else {
        var_00 = var_00 + 0.05;
        if(var_03 > 100 && var_04) {
          var_02 = self.var_19A1.var_0116;
          var_04 = 0;
        }

        if(var_00 > 0.5) {
          var_0A = distancesquared(var_05, self.var_19A7);
          if(var_0A > self.var_19AA * self.var_19AA) {
            self notify("defend_force_node_recalculation");
            wait(0.25);
          }
        }
      }

      var_03 = var_07;
      if(abs(self.var_19A1.var_0116[2] - var_05[2]) >= 50) {
        self notify("defend_force_node_recalculation");
        wait(0.25);
      }
    }

    wait 0.05;
  }
}

func_3B6F() {
  var_00 = func_19A0();
  var_01 = maps\mp\bots\_bots_util::func_19CC(maps\mp\bots\_bots_util::func_2C6C(), self.var_19AA, var_00);
  if(isDefined(var_01)) {
    if(isDefined(var_00)) {
      var_02 = vectornormalize(var_00 - var_01.var_0116);
      self.var_28C5 = vectortoangles(var_02);
    } else {
      var_03 = vectornormalize(var_01.var_0116 - maps\mp\bots\_bots_util::func_2C6C());
      self.var_28C5 = vectortoangles(var_03);
    }

    self.var_28C6 = var_01;
    return;
  }

  if(isDefined(var_00)) {
    func_1A0F(var_00, undefined);
    return;
  }

  func_1A0F(undefined, maps\mp\bots\_bots_util::func_2C6C());
}

func_3B70() {
  var_00 = func_19A0();
  var_01 = maps\mp\bots\_bots_util::func_19CD(self.var_19A8, var_00);
  if(isDefined(var_01)) {
    if(isDefined(var_00)) {
      var_02 = vectornormalize(var_00 - var_01.var_0116);
      self.var_28C5 = vectortoangles(var_02);
    } else {
      var_03 = vectornormalize(var_01.var_0116 - maps\mp\bots\_bots_util::func_2C6C());
      self.var_28C5 = vectortoangles(var_03);
    }

    self.var_28C6 = var_01;
    return;
  }

  if(isDefined(var_00)) {
    func_1A0F(var_00, undefined);
    return;
  }

  func_1A0F(undefined, maps\mp\bots\_bots_util::func_2C6C());
}

func_3B72() {
  var_00 = maps\mp\bots\_bots_util::func_19CB(maps\mp\bots\_bots_util::func_2C6C(), self.var_19AA);
  if(isDefined(var_00)) {
    var_01 = vectornormalize(maps\mp\bots\_bots_util::func_2C6C() - var_00.var_0116);
    self.var_28C5 = vectortoangles(var_01);
    self.var_28C6 = var_00;
    return;
  }

  func_1A0F(maps\mp\bots\_bots_util::func_2C6C(), undefined);
}

func_3B73() {
  var_00 = maps\mp\bots\_bots_util::func_19CF(self.var_19A8, maps\mp\bots\_bots_util::func_2C6C());
  if(isDefined(var_00)) {
    self.var_28C6 = var_00;
    return;
  }

  func_1A0F(maps\mp\bots\_bots_util::func_2C6C(), undefined);
}

func_3B6E() {
  var_00 = maps\mp\bots\_bots_util::func_19CE(maps\mp\bots\_bots_util::func_2C6C(), self.var_19AA);
  if(isDefined(var_00)) {
    self.var_28C6 = var_00;
    return;
  }

  var_01 = self getnearestnode();
  if(isDefined(var_01)) {
    self.var_28C6 = var_01;
    return;
  }

  self.var_28C7 = self.var_0116;
}

func_3B71() {
  var_00 = undefined;
  var_01 = getnodesinradius(maps\mp\bots\_bots_util::func_2C6C(), self.var_19AA, 0);
  if(isDefined(var_01) && var_01.size > 0) {
    var_00 = self method_8366(var_01, 1 + var_01.size * 0.5, "node_traffic");
  }

  if(isDefined(var_00)) {
    self.var_28C6 = var_00;
    return;
  }

  func_1A0F(undefined, maps\mp\bots\_bots_util::func_2C6C());
}

func_1A0F(param_00, param_01) {
  if(self.var_19AC == "protect_zone") {
    self.var_28C7 = common_scripts\utility::func_7A33(self.var_19A8).var_0116;
    return;
  }

  if(self.var_19AC == "capture_zone") {
    self.var_28C7 = maps\mp\bots\_bots_util::func_1A98(maps\mp\bots\_bots_util::func_2C6C(), self.var_19A8, ::func_1966);
  } else {
    self.var_28C7 = maps\mp\bots\_bots_util::func_1A99(maps\mp\bots\_bots_util::func_2C6C(), self.var_19AA, ::func_1966, 0.15, 0.9);
  }

  if(isDefined(param_00)) {
    var_02 = vectornormalize(param_00 - self.var_28C7);
    self.var_28C5 = vectortoangles(var_02);
    return;
  }

  if(isDefined(param_01)) {
    var_02 = vectornormalize(self.var_28C7 - param_01);
    self.var_28C5 = vectortoangles(var_02);
  }
}

func_1966(param_00) {
  if(func_196F(param_00, 1, 1, 1)) {
    return 0;
  }

  return 1;
}

func_196F(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < level.var_6E97.size; var_04++) {
    var_05 = level.var_6E97[var_04];
    if(var_05.var_01A7 == self.var_01A7 && var_05 != self) {
      if(isai(var_05)) {
        if(param_02) {
          if(distancesquared(param_00, var_05.var_0116) < 441) {
            return 1;
          }
        }

        if(param_03 && var_05 method_8367()) {
          var_06 = var_05 method_835C();
          if(distancesquared(param_00, var_06) < 441) {
            return 1;
          }
        }

        continue;
      }

      if(param_01) {
        if(distancesquared(param_00, var_05.var_0116) < 441) {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_196C() {
  var_00 = 0;
  if(isDefined(self.var_19A8)) {
    foreach(var_02 in self.var_19A8) {
      var_03 = distance(self.var_19A7, var_02.var_0116);
      var_00 = max(var_03, var_00);
    }
  }

  return var_00;
}

func_1B04() {
  self notify("bot_think_tactical_goals");
  self endon("bot_think_tactical_goals");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.var_959E = [];
  self.var_959D = 0;
  for(;;) {
    if(self.var_959E.size > 0 && !maps\mp\bots\_bots_util::func_1A36()) {
      var_00 = self.var_959E[0];
      if(!isDefined(var_00.var_0843)) {
        self notify("start_tactical_goal");
        if(isDefined(var_00.var_9296)) {
          self[[var_00.var_9296]](var_00);
        }

        childthread func_A8B8(var_00);
        var_01 = "tactical";
        if(isDefined(var_00.var_4809)) {
          var_01 = var_00.var_4809;
        }

        if(common_scripts\utility::func_562E(var_00.var_23C7)) {
          self method_8358();
        }

        self botsetscriptgoal(var_00.var_4805, var_00.var_4806, var_01, var_00.var_480A, var_00.var_691E, var_00.var_8B2D);
        var_02 = maps\mp\bots\_bots_util::func_1B21(undefined, "stop_tactical_goal");
        self notify("stop_goal_aborted_watch");
        if(var_02 == "goal") {
          if(isDefined(var_00.var_087F)) {
            self.var_959D = 1;
            self[[var_00.var_087F]](var_00);
            self.var_959D = 0;
          }
        }

        if(var_02 != "script_goal_changed") {
          self method_8358();
        }

        if(isDefined(var_00.var_36AC)) {
          self[[var_00.var_36AC]](var_00);
        }
      }

      self.var_959E = common_scripts\utility::func_0F93(self.var_959E, var_00);
    }

    wait 0.05;
  }
}

func_A8B8(param_00) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  wait 0.05;
  for(;;) {
    if(isDefined(param_00.var_0843) || isDefined(param_00.var_8B3E) && self[[param_00.var_8B3E]](param_00)) {
      self notify("stop_tactical_goal");
    }

    wait 0.05;
  }
}

func_1A85(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_01B9 = param_00;
  var_04.var_4805 = param_01;
  if(isDefined(self.var_6B4F)) {
    if(!common_scripts\utility::func_0F79(self.var_6B4F, param_00)) {
      return;
    }
  }

  var_04.var_7734 = param_02;
  var_04.var_68FB = param_03.var_68FB;
  var_04.var_4809 = param_03.var_81C9;
  var_04.var_480A = param_03.var_81CA;
  var_04.var_4806 = 0;
  if(isDefined(param_03.var_81C8)) {
    var_04.var_4806 = param_03.var_81C8;
  }

  var_04.var_9296 = param_03.var_9296;
  var_04.var_36AC = param_03.var_36AC;
  var_04.var_8B3E = param_03.var_8B3E;
  var_04.var_087F = param_03.var_087F;
  var_04.var_691E = param_03.var_691E;
  var_04.var_8B2D = param_03.var_8B2D;
  var_04.var_6C13 = param_03.var_6C13;
  var_04.var_23C7 = param_03.var_23C7;
  for(var_05 = 0; var_05 < self.var_959E.size; var_05++) {
    if(var_04.var_7734 > self.var_959E[var_05].var_7734) {
      break;
    }
  }

  for(var_06 = self.var_959E.size - 1; var_06 >= var_05; var_06--) {
    self.var_959E[var_06 + 1] = self.var_959E[var_06];
  }

  self.var_959E[var_05] = var_04;
}

func_1A14(param_00, param_01) {
  if(!isDefined(self.var_959E)) {
    return 0;
  }

  if(isDefined(param_00)) {
    foreach(var_03 in self.var_959E) {
      if(var_03.var_01B9 == param_00) {
        if(isDefined(param_01) && isDefined(var_03.var_68FB)) {
          return var_03.var_68FB == param_01;
        } else {
          return 1;
        }
      }
    }

    return 0;
  }

  return self.var_959E.size > 0;
}

func_19EB(param_00) {
  var_01 = [];
  if(isDefined(self.var_959E)) {
    foreach(var_03 in self.var_959E) {
      if(!common_scripts\utility::func_562E(var_03.var_0843) && var_03.var_01B9 == param_00) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

func_192C(param_00, param_01) {
  if(!isDefined(self.var_959E)) {
    return;
  }

  foreach(var_03 in self.var_959E) {
    if(var_03.var_01B9 == param_00) {
      if(isDefined(param_01)) {
        if(isDefined(var_03.var_68FB) && var_03.var_68FB == param_01) {
          var_03.var_0843 = 1;
        }

        continue;
      }

      var_03.var_0843 = 1;
    }
  }
}

func_19B0() {
  self.var_6B4F[0] = "map_interactive_object";
  foreach(var_01 in self.var_959E) {
    if(var_01.var_01B9 != "map_interactive_object") {
      var_01.var_0843 = 1;
    }
  }
}

func_19BC() {
  self.var_6B4F = undefined;
}

func_1A7A() {
  var_00 = gettime();
  if(!isDefined(self.var_5B31) || var_00 - self.var_5B31 > 1000) {
    self.var_5B31 = var_00;
    var_01 = func_19ED("tacticalinsertion");
    if(!isDefined(var_01)) {
      return 0;
    }

    if(isDefined(self.var_0088) && self method_8371(self.var_0088)) {
      return 0;
    }

    var_02 = getzonenearest(self.var_0116);
    if(!isDefined(var_02)) {
      return 0;
    }

    var_03 = botzonenearestcount(var_02, self.var_01A7, 1, "enemy_predict", ">", 0);
    if(!isDefined(var_03)) {
      return 0;
    }

    var_04 = getnodesinradius(self.var_0116, 500, 0);
    if(var_04.size <= 0) {
      return 0;
    }

    var_05 = self method_8366(var_04, var_04.size * 0.15, "node_hide");
    if(!isDefined(var_05)) {
      return 0;
    }

    return func_1AD0(var_01, undefined, undefined, undefined, var_05);
  }

  return 0;
}