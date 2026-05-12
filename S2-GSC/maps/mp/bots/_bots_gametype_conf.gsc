/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_conf.gsc
************************************************/

func_00F9() {
  func_87A7();
  func_8790();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_197D;
}

func_8790() {
  level.var_1AF6 = 200;
  level.var_1AF5 = 38;
}

func_197D() {
  self notify("bot_conf_think");
  self endon("bot_conf_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.var_66B7 = gettime() + 500;
  self.var_95BB = [];
  childthread func_1B29();
  if(self.var_6F7D == "camper") {
    self.var_257C = 0;
    if(!isDefined(self.var_257D)) {
      self.var_257D = 0;
    }
  }

  for(;;) {
    var_00 = isDefined(self.var_95A8);
    var_01 = 0;
    if(var_00 && self method_8367()) {
      var_02 = self method_835C();
      if(maps\mp\bots\_bots_util::func_1B1C(self.var_95A8.var_487B, var_02)) {
        if(self method_8377()) {
          var_01 = 1;
        }
      } else if(maps\mp\bots\_bots_strategy::func_1A14("kill_tag") && self.var_95A8 maps\mp\gametypes\_gameobjects::func_1F53(self.var_01A7)) {
        self.var_95A8 = undefined;
        var_00 = 0;
      }
    }

    self botsetflag("force_sprint", var_03);
    self.var_95BB = func_1AB5(self.var_95BB);
    var_04 = func_19C9(self.var_95BB, 1);
    var_06 = isDefined(var_04);
    if((var_01 && !var_06) || (!var_01 && var_06) || var_01 && var_06 && self.var_95A8 != var_04) {
      self.var_95A8 = var_04;
      self method_8358();
      self notify("stop_camping_tag");
      maps\mp\bots\_bots_personality::func_23AB();
      maps\mp\bots\_bots_strategy::func_192C("kill_tag");
    }

    if(isDefined(self.var_95A8)) {
      self.var_257D = 0;
      if(self.var_6F7D == "camper" && self.var_257C) {
        self.var_257D = 1;
        if(maps\mp\bots\_bots_personality::func_8B73()) {
          if(maps\mp\bots\_bots_personality::func_3B64(self.var_95A8.var_487B, 1000)) {
            childthread func_1954(self.var_95A8, "camp");
          } else {
            self.var_257D = 0;
          }
        }
      }

      if(!self.var_257D) {
        if(!maps\mp\bots\_bots_strategy::func_1A14("kill_tag")) {
          var_05 = spawnStruct();
          var_05.var_81C9 = "objective";
          var_05.var_691E = level.var_1AF6;
          maps\mp\bots\_bots_strategy::func_1A85("kill_tag", self.var_95A8.var_487B, 25, var_05);
        }
      }
    }

    var_02 = 0;
    if(isDefined(self.var_09B4)) {
      var_02 = self[[self.var_09B4]]();
    }

    if(!isDefined(self.var_95A8)) {
      if(!var_02) {
        self[[self.var_6F7F]]();
      }
    }

    if(gettime() > self.var_66B7) {
      self.var_66B7 = gettime() + 500;
      var_07 = func_19D1(1);
      self.var_95BB = func_197C(var_07, self.var_95BB);
    }

    wait 0.05;
  }
}

func_196E(param_00) {
  if(isDefined(param_00.var_6AA9) && param_00.var_6AA9) {
    var_01 = self.var_0116 + (0, 0, 55);
    if(distance2dsquared(param_00.var_28D4, var_01) < 144) {
      var_02 = param_00.var_28D4[2] - var_01[2];
      if(var_02 > 0) {
        if(var_02 < level.var_1AF5) {
          if(!isDefined(self.var_5B60)) {
            self.var_5B60 = 0;
          }

          if(gettime() - self.var_5B60 > 3000) {
            self.var_5B60 = gettime();
            thread func_1A3B();
          }
        } else {
          param_00.var_6AA9 = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

func_1A3B() {
  self endon("death");
  self endon("disconnect");
  self botsetstance("stand");
  wait(1);
  self botpressbutton("jump");
  wait(1);
  self botsetstance("none");
}

func_1B29() {
  for(;;) {
    level waittill("new_tag_spawned", var_00);
    self.var_66B7 = -1;
    if(isDefined(var_00)) {
      if((isDefined(var_00.var_A490) && var_00.var_A490 == self) || isDefined(var_00.var_1180) && var_00.var_1180 == self) {
        if(!isDefined(var_00.var_6AA9) && !isDefined(var_00.var_1E5A)) {
          thread func_1E48(var_00);
          func_A761(var_00);
          if(var_00.var_6AA9) {
            var_01 = spawnStruct();
            var_01.var_0116 = var_00.var_28D4;
            var_01.var_95A6 = var_00;
            var_02[0] = var_01;
            self.var_95BB = func_197C(var_02, self.var_95BB);
          }
        }
      }
    }
  }
}

func_197C(param_00, param_01) {
  var_02 = param_01;
  foreach(var_04 in param_00) {
    var_05 = 0;
    foreach(var_07 in param_01) {
      if(var_04.var_95A6 == var_07.var_95A6 && maps\mp\bots\_bots_util::func_1B1C(var_04.var_0116, var_07.var_0116)) {
        var_05 = 1;
        break;
      }
    }

    if(!var_05) {
      var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
    }
  }

  return var_02;
}

func_1A37(param_00, param_01, param_02) {
  if(!param_00.var_1E4D) {
    param_00.var_6638 = function_00BA(param_00.var_28D4);
    param_00.var_1E4D = 1;
  }

  if(isDefined(param_00.var_1E5A)) {
    return 0;
  }

  var_03 = param_00.var_6638;
  var_04 = !isDefined(param_00.var_6AA9);
  if(isDefined(var_03) && var_04 || param_00.var_6AA9) {
    var_05 = var_03 == param_01 || function_01F4(var_03, param_01, 1);
    if(var_05) {
      var_06 = common_scripts\utility::func_AA4A(self.var_0116, self getangles(), param_00.var_28D4, param_02);
      if(var_06) {
        if(var_04) {
          thread func_1E48(param_00);
          func_A761(param_00);
          if(!param_00.var_6AA9) {
            return 0;
          }
        }

        return 1;
      }
    }
  }

  return 0;
}

func_19D1(param_00, param_01, param_02) {
  var_03 = undefined;
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = self getnearestnode();
  }

  var_04 = undefined;
  if(isDefined(param_02)) {
    var_04 = param_02;
  } else {
    var_04 = self method_8375();
  }

  var_05 = [];
  if(isDefined(var_03)) {
    foreach(var_07 in level.var_31F9) {
      if(var_07 maps\mp\gametypes\_gameobjects::func_1F53(self.var_01A7)) {
        var_08 = 0;
        if(!param_00 || var_07.var_1180 == self) {
          if(!isDefined(var_07.var_1E5A)) {
            if(!isDefined(var_07.var_6AA9)) {
              level thread func_1E48(var_07);
              func_A761(var_07);
            }

            var_08 = distancesquared(self.var_0116, var_07.var_487B) < 1000000 && var_07.var_6AA9;
          }
        } else if(func_1A37(var_07, var_03, var_04)) {
          var_08 = 1;
        }

        if(var_08) {
          var_09 = spawnStruct();
          var_09.var_0116 = var_07.var_28D4;
          var_09.var_95A6 = var_07;
          var_05 = common_scripts\utility::func_0F6F(var_05, var_09);
        }
      }
    }
  }

  return var_0A;
}

func_1E48(param_00) {
  param_00 endon("reset");
  param_00.var_1E5A = 1;
  param_00.var_6AA9 = maps\mp\bots\_bots_util::func_1A9D(param_00.var_28D4, undefined, level.var_1AF5 + 55);
  if(param_00.var_6AA9) {
    param_00.var_487B = getgroundposition(param_00.var_28D4, 0, 256, 32);
    if(!isDefined(param_00.var_487B)) {
      param_00.var_6AA9 = 0;
    }
  }

  param_00.var_1E5A = undefined;
}

func_A761(param_00) {
  while(!isDefined(param_00.var_6AA9)) {
    wait 0.05;
  }
}

func_19C9(param_00, param_01) {
  var_02 = undefined;
  if(param_00.size > 0) {
    var_03 = 1409865409;
    foreach(var_05 in param_00) {
      var_06 = func_424F(var_05.var_95A6);
      if(!param_01 || var_06 < 2) {
        var_07 = distancesquared(var_05.var_95A6.var_487B, self.var_0116);
        if(var_07 < var_03) {
          var_02 = var_05.var_95A6;
          var_03 = var_07;
        }
      }
    }
  }

  return var_02;
}

func_1AB5(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(var_03.var_95A6 maps\mp\gametypes\_gameobjects::func_1F53(self.var_01A7) && maps\mp\bots\_bots_util::func_1B1C(var_03.var_95A6.var_28D4, var_03.var_0116)) {
      if(!func_196E(var_03.var_95A6) && var_03.var_95A6.var_6AA9) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_03);
      }
    }
  }

  return var_01;
}

func_424F(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_6E97) {
    if(!isDefined(var_03.var_01A7)) {
      continue;
    }

    if(var_03.var_01A7 == self.var_01A7 && var_03 != self) {
      if(isai(var_03)) {
        if(isDefined(var_03.var_95A8) && var_03.var_95A8 == param_00) {
          var_01++;
        }

        continue;
      }

      if(distancesquared(var_03.var_0116, param_00.var_28D4) < 160000) {
        var_01++;
      }
    }
  }

  return var_01;
}

func_1954(param_00, param_01, param_02) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");
  if(isDefined(param_02)) {
    self endon(param_02);
  }

  self botsetscriptgoalnode(self.var_6708, param_01, self.var_0D94);
  var_03 = maps\mp\bots\_bots_util::func_1B21();
  if(var_03 == "goal") {
    var_04 = param_00.var_6638;
    if(isDefined(var_04)) {
      var_05 = findentrances(self.var_0116);
      var_05 = common_scripts\utility::func_0F6F(var_05, var_04);
      childthread maps\mp\bots\_bots_util::func_1B2A(var_05);
    }
  }
}