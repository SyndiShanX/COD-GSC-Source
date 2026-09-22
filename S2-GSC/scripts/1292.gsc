/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1292.gsc
**************************************/

_id_534F() {
  var_0 = "mp/spawnConstantsPerMap.csv";
  var_1 = _tablegetcolumncount(var_0);

  for(var_2 = 1; var_2 < var_1; var_2++) {
    var_3 = tablelookup(var_0, 0, "spawn_constants", var_2);

    if(isDefined(var_3) && _id_57DA(var_3)) {
      var_4 = _id_468F(var_0, var_2);
      level._id_9036[var_3] = var_4;
      var_5 = tablelookup(var_0, 0, "save_squared_constant", var_2);

      if(isDefined(var_5) && var_5 == "TRUE") {
        level._id_9037[var_3] = _squared(var_4);
      }
    }
  }

  if(level.gametype == "ctf") {
    level._id_9036["allyDeathTime"] = 4000;
  }
}

_id_57DA(var_0) {
  switch (var_0) {
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

_id_468F(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, maps\mp\_utility::_id_4571(), var_1);

  if(!isDefined(var_2) || var_2 == "") {
    var_2 = tablelookup(var_0, 0, "mp_default", var_1);
  }

  return int(var_2);
}

delete(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = [[var_1]](var_2, var_3, var_4);
  } else {
    var_5 = [[var_1]](var_2, var_3);
  }

  var_5 = clamp(var_5, 0, 100);
  var_5 = var_5 * var_0;
  var_3._id_2B5E[var_3._id_2B5E.size] = var_5;
  var_3._id_9AB7 = var_3._id_9AB7 + 100 * var_0;
  return var_5;
}

_id_2857(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = [[var_0]](var_1, var_2, var_3);
  } else {
    var_4 = [[var_0]](var_1, var_2);
  }

  var_4 = clamp(var_4, 0, 100);
  var_2._id_2B4F[var_2._id_2B4F.size] = var_4;
  return var_4;
}

_id_1437(var_0, var_1) {
  foreach(var_3 in level._id_1FFD) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(distancesquared(var_1.origin, var_3.origin) < 2500) {
      return 0;
    }
  }

  return 100;
}

_id_1443(var_0, var_1) {
  foreach(var_3 in level._id_486C) {
    if(!isDefined(var_3) || !var_3 _id_56E4(self)) {
      continue;
    }
    if(distancesquared(var_1.origin, var_3.origin) < 65536) {
      return 0;
    }
  }

  return 100;
}

_id_1447(var_0, var_1) {
  var_2 = level._id_61ED;

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || !var_4 _id_56E4(self)) {
      continue;
    }
    if(distancesquared(var_1.origin, var_4.origin) < 65536) {
      return 0;
    }
  }

  return 100;
}

_id_56E4(var_0) {
  if(!level.teambased || level._id_3EC4 || isDefined(var_0) && !isDefined(var_0.team)) {
    return 1;
  }

  if(!isDefined(self._id_0117) || !isDefined(self._id_0117.team)) {
    return 1;
  }

  if(isDefined(var_0) && var_0 == self._id_0117) {
    return 1;
  }

  var_1 = self._id_0117.team;
  return var_1 != var_0.team;
}

_id_144D(var_0, var_1) {
  if(!isDefined(level.makeglobalusable)) {
    return 100;
  }

  if(!var_1._id_6C97) {
    return 100;
  }

  var_2 = _id_0526::_id_4675(var_1.origin);

  if(var_2 > 0.25) {
    return 0;
  }

  return 100;
}

_id_143A(var_0, var_1) {
  var_2 = _id_04D1::_id_44B9(var_0);

  if(var_1._id_266E[var_2] > 0) {
    return 0;
  }

  return 100;
}

_id_1442(var_0, var_1) {
  var_2 = _id_04D1::_id_44B9(var_0);

  if(var_1._id_3EFF[var_2] > 0) {
    return 0;
  }

  return 100;
}

_id_765F(var_0, var_1) {
  var_2 = maps\mp\_utility::getotherteam(var_0);

  if(getdvarint("disableSpawnClaim") || level._id_909B["preferClaimedSpawn"]["scoreFactorWeight"] == 0) {
    return 0;
  }

  if(!isDefined(level._id_9034)) {
    level._id_9034 = 0;
    var_3 = _id_050D::_id_44F9();
    var_4 = _id_050D::_id_46A0("allies");
    var_5 = _id_050D::_id_46A0("axis");

    foreach(var_7 in var_3) {
      var_8 = 9999999;

      foreach(var_10 in var_4) {
        var_11 = distance(var_7.origin, var_10.origin);

        if(var_11 < var_8) {
          var_8 = var_11;
        }
      }

      if(isDefined(var_7._id_0165) && var_7._id_0165 == "axis_override") {
        var_7._id_2BD3 = "axis";
        continue;
      }

      if(isDefined(var_7._id_0165) && var_7._id_0165 == "allies_override") {
        var_7._id_2BD3 = "allies";
        continue;
      }

      var_7._id_2BD3 = "allies";

      foreach(var_14 in var_5) {
        var_15 = distance(var_7.origin, var_14.origin);

        if(var_15 < var_8 / 2) {
          var_7._id_2BD3 = "axis";
          break;
        } else if(var_15 <= var_8 * 2)
          var_7._id_2BD3 = "none";
      }
    }
  }

  if(level._id_9034) {
    var_18 = maps\mp\_utility::getotherteam(var_0);
  } else {
    var_18 = var_0;
  }

  if(var_1._id_2BD3 == var_18) {
    return 100;
  }

  return 0;
}

_id_10DE(var_0, var_1) {
  if(_id_2936() && isDefined(var_1._id_3EF5) && level._id_3EF3._id_565F[self.team] && var_1._id_3EF5 != self.team) {
    return 0;
  }

  return 100;
}

_id_1451(var_0, var_1) {
  if(_positionwouldtelefrag(var_1.origin)) {
    foreach(var_3 in var_1._id_0CAD) {
      if(!_positionwouldtelefrag(var_3)) {
        break;
      }
    }

    return 0;
  }

  return 100;
}

_id_144C(var_0, var_1) {
  if(isDefined(self._id_5BE0) && self._id_5BE0 == var_1) {
    return 0;
  }

  return 100;
}

_id_144A(var_0, var_1) {
  if(isDefined(var_1._id_5BE2)) {
    var_2 = gettime() - var_1._id_5BE2;

    if(var_2 > 4000) {
      return 100;
    }

    return var_2 / 4000 * 100;
  }

  return 100;
}

_id_143E(var_0, var_1) {
  if(isDefined(var_1._id_5BE1) && (!level.teambased || var_1._id_5BE1 != var_0)) {
    var_2 = var_1._id_5BE2 + 500;

    if(gettime() < var_2) {
      return 0;
    }
  }

  return 100;
}

_id_1438(var_0, var_1) {
  var_2 = _id_3B92(var_0, var_1, 1);

  if(isDefined(var_2)) {
    var_3 = var_2 / level._id_9037["enemySpawnAreaDistance"];
    return var_3 * 100;
  }

  return 100;
}

_id_3B92(var_0, var_1, var_2) {
  var_3 = maps\mp\_utility::getotherteam(var_0);

  if(!level.teambased) {
    var_0 = "all";
    var_3 = "all";
  }

  if(!isDefined(level._id_7AD4[var_3])) {
    return undefined;
  }

  var_4 = [];
  var_5 = 99999999;
  var_6 = 0;

  foreach(var_8 in level._id_7AD4[var_3]) {
    var_9 = gettime() - var_8["time"];

    if(var_9 > level._id_9036["enemySpawnAreaTime"]) {
      continue;
    }
    var_4[var_4.size] = var_8;
    var_10 = distancesquared(var_1.origin, var_8["position"]);

    if(var_2 && var_10 > level._id_9037["enemySpawnAreaDistance"] || !level.teambased && var_8["player"] == self.guid) {
      continue;
    }
    if(var_10 < var_5) {
      var_5 = var_10;
      var_6 = 1;
    }
  }

  if(var_6) {
    return var_5;
  } else {
    return undefined;
  }
}

_id_1450(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = distancesquared(var_1.origin, var_2["position"]);
  var_4 = var_3 / level._id_9037["enemySpawnAreaDistance"];
  return var_4 * 100;
}

_id_143F(var_0, var_1) {
  var_2 = level._id_909B["avoidEnemySpawnLocations"]["scoreFactorWeight"];
  var_3 = maps\mp\_utility::getotherteam(var_0);

  if(!level.teambased) {
    var_0 = "all";
    var_3 = "all";
  }

  var_4 = 0;
  var_5 = [];

  foreach(var_7 in level._id_7AD4[var_3]) {
    var_8 = gettime() - var_7["time"];

    if(var_8 > level._id_9036["enemySpawnAreaTime"]) {
      continue;
    }
    var_5[var_5.size] = var_7;

    if(level.teambased || var_7["player"] != self.guid) {
      var_4 = var_4 + delete(var_2, ::_id_1450, var_0, var_1, var_7);
    }
  }

  level._id_7AD4[var_3] = var_5;
  return var_4;
}

_id_144F(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2.origin, var_1.origin);

  if(var_3 < 692224) {
    return 0;
  }

  return 100;
}

_id_144E(var_0, var_1, var_2) {
  return _id_144F(var_0, var_1, maps\mp\gametypes\hp::_id_4484());
}

_id_68A3(var_0, var_1) {
  if(!isDefined(var_1._id_9849) || var_1._id_9849 == "none" || var_0 == var_1._id_9849) {
    return 100;
  } else {
    return 0;
  }
}

_id_1446(var_0, var_1) {
  if(!isDefined(self._id_5B90)) {
    return 100;
  }

  var_2 = distancesquared(var_1.origin, self._id_5B90);

  if(var_2 > 4000000) {
    return 100;
  }

  var_3 = var_2 / 4000000;
  return var_3 * 100;
}

_id_7664(var_0, var_1) {
  if(!isDefined(self._id_5B90)) {
    return 0;
  }

  var_2 = distancesquared(var_1.origin, self._id_5B90);

  if(var_2 > 400000000) {
    return 0;
  }

  var_3 = 1 - var_2 / 400000000;
  return var_3 * 100;
}

_id_1439(var_0, var_1) {
  var_2 = _id_3B91(var_0, var_1, 1);

  if(isDefined(var_2)) {
    var_3 = var_2 / level._id_9037["allyDeathDistance"];
    return var_3 * 100;
  }

  return 100;
}

_id_3B91(var_0, var_1, var_2) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level._id_7AD1[var_0])) {
    return undefined;
  }

  var_3 = [];
  var_4 = 99999999;
  var_5 = 0;

  foreach(var_7 in level._id_7AD1[var_0]) {
    var_8 = gettime() - var_7["time"];

    if(var_8 > level._id_9036["allyDeathTime"]) {
      continue;
    }
    var_3[var_3.size] = var_7;
    var_9 = distancesquared(var_1.origin, var_7["position"]);

    if(var_2 && var_9 > level._id_9037["allyDeathDistance"] || !level.teambased && var_7["player"] != self.guid) {
      continue;
    }
    if(var_9 < var_4) {
      var_4 = var_9;
      var_5 = 1;
    }
  }

  level._id_7AD1[var_0] = var_3;

  if(var_5) {
    return var_4;
  } else {
    return undefined;
  }
}

_id_143B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = distancesquared(var_1.origin, var_2["position"]);
  var_4 = var_3 / level._id_9037["allyDeathDistance"];
  return var_4 * 100;
}

_id_1435(var_0, var_1) {
  var_2 = level._id_909B["avoidAllyDeathLocations"]["scoreFactorWeight"];

  if(!level.teambased) {
    var_0 = "all";
  }

  var_3 = 0;
  var_4 = [];

  foreach(var_6 in level._id_7AD1[var_0]) {
    var_7 = gettime() - var_6["time"];

    if(var_7 > level._id_9036["allyDeathTime"]) {
      continue;
    }
    var_4[var_4.size] = var_6;

    if(level.teambased || var_6["player"] == self.guid) {
      var_3 = var_3 + delete(var_2, ::_id_143B, var_0, var_1, var_6);
    }
  }

  level._id_7AD1[var_0] = var_4;
  return var_3;
}

_id_1445(var_0, var_1) {
  if(!isDefined(self._id_00E6) || !isDefined(self._id_00E6.origin)) {
    return 100;
  }

  if(!maps\mp\_utility::isreallyalive(self._id_00E6)) {
    return 100;
  }

  var_2 = distancesquared(var_1.origin, self._id_00E6.origin);

  if(var_2 > 4000000) {
    return 100;
  }

  var_3 = var_2 / 4000000;
  return var_3 * 100;
}

_id_765D(var_0, var_1) {
  var_2 = _func_393(var_1._id_00D4, var_0);

  if(var_2 == 0) {
    return 0;
  }

  var_3 = _func_392(var_1._id_00D4, var_0);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3 = var_3 / var_2;
  var_3 = _min(var_3, level._id_9036["enemyDistance"]);
  var_4 = 1 - var_3 / level._id_9036["enemyDistance"];
  return var_4 * 100;
}

_id_7660(var_0, var_1) {
  if(_func_393(var_1._id_00D4, var_0) == 0) {
    return 0;
  }

  var_2 = _func_391(var_1._id_00D4, var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = 1 - var_2 / level._id_9036["allyDistance"];
  return var_3 * 100;
}

_id_AAFF(var_0, var_1) {
  var_2 = _id_04D1::_id_44B9(var_0);

  if(_func_393(var_1._id_00D4, var_2) == 0) {
    return 100;
  }

  var_3 = _func_391(var_1._id_00D4, var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = var_3 / level._id_9036["enemyDistance"];
  return var_4 * 100;
}

_id_7669(var_0, var_1, var_2) {
  var_3 = _func_396(var_1._id_00D4, var_2 getentitynumber());

  if(!isDefined(var_3) || !maps\mp\_utility::isreallyalive(var_2)) {
    return 100;
  }

  var_4 = 1 - var_3 / level._id_9036["allyDistance"];
  return var_4 * 100;
}

_id_1449(var_0, var_1, var_2) {
  var_3 = _func_396(var_1._id_00D4, var_2 getentitynumber());

  if(!isDefined(var_3) || !maps\mp\_utility::isreallyalive(var_2)) {
    return 100;
  }

  var_4 = var_3 / level._id_9036["enemyDistance"];
  return var_4 * 100;
}

_id_143C(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  if(isDefined(level._id_909B["avoidEnemies"])) {
    var_2 = level._id_909B["avoidEnemies"]["scoreFactorWeight"];
  }

  if(isDefined(level._id_909B["preferAllies"])) {
    var_3 = level._id_909B["preferAllies"]["scoreFactorWeight"];
  }

  var_4 = 0;

  if(isDefined(var_0)) {
    foreach(var_6 in level.players) {
      if(!isDefined(var_6) || !isDefined(var_6.team) || var_6 == self || _func_2D5(var_6) == "spectator") {
        continue;
      } else {
        if((level.teambased && var_6.team != var_0 || !level.teambased) && var_2 > 0) {
          var_4 = var_4 + delete(var_2, ::_id_1449, var_0, var_1, var_6);
          continue;
        }

        if(level.teambased && var_6.team == var_0 && var_3 > 0) {
          var_4 = var_4 + delete(var_3, ::_id_7669, var_0, var_1, var_6);
        }
      }
    }
  }

  return var_4;
}

_id_7663(var_0, var_1) {
  if(var_1._id_3767 > 0) {
    var_2 = var_1._id_3ED2 / var_1._id_3767 / var_1._id_3ED1._id_4D3F * 1.33;
  } else {
    var_2 = 0;
  }

  return var_2 * 100;
}

_id_7662(var_0, var_1) {
  if(var_1._id_3767 > 0 && var_1._id_3ED1._id_645F > 0) {
    var_2 = var_1._id_3767 / var_1._id_3ED1._id_645F;
  } else {
    var_2 = 0;
  }

  return var_2 * 100;
}

_id_7661(var_0, var_1) {
  if(var_0 == "allies" && level._id_0BF7 == 0 || var_0 == "axis" && level._id_147E == 0) {
    return 0;
  } else {
    return _id_7662(var_0, var_1);
  }
}

_id_1441(var_0, var_1) {
  if(var_1._id_3ED2 > level._id_9037["CTFBaseDistance"]) {
    return 100;
  }

  var_2 = var_1._id_3ED2 / level._id_9037["CTFBaseDistance"];
  return var_2 * 100;
}

_id_1440(var_0, var_1) {
  if(var_0 == "allies" && level._id_0BF7 == 0 || var_0 == "axis" && level._id_147E == 0) {
    return _id_1441(var_0, var_1);
  } else {
    return 0;
  }
}

_id_765E(var_0, var_1) {
  var_2 = maps\mp\gametypes\dom::_id_4638(var_0);

  if(isDefined(var_1._id_766F) && var_2[var_1._id_766F]) {
    return 100;
  }

  return 0;
}

_id_143D(var_0, var_1) {
  var_2 = maps\mp\gametypes\dom::_id_4638(maps\mp\_utility::getotherteam(var_0));

  if(!isDefined(var_1._id_766F) || !var_2[var_1._id_766F]) {
    return 100;
  }

  var_3 = distancesquared(var_1.origin, maps\mp\gametypes\dom::_id_44E1(var_1._id_766F));
  var_4 = var_3 / level._id_9037["DOMPointTooCloseDistance"];
  return 100 * var_4;
}

_id_7676(var_0, var_1) {
  if(!isDefined(level._id_321C) || !isDefined(level._id_321C[var_0])) {
    return 0;
  }

  var_2 = gettime() - level._id_321C[var_0]["time"];

  if(var_2 > level._id_9036["DOMPointPerferLastTeamSpawnTime"]) {
    level._id_321C[var_0] = undefined;
    return 0;
  }

  if(isDefined(var_1._id_766F) && var_1._id_766F == level._id_321C[var_0]["flag"]) {
    return 100;
  }

  return 0;
}

_id_7A5E(var_0, var_1) {
  return _randomintrange(0, 99);
}

_id_7667(var_0, var_1) {
  var_2 = maps\mp\gametypes\hp::_id_4484();
  var_3 = distancesquared(var_2.origin, var_1.origin);
  var_4 = var_3 - 692224;
  var_5 = 6067776;
  var_6 = 1867776;

  if(var_4 >= var_6) {
    return 100 * (1.0 - 0.25 * (var_4 - var_6) / (var_5 - var_6));
  } else if(var_4 > 0) {
    return 100.0 * (var_4 / var_6);
  } else {
    return 0;
  }
}

_id_1452(var_0, var_1) {
  var_2 = maps\mp\gametypes\hp::_id_4484();
  var_3 = distancesquared(var_2.origin, var_1.origin);

  if(var_3 <= level._id_9037["HPZoneTooCloseDistance"]) {
    return 0;
  } else {
    return 100;
  }
}

_id_7666(var_0, var_1) {
  var_2 = maps\mp\gametypes\hp::_id_4484();
  var_3 = distancesquared(var_2.origin, var_1.origin);

  if(var_3 >= level._id_9037["HPZoneNearDistance"]) {
    return 0;
  }

  var_4 = 1 - var_3 / level._id_9037["HPZoneNearDistance"];
  return var_4 * 100;
}

avoidveryclosetorelic(var_0, var_1) {
  var_2 = level._id_1562[0]._id_28D4;
  var_3 = distancesquared(var_2, var_1.origin);

  if(var_3 <= level._id_9037["HPZoneTooCloseDistance"]) {
    return 0;
  } else {
    return 100;
  }
}

prefernearrelic(var_0, var_1) {
  var_2 = level._id_1562[0]._id_28D4;
  var_3 = distancesquared(var_2, var_1.origin);

  if(var_3 >= level._id_9037["HPZoneNearDistance"]) {
    return 0;
  }

  var_4 = 1 - var_3 / level._id_9037["HPZoneNearDistance"];
  return var_4 * 100;
}

_id_7668(var_0, var_1) {
  var_2 = maps\mp\_utility::getotherteam(var_0);
  var_3 = _func_394(var_1._id_00D4, var_0);
  var_4 = _func_395(var_1._id_00D4, var_2);

  if(var_3 == 0) {
    return 0;
  }

  if(var_4 == 0) {
    return 100;
  }

  var_5 = var_3 - var_4;

  if(var_5 <= 0) {
    return 0;
  }

  if(var_5 == 1) {
    return 35.0;
  }

  if(var_5 >= 2) {
    return 50.0;
  }

  return 0;
}

_id_AB32(var_0, var_1) {
  if(!isDefined(var_1._id_0165)) {
    return 100;
  }

  if(isDefined(level.zombies_active_spawn_event)) {
    var_2 = "zombie_event_spawn_" + level.zombies_active_spawn_event;

    if(isDefined(var_1.targetname) && var_1.targetname == var_2) {
      return 100;
    }
  }

  if(isDefined(level._id_1F1D) && ![[level._id_1F1D]](var_1._id_0165)) {
    return 0;
  }

  if(isDefined(level._id_AC88) && [[level._id_AC88]](var_1._id_0165)) {
    return 0;
  }

  return 100;
}

_id_AB3F(var_0, var_1) {
  if(!isDefined(level._id_A24A) || !level._id_A24A) {
    return 0;
  }

  if(!isDefined(self._id_5B90) || !isDefined(level._id_4200) || !isDefined(level._id_43F2)) {
    return 100;
  }

  var_2 = [[level._id_4200]](self._id_5B90);

  if(!isDefined(var_2)) {
    return 100;
  }

  var_3 = [[level._id_43F2]](var_2, var_1._id_0165);

  if(var_3 < 0) {
    return 0;
  }

  if(var_3 == 0) {
    return 100;
  }

  return 100 / var_3;
}

_id_AB40(var_0, var_1) {
  if(isDefined(level._id_A24A) && level._id_A24A) {
    return 0;
  }

  if(!isDefined(level._id_AC88)) {
    return 0;
  }

  if(!isDefined(self._id_5B90) || !isDefined(level._id_4200) || !isDefined(level._id_43F4)) {
    return 100;
  }

  var_2 = [[level._id_4200]](self._id_5B90);

  if(!isDefined(var_2)) {
    return 100;
  }

  var_3 = [[level._id_43F4]](var_2, var_1._id_0165);

  if(var_3 < 0) {
    return 0;
  }

  if(var_3 == 0) {
    return 100;
  }

  return 100 / var_3;
}

_id_AB41(var_0, var_1) {
  if(!isDefined(self._id_5B90)) {
    return 0;
  }

  var_2 = distance(var_1.origin, self._id_5B90);

  if(var_2 >= 2500 || var_2 <= 500) {
    return 0;
  }

  var_3 = max(0.0, 1.0 - _abs(1500 - var_2) / 1000);
  return var_3 * 100;
}

_id_A119(var_0) {
  if(!_id_A11B()) {
    return;
  }
  _id_7FA2(var_0);
  _id_A11A();
}

_id_A11B() {
  if(!_id_2936()) {
    return 0;
  }

  var_0 = _id_4500();
  var_1 = _id_4572();
  var_2 = gettime();

  if(!isDefined(var_0._id_5C09)) {
    var_0._id_5C09 = var_2;
  } else if(var_0._id_565F["allies"] && var_0._id_565F["axis"]) {
    var_0._id_A1C7 = var_0._id_A1C7 + var_0._id_5C0A;
  } else {
    var_0._id_32D2 = var_0._id_32D2 + var_0._id_5C0A;
  }

  var_3 = (var_2 - var_0._id_5C09) / 1000.0;
  var_0._id_5C09 = var_2;
  var_0._id_5C0A = var_3;
  var_4 = _id_44F2("allies");

  if(!isDefined(var_4)) {
    return 0;
  }

  var_4 = (var_4[0], var_4[1], 0);
  var_0._id_0BF3 = var_4;
  var_5 = _id_44F2("axis");

  if(!isDefined(var_5)) {
    return 0;
  }

  var_5 = (var_5[0], var_5[1], 0);
  var_0._id_1479 = var_5;
  var_6 = var_5 - var_4;
  var_7 = _vectortoyaw(var_6);
  var_8 = var_4 + var_6 * 0.5;

  if(var_7 > 180) {
    var_7 = var_7 - 360;
  } else if(var_7 < -180) {
    var_7 = 360 + var_7;
  }

  var_0._id_5030 = var_8;
  var_0._id_5031 = var_7;
  var_9 = common_scripts\utility::_id_98E7(var_0._id_9A9D == "allies", "axis", "allies");
  var_10 = common_scripts\utility::_id_98E7(var_0._id_9A9D == "allies", var_4, var_5);
  var_11 = common_scripts\utility::_id_98E7(var_9 == "allies", var_4, var_5);
  var_12 = _distance2dsquared(var_11, (var_1._id_5FEB[0] - var_1._id_3D75, var_1._id_5FEB[1], var_8[2])) < _distance2dsquared(var_10, (var_1._id_5FEB[0] - var_1._id_3D75, var_1._id_5FEB[1], var_8[2]));
  var_13 = _distance2dsquared(var_11, (var_1._id_5FEB[0] + var_1._id_3D75, var_1._id_5FEB[1], var_8[2])) > _distance2dsquared(var_10, (var_1._id_5FEB[0] + var_1._id_3D75, var_1._id_5FEB[1], var_8[2]));
  var_14 = 0;
  var_2 = gettime();

  if(var_2 > var_0._id_5B9D + var_1._id_3D76) {
    if(var_7 < var_1._id_3D72 && var_7 > -180 - var_1._id_3D72 || var_7 > var_1._id_3D70 && var_7 < 180 - var_1._id_3D70 || _distance2d(var_1._id_5FEB, var_8) > var_1._id_3D75 || var_13 || var_12) {
      if(isDefined(var_0._id_530B)) {
        if(var_2 > var_0._id_530B + var_1._id_3D71) {
          if(var_13 || var_12) {
            var_14 = 1;
            var_0._id_5B9D = var_2;
            var_0._id_9A9D = var_9;
            level._id_90A2 = 1;
          }

          var_0._id_530B = undefined;
        }
      } else
        var_0._id_530B = var_2;
    } else
      var_0._id_530B = undefined;
  } else
    var_0._id_530B = undefined;

  var_15 = clamp(var_8[0], var_1._id_5FEB[0] - var_1.radius, var_1._id_5FEB[0] + var_1.radius);
  var_16 = var_1._id_5FEB[1];
  var_8 = (var_15, var_16, var_8[2]);
  var_17 = 1 - _abs((var_8[0] - var_1._id_5FEB[0]) / var_1.radius);
  var_18 = 0;

  if(var_7 < var_1._id_6224 * var_17 && var_7 > -180 - var_1._id_6224 * var_17) {
    if(var_7 >= -90) {
      var_7 = clamp(var_7, var_1._id_6224 * var_17, 0);
    } else {
      var_7 = clamp(-1 * var_7, 0, var_1._id_60A8 * var_17) + 180;
      var_18 = 1;
    }
  } else if(var_7 < var_1._id_6224 * var_17)
    var_18 = 1;
  else if(var_7 > var_1._id_60A8 * var_17 && var_7 < 180 - var_1._id_60A8 * var_17) {
    if(var_7 <= 90) {
      var_7 = clamp(var_7, 0, var_1._id_60A8 * var_17);
    } else {
      var_7 = clamp(-1 * var_7, var_1._id_6224 * var_17, 0) - 180;
      var_18 = 1;
    }
  } else if(var_7 > var_1._id_60A8 * var_17)
    var_18 = 1;

  if(!isDefined(var_0._id_9851) || !var_0._id_565F["allies"] || !var_0._id_565F["axis"]) {
    var_0._id_9851 = var_7;
  }

  var_0._id_9851 = var_7;

  if(!isDefined(var_0._id_6162) || !var_0._id_565F["allies"] || !var_0._id_565F["axis"]) {
    var_0._id_6162 = var_8;
  }

  var_19 = var_8 - var_0._id_6162;
  var_20 = _length2d(var_19);
  var_21 = _min(var_20, 40.0 * var_3);

  if(var_21 > 0) {
    var_19 = var_19 * (var_21 / var_20);
    var_0._id_6162 = var_0._id_6162 + var_19;
  }

  var_22 = anglesToForward((0, var_0._id_9851, 0));

  if(var_0._id_3C62) {
    var_0._id_5B9D = gettime();
    var_23 = var_0._id_6162 - var_0._id_0BF3;
    var_24 = vectordot(var_23, var_22);
    var_0._id_9A9D = common_scripts\utility::_id_98E7(var_24 > 0, "allies", "axis");
    var_0._id_3C62 = 0;
  }

  var_25 = level._id_908B;
  var_25 = _id_050D::_id_44F9();

  foreach(var_27 in var_25) {
    var_28 = undefined;
    var_29 = var_0._id_6162 - var_27.origin;
    var_24 = vectordot(vectorNormalize(var_29), vectorNormalize(var_22));

    if(var_0._id_9A9D == "allies" && var_24 > 0 || var_0._id_9A9D != "allies" && var_24 <= 0) {
      if(!var_18) {
        var_28 = "allies";
      } else {
        var_28 = "axis";
      }

      var_27._id_3EF5 = var_28;
      continue;
    }

    if(!var_18) {
      var_28 = "axis";
    } else {
      var_28 = "allies";
    }

    var_27._id_3EF5 = var_28;
  }

  return 1;
}

_id_A11A() {
  var_0 = isDefined(level._id_602E) && isDefined(level._id_602D);
  var_1 = 0;

  if(!var_0 && !var_1) {
    return;
  }
  var_2 = _id_4500();

  if(!isDefined(var_2._id_5E94) && isDefined(level._id_602D)) {
    var_2._id_5E94 = [];
    var_2._id_5E94["line"] = [[level._id_602D]]();
    var_2._id_5E94["alliesCenter"] = [[level._id_602D]]();
    var_2._id_5E94["axisCenter"] = [[level._id_602D]]();
  }

  if(!var_2._id_565F["allies"] && !var_2._id_565F["axis"]) {
    return;
  }
  var_3 = (var_2._id_6162[0], var_2._id_6162[1], level._id_5FEB[2]);
  var_4 = anglestoright((0, var_2._id_9851, 0));
  var_5 = var_3 + var_4 * 5000;
  var_6 = var_3 - var_4 * 5000;

  if(isDefined(level._id_602E)) {
    var_7 = undefined;

    if(var_2._id_565F["allies"] && var_2._id_565F["axis"]) {
      var_7 = "FRONT_LINE";
    } else {
      var_7 = common_scripts\utility::_id_98E7(var_2._id_565F["allies"], "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level._id_602E]](var_2._id_5E94["line"], "allies", var_7, var_5[0], var_5[1], gettime(), undefined, var_6[0], var_6[1]);
  }

  if(isDefined(level._id_602E)) {
    var_8 = common_scripts\utility::_id_98E7(var_2._id_565F["axis"], var_2._id_1479, (10000, 10000, 10000));
    [[level._id_602E]](var_2._id_5E94["axisCenter"], "axis", "ANCHOR", var_8[0], var_8[1], gettime());
    var_9 = common_scripts\utility::_id_98E7(var_2._id_565F["allies"], var_2._id_0BF3, (10000, 10000, 10000));
    [[level._id_602E]](var_2._id_5E94["alliesCenter"], "allies", "ANCHOR", var_9[0], var_9[1], gettime());
  }
}

_id_44F2(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_3)) {
      continue;
    }
    if(var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = maps\mp\_utility::getaverageorigin(var_1);
  return var_5;
}

_id_7FA2(var_0) {
  if(!_id_2936()) {
    return;
  }
  var_1 = _id_4500();
  var_1._id_565F[var_0] = 1;

  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }
  var_2 = getdvarint("scr_frontline_min_spawns", 0);

  if(var_2 == 0) {
    var_2 = 4;
  }

  var_3 = maps\mp\_utility::getotherteam(var_0);
  var_4 = 0;
  var_5 = level._id_908B;
  var_5 = _id_050D::_id_44F9();

  foreach(var_7 in var_5) {
    if(!isDefined(var_7._id_3EF5) || var_7._id_3EF5 != var_0) {
      continue;
    }
    if(!isDefined(var_7._id_3EFF) || !isDefined(var_7._id_3EFF[var_3]) || var_7._id_3EFF[var_3] <= 0) {
      var_4++;
    }
  }

  var_9 = var_4 / var_5.size;

  if(var_4 < var_2 || var_9 < 0.0) {
    if(var_4 < var_2) {
      var_1._id_2F7F[var_0] = 0;
    } else {
      var_1._id_2F7F[var_0] = 1;
    }

    var_1._id_565F[var_0] = 0;
  }
}

_id_2936() {
  if(getdvarint("spawning_revised_frontline") == 0) {
    return 0;
  }

  if(level.gametype != "war" && level.gametype != "conf" && level.gametype != "cranked") {
    return 0;
  }

  if(maps\mp\_utility::_id_4571() != "mp_d_day") {
    return 0;
  }

  return 1;
}

_id_4500() {
  if(!isDefined(level._id_3EF3)) {
    level._id_3EF3 = spawnStruct();
    level._id_3EF3._id_565F = [];
    level._id_3EF3._id_565F["allies"] = 0;
    level._id_3EF3._id_565F["axis"] = 0;
    level._id_3EF3._id_A1C7 = 0.0;
    level._id_3EF3._id_32D2 = 0.0;
    level._id_3EF3._id_5B9D = 0.0;
    level._id_3EF3._id_530B = undefined;
    level._id_3EF3._id_9A9D = "none";
    level._id_3EF3._id_3C62 = 1;
  }

  return level._id_3EF3;
}

_id_4572() {
  if(!isDefined(level._id_3EF4)) {
    level._id_3EF4 = spawnStruct();
    var_0 = getEntArray("minimap_corner", "targetname");
    level._id_3EF4._id_5FEB = _id_050D::_id_3B89(var_0[0].origin, var_0[1].origin);
    level._id_3EF4.radius = 500;
    level._id_3EF4._id_60A8 = 20;
    level._id_3EF4._id_6224 = -20;
    level._id_3EF4._id_3D70 = 50;
    level._id_3EF4._id_3D72 = -50;
    level._id_3EF4._id_3D75 = 850;
    level._id_3EF4._id_3D71 = 2500;
    level._id_3EF4._id_3D76 = 14000;
  }

  return level._id_3EF4;
}