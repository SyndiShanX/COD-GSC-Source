/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_hp.gsc
**********************************************/

func_00F9() {
  func_87A7();
  func_8796();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1A1A;
  level.var_19D5["should_start_cautious_approach"] = ::func_8B7C;
}

func_8796() {
  maps\mp\bots\_bots_util::func_1B20();
  var_00 = 0;
  for(var_01 = 0; var_01 < level.var_0BCF.size; var_01++) {
    var_02 = level.var_0BCF[var_01];
    var_02.var_81E8 = "zone_" + var_01;
    var_02 thread maps\mp\bots\_bots_gametype_common::func_6361();
    var_03 = 0;
    if(isDefined(var_02.var_9D5E.var_9D9F) && var_02.var_9D5E.var_9D9F) {
      var_02.var_9D5E common_scripts\utility::func_9DA3();
      var_03 = 1;
    }

    var_02.var_671A = maps\mp\bots\_bots_gametype_common::func_1A08(var_02.var_9D5E);
    if(var_03) {
      var_02.var_9D5E common_scripts\utility::func_9D9F();
    }
  }

  level.var_1AD9 = 1;
  if(!var_00) {
    level.var_1A19 = 1;
    var_04 = level.var_AC7C;
    if(!isDefined(var_04)) {
      var_04 = common_scripts\utility::func_7A33(level.var_0BCF);
    }

    maps\mp\bots\_bots_gametype_common::func_1951([var_04]);
    level.var_19EA[var_04 getentitynumber()] = 1;
    level.var_19E8 = 1;
    thread func_1950(var_04);
  }
}

func_1950(param_00) {
  for(var_01 = common_scripts\utility::func_0F93(level.var_0BCF, param_00); var_01.size > 0; var_01 = common_scripts\utility::func_0F93(var_01, var_02)) {
    var_02 = undefined;
    var_03 = level.var_AC7C;
    if(isDefined(var_03) && common_scripts\utility::func_0F79(var_01, var_03)) {
      var_02 = var_03;
    } else {
      var_02 = common_scripts\utility::func_7A33(var_01);
    }

    maps\mp\bots\_bots_gametype_common::func_1951([var_02]);
    level.var_19EA[var_02 getentitynumber()] = 1;
  }
}

func_1A1A() {
  self notify("bot_hp_think");
  self endon("bot_hp_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  var_00 = undefined;
  var_01 = level.var_AC7C;
  for(;;) {
    wait 0.05;
    if(self.var_00BC <= 0) {
      continue;
    }

    if(!isDefined(level.var_AC7C) || !isDefined(level.var_19EA[level.var_AC7C getentitynumber()])) {
      if(maps\mp\bots\_bots_util::func_1A2D()) {
        maps\mp\bots\_bots_strategy::func_19A3();
      }

      self.var_291F = undefined;
      self[[self.var_6F7F]]();
      continue;
    }

    if(var_01 != level.var_AC7C) {
      var_00 = undefined;
      var_01 = level.var_AC7C;
    }

    if(isDefined(level.var_ACAF) && !isDefined(var_00) && level.var_7A62 == 0 && level.var_1A19) {
      var_02 = level.var_ACAF - gettime();
      if(var_02 > 0 && var_02 < 10000) {
        var_03 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7() == self.var_01A7;
        if(!var_03) {
          var_04 = level.var_AC7C.var_AC7F.var_014F * 6;
          if(var_02 < 5000) {
            var_04 = level.var_AC7C.var_AC7F.var_014F * 3;
          }

          var_05 = distance(level.var_AC7C.var_AC7F.var_206B, self.var_0116);
          if(var_05 > var_04) {
            var_00 = func_1ADF();
          }
        } else {
          var_06 = maps\mp\bots\_bots_util::func_19F9(self.var_01A7);
          var_07 = ceil(var_06 / 2);
          if(var_02 < 5000) {
            var_07 = ceil(var_06 / 3);
          }

          var_08 = func_19FB(level.var_AC7C);
          if(var_08 + 1 > var_07) {
            var_00 = func_1ADF();
          }
        }
      }
    }

    var_02 = level.var_AC7C;
    if(isDefined(var_01) && var_01) {
      var_02 = level.var_ACB3[level.var_76EE + 1 % level.var_ACB3.size];
    }

    if(!func_1A2B(var_02)) {
      func_1969(var_02);
    }
  }
}

func_1ADF() {
  if(level.var_7A62) {
    return 0;
  }

  var_00 = self botgetdifficultysetting("strategyLevel");
  var_01 = 0;
  if(var_00 == 1) {
    var_01 = 0.1;
  } else if(var_00 == 2) {
    var_01 = 0.5;
  } else if(var_00 == 3) {
    var_01 = 0.8;
  }

  return randomfloat(1) < var_01;
}

func_19FB(param_00) {
  return func_1A03(param_00).size;
}

func_1A03(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_6E97) {
    if(var_03 != self && maps\mp\_utility::func_5800(var_03) && isalliedsentient(self, var_03)) {
      if(var_03 istouching(level.var_AC7C.var_9D5E)) {
        if(!isai(var_03) || var_03 func_1A2B(param_00)) {
          var_01[var_01.size] = var_03;
        }
      }
    }
  }

  return var_01;
}

func_1A2B(param_00) {
  if(!maps\mp\bots\_bots_util::func_1A28()) {
    return 0;
  }

  return self.var_291F == param_00;
}

func_1969(param_00) {
  self.var_291F = param_00;
  var_01["entrance_points_index"] = param_00.var_37DA;
  var_01["override_origin_node"] = param_00.var_206D;
  maps\mp\bots\_bots_strategy::func_196B(param_00.var_0116, param_00.var_671A, param_00.var_9D5E, var_01);
}

func_8B7C(param_00) {
  if(param_00) {
    var_01 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
    if(var_01 == "neutral" || var_01 == self.var_01A7) {
      return 0;
    }
  }

  return maps\mp\bots\_bots_strategy::func_8B7A(param_00);
}