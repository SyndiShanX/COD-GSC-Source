/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\accolades.gsc
***********************************************/

function init() {
  level.accolades = [];
  registeraccolade("adsKills", ["adsKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("hipfireKills", ["hipfireKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("lowerRankedKills", ["lowerRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("higherRankedKills", ["higherRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("highestRankedKills", ["highestRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("reloads", ["reloads"], 0, 0, undefined, undefined, undefined);
  registeraccolade("weaponPickups", ["weaponPickups"], 0, 0, undefined, undefined, undefined);
  registeraccolade("shotsFired", ["shotsFired"], 0, 0, undefined, undefined, undefined);
  registeraccolade("classChanges", ["classChanges"], 0, 0, &isclasschoiceallowed, undefined, undefined);
  registeraccolade("headshots", ["headshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("timeWatchingKillcams", ["timeWatchingKillcams"], 0, 0, &arekillcamsenabled, undefined, undefined);
  registeraccolade("skippedKillcams", ["skippedKillcams"], 0, 0, &arekillcamsenabled, undefined, undefined);
  registeraccolade("longestStreak", ["longestStreak"], 0, 0, undefined, undefined, undefined);
  registeraccolade("mostKills", ["kills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastKills", ["kills"], 0, 1, undefined, undefined, &scoreminimum);
  registeraccolade("mostAssists", ["assists"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastAssists", ["assists"], 0, 1, undefined, undefined, &scoreminimum);
  registeraccolade("mostDeaths", ["deaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastDeaths", ["deaths"], 0, 1, undefined, undefined, &scoreminimum);
  registeraccolade("suicides", ["suicides"], 0, 0, undefined, undefined, undefined);
  registeraccolade("noKillsWithDeath", ["kills", "deaths"], 0, 0, undefined, undefined, &nokillswithdeath_evaluate);
  registeraccolade("noKillNoDeath", ["kills", "deaths"], 0, 0, undefined, undefined, &nokillnodeath_evaluate);
  registeraccolade("noKill10Deaths", ["kills", "deaths"], 0, 0, undefined, undefined, &nokill10deaths_evaluate);
  registeraccolade("mostKillsLeastDeaths", ["kills", "deaths"], 0, 0, undefined, undefined, &mostkillsleastdeaths_evaluate);
  registeraccolade("mostKillsMostHeadshots", ["kills", "headshots"], 0, 0, undefined, undefined, &mostkillsmostheadshots_evaluate);
  registeraccolade("mostKillsLongestStreak", ["kills", "longestStreak"], 0, 0, undefined, undefined, &mostkillslongeststreak_evaluate);
  registeraccolade("kills10NoDeaths", ["kills", "deaths"], 0, 0, undefined, undefined, &kills10nodeaths_evaluate);
  registeraccolade("deathsFromBehind", ["deathsFromBehind"], 0, 0, undefined, undefined, undefined);
  registeraccolade("killsFromBehind", ["killsFromBehind"], 0, 0, undefined, undefined, undefined);
  registeraccolade("noDeathsFromBehind", ["deathsFromBehind"], 0, 1, undefined, undefined, &nodeathsfrombehind_evaluate);
  registeraccolade("shortestLife", ["shortestLife"], 0, 0, undefined, undefined, &scoreminimum);
  registeraccolade("longestLife", ["longestLife"], 0, 0, undefined, undefined, undefined);
  registeraccolade("damageDealt", ["damage"], 0, 0, undefined, undefined, undefined);
  registeraccolade("damageTaken", ["damageTaken"], 0, 0, undefined, undefined, undefined);
  registeraccolade("highestMultikill", ["highestMultikill"], 0, 0, undefined, undefined, undefined);
  registeraccolade("mostMultikills", ["mostMultikills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("revives", ["revives"], 0, 0, &isreviveenabled, undefined, undefined);
  registeraccolade("penetrationKills", ["penetrationKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("revengeKills", ["revengeKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("avengerKills", ["avengerKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("defenderKills", ["defenderKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("longshotKills", ["longshotKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("pointBlankKills", ["pointBlankKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("oneShotOneKills", ["oneShotOneKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("executionKills", ["executionKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("comebackKills", ["comebackKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("explosionsSurvived", ["explosionsSurvived"], 0, 0, undefined, undefined, undefined);
  registeraccolade("killEnemyTeam", ["killEnemyTeam"], 0, 0, &iscorempgametype, undefined, undefined);
  registeraccolade("timeCrouched", ["timeCrouched"], 0, 0, &isnotleanthreadmode, undefined, undefined);
  registeraccolade("timeProne", ["timeProne"], 0, 0, &isnotleanthreadmode, undefined, undefined);
  registeraccolade("distanceTravelled", ["totalDistTraveled"], 0, 0, &isnotleanthreadmode, undefined, undefined);
  registeraccolade("highestAvgAltitude", ["averageAltitude", "averageAltitudeCount"], 0, 0, &isnotleanthreadmode, undefined, &highestavgaltitude_evaluate);
  registeraccolade("lowestAvgAltitude", ["averageAltitude", "averageAltitudeCount"], 0, 0, &isnotleanthreadmode, undefined, &lowestavgaltitude_evaluate);
  registeraccolade("meleeKills", ["meleeKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("pistolKills", ["pistolKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("launcherKills", ["launcherKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("shotgunKills", ["shotgunKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("smgKills", ["smgKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("arKills", ["arKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("lmgKills", ["lmgKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("sniperKills", ["sniperKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("pistolHeadshots", ["pistolHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("launcherHeadshots", ["launcherHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("shotgunHeadshots", ["shotgunHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("smgHeadshots", ["smgHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("arHeadshots", ["arHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("lmgHeadshots", ["lmgHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("sniperHeadshots", ["sniperHeadshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("meleeDeaths", ["meleeDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("pistolPeaths", ["pistolPeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("launcherDeaths", ["launcherDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("shotgunDeaths", ["shotgunDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("smgDeaths", ["smgDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("arDeaths", ["arDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("lmgDeaths", ["lmgDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("sniperDeaths", ["sniperDeaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("riotShieldDamageAbsorbed", ["riotShieldDamageAbsorbed"], 0, 0, undefined, undefined, undefined);
  registeraccolade("killstreakPersonalUAVKills", ["killstreakPersonalUAVKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakShieldTurretKills", ["killstreakShieldTurretKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakUAVAssists", ["killstreakUAVAssists"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCUAVAssists", ["killstreakCUAVAssists"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCarePackageUsed", ["killstreakCarePackageUsed"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCluserStrikeKills", ["killstreakCluserStrikeKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCruiseMissileKills", ["killstreakCruiseMissileKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAirstrikeKills", ["killstreakAirstrikeKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakTankKills", ["killstreakTankKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakSentryGunKills", ["killstreakSentryGunKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakWheelsonKills", ["killstreakWheelsonKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakEmergencyAirdropUsed", ["killstreakEmergencyAirdropUsed"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakVTOLJetKills", ["killstreakVTOLJetKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakWhitePhosphorousKillsAssists", ["killstreakWhitePhosphorousKillsAssists"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakChopperGunnerKills", ["killstreakChopperGunnerKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakChopperSupportKills", ["killstreakChopperSupportKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakGunshipKills", ["killstreakGunshipKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAUAVAssists", ["killstreakAUAVAssists"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakJuggernautKills", ["killstreakJuggernautKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAssaultDroneKills", ["killstreakAssaultDroneKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakKills", ["killstreakKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAirKills", ["killstreakAirKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakGroundKills", ["killstreakGroundKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("destroyedKillstreaks", ["destroyedKillstreaks"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("fragKills", ["fragKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("semtexKills", ["semtexKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("molotovKills", ["molotovKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("claymoreKills", ["claymoreKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("throwingKnifeKills", ["throwingKnifeKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("c4LethalKills", ["c4Kills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("thermiteKills", ["thermiteKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("proximityMineKills", ["proximityMineKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("flashbangHits", ["flashbangHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("smokesUsed", ["smokesUsed"], 0, 0, undefined, undefined, undefined);
  registeraccolade("stunHits", ["stunHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("stimDamageHealed", ["stimDamageHealed"], 0, 0, undefined, undefined, undefined);
  registeraccolade("decoyHits", ["decoyHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("gasHits", ["gasHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("snapshotHits", ["snapshotHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("ammoBoxUsed", ["ammoBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("reconDroneMarks", ["reconDroneMarks"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("empDroneHits", ["empDroneHits"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("stoppingPowerKills", ["stoppingPowerKills"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("trophySystemHits", ["trophySystemHits"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deadSilenceKills", ["deadSilenceKills"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("tacticalInsertionSpawns", ["tacticalInsertionSpawns"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deployableCoverUsed", ["deployableCoverUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("munitionsBoxUsed", ["munitionsBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("defends", ["defends"], 0, 0, &isobjectivegametype, undefined, undefined);
  registeraccolade("assaults", ["assaults"], 0, 0, &isobjectivegametype, undefined, undefined);
  registeraccolade("pickups", ["pickups"], 0, 0, &iscarrygametype, undefined, undefined);
  registeraccolade("captures", ["captures"], 0, 0, &iscapturegametype, undefined, undefined);
  registeraccolade("returns", ["returns"], 0, 0, &isctf, undefined, undefined);
  registeraccolade("carrierKills", ["carrierKills"], 0, 0, &iscarrygametype, undefined, undefined);
  registeraccolade("bombPlanted", ["plants"], 0, 0, &isbombgametype, undefined, undefined);
  registeraccolade("bombDefused", ["defuses"], 0, 0, &isbombgametype, undefined, undefined);
  registeraccolade("bombDetonated", ["destructions"], 0, 0, &isbombgametype, undefined, undefined);
  registeraccolade("clutch", ["clutch"], 0, 0, &islifelimited, undefined, undefined);
  registeraccolade("clutchRevives", ["clutchRevives"], 0, 0, &isreviveenabled, undefined, undefined);
  registeraccolade("tagsCaptured", ["confirmed"], 0, 0, &aretagsenabled, undefined, undefined);
  registeraccolade("tagsDenied", ["denied"], 0, 0, &aretagsenabled, undefined, undefined);
  registeraccolade("tagsMegaBanked", ["tagsMegaBanked"], 0, 0, &isgrind, undefined, undefined);
  registeraccolade("tagsLargestBank", ["tagsLargestBank"], 0, 0, &isgrind, undefined, undefined);
  registeraccolade("firstInfected", ["firstInfected"], 0, 0, &isinfected, undefined, undefined);
  registeraccolade("survivorKills", ["killsAsSurvivor"], 0, 0, &isinfected, undefined, undefined);
  registeraccolade("infectedKills", ["killsAsInfected"], 0, 0, &isinfected, undefined, undefined);
  registeraccolade("lastSurvivor", ["lastSurvivor"], 0, 0, &isinfected, undefined, undefined);
  registeraccolade("setbacks", ["setbacks"], 0, 0, &isgungame, undefined, undefined);
  registeraccolade("longestTimeSpentOnWeapon", ["longestTimeSpentOnWeapon"], 0, 0, &isgungame, undefined, undefined);
  registeraccolade("carepackagesCaptured", ["carepackagesCaptured"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("spawnSelectSquad", ["spawnSelectSquad"], 0, 0, &isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectVehicle", ["spawnSelectVehicle"], 0, 0, &isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectFlag", ["spawnSelectFlag"], 0, 0, &isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectBase", ["spawnSelectBase"], 0, 0, &isspawnselectionenabled, undefined, undefined);
  registeraccolade("timesSelectedAsSquadLeader", ["timesSelectedAsSquadLeader"], 0, 0, &isspawnselectionenabled, undefined, undefined);
  registeraccolade("timeSpentAsDriver", ["timeSpentAsDriver"], 0, 0, &arevehiclesenabled, undefined, undefined);
  registeraccolade("timeSpentAsPassenger", ["timeSpentAsPassenger"], 0, 0, &arevehiclesenabled, undefined, undefined);
  registeraccolade("distanceTraveledInVehicle", ["distanceTraveledInVehicle"], 0, 0, &arevehiclesenabled, undefined, undefined);
  registeraccolade("timeOnPoint", ["objTime"], 0, 0, &ishardpoint, undefined, undefined);
}

function registeraccolade(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7.datapoints = var1;
  var7.priority = var2;
  var7.intialvalueisvalid = var3;
  var7.evaluatefunc = var6;
  var7.winners = [];
  var7.isactive = !isDefined(var4) || [[var4]]();
  level.accolades[var0] = var7;

  if(isDefined(var5)) {
    level thread[[var5]]();
    return;
  }
}

function applyaccoladestructtoplayerpers() {
  var0 = scripts\mp\utility\game::onlinestatsenabled();

  foreach(var2 in level.accolades) {
    if(var0) {
      self setplayerdata("mp", "playerStats", "matchAccolades", var6, 0);
    }

    if(!isDefined(var2.datapoints)) {
      continue;
    }

    foreach(var4 in var2.datapoints) {
      scripts\mp\utility\stats::initpersstat(var4);
    }
  }
}

function obj_riverbed() {
  if(!istrue(level.challengesallowed)) {
    return;
  }

  foreach(var2, var1 in level.accolades) {
    if(!var1.isactive) {
      continue;
    }

    evaluateaccolade(level, var2);
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    foreach(var2, var1 in level.accolades) {
      if(!var1.isactive) {
        continue;
      }

      foreach(var5 in var1.winners) {
        if(!isDefined(var5)) {
          continue;
        }

        var6 = var5 getplayerdata("mp", "playerStats", "accoladeStats", var2);
        var5 setplayerdata("mp", "playerStats", "accoladeStats", var2, var6 + 1);
        var5 setplayerdata("mp", "playerStats", "matchAccolades", var2, 1);
      }
    }

    return;
  }
}

function evaluateaccolade(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var3.pers[var0];

    if(isDefined(level.accolades[var0].evaluatefunc)) {
      var4 = var3[[level.accolades[var0].evaluatefunc]](var0);
    } else {
      var4 = var3.pers[level.accolades[var0].datapoints[0]];
    }

    if(!isDefined(var4) || !level.accolades[var0].intialvalueisvalid && var4 == 0) {
      continue;
    }

    if(!isDefined(var1) || var4 > var1) {
      var1 = var4;
      level.accolades[var0].winners = [];
      level.accolades[var0].winners[level.accolades[var0].winners.size] = var3;
      continue;
    }

    if(var4 == var1) {
      level.accolades[var0].winners[level.accolades[var0].winners.size] = var3;
    }
  }
}

function arekillcamsenabled() {
  return istrue(level.killcam);
}

function isnotleanthreadmode() {
  return !scripts\mp\utility\game::runleanthreadmode();
}

function isclasschoiceallowed() {
  scripts\mp\flags::gameflagwait("infil_setup_complete");
  return scripts\mp\utility\game::allowclasschoice();
}

function islifelimited() {
  return istrue(level.numlifelimited);
}

function isreviveenabled() {
  return istrue(level.numrevives);
}

function iscorempgametype() {
  return scripts\mp\utility\game::getgametype() != "br";
}

function arekillstreaksallowed() {
  return istrue(level.allowkillstreaks);
}

function arefieldupgradesallowed() {
  return istrue(level.allowsupers);
}

function isobjectivegametype() {
  return scripts\mp\utility\game::getgametype() != "war" && scripts\mp\utility\game::getgametype() != "dm" && scripts\mp\utility\game::getgametype() != "br";
}

function isbombgametype() {
  return scripts\mp\gameobjects::isbombmode();
}

function iscarrygametype() {
  if(scripts\mp\gameobjects::isbombmode()) {
    return true;
  }

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "ctf":
      return true;
  }

  return false;
}

function iscapturegametype() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "grnd":
    case "grind":
    case "koth":
    case "hq":
    case "siege":
    case "dom":
    case "arena":
    case "arm":
      return true;
  }

  return false;
}

function isctf() {
  return scripts\mp\utility\game::getgametype() == "ctf";
}

function isspawnselectionenabled() {
  return istrue(level.usespawnselection);
}

function aretagsenabled() {
  return istrue(level.dogtagsenabled);
}

function isgrind() {
  return scripts\mp\utility\game::getgametype() == "grind";
}

function isinfected() {
  return scripts\mp\utility\game::getgametype() == "infect";
}

function isgungame() {
  return scripts\mp\utility\game::getgametype() == "gun";
}

function ishardpoint() {
  return scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd";
}

function arevehiclesenabled() {
  return getdvarint("scr_allow_vehicles", 0) == 1;
}

function scoreminimum(var0) {
  return self.pers[level.accolades[var0].datapoints[0]] * -1;
}

function nokillswithdeath_evaluate(var0) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] > 0) {
    return true;
  }

  return false;
}

function nokillnodeath_evaluate(var0) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] == 0) {
    return true;
  }

  return false;
}

function nokill10deaths_evaluate(var0) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] >= 10) {
    return true;
  }

  return false;
}

function mostkillsleastdeaths_evaluate(var0) {
  var1 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  var2 = scripts\engine\utility::array_contains(level.accolades["leastDeaths"].winners, self);

  if(var1 && var2) {
    return true;
  }

  return false;
}

function mostkillsmostheadshots_evaluate(var0) {
  var1 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  var2 = scripts\engine\utility::array_contains(level.accolades["headshots"].winners, self);

  if(var1 && var2) {
    return true;
  }

  return false;
}

function mostkillslongeststreak_evaluate(var0) {
  var1 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  var2 = scripts\engine\utility::array_contains(level.accolades["longestStreak"].winners, self);

  if(var1 && var2) {
    return true;
  }

  return false;
}

function kills10nodeaths_evaluate(var0) {
  if(self.pers["kills"] >= 10 && self.pers["deaths"] == 0) {
    return true;
  }

  return false;
}

function nodeathsfrombehind_evaluate(var0) {
  if(self.pers["deathsFromBehind"] == 10) {
    return true;
  }

  return false;
}

function highestavgaltitude_evaluate(var0) {
  if(self.pers["averageAltitudeCount"] > 0) {
    return (self.pers["averageAltitude"] / self.pers["averageAltitudeCount"]);
  }

  return 0;
}

function lowestavgaltitude_evaluate(var0) {
  if(self.pers["averageAltitudeCount"] > 0) {
    return (self.pers["averageAltitude"] / self.pers["averageAltitudeCount"] * -1);
  }

  return 0;
}