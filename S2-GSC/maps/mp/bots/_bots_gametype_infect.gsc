/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_infect.gsc
**************************************************/

func_00F9() {
  func_87A7();
  func_8797();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1A21;
  level.var_19D5["should_pickup_weapons"] = ::func_1AE4;
}

func_8797() {
  level.var_1B3D = 1;
  level.var_1B3F = 1;
  level.var_1B3E = 1;
  level.var_5119 = "throwingknife_mp";
  thread func_1A1D();
}

func_1AE4() {
  if(level.var_5111 && self.var_01A7 == "axis") {
    return 0;
  }

  return maps\mp\bots\_bots::func_1AE3();
}

func_1A21() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  childthread func_1A20();
  for(;;) {
    if(level.var_5111) {
      if(self.var_01A7 == "axis" && self method_8368() != "run_and_gun") {
        maps\mp\bots\_bots_util::func_1AD5("run_and_gun");
      }
    }

    if(self.var_1AFA != self.var_01A7) {
      self.var_1AFA = self.var_01A7;
    }

    if(self.var_01A7 == "axis") {
      var_00 = maps\mp\bots\_bots_strategy::func_1A7A();
      if(!isDefined(var_00) || var_00) {
        self method_8358();
      }
    }

    self[[self.var_6F7F]]();
    wait 0.05;
  }
}

func_1A1D() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");
  for(;;) {
    var_00 = [];
    var_01 = [];
    foreach(var_03 in level.var_744A) {
      if(!isDefined(var_03.var_52D5) && var_03.var_00BC > 0 && isDefined(var_03.var_01A7) && var_03.var_01A7 == "allies" || var_03.var_01A7 == "axis") {
        var_03.var_52D5 = gettime();
      }

      if(isDefined(var_03.var_52D5) && gettime() - var_03.var_52D5 > 5000) {
        if(!isDefined(var_03.var_01A7)) {
          continue;
        }

        if(var_03.var_01A7 == "axis") {
          var_00[var_00.size] = var_03;
          continue;
        }

        if(var_03.var_01A7 == "allies") {
          var_01[var_01.size] = var_03;
        }
      }
    }

    if(var_00.size > 0 && var_01.size > 0) {
      var_05 = 1;
      foreach(var_07 in var_01) {
        if(isbot(var_07)) {
          var_05 = 0;
        }
      }

      if(var_05) {
        foreach(var_03 in var_01) {
          if(!isDefined(var_03.var_5B2B)) {
            var_03.var_5B2B = gettime();
            var_03.var_5B2A = var_03.var_0116;
            var_03.var_99E4 = 0;
          }

          if(gettime() >= var_03.var_5B2B + 5000) {
            var_03.var_5B2B = gettime();
            var_0A = distancesquared(var_03.var_0116, var_03.var_5B2A);
            var_03.var_5B2A = var_03.var_0116;
            if(var_0A < 90000) {
              var_03.var_99E4 = var_03.var_99E4 + 5000;
              if(var_03.var_99E4 >= 20000) {
                var_0B = common_scripts\utility::func_40B0(var_03.var_0116, var_00);
                foreach(var_0D in var_0B) {
                  if(isbot(var_0D)) {
                    var_0E = var_0D method_835F();
                    if(var_0E != "tactical" && var_0E != "critical") {
                      var_0D thread func_4FA2(var_03);
                      break;
                    }
                  }
                }
              }
            } else {
              var_03.var_99E4 = 0;
              var_03.var_5B2A = var_03.var_0116;
            }
          }
        }
      }
    }

    wait(1);
  }
}

func_4FA2(param_00) {
  self endon("disconnect");
  self endon("death");
  self botsetscriptgoal(param_00.var_0116, 0, "critical");
  maps\mp\bots\_bots_util::func_1B21();
  self method_8358();
}

func_1A20() {
  if(self.var_01A7 == "axis") {
    self.var_1F1A = 0;
    self.var_60D5 = undefined;
    self.var_60D7 = undefined;
    self.var_60D6 = 0;
    self.var_60DC = undefined;
    self.var_60DB = 0;
    var_00 = self botgetdifficultysetting("throwKnifeChance");
    if(var_00 < 0.25) {
      self botsetdifficultysetting("throwKnifeChance", 0.25);
    }

    self botsetdifficultysetting("allowGrenades", 1);
    for(;;) {
      if(self hasweapon(level.var_5119)) {
        if(maps\mp\_utility::func_56FF(self.var_0088)) {
          var_01 = gettime();
          if(!isDefined(self.var_60D5) || self.var_60D5 != self.var_0088) {
            self.var_60D5 = self.var_0088;
            self.var_60D7 = self.var_0088 getnearestnode();
            self.var_60D6 = var_01;
          } else {
            var_02 = squared(self botgetdifficultysetting("meleeDist"));
            if(distancesquared(self.var_0088.var_0116, self.var_0116) <= var_02) {
              self.var_1F1A = var_01;
            }

            var_03 = self.var_0088 getnearestnode();
            var_04 = self getnearestnode();
            if(!isDefined(self.var_60D7) || self.var_60D7 != var_03) {
              self.var_60D6 = var_01;
              self.var_60D7 = var_03;
            }

            if(!isDefined(self.var_60DC) || self.var_60DC != var_04) {
              self.var_60DB = var_01;
              self.var_60DC = var_04;
            } else if(distancesquared(self.var_0116, self.var_60DC.var_0116) > 9216) {
              self.var_60DA = var_01;
            }

            if(self.var_1F1A + 3000 < var_01) {
              if(self.var_60DB + 3000 < var_01) {
                if(self.var_60D6 + 3000 < var_01) {
                  if(func_1A1E(self.var_0116, self.var_0088.var_0116)) {
                    maps\mp\bots\_bots_util::func_1AA8("find_node_can_see_ent", ::func_1A1F, self.var_0088, self.var_60DC);
                  }

                  if(!self method_817F(level.var_5119)) {
                    self method_82FA(level.var_5119, 1);
                  }

                  maps\mp\_utility::func_A6D1(30, "enemy");
                  self method_8358();
                }
              }
            }
          }
        }
      }

      wait(0.25);
    }
  }
}

func_1A1E(param_00, param_01) {
  if(abs(param_00[2] - param_01[2]) > 56 && distance2dsquared(param_00, param_01) < 2304) {
    return 1;
  }

  return 0;
}

func_1A1F(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  var_02 = 0;
  if(issubstr(param_01.var_01B9, "Begin")) {
    var_02 = 1;
  }

  var_03 = function_0204(param_01);
  if(isDefined(var_03) && var_03.size) {
    var_04 = common_scripts\utility::func_0F92(var_03);
    foreach(var_06 in var_04) {
      if(var_02 && issubstr(var_06.var_01B9, "End")) {
        continue;
      }

      if(func_1A1E(var_06.var_0116, param_00.var_0116)) {
        continue;
      }

      var_07 = self getEye() - self.var_0116;
      var_08 = var_06.var_0116 + var_07;
      var_09 = param_00.var_0116;
      if(isPlayer(param_00)) {
        var_09 = param_00 maps\mp\_utility::func_469E();
      }

      if(sighttracepassed(var_08, var_09, 0, self, param_00)) {
        var_0A = vectortoyaw(var_09 - var_08);
        self botsetscriptgoalnode(var_06, "critical", var_0A);
        maps\mp\bots\_bots_util::func_1B21(3);
        return;
      }

      wait 0.05;
    }
  }
}