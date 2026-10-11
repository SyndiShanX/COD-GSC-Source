/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\accolades.gsc
***********************************************/

#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace accolades;

function init() {
  level.accolades = [];

  if(!isDefined(level.var_48154008716f7116)) {
    level.var_48154008716f7116 = getdvarint(@ "hash_609906ade74f653e", 0);
  }

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
  registeraccolade("killstreakKills", ["killstreakKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAirKills", ["killstreakAirKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakGroundKills", ["killstreakGroundKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("destroyedKillstreaks", ["destroyedKillstreaks"], 0, 0, &arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakRemoteTurretKills", ["killstreakRemoteTurretKills"], 0, 0, &arekillstreaksallowed, undefined, undefined);
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
  registeraccolade("trackerGrenadeHits", ["trackerGrenadeHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("butterflyMineHits", ["butterflyMineHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("thermobaricGrenadeHits", ["thermobaricGrenadeHits"], 0, 0, undefined, undefined, undefined);
  registeraccolade("ammoBoxUsed", ["ammoBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("reconDroneMarks", ["reconDroneMarks"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("empDroneHits", ["empDroneHits"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("stoppingPowerKills", ["stoppingPowerKills"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("trophySystemHits", ["trophySystemHits"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deadSilenceKills", ["deadSilenceKills"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("tacticalInsertionSpawns", ["tacticalInsertionSpawns"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deployableCoverUsed", ["deployableCoverUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("munitionsBoxUsed", ["munitionsBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("blastshieldBoxUsed", ["blastshieldBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
  registeraccolade("selfReviveBoxUsed", ["selfReviveBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
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
  registeraccolade("armorBoxUsed", ["armorBoxUsed"], 0, 0, &arefieldupgradesallowed, undefined, undefined);
}

function registeraccolade(ref, datapoints, priority, var_b9056cc2c7e5783e, validatefunc, updatefunc, evaluatefunc) {
  assertex(!isDefined(level.accolades[ref]), "<dev string:x1c>" + ref + "<dev string:x37>");
  data = spawnStruct();
  data.datapoints = datapoints;
  data.priority = priority;
  data.intialvalueisvalid = var_b9056cc2c7e5783e;
  data.evaluatefunc = evaluatefunc;
  data.winners = [];
  data.isactive = !isDefined(validatefunc) || [[validatefunc]]();
  level.accolades[ref] = data;

  if(isDefined(updatefunc)) {
    level thread[[updatefunc]]();
  }
}

function applyaccoladestructtoplayerpers() {
  if(!level.rankedmatch) {
    return;
  }

  foreach(ref, accolade in level.accolades) {
    self setplayerdata(level.progressiongroup, "playerStats", "matchAccolades", ref, 0);

    if(!isDefined(accolade.datapoints)) {
      continue;
    }

    foreach(datapoint in accolade.datapoints) {
      initpersstat(datapoint);
    }
  }
}

function evaluateallaccolades() {
  if(!istrue(level.challengesallowed)) {
    return;
  }

  if(istrue(level.var_48154008716f7116)) {
    return;
  }

  foreach(ref, accolade in level.accolades) {
    if(!accolade.isactive) {
      continue;
    }

    level evaluateaccolade(ref);
  }

  foreach(ref, accolade in level.accolades) {
    if(!accolade.isactive) {
      continue;
    }

    foreach(winner in accolade.winners) {
      if(!isDefined(winner)) {
        continue;
      }

      oldval = winner getplayerdata(level.progressiongroup, "playerStats", "accoladeStats", ref);
      winner setplayerdata(level.progressiongroup, "playerStats", "accoladeStats", ref, oldval + 1);
      winner setplayerdata(level.progressiongroup, "playerStats", "matchAccolades", ref, 1);
    }
  }

  println("<dev string:x4b>");
  println("<dev string:x93>");
  println("<dev string:x4b>");

  foreach(ref, accolade in level.accolades) {
    if(!accolade.isactive) {
      continue;
    }

    println(ref);

    foreach(winner in accolade.winners) {
      playervalue = 0;

      if(isDefined(level.accolades[ref].evaluatefunc)) {
        playervalue = winner[[level.accolades[ref].evaluatefunc]](ref);
      } else {
        assertex(level.accolades[ref].datapoints.size == 1, "<dev string:xdb>" + ref + "<dev string:xe8>");
        playervalue = winner scripts\mp\utility\stats::getpersstat(level.accolades[ref].datapoints[0]);
      }

      println("<dev string:x124>" + playervalue + "<dev string:x129>" + winner.name);
    }

    println("<dev string:x12e>");
  }
}

function evaluateaccolade(ref) {
  highestvalue = undefined;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    playervalue = player scripts\mp\utility\stats::getpersstat(ref);

    if(isDefined(level.accolades[ref].evaluatefunc)) {
      playervalue = player[[level.accolades[ref].evaluatefunc]](ref);
    } else {
      assertex(level.accolades[ref].datapoints.size == 1, "<dev string:xdb>" + ref + "<dev string:xe8>");
      playervalue = player scripts\mp\utility\stats::getpersstat(level.accolades[ref].datapoints[0]);
    }

    if(!isDefined(playervalue) || !level.accolades[ref].intialvalueisvalid && playervalue == 0) {
      continue;
    }

    if(!isDefined(highestvalue) || playervalue > highestvalue) {
      highestvalue = playervalue;
      level.accolades[ref].winners = [];
      level.accolades[ref].winners[level.accolades[ref].winners.size] = player;
      continue;
    }

    if(playervalue == highestvalue) {
      level.accolades[ref].winners[level.accolades[ref].winners.size] = player;
    }
  }
}

function arekillcamsenabled() {
  return istrue(level.killcam);
}

function isnotleanthreadmode() {
  return !runleanthreadmode();
}

function isclasschoiceallowed() {
  gameflagwait("infil_setup_complete");
  return allowclasschoice();
}

function isreviveenabled() {
  return istrue(level.numrevives);
}

function iscorempgametype() {
  return !scripts\cp_mp\utility\game_utility::isbrstylegametype();
}

function arekillstreaksallowed() {
  return istrue(level.allowkillstreaks);
}

function arefieldupgradesallowed() {
  return istrue(level.allowsupers);
}

function isobjectivegametype() {
  return getgametype() != "war" && getgametype() != "dm" && !scripts\cp_mp\utility\game_utility::isbrstylegametype();
}

function isbombgametype() {
  return scripts\mp\gameobjects::isbombmode();
}

function iscarrygametype() {
  if(scripts\mp\gameobjects::isbombmode()) {
    return true;
  }

  switch (getgametype()) {
    case #"hash_1a5d186c17c00d3c":
    case #"hash_3a17de6e294210d2":
      return true;
  }

  return false;
}

function iscapturegametype() {
  switch (getgametype()) {
    case #"hash_ca6516c10db2c95":
    case #"hash_2f5af599c5c220d3":
    case #"hash_53825b446469ac4c":
    case #"hash_5e78ea9021845d4a":
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_6efb0f59a62300fb":
    case #"hash_7f9c384a34cc392f":
    case #"hash_cf3000550ee7e8b3":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ec24570718a340f5":
    case #"hash_ec72fd25bbbac99e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa34c5f6bd6d4432":
      return true;
  }

  return false;
}

function isctf() {
  return getgametype() == "ctf";
}

function isspawnselectionenabled() {
  return istrue(level.usespawnselection);
}

function aretagsenabled() {
  return istrue(level.dogtagsenabled);
}

function isgrind() {
  return getgametype() == "grind";
}

function isinfected() {
  return scripts\cp_mp\utility\game_utility::isinfectedgametype();
}

function isgungame() {
  return getgametype() == "gun";
}

function ishardpoint() {
  return getgametype() == "koth" || getgametype() == "koth_horde" || getgametype() == "koth_jugg" || getgametype() == "grnd";
}

function arevehiclesenabled() {
  if(namespace_ef54497d29a56093::function_5a60778277d6ae4b()) {
    return 0;
  }

  return getmatchrulesdata("commonOption", "allowVehicles");
}

function scoreminimum(ref) {
  assertex(level.accolades[ref].datapoints.size == 1, "<dev string:x133>" + ref + "<dev string:x144>");
  return scripts\mp\utility\stats::getpersstat(level.accolades[ref].datapoints[0]) * -1;
}

function nokillswithdeath_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("kills") == 0 && scripts\mp\utility\stats::getpersstat("deaths") > 0) {
    return true;
  }

  return false;
}

function nokillnodeath_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("kills") == 0 && scripts\mp\utility\stats::getpersstat("deaths") == 0) {
    return true;
  }

  return false;
}

function nokill10deaths_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("kills") == 0 && scripts\mp\utility\stats::getpersstat("deaths") >= 10) {
    return true;
  }

  return false;
}

function mostkillsleastdeaths_evaluate(ref) {
  check1 = array_contains(level.accolades["mostKills"].winners, self);
  check2 = array_contains(level.accolades["leastDeaths"].winners, self);

  if(check1 && check2) {
    return true;
  }

  return false;
}

function mostkillsmostheadshots_evaluate(ref) {
  check1 = array_contains(level.accolades["mostKills"].winners, self);
  check2 = array_contains(level.accolades["headshots"].winners, self);

  if(check1 && check2) {
    return true;
  }

  return false;
}

function mostkillslongeststreak_evaluate(ref) {
  check1 = array_contains(level.accolades["mostKills"].winners, self);
  check2 = array_contains(level.accolades["longestStreak"].winners, self);

  if(check1 && check2) {
    return true;
  }

  return false;
}

function kills10nodeaths_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("kills") >= 10 && scripts\mp\utility\stats::getpersstat("deaths") == 0) {
    return true;
  }

  return false;
}

function nodeathsfrombehind_evaluate(ref) {
  if(isDefined(self.pers) && isDefined(scripts\mp\utility\stats::getpersstat("deathsFromBehind")) && scripts\mp\utility\stats::getpersstat("deathsFromBehind") == 10) {
    return true;
  }

  return false;
}

function highestavgaltitude_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("averageAltitudeCount") > 0) {
    return (scripts\mp\utility\stats::getpersstat("averageAltitude") / scripts\mp\utility\stats::getpersstat("averageAltitudeCount"));
  }

  return 0;
}

function lowestavgaltitude_evaluate(ref) {
  if(scripts\mp\utility\stats::getpersstat("averageAltitudeCount") > 0) {
    return (scripts\mp\utility\stats::getpersstat("averageAltitude") / scripts\mp\utility\stats::getpersstat("averageAltitudeCount") * -1);
  }

  return 0;
}