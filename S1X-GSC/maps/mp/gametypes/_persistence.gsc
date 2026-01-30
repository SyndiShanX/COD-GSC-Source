/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
***************************************************/

#include maps\mp\_utility;

init() {
  level.persistentDataInfo = [];

  maps\mp\gametypes\_class::init();
  maps\mp\gametypes\_missions::init();
  maps\mp\gametypes\_playercards::init();

  maps\mp\gametypes\_rank::init();

  if(GetDvarInt("virtualLobbyActive", 0) > 0) {
    return;
  }
  level thread updateBufferedStats();

  level thread uploadGlobalStatCounters();
}

initBufferedStats() {
  println("Init Buffered Stats for " + self.name);

  self.bufferedStats = [];

  if(self rankingEnabled()) {
    self.bufferedStats["totalShots"] = self getRankedPlayerData("totalShots");
    self.bufferedStats["accuracy"] = self getRankedPlayerData("accuracy");
    self.bufferedStats["misses"] = self getRankedPlayerData("misses");
    self.bufferedStats["hits"] = self getRankedPlayerData("hits");
    self.bufferedStats["timePlayedAllies"] = self getRankedPlayerData("timePlayedAllies");
    self.bufferedStats["timePlayedOpfor"] = self getRankedPlayerData("timePlayedOpfor");
    self.bufferedStats["timePlayedOther"] = self getRankedPlayerData("timePlayedOther");
    self.bufferedStats["timePlayedTotal"] = self getRankedPlayerData("timePlayedTotal");

    println("timePlayedAllies " + self.bufferedStats["timePlayedAllies"]);
    println("timePlayedOpfor " + self.bufferedStats["timePlayedOpfor"]);
    println("timePlayedOther " + self.bufferedStats["timePlayedOther"]);
    println("timePlayedTotal " + self.bufferedStats["timePlayedTotal"]);
  }

  self.bufferedChildStats = [];
  self.bufferedChildStats["round"] = [];
  self.bufferedChildStats["round"]["timePlayed"] = self getCommonPlayerData("round", "timePlayed");
}

statGet(dataName) {
  assert(!isDefined(self.bufferedStats[dataName]));
  return self getRankedPlayerData(dataName);
}

statSet(dataName, value) {
  if(!self rankingEnabled() || practiceRoundGame()) {
    return;
  }

  assert(!isDefined(self.bufferedStats[dataName]));

  self setRankedPlayerData(dataName, value);
}

statAdd(dataName, value, optionalArrayInd) {
  if(!self rankingEnabled() || practiceRoundGame()) {
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
  } else {
    return self getRankedPlayerData(parent, child);
  }
}

statSetChild(parent, child, value) {
  if(IsAgent(self)) {
    return;
  }

  if(inVirtualLobby()) {
    return;
  }

  if(parent == "round") {
    self setCommonPlayerData(parent, child, value);
  } else {
    if(!self rankingEnabled() || practiceRoundGame()) {
      return;
    }

    self setRankedPlayerData(parent, child, value);
  }
}

statAddChild(parent, child, value) {
  if(!self rankingEnabled() || practiceRoundGame()) {
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

statSetBuffered(dataName, value) {
  if(!self rankingEnabled()) {
    return;
  }

  assert(isDefined(self.bufferedStats[dataName]));

  self.bufferedStats[dataName] = value;
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
  rankingEnabled = (self rankingEnabled() && !practiceRoundGame());
  if(rankingEnabled) {
    foreach(statName, statVal in self.bufferedStats) {
      self setRankedPlayerData(statName, statVal);
    }
  }

  foreach(statName, statVal in self.bufferedChildStats) {
    foreach(childStatName, childStatVal in statVal) {
      if(statName == "round") {
        self setCommonPlayerData(statName, childStatName, childStatVal);
      } else if(rankingEnabled) {
        self setRankedPlayerData(statName, childStatName, childStatVal);
      }
    }
  }
}

incrementWeaponStat(weaponName, stat, incValue) {
  if(isKillstreakWeapon(weaponName)) {
    return;
  }

  if(isDefined(level.disableWeaponStats) && level.disableWeaponStats) {
    return;
  }

  if(self rankingEnabled() && !practiceRoundGame()) {
    oldval = self getRankedPlayerData("weaponStats", weaponName, stat);
    self setRankedPlayerData("weaponStats", weaponName, stat, oldval + incValue);
  }
}

incrementAttachmentStat(attachmentName, stat, incValue) {
  if(self rankingEnabled() && !practiceRoundGame()) {
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

  tmp = self.trackingWeaponName;

  if(isKillstreakWeapon(tmp) || isEnvironmentWeapon(tmp)) {
    return;
  }

  tokens = getWeaponNameTokens(tmp);

  if(tokens[0] == "iw5") {
    tokens[0] = tokens[0] + "_" + tokens[1];
  }

  if(tokens[0] == "alt") {
    foreach(token in tokens) {
      if(token == "gl" || token == "gp25" || token == "m320") {
        tokens[0] = "gl";
        break;
      }
      if(token == "shotgun") {
        tokens[0] = "shotgun";
        break;
      }
    }

    if(tokens[0] == "alt") {
      tokens[0] = tokens[1] + "_" + tokens[2];
    }

  }

  if(tokens[0] == "gl" || tokens[0] == "shotgun") {
    if(self.trackingWeaponShots > 0) {
      self incrementAttachmentStat(tokens[0], "shots", self.trackingWeaponShots);
    }

    if(self.trackingWeaponKills > 0) {
      self incrementAttachmentStat(tokens[0], "kills", self.trackingWeaponKills);
    }

    if(self.trackingWeaponHits > 0) {
      self incrementAttachmentStat(tokens[0], "hits", self.trackingWeaponHits);
    }

    if(self.trackingWeaponHeadShots > 0) {
      self incrementAttachmentStat(tokens[0], "headShots", self.trackingWeaponHeadShots);
    }

    if(self.trackingWeaponDeaths > 0) {
      self incrementAttachmentStat(tokens[0], "deaths", self.trackingWeaponDeaths);
    }

    if(self.trackingWeaponHipFireKills > 0) {
      self incrementAttachmentStat(tokens[0], "hipfirekills", self.trackingWeaponHipFireKills);
    }

    if(self.trackingWeaponUseTime > 0) {
      self incrementAttachmentStat(tokens[0], "timeInUse", self.trackingWeaponUseTime);
    }

    self.trackingWeaponName = "none";
    self.trackingWeaponShots = 0;
    self.trackingWeaponKills = 0;
    self.trackingWeaponHits = 0;
    self.trackingWeaponHeadShots = 0;
    self.trackingWeaponDeaths = 0;
    self.trackingWeaponHipFireKills = 0;
    self.trackingWeaponUseTime = 0;
    return;
  }

  if(!isCACPrimaryWeapon(tokens[0]) && !isCACSecondaryWeapon(tokens[0])) {
    return;
  }

  if(self.trackingWeaponShots > 0) {
    self incrementWeaponStat(tokens[0], "shots", self.trackingWeaponShots);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "shots", self.trackingWeaponShots);
  }

  if(self.trackingWeaponKills > 0) {
    self incrementWeaponStat(tokens[0], "kills", self.trackingWeaponKills);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "kills", self.trackingWeaponKills);
  }

  if(self.trackingWeaponHits > 0) {
    self incrementWeaponStat(tokens[0], "hits", self.trackingWeaponHits);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "hits", self.trackingWeaponHits);
  }

  if(self.trackingWeaponHeadShots > 0) {
    self incrementWeaponStat(tokens[0], "headShots", self.trackingWeaponHeadShots);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "headShots", self.trackingWeaponHeadShots);
  }

  if(self.trackingWeaponDeaths > 0) {
    self incrementWeaponStat(tokens[0], "deaths", self.trackingWeaponDeaths);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "deaths", self.trackingWeaponDeaths);
  }

  if(self.trackingWeaponHipFireKills > 0) {
    self incrementWeaponStat(tokens[0], "hipfirekills", self.trackingWeaponHipFireKills);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "hipfirekills", self.trackingWeaponHipFireKills);
  }

  if(self.trackingWeaponUseTime > 0) {
    self incrementWeaponStat(tokens[0], "timeInUse", self.trackingWeaponUseTime);
    self maps\mp\_matchdata::logWeaponStat(tokens[0], "timeInUse", self.trackingWeaponUseTime);
  }

  attachments = GetWeaponAttachments(tmp);
  foreach(attachmentName in attachments) {
    attachmentBase = attachmentMap_toBase(attachmentName);
    if(attachmentBase == "gl" || attachmentBase == "shotgun") {
      continue;
    }

    if(self.trackingWeaponShots > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "shots", self.trackingWeaponShots);
      }

    }

    if(self.trackingWeaponKills > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "kills", self.trackingWeaponKills);
      }
    }

    if(self.trackingWeaponHits > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "hits", self.trackingWeaponHits);
      }
    }

    if(self.trackingWeaponHeadShots > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "headShots", self.trackingWeaponHeadShots);
      }
    }

    if(self.trackingWeaponHipFireKills > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "hipfirekills", self.trackingWeaponHipFireKills);
      }
    }

    if(self.trackingWeaponUseTime > 0) {
      if(attachmentBase != "tactical") {
        self incrementAttachmentStat(attachmentBase, "timeInUse", self.trackingWeaponUseTime);
      }
    }

    if(self.trackingWeaponDeaths > 0) {
      self incrementAttachmentStat(attachmentBase, "deaths", self.trackingWeaponDeaths);
    }
  }

  self.trackingWeaponName = "none";
  self.trackingWeaponShots = 0;
  self.trackingWeaponKills = 0;
  self.trackingWeaponHits = 0;
  self.trackingWeaponHeadShots = 0;
  self.trackingWeaponDeaths = 0;
  self.trackingWeaponHipFireKills = 0;
  self.trackingWeaponUseTime = 0;
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

  if(!wasLastRound()) {
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

  incrementCounter("global_kills", totalKills);
  incrementCounter("global_deaths", totalDeaths);
  incrementCounter("global_assists", totalAssists);
  incrementCounter("global_headshots", totalHeadshots);
  incrementCounter("global_suicides", totalSuicides);
  incrementCounter("global_games", 1);
}