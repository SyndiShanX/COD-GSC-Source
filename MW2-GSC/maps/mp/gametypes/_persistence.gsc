/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
********************************************************/

#include maps\mp\_utility;

init() {
  level.persistentDataInfo = [];

  maps\mp\gametypes\_class::init();
  maps\mp\gametypes\_rank::init();
  maps\mp\gametypes\_missions::init();
  maps\mp\gametypes\_playercards::init();

  level thread updateBufferedStats();
}

initBufferedStats() {
  self.bufferedStats = [];
  self.bufferedStats["totalShots"] = self getPlayerData("totalShots");
  self.bufferedStats["accuracy"] = self getPlayerData("accuracy");
  self.bufferedStats["misses"] = self getPlayerData("misses");
  self.bufferedStats["hits"] = self getPlayerData("hits");
  self.bufferedStats["timePlayedAllies"] = self getPlayerData("timePlayedAllies");
  self.bufferedStats["timePlayedOpfor"] = self getPlayerData("timePlayedOpfor");
  self.bufferedStats["timePlayedOther"] = self getPlayerData("timePlayedOther");
  self.bufferedStats["timePlayedTotal"] = self getPlayerData("timePlayedTotal");

  self.bufferedChildStats = [];
  self.bufferedChildStats["round"] = [];
  self.bufferedChildStats["round"]["timePlayed"] = self getPlayerData("round", "timePlayed");
}

statGet(dataName) {
  assert(!isDefined(self.bufferedStats[dataName]));
  return self GetPlayerData(dataName);
}

statSet(dataName, value) {
  assert(!isDefined(self.bufferedStats[dataName]));

  if(!self rankingEnabled()) {
    return;
  }
  self SetPlayerData(dataName, value);
}

statAdd(dataName, value) {
  assert(!isDefined(self.bufferedStats[dataName]));

  if(!self rankingEnabled()) {
    return;
  }
  curValue = self GetPlayerData(dataName);
  self SetPlayerData(dataName, value + curValue);
}

statGetChild(parent, child) {
  return self GetPlayerData(parent, child);
}

statSetChild(parent, child, value) {
  if(!self rankingEnabled()) {
    return;
  }
  self SetPlayerData(parent, child, value);
}

statAddChild(parent, child, value) {
  assert(isDefined(self.bufferedChildStats[parent][child]));

  if(!self rankingEnabled()) {
    return;
  }
  curValue = self GetPlayerData(parent, child);
  self SetPlayerData(parent, child, curValue + value);
}

statGetChildBuffered(parent, child) {
  assert(isDefined(self.bufferedChildStats[parent][child]));

  return self.bufferedChildStats[parent][child];
}

statSetChildBuffered(parent, child, value) {
  assert(isDefined(self.bufferedChildStats[parent][child]));

  if(!self rankingEnabled()) {
    return;
  }
  self.bufferedChildStats[parent][child] = value;
}

statAddChildBuffered(parent, child, value) {
  assert(isDefined(self.bufferedChildStats[parent][child]));

  if(!self rankingEnabled()) {
    return;
  }
  curValue = statGetChildBuffered(parent, child);
  statSetChildBuffered(parent, child, curValue + value);
}

statGetBuffered(dataName) {
  assert(isDefined(self.bufferedStats[dataName]));

  return self.bufferedStats[dataName];
}

statSetBuffered(dataName, value) {
  assert(isDefined(self.bufferedStats[dataName]));

  if(!self rankingEnabled()) {
    return;
  }
  self.bufferedStats[dataName] = value;
}

statAddBuffered(dataName, value) {
  assert(isDefined(self.bufferedStats[dataName]));

  if(!self rankingEnabled()) {
    return;
  }
  curValue = statGetBuffered(dataName);
  statSetBuffered(dataName, curValue + value);
}

updateBufferedStats() {
  wait(0.15);

  nextToUpdate = 0;
  while(!level.gameEnded) {
    nextToUpdate++;
    if(nextToUpdate >= level.players.size)
      nextToUpdate = 0;

    if(isDefined(level.players[nextToUpdate]))
      level.players[nextToUpdate] writeBufferedStats();

    wait(2.0);
  }

  foreach(player in level.players)
  player writeBufferedStats();
}

writeBufferedStats() {
  foreach(statName, statVal in self.bufferedStats) {
    self setPlayerData(statName, statVal);
  }

  foreach(statName, statVal in self.bufferedChildStats) {
    foreach(childStatName, childStatVal in statVal)
    self setPlayerData(statName, childStatName, childStatVal);
  }
}