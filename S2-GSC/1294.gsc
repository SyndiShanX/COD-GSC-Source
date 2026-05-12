/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1294.gsc
*********************************************/

lib_050E::func_5350() {
  level.var_909C["TDM"] = "mp/spawnScoreFactorsPerMap_TDM.csv";
  level.var_909C["DOM"] = "mp/spawnScoreFactorsPerMap_DOM.csv";
  level.var_909C["HP"] = "mp/spawnScoreFactorsPerMap_HP.csv";
  level.var_909C["CTF"] = "mp/spawnScoreFactorsPerMap_CTF.csv";
  level.var_909C["FFA"] = "mp/spawnScoreFactorsPerMap_FFA.csv";
  level.var_909C["UPLINK"] = "mp/spawnScoreFactorsPerMap_UPLINK.csv";
  level.var_909C["DEFAULT"] = "mp/spawnScoreFactorsPerMap_DEFAULT.csv";
  level.var_909C["ZOMBIES"] = "mp/spawnScoreFactorsPerMap_ZOMBIES.csv";
  level.var_909C["ZOMBIES_NPC"] = "mp/spawnScoreFactorsPerMap_ZOMBIES_NPC.csv";
  level.var_909C["RAIDS"] = "mp/spawnScoreFactorsPerMap_RAIDS.csv";
  level.var_909C["RELIC"] = "mp/spawnScoreFactorsPerMap_RELIC.csv";
  level.var_909C["UNDEAD"] = "mp/spawnScoreFactorsPerMap_UNDEAD.csv";
  level.var_909B = lib_050E::func_4698(1);
  level.var_909D = lib_050E::func_4698(2);
  level.var_903A = lib_050E::func_4690(3);
  level.var_903B = lib_050E::func_4690(4);
  if(getdvarint("spawning_revised_frontline") != 0 && level.var_3FDC == "war") {
    level.var_909B["preferClaimedSpawn"]["scoreFactorWeight"] = 0;
  }

  if(maps\mp\_utility::func_56B1() && level.var_3FDC == "dom") {
    level.var_909B["preferAllyDomPoints"]["scoreFactorWeight"] = 1;
    level.var_909B["preferTeamLastSpawnDOMPoint"]["scoreFactorWeight"] = 1.5;
    level.var_909B["avoidEnemies"]["scoreFactorWeight"] = 1.1;
    level.var_909B["avoidAllyDeathLocations"]["scoreFactorWeight"] = 1;
  }

  level.var_909A["avoidEnemies"] = ::lib_050C::func_143C;
  level.var_909A["preferAllies"] = undefined;
  level.var_909A["avoidAllyDeathLocations"] = ::lib_050C::func_1435;
  level.var_909A["avoidEnemySpawnLocations"] = ::lib_050C::func_143F;
  level.var_909A["preferClaimedSpawn"] = ::lib_050C::func_765F;
  level.var_909A["preferAllyDomPoints"] = ::lib_050C::func_765E;
  level.var_909A["avoidEnemyDomPointsByDistance"] = ::lib_050C::func_143D;
  level.var_909A["preferTeamLastSpawnDOMPoint"] = ::lib_050C::func_7676;
  level.var_909A["avoidVeryCloseToHPZone"] = ::lib_050C::func_1452;
  level.var_909A["preferNearHPZone"] = ::lib_050C::func_7666;
  level.var_909A["avoidFriendlyFlagBaseByDistance"] = ::lib_050C::func_1441;
  level.var_909A["avoidFriendlyCTFBaseByDistance"] = ::lib_050C::func_1440;
  level.var_909A["preferForwardCTFSpawns"] = ::lib_050C::func_7661;
  level.var_909A["zombiesPreferTombstoneByDistance"] = ::lib_050C::func_AB41;
  level.var_909A["zombiesPreferShortZoneConnection"] = ::lib_050C::func_AB3F;
  level.var_909A["zombiesPreferShortZoneConnectionNonInfected"] = ::lib_050C::func_AB40;
  level.var_909A["raidsPreferLastDeathLocation"] = ::lib_050C::func_7664;
  level.var_909A["avoidVeryCloseToRelic"] = ::lib_050C::avoidveryclosetorelic;
  level.var_909A["preferNearRelic"] = ::lib_050C::prefernearrelic;
  level.var_909A["randomSpawn"] = ::lib_050C::func_7A5E;
  level.var_909A["avoidSameSpawn"] = ::lib_050C::func_144C;
  level.var_909A["avoidRecentlyUsed"] = ::lib_050C::func_144A;
  level.var_909A["avoidLastDeathLocation"] = ::lib_050C::func_1446;
  level.var_909A["avoidLastAttackerLocation"] = ::lib_050C::func_1445;
  level.var_909A["preferAllyCenterPointByDistance"] = ::lib_050C::func_765D;
  level.var_909A["zombiesAvoidClosestEnemyByDistance"] = ::lib_050C::func_AAFF;
  lib_050E::func_09EC("avoidFullVisibleEnemies", ::lib_050C::func_1442, 0);
  lib_050E::func_09EC("avoidCornerVisibleEnemies", ::lib_050C::func_143A, 1);
  lib_050E::func_09EC("assignedViaFrontline", ::lib_050C::func_10DE, 2);
  lib_050E::func_09EC("obeyTeamAssignments", ::lib_050C::func_68A3, 3);
  lib_050E::func_09EC("avoidGrenades", ::lib_050C::func_1443, 4);
  lib_050E::func_09EC("avoidMines", ::lib_050C::func_1447, 5);
  lib_050E::func_09EC("avoidScorestreakLocations", ::lib_050C::func_144D, 6);
  lib_050E::func_09EC("avoidCarePackages", ::lib_050C::func_1437, 7);
  lib_050E::func_09EC("avoidTelefrag", ::lib_050C::func_1451, 8);
  lib_050E::func_09EC("avoidEnemySpawn", ::lib_050C::func_143E, 9);
  lib_050E::func_09EC("avoidSpawnInHPZone", ::lib_050C::func_144E, 10);
  lib_050E::func_09EC("zombiesIsInValidZone", ::lib_050C::func_AB32, 11);
}

lib_050E::func_57B9(param_00) {
  switch (param_00) {
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

lib_050E::func_3152(param_00) {
  switch (param_00) {
    case "avoidEnemySpawnLocations":
    case "avoidAllyDeathLocations":
    case "preferAllies":
    case "avoidEnemies":
      return 1;

    default:
      return 0;
  }
}

lib_050E::func_09EC(param_00, param_01, param_02) {
  if(!isDefined(param_00) || !lib_050E::func_56BE(param_00) || !isDefined(param_02)) {}

  level.var_9039[param_00]["criticalFactorFunc"] = param_01;
  level.var_9039[param_00]["criticalFactorAnalyticsIndex"] = param_02;
}

lib_050E::func_56BE(param_00) {
  switch (param_00) {
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

lib_050E::func_56BD(param_00) {
  switch (param_00) {
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

lib_050E::func_4698(param_00) {
  var_01 = [];
  var_02 = tablelookup("mp/spawnFactorsPerMode.csv", 0, level.var_3FDC, param_00);
  if(!isDefined(var_02) || var_02 == "") {
    return var_01;
  }

  var_03 = level.var_909C[var_02];
  var_04 = function_027B(var_03);
  for(var_05 = 1; var_05 < var_04; var_05++) {
    var_06 = tablelookup(var_03, 0, "score_factors", var_05);
    if(isDefined(var_06) && lib_050E::func_57B9(var_06)) {
      var_07 = lib_050E::func_4670(var_03, var_05);
      var_01[var_06]["scoreFactorName"] = var_06;
      var_01[var_06]["scoreFactorWeight"] = var_07;
    } else if(!isDefined(var_06) || var_06 != maps\mp\_utility::no_obfuscate("ProductionLevel")) {}
  }

  return var_01;
}

lib_050E::func_4670(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, maps\mp\_utility::func_4571(), param_01);
  if(!isDefined(var_02) || var_02 == "") {
    var_02 = tablelookup(param_00, 0, "mp_default", param_01);
  }

  return float(var_02);
}

lib_050E::func_4690(param_00) {
  var_01 = [];
  var_02 = tablelookup("mp/spawnFactorsPerMode.csv", 0, level.var_3FDC, param_00);
  if(!isDefined(var_02) || !lib_050E::func_56BD(var_02)) {
    return var_01;
  }

  var_03 = "mp/spawnCriticalFactors.csv";
  if(getdvarint("spawning_revised_frontline") != 0) {
    var_03 = "mp/spawnCriticalFactors_EXPERIMENTAL.csv";
  }

  var_04 = function_027B(var_03);
  var_05 = -1;
  for(var_06 = 1; var_06 < var_04; var_06++) {
    if(var_02 == tablelookupbyrow(var_03, 0, var_06)) {
      var_05 = var_06;
      break;
    }
  }

  var_07 = function_027A(var_03);
  for(var_08 = 1; var_08 < var_07; var_08++) {
    var_09 = tablelookupbyrow(var_03, var_08, 0);
    if(isDefined(var_09) && lib_050E::func_56BE(var_09)) {
      var_0A = tablelookupbyrow(var_03, var_08, var_05);
      if(isDefined(var_0A) && var_0A == "primary" || var_0A == "secondary" || var_0A == "bad") {
        var_01[var_0A][var_09]["criticalFactorName"] = var_09;
        var_01[var_0A][var_09]["criticalFactorResult"] = var_0A;
      }

      continue;
    }
  }

  return var_01;
}

lib_050E::func_3890(param_00, param_01, param_02) {
  foreach(var_04 in param_02) {
    var_05 = var_04["criticalFactorName"];
    var_06 = var_04["criticalFactorResult"];
    var_07 = level.var_9039[var_05]["criticalFactorFunc"];
    if(isDefined(var_07)) {
      if(!lib_050C::func_2857(var_07, param_00, param_01)) {
        return var_04;
      }
    }
  }

  return undefined;
}

lib_050E::func_388F(param_00, param_01) {
  var_02 = level.var_903A;
  if(isDefined(level.var_746E) && param_00 != level.var_746E) {
    var_02 = level.var_903B;
  }

  if(isDefined(var_02) && var_02.size > 0) {
    var_03 = ["bad", "secondary", "primary"];
    foreach(var_05 in var_03) {
      if(isDefined(var_02[var_05]) && var_02[var_05].size > 0) {
        var_06 = lib_050E::func_3890(param_00, param_01, var_02[var_05]);
        if(isDefined(var_06)) {
          return var_06;
        }
      }
    }
  }

  var_08 = [];
  var_08["criticalFactorName"] = "";
  var_08["criticalFactorResult"] = "primary";
  return var_08;
}

lib_050E::func_3894(param_00, param_01, param_02) {
  foreach(var_04 in param_02) {
    var_05 = var_04["scoreFactorName"];
    var_06 = var_04["scoreFactorWeight"];
    var_07 = level.var_909A[var_05];
    if(isDefined(var_07)) {
      if(lib_050E::func_3152(var_05)) {
        param_01.var_9AB8 = param_01.var_9AB8 + [[var_07]](param_00, param_01);
        continue;
      }

      param_01.var_9AB8 = param_01.var_9AB8 + lib_050C::func_80A2(var_06, var_07, param_00, param_01);
    }
  }
}

lib_050E::func_3893(param_00, param_01) {
  lib_050E::func_3894(param_00, param_01, level.var_909B);
}

lib_050E::func_3895(param_00, param_01) {
  lib_050E::func_3894(param_00, param_01, level.var_909D);
}

lib_050E::func_80AE(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    param_02.var_6884 = param_01.size;
  }

  foreach(var_04 in param_01) {
    if(isDefined(level.var_746E) && param_00 != level.var_746E) {
      lib_050E::func_3895(param_00, var_04);
      continue;
    }

    lib_050E::func_3893(param_00, var_04);
  }
}

lib_050E::func_4007(param_00, param_01, param_02, param_03) {
  var_04["primary"] = [];
  var_04["secondary"] = [];
  var_04["bad"] = [];
  if(!lib_050D::func_580F()) {
    if(!isDefined(level.var_4B94)) {
      if(isDefined(level.var_602F)) {
        [[level.var_602F]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");
      }

      level.var_4B94 = 1;
    }

    if(getdvarint("3950", 0) == 1 && level.var_3FDC != "zombies" && !maps\mp\_utility::func_579B()) {
      iprintlnbold("Spawning a player without any LOS data!");
    }
  }

  lib_050D::func_A167();
  lib_050C::func_A119(param_00);
  foreach(var_06 in param_01) {
    lib_050E::func_534D(var_06);
    lib_050D::func_3892(var_06, param_00);
    var_07 = lib_050E::func_388F(param_00, var_06);
    var_06.var_285B = var_07["criticalFactorResult"];
    var_06.var_285A = var_07["criticalFactorName"];
    if(!isDefined(var_06.var_285A) || var_06.var_285A == "") {
      var_06.var_2859 = -1;
    } else {
      var_06.var_2859 = level.var_9039[var_06.var_285A]["criticalFactorAnalyticsIndex"];
    }

    var_04[var_06.var_285B][var_04[var_06.var_285B].size] = var_06;
  }

  if(param_01.size > 0) {
    param_02.var_90B3["primary"] = var_04["primary"].size / param_01.size;
    param_02.var_90B3["secondary"] = var_04["secondary"].size / param_01.size;
    param_02.var_90B3["bad"] = var_04["bad"].size / param_01.size;
  }

  if(var_04["primary"].size || param_03) {
    lib_050E::func_80AE(param_00, var_04["primary"], param_02);
    param_02.var_0BD9 = 0;
    if(var_04["secondary"].size) {
      var_09 = var_04["primary"][0].var_9AB8;
      foreach(var_06 in var_04["primary"]) {
        if(isDefined(var_06.var_9AB8) && var_06.var_9AB8 > var_09) {
          var_09 = var_06.var_9AB8;
        }
      }

      lib_050E::func_80AE(param_00, var_04["secondary"], undefined);
      var_0C = 0;
      foreach(var_06 in var_04["secondary"]) {
        if(isDefined(var_06.var_9AB8) && var_06.var_9AB8 > var_09) {
          var_0C++;
        }
      }

      param_02.var_689C = var_0C;
    } else {
      param_02.var_689C = -1;
    }

    return var_04["primary"];
  }

  if(var_04["secondary"].size) {
    lib_050E::func_80AE(param_00, var_04["secondary"], param_02);
    param_02.var_0BD9 = 0;
    param_02.var_689C = -1;
    return var_04["secondary"];
  }

  lib_050E::func_80AE(param_00, param_01, param_02);
  param_02.var_0BD9 = 1;
  param_02.var_689C = -1;
  return param_01;
}

lib_050E::func_909E(param_00, param_01) {
  return param_00.var_9AB8 > param_01.var_9AB8;
}

lib_050E::func_8399(param_00, param_01, param_02, param_03) {
  var_04 = lib_050E::func_4007(param_00, param_01, param_02, 0);
  foreach(var_06 in param_01) {
    if(isDefined(param_03) && param_03) {
      maps\mp\gametypes\_spawnscoring::func_7AF5(var_06);
    }
  }

  var_08 = [];
  var_08[var_08.size] = var_04[0];
  var_09 = -1;
  var_0A = [];
  var_0B = -2;
  foreach(var_06 in var_04) {
    if(isDefined(var_06.var_9AB8)) {
      if(var_06.var_9AB8 > var_09) {
        var_0A = var_08;
        var_0B = var_09;
        var_08 = [];
        var_08[var_08.size] = var_06;
        var_09 = var_06.var_9AB8;
        continue;
      }

      if(var_06.var_9AB8 == var_09) {
        var_08[var_08.size] = var_06;
        continue;
      }

      if(var_06.var_9AB8 > var_0B) {
        var_0A = [];
        var_0A[var_0A.size] = var_06;
        var_0B = var_06.var_9AB8;
        continue;
      }

      if(var_06.var_9AB8 == var_0B) {
        var_0A[var_0A.size] = var_06;
      }
    }
  }

  if(getdvarint("spawning_revised_fatique") != 0) {
    var_0E = undefined;
    var_0F = [];
    if(isDefined(param_02)) {
      if(isDefined(param_02.var_9087) && isDefined(param_02.var_9087.var_0116)) {
        var_0E = param_02.var_9087;
      }

      if(isDefined(param_02.var_3A5D)) {
        var_0F = param_02.var_3A5D;
      }
    }

    var_10 = 0;
    foreach(var_12 in var_0F) {
      if(var_12["spawnCount"] >= 2 || var_12["spawnsSinceLastUsed"] > 0 && var_12["spawnsSinceLastUsed"] <= 2) {
        if(common_scripts\utility::func_0F79(var_08, var_12["spawnPoint"])) {
          if(var_08.size > 1) {
            var_08 = common_scripts\utility::func_0F93(var_08, var_12["spawnPoint"]);
          } else {
            var_10 = 1;
          }
        }

        if(common_scripts\utility::func_0F79(var_0A, var_12["spawnPoint"])) {
          var_0A = common_scripts\utility::func_0F93(var_0A, var_12["spawnPoint"]);
        }
      }
    }

    if(isDefined(var_0E)) {
      if(var_08.size > 1 && common_scripts\utility::func_0F79(var_08, var_0E)) {
        var_08 = common_scripts\utility::func_0F93(var_08, var_0E);
      }

      if((var_0A.size > 1 || !var_10) && common_scripts\utility::func_0F79(var_0A, var_0E)) {
        var_0A = common_scripts\utility::func_0F93(var_0A, var_0E);
      }
    }

    if(var_10 && var_0A.size > 0) {
      if(var_09 > 0 && var_0B > 0 && var_0B / var_09 > 0.9) {
        var_14 = var_08[0];
        var_15 = [];
        foreach(var_06 in var_0A) {
          if(distance2d(var_06.var_0116, var_14.var_0116) <= 1300) {
            var_15[var_15.size] = var_06;
          }
        }

        if(var_15.size > 0) {
          var_08 = var_15;
        }
      }
    }
  }

  return common_scripts\utility::func_7A33(var_0E);
}

lib_050E::func_4706(param_00) {
  if(isDefined(param_00.var_0165)) {
    if(param_00.var_0165 == "primary_override") {
      return "primary";
    } else if(param_00.var_0165 == "secondary_override") {
      return "secondary";
    } else if(param_00.var_0165 == "tertiary_override") {
      return "tertiary";
    }
  }

  if(!isDefined(param_00.var_7702) || param_00.var_7702) {
    return "primary";
  }

  return "secondary";
}

lib_050E::func_839A(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = undefined;
  param_00 = common_scripts\utility::func_0F92(param_00);
  foreach(var_03 in param_00) {
    if(lib_050E::func_4706(var_03) != "primary") {
      continue;
    }

    if(!canspawn(var_03.var_0116) || positionwouldtelefrag(var_03.var_0116)) {
      continue;
    }

    if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_03)) {
      continue;
    }

    var_01 = var_03;
  }

  if(!isDefined(var_01)) {
    foreach(var_03 in param_00) {
      if(lib_050E::func_4706(var_03) != "secondary") {
        continue;
      }

      if(!canspawn(var_03.var_0116) || positionwouldtelefrag(var_03.var_0116)) {
        continue;
      }

      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_03)) {
        continue;
      }

      var_01 = var_03;
    }
  }

  if(!isDefined(var_01)) {
    foreach(var_03 in param_00) {
      if(lib_050E::func_4706(var_03) != "tertiary") {
        continue;
      }

      if(!canspawn(var_03.var_0116) || positionwouldtelefrag(var_03.var_0116)) {
        continue;
      }

      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_03)) {
        continue;
      }

      var_01 = var_03;
    }
  }

  if(!isDefined(var_01)) {
    foreach(var_03 in param_00) {
      if(!canspawn(var_03.var_0116) || positionwouldtelefrag(var_03.var_0116)) {
        continue;
      }

      if(isDefined(level.checkunscoredspawnpoint) && ![[level.checkunscoredspawnpoint]](var_03)) {
        continue;
      }

      var_01 = var_03;
    }
  }

  if(!isDefined(var_01)) {
    var_01 = param_00[0];
  }

  return var_01;
}

lib_050E::func_8398(param_00, param_01, param_02, param_03) {
  level.var_9068.var_9090 = param_01;
  if(isDefined(level.var_746E) && param_00 != level.var_746E) {
    return lib_050E::func_8399(param_00, param_01, param_02, param_03);
  }

  if(level.var_A239 && ((maps\mp\_utility::func_585F() || level.var_984D) && level.var_5139) || !level.var_984D && maps\mp\_utility::func_46E3() == 0) {
    return lib_050E::func_839A(param_01);
  }

  return lib_050E::func_8399(param_00, param_01, param_02, param_03);
}

lib_050E::func_8BA2() {
  switch (level.var_3FDC) {
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
      break;
  }
}

lib_050E::func_4436(param_00, param_01, param_02, param_03, param_04, param_05) {
  level.var_A6EC = 1;
  if(level.var_A239 && ((maps\mp\_utility::func_585F() || level.var_984D) && level.var_5139) || !level.var_984D && maps\mp\_utility::func_46E3() == 0) {
    if(level.var_984D) {
      var_06 = lib_050D::func_46A0(param_00);
    } else {
      var_06 = lib_050D::func_46A0("allies");
    }

    if(level.var_3FDC == "zombies") {
      var_06 = lib_050D::func_3ACC(var_06);
    }
  } else {
    var_06 = lib_050D::func_44F9(param_01);
    if(level.var_3FDC == "zombies" && isDefined(level.zombies_active_spawn_event)) {
      var_06 = lib_050D::filterspawnpointszombiesactiveevent(var_06);
    }
  }

  var_07 = lib_050E::func_8398(param_00, var_06, param_01, param_03);
  if(isDefined(level.var_90A2) && level.var_90A2) {
    level.var_90A2 = 0;
    var_08 = gettime();
    var_09 = level.var_90B4;
    if(isDefined(self)) {
      var_0A = self.var_6870;
      if(!isDefined(var_0A)) {
        var_0A = -1;
      }

      function_00F6(var_07.var_0116, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", self.var_0109, self.var_5CC6, var_0A, param_00, var_08, var_09);
    } else {
      function_00F6(var_07.var_0116, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", "unknown", -1, -1, param_00, var_08, var_09);
    }

    if(isDefined(game["spawnClaimFlipCount"])) {
      game["spawnClaimFlipCount"]++;
    } else {
      game["spawnClaimFlipCount"] = 1;
    }

    var_07.var_2055 = 1;
  } else {
    var_09.var_2055 = 0;
  }

  if(var_07 && !function_0367() && isDefined(level.var_9034)) {
    if(level.var_9034) {
      var_0B = param_02;
    } else {
      var_0B = maps\mp\_utility::func_45DE(param_03);
    }

    if(var_09.var_2BD3 == var_0B) {
      var_08 = gettime();
      var_09 = level.var_90B4;
      if(isDefined(self)) {
        var_0A = self.var_6870;
        if(!isDefined(var_0A)) {
          var_0A = -1;
        }

        function_00F6(var_07.var_0116, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", self.var_0109, self.var_5CC6, var_0A, param_00, var_09, var_0B);
      } else {
        function_00F6(var_07.var_0116, "script_mp_spawn_flip: player_name %s, life_id %d, life_index %d, team %s, gameTime %d, spawnVersion %f", "unknown", -1, -1, param_00, var_09, var_0B);
      }

      if(isDefined(game["spawnClaimFlipCount"])) {
        game["spawnClaimFlipCount"]++;
      } else {
        game["spawnClaimFlipCount"] = 1;
      }

      if(level.var_3FDC == "war" || level.var_3FDC == "conf") {
        if(isDefined(game["objectiveFlipCount"])) {
          game["objectiveFlipCount"]++;
        } else {
          game["objectiveFlipCount"] = 1;
        }
      }

      level.var_9034 = !level.var_9034;
      var_07.var_2055 = 1;
    } else {
      var_09.var_2055 = 0;
    }
  }

  return var_0B;
}

lib_050E::func_A278(param_00) {
  level.var_A6EC = undefined;
  if(!isDefined(self) || !isDefined(param_00)) {
    return;
  }

  var_01 = self method_856A();
  var_02 = self method_856B();
}

lib_050E::func_2B5D() {
  if(!isDefined(level.var_744A[0])) {
    return;
  }

  var_00 = maps\mp\_utility::func_45DE(level.var_744A[0].var_01A7);
  if(var_00 == "none") {
    var_00 = "axis";
  }

  var_01 = lib_050D::func_44F9(var_00);
  var_02 = spawnStruct();
  level.var_744A[0] lib_050E::func_4007(var_00, var_01, var_02, 0);
}

lib_050E::func_5767(param_00) {
  if(!isDefined(level.var_746E)) {
    return 1;
  }

  if(isDefined(param_00.var_01A7)) {
    return param_00.var_01A7 == level.var_746E;
  }

  return 0;
}

lib_050E::func_534D(param_00) {
  param_00.var_9AB8 = 0;
  param_00.var_1CED = 0;
  param_00.var_2B5E = [];
  param_00.var_2B4F = [];
  param_00.var_9AB7 = 0;
}