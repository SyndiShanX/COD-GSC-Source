/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_matchdata.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
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
    setMatchData("dateTime", getSystemTime());
    setMatchDataID();
  }

  level.MaxLives = 285;
  level.MaxNameLength = 26;
  level.MaxEvents = 150;
  level.MaxKillstreaks = 64;
  level.MaxLogClients = 30;
  level.MaxNumChallengesPerPlayer = 10;
  level.MaxNumAwardsPerPlayer = 10;

  if(!is_aliens()) {
    level thread gameEndListener();
    level thread endOfGameSummaryLogger();
  }
}

getMatchDateTime() {
  return GetMatchData("dateTime");
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
  setMatchData("killstreaks", eventId, "eventTime", getTime());
  setMatchData("killstreaks", eventId, "eventPos", 0, int(position[0]));
  setMatchData("killstreaks", eventId, "eventPos", 1, int(position[1]));
  setMatchData("killstreaks", eventId, "eventPos", 2, int(position[2]));
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
  setMatchData("events", eventId, "eventTime", getTime());
  setMatchData("events", eventId, "eventPos", 0, int(position[0]));
  setMatchData("events", eventId, "eventPos", 1, int(position[1]));
  setMatchData("events", eventId, "eventPos", 2, int(position[2]));
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

logPlayerLife() {
  if(!canLogClient(self)) {
    lifeId = level.MaxLives;
  }

  if(self.curClass == "gamemode") {
    lifeId = self LogMatchDataLife(self.clientid, self.spawnPos, self.spawnTime, self.wasTI);
  } else if(IsSubStr(self.curClass, "custom")) {
    class_num = getClassIndex(self.curClass);

    primaryWeapon = maps\mp\gametypes\_class::cac_getWeapon(class_num, 0);
    primaryAttachment1 = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 0);
    primaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 0);

    secondaryWeapon = maps\mp\gametypes\_class::cac_getWeapon(class_num, 1);
    secondaryAttachment1 = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 1);
    secondaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 1);

    offhandWeapon = "none";

    equipment = maps\mp\gametypes\_class::cac_getPerk(class_num, 0);

    lifeId = self LogMatchDataLife(self.clientid, self.spawnPos, self.spawnTime, self.wasTI, primaryWeapon, primaryAttachment1, primaryAttachment2, secondaryWeapon, secondaryAttachment1, secondaryAttachment2, offhandWeapon, equipment);
    self logPlayerAbilityPerks(lifeId);
  } else {
    class_num = getClassIndex(self.curClass);

    primaryWeapon = maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 0);
    primaryAttachment1 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 0);
    primaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 0, 1);

    secondaryWeapon = maps\mp\gametypes\_class::table_getWeapon(level.classTableName, class_num, 1);
    secondaryAttachment1 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 0);
    secondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment(level.classTableName, class_num, 1, 1);;

    offhandWeapon = maps\mp\gametypes\_class::table_getOffhand(level.classTableName, class_num);

    equipment = maps\mp\gametypes\_class::table_getEquipment(level.classTableName, class_num, 0);

    lifeId = self LogMatchDataLife(self.clientid, self.spawnPos, self.spawnTime, self.wasTI, primaryWeapon, primaryAttachment1, primaryAttachment2, secondaryWeapon, secondaryAttachment1, secondaryAttachment2, offhandWeapon, equipment);
    self logPlayerAbilityPerks(lifeId);
  }

  return lifeId;
}

logPlayerAbilityPerks(lifeId) {
  if(GetDvarInt("scr_trackPlayerAbilities", 0) != 0) {
    if(isDefined(self.abilityFlags) && self.abilityFlags.size == 2) {
      SetMatchData("lives", lifeId, "abilityFlags", 0, self.abilityFlags[0]);
      SetMatchData("lives", lifeId, "abilityFlags", 1, self.abilityFlags[1]);
    }
  }
}

logPlayerXP(xp, xpName) {
  if(!canLogClient(self)) {
    return;
  }
  setMatchData("players", self.clientid, xpName, xp);
}

logPlayerDeath(lifeId, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc) {
  if(!canLogClient(self)) {
    return;
  }
  if(lifeId >= level.MaxLives) {
    return;
  }
  if(IsPlayer(attacker) && canLogClient(attacker)) {
    self LogMatchDataDeath(lifeId, self.clientid, attacker, attacker.clientid, sWeapon, sMeansOfDeath, isKillstreakWeapon(sWeapon), attacker isJuggernaut());
  } else {
    self LogMatchDataDeath(lifeId, self.clientid, undefined, undefined, sWeapon, sMeansOfDeath, isKillstreakWeapon(sWeapon), false);
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

  if(self getPersStat("validationInfractions") > 255) {
    setMatchData("players", self.clientid, "validationInfractions", 255);
  } else {
    setMatchData("players", self.clientid, "validationInfractions", self getPersStat("validationInfractions"));
  }
}

endOfGameSummaryLogger() {
  level waittill("game_ended");

  foreach(player in level.players) {
    wait(0.05);

    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.detectedExploit) && player.detectedExploit && (player rankingEnabled())) {
      player setRankedPlayerData("restXPGoal", player.detectedExploit);
    }

    if(isDefined(player.weaponsUsed)) {
      player doubleBubbleSort();
      counter = 0;

      if(player.weaponsUsed.size > 3) {
        for(i = (player.weaponsUsed.size - 1); i > (player.weaponsUsed.size - 3); i--) {
          player setCommonPlayerData("round", "weaponsUsed", counter, player.weaponsUsed[i]);
          player setCommonPlayerData("round", "weaponXpEarned", counter, player.weaponXpEarned[i]);
          counter++;
        }
      } else {
        for(i = (player.weaponsUsed.size - 1); i >= 0; i--) {
          player setCommonPlayerData("round", "weaponsUsed", counter, player.weaponsUsed[i]);
          player setCommonPlayerData("round", "weaponXpEarned", counter, player.weaponXpEarned[i]);
          counter++;
        }
      }
    } else {
      player setCommonPlayerData("round", "weaponsUsed", 0, "none");
      player setCommonPlayerData("round", "weaponsUsed", 1, "none");
      player setCommonPlayerData("round", "weaponsUsed", 2, "none");
      player setCommonPlayerData("round", "weaponXpEarned", 0, 0);
      player setCommonPlayerData("round", "weaponXpEarned", 1, 0);
      player setCommonPlayerData("round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(player.operationsCompleted)) {
      player setCommonPlayerData("round", "operationNumCompleted", player.operationsCompleted.size);
    } else {
      player setCommonPlayerData("round", "operationNumCompleted", 0);
    }

    for(i = 0; i < 5; i++) {
      if(isDefined(player.operationsCompleted) && isDefined(player.operationsCompleted[i]) && player.operationsCompleted[i] != "ch_prestige" && !IsSubStr(player.operationsCompleted[i], "_daily") && !IsSubStr(player.operationsCompleted[i], "_weekly")) {
        player setCommonPlayerData("round", "operationsCompleted", i, player.operationsCompleted[i]);
      } else {
        player setCommonPlayerData("round", "operationsCompleted", i, "");
      }
    }

    if(isDefined(player.challengesCompleted)) {
      player setCommonPlayerData("round", "challengeNumCompleted", player.challengesCompleted.size);
    } else {
      player setCommonPlayerData("round", "challengeNumCompleted", 0);
    }

    for(i = 0; i < 20; i++) {
      if(isDefined(player.challengesCompleted) && isDefined(player.challengesCompleted[i]) && player.challengesCompleted[i] != "ch_prestige" && !IsSubStr(player.challengesCompleted[i], "_daily") && !IsSubStr(player.challengesCompleted[i], "_weekly")) {
        player setCommonPlayerData("round", "challengesCompleted", i, player.challengesCompleted[i]);
      } else {
        player setCommonPlayerData("round", "challengesCompleted", i, "");
      }
    }

    player setCommonPlayerData("round", "gameMode", level.gametype);
    player setCommonPlayerData("round", "map", ToLower(GetDvar("mapname")));
    if(IsSquadsMode()) {
      player setCommonPlayerData("round", "squadMode", 1);
    } else {
      player setCommonPlayerData("round", "squadMode", 0);
    }
  }

}

doubleBubbleSort() {
  A = self.weaponXpEarned;
  n = self.weaponXpEarned.size;

  for(i = (n - 1); i > 0; i--) {
    for(j = 1; j <= i; j++) {
      if(A[j - 1] < A[j]) {
        temp = self.weaponsUsed[j];
        self.weaponsUsed[j] = self.weaponsUsed[j - 1];
        self.weaponsUsed[j - 1] = temp;

        temp2 = self.weaponXpEarned[j];
        self.weaponXpEarned[j] = self.weaponXpEarned[j - 1];
        self.weaponXpEarned[j - 1] = temp2;
        A = self.weaponXpEarned;
      }
    }
  }
}

gameEndListener() {
  level waittill("game_ended");

  foreach(player in level.players) {
    player logPlayerData();

    if(!isAlive(player)) {
      continue;
    }
    player logPlayerLife();
  }
}

canLogClient(client) {
  if(IsAgent(client)) {
    return false;
  }
  assertEx(isPlayer(client), "Client is not a player: " + client.code_classname);
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
  if(weaponName == "iw6_pdwauto") {
    weaponName = "iw6_pdw";
  } else if(weaponName == "iw6_knifeonlyfast") {
    weaponName = "iw6_knifeonly";
  }

  if(isKillstreakWeapon(weaponName)) {
    return;
  }
  self storeWeaponAndAttachmentStats("weaponStats", weaponName, statName, incValue);
}

logAttachmentStat(weaponName, statName, incValue) {
  if(!canLogClient(self)) {
    return;
  }
  self storeWeaponAndAttachmentStats("attachmentsStats", weaponName, statName, incValue);
}

storeWeaponAndAttachmentStats(statCategory, weaponName, statName, incValue) {
  oldValue = GetMatchData("players", self.clientid, statCategory, weaponName, statName);
  newValue = oldValue + incValue;

  if(statName == "kills" || statName == "deaths" || statName == "headShots") {
    if(newValue > 255) {
      newValue = 255;
    }
  } else if(newValue > 65535) {
    newValue = 65535;
  }

  SetMatchData("players", self.clientid, statCategory, weaponName, statName, newValue);
}

buildBaseWeaponList() {
  baseWeapons = [];
  max_weapon_num = 149;
  for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
    weapon_name = tablelookup("mp/statstable.csv", 0, weaponId, 4);

    if(
      weapon_name == "" ||
      weapon_name == "uav" ||
      weapon_name == "iw6_knifeonlyfast" ||
      weapon_name == "laser_designator" ||
      weapon_name == "iw6_pdwauto"
    ) {
      continue;
    }

    if(!isSubStr(tableLookup("mp/statsTable.csv", 0, weaponId, 2), "weapon_")) {
      continue;
    }
    if(tableLookup("mp/statsTable.csv", 0, weaponId, 2) == "weapon_other") {
      continue;
    }
    baseWeapons[baseWeapons.size] = weapon_name;
  }
  return baseWeapons;
}

logChallenge(challengeName, tier) {
  if(!canLogClient(self)) {
    return;
  }
  if(IsSubStr(challengeName, "_daily") || IsSubStr(challengeName, "_weekly")) {
    return;
  }
  challengeCount = getMatchData("players", self.clientid, "challengeCount");
  if(challengeCount < level.MaxNumChallengesPerPlayer) {
    setMatchData("players", self.clientid, "challenge", challengeCount, challengeName);
    setMatchData("players", self.clientid, "tier", challengeCount, tier);
    setMatchData("players", self.clientid, "challengeCount", challengeCount + 1);
  }
}

logAward(awardName) {
  if(!canLogClient(self)) {
    return;
  }
  awardCount = getMatchData("players", self.clientid, "awardCount");
  if(awardCount < level.MaxNumAwardsPerPlayer) {
    setMatchData("players", self.clientid, "awards", awardCount, awardName);
    setMatchData("players", self.clientid, "awardCount", awardCount + 1);
  }
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
    setMatchData("players", self.clientid, "startXp", self getRankedPlayerData("experience"));
    setMatchData("players", self.clientid, "startKills", self getRankedPlayerData("kills"));
    setMatchData("players", self.clientid, "startDeaths", self getRankedPlayerData("deaths"));
    setMatchData("players", self.clientid, "startWins", self getRankedPlayerData("wins"));
    setMatchData("players", self.clientid, "startLosses", self getRankedPlayerData("losses"));
    setMatchData("players", self.clientid, "startHits", self getRankedPlayerData("hits"));
    setMatchData("players", self.clientid, "startMisses", self getRankedPlayerData("misses"));
    setMatchData("players", self.clientid, "startGamesPlayed", self getRankedPlayerData("gamesPlayed"));
    setMatchData("players", self.clientid, "startTimePlayedTotal", self getRankedPlayerData("timePlayedTotal"));
    setMatchData("players", self.clientid, "startScore", self getRankedPlayerData("score"));
    setMatchData("players", self.clientid, "startUnlockPoints", self getRankedPlayerData("unlockPoints"));
    setMatchData("players", self.clientid, "startPrestige", self getRankedPlayerData("prestige"));

    for(squadMember = 0; squadMember < 10; squadMember++) {
      setMatchData("players", self.clientid, "startCharacterXP", squadMember, self getRankedPlayerData("characterXP", squadMember));
    }
  }
}

logFinalStats() {
  if(GetDvarInt("mdsd") > 0) {
    setMatchData("players", self.clientid, "endXp", self getRankedPlayerData("experience"));
    setMatchData("players", self.clientid, "endKills", self getRankedPlayerData("kills"));
    setMatchData("players", self.clientid, "endDeaths", self getRankedPlayerData("deaths"));
    setMatchData("players", self.clientid, "endWins", self getRankedPlayerData("wins"));
    setMatchData("players", self.clientid, "endLosses", self getRankedPlayerData("losses"));
    setMatchData("players", self.clientid, "endHits", self getRankedPlayerData("hits"));
    setMatchData("players", self.clientid, "endMisses", self getRankedPlayerData("misses"));
    setMatchData("players", self.clientid, "endGamesPlayed", self getRankedPlayerData("gamesPlayed"));
    setMatchData("players", self.clientid, "endTimePlayedTotal", self getRankedPlayerData("timePlayedTotal"));
    setMatchData("players", self.clientid, "endScore", self getRankedPlayerData("score"));
    setMatchData("players", self.clientid, "endUnlockPoints", self getRankedPlayerData("unlockPoints"));
    setMatchData("players", self.clientid, "endPrestige", self getRankedPlayerData("prestige"));

    for(squadMember = 0; squadMember < 10; squadMember++) {
      setMatchData("players", self.clientid, "endCharacterXP", squadMember, self getRankedPlayerData("characterXP", squadMember));
    }
  }
}