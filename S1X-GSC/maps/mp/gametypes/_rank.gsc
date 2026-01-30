/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_rank.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

RANK_TABLE = "mp/rankTable.csv";
RANK_ICON_TABLE = "mp/rankIconTable.csv";

init() {
  level.xpScale = getXPScale();
  level.xpEventInfo = [];
  level.rankTable = [];
  level.maxRank = int(tableLookup(RANK_TABLE, 0, "maxrank", 1));
  level.maxPrestige = int(tableLookup(RANK_ICON_TABLE, 0, "maxPrestige", 1));

  rankId = 0;
  rankName = tableLookup(RANK_TABLE, 0, rankId, 1);
  assert(isDefined(rankName) && rankName != "");

  while(isDefined(rankName) && rankName != "") {
    level.rankTable[rankId][1] = tableLookup(RANK_TABLE, 0, rankId, 1);
    level.rankTable[rankId][2] = tableLookup(RANK_TABLE, 0, rankId, 2);
    level.rankTable[rankId][3] = tableLookup(RANK_TABLE, 0, rankId, 3);
    level.rankTable[rankId][7] = tableLookup(RANK_TABLE, 0, rankId, 7);

    rankId++;
    rankName = tableLookup(RANK_TABLE, 0, rankId, 1);
  }

  maps\mp\gametypes\_missions::buildChallegeInfo();

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!IsAI(player) && (player rankingEnabled())) {
      prestige = player getPrestigeLevel();
      rankXP = player maps\mp\gametypes\_persistence::statGet("experience");

      if(rankXP < 0) {
        rankXP = 0;
      }

      redeemedXP = player GetTotalMpXp() - rankXP;
      matchStartXp = player GetTotalMpXp();
    } else if(IsAI(player)) {
      player set_rank_xp_and_prestige_for_bot();
      rankXP = player.pers["rankxp"];
      prestige = player.pers["prestige"];
      redeemedXP = 0;
      matchStartXp = rankXP;
    } else {
      prestige = 0;
      rankXP = 0;
      redeemedXP = 0;
      matchStartXp = rankXP;
    }

    player.pers["rankxp"] = rankXP;
    player.pers["redeemedxp"] = redeemedXP;
    player.pers["prestige"] = prestige;
    player.pers["participation"] = 0;

    rankId = player getRankForXp(player getTotalXP());
    player.pers["rank"] = rankId;

    player.xpUpdateTotal = 0;
    player.postGamePromotion = false;
    player.explosiveKills[0] = 0;

    player setRank(rankId, prestige);

    player processPrestigeMastery(prestige, rankXP);

    if(player.clientid < level.MaxLogClients) {
      setMatchData("players", player.clientid, "Prestige", prestige);
      setMatchData("players", player.clientid, "rankAtStart", clampToByte(player.pers["rank"]));
    }

    if(!isDefined(player.pers["postGameChallenges"])) {
      player setClientDvars("ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "");
    }

    player setClientDvar("ui_promotion", 0);

    if(!isDefined(player.pers["summary"])) {
      player.pers["summary"] = [];
      player.pers["summary"]["xp"] = 0;
      player.pers["summary"]["score"] = 0;
      player.pers["summary"]["challenge"] = 0;
      player.pers["summary"]["match"] = 0;
      player.pers["summary"]["misc"] = 0;
      player.pers["summary"]["entitlementXP"] = 0;
      player.pers["summary"]["clanWarsXP"] = 0;
      player.pers["summary"]["matchStartXp"] = matchStartXp;
    }

    if(GetDvar("virtualLobbyActive") != "1") {
      player setClientDvar("ui_opensummary", 0);

      player thread maps\mp\gametypes\_missions::updateChallenges();
    }

    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    AssertEx(isDefined(self.class), "Player should have class here.");
  }
}

getXPScale() {
  xpScale = getDvarInt("scr_xpscale");

  if(xpScale > 4 || xpScale < 0) {
    exitLevel(false);
  }

  return xpScale;
}

isRegisteredEvent(event) {
  if(isDefined(level.xpEventInfo[event])) {
    return true;
  } else {
    return false;
  }
}

registerXPEventInfo(event, value, allowPlayerScore, playSplash) {
  level.xpEventInfo[event]["value"] = value;
  level.xpEventInfo[event]["allowPlayerScore"] = 0;
  level.xpEventInfo[event]["playSplash"] = 0;

  if(isDefined(allowPlayerScore) && allowPlayerScore) {
    level.xpEventInfo[event]["allowPlayerScore"] = 1;
  }

  if(isDefined(playSplash) && playSplash) {
    level.xpEventInfo[event]["playSplash"] = 1;
  }
}

allowPlayerScore(event) {
  return level.xpEventInfo[event]["allowPlayerScore"];
}

shouldPlaySplash(event) {
  return level.xpEventInfo[event]["playSplash"];
}

getScoreInfoValue(type) {
  overrideDvar = "scr_" + level.gameType + "_score_" + type;

  if(getDvar(overrideDvar) != "") {
    return getDvarInt(overrideDvar);
  }

  assertEx(isDefined(level.xpEventInfo[type]["value"]), "Unknown event: " + type);

  return level.xpEventInfo[type]["value"];
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
  return tableLookupIString(RANK_TABLE, 0, rankId, 16);
}

getRankInfoLevel(rankId) {
  return int(tableLookup(RANK_TABLE, 0, rankId, 13));
}

awardGameEvent(event, player, currentWeapon, victim, sMeansOfDeath) {
  assertEx(isDefined(level.xpEventInfo[event]), "Unknown event: " + event);

  if(inVirtualLobby()) {
    return;
  }

  if(shouldPlaySplash(event)) {
    player thread maps\mp\gametypes\_hud_message::splashNotify(event);
  }

  player giveRankXP(event, undefined, currentWeapon, sMeansOfDeath, undefined, victim);

  if(allowPlayerScore(event)) {
    player maps\mp\gametypes\_gamescore::givePlayerScore(event, player, victim);
  }
}

giveRankXP(type, value, weapon, sMeansOfDeath, challengeName, victim) {
  self endon("disconnect");

  if(isDefined(self.owner) && !IsBot(self)) {
    self.owner giveRankXP(type, value, weapon, sMeansOfDeath, challengeName, victim);
    return;
  }

  if(isAI(self)) {
    return;
  }

  if(!IsPlayer(self)) {
    return;
  }

  if(!self rankingEnabled()) {
    return;
  }

  if(level.teamBased && (!level.teamCount["allies"] || !level.teamCount["axis"])) {
    return;
  }

  if(!level.teamBased && (level.teamCount["allies"] + level.teamCount["axis"] < 2)) {
    return;
  }

  if(isDefined(level.disableRanking) && level.disableRanking) {
    return;
  }

  if(practiceRoundGame()) {
    return;
  }

  if(!isDefined(value)) {
    value = getScoreInfoValue(type);
  }

  if(value == 0) {
    return;
  }

  if(value > 0 && !isDefined(self.lootPlayTimeValidated)) {
    self.lootPlayTimeValidated = true;
    lootservicevalidateplaytime(self.xuid);
  }

  modifiedValue = value;

  clanWarsXPMod = 0;

  switch (type) {
    case "challenge":
    case "win":
    case "tie":
    case "loss": {
      break;
    }
    default: {
      if(getGametypeNumLives() > 0 && (type != "shield_damage")) {
        multiplier = max(1, int(10 / getGametypeNumLives()));

        if(level.gameType == "sr") {
          multiplier = max(1, int(5 / getGametypeNumLives()));
        }

        modifiedValue = int(modifiedValue * multiplier);
      }

      if(level.xpScale > 1) {
        modifiedValue = int(modifiedValue * level.xpScale);
      }

      if(self GetRankedPlayerData("hasDoubleXPItem")) {
        modifiedValue = int(modifiedValue * 2);
      }

      if(isDefined(level.nukeDetonated) && level.nukeDetonated) {
        if(level.teamBased && level.nukeInfo.team == self.team) {
          modifiedValue *= level.nukeInfo.xpScalar;
        } else if(!level.teamBased && level.nukeInfo.player == self) {
          modifiedValue *= level.nukeInfo.xpScalar;
        }

        modifiedValue = int(modifiedValue);
      }

      clanWarsXPMod = self GetClanWarsBonus();

      AssertEx((modifiedValue < 100000), "Tried to award " + self.name + "over 100000 XP: " + modifiedValue);

      break;
    }
  }

  clanWarsBonus = int(modifiedValue * clanWarsXPMod);

  oldxp = self getRankXP();
  self incRankXP(modifiedValue + clanWarsBonus);

  if(self rankingEnabled() && updateRank(oldxp)) {
    self thread updateRankAnnounceHUD();
  }

  self syncXPStat();

  weaponChallenge = maps\mp\gametypes\_missions::isWeaponChallenge(challengeName);
  if(weaponChallenge) {
    weapon = self GetCurrentWeapon();
  }

  if(type == "shield_damage") {
    weapon = self GetCurrentWeapon();
    sMeansOfDeath = "MOD_MELEE";
  }

  self.pers["summary"]["clanWarsXP"] += clanWarsBonus;
  self.pers["summary"]["xp"] += (modifiedValue + clanWarsBonus);

  switch (type) {
    case "win":
    case "loss":
    case "tie":
      self.pers["summary"]["match"] += modifiedValue;
      break;

    case "challenge":
      self.pers["summary"]["challenge"] += modifiedValue;
      break;
    default: {
      if(isRegisteredEvent(type)) {
        self.pers["summary"]["score"] += modifiedValue;
      } else {
        self.pers["summary"]["misc"] += modifiedValue;
      }
      break;
    }
  }
}

updateRank(oldxp) {
  newRankId = self getRank();
  if(newRankId == self.pers["rank"]) {
    return false;
  }

  oldRank = self.pers["rank"];
  self.pers["rank"] = newRankId;

  println("promoted " + self.name + " from rank " + oldRank + " to " + newRankId + ". Experience went from " + oldxp + " to " + self getRankXP() + ".");

  self setRank(newRankId);

  return true;
}

updateRankAnnounceHUD() {
  self endon("disconnect");

  self notify("update_rank");
  self endon("update_rank");

  team = self.pers["team"];
  if(!isDefined(team)) {
    return;
  }

  if(!levelFlag("game_over")) {
    level waittill_notify_or_timeout("game_over", 0.25);
  }

  newRankName = self getRankInfoFull(self.pers["rank"]);
  rank_char = level.rankTable[self.pers["rank"]][1];
  subRank = int(rank_char[rank_char.size - 1]);

  self thread maps\mp\gametypes\_hud_message::rankupSplashNotify("ranked_up", self.pers["rank"], self.pers["prestige"]);

  if(subRank > 1) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    playerteam = player.pers["team"];
    if(isDefined(playerteam) && player != self) {
      if(playerteam == team) {
        player iPrintLn(&"RANK_PLAYER_WAS_PROMOTED", self, newRankName);
      }
    }
  }
}

xpPointsPopup(event, amount) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(amount == 0) {
    return;
  }

  self notify("xpPointsPopup");
  self endon("xpPointsPopup");

  self.xpUpdateTotal += amount;
  self SetClientOmnvar("ui_points_popup", self.xpUpdateTotal);

  eventId = TableLookupRowNum("mp/xp_event_table.csv", 0, event);
  if(!isDefined(eventId) || (isDefined(eventId) && eventId == -1)) {
    AssertMsg(event + " must be added to the xp_event_table.csv table");
  } else {
    self SetClientOmnvar("ui_points_popup_event", eventId);
  }

  wait(1);

  self.xpUpdateTotal = 0;
}

getRank() {
  rankXp = self getTotalXP();
  rankId = self.pers["rank"];

  if(rankXp < (getRankInfoMinXP(rankId) + getRankInfoXPAmt(rankId))) {
    return rankId;
  } else {
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
    } else {
      rankName = undefined;
    }
  }

  rankId--;
  return rankId;
}

getPrestigeLevel() {
  if(IsAI(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  } else {
    return self maps\mp\gametypes\_persistence::statGet("prestige");
  }
}

getRankXP() {
  if(isDefined(self.pers["rankxp"])) {
    return self.pers["rankxp"];
  } else {
    return 0;
  }
}

getRedeemedXP() {
  if(isDefined(self.pers["redeemedxp"])) {
    return self.pers["redeemedxp"];
  } else {
    return 0;
  }
}

getTotalXP() {
  return self getRankXP() + self getRedeemedXP();
}

incRankXP(amount) {
  if(!self rankingEnabled()) {
    return;
  }

  xp = self getRankXP();
  prestige = self getPrestigeLevel();

  maxXp = getRankInfoMaxXP(level.maxRank) - self getRedeemedXP();
  newXp = (int(min(xp, maxXp)) + amount);

  if(newXp > maxXp) {
    newXp = maxXp;
  }

  self.pers["rankxp"] = newXp;

  self processPrestigeMastery(prestige, newXp);
}

processPrestigeMastery(prestige, xp) {
  maxXp = getRankInfoMaxXP(level.maxRank) - self getRedeemedXP();

  if(prestige == level.maxPrestige && xp >= maxXp && !isDefined(self.pers["prestige16"])) {
    self.pers["prestige16"] = self SetPrestigeMastery();
    if(isDefined(self.pers["prestige16"])) {
      self thread maps\mp\gametypes\_hud_message::splashNotifyUrgent("prestige16");
    }
  }
}

syncXPStat() {
  xp = self getRankXP();

  oldXp = self GetRankedPlayerData("experience");
  assert(xp >= oldXp, "Attempted XP regression in syncXPStat - " + oldXp + " -> " + xp + " for player " + self.name);

  self maps\mp\gametypes\_persistence::statSet("experience", xp);
}