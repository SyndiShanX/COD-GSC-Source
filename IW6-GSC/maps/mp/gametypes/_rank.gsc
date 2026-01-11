/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_rank.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

WEAPONXP_KILL = 100;

HACK_MAX_PRESTIGE_PRECACHE = 10;

EARNED_SQUAD_POINT_XP = 3000;

STATS_TABLE = "mp/statsTable.csv";
RANK_TABLE = "mp/rankTable.csv";
RANK_ICON_TABLE = "mp/rankIconTable.csv";
WEAPON_RANK_TABLE = "mp/weaponRankTable.csv";
XP_EVENT_TABLE = "mp/xp_event_table.csv";

init() {
  level.scoreInfo = [];
  level.xpScale = getDvarInt("scr_xpscale");

  if(level.xpScale > 4 || level.xpScale < 0) {
    exitLevel(false);
  }

  level.xpScale = min(level.xpScale, 4);
  level.xpScale = max(level.xpScale, 0);

  level.teamXPScale["axis"] = 1;
  level.teamXPScale["allies"] = 1;

  level.rankTable = [];
  level.weaponRankTable = [];

  level.maxRank = int(tableLookup(RANK_TABLE, 0, "maxrank", 1));
  level.maxPrestige = int(tableLookup(RANK_TABLE, 0, "maxprestige", 1));

  level.maxForBotMatch = GetDvarInt("max_xp_per_match", 0);

  pId = 0;
  rId = 0;
  for(pId = 0; pId <= min(HACK_MAX_PRESTIGE_PRECACHE, level.maxPrestige); pId++) {
    for(rId = 0; rId <= level.maxRank; rId++) {
      precacheShader(tableLookup(RANK_ICON_TABLE, 0, rId, pId + 1));
    }
  }

  rankId = 0;
  rankName = tableLookup(RANK_TABLE, 0, rankId, 1);
  assert(isDefined(rankName) && rankName != "");

  while(isDefined(rankName) && rankName != "") {
    level.rankTable[rankId][1] = tableLookup(RANK_TABLE, 0, rankId, 1);
    level.rankTable[rankId][2] = tableLookup(RANK_TABLE, 0, rankId, 2);
    level.rankTable[rankId][3] = tableLookup(RANK_TABLE, 0, rankId, 3);
    level.rankTable[rankId][7] = tableLookup(RANK_TABLE, 0, rankId, 7);

    precacheString(tableLookupIString(RANK_TABLE, 0, rankId, 16));

    rankId++;
    rankName = tableLookup(RANK_TABLE, 0, rankId, 1);
  }

  weaponMaxRank = int(tableLookup(WEAPON_RANK_TABLE, 0, "maxrank", 1));
  for(i = 0; i < weaponMaxRank + 1; i++) {
    level.weaponRankTable[i][1] = tableLookup(WEAPON_RANK_TABLE, 0, i, 1);
    level.weaponRankTable[i][2] = tableLookup(WEAPON_RANK_TABLE, 0, i, 2);
    level.weaponRankTable[i][3] = tableLookup(WEAPON_RANK_TABLE, 0, i, 3);
  }

  maps\mp\gametypes\_missions::buildChallegeInfo();

  level thread patientZeroWaiter();

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("scr_devweaponxpmult", "0");
  SetDevDvarIfUninitialized("scr_devsetweaponmaxrank", "0");

  level thread watchDevDvars();
}

patientZeroWaiter() {
  level endon("game_ended");

  while(!isDefined(level.players) || !level.players.size) {
    wait(0.05);
  }

  if(!matchMakingGame()) {
    if((getDvar("mapname") == "mp_rust" && randomInt(1000) == 999)) {
      level.patientZeroName = level.players[0].name;
    }
  } else {
    if(getDvar("scr_patientZero") != "") {
      level.patientZeroName = getDvar("scr_patientZero");
    }
  }
}

isRegisteredEvent(type) {
  if(isDefined(level.scoreInfo[type])) {
    return true;
  } else {
    return false;
  }
}

registerScoreInfo(type, value) {
  level.scoreInfo[type]["value"] = value;
  if(type == "kill") {
    SetOmnvar("ui_game_type_kill_value", int(value));
  }
}

getScoreInfoValue(type) {
  overrideDvar = "scr_" + level.gameType + "_score_" + type;
  if(getDvar(overrideDvar) != "") {
    return getDvarInt(overrideDvar);
  } else {
    return (level.scoreInfo[type]["value"]);
  }
}

getScoreInfoLabel(type) {
  return (level.scoreInfo[type]["label"]);
}

getRankInfoMinXP(rankId) {
  return int(level.rankTable[rankId][2]);
}

getWeaponRankInfoMinXP(rankId) {
  return int(level.weaponRankTable[rankId][1]);
}

getRankInfoXPAmt(rankId) {
  return int(level.rankTable[rankId][3]);
}

getWeaponRankInfoXPAmt(rankId) {
  return int(level.weaponRankTable[rankId][2]);
}

getRankInfoMaxXP(rankId) {
  return int(level.rankTable[rankId][7]);
}

getWeaponRankInfoMaxXp(rankId) {
  return int(level.weaponRankTable[rankId][3]);
}

getRankInfoFull(rankId) {
  return tableLookupIString(RANK_TABLE, 0, rankId, 16);
}

getRankInfoIcon(rankId, prestigeId) {
  return tableLookup(RANK_ICON_TABLE, 0, rankId, prestigeId + 1);
}

getRankInfoLevel(rankId) {
  return int(tableLookup(RANK_TABLE, 0, rankId, 13));
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(getDvarInt("scr_forceSequence")) {
      player setRankedPlayerData("experience", 145499);
    }

    if(!isAI(player)) {
      if(MatchMakingGame()) {
        player.pers["activeSquadMember"] = player GetRankedPlayerData("activeSquadMember");
        player.pers["rankxp"] = player getRankedPlayerData("squadMembers", player.pers["activeSquadMember"], "squadMemXP");
        prestige = player getRankedPlayerDataReservedInt("prestigeLevel");

        if(!isDefined(player.pers["xpEarnedThisMatch"])) {
          player.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        player.pers["activeSquadMember"] = player GetPrivatePlayerData("privateMatchActiveSquadMember");
        prestige = 0;
        player.pers["rankxp"] = 0;
      }
    } else {
      prestige = 0;
      player.pers["rankxp"] = 0;
    }

    player.pers["prestige"] = prestige;

    if(player.pers["rankxp"] < 0) {
      player.pers["rankxp"] = 0;
    }

    rankId = player getRankForXp(player getRankXP());
    player.pers["rank"] = rankId;
    player setRank(rankId, prestige);

    if(player.clientid < level.MaxLogClients) {
      setMatchData("players", player.clientid, "rank", rankId);
      setMatchData("players", player.clientid, "Prestige", prestige);

      if(!isAi(player) && (privateMatch() || MatchMakingGame())) {
        setMatchData("players", player.clientid, "isSplitscreen", player isSplitscreenPlayer());
        setMatchData("players", player.clientid, "activeSquadMember", player.pers["activeSquadMember"]);
      }
    }

    player.pers["participation"] = 0;

    player.xpUpdateTotal = 0;
    player.bonusUpdateTotal = 0;

    player.postGamePromotion = false;
    if(!isDefined(player.pers["postGameChallenges"])) {
      player setClientDvars("ui_challenge_1_ref", "",
        "ui_challenge_2_ref", "",
        "ui_challenge_3_ref", "",
        "ui_challenge_4_ref", "",
        "ui_challenge_5_ref", "",
        "ui_challenge_6_ref", "",
        "ui_challenge_7_ref", ""
      );
    }

    player setClientDvar("ui_promotion", 0);

    if(!isDefined(player.pers["summary"])) {
      player.pers["summary"] = [];
      player.pers["summary"]["xp"] = 0;
      player.pers["summary"]["score"] = 0;
      player.pers["summary"]["operation"] = 0;
      player.pers["summary"]["challenge"] = 0;
      player.pers["summary"]["match"] = 0;
      player.pers["summary"]["misc"] = 0;
      player.pers["summary"]["entitlementXP"] = 0;
      player.pers["summary"]["clanWarsXP"] = 0;
    }

    player setClientDvar("ui_opensummary", 0);

    player thread maps\mp\gametypes\_missions::updateChallenges();
    player.explosiveKills[0] = 0;
    player.xpGains = [];

    player thread onPlayerSpawned();
    player thread onPlayerGiveLoadout();

    if(player rankingEnabled()) {
      if(IsSquadsMode()) {
        if(player GetRankedPlayerData("prestigeDoubleXp")) {
          player.prestigeDoubleXp = true;
        } else {
          player.prestigeDoubleXp = false;
        }
      }

      if(player GetRankedPlayerData("prestigeDoubleWeaponXp")) {
        player.prestigeDoubleWeaponXp = true;
      } else {
        player.prestigeDoubleWeaponXp = false;
      }
    }
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    if(IsAI(self)) {
      self.pers["rankxp"] = self get_rank_xp_for_bot();
    } else if(!level.rankedMatch) {
      self.pers["rankxp"] = 0;
    } else {
      AssertEx(isDefined(self.class), "Player should have class here.");
      AssertEx(isDefined(self.class_num), "Player should have class_num here.");

    }

    self playerUpdateRank();
  }
}

playerUpdateRank() {
  if(self.pers["rankxp"] < 0) {
    self.pers["rankxp"] = 0;
  }

  rankId = self getRankForXp(self getRankXP());
  self.pers["rank"] = rankId;

  if(IsAI(self) || !isDefined(self.pers["prestige"])) {
    if(level.rankedMatch && isDefined(self.bufferedStats)) {
      prestige = self getPrestigeLevel();
    } else {
      prestige = 0;
    }

    self setRank(rankId, prestige);
    self.pers["prestige"] = prestige;
  }

  if(isDefined(self.clientid) && (self.clientid < level.MaxLogClients)) {
    setMatchData("players", self.clientid, "rank", rankId);
    setMatchData("players", self.clientid, "Prestige", self.pers["prestige"]);
  }
}

onPlayerGiveLoadout() {
  self endon("disconnect");

  while(true) {
    self waittill_any("giveLoadout", "changed_kit");

    AssertEx(isDefined(self.class), "Player should have class here.");
    if(IsSubStr(self.class, "custom")) {
      if(!level.rankedMatch) {
        self.pers["rankxp"] = 0;
      } else {
        if(IsAI(self)) {
          self.pers["rankxp"] = 0;
        } else {
          AssertEx(isDefined(self.class_num), "Player should have class_num here.");

        }
      }
    }
  }
}

roundUp(floatVal) {
  if(int(floatVal) != floatVal) {
    return int(floatVal + 1);
  } else {
    return int(floatVal);
  }
}

giveRankXP(type, value, weapon, sMeansOfDeath, challengeName, victim) {
  if(is_aliens()) {
    return;
  } else {
    giveRankXP_regularMP(type, value, weapon, sMeansOfDeath, challengeName, victim);
  }
}

giveRankXP_regularMP(type, value, weapon, sMeansOfDeath, challengeName, victim) {
  prof_begin("giveRankXP");
  self endon("disconnect");

  lootType = "none";

  if(isDefined(self.owner) && !IsBot(self)) {
    self.owner giveRankXP(type, value, weapon, sMeansOfDeath, challengeName, victim);
    return;
  }

  if(!IsBot(self)) {
    if(isDefined(self.commanding_bot)) {
      self.commanding_bot giveRankXP(type, value, weapon, sMeansOfDeath, challengeName, victim);
    }
  }

  if(isAI(self)) {
    return;
  }
  if(!IsPlayer(self)) {
    return;
  }
  if(!self rankingEnabled()) {
    if(type == "assist") {
      if(isDefined(self.taggedAssist)) {
        self.taggedAssist = undefined;
      } else {
        event = "assist";
        if(level.gameType == "cranked") {
          if(isDefined(self.cranked)) {
            event = "assist_cranked";
          }
        }
        if(self _hasPerk("specialty_assists")) {
          if(!(self.pers["assistsToKill"] % 2)) {
            event = "assist_to_kill";
          }
        }
        self thread maps\mp\gametypes\_rank::xpEventPopup(event);
      }
    }

    return;
  }

  if(!isDefined(level.forceRanking) || !level.forceRanking) {
    if(level.teamBased && (!level.teamCount["allies"] || !level.teamCount["axis"])) {
      return;
    } else if(!level.teamBased && (level.teamCount["allies"] + level.teamCount["axis"] < 2)) {
      return;
    }
  }

  if(!isDefined(value)) {
    value = getScoreInfoValue(type);
  }

  if(!isDefined(self.xpGains[type])) {
    self.xpGains[type] = 0;
  }

  modifiedValue = value;

  entitlement_xp = 0;
  clan_wars_bonus_xp = 0;

  prof_begin("rankXP sort");
  if(isDefined(victim) && getTimePassed() > (60 * 1000) * 1.5) {
    attacker = self;

    if(level.teamBased) {
      enemies_sorted_by_rank = array_sort_with_func(level.teamList[getOtherTeam(attacker.team)], ::is_score_a_greater_than_b);
      friendlies_sorted_by_rank = array_sort_with_func(level.teamList[attacker.team], ::is_score_a_greater_than_b);
      if(isDefined(enemies_sorted_by_rank[0]) && victim == enemies_sorted_by_rank[0]) {
        if(isDefined(friendlies_sorted_by_rank[1]) && attacker.score < friendlies_sorted_by_rank[1].score) {
          modifiedValue *= 2.0;
          attacker thread xpEventPopup("first_place_kill");
        }
      } else if(isDefined(enemies_sorted_by_rank[1]) && victim == enemies_sorted_by_rank[1]) {
        if(isDefined(friendlies_sorted_by_rank[2]) && attacker.score < friendlies_sorted_by_rank[2].score) {
          modifiedValue *= 1.5;
          attacker thread xpEventPopup("second_place_kill");
        }
      }
    } else {
      enemies_sorted_by_rank = array_sort_with_func(level.players, ::is_score_a_greater_than_b);
      if(isDefined(enemies_sorted_by_rank[0]) && victim == enemies_sorted_by_rank[0]) {
        if(isDefined(enemies_sorted_by_rank[1]) && attacker.score < enemies_sorted_by_rank[1].score) {
          modifiedValue *= 2.0;
          attacker thread xpEventPopup("first_place_kill");
        }
      } else if(isDefined(enemies_sorted_by_rank[1]) && victim == enemies_sorted_by_rank[1]) {
        if(isDefined(enemies_sorted_by_rank[2]) && attacker.score < enemies_sorted_by_rank[2].score) {
          modifiedValue *= 1.5;
          attacker thread xpEventPopup("second_place_kill");
        }
      } else if(isDefined(enemies_sorted_by_rank[2]) && victim == enemies_sorted_by_rank[2]) {
        if(isDefined(enemies_sorted_by_rank[2]) && attacker.score < enemies_sorted_by_rank[2].score) {
          modifiedValue *= 1.5;
          attacker thread xpEventPopup("third_place_kill");
        }
      }
    }

    cur_kill_streak = attacker.killsThisLife.size + 1;
    if(cur_kill_streak > 2) {
      if(!(cur_kill_streak % 5)) {
        if(!isDefined(attacker.lastKillSplash) || cur_kill_streak != attacker.lastKillSplash) {
          attacker thread teamPlayerCardSplash("callout_kill_streaking", attacker, undefined, cur_kill_streak);
          attacker.lastKillSplash = cur_kill_streak;
        }
      }
    }
  }
  prof_end("rankXP sort");

  momentumBonus = 0;
  gotRestXP = false;

  switch (type) {
    case "kill":
    case "headshot":
    case "shield_damage":
      modifiedValue *= self.xpScaler;
    case "assist":
    case "suicide":
    case "teamkill":
    case "capture":
    case "defend":
    case "obj_return":
    case "pickup":
    case "assault":
    case "plant":
    case "destroy":
    case "save":
    case "defuse":
    case "kill_confirmed":
    case "kill_denied":
    case "tags_retrieved":
    case "team_assist":
    case "kill_bonus":
    case "kill_carrier":
    case "draft_rogue":
    case "survivor":
    case "final_rogue":
    case "gained_gun_rank":
    case "dropped_enemy_gun_rank":
    case "got_juggernaut":
    case "kill_as_juggernaut":
    case "kill_juggernaut":
    case "jugg_on_jugg":
    case "damage_body":
    case "damage_head":
    case "kill_normal":
    case "kill_melee":
    case "kill_head":
      if(getGametypeNumLives() > 0 && type != "shield_damage") {
        if(!isDefined(level.skipLivesXPScalar) || !level.skipLivesXPScalar) {
          if(level.gameType == "sd") {
            multiplier = max(1, int(10 / getGametypeNumLives()));
          } else {
            multiplier = max(1, int(5 / getGametypeNumLives()));
          }
          modifiedValue = int(modifiedValue * multiplier);
        }
      }

      prestigeBonus_xp = 0;

      if(IsSquadsMode()) {
        if(self.prestigeDoubleXp) {
          howMuchTimePlayed = self GetRankedPlayerData("prestigeDoubleXpTimePlayed");
          if(howMuchTimePlayed >= self.bufferedStatsMax["prestigeDoubleXpMaxTimePlayed"]) {
            self setRankedPlayerData("prestigeDoubleXp", false);
            self setRankedPlayerData("prestigeDoubleXpTimePlayed", 0);
            self setRankedPlayerData("prestigeDoubleXpMaxTimePlayed", 0);
            self.prestigeDoubleXp = false;
          } else {
            prestigeBonus_xp = 1.1;
          }
        }
      }
      entitlement_xp = self getXPMultiplier();

      clan_wars_bonus_xp = self GetClanWarsBonus();

      if(prestigeBonus_xp > 0) {
        modifiedValue = int(modifiedValue * prestigeBonus_xp);
      }

      teamXPScale = 1;
      if(level.teamBased) {
        teamXPScale = level.teamXPScale[self.team];
      } else {
        if(isDefined(level.teamXPScale[self GetEntityNumber()])) {
          teamXPScale = level.teamXPScale[self GetEntityNumber()];
        }
      }

      modifiedValue = int(modifiedValue * level.xpScale * teamXPScale);

      if(isDefined(level.nukeDetonated) && level.nukeDetonated) {
        if(level.teamBased && level.nukeInfo.team == self.team) {
          modifiedValue *= level.nukeInfo.xpScalar;
        } else if(!level.teamBased && level.nukeInfo.player == self) {
          modifiedValue *= level.nukeInfo.xpScalar;
        }

        modifiedValue = int(modifiedValue);
      }

      AssertEx((modifiedValue < 100000), "Tried to award " + self.name + "over 100000 XP: " + modifiedValue);

      restXPAwarded = getRestXPAward(modifiedValue);
      modifiedValue += restXPAwarded;
      if(restXPAwarded > 0) {
        if(isLastRestXPAward(modifiedValue)) {
          thread maps\mp\gametypes\_hud_message::splashNotify("rested_done");
        }

        gotRestXP = true;
      }
      break;
    case "challenge":
      clan_wars_bonus_xp = self GetClanWarsBonus();

      entitlement_xp = self getXPMultiplier();
      break;

    case "operation":
      entitlement_xp = 0;
      if(self GetRankedPlayerData("challengeXPMultiplierTimePlayed", 0) < self.bufferedChildStatsMax["challengeXPMaxMultiplierTimePlayed"][0]) {
        entitlement_xp += int(self GetRankedPlayerData("challengeXPMultiplier", 0));
      }

      break;
    default:
      clan_wars_bonus_xp = self GetClanWarsBonus();
      entitlement_xp = self getXPMultiplier();
      break;
  }

  if(level.maxForBotMatch && (self.pers["xpEarnedThisMatch"] > level.maxForBotMatch)) {
    if(!isDefined(level.skipPointDisplayXP)) {
      self thread xpPointsPopup(modifiedValue, momentumBonus);
    }

    modifiedValue = 0;

    if(self.pers["xpEarnedThisMatch"] != 999790) {
      self thread maps\mp\gametypes\_hud_message::splashNotifyDelayed("max_xp_for_match");

      self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("airdrop_assault", false, false, self);
      self thread[[level.leaderDialogOnPlayer_func]]("achieve_carepackage", undefined, undefined, self.origin);
      self.pers["xpEarnedThisMatch"] = 999790;
    }
  }

  entitlementBonus = int(max(modifiedValue * entitlement_xp - modifiedValue, 0));
  clanWarsBonus = int(modifiedValue * clan_wars_bonus_xp);

  oldxp = self getRankXP();

  self incRankXP(modifiedValue + entitlementBonus + clanWarsBonus);

  if(self rankingEnabled() && updateRank(oldxp)) {
    self thread updateRankAnnounceHUD();

    curRank = self getRank();

    if(curRank < 5) {
      self giveUnlockPoints(5, false);
    } else {
      self giveUnlockPoints(2, false);
    }
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

  if(!level.hardcoreMode) {
    if(!isDefined(level.skipPointDisplayXP)) {
      self thread xpPointsPopup(modifiedValue, momentumBonus);
    }

    if(type == "assist") {
      if(isDefined(self.taggedAssist)) {
        self.taggedAssist = undefined;
      } else {
        event = "assist";
        if(level.gameType == "cranked") {
          if(isDefined(self.cranked)) {
            event = "assist_cranked";
          }
        }
        if(self _hasPerk("specialty_assists")) {
          if(!(self.pers["assistsToKill"] % 2)) {
            event = "assist_to_kill";
          }
        }
        self thread maps\mp\gametypes\_rank::xpEventPopup(event);
      }
    }
  }

  switch (type) {
    case "kill":
    case "headshot":
    case "suicide":
    case "teamkill":
    case "assist":
    case "capture":
    case "defend":
    case "obj_return":
    case "pickup":
    case "assault":
    case "plant":
    case "defuse":
    case "kill_confirmed":
    case "kill_denied":
    case "tags_retrieved":
    case "team_assist":
    case "kill_bonus":
    case "kill_carrier":
    case "draft_rogue":
    case "survivor":
    case "final_rogue":
    case "gained_gun_rank":
    case "dropped_enemy_gun_rank":
    case "got_juggernaut":
    case "kill_as_juggernaut":
    case "kill_juggernaut":
    case "jugg_on_jugg":
    case "damage_body":
    case "damage_head":
    case "kill_normal":
    case "kill_melee":
    case "kill_head":

      PrintLn("Base XP Awarded: " + modifiedValue);
      PrintLn("Entitlement XP Awarded: " + entitlementBonus);
      PrintLn("Clan Wars XP Awarded: " + clanWarsBonus);

      self.pers["summary"]["score"] += modifiedValue;
      self.pers["summary"]["entitlementXP"] += entitlementBonus;
      self.pers["summary"]["clanWarsXP"] += clanWarsBonus;
      self.pers["summary"]["xp"] += (modifiedValue + entitlementBonus + clanWarsBonus);
      break;

    case "win":
    case "loss":
    case "tie":
      self.pers["summary"]["match"] += modifiedValue;
      self.pers["summary"]["xp"] += modifiedValue;
      break;

    case "challenge":

      PrintLn("Challenge XP Awarded: " + modifiedValue);
      PrintLn("Entitlement XP Awarded: " + entitlementBonus);
      PrintLn("Clan Wars XP Awarded: " + clanWarsBonus);

      self.pers["summary"]["challenge"] += modifiedValue;
      self.pers["summary"]["entitlementXP"] += entitlementBonus;
      self.pers["summary"]["clanWarsXP"] += clanWarsBonus;
      self.pers["summary"]["xp"] += (modifiedValue + entitlementBonus + clanWarsBonus);
      break;

    case "operation":
      self.pers["summary"]["entitlementXP"] += entitlementBonus;
      self.pers["summary"]["operation"] += modifiedValue;
      self.pers["summary"]["xp"] += (modifiedValue + entitlementBonus);
      break;

    default:

      PrintLn("Misc XP Awarded: " + modifiedValue);
      PrintLn("Entitlement XP Awarded: " + entitlementBonus);
      PrintLn("Clan Wars XP Awarded: " + clanWarsBonus);

      self.pers["summary"]["misc"] += modifiedValue;
      self.pers["summary"]["entitlementXP"] += entitlementBonus;
      self.pers["summary"]["clanWarsXP"] += clanWarsBonus;
      self.pers["summary"]["xp"] += (modifiedValue + entitlementBonus + clanWarsBonus);
      break;
  }

  prof_end("giveRankXP");
}

is_score_a_greater_than_b(a, b) {
  return (a.score > b.score);
}

getXPMultiplier() {
  multiplier = 0;
  for(i = 0; i < 3; i++) {
    xpMultiplierTimePlayed = self GetRankedPlayerData("xpMultiplierTimePlayed", i);
    xpMaxMultiplierTimePlayed = self.bufferedChildStatsMax["xpMaxMultiplierTimePlayed"][i];
    if(xpMultiplierTimePlayed < xpMaxMultiplierTimePlayed) {
      multiplier += int(self GetRankedPlayerData("xpMultiplier", i));
    }
  }
  return multiplier;
}

weaponShouldGetXP(weapon, meansOfDeath) {
  if(self IsItemUnlocked("cac") &&
    !self isJuggernaut() &&
    isDefined(weapon) &&
    isDefined(meansOfDeath) &&
    !isKillstreakWeapon(weapon)) {
    if(isBulletDamage(meansOfDeath)) {
      return true;
    }
    if(IsExplosiveDamageMOD(meansOfDeath) || meansOfDeath == "MOD_IMPACT") {
      if(getWeaponClass(weapon) == "weapon_projectile" || getWeaponClass(weapon) == "weapon_assault") {
        return true;
      }
    }
    if(meansOfDeath == "MOD_MELEE") {
      if(getWeaponClass(weapon) == "weapon_riot") {
        return true;
      }
    }
  }

  return false;
}

characterTypeBonusXP(weapon, xp) {
  percent = 1.2;

  if(isDefined(weapon) && isDefined(self.character_type)) {
    switch (getWeaponClass(weapon)) {
      case "weapon_smg":
        if(self.character_type == "charactertype_smg") {
          xp *= percent;
        }
        break;
      case "weapon_assault":
        if(self.character_type == "charactertype_assault") {
          xp *= percent;
        }
        break;
      case "weapon_shotgun":
        if(self.character_type == "charactertype_shotgun") {
          xp *= percent;
        }
        break;
      case "weapon_dmr":
        if(self.character_type == "charactertype_dmr") {
          xp *= percent;
        }
        break;
      case "weapon_sniper":
        if(self.character_type == "charactertype_sniper") {
          xp *= percent;
        }
        break;
      case "weapon_lmg":
        if(self.character_type == "charactertype_lmg") {
          xp *= percent;
        }
        break;
      default:
        break;
    };
  }

  return int(xp);
}

updateRank(oldxp) {
  newRankId = self getRank();
  if(newRankId == self.pers["rank"] || self.pers["rank"] == level.maxRank) {
    return false;
  }

  oldRank = self.pers["rank"];
  self.pers["rank"] = newRankId;

  PrintLn("promoted " + self.name + " from rank " + oldRank + " to " + newRankId + ". Experience went from " + oldxp + " to " + self getRankXP() + ".");

  self SetRank(newRankId);

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

  self thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("ranked_up", self.pers["rank"]);

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

endGameUpdate() {
  player = self;
}

xpPointsPopup(amount, bonus) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(amount == 0) {
    return;
  }
  if(!isDefined(bonus)) {
    bonus = 0;
  }

  self notify("xpPointsPopup");
  self endon("xpPointsPopup");

  self.xpUpdateTotal += amount;
  self.bonusUpdateTotal += bonus;

  self SetClientOmnvar("ui_points_popup", self.xpUpdateTotal);

  increment = max(int(self.bonusUpdateTotal / 20), 1);

  if(self.bonusUpdateTotal) {
    while(self.bonusUpdateTotal > 0) {
      self.xpUpdateTotal += min(self.bonusUpdateTotal, increment);
      self.bonusUpdateTotal -= min(self.bonusUpdateTotal, increment);

      wait(0.05);
    }
  } else {
    wait(1.0);
  }

  self.xpUpdateTotal = 0;
}

xpEventPopupFinalize(event) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  self notify("xpEventPopup");
  self endon("xpEventPopup");

  if(level.hardcoreMode) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  eventId = TableLookupRowNum(XP_EVENT_TABLE, 0, event);
  if(!isDefined(eventId) || (isDefined(eventId) && eventId == -1)) {
    AssertMsg(event + " must be added to the xp_event_table.csv! Do it now!");
    return;
  }
  self SetClientOmnvar("ui_points_popup_desc", eventId);

  wait(1.0);

  if(!isDefined(self)) {
    return;
  }
  self notify("PopComplete");
}

xpEventPopup(event) {
  if(is_aliens()) {
    return;
  } else {
    xpEventPopup_regularMP(event);
  }
}

xpEventPopup_regularMP(event) {
  if(isDefined(self.owner)) {
    self.owner xpEventPopup(event);
  }

  if(!IsPlayer(self)) {
    return;
  }
  self thread xpEventPopupFinalize(event);
}

getRank() {
  rankXp = self.pers["rankxp"];
  rankId = self.pers["rank"];

  if(rankXp < (getRankInfoMinXP(rankId) + getRankInfoXPAmt(rankId))) {
    return rankId;
  } else {
    return self getRankForXp(rankXp);
  }
}

getWeaponRank(weapon) {
  rankXp = self GetRankedPlayerData("weaponXP", weapon);
  return self getWeaponRankForXp(rankXp, weapon);
}

levelForExperience(experience) {
  return getRankForXP(experience);
}

weaponLevelForExperience(experience) {
  return getWeaponRankForXP(experience);
}

getCurrentWeaponXP() {
  weapon = self GetCurrentWeapon();
  if(isDefined(weapon)) {
    return self GetRankedPlayerData("weaponXP", weapon);
  }

  return 0;
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

getWeaponRankForXp(xpVal, weapon) {
  if(!isDefined(xpVal)) {
    xpVal = 0;
  }

  weaponClass = tablelookup(STATS_TABLE, 4, weapon, 2);
  weaponMaxRank = int(tableLookup(WEAPON_RANK_TABLE, 0, weaponClass, 1));
  for(rankId = 0; rankId < weaponMaxRank + 1; rankId++) {
    if(xpVal < getWeaponRankInfoMinXP(rankId) + getWeaponRankInfoXPAmt(rankId)) {
      return rankId;
    }
  }

  return (rankId - 1);
}

getSPM() {
  rankLevel = self getRank() + 1;
  return (3 + (rankLevel * 0.5)) * 10;
}

getPrestigeLevel() {
  if(IsAI(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  } else {
    return self maps\mp\gametypes\_persistence::statGet("prestige");
  }
}

getRankXP() {
  return self.pers["rankxp"];
}

getWeaponRankXP(weapon) {
  return self GetRankedPlayerData("weaponXP", weapon);
}

getWeaponMaxRankXP(weapon) {
  weaponClass = tablelookup(STATS_TABLE, 4, weapon, 2);
  weaponMaxRank = int(tableLookup(WEAPON_RANK_TABLE, 0, weaponClass, 1));
  weaponMaxRankXP = getWeaponRankInfoMaxXp(weaponMaxRank);

  return weaponMaxRankXP;
}

isWeaponMaxRank(weapon) {
  weaponRankXP = self GetRankedPlayerData("weaponXP", weapon);
  weaponMaxRankXP = getWeaponMaxRankXP(weapon);

  return (weaponRankXP >= weaponMaxRankXP);
}

giveUnlockPoints(numPoints, showSplash) {
  if(!isDefined(showSplash)) {
    dontShowSplash = true;
  }

  squadMember = self.pers["activeSquadMember"];
  numCommendationsEarned = self GetRankedPlayerData("squadMembers", squadMember, "commendationsEarned");
  numCommendationsEarned += numPoints;
  self SetRankedPlayerData("squadMembers", squadMember, "commendationsEarned", numCommendationsEarned);

  if(showSplash) {
    self thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("earned_unlock", self);
  }

  unlockPoints = self GetRankedPlayerData("unlockPoints");
  newUnlockPoints = unlockPoints + numPoints;
  self setRankedPlayerData("unlockPoints", newUnlockPoints);
}

incRankXP(amount) {
  if(!self rankingEnabled()) {
    return;
  }
  if(isAI(self)) {
    return;
  }
  points = self GetRankedPlayerData("points");
  updatedPoints = points + amount;

  updatedPoints = Int(Clamp(updatedPoints, 0, EARNED_SQUAD_POINT_XP * 2 - 1));

  if(updatedPoints >= EARNED_SQUAD_POINT_XP) {
    updatedPoints = updatedPoints % EARNED_SQUAD_POINT_XP;

    self setRankedPlayerData("points", updatedPoints);

    self giveUnlockPoints(1, true);
  } else {
    self setRankedPlayerData("points", updatedPoints);
  }

  xp = self getRankXP();
  newXp = (int(min(xp, getRankInfoMaxXP(level.maxRank))) + amount);

  if(self.pers["rank"] == level.maxRank && newXp >= getRankInfoMaxXP(level.maxRank)) {
    newXp = getRankInfoMaxXP(level.maxRank);
  }
  self.pers["xpEarnedThisMatch"] += amount;
  self.pers["rankxp"] = newXp;
}

getRestXPAward(baseXP) {
  if(!getdvarint("scr_restxp_enable")) {
    return 0;
  }

  restXPAwardRate = getDvarFloat("scr_restxp_restedAwardScale");

  wantGiveRestXP = int(baseXP * restXPAwardRate);
  mayGiveRestXP = self GetRankedPlayerData("restXPGoal") - self getRankXP();

  if(mayGiveRestXP <= 0) {
    return 0;
  }

  return wantGiveRestXP;
}

isLastRestXPAward(baseXP) {
  if(!getdvarint("scr_restxp_enable")) {
    return false;
  }

  restXPAwardRate = getDvarFloat("scr_restxp_restedAwardScale");

  wantGiveRestXP = int(baseXP * restXPAwardRate);
  mayGiveRestXP = self GetRankedPlayerData("restXPGoal") - self getRankXP();

  if(mayGiveRestXP <= 0) {
    return false;
  }

  if(wantGiveRestXP >= mayGiveRestXP) {
    return true;
  }

  return false;
}

syncXPStat() {
  if(level.xpScale > 4 || level.xpScale <= 0) {
    exitLevel(false);
  }

  xp = self getRankXP();
  squadMember = self.pers["activeSquadMember"];

  oldXp = self GetRankedPlayerData("squadMembers", squadMember, "squadMemXP");
  assert(xp >= oldXp, "Attempted XP regression in syncXPStat - " + oldXp + " -> " + xp + " for player " + self.name);

  self SetRankedPlayerData("squadMembers", squadMember, "squadMemXP", xp);

  self SetRankedPlayerData("experience", xp);

  if(xp >= getRankInfoMaxXP(level.maxRank)) {
    date = self GetRankedPlayerData("characterXP", squadMember);

    if(date == 0) {
      completionDate = getSystemTime();

      self SetRankedPlayerData("characterXP", squadMember, completionDate);

      oldPrestige = self getRankedPlayerDataReservedInt("prestigeLevel");
      newPrestige = oldPrestige + 1;
      self setRankedPlayerDataReservedInt("prestigeLevel", newPrestige);
      self SetRank(level.maxRank, newPrestige);

      self thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("prestige" + newPrestige);

      team = self.pers["team"];
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam) && player != self) {
          if(playerteam == team) {
            player IPrintLn(&"RANK_PLAYER_WAS_PROMOTED", self, &"MPUI_PRESTIGE");
          }
        }
      }
    }
  }
}

createMultiplierText() {
  hud_multiplierText = newClientHudElem(self);
  hud_multiplierText.horzAlign = "center";
  hud_multiplierText.vertAlign = "bottom";
  hud_multiplierText.alignX = "center";
  hud_multiplierText.alignY = "middle";
  hud_multiplierText.x = 70;
  if(level.splitScreen) {
    hud_multiplierText.y = -55;
  } else {
    hud_multiplierText.y = -10;
  }
  hud_multiplierText.font = "default";
  hud_multiplierText.fontscale = 1.3;
  hud_multiplierText.archived = false;
  hud_multiplierText.color = (1.0, 1.0, 1.0);
  hud_multiplierText.sort = 10000;
  hud_multiplierText maps\mp\gametypes\_hud::fontPulseInit(1.5);
  return hud_multiplierText;
}

multiplierTextPopup(string) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("round_end_finished");
  self endon("death");

  self notify("multiplierTextPopup");
  self endon("multiplierTextPopup");

  if(!isDefined(self.hud_multiplierText)) {
    self.hud_multiplierText = self createMultiplierText();
  }

  wait(0.05);

  self thread multiplierTextPopup_watchDeath();
  self thread multiplierTextPopup_watchGameEnd();

  self.hud_multiplierText SetText(string);
  while(true) {
    self.hud_multiplierText.alpha = 0.85;
    self.hud_multiplierText thread maps\mp\gametypes\_hud::fontPulse(self);
    wait(1.0);

    self.hud_multiplierText fadeOverTime(0.75);
    self.hud_multiplierText.alpha = 0.25;
    wait(1.0);
  }
}

multiplierTextPopup_watchDeath() {
  self waittill("death");
  if(isDefined(self.hud_multiplierText)) {
    self.hud_multiplierText.alpha = 0;
  }
}

multiplierTextPopup_watchGameEnd() {
  level waittill("game_ended");
  if(isDefined(self.hud_multiplierText)) {
    self.hud_multiplierText.alpha = 0;
  }
}

watchDevDvars() {
  level endon("game_ended");

  while(true) {
    if(GetDvarInt("scr_devsetweaponmaxrank") > 0) {
      foreach(player in level.players) {
        if(isDefined(player.pers["isBot"]) && player.pers["isBot"]) {
          continue;
        }
        weapon = player GetCurrentWeapon();

        weaponTokens = StrTok(weapon, "_");

        if(weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6") {
          weaponName = weaponTokens[0] + "_" + weaponTokens[1];
        } else if(weaponTokens[0] == "alt") {
          weaponName = weaponTokens[1] + "_" + weaponTokens[2];
        } else {
          weaponName = weaponTokens[0];
        }

        if(weaponTokens[0] == "gl") {
          weaponName = weaponTokens[1];
        }

      }
      SetDevDvar("scr_devsetweaponmaxrank", 0);
    }

    wait(0.05);
  }
}
# /