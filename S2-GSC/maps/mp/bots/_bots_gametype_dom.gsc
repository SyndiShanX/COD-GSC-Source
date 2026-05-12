/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dom.gsc
***********************************************/

func_00F9() {
  level.var_1A1B = 0;
  func_87A7();
  func_8794();
  level thread maps\mp\bots\_bots_util::func_1A80(::maps\mp\bots\_bots_util::func_1B17);
}

func_87A7() {
  level.var_19D5["crate_can_use"] = ::func_2734;
  level.var_19D5["gametype_think"] = ::func_19B7;
  level.var_19D5["should_start_cautious_approach"] = ::func_8B7B;
  level.var_19D5["leader_dialog"] = ::func_19B5;
  if(!level.var_1A1B) {
    level.var_19D5["get_watch_node_chance"] = ::func_19B4;
  }
}

func_2734(param_00) {
  if(function_01EF(self) && !isDefined(param_00.var_1B7B)) {
    return 0;
  }

  if(!maps\mp\_utility::func_5800(self)) {
    return 1;
  }

  return maps\mp\bots\_bots_util::func_1A33();
}

func_630C() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(1);
    var_00 = maps\mp\gametypes\dom::func_44E3();
    if(var_00 != "neutral") {
      var_01 = getzonenearest(self.var_0116);
      if(isDefined(var_01)) {
        botzonesetteam(var_01, var_00);
      }
    }
  }
}

func_630D() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_00 = maps\mp\gametypes\dom::func_44E3();
  for(;;) {
    var_01 = maps\mp\gametypes\dom::func_44E3();
    if(var_01 != var_00) {
      level notify("flag_changed_ownership");
    }

    var_00 = var_01;
    wait 0.05;
  }
}

func_8794() {
  maps\mp\bots\_bots_util::func_1B20();
  var_00 = func_19EC();
  if(var_00.size > 3) {
    while(!isDefined(level.var_987B)) {
      wait 0.05;
    }

    var_01 = [];
    foreach(var_03 in var_00) {
      if(!isDefined(var_01[var_03.var_98BF])) {
        var_01[var_03.var_98BF] = [];
      }

      var_01[var_03.var_98BF] = common_scripts\utility::func_0F6F(var_01[var_03.var_98BF], var_03);
    }

    foreach(var_07, var_06 in var_01) {
      level.var_37DD = 0;
      func_1952(var_06);
      maps\mp\bots\_bots_gametype_common::func_194F(var_06, var_07 + "_flag", level.var_1A1B);
    }
  } else {
    maps\mp\bots\_bots_gametype_common::func_194F(var_00, "flag", level.var_1A1B);
    func_1952(var_00);
    thread func_1B1F(var_00);
  }

  foreach(var_03 in var_00) {
    var_03 thread func_630C();
    var_03 thread func_630D();
    if(var_03.var_81E8 != "_a" && var_03.var_81E8 != "_b" && var_03.var_81E8 != "_c") {}

    var_03.var_671A = maps\mp\bots\_bots_gametype_common::func_1A08(var_03);
    var_03.var_5B62["allies"] = 0;
    var_03.var_5B62["axis"] = 0;
  }

  level.var_19B6 = [];
  level.var_19B6["axis"] = [];
  level.var_19B6["allies"] = [];
  level.var_19E8 = 1;
}

func_1B1F(param_00) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  maps\mp\bots\_bots_gametype_common::func_194F(param_00, "flag", level.var_1A1B, 1);
  func_1952(param_00);
  foreach(var_02 in param_00) {
    var_02.var_671A = maps\mp\bots\_bots_gametype_common::func_1A08(var_02);
  }

  foreach(var_05 in level.var_6E97) {
    if(maps\mp\_utility::func_566A(var_05)) {
      var_05.var_3DF4 = 1;
    }
  }
}

func_19EC() {
  if(isDefined(level.var_0BCA)) {
    return level.var_0BCA;
  }

  return level.var_3CC5;
}

func_1952(param_00) {
  if(!isDefined(level.var_3C81)) {
    level.var_3C81 = [];
  }

  for(var_01 = 0; var_01 < param_00.size - 1; var_01++) {
    for(var_02 = var_01 + 1; var_02 < param_00.size; var_02++) {
      var_03 = distance(param_00[var_01].var_0116, param_00[var_02].var_0116);
      var_04 = func_4194(param_00[var_01]);
      var_05 = func_4194(param_00[var_02]);
      level.var_3C81[var_04][var_05] = var_03;
      level.var_3C81[var_05][var_04] = var_03;
    }
  }
}

func_8B7B(param_00) {
  if(param_00) {
    if(self.var_28F7 maps\mp\gametypes\dom::func_44E3() == "neutral" && func_3C86(self.var_28F7)) {
      var_01 = func_40FC(self.var_5BE0.var_0116);
      if(var_01 == self.var_28F7) {
        return 0;
      } else {
        var_02 = func_426A(var_01, self.var_28F7);
        var_03 = distancesquared(var_01.var_0116, self.var_28F7.var_0116);
        var_04 = distancesquared(var_02.var_0116, self.var_28F7.var_0116);
        if(var_03 < var_04) {
          return 0;
        }
      }
    }
  }

  return maps\mp\bots\_bots_strategy::func_8B7A(param_00);
}

func_19B2() {
  return 0;
}

func_19B3() {
  return 0;
}

func_19B7() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self.var_3DF4 = 0;
  self.var_668C = 0;
  self.var_66B0 = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  for(;;) {
    maps\mp\bots\_bots_util::func_1B13();
    var_00 = gettime();
    if(var_00 > self.var_66B0) {
      self.var_66B0 = gettime() + 10000;
      self.var_943A = self botgetdifficultysetting("strategyLevel");
    }

    if(var_00 > self.var_668C || self.var_3DF4) {
      if(func_8B52()) {
        self.var_668C = var_00 + 5000;
      } else {
        self.var_3DF4 = 0;
        func_1975();
        self.var_668C = var_00 + randomintrange(30000, -20536);
      }
    }

    common_scripts\utility::func_A74B("needs_new_flag_goal", 1);
  }
}

func_8B52() {
  if(self.var_3DF4) {
    return 0;
  }

  if(!maps\mp\bots\_bots_util::func_1A28()) {
    return 0;
  }

  if(self.var_28F7 maps\mp\gametypes\dom::func_44E3() == self.var_01A7) {
    return 0;
  }

  var_00 = func_4193();
  if(distancesquared(self.var_0116, self.var_28F7.var_0116) < var_00 * 2 * var_00 * 2) {
    var_01 = func_4094(self.var_01A7);
    if(var_01.size == 2 && !common_scripts\utility::func_0F79(var_01, self.var_28F7) && !func_1934()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_4278() {
  return level.var_19B6[self.var_01A7];
}

func_4B37() {
  var_00 = func_4278();
  return var_00.size > 0;
}

func_3C85(param_00) {
  return !func_3C86(param_00);
}

func_3C86(param_00) {
  return param_00.var_A222.var_3C66;
}

func_1975() {
  var_00 = undefined;
  var_01 = [];
  var_02 = [];
  var_03 = 1;
  var_04 = func_4278();
  if(var_04.size > 0) {
    var_05 = var_04;
  } else {
    var_05 = level.var_3CC5;
  }

  for(var_06 = 0; var_06 < var_05.size; var_06++) {
    var_07 = var_05[var_06] maps\mp\gametypes\dom::func_44E3();
    if(var_03) {
      if(func_3C85(var_05[var_06])) {
        var_03 = 0;
      } else {}
    }

    if(var_07 != self.var_01A7) {
      var_01[var_01.size] = var_05[var_06];
      continue;
    }

    var_02[var_02.size] = var_05[var_06];
  }

  var_08 = undefined;
  if(var_01.size == 3) {
    var_08 = 1;
  } else if(var_01.size == 2) {
    if(var_02.size == 1) {
      if(!func_1AE1(var_02[0], 1)) {
        var_08 = 1;
      } else {
        var_08 = !func_1AE0(0.34);
      }

      if(maps\mp\bots\_bots_util::func_19F9(self.var_01A7) == 1) {
        var_08 = 1;
      }
    } else if(var_02.size == 0) {
      var_08 = 1;
    }
  } else if(var_01.size == 1) {
    if(var_02.size == 2) {
      if(func_1934()) {
        if(!func_1AE1(var_02[0], 2) && !func_1AE1(var_02[1], 2)) {
          var_08 = 1;
        } else if(self.var_943A == 0) {
          var_08 = !func_1AE0(0.34);
        } else {
          var_08 = !func_1AE0(0.5);
        }
      } else {
        var_08 = 0;
      }
    } else if(var_02.size == 1) {
      if(!func_1AE1(var_02[0], 1)) {
        var_08 = 1;
      } else {
        var_08 = !func_1AE0(0.34);
      }
    } else if(var_02.size == 0) {
      var_08 = 1;
    }
  } else if(var_01.size == 0) {
    var_08 = 0;
  }

  if(var_08) {
    if(var_01.size > 1) {
      var_09 = common_scripts\utility::func_40B0(self.var_0116, var_01);
    } else {
      var_09 = var_02;
    }

    if(var_03 && !func_4B37()) {
      var_0A = func_424E(var_09[0], 1);
      if(var_0A < func_61AD()) {
        var_0B = 0;
      } else {
        var_0C = 20;
        var_0D = 65;
        var_0E = 15;
        if(self.var_943A == 0) {
          var_0C = 50;
          var_0D = 25;
          var_0E = 25;
        } else if(self.var_943A == 1) {
          var_0C = 40;
          var_0D = 40;
          var_0E = 20;
        }

        var_0F = randomint(100);
        if(var_0F < var_0C) {
          var_0B = 0;
        } else if(var_0F < var_0C + var_0D) {
          var_0B = 1;
        } else {
          var_0B = 2;
        }
      }

      var_10 = undefined;
      if(var_0F == 0) {
        var_10 = "critical";
      }

      func_1FAD(var_0D[var_0F], var_10);
      return;
    }

    if(var_0F.size == 1) {
      var_06 = var_0F[0];
    } else if(distancesquared(var_0F[0].var_0116, self.var_0116) < 102400) {
      var_06 = var_0F[0];
    } else {
      var_11 = [];
      var_12 = [];
      for(var_0C = 0; var_0C < var_0F.size; var_0C++) {
        var_13 = distance(var_0F[var_0C].var_0116, self.var_0116);
        var_12[var_0C] = var_13;
        var_11[var_0C] = var_13;
      }

      if(var_08.size == 1) {
        var_14 = 1.5;
        for(var_0C = 0; var_0C < var_11.size; var_0C++) {
          var_11[var_0C] = var_11[var_0C] + level.var_3C81[func_4194(var_0F[var_0C])][func_4194(var_08[0])] * var_14;
        }
      }

      if(self.var_943A == 0) {
        var_0F = randomint(100);
        if(var_13 < 50) {
          var_05 = var_0E[0];
        } else if(var_13 < 50 + 50 / var_0E.size - 1) {
          var_05 = var_0E[1];
        } else {
          var_05 = var_0E[2];
        }
      } else if(var_11.size == 2) {
        var_15[0] = 50;
        var_15[1] = 50;
        for(var_0C = 0; var_0C < var_0F.size; var_0C++) {
          if(var_11[var_0C] < var_11[1 - var_0C]) {
            var_15[var_0C] = var_15[var_0C] + 20;
            var_15[1 - var_0C] = var_15[1 - var_0C] - 20;
          }

          if(var_12[var_0C] < 640) {
            var_15[var_0C] = var_15[var_0C] + 15;
            var_15[1 - var_0C] = var_15[1 - var_0C] - 15;
          }

          if(var_0F[var_0C] maps\mp\gametypes\dom::func_44E3() == "neutral") {
            var_15[var_0C] = var_15[var_0C] + 15;
            var_15[1 - var_0C] = var_15[1 - var_0C] - 15;
          }
        }

        var_0F = randomint(100);
        if(var_15 < var_13[0]) {
          var_05 = var_0E[0];
        } else {
          var_05 = var_0E[1];
        }
      } else if(var_12.size == 3) {
        var_15[0] = 34;
        var_15[1] = 33;
        var_15[2] = 33;
        for(var_0C = 0; var_0C < var_0F.size; var_0C++) {
          var_16 = var_0C + 1 % 3;
          var_17 = var_0C + 2 % 3;
          if(var_11[var_0C] < var_11[var_16] && var_11[var_0C] < var_11[var_17]) {
            var_15[var_0C] = var_15[var_0C] + 36;
            var_15[var_16] = var_15[var_16] - 18;
            var_15[var_17] = var_15[var_17] - 18;
          }

          if(var_12[var_0C] < 640) {
            var_15[var_0C] = var_15[var_0C] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }

          if(var_0F[var_0C] maps\mp\gametypes\dom::func_44E3() == "neutral") {
            var_15[var_0C] = var_15[var_0C] + 15;
            var_15[var_16] = var_15[var_16] - 7;
            var_15[var_17] = var_15[var_17] - 8;
          }
        }

        var_0F = randomint(100);
        if(var_17 < var_13[0]) {
          var_05 = var_0E[0];
        } else if(var_17 < var_13[0] + var_13[1]) {
          var_05 = var_0E[1];
        } else {
          var_05 = var_0E[2];
        }
      }
    }
  } else {
    if(var_0F.size > 1) {
      var_18 = common_scripts\utility::func_40B0(self.var_0116, var_0F);
    } else {
      var_18 = var_11;
    }

    foreach(var_1A in var_18) {
      if(func_1AE1(var_1A, var_0F.size)) {
        var_0D = var_1A;
        break;
      }
    }

    if(!isDefined(var_0D)) {
      if(self.var_943A == 0) {
        var_0D = var_0F[0];
      } else if(var_18.size == 2) {
        var_1C = func_426A(var_18[0], var_18[1]);
        var_1D = common_scripts\utility::func_40B0(var_1C.var_0116, var_18);
        var_0F = randomint(100);
        if(var_1D < 70) {
          var_0C = var_1C[0];
        } else {
          var_0C = var_1C[1];
        }
      } else {
        var_0F = var_1A[0];
      }
    }
  }

  if(var_1B) {
    func_1FAD(var_12);
    return;
  }

  func_2C17(var_12);
}

func_61AD() {
  var_00 = maps\mp\bots\_bots_util::func_19F9(self.var_01A7);
  return ceil(var_00 / 3);
}

func_1934() {
  if(self.var_943A == 0) {
    return 1;
  }

  var_00 = func_4278();
  if(var_00.size == 3) {
    return 1;
  }

  var_01 = maps\mp\gametypes\_gamescore::func_063E(common_scripts\utility::func_416F(self.var_01A7));
  var_02 = maps\mp\gametypes\_gamescore::func_063E(self.var_01A7);
  var_03 = 200 - var_01;
  var_04 = 200 - var_02;
  var_05 = var_04 * 0.5 > var_03;
  return var_05;
}

func_1AE0(param_00) {
  if(randomfloat(1) < param_00) {
    return 1;
  }

  var_01 = level.var_1A92[self.var_6F7D];
  if(var_01 == "stationary") {
    return 1;
  } else if(var_01 == "active") {
    return 0;
  }
}

func_1FAD(param_00, param_01, param_02) {
  self.var_28F7 = param_00;
  if(func_19B3()) {
    var_03["override_goal_type"] = param_01;
    var_03["entrance_points_index"] = func_4194(param_00);
    maps\mp\bots\_bots_strategy::func_1AA6(param_00.var_0116, func_4195(), var_03);
  } else {
    param_00["override_goal_type"] = param_02;
    var_03["entrance_points_index"] = func_4194(param_00);
    maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_00.var_671A, param_00, var_03);
  }

  if(!isDefined(param_02) || !param_02) {
    thread func_630E(param_00);
  }
}

func_2C17(param_00) {
  self.var_28F7 = param_00;
  if(func_19B2()) {
    var_01["entrance_points_index"] = func_4194(param_00);
    maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_00.var_671A, param_00, var_01);
  } else {
    param_00["entrance_points_index"] = func_4194(var_01);
    var_01["nearest_node_to_center"] = param_00.var_6638;
    maps\mp\bots\_bots_strategy::func_1AA6(param_00.var_0116, func_4195(), var_01);
  }

  thread func_630E(param_00);
}

func_4193() {
  if(!isDefined(level.var_1FB1)) {
    level.var_1FB1 = 158;
  }

  return level.var_1FB1;
}

func_4195() {
  if(!isDefined(level.var_7790)) {
    var_00 = self method_8361();
    var_01 = var_00[0] + var_00[1] / 2;
    level.var_7790 = min(1000, var_01 / 3.5);
  }

  return level.var_7790;
}

func_19B5(param_00, param_01) {
  if(issubstr(param_00, "losing") && param_00 != "losing_score" && param_00 != "losing_time") {
    var_02 = getsubstr(param_00, param_00.size - 2);
    var_03 = func_4341(var_02);
    if(func_1933(var_03)) {
      self botmemoryevent("known_enemy", undefined, var_03.var_0116);
      if(!isDefined(self.var_5B30) || gettime() - self.var_5B30 > 10000) {
        if(maps\mp\bots\_bots_util::func_1A33()) {
          var_04 = distancesquared(self.var_0116, var_03.var_0116) < 490000;
          var_05 = func_1A34(var_03);
          if(var_04 || var_05) {
            func_1FAD(var_03);
            self.var_5B30 = gettime();
          }
        }
      }
    }
  } else if(issubstr(param_00, "secured")) {
    var_02 = getsubstr(param_00, param_00.size - 2);
    var_06 = func_4341(var_02);
    var_06.var_5B62[self.var_01A7] = gettime();
  }

  maps\mp\bots\_bots_util::func_1A59(param_00, param_01);
}

func_1933(param_00) {
  var_01 = func_4278();
  if(var_01.size == 0) {
    return 1;
  }

  if(common_scripts\utility::func_0F79(var_01, param_00)) {
    return 1;
  }

  return 0;
}

func_630E(param_00) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = func_4250(self.var_01A7);
  var_02 = func_4193() * func_4193();
  var_03 = func_4193() * 3 * func_4193() * 3;
  var_04 = 1;
  while(var_04) {
    var_05 = 0;
    var_06 = param_00 maps\mp\gametypes\dom::func_44E3();
    var_07 = func_4250(self.var_01A7);
    var_08 = func_416E(self.var_01A7);
    if(maps\mp\bots\_bots_util::func_1A28()) {
      if(var_06 == self.var_01A7 && param_00.var_A222.var_230F == "none") {
        if(!func_19B2()) {
          var_05 = 1;
        }
      }

      if(var_07 == 2 && var_06 != self.var_01A7 && !func_1934()) {
        if(distancesquared(self.var_0116, param_00.var_0116) > var_02) {
          var_05 = 1;
        }
      }

      foreach(var_0A in var_08) {
        if(var_0A != param_00 && func_1933(var_0A)) {
          if(distancesquared(self.var_0116, var_0A.var_0116) < var_03) {
            var_05 = 1;
          }
        }
      }

      if(self istouching(param_00) && param_00.var_A222.var_A22B <= 0) {
        if(self method_8367()) {
          var_0C = self method_835C();
          var_0D = self method_835D();
          if(distancesquared(self.var_0116, var_0C) < squared(var_0D)) {
            var_0E = self getnearestnode();
            if(isDefined(var_0E)) {
              var_0F = undefined;
              foreach(var_11 in param_00.var_671A) {
                if(!function_01F4(var_11, var_0E, 1)) {
                  var_0F = var_11.var_0116;
                  break;
                }
              }

              if(isDefined(var_0F)) {
                self.var_2C87 = var_0F;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(maps\mp\bots\_bots_util::func_1A33()) {
      if(var_06 != self.var_01A7) {
        if(!func_19B3()) {
          var_05 = 1;
        }
      } else if(var_07 == 1 && var_01 > 1) {
        var_05 = 1;
      }
    }

    var_01 = var_07;
    if(var_05) {
      self.var_3DF4 = 1;
      var_04 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_13 = level common_scripts\utility::func_A74D("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    if(!isDefined(var_13) && var_13 == "timeout") {
      var_14 = max(3 - self.var_943A * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait(var_14);
    }
  }
}

func_19B4(param_00) {
  if(param_00 == self.var_6709) {
    return 1;
  }

  if(!isDefined(self.var_28F7)) {
    return 1;
  }

  var_01 = 0;
  var_02 = func_4194(self.var_28F7);
  var_03 = func_4094(self.var_01A7);
  foreach(var_05 in var_03) {
    if(var_05 != self.var_28F7) {
      var_01 = param_00 maps\mp\bots\_bots_util::func_670D(var_02, func_4194(var_05));
      if(var_01) {
        var_06 = func_426A(self.var_28F7, var_05);
        var_07 = var_06 maps\mp\gametypes\dom::func_44E3();
        if(var_07 != self.var_01A7) {
          if(param_00 maps\mp\bots\_bots_util::func_670D(var_02, func_4194(var_06))) {
            var_01 = 0;
          }
        }
      }
    }
  }

  if(var_01) {
    return 0.2;
  }

  return 1;
}

func_4194(param_00) {
  var_01 = "";
  if(isDefined(param_00.var_98BF)) {
    var_01 = var_01 + param_00.var_98BF + "_";
  }

  var_01 = var_01 + "flag" + param_00.var_81E8;
  return var_01;
}

func_426A(param_00, param_01) {
  for(var_02 = 0; var_02 < level.var_3CC5.size; var_02++) {
    if(level.var_3CC5[var_02] != param_00 && level.var_3CC5[var_02] != param_01) {
      return level.var_3CC5[var_02];
    }
  }
}

func_4342(param_00) {
  var_01 = "_" + tolower(param_00);
  return func_4341(var_01);
}

func_4341(param_00) {
  for(var_01 = 0; var_01 < level.var_3CC5.size; var_01++) {
    if(level.var_3CC5[var_01].var_81E8 == param_00) {
      return level.var_3CC5[var_01];
    }
  }
}

func_40FC(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in level.var_3CC5) {
    var_05 = distancesquared(var_04.var_0116, param_00);
    if(!isDefined(var_02) || var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

func_424E(param_00, param_01) {
  var_02 = 0;
  var_03 = func_4193();
  foreach(var_05 in level.var_6E97) {
    if(!isDefined(var_05.var_01A7)) {
      continue;
    }

    if(var_05.var_01A7 == self.var_01A7 && var_05 != self && maps\mp\_utility::func_5800(var_05)) {
      if(isai(var_05)) {
        if(var_05 func_1A29(param_00)) {
          var_02++;
        }

        continue;
      }

      if(!isDefined(param_01) || !param_01) {
        if(var_05 istouching(param_00)) {
          var_02++;
        }
      }
    }
  }

  return var_02;
}

func_1A29(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A28()) {
    return 0;
  }

  return func_1AF8(param_00);
}

func_1A34(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A33()) {
    return 0;
  }

  return func_1AF8(param_00);
}

func_1AF8(param_00) {
  return self.var_28F7 == param_00;
}

func_4250(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.var_3CC5.size; var_02++) {
    var_03 = level.var_3CC5[var_02] maps\mp\gametypes\dom::func_44E3();
    if(var_03 == param_00) {
      var_01++;
    }
  }

  return var_01;
}

func_416E(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_3CC5.size; var_02++) {
    var_03 = level.var_3CC5[var_02] maps\mp\gametypes\dom::func_44E3();
    if(var_03 == common_scripts\utility::func_416F(param_00)) {
      var_01 = common_scripts\utility::func_0F6F(var_01, level.var_3CC5[var_02]);
    }
  }

  return var_01;
}

func_4094(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_3CC5.size; var_02++) {
    var_03 = level.var_3CC5[var_02] maps\mp\gametypes\dom::func_44E3();
    if(var_03 == param_00) {
      var_01 = common_scripts\utility::func_0F6F(var_01, level.var_3CC5[var_02]);
    }
  }

  return var_01;
}

func_1AE1(param_00, param_01) {
  var_02 = func_420D(param_01);
  var_03 = func_42B5(param_00);
  return var_03.size < var_02;
}

func_420D(param_00) {
  var_01 = maps\mp\bots\_bots_util::func_19F9(self.var_01A7);
  if(param_00 == 1) {
    return ceil(var_01 / 6);
  }

  return ceil(var_01 / 3);
}

func_42B5(param_00) {
  var_01 = func_4195();
  var_02 = [];
  foreach(var_04 in level.var_6E97) {
    if(!isDefined(var_04.var_01A7)) {
      continue;
    }

    if(var_04.var_01A7 == self.var_01A7 && var_04 != self && maps\mp\_utility::func_5800(var_04)) {
      if(isai(var_04)) {
        if(var_04 func_1A34(param_00)) {
          var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
        }

        continue;
      }

      var_05 = gettime() - param_00.var_5B62[self.var_01A7];
      if(var_05 < 10000) {
        continue;
      }

      if(distancesquared(param_00.var_0116, var_04.var_0116) < var_01 * var_01) {
        var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
      }
    }
  }

  return var_02;
}