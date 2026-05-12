/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_common.gsc
**************************************************/

func_194E() {
  var_00 = [];
  var_01 = [];
  var_02 = 0;
  foreach(var_04 in level.var_1913) {
    var_00[var_02] = common_scripts\utility::func_7A33(var_04.var_1B49).var_0116;
    var_01[var_02] = "zone" + var_04.var_00E5;
    var_02++;
  }

  func_194D(var_00, var_01);
}

func_194F(param_00, param_01, param_02, param_03) {
  wait(1);
  var_04 = [];
  var_05 = [];
  var_06 = 0;
  foreach(var_0A, var_08 in param_00) {
    if(isDefined(param_00[var_0A].var_1B48)) {
      var_04[var_06] = param_00[var_0A].var_1B48.var_0116;
    } else {
      param_00[var_0A].var_6638 = function_00BA(param_00[var_0A].var_0116);
      if(!isDefined(param_00[var_0A].var_6638) || param_00[var_0A].var_6638 method_8389()) {
        var_09 = getnodesinradiussorted(param_00[var_0A].var_0116, 256, 0);
        if(var_09.size > 0) {
          param_00[var_0A].var_6638 = var_09[0];
        }
      }

      if(!isDefined(param_00[var_0A].var_6638)) {
        continue;
      }

      if(distance(param_00[var_0A].var_6638.var_0116, param_00[var_0A].var_0116) > 128) {
        param_00[var_0A].var_6638 = undefined;
        continue;
      }

      var_04[var_06] = param_00[var_0A].var_6638.var_0116;
    }

    var_05[var_06] = param_01 + param_00[var_0A].var_81E8;
    var_06++;
  }

  func_194D(var_04, var_05, param_02, param_03);
}

func_194D(param_00, param_01, param_02, param_03) {
  var_04 = !isDefined(param_02) || !param_02;
  var_05 = isDefined(param_03) && param_03;
  wait(0.1);
  if(var_05 && var_04) {
    var_06 = getallnodes();
    foreach(var_08 in var_06) {
      var_08.var_6AA8 = undefined;
    }
  }

  var_0A = [];
  for(var_0B = 0; var_0B < param_00.size; var_0B++) {
    var_0C = param_01[var_0B];
    var_0A[var_0C] = findentrances(param_00[var_0B]);
    wait 0.05;
    for(var_0D = 0; var_0D < var_0A[var_0C].size; var_0D++) {
      var_0E = var_0A[var_0C][var_0D];
      var_0E.var_55F0 = 1;
      var_0E.var_7779[var_0C] = maps\mp\bots\_bots_util::func_37DF(var_0E.var_0116, param_00[var_0B], "prone");
      wait 0.05;
      var_0E.var_2864[var_0C] = maps\mp\bots\_bots_util::func_37DF(var_0E.var_0116, param_00[var_0B], "crouch");
      wait 0.05;
    }
  }

  var_0F = [];
  if(var_04) {
    for(var_0B = 0; var_0B < param_00.size; var_0B++) {
      for(var_0D = var_0B + 1; var_0D < param_00.size; var_0D++) {
        var_10 = maps\mp\bots\_bots_util::func_4187(param_00[var_0B], param_00[var_0D]);
        foreach(var_08 in var_10) {
          var_08.var_6AA8[param_01[var_0B]][param_01[var_0D]] = 1;
        }
      }
    }
  }

  if(!isDefined(level.var_37DB)) {
    level.var_37DB = [];
  }

  if(!isDefined(level.var_37DA)) {
    level.var_37DA = [];
  }

  if(!isDefined(level.var_37DC)) {
    level.var_37DC = [];
  }

  if(var_05) {
    level.var_37DB = param_00;
    level.var_37DA = param_01;
    level.var_37DC = var_0A;
  } else {
    level.var_37DB = common_scripts\utility::func_0F73(level.var_37DB, param_00);
    level.var_37DA = common_scripts\utility::func_0F73(level.var_37DA, param_01);
    level.var_37DC = common_scripts\utility::func_0F76(level.var_37DC, var_0A);
  }

  level.var_37DD = 1;
}

func_192E(param_00, param_01) {
  if(param_01.var_003A == "trigger_radius") {
    var_02 = getnodesinradius(param_01.var_0116, param_01.var_014F, 0, 100);
    var_03 = common_scripts\utility::func_0F94(var_02, param_00);
    if(var_03.size > 0) {
      param_00 = common_scripts\utility::func_0F73(param_00, var_03);
    }
  } else if(param_01.var_003A == "trigger_multiple" || param_01.var_003A == "trigger_use_touch") {
    var_04[0] = param_01 method_8216(1, 1, 1);
    var_04[1] = param_01 method_8216(1, 1, -1);
    var_04[2] = param_01 method_8216(1, -1, 1);
    var_04[3] = param_01 method_8216(1, -1, -1);
    var_04[4] = param_01 method_8216(-1, 1, 1);
    var_04[5] = param_01 method_8216(-1, 1, -1);
    var_04[6] = param_01 method_8216(-1, -1, 1);
    var_04[7] = param_01 method_8216(-1, -1, -1);
    var_05 = 0;
    foreach(var_07 in var_04) {
      var_08 = distance(var_07, param_01.var_0116);
      if(var_08 > var_05) {
        var_05 = var_08;
      }
    }

    var_02 = getnodesinradius(param_01.var_0116, var_05, 0, 200);
    foreach(var_0B in var_02) {
      if(!ispointinvolume(var_0B.var_0116, param_01)) {
        if(ispointinvolume(var_0B.var_0116 + (0, 0, 40), param_01) || ispointinvolume(var_0B.var_0116 + (0, 0, 80), param_01) || ispointinvolume(var_0B.var_0116 + (0, 0, 120), param_01)) {
          param_00 = common_scripts\utility::func_0F6F(param_00, var_0B);
        }
      }
    }
  }

  return param_00;
}

func_1ADB() {
  wait(1);
  func_1ADC(level.var_1913);
  level.var_1AD2 = 1;
}

func_1ADC(param_00) {
  foreach(var_02 in param_00) {
    if(!isDefined(var_02.var_1B49)) {
      var_02.var_1B49 = func_1A08(var_02.var_9D65);
    }
  }
}

func_19E1(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_6E97) {
    if(maps\mp\_utility::func_5800(var_03) && isDefined(var_03.var_01A7) && var_03.var_01A7 == param_00) {
      var_01++;
    }
  }

  return var_01;
}

func_19DF(param_00, param_01, param_02) {
  var_03 = func_19E2("attacker", param_00);
  foreach(var_05 in level.var_744A) {
    if(!isai(var_05) && isDefined(var_05.var_01A7) && var_05.var_01A7 == param_00) {
      if(var_05 func_19E4() || distancesquared(param_01, var_05.var_0116) > squared(param_02)) {
        var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
      }
    }
  }

  return var_03;
}

func_19E0(param_00, param_01, param_02) {
  var_03 = func_19E2("defender", param_00);
  foreach(var_05 in level.var_744A) {
    if(!isai(var_05) && isDefined(var_05.var_01A7) && var_05.var_01A7 == param_00) {
      if(var_05 func_19E5() || distancesquared(param_01, var_05.var_0116) <= squared(param_02)) {
        var_03 = common_scripts\utility::func_0F6F(var_03, var_05);
      }
    }
  }

  return var_03;
}

func_19E4() {
  if(isDefined(level.var_19E3)) {
    return self[[level.var_19E3]]();
  }

  return 0;
}

func_19E5() {
  if(isDefined(level.var_19E6)) {
    return self[[level.var_19E6]]();
  }

  return 0;
}

func_19E9(param_00) {
  self.var_7ECA = param_00;
  self method_8358();
  maps\mp\bots\_bots_strategy::func_19A3();
}

func_19E2(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.var_6E97) {
    if(isDefined(var_04.var_01A7) && isalive(var_04) && maps\mp\_utility::func_5800(var_04) && var_04.var_01A7 == param_01 && isDefined(var_04.var_7ECA) && var_04.var_7ECA == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_19E7() {
  var_00 = [[level.var_19D6]](self.var_01A7);
  var_01 = [[level.var_19D7]](self.var_01A7);
  var_02 = [[level.var_19DB]](self.var_01A7);
  var_03 = [[level.var_19DE]](self.var_01A7);
  var_04 = level.var_1A92[self.var_6F7D];
  if(var_04 == "active") {
    if(var_00.size >= var_02) {
      var_05 = 0;
      foreach(var_07 in var_00) {
        if(isai(var_07) && level.var_1A92[var_07.var_6F7D] == "stationary" && var_07 func_195B()) {
          var_07.var_7ECA = undefined;
          var_05 = 1;
          break;
        }
      }

      if(var_05) {
        func_19E9("attacker");
        return;
      }

      func_19E9("defender");
      return;
    }

    func_19E9("attacker");
    return;
  }

  if(var_04 == "stationary") {
    if(var_01.size >= var_03) {
      var_05 = 0;
      foreach(var_0A in var_01) {
        if(isai(var_0A) && level.var_1A92[var_0A.var_6F7D] == "active" && var_0A func_195A()) {
          var_0A.var_7ECA = undefined;
          var_05 = 1;
          break;
        }
      }

      if(var_05) {
        func_19E9("defender");
        return;
      }

      func_19E9("attacker");
      return;
    }

    func_19E9("defender");
    return;
  }
}

func_19DA() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  var_00 = ["allies", "axis"];
  var_01 = gettime() + 2000;
  for(;;) {
    if(gettime() > var_01) {
      var_01 = gettime() + 1000;
      foreach(var_03 in var_00) {
        var_04 = [[level.var_19D6]](var_03);
        var_05 = [[level.var_19D7]](var_03);
        var_06 = [[level.var_19DB]](var_03);
        var_07 = [[level.var_19DE]](var_03);
        if(var_04.size > var_06) {
          var_08 = [];
          var_09 = 0;
          foreach(var_0B in var_04) {
            if(isai(var_0B) && var_0B func_195B()) {
              if(level.var_1A92[var_0B.var_6F7D] == "stationary") {
                var_0B func_19E9("defender");
                var_09 = 1;
                break;
              } else {
                var_08 = common_scripts\utility::func_0F6F(var_08, var_0B);
              }
            }
          }

          if(!var_09 && var_08.size > 0) {
            common_scripts\utility::func_7A33(var_08) func_19E9("defender");
          }
        }

        if(var_09.size > var_0B) {
          var_0D = [];
          var_0E = 0;
          foreach(var_10 in var_09) {
            if(isai(var_10) && var_10 func_195A()) {
              if(level.var_1A92[var_10.var_6F7D] == "active") {
                var_10 func_19E9("attacker");
                var_0E = 1;
                break;
              } else {
                var_0D = common_scripts\utility::func_0F6F(var_0D, var_10);
              }
            }
          }

          if(!var_0E && var_0D.size > 0) {
            common_scripts\utility::func_7A33(var_0D) func_19E9("attacker");
          }
        }
      }
    }

    wait 0.05;
  }
}

func_195A() {
  if(isDefined(level.var_19D8)) {
    return self[[level.var_19D8]]();
  }

  return 1;
}

func_195B() {
  if(isDefined(level.var_19D9)) {
    return self[[level.var_19D9]]();
  }

  return 1;
}

func_1B1D(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_1913) {}

  if(!var_01) {
    func_194E();
  }

  return !var_01;
}

func_1A08(param_00) {
  var_01 = getnodesintrigger(param_00, 1);
  var_02 = [];
  foreach(var_04 in var_01) {
    if(!var_04 method_8389() && var_04.var_01B9 != "Begin" && var_04.var_01B9 != "End") {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_1951(param_00) {
  var_01 = [];
  var_02 = [];
  var_03 = 0;
  foreach(var_05 in param_00) {
    var_06 = 0;
    var_05.var_37DA = [];
    var_05.var_AC7F = func_1E4B(var_05);
    var_05.var_206D = func_AC85(var_05, 0, 0);
    var_07 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];
    foreach(var_09 in var_07) {
      var_0A = func_AC85(var_05, var_09[0], var_09[1]);
      var_01[var_03] = var_0A.var_0116;
      var_0B = var_05.var_81E8 + "_" + var_06;
      var_02[var_03] = var_0B;
      var_05.var_37DA[var_05.var_37DA.size] = var_0B;
      var_03++;
      var_06++;
    }
  }

  func_194D(var_01, var_02, 1);
}

func_1E4B(param_00) {
  var_01 = spawnStruct();
  var_01.var_61B1 = (999999, 999999, 999999);
  var_01.var_605E = (-999999, -999999, -999999);
  foreach(var_03 in param_00.var_671A) {
    var_01.var_61B1 = (min(var_03.var_0116[0], var_01.var_61B1[0]), min(var_03.var_0116[1], var_01.var_61B1[1]), min(var_03.var_0116[2], var_01.var_61B1[2]));
    var_01.var_605E = (max(var_03.var_0116[0], var_01.var_605E[0]), max(var_03.var_0116[1], var_01.var_605E[1]), max(var_03.var_0116[2], var_01.var_605E[2]));
  }

  var_01.var_206B = (var_01.var_61B1[0] + var_01.var_605E[0] / 2, var_01.var_61B1[1] + var_01.var_605E[1] / 2, var_01.var_61B1[2] + var_01.var_605E[2] / 2);
  var_01.var_4954 = (var_01.var_605E[0] - var_01.var_206B[0], var_01.var_605E[1] - var_01.var_206B[1], var_01.var_605E[2] - var_01.var_206B[2]);
  var_01.var_014F = max(var_01.var_4954[0], var_01.var_4954[1]);
  return var_01;
}

func_AC85(param_00, param_01, param_02) {
  var_03 = (param_00.var_AC7F.var_206B[0] + param_01 * param_00.var_AC7F.var_4954[0], param_00.var_AC7F.var_206B[1] + param_02 * param_00.var_AC7F.var_4954[1], 0);
  var_04 = undefined;
  var_05 = 9999999;
  foreach(var_07 in param_00.var_671A) {
    var_08 = distance2dsquared(var_07.var_0116, var_03);
    if(var_08 < var_05) {
      var_05 = var_08;
      var_04 = var_07;
    }
  }

  return var_04;
}

func_6361() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var_00 = getzonenearest(self.var_0116);
  for(;;) {
    var_01 = "none";
    if(isDefined(self.var_3FCA)) {
      var_01 = self.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
    }

    if(var_01 == "neutral" || var_01 == "none") {
      botzonesetteam(var_00, "free");
    } else {
      botzonesetteam(var_00, var_01);
    }

    wait(1);
  }
}

func_62EA() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var_00 = getzonenearest(self.var_28D4);
  for(;;) {
    if(self.var_18F9) {
      var_01 = common_scripts\utility::func_416F(self.var_6DB2);
    } else {
      var_01 = self.var_6DB2;
    }

    if(var_01 == "neutral" || var_01 == "any") {
      var_01 = "free";
    }

    botzonesetteam(var_00, var_01);
    wait(1);
  }
}

func_3B69(param_00) {
  var_01 = undefined;
  var_02 = 999999999;
  foreach(var_04 in level.var_1913) {
    var_05 = distancesquared(var_04.var_28D4, param_00.var_0116);
    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

func_41FB(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.var_6E97) {
    if(!isDefined(var_04.var_01A7)) {
      continue;
    }

    if(maps\mp\_utility::func_57A0(var_04) && maps\mp\_utility::func_5800(var_04) && var_04.var_01A7 == param_00) {
      if(!isDefined(param_01) || param_01 && isai(var_04) && isDefined(var_04.var_7ECA)) {
        var_02[var_02.size] = var_04;
      }
    }
  }

  return var_02;
}

func_40DF(param_00, param_01) {
  if(param_00.var_1B49.size >= 2) {
    if(param_01) {
      var_02 = self method_8382(param_00.var_1B49, "node_exposed");
    } else {
      var_02 = self method_8382(param_01.var_1B49, "node_hide_anywhere", "ignore_occupancy");
    }

    var_03 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_04 = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
    var_05 = common_scripts\utility::func_0F92(param_00.var_1B49);
    foreach(var_07 in var_05) {
      if(!common_scripts\utility::func_0F79(var_02, var_07)) {
        var_02[var_02.size] = var_07;
      }
    }

    if(randomfloat(1) < var_03) {
      return var_02[0];
    }

    if(randomfloat(1) < var_04) {
      return var_02[1];
    }

    return common_scripts\utility::func_7A33(var_02);
  }

  return param_00.var_1B49[0];
}

func_40DE(param_00) {
  var_01 = self method_8382(param_00.var_1B49, "node_hide_anywhere", "ignore_occupancy");
  var_02 = self botgetdifficultysetting("strategyLevel") * 0.3;
  var_03 = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
  var_04 = common_scripts\utility::func_0F92(param_00.var_1B49);
  foreach(var_06 in var_04) {
    if(!common_scripts\utility::func_0F79(var_01, var_06)) {
      var_01[var_01.size] = var_06;
    }
  }

  if(randomfloat(1) < var_02) {
    return var_01[0];
  }

  if(randomfloat(1) < var_03) {
    return var_01[1];
  }

  return common_scripts\utility::func_7A33(var_01);
}

func_1911(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_04 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_04 = 80;
  }

  if(randomint(100) < var_04 && !isDefined(param_03) && param_03) {
    self botsetstance("prone");
    wait(0.2);
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !param_02) {
    childthread func_6800();
    childthread func_67FA();
  }

  self botpressbutton("use", param_00);
  var_05 = maps\mp\bots\_bots_util::func_1B16(param_00, param_01, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var_06 = var_05 == param_01;
  return var_06;
}

func_6800() {
  self endon("stop_usebutton_watcher");
  var_00 = func_3B69(self);
  self waittill("bulletwhizby", var_01);
  if(!isDefined(var_01.var_01A7) || var_01.var_01A7 != self.var_01A7) {
    var_02 = var_00.var_A23F - var_00.var_28D5;
    if(var_02 > 1000) {
      self notify("use_interrupted");
    }
  }
}

func_67FA() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", var_00, var_01);
  if(!isDefined(var_01.var_01A7) || var_01.var_01A7 != self.var_01A7) {
    self notify("use_interrupted");
  }
}

func_4065(param_00) {
  var_01 = [];
  var_02 = func_41FB(common_scripts\utility::func_416F(self.var_01A7));
  foreach(var_04 in var_02) {
    if(!isai(var_04)) {
      continue;
    }

    var_05 = 0;
    if(param_00 == "plant") {
      var_05 = 300 + var_04 botgetdifficultysetting("strategyLevel") * 100;
    } else if(param_00 == "defuse") {
      var_05 = 500 + var_04 botgetdifficultysetting("strategyLevel") * 500;
    }

    if(distancesquared(var_04.var_0116, self.var_0116) < squared(var_05)) {
      var_01[var_01.size] = var_04;
    }
  }

  return var_01;
}