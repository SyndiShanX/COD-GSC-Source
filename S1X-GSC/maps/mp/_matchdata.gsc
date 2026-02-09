/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_matchdata.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  PrintLn("---- _matchdata::init() ----");

  if(!isDefined(game["gamestarted"])) {
    setMatchDataDef("mp/matchdata.def");
    setMatchData("map", level.script);
    if(level.hardcoremode) {
      tmp = level.gametype + " hc";
      setMatchData("gametype", tmp);
    } else {
      setMatchData("gametype", level.gametype);
    }
    setMatchData("buildVersion", getBuildVersion());
    setMatchData("buildNumber", getBuildNumber());

    setMatchDataID();
  }

  level.MaxLives = 490;

  level.MaxEvents = 150;
  level.MaxKillstreaks = 64;
  level.MaxLogClients = 30;
  level.MaxNumChallengesPerPlayer = 5;
  level.MaxNumAwardsPerPlayer = 10;
  level.MaxLoadouts = 10;

  level thread gameEndListener();

  if(getDvar("virtualLobbyActive") != "1") {
    level thread reconLogPlayerInfo();
  }
}

matchStarted() {
  if(getDvar("virtualLobbyActive") == "1") {
    PrintLn("_matchdata::matchStarted() -- skipping because getDvar('virtualLobbyActive') == '1'");
    return;
  }
  if(getDvar("mapname") == getDvar("virtualLobbyMap")) {
    PrintLn("_matchdata::matchStarted() -- skipping because getDvar('mapname') == getDvar('virtualLobbyMap')");
    return;
  }

  PrintLn("---- _matchdata::matchStarted() ----");

  SysPrint("MatchStarted: Completed");

  playlistName = GetPlaylistName();
  setMatchData("playlistName", playlistName);

  localTimeString = GetLocalTimeString();
  setMatchData("localTimeStringAtMatchStart", localTimeString);

  if(getMatchStartTimeUTC() == 0) {
    setMatchData("startTimeUTC", getSystemTime());
  }

  setMatchData("iseSports", isMLGMatch());

  if(privateMatch()) {
    setMatchData("privateMatch", true);
  }

  if(practiceRoundGame()) {
    setMatchData("practiceRound", true);
  }

  if(!isAugmentedGameMode()) {
    setMatchData("classicMode", true);
  }

  if(isDivisionMode()) {
    setMatchData("divisionMode", true);
  }

  thread logBreadcrumbData();
  thread accumulatePlayerPingData();
}

logBreadcrumbData() {
  level endon("game_ended");
  while(1) {
    timePassedSecondsIncludingRounds = getGameTimePassedSeconds();

    foreach(player in level.players) {
      if(IsBot(player) || IsTestClient(player)) {
        continue;
      }

      if(isReallyAlive(player) && isDefined(player.lifeId) && canLogLife(player.lifeId)) {
        lastShotBy = 31;
        if(isDefined(player.lastShotBy)) {
          lastShotBy = player.lastShotBy;
        }

        RecordBreadCrumbDataForPlayer(player, player.lifeId, timePassedSecondsIncludingRounds, lastShotBy);
        player.lastShotBy = undefined;
      }
    }
    wait 2;
  }
}

accumulatePlayerPingData() {
  level endon("game_ended");
  while(1) {
    foreach(player in level.players) {
      if(IsBot(player) || IsTestClient(player)) {
        continue;
      }

      if(!isDefined(player.pers["pingAccumulation"]) || !isDefined(player.pers["minPing"]) || !isDefined(player.pers["maxPing"]) || !isDefined(player.pers["pingSampleCount"])) {
        continue;
      }
      currentPing = player GetCurrentPing();
      player.pers["pingAccumulation"] += currentPing;
      player.pers["pingSampleCount"]++;

      if(player.pers["pingSampleCount"] > 5 && currentPing > 0) {
        if(currentPing > player.pers["maxPing"]) {
          player.pers["maxPing"] = currentPing;
        }

        if(currentPing < player.pers["minPing"]) {
          player.pers["minPing"] = currentPing;
        }
      }
    }
    wait 2;
  }
}

getMatchStartTimeUTC() {
  return GetMatchData("startTimeUTC");
}

logKillstreakEvent(event, position) {
  assertEx(IsGameParticipant(self), "self is not a player: " + self.code_classname);

  if(!canLogClient(self) || !canLogKillstreak()) {
    return;
  }

  eventId = getMatchData("killstreakCount");
  setMatchData("killstreakCount", eventId + 1);

  setMatchData("killstreaks", eventId, "eventType", event);
  setMatchData("killstreaks", eventId, "player", self.clientid);
  setMatchData("killstreaks", eventId, "eventStartTimeDeciSecondsFromMatchStart", getTimePassedDeciSeconds());
  setMatchData("killstreaks", eventId, "eventPos", 0, int(position[0]));
  setMatchData("killstreaks", eventId, "eventPos", 1, int(position[1]));
  setMatchData("killstreaks", eventId, "eventPos", 2, int(position[2]));
  setMatchData("killstreaks", eventId, "index", eventId);
  setMatchData("killstreaks", eventId, "coopPlayerIndex", 255);

  self.currentKillStreakIndex = eventId;

  ReconSpatialEvent(position, "script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d", event, self.name, self.clientid, getTime());
}

logGameEvent(event, position) {
  assertEx(IsGameParticipant(self), "self is not a player: " + self.code_classname);

  if(!canLogClient(self) || !canLogEvent()) {
    return;
  }

  eventId = getMatchData("eventCount");
  setMatchData("eventCount", eventId + 1);

  setMatchData("events", eventId, "eventType", event);
  setMatchData("events", eventId, "player", self.clientid);
  setMatchData("events", eventId, "eventTimeDeciSecondsFromMatchStart", getTimePassedDeciSeconds());
  setMatchData("events", eventId, "eventPos", 0, int(position[0]));
  setMatchData("events", eventId, "eventPos", 1, int(position[1]));
  setMatchData("events", eventId, "eventPos", 2, int(position[2]));

  ReconSpatialEvent(position, "script_mp_event: event_type %s, player_name %s, player %d, gameTime %d", event, self.name, self.clientid, getTime());
}

logKillEvent(lifeId, eventRef) {
  if(!canLogLife(lifeId)) {
    return;
  }

  setMatchData("lives", lifeId, "modifiers", eventRef, true);
}

logMultiKill(lifeId, multikillCount) {
  if(!canLogLife(lifeId)) {
    return;
  }

  setMatchData("lives", lifeId, "multikill", multikillCount);
}

logPlayerLife(died) {
  if(!canLogClient(self) || !canLogLife(self.lifeId)) {
    return;
  }

  lifeDuration = getTime() - self.spawnTime;
  self.totalLifeTime += lifeDuration;
  lifeDurationDeciSeconds = convertMillisecondsToDeciSecondsAndClampToShort(lifeDuration);

  setMatchData("lives", self.lifeId, "player", self.clientid);
  setMatchData("lives", self.lifeId, "spawnPos", 0, int(self.spawnPos[0]));
  setMatchData("lives", self.lifeId, "spawnPos", 1, int(self.spawnPos[1]));
  setMatchData("lives", self.lifeId, "spawnPos", 2, int(self.spawnPos[2]));
  setMatchData("lives", self.lifeId, "wasTacticalInsertion", self.wasTI);
  setMatchData("lives", self.lifeId, "team", self.team);

  if(isDefined(self.spawnTimeDeciSecondsFromMatchStart)) {
    setMatchData("lives", self.lifeId, "spawnTimeDeciSecondsFromMatchStart", self.spawnTimeDeciSecondsFromMatchStart);
  } else {
    setMatchData("lives", self.lifeId, "spawnTimeDeciSecondsFromMatchStart", -1);
  }

  setMatchData("lives", self.lifeId, "durationDeciSeconds", lifeDurationDeciSeconds);

  loadoutIndex = self logLoadout();
  setMatchData("lives", self.lifeId, "loadoutIndex", loadoutIndex);

  score = clampToShort(self.pers["score"] - self.scoreAtLifeStart);
  setMatchData("lives", self.lifeId, "scoreEarnedDuringThisLife", score);

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
    if(isDefined(self.xpAtLifeStart)) {
      xp = clampToShort(self.pers["summary"]["xp"] - self.xpAtLifeStart);
      setMatchData("lives", self.lifeId, "xpEarnedDuringThisLife", xp);
    }
  }

}

logPlayerXP(xp, xpName) {
  if(!canLogClient(self)) {
    return;
  }
  setMatchData("players", self.clientid, xpName, xp);
}

logCompletedChallenge(challengeID) {
  if(!isPlayer(self) || !canLogClient(self) || isBot(self)) {
    return;
  }

  numCompletedChallenges = getMatchData("players", self.clientid, "challengeCount");
  if(numCompletedChallenges < level.MaxNumChallengesPerPlayer) {
    setMatchData("players", self.clientid, "challenges", numCompletedChallenges, challengeID);
    setMatchData("players", self.clientid, "challengeCount", numCompletedChallenges + 1);
  }
}

logLoadout() {
  noSlotValue = 255;
  if(!canLogClient(self) || !canLogLife(self.lifeId) || self.curClass == "gamemode") {
    return noSlotValue;
  }

  class = self.curClass;

  slot = 0;
  for(slot = 0; slot < level.MaxLoadouts; slot++) {
    slotUsed = getMatchData("players", self.clientid, "loadouts", slot, "slotUsed");
    if(!slotUsed) {
      break;
    } else {
      className = getMatchData("players", self.clientid, "loadouts", slot, "className");
      if(class == className) {
        return slot;
      }
    }
  }
  if(slot == level.MaxLoadouts) {
    PrintLn(" WARNING: trying to log loadout information and no more Player.loadouts slots available! ");
    return noSlotValue;
  }

  setMatchData("players", self.clientid, "loadouts", slot, "slotUsed", true);
  setMatchData("players", self.clientid, "loadouts", slot, "className", class);

  loadoutKillstreak1 = "";
  loadoutKillstreak2 = "";
  loadoutKillstreak3 = "";
  loadoutKillstreak4 = "";

  loadoutPerks = [];
  loadoutWildcards = [];

  loadoutEquipment = "";
  loadoutEquipmentExtra = false;
  loadoutOffhand = "";
  loadoutOffhand2 = "";
  loadoutOffhandExtra = false;

  if(class == "copycat") {
    clonedLoadout = self.pers["copyCatLoadout"];

    loadoutPrimary = clonedLoadout["loadoutPrimary"];
    loadoutPrimaryAttachment = clonedLoadout["loadoutPrimaryAttachment"];
    loadoutPrimaryAttachment2 = clonedLoadout["loadoutPrimaryAttachment2"];
    loadoutPrimaryAttachment3 = clonedLoadout["loadoutPrimaryAttachment3"];
    loadoutPrimaryCamo = clonedLoadout["loadoutPrimaryCamo"];
    loadoutPrimaryReticle = clonedLoadout["loadoutPrimaryReticle"];

    loadoutSecondary = clonedLoadout["loadoutSecondary"];
    loadoutSecondaryAttachment = clonedLoadout["loadoutSecondaryAttachment"];
    loadoutSecondaryAttachment2 = clonedLoadout["loadoutSecondaryAttachment2"];
    loadoutSecondaryCamo = clonedLoadout["loadoutSecondaryCamo"];
    loadoutSecondaryReticle = clonedLoadout["loadoutSecondaryReticle"];

    loadoutEquipment = clonedLoadout["loadoutEquipment"];
    loadoutEquipmentExtra = clonedLoadout["loadoutEquipmentExtra"];
    loadoutOffhand = clonedLoadout["loadoutOffhand"];
    loadoutOffhandExtra = clonedLoadout["loadoutOffhandExtra"];

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = clonedLoadout["loadoutPerks"][i];
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = clonedLoadout["loadoutWildcards"][i];
    }

    loadoutKillstreak1 = clonedLoadout["loadoutKillstreaks"][0];
    loadoutKillstreak1ModuleA = clonedLoadout["loadoutKillstreakModules"][0][0];
    loadoutKillstreak1ModuleB = clonedLoadout["loadoutKillstreakModules"][0][1];
    loadoutKillstreak1ModuleC = clonedLoadout["loadoutKillstreakModules"][0][2];
    loadoutKillstreak2 = clonedLoadout["loadoutKillstreaks"][1];
    loadoutKillstreak2ModuleA = clonedLoadout["loadoutKillstreakModules"][1][0];
    loadoutKillstreak2ModuleB = clonedLoadout["loadoutKillstreakModules"][1][1];
    loadoutKillstreak2ModuleC = clonedLoadout["loadoutKillstreakModules"][1][2];
    loadoutKillstreak3 = clonedLoadout["loadoutKillstreaks"][2];
    loadoutKillstreak3ModuleA = clonedLoadout["loadoutKillstreakModules"][2][0];
    loadoutKillstreak3ModuleB = clonedLoadout["loadoutKillstreakModules"][2][1];
    loadoutKillstreak3ModuleC = clonedLoadout["loadoutKillstreakModules"][2][2];
    loadoutKillstreak4 = clonedLoadout["loadoutKillstreaks"][3];
    loadoutKillstreak4ModuleA = clonedLoadout["loadoutKillstreakModules"][3][0];
    loadoutKillstreak4ModuleB = clonedLoadout["loadoutKillstreakModules"][3][1];
    loadoutKillstreak4ModuleC = clonedLoadout["loadoutKillstreakModules"][3][2];

    assert(isDefined(loadoutKillstreak1));
    assert(isDefined(loadoutKillstreak2));
    assert(isDefined(loadoutKillstreak3));
    assert(isDefined(loadoutKillstreak4));
  } else if(isSubstr(class, "custom")) {
    class_num = getClassIndex(class);

    loadoutPrimary = maps\mp\gametypes\_class::cac_getWeapon(class_num, 0);
    loadoutPrimaryAttachment = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 0);
    loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 0);
    loadoutPrimaryAttachment3 = maps\mp\gametypes\_class::cac_getWeaponAttachmentThree(class_num, 0);
    loadoutPrimaryCamo = maps\mp\gametypes\_class::cac_getWeaponCamo(class_num, 0);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = maps\mp\gametypes\_class::cac_getPerk(class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = maps\mp\gametypes\_class::cac_getWildcard(class_num, i);
    }

    loadoutSecondary = maps\mp\gametypes\_class::cac_getWeapon(class_num, 1);
    loadoutSecondaryAttachment = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 1);
    loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 1);
    loadoutSecondaryCamo = maps\mp\gametypes\_class::cac_getWeaponCamo(class_num, 1);

    loadoutEquipment = maps\mp\gametypes\_class::cac_getEquipment(class_num, 0);
    loadoutEquipmentExtra = maps\mp\gametypes\_class::cac_getEquipmentExtra(class_num, 0);
    loadoutOffhand = maps\mp\gametypes\_class::cac_getOffhand(class_num);

    loadoutKillstreak1 = maps\mp\gametypes\_class::cac_getKillstreak(class_num, 0);
    loadoutKillstreak1ModuleA = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 0, 0);
    loadoutKillstreak1ModuleB = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 0, 1);
    loadoutKillstreak1ModuleC = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 0, 2);
    loadoutKillstreak2 = maps\mp\gametypes\_class::cac_getKillstreak(class_num, 1);
    loadoutKillstreak2ModuleA = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 1, 0);
    loadoutKillstreak2ModuleB = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 1, 1);
    loadoutKillstreak2ModuleC = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 1, 2);
    loadoutKillstreak3 = maps\mp\gametypes\_class::cac_getKillstreak(class_num, 2);
    loadoutKillstreak3ModuleA = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 2, 0);
    loadoutKillstreak3ModuleB = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 2, 1);
    loadoutKillstreak3ModuleC = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 2, 2);
    loadoutKillstreak4 = maps\mp\gametypes\_class::cac_getKillstreak(class_num, 3);
    loadoutKillstreak4ModuleA = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 3, 0);
    loadoutKillstreak4ModuleB = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 3, 1);
    loadoutKillstreak4ModuleC = maps\mp\gametypes\_class::cac_getKillstreakModule(class_num, 3, 2);

    assert(isDefined(loadoutKillstreak1));
    assert(isDefined(loadoutKillstreak2));
    assert(isDefined(loadoutKillstreak3));
    assert(isDefined(loadoutKillstreak4));
  } else if(IsSubStr(class, "practice")) {
    class_num = getClassIndex(class);

    class_num = self.pers["practiceRoundClasses"][class_num];

    loadoutPrimary = maps\mp\gametypes\_class::table_getWeapon(level.practiceRoundClassTableName, class_num, 0);
    loadoutPrimaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 2);
    loadoutPrimaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 0);

    loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon(level.practiceRoundClassTableName, class_num, 1);
    loadoutSecondaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 1);
    loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 1);

    loadoutEquipment = maps\mp\gametypes\_class::table_getEquipment(level.practiceRoundClassTableName, class_num);
    loadoutEquipmentExtra = maps\mp\gametypes\_class::table_getEquipmentExtra(level.practiceRoundClassTableName, class_num);
    loadoutOffhand = maps\mp\gametypes\_class::table_getOffhand(level.practiceRoundClassTableName, class_num);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = maps\mp\gametypes\_class::table_getPerk(level.practiceRoundClassTableName, class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = maps\mp\gametypes\_class::table_getWildcard(level.practiceRoundClassTableName, class_num, i);
    }

    loadoutKillstreak1 = maps\mp\gametypes\_class::table_getKillstreak(level.practiceRoundClassTableName, class_num, 0);
    loadoutKillstreak1ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 0, 0);
    loadoutKillstreak1ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 0, 1);
    loadoutKillstreak1ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 0, 2);
    loadoutKillstreak2 = maps\mp\gametypes\_class::table_getKillstreak(level.practiceRoundClassTableName, class_num, 1);
    loadoutKillstreak2ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 1, 0);
    loadoutKillstreak2ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 1, 1);
    loadoutKillstreak2ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 1, 2);
    loadoutKillstreak3 = maps\mp\gametypes\_class::table_getKillstreak(level.practiceRoundClassTableName, class_num, 2);
    loadoutKillstreak3ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 2, 0);
    loadoutKillstreak3ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 2, 1);
    loadoutKillstreak3ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 2, 2);
    loadoutKillstreak4 = maps\mp\gametypes\_class::table_getKillstreak(level.practiceRoundClassTableName, class_num, 3);
    loadoutKillstreak4ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 3, 0);
    loadoutKillstreak4ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 3, 1);
    loadoutKillstreak4ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.practiceRoundClassTableName, class_num, 3, 2);

    assert(isDefined(loadoutKillstreak1));
    assert(isDefined(loadoutKillstreak2));
    assert(isDefined(loadoutKillstreak3));
    assert(isDefined(loadoutKillstreak4));
  } else {
    class_num = getClassIndex(class);

    loadoutPrimary = maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 0);
    loadoutPrimaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 2);
    loadoutPrimaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo(level.classTableName, class_num, 0);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = maps\mp\gametypes\_class::table_getPerk(level.classTableName, class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = maps\mp\gametypes\_class::table_getWildcard(level.classTableName, class_num, i);
    }

    loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 1);
    loadoutSecondaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 1);;
    loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo(level.classTableName, class_num, 1);

    loadoutEquipment = maps\mp\gametypes\_class::table_getEquipment(level.classTableName, class_num);
    loadoutEquipmentExtra = maps\mp\gametypes\_class::table_getEquipmentExtra(level.classTableName, class_num);
    loadoutOffhand = maps\mp\gametypes\_class::table_getOffhand(level.classTableName, class_num);

    loadoutKillstreak1 = maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 0);
    loadoutKillstreak1ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 0, 0);
    loadoutKillstreak1ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 0, 1);
    loadoutKillstreak1ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 0, 2);
    loadoutKillstreak2 = maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 1);
    loadoutKillstreak2ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 1, 0);
    loadoutKillstreak2ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 1, 1);
    loadoutKillstreak2ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 1, 2);
    loadoutKillstreak3 = maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 2);
    loadoutKillstreak3ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 2, 0);
    loadoutKillstreak3ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 2, 1);
    loadoutKillstreak3ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 2, 2);
    loadoutKillstreak4 = maps\mp\gametypes\_class::table_getKillstreak(level.classTableName, class_num, 3);
    loadoutKillstreak4ModuleA = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 3, 0);
    loadoutKillstreak4ModuleB = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 3, 1);
    loadoutKillstreak4ModuleC = maps\mp\gametypes\_class::table_getKillstreakModule(level.classTableName, class_num, 3, 2);

    assert(isDefined(loadoutKillstreak1));
    assert(isDefined(loadoutKillstreak2));
    assert(isDefined(loadoutKillstreak3));
    assert(isDefined(loadoutKillstreak4));
  }

  loadoutPrimaryAttachment = attachmentMap_toBase(loadoutPrimaryAttachment);
  loadoutPrimaryAttachment2 = attachmentMap_toBase(loadoutPrimaryAttachment2);
  loadoutPrimaryAttachment3 = attachmentMap_toBase(loadoutPrimaryAttachment3);
  loadoutSecondaryAttachment = attachmentMap_toBase(loadoutSecondaryAttachment);
  loadoutSecondaryAttachment2 = attachmentMap_toBase(loadoutSecondaryAttachment2);

  setMatchData("players", self.clientid, "loadouts", slot, "primaryWeapon", loadoutPrimary);
  setMatchData("players", self.clientid, "loadouts", slot, "primaryAttachments", 0, loadoutPrimaryAttachment);
  setMatchData("players", self.clientid, "loadouts", slot, "primaryAttachments", 1, loadoutPrimaryAttachment2);
  setMatchData("players", self.clientid, "loadouts", slot, "primaryAttachments", 2, loadoutPrimaryAttachment3);

  for(i = 0; i < 6; i++) {
    setMatchData("players", self.clientid, "loadouts", slot, "perkSlots", i, loadoutPerks[i]);
  }

  for(i = 0; i < 3; i++) {
    setMatchData("players", self.clientid, "loadouts", slot, "wildcardSlots", i, loadoutWildcards[i]);
  }

  setMatchData("players", self.clientid, "loadouts", slot, "secondaryWeapon", loadoutSecondary);
  setMatchData("players", self.clientid, "loadouts", slot, "secondaryAttachments", 0, loadoutSecondaryAttachment);
  setMatchData("players", self.clientid, "loadouts", slot, "secondaryAttachments", 1, loadoutSecondaryAttachment2);

  setMatchData("players", self.clientid, "loadouts", slot, "offhandWeapons", 0, loadoutOffhand);

  setMatchData("players", self.clientid, "loadouts", slot, "equipment", 0, loadoutEquipment);

  setMatchData("players", self.clientid, "loadouts", slot, "equipmentWeaponExtra", loadoutEquipmentExtra);

  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 0, "streak", loadoutKillstreak1);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 0, "modules", 0, loadoutKillstreak1ModuleA);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 0, "modules", 1, loadoutKillstreak1ModuleB);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 0, "modules", 2, loadoutKillstreak1ModuleC);

  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 1, "streak", loadoutKillstreak2);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 1, "modules", 0, loadoutKillstreak2ModuleA);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 1, "modules", 1, loadoutKillstreak2ModuleB);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 1, "modules", 2, loadoutKillstreak2ModuleC);

  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 2, "streak", loadoutKillstreak3);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 2, "modules", 0, loadoutKillstreak3ModuleA);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 2, "modules", 1, loadoutKillstreak3ModuleB);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 2, "modules", 2, loadoutKillstreak3ModuleC);

  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 3, "streak", loadoutKillstreak4);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 3, "modules", 0, loadoutKillstreak4ModuleA);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 3, "modules", 1, loadoutKillstreak4ModuleB);
  SetMatchData("players", self.clientid, "loadouts", slot, "assaultStreaks", 3, "modules", 2, loadoutKillstreak4ModuleC);

  thread recon_log_loadout(self, loadoutPrimary, loadoutPrimaryAttachment, loadoutPrimaryAttachment2, loadoutPrimaryAttachment3, loadoutPrimaryCamo, loadoutSecondary, loadoutSecondaryAttachment, loadoutSecondaryAttachment2, loadoutSecondaryCamo, loadoutEquipment, loadoutEquipmentExtra, loadoutOffhand, loadoutPerks[0], loadoutPerks[1], loadoutPerks[2], loadoutPerks[3], loadoutPerks[4], loadoutPerks[5], loadoutWildcards[0], loadoutWildcards[1], loadoutWildcards[2], loadoutKillstreak1, loadoutKillstreak1ModuleA, loadoutKillstreak1ModuleB, loadoutKillstreak1ModuleC, loadoutKillstreak2, loadoutKillstreak2ModuleA, loadoutKillstreak2ModuleB, loadoutKillstreak2ModuleC, loadoutKillstreak3, loadoutKillstreak3ModuleA, loadoutKillstreak3ModuleB, loadoutKillstreak3ModuleC, loadoutKillstreak4, loadoutKillstreak4ModuleA, loadoutKillstreak4ModuleB, loadoutKillstreak4ModuleC);

  return slot;
}

recon_log_loadout(player, primary_weapon, primary_attach_1, primary_attach_2, primary_attach_3, primary_camo, secondary_weapon, secondary_attach_1, secondary_attach_2, secondary_camo, equipment, equipment_extra, exo_ability, perk_1, perk_2, perk_3, perk_4, perk_5, perk_6, wildcard_1, wildcard_2, wildcard_3, killstreak_1, killstreak_1_module_a, killstreak_1_module_b, killstreak_1_module_c, killstreak_2, killstreak_2_module_a, killstreak_2_module_b, killstreak_2_module_c, killstreak_3, killstreak_3_module_a, killstreak_3_module_b, killstreak_3_module_c, killstreak_4, killstreak_4_module_a, killstreak_4_module_b, killstreak_4_module_c) {
  is_bot = isBot(player) || IsTestClient(player);
  script_file = "_matchdata.gsc";
  gameTime = player.spawnTime;
  class = player.curClass;
  player_name = player.name;

  ReconEvent("script_mp_loadout_gear: script_file %s, gameTime %d, player_name %s, is_bot %b, class %s, primary_weapon %s, primary_attach_1 %s, primary_attach_2 %s, primary_attach_3 %s, primary_camo %s, secondary_weapon %s, secondary_attach_1 %s, secondary_attach_2 %s, secondary_camo %s, equipment %s, equipment_extra %b, exo_ability %s", script_file, gameTime, player_name, is_bot, class, primary_weapon, primary_attach_1, primary_attach_2, primary_attach_3, primary_camo, secondary_weapon, secondary_attach_1, secondary_attach_2, secondary_camo, equipment, equipment_extra, exo_ability);

  ReconEvent("script_mp_loadout_perks: script_file %s, gameTime %d, player_name %s, perk_1 %s, perk_2 %s, perk_3 %s, perk_4 %s, perk_5 %s, perk_6 %s, wildcard_1 %s, wildcard_2 %s, wildcard_3 %s", script_file, gameTime, player_name, perk_1, perk_2, perk_3, perk_4, perk_5, perk_6, wildcard_1, wildcard_2, wildcard_3);

  ReconEvent("script_mp_loadout_killstreaks: script_file %s, gameTime %d, player_name %s, killstreak_1 %s, killstreak_1_module_a %s, killstreak_1_module_b %s, killstreak_1_module_c %s, killstreak_2 %s, killstreak_2_module_a %s, killstreak_2_module_b %s, killstreak_2_module_c %s, killstreak_3 %s, killstreak_3_module_a %s, killstreak_3_module_b %s, killstreak_3_module_c %s, killstreak_4 %s, killstreak_4_module_a %s, killstreak_4_module_b %s, killstreak_4_module_c %s", script_file, gameTime, player_name, killstreak_1, killstreak_1_module_a, killstreak_1_module_b, killstreak_1_module_c, killstreak_2, killstreak_2_module_a, killstreak_2_module_b, killstreak_2_module_c, killstreak_3, killstreak_3_module_a, killstreak_3_module_b, killstreak_3_module_c, killstreak_4, killstreak_4_module_a, killstreak_4_module_b, killstreak_4_module_c);
}

logPlayerAndKillerExoMoveData(lifeId, killer) {
  if(!canLogClient(self) || (isPlayer(killer) && !canLogClient(killer)) || !canLogLife(lifeId)) {
    return;
  }

  if(lifeId >= level.MaxLives) {
    return;
  }

  currentDeciSeconds = getTimePassedDeciSecondsIncludingRounds();

  if(isDefined(self.exoCount["exo_boost"]) && isDefined(self.exoMostRecentTimeDeciSeconds["exo_boost"])) {
    setMatchData("lives", lifeId, "numberOfBoosts", self.exoCount["exo_boost"]);
    diffTime = clampToByte(currentDeciSeconds - self.exoMostRecentTimeDeciSeconds["exo_boost"]);
    setMatchData("lives", lifeId, "victimDeciSecondsSinceLastBoost", diffTime);
  }
  if(isDefined(self.exoCount["ground_slam"]) && isDefined(self.exoMostRecentTimeDeciSeconds["ground_slam"])) {
    setMatchData("lives", lifeId, "numberOfBoostsSlams", self.exoCount["ground_slam"]);
    diffTime = clampToByte(currentDeciSeconds - self.exoMostRecentTimeDeciSeconds["ground_slam"]);
    setMatchData("lives", lifeId, "victimDeciSecondsSinceLastBoostSlam", diffTime);
  }
  if(isDefined(self.exoCount["exo_dodge"]) && isDefined(self.exoMostRecentTimeDeciSeconds["exo_dodge"])) {
    setMatchData("lives", lifeId, "numberOfDodges", self.exoCount["exo_dodge"]);
    diffTime = clampToByte(currentDeciSeconds - self.exoMostRecentTimeDeciSeconds["exo_dodge"]);
    setMatchData("lives", lifeId, "victimDeciSecondsSinceLastDodge", diffTime);
  }
  if(isDefined(self.exoCount["exo_slide"])) {
    setMatchData("lives", lifeId, "numberOfKneeSlides", self.exoCount["exo_slide"]);
  }

  if(isPlayer(killer)) {
    if(!isDefined(killer.exoMostRecentTimeDeciSeconds)) {
      return;
    }

    if(isDefined(killer.exoMostRecentTimeDeciSeconds["exo_boost"])) {
      diffTime = clampToByte(currentDeciSeconds - killer.exoMostRecentTimeDeciSeconds["exo_boost"]);
      setMatchData("lives", lifeId, "killerDeciSecondsSinceLastBoost", diffTime);
    }
    if(isDefined(killer.exoMostRecentTimeDeciSeconds["ground_slam"])) {
      diffTime = clampToByte(currentDeciSeconds - killer.exoMostRecentTimeDeciSeconds["ground_slam"]);
      setMatchData("lives", lifeId, "killerDeciSecondsSinceLastBoostSlam", diffTime);
    }
    if(isDefined(killer.exoMostRecentTimeDeciSeconds["exo_dodge"])) {
      diffTime = clampToByte(currentDeciSeconds - killer.exoMostRecentTimeDeciSeconds["exo_dodge"]);
      setMatchData("lives", lifeId, "killerDeciSecondsSinceLastDodge", diffTime);
    }
  }
}

logPlayerAndKillerADSandFOV(lifeId, killer) {
  if(!canLogClient(self) || (isPlayer(killer) && !canLogClient(killer)) || !canLogLife(lifeId)) {
    return;
  }

  if(lifeId >= level.MaxLives) {
    return;
  }

  if(isPlayer(killer)) {
    if(killer PlayerAds() > 0.5) {
      setMatchData("lives", lifeId, "killerWasADS", true);
    }

    killerEye = killer getEye();
    if(within_fov(killerEye, killer.angles, self.origin, cos(GetDvarFloat("cg_fov")))) {
      setMatchData("lives", lifeId, "victimWasInKillersFOV", true);
    }
    victimEye = self getEye();
    if(within_fov(victimEye, self.angles, killer.origin, cos(GetDvarFloat("cg_fov")))) {
      setMatchData("lives", lifeId, "killerWasInVictimsFOV", true);
    }
  }

  if(self PlayerAds() > 0.5) {
    setMatchData("lives", lifeId, "victimWasADS", true);
  }
}

logPlayerAndKillerShieldCloakHoverActive(lifeId, killer) {
  if(!canLogClient(self) || (isPlayer(killer) && !canLogClient(killer)) || !canLogLife(lifeId)) {
    return;
  }

  if(lifeId >= level.MaxLives) {
    return;
  }

  if(isDefined(self.exo_shield_on) && self.exo_shield_on) {
    setMatchData("lives", lifeId, "victimShieldActive", true);
  }
  if(isDefined(self.exo_hover_on) && self.exo_hover_on) {
    setMatchData("lives", lifeId, "victimHoverActive", true);
  }
  if(self IsCloaked()) {
    setMatchData("lives", lifeId, "victimCloakingActive", true);
  }

  if(isPlayer(killer)) {
    if(isDefined(killer.exo_shield_on) && killer.exo_shield_on) {
      setMatchData("lives", lifeId, "killerShieldActive", true);
    }
    if(isDefined(killer.exo_hover_on) && killer.exo_hover_on) {
      setMatchData("lives", lifeId, "killerHoverActive", true);
    }
    if(killer IsCloaked()) {
      setMatchData("lives", lifeId, "killerCloakingActive", true);
    }
  }
}

determineWeaponNameAndAttachments(weaponNameFull, primaryWeapon) {
  weaponType = undefined;
  weaponClass = undefined;

  if(weaponNameFull == "none") {
    weaponType = "none";
    weaponClass = "none";
  } else {
    weaponType = weaponInventoryType(weaponNameFull);
    weaponClass = weaponClass(weaponNameFull);
  }

  if(isSubstr(weaponNameFull, "destructible")) {
    weaponNameFull = "destructible";
  }

  attachments = [];
  attachments[0] = "None";
  attachments[1] = "None";
  attachments[2] = "None";

  weaponName = "";

  if(isDefined(weaponType) && (weaponType == "primary" || weaponType == "altmode") && (weaponClass == "pistol" || weaponClass == "smg" || weaponClass == "rifle" || weaponClass == "spread" || weaponClass == "mg" || weaponClass == "grenade" || weaponClass == "rocketlauncher" || weaponClass == "sniper" || weaponClass == "cone" || weaponClass == "beam" || weaponClass == "shield")) {
    if(weaponType == "altmode") {
      if(isDefined(primaryWeapon)) {
        weaponNameFull = primaryWeapon;
      }
    }

    assertEx(isDefined(weaponNameFull), "No weapon defined in _matchdata::determineWeaponEnumAndAttachments");

    weaponTokens = getWeaponNameTokens(weaponNameFull);
    weaponName = getBaseWeaponName(weaponNameFull);

    if(weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6") {
      assert(weaponTokens.size > 1);

      weaponAttachments = GetWeaponAttachments(weaponNameFull);

      i = 0;
      foreach(weaponAtt in weaponAttachments) {
        if(!isAttachment(weaponAtt)) {
          continue;
        }

        weaponAttachment = attachmentMap_toBase(weaponAtt);
        assert(i <= 2);
        if(i <= 2) {
          attachments[i] = weaponAttachment;
          i++;
        } else {
          break;
        }
      }
    } else if(weaponTokens[0] == "alt") {
      assert(weaponTokens.size > 1);

      baseMW5WeaponName = weaponTokens[1] + "_" + weaponTokens[2];

      weaponName = baseMW5WeaponName;

      if(isDefined(weaponTokens[4]) && isAttachment(weaponTokens[4])) {
        weaponAttachment = attachmentMap_toBase(weaponTokens[4]);
        attachments[0] = weaponAttachment;
      }

      if(isDefined(weaponTokens[5]) && isAttachment(weaponTokens[5])) {
        weaponAttachment = attachmentMap_toBase(weaponTokens[5]);
        attachments[1] = weaponAttachment;
      }
    } else {
      assert(weaponTokens.size > 1 && weaponTokens.size < 4);

      assertEx(weaponTokens[weaponTokens.size - 1] == "mp", "weaponTokens[weaponTokens.size - 1]: " + weaponTokens[weaponTokens.size - 1]);
      weaponTokens[weaponTokens.size - 1] = undefined;

      if(isDefined(weaponTokens[1]) && weaponType != "altmode") {
        weaponAttachment = attachmentMap_toBase(weaponTokens[1]);
        attachments[0] = weaponAttachment;
      }

      if(isDefined(weaponTokens[2]) && weaponType != "altmode") {
        weaponAttachment = attachmentMap_toBase(weaponTokens[2]);
        attachments[1] = weaponAttachment;
      }
    }
  } else if(weaponType == "item" || weaponType == "offhand") {
    weaponName = maps\mp\_utility::strip_suffix(weaponNameFull, "_lefthand");
    weaponName = maps\mp\_utility::strip_suffix(weaponName, "_mp");
  } else {
    weaponName = weaponNameFull;
  }

  returnStruct = spawnStruct();
  returnStruct.weaponName = weaponName;
  returnStruct.attachments = attachments;
  returnStruct.weaponType = weaponType;
  returnStruct.weaponClass = weaponClass;
  returnStruct.weaponNameFull = weaponNameFull;

  return returnStruct;
}

logFirefightShotsHits(lifeId, killer) {
  if(!canLogClient(self) || (isPlayer(killer) && !canLogClient(killer)) || !canLogLife(lifeId)) {
    return;
  }

  if(!isPlayer(killer)) {
    return;
  }

  if(lifeId >= level.MaxLives) {
    return;
  }

  if(self.currentFirefightShots > 0) {
    setMatchData("lives", lifeId, "shots", clampToByte(self.currentFirefightShots));
  }
  if(isDefined(killer.enemyHitCounts) && isDefined(killer.enemyHitCounts[self.guid]) && killer.enemyHitCounts[self.guid] > 0) {
    setMatchData("lives", lifeId, "hits", clampToByte(killer.enemyHitCounts[self.guid]));
  }

  if(killer.currentFirefightShots > 0) {
    setMatchData("lives", lifeId, "killerShots", clampToByte(killer.currentFirefightShots));
  }

  if(isDefined(self.enemyHitCounts) && isDefined(self.enemyHitCounts[killer.guid]) && self.enemyHitCounts[killer.guid] > 0) {
    setMatchData("lives", lifeId, "killerHits", clampToByte(self.enemyHitCounts[killer.guid]));
  }
}

logPlayerAndKillerStanceAndMotionState(lifeId, attacker) {
  if(!canLogLife(lifeId)) {
    return;
  }

  if(isPlayer(self) && canLogClient(self)) {
    stanceAndMotionState = GetStanceAndMotionStateForPlayer(self);
    setMatchData("lives", lifeId, "victimStanceAndMotionState", stanceAndMotionState);
  }
  if(isPlayer(attacker) && canLogClient(attacker)) {
    stanceAndMotionState = GetStanceAndMotionStateForPlayer(attacker);
    setMatchData("lives", lifeId, "killerStanceAndMotionState", stanceAndMotionState);
  }
}

logAssists(lifeId, attacker) {
  if(!canLogLife(lifeId)) {
    return;
  }

  if(isPlayer(self) && canLogClient(self)) {
    if(isDefined(self.attackerData)) {
      slot = 0;
      foreach(attackerStruct in self.attackerData) {
        if(isPlayer(attackerStruct.attackerEnt)) {
          if(attackerStruct.attackerEnt != attacker) {
            setMatchData("lives", lifeId, "assists", slot, "assistingPlayerIndex", attackerStruct.attackerEnt.clientid);
            setMatchData("lives", lifeId, "assists", slot, "damage", clampToByte(attackerStruct.damage));
            slot++;
            if(slot == 5) {
              break;
            }
          }
        }
      }
      if(slot < 5) {
        for(i = slot; i < 5; i++) {
          setMatchData("lives", lifeId, "assists", i, "assistingPlayerIndex", 255);
        }
      }
    }
  }
}

logSpecialAssists(attacker, xpevent) {
  if(!isPlayer(self) || !canLogClient(self)) {
    return;
  }

  if(!isPlayer(attacker) || !canLogClient(attacker)) {
    return;
  }

  lifeId = self.lifeId;

  if(!canLogLife(lifeId)) {
    return;
  }

  if(xpevent == "assist_emp" || xpevent == "assist_uav" || xpevent == "assist_uav_plus" || xpevent == "assist_riot_shield") {
    for(i = 0; i < 5; i++) {
      assistingPlayerIndex = getMatchData("lives", lifeId, "assists", i, "assistingPlayerIndex");
      if(assistingPlayerIndex == attacker.clientid || assistingPlayerIndex == 255) {
        if(assistingPlayerIndex == 255) {
          setMatchData("lives", lifeId, "assists", i, "assistingPlayerIndex", attacker.clientid);
        }

        if(xpevent == "assist_emp") {
          setMatchData("lives", lifeId, "assists", i, "assistEMP", true);
        } else if(xpevent == "assist_uav") {
          setMatchData("lives", lifeId, "assists", i, "assistUAV", true);
        } else if(xpevent == "assist_uav_plus") {
          setMatchData("lives", lifeId, "assists", i, "assistUAVPlus", true);
        } else if(xpevent == "assist_riot_shield") {
          setMatchData("lives", lifeId, "assists", i, "assistRiotShield", true);
        } else {
          PrintLn("^1warning: assist type: ", xpevent, " not currently handled by matchdata Life.assists[] ");
        }

        break;
      }
    }
  }
}

logPlayerDeath(lifeId, attacker, iDamage, sMeansOfDeath, sKillersWeapon, sKillersPrimaryWeapon, sHitLoc, victimCurrentWeapon) {
  if(!canLogClient(self) || (isPlayer(attacker) && !canLogClient(attacker)) || !canLogLife(lifeId)) {
    return;
  }

  if(lifeId >= level.MaxLives) {
    return;
  }

  if(level.isZombieGame) {
    return;
  }

  self logPlayerAndKillerExoMoveData(lifeId, attacker);
  self logPlayerAndKillerADSandFOV(lifeId, attacker);
  self logPlayerAndKillerShieldCloakHoverActive(lifeId, attacker);
  self logFirefightShotsHits(lifeId, attacker);
  self logPlayerAndKillerStanceAndMotionState(lifeId, attacker);
  self logAssists(lifeId, attacker);

  killerWeaponAndAttachments = determineWeaponNameAndAttachments(sKillersWeapon, sKillersPrimaryWeapon);
  assert(isDefined(killerWeaponAndAttachments.weaponName));
  assert(isDefined(killerWeaponAndAttachments.attachments));
  assert(isDefined(killerWeaponAndAttachments.weaponType));
  assert(isDefined(killerWeaponAndAttachments.weaponClass));
  assert(isDefined(killerWeaponAndAttachments.weaponNameFull));
  for(i = 0; i < 3; i++) {
    if(isDefined(killerWeaponAndAttachments.attachments[i]) && killerWeaponAndAttachments.attachments[i] != "None") {
      setMatchData("lives", lifeId, "killersWeaponAttachments", i, killerWeaponAndAttachments.attachments[i]);
    }
  }
  if(killerWeaponAndAttachments.weaponType != "exclusive") {
    setMatchData("lives", lifeId, "killersWeapon", killerWeaponAndAttachments.weaponName);
  }

  if(killerWeaponAndAttachments.weaponNameFull == "altmode") {
    setMatchData("lives", lifeId, "killersWeaponAltMode", true);
  }

  if(isKillstreakWeapon(killerWeaponAndAttachments.weaponNameFull)) {
    setMatchData("lives", lifeId, "modifiers", "killstreak", true);

    if(isDefined(attacker.currentKillStreakIndex)) {
      currKills = getMatchData("killstreaks", attacker.currentKillStreakIndex, "killsTotal");
      currKills++;
      setMatchData("killstreaks", attacker.currentKillStreakIndex, "killsTotal", clampToShort(currKills));

      setMatchData("lives", lifeId, "killerKillstreakIndex", attacker.currentKillStreakIndex);
    }
  } else {
    setMatchData("lives", lifeId, "killerKillstreakIndex", 255);
  }

  victimWeaponAndAttachments = determineWeaponNameAndAttachments(victimCurrentWeapon, undefined);
  assert(isDefined(victimWeaponAndAttachments.weaponName));
  assert(isDefined(victimWeaponAndAttachments.attachments));
  assert(isDefined(victimWeaponAndAttachments.weaponType));
  assert(isDefined(victimWeaponAndAttachments.weaponClass));
  assert(isDefined(victimWeaponAndAttachments.weaponNameFull));
  for(i = 0; i < 3; i++) {
    if(isDefined(victimWeaponAndAttachments.attachments[i]) && victimWeaponAndAttachments.attachments[i] != "None") {
      setMatchData("lives", lifeId, "victimCurrentWeaponAtDeathAttachments", i, victimWeaponAndAttachments.attachments[i]);
    }
  }

  if(victimWeaponAndAttachments.weaponType != "exclusive") {
    if(isKillstreakWeapon(victimWeaponAndAttachments.weaponName)) {
      if(isDefined(self.primaryWeapon)) {
        baseName = getBaseWeaponName(self.primaryWeapon);
        setMatchData("lives", lifeId, "victimCurrentWeaponAtDeath", baseName);
      }
    } else {
      setMatchData("lives", lifeId, "victimCurrentWeaponAtDeath", victimWeaponAndAttachments.weaponName);
    }
  }

  if(isDefined(self.pickedUpWeaponFrom) && isDefined(self.pickedUpWeaponFrom[victimWeaponAndAttachments.weaponNameFull])) {
    setMatchData("lives", lifeId, "victimCurrentWeaponPickedUp", true);
  }

  setMatchData("lives", lifeId, "meansOfDeath", sMeansOfDeath);
  deathDot = 2;
  if(isPlayer(attacker)) {
    setMatchData("lives", lifeId, "killer", attacker.clientid);
    setMatchData("lives", lifeId, "killerLifeIndex", attacker.lifeId);
    setMatchData("lives", lifeId, "killerPos", 0, int(attacker.origin[0]));
    setMatchData("lives", lifeId, "killerPos", 1, int(attacker.origin[1]));
    setMatchData("lives", lifeId, "killerPos", 2, int(attacker.origin[2]));

    setMatchData("lives", lifeId, "killerAngles", 0, int(attacker.angles[0]));
    setMatchData("lives", lifeId, "killerAngles", 1, int(attacker.angles[1]));
    setMatchData("lives", lifeId, "killerAngles", 2, int(attacker.angles[2]));

    victimForward = anglesToForward((0, self.angles[1], 0));
    attackDirection = (self.origin - attacker.origin);
    attackDirection = VectorNormalize((attackDirection[0], attackDirection[1], 0));
    deathDot = VectorDot(victimForward, attackDirection);
    setMatchData("lives", lifeId, "dotOfDeath", deathDot);

    if(attacker isJuggernaut()) {
      SetMatchData("lives", lifeId, "killerIsJuggernaut", true);
    }

    if(isDefined(attacker.pickedUpWeaponFrom) && isDefined(attacker.pickedUpWeaponFrom[killerWeaponAndAttachments.weaponNameFull])) {
      setMatchData("lives", lifeId, "killerCurrentWeaponPickedUp", true);
    }
  } else {
    setMatchData("lives", lifeId, "killer", 255);
    setMatchData("lives", lifeId, "killerLifeIndex", 65535);
    setMatchData("lives", lifeId, "killerPos", 0, int(self.origin[0]));
    setMatchData("lives", lifeId, "killerPos", 1, int(self.origin[1]));
    setMatchData("lives", lifeId, "killerPos", 2, int(self.origin[2]));

    setMatchData("lives", lifeId, "killerAngles", 0, int(self.angles[0]));
    setMatchData("lives", lifeId, "killerAngles", 1, int(self.angles[1]));
    setMatchData("lives", lifeId, "killerAngles", 2, int(self.angles[2]));
  }

  setMatchData("lives", lifeId, "player", self.clientid);
  setMatchData("lives", lifeId, "victimPos", 0, int(self.origin[0]));
  setMatchData("lives", lifeId, "victimPos", 1, int(self.origin[1]));
  setMatchData("lives", lifeId, "victimPos", 2, int(self.origin[2]));

  setMatchData("lives", lifeId, "victimAngles", 0, int(self.angles[0]));
  setMatchData("lives", lifeId, "victimAngles", 1, int(self.angles[1]));
  setMatchData("lives", lifeId, "victimAngles", 2, int(self.angles[2]));

  attacker_name = "world";
  if(isPlayer(attacker)) {
    attacker_name = attacker.name;
  }

  bSoleAttacker = true;
  numBullets = 0;
  bIsBot = IsAITeamParticipant(self);

  bKillerIsbot = false;
  if(isPlayer(attacker)) {
    bKillerIsbot = IsAITeamParticipant(attacker);
  }

  attacker_distance = Length(self.origin - attacker.origin);
  bIsLoot = false;
  adsFrac = 0.0;
  spawnToDeathTime = -1;
  spawnToKillTime = -1;
  gameTime = GetTime();

  if(isPlayer(attacker)) {
    adsFrac = attacker PlayerAds();
  }
  attacker_clientid = attacker.clientid;
  if(!isDefined(attacker_clientid)) {
    attacker_clientid = -1;
  }
  attacker_lifeid = attacker.lifeId;
  if(!isDefined(attacker_lifeid)) {
    attacker_lifeid = -1;
  }
  CONST_weapon_tuning_version = 0.1;

  if(self.damage_info.size > 1) {
    bSoleAttacker = false;
  }

  if(isDefined(self.damage_info[attacker GetEntityNumber()])) {
    numBullets = self.damage_info[attacker GetEntityNumber()].num_shots;
  }

  reconVictimWeapon = self.pers["primaryWeapon"] + "_mp";
  reconVictimWeaponClass = WeaponClass(reconVictimWeapon);

  if(IsSubStr(killerWeaponAndAttachments.weaponName, "loot")) {
    bIsLoot = true;
  }

  if(isDefined(self.spawnInfo) && isDefined(self.spawnInfo.spawnTime)) {
    spawnToDeathTime = (gameTime - self.spawnInfo.spawnTime) / 1000.0;
  }

  if(isDefined(attacker.spawnInfo) && isDefined(attacker.spawnInfo.spawnTime) && isPlayer(attacker)) {
    spawnToKillTime = (gameTime - attacker.spawnInfo.spawnTime) / 1000.0;
  }

  ReconSpatialEvent(self.origin, "script_mp_playerdeath: player_name %s, life_id %d, angles %v, death_dot %f, is_jugg %b, is_killstreak %b, mod %s, gameTime %d, spawnToDeathTime %f, attackerAliveTime %f, attacker_life_id %d", self.name, self.lifeId, self.angles, deathDot, attacker isJuggernaut(), isKillstreakWeapon(killerWeaponAndAttachments.weaponNameFull), sMeansOfDeath, gameTime, spawnToDeathTime, spawnToKillTime, attacker_lifeid);
  ReconSpatialEvent(self.origin, "script_mp_weaponinfo: player_name %s, life_id %d, isbot %b, attacker_name %s, attacker %d, attacker_pos %v, distance %f, ads_fraction %f, is_jugg %b, is_killstreak %b, weapon_type %s, weapon_class %s, weapon_name %s, isLoot %b, attachment0 %s, attachment1 %s, attachment2 %s, numShots %d, soleAttacker %b, gameTime %d", self.name, self.lifeId, bIsBot, attacker_name, attacker_clientid, attacker.origin, attacker_distance, adsFrac, attacker isJuggernaut(), isKillstreakWeapon(killerWeaponAndAttachments.weaponNameFull), killerWeaponAndAttachments.weaponType, killerWeaponAndAttachments.weaponClass, killerWeaponAndAttachments.weaponName, bIsLoot, killerWeaponAndAttachments.attachments[0], killerWeaponAndAttachments.attachments[1], killerWeaponAndAttachments.attachments[2], numBullets, bSoleAttacker, gameTime);
  ReconSpatialEvent(self.origin, "script_mp_weaponinfo_ext: player_name %s, life_id %d, gametime %d, version %f, victimWeapon %s, victimWeaponClass %s, killerIsBot %b", self.name, self.lifeId, gameTime, CONST_weapon_tuning_version, reconVictimWeapon, reconVictimWeaponClass, bKillerIsbot);

  if(!isDefined(level.matchData)) {
    level.matchData = [];
  }

  if(!isDefined(level.matchData["deathCount"])) {
    level.matchData["deathCount"] = 1;
  } else {
    level.matchData["deathCount"]++;
  }

  if(spawnToDeathTime <= 3.0) {
    if(!isDefined(level.matchData["badSpawnDiedTooFastCount"])) {
      level.matchData["badSpawnDiedTooFastCount"] = 1;
    } else {
      level.matchData["badSpawnDiedTooFastCount"]++;
    }

    if(self.spawnInfo.badSpawn == false) {
      if(!isDefined(level.matchData["badSpawnByAnyMeansCount"])) {
        level.matchData["badSpawnByAnyMeansCount"] = 1;
      } else {
        level.matchData["badSpawnByAnyMeansCount"]++;
      }

      self.spawnInfo.badSpawn = true;
    }
  }

  if(isPlayer(attacker) && spawnToKillTime <= 3.0 && !(killerWeaponAndAttachments.weaponName == "sentry_minigun_mp")) {
    if(!isDefined(level.matchData["badSpawnKilledTooFastCount"])) {
      level.matchData["badSpawnKilledTooFastCount"] = 1;
    } else {
      level.matchData["badSpawnKilledTooFastCount"]++;
    }

    if(attacker.spawnInfo.badSpawn == false) {
      if(!isDefined(level.matchData["badSpawnByAnyMeansCount"])) {
        level.matchData["badSpawnByAnyMeansCount"] = 1;
      } else {
        level.matchData["badSpawnByAnyMeansCount"]++;
      }

      attacker.spawnInfo.badSpawn = true;
    }
  }

}

logPlayerData() {
  if(!canLogClient(self)) {
    return;
  }

  setMatchData("players", self.clientid, "score", self getPersStat("score"));

  if(self getPersStat("assists") > 255) {
    setMatchData("players", self.clientid, "assists", 255);
  } else {
    setMatchData("players", self.clientid, "assists", self getPersStat("assists"));
  }

  if(self getPersStat("longestStreak") > 255) {
    setMatchData("players", self.clientid, "longestStreak", 255);
  } else {
    setMatchData("players", self.clientid, "longestStreak", self getPersStat("longestStreak"));
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    if(self getPersStat("validationInfractions") > 255) {
      setMatchData("players", self.clientid, "validationInfractions", 255);
    } else {
      setMatchData("players", self.clientid, "validationInfractions", self getPersStat("validationInfractions"));
    }
  }
}

endOfGameSummaryLogger() {
  foreach(player in level.players) {
    wait(0.05);

    if(!isDefined(player)) {
      continue;
    }

    logPlayerPing(player);

    if(isDefined(player.detectedExploit) && player.detectedExploit && (player rankingEnabled())) {
      player setRankedPlayerData("restXPGoal", player.detectedExploit);
    }

    challengesCompleted = undefined;
    challengeDataDefined = false;
    if(isDefined(game["challengeStruct"]) && isDefined(game["challengeStruct"]["challengesCompleted"]) && isDefined(game["challengeStruct"]["challengesCompleted"][player.guid])) {
      challengeDataDefined = true;
    }

    if(challengeDataDefined) {
      challengesCompleted = game["challengeStruct"]["challengesCompleted"][player.guid];
      if(challengesCompleted.size > 0) {
        player setCommonPlayerData("round", "challengeNumCompleted", challengesCompleted.size);
        cp = clampToByte(challengesCompleted.size);
        setMatchData("players", player.clientid, "challengesCompleted", cp);
      } else {
        player setCommonPlayerData("round", "challengeNumCompleted", 0);
      }
    } else {
      player setCommonPlayerData("round", "challengeNumCompleted", 0);
    }

    for(i = 0; i < 20; i++) {
      if(isDefined(challengesCompleted) && isDefined(challengesCompleted[i]) && challengesCompleted[i] != 8000) {
        player setCommonPlayerData("round", "challengesCompleted", i, challengesCompleted[i]);
      } else {
        player setCommonPlayerData("round", "challengesCompleted", i, 0);
      }
    }

    player setCommonPlayerData("round", "gameMode", level.gametype);
    player setCommonPlayerData("round", "map", ToLower(getDvar("mapname")));
  }
}

logPlayerPing(player) {
  if(!isDefined(player.pers["maxPing"]) || !isDefined(player.pers["minPing"]) || !isDefined(player.pers["pingAccumulation"]) || !isDefined(player.pers["pingSampleCount"])) {
    return;
  }

  if(player.pers["pingSampleCount"] > 0 && player.pers["maxPing"] > 0) {
    averagePing = clampToShort(player.pers["pingAccumulation"] / player.pers["pingSampleCount"]);
    setMatchData("players", player.clientid, "averagePing", averagePing);
    setMatchData("players", player.clientid, "maxPing", clampToShort(player.pers["maxPing"]));
    setMatchData("players", player.clientid, "minPing", clampToShort(player.pers["minPing"]));
  }
}

gameEndListener() {
  level waittill("game_ended");

  foreach(player in level.players) {
    player logPlayerData();

    if(!isAlive(player)) {
      continue;
    }

    player logPlayerLife(false);
  }

  foreach(player in level.players) {
    if(player.totalLifeTime > 0) {
      scoreperminute = player getPersStat("score") / (player.totalLifeTime / 60000);
      tournamentreportplayerspm(player.xuid, scoreperminute, player.team);
    }

    player.totalLifeTime = 0;
  }
}

canLogClient(client) {
  if(IsAgent(client)) {
    return false;
  }

  classname = client.code_classname;
  if(!isDefined(classname)) {
    classname = "undefined";
  }

  assertEx(isPlayer(client), "Client is not a player: " + classname);
  return (client.clientid < level.MaxLogClients);
}

canLogEvent() {
  return (getMatchData("eventCount") < level.MaxEvents);
}

canLogKillstreak() {
  return (getMatchData("killstreakCount") < level.MaxKillstreaks);
}

canLogLife(lifeId) {
  return (getMatchData("lifeCount") < level.MaxLives);
}

logWeaponStat(weaponName, statName, incValue) {
  if(!canLogClient(self)) {
    return;
  }

  if(isKillstreakWeapon(weaponName)) {
    return;
  }

  if(!isDefined(self.pers["mpWeaponStats"][weaponName])) {
    self.pers["mpWeaponStats"][weaponName] = [];
  }

  if(!isDefined(self.pers["mpWeaponStats"][weaponName][statName])) {
    self.pers["mpWeaponStats"][weaponName][statName] = 0;
  }

  value = self.pers["mpWeaponStats"][weaponName][statName];
  value += incValue;
  self.pers["mpWeaponStats"][weaponName][statName] = value;
}

buildBaseWeaponList() {
  baseWeapons = [];
  max_weapon_num = 149;
  for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
    weapon_name = tablelookup("mp/statstable.csv", 0, weaponId, 4);
    if(weapon_name == "") {
      continue;
    }

    if(!isSubStr(tableLookup("mp/statsTable.csv", 0, weaponId, 2), "weapon_")) {
      continue;
    }

    if(tableLookup("mp/statsTable.csv", 0, weaponId, 2) == "weapon_other") {
      continue;
    }

    if(TableLookup("mp/statsTable.csv", 0, weaponId, 51) != "") {
      continue;
    }

    baseWeapons[baseWeapons.size] = weapon_name;
  }
  return baseWeapons;
}

logKillsConfirmed() {
  if(!canLogClient(self)) {
    return;
  }

  setMatchData("players", self.clientid, "killsConfirmed", self.pers["confirmed"]);
}

logKillsDenied() {
  if(!canLogClient(self)) {
    return;
  }

  setMatchData("players", self.clientid, "killsDenied", self.pers["denied"]);
}

logInitialStats() {
  if(GetDvarInt("mdsd") > 0) {
    xp = self getRankedPlayerData("experience");
    setMatchData("players", self.clientid, "startXp", xp);

    setMatchData("players", self.clientid, "startKills", self getRankedPlayerData("kills"));
    setMatchData("players", self.clientid, "startDeaths", self getRankedPlayerData("deaths"));
    setMatchData("players", self.clientid, "startWins", self getRankedPlayerData("wins"));
    setMatchData("players", self.clientid, "startLosses", self getRankedPlayerData("losses"));
    setMatchData("players", self.clientid, "startHits", self getRankedPlayerData("hits"));
    setMatchData("players", self.clientid, "startMisses", self getRankedPlayerData("misses"));
    setMatchData("players", self.clientid, "startGamesPlayed", self getRankedPlayerData("gamesPlayed"));

    setMatchData("players", self.clientid, "startScore", self getRankedPlayerData("score"));
    setMatchData("players", self.clientid, "startUnlockPoints", self getRankedPlayerData("unlockPoints"));
    setMatchData("players", self.clientid, "startPrestige", self getRankedPlayerData("prestige"));
    setMatchData("players", self.clientid, "startDP", self getRankedPlayerData("division"));
    setMatchData("players", self.clientid, "startMMR", self getRankedPlayerData("mmr"));
  }
}

logFinalStats() {
  if(GetDvarInt("mdsd") > 0) {
    xp = self getRankedPlayerData("experience");
    setMatchData("players", self.clientid, "endXp", xp);

    setMatchData("players", self.clientid, "endKills", self getRankedPlayerData("kills"));
    setMatchData("players", self.clientid, "endDeaths", self getRankedPlayerData("deaths"));
    setMatchData("players", self.clientid, "endWins", self getRankedPlayerData("wins"));
    setMatchData("players", self.clientid, "endLosses", self getRankedPlayerData("losses"));
    setMatchData("players", self.clientid, "endHits", self getRankedPlayerData("hits"));
    setMatchData("players", self.clientid, "endMisses", self getRankedPlayerData("misses"));
    setMatchData("players", self.clientid, "endGamesPlayed", self getRankedPlayerData("gamesPlayed"));

    setMatchData("players", self.clientid, "endScore", self getRankedPlayerData("score"));
    setMatchData("players", self.clientid, "endUnlockPoints", self getRankedPlayerData("unlockPoints"));
    setMatchData("players", self.clientid, "endPrestige", self getRankedPlayerData("prestige"));
    setMatchData("players", self.clientid, "endMMR", self getRankedPlayerData("mmr"));

    if(isDefined(self.pers["rank"])) {
      rank = clampToByte(self maps\mp\gametypes\_rank::getRank());
      setMatchData("players", self.clientid, "rankAtEnd", rank);
    }
  }
}

reconLogPlayerInfo() {
  while(true) {
    if(getdvarint("cl_freemove") == 0) {
      foreach(player in level.players) {
        is_alive = false;
        if(isReallyAlive(player)) {
          is_alive = true;
        }

        if(IsTestClient(player)) {
          continue;
        }

        if(!isDefined(player.origin)) {
          continue;
        }

        player_name = "disconnected?";
        if(isDefined(player.name)) {
          player_name = player.name;
        }

        client = -1;
        if(isDefined(player.clientid)) {
          client = player.clientid;
        }

        angles = (-999, -999, -999);
        if(isDefined(player.angles)) {
          angles = player.angles;
        }

        playerTeam = "undefined";
        if(isDefined(player.team)) {
          playerTeam = player.team;
        }

        gameTime = getTime();

        ReconSpatialEvent(player.origin, "script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b", player_name, angles, gameTime, playerTeam, is_alive);
      }
    }
    wait 0.2;
  }
}