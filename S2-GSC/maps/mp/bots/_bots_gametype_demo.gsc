/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_demo.gsc
************************************************/

func_00F9() {
  func_87A7();
  func_199A();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_199B;
  level.var_19D5["notify_enemy_bots_bomb_used"] = ::func_67F5;
}

func_199A() {
  func_8792();
}

func_8792() {
  maps\mp\bots\_bots_gametype_common::func_1ADB();
  maps\mp\bots\_bots_util::func_1B20();
  var_00 = maps\mp\bots\_bots_gametype_common::func_1B1D(["_a", "_b"]);
  if(var_00) {
    foreach(var_02 in level.var_1913) {
      var_02 thread maps\mp\bots\_bots_gametype_common::func_62EA();
    }

    thread func_1997();
    level.var_19E8 = 1;
  }
}

func_199B() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self.var_28EE = undefined;
  self.var_2CA5 = 0;
  for(;;) {
    wait 0.05;
    if(isDefined(self.var_28EE) && !func_190F(self.var_28EE)) {
      self.var_28EE = undefined;
      func_1998();
    }

    if(maps\mp\_utility::func_5380()) {
      var_00 = level.var_1913[0].var_6DB2 != self.var_01A7;
    } else {
      var_00 = self.var_01A7 == game["attackers"];
    }

    if(var_00) {
      func_1A96("attack");
      if(!isDefined(self.var_28EE)) {
        continue;
      }

      func_1B08();
      func_1970();
      if(self.var_7ECA == "sweep_zone") {
        if(!maps\mp\bots\_bots_util::func_1A2E(self.var_28EE.var_28D4)) {
          var_01["min_goal_time"] = 2;
          var_01["max_goal_time"] = 4;
          var_01["override_origin_node"] = common_scripts\utility::func_7A33(self.var_28EE.var_1B49);
          maps\mp\bots\_bots_strategy::func_1AA6(self.var_28EE.var_28D4, level.var_7790, var_01);
        }
      } else if(self.var_7ECA == "defend_zone") {
        if(!function_0279(level.var_2D65[self.var_28EE.var_00E5]) && !maps\mp\bots\_bots_util::func_1A2E(level.var_2D65[self.var_28EE.var_00E5].var_0116)) {
          var_01["score_flags"] = "strongly_avoid_center";
          maps\mp\bots\_bots_strategy::func_1AA6(level.var_2D65[self.var_28EE.var_00E5].var_0116, level.var_7790, var_01);
        }
      } else if(self.var_7ECA == "investigate_someone_using_bomb") {
        func_5519();
      } else if(self.var_7ECA == "atk_bomber") {
        func_7060();
      }

      continue;
    }

    func_1A96("defend");
    if(!isDefined(self.var_28EE)) {
      continue;
    }

    func_1972();
    if(self.var_7ECA == "defend_zone") {
      if(!maps\mp\bots\_bots_util::func_1A2E(self.var_28EE.var_28D4)) {
        var_01["score_flags"] = "strict_los";
        var_01["override_origin_node"] = common_scripts\utility::func_7A33(self.var_28EE.var_1B49);
        maps\mp\bots\_bots_strategy::func_1AA6(self.var_28EE.var_28D4, level.var_7790, var_01);
      }

      continue;
    }

    if(self.var_7ECA == "investigate_someone_using_bomb") {
      func_5519();
      continue;
    }

    if(self.var_7ECA == "defuser") {
      func_2C92();
    }
  }
}

func_67F5(param_00) {
  var_01 = maps\mp\bots\_bots_gametype_common::func_3B69(self);
  var_02 = maps\mp\bots\_bots_gametype_common::func_4065(param_00);
  foreach(var_04 in var_02) {
    if(isDefined(var_04.var_28EE) && var_01 == var_04.var_28EE) {
      var_04 func_1999("investigate_someone_using_bomb");
    }
  }
}

func_7060() {
  self endon("change_role");
  var_00 = maps\mp\bots\_bots_gametype_common::func_40DF(self.var_28EE, 0);
  self botsetscriptgoal(var_00.var_0116, 0, "critical");
  var_01 = maps\mp\bots\_bots_util::func_1B21(undefined, "change_role");
  if(var_01 == "goal") {
    var_02 = maps\mp\gametypes\_gamelogic::func_46E5();
    var_03 = var_02 - level.var_7078 * 2 * 1000;
    var_04 = gettime() + var_03;
    if(var_03 > 0) {
      maps\mp\bots\_bots_util::func_1B22(var_03);
    }

    var_05 = var_04 > 0 && gettime() >= var_04;
    var_06 = maps\mp\bots\_bots_gametype_common::func_1911(level.var_7078 + 2, "bomb_planted", var_05);
    self method_8358();
    if(var_06) {
      func_1998();
    }
  }
}

func_2C92() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  var_00 = maps\mp\bots\_bots_gametype_common::func_40DE(self.var_28EE).var_0116;
  self botsetscriptgoal(var_00, 20, "critical");
  var_01 = maps\mp\bots\_bots_util::func_1B21(undefined, "change_role");
  if(var_01 == "bad_path") {
    self.var_2CA5++;
    if(self.var_2CA5 >= 4) {
      for(;;) {
        var_02 = getnodesinradiussorted(var_00, 50, 0);
        var_03 = self.var_2CA5 - 4;
        if(var_02.size <= var_03) {
          var_04 = botgetclosestnavigablepoint(var_00, 50, self);
          if(isDefined(var_04)) {
            self botsetscriptgoal(var_04, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var_03[var_04].var_0116, 20, "critical");
        }

        var_02 = maps\mp\bots\_bots_util::func_1B21(undefined, "change_role");
        if(var_02 == "bad_path") {
          self.var_2CA5++;
          continue;
        }

        break;
      }
    }
  }

  if(var_03 == "goal") {
    var_05 = self.var_28EE.var_2CA0 - gettime() * 1000;
    var_06 = var_05 - level.var_2CA9 * 2 * 1000;
    var_07 = gettime() + var_06;
    if(var_06 > 0) {
      maps\mp\bots\_bots_util::func_1B22(var_06);
    }

    var_08 = var_07 > 0 && gettime() >= var_07;
    var_09 = maps\mp\bots\_bots_gametype_common::func_1911(level.var_2CA9 + 2, "bomb_defused", var_08);
    if(!var_09 && self.var_2CA5 >= 4) {
      self.var_2CA5++;
    }

    self method_8358();
    if(var_09) {
      func_1998();
    }
  }
}

func_5519() {
  self endon("change_role");
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  self botsetscriptgoalnode(common_scripts\utility::func_7A33(self.var_28EE.var_1B49), "critical");
  var_00 = maps\mp\bots\_bots_util::func_1B21();
  if(var_00 == "goal") {
    wait(2);
    func_1998();
  }
}

func_4297(param_00) {
  var_01 = func_42B2(param_00, self.var_01A7);
  foreach(var_03 in var_01) {
    if(!isai(var_03)) {
      if(var_03.var_56C2) {
        return var_03;
      }
    }
  }

  foreach(var_03 in var_01) {
    if(isai(var_03)) {
      if(isDefined(var_03.var_7ECA) && var_03.var_7ECA == "defuser") {
        return var_03;
      }
    }
  }

  return undefined;
}

func_42A6(param_00) {
  var_01 = func_42B2(param_00, self.var_01A7);
  foreach(var_03 in var_01) {
    if(!isai(var_03)) {
      if(var_03.var_5777) {
        return var_03;
      }
    }
  }

  foreach(var_03 in var_01) {
    if(isai(var_03)) {
      if(isDefined(var_03.var_7ECA) && var_03.var_7ECA == "atk_bomber") {
        return var_03;
      }
    }
  }

  return undefined;
}

func_190F(param_00) {
  if(param_00.var_A560 == "any" || param_00.var_18F9) {
    return 1;
  }

  return 0;
}

func_405F() {
  var_00 = [];
  foreach(var_02 in level.var_1913) {
    if(func_190F(var_02)) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_42B2(param_00, param_01) {
  var_02 = [];
  var_03 = maps\mp\bots\_bots_gametype_common::func_41FB(param_01);
  foreach(var_05 in var_03) {
    if(isai(var_05)) {
      if(isDefined(var_05.var_28EE) && var_05.var_28EE == param_00) {
        var_02 = common_scripts\utility::func_0F6F(var_02, var_05);
      }

      continue;
    }

    if(distancesquared(var_05.var_0116, param_00.var_28D4) < level.var_7790 * level.var_7790) {
      var_02 = common_scripts\utility::func_0F6F(var_02, var_05);
    }
  }

  return var_02;
}

func_1A94(param_00, param_01) {
  var_02[0] = func_42B2(param_00[0], game["defenders"]).size;
  var_02[1] = func_42B2(param_00[1], game["defenders"]).size;
  if(var_02[0] > var_02[1] + param_01) {
    return param_00[1];
  }

  if(var_02[0] + param_01 < var_02[1]) {
    return param_00[0];
  }
}

func_1A96(param_00) {
  var_01 = undefined;
  if(param_00 == "attack") {
    var_01 = func_1971();
  } else if(param_00 == "defend") {
    var_01 = func_1973();
  }

  if(isDefined(var_01) && !isDefined(self.var_28EE) || self.var_28EE != var_01) {
    self.var_28EE = var_01;
    func_1998();
  }
}

func_1973() {
  var_00 = func_405F();
  var_01 = undefined;
  if(var_00.size == 1) {
    var_01 = var_00[0];
  } else if(var_00.size == 2) {
    var_02[0] = func_42B2(var_00[0], game["defenders"]).size;
    var_02[1] = func_42B2(var_00[1], game["defenders"]).size;
    var_03[0] = func_553C(var_00[0]);
    var_03[1] = func_553C(var_00[1]);
    if((var_03[0] && var_03[1]) || !var_03[0] && !var_03[1]) {
      var_04 = 0;
      if(isDefined(self.var_28EE)) {
        var_04 = 1;
      }

      var_01 = func_1A94(var_00, var_04);
      if(!isDefined(var_01) && !isDefined(self.var_28EE)) {
        var_01 = common_scripts\utility::func_7A33(var_00);
      }
    } else if(var_03[0] || var_03[1]) {
      var_05 = common_scripts\utility::func_98E7(var_03[0], 0, 1);
      var_06 = common_scripts\utility::func_98E7(!var_03[0], 0, 1);
      if(var_02[var_05] > var_02[var_06] + 2) {
        var_01 = var_00[var_06];
      } else if(var_02[var_05] <= var_02[var_06]) {
        var_01 = var_00[var_05];
      } else if(!isDefined(self.var_28EE)) {
        if(var_02[var_05] >= var_02[var_06] + 2) {
          var_01 = var_00[var_06];
        } else if(var_02[var_05] < var_02[var_06] + 2) {
          var_01 = var_00[var_05];
        }
      }
    }
  }

  return var_06;
}

func_4269(param_00) {
  var_01 = func_405F();
  foreach(var_03 in var_01) {
    if(var_03 != param_00) {
      return var_03;
    }
  }
}

func_1971() {
  if(isDefined(self.var_28EE)) {
    return;
  }

  if(!isDefined(level.var_2921) || !func_190F(level.var_2921) || gettime() > level.var_66B4) {
    level.var_66B4 = gettime() + 1000 * randomintrange(30, 45);
    level.var_2921 = common_scripts\utility::func_7A33(func_405F());
  }

  if(!isDefined(level.var_2921)) {
    return;
  }

  var_00 = level.var_2921;
  var_01 = func_4269(var_00);
  self.var_28EE = undefined;
  if(isDefined(var_01)) {
    if(randomfloat(1) < 0.25) {
      return var_01;
    }
  }

  return var_00;
}

func_1B08() {
  var_00 = func_4269(self.var_28EE);
  if(isDefined(var_00)) {
    var_01 = distance(self.var_0116, self.var_28EE.var_28D4);
    var_02 = distance(self.var_0116, var_00.var_28D4);
    if(var_02 < var_01 * 0.6) {
      self.var_28EE = var_00;
    }
  }
}

func_1970() {
  if(isDefined(self.var_7ECA)) {
    if(self.var_7ECA == "investigate_someone_using_bomb") {
      return;
    }
  }

  var_00 = undefined;
  if(func_553C(self.var_28EE)) {
    var_00 = "defend_zone";
  } else {
    var_01 = func_42A6(self.var_28EE);
    if(!isDefined(var_01) || var_01 == self) {
      var_00 = "atk_bomber";
    } else if(isai(var_01)) {
      var_02 = distance(self.var_0116, self.var_28EE.var_28D4);
      var_03 = distance(var_01.var_0116, self.var_28EE.var_28D4);
      if(var_02 < var_03 * 0.9) {
        var_00 = "atk_bomber";
        var_01 func_1998();
      }
    }
  }

  if(!isDefined(var_01)) {
    var_01 = "sweep_zone";
  }

  func_1999(var_01);
}

func_1972() {
  if(isDefined(self.var_7ECA)) {
    if(self.var_7ECA == "investigate_someone_using_bomb") {
      return;
    }
  }

  var_00 = undefined;
  if(func_553C(self.var_28EE)) {
    var_01 = func_4297(self.var_28EE);
    if(!isDefined(var_01) || var_01 == self) {
      var_00 = "defuser";
    } else if(isai(var_01)) {
      var_02 = distance(self.var_0116, self.var_28EE.var_28D4);
      var_03 = distance(var_01.var_0116, self.var_28EE.var_28D4);
      if(var_02 < var_03 * 0.9) {
        var_00 = "defuser";
        var_01 func_1998();
      }
    }
  }

  if(!isDefined(var_01)) {
    var_01 = "defend_zone";
  }

  func_1999(var_01);
}

func_1999(param_00) {
  if(!isDefined(self.var_7ECA) || self.var_7ECA != param_00) {
    func_1998();
    self.var_7ECA = param_00;
  }
}

func_1998() {
  self.var_7ECA = undefined;
  self method_8358();
  self botsetpathingstyle(undefined);
  maps\mp\bots\_bots_strategy::func_19A3();
  self notify("change_role");
  self.var_2CA5 = 0;
}

func_1997() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level.var_7790 = 725;
  for(;;) {
    foreach(var_01 in level.var_1913) {
      foreach(var_03 in level.var_744A) {
        if(isDefined(var_03.var_7ECA) && isDefined(var_03.var_28EE) && var_03.var_28EE == var_01) {
          if(!func_190F(var_01)) {
            if(var_03.var_7ECA == "atk_bomber" || var_03.var_7ECA == "defuser") {
              var_03 func_1998();
            }

            continue;
          }

          if(func_553C(var_01)) {
            if(var_03.var_7ECA == "atk_bomber") {
              var_03 func_1998();
            }
          }
        }
      }
    }

    wait(0.5);
  }
}

func_553C(param_00) {
  return common_scripts\utility::func_562E(param_00.var_18F9);
}