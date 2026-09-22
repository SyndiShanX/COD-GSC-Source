/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1294.gsc
**************************************/

_id_5350() {
  level._id_909C["TDM"] = "mp/spawnScoreFactorsPerMap_TDM.csv";
  level._id_909C["DOM"] = "mp/spawnScoreFactorsPerMap_DOM.csv";
  level._id_909C["HP"] = "mp/spawnScoreFactorsPerMap_HP.csv";
  level._id_909C["CTF"] = "mp/spawnScoreFactorsPerMap_CTF.csv";
  level._id_909C["FFA"] = "mp/spawnScoreFactorsPerMap_FFA.csv";
  level._id_909C["UPLINK"] = "mp/spawnScoreFactorsPerMap_UPLINK.csv";
  level._id_909C["DEFAULT"] = "mp/spawnScoreFactorsPerMap_DEFAULT.csv";
  level._id_909C["ZOMBIES"] = "mp/spawnScoreFactorsPerMap_ZOMBIES.csv";
  level._id_909C["ZOMBIES_NPC"] = "mp/spawnScoreFactorsPerMap_ZOMBIES_NPC.csv";
  level._id_909C["RAIDS"] = "mp/spawnScoreFactorsPerMap_RAIDS.csv";
  level._id_909C["RELIC"] = "mp/spawnScoreFactorsPerMap_RELIC.csv";
  level._id_909C["UNDEAD"] = "mp/spawnScoreFactorsPerMap_UNDEAD.csv";
  level._id_909B = _id_4698(1);
  level._id_909D = _id_4698(2);
  level._id_903A = _id_4690(3);
  level._id_903B = _id_4690(4);

  if(getdvarint("spawning_revised_frontline") != 0 && level.gametype == "war") {
    level._id_909B["preferClaimedSpawn"]["scoreFactorWeight"] = 0.0;
  }

  if(maps\mp\_utility::_id_56B1() && level.gametype == "dom") {
    level._id_909B["preferAllyDomPoints"]["scoreFactorWeight"] = 1.0;
    level._id_909B["preferTeamLastSpawnDOMPoint"]["scoreFactorWeight"] = 1.5;
    level._id_909B["avoidEnemies"]["scoreFactorWeight"] = 1.1;
    level._id_909B["avoidAllyDeathLocations"]["scoreFactorWeight"] = 1.0;
  }

  level._id_909A["avoidEnemies"] = _id_050C::_id_143C;
  level._id_909A["preferAllies"] = undefined;
  level._id_909A["avoidAllyDeathLocations"] = _id_050C::_id_1435;
  level._id_909A["avoidEnemySpawnLocations"] = _id_050C::_id_143F;
  level._id_909A["preferClaimedSpawn"] = _id_050C::_id_765F;
  level._id_909A["preferAllyDomPoints"] = _id_050C::_id_765E;
  level._id_909A["avoidEnemyDomPointsByDistance"] = _id_050C::_id_143D;
  level._id_909A["preferTeamLastSpawnDOMPoint"] = _id_050C::_id_7676;
  level._id_909A["avoidVeryCloseToHPZone"] = _id_050C::_id_1452;
  level._id_909A["preferNearHPZone"] = _id_050C::_id_7666;
  level._id_909A["avoidFriendlyFlagBaseByDistance"] = _id_050C::_id_1441;
  level._id_909A["avoidFriendlyCTFBaseByDistance"] = _id_050C::_id_1440;
  level._id_909A["preferForwardCTFSpawns"] = _id_050C::_id_7661;
  level._id_909A["zombiesPreferTombstoneByDistance"] = _id_050C::_id_AB41;
  level._id_909A["zombiesPreferShortZoneConnection"] = _id_050C::_id_AB3F;
  level._id_909A["zombiesPreferShortZoneConnectionNonInfected"] = _id_050C::_id_AB40;
  level._id_909A["raidsPreferLastDeathLocation"] = _id_050C::_id_7664;
  level._id_909A["avoidVeryCloseToRelic"] = _id_050C::avoidveryclosetorelic;
  level._id_909A["preferNearRelic"] = _id_050C::prefernearrelic;
  level._id_909A["randomSpawn"] = _id_050C::_id_7A5E;
  level._id_909A["avoidSameSpawn"] = _id_050C::_id_144C;
  level._id_909A["avoidRecentlyUsed"] = _id_050C::_id_144A;
  level._id_909A["avoidLastDeathLocation"] = _id_050C::_id_1446;
  level._id_909A["avoidLastAttackerLocation"] = _id_050C::_id_1445;
  level._id_909A["preferAllyCenterPointByDistance"] = _id_050C::_id_765D;
  level._id_909A["zombiesAvoidClosestEnemyByDistance"] = _id_050C::_id_AAFF;
  _id_09EC("avoidFullVisibleEnemies", _id_050C::_id_1442, 0);
  _id_09EC("avoidCornerVisibleEnemies", _id_050C::_id_143A, 1);
  _id_09EC("assignedViaFrontline", _id_050C::_id_10DE, 2);
  _id_09EC("obeyTeamAssignments", _id_050C::_id_68A3, 3);
  _id_09EC("avoidGrenades", _id_050C::_id_1443, 4);
  _id_09EC("avoidMines", _id_050C::_id_1447, 5);
  _id_09EC("avoidScorestreakLocations", _id_050C::_id_144D, 6);
  _id_09EC("avoidCarePackages", _id_050C::_id_1437, 7);
  _id_09EC("avoidTelefrag", _id_050C::_id_1451, 8);
  _id_09EC("avoidEnemySpawn", _id_050C::_id_143E, 9);
  _id_09EC("avoidSpawnInHPZone", _id_050C::_id_144E, 10);
  _id_09EC("zombiesIsInValidZone", _id_050C::_id_AB32, 11);
}

_id_57B9(var_0) {
  switch (var_0) {
    case "preferAllyCenterPointByDistance":
    case "avoidLastAttackerLocation":
    case "avoidLastDeathLocation":
    case "avoidRecentlyUsed":
    case "avoidSameSpawn":
    case "randomSpawn":
    case "preferNearRelic":
    case "avoidVeryCloseToRelic":
    case "zombiesAvoidClosestEnemyByDistance":
    case "raidsPreferLastDeathLocation":
    case "zombiesPreferShortZoneConnectionNonInfected":
    case "zombiesPreferShortZoneConnection":
    case "preferForwardCTFSpawns":
    case "zombiesPreferTombstoneByDistance":
    case "avoidFriendlyCTFBaseByDistance":
    case "preferNearHPZone":
    case "avoidVeryCloseToHPZone":
    case "avoidFriendlyFlagBaseByDistance":
    case "preferTeamLastSpawnDOMPoint":
    case "preferAllyDomPoints":
    case "preferClaimedSpawn":
    case "avoidEnemySpawnLocations":
    case "avoidAllyDeathLocations":
    case "preferAllies":
    case "avoidEnemies":
    case "avoidEnemyDomPointsByDistance":
      return 1;
    default:
      return 0;
  }
}

_id_3152(var_0) {
  switch (var_0) {
    case "avoidEnemySpawnLocations":
    case "avoidAllyDeathLocations":
    case "preferAllies":
    case "avoidEnemies":
      return 1;
    default:
      return 0;
  }
}

_id_09EC(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !_id_56BE(var_0) || !isDefined(var_2)) {}

  level._id_9039[var_0]["criticalFactorFunc"] = var_1;
  level._id_9039[var_0]["criticalFactorAnalyticsIndex"] = var_2;
}

_id_56BE(var_0) {
  switch (var_0) {
    case "zombiesIsInValidZone":
    case "avoidSpawnInHPZone":
    case "avoidEnemySpawn":
    case "avoidTelefrag":
    case "avoidCarePackages":
    case "avoidScorestreakLocations":
    case "avoidMines":
    case "avoidGrenades":
    case "obeyTeamAssignments":
    case "assignedViaFrontline":
    case "avoidCornerVisibleEnemies":
    case "avoidFullVisibleEnemies":
      return 1;
    default:
      return 0;
  }
}

_id_56BD(var_0) {
  switch (var_0) {
    case "SIDE_BASED":
    case "UNDEAD":
    case "RAIDS":
    case "ZOMBIES":
    case "DEFAULT":
    case "HP":
    case "TDM":
      return 1;
    default:
      return 0;
  }
}

_id_4698(var_0) {
  var_1 = [];
  var_2 = tablelookup("mp/spawnFactorsPerMode.csv", 0, level.gametype, var_0);

  if(!isDefined(var_2) || var_2 == "") {
    return var_1;
  }

  var_3 = level._id_909C[var_2];
  var_4 = _tablegetcolumncount(var_3);

  for(var_5 = 1; var_5 < var_4; var_5++) {
    var_6 = tablelookup(var_3, 0, "score_factors", var_5);

    if(isDefined(var_6) && _id_57B9(var_6)) {
      var_7 = _id_4670(var_3, var_5);
      var_1[var_6]["scoreFactorName"] = var_6;
      var_1[var_6]["scoreFactorWeight"] = var_7;
      continue;
    }

    if(!isDefined(var_6) || var_6 != maps\mp\_utility::no_obfuscate("ProductionLevel")) {}
  }

  return var_1;
}

_id_4670(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, maps\mp\_utility::_id_4571(), var_1);

  if(!isDefined(var_2) || var_2 == "") {
    var_2 = tablelookup(var_0, 0, "mp_default", var_1);
  }

  return _float(var_2);
}

_id_4690(var_0) {
  var_1 = [];
  var_2 = tablelookup("mp/spawnFactorsPerMode.csv", 0, level.gametype, var_0);

  if(!isDefined(var_2) || !_id_56BD(var_2)) {
    return var_1;
  }

  var_3 = "mp/spawnCriticalFactors.csv";

  if(getdvarint("spawning_revised_frontline") != 0) {
    var_3 = "mp/spawnCriticalFactors_EXPERIMENTAL.csv";
  }

  var_4 = _tablegetcolumncount(var_3);
  var_5 = -1;

  for(var_6 = 1; var_6 < var_4; var_6++) {
    if(var_2 == _tablelookupbyrow(var_3, 0, var_6)) {
      var_5 = var_6;
      break;
    }
  }

  var_7 = _tablegetrowcount(var_3);

  for(var_8 = 1; var_8 < var_7; var_8++) {
    var_9 = _tablelookupbyrow(var_3, var_8, 0);

    if(isDefined(var_9) && _id_56BE(var_9)) {
      var_10 = _tablelookupbyrow(var_3, var_8, var_5);

      if(isDefined(var_10) && (var_10 == "primary" || var_10 == "secondary" || var_10 == "bad")) {
        var_1[var_10][var_9]["criticalFactorName"] = var_9;
        var_1[var_10][var_9]["criticalFactorResult"] = var_10;
      }

      continue;
    }
  }

  return var_1;
}

_id_3890(var_0, var_1, var_2) {
  foreach(var_4 in var_2) {
    var_5 = var_4["criticalFactorName"];
    var_6 = var_4["criticalFactorResult"];
    var_7 = level._id_9039[var_5]["criticalFactorFunc"];

    if(isDefined(var_7)) {
      if(!_id_050C::_id_2857(var_7, var_0, var_1)) {
        return var_4;
      }
    }
  }

  return undefined;
}

_id_388F(var_0, var_1) {
  var_2 = level._id_903A;

  if(isDefined(level._id_746E) && var_0 != level._id_746E) {
    var_2 = level._id_903B;
  }

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = ["bad", "secondary", "primary"];

    foreach(var_5 in var_3) {
      if(isDefined(var_2[var_5]) && var_2[var_5].size > 0) {
        var_6 = _id_3890(var_0, var_1, var_2[var_5]);

        if(isDefined(var_6)) {
          return var_6;
        }
      }
    }
  }

  var_8 = [];
  var_8["criticalFactorName"] = "";
  var_8["criticalFactorResult"] = "primary";
  return var_8;
}

_id_3894(var_0, var_1, var_2) {
  foreach(var_4 in var_2) {
    var_5 = var_4["scoreFactorName"];
    var_6 = var_4["scoreFactorWeight"];
    var_7 = level._id_909A[var_5];

    if(isDefined(var_7)) {
      if(_id_3152(var_5)) {
        var_1._id_9AB8 = var_1._id_9AB8 + [[var_7]](var_0, var_1);
        continue;
      }

      var_1._id_9AB8 = var_1._id_9AB8 + _id_050C::delete(var_6, var_7, var_0, var_1);
    }
  }
}

_id_3893(var_0, var_1) {
  _id_3894(var_0, var_1, level._id_909B);
}

_id_3895(var_0, var_1) {
  _id_3894(var_0, var_1, level._id_909D);
}

_id_80AE(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2._id_6884 = var_1.size;
  }

  foreach(var_4 in var_1) {
    if(isDefined(level._id_746E) && var_0 != level._id_746E) {
      _id_3895(var_0, var_4);
      continue;
    }

    _id_3893(var_0, var_4);
  }
}

_id_4007(var_0, var_1, var_2, var_3) {
  var_4["primary"] = [];
  var_4["secondary"] = [];
  var_4["bad"] = [];

  if(!_id_050D::_id_580F()) {
    if(!isDefined(level._id_4B94)) {
      if(isDefined(level._id_602F)) {
        [[level._id_602F]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");
      }

      level._id_4B94 = 1;
    }

    if(getdvarint("3950", 0) == 1 && level.gametype != "zombies" && !maps\mp\_utility::_id_579B()) {
      _iprintlnbold("Spawning a player without any LOS data!");
    }
  }

  _id_050D::_id_A167();
  _id_050C::_id_A119(var_0);

  foreach(var_6 in var_1) {
    _id_534D(var_6);
    _id_050D::_id_3892(var_6, var_0);
    var_7 = _id_388F(var_0, var_6);
    var_6._id_285B = var_7["criticalFactorResult"];
    var_6._id_285A = var_7["criticalFactorName"];

    if(!isDefined(var_6._id_285A) || var_6._id_285A == "") {
      var_6._id_2859 = -1;
    } else {
      var_6._id_2859 = level._id_9039[var_6._id_285A]["criticalFactorAnalyticsIndex"];
    }

    var_4[var_6._id_285B][var_4[var_6._id_285B].size] = var_6;
  }

  if(var_1.size > 0) {
    var_2._id_90B3["primary"] = var_4["primary"].size / var_1.size;
    var_2._id_90B3["secondary"] = var_4["secondary"].size / var_1.size;
    var_2._id_90B3["bad"] = var_4["bad"].size / var_1.size;
  }

  if(var_4["primary"].size || var_3) {
    _id_80AE(var_0, var_4["primary"], var_2);
    var_2._id_0BD9 = 0;

    if(var_4["secondary"].size) {
      var_9 = var_4["primary"][0]._id_9AB8;

      foreach(var_6 in var_4["primary"]) {
        if(isDefined(var_6._id_9AB8) && var_6._id_9AB8 > var_9) {
          var_9 = var_6._id_9AB8;
        }
      }

      _id_80AE(var_0, var_4["secondary"], undefined);
      var_12 = 0;

      foreach(var_6 in var_4["secondary"]) {
        if(isDefined(var_6._id_9AB8) && var_6._id_9AB8 > var_9) {
          var_12++;
        }
      }

      var_2._id_689C = var_12;
    } else
      var_2._id_689C = -1;

    return var_4["primary"];
  } else if(var_4["secondary"].size) {
    _id_80AE(var_0, var_4["secondary"], var_2);
    var_2._id_0BD9 = 0;
    var_2._id_689C = -1;
    return var_4["secondary"];
  } else {
    _id_80AE(var_0, var_1, var_2);
    var_2._id_0BD9 = 1;
    var_2._id_689C = -1;
    return var_1;
  }
}

_id_909E(var_0, var_1) {
  return var_0._id_9AB8 > var_1._id_9AB8;
}

scragentsetgoalRadius(var_0, var_1, var_2, var_3) {
  var_4 = _id_4007(var_0, var_1, var_2, 0);

  foreach(var_6 in var_1) {
    if(isDefined(var_3) && var_3) {
      _id_050B::_id_7AF5(var_6);
    }
  }

  var_8 = [];
  var_8[var_8.size] = var_4[0];
  var_9 = -1;
  var_10 = [];
  var_11 = -2;

  foreach(var_6 in var_4) {
    if(isDefined(var_6._id_9AB8)) {
      if(var_6._id_9AB8 > var_9) {
        var_10 = var_8;
        var_11 = var_9;
        var_8 = [];
        var_8[var_8.size] = var_6;
        var_9 = var_6._id_9AB8;
        continue;
      }

      if(var_6._id_9AB8 == var_9) {
        var_8[var_8.size] = var_6;
        continue;
      }

      if(var_6._id_9AB8 > var_11) {
        var_10 = [];
        var_10[var_10.size] = var_6;
        var_11 = var_6._id_9AB8;
        continue;
      }

      if(var_6._id_9AB8 == var_11) {
        var_10[var_10.size] = var_6;
      }
    }
  }

  if(getdvarint("spawning_revised_fatique") != 0) {
    var_14 = undefined;
    var_15 = [];

    if(isDefined(var_2)) {
      if(isDefined(var_2._id_9087) && isDefined(var_2._id_9087.origin)) {
        var_14 = var_2._id_9087;
      }

      if(isDefined(var_2._id_3A5D)) {
        var_15 = var_2._id_3A5D;
      }
    }

    var_16 = 0;

    foreach(var_18 in var_15) {
      if(var_18["spawnCount"] >= 2 || var_18["spawnsSinceLastUsed"] > 0 && var_18["spawnsSinceLastUsed"] <= 2) {
        if(common_scripts\utility::_id_0F79(var_8, var_18["spawnPoint"])) {
          if(var_8.size > 1) {
            var_8 = common_scripts\utility::_id_0F93(var_8, var_18["spawnPoint"]);
          } else {
            var_16 = 1;
          }
        }

        if(common_scripts\utility::_id_0F79(var_10, var_18["spawnPoint"])) {
          var_10 = common_scripts\utility::_id_0F93(var_10, var_18["spawnPoint"]);
        }
      }
    }

    if(isDefined(var_14)) {
      if(var_8.size > 1 && common_scripts\utility::_id_0F79(var_8, var_14)) {
        var_8 = common_scripts\utility::_id_0F93(var_8, var_14);
      }

      if((var_10.size > 1 || !var_16) && common_scripts\utility::_id_0F79(var_10, var_14)) {
        var_10 = common_scripts\utility::_id_0F93(var_10, var_14);
      }
    }

    if(var_16 && var_10.size > 0) {
      if(var_9 > 0 && var_11 > 0 && var_11 / var_9 > 0.9) {
        var_20 = var_8[0];
        var_21 = [];

        foreach(var_6 in var_10) {
          if(_distance2d(var_6.origin, var_20.origin) <= 1300) {
            var_21[var_21.size] = var_6;
          }
        }

        if(var_21.size > 0) {
          var_8 = var_21;
        }
      }
    }
  }

  return common_scripts\utility::random(var_8);
}

_id_4706(var_0) {
  if(isDefined(var_0._id_0165)) {
    if(var_0._id_0165 == "primary_override") {
      return "primary";
    } else if(var_0._id_0165 == "secondary_override") {
      return "secondary";
    } else if(var_0._id_0165 == "tertiary_override") {
      return "tertiary";
    }
  }

  if(!isDefined(var_0._id_7702) || var_0._id_7702) {
    return "primary";
  } else {
    return "secondary";
  }
}

scragentsetanimscale(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    if(_id_4706(var_3) != "primary") {
      continue;
    }
    if(!_canspawn(var_3.origin) || _positionwouldtelefrag(var_3.origin)) {
      continue;
    }
    if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_3)) {
      continue;
    }
    var_1 = var_3;
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      if(_id_4706(var_3) != "secondary") {
        continue;
      }
      if(!_canspawn(var_3.origin) || _positionwouldtelefrag(var_3.origin)) {
        continue;
      }
      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_3)) {
        continue;
      }
      var_1 = var_3;
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      if(_id_4706(var_3) != "tertiary") {
        continue;
      }
      if(!_canspawn(var_3.origin) || _positionwouldtelefrag(var_3.origin)) {
        continue;
      }
      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_3)) {
        continue;
      }
      var_1 = var_3;
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      if(!_canspawn(var_3.origin) || _positionwouldtelefrag(var_3.origin)) {
        continue;
      }
      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_3)) {
        continue;
      }
      var_1 = var_3;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_0[0];
  }

  return var_1;
}

scragentsetgoalentity(var_0, var_1, var_2, var_3) {
  level._id_9068._id_9090 = var_1;

  if(isDefined(level._id_746E) && var_0 != level._id_746E) {
    return scragentsetgoalRadius(var_0, var_1, var_2, var_3);
  } else if(level._id_A239 && ((maps\mp\_utility::_id_585F() || level.teambased) && level.ingraceperiod || !level.teambased && maps\mp\_utility::gettimepassed() == 0)) {
    return scragentsetanimscale(var_1);
  } else {
    return scragentsetgoalRadius(var_0, var_1, var_2, var_3);
  }
}

_id_8BA2() {
  switch (level.gametype) {
    case "aon":
      return 1;
    case "ball":
      return 1;
    case "blades":
      return 1;
    case "conf":
      return 1;
    case "control":
      return 1;
    case "ctf":
      return 1;
    case "dm":
      return 1;
    case "dom":
      return 1;
    case "goliath":
      return 0;
    case "gun":
      return 1;
    case "hp":
      return 1;
    case "infect":
      return 1;
    case "lockdown":
      return 1;
    case "oitc":
      return 1;
    case "onevone":
      return 1;
    case "scorestreak_training":
      return 1;
    case "sd":
      return 0;
    case "sr":
      return 1;
    case "twar":
      return 1;
    case "relic":
      return 1;
    case "undead":
      return 1;
    case "war":
      return 1;
    case "assault":
      return 1;
    case "air":
      return 1;
    case "aces":
      return 1;
    case "hub":
      return 1;
    case "zombies":
      return 0;
    case "raid":
      return 1;
    case "demo":
      return 1;
    default:
  }
}

_id_4436(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_A6EC = 1;

  if(level._id_A239 && ((maps\mp\_utility::_id_585F() || level.teambased) && level.ingraceperiod || !level.teambased && maps\mp\_utility::gettimepassed() == 0)) {
    if(level.teambased) {
      var_6 = _id_050D::_id_46A0(var_0);
    } else {
      var_6 = _id_050D::_id_46A0("allies");
    }

    if(level.gametype == "zombies") {
      var_6 = _id_050D::_id_3ACC(var_6);
    }
  } else {
    var_6 = _id_050D::_id_44F9(var_0);

    if(level.gametype == "zombies" && isDefined(level.zombies_active_spawn_event)) {
      var_6 = _id_050D::filterspawnpointszombiesactiveevent(var_6);
    }
  }

  var_7 = scragentsetgoalentity(var_0, var_6, var_1, var_3);

  if(isDefined(level._id_90A2) && level._id_90A2) {
    level._id_90A2 = 0;
    var_8 = gettime();
    var_9 = level._id_90B4;

    if(isDefined(self)) {
      var_10 = self._id_6870;

      if(!isDefined(var_10)) {
        var_10 = -1;
      }

      _reconspatialevent(var_7.origin, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", self.name, self._id_5CC6, var_10, var_0, var_8, var_9);
    } else
      _reconspatialevent(var_7.origin, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", "unknown", -1, -1, var_0, var_8, var_9);

    if(isDefined(game["spawnClaimFlipCount"])) {
      game["spawnClaimFlipCount"]++;
    } else {
      game["spawnClaimFlipCount"] = 1;
    }

    var_7._id_2055 = 1;
  } else
    var_7._id_2055 = 0;

  if(var_5 && !_func_367() && isDefined(level._id_9034)) {
    if(level._id_9034) {
      var_11 = var_0;
    } else {
      var_11 = maps\mp\_utility::getotherteam(var_0);
    }

    if(var_7._id_2BD3 == var_11) {
      var_8 = gettime();
      var_9 = level._id_90B4;

      if(isDefined(self)) {
        var_10 = self._id_6870;

        if(!isDefined(var_10)) {
          var_10 = -1;
        }

        _reconspatialevent(var_7.origin, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", self.name, self._id_5CC6, var_10, var_0, var_8, var_9);
      } else
        _reconspatialevent(var_7.origin, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", "unknown", -1, -1, var_0, var_8, var_9);

      if(isDefined(game["spawnClaimFlipCount"])) {
        game["spawnClaimFlipCount"]++;
      } else {
        game["spawnClaimFlipCount"] = 1;
      }

      if(level.gametype == "war" || level.gametype == "conf") {
        if(isDefined(game["objectiveFlipCount"])) {
          game["objectiveFlipCount"]++;
        } else {
          game["objectiveFlipCount"] = 1;
        }
      }

      level._id_9034 = !level._id_9034;
      var_7._id_2055 = 1;
    } else
      var_7._id_2055 = 0;
  }

  return var_7;
}

_id_A278(var_0) {
  level._id_A6EC = undefined;

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  var_1 = self _meth_856A();
  var_2 = self _meth_856B();
}

_id_2B5D() {
  if(!isDefined(level.players[0])) {
    return;
  }
  var_0 = maps\mp\_utility::getotherteam(level.players[0].team);

  if(var_0 == "none") {
    var_0 = "axis";
  }

  var_1 = _id_050D::_id_44F9(var_0);
  var_2 = spawnStruct();
  level.players[0] _id_4007(var_0, var_1, var_2, 0);
}

_id_5767(var_0) {
  if(!isDefined(level._id_746E)) {
    return 1;
  }

  if(isDefined(var_0.team)) {
    return var_0.team == level._id_746E;
  }

  return 0;
}

_id_534D(var_0) {
  var_0._id_9AB8 = 0;
  var_0._id_1CED = 0;
  var_0._id_2B5E = [];
  var_0._id_2B4F = [];
  var_0._id_9AB7 = 0;
}