/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
**********************************************/

#include maps\mp\_utility;

MAX_KD_HISTORY = 5;

init() {
  maps\mp\gametypes\_class::init();

  if(!is_aliens()) {
    level.persistentDataInfo = [];

    maps\mp\gametypes\_missions::init();
    maps\mp\gametypes\_rank::init();

    level thread updateBufferedStats();

    level thread uploadGlobalStatCounters();

    level thread writeKDHistoryStats();
  }

  maps\mp\gametypes\_playercards::init();
}

initBufferedStats() {
  println("Init Buffered Stats for " + self.name);

  self.bufferedStats = [];
  self.squadMemberBufferedStats = [];

  if(self rankingEnabled()) {
    self.bufferedStats["totalShots"] = self getRankedPlayerData("totalShots");
    self.bufferedStats["accuracy"] = self getRankedPlayerData("accuracy");
    self.bufferedStats["misses"] = self getRankedPlayerData("misses");
    self.bufferedStats["hits"] = self getRankedPlayerData("hits");
    self.bufferedStats["timePlayedAllies"] = self getRankedPlayerData("timePlayedAllies");
    self.bufferedStats["timePlayedOpfor"] = self getRankedPlayerData("timePlayedOpfor");
    self.bufferedStats["timePlayedOther"] = self getRankedPlayerData("timePlayedOther");
    self.bufferedStats["timePlayedTotal"] = self getRankedPlayerData("timePlayedTotal");

    activeMember = self GetRankedPlayerData("activeSquadMember");
    self.squadMemberBufferedStats["experienceToPrestige"] = self getRankedPlayerData("squadMembers", activeMember, "experienceToPrestige");

    println("timePlayedAllies " + self.bufferedStats["timePlayedAllies"]);
    println("timePlayedOpfor " + self.bufferedStats["timePlayedOpfor"]);
    println("timePlayedOther " + self.bufferedStats["timePlayedOther"]);
    println("timePlayedTotal " + self.bufferedStats["timePlayedTotal"]);
  }

  self.bufferedChildStats = [];
  self.bufferedChildStats["round"] = [];
  self.bufferedChildStats["round"]["timePlayed"] = self getCommonPlayerData("round", "timePlayed");

  if(self rankingEnabled()) {
    self.bufferedChildStats["xpMultiplierTimePlayed"] = [];
    self.bufferedChildStats["xpMultiplierTimePlayed"][0] = self getRankedPlayerData("xpMultiplierTimePlayed", 0);
    self.bufferedChildStats["xpMultiplierTimePlayed"][1] = self getRankedPlayerData("xpMultiplierTimePlayed", 1);
    self.bufferedChildStats["xpMultiplierTimePlayed"][2] = self getRankedPlayerData("xpMultiplierTimePlayed", 2);

    self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"] = [];
    self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][0] = self getRankedPlayerData("xpMaxMultiplierTimePlayed", 0);
    self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][1] = self getRankedPlayerData("xpMaxMultiplierTimePlayed", 1);
    self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][2] = self getRankedPlayerData("xpMaxMultiplierTimePlayed", 2);

    self.bufferedChildStats["challengeXPMultiplierTimePlayed"] = [];
    self.bufferedChildStats["challengeXPMultiplierTimePlayed"][0] = self getRankedPlayerData("challengeXPMultiplierTimePlayed", 0);

    self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"] = [];
    self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"][0] = self getRankedPlayerData("challengeXPMaxMultiplierTimePlayed", 0);

    self.bufferedChildStats["weaponXPMultiplierTimePlayed"] = [];
    self.bufferedChildStats["weaponXPMultiplierTimePlayed"][0] = self getRankedPlayerData("weaponXPMultiplierTimePlayed", 0);

    self.bufferedChildStatsMax["weaponXPMaxMultiplierTimePlayed"] = [];
    self.bufferedChildStatsMax["weaponXPMaxMultiplierTimePlayed"][0] = self getRankedPlayerData("weaponXPMaxMultiplierTimePlayed", 0);

    if(IsSquadsMode()) {
      self.bufferedStats["prestigeDoubleXp"] = self getRankedPlayerData("prestigeDoubleXp");
      self.bufferedStats["prestigeDoubleXpTimePlayed"] = self getRankedPlayerData("prestigeDoubleXpTimePlayed");
      self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"] = self getRankedPlayerData("prestigeDoubleXpMaxTimePlayed");
    }

    self.bufferedStats["prestigeDoubleWeaponXp"] = self getRankedPlayerData("prestigeDoubleWeaponXp");
    self.bufferedStats["prestigeDoubleWeaponXpTimePlayed"] = self getRankedPlayerData("prestigeDoubleWeaponXpTimePlayed");
    self.bufferedStatsMax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getRankedPlayerData("prestigeDoubleWeaponXpMaxTimePlayed");
  }
}

statGet(dataName) {
  assert(!isDefined(self.bufferedStats[dataName]));
  return self getRankedPlayerData(dataName);
}

statSet(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(!isDefined(self.bufferedStats[dataName]));

  self setRankedPlayerData(dataName, value);
}

statAdd(dataName, value, optionalArrayInd) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(!isDefined(self.bufferedStats[dataName]));

  if(isDefined(optionalArrayInd)) {
    curValue = self getRankedPlayerData(dataName, optionalArrayInd);
    self setRankedPlayerData(dataName, optionalArrayInd, value + curValue);
  } else {
    curValue = self getRankedPlayerData(dataName);
    self setRankedPlayerData(dataName, value + curValue);
  }
}

statGetChild(parent, child) {
  if(parent == "round") {
    return self getCommonPlayerData(parent, child);
  }
  else {
    return self getRankedPlayerData(parent, child);
  }
}

statSetChild(parent, child, value) {
  if(IsAgent(self)) {
    return;
  }
  if(!self rankingEnabled()) {
    return;
  }
  if(parent == "round") {
    self setCommonPlayerData(parent, child, value);
  }
  else {
    self setRankedPlayerData(parent, child, value);
  }
}

statAddChild(parent, child, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedChildStats[parent][child]));

  curValue = self getRankedPlayerData(parent, child);
  self setRankedPlayerData(parent, child, curValue + value);
}

statGetChildBuffered(parent, child) {
  if(!self rankingEnabled()) {
    return 0;
  }

  assert(isDefined(self.bufferedChildStats[parent][child]));

  return self.bufferedChildStats[parent][child];
}

statSetChildBuffered(parent, child, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedChildStats[parent][child]));

  self.bufferedChildStats[parent][child] = value;
}

statAddChildBuffered(parent, child, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedChildStats[parent][child]));

  curValue = statGetChildBuffered(parent, child);
  statSetChildBuffered(parent, child, curValue + value);
}

statAddBufferedWithMax(stat, value, max) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedStats[stat]));

  newValue = statGetBuffered(stat) + value;

  if(newValue > max) {
    newValue = max;
  }

  if(newValue < statGetBuffered(stat)) {
    newValue = max;
  }

  statSetBuffered(stat, newValue);
}

statAddChildBufferedWithMax(parent, child, value, max) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedChildStats[parent][child]));

  newValue = statGetChildBuffered(parent, child) + value;

  if(newValue > max) {
    newValue = max;
  }

  if(newValue < statGetChildBuffered(parent, child)) {
    newValue = max;
  }

  statSetChildBuffered(parent, child, newValue);
}

statGetBuffered(dataName) {
  if(!self rankingEnabled()) {
    return 0;
  }

  assert(isDefined(self.bufferedStats[dataName]));

  return self.bufferedStats[dataName];
}

statGetSquadBuffered(dataName) {
  if(!self rankingEnabled()) {
    return 0;
  }

  assert(isDefined(self.SquadMemberBufferedStats[dataName]));

  return self.SquadMemberBufferedStats[dataName];
}

statSetBuffered(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedStats[dataName]));

  self.bufferedStats[dataName] = value;
}

statSetSquadBuffered(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.SquadMemberBufferedStats[dataName]));

  self.SquadMemberBufferedStats[dataName] = value;
}

statAddBuffered(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.bufferedStats[dataName]));
  assert(value >= 0);

  curValue = statGetBuffered(dataName);
  statSetBuffered(dataName, curValue + value);
}

statAddSquadBuffered(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }
  assert(isDefined(self.SquadMemberBufferedStats[dataName]));
  assert(value >= 0);

  curValue = statGetSquadBuffered(dataName);
  statSetSquadBuffered(dataName, curValue + value);
}

updateBufferedStats() {
  wait(0.15);

  nextToUpdate = 0;
  while(!level.gameEnded) {
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    nextToUpdate++;
    if(nextToUpdate >= level.players.size) {
      nextToUpdate = 0;
    }

    if(isDefined(level.players[nextToUpdate])) {
      level.players[nextToUpdate] writeBufferedStats();
      level.players[nextToUpdate] updateWeaponBufferedStats();
    }

    wait(2.0);
  }

  foreach(player in level.players) {
    player writeBufferedStats();
    player updateWeaponBufferedStats();
  }

}

writeBufferedStats() {
  rankingEnabled = self rankingEnabled();
  if(rankingEnabled) {
    foreach(statName, statVal in self.bufferedStats) {
      self setRankedPlayerData(statName, statVal);
    }

    if(!isAI(self)) {
      foreach(statName, statVal in self.squadMemberBufferedStats) {
        self SetRankedPlayerData("squadMembers", self.pers["activeSquadMember"], statName, statVal);
      }
    }
  }

  foreach(statName, statVal in self.bufferedChildStats) {
    foreach(childStatName, childStatVal in statVal) {
      if(statName == "round") {
        self setCommonPlayerData(statName, childStatName, childStatVal);
      }
      else if(rankingEnabled) {
        self setRankedPlayerData(statName, childStatName, childStatVal);
      }
    }
  }
}

writeKDHistoryStats() {
  if(!matchMakingGame()) {
    return;
  }
  if(IsSquadsMode()) {
    return;
  }
  level waittill("game_ended");

  wait 0.1;

  if(wasLastRound() || (!isRoundBased() && hitTimeLimit())) {
    foreach(player in level.players) {
      player incrementRankedReservedHistory(player.kills, player.deaths);
    }
  }
}

incrementRankedReservedHistory(kills, deaths) {
  if(!self rankingEnabled()) {
    return;
  }
  for(i = 0; i < MAX_KD_HISTORY - 1; i++) {
    prev = self getRankedPlayerDataReservedInt("kdHistoryK" + (i + 1));
    self setRankedPlayerDataReservedInt("kdHistoryK" + i, prev);

    prev = self getRankedPlayerDataReservedInt("kdHistoryD" + (i + 1));
    self setRankedPlayerDataReservedInt("kdHistoryD" + i, prev);
  }

  self setRankedPlayerDataReservedInt("kdHistoryK" + (MAX_KD_HISTORY - 1), int(clamp(kills, 0, 255)));
  self setRankedPlayerDataReservedInt("kdHistoryD" + (MAX_KD_HISTORY - 1), int(clamp(deaths, 0, 255)));
}

incrementWeaponStat(weaponName, stat, incValue) {
  if(weaponName == "iw6_pdwauto") {
    weaponName = "iw6_pdw";
  }
  else if(weaponName == "iw6_knifeonlyfast") {
    weaponName = "iw6_knifeonly";
  }

  if(isKillstreakWeapon(weaponName)) {
    return;
  }
  if(isDefined(level.disableWeaponStats)) {
    return;
  }
  if(self rankingEnabled()) {
    oldval = self getRankedPlayerData("weaponStats", weaponName, stat);
    self setRankedPlayerData("weaponStats", weaponName, stat, oldval + incValue);
  }
}

incrementAttachmentStat(attachmentName, stat, incValue) {
  if(isDefined(level.disableWeaponStats)) {
    return;
  }
  if(self rankingEnabled()) {
    oldval = self getRankedPlayerData("attachmentsStats", attachmentName, stat);
    self setRankedPlayerData("attachmentsStats", attachmentName, stat, oldval + incValue);
  }
}

updateWeaponBufferedStats() {
  if(!isDefined(self.trackingWeaponName)) {
    return;
  }
  if(self.trackingWeaponName == "" || self.trackingWeaponName == "none") {
    return;
  }
  if(isKillstreakWeapon(self.trackingWeaponName) || isEnvironmentWeapon(self.trackingWeaponName)) {
    return;
  }
  weapName = self.trackingWeaponName;
  weapStat = undefined;

  strStart = GetSubStr(weapName, 0, 4);
  if(strStart == "alt_") {
    attachments = getWeaponAttachmentsBaseNames(weapName);

    foreach(attachName in attachments) {
      if(attachName == "shotgun" || attachName == "gl") {
        weapStat = attachName;
        break;
      }
    }

    if(!isDefined(weapStat)) {
      tokens = StrTok(weapName, "_");
      weapStat = tokens[1] + "_" + tokens[2];
    }
  } else if(strStart == "iw5_" || strStart == "iw6_") {
    tokens = StrTok(weapName, "_");
    weapStat = tokens[0] + "_" + tokens[1];
  }

  AssertEx(isDefined(weapStat), "updateWeaponBufferedStats() failed to get weapon name for stats.");

  if(weapStat == "gl" || weapStat == "shotgun") {
    self persLog_attachmentStats(weapStat);

    self persClear_stats();
    return;
  }

  if(!isCACPrimaryWeapon(weapStat) && !isCACSecondaryWeapon(weapStat)) {
    return;
  }
  persLog_weaponStats(weapStat);

  attachments = GetWeaponAttachments(weapName);

  foreach(attachName in attachments) {
    attachBase = attachmentMap_toBase(attachName);

    switch (attachBase) {
      case "scope":
      case "gl":
      case "shotgun":
        continue;
    }

    persLog_attachmentStats(attachBase);
  }

  self persClear_stats();
}

persClear_stats() {
  self.trackingWeaponName = "none";
  self.trackingWeaponShots = 0;
  self.trackingWeaponKills = 0;
  self.trackingWeaponHits = 0;
  self.trackingWeaponHeadShots = 0;
  self.trackingWeaponDeaths = 0;
}

persLog_weaponStats(weaponName) {
  if(self.trackingWeaponShots > 0) {
    self incrementWeaponStat(weaponName, "shots", self.trackingWeaponShots);
    self maps\mp\_matchdata::logWeaponStat(weaponName, "shots", self.trackingWeaponShots);
  }

  if(self.trackingWeaponKills > 0) {
    self incrementWeaponStat(weaponName, "kills", self.trackingWeaponKills);
    self maps\mp\_matchdata::logWeaponStat(weaponName, "kills", self.trackingWeaponKills);
  }

  if(self.trackingWeaponHits > 0) {
    self incrementWeaponStat(weaponName, "hits", self.trackingWeaponHits);
    self maps\mp\_matchdata::logWeaponStat(weaponName, "hits", self.trackingWeaponHits);
  }

  if(self.trackingWeaponHeadShots > 0) {
    self incrementWeaponStat(weaponName, "headShots", self.trackingWeaponHeadShots);
    self maps\mp\_matchdata::logWeaponStat(weaponName, "headShots", self.trackingWeaponHeadShots);
  }

  if(self.trackingWeaponDeaths > 0) {
    self incrementWeaponStat(weaponName, "deaths", self.trackingWeaponDeaths);
    self maps\mp\_matchdata::logWeaponStat(weaponName, "deaths", self.trackingWeaponDeaths);
  }
}

persLog_attachmentStats(attachName) {
  if(self.trackingWeaponShots > 0 && attachName != "tactical") {
    self incrementAttachmentStat(attachName, "shots", self.trackingWeaponShots);
    self maps\mp\_matchdata::logAttachmentStat(attachName, "shots", self.trackingWeaponShots);
  }

  if(self.trackingWeaponKills > 0 && attachName != "tactical") {
    self incrementAttachmentStat(attachName, "kills", self.trackingWeaponKills);
    self maps\mp\_matchdata::logAttachmentStat(attachName, "kills", self.trackingWeaponKills);
  }

  if(self.trackingWeaponHits > 0 && attachName != "tactical") {
    self incrementAttachmentStat(attachName, "hits", self.trackingWeaponHits);
    self maps\mp\_matchdata::logAttachmentStat(attachName, "hits", self.trackingWeaponHits);
  }

  if(self.trackingWeaponHeadShots > 0 && attachName != "tactical") {
    self incrementAttachmentStat(attachName, "headShots", self.trackingWeaponHeadShots);
    self maps\mp\_matchdata::logAttachmentStat(attachName, "headShots", self.trackingWeaponHeadShots);
  }

  if(self.trackingWeaponDeaths > 0) {
    self incrementAttachmentStat(attachName, "deaths", self.trackingWeaponDeaths);
    self maps\mp\_matchdata::logAttachmentStat(attachName, "deaths", self.trackingWeaponDeaths);
  }
}

uploadGlobalStatCounters() {
  level waittill("game_ended");

  if(!matchMakingGame()) {
    return;
  }
  totalKills = 0;
  totalDeaths = 0;
  totalAssists = 0;
  totalHeadshots = 0;
  totalSuicides = 0;
  totalTimePlayed = 0;

  foreach(player in level.players) {
    totalTimePlayed += player.timePlayed["total"];
  }

  incrementCounter("global_minutes", int(totalTimePlayed / 60));

  if(isRoundBased() && !wasLastRound()) {
    return;
  }
  wait(0.05);

  foreach(player in level.players) {
    totalKills += player.kills;
    totalDeaths += player.deaths;
    totalAssists += player.assists;
    totalHeadshots += player.headshots;
    totalSuicides += player.suicides;
  }

  incrementCounter("global_headshots", totalHeadshots);
  incrementCounter("global_suicides", totalSuicides);
  incrementCounter("global_games", 1);

  if(!isDefined(level.assists_disabled)) {
    incrementCounter("global_assists", totalAssists);
  }

  if(!isDefined(level.isHorde)) {
    incrementCounter("global_kills", totalKills);
  }

  if(!isDefined(level.isHorde)) {
    incrementCounter("global_deaths", totalDeaths);
  }
}