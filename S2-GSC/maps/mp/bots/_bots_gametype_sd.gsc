/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_sd.gsc
**********************************************/

func_00F9() {
  func_87A7();
  func_1ABF();
}

func_87A7() {
  level.var_19D5["crate_can_use"] = ::func_2734;
  level.var_19D5["gametype_think"] = ::func_1AC0;
  level.var_19D5["should_start_cautious_approach"] = ::func_8B7D;
  level.var_19D5["know_enemies_on_start"] = undefined;
  level.var_19D5["notify_enemy_bots_bomb_used"] = ::func_67F5;
}

func_1ABF() {
  func_8799();
}

func_2734(param_00) {
  if(function_01EF(self) && !isDefined(param_00.var_1B7B)) {
    return 0;
  }

  if(!maps\mp\_utility::func_5800(self)) {
    return 1;
  }

  if(!isDefined(self.var_7ECA)) {
    return 0;
  }

  switch (self.var_7ECA) {
    case "investigate_someone_using_bomb":
    case "bomb_defuser":
    case "atk_bomber":
      return 0;
  }

  return 1;
}

func_8799() {
  level.var_1B3B = 1;
  level.var_52D4 = 3000;
  maps\mp\bots\_bots_gametype_common::func_1ADB();
  maps\mp\bots\_bots_util::func_1B20();
  level.var_1ABE = [];
  level.var_1ABE["axis"] = [];
  level.var_1ABE["allies"] = [];
  level.var_199D["atk_bomber"] = ::func_10F8;
  level.var_199D["clear_target_zone"] = ::func_23CF;
  level.var_199D["defend_planted_bomb"] = ::func_2C3B;
  level.var_199D["defuser"] = ::func_18B6;
  level.var_199D["investigate_someone_using_bomb"] = ::func_551A;
  level.var_199D["camp_bomb"] = ::func_1ECB;
  level.var_199D["defender"] = ::func_2C7C;
  level.var_199D["backstabber"] = ::func_14ED;
  level.var_199D["random_killer"] = ::func_7A3B;
  var_00 = maps\mp\bots\_bots_gametype_common::func_1B1D(["_a", "_b"]);
  if(var_00) {
    foreach(var_02 in level.var_1913) {
      var_02 thread maps\mp\bots\_bots_gametype_common::func_62EA();
    }

    thread func_1ABD();
    level.var_19E8 = 1;
  }
}

func_1AC0() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.var_4B44 = undefined;
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  var_00 = game["attackers"];
  var_01 = 1;
  if(isDefined(level.var_832F) && isDefined(level.var_832F.var_2006) && level.var_832F.var_2006 == self && isDefined(self.var_7ECA) && self.var_7ECA == "atk_bomber") {
    var_01 = 0;
  }

  if(var_01) {
    self.var_7ECA = undefined;
    if(isDefined(level.var_10F6) && level.var_10F6 == self) {
      level.var_10F6 = undefined;
    }
  }

  self.var_9526 = undefined;
  self.var_4B44 = 0;
  self.var_10F7 = 0;
  self.var_8311 = undefined;
  self.var_2C7B = undefined;
  self.var_2CA5 = 0;
  if(!isDefined(level.var_52CA) && !level.var_6510) {
    level.var_52CA = level.var_832F.var_28D4;
    level.var_52CB = function_00BA(level.var_832F.var_28D4);
  }

  if(self.var_01A7 == var_00 && !isDefined(level.var_1F1B)) {
    var_02 = 0;
    if(!level.var_6510) {
      var_03 = maps\mp\bots\_bots_gametype_common::func_41FB(var_00);
      foreach(var_05 in var_03) {
        if(!isai(var_05)) {
          var_02 = 1;
        }
      }
    }

    if(var_02) {
      var_07 = 6000;
      level.var_1F1B = gettime() + var_07;
      badplace_cylinder("bomb", var_07 / 1000, level.var_832F.var_28D4, 75, 300, var_00);
    }
  }

  for(;;) {
    wait(randomintrange(1, 3) * 0.05);
    if(self.var_00BC <= 0) {
      continue;
    }

    self.var_4B44 = 1;
    if(!isDefined(self.var_7ECA)) {
      func_52E9();
    }

    if(isDefined(self.var_9526)) {
      continue;
    }

    if(self.var_01A7 == var_00) {
      if(!level.var_6510 && isDefined(level.var_1F1B) && gettime() < level.var_1F1B && !isDefined(level.var_832F.var_2006)) {
        if(!maps\mp\bots\_bots_util::func_1A2E(level.var_832F.var_28D4)) {
          var_08 = function_00BA(level.var_832F.var_28D4);
          if(isDefined(var_08)) {
            var_09["nearest_node_to_center"] = var_08;
            maps\mp\bots\_bots_strategy::func_1AA6(level.var_832F.var_28D4, 900, var_09);
          } else {
            level.var_1F1B = gettime();
          }
        }
      } else {
        self[[level.var_199D[self.var_7ECA]]]();
      }

      continue;
    }

    if(level.var_18F9 && isDefined(level.var_8330)) {
      if(distancesquared(self.var_0116, level.var_8330.var_0116) > squared(level.var_7790 * 2)) {
        if(!isDefined(self.var_2C7B)) {
          self.var_2C7B = 1;
          self botsetpathingstyle("scripted");
        }
      } else if(isDefined(self.var_2C7B) && !isDefined(self.var_8311)) {
        self.var_2C7B = undefined;
        self botsetpathingstyle(undefined);
      }
    }

    if(level.var_18F9 && isDefined(level.var_18B5) && isDefined(level.var_8330) && self.var_7ECA != "defuser") {
      if(!maps\mp\bots\_bots_util::func_1A2E(level.var_8330.var_0116)) {
        self method_8358();
        maps\mp\bots\_bots_strategy::func_1AA6(level.var_8330.var_0116, level.var_7790);
      }

      continue;
    }

    self[[level.var_199D[self.var_7ECA]]]();
  }
}

func_18D9(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  self botsetstance("stand");
  wait(param_00);
  self botsetflag("disable_movement", 0);
  self botsetstance("none");
}

func_10F8() {
  self endon("new_role");
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  if(isDefined(level.var_832F) && isDefined(level.var_832F.var_2006) && isalive(level.var_832F.var_2006) && level.var_832F.var_2006 != self) {
    wait(0.7);
  }

  if(!self.var_568D && !level.var_6510) {
    if(isDefined(level.var_832F)) {
      if(!isDefined(self.var_5B18)) {
        self.var_5B18 = level.var_832F.var_28D4;
      }

      if(distancesquared(self.var_5B18, level.var_832F.var_28D4) > 4) {
        self method_8358();
        self.var_5B18 = level.var_832F.var_28D4;
      }
    }

    if(self.var_10F7 >= 2) {
      var_01 = getnodesinradiussorted(level.var_832F.var_28D4, 512, 0);
      var_02 = undefined;
      foreach(var_04 in var_01) {
        if(!var_04 method_8389()) {
          var_02 = var_04;
          break;
        }
      }

      if(isDefined(var_02)) {
        self botsetscriptgoal(var_02.var_0116, 20, "critical");
        maps\mp\bots\_bots_util::func_1B21();
        if(isDefined(level.var_832F) && !isDefined(level.var_832F.var_2006)) {
          level.var_832F maps\mp\gametypes\_gameobjects::func_86F9(self);
        }
      } else {}

      return;
    }

    if(!self method_8367()) {
      var_06 = 15;
      var_07 = 32;
      var_08 = maps\mp\bots\_bots_util::func_1AA8("BotGetClosestNavigablePoint", ::maps\mp\bots\_bots_util::func_3F03, level.var_832F.var_28D4, var_06 + var_07, self);
      if(isDefined(var_08)) {
        var_09 = self botsetscriptgoal(level.var_832F.var_28D4, 0, "critical");
        if(var_09) {
          childthread func_18E0();
          return;
        }

        return;
      }

      var_01 = getnodesinradiussorted(level.var_832F.var_28D4, 512, 0);
      if(var_08.size > 0) {
        self botsetscriptgoal(var_08[0].var_0116, 0, "critical");
        maps\mp\bots\_bots_util::func_1B21();
      }

      if(isDefined(level.var_832F) && !isDefined(level.var_832F.var_2006)) {
        var_07 = maps\mp\bots\_bots_util::func_1AA8("BotGetClosestNavigablePoint", ::maps\mp\bots\_bots_util::func_3F03, level.var_832F.var_28D4, var_05 + var_06, self);
        if(!isDefined(var_07)) {
          level.var_832F maps\mp\gametypes\_gameobjects::func_86F9(self);
          return;
        }

        return;
      }

      return;
    }

    return;
  }

  if(isDefined(self.var_3237) && gettime() < self.var_3237) {
    return;
  }

  if(!isDefined(level.var_18D1)) {
    level.var_18D1 = level.var_1913[randomint(level.var_1913.size)];
  }

  var_0A = level.var_18D1;
  self.var_1912 = var_0A;
  if(!isDefined(level.var_52CC) || gettime() - level.var_52CC < level.var_52D4) {
    level.var_52CC = gettime() + level.var_52D4;
    thread func_18D9(level.var_52D4 / 1000);
    wait(level.var_52D4 / 1000);
  }

  self method_8358();
  if(level.var_115F == "rush") {
    self botsetpathingstyle("scripted");
    var_0B = maps\mp\bots\_bots_gametype_common::func_40DF(var_0A, 1);
    self botsetscriptgoal(var_0B.var_0116, 0, "critical");
  }

  var_0C = maps\mp\bots\_bots_util::func_1B21();
  if(var_0C == "goal") {
    var_0D = func_4308() - gettime();
    var_0E = var_0D - level.var_7078 * 2 * 1000;
    var_0F = gettime() + var_0E;
    if(var_0E > 0) {
      maps\mp\bots\_bots_util::func_1B22(var_0E);
    }

    var_10 = gettime() >= var_0F;
    var_11 = maps\mp\bots\_bots_gametype_common::func_1911(level.var_7078 + 2, "bomb_planted", var_10);
    self method_8358();
    if(var_11) {
      maps\mp\bots\_bots_strategy::func_19BC();
      func_1AD7("defend_planted_bomb");
      return;
    }

    if(var_0E > 5000) {
      self.var_3237 = gettime() + 5000;
      return;
    }

    return;
  }
}

func_4308() {
  if(level.var_18F9) {
    return level.var_2CA0;
  }

  return gettime() + maps\mp\gametypes\_gamelogic::func_46E5();
}

func_18E0() {
  self notify("bomber_monitor_no_path");
  self endon("death");
  self endon("disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level.var_832F endon("pickup_object");
  for(;;) {
    self waittill("no_path");
    self.var_10F7++;
  }
}

func_23CF() {
  self endon("new_role");
  if(isDefined(level.var_10F6)) {
    if(level.var_115F == "rush") {
      if(!isDefined(self.var_84E9)) {
        if(!level.var_6510) {
          var_00["nearest_node_to_center"] = level.var_52CB;
          maps\mp\bots\_bots_strategy::func_1AA6(level.var_52CA, 900, var_00);
          wait(randomfloatrange(0, 4));
          maps\mp\bots\_bots_strategy::func_19A3();
        }

        self.var_84E9 = 1;
      }

      if(self botgetdifficultysetting("strategyLevel") > 0) {
        func_84A4();
      }

      if(isai(level.var_10F6) && isDefined(level.var_10F6.var_1912)) {
        var_01 = level.var_10F6.var_1912;
      } else if(isDefined(level.var_18D1)) {
        var_01 = level.var_18D1;
      } else {
        var_01 = maps\mp\bots\_bots_gametype_common::func_3B69(level.var_10F6);
      }

      if(!maps\mp\bots\_bots_util::func_1A2E(var_01.var_28D4)) {
        var_01["min_goal_time"] = 2;
        var_01["max_goal_time"] = 4;
        var_01["override_origin_node"] = common_scripts\utility::func_7A33(var_01.var_1B49);
        maps\mp\bots\_bots_strategy::func_1AA6(var_01.var_28D4, level.var_7790, var_01);
        return;
      }
    }
  }
}

func_2C3B() {
  self endon("new_role");
  if(level.var_18F9 && isDefined(level.var_8330)) {
    if(level.var_115F == "rush") {
      func_2F3A();
    }

    if(!maps\mp\bots\_bots_util::func_1A2E(level.var_8330.var_0116)) {
      var_00["score_flags"] = "strongly_avoid_center";
      maps\mp\bots\_bots_strategy::func_1AA6(level.var_8330.var_0116, level.var_7790, var_00);
    }
  }
}

func_18B6() {
  self endon("new_role");
  if(level.var_18D3 || !isDefined(level.var_8330)) {
    return;
  }

  var_00 = func_3B82();
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = common_scripts\utility::func_40B0(level.var_8330.var_0116, var_00.var_1B49);
  var_02 = (level.var_8330.var_0116[0], level.var_8330.var_0116[1], var_01[0].var_0116[2]);
  if(self.var_2CA5 <= 1) {
    var_03 = func_2056(var_02, undefined);
  } else {
    self method_8358();
    var_03 = self botsetscriptgoal(var_03, 20, "critical");
  }

  if(!var_03) {
    return;
  }

  var_04 = maps\mp\bots\_bots_util::func_1B21();
  if(var_04 == "bad_path") {
    self.var_2CA5++;
    if(self.var_2CA5 >= 4) {
      for(;;) {
        var_05 = getnodesinradiussorted(var_02, 50, 0);
        var_06 = self.var_2CA5 - 4;
        if(var_05.size <= var_06) {
          var_07 = botgetclosestnavigablepoint(var_02, 50, self);
          if(isDefined(var_07)) {
            self botsetscriptgoal(var_07, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var_06[var_07].var_0116, 20, "critical");
        }

        var_05 = maps\mp\bots\_bots_util::func_1B21();
        if(var_05 == "bad_path") {
          self.var_2CA5++;
          continue;
        }

        break;
      }
    }
  }

  if(var_06 == "goal") {
    var_08 = func_4308() - gettime();
    var_09 = var_08 - level.var_2CA9 * 2 * 1000;
    var_0A = gettime() + var_09;
    if(var_09 > 0) {
      maps\mp\bots\_bots_util::func_1B22(var_09);
    }

    var_0B = gettime() >= var_0A;
    var_0C = level.var_8330.var_0116[2] - self.var_0116[2];
    var_0D = maps\mp\bots\_bots_gametype_common::func_1911(level.var_2CA9 + 2, "bomb_defused", var_0B, var_0C > 40);
    if(!var_0D && self.var_2CA5 >= 4) {
      self.var_2CA5++;
    }

    self method_8358();
    maps\mp\bots\_bots_strategy::func_19BC();
  }
}

func_551A() {
  self endon("new_role");
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  var_00 = maps\mp\bots\_bots_gametype_common::func_3B69(self);
  self botsetscriptgoalnode(common_scripts\utility::func_7A33(var_00.var_1B49), "critical");
  var_01 = maps\mp\bots\_bots_util::func_1B21();
  if(var_01 == "goal") {
    wait(2);
    func_1AD7(self.var_76C6);
  }
}

func_1ECB() {
  self endon("new_role");
  if(isDefined(level.var_832F.var_2006)) {
    if(self.var_76C6 == "defender") {
      self.var_2C75 = maps\mp\bots\_bots_gametype_common::func_3B69(self);
    }

    func_1AD7(self.var_76C6);
    return;
  }

  if(!maps\mp\bots\_bots_util::func_1A2E(level.var_832F.var_28D4)) {
    var_00["nearest_node_to_center"] = level.var_832F.var_6639;
    maps\mp\bots\_bots_strategy::func_1AA6(level.var_832F.var_28D4, level.var_7790, var_00);
  }
}

func_2C7C() {
  self endon("new_role");
  if(!maps\mp\bots\_bots_util::func_1A2E(self.var_2C75.var_28D4)) {
    var_00["score_flags"] = "strict_los";
    var_00["override_origin_node"] = common_scripts\utility::func_7A33(self.var_2C75.var_1B49);
    maps\mp\bots\_bots_strategy::func_1AA6(self.var_2C75.var_28D4, level.var_7790, var_00);
  }
}

func_14ED() {
  self endon("new_role");
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  if(!isDefined(self.var_14EC)) {
    self.var_14EC = "1_move_to_midpoint";
  }

  if(self.var_14EC == "1_move_to_midpoint") {
    var_00 = level.var_1913[0].var_28D4;
    var_01 = level.var_1913[1].var_28D4;
    var_02 = (var_00[0] + var_01[0] * 0.5, var_00[1] + var_01[1] * 0.5, var_00[2] + var_01[2] * 0.5);
    var_03 = getnodesinradiussorted(var_02, 512, 0);
    if(var_03.size == 0) {
      func_1AD7("random_killer");
      return;
    }

    var_04 = undefined;
    var_05 = int(var_03.size * var_03.size + 1 * 0.5);
    var_06 = randomint(var_05);
    for(var_07 = 0; var_07 < var_03.size; var_07++) {
      var_08 = var_03.size - var_07;
      if(var_06 < var_08) {
        var_04 = var_03[var_07];
        break;
      }

      var_06 = var_06 - var_08;
    }

    self botsetpathingstyle("scripted");
    var_09 = self botsetscriptgoalnode(var_04, "guard");
    if(var_09) {
      var_0A = maps\mp\bots\_bots_util::func_1B21();
      if(var_0A == "goal") {
        wait(randomfloatrange(1, 4));
        self.var_14EC = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.var_14EC == "2_move_to_enemy_spawn") {
    var_0B = lib_050D::func_46A0("allies");
    var_0C = common_scripts\utility::func_7A33(var_0B);
    self botsetpathingstyle("scripted");
    var_09 = self botsetscriptgoal(var_0C.var_0116, 250, "guard");
    if(var_09) {
      var_0A = maps\mp\bots\_bots_util::func_1B21();
      if(var_0A == "goal") {
        self.var_14EC = "3_move_to_bombzone";
      }
    }
  }

  if(self.var_14EC == "3_move_to_bombzone") {
    if(!isDefined(self.var_1910)) {
      self.var_1910 = randomint(level.var_1913.size);
    }

    self botsetpathingstyle(undefined);
    var_09 = self botsetscriptgoal(common_scripts\utility::func_7A33(level.var_1913[self.var_1910].var_1B49).var_0116, 160, "objective");
    if(var_09) {
      var_0A = maps\mp\bots\_bots_util::func_1B21();
      if(var_0A == "goal") {
        self method_8358();
        self.var_14EC = "2_move_to_enemy_spawn";
        self.var_1910 = 1 - self.var_1910;
        return;
      }
    }
  }
}

func_7A3B() {
  self endon("new_role");
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  self[[self.var_6F7F]]();
}

func_84A4() {
  if(!isDefined(self.var_0CB2)) {
    self botsetflag("force_sprint", 1);
    self.var_0CB2 = 1;
  }
}

func_2F3A() {
  if(isDefined(self.var_0CB2)) {
    self botsetflag("force_sprint", 0);
    self.var_0CB2 = undefined;
  }
}

func_8578() {
  if(!isDefined(self.var_8311)) {
    self botsetpathingstyle("scripted");
    self.var_8311 = 1;
  }
}

func_2056(param_00, param_01) {
  var_02 = level.var_1FB1;
  var_03["entrance_points_index"] = param_01;
  maps\mp\bots\_bots_strategy::func_196A(param_00, var_02, var_03);
  wait 0.05;
  while(distancesquared(self.var_0116, param_00) > var_02 * var_02 && maps\mp\bots\_bots_util::func_1A2D()) {
    if(func_4308() - gettime() < 20000) {
      func_8578();
      func_84A4();
      break;
    }

    wait 0.05;
  }

  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  return self botsetscriptgoal(param_00, 20, "critical");
}

func_67F5(param_00) {
  var_01 = maps\mp\bots\_bots_gametype_common::func_4065(param_00);
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_7ECA)) {
      var_03 func_1AD7("investigate_someone_using_bomb");
    }
  }
}

func_8B7D(param_00) {
  var_01 = 2000;
  var_02 = var_01 * var_01;
  if(param_00) {
    if(func_4308() - gettime() < 15000) {
      return 0;
    }

    var_03 = 0;
    var_04 = common_scripts\utility::func_416F(self.var_01A7);
    foreach(var_06 in level.var_744A) {
      if(!isDefined(var_06.var_01A7)) {
        continue;
      }

      if(isalive(var_06) && var_06.var_01A7 == var_04) {
        var_03 = 1;
      }
    }

    return var_03;
  }

  return distancesquared(self.var_0116, self.var_19A7) <= var_02 && self method_8377();
}

func_42B6(param_00) {
  var_01 = [];
  var_02 = maps\mp\bots\_bots_gametype_common::func_41FB(game["defenders"]);
  foreach(var_04 in var_02) {
    if(isai(var_04) && isDefined(var_04.var_7ECA) && var_04.var_7ECA == "defender") {
      if(isDefined(var_04.var_2C75) && var_04.var_2C75 == param_00) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
      }

      continue;
    }

    if(distancesquared(var_04.var_0116, param_00.var_28D4) < level.var_7790 * level.var_7790) {
      var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
    }
  }

  return var_01;
}

func_3B82() {
  if(isDefined(level.var_99C0)) {
    foreach(var_01 in level.var_1913) {
      if(distancesquared(level.var_99C0.var_0116, var_01.var_28D4) < 90000) {
        return var_01;
      }
    }
  }

  return undefined;
}

func_4343(param_00) {
  param_00 = "_" + tolower(param_00);
  for(var_01 = 0; var_01 < level.var_1913.size; var_01++) {
    if(level.var_1913[var_01].var_00E5 == param_00) {
      return level.var_1913[var_01];
    }
  }
}

func_18E7() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  common_scripts\utility::func_A70A("death", "disconnect");
  level.var_10F6 = undefined;
  level.var_5B15 = gettime();
  if(isDefined(self)) {
    self.var_7ECA = undefined;
  }

  var_00 = maps\mp\bots\_bots_gametype_common::func_41FB(game["attackers"], 1);
  func_3DE4(var_00, undefined);
}

func_18E6() {
  self endon("death");
  self endon("disconnect");
  self endon("stopped_being_bomb_carrier");
  level.var_832F endon("pickup_object");
  level.var_832F waittill("reset");
  if(maps\mp\_utility::func_566A(self)) {
    self method_8358();
  }

  func_1AD7("atk_bomber");
}

func_8532() {
  level.var_10F6 = self;
  func_1AD7("atk_bomber");
  thread func_18E7();
  if(!level.var_6510) {
    thread func_18E6();
  }

  if(isai(self)) {
    maps\mp\bots\_bots_strategy::func_19B0();
    if(level.var_115F == "rush" && self botgetdifficultysetting("strategyLevel") > 0) {
      func_84A4();
    }
  }
}

func_52E9() {
  if(self.var_01A7 == game["attackers"]) {
    if(level.var_18F9) {
      func_1AD7("defend_planted_bomb");
      return;
    }

    if(!isDefined(level.var_10F6)) {
      func_8532();
      return;
    }

    if(level.var_115F == "rush") {
      func_1AD7("clear_target_zone");
      return;
    }

    return;
  }

  var_00 = func_42B3("backstabber");
  var_01 = func_42B3("defender");
  var_02 = level.var_1A92[self.var_6F7D];
  var_03 = self botgetdifficultysetting("strategyLevel");
  if(var_02 == "active") {
    if(!isDefined(self.var_7ECA) && level.var_0C10 && var_03 > 0) {
      if(var_00.size == 0) {
        func_1AD7("backstabber");
      } else {
        var_04 = 1;
        foreach(var_06 in var_00) {
          var_07 = level.var_1A92[var_06.var_6F7D];
          if(var_07 == "active") {
            var_04 = 0;
            break;
          }
        }

        if(var_04) {
          func_1AD7("backstabber");
          var_00[0] func_1AD7(undefined);
        }
      }
    }

    if(!isDefined(self.var_7ECA)) {
      if(var_01.size < 4) {
        func_1AD7("defender");
      }
    }

    if(!isDefined(self.var_7ECA)) {
      var_09 = randomint(4);
      if(var_09 == 3 && level.var_0C18 && var_03 > 0) {
        func_1AD7("random_killer");
      } else if(var_09 == 2 && level.var_0C10 && var_03 > 0) {
        func_1AD7("backstabber");
      } else {
        func_1AD7("defender");
      }
    }
  } else if(var_03 == "stationary") {
    if(!isDefined(self.var_7ECA)) {
      if(var_02.size < 4) {
        func_1AD7("defender");
      } else {
        foreach(var_0B in var_02) {
          var_0C = level.var_1A92[var_0B.var_6F7D];
          if(var_0C == "active") {
            func_1AD7("defender");
            var_0B func_1AD7(undefined);
            break;
          }
        }
      }
    }

    if(!isDefined(self.var_7ECA) && level.var_0C10 && var_09 > 0) {
      if(var_01.size == 0) {
        func_1AD7("backstabber");
      }
    }

    if(!isDefined(self.var_7ECA)) {
      func_1AD7("defender");
    }
  }

  if(self.var_7ECA == "defender") {
    var_0E = level.var_1913;
    if(func_4B38(self.var_01A7)) {
      var_0E = func_427A(self.var_01A7);
    }

    if(var_0E.size == 1) {
      self.var_2C75 = var_0E[0];
      return;
    }

    var_0F = func_42B6(var_0E[0]);
    var_10 = func_42B6(var_0E[1]);
    if(var_0F.size < var_10.size) {
      self.var_2C75 = var_0E[0];
      return;
    }

    if(var_10.size < var_0F.size) {
      self.var_2C75 = var_0E[1];
      return;
    }

    self.var_2C75 = common_scripts\utility::func_7A33(var_0E);
    return;
  }
}

func_1AD7(param_00) {
  if(isai(self)) {
    maps\mp\bots\_bots_strategy::func_19A3();
    self botsetpathingstyle(undefined);
  }

  self.var_76C6 = self.var_7ECA;
  self.var_7ECA = param_00;
  self notify("new_role");
}

func_1AD8(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("new_role");
  wait(param_01);
  func_1AD7(param_00);
}

func_3DE4(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    if(isDefined(param_02)) {
      var_04 thread func_1AD8(param_01, randomfloatrange(0, param_02));
      continue;
    }

    var_04 thread func_1AD7(param_01);
  }
}

func_427A(param_00) {
  return level.var_1ABE[param_00];
}

func_4B38(param_00) {
  var_01 = func_427A(param_00);
  return var_01.size > 0;
}

func_42B3(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_6E97) {
    if(isalive(var_03) && maps\mp\_utility::func_5800(var_03) && isDefined(var_03.var_7ECA) && var_03.var_7ECA == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_1ABD() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");
  level.var_0C10 = randomint(3) <= 1;
  level.var_0C18 = randomint(3) <= 1;
  level.var_115F = "rush";
  level.var_7790 = 725;
  level.var_1FB1 = 140;
  for(;;) {
    if(isDefined(level.var_832F) && isDefined(level.var_832F.var_2006) && !isai(level.var_832F.var_2006)) {
      level.var_18D1 = maps\mp\bots\_bots_gametype_common::func_3B69(level.var_832F.var_2006);
    }

    var_00 = 0;
    if(!level.var_18F9) {
      var_01 = maps\mp\bots\_bots_gametype_common::func_41FB(game["attackers"]);
      foreach(var_03 in var_01) {
        if(var_03.var_568D) {
          level.var_1F1B = gettime();
          if(!isDefined(level.var_10F6) || var_03 != level.var_10F6) {
            if(isDefined(level.var_10F6) && isalive(level.var_10F6)) {
              level.var_10F6 func_1AD7(undefined);
              level.var_10F6 notify("stopped_being_bomb_carrier");
            }

            var_00 = 1;
            var_03 func_8532();
          }
        }
      }

      if(!level.var_6510 && !isDefined(level.var_832F.var_2006)) {
        var_05 = function_00BA(level.var_832F.var_28D4);
        if(isDefined(var_05)) {
          level.var_832F.var_6639 = var_05;
          var_06 = 0;
          var_07 = maps\mp\bots\_bots_gametype_common::func_41FB(game["defenders"], 1);
          foreach(var_09 in var_07) {
            var_0A = var_09 getnearestnode();
            var_0B = var_09 botgetdifficultysetting("strategyLevel");
            if(var_0B > 0 && var_09.var_7ECA != "camp_bomb" && isDefined(var_0A) && function_01F4(var_05, var_0A, 1)) {
              var_0C = var_09 method_8375();
              if(common_scripts\utility::func_AA4A(var_09.var_0116, var_09 getangles(), level.var_832F.var_28D4, var_0C)) {
                if(var_0B >= 2 || distancesquared(var_09.var_0116, level.var_832F.var_28D4) < squared(700)) {
                  var_06 = 1;
                  break;
                }
              }
            }
          }

          if(var_06) {
            foreach(var_09 in var_07) {
              if(var_09.var_7ECA != "camp_bomb" && var_09 botgetdifficultysetting("strategyLevel") > 0) {
                var_09 func_1AD7("camp_bomb");
              }
            }
          }
        }
      }

      var_10 = level.var_1913;
      if(func_4B38(game["defenders"])) {
        var_10 = func_427A(game["defenders"]);
      }

      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        for(var_12 = 0; var_12 < var_10.size; var_12++) {
          var_13 = func_42B6(var_10[var_11]);
          var_14 = func_42B6(var_10[var_12]);
          if(var_13.size > var_14.size + 1) {
            var_15 = [];
            foreach(var_03 in var_13) {
              if(isai(var_03)) {
                var_15 = common_scripts\utility::func_0F6F(var_15, var_03);
              }
            }

            if(var_15.size > 0) {
              var_18 = common_scripts\utility::func_7A33(var_15);
              var_18 maps\mp\bots\_bots_strategy::func_19A3();
              var_18.var_2C75 = var_10[var_12];
            }
          }
        }
      }
    } else {
      if(isDefined(level.var_10F6)) {
        level.var_10F6 = undefined;
      }

      if(!isDefined(level.var_18B5) || !isalive(level.var_18B5)) {
        var_19 = [];
        var_1A = func_42B3("defender");
        var_1B = func_42B3("backstabber");
        var_1C = func_42B3("random_killer");
        if(var_1A.size > 0) {
          var_19 = var_1A;
        } else if(var_1B.size > 0) {
          var_19 = var_1B;
        } else if(var_1C.size > 0) {
          var_19 = var_1C;
        }

        if(var_19.size > 0 && isDefined(level.var_8330)) {
          var_1D = common_scripts\utility::func_40B0(level.var_8330.var_0116, var_19);
          level.var_18B5 = var_1D[0];
          level.var_18B5 func_1AD7("defuser");
          level.var_18B5 maps\mp\bots\_bots_strategy::func_19B0();
          level.var_18B5 thread func_2CA6();
        }
      }

      if(!isDefined(level.var_8327)) {
        level.var_8327 = 1;
        var_1E = maps\mp\bots\_bots_gametype_common::func_41FB(game["attackers"]);
        foreach(var_03 in var_1E) {
          if(isDefined(var_03.var_7ECA)) {
            if(var_03.var_7ECA == "atk_bomber") {
              var_03 thread func_1AD7(undefined);
              continue;
            }

            if(var_03.var_7ECA != "defend_planted_bomb") {
              var_03 thread func_1AD8("defend_planted_bomb", randomfloatrange(0, 3));
            }
          }
        }
      }
    }

    wait(0.5);
  }
}

func_2CA6() {
  common_scripts\utility::func_A70A("death", "disconnect");
  level.var_18B5 = undefined;
}