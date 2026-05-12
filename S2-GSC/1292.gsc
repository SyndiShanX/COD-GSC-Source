/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1292.gsc
*********************************************/

lib_050C::func_534F() {
  var_00 = "mp/spawnConstantsPerMap.csv";
  var_01 = function_027B(var_00);
  for(var_02 = 1; var_02 < var_01; var_02++) {
    var_03 = tablelookup(var_00, 0, "spawn_constants", var_02);
    if(isDefined(var_03) && lib_050C::func_57DA(var_03)) {
      var_04 = lib_050C::func_468F(var_00, var_02);
      level.var_9036[var_03] = var_04;
      var_05 = tablelookup(var_00, 0, "save_squared_constant", var_02);
      if(isDefined(var_05) && var_05 == "TRUE") {
        level.var_9037[var_03] = squared(var_04);
      }
    }
  }

  if(level.var_3FDC == "ctf") {
    level.var_9036["allyDeathTime"] = 4000;
  }
}

lib_050C::func_57DA(param_00) {
  switch (param_00) {
    case "DOMPointTooCloseDistance":
    case "HPZoneTooCloseDistance":
    case "HPZoneNearDistance":
    case "CTFBaseDistance":
    case "allyDeathTime":
    case "allyDeathDistance":
    case "enemySpawnAreaTime":
    case "enemySpawnAreaDistance":
    case "allyDistance":
    case "enemyDistance":
    case "LOSDistance":
    case "DOMPointPerferLastTeamSpawnTime":
      return 1;

    default:
      return 0;
  }
}

lib_050C::func_468F(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, maps\mp\_utility::func_4571(), param_01);
  if(!isDefined(var_02) || var_02 == "") {
    var_02 = tablelookup(param_00, 0, "mp_default", param_01);
  }

  return int(var_02);
}

lib_050C::func_80A2(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04)) {
    var_05 = [[param_01]](param_02, param_03, param_04);
  } else {
    var_05 = [[param_02]](param_03, param_04);
  }

  var_05 = clamp(var_05, 0, 100);
  var_05 = var_05 * param_00;
  param_03.var_2B5E[param_03.var_2B5E.size] = var_05;
  param_03.var_9AB7 = param_03.var_9AB7 + 100 * param_00;
  return var_05;
}

lib_050C::func_2857(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = [[param_00]](param_01, param_02, param_03);
  } else {
    var_04 = [[param_01]](param_02, param_03);
  }

  var_04 = clamp(var_04, 0, 100);
  param_02.var_2B4F[param_02.var_2B4F.size] = var_04;
  return var_04;
}

lib_050C::func_1437(param_00, param_01) {
  foreach(var_03 in level.var_1FFD) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(distancesquared(param_01.var_0116, var_03.var_0116) < 2500) {
      return 0;
    }
  }

  return 100;
}

lib_050C::func_1443(param_00, param_01) {
  foreach(var_03 in level.var_486C) {
    if(!isDefined(var_03) || !var_03 lib_050C::func_56E4(self)) {
      continue;
    }

    if(distancesquared(param_01.var_0116, var_03.var_0116) < 65536) {
      return 0;
    }
  }

  return 100;
}

lib_050C::func_1447(param_00, param_01) {
  var_02 = level.var_61ED;
  foreach(var_04 in var_02) {
    if(!isDefined(var_04) || !var_04 lib_050C::func_56E4(self)) {
      continue;
    }

    if(distancesquared(param_01.var_0116, var_04.var_0116) < 65536) {
      return 0;
    }
  }

  return 100;
}

lib_050C::func_56E4(param_00) {
  if(!level.var_984D || level.var_3EC4 || isDefined(param_00) && !isDefined(param_00.var_01A7)) {
    return 1;
  }

  if(!isDefined(self.var_0117) || !isDefined(self.var_0117.var_01A7)) {
    return 1;
  }

  if(isDefined(param_00) && param_00 == self.var_0117) {
    return 1;
  }

  var_01 = self.var_0117.var_01A7;
  return var_01 != param_00.var_01A7;
}

lib_050C::func_144D(param_00, param_01) {
  if(!isDefined(level.var_80B4)) {
    return 100;
  }

  if(!param_01.var_6C97) {
    return 100;
  }

  var_02 = lib_0526::func_4675(param_01.var_0116);
  if(var_02 > 0.25) {
    return 0;
  }

  return 100;
}

lib_050C::func_143A(param_00, param_01) {
  var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
  if(param_01.var_266E[var_02] > 0) {
    return 0;
  }

  return 100;
}

lib_050C::func_1442(param_00, param_01) {
  var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
  if(param_01.var_3EFF[var_02] > 0) {
    return 0;
  }

  return 100;
}

lib_050C::func_765F(param_00, param_01) {
  var_02 = maps\mp\_utility::func_45DE(param_00);
  if(getdvarint("disableSpawnClaim") || level.var_909B["preferClaimedSpawn"]["scoreFactorWeight"] == 0) {
    return 0;
  }

  if(!isDefined(level.var_9034)) {
    level.var_9034 = 0;
    var_03 = lib_050D::func_44F9();
    var_04 = lib_050D::func_46A0("allies");
    var_05 = lib_050D::func_46A0("axis");
    foreach(var_07 in var_03) {
      var_08 = 9999999;
      foreach(var_0A in var_04) {
        var_0B = distance(var_07.var_0116, var_0A.var_0116);
        if(var_0B < var_08) {
          var_08 = var_0B;
        }
      }

      if(isDefined(var_07.var_0165) && var_07.var_0165 == "axis_override") {
        var_07.var_2BD3 = "axis";
        continue;
      }

      if(isDefined(var_07.var_0165) && var_07.var_0165 == "allies_override") {
        var_07.var_2BD3 = "allies";
        continue;
      }

      var_07.var_2BD3 = "allies";
      foreach(var_0E in var_05) {
        var_0F = distance(var_07.var_0116, var_0E.var_0116);
        if(var_0F < var_08 / 2) {
          var_07.var_2BD3 = "axis";
          break;
        } else if(var_0F <= var_08 * 2) {
          var_07.var_2BD3 = "none";
        }
      }
    }
  }

  if(level.var_9034) {
    var_12 = maps\mp\_utility::func_45DE(var_0B);
  } else {
    var_12 = var_0C;
  }

  if(var_0C.var_2BD3 == var_12) {
    return 100;
  }

  return 0;
}

lib_050C::func_10DE(param_00, param_01) {
  if(lib_050C::func_2936() && isDefined(param_01.var_3EF5) && level.var_3EF3.var_565F[self.var_01A7] && param_01.var_3EF5 != self.var_01A7) {
    return 0;
  }

  return 100;
}

lib_050C::func_1451(param_00, param_01) {
  if(positionwouldtelefrag(param_01.var_0116)) {
    foreach(var_03 in param_01.var_0CAD) {
      if(!positionwouldtelefrag(var_03)) {
        break;
      }
    }

    return 0;
  }

  return 100;
}

lib_050C::func_144C(param_00, param_01) {
  if(isDefined(self.var_5BE0) && self.var_5BE0 == param_01) {
    return 0;
  }

  return 100;
}

lib_050C::func_144A(param_00, param_01) {
  if(isDefined(param_01.var_5BE2)) {
    var_02 = gettime() - param_01.var_5BE2;
    if(var_02 > 4000) {
      return 100;
    }

    return var_02 / 4000 * 100;
  }

  return 100;
}

lib_050C::func_143E(param_00, param_01) {
  if(isDefined(param_01.var_5BE1) && !level.var_984D || param_01.var_5BE1 != param_00) {
    var_02 = param_01.var_5BE2 + 500;
    if(gettime() < var_02) {
      return 0;
    }
  }

  return 100;
}

lib_050C::func_1438(param_00, param_01) {
  var_02 = lib_050C::func_3B92(param_00, param_01, 1);
  if(isDefined(var_02)) {
    var_03 = var_02 / level.var_9037["enemySpawnAreaDistance"];
    return var_03 * 100;
  }

  return 100;
}

lib_050C::func_3B92(param_00, param_01, param_02) {
  var_03 = maps\mp\_utility::func_45DE(param_00);
  if(!level.var_984D) {
    param_00 = "all";
    var_03 = "all";
  }

  if(!isDefined(level.var_7AD4[var_03])) {
    return undefined;
  }

  var_04 = [];
  var_05 = 99999999;
  var_06 = 0;
  foreach(var_08 in level.var_7AD4[var_03]) {
    var_09 = gettime() - var_08["time"];
    if(var_09 > level.var_9036["enemySpawnAreaTime"]) {
      continue;
    }

    var_04[var_04.size] = var_08;
    var_0A = distancesquared(param_01.var_0116, var_08["position"]);
    if((param_02 && var_0A > level.var_9037["enemySpawnAreaDistance"]) || !level.var_984D && var_08["player"] == self.var_48CA) {
      continue;
    }

    if(var_0A < var_05) {
      var_05 = var_0A;
      var_06 = 1;
    }
  }

  if(var_06) {
    return var_05;
  }

  return undefined;
}

lib_050C::func_1450(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return 0;
  }

  var_03 = distancesquared(param_01.var_0116, param_02["position"]);
  var_04 = var_03 / level.var_9037["enemySpawnAreaDistance"];
  return var_04 * 100;
}

lib_050C::func_143F(param_00, param_01) {
  var_02 = level.var_909B["avoidEnemySpawnLocations"]["scoreFactorWeight"];
  var_03 = maps\mp\_utility::func_45DE(param_00);
  if(!level.var_984D) {
    param_00 = "all";
    var_03 = "all";
  }

  var_04 = 0;
  var_05 = [];
  foreach(var_07 in level.var_7AD4[var_03]) {
    var_08 = gettime() - var_07["time"];
    if(var_08 > level.var_9036["enemySpawnAreaTime"]) {
      continue;
    }

    var_05[var_05.size] = var_07;
    if(level.var_984D || var_07["player"] != self.var_48CA) {
      var_04 = var_04 + lib_050C::func_80A2(var_02, ::lib_050C::func_1450, param_00, param_01, var_07);
    }
  }

  level.var_7AD4[var_03] = var_05;
  return var_04;
}

lib_050C::func_144F(param_00, param_01, param_02) {
  var_03 = distancesquared(param_02.var_0116, param_01.var_0116);
  if(var_03 < 692224) {
    return 0;
  }

  return 100;
}

lib_050C::func_144E(param_00, param_01, param_02) {
  return lib_050C::func_144F(param_00, param_01, maps\mp\gametypes\hp::func_4484());
}

lib_050C::func_68A3(param_00, param_01) {
  if(!isDefined(param_01.var_9849) || param_01.var_9849 == "none" || param_00 == param_01.var_9849) {
    return 100;
  }

  return 0;
}

lib_050C::func_1446(param_00, param_01) {
  if(!isDefined(self.var_5B90)) {
    return 100;
  }

  var_02 = distancesquared(param_01.var_0116, self.var_5B90);
  if(var_02 > 4000000) {
    return 100;
  }

  var_03 = var_02 / 4000000;
  return var_03 * 100;
}

lib_050C::func_7664(param_00, param_01) {
  if(!isDefined(self.var_5B90)) {
    return 0;
  }

  var_02 = distancesquared(param_01.var_0116, self.var_5B90);
  if(var_02 > 400000000) {
    return 0;
  }

  var_03 = 1 - var_02 / 400000000;
  return var_03 * 100;
}

lib_050C::func_1439(param_00, param_01) {
  var_02 = lib_050C::func_3B91(param_00, param_01, 1);
  if(isDefined(var_02)) {
    var_03 = var_02 / level.var_9037["allyDeathDistance"];
    return var_03 * 100;
  }

  return 100;
}

lib_050C::func_3B91(param_00, param_01, param_02) {
  if(!level.var_984D) {
    param_00 = "all";
  }

  if(!isDefined(level.var_7AD1[param_00])) {
    return undefined;
  }

  var_03 = [];
  var_04 = 99999999;
  var_05 = 0;
  foreach(var_07 in level.var_7AD1[param_00]) {
    var_08 = gettime() - var_07["time"];
    if(var_08 > level.var_9036["allyDeathTime"]) {
      continue;
    }

    var_03[var_03.size] = var_07;
    var_09 = distancesquared(param_01.var_0116, var_07["position"]);
    if((param_02 && var_09 > level.var_9037["allyDeathDistance"]) || !level.var_984D && var_07["player"] != self.var_48CA) {
      continue;
    }

    if(var_09 < var_04) {
      var_04 = var_09;
      var_05 = 1;
    }
  }

  level.var_7AD1[param_00] = var_03;
  if(var_05) {
    return var_04;
  }

  return undefined;
}

lib_050C::func_143B(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return 0;
  }

  var_03 = distancesquared(param_01.var_0116, param_02["position"]);
  var_04 = var_03 / level.var_9037["allyDeathDistance"];
  return var_04 * 100;
}

lib_050C::func_1435(param_00, param_01) {
  var_02 = level.var_909B["avoidAllyDeathLocations"]["scoreFactorWeight"];
  if(!level.var_984D) {
    param_00 = "all";
  }

  var_03 = 0;
  var_04 = [];
  foreach(var_06 in level.var_7AD1[param_00]) {
    var_07 = gettime() - var_06["time"];
    if(var_07 > level.var_9036["allyDeathTime"]) {
      continue;
    }

    var_04[var_04.size] = var_06;
    if(level.var_984D || var_06["player"] == self.var_48CA) {
      var_03 = var_03 + lib_050C::func_80A2(var_02, ::lib_050C::func_143B, param_00, param_01, var_06);
    }
  }

  level.var_7AD1[param_00] = var_04;
  return var_03;
}

lib_050C::func_1445(param_00, param_01) {
  if(!isDefined(self.var_00E6) || !isDefined(self.var_00E6.var_0116)) {
    return 100;
  }

  if(!maps\mp\_utility::func_57A0(self.var_00E6)) {
    return 100;
  }

  var_02 = distancesquared(param_01.var_0116, self.var_00E6.var_0116);
  if(var_02 > 4000000) {
    return 100;
  }

  var_03 = var_02 / 4000000;
  return var_03 * 100;
}

lib_050C::func_765D(param_00, param_01) {
  var_02 = getspawnpointtotalplayers(param_01.var_00D4, param_00);
  if(var_02 == 0) {
    return 0;
  }

  var_03 = getspawnpointdistsum(param_01.var_00D4, param_00);
  if(!isDefined(var_03)) {
    return 0;
  }

  var_03 = var_03 / var_02;
  var_03 = min(var_03, level.var_9036["enemyDistance"]);
  var_04 = 1 - var_03 / level.var_9036["enemyDistance"];
  return var_04 * 100;
}

lib_050C::func_7660(param_00, param_01) {
  if(getspawnpointtotalplayers(param_01.var_00D4, param_00) == 0) {
    return 0;
  }

  var_02 = getspawnpointmindist(param_01.var_00D4, param_00);
  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = 1 - var_02 / level.var_9036["allyDistance"];
  return var_03 * 100;
}

lib_050C::func_AAFF(param_00, param_01) {
  var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
  if(getspawnpointtotalplayers(param_01.var_00D4, var_02) == 0) {
    return 100;
  }

  var_03 = getspawnpointmindist(param_01.var_00D4, var_02);
  if(!isDefined(var_03)) {
    return 0;
  }

  var_04 = var_03 / level.var_9036["enemyDistance"];
  return var_04 * 100;
}

lib_050C::func_7669(param_00, param_01, param_02) {
  var_03 = getspawnpointdistancetoplayer(param_01.var_00D4, param_02 getentitynumber());
  if(!isDefined(var_03) || !maps\mp\_utility::func_57A0(param_02)) {
    return 100;
  }

  var_04 = 1 - var_03 / level.var_9036["allyDistance"];
  return var_04 * 100;
}

lib_050C::func_1449(param_00, param_01, param_02) {
  var_03 = getspawnpointdistancetoplayer(param_01.var_00D4, param_02 getentitynumber());
  if(!isDefined(var_03) || !maps\mp\_utility::func_57A0(param_02)) {
    return 100;
  }

  var_04 = var_03 / level.var_9036["enemyDistance"];
  return var_04 * 100;
}

lib_050C::func_143C(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  if(isDefined(level.var_909B["avoidEnemies"])) {
    var_02 = level.var_909B["avoidEnemies"]["scoreFactorWeight"];
  }

  if(isDefined(level.var_909B["preferAllies"])) {
    var_03 = level.var_909B["preferAllies"]["scoreFactorWeight"];
  }

  var_04 = 0;
  if(isDefined(param_00)) {
    foreach(var_06 in level.var_744A) {
      if(!isDefined(var_06) || !isDefined(var_06.var_01A7) || var_06 == self || function_02D5(var_06) == "spectator") {
        continue;
      } else {
        if(((level.var_984D && var_06.var_01A7 != param_00) || !level.var_984D) && var_02 > 0) {
          var_04 = var_04 + lib_050C::func_80A2(var_02, ::lib_050C::func_1449, param_00, param_01, var_06);
          continue;
        }

        if(level.var_984D && var_06.var_01A7 == param_00 && var_03 > 0) {
          var_04 = var_04 + lib_050C::func_80A2(var_03, ::lib_050C::func_7669, param_00, param_01, var_06);
        }
      }
    }
  }

  return var_07;
}

lib_050C::func_7663(param_00, param_01) {
  if(param_01.var_3767 > 0) {
    var_02 = param_01.var_3ED2 / param_01.var_3767 / param_01.var_3ED1.var_4D3F * 1.33;
  } else {
    var_02 = 0;
  }

  return var_02 * 100;
}

lib_050C::func_7662(param_00, param_01) {
  if(param_01.var_3767 > 0 && param_01.var_3ED1.var_645F > 0) {
    var_02 = param_01.var_3767 / param_01.var_3ED1.var_645F;
  } else {
    var_02 = 0;
  }

  return var_02 * 100;
}

lib_050C::func_7661(param_00, param_01) {
  if((param_00 == "allies" && level.var_0BF7 == 0) || param_00 == "axis" && level.var_147E == 0) {
    return 0;
  }

  return lib_050C::func_7662(param_00, param_01);
}

lib_050C::func_1441(param_00, param_01) {
  if(param_01.var_3ED2 > level.var_9037["CTFBaseDistance"]) {
    return 100;
  }

  var_02 = param_01.var_3ED2 / level.var_9037["CTFBaseDistance"];
  return var_02 * 100;
}

lib_050C::func_1440(param_00, param_01) {
  if((param_00 == "allies" && level.var_0BF7 == 0) || param_00 == "axis" && level.var_147E == 0) {
    return lib_050C::func_1441(param_00, param_01);
  }

  return 0;
}

lib_050C::func_765E(param_00, param_01) {
  var_02 = maps\mp\gametypes\dom::func_4638(param_00);
  if(isDefined(param_01.var_766F) && var_02[param_01.var_766F]) {
    return 100;
  }

  return 0;
}

lib_050C::func_143D(param_00, param_01) {
  var_02 = maps\mp\gametypes\dom::func_4638(maps\mp\_utility::func_45DE(param_00));
  if(!isDefined(param_01.var_766F) || !var_02[param_01.var_766F]) {
    return 100;
  }

  var_03 = distancesquared(param_01.var_0116, maps\mp\gametypes\dom::func_44E1(param_01.var_766F));
  var_04 = var_03 / level.var_9037["DOMPointTooCloseDistance"];
  return 100 * var_04;
}

lib_050C::func_7676(param_00, param_01) {
  if(!isDefined(level.var_321C) || !isDefined(level.var_321C[param_00])) {
    return 0;
  }

  var_02 = gettime() - level.var_321C[param_00]["time"];
  if(var_02 > level.var_9036["DOMPointPerferLastTeamSpawnTime"]) {
    level.var_321C[param_00] = undefined;
    return 0;
  }

  if(isDefined(param_01.var_766F) && param_01.var_766F == level.var_321C[param_00]["flag"]) {
    return 100;
  }

  return 0;
}

lib_050C::func_7A5E(param_00, param_01) {
  return randomintrange(0, 99);
}

lib_050C::func_7667(param_00, param_01) {
  var_02 = maps\mp\gametypes\hp::func_4484();
  var_03 = distancesquared(var_02.var_0116, param_01.var_0116);
  var_04 = var_03 - 692224;
  var_05 = 6067776;
  var_06 = 1867776;
  if(var_04 >= var_06) {
    return 100 * 1 - 0.25 * var_04 - var_06 / var_05 - var_06;
  }

  if(var_04 > 0) {
    return 100 * var_04 / var_06;
  }

  return 0;
}

lib_050C::func_1452(param_00, param_01) {
  var_02 = maps\mp\gametypes\hp::func_4484();
  var_03 = distancesquared(var_02.var_0116, param_01.var_0116);
  if(var_03 <= level.var_9037["HPZoneTooCloseDistance"]) {
    return 0;
  }

  return 100;
}

lib_050C::func_7666(param_00, param_01) {
  var_02 = maps\mp\gametypes\hp::func_4484();
  var_03 = distancesquared(var_02.var_0116, param_01.var_0116);
  if(var_03 >= level.var_9037["HPZoneNearDistance"]) {
    return 0;
  }

  var_04 = 1 - var_03 / level.var_9037["HPZoneNearDistance"];
  return var_04 * 100;
}

avoidveryclosetorelic(param_00, param_01) {
  var_02 = level.var_1562[0].var_28D4;
  var_03 = distancesquared(var_02, param_01.var_0116);
  if(var_03 <= level.var_9037["HPZoneTooCloseDistance"]) {
    return 0;
  }

  return 100;
}

prefernearrelic(param_00, param_01) {
  var_02 = level.var_1562[0].var_28D4;
  var_03 = distancesquared(var_02, param_01.var_0116);
  if(var_03 >= level.var_9037["HPZoneNearDistance"]) {
    return 0;
  }

  var_04 = 1 - var_03 / level.var_9037["HPZoneNearDistance"];
  return var_04 * 100;
}

lib_050C::func_7668(param_00, param_01) {
  var_02 = maps\mp\_utility::func_45DE(param_00);
  var_03 = getspawnpointnearbyfriendlies(param_01.var_00D4, param_00);
  var_04 = getspawnpointnearbyenemies(param_01.var_00D4, var_02);
  if(var_03 == 0) {
    return 0;
  }

  if(var_04 == 0) {
    return 100;
  }

  var_05 = var_03 - var_04;
  if(var_05 <= 0) {
    return 0;
  }

  if(var_05 == 1) {
    return 35;
  }

  if(var_05 >= 2) {
    return 50;
  }

  return 0;
}

lib_050C::func_AB32(param_00, param_01) {
  if(!isDefined(param_01.var_0165)) {
    return 100;
  }

  if(isDefined(level.zombies_active_spawn_event)) {
    var_02 = "zombie_event_spawn_" + level.zombies_active_spawn_event;
    if(isDefined(param_01.var_01A5) && param_01.var_01A5 == var_02) {
      return 100;
    }
  }

  if(isDefined(level.var_1F1D) && ![[level.var_1F1D]](param_01.var_0165)) {
    return 0;
  }

  if(isDefined(level.var_AC88) && [[level.var_AC88]](param_01.var_0165)) {
    return 0;
  }

  return 100;
}

lib_050C::func_AB3F(param_00, param_01) {
  if(!isDefined(level.var_A24A) || !level.var_A24A) {
    return 0;
  }

  if(!isDefined(self.var_5B90) || !isDefined(level.var_4200) || !isDefined(level.var_43F2)) {
    return 100;
  }

  var_02 = [[level.var_4200]](self.var_5B90);
  if(!isDefined(var_02)) {
    return 100;
  }

  var_03 = [[level.var_43F2]](var_02, param_01.var_0165);
  if(var_03 < 0) {
    return 0;
  }

  if(var_03 == 0) {
    return 100;
  }

  return 100 / var_03;
}

lib_050C::func_AB40(param_00, param_01) {
  if(isDefined(level.var_A24A) && level.var_A24A) {
    return 0;
  }

  if(!isDefined(level.var_AC88)) {
    return 0;
  }

  if(!isDefined(self.var_5B90) || !isDefined(level.var_4200) || !isDefined(level.var_43F4)) {
    return 100;
  }

  var_02 = [[level.var_4200]](self.var_5B90);
  if(!isDefined(var_02)) {
    return 100;
  }

  var_03 = [[level.var_43F4]](var_02, param_01.var_0165);
  if(var_03 < 0) {
    return 0;
  }

  if(var_03 == 0) {
    return 100;
  }

  return 100 / var_03;
}

lib_050C::func_AB41(param_00, param_01) {
  if(!isDefined(self.var_5B90)) {
    return 0;
  }

  var_02 = distance(param_01.var_0116, self.var_5B90);
  if(var_02 >= 2500 || var_02 <= 500) {
    return 0;
  }

  var_03 = max(0, 1 - abs(1500 - var_02) / 1000);
  return var_03 * 100;
}

lib_050C::func_A119(param_00) {
  if(!lib_050C::func_A11B()) {
    return;
  }

  lib_050C::func_7FA2(param_00);
  lib_050C::func_A11A();
}

lib_050C::func_A11B() {
  if(!lib_050C::func_2936()) {
    return 0;
  }

  var_00 = lib_050C::func_4500();
  var_01 = lib_050C::func_4572();
  var_02 = gettime();
  if(!isDefined(var_00.var_5C09)) {
    var_00.var_5C09 = var_02;
  } else if(var_00.var_565F["allies"] && var_00.var_565F["axis"]) {
    var_00.var_A1C7 = var_00.var_A1C7 + var_00.var_5C0A;
  } else {
    var_00.var_32D2 = var_00.var_32D2 + var_00.var_5C0A;
  }

  var_03 = var_02 - var_00.var_5C09 / 1000;
  var_00.var_5C09 = var_02;
  var_00.var_5C0A = var_03;
  var_04 = lib_050C::func_44F2("allies");
  if(!isDefined(var_04)) {
    return 0;
  }

  var_04 = (var_04[0], var_04[1], 0);
  var_00.var_0BF3 = var_04;
  var_05 = lib_050C::func_44F2("axis");
  if(!isDefined(var_05)) {
    return 0;
  }

  var_05 = (var_05[0], var_05[1], 0);
  var_00.var_1479 = var_05;
  var_06 = var_05 - var_04;
  var_07 = vectortoyaw(var_06);
  var_08 = var_04 + var_06 * 0.5;
  if(var_07 > 180) {
    var_07 = var_07 - 360;
  } else if(var_07 < -180) {
    var_07 = 360 + var_07;
  }

  var_00.var_5030 = var_08;
  var_00.var_5031 = var_07;
  var_09 = common_scripts\utility::func_98E7(var_00.var_9A9D == "allies", "axis", "allies");
  var_0A = common_scripts\utility::func_98E7(var_00.var_9A9D == "allies", var_04, var_05);
  var_0B = common_scripts\utility::func_98E7(var_09 == "allies", var_04, var_05);
  var_0C = distance2dsquared(var_0B, (var_01.var_5FEB[0] - var_01.var_3D75, var_01.var_5FEB[1], var_08[2])) < distance2dsquared(var_0A, (var_01.var_5FEB[0] - var_01.var_3D75, var_01.var_5FEB[1], var_08[2]));
  var_0D = distance2dsquared(var_0B, (var_01.var_5FEB[0] + var_01.var_3D75, var_01.var_5FEB[1], var_08[2])) > distance2dsquared(var_0A, (var_01.var_5FEB[0] + var_01.var_3D75, var_01.var_5FEB[1], var_08[2]));
  var_0E = 0;
  var_02 = gettime();
  if(var_02 > var_00.var_5B9D + var_01.var_3D76) {
    if((var_07 < var_01.var_3D72 && var_07 > -180 - var_01.var_3D72) || (var_07 > var_01.var_3D70 && var_07 < 180 - var_01.var_3D70) || distance2d(var_01.var_5FEB, var_08) > var_01.var_3D75 || var_0D || var_0C) {
      if(isDefined(var_00.var_530B)) {
        if(var_02 > var_00.var_530B + var_01.var_3D71) {
          if(var_0D || var_0C) {
            var_0E = 1;
            var_00.var_5B9D = var_02;
            var_00.var_9A9D = var_09;
            level.var_90A2 = 1;
          }

          var_00.var_530B = undefined;
        }
      } else {
        var_00.var_530B = var_02;
      }
    } else {
      var_00.var_530B = undefined;
    }
  } else {
    var_00.var_530B = undefined;
  }

  var_0F = clamp(var_08[0], var_01.var_5FEB[0] - var_01.var_014F, var_01.var_5FEB[0] + var_01.var_014F);
  var_10 = var_01.var_5FEB[1];
  var_08 = (var_0F, var_10, var_08[2]);
  var_11 = 1 - abs(var_08[0] - var_01.var_5FEB[0] / var_01.var_014F);
  var_12 = 0;
  if(var_07 < var_01.var_6224 * var_11 && var_07 > -180 - var_01.var_6224 * var_11) {
    if(var_07 >= -90) {
      var_07 = clamp(var_07, var_01.var_6224 * var_11, 0);
    } else {
      var_07 = clamp(-1 * var_07, 0, var_01.var_60A8 * var_11) + 180;
      var_12 = 1;
    }
  } else if(var_07 < var_01.var_6224 * var_11) {
    var_12 = 1;
  } else if(var_07 > var_01.var_60A8 * var_11 && var_07 < 180 - var_01.var_60A8 * var_11) {
    if(var_07 <= 90) {
      var_07 = clamp(var_07, 0, var_01.var_60A8 * var_11);
    } else {
      var_07 = clamp(-1 * var_07, var_01.var_6224 * var_11, 0) - 180;
      var_12 = 1;
    }
  } else if(var_07 > var_01.var_60A8 * var_11) {
    var_12 = 1;
  }

  if(!isDefined(var_00.var_9851) || !var_00.var_565F["allies"] || !var_00.var_565F["axis"]) {
    var_00.var_9851 = var_07;
  }

  var_00.var_9851 = var_07;
  if(!isDefined(var_00.var_6162) || !var_00.var_565F["allies"] || !var_00.var_565F["axis"]) {
    var_00.var_6162 = var_08;
  }

  var_13 = var_08 - var_00.var_6162;
  var_14 = length2d(var_13);
  var_15 = min(var_14, 40 * var_03);
  if(var_15 > 0) {
    var_13 = var_13 * var_15 / var_14;
    var_00.var_6162 = var_00.var_6162 + var_13;
  }

  var_16 = anglesToForward((0, var_00.var_9851, 0));
  if(var_00.var_3C62) {
    var_00.var_5B9D = gettime();
    var_17 = var_00.var_6162 - var_00.var_0BF3;
    var_18 = vectordot(var_17, var_16);
    var_00.var_9A9D = common_scripts\utility::func_98E7(var_18 > 0, "allies", "axis");
    var_00.var_3C62 = 0;
  }

  var_19 = level.var_908B;
  var_19 = lib_050D::func_44F9();
  foreach(var_1B in var_19) {
    var_1C = undefined;
    var_1D = var_00.var_6162 - var_1B.var_0116;
    var_18 = vectordot(vectornormalize(var_1D), vectornormalize(var_16));
    if((var_00.var_9A9D == "allies" && var_18 > 0) || var_00.var_9A9D != "allies" && var_18 <= 0) {
      if(!var_12) {
        var_1C = "allies";
      } else {
        var_1C = "axis";
      }

      var_1B.var_3EF5 = var_1C;
      continue;
    }

    if(!var_12) {
      var_1C = "axis";
    } else {
      var_1C = "allies";
    }

    var_1B.var_3EF5 = var_1C;
  }

  return 1;
}

lib_050C::func_A11A() {
  var_00 = isDefined(level.var_602E) && isDefined(level.var_602D);
  var_01 = 0;
  if(!var_00 && !var_01) {
    return;
  }

  var_02 = lib_050C::func_4500();
  if(!isDefined(var_02.var_5E94) && isDefined(level.var_602D)) {
    var_02.var_5E94 = [];
    var_02.var_5E94["line"] = [[level.var_602D]]();
    var_02.var_5E94["alliesCenter"] = [[level.var_602D]]();
    var_02.var_5E94["axisCenter"] = [[level.var_602D]]();
  }

  if(!var_02.var_565F["allies"] && !var_02.var_565F["axis"]) {
    return;
  }

  var_03 = (var_02.var_6162[0], var_02.var_6162[1], level.var_5FEB[2]);
  var_04 = anglestoright((0, var_02.var_9851, 0));
  var_05 = var_03 + var_04 * 5000;
  var_06 = var_03 - var_04 * 5000;
  if(isDefined(level.var_602E)) {
    var_07 = undefined;
    if(var_02.var_565F["allies"] && var_02.var_565F["axis"]) {
      var_07 = "FRONT_LINE";
    } else {
      var_07 = common_scripts\utility::func_98E7(var_02.var_565F["allies"], "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level.var_602E]](var_02.var_5E94["line"], "allies", var_07, var_05[0], var_05[1], gettime(), undefined, var_06[0], var_06[1]);
  }

  if(isDefined(level.var_602E)) {
    var_08 = common_scripts\utility::func_98E7(var_03.var_565F["axis"], var_03.var_1479, (10000, 10000, 10000));
    [[level.var_602E]](var_03.var_5E94["axisCenter"], "axis", "ANCHOR", var_08[0], var_08[1], gettime());
    var_09 = common_scripts\utility::func_98E7(var_03.var_565F["allies"], var_03.var_0BF3, (10000, 10000, 10000));
    [[level.var_602E]](var_03.var_5E94["alliesCenter"], "allies", "ANCHOR", var_09[0], var_09[1], gettime());
  }
}

lib_050C::func_44F2(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_744A) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(!maps\mp\_utility::func_57A0(var_03)) {
      continue;
    }

    if(var_03.var_01A7 == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  if(var_01.size == 0) {
    return undefined;
  }

  var_05 = maps\mp\_utility::func_442E(var_01);
  return var_05;
}

lib_050C::func_7FA2(param_00) {
  if(!lib_050C::func_2936()) {
    return;
  }

  var_01 = lib_050C::func_4500();
  var_01.var_565F[param_00] = 1;
  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }

  var_02 = getdvarint("scr_frontline_min_spawns", 0);
  if(var_02 == 0) {
    var_02 = 4;
  }

  var_03 = maps\mp\_utility::func_45DE(param_00);
  var_04 = 0;
  var_05 = level.var_908B;
  var_05 = lib_050D::func_44F9();
  foreach(var_07 in var_05) {
    if(!isDefined(var_07.var_3EF5) || var_07.var_3EF5 != param_00) {
      continue;
    }

    if(!isDefined(var_07.var_3EFF) || !isDefined(var_07.var_3EFF[var_03]) || var_07.var_3EFF[var_03] <= 0) {
      var_04++;
    }
  }

  var_09 = var_04 / var_05.size;
  if(var_04 < var_02 || var_09 < 0) {
    if(var_04 < var_02) {
      var_01.var_2F7F[param_00] = 0;
    } else {
      var_01.var_2F7F[param_00] = 1;
    }

    var_01.var_565F[param_00] = 0;
  }
}

lib_050C::func_2936() {
  if(getdvarint("spawning_revised_frontline") == 0) {
    return 0;
  }

  if(level.var_3FDC != "war" && level.var_3FDC != "conf" && level.var_3FDC != "cranked") {
    return 0;
  }

  if(maps\mp\_utility::func_4571() != "mp_d_day") {
    return 0;
  }

  return 1;
}

lib_050C::func_4500() {
  if(!isDefined(level.var_3EF3)) {
    level.var_3EF3 = spawnStruct();
    level.var_3EF3.var_565F = [];
    level.var_3EF3.var_565F["allies"] = 0;
    level.var_3EF3.var_565F["axis"] = 0;
    level.var_3EF3.var_A1C7 = 0;
    level.var_3EF3.var_32D2 = 0;
    level.var_3EF3.var_5B9D = 0;
    level.var_3EF3.var_530B = undefined;
    level.var_3EF3.var_9A9D = "none";
    level.var_3EF3.var_3C62 = 1;
  }

  return level.var_3EF3;
}

lib_050C::func_4572() {
  if(!isDefined(level.var_3EF4)) {
    level.var_3EF4 = spawnStruct();
    var_00 = getEntArray("minimap_corner", "targetname");
    level.var_3EF4.var_5FEB = lib_050D::func_3B89(var_00[0].var_0116, var_00[1].var_0116);
    level.var_3EF4.var_014F = 500;
    level.var_3EF4.var_60A8 = 20;
    level.var_3EF4.var_6224 = -20;
    level.var_3EF4.var_3D70 = 50;
    level.var_3EF4.var_3D72 = -50;
    level.var_3EF4.var_3D75 = 850;
    level.var_3EF4.var_3D71 = 2500;
    level.var_3EF4.var_3D76 = 14000;
  }

  return level.var_3EF4;
}