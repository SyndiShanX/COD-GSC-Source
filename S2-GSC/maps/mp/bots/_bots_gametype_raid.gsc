/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_raid.gsc
************************************************/

func_00F9() {
  if(common_scripts\utility::func_562E(level.var_27F6)) {
    return;
  }

  func_87A7();
  func_8798();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1AAD;
  level.var_19D5["bot_entrance_update"] = ::func_1AAC;
  level.var_1B31 = ::func_1A11;
}

func_8798() {
  maps\mp\bots\_bots_util::func_1B20(1);
  level.pathnodecount = getallnodes().size;
  level.var_5B19 = 0;
  level.var_1A88["useHoldBuildObjective"] = ::func_A1E3;
  level.var_1A88["bombObjective"] = ::bomb_objective_is_ready_to_set_up;
  level.var_1A88["multiBombObjective"] = ::bomb_objective_is_ready_to_set_up;
  level.var_1A88["destructionObjective"] = ::destruction_objective_is_ready_to_set_up;
  level.var_1A89["captureObjective"] = ::func_1FAF;
  level.var_1A89["useHoldBuildObjective"] = ::func_A1E4;
  level.var_1A89["bombObjective"] = ::func_18C2;
  level.var_1A89["multiBombObjective"] = ::func_18C2;
  level.var_1A89["escortObjective"] = ::func_3818;
  level.var_1A89["escortContinueObjective"] = ::func_3818;
  level.var_1A89["multipleObjective"] = ::func_6519;
  level.var_1A89["relayObjective"] = ::func_289A;
  level.var_1A89["destructionObjective"] = ::destruction_objective_setup;
  level.var_1A89["hostageObjective"] = ::hostage_objective_setup;
  level.var_1A89["secureDropsObjective"] = ::secure_drop_objective_setup;
  level.var_1A89["flagsObjective"] = ::momentum_objective_setup;
  level.var_1A89["safeObjective"] = ::opensafe_objective_setup;
  level.var_1A8A["captureObjective"] = ::func_1FB0;
  level.var_1A8A["useHoldBuildObjective"] = ::func_A1E5;
  level.var_1A8A["bombObjective"] = ::func_18C3;
  level.var_1A8A["multiBombObjective"] = ::func_18C3;
  level.var_1A8A["escortObjective"] = ::func_3819;
  level.var_1A8A["escortContinueObjective"] = ::func_3819;
  level.var_1A8A["multipleObjective"] = ::func_651A;
  level.var_1A8A["relayObjective"] = ::func_289B;
  level.var_1A8A["destructionObjective"] = ::destruction_objective_think;
  level.var_1A8A["hostageObjective"] = ::hostage_objective_think;
  level.var_1A8A["secureDropsObjective"] = ::secure_drop_objective_think;
  level.var_1A8A["flagsObjective"] = ::momentum_objective_think;
  level.var_1A8A["safeObjective"] = ::opensafe_objective_think;
  level thread func_1E46();
  level thread handle_objective_completion();
}

func_1AAD() {
  self notify("bot_raid_think");
  self endon("bot_raid_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  level endon("game_end_vignette");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  while(lib_0505::introvignetteactiveforplayer(self)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  var_00 = undefined;
  self.var_5B29 = 0;
  self.var_1957 = 1;
  self.var_6903 = undefined;
  childthread func_1B15();
  childthread func_395C();
  for(;;) {
    if(level.var_A27E["both"].size > level.pathnodecount * 0.5) {
      wait 0.05;
      continue;
    }

    var_01 = func_412E();
    if(!isDefined(var_01)) {
      self[[self.var_6F7F]]();
      wait 0.05;
      continue;
    }

    if(isDefined(var_01.var_6E78)) {
      var_02 = 0;
      foreach(var_04 in level.var_79AE.var_08DB) {
        if(var_04.var_695A == var_01.var_6E78) {
          var_02 = 1;
        }
      }

      if(!var_02) {
        wait 0.05;
        continue;
      }
    }

    var_06 = !isDefined(var_00) || var_01.var_695A != var_00.var_695A;
    if(var_06) {
      if(can_set_up_objective(var_01)) {
        func_1977();
        if(isDefined(var_00)) {
          var_00.var_1B39 = undefined;
        }

        var_07 = level.var_1A89[var_01.var_0165];
        if(isDefined(var_07)) {
          [[var_07]](var_01);
        }

        var_00 = var_01;
      }
    }

    if(isDefined(level.var_1A8A[var_01.var_0165])) {
      func_196D(var_01);
      var_08 = isDefined(var_00) && var_01.var_695A == var_00.var_695A;
      if(var_08) {
        childthread func_1B24(var_01);
        childthread bot_defensive_structure_think(var_01);
        childthread func_194C(var_01);
        self[[level.var_1A8A[var_01.var_0165]]](var_01);
      }
    } else {
      self[[self.var_6F7F]]();
    }

    wait 0.05;
  }
}

can_set_up_objective(param_00) {
  var_01 = level.var_1A88[param_00.var_0165];
  if(isDefined(var_01) && ![[var_01]](param_00)) {
    return 0;
  }

  if(isDefined(param_00.var_94CE)) {
    var_02 = func_4060(param_00);
    foreach(var_04 in var_02) {
      var_01 = level.var_1A88[var_04.var_0165];
      if(isDefined(var_01) && ![[var_01]](var_04)) {
        return 0;
      }
    }
  }

  return 1;
}

func_1FAF(param_00, param_01, param_02) {
  var_03 = !common_scripts\utility::func_562E(param_02);
  if(var_03) {
    if(func_1A25()) {
      self.var_3026 = randomfloatrange(200, 1200);
    }
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  var_04 = param_00.var_1FBA.var_9D65;
  param_00.var_1B39.var_1FB2 = maps\mp\bots\_bots_gametype_common::func_1A08(var_04);
  var_04 thread func_6325(param_00);
  param_00.var_1B39.var_6638 = getnodesinradiussorted(var_04.var_0116, 256, 0)[0];
  if(!common_scripts\utility::func_562E(param_01)) {
    thread func_87A5(param_00);
  }
}

func_1FB0(param_00) {
  level endon("objectiveComplete");
  var_01 = param_00.var_1FBA.var_9D65;
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = undefined;
  if(isDefined(param_00.zonecenternode)) {
    var_02["nearest_node_to_center"] = param_00.zonecenternode;
  }

  if(func_1A25()) {
    if(!func_1A2A(var_01)) {
      func_1968(var_01, param_00.var_1B39.var_1FB2, var_02);
    }
  }

  if(func_1A2C()) {
    if(func_1FAE(var_01)) {
      if(func_1A2A(var_01) && self method_835F() == "objective") {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!func_1A2A(var_01)) {
        func_199E(var_01, param_00.var_1B39.var_1FB2, "critical", var_02);
      }
    } else {
      if(!isDefined(self.var_1F1E)) {
        self.var_1F1E = randomint(100) > 50 && level.var_015D == "mp_raid_cobra";
      }

      if(self.var_1F1E) {
        if(!func_1A35(var_01)) {
          if(!isDefined(param_00.var_1B39.var_2C35)) {
            param_00.var_1B39.var_2C35 = [];
            foreach(var_05, var_04 in level.var_A27E["both"]) {
              param_00.var_1B39.var_2C35[param_00.var_1B39.var_2C35.size] = function_039A(var_05);
            }
          }

          func_1AA5(var_01, param_00.var_1B39.var_2C35, "warCaptureObjDefend", undefined, undefined);
        }
      } else {
        if(func_1A2A(var_01) && self method_835F() == "critical") {
          maps\mp\bots\_bots_strategy::func_19A3();
        }

        if(!func_1A2A(var_01)) {
          func_199E(var_01, param_00.var_1B39.var_1FB2, "objective", var_02);
        }
      }
    }
  }

  if(func_195D(param_00, var_01, param_00.var_1B39.var_1FB2)) {
    func_1B09(var_01, param_00.var_1B39.var_1FB2, param_00.var_0165);
  }
}

func_195D(param_00, param_01, param_02) {
  if(func_1A25()) {
    var_03 = func_19F0(param_02);
    if(var_03 < self.var_3026) {
      return 1;
    }
  }

  if(func_1A2C()) {
    if(func_6922(param_00, 10000)) {
      return 0;
    }

    if(func_1FAE(param_01)) {
      return 1;
    }
  }

  return 0;
}

is_capture_objective(param_00) {
  return param_00 == "captureObjective";
}

func_1FAE(param_00) {
  if(param_00.var_1FBA.var_931A == "taking" || param_00.var_1FBA.var_931A == "contested") {
    return 1;
  }

  return 0;
}

func_1968(param_00, param_01, param_02) {
  self.var_291F = param_00;
  if(!isDefined(param_02)) {
    param_02 = [];
  }

  if(func_1A25()) {
    param_02["min_goal_time"] = 2;
    param_02["max_goal_time"] = 4;
  }

  maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_01, param_00, param_02);
}

func_199E(param_00, param_01, param_02, param_03) {
  self.var_291F = param_00;
  param_03["override_goal_type"] = param_02;
  maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_01, param_00, param_03);
}

func_1A2A(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A28()) {
    return 0;
  }

  return self.var_291F == param_00;
}

func_6325(param_00) {
  level endon("game_ended");
  var_01 = getzonenearest(self.var_0116);
  var_02 = lib_04FF::func_6937(param_00.var_695A);
  while(isDefined(self) && !common_scripts\utility::func_3C77(var_02)) {
    var_03 = "none";
    if(isDefined(self.var_1FBA)) {
      var_03 = self.var_1FBA maps\mp\gametypes\_gameobjects::func_445B();
    }

    if(var_03 == "neutral" || var_03 == "none" || self.var_1FBA.var_931A == "contested") {
      botzonesetteam(var_01, "free");
      continue;
    }

    botzonesetteam(var_01, var_03);
    wait(1);
  }

  botzonesetteam(var_01, "free");
}

func_19F0(param_00) {
  var_01 = common_scripts\utility::func_40B0(self.var_0116, param_00);
  return distance(self.var_0116, var_01[0].var_0116);
}

func_A1E3(param_00) {
  var_01 = param_00 lib_0502::func_207E("build_trigger");
  if(common_scripts\utility::func_562E(var_01.var_9D9F)) {
    return 0;
  }

  return 1;
}

func_A1E4(param_00) {
  self botsetpathingstyle("scripted");
  self botsetflag("no_enemy_search", 1);
  self botsetflag("can_approach_bad_place_goals", 1);
  self botsetflag("dont_path_to_enemy", 1);
  if(func_1A25()) {
    if(self.var_6F7D == "cqb") {
      self.var_6903 = "build";
    } else if(self.var_6F7D == "camper") {
      self.var_6903 = "protect";
    } else {
      self.var_6903 = common_scripts\utility::func_7A33(["build", "protect"]);
    }

    if(self.var_6903 == "protect") {
      var_01 = 0;
      foreach(var_03 in level.var_744A) {
        if(isalive(var_03) && isbot(var_03) && isDefined(var_03.var_01A7) && var_03.var_01A7 == self.var_01A7) {
          if(isDefined(var_03.var_6903) && var_03.var_6903 == "build") {
            var_01 = 1;
            break;
          }
        }
      }

      if(!var_01) {
        self.var_6903 = "build";
      }
    }

    if(self.var_6903 == "build") {
      self.var_66E4 = 1;
      self botsetflag("force_sprint", 1);
    }
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  var_05 = param_00 lib_0502::func_207E("build_trigger");
  param_00.var_1B39.var_1D2B = getnodesintrigger(var_05, 1);
  level.var_664A = [];
  level.var_3BA8 = [];
  param_00.var_1B39.var_A268 = [];
  var_06 = maps\mp\_utility::func_442E(param_00.var_1B39.var_1D2B);
  var_07 = common_scripts\utility::func_40B0(var_06, param_00.var_1B39.var_1D2B)[0];
  param_00.var_1B39.var_52CD = findentrances(var_07.var_0116);
  param_00.var_1B39.var_52C9 = getnodearray("attacker_look_node", "script_noteworthy");
  thread func_87A5(param_00);
  var_08 = getnodearray("bridge_nodes", "targetname");
  foreach(var_0A in var_08) {
    nodeallowpathspread(var_0A, 0);
  }
}

func_A1E5(param_00) {
  level endon("objectiveComplete");
  if(!isDefined(param_00.var_601F)) {
    return;
  }

  var_01 = param_00 lib_0502::func_207D("build_trigger");
  var_02 = var_01[0];
  if(func_1A25()) {
    if(self.var_6903 == "build") {
      if(!isDefined(self.var_671B)) {
        self.var_671B = common_scripts\utility::func_7A33(param_00.var_1B39.var_1D2B);
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
      }

      if(self istouching(var_02)) {
        func_7CC5();
        self botsetstance("prone");
        while(self getstance() != "prone") {
          wait 0.05;
        }

        func_A720();
        self botsetscriptgoal(self.var_0116, 0, "critical");
        for(;;) {
          self botpressbutton("use", 0.6);
          wait(0.5);
        }
      }
    } else if(self.var_6903 == "protect") {
      if(!func_1A35(var_02)) {
        self.var_2C6E = 0.1;
        var_03 = param_00.var_1B39.var_52C9;
        if(!isDefined(param_00.var_1B39.var_A268["attackers"]) || common_scripts\utility::func_562E(level.var_664A["attackers"])) {
          func_3B84(param_00, "attackers", var_03, 0);
        }

        var_04 = common_scripts\utility::func_7A33(var_03);
        var_05["min_goal_time"] = 20;
        var_05["max_goal_time"] = 40;
        var_05["nearest_node_to_center"] = var_04;
        var_05["override_watch_nodes"] = func_4206(param_00, "attackers");
        var_05["override_goal_type"] = "critical";
        var_05["dont_leave_goal_during_combat"] = 1;
        func_1AA5(var_02, param_00.var_1B39.var_A268["attackers"], "warUseHoldObjAttack", var_04.var_0116, var_05);
      }
    } else {}
  } else if(!func_1A35(var_02)) {
    self.var_2C6E = 0.1;
    var_03 = param_00.var_1B39.var_1D2B;
    if(!isDefined(param_00.var_1B39.var_A268["defenders"]) || common_scripts\utility::func_562E(level.var_664A["defenders"])) {
      func_3B84(param_00, "defenders", var_03, 1);
    }

    var_04 = common_scripts\utility::func_7A33(var_03);
    var_05["min_goal_time"] = 20;
    var_05["max_goal_time"] = 40;
    var_05["score_flags"] = "strict_los";
    var_05["nearest_node_to_center"] = var_04;
    var_05["override_watch_nodes"] = func_4206(param_00, "defenders");
    var_05["override_goal_type"] = "critical";
    var_05["dont_leave_goal_during_combat"] = 1;
    func_1AA5(var_02, param_00.var_1B39.var_A268["defenders"], "warUseHoldObjDefend", var_04.var_0116, var_05);
  }

  if(func_1960(param_00)) {
    func_1B09(var_02, param_00.var_1B39.var_1D2B, param_00.var_0165);
  }
}

func_1960(param_00) {
  if(func_1A2C()) {
    if(func_6922(param_00, 20000)) {
      return 0;
    }
  }

  return 1;
}

func_4206(param_00, param_01) {
  if(param_01 == "defenders") {
    return param_00.var_1B39.var_52CD;
  }

  if(param_01 == "attackers") {
    return param_00.var_1B39.var_52C9;
  }
}

func_3B84(param_00, param_01, param_02, param_03) {
  var_04 = [];
  foreach(var_0C, var_06 in level.var_A27E[param_01]) {
    var_07 = function_039A(var_0C);
    if(var_07 method_8389()) {
      continue;
    }

    var_08 = 0;
    foreach(var_0A in param_02) {
      if(function_01F4(var_07, var_0A, 1)) {
        var_08 = 1;
        break;
      }
    }

    if(var_08) {
      var_04[var_04.size] = var_07;
    }
  }

  if(!isDefined(param_00.var_1B39.var_A268[param_01])) {
    param_00.var_1B39.var_A268[param_01] = var_04;
  }

  level.var_664A[param_01] = undefined;
  if(!common_scripts\utility::func_562E(param_03)) {
    param_02 = undefined;
  }

  thread func_28BD(param_00, param_01, var_04, param_02);
}

func_28BD(param_00, param_01, param_02, param_03) {
  level notify("cull_defend_nodes_over_time_" + param_01);
  level endon("cull_defend_nodes_over_time_" + param_01);
  level endon("objectiveComplete");
  level endon("game_ended");
  if(isDefined(param_03)) {
    var_04 = 0;
    for(var_05 = 0; var_05 < param_02.size; var_05++) {
      var_06 = param_02[var_05];
      var_07 = 0;
      foreach(var_09 in param_03) {
        var_04++;
        var_0A = sighttracepassed(var_06.var_0116 + (0, 0, 60), var_09.var_0116 + (0, 0, 11), 0, undefined);
        if(var_0A) {
          var_07 = 1;
          break;
        }
      }

      if(!var_07) {
        param_02[var_05] = param_02[param_02.size - 1];
        param_02[param_02.size - 1] = undefined;
        var_05--;
      }

      if(var_04 >= 10) {
        wait 0.05;
        var_04 = 0;
      }
    }
  }

  var_0C = lib_0502::func_3B80(lib_0502::func_447F(game[param_01])).var_0116;
  var_0D = 0;
  var_05 = 0;
  while(var_05 < param_02.size) {
    var_09 = param_02[var_05];
    var_0D++;
    var_0E = getnodesonpath(var_0C, var_09.var_0116, 1, undefined, var_09);
    var_0F = 0;
    if(isDefined(var_0E) && var_0E.size > 0) {
      var_0F = 1;
      foreach(var_11 in var_0E) {
        var_12 = 0;
        if(nodeinvalidforteam(var_11, game[param_01])) {
          var_12 = 1;
        } else if(isDefined(var_11.var_0165)) {
          if(param_01 == "defenders" && var_11.var_0165 == "defenders_dont_pass") {
            var_12 = 1;
          } else if(param_01 == "attackers" && var_11.var_0165 == "attackers_dont_pass") {
            var_12 = 1;
          }
        }

        if(var_12) {
          var_0F = 0;
          break;
        }
      }
    }

    if(!var_13) {
      var_05[var_10] = var_05[var_05.size - 1];
      var_05[var_05.size - 1] = undefined;
      var_10--;
    }

    if(var_0F >= 2) {
      wait 0.05;
      var_0F = 0;
    }

    var_10++;
  }

  param_00.var_1B39.var_A268[param_01] = param_02;
  level.var_3BA8[param_01] = 1;
  func_7DCC();
}

bomb_objective_is_ready_to_set_up(param_00) {
  var_01 = param_00 lib_0502::func_207E("trigger");
  if(common_scripts\utility::func_562E(var_01.var_9D9F)) {
    return 0;
  }

  return 1;
}

func_18C2(param_00, param_01, param_02) {
  var_03 = !common_scripts\utility::func_562E(param_02);
  if(var_03) {
    self.var_3026 = randomfloatrange(200, 1200);
    self.var_6903 = common_scripts\utility::func_7A33(["quick", "careful"]);
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  var_04 = param_00 lib_0502::func_207E("trigger");
  param_00.var_1B39.var_18D0 = getnodesintrigger(var_04, 1);
  param_00.var_1B39.var_6638 = param_00.var_1B39.var_18D0[0];
  if(!common_scripts\utility::func_562E(param_01)) {
    var_05 = getnodearray("bridge_nodes", "targetname");
    foreach(var_07 in var_05) {
      nodeallowpathspread(var_07, 0);
    }

    thread func_18C1(param_00);
    thread func_87A5(param_00);
  }
}

is_bomb_objective(param_00) {
  return param_00 == "bombObjective" || param_00 == "multiBombObjective";
}

func_18C1(param_00) {
  level endon("objectiveComplete");
  for(;;) {
    level common_scripts\utility::func_A70A("bomb_planted", "bomb_defused");
    var_01 = lib_04F7::func_440F();
    foreach(var_03 in var_01) {
      if(var_03.var_56FC) {
        var_04 = var_03 lib_0502::func_207C("bomb_traversal_start");
        var_03 func_1A11(var_04);
      }
    }
  }
}

func_18C3(param_00) {
  level endon("objectiveComplete");
  var_01 = param_00 lib_0502::func_207E("trigger");
  if(func_1A25()) {
    if(!common_scripts\utility::func_562E(param_00.var_18F9)) {
      func_7066(param_00, "plant");
    } else if(!func_1A35(var_01)) {
      func_1AA4(var_01, 550);
    }
  } else if(!common_scripts\utility::func_562E(param_00.var_18F9)) {
    if(!func_1A35(var_01)) {
      func_1AA4(var_01, 800);
    }
  } else {
    func_7066(param_00, "defuse");
  }

  if(func_195C(param_00, param_00.var_1B39.var_18D0)) {
    func_1B09(var_01, param_00.var_1B39.var_18D0, param_00.var_0165);
  }
}

func_195C(param_00, param_01) {
  if(func_1A2C()) {
    var_02 = 10000;
    if(level.var_015D == "mp_raid_cobra") {
      var_02 = 30000;
    }

    if(func_6922(param_00, var_02)) {
      return 0;
    }
  }

  var_03 = func_19F0(param_01);
  if(var_03 < self.var_3026) {
    return 1;
  }

  return 0;
}

func_7066(param_00, param_01) {
  if(!isDefined(self.var_671B)) {
    var_02 = common_scripts\utility::func_40B0(self.var_0116, param_00.var_1B39.var_18D0);
    var_03 = randomint(8);
    self.var_671B = var_02[var_03];
  }

  var_04 = self.var_6903 == "careful";
  if(var_04) {
    if(func_1A25()) {
      var_05 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
      if(var_05 > 0 && var_05 < 20) {
        var_04 = 0;
      }
    } else if(common_scripts\utility::func_562E(param_00.var_18F9)) {
      var_05 = param_00.var_2CA0 - gettime() / 1000;
      if(var_05 > 0 && var_05 < 10) {
        var_04 = 0;
      }
    }
  }

  if(var_04) {
    if(distancesquared(self.var_0116, self.var_671B.var_0116) > -25536) {
      if(!maps\mp\bots\_bots_util::func_1A28()) {
        maps\mp\bots\_bots_strategy::func_196A(self.var_671B.var_0116, 200);
      }
    } else {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "objective");
      }
    }
  } else {
    if(maps\mp\bots\_bots_util::func_1A2D()) {
      maps\mp\bots\_bots_strategy::func_19A3();
    }

    if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
      self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
    }
  }

  if(distance2dsquared(self.var_0116, self.var_671B.var_0116) < 256) {
    func_7CC5();
    self botsetstance("prone");
    while(self getstance() != "prone") {
      wait 0.05;
    }

    func_A720();
    self botsetscriptgoal(self.var_0116, 0, "critical");
    while((param_01 == "plant" && !param_00.var_18F9) || param_01 == "defuse" && param_00.var_18F9) {
      self botpressbutton("use", 0.6);
      wait(0.5);
    }

    self method_8358();
  }
}

func_3818(param_00, param_01, param_02) {
  var_03 = !common_scripts\utility::func_562E(param_02);
  if(var_03) {
    self.var_3026 = randomfloatrange(200, 1200);
    self.var_5B63 = 0;
    self.var_66B5 = 0;
    if(func_1A25()) {
      self botsetpathingstyle("scripted");
      self botsetflag("force_sprint", 1);
      var_04 = 0;
      if(self botgetdifficultysetting("strategyLevel") == 1) {
        var_04 = 40;
      } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
        var_04 = 80;
      }

      self.var_1F4A = randomint(100) < var_04;
    } else {
      self.var_6903 = common_scripts\utility::func_7A33(["clear_enemies", "block_tank"]);
      if(self.var_6903 == "block_tank") {
        self botsetpathingstyle("scripted");
        self botsetflag("force_sprint", 1);
      }
    }
  }

  if(isDefined(param_01.var_1B39)) {
    return;
  }

  param_01.var_1B39 = spawnStruct();
  thread func_8540(param_01);
  if(!common_scripts\utility::func_562E(param_02)) {
    thread func_87A5(param_01);
  }
}

func_8540(param_00) {
  var_01 = param_00.var_A2C8;
  while(!isDefined(param_00.var_1B39.var_6638)) {
    param_00.var_1B39.var_6638 = getnodesinradiussorted(var_01.var_0116, 256, 0)[0];
    wait 0.05;
  }
}

func_5575(param_00) {
  return param_00 == "escortObjective" || param_00 == "escortContinueObjective";
}

handle_objective_completion() {
  level endon("game_ended");
  for(;;) {
    level waittill("objectiveComplete");
    foreach(var_01 in level.var_744A) {
      if(isbot(var_01)) {
        if(var_01 maps\mp\bots\_bots_util::func_1A2D()) {
          var_01 maps\mp\bots\_bots_strategy::func_19A3();
        }
      }
    }

    var_03 = level.var_79AE.completedobjectives[level.var_79AE.completedobjectives.size - 1];
    if(isDefined(level.var_1B45)) {
      foreach(var_05 in level.var_1B45) {
        if(var_03.var_695A == var_05) {
          var_03.var_A2C8.var_9EDD.var_1B3A = 1;
        }
      }
    }

    foreach(var_08 in level.var_79C2.var_9F96) {
      if(isDefined(var_08) && isDefined(var_08.var_817E) && var_08.var_817E == var_03.var_695A) {
        var_08.var_1B3A = 1;
      }
    }
  }
}

func_3819(param_00) {
  level endon("objectiveComplete");
  if(!isDefined(param_00.var_A2C8.var_1B49) || !isDefined(param_00.var_5024)) {
    return;
  }

  if(func_1A25()) {
    if(func_96F0(param_00)) {
      var_01 = param_00.var_17DA.var_4C28;
      if(distancesquared(self.var_0116, var_01.var_9D65.var_0116) < 1048576) {
        if(bot_can_use_defensive_structures() && defensive_structure_is_usable(var_01)) {
          bot_use_defensive_structure(var_01, param_00);
        }
      }
    }

    if(gettime() > self.var_66B5) {
      var_02 = func_43B7(param_00.var_A2C8, undefined, "front");
      if(var_02.size == 0) {
        return;
      }

      self.var_671B = common_scripts\utility::func_7A33(var_02);
      self.var_66B5 = gettime() + randomintrange(5000, 15000);
    }

    if(gettime() > self.var_5B63 + 500 || !self method_8367()) {
      if(param_00.var_5024 == "contested") {
        var_03 = func_43B7(param_00.var_A2C8, "front");
        if(var_03.size == 0) {
          return;
        }

        var_04 = common_scripts\utility::func_40B0(self.var_0116, var_03);
        func_8485(param_00.var_A2C8, var_04[0], "critical");
      } else {
        if(self method_835F() == "critical") {
          self method_8358();
        }

        func_8485(param_00.var_A2C8, self.var_671B, "guard");
      }

      self.var_5B63 = gettime();
    }

    if(self.var_1F4A && self method_8367()) {
      var_05 = distancesquared(self.var_0116, self method_835C());
      if(var_05 < 16384) {
        self botsetstance("crouch");
      } else if(var_05 > 65536 && self getstance() == "crouch") {
        self botsetstance("none");
      }
    }
  } else {
    if(func_96F1(var_05)) {
      var_01 = var_05.var_17DE.var_4C28;
      if(distancesquared(self.var_0116, var_01.var_9D65.var_0116) < 1048576) {
        if(bot_can_use_defensive_structures() && defensive_structure_is_usable(var_01)) {
          bot_use_defensive_structure(var_01, var_05);
        }
      }
    }

    if(self.var_6903 == "block_tank") {
      if(gettime() > self.var_5B63 + 250 || !self method_8367()) {
        var_03 = func_43B7(var_05.var_A2C8, "front");
        var_06 = undefined;
        if(var_03.size > 0) {
          var_04 = common_scripts\utility::func_40B0(self.var_0116, var_03);
          var_06 = var_04[0];
        }

        set_defender_escort_goal(var_06, var_05.var_A2C8, "critical");
        self.var_5B63 = gettime();
      }

      if(self method_8367()) {
        if(distancesquared(self.var_0116, self method_835C()) < 256) {
          self botsetstance("prone");
        } else if(self getstance() != "stand") {
          self botsetstance("none");
        }
      }
    } else if(self.var_6903 == "clear_enemies") {
      if(gettime() > self.var_66B5) {
        var_02 = func_43B7(var_05.var_A2C8);
        self.var_671B = undefined;
        if(var_02.size >= 0) {
          self.var_671B = common_scripts\utility::func_7A33(var_02);
        }

        self.var_66B5 = gettime() + randomintrange(5000, 15000);
      }

      if(gettime() > self.var_5B63 + 500 || !self method_8367()) {
        if(self method_835F() == "critical") {
          self method_8358();
        }

        set_defender_escort_goal(self.var_671B, var_05.var_A2C8, "guard");
        self.var_5B63 = gettime();
      }
    } else {}
  }

  var_07 = var_05.var_A2C8.var_3850;
  var_08 = maps\mp\bots\_bots_gametype_common::func_1A08(var_07);
  if(var_08.size > 0 && func_195F(var_05.var_A2C8.var_1B49)) {
    func_1B09(var_05.var_A2C8.var_3850, var_08, var_05.var_0165);
  }
}

set_defender_escort_goal(param_00, param_01, param_02) {
  var_03 = 0;
  if(isDefined(param_00)) {
    var_04 = getnodesinradiussorted(param_00.var_0116, 256, 0);
    if(var_04.size == 0) {
      return;
    }

    var_05 = var_04[0];
    var_06 = function_0366(var_05);
    var_03 = common_scripts\utility::func_562E(level.var_A27E["defenders"][var_06]);
  }

  if(var_03) {
    func_8485(param_01, param_00, param_02);
    self.altambushnode = undefined;
    return;
  }

  var_07 = undefined;
  var_08 = param_01 method_84C8();
  var_09 = undefined;
  while(!var_03) {
    var_08 = var_08 method_864F();
    var_07 = var_08.var_0116;
    var_0A = getnodesinradiussorted(var_07, 512, 0);
    var_05 = var_0A[0];
    var_06 = function_0366(var_05);
    var_03 = common_scripts\utility::func_562E(level.var_A27E["defenders"][var_06]);
    if(var_03 && !isDefined(self.altambushnode)) {
      var_0B = [];
      for(var_0C = 0; var_0C < var_0A.size; var_0C++) {
        if(common_scripts\utility::func_562E(level.var_A27E["defenders"][function_0366(var_0A[var_0C])])) {
          var_0B[var_0B.size] = var_0A[var_0C];
        }
      }

      var_09 = self method_8366(var_0B, var_0B.size * 0.15, "node_ambush", var_05.var_0116);
      if(isDefined(var_09)) {
        var_07 = var_09.var_0116;
        self.altambushnode = var_07;
      } else {
        var_07 = self.var_0116;
      }

      continue;
    }

    if(isDefined(self.altambushnode)) {
      var_09 = self.altambushnode;
    }
  }

  self botsetscriptgoal(var_07, 16, param_02, undefined, undefined, 1);
}

func_96F0(param_00) {
  if(param_00.var_5024 == "blocked" && param_00 lib_04FF::func_3840()) {
    if(isDefined(param_00.var_17DA)) {
      return 1;
    }
  }

  return 0;
}

func_96F1(param_00) {
  if(param_00.var_5024 == "blocked" && param_00 lib_04FF::func_3842()) {
    if(isDefined(param_00.var_17DE)) {
      return 1;
    }
  }

  return 0;
}

func_43B7(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_00.var_1B49) {
    if(isDefined(param_01)) {
      if(var_05.var_8C3A != param_01) {
        continue;
      }
    }

    if(isDefined(param_02)) {
      if(var_05.var_8C3A == param_02) {
        continue;
      }
    }

    var_06 = function_00BA(var_05.var_0116);
    if(isDefined(var_06)) {
      var_07 = function_0366(var_06);
      if(func_1A25()) {
        if(isDefined(level.var_54F9["attackers"][var_07])) {
          continue;
        }
      } else if(func_1A2C()) {
        if(isDefined(level.var_54F9["defenders"][var_07])) {
          continue;
        }
      }
    }

    var_03[var_03.size] = var_05;
  }

  return var_03;
}

func_8485(param_00, param_01, param_02) {
  var_03 = param_01.var_0116;
  if(param_00.var_01C4 > 1) {
    if(param_01.var_8C3A == "front" && param_00.var_01C1 == "forward") {
      var_04 = anglesToForward(param_01.var_001D);
      var_03 = param_01.var_0116 + var_04 * 25;
    } else if(param_01.var_8C3A == "back" && param_00.var_01C1 == "reverse") {
      var_04 = anglesToForward(param_01.var_001D);
      var_03 = param_01.var_0116 + -1 * var_04 * 25;
    }
  }

  self botsetscriptgoal(var_03, 16, param_02, undefined, undefined, 1);
}

func_195F(param_00) {
  var_01 = func_19F0(param_00);
  if(var_01 < self.var_3026 && var_01 > 100) {
    return 1;
  }

  return 0;
}

func_3815(param_00) {
  return param_00.var_5024 == "forward" || param_00.var_5024 == "contested";
}

func_3817(param_00) {
  return param_00.var_5024 == "enemy";
}

func_3816(param_00) {
  return param_00.var_5024 == "normal";
}

func_3814(param_00) {
  return param_00.var_383C.var_2947;
}

func_6519(param_00) {
  if(!isDefined(self.var_94CD) || !func_94CC(self.var_94CD)) {
    func_8393(param_00);
  }

  if(!isDefined(self.var_94CD)) {
    return 0;
  }

  var_01 = level.var_1A89[self.var_94CD.var_0165];
  if(isDefined(var_01)) {
    [[var_01]](self.var_94CD, 1);
  }

  self.var_66B1 = gettime() + randomintrange(2000, 10000);
  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  foreach(var_03 in param_00.var_94CE) {
    var_01 = level.var_1A89[var_03.var_0165];
    if(isDefined(var_01)) {
      [[var_01]](var_03, 1, 1);
    }
  }

  var_05 = [];
  foreach(var_03 in param_00.var_94CE) {
    var_05[var_05.size] = var_03.var_1B39.var_6638;
  }

  var_08 = maps\mp\_utility::func_442E(var_05);
  param_00.var_1B39.var_6638 = getnodesinradiussorted(var_08, 512, 0)[0];
  thread func_87A5(param_00);
}

func_94CC(param_00) {
  return common_scripts\utility::func_0F79(level.var_79AE.var_08DB, param_00);
}

func_4060(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_94CE) {
    if(func_94CC(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_414A(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(func_5575(var_03.var_0165)) {
      if(func_1A25()) {
        var_01[var_01.size] = var_03;
      } else if(func_1A2C()) {
        if(func_3815(var_03)) {
          var_01[var_01.size] = var_03;
        }
      }

      continue;
    }

    if(is_capture_objective(var_03.var_0165)) {
      if(func_1A2C() && func_1FAE(var_03.var_1FBA.var_9D65)) {
        var_04 = 0;
        foreach(var_06 in level.var_744A) {
          if(isDefined(var_06.var_01A7) && var_06.var_01A7 == self.var_01A7) {
            if(isDefined(var_06.var_94CD) && var_06.var_94CD == var_03) {
              var_04++;
            }
          }
        }

        if(var_04 <= 2) {
          var_01[var_01.size] = var_03;
        }
      }

      continue;
    }

    if(is_bomb_objective(var_03.var_0165)) {
      if(func_1A2C() && common_scripts\utility::func_562E(var_03.var_18F9)) {
        var_04 = 0;
        foreach(var_06 in level.var_744A) {
          if(isDefined(var_06.var_01A7) && var_06.var_01A7 == self.var_01A7) {
            if(isDefined(var_06.var_94CD) && var_06.var_94CD == var_03) {
              var_04++;
            }
          }
        }

        if(var_04 <= 2) {
          var_01[var_01.size] = var_03;
        }
      }

      continue;
    }

    if(is_hostage_objective(var_03.var_0165)) {
      if((func_1A2C() && var_03.var_5024 == "inUse") || var_03.var_5024 == "contested") {
        var_04 = 0;
        foreach(var_06 in level.var_744A) {
          if(isDefined(var_06.var_01A7) && var_06.var_01A7 == self.var_01A7) {
            if(isDefined(var_06.var_94CD) && var_06.var_94CD == var_03) {
              var_04++;
            }
          }
        }

        if(var_04 <= 2) {
          var_01[var_01.size] = var_03;
        }
      }

      continue;
    }
  }

  if(var_01.size > 0) {
    return var_01;
  }

  var_0D = [];
  foreach(var_03 in param_00) {
    if(func_5575(var_03.var_0165)) {
      if(func_1A2C()) {
        if(func_3814(var_03) > 0.33) {
          var_0D[var_0D.size] = var_03;
        }
      }

      continue;
    }

    if(is_capture_objective(var_03.var_0165)) {
      continue;
    }

    if(is_bomb_objective(var_03.var_0165)) {
      continue;
    }

    if(is_hostage_objective(var_03.var_0165)) {
      continue;
    }
  }

  return var_0D;
}

func_8393(param_00) {
  var_01 = func_4060(param_00);
  if(var_01.size == 0) {
    self.var_94CD = undefined;
    return 0;
  }

  var_02 = func_414A(var_01);
  if(var_02.size > 0) {
    var_03 = common_scripts\utility::func_7A33(var_02);
  } else {
    var_03 = common_scripts\utility::func_7A33(var_02);
  }

  if(isDefined(self.var_94CD) && var_03 == self.var_94CD) {
    return 0;
  }

  func_1977();
  self.var_94CD = var_03;
  return 1;
}

func_651A(param_00) {
  level endon("objectiveComplete");
  var_01 = 0;
  if(!isDefined(self.var_94CD) || !common_scripts\utility::func_0F79(level.var_79AE.var_08DB, self.var_94CD)) {
    var_01 = 1;
  } else if(gettime() > self.var_66B1) {
    self.var_66B1 = gettime() + randomintrange(2000, 5000);
    if(func_1A2C()) {
      var_02 = self.var_94CD.var_0165;
      if(func_5575(var_02)) {
        var_03 = func_3816(self.var_94CD);
        var_04 = func_3817(self.var_94CD) && func_3814(self.var_94CD) <= 0.33;
        var_05 = 0;
        if(func_3817(self.var_94CD)) {
          var_06 = 0;
          var_07 = 0;
          foreach(var_09 in level.var_744A) {
            if(isDefined(var_09.var_01A7) && var_09.var_01A7 == self.var_01A7) {
              var_06++;
              if(var_09 != self && isDefined(var_09.var_94CD) && var_09.var_94CD == self.var_94CD) {
                var_07++;
              }
            }
          }

          if(var_07 >= var_06 / 3) {
            var_05 = 1;
          }
        }

        if(var_03 || var_04 || var_05) {
          var_0B = func_414A(func_4060(param_00));
          if(var_0B.size > 0) {
            var_01 = 1;
          }
        }
      } else if(is_capture_objective(var_02) || is_bomb_objective(var_02) || is_hostage_objective(var_02)) {
        var_0B = func_414A(func_4060(param_00));
        if(var_0B.size > 0) {
          if(var_0B.size > 1 || var_0B[0] != self.var_94CD) {
            var_01 = 1;
          }
        }
      }
    }
  }

  if(var_01) {
    var_0C = func_8393(param_00);
    if(var_0C) {
      var_0D = level.var_1A89[self.var_94CD.var_0165];
      if(isDefined(var_0D)) {
        [[var_0D]](self.var_94CD, 1);
      }
    }
  }

  if(isDefined(self.var_94CD) && isDefined(level.var_1A8A[self.var_94CD.var_0165])) {
    self[[level.var_1A8A[self.var_94CD.var_0165]]](self.var_94CD);
  }
}

secure_drop_objective_setup(param_00) {
  self.var_3026 = randomfloatrange(200, 1200);
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  param_00.var_1B39.prev_attackers_at_drop = 0;
  param_00.var_1B39.was_drop_trigger_defined = 0;
}

secure_drop_objective_contains_attackers(param_00) {
  if(param_00.var_A222.var_689F[game["attackers"]] > 0) {
    return 1;
  }

  return 0;
}

secure_drop_objective_contains_defenders(param_00) {
  if(param_00.var_A222.var_689F[game["defenders"]] > 0) {
    return 1;
  }

  return 0;
}

secure_drop_objective_think(param_00) {
  level endon("objectiveComplete");
  if(!isDefined(param_00.var_A222)) {
    if(isDefined(param_00.drop_sites)) {
      if(!maps\mp\bots\_bots_util::func_1A32()) {
        var_01 = param_00.drop_sites[0];
        var_02 = common_scripts\utility::func_7A33(var_01);
        maps\mp\bots\_bots_strategy::func_1A8D(var_02.var_0116, 512);
      }
    } else {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      self[[self.var_6F7F]]();
    }

    return;
  }

  var_03 = param_00.var_A222.var_9D65;
  param_00.var_1B39.current_drop_site = param_00.current_drop_site;
  var_04 = [];
  var_05 = [];
  if(isDefined(var_03)) {
    var_05 = maps\mp\bots\_bots_gametype_common::func_1A08(var_03);
  }

  if(isDefined(var_03) && var_05.size > 0) {
    if(!param_00.var_1B39.was_drop_trigger_defined && maps\mp\bots\_bots_util::func_1A2D()) {
      maps\mp\bots\_bots_strategy::func_19A3();
    }

    if(func_1A25()) {
      if(!bot_is_securing_drop(var_03)) {
        bot_secure_drop(var_03, var_05, "critical", var_04);
      }
    } else if(secure_drop_objective_contains_attackers(param_00)) {
      if(func_1A35(var_03) && self method_835F() == "objective") {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!func_1A35(var_03)) {
        bot_protect_drop_nodes(var_03, var_05, "warProtectDropZone", "critical", param_00.var_A222.var_0116, var_04);
      }
    } else {
      if(bot_is_protecting_drop(var_03) && self method_835F() == "critical") {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!bot_is_protecting_drop(var_03)) {
        bot_protect_drop(var_03, 1500, "objective", var_04);
      }
    }

    if(bot_can_throw_grenade_at_secure_drop_objective(param_00, var_05)) {
      func_1B09(var_03, var_05, param_00.var_0165);
    }
  } else if(isDefined(param_00.var_1B39.current_drop_site)) {
    if(!isDefined(param_00.var_1B39.prev_drop_site) || param_00.var_1B39.prev_drop_site != param_00.var_1B39.current_drop_site) {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }
    }

    if(!maps\mp\bots\_bots_util::func_1A32()) {
      maps\mp\bots\_bots_strategy::func_1A8D(param_00.current_drop_site.var_0116, 1200);
    }

    param_00.var_1B39.prev_drop_site = param_00.var_1B39.current_drop_site;
  }

  param_00.var_1B39.was_drop_trigger_defined = isDefined(var_03);
}

bot_protect_drop(param_00, param_01, param_02, param_03) {
  self.var_291F = param_00;
  param_03["nearest_node_to_center"] = function_00BA(param_00.var_0116);
  if(!isDefined(param_03["nearest_node_to_center"])) {
    var_04 = common_scripts\utility::func_40B0(param_00.var_0116, getnodesinradius(param_00.var_0116, 256, 0));
    if(var_04.size > 0) {
      param_03["nearest_node_to_center"] = var_04[0];
    }
  }

  param_03["override_goal_type"] = param_02;
  maps\mp\bots\_bots_strategy::func_1AA6(param_00.var_0116, param_01, param_03);
}

bot_protect_drop_nodes(param_00, param_01, param_02, param_03, param_04, param_05) {
  self.var_291F = param_00;
  param_05["override_goal_type"] = param_03;
  maps\mp\bots\_bots_strategy::func_1AA7(param_01, param_04, param_02, param_05);
}

bot_is_protecting_drop(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A33() || !isDefined(self.var_291F)) {
    return 0;
  }

  return self.var_291F == param_00;
}

bot_secure_drop(param_00, param_01, param_02, param_03) {
  self.var_291F = param_00;
  param_03["override_goal_type"] = param_02;
  maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_01, param_00, param_03);
}

bot_is_securing_drop(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A28() || !isDefined(self.var_291F)) {
    return 0;
  }

  return self.var_291F == param_00;
}

bot_can_throw_grenade_at_secure_drop_objective(param_00, param_01) {
  if(func_1A2C()) {
    var_02 = 10000;
    if(!secure_drop_objective_contains_attackers(param_00)) {
      return 0;
    }

    if(func_6922(param_00, var_02)) {
      return 0;
    }
  } else if(!secure_drop_objective_contains_defenders(param_00)) {
    return 0;
  }

  var_03 = func_19F0(param_01);
  if(var_03 < self.var_3026) {
    return 1;
  }

  return 0;
}

momentum_objective_setup(param_00) {
  self botsetpathingstyle("scripted");
  self botsetflag("no_enemy_search", 1);
  self botsetflag("can_approach_bad_place_goals", 1);
  self botsetflag("dont_path_to_enemy", 1);
  if(func_1A25()) {
    if(self.var_6F7D == "cqb") {
      self.var_6903 = "build";
    } else if(self.var_6F7D == "camper") {
      self.var_6903 = "protect";
    } else {
      self.var_6903 = common_scripts\utility::func_7A33(["build", "protect"]);
    }

    self.prev_momentum_point = undefined;
    if(self.var_6903 == "protect") {
      var_01 = 0;
      foreach(var_03 in level.var_744A) {
        if(isalive(var_03) && isbot(var_03) && isDefined(var_03.var_01A7) && var_03.var_01A7 == self.var_01A7) {
          if(isDefined(var_03.var_6903) && var_03.var_6903 == "build") {
            var_01 = 1;
            break;
          }
        }
      }

      if(!var_01) {
        self.var_6903 = "build";
      }
    }

    if(self.var_6903 == "build") {
      self.var_66E4 = 1;
      self botsetflag("force_sprint", 1);
    }
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  thread func_87A5(param_00);
}

momentum_objective_think(param_00) {
  level endon("objectiveComplete");
  if(!isDefined(param_00.var_62CF)) {
    return;
  }

  var_01 = param_00.var_62CF;
  var_02 = var_01[param_00.var_292D];
  param_00.var_1B39.momentum_point_nodes = getnodesintrigger(var_02, 1);
  if(func_1A25()) {
    if(self.var_6903 == "build") {
      if(!isDefined(self.var_671B) || !isDefined(self.prev_momentum_point) || var_02 != self.prev_momentum_point) {
        self.var_671B = common_scripts\utility::func_7A33(param_00.var_1B39.momentum_point_nodes);
        self.prev_momentum_point = var_02;
        if(self getstance() == "prone") {
          self botsetstance("none");
        }
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
      }

      if(self istouching(var_02)) {
        func_7CC5();
        self botsetstance("prone");
        while(self getstance() != "prone") {
          wait 0.05;
        }

        func_A720();
        self botsetscriptgoal(self.var_0116, 0, "critical");
        while(self istouching(var_02)) {
          self botpressbutton("use", 0.6);
          wait(0.5);
        }
      }
    } else if(self.var_6903 == "protect") {
      if(!func_1A35(var_02)) {
        func_1AA4(var_02, 300);
      }
    } else {}
  } else if(!func_1A35(var_02)) {
    func_1AA4(var_02, 200);
  }

  if(bot_can_throw_grenade_at_momentum_objective(param_00)) {
    func_1B09(var_02, param_00.var_1B39.momentum_point_nodes, param_00.var_0165);
  }
}

bot_can_throw_grenade_at_momentum_objective(param_00) {
  if(func_1A2C()) {
    if(func_6922(param_00, 20000)) {
      return 0;
    }
  }

  return 1;
}

func_289A(param_00) {
  self.var_3026 = randomfloatrange(200, 1200);
  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  foreach(var_02 in param_00.var_3CC2) {
    var_03 = 0;
    if(common_scripts\utility::func_562E(var_02.var_9D9F)) {
      var_03 = 1;
      var_02 common_scripts\utility::func_9DA3();
    }

    var_02.var_6638 = getnodesinradiussorted(var_02.var_0116, 256, 0)[0];
    var_02.var_671A = getnodesintrigger(var_02, 1);
    if(var_03) {
      var_02 common_scripts\utility::func_9D9F();
    }
  }

  var_05 = [];
  foreach(var_07 in param_00.var_3CC2) {
    var_05 = common_scripts\utility::func_0F6F(var_05, var_07.var_6638);
  }

  foreach(var_0A in param_00.var_3CB8) {
    var_05 = common_scripts\utility::func_0F6F(var_05, var_0A);
  }

  var_0C = maps\mp\_utility::func_442E(var_05);
  param_00.var_1B39.var_6638 = getnodesinradiussorted(var_0C, 512, 0)[0];
  thread func_87A5(param_00);
}

func_289B(param_00) {
  level endon("objectiveComplete");
  var_01 = param_00.var_3CC2;
  var_02 = [];
  foreach(var_04 in var_01) {
    if(!isDefined(var_04.var_2566) && var_04.var_2566) {
      var_02[var_02.size] = var_04;
    }
  }

  if(func_1A25()) {
    if(!isDefined(self.var_291F) || isDefined(self.var_291F.var_2566) && self.var_291F.var_2566) {
      self.var_291F = common_scripts\utility::func_7A33(var_02);
    }

    if(func_198E()) {
      if(!isDefined(self.var_76D1)) {
        self.var_76D1 = self botgetdifficultysetting("allowGrenades");
        self.var_66E4 = 1;
        self botsetdifficultysetting("allowGrenades", 0);
        self botsetpathingstyle("scripted");
        self botsetflag("force_sprint", 1);
      }

      if(!isDefined(self.var_671B)) {
        if(param_00.var_01A5 == "tank_refuel" && isDefined(level.var_97C5)) {
          var_06 = undefined;
          foreach(var_08 in level.var_97C5) {
            if(var_08.var_003A == "script_vehicle" && var_08.var_01C4 == 0 && var_08 istouching(param_00.var_3CB8[0])) {
              var_06 = var_08;
              break;
            }
          }

          if(isDefined(var_06)) {
            self.var_671B = common_scripts\utility::func_7A33(var_06.var_1B49);
          } else {
            var_0A = getnodesintrigger(param_00.var_3CB8[0], 1);
            foreach(var_0C in var_0A) {
              if(!var_0C method_8389()) {
                self.var_671B = var_0C;
                break;
              }
            }
          }
        } else {
          var_0A = getnodesintrigger(var_04.var_3CB8[0], 1);
          foreach(var_0C in var_0A) {
            if(!var_0C method_8389()) {
              self.var_671B = var_0C;
              break;
            }
          }
        }
      }

      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
      }
    } else {
      if(isDefined(self.var_76D1)) {
        self botsetdifficultysetting("allowGrenades", self.var_76D1);
        self.var_66E4 = 0;
        self.var_76D1 = undefined;
        self botsetpathingstyle(undefined);
        self botsetflag("force_sprint", 0);
        self.var_671B = undefined;
      }

      var_10 = self.var_291F.var_A223.var_2016;
      if(func_198B(self.var_291F)) {
        if(!maps\mp\bots\_bots_util::func_1A27()) {
          if(maps\mp\bots\_bots_util::func_1A2D()) {
            maps\mp\bots\_bots_strategy::func_19A3();
          }

          self method_8358();
          var_11 = func_198C(self.var_291F);
          maps\mp\bots\_bots_strategy::func_1A0C(var_11, 500);
        }
      } else if(!func_198A(var_10)) {
        func_198F(var_10);
      } else {
        if(maps\mp\bots\_bots_util::func_1A2D()) {
          maps\mp\bots\_bots_strategy::func_19A3();
        }

        if(self method_835F() == "critical") {
          self method_8358();
        }

        if(self.var_291F.var_671A.size > 0) {
          if(!self method_8367() || distancesquared(self method_835C(), self.var_291F.var_0116) > 10000) {
            self botsetscriptgoal(common_scripts\utility::func_7A33(self.var_291F.var_671A).var_0116, 16, "objective", undefined, 300);
          }
        }
      }
    }
  } else {
    if(!isDefined(self.var_291F) || isDefined(self.var_291F.var_2566) && self.var_291F.var_2566) {
      self.var_291F = common_scripts\utility::func_7A33(var_07);
    }

    if(var_07.size > 1) {
      var_12 = func_42B4(self.var_291F);
      var_13 = func_198D(self.var_291F, var_07);
      var_14 = func_42B4(var_13);
      if(var_14.size + 1 < var_12.size) {
        self.var_291F = var_13;
      }
    }

    var_10 = self.var_291F.var_A223.var_2016;
    if(!func_198A(var_10)) {
      self botsetflag("force_sprint", 1);
      func_198F(var_10);
    } else if(!maps\mp\bots\_bots_util::func_1A33()) {
      self method_8358();
      self botsetflag("force_sprint", 0);
      var_15["nearest_node_to_center"] = self.var_291F.var_6638;
      maps\mp\bots\_bots_strategy::func_1AA6(self.var_291F.var_6638.var_0116, 700, var_15);
    }
  }

  if(func_195E(self.var_291F.var_671A)) {
    func_1B09(self.var_291F, self.var_291F.var_671A, var_05.var_0165);
  }
}

func_198E() {
  return isDefined(self.var_2013);
}

func_198B(param_00) {
  var_01 = func_198C(param_00);
  return isDefined(var_01);
}

func_198C(param_00) {
  var_01 = param_00.var_A223.var_2016;
  return var_01.var_2006;
}

func_198A(param_00) {
  return param_00 maps\mp\gametypes\_gameobjects::func_5715();
}

func_198F(param_00) {
  var_01 = param_00.var_2006;
  if(!isDefined(var_01)) {
    var_02 = param_00.var_9D65.var_0116;
  } else {
    var_02 = var_02.var_0116;
  }

  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  self botsetscriptgoal(var_02, 16, "critical");
}

func_198D(param_00, param_01) {
  var_02 = common_scripts\utility::func_0F93(param_01, param_00);
  return var_02[0];
}

func_42B4(param_00) {
  var_01 = [];
  var_02 = maps\mp\bots\_bots_gametype_common::func_41FB(game["defenders"]);
  foreach(var_04 in var_02) {
    if(isai(var_04)) {
      if(isDefined(var_04.var_291F) && var_04.var_291F == param_00) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
      }

      continue;
    }

    if(distancesquared(var_04.var_0116, param_00.var_0116) < 490000) {
      var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
    }
  }

  return var_01;
}

func_195E(param_00) {
  if(func_1A25()) {
    var_01 = func_19F0(param_00);
    if(var_01 < self.var_3026) {
      return 1;
    }
  }

  return 0;
}

opensafe_objective_setup(param_00) {
  self.var_3026 = randomfloatrange(200, 1200);
  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  foreach(var_02 in param_00.flagcontainers) {
    var_03 = 0;
    if(common_scripts\utility::func_562E(var_02.var_9D9F)) {
      var_03 = 1;
      var_02 common_scripts\utility::func_9DA3();
    }

    var_02.var_6638 = getnodesinradiussorted(var_02.var_0116, 256, 0)[0];
    var_02.var_671A = getnodesintrigger(var_02, 1);
    if(var_03) {
      var_02 common_scripts\utility::func_9D9F();
    }
  }

  foreach(var_02 in param_00.var_3CC2) {
    var_03 = 0;
    if(common_scripts\utility::func_562E(var_02.var_9D9F)) {
      var_03 = 1;
      var_02 common_scripts\utility::func_9DA3();
    }

    var_02.var_6638 = getnodesinradiussorted(var_02.var_0116, 256, 0)[0];
    var_02.var_671A = getnodesintrigger(var_02, 1);
    if(var_03) {
      var_02 common_scripts\utility::func_9D9F();
    }
  }

  var_07 = [];
  foreach(var_09 in param_00.var_3CC2) {
    var_07 = common_scripts\utility::func_0F6F(var_07, var_09.var_6638);
  }

  foreach(var_0C in param_00.var_3CB8) {
    var_07 = common_scripts\utility::func_0F6F(var_07, var_0C);
  }

  var_0E = maps\mp\_utility::func_442E(var_07);
  param_00.var_1B39.var_6638 = getnodesinradiussorted(var_0E, 512, 0)[0];
  thread func_87A5(param_00);
}

opensafe_objective_think(param_00) {
  level endon("objectiveComplete");
  var_01 = param_00.flagcontainers;
  var_02 = param_00.var_3CC2;
  var_03 = [];
  var_04 = [];
  foreach(var_06 in var_01) {
    if(!isDefined(var_06.var_2566) && var_06.var_2566) {
      var_03[var_03.size] = var_06;
    }
  }

  foreach(var_06 in var_02) {
    if(!isDefined(var_06.var_2566) && var_06.var_2566 && !common_scripts\utility::func_562E(var_06.var_9D9F) || !func_198A(var_06.var_A223.var_2016)) {
      var_04[var_04.size] = var_06;
    }
  }

  var_0A = common_scripts\utility::func_0F73(var_03, var_04);
  if(func_1A25()) {
    if(!isDefined(self.var_291F)) {
      self.var_291F = common_scripts\utility::func_7A33(var_0A);
    } else if(isDefined(self.var_291F.var_2566) && self.var_291F.var_2566) {
      self.var_291F = common_scripts\utility::func_4461(self.var_0116, var_0A);
    }

    if(func_198E()) {
      if(!isDefined(self.var_76D1)) {
        self.var_76D1 = self botgetdifficultysetting("allowGrenades");
        self.var_66E4 = 1;
        self botsetdifficultysetting("allowGrenades", 0);
        self botsetpathingstyle("scripted");
        self botsetflag("force_sprint", 1);
      }

      if(!isDefined(self.var_671B)) {
        if(param_00.var_01A5 == "tank_refuel" && isDefined(level.var_97C5)) {
          var_0B = undefined;
          foreach(var_0D in level.var_97C5) {
            if(var_0D.var_003A == "script_vehicle" && var_0D.var_01C4 == 0 && var_0D istouching(param_00.var_3CB8[0])) {
              var_0B = var_0D;
              break;
            }
          }

          if(isDefined(var_0B)) {
            self.var_671B = common_scripts\utility::func_7A33(var_0B.var_1B49);
          } else {
            var_0F = getnodesintrigger(param_00.var_3CB8[0], 1);
            foreach(var_11 in var_0F) {
              if(!var_11 method_8389()) {
                self.var_671B = var_11;
                break;
              }
            }
          }
        } else {
          var_0F = getnodesintrigger(var_04.var_3CB8[0], 1);
          foreach(var_11 in var_0F) {
            if(!var_11 method_8389()) {
              self.var_671B = var_11;
              break;
            }
          }
        }
      }

      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
        wait(1);
        return;
      }

      return;
    }

    if(isDefined(self.var_76D1)) {
      self botsetdifficultysetting("allowGrenades", self.var_76D1);
      self.var_66E4 = 0;
      self.var_76D1 = undefined;
      self botsetpathingstyle(undefined);
      self botsetflag("force_sprint", 0);
      self.var_671B = undefined;
    }

    if(common_scripts\utility::func_0F79(var_01, self.var_291F)) {
      if(self istouching(self.var_291F)) {
        func_7CC5();
        func_A720();
        self botsetscriptgoal(self.var_0116, 0, "critical");
        while(self istouching(self.var_291F) && !isDefined(self.var_291F.var_2566) && self.var_291F.var_2566) {
          self botpressbutton("use", 0.6);
          wait(0.5);
        }

        return;
      }

      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(self method_835F() == "critical") {
        self method_8358();
      }

      if(self.var_291F.var_671A.size > 0) {
        if(!self method_8367() || distancesquared(self method_835C(), self.var_291F.var_0116) > 10000) {
          self botsetscriptgoal(common_scripts\utility::func_7A33(self.var_291F.var_671A).var_0116, 16, "objective", undefined, 200);
          wait(1);
          return;
        }

        return;
      }

      return;
    }

    var_15 = self.var_291F.var_A223.var_2016;
    if(func_198B(self.var_291F)) {
      if(!maps\mp\bots\_bots_util::func_1A27()) {
        if(maps\mp\bots\_bots_util::func_1A2D()) {
          maps\mp\bots\_bots_strategy::func_19A3();
        }

        self method_8358();
        var_16 = func_198C(self.var_291F);
        maps\mp\bots\_bots_strategy::func_1A0C(var_16, 500);
        return;
      }

      return;
    }

    if(!func_198A(var_15)) {
      func_198F(var_15);
      return;
    }

    if(maps\mp\bots\_bots_util::func_1A2D()) {
      maps\mp\bots\_bots_strategy::func_19A3();
    }

    if(self method_835F() == "critical") {
      self method_8358();
    }

    if(self.var_291F.var_671A.size > 0) {
      if(!self method_8367() || distancesquared(self method_835C(), self.var_291F.var_0116) > 10000) {
        self botsetscriptgoal(common_scripts\utility::func_7A33(self.var_291F.var_671A).var_0116, 16, "objective", undefined, 200);
        wait(1);
        return;
      }

      return;
    }

    return;
  }

  if(!isDefined(self.var_291F) || isDefined(self.var_291F.var_2566) && self.var_291F.var_2566) {
    self.var_291F = common_scripts\utility::func_7A33(var_0A);
  }

  if(var_0A.size > 1) {
    var_17 = func_42B4(self.var_291F);
    var_18 = func_198D(self.var_291F, var_0A);
    var_19 = func_42B4(var_18);
    if(var_19.size + 1 < var_17.size) {
      self.var_291F = var_18;
    }
  }

  if(!common_scripts\utility::func_0F79(var_01, self.var_291F)) {
    var_15 = self.var_291F.var_A223.var_2016;
    if(!func_198A(var_15)) {
      self botsetflag("force_sprint", 1);
      func_198F(var_15);
      return;
    }

    return;
  }

  if(!maps\mp\bots\_bots_util::func_1A33()) {
    self method_8358();
    self botsetflag("force_sprint", 0);
    var_1A["nearest_node_to_center"] = self.var_291F.var_6638;
    maps\mp\bots\_bots_strategy::func_1AA6(self.var_291F.var_6638.var_0116, 700, var_1A);
    return;
  }
}

destruction_objective_is_ready_to_set_up(param_00) {
  var_01 = param_00 lib_0502::func_207C("destructionTarget");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_006A) || !isDefined(var_03.var_00FB)) {
      return 0;
    }
  }

  return 1;
}

destruction_objective_setup(param_00) {
  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  param_00.var_1B39.destructiontargets = param_00 lib_0502::func_207C("destructionTarget");
  foreach(var_02 in param_00.var_1B39.destructiontargets) {
    var_03 = var_02 lib_0502::func_207C("destructionNode");
    var_02.var_010D = var_03[0];
    var_02 thread makedestructiontargetsentient(param_00);
  }

  var_05 = maps\mp\_utility::func_442E(param_00.var_1B39.destructiontargets);
  var_06 = getnodesinradius(var_05, 512, 0);
  param_00.var_1B39.var_6638 = common_scripts\utility::func_40B0(var_05, var_06)[0];
  var_07 = common_scripts\utility::func_0F73(param_00 lib_0502::func_207C("destructionOvertimeZone"), param_00 lib_0502::func_207C("overtime_trigger"));
  param_00.objective_zone_trigger = var_07[0];
  var_08 = getnodearray("defenders_dont_use", "script_noteworthy");
  foreach(var_0A in var_08) {
    nodesetinvalidforteam(var_0A, game["defenders"], 1);
  }

  thread func_87A5(param_00);
}

makedestructiontargetsentient(param_00) {
  common_scripts\utility::func_5FA9(game["defenders"], undefined, undefined, undefined, 1);
  self.var_01AA = -500;
  waittill_destruction_entity_destroyed(param_00);
  common_scripts\utility::free_entity_sentient_mp();
}

waittill_destruction_entity_destroyed(param_00) {
  var_01 = lib_04FF::func_6937(param_00.var_695A);
  while(!destruction_target_is_destroyed(self) && !common_scripts\utility::func_3C77(var_01)) {
    wait 0.05;
  }
}

destruction_target_is_destroyed(param_00) {
  return param_00.var_006A >= param_00.var_00FB;
}

destruction_target_is_repairable(param_00) {
  return common_scripts\utility::func_562E(param_00.repairenabled) && common_scripts\utility::func_562E(param_00.canrepair) && param_00 method_8562() && param_00 method_8691(self);
}

destruction_objective_think(param_00) {
  level endon("objectiveComplete");
  if(!isDefined(self.objectivetarget) || destruction_target_is_destroyed(self.objectivetarget)) {
    self.objectivetarget = get_new_destruction_target(param_00);
    self.var_671B = undefined;
    if(isDefined(self.objectivetarget) && func_1A25()) {
      var_01 = function_0204(self.objectivetarget.var_010D);
      var_02 = common_scripts\utility::func_40B1(self.objectivetarget.var_010D.var_0116, var_01);
      self.var_671B = var_02[randomint(3)];
    }
  }

  if(func_1A25()) {
    if(isDefined(self.var_671B)) {
      self botsetscriptgoalnode(self.var_671B, "guard");
    }

    foreach(var_04 in param_00.var_1B39.destructiontargets) {
      if(!destruction_target_is_destroyed(var_04)) {
        self getenemyinfo(var_04);
      }
    }

    return;
  }

  if(!maps\mp\bots\_bots_util::func_1A1C()) {
    var_06 = [];
    var_07 = get_repairable_objects(param_00);
    foreach(var_09 in var_07) {
      if(self method_8371(var_09, 1)) {
        var_06[var_06.size] = var_09;
      }
    }

    if(var_06.size > 0) {
      var_0B = common_scripts\utility::func_7A33(var_06);
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      self botsetscriptgoal(var_0B.var_010D.var_0116, 0, "guard", vectortoangles(var_0B.var_0116 - var_0B.var_010D.var_0116)[1]);
      var_0C = maps\mp\bots\_bots_util::func_1B21();
      if(var_0C == "goal") {
        while(isDefined(var_0B) && !destruction_target_is_destroyed(var_0B) && destruction_target_is_repairable(var_0B)) {
          if(!self method_8367() || !maps\mp\bots\_bots_util::func_1B1C(self method_835C(), var_0B.var_010D.var_0116)) {
            break;
          }

          self botpressbutton("use", 0.3);
          wait(0.25);
        }
      }
    }
  }

  if(isDefined(param_00.var_5024) && param_00.var_5024 == "contested") {
    var_0D = get_alive_destruction_targets(param_00);
    if(!isDefined(self.objectivecounter) || self.objectivecounter != var_0D.size) {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      self.objectivecounter = var_0D.size;
    }

    if(!func_1A35(param_00.overtimezone)) {
      var_0D = get_alive_destruction_targets(param_00);
      var_0E = [];
      foreach(var_04 in var_0D) {
        var_10 = maps\mp\_utility::array_combine_no_dupes([var_04.var_010D], function_0204(var_04.var_010D));
        var_0E = maps\mp\_utility::array_combine_no_dupes(var_0E, var_10);
      }

      if(var_0E.size > 0) {
        func_1AA5(param_00.objective_zone_trigger, var_0E, "warDestructionDefendTargets", undefined, undefined);
        return;
      }

      return;
    }

    return;
  }

  if(!func_1A35(self.objectivetarget)) {
    func_1AA4(self.objectivetarget, level.botsdestructionobjectivedefenseradius);
    return;
  }
}

get_repairable_objects(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_1B39.destructiontargets) {
    if(!destruction_target_is_destroyed(var_03) && destruction_target_is_repairable(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

get_alive_destruction_targets(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_1B39.destructiontargets) {
    if(!destruction_target_is_destroyed(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

get_new_destruction_target(param_00) {
  if(isDefined(self.objectivetarget) && func_1A25()) {
    var_01 = common_scripts\utility::func_40B0(self.var_0116, param_00.var_1B39.destructiontargets);
  } else {
    var_01 = common_scripts\utility::func_0F92(var_01.var_1B39.destructiontargets);
  }

  foreach(var_03 in var_01) {
    if(!destruction_target_is_destroyed(var_03)) {
      return var_03;
    }
  }
}

hostage_objective_setup(param_00, param_01, param_02) {
  var_03 = !common_scripts\utility::func_562E(param_02);
  if(var_03) {
    self.var_6903 = common_scripts\utility::func_7A33(["quick", "careful"]);
  }

  if(isDefined(param_00.var_1B39)) {
    return;
  }

  param_00.var_1B39 = spawnStruct();
  param_00.rescue_hostage_triggers = param_00 lib_0502::func_207C("hostage_rescue_trigger");
  foreach(var_05 in param_00.rescue_hostage_triggers) {
    var_05.var_671A = getnodesintrigger(var_05, 1);
  }

  var_07 = param_00 lib_0502::func_207C("door_trigger");
  param_00.doortrigger = var_07[0];
  param_00.doortrigger.var_671A = getnodesintrigger(param_00.doortrigger, 1);
  var_08 = param_00 lib_0502::func_207C("hostage_room_trigger");
  param_00.hostage_room_trigger = var_08[0];
  param_00.hostage_room_trigger.var_671A = getnodesintrigger(param_00.hostage_room_trigger, 1);
  var_09 = param_00 lib_0502::func_207C("hostage_building_trigger");
  param_00.hostage_building_trigger = var_09[0];
  param_00.hostage_building_trigger.var_671A = getnodesintrigger(param_00.hostage_building_trigger, 1);
  var_0A = maps\mp\_utility::func_442E(param_00.rescue_hostage_triggers);
  param_00.var_1B39.var_6638 = function_00BA(var_0A);
  if(!common_scripts\utility::func_562E(param_01)) {
    thread func_87A5(param_00);
  }
}

hostage_objective_think(param_00) {
  level endon("objectiveComplete");
  if(func_1A25()) {
    if(!common_scripts\utility::func_562E(param_00.doorunlocked)) {
      bot_use_raid_trigger(param_00.doortrigger);
      return;
    }

    if(!isDefined(self.objectivetarget)) {
      var_01 = [];
      foreach(var_03 in param_00.rescue_hostage_triggers) {
        if(isDefined(var_03)) {
          var_01[var_01.size] = var_03;
        }
      }

      self.objectivetarget = common_scripts\utility::func_7A33(var_01);
    }

    if(isDefined(self.objectivetarget)) {
      bot_use_raid_trigger(self.objectivetarget);
      return;
    }

    return;
  }

  if(param_00.var_5024 == "inUse" || param_00.var_5024 == "contested") {
    if(!common_scripts\utility::func_562E(param_00.doorunlocked)) {
      if(!func_1A35(param_00.doortrigger)) {
        func_1AA5(param_00.doortrigger, param_00.doortrigger.var_671A, "warHostageObjDefendDoor", undefined, undefined);
        return;
      }

      return;
    }

    if(!func_1A35(param_00.hostage_room_trigger)) {
      func_1AA5(param_00.hostage_room_trigger, param_00.hostage_room_trigger.var_671A, "warHostageObjDefendRoom", undefined, undefined);
      return;
    }

    return;
  }

  if(!func_1A35(param_00.hostage_building_trigger)) {
    if(!isDefined(param_00.var_1B39.var_2C35)) {
      param_00.var_1B39.var_2C35 = [];
      foreach(var_06 in param_00.hostage_building_trigger.var_671A) {
        if(common_scripts\utility::func_562E(level.var_A27E["both"][function_0366(var_06)])) {
          param_00.var_1B39.var_2C35[param_00.var_1B39.var_2C35.size] = var_06;
        }
      }
    }

    func_1AA5(param_00.hostage_building_trigger, param_00.var_1B39.var_2C35, "warHostageObjDefend", undefined, undefined);
    return;
  }
}

is_hostage_objective(param_00) {
  return param_00 == "hostageObjective";
}

func_1B24(param_00) {
  if(!isDefined(self.var_66B9)) {
    self.var_66B9 = gettime() + randomintrange(2000, 8000);
  }

  if(gettime() < self.var_66B9) {
    return;
  }

  self.var_66B9 = gettime() + randomintrange(2000, 8000);
  if(common_scripts\utility::func_562E(self.var_66E4)) {
    return;
  }

  if(!isDefined(param_00.var_1B39.var_08E7) || param_00.var_1B39.var_08E7.size == 0) {
    return;
  }

  if(maps\mp\bots\_bots_strategy::func_1A14("build_wall") || self method_835F() == "tactical") {
    return;
  }

  if(maps\mp\bots\_bots_util::func_1A1C() || maps\mp\bots\_bots_util::func_1A36()) {
    return;
  }

  var_01 = [];
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.var_1B39.var_08E7.size; var_03++) {
    var_04 = param_00.var_1B39.var_08E7[var_03];
    if(func_A7CB(var_04)) {
      param_00.var_1B39.var_08E7[var_03] = param_00.var_1B39.var_08E7[param_00.var_1B39.var_08E7.size - 1];
      param_00.var_1B39.var_08E7[param_00.var_1B39.var_08E7.size - 1] = undefined;
      var_03--;
      continue;
    }

    if(func_A7CA(var_04)) {
      continue;
    }

    if(!func_1AFB(var_04)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_04.onlyusewhenbuilt)) {
      if(var_04.var_2599) {
        var_01[var_01.size] = var_04;
      }
    } else if(!var_04.var_2599) {
      var_01[var_01.size] = var_04;
    }

    if(var_04.var_5708) {
      var_02[var_02.size] = var_04;
    }
  }

  if(var_01.size == 0 && var_02.size == 0) {
    return;
  }

  var_05 = common_scripts\utility::func_0F73(var_01, var_02);
  var_06 = common_scripts\utility::func_40B0(self.var_0116, var_05);
  var_07 = 512;
  if(isDefined(level.bots_build_walls_radius)) {
    var_07 = level.bots_build_walls_radius;
  }

  var_08 = distance(self.var_0116, var_06[0].var_0116);
  if(var_08 < 0 || var_08 > var_07) {
    return;
  }

  var_09 = 25;
  if(func_6922(param_00, 20000)) {
    var_09 = var_09 + 25;
  }

  if(maps\mp\bots\_bots_util::func_193A()) {
    if(var_08 < 64) {
      var_09 = var_09 + 50;
    } else if(var_08 < 128) {
      var_09 = var_09 + 35;
    } else if(var_08 < 256) {
      var_09 = var_09 + 25;
    }
  }

  if(randomint(100) >= var_09) {
    return;
  }

  var_0A = var_06[0];
  if(common_scripts\utility::func_562E(var_0A.var_1956)) {
    var_0B = common_scripts\utility::func_7A33([var_0A.var_19A5, var_0A.var_193D]);
  } else if(func_1A2F()) {
    var_0B = var_0B.var_19A5;
  } else {
    var_0B = var_0B.var_193D;
  }

  var_0C = undefined;
  if(func_1A25()) {
    var_0C = common_scripts\utility::func_7A33(var_0B.build_nodes_attackers_team);
  } else if(func_1A2C()) {
    var_0C = common_scripts\utility::func_7A33(var_0B.build_nodes_defenders_team);
  }

  var_0D = spawnStruct();
  var_0D.var_68FB = var_0A;
  var_0D.var_087F = ::func_1D30;
  var_0D.var_8B3E = ::func_1D31;
  var_0D.var_81CA = vectortoangles(var_0A.var_0116 - var_0C.var_0116)[1];
  var_0D.var_6C13 = param_00.var_695A;
  maps\mp\bots\_bots_strategy::func_1A85("build_wall", var_0C.var_0116, 10, var_0D);
}

func_1AFB(param_00) {
  if(param_00.var_1B46 == "defenders" && func_1A25()) {
    return 0;
  }

  if(param_00.var_1B46 == "attackers" && func_1A2C()) {
    return 0;
  }

  if(param_00.var_1B4F == "defending" && func_1A26()) {
    return 0;
  }

  if(param_00.var_1B4F == "attacking" && func_1A2F()) {
    return 0;
  }

  return 1;
}

func_A7C5(param_00) {
  if(!isDefined(param_00.var_19A5.var_A240)) {
    return 0;
  }

  if(!isDefined(param_00.var_193D.var_A240)) {
    return 0;
  }

  return 1;
}

func_A7CA(param_00) {
  if(isDefined(param_00.var_19A5.var_A240) && common_scripts\utility::func_562E(param_00.var_19A5.var_A240.var_54F5)) {
    return 1;
  }

  if(isDefined(param_00.var_193D.var_A240) && common_scripts\utility::func_562E(param_00.var_193D.var_A240.var_54F5)) {
    return 1;
  }

  return 0;
}

func_A7CB(param_00) {
  if(!isDefined(param_00.var_19A5)) {
    return 1;
  }

  if(!isDefined(param_00.var_193D)) {
    return 1;
  }

  return 0;
}

func_1D30(param_00) {
  var_01 = param_00.var_68FB;
  var_02 = 0;
  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_02 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_02 = 80;
  }

  func_7CC5();
  var_03 = 0;
  if(randomint(100) < var_02) {
    var_03 = 1;
    self botsetstance("prone");
    wait(0.5);
  }

  func_A720();
  if(var_01.var_56FC || !func_A7C5(var_01) || func_A7CA(var_01)) {
    if(var_03) {
      self botsetstance("none");
    }

    self.var_1B2F = undefined;
    return;
  }

  childthread maps\mp\bots\_bots_gametype_common::func_67FA();
  var_04 = var_01.var_19A5.var_A240.var_A23F / 1000 + 1;
  self botpressbutton("use", var_04);
  var_05 = maps\mp\bots\_bots_util::func_1B16(var_04, "use_interrupted");
  if(var_03) {
    self botsetstance("none");
  }

  self.var_1B2F = undefined;
}

func_1D31(param_00) {
  var_01 = param_00.var_68FB;
  if(!isDefined(var_01)) {
    return 1;
  }

  if(var_01.var_56FC) {
    return 1;
  }

  if(!func_A7C5(var_01)) {
    return 1;
  }

  if(func_A7CA(var_01)) {
    return 1;
  }

  if(maps\mp\bots\_bots_util::func_1A1C()) {
    return 1;
  }

  var_02 = func_412E();
  if(!isDefined(var_02) || var_02.var_695A != param_00.var_6C13) {
    return 1;
  }

  return 0;
}

func_3B86(param_00) {
  param_00.var_1B39.var_08E7 = [];
  var_01 = lib_04F7::func_440F();
  foreach(var_03 in var_01) {
    var_03.var_19A5 = undefined;
    var_03.var_193D = undefined;
    var_03.var_1956 = undefined;
    var_03.var_1B46 = "any";
    var_03.var_1B47 = "any";
    var_03.var_1B4F = "defending";
    var_03.botwhencandestroy = "attacking";
  }

  var_05 = [];
  foreach(var_03 in var_01) {
    if(common_scripts\utility::func_562E(var_03.var_2F16)) {
      continue;
    }

    if(isDefined(var_03.var_8260)) {
      if(var_03.var_8260 == "raid_wall_single_destroy") {
        continue;
      }

      if(var_03.var_8260 == "bots_ignore") {
        continue;
      }
    }

    var_05[var_05.size] = var_03;
  }

  foreach(var_03 in var_05) {
    wall_calculate_defender_and_attacker_triggers(param_00, var_03);
    if(!isDefined(var_03.var_19A5) || !isDefined(var_03.var_193D)) {
      continue;
    }

    if(isDefined(var_03.var_8251)) {
      if(issubstr(var_03.var_8251, "bot_defender_team_only")) {
        var_03.var_1B46 = "defenders";
        var_03.var_1B47 = "attackers";
      } else if(issubstr(var_03.var_8251, "bot_attacker_team_only")) {
        var_03.var_1B46 = "attackers";
        var_03.var_1B47 = "defenders";
      }

      if(issubstr(var_03.var_8251, "bot_zone_attackers_only")) {
        var_03.var_1B4F = "attacking";
        var_03.botwhencandestroy = "defending";
      }
    }

    param_00.var_1B39.var_08E7[param_00.var_1B39.var_08E7.size] = var_03;
    if(var_03.var_56FC) {
      var_09 = var_03 lib_0502::func_207C("bomb_traversal_start");
      var_03 func_1A11(var_09);
    }
  }
}

wall_calculate_defender_and_attacker_triggers(param_00, param_01) {
  if(isDefined(param_01.var_8260) && param_01.var_8260 == "bots_destroy_as_build") {
    param_01.onlyusewhenbuilt = 1;
    var_02 = param_01 lib_0502::func_207D("explosive_trigger");
    param_01.var_19A5 = var_02[0];
    param_01.var_19A5.build_nodes_defenders_team = getnodesintrigger(param_01.var_19A5, 1);
    param_01.var_193D = param_01.var_19A5;
    return;
  }

  if(!isDefined(param_01.var_19A5) || !isDefined(param_01.var_193D)) {
    var_02 = param_01 lib_0502::func_207D("repair_trigger");
    foreach(var_04 in var_02) {
      var_05 = var_04.var_A240.var_5412 == "none";
      if(var_05) {
        var_04.var_0116 = var_04.var_0116 + (0, 0, 50000);
      }

      var_04.build_nodes_all = getnodesintrigger(var_04, 1);
      var_04.build_nodes_defenders_team = [];
      foreach(var_07 in var_04.build_nodes_all) {
        var_08 = function_0366(var_07);
        if(common_scripts\utility::func_562E(level.var_A27E["defenders"][var_08])) {
          var_04.build_nodes_defenders_team[var_04.build_nodes_defenders_team.size] = var_07;
        }
      }

      var_04.build_nodes_attackers_team = [];
      foreach(var_07 in var_04.build_nodes_all) {
        var_08 = function_0366(var_07);
        if(common_scripts\utility::func_562E(level.var_A27E["attackers"][var_08])) {
          var_04.build_nodes_attackers_team[var_04.build_nodes_attackers_team.size] = var_07;
        }
      }

      if(var_05) {
        var_04.var_0116 = var_04.var_0116 - (0, 0, 50000);
      }
    }

    if(!wall_triggers_are_reachable_for_current_objective(var_02)) {
      return;
    }

    if(var_02.size == 2) {
      var_0D = getpathdist(param_00.var_1B39.var_6638.var_0116, maps\mp\_utility::func_442E(var_02[0].build_nodes_all));
      var_0E = getpathdist(param_00.var_1B39.var_6638.var_0116, maps\mp\_utility::func_442E(var_02[1].build_nodes_all));
      if(var_0D < var_0E) {
        param_01.var_19A5 = var_02[0];
        param_01.var_193D = var_02[1];
      } else {
        param_01.var_19A5 = var_02[1];
        param_01.var_193D = var_02[0];
      }

      if(isDefined(param_01.var_8251)) {
        if(issubstr(param_01.var_8251, "bot_reverse_defenders_side")) {
          var_0F = param_01.var_19A5;
          var_10 = param_01.var_193D;
          param_01.var_19A5 = var_10;
          param_01.var_193D = var_0F;
        }

        if(issubstr(param_01.var_8251, "bot_build_either_side")) {
          param_01.var_1956 = 1;
          return;
        }

        return;
      }

      return;
    }

    if(var_04.size == 1) {
      var_03.var_19A5 = var_04[0];
      var_03.var_193D = var_04[0];
      return;
    }

    return;
  }
}

wall_triggers_are_reachable_for_current_objective(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.build_nodes_defenders_team.size > 0 && var_02.build_nodes_attackers_team.size > 0) {
      return 1;
    }
  }

  return 0;
}

func_1A11(param_00) {
  if(!isDefined(self.var_1B47)) {
    return;
  }

  foreach(var_02 in param_00) {
    var_03 = "";
    var_04 = "";
    if(self.var_1B47 == "any") {
      if(self.botwhencandestroy == "attacking") {
        var_03 = game["defenders"];
        var_04 = game["attackers"];
        if(func_193E()) {
          var_03 = game["attackers"];
          var_04 = game["defenders"];
        }

        if(isDefined(self.var_982D) && isDefined(self.var_982D["build_animated"]) && isDefined(self.var_982D["build_animated"][0]) && isDefined(self.var_982D["build_animated"][0].var_0106) && self.var_982D["build_animated"][0].var_0106 == "tun_guard_tower_01") {
          var_05 = var_03;
          var_03 = var_04;
          var_04 = var_05;
        }
      } else if(self.botwhencandestroy == "defending") {
        var_03 = game["attackers"];
        var_04 = game["defenders"];
        if(func_193E()) {
          var_03 = game["defenders"];
          var_04 = game["attackers"];
        }
      }
    } else if(self.var_1B47 == "defenders") {
      var_03 = game["attackers"];
      var_04 = game["defenders"];
    } else if(self.var_1B47 == "attackers") {
      var_03 = game["defenders"];
      var_04 = game["attackers"];
    }

    nodesetinvalidforteam(var_02, var_03, 1);
    nodesetinvalidforteam(var_02, var_04, 0);
  }
}

func_395C() {
  self notify("explosive_traversal_killstreak_think");
  self endon("explosive_traversal_killstreak_think");
  for(;;) {
    if(has_use_object_traversal_on_path()) {
      func_7CC5();
      while(has_use_object_traversal_on_path()) {
        wait 0.05;
      }

      self.var_1B2F = undefined;
    }

    wait 0.05;
  }
}

has_use_object_traversal_on_path() {
  var_00 = self method_86AC();
  if(isDefined(var_00)) {
    if(var_00.var_001E == "bot_plant_bomb" || var_00.var_001E == "bot_use_object") {
      return 1;
    }
  }

  return 0;
}

func_194C(param_00) {
  if(!isDefined(self.var_66B8)) {
    self.var_66B8 = gettime() + randomintrange(2000, 10000);
  }

  if(gettime() < self.var_66B8) {
    return;
  }

  self.var_66B8 = gettime() + randomintrange(2000, 10000);
  if(common_scripts\utility::func_562E(self.var_66E4)) {
    return;
  }

  if(!isDefined(param_00.var_1B39.var_08E5) || param_00.var_1B39.var_08E5.size == 0) {
    return;
  }

  if(maps\mp\bots\_bots_strategy::func_1A14("build_turret") || self method_835F() == "tactical") {
    return;
  }

  if(maps\mp\bots\_bots_util::func_1A1C() || maps\mp\bots\_bots_util::func_1A36()) {
    return;
  }

  var_01 = [];
  foreach(var_03 in param_00.var_1B39.var_08E5) {
    if(func_9F2F(var_03)) {
      continue;
    }

    if(func_9F2E(var_03) || !isDefined(var_03.var_1D4F)) {
      continue;
    }

    if(func_1A25() && common_scripts\utility::func_562E(var_03.var_2C7F)) {
      continue;
    }

    if(func_1A2C() && common_scripts\utility::func_562E(var_03.var_119B)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  if(var_01.size == 0) {
    return;
  }

  var_05 = common_scripts\utility::func_40B0(self.var_0116, var_01);
  var_06 = 512;
  var_07 = distance(self.var_0116, var_05[0].var_0116);
  if(var_07 < 0 || var_07 > var_06) {
    return;
  }

  var_08 = 25;
  if(func_6922(param_00, 20000)) {
    var_08 = var_08 + 25;
  }

  if(maps\mp\bots\_bots_util::func_193A()) {
    var_09 = anglesToForward(self getangles());
    var_0A = anglesToForward(var_05[0].var_001D);
    if(vectordot(var_09, var_0A) > 0.5) {
      if(var_07 < 64) {
        var_08 = var_08 + 50;
      } else if(var_07 < 128) {
        var_08 = var_08 + 35;
      } else if(var_07 < 256) {
        var_08 = var_08 + 25;
      }
    }
  }

  if(randomint(100) >= var_0A) {
    return;
  }

  var_0B = var_07[0];
  var_0C = spawnStruct();
  var_0C.var_68FB = var_0B;
  var_0C.var_087F = ::func_1D2C;
  var_0C.var_8B3E = ::func_1D2D;
  var_0C.var_81CA = var_0B.var_010D.var_001D[1];
  var_0C.var_6C13 = var_02.var_695A;
  maps\mp\bots\_bots_strategy::func_1A85("build_turret", var_0B.var_010D.var_0116, 10, var_0C);
}

func_1B15() {
  self notify("bot_use_turret_think");
  self endon("bot_use_turret_think");
  for(;;) {
    common_scripts\utility::func_A71A(randomfloatrange(2, 10), "built_turret");
    if(common_scripts\utility::func_562E(self.var_66E4)) {
      continue;
    }

    var_00 = func_412E();
    if(!isDefined(self.var_9EF3)) {
      if(!isDefined(var_00) || !isDefined(var_00.var_1B39)) {
        continue;
      }

      if(!isDefined(var_00.var_1B39.var_08E5) || var_00.var_1B39.var_08E5.size == 0) {
        continue;
      }

      if(maps\mp\bots\_bots_strategy::func_1A14()) {
        continue;
      }

      if(maps\mp\bots\_bots_util::func_1A1C() || maps\mp\bots\_bots_util::func_1A36()) {
        continue;
      }

      var_01 = [];
      foreach(var_03 in var_00.var_1B39.var_08E5) {
        if(!var_03 method_8562()) {
          continue;
        }

        if(isDefined(var_03.var_003A) && var_03.var_003A == "misc_turret" && isDefined(var_03 method_80E2())) {
          continue;
        }

        if(func_9F2F(var_03)) {
          continue;
        }

        if(func_1A25() && common_scripts\utility::func_562E(var_03.var_2C7F)) {
          continue;
        }

        if(func_1A2C() && common_scripts\utility::func_562E(var_03.var_119B)) {
          continue;
        }

        if(var_03.var_01B9 == "emplaced" && !self botnodeavailable(var_03.var_010D)) {
          continue;
        }

        var_01[var_01.size] = var_03;
      }

      if(var_01.size == 0) {
        continue;
      }

      var_05 = common_scripts\utility::func_40B0(self.var_0116, var_01);
      var_06 = var_05[0];
      var_07 = 512;
      if(isDefined(var_06.var_8260) && var_06.var_8260 == "tower_turret") {
        var_07 = 2048;
      }

      if(isDefined(level.botgetmaxturretdistscalar)) {
        var_07 = var_07 * [[level.botgetmaxturretdistscalar]](var_06);
      }

      var_08 = distance2d(self.var_0116, var_06.var_0116);
      if(var_08 < 0 || var_08 > var_07) {
        continue;
      }

      var_09 = 25;
      var_0A = 20000;
      if(level.var_015D == "mp_raid_d_day" && var_00.var_695A == "capture_bunkers" && func_1A2C()) {
        var_0A = -5536;
      }

      if(func_6922(var_00, var_0A)) {
        var_09 = var_09 + 25;
      }

      if(isDefined(level.botgetincreasedturretchance)) {
        var_09 = var_09 + [[level.botgetincreasedturretchance]](var_06);
      }

      if(maps\mp\bots\_bots_util::func_193A() && var_06.var_01B9 == "emplaced") {
        var_0B = anglesToForward(self getangles());
        var_0C = anglesToForward(var_06.var_001D);
        if(vectordot(var_0B, var_0C) > 0.5) {
          if(var_08 < 64) {
            var_09 = var_09 + 50;
          } else if(var_08 < 128) {
            var_09 = var_09 + 35;
          } else if(var_08 < 256) {
            var_09 = var_09 + 25;
          }
        }
      } else if(var_08.var_01B9 == "trigger_on_vehicle") {
        if(self method_8367()) {
          if(distancesquared(self method_835C(), var_08.var_0116) < 65536) {
            var_0D = var_0D + 25;
          }
        }
      }

      if(randomint(100) >= var_0D) {
        continue;
      }

      var_0B = var_08;
    } else {
      var_0B = self.var_9EF3;
    }

    childthread func_6357(var_0B);
    var_0C = "";
    if(var_0B.var_01B9 == "trigger_on_vehicle") {
      var_0F = var_0B.var_9EDD.var_A2C8;
      childthread func_7A97(var_0F);
      for(;;) {
        var_0C = maps\mp\bots\_bots_util::func_1B21(undefined, "turret_invalid", "touching_turret", "new_objective");
        if(var_0C != "script_goal_changed") {
          break;
        }
      }
    } else {
      var_10 = undefined;
      if(var_0B.var_01B9 == "stationary_trigger") {
        var_11 = getnodesintrigger(var_0B, 1);
        var_10 = common_scripts\utility::func_7A33(var_11);
      } else {
        var_10 = var_0B.var_010D;
      }

      self botsetscriptgoalnode(var_10, "tactical", var_10.var_001D[1]);
      var_12 = self method_84D1(1);
      if(isDefined(var_12) && var_12 == var_0B) {
        var_0C = "touching_turret";
      } else {
        var_0C = maps\mp\bots\_bots_util::func_1B21(undefined, "turret_invalid", "touching_turret", "new_objective");
      }
    }

    self notify("done_seeking_turret");
    if(var_12 == "goal" || var_12 == "touching_turret") {
      if(function_01EF(self)) {
        common_scripts\utility::func_0615();
        var_10 enableplayeruse(self);
        wait 0.05;
      }

      wait 0.05;
      self botpressbutton("use", 0.5);
      wait(0.5);
      if(!self isusingturret()) {
        self botpressbutton("use", 0.5);
        wait(0.5);
      }

      if(self isusingturret()) {
        var_13 = randomfloatrange(12, 24);
        var_14 = undefined;
        if(isDefined(var_04)) {
          var_14 = var_04;
          if(isDefined(self.var_94CD)) {
            var_14 = self.var_94CD;
          }
        }

        if(isDefined(var_14)) {
          if(func_5575(var_14.var_0165) && var_10.var_01B9 == "trigger_on_vehicle") {
            if(var_14.var_A2C8.var_9EDD == var_10.var_9EDD) {
              var_13 = 99999;
              childthread bot_vehicle_turret_watch_for_contested(var_10);
            }
          }

          if(var_14.var_0165 == "useHoldBuildObjective" && isDefined(var_14.var_1B39)) {
            var_15 = "attackers";
            if(func_1A2C()) {
              var_15 = "defenders";
            }

            var_16 = func_4206(var_14, var_15);
            if(var_15 == "defenders") {
              var_16 = common_scripts\utility::func_0F6F(var_16, common_scripts\utility::func_7A33(var_14.var_1B39.var_1D2B));
            }

            childthread maps\mp\bots\_bots_util::func_1B2A(var_16);
            childthread func_1AAC();
          } else if(var_10.var_01B9 == "emplaced") {
            var_17 = var_10 method_85A4();
            var_18 = var_10 method_85A3();
            var_19 = var_10 method_84BC();
            var_1A = var_10 method_84BB();
            var_1B = findentrances(self.var_0116);
            var_16 = [];
            var_1C = 0;
            while(var_16 < var_1A.size) {
              var_1C = var_1A[var_16];
              var_1D = var_1C.var_0116 - var_0C.var_0116;
              var_1E = vectortoangles(var_1D);
              var_1F = angleclamp180(var_1E[0] - var_0C.var_001D[0]);
              if(var_1F > 0 && var_1F > var_18) {
                continue;
              }

              if(var_1F < 0 && -1 * var_1F > var_19) {
                continue;
              }

              var_20 = angleclamp180(var_1E[1] - var_0C.var_001D[1]);
              if(var_20 > 0 && var_20 > var_17) {
                continue;
              }

              if(var_20 < 0 && -1 * var_20 > var_14) {
                continue;
              }

              var_1B[var_1B.size] = var_1C;
              var_16++;
            }

            childthread maps\mp\bots\_bots_util::func_1B2A(var_1B);
            childthread func_1AAC();
          }
        }

        childthread bot_force_exit_turret_on_damage(var_10);
        if(is_capture_objective(var_14.var_0165)) {
          childthread bot_force_exit_turret_enemy_in_capture_zone(var_10);
        }

        if(func_5575(var_14.var_0165)) {
          childthread bot_force_exit_turret_for_hedgehog(var_10);
        }

        childthread bot_force_exit_turret_on_destroyed(var_10);
        var_12 = common_scripts\utility::func_A71A(var_13, "new_objective", "force_turret_exit");
        while(maps\mp\bots\_bots_util::func_1A1C() && !isDefined(var_12) || var_12 != "force_turret_exit") {
          wait 0.05;
        }

        if(self isusingturret()) {
          self botpressbutton("use", 1);
        }

        self notify("exited_turret");
      }

      self method_8358();
      if(function_01EF(self)) {
        common_scripts\utility::func_0601();
        if(isDefined(var_13)) {
          var_13 disableplayeruse(self);
        }
      }
    } else if(var_14 != "script_goal_changed") {
      self method_8358();
    }

    self.var_9EF3 = undefined;
  }
}

bot_vehicle_turret_watch_for_contested(param_00) {
  self endon("exited_turret");
  param_00 endon("death");
  var_01 = param_00.var_9EDD.var_A2C8;
  if(!isDefined(var_01) || !isDefined(var_01.var_0112)) {
    return;
  }

  for(;;) {
    if(var_01.var_0112.var_5024 == "contested") {
      if(!isDefined(self.var_0088) || !self method_8371(self.var_0088)) {
        var_02 = vectornormalize(anglesToForward(self.var_001D) * (1, 1, 0));
        var_03 = [];
        foreach(var_05 in var_01.var_1B49) {
          var_06 = vectornormalize(var_05.var_0116 - self.var_0116 * (1, 1, 0));
          var_07 = vectordot(var_02, var_06);
          if(var_07 <= 0) {
            var_03[var_03.size] = var_05;
          }
        }

        if(var_03.size > 0) {
          self botlookatpoint(common_scripts\utility::func_7A33(var_03).var_0116 + (0, 0, 55), 2, "script_search");
        }

        wait(2);
      }
    }

    wait 0.05;
  }
}

bot_force_exit_turret_on_damage(param_00) {
  self endon("exited_turret");
  param_00 endon("death");
  if(param_00.var_01B9 == "trigger_on_vehicle" || param_00.var_01B9 == "stationary_trigger") {
    return;
  }

  var_01 = anglesToForward(param_00.var_001D);
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(isDefined(var_06) && isexplosivedamagemod(var_06)) {
      continue;
    }

    var_04 = vectornormalize(var_04);
    if(vectordot(var_01, var_04) >= 0) {
      break;
    }
  }

  self notify("force_turret_exit");
}

bot_force_exit_turret_enemy_in_capture_zone(param_00) {
  self endon("exited_turret");
  param_00 endon("death");
  if(param_00.var_01B9 == "trigger_on_vehicle" || param_00.var_01B9 == "stationary_trigger") {
    return;
  }

  var_01 = anglesToForward(param_00.var_001D);
  var_02 = 1000;
  for(;;) {
    var_03 = undefined;
    foreach(var_05 in level.var_79AE.var_08DB) {
      if(is_capture_objective(var_05.var_0165) && self istouching(var_05.var_1FBA.var_9D65)) {
        var_03 = var_05.var_1FBA;
      }
    }

    var_07 = 0;
    if(isDefined(var_03)) {
      foreach(var_09 in var_03.var_9AC3[self.var_01A7]) {
        if(isDefined(var_09.var_721C) && !var_09.var_721C isusingturret()) {
          var_07 = 1;
        }
      }

      if(!var_07) {
        if(func_1FAE(var_03.var_9D65)) {
          wait(randomfloatrange(0.5, 2));
          break;
        }
      }
    }

    wait(0.2);
  }

  self notify("force_turret_exit");
}

bot_force_exit_turret_for_hedgehog(param_00) {
  self endon("exited_turret");
  param_00 endon("death");
  if(param_00.var_01B9 != "trigger_on_vehicle") {
    return;
  }

  var_01 = param_00.var_9EDD.var_A2C8;
  if(!isDefined(var_01)) {
    return;
  }

  var_01 endon("death");
  var_02 = 3000;
  var_03 = undefined;
  for(;;) {
    wait 0.05;
    if(func_96F0(var_01.var_0112)) {
      var_04 = var_01.var_0112.var_17DA.var_4C28;
      if(defensive_structure_is_usable(var_04)) {
        if(var_01.var_0112 lib_04FF::func_3844(game["attackers"]) <= 1) {
          if(!maps\mp\bots\_bots_util::func_1A1C()) {
            break;
          }

          if(!isDefined(var_03)) {
            var_03 = gettime();
          } else if(gettime() - var_03 > var_02) {
            break;
          }

          continue;
        }
      }
    }

    var_03 = undefined;
  }

  self notify("force_turret_exit");
}

bot_force_exit_turret_on_destroyed(param_00) {
  self endon("exited_turret");
  param_00 endon("death");
  param_00 waittill("turret_destroyed");
  self notify("force_turret_exit");
}

func_9F2F(param_00) {
  return (param_00.var_01B9 == "emplaced" && common_scripts\utility::func_562E(param_00.var_1B3A)) || param_00.var_003A == "trigger_use_touch" && common_scripts\utility::func_562E(param_00.var_9EDD.var_1B3A);
}

func_7A97(param_00) {
  self endon("done_seeking_turret");
  var_01 = common_scripts\utility::func_40B0(self.var_0116, param_00.var_1B49);
  var_02 = int(min(6, var_01.size));
  var_03 = randomintrange(0, var_02 - 1);
  for(;;) {
    self botsetscriptgoal(var_01[var_03].var_0116, 0, "tactical");
    wait(0.5);
  }
}

func_6357(param_00) {
  self endon("done_seeking_turret");
  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    if(!param_00 method_8562()) {
      self notify("turret_invalid");
      break;
    }

    var_01 = self method_84D1(1);
    if(isDefined(var_01) && var_01 == param_00) {
      self notify("touching_turret");
      break;
    }

    wait 0.05;
  }
}

func_9F2E(param_00) {
  if(isDefined(param_00.var_1D4F) && common_scripts\utility::func_562E(param_00.var_1D4F.var_54F5)) {
    return 1;
  }

  return 0;
}

func_1D2C(param_00) {
  var_01 = param_00.var_68FB;
  if(function_01EF(self)) {
    common_scripts\utility::func_0615();
    var_01.var_1F89 enableplayeruse(self);
    wait 0.05;
  }

  while(abs(angleclamp180(param_00.var_480A - self getangles()[1])) > 10) {
    wait 0.05;
  }

  func_7CC5();
  self botsetstance("prone");
  wait(0.5);
  func_A720();
  if(!isDefined(var_01.var_1D4F) || func_9F2E(var_01)) {
    self botsetstance("none");
    self.var_1B2F = undefined;
    return;
  }

  childthread maps\mp\bots\_bots_gametype_common::func_67FA();
  var_02 = var_01.var_1D4F.var_A23F / 1000 + 1;
  self botpressbutton("use", var_02);
  var_03 = maps\mp\bots\_bots_util::func_1B16(var_02, "use_interrupted");
  if(function_01EF(self)) {
    common_scripts\utility::func_0601();
    if(isDefined(var_01.var_1F89)) {
      var_01.var_1F89 disableplayeruse(self);
    }
  }

  self botsetstance("none");
  self.var_1B2F = undefined;
  if(var_01 method_8562()) {
    self.var_9EF3 = var_01;
    self notify("built_turret");
  }
}

func_1D2D(param_00) {
  var_01 = param_00.var_68FB;
  if(!isDefined(var_01)) {
    return 1;
  }

  if(!isDefined(var_01.var_1D4F)) {
    return 1;
  }

  if(func_9F2E(var_01)) {
    return 1;
  }

  if(maps\mp\bots\_bots_util::func_1A1C()) {
    return 1;
  }

  var_02 = func_412E();
  if(!isDefined(var_02) || var_02.var_695A != param_00.var_6C13) {
    return 1;
  }

  return 0;
}

turret_valid_for_objective(param_00, param_01) {
  if(!isDefined(param_00.var_8251)) {
    return 0;
  }

  var_02 = strtok(param_00.var_8251, "|");
  var_03 = 1;
  foreach(var_05 in var_02) {
    if(!common_scripts\utility::func_0F79(level.var_696E, var_05)) {
      var_03 = 0;
    }
  }

  if(!var_03) {
    return 0;
  }

  if(!common_scripts\utility::func_0F79(var_02, param_01.var_695A)) {
    return 0;
  }

  return 1;
}

turret_find_turret_node(param_00) {
  if(param_00.var_003A != "trigger_use_touch" && !isDefined(param_00.var_010D)) {
    var_01 = getnodesinradiussorted(param_00.var_0116, 60, 0);
    foreach(var_03 in var_01) {
      if(var_03.var_01B9 == "Turret") {
        param_00.var_010D = var_03;
        var_03.var_9EDD = param_00;
        break;
      }
    }

    if(!isDefined(param_00.var_010D) || param_00.var_010D.var_01B9 != "Turret" || param_00.var_010D method_8389()) {
      return 0;
    }
  }

  return 1;
}

func_3B83(param_00) {
  param_00.var_1B39.var_08E5 = [];
  var_01 = level.var_79C2.var_9F96;
  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(!turret_find_turret_node(var_03)) {
      continue;
    }

    if(!turret_valid_for_objective(var_03, param_00)) {
      continue;
    }

    if(isDefined(var_03.var_817E)) {
      if(!common_scripts\utility::func_0F79(level.var_696E, var_03.var_817E)) {
        continue;
      }
    }

    var_03.var_2C7F = 0;
    var_03.var_119B = 0;
    if(var_03.var_003A == "trigger_use_touch") {
      if(var_03.var_6DB2 == game["defenders"]) {
        var_03.var_2C7F = 1;
      } else if(var_03.var_6DB2 == game["attackers"]) {
        var_03.var_119B = 1;
      }

      if(isDefined(var_03.var_9EDD.var_A2C8)) {
        var_03.var_01B9 = "trigger_on_vehicle";
      } else {
        var_03.var_01B9 = "stationary_trigger";
      }

      var_03.var_9EDD.var_1B3A = undefined;
    } else {
      var_04 = function_0366(var_03.var_010D);
      if(common_scripts\utility::func_562E(level.var_A27E["defenders"][var_04])) {
        var_03.var_2C7F = 1;
      } else if(common_scripts\utility::func_562E(level.var_A27E["attackers"][var_04])) {
        if(isDefined(var_03.var_8260) && var_03.var_8260 == "bot_defender_team_only") {
          continue;
        }

        var_03.var_119B = 1;
      } else {
        continue;
      }

      var_03.var_01B9 = "emplaced";
      var_03.var_1B3A = undefined;
    }

    param_00.var_1B39.var_08E5[param_00.var_1B39.var_08E5.size] = var_03;
  }
}

bot_can_use_defensive_structures() {
  if(common_scripts\utility::func_562E(self.var_66E4)) {
    return 0;
  }

  if(maps\mp\bots\_bots_strategy::func_1A14("use_defensive_structure") || self method_835F() == "tactical") {
    return 0;
  }

  if(maps\mp\bots\_bots_util::func_1A1C() || maps\mp\bots\_bots_util::func_1A36()) {
    return 0;
  }

  return 1;
}

defensive_structure_is_usable(param_00) {
  if(defensive_structure_is_in_use(param_00)) {
    return 0;
  }

  if(bomb_is_planted_on_defensive_structure(param_00)) {
    return 0;
  }

  if(defensive_structure_is_disabled(param_00)) {
    return 0;
  }

  return 1;
}

bot_defensive_structure_think(param_00) {
  if(!isDefined(self.next_defensive_structure_check_time)) {
    self.next_defensive_structure_check_time = gettime() + randomintrange(2000, 5000);
  }

  if(gettime() < self.next_defensive_structure_check_time) {
    return;
  }

  self.next_defensive_structure_check_time = gettime() + randomintrange(2000, 5000);
  if(!isDefined(param_00.var_1B39.activedefensivestructures) || param_00.var_1B39.activedefensivestructures.size == 0) {
    return 0;
  }

  if(!bot_can_use_defensive_structures()) {
    return;
  }

  var_01 = [];
  for(var_02 = 0; var_02 < param_00.var_1B39.activedefensivestructures.size; var_02++) {
    var_03 = param_00.var_1B39.activedefensivestructures[var_02];
    if(!defensive_structure_is_usable(var_03)) {
      continue;
    }

    if(!bot_team_should_use_defensive_structure(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  if(var_01.size == 0) {
    return;
  }

  var_04 = common_scripts\utility::func_40B0(self.var_0116, var_01);
  var_05 = 512;
  var_06 = distance(self.var_0116, var_04[0].var_0116);
  if(var_06 > var_05) {
    return;
  }

  var_07 = 40;
  if(func_6922(param_00, 20000)) {
    var_07 = var_07 + 20;
  }

  if(randomint(100) >= var_07) {
    return;
  }

  var_08 = var_04[0];
  bot_use_defensive_structure(var_08, param_00);
}

bot_use_defensive_structure(param_00, param_01) {
  if(!isDefined(param_00.var_671A)) {
    get_defensive_structure_nodes(param_00);
  }

  var_02 = [];
  foreach(var_04 in param_00.var_671A) {
    if(!var_04 method_8389()) {
      var_02[var_02.size] = var_04;
    }
  }

  var_06 = common_scripts\utility::func_7A33(var_02);
  var_07 = spawnStruct();
  var_07.var_68FB = param_00;
  var_07.var_087F = ::build_defensive_structure;
  var_07.var_8B3E = ::build_defensive_structure_should_abort;
  var_08 = param_01.var_695A;
  if(common_scripts\utility::func_562E(param_01.var_651B)) {
    var_08 = param_01.var_6E78;
  }

  var_07.var_6C13 = var_08;
  maps\mp\bots\_bots_strategy::func_1A85("use_defensive_structure", var_06.var_0116, 10, var_07);
}

defensive_structure_is_in_use(param_00) {
  return common_scripts\utility::func_562E(param_00.var_9D65.var_A240.var_54F5);
}

bomb_is_planted_on_defensive_structure(param_00) {
  return common_scripts\utility::func_562E(param_00.var_18C6);
}

defensive_structure_is_disabled(param_00) {
  return common_scripts\utility::func_562E(param_00.var_9D65.var_9D9F);
}

bot_team_should_use_defensive_structure(param_00) {
  if(param_00.var_172D == self.var_01A7) {
    if(!param_00.var_2599) {
      return 1;
    }
  } else if(param_00.var_2599) {
    return 1;
  }

  return 0;
}

build_defensive_structure(param_00) {
  var_01 = param_00.var_68FB;
  var_02 = 0;
  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_02 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_02 = 80;
  }

  func_7CC5();
  var_03 = 0;
  if(randomint(100) < var_02) {
    var_03 = 1;
    self botsetstance("prone");
    wait(0.5);
  }

  func_A720();
  if(defensive_structure_is_in_use(var_01) || bomb_is_planted_on_defensive_structure(var_01) || !bot_team_should_use_defensive_structure(var_01)) {
    if(var_03) {
      self botsetstance("none");
    }

    self.var_1B2F = undefined;
    return;
  }

  if(!isDefined(var_01.var_9D65)) {
    return;
  }

  var_04 = var_01.var_9D65.var_A240.var_A23F / 1000 + 1;
  self botpressbutton("use", var_04);
  var_05 = maps\mp\bots\_bots_util::func_1B16(var_04);
  if(var_03) {
    self botsetstance("none");
  }

  self.var_1B2F = undefined;
}

build_defensive_structure_should_abort(param_00) {
  var_01 = param_00.var_68FB;
  if(!isDefined(var_01)) {
    return 1;
  }

  if(bomb_is_planted_on_defensive_structure(var_01)) {
    return 1;
  }

  if(defensive_structure_is_disabled(var_01)) {
    return 1;
  }

  if(!bot_team_should_use_defensive_structure(var_01)) {
    return 1;
  }

  if(maps\mp\bots\_bots_util::func_1A1C()) {
    return 1;
  }

  var_02 = func_412E();
  if(!isDefined(var_02) || var_02.var_695A != param_00.var_6C13) {
    return 1;
  }

  return 0;
}

get_defensive_structure_nodes(param_00) {
  var_01 = 0;
  if(common_scripts\utility::func_562E(param_00.var_9D65.var_9D9F)) {
    var_01 = 1;
    param_00.var_9D65 common_scripts\utility::func_9DA3();
  }

  var_02 = getnodesintrigger(param_00.var_9D65, 1);
  param_00.var_671A = [];
  foreach(var_04 in var_02) {
    var_05 = function_0366(var_04);
    if(!var_04 method_8389() && common_scripts\utility::func_562E(level.var_A27E["defenders"][var_05])) {
      param_00.var_671A[param_00.var_671A.size] = var_04;
    }
  }

  if(var_01) {
    param_00.var_9D65 common_scripts\utility::func_9D9F();
  }
}

find_defensive_structures_associated_with_objective(param_00) {
  param_00.var_1B39.activedefensivestructures = [];
  var_01 = [];
  if(isDefined(level.var_79C2.var_4C32)) {
    var_01 = common_scripts\utility::func_0F73(var_01, level.var_79C2.var_4C32);
  }

  if(isDefined(level.var_79C2.var_159A)) {
    var_01 = common_scripts\utility::func_0F73(var_01, level.var_79C2.var_159A);
  }

  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_9D65)) {
      continue;
    }

    get_defensive_structure_nodes(var_03);
    if(var_03.var_671A.size == 0) {
      continue;
    }

    var_04 = 1;
    foreach(var_06 in var_03.var_671A) {
      var_07 = function_0366(var_06);
      if(!common_scripts\utility::func_562E(level.var_A27E["both"][var_07])) {
        var_04 = 0;
        break;
      }
    }

    if(!var_04) {
      continue;
    }

    param_00.var_1B39.activedefensivestructures[param_00.var_1B39.activedefensivestructures.size] = var_03;
  }
}

func_87A5(param_00) {
  level endon("game_ended");
  wait(0.5);
  for(var_01 = func_412E(); !isDefined(var_01); var_01 = func_412E()) {
    wait 0.05;
  }

  if(param_00 != var_01) {
    return;
  }

  level notify("calculate_buildables");
  thread func_3B86(param_00);
  thread func_3B83(param_00);
  thread find_defensive_structures_associated_with_objective(param_00);
}

bot_use_raid_trigger(param_00) {
  if(!isDefined(self.var_671B) || !common_scripts\utility::func_0F79(param_00.var_671A, self.var_671B)) {
    var_01 = common_scripts\utility::func_40B0(self.var_0116, param_00.var_671A);
    var_02 = int(min(var_01.size, 8));
    var_03 = randomint(var_02);
    self.var_671B = var_01[var_03];
  }

  var_04 = self.var_6903 == "careful";
  if(var_04) {
    var_05 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
    if(var_05 > 0 && var_05 < 20) {
      var_04 = 0;
    }
  }

  if(var_04) {
    if(distancesquared(self.var_0116, self.var_671B.var_0116) > -25536) {
      if(!maps\mp\bots\_bots_util::func_1A28() || !common_scripts\utility::func_5646(self.var_19A7, self.var_671B.var_0116)) {
        maps\mp\bots\_bots_strategy::func_196A(self.var_671B.var_0116, 200);
      }
    } else {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
        self botsetscriptgoal(self.var_671B.var_0116, 0, "objective");
      }
    }
  } else {
    if(maps\mp\bots\_bots_util::func_1A2D()) {
      maps\mp\bots\_bots_strategy::func_19A3();
    }

    if(!self method_8367() || distancesquared(self method_835C(), self.var_671B.var_0116) > 4) {
      self botsetscriptgoal(self.var_671B.var_0116, 0, "critical");
    }
  }

  if(distance2dsquared(self.var_0116, self.var_671B.var_0116) < 256) {
    func_7CC5();
    var_06 = common_scripts\utility::func_7A33(["stand", "crouch", "prone"]);
    self botsetstance(var_06);
    while(self getstance() != var_06) {
      wait 0.05;
    }

    func_A720();
    self botsetscriptgoal(self.var_0116, 0, "critical");
    while(isDefined(param_00) && param_00 method_8562()) {
      self botpressbutton("use", 0.6);
      wait(0.5);
    }

    self method_8358();
    self botsetstance("none");
  }
}

func_7CC5() {
  if(maps\mp\gametypes\_gameobjects::func_2956()) {
    self switchtoweapon("none");
    self.var_1B2F = 1;
  }
}

func_A720() {
  while(maps\mp\gametypes\_gameobjects::func_2956()) {
    wait 0.05;
  }
}

func_7DCC() {
  foreach(var_01 in level.var_744A) {
    if(isbot(var_01) && isalive(var_01)) {
      if(var_01 maps\mp\bots\_bots_util::func_1A2D()) {
        var_01 maps\mp\bots\_bots_strategy::func_19A3();
      }
    }
  }
}

func_1977() {
  self notify("new_objective");
  self method_8358();
  self botsetstance("none");
  maps\mp\bots\_bots_strategy::func_19A3();
  self.var_291F = undefined;
  self botsetpathingstyle(undefined);
  self botsetflag("no_enemy_search", 0);
  self botsetflag("can_approach_bad_place_goals", 0);
  self botsetflag("dont_path_to_enemy", 0);
  self botsetflag("force_sprint", 0);
  self.var_3026 = undefined;
  self.var_1F1E = undefined;
  self.var_9EF3 = undefined;
  self.var_66E4 = undefined;
  self.var_2C6E = undefined;
  self.var_6903 = undefined;
  self.var_671B = undefined;
  self.objectivetarget = undefined;
  self.var_66B5 = undefined;
  self.var_1F4A = undefined;
  self.var_5B63 = undefined;
  self.var_94CD = undefined;
  self.var_76D1 = undefined;
  self.var_1B2F = undefined;
  self.var_A877 = undefined;
  self.objectivecounter = undefined;
  if(self isusingturret()) {
    self botpressbutton("use", 0.5);
  }
}

func_196D(param_00) {
  if(func_1A2C()) {
    var_01 = gettime() - func_4259(param_00);
    if(var_01 < 20000) {
      self.var_A877 = 1;
      self botsetpathingstyle("beeline");
      self botsetflag("force_sprint", 1);
      return;
    }

    if(var_01 > 30000 && common_scripts\utility::func_562E(self.var_A877)) {
      self botsetpathingstyle(undefined);
      self botsetflag("force_sprint", 0);
      self.var_A877 = undefined;
      return;
    }
  }
}

func_1AEF() {
  if(isDefined(level.var_79C2.var_694A) && self.var_5BE2 < level.var_79C2.var_694A) {
    return 1;
  }

  return 0;
}

func_6922(param_00, param_01) {
  var_02 = gettime() - func_4259(param_00);
  if(var_02 < param_01) {
    return 1;
  }

  return 0;
}

func_4259(param_00) {
  if(param_00.var_695A == "bridge_2") {
    param_00 = common_scripts\utility::func_46B5("bridge_1", "targetname");
  }

  if(isDefined(param_00.var_A4BF) && isDefined(param_00.var_A4BF[self.var_01A7])) {
    return param_00.var_A4BF[self.var_01A7];
  }

  return param_00.var_6974;
}

func_1B09(param_00, param_01, param_02) {
  if(self botgetdifficultysetting("allowGrenades") == 0) {
    return;
  }

  if(self method_8126() || self method_8689()) {
    return;
  }

  var_03 = gettime();
  if(var_03 - self.var_5B29 <= 500) {
    return;
  }

  if(var_03 == level.var_5B19) {
    return;
  }

  if(self istouching(param_00)) {
    return;
  }

  if(randomint(100) > 50) {
    return;
  }

  var_04 = func_19EF(param_02);
  if(!isDefined(var_04)) {
    return;
  }

  var_05 = self getnearestnode();
  if(!isDefined(var_05)) {
    return;
  }

  if(maps\mp\bots\_bots_util::func_1A1C()) {
    return;
  }

  level.var_5B19 = var_03;
  self.var_5B29 = var_03;
  var_06 = common_scripts\utility::func_0F92(param_01);
  var_07 = 0;
  foreach(var_09 in var_06) {
    if(function_01F4(var_05, var_09, 1) && distancesquared(self.var_0116, var_09.var_0116) > 122500) {
      if(sighttracepassed(self getEye(), var_09.var_0116 + (0, 0, 60), 0, self)) {
        if(param_02 == "captureObjective") {
          var_0A = var_09.var_0116;
        } else {
          var_0B = self botgetdifficultysetting("strategyLevel");
          var_0A = var_09.var_0116 + 3 - var_0B * (randomfloatrange(-33, 33), randomfloatrange(-33, 33), 0);
        }

        self botthrowscriptedgrenade(var_0A, var_04, 1);
        while(self method_8126() || self method_8689()) {
          wait 0.05;
        }

        self.var_5B29 = 0;
        break;
      }

      var_07++;
      if(var_07 >= 4) {
        break;
      }
    }
  }
}

func_19EF(param_00) {
  var_01[0] = ["lethal", self method_834A()];
  var_01[1] = ["tactical", self method_831F()];
  var_01 = common_scripts\utility::func_0F92(var_01);
  foreach(var_03 in var_01) {
    var_04 = var_03[0];
    var_05 = var_03[1];
    if(isDefined(var_05) && var_05 != "none") {
      if(func_1964(var_05, param_00)) {
        var_06 = self getweaponammostock(var_05);
        if(var_06 > 0) {
          return var_04;
        }
      }
    }
  }
}

func_1A26() {
  var_00 = func_412E();
  if(isDefined(var_00) && var_00.var_0165 == "bombObjective") {
    if(func_193E()) {
      return !func_1A25();
    }
  }

  return func_1A25();
}

func_1A2F() {
  return !func_1A26();
}

func_193E() {
  var_00 = func_412E();
  if(isDefined(var_00) && common_scripts\utility::func_562E(var_00.var_18F9)) {
    return 1;
  }

  return 0;
}

func_1964(param_00, param_01) {
  if(func_1A2F()) {
    if(func_560D(param_00)) {
      return 0;
    }
  } else if(param_01 == "useHoldBuildObjective" || param_01 == "bombObjective" || func_5575(param_01)) {
    if(!func_560D(param_00)) {
      return 0;
    }
  }

  return 1;
}

func_560D(param_00) {
  if(param_00 == "smoke_grenade_mp" || param_00 == "smoke_grenade_axis_mp" || param_00 == "smoke_grenade_expeditionary_mp" || param_00 == "smoke_grenade_axis_expeditionary_mp") {
    return 1;
  }

  return 0;
}

func_1A25() {
  return self.var_01A7 == game["attackers"];
}

func_1A2C() {
  return self.var_01A7 == game["defenders"];
}

func_1AA4(param_00, param_01) {
  self.var_291F = param_00;
  var_02["nearest_node_to_center"] = function_00BA(param_00.var_0116);
  if(!isDefined(var_02["nearest_node_to_center"])) {
    var_03 = common_scripts\utility::func_40B0(param_00.var_0116, getnodesinradius(param_00.var_0116, 256, 0));
    if(var_03.size > 0) {
      var_02["nearest_node_to_center"] = var_03[0];
    }
  }

  maps\mp\bots\_bots_strategy::func_1AA6(param_00.var_0116, param_01, var_02);
}

func_1AA5(param_00, param_01, param_02, param_03, param_04) {
  self.var_291F = param_00;
  maps\mp\bots\_bots_strategy::func_1AA7(param_01, param_03, param_02, param_04);
}

func_1A35(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A33()) {
    return 0;
  }

  return self.var_291F == param_00;
}

func_1AAC() {
  self notify("bot_raid_bot_entrance_update");
  self endon("bot_raid_bot_entrance_update");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  while(!isDefined(self.var_A8C9)) {
    wait 0.05;
  }

  var_00 = self getnearestnode();
  for(var_01 = 0; var_01 < self.var_A8C9.size; var_01++) {
    if(!function_01F4(var_00, self.var_A8C9[var_01], 1)) {
      maps\mp\bots\_bots_util::func_A8C8(self.var_A8C9[var_01]);
      self.var_A8C9[var_01] = self.var_A8C9[self.var_A8C9.size - 1];
      self.var_A8C9[self.var_A8C9.size - 1] = undefined;
      var_01--;
    }
  }

  var_02 = "toward_enemy_spawns";
  var_03 = func_412E();
  if(isDefined(var_03) && var_03.var_0165 == "useHoldBuildObjective") {
    if(func_1A2C()) {
      var_02 = "prioritize_objective_center";
    } else {
      var_02 = "";
    }
  }

  if(var_02 == "prioritize_objective_center") {
    var_04 = maps\mp\_utility::func_442E(var_03.var_1B39.var_1D2B);
    var_05 = vectornormalize(var_04 - self.var_0116);
    foreach(var_07 in self.var_A8C9) {
      var_08 = vectornormalize(var_07.var_0116 - self.var_0116);
      var_09 = vectordot(var_05, var_08);
      if(var_09 < 0) {
        var_07.var_A8C7[self.var_37CD] = 0;
        continue;
      }

      if(common_scripts\utility::func_0F79(var_03.var_1B39.var_1D2B, var_07)) {
        var_07.var_A8C7[self.var_37CD] = 1;
        continue;
      }

      var_07.var_A8C7[self.var_37CD] = 0.2;
    }

    return;
  }

  if(var_02 == "toward_enemy_spawns") {
    var_0B = self.var_01A7;
    var_0C = maps\mp\_utility::func_45DE(var_0B);
    var_0D[var_0B] = lib_0502::func_3B80(lib_0502::func_447F(var_0B)).var_0116;
    self.var_6EC1[var_0B] = getpathdist(self.var_0116, var_0D[var_0B], 999999);
    var_0D[var_0C] = lib_0502::func_3B80(lib_0502::func_447F(var_0C)).var_0116;
    self.var_6EC1[var_0C] = getpathdist(self.var_0116, var_0D[var_0C], 999999);
    if(self.var_6EC1[var_0B] < 0 || self.var_6EC1[var_0C] < 0) {
      return;
    }

    foreach(var_07 in self.var_A8C9) {
      if(!isDefined(var_07.var_3025)) {
        var_07.var_3025 = [];
      }

      if(!isDefined(var_07.var_3025[var_0B])) {
        var_07.var_3025[var_0B] = getpathdist(var_07.var_0116, var_0D[var_0B], 999999);
      }

      if(!isDefined(var_07.var_3025[var_0C])) {
        var_07.var_3025[var_0C] = getpathdist(var_07.var_0116, var_0D[var_0C], 999999);
      }

      var_07.var_A8C7[self.var_37CD] = var_07.var_A8C6[self.var_37CD];
      if(var_07.var_3025[var_0B] >= 0 && var_07.var_3025[var_0C] >= 0) {
        var_0F = var_07.var_3025[var_0B] < self.var_6EC1[var_0B];
        var_10 = var_07.var_3025[var_0C] < self.var_6EC1[var_0C];
        if(var_0F && !var_10) {
          var_07.var_A8C7[self.var_37CD] = var_07.var_A8C7[self.var_37CD] * 0.01;
        }
      }
    }
  }
}

func_1E46() {
  level endon("game_ended");
  wait(1);
  while(!isDefined(func_412E())) {
    wait 0.05;
  }

  if(!isDefined(level.var_696E)) {
    return;
  }

  level.var_19E8 = 1;
  for(;;) {
    var_00 = gettime();
    var_01 = level.var_1920;
    func_1E45();
    if(func_191F(var_01, level.var_1920)) {
      var_02 = func_412E();
      if(isDefined(var_02)) {
        if(isDefined(var_02.var_1B39) && isDefined(var_02.var_1B39.var_A268)) {
          level.var_664A["attackers"] = 1;
          level.var_664A["defenders"] = 1;
          func_7DCC();
        }

        if(func_5575(var_02.var_0165)) {
          waittillframeend;
          if(var_02.currentcheckpoint > 0 && isDefined(var_02.var_1B39)) {
            if(isDefined(var_02.var_1B39.var_08E7) || isDefined(var_02.var_1B39.var_08E5) || isDefined(var_02.var_1B39.activedefensivestructures)) {
              thread func_87A5(var_02);
            }
          }
        }
      }
    }

    level common_scripts\utility::func_A70A("raid_spawns_changed", "raid_boundaries_changed");
    waittillframeend;
  }
}

func_191F(param_00, param_01) {
  if(!isDefined(param_00) && isDefined(param_01)) {
    return 1;
  }

  var_02 = ["attackers", "defenders"];
  foreach(var_04 in var_02) {
    if(!common_scripts\utility::func_0F78(param_00[var_04], param_01[var_04])) {
      return 1;
    }
  }

  return 0;
}

func_1E45() {
  level.var_A27E["both"] = [];
  func_1E4A("attackers");
  func_1E4A("defenders");
  var_00 = getallnodes();
  foreach(var_02 in var_00) {
    var_03 = function_0366(var_02);
    if(isDefined(level.var_A27E["attackers"][var_03]) && isDefined(level.var_A27E["defenders"][var_03])) {
      level.var_A27E["both"][var_03] = 1;
    }

    var_04 = 1;
    if(var_02.var_01B9 == "Begin" && var_02.var_001E == "bot_plant_bomb" || var_02.var_001E == "bot_use_object") {
      var_04 = 0;
    }

    if(var_04) {
      nodesetinvalidforteam(var_02, game["attackers"], 0);
      nodesetinvalidforteam(var_02, game["defenders"], 0);
    }

    var_02.var_3025 = undefined;
  }

  foreach(var_07 in ["attackers", "defenders"]) {
    foreach(var_03, var_09 in level.var_1920[var_07]) {
      var_02 = function_039A(var_03);
      nodesetinvalidforteam(var_02, game[var_07], 1);
    }
  }
}

func_1E4A(param_00) {
  level.var_1920[param_00] = [];
  level.var_A27E[param_00] = [];
  var_01 = lib_0502::func_447F(game[param_00]);
  var_02 = getnodesinradiussorted(var_01[0].var_0116, 256, 0);
  var_03 = var_02[0];
  level.var_54F9[param_00] = [];
  var_04 = [];
  foreach(var_06 in level.var_1B69) {
    if(var_06.var_931A == "active") {
      var_07 = getnodesintrigger(var_06.var_9D65, 1);
      if(var_06.var_01A7 == maps\mp\_utility::func_45DE(game[param_00])) {
        foreach(var_09 in var_07) {
          level.var_54F9[param_00][function_0366(var_09)] = 1;
        }
      }

      continue;
    }

    if(var_06.var_931A == "incoming") {
      var_07 = getnodesintrigger(var_06.var_9D65, 1);
      if(var_06.var_01A7 == maps\mp\_utility::func_45DE(game[param_00])) {
        foreach(var_09 in var_07) {
          var_04[function_0366(var_09)] = 1;
        }
      }
    }
  }

  level.var_A27E[param_00][function_0366(var_03)] = 1;
  var_0E = [var_03];
  while(var_0E.size > 0) {
    var_0F = var_0E[var_0E.size - 1];
    var_0E[var_0E.size - 1] = undefined;
    var_10 = function_0204(var_0F);
    foreach(var_12 in var_10) {
      var_13 = function_0366(var_12);
      var_14 = isDefined(level.var_A27E[param_00][var_13]);
      if(!var_14) {
        var_15 = isDefined(level.var_54F9[param_00][var_13]);
        if(!var_15) {
          var_16 = isDefined(var_04[var_13]);
          if(!var_16) {
            level.var_A27E[param_00][var_13] = 1;
            var_0E[var_0E.size] = var_12;
          }
        } else {
          level.var_1920[param_00][var_13] = 1;
        }
      }
    }
  }
}

func_412E() {
  var_00 = undefined;
  foreach(var_02 in level.var_79AE.var_08DB) {
    if(isDefined(var_02.var_94CE)) {
      var_00 = var_02;
    }
  }

  if(!isDefined(var_00)) {
    foreach(var_02 in level.var_79AE.var_08DB) {
      if(!common_scripts\utility::func_562E(var_02.var_651B)) {
        var_00 = var_02;
      }
    }
  }

  return var_00;
}