/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\accolades.gsc
***********************************************/

init() {
  level.accolades = [];

  if(!isDefined(level._id_48154008716F7116))
    level._id_48154008716F7116 = getdvarint("dvar_609906ADE74F653E", 0);

  registeraccolade("adsKills", ["adsKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("hipfireKills", ["hipfireKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("lowerRankedKills", ["lowerRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("higherRankedKills", ["higherRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("highestRankedKills", ["highestRankedKills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("reloads", ["reloads"], 0, 0, undefined, undefined, undefined);
  registeraccolade("weaponPickups", ["weaponPickups"], 0, 0, undefined, undefined, undefined);
  registeraccolade("shotsFired", ["shotsFired"], 0, 0, undefined, undefined, undefined);
  registeraccolade("classChanges", ["classChanges"], 0, 0, ::isclasschoiceallowed, undefined, undefined);
  registeraccolade("headshots", ["headshots"], 0, 0, undefined, undefined, undefined);
  registeraccolade("timeWatchingKillcams", ["timeWatchingKillcams"], 0, 0, ::arekillcamsenabled, undefined, undefined);
  registeraccolade("skippedKillcams", ["skippedKillcams"], 0, 0, ::arekillcamsenabled, undefined, undefined);
  registeraccolade("longestStreak", ["longestStreak"], 0, 0, undefined, undefined, undefined);
  registeraccolade("mostKills", ["kills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastKills", ["kills"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("mostAssists", ["assists"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastAssists", ["assists"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("mostDeaths", ["deaths"], 0, 0, undefined, undefined, undefined);
  registeraccolade("leastDeaths", ["deaths"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("suicides", ["suicides"], 0, 0, undefined, undefined, undefined);
  registeraccolade("noKillsWithDeath", ["kills", "deaths"], 0, 0, undefined, undefined, ::nokillswithdeath_evaluate);
  registeraccolade("noKillNoDeath", ["kills", "deaths"], 0, 0, undefined, undefined, ::nokillnodeath_evaluate);
  registeraccolade("noKill10Deaths", ["kills", "deaths"], 0, 0, undefined, undefined, ::nokill10deaths_evaluate);
  registeraccolade("mostKillsLeastDeaths", ["kills", "deaths"], 0, 0, undefined, undefined, ::mostkillsleastdeaths_evaluate);
  registeraccolade("mostKillsMostHeadshots", ["kills", "headshots"], 0, 0, undefined, undefined, ::mostkillsmostheadshots_evaluate);
  registeraccolade("mostKillsLongestStreak", ["kills", "longestStreak"], 0, 0, undefined, undefined, ::mostkillslongeststreak_evaluate);
  registeraccolade("kills10NoDeaths", ["kills", "deaths"], 0, 0, undefined, undefined, ::kills10nodeaths_evaluate);
  registeraccolade("deathsFromBehind", ["deathsFromBehind"], 0, 0, undefined, undefined, undefined);
  registeraccolade("killsFromBehind", ["killsFromBehind"], 0, 0, undefined, undefined, undefined);
  registeraccolade("noDeathsFromBehind", ["deathsFromBehind"], 0, 1, undefined, undefined, ::nodeathsfrombehind_evaluate);
  registeraccolade("shortestLife", ["shortestLife"], 0, 0, undefined, undefined, ::scoreminimum);
  registeraccolade("longestLife", ["longestLife"], 0, 0, undefined, undefined, undefined);
  registeraccolade("damageDealt", ["damage"], 0, 0, undefined, undefined, undefined);
  registeraccolade("damageTaken", ["damageTaken"], 0, 0, undefined, undefined, undefined);
  registeraccolade("highestMultikill", ["highestMultikill"], 0, 0, undefined, undefined, undefined);
  registeraccolade("mostMultikills", ["mostMultikills"], 0, 0, undefined, undefined, undefined);
  registeraccolade("revives", ["revives"], 0, 0, ::isreviveenabled, undefined, undefined);
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
  registeraccolade("killEnemyTeam", ["killEnemyTeam"], 0, 0, ::iscorempgametype, undefined, undefined);
  registeraccolade("timeCrouched", ["timeCrouched"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("timeProne", ["timeProne"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("distanceTravelled", ["totalDistTraveled"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("highestAvgAltitude", ["averageAltitude", "averageAltitudeCount"], 0, 0, ::isnotleanthreadmode, undefined, ::highestavgaltitude_evaluate);
  registeraccolade("lowestAvgAltitude", ["averageAltitude", "averageAltitudeCount"], 0, 0, ::isnotleanthreadmode, undefined, ::lowestavgaltitude_evaluate);
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
  registeraccolade("killstreakPersonalUAVKills", ["killstreakPersonalUAVKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakShieldTurretKills", ["killstreakShieldTurretKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakUAVAssists", ["killstreakUAVAssists"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCUAVAssists", ["killstreakCUAVAssists"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCarePackageUsed", ["killstreakCarePackageUsed"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCluserStrikeKills", ["killstreakCluserStrikeKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakCruiseMissileKills", ["killstreakCruiseMissileKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAirstrikeKills", ["killstreakAirstrikeKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakTankKills", ["killstreakTankKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakSentryGunKills", ["killstreakSentryGunKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakWheelsonKills", ["killstreakWheelsonKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakEmergencyAirdropUsed", ["killstreakEmergencyAirdropUsed"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakVTOLJetKills", ["killstreakVTOLJetKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakWhitePhosphorousKillsAssists", ["killstreakWhitePhosphorousKillsAssists"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakChopperGunnerKills", ["killstreakChopperGunnerKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakChopperSupportKills", ["killstreakChopperSupportKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakGunshipKills", ["killstreakGunshipKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAUAVAssists", ["killstreakAUAVAssists"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakJuggernautKills", ["killstreakJuggernautKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakKills", ["killstreakKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakAirKills", ["killstreakAirKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("killstreakGroundKills", ["killstreakGroundKills"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("destroyedKillstreaks", ["destroyedKillstreaks"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
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
  registeraccolade("ammoBoxUsed", ["ammoBoxUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("reconDroneMarks", ["reconDroneMarks"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("empDroneHits", ["empDroneHits"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("stoppingPowerKills", ["stoppingPowerKills"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("trophySystemHits", ["trophySystemHits"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deadSilenceKills", ["deadSilenceKills"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("tacticalInsertionSpawns", ["tacticalInsertionSpawns"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("deployableCoverUsed", ["deployableCoverUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("munitionsBoxUsed", ["munitionsBoxUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("blastshieldBoxUsed", ["blastshieldBoxUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("selfReviveBoxUsed", ["selfReviveBoxUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("defends", ["defends"], 0, 0, ::isobjectivegametype, undefined, undefined);
  registeraccolade("assaults", ["assaults"], 0, 0, ::isobjectivegametype, undefined, undefined);
  registeraccolade("pickups", ["pickups"], 0, 0, ::iscarrygametype, undefined, undefined);
  registeraccolade("captures", ["captures"], 0, 0, ::iscapturegametype, undefined, undefined);
  registeraccolade("returns", ["returns"], 0, 0, ::isctf, undefined, undefined);
  registeraccolade("carrierKills", ["carrierKills"], 0, 0, ::iscarrygametype, undefined, undefined);
  registeraccolade("bombPlanted", ["plants"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("bombDefused", ["defuses"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("bombDetonated", ["destructions"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("clutch", ["clutch"], 0, 0, scripts\mp\utility\game::islifelimited, undefined, undefined);
  registeraccolade("clutchRevives", ["clutchRevives"], 0, 0, ::isreviveenabled, undefined, undefined);
  registeraccolade("tagsCaptured", ["confirmed"], 0, 0, ::aretagsenabled, undefined, undefined);
  registeraccolade("tagsDenied", ["denied"], 0, 0, ::aretagsenabled, undefined, undefined);
  registeraccolade("tagsMegaBanked", ["tagsMegaBanked"], 0, 0, ::isgrind, undefined, undefined);
  registeraccolade("tagsLargestBank", ["tagsLargestBank"], 0, 0, ::isgrind, undefined, undefined);
  registeraccolade("firstInfected", ["firstInfected"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("survivorKills", ["killsAsSurvivor"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("infectedKills", ["killsAsInfected"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("lastSurvivor", ["lastSurvivor"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("setbacks", ["setbacks"], 0, 0, ::isgungame, undefined, undefined);
  registeraccolade("longestTimeSpentOnWeapon", ["longestTimeSpentOnWeapon"], 0, 0, ::isgungame, undefined, undefined);
  registeraccolade("carepackagesCaptured", ["carepackagesCaptured"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("spawnSelectSquad", ["spawnSelectSquad"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectVehicle", ["spawnSelectVehicle"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectFlag", ["spawnSelectFlag"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("spawnSelectBase", ["spawnSelectBase"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("timesSelectedAsSquadLeader", ["timesSelectedAsSquadLeader"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("timeSpentAsDriver", ["timeSpentAsDriver"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("timeSpentAsPassenger", ["timeSpentAsPassenger"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("distanceTraveledInVehicle", ["distanceTraveledInVehicle"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("timeOnPoint", ["objTime"], 0, 0, ::ishardpoint, undefined, undefined);
  registeraccolade("armorBoxUsed", ["armorBoxUsed"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
}

registeraccolade(ref, datapoints, priority, _id_B9056CC2C7E5783E, validatefunc, updatefunc, evaluatefunc) {
  data = spawnStruct();
  data.datapoints = datapoints;
  data.priority = priority;
  data.intialvalueisvalid = _id_B9056CC2C7E5783E;
  data.evaluatefunc = evaluatefunc;
  data.winners = [];
  data.isactive = !isDefined(validatefunc) || [[validatefunc]]();
  level.accolades[ref] = data;

  if(isDefined(updatefunc))
    level thread[[updatefunc]]();
}

applyaccoladestructtoplayerpers() {
  if(!level.rankedmatch) {
    return;
  }
  foreach(ref, _id_9C106D8742ED698F in level.accolades) {
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchAccolades", ref, 0);

    if(!isDefined(_id_9C106D8742ED698F.datapoints)) {
      continue;
    }
    foreach(_id_74B0293D336B519D in _id_9C106D8742ED698F.datapoints)
    scripts\mp\utility\stats::initpersstat(_id_74B0293D336B519D);
  }
}

evaluateallaccolades() {
  if(!istrue(level.challengesallowed)) {
    return;
  }
  if(istrue(level._id_48154008716F7116)) {
    return;
  }
  foreach(ref, _id_9C106D8742ED698F in level.accolades) {
    if(!_id_9C106D8742ED698F.isactive) {
      continue;
    }
    level evaluateaccolade(ref);
  }

  foreach(ref, _id_9C106D8742ED698F in level.accolades) {
    if(!_id_9C106D8742ED698F.isactive) {
      continue;
    }
    foreach(winner in _id_9C106D8742ED698F.winners) {
      if(!isDefined(winner)) {
        continue;
      }
      _id_9DD650BC2F7C8A01 = winner getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "accoladeStats", ref);
      winner setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "accoladeStats", ref, _id_9DD650BC2F7C8A01 + 1);
      winner setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchAccolades", ref, 1);
    }
  }
}

evaluateaccolade(ref) {
  _id_87A119DD08448388 = undefined;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_C2D1738D79D98C15 = player.pers[ref];

    if(isDefined(level.accolades[ref].evaluatefunc))
      _id_C2D1738D79D98C15 = player[[level.accolades[ref].evaluatefunc]](ref);
    else
      _id_C2D1738D79D98C15 = player.pers[level.accolades[ref].datapoints[0]];

    if(!isDefined(_id_C2D1738D79D98C15) || !level.accolades[ref].intialvalueisvalid && _id_C2D1738D79D98C15 == 0) {
      continue;
    }
    if(!isDefined(_id_87A119DD08448388) || _id_C2D1738D79D98C15 > _id_87A119DD08448388) {
      _id_87A119DD08448388 = _id_C2D1738D79D98C15;
      level.accolades[ref].winners = [];
      level.accolades[ref].winners[level.accolades[ref].winners.size] = player;
      continue;
    }

    if(_id_C2D1738D79D98C15 == _id_87A119DD08448388)
      level.accolades[ref].winners[level.accolades[ref].winners.size] = player;
  }
}

arekillcamsenabled() {
  return istrue(level.killcam);
}

isnotleanthreadmode() {
  return !scripts\mp\utility\game::runleanthreadmode();
}

isclasschoiceallowed() {
  scripts\mp\flags::gameflagwait("infil_setup_complete");
  return scripts\mp\utility\game::allowclasschoice();
}

isreviveenabled() {
  return istrue(level.numrevives);
}

iscorempgametype() {
  return !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
}

arekillstreaksallowed() {
  return istrue(level.allowkillstreaks);
}

arefieldupgradesallowed() {
  return istrue(level.allowsupers);
}

isobjectivegametype() {
  return scripts\mp\utility\game::getgametype() != "war" && scripts\mp\utility\game::getgametype() != "dm" && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
}

isbombgametype() {
  return scripts\mp\gameobjects::isbombmode();
}

iscarrygametype() {
  if(scripts\mp\gameobjects::isbombmode())
    return 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "ctf":
      return 1;
  }

  return 0;
}

iscapturegametype() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "grnd":
    case "grind":
    case "koth":
    case "hq":
    case "conflict":
    case "siege":
    case "dom":
    case "risk":
    case "arena":
    case "arm":
      return 1;
  }

  return 0;
}

isctf() {
  return scripts\mp\utility\game::getgametype() == "ctf";
}

isspawnselectionenabled() {
  return istrue(level.usespawnselection);
}

aretagsenabled() {
  return istrue(level.dogtagsenabled);
}

isgrind() {
  return scripts\mp\utility\game::getgametype() == "grind";
}

isinfected() {
  return scripts\mp\utility\game::getgametype() == "infect";
}

isgungame() {
  return scripts\mp\utility\game::getgametype() == "gun";
}

ishardpoint() {
  return scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd";
}

arevehiclesenabled() {
  return getdvarint("dvar_E4FA721677F03DE0", 0) == 1;
}

scoreminimum(ref) {
  return self.pers[level.accolades[ref].datapoints[0]] * -1;
}

nokillswithdeath_evaluate(ref) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] > 0)
    return 1;

  return 0;
}

nokillnodeath_evaluate(ref) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] == 0)
    return 1;

  return 0;
}

nokill10deaths_evaluate(ref) {
  if(self.pers["kills"] == 0 && self.pers["deaths"] >= 10)
    return 1;

  return 0;
}

mostkillsleastdeaths_evaluate(ref) {
  _id_E7AF623C76844586 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  _id_E7AF613C76844353 = scripts\engine\utility::array_contains(level.accolades["leastDeaths"].winners, self);

  if(_id_E7AF623C76844586 && _id_E7AF613C76844353)
    return 1;

  return 0;
}

mostkillsmostheadshots_evaluate(ref) {
  _id_E7AF623C76844586 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  _id_E7AF613C76844353 = scripts\engine\utility::array_contains(level.accolades["headshots"].winners, self);

  if(_id_E7AF623C76844586 && _id_E7AF613C76844353)
    return 1;

  return 0;
}

mostkillslongeststreak_evaluate(ref) {
  _id_E7AF623C76844586 = scripts\engine\utility::array_contains(level.accolades["mostKills"].winners, self);
  _id_E7AF613C76844353 = scripts\engine\utility::array_contains(level.accolades["longestStreak"].winners, self);

  if(_id_E7AF623C76844586 && _id_E7AF613C76844353)
    return 1;

  return 0;
}

kills10nodeaths_evaluate(ref) {
  if(self.pers["kills"] >= 10 && self.pers["deaths"] == 0)
    return 1;

  return 0;
}

nodeathsfrombehind_evaluate(ref) {
  if(self.pers["deathsFromBehind"] == 10)
    return 1;

  return 0;
}

highestavgaltitude_evaluate(ref) {
  if(self.pers["averageAltitudeCount"] > 0)
    return self.pers["averageAltitude"] / self.pers["averageAltitudeCount"];
  else
    return 0;
}

lowestavgaltitude_evaluate(ref) {
  if(self.pers["averageAltitudeCount"] > 0)
    return self.pers["averageAltitude"] / self.pers["averageAltitudeCount"] * -1;
  else
    return 0;
}