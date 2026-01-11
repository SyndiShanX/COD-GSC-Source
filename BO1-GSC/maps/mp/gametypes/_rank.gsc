/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_rank.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level.scoreInfo = [];
  level.xpScale = GetDvarInt(#"scr_xpscale");
  level.codPointsXpScale = GetDvarFloat(#"scr_codpointsxpscale");
  level.codPointsMatchScale = GetDvarFloat(#"scr_codpointsmatchscale");
  level.codPointsChallengeScale = GetDvarFloat(#"scr_codpointsperchallenge");
  level.rankXpCap = GetDvarInt(#"scr_rankXpCap");
  level.codPointsCap = GetDvarInt(#"scr_codPointsCap");
  level.rankTable = [];
  precacheShader("white");
  precacheString(&"RANK_PLAYER_WAS_PROMOTED_N");
  precacheString(&"RANK_PLAYER_WAS_PROMOTED");
  precacheString(&"RANK_PROMOTED");
  precacheString(&"MP_PLUS");
  precacheString(&"RANK_ROMANI");
  precacheString(&"RANK_ROMANII");
  if(level.teamBased) {
    registerScoreInfo("kill", 100);
    registerScoreInfo("headshot", 100);
    registerScoreInfo("assist_75", 80);
    registerScoreInfo("assist_50", 60);
    registerScoreInfo("assist_25", 40);
    registerScoreInfo("assist", 20);
    registerScoreInfo("suicide", 0);
    registerScoreInfo("teamkill", 0);
    registerScoreInfo("dogkill", 30);
    registerScoreInfo("dogassist", 10);
    registerScoreInfo("helicopterkill", 200);
    registerScoreInfo("helicopterassist", 50);
    registerScoreInfo("helicopterassist_75", 150);
    registerScoreInfo("helicopterassist_50", 100);
    registerScoreInfo("helicopterassist_25", 50);
    registerScoreInfo("spyplanekill", 100);
    registerScoreInfo("spyplaneassist", 50);
    registerScoreInfo("rcbombdestroy", 50);
  } else {
    registerScoreInfo("kill", 50);
    registerScoreInfo("headshot", 50);
    registerScoreInfo("assist_75", 0);
    registerScoreInfo("assist_50", 0);
    registerScoreInfo("assist_25", 0);
    registerScoreInfo("assist", 0);
    registerScoreInfo("suicide", 0);
    registerScoreInfo("teamkill", 0);
    registerScoreInfo("dogkill", 20);
    registerScoreInfo("dogassist", 0);
    registerScoreInfo("helicopterkill", 100);
    registerScoreInfo("helicopterassist", 0);
    registerScoreInfo("helicopterassist_75", 0);
    registerScoreInfo("helicopterassist_50", 0);
    registerScoreInfo("helicopterassist_25", 0);
    registerScoreInfo("spyplanekill", 25);
    registerScoreInfo("spyplaneassist", 0);
    registerScoreInfo("rcbombdestroy", 30);
  }
  registerScoreInfo("win", 1);
  registerScoreInfo("loss", 0.5);
  registerScoreInfo("tie", 0.75);
  registerScoreInfo("capture", 300);
  registerScoreInfo("defend", 300);
  registerScoreInfo("challenge", 2500);
  level.maxRank = int(tableLookup("mp/rankTable.csv", 0, "maxrank", 1));
  level.maxPrestige = int(tableLookup("mp/rankIconTable.csv", 0, "maxprestige", 1));
  pId = 0;
  rId = 0;
  for(pId = 0; pId <= level.maxPrestige; pId++) {
    for(rId = 0; rId <= level.maxRank; rId++) {
      precacheShader(tableLookup("mp/rankIconTable.csv", 0, rId, pId + 1));
    }
  }
  rankId = 0;
  rankName = tableLookup("mp/ranktable.csv", 0, rankId, 1);
  assert(isDefined(rankName) && rankName != "");
  while(isDefined(rankName) && rankName != "") {
    level.rankTable[rankId][1] = tableLookup("mp/ranktable.csv", 0, rankId, 1);
    level.rankTable[rankId][2] = tableLookup("mp/ranktable.csv", 0, rankId, 2);
    level.rankTable[rankId][3] = tableLookup("mp/ranktable.csv", 0, rankId, 3);
    level.rankTable[rankId][7] = tableLookup("mp/ranktable.csv", 0, rankId, 7);
    level.rankTable[rankId][14] = tableLookup("mp/ranktable.csv", 0, rankId, 14);
    precacheString(tableLookupIString("mp/ranktable.csv", 0, rankId, 16));
    rankId++;
    rankName = tableLookup("mp/ranktable.csv", 0, rankId, 1);
  }
  level.numStatsMilestoneTiers = 4;
  level.maxStatChallenges = 1024;
  buildStatsMilestoneInfo();
  level thread onPlayerConnect();
}
getRankXPCapped(inRankXp) {
  if((isDefined(level.rankXpCap)) && level.rankXpCap && (level.rankXpCap <= inRankXp)) {
    return level.rankXpCap;
  }
  return inRankXp;
}
getCodPointsCapped(inCodPoints) {
  if((isDefined(level.codPointsCap)) && level.codPointsCap && (level.codPointsCap <= inCodPoints)) {
    return level.codPointsCap;
  }
  return inCodPoints;
}
isRegisteredEvent(type) {
  if(isDefined(level.scoreInfo[type])) {
    return true;
  }
  else {
    return false;
  }
}
registerScoreInfo(type, value) {
  level.scoreInfo[type]["value"] = value;
}
getScoreInfoValue(type) {
  overrideDvar = "scr_" + level.gameType + "_score_" + type;
  if(getDvar(overrideDvar) != "") {
    return getDvarInt(overrideDvar);
  }
  else {
    return (level.scoreInfo[type]["value"]);
  }
}
getScoreInfoLabel(type) {
  return (level.scoreInfo[type]["label"]);
}
getRankInfoMinXP(rankId) {
  return int(level.rankTable[rankId][2]);
}
getRankInfoXPAmt(rankId) {
  return int(level.rankTable[rankId][3]);
}
getRankInfoMaxXp(rankId) {
  return int(level.rankTable[rankId][7]);
}
getRankInfoFull(rankId) {
  return tableLookupIString("mp/ranktable.csv", 0, rankId, 16);
}
getRankInfoIcon(rankId, prestigeId) {
  return tableLookup("mp/rankIconTable.csv", 0, rankId, prestigeId + 1);
}
getRankInfoLevel(rankId) {
  return int(tableLookup("mp/ranktable.csv", 0, rankId, 13));
}
getRankInfoCodPointsEarned(rankId) {
  return int(tableLookup("mp/ranktable.csv", 0, rankId, 17));
}
shouldKickByRank() {
  if(self IsHost()) {
    return false;
  }
  if(level.rankCap > 0 && self.pers["rank"] > level.rankCap) {
    return true;
  }
  if((level.rankCap > 0) && (level.minPrestige == 0) && (self.pers["plevel"] > 0)) {
    return true;
  }
  if(level.minPrestige > self.pers["plevel"]) {
    return true;
  }
  return false;
}
getCodPointsStat() {
  codPoints = self maps\mp\gametypes\_persistence::statGet("CODPOINTS");
  codPointsCapped = getCodPointsCapped(codPoints);
  if(codPoints > codPointsCapped) {
    self setCodPointsStat(codPointsCapped);
  }
  return codPointsCapped;
}
setCodPointsStat(codPoints) {
  self maps\mp\gametypes\_persistence::setPlayerStat("PlayerStatsList", "CODPOINTS", getCodPointsCapped(codPoints));
}
getRankXpStat() {
  rankXp = self maps\mp\gametypes\_persistence::statGet("RANKXP");
  rankXpCapped = getRankXPCapped(rankXp);
  if(rankXp > rankXpCapped) {
    self maps\mp\gametypes\_persistence::statSet("RANKXP", rankXpCapped, false);
  }
  return rankXpCapped;
}
onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player.pers["rankxp"] = player getRankXpStat();
    player.pers["codpoints"] = player getCodPointsStat();
    player.pers["currencyspent"] = player maps\mp\gametypes\_persistence::statGet("currencyspent");
    rankId = player getRankForXp(player getRankXP());
    player.pers["rank"] = rankId;
    player.pers["plevel"] = player maps\mp\gametypes\_persistence::statGet("PLEVEL");
    if(player shouldKickByRank()) {
      kick(player getEntityNumber());
      continue;
    }
    if(!isDefined(player.pers["participation"]) || !((level.gameType == "twar") && (0 < game["roundsplayed"]) && (0 < player.pers["participation"]))) {
      player.pers["participation"] = 0;
    }
    player.rankUpdateTotal = 0;
    player.cur_rankNum = rankId;
    assertex(isDefined(player.cur_rankNum), "rank: " + rankId + " does not have an index, check mp/ranktable.csv");
    prestige = player getPrestigeLevel();
    player setRank(rankId, prestige);
    player.pers["prestige"] = prestige;
    if(!isDefined(player.pers["summary"])) {
      player.pers["summary"] = [];
      player.pers["summary"]["xp"] = 0;
      player.pers["summary"]["score"] = 0;
      player.pers["summary"]["challenge"] = 0;
      player.pers["summary"]["match"] = 0;
      player.pers["summary"]["misc"] = 0;
      player.pers["summary"]["codpoints"] = 0;
    }
    player setclientdvar("ui_lobbypopup", "");
    if(level.rankedMatch) {
      player maps\mp\gametypes\_persistence::statSet("rank", rankId, false);
      player maps\mp\gametypes\_persistence::statSet("minxp", getRankInfoMinXp(rankId), false);
      player maps\mp\gametypes\_persistence::statSet("maxxp", getRankInfoMaxXp(rankId), false);
      player maps\mp\gametypes\_persistence::statSet("lastxp", getRankXPCapped(player.pers["rankxp"]), false);
    }
    player.explosiveKills[0] = 0;
    player.xpGains = [];
    player thread onPlayerSpawned();
    player thread onJoinedTeam();
    player thread onJoinedSpectators();
  }
}
onJoinedTeam() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    self thread removeRankHUD();
  }
}
onJoinedSpectators() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_spectators");
    self thread removeRankHUD();
  }
}
onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    if(!isDefined(self.hud_rankscroreupdate)) {
      self.hud_rankscroreupdate = NewScoreHudElem(self);
      self.hud_rankscroreupdate.horzAlign = "center";
      self.hud_rankscroreupdate.vertAlign = "middle";
      self.hud_rankscroreupdate.alignX = "center";
      self.hud_rankscroreupdate.alignY = "middle";
      self.hud_rankscroreupdate.x = 0;
      if(self IsSplitscreen()) {
        self.hud_rankscroreupdate.y = -15;
      }
      else {
        self.hud_rankscroreupdate.y = -60;
      }
      self.hud_rankscroreupdate.font = "default";
      self.hud_rankscroreupdate.fontscale = 2.0;
      self.hud_rankscroreupdate.archived = false;
      self.hud_rankscroreupdate.color = (0.5, 0.5, 0.5);
      self.hud_rankscroreupdate.alpha = 0;
      self.hud_rankscroreupdate.sort = 50;
      self.hud_rankscroreupdate maps\mp\gametypes\_hud::fontPulseInit();
      self.hud_rankscroreupdate.overrridewhenindemo = true;
    }
  }
}
incCodPoints(amount) {
  if(!isRankEnabled()) {
    return;
  }
  if(level.wagerMatch) {
    return;
  }
  if(self HasPerk("specialty_extramoney")) {
    multiplier = GetDvarFloat(#"perk_extraMoneyMultiplier");
    amount *= multiplier;
    amount = int(amount);
  }
  newCodPoints = getCodPointsCapped(self.pers["codpoints"] + amount);
  if(newCodPoints > self.pers["codpoints"]) {
    self.pers["summary"]["codpoints"] += (newCodPoints - self.pers["codpoints"]);
  }
  self.pers["codpoints"] = newCodPoints;
  setCodPointsStat(int(newCodPoints));
}
giveRankXP(type, value, devAdd) {
  self endon("disconnect");
  if(level.teamBased && (!level.playerCount["allies"] || !level.playerCount["axis"]) && !isDefined(devAdd)) {
    return;
  }
  else if(!level.teamBased && (level.playerCount["allies"] + level.playerCount["axis"] < 2) && !isDefined(devAdd)) {
    return;
  }
  if(!isRankEnabled()) {
    return;
  }
  if(level.wagerMatch || !level.onlineGame || (GetDvarInt(#"xblive_privatematch") && !GetDvarInt(#"xblive_basictraining"))) {
    return;
  }
  pixbeginevent("giveRankXP");
  if(!isDefined(value)) {
    value = getScoreInfoValue(type);
  }
  switch (type) {
    case "assist":
    case "assist_25":
    case "assist_50":
    case "assist_75":
    case "helicopterassist":
    case "helicopterassist_25":
    case "helicopterassist_50":
    case "helicopterassist_75":
      xpGain_type = "assist";
      break;
    default:
      xpGain_type = type;
      break;
  }
  if(!isDefined(self.xpGains[xpGain_type])) {
    self.xpGains[xpGain_type] = 0;
  }
  if(level.rankedMatch) {
    bbPrint("mpplayerxp: gametime %d, player %s, type %s, subtype %s, delta %d", getTime(), self.name, xpGain_type, type, value);
  }
  switch (type) {
    case "kill":
    case "headshot":
    case "assist":
    case "assist_25":
    case "assist_50":
    case "assist_75":
    case "helicopterassist":
    case "helicopterassist_25":
    case "helicopterassist_50":
    case "helicopterassist_75":
    case "helicopterkill":
    case "rcbombdestroy":
    case "spyplanekill":
    case "spyplaneassist":
    case "dogkill":
    case "dogassist":
    case "capture":
    case "defend":
    case "return":
    case "pickup":
    case "plant":
    case "defuse":
    case "destroyer":
    case "assault":
    case "assault_assist":
    case "revive":
    case "medal":
      value = int(value * level.xpScale);
      break;
    default:
      if(level.xpScale == 0) {
        value = 0;
      }
      break;
  }
  self.xpGains[xpGain_type] += value;
  xpIncrease = self incRankXP(value);
  if(level.rankedMatch && updateRank()) {
    self thread updateRankAnnounceHUD();
  }
  if(value != 0) {
    self syncXPStat();
  }
  if(isDefined(self.enableText) && self.enableText && !level.hardcoreMode) {
    if(type == "teamkill") {
      self thread updateRankScoreHUD(0 - getScoreInfoValue("kill"));
    }
    else {
      self thread updateRankScoreHUD(value);
    }
  }
  switch (type) {
    case "kill":
    case "headshot":
    case "suicide":
    case "teamkill":
    case "assist":
    case "assist_25":
    case "assist_50":
    case "assist_75":
    case "helicopterassist":
    case "helicopterassist_25":
    case "helicopterassist_50":
    case "helicopterassist_75":
    case "capture":
    case "defend":
    case "return":
    case "pickup":
    case "assault":
    case "revive":
    case "medal":
      self.pers["summary"]["score"] += value;
      incCodPoints(round_this_number(value * level.codPointsXPScale));
      break;
    case "win":
    case "loss":
    case "tie":
      self.pers["summary"]["match"] += value;
      incCodPoints(round_this_number(value * level.codPointsMatchScale));
      break;
    case "challenge":
      self.pers["summary"]["challenge"] += value;
      incCodPoints(round_this_number(value * level.codPointsChallengeScale));
      break;
    default:
      self.pers["summary"]["misc"] += value;
      self.pers["summary"]["match"] += value;
      incCodPoints(round_this_number(value * level.codPointsMatchScale));
      break;
  }
  self.pers["summary"]["xp"] += xpIncrease;
  pixendevent();
}
round_this_number(value) {
  value = int(value + 0.5);
  return value;
}
updateRank() {
  newRankId = self getRank();
  if(newRankId == self.pers["rank"]) {
    return false;
  }
  oldRank = self.pers["rank"];
  rankId = self.pers["rank"];
  self.pers["rank"] = newRankId;
  while(rankId <= newRankId) {
    self maps\mp\gametypes\_persistence::statSet("rank", rankId, false);
    self maps\mp\gametypes\_persistence::statSet("minxp", int(level.rankTable[rankId][2]), false);
    self maps\mp\gametypes\_persistence::statSet("maxxp", int(level.rankTable[rankId][7]), false);
    self.setPromotion = true;
    if(level.rankedMatch && level.gameEnded && !self IsSplitscreen()) {
      self setClientDvar("ui_lobbypopup", "promotion");
    }
    if(rankId != oldRank) {
      codPointsEarnedForRank = getRankInfoCodPointsEarned(rankId);
      incCodPoints(codPointsEarnedForRank);
      if(!isDefined(self.pers["rankcp"])) {
        self.pers["rankcp"] = 0;
      }
      self.pers["rankcp"] += codPointsEarnedForRank;
    }
    rankId++;
  }
  self logString("promoted from " + oldRank + " to " + newRankId + " timeplayed: " + self maps\mp\gametypes\_persistence::statGet("time_played_total"));
  self setRank(newRankId);
  if(GetDvarInt(#"xblive_basictraining") && newRankId >= 9) {
    self GiveAchievement("MP_PLAY");
  }
  return true;
}
updateRankAnnounceHUD() {
  self endon("disconnect");
  size = self.rankNotifyQueue.size;
  self.rankNotifyQueue[size] = spawnStruct();
  display_rank_column = 14;
  self.rankNotifyQueue[size].rank = int(level.rankTable[self.pers["rank"]][display_rank_column]);
  self.rankNotifyQueue[size].prestige = self.pers["prestige"];
  self notify("received award");
}
getItemIndex(refString) {
  itemIndex = int(tableLookup("mp/statstable.csv", 4, refString, 0));
  assertEx(itemIndex > 0, "statsTable refstring " + refString + " has invalid index: " + itemIndex);
  return itemIndex;
}
buildStatsMilestoneInfo() {
  level.statsMilestoneInfo = [];
  for(tierNum = 1; tierNum <= level.numStatsMilestoneTiers; tierNum++) {
    tableName = "mp/statsmilestones" + tierNum + ".csv";
    moveToNextTable = false;
    for(idx = 0; idx < level.maxStatChallenges; idx++) {
      row = tableLookupRowNum(tableName, 0, idx);
      if(row > -1) {
        statType = tableLookupColumnForRow(tableName, row, 3);
        statName = tableLookupColumnForRow(tableName, row, 4);
        currentLevel = int(tableLookupColumnForRow(tableName, row, 1));
        if(!isDefined(level.statsMilestoneInfo[statType])) {
          level.statsMilestoneInfo[statType] = [];
        }
        if(!isDefined(level.statsMilestoneInfo[statType][statName])) {
          level.statsMilestoneInfo[statType][statName] = [];
        }
        level.statsMilestoneInfo[statType][statName][currentLevel] = [];
        level.statsMilestoneInfo[statType][statName][currentLevel]["index"] = idx;
        level.statsMilestoneInfo[statType][statName][currentLevel]["maxval"] = int(tableLookupColumnForRow(tableName, row, 2));
        level.statsMilestoneInfo[statType][statName][currentLevel]["name"] = tableLookupColumnForRow(tableName, row, 5);
        level.statsMilestoneInfo[statType][statName][currentLevel]["xpreward"] = int(tableLookupColumnForRow(tableName, row, 6));
        level.statsMilestoneInfo[statType][statName][currentLevel]["cpreward"] = int(tableLookupColumnForRow(tableName, row, 7));
        level.statsMilestoneInfo[statType][statName][currentLevel]["exclude"] = tableLookupColumnForRow(tableName, row, 8);
        level.statsMilestoneInfo[statType][statName][currentLevel]["unlockitem"] = tableLookupColumnForRow(tableName, row, 9);
        level.statsMilestoneInfo[statType][statName][currentLevel]["unlocklvl"] = int(tableLookupColumnForRow(tableName, row, 11));
      }
    }
  }
}
endGameUpdate() {
  player = self;
}
updateRankScoreHUD(amount) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  if(amount == 0) {
    return;
  }
  self notify("update_score");
  self endon("update_score");
  self.rankUpdateTotal += amount;
  wait(0.05);
  if(isDefined(self.hud_rankscroreupdate)) {
    if(self.rankUpdateTotal < 0) {
      self.hud_rankscroreupdate.label = &"";
      self.hud_rankscroreupdate.color = (0.73, 0.19, 0.19);
    } else {
      self.hud_rankscroreupdate.label = &"MP_PLUS";
      self.hud_rankscroreupdate.color = (1, 1, 0.5);
    }
    self.hud_rankscroreupdate setValue(self.rankUpdateTotal);
    self.hud_rankscroreupdate.alpha = 0.85;
    self.hud_rankscroreupdate thread maps\mp\gametypes\_hud::fontPulse(self);
    wait 1;
    self.hud_rankscroreupdate fadeOverTime(0.75);
    self.hud_rankscroreupdate.alpha = 0;
    self.rankUpdateTotal = 0;
  }
}
removeRankHUD() {
  if(isDefined(self.hud_rankscroreupdate)) {
    self.hud_rankscroreupdate.alpha = 0;
  }
}
getRank() {
  rankXp = getRankXPCapped(self.pers["rankxp"]);
  rankId = self.pers["rank"];
  if(rankXp < (getRankInfoMinXP(rankId) + getRankInfoXPAmt(rankId))) {
    return rankId;
  }
  else {
    return self getRankForXp(rankXp);
  }
}
getRankForXp(xpVal) {
  rankId = 0;
  rankName = level.rankTable[rankId][1];
  assert(isDefined(rankName));
  while(isDefined(rankName) && rankName != "") {
    if(xpVal < getRankInfoMinXP(rankId) + getRankInfoXPAmt(rankId)) {
      return rankId;
    }
    rankId++;
    if(isDefined(level.rankTable[rankId])) {
      rankName = level.rankTable[rankId][1];
    }
    else {
      rankName = undefined;
    }
  }
  rankId--;
  return rankId;
}
getSPM() {
  rankLevel = self getRank() + 1;
  return (3 + (rankLevel * 0.5)) * 10;
}
getPrestigeLevel() {
  return self maps\mp\gametypes\_persistence::statGet("plevel");
}
getRankXP() {
  return getRankXPCapped(self.pers["rankxp"]);
}
incRankXP(amount) {
  if(!level.rankedMatch) {
    return 0;
  }
  xp = self getRankXP();
  newXp = getRankXPCapped(xp + amount);
  if(self.pers["rank"] == level.maxRank && newXp >= getRankInfoMaxXP(level.maxRank)) {
    newXp = getRankInfoMaxXP(level.maxRank);
  }
  xpIncrease = getRankXPCapped(newXp) - self.pers["rankxp"];
  if(xpIncrease < 0) {
    xpIncrease = 0;
  }
  self.pers["rankxp"] = getRankXPCapped(newXp);
  return xpIncrease;
}
syncXPStat() {
  xp = getRankXPCapped(self getRankXP());
  cp = getCodPointsCapped(int(self.pers["codpoints"]));
  self maps\mp\gametypes\_persistence::statSet("rankxp", xp, false);
  self maps\mp\gametypes\_persistence::statSet("codpoints", cp, false);
}