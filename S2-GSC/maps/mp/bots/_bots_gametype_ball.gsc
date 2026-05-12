/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_ball.gsc
************************************************/

func_00F9() {
  func_87A7();
  func_878F();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1948;
  level.var_19D5["crate_can_use"] = ::func_2734;
}

func_878F() {
  level.var_19DB = ::func_1940;
  level.var_19DE = ::func_1941;
  level.var_19D6 = ::func_4091;
  level.var_19D7 = ::func_4092;
  maps\mp\bots\_bots_util::func_1B20();
  while(!isDefined(level.var_152B)) {
    wait 0.05;
  }

  level.var_152B["allies"].var_81E8 = "allies";
  level.var_152B["axis"].var_81E8 = "axis";
  bot_setup_ball_goal_node();
  var_00 = getzonenearest(level.var_152B["allies"].var_0116);
  if(isDefined(var_00)) {
    botzonesetteam(var_00, "allies");
  }

  var_00 = getzonenearest(level.var_152B["axis"].var_0116);
  if(isDefined(var_00)) {
    botzonesetteam(var_00, "axis");
  }

  foreach(var_02 in level.var_1562) {
    var_02 thread func_62E7();
  }

  var_04 = 0;
  thread maps\mp\bots\_bots_gametype_common::func_19DA();
  level.var_19E8 = 1;
}

func_62E7() {
  var_00 = self.var_A582[0].var_0116;
  self.var_6638 = function_00BA(var_00);
  for(;;) {
    var_01 = self.var_A582[0].var_0116;
    self.var_150B = maps\mp\bots\_bots_util::func_1B1C(var_00, var_01);
    if(!self.var_150B) {
      var_02 = function_00BA(var_01);
      if(!isDefined(var_02)) {
        var_03 = getnodesinradiussorted(var_01, 512, 0, 6000);
        if(var_03.size > 0) {
          var_02 = var_03[0];
        }
      }

      if(isDefined(var_02)) {
        self.var_6638 = var_02;
      }
    }

    var_00 = var_01;
    wait(0.2);
  }
}

bot_setup_ball_goal_node() {
  wait(1);
  foreach(var_01 in level.var_152B) {
    var_01.var_6638 = function_00BA(var_01.var_0116);
    if(!isDefined(var_01.var_6638)) {
      var_02 = getnodesinradiussorted(var_01.var_0116, 375, 0);
      if(var_02.size > 0) {
        var_01.var_6638 = var_02[0];
      }
    }

    wait 0.05;
  }
}

func_1947(param_00, param_01, param_02) {
  var_03 = func_1949(param_00, param_01.var_0116);
  if(isDefined(param_02) && param_02) {
    if(!var_03) {
      var_04 = param_01.var_0116 - (0, 0, param_01.var_014F * 0.5);
      var_03 = func_1949(param_00, var_04);
    }

    if(!var_03) {
      var_04 = param_01.var_0116 + (0, 0, param_01.var_014F * 0.5);
      var_03 = func_1949(param_00, var_04);
    }
  }

  return var_03;
}

func_1949(param_00, param_01) {
  if(isDefined(self) && isPlayer(self) || function_01EF(self)) {
    var_02 = playerphysicstrace(param_00, param_01, self);
  } else {
    var_02 = playerphysicstrace(param_01, var_02);
  }

  return distancesquared(var_02, param_01) < 1;
}

func_2734(param_00) {
  if(function_01EF(self) && !isDefined(param_00.var_1B7B)) {
    return 0;
  }

  if(func_4B23()) {
    return 0;
  }

  return 1;
}

func_1948() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  var_00 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_01 = 0;
  self.var_5B38 = 0;
  self.var_150C = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self.var_150D = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self.var_150F = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_02 = level.var_152B[self.var_01A7];
  var_03 = level.var_152B[common_scripts\utility::func_416F(self.var_01A7)];
  childthread func_A87E();
  for(;;) {
    var_04 = !isDefined(self.var_7ECA);
    if(var_04) {
      maps\mp\bots\_bots_gametype_common::func_19E7();
    }

    self botsetflag("force_sprint", 0);
    var_05 = func_1942(self.var_01A7);
    var_06 = func_1942(common_scripts\utility::func_416F(self.var_01A7));
    foreach(var_08 in var_06) {
      var_09 = var_08 func_1945() - (0, 0, 75);
      self method_8379(var_08.var_2006, var_09);
    }

    if(func_4B23()) {
      self botsetflag("force_sprint", 1);
      func_23B3();
      self botsetscriptgoal(var_03.var_0116, 0, "critical");
      maps\mp\bots\_bots_util::func_1B21(undefined, "bot_no_longer_has_ball");
      self method_8358();
    } else if(self.var_7ECA == "attacker") {
      var_0B = func_1944();
      if(var_0B.size <= 0) {
        if(var_06.size > 0) {
          var_0C = func_1943(var_06);
          var_0D = var_0C func_1945() - (0, 0, 75);
          if(var_00) {
            if(gettime() > var_01) {
              var_01 = gettime() + 5000;
              var_0E = undefined;
              var_0F = getnodesonpath(var_0D, var_02.var_6638.var_0116);
              if(isDefined(var_0F) && var_0F.size > 0) {
                var_0E = var_0F[int(var_0F.size * randomfloatrange(0.25, 0.75))].var_0116;
              }

              func_23B3();
              if(isDefined(var_0E) && maps\mp\bots\_bots_personality::func_3B64(var_0E, 512)) {
                self botsetscriptgoalnode(self.var_6708, "guard", self.var_0D94);
              } else {
                self botsetscriptgoal(var_0D, 16, "guard");
              }
            }
          } else {
            func_23B3();
            self botsetscriptgoal(var_0F, 16, "guard");
          }
        } else if(var_07.size > 0) {
          if(!maps\mp\bots\_bots_util::func_1A27()) {
            var_10 = func_1943(var_07);
            func_23B3();
            maps\mp\bots\_bots_strategy::func_1A0C(var_10.var_2006, 500);
          }
        } else {
          var_11 = common_scripts\utility::func_40B0(self.var_0116, level.var_1554);
          func_23B3();
          self botsetscriptgoal(var_11[0].var_0116, 16, "guard");
        }
      } else {
        var_12 = func_1943(var_0D);
        func_23B3("objective");
        if(var_12.var_150B) {
          var_13 = var_12 func_1945();
          if(!self method_8367() || !maps\mp\bots\_bots_util::func_1B1C(var_13, self method_835C())) {
            self botsetscriptgoal(var_13, 16, "objective", undefined, 180);
          }
        } else {
          self botsetscriptgoal(var_12.var_6638.var_0116, 16, "objective", undefined, 180);
        }
      }
    } else {
      var_14 = undefined;
      var_12 = func_1944();
      foreach(var_0B in var_12) {
        var_16 = distance2dsquared(var_0B func_1945(), var_05.var_0116);
        if(var_16 < squared(func_40BB())) {
          var_14 = var_0B;
          break;
        }
      }

      if(isDefined(var_14)) {
        func_23B3();
        if(var_14.var_150B) {
          self botsetscriptgoal(var_14 func_1945(), 16, "guard");
        } else {
          self botsetscriptgoal(var_14.var_6638.var_0116, 16, "guard");
        }

        maps\mp\bots\_bots_util::func_1B21(1);
      } else if(!maps\mp\bots\_bots_util::func_1A33()) {
        self method_8358();
        var_18["score_flags"] = "strict_los";
        var_18["override_origin_node"] = var_05.var_6638;
        maps\mp\bots\_bots_strategy::func_1AA6(var_05.var_6638.var_0116, func_40BB(), var_18);
      }
    }

    wait 0.05;
  }
}

func_A87E() {
  var_00 = 0;
  for(;;) {
    if(func_4B23() && !var_00) {
      childthread func_632C();
      var_00 = 1;
      self botsetflag("melee_critical_path", 1);
    } else if(!func_4B23() && var_00) {
      self notify("bot_no_longer_has_ball");
      var_00 = 0;
      self botsetflag("melee_critical_path", 0);
    }

    wait 0.05;
  }
}

func_632C() {
  self endon("bot_no_longer_has_ball");
  var_00 = level.var_152B[self.var_01A7];
  var_01 = level.var_152B[common_scripts\utility::func_416F(self.var_01A7)];
  for(;;) {
    if(self.var_150C) {
      if(isDefined(self.var_6EA9)) {
        var_02 = 1;
        if(var_02) {
          var_03 = distancesquared(self.var_0116, var_01.var_0116);
          var_04 = distancesquared(self.var_6EA9.var_0116, var_01.var_0116);
          if(var_04 <= var_03) {
            var_05 = anglesToForward(self getangles());
            var_06 = vectornormalize(self.var_6EA9.var_0116 - self.var_0116);
            var_07 = vectordot(var_05, var_06);
            if(var_07 > 0.7) {
              self botlookatpoint(self.var_6EA9.var_0116 + (0, 0, 40), 1.25, "script_forced");
              wait(0.25);
              self botpressbutton("throw");
              wait(1);
            }
          }
        }
      }
    }

    if(self.var_150D) {
      if(isDefined(self.var_0088) && isalive(self.var_0088) && self method_8371(self.var_0088)) {
        var_08 = 1;
        if(var_08) {
          var_09 = distancesquared(self.var_0116, var_00.var_0116);
          var_0A = var_09 < squared(func_40BB());
          if(!var_0A && distancesquared(self.var_0116, self.var_0088.var_0116) < squared(350)) {
            var_0B = anglesToForward(self.var_0088 getangles());
            var_0C = vectornormalize(self.var_0116 - self.var_0088.var_0116);
            var_07 = vectordot(var_0B, var_0C);
            if(var_07 > 0.5) {
              var_05 = anglesToForward(self getangles());
              var_0D = -1 * var_0C;
              var_07 = vectordot(var_05, var_0D);
              if(var_07 > 0.77) {
                self botlookatpoint(self.var_0088.var_0116 + (0, 0, 40), 1.25, "script_forced");
                wait(0.25);
                self botpressbutton("attack");
                wait(1);
              }
            }
          }
        }
      }
    }

    if(self.var_150F) {
      if(self.var_00BC < 100 && func_1947(self.var_0116, var_01)) {
        self botlookatpoint(var_01.var_0116, 1.25, "script_forced");
        wait(0.25);
        self botpressbutton("attack");
        wait(1);
      } else if(self.var_7ECA == "defender") {
        var_09 = distancesquared(self.var_0116, var_00.var_0116);
        if(var_09 < squared(func_40BB())) {
          var_0E = anglesToForward(self getangles() * (0, 1, 1) + (-30, 0, 0));
          self botlookatpoint(self getEye() + var_0E * 200, 1.25, "script_forced");
          wait(0.25);
          self botpressbutton("attack");
          wait(1);
        }
      }
    }

    wait 0.05;
  }
}

func_1512(param_00) {
  var_01 = self getnearestnode();
  var_02 = param_00 getnearestnode();
  if(isDefined(var_01) && isDefined(var_02)) {
    if(function_01F4(var_01, var_02, 1)) {
      return var_02;
    }

    var_03 = function_0204(var_02);
    foreach(var_05 in var_03) {
      if(function_01F4(var_01, var_05, 1)) {
        return var_05;
      }
    }
  }

  return undefined;
}

func_1946() {
  return self.var_2562["friendly"] == "waypoint_ball_download" || self.var_2562["friendly"] == "waypoint_ball_upload";
}

func_1943(param_00) {
  if(param_00.size == 1) {
    return param_00[0];
  }

  var_01 = 99999999;
  var_02 = undefined;
  foreach(var_04 in param_00) {
    var_05 = distancesquared(self.var_0116, var_04 func_1945());
    if(var_05 < var_01) {
      var_01 = var_05;
      var_02 = var_04;
    }
  }

  return var_02;
}

func_1945() {
  if(isDefined(self.var_2006)) {
    return self.var_28D4;
  }

  return self.var_A582[0].var_0116;
}

func_23B3(param_00) {
  if(maps\mp\bots\_bots_util::func_1A2D()) {
    maps\mp\bots\_bots_strategy::func_19A3();
  }

  if(self method_835F() == "objective") {
    var_01 = isDefined(param_00) && param_00 == "objective";
    if(!var_01) {
      self method_8358();
    }
  }
}

func_4B23() {
  return isDefined(self.var_1510);
}

func_1944() {
  var_00 = [];
  foreach(var_02 in level.var_1562) {
    if(var_02 func_1946()) {
      continue;
    }

    if(!isDefined(var_02.var_2006)) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_1942(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_1562) {
    if(var_03 func_1946()) {
      continue;
    }

    if(isDefined(var_03.var_2006) && var_03.var_2006.var_01A7 == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_1940(param_00) {
  var_01 = maps\mp\bots\_bots_gametype_common::func_19E1(param_00);
  var_02 = var_01 * 0.67;
  var_03 = floor(var_02);
  var_04 = ceil(var_02);
  var_05 = var_02 - var_03;
  var_06 = var_04 - var_02;
  if(var_05 < var_06) {
    var_07 = int(var_03);
  } else {
    var_07 = int(var_05);
  }

  return var_07;
}

func_1941(param_00) {
  var_01 = maps\mp\bots\_bots_gametype_common::func_19E1(param_00);
  return var_01 - func_1940(param_00);
}

func_40BB() {
  if(isalive(self) && !isDefined(level.var_7790)) {
    var_00 = self method_8361();
    var_01 = var_00[0] + var_00[1] / 2;
    level.var_7790 = min(800, var_01 / 5.5);
  }

  if(!isDefined(level.var_7790)) {
    return 900;
  }

  return level.var_7790;
}

func_4091(param_00) {
  return maps\mp\bots\_bots_gametype_common::func_19DF(param_00, level.var_152B[param_00].var_0116, func_40BB());
}

func_4092(param_00) {
  return maps\mp\bots\_bots_gametype_common::func_19E0(param_00, level.var_152B[param_00].var_0116, func_40BB());
}