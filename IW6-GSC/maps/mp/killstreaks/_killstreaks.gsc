/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_killstreaks.gsc
************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

MIN_NUM_KILLS_GIVE_BONUS_PERKS = 8;
NUM_ABILITY_CATEGORIES = 7;
NUM_SUB_ABILITIES = 5;

KILLSTREAK_GIMME_SLOT = 0;
KILLSTREAK_SLOT_1 = 1;
KILLSTREAK_SLOT_2 = 2;
KILLSTREAK_SLOT_3 = 3;
KILLSTREAK_BONUS_PERKS_SLOT = 4;
KILLSTREAK_STACKING_START_SLOT = 5;

initKillstreakData() {
  for(i = 1; true; i++) {
    retVal = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].ref_col);
    if(!isDefined(retVal) || retVal == "") {
      break;
    }

    streakRef = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].ref_col);
    assert(streakRef != "");

    streakUseHint = TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].earned_hint_col);
    assert(streakUseHint != &"");

    streakEarnDialog = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].earned_dialog_col);
    assert(streakEarnDialog != "");
    game["dialog"][streakRef] = streakEarnDialog;

    streakAlliesUseDialog = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].allies_dialog_col);
    assert(streakAlliesUseDialog != "");
    game["dialog"]["allies_friendly_" + streakRef + "_inbound"] = "friendly_" + streakAlliesUseDialog;
    game["dialog"]["allies_enemy_" + streakRef + "_inbound"] = "enemy_" + streakAlliesUseDialog;

    streakAxisUseDialog = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].enemy_dialog_col);
    assert(streakAxisUseDialog != "");
    game["dialog"]["axis_friendly_" + streakRef + "_inbound"] = "friendly_" + streakAxisUseDialog;
    game["dialog"]["axis_enemy_" + streakRef + "_inbound"] = "enemy_" + streakAxisUseDialog;

    streakPoints = int(TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].index_col, i, level.global_tables["killstreakTable"].score_col));
    assert(streakPoints != 0);
    maps\mp\gametypes\_rank::registerScoreInfo("killstreak_" + streakRef, streakPoints);
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["killstreaks"])) {
      player.pers["killstreaks"] = [];
    }

    if(!isDefined(player.pers["kID"])) {
      player.pers["kID"] = 10;
    }

    player.lifeId = 0;
    player.curDefValue = 0;

    if(isDefined(player.pers["deaths"])) {
      player.lifeId = player.pers["deaths"];
    }

    player VisionSetMissilecamForPlayer(game["thermal_vision"]);

    player thread onPlayerSpawned();
    player thread monitorDisownKillstreaks();

    player.spUpdateTotal = 0;
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  if(is_aliens()) {
    return;
  }
  for(;;) {
    self waittill("spawned_player");

    self thread killstreakUseWaiter();
    self thread waitForChangeTeam();

    self thread streakSelectUpTracker();
    self thread streakSelectDownTracker();

    if(level.console) {
      self thread streakUseTimeTracker();
    } else {
      self thread pc_watchStreakUse();

      self thread pc_watchGamepad();
    }
    self thread streakNotifyTracker();

    if(!isDefined(self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT])) {
      self initPlayerKillstreaks();
    }
    if(!isDefined(self.earnedStreakLevel)) {
      self.earnedStreakLevel = 0;
    }

    if(game["roundsPlayed"] > 0 && self.adrenaline == 0) {
      self.adrenaline = self GetCommonPlayerData("killstreaksState", "count");
    }

    {
      self setStreakCountToNext();
      self updateStreakSlots();
    }

    if(self.streakType == "specialist") {
      self updateSpecialistKillstreaks();
    } else {
      self giveOwnedKillstreakItem();
    }
  }
}

initPlayerKillstreaks() {
  if(!isDefined(self.streakType)) {
    return;
  }
  if(self.streakType == "specialist") {
    self setCommonPlayerData("killstreaksState", "isSpecialist", true);
  } else {
    self setCommonPlayerData("killstreaksState", "isSpecialist", false);
  }

  self_pers_killstreaks_gimme_slot = spawnStruct();
  self_pers_killstreaks_gimme_slot.available = false;
  self_pers_killstreaks_gimme_slot.streakName = undefined;
  self_pers_killstreaks_gimme_slot.earned = false;
  self_pers_killstreaks_gimme_slot.awardxp = undefined;
  self_pers_killstreaks_gimme_slot.owner = undefined;
  self_pers_killstreaks_gimme_slot.kID = undefined;
  self_pers_killstreaks_gimme_slot.lifeId = undefined;
  self_pers_killstreaks_gimme_slot.isGimme = true;
  self_pers_killstreaks_gimme_slot.isSpecialist = false;
  self_pers_killstreaks_gimme_slot.nextSlot = undefined;
  self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT] = self_pers_killstreaks_gimme_slot;

  for(i = 1; i < KILLSTREAK_BONUS_PERKS_SLOT; i++) {
    self_pers_killstreaks_i = spawnStruct();

    self_pers_killstreaks_i.available = false;
    self_pers_killstreaks_i.streakName = undefined;
    self_pers_killstreaks_i.earned = true;
    self_pers_killstreaks_i.awardxp = 1;
    self_pers_killstreaks_i.owner = undefined;
    self_pers_killstreaks_i.kID = undefined;
    self_pers_killstreaks_i.lifeId = -1;
    self_pers_killstreaks_i.isGimme = false;
    self_pers_killstreaks_i.isSpecialist = false;
    self.pers["killstreaks"][i] = self_pers_killstreaks_i;
  }

  self_pers_killstreaks_bonus_perks_slot = spawnStruct();

  self_pers_killstreaks_bonus_perks_slot.available = false;
  self_pers_killstreaks_bonus_perks_slot.streakName = "all_perks_bonus";
  self_pers_killstreaks_bonus_perks_slot.earned = true;
  self_pers_killstreaks_bonus_perks_slot.awardxp = 0;
  self_pers_killstreaks_bonus_perks_slot.owner = undefined;
  self_pers_killstreaks_bonus_perks_slot.kID = undefined;
  self_pers_killstreaks_bonus_perks_slot.lifeId = -1;
  self_pers_killstreaks_bonus_perks_slot.isGimme = false;
  self_pers_killstreaks_bonus_perks_slot.isSpecialist = true;
  self.pers["killstreaks"][KILLSTREAK_BONUS_PERKS_SLOT] = self_pers_killstreaks_bonus_perks_slot;

  for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
    self setCommonPlayerData("killstreaksState", "icons", i, 0);
    self setCommonPlayerData("killstreaksState", "hasStreak", i, false);
  }
  self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_GIMME_SLOT, false);

  index = 1;
  foreach(streakName in self.killstreaks) {
    self_pers_killstreaks_index = self.pers["killstreaks"][index];
    self_pers_killstreaks_index.streakName = streakName;
    self_pers_killstreaks_index.isSpecialist = (self.streakType == "specialist");

    killstreakIndexName = self_pers_killstreaks_index.streakName;

    if(self.streakType == "specialist") {
      perkTokens = StrTok(self_pers_killstreaks_index.streakName, "_");
      if(perkTokens[perkTokens.size - 1] == "ks") {
        perkName = undefined;
        foreach(token in perkTokens) {
          if(token != "ks") {
            if(!isDefined(perkName)) {
              perkName = token;
            } else {
              perkName += ("_" + token);
            }
          }
        }

        if(isStrStart(self_pers_killstreaks_index.streakName, "_")) {
          perkName = "_" + perkName;
        }

        if(isDefined(perkName) && self maps\mp\gametypes\_class::getPerkUpgrade(perkName) != "specialty_null") {
          killstreakIndexName = self_pers_killstreaks_index.streakName + "_pro";
        }
      }
    }

    self setCommonPlayerData("killstreaksState", "icons", index, getKillstreakIndex(killstreakIndexName));
    self setCommonPlayerData("killstreaksState", "hasStreak", index, false);

    index++;
  }

  self setCommonPlayerData("killstreaksState", "nextIndex", 1);
  self setCommonPlayerData("killstreaksState", "selectedIndex", -1);
  self setCommonPlayerData("killstreaksState", "numAvailable", 0);

  self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT, false);
}

updateStreakCount() {
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  if(self.adrenaline == self.previousAdrenaline) {
    return;
  }
  curCount = self.adrenaline;

  self setCommonPlayerData("killstreaksState", "count", self.adrenaline);

  if(self.adrenaline >= self getCommonPlayerData("killstreaksState", "countToNext")) {
    self setStreakCountToNext();
  }
}

resetStreakCount() {
  self setCommonPlayerData("killstreaksState", "count", 0);
  self setStreakCountToNext();
}

setStreakCountToNext() {
  if(!isDefined(self.streakType)) {
    self setCommonPlayerData("killstreaksState", "countToNext", 0);
    return;
  }

  if(self getMaxStreakCost() == 0) {
    self setCommonPlayerData("killstreaksState", "countToNext", 0);
    return;
  }

  if(self.streakType == "specialist") {
    if(self.adrenaline >= self getMaxStreakCost()) {
      return;
    }
  }

  nextStreakName = getNextStreakName();
  if(!isDefined(nextStreakname)) {
    return;
  }
  nextStreakCost = getStreakCost(nextStreakName);
  self setCommonPlayerData("killstreaksState", "countToNext", nextStreakCost);
}

getNextStreakName() {
  if(self.adrenaline == self getMaxStreakCost() && (self.streakType != "specialist")) {
    adrenaline = 0;
  } else {
    adrenaline = self.adrenaline;
  }

  foreach(streakName in self.killstreaks) {
    streakVal = self getStreakCost(streakName);

    if(streakVal > adrenaline) {
      return streakName;
    }
  }
  return undefined;
}

getMaxStreakCost() {
  maxCost = 0;
  foreach(streakName in self.killstreaks) {
    streakVal = self getStreakCost(streakName);

    if(streakVal > maxCost) {
      maxCost = streakVal;
    }
  }
  return maxCost;
}

updateStreakSlots() {
  if(!isDefined(self.streakType)) {
    return;
  }
  if(!isReallyAlive(self)) {
    return;
  }
  self_pers_killstreaks = self.pers["killstreaks"];

  numStreaks = 0;
  for(i = 0; i < KILLSTREAK_SLOT_3 + 1; i++) {
    if(isDefined(self_pers_killstreaks[i]) && isDefined(self_pers_killstreaks[i].streakName)) {
      self setCommonPlayerData("killstreaksState", "hasStreak", i, self_pers_killstreaks[i].available);
      if(self_pers_killstreaks[i].available == true) {
        numStreaks++;
      }

      if(isDefined(level.removeKillStreakIcons) && level.removeKillStreakIcons && !self_pers_killstreaks[i].available) {
        self setCommonPlayerData("killstreaksState", "icons", i, 0);
      }
    }
  }
  if(self.streakType != "specialist") {
    self setCommonPlayerData("killstreaksState", "numAvailable", numStreaks);
  }

  minLevel = self.earnedStreakLevel;
  maxLevel = self getMaxStreakCost();
  if(self.earnedStreakLevel == maxLevel && self.streakType != "specialist") {
    minLevel = 0;
  }

  nextIndex = 1;

  foreach(streakName in self.killstreaks) {
    streakVal = self getStreakCost(streakName);

    if(streakVal > minLevel) {
      nextStreak = streakName;
      break;
    }

    if(self.streakType == "specialist") {
      if(self.earnedStreakLevel == maxLevel) {
        break;
      }
    }

    nextIndex++;
  }

  self setCommonPlayerData("killstreaksState", "nextIndex", nextIndex);

  if(isDefined(self.killstreakIndexWeapon) && (self.streakType != "specialist")) {
    self setCommonPlayerData("killstreaksState", "selectedIndex", self.killstreakIndexWeapon);
  } else {
    if(self.streakType == "specialist" && self_pers_killstreaks[KILLSTREAK_GIMME_SLOT].available) {
      self setCommonPlayerData("killstreaksState", "selectedIndex", 0);
    } else {
      self setCommonPlayerData("killstreaksState", "selectedIndex", -1);
    }
  }
}

waitForChangeTeam() {
  self endon("disconnect");
  self endon("faux_spawn");

  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");

  for(;;) {
    self waittill("joined_team");
    clearKillstreaks();
  }
}

killstreakUsePressed() {
  self_pers_killstreaks = self.pers["killstreaks"];

  streakName = self_pers_killstreaks[self.killstreakIndexWeapon].streakName;
  lifeId = self_pers_killstreaks[self.killstreakIndexWeapon].lifeId;
  isEarned = self_pers_killstreaks[self.killstreakIndexWeapon].earned;
  awardXp = self_pers_killstreaks[self.killstreakIndexWeapon].awardXp;
  kID = self_pers_killstreaks[self.killstreakIndexWeapon].kID;
  isGimme = self_pers_killstreaks[self.killstreakIndexWeapon].isGimme;

  if(!self validateUseStreak()) {
    return false;
  }

  if(!self[[level.killstreakFuncs[streakName]]](lifeId, streakName)) {
    return (false);
  }

  if(!IsBot(self) && isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
    return true;
  }

  self thread updateKillstreaks();
  self usedKillstreak(streakName, awardXp);

  return (true);
}

usedKillstreak(streakName, awardXp) {
  if(awardXp) {
    self thread[[level.onXPEvent]]("killstreak_" + streakName);
    self thread maps\mp\gametypes\_missions::useHardpoint(streakName);
  }

  awardref = maps\mp\_awards::getKillstreakAwardRef(streakName);
  if(isDefined(awardref)) {
    self thread incPlayerStat(awardref, 1);
  }

  if(isAssaultKillstreak(streakName)) {
    self thread incPlayerStat("assaultkillstreaksused", 1);
  } else if(isSupportKillstreak(streakName)) {
    self thread incPlayerStat("supportkillstreaksused", 1);
  } else if(isSpecialistKillstreak(streakName)) {
    self thread incPlayerStat("specialistkillstreaksearned", 1);

    return;
  }

  team = self.team;
  if(level.teamBased) {
    thread leaderDialog(team + "_friendly_" + streakName + "_inbound", team);

    if(getKillstreakEnemyUseDialog(streakName)) {
      if(self playEnemyDialog(streakName)) {
        thread leaderDialog(team + "_enemy_" + streakName + "_inbound", level.otherTeam[team]);
      }
    }
  } else {
    self thread leaderDialogOnPlayer(team + "_friendly_" + streakName + "_inbound");

    if(getKillstreakEnemyUseDialog(streakName)) {
      excludeList[0] = self;

      if(self playEnemyDialog(streakName)) {
        thread leaderDialog(team + "_enemy_" + streakName + "_inbound", undefined, undefined, excludeList);
      }
    }
  }
}

playEnemyDialog(streakName) {
  if(!is_aliens()) {
    if(level.teamBased && streakName == "uplink" && [
        [level.comExpFuncs["getRadarStrengthForTeam"]]
      ](self.team) != 1)
      return false;

    else if(!level.teamBased && streakName == "uplink" && [
        [level.comExpFuncs["getRadarStrengthForPlayer"]]
      ](self) != 2)
      return false;
  }

  return true;
}

updateKillstreaks(keepCurrent) {
  if(IsAI(self) && !isDefined(self.killstreakIndexWeapon)) {
    return;
  }
  if(!isDefined(keepCurrent)) {
    self.pers["killstreaks"][self.killstreakIndexWeapon].available = false;

    if(self.killstreakIndexWeapon == KILLSTREAK_GIMME_SLOT) {
      self.pers["killstreaks"][self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].nextSlot] = undefined;

      streakName = undefined;
      kID = undefined;
      self_pers_killstreaks = self.pers["killstreaks"];
      for(i = KILLSTREAK_STACKING_START_SLOT; i < self_pers_killstreaks.size; i++) {
        if(!isDefined(self_pers_killstreaks[i]) || !isDefined(self_pers_killstreaks[i].streakName)) {
          continue;
        }
        streakName = self_pers_killstreaks[i].streakName;
        kID = self_pers_killstreaks[i].kID;
        self_pers_killstreaks[KILLSTREAK_GIMME_SLOT].nextSlot = i;
      }

      if(isDefined(streakName)) {
        self_pers_killstreaks[KILLSTREAK_GIMME_SLOT].available = true;
        self_pers_killstreaks[KILLSTREAK_GIMME_SLOT].streakName = streakName;
        self_pers_killstreaks[KILLSTREAK_GIMME_SLOT].kID = kID;

        streakIndex = getKillstreakIndex(streakName);
        self setCommonPlayerData("killstreaksState", "icons", KILLSTREAK_GIMME_SLOT, streakIndex);

        if(!level.console && !self is_player_gamepad_enabled()) {
          killstreakWeapon = getKillstreakWeapon(streakName);
          _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }
    }
  }

  highestStreakIndex = undefined;
  if(self.streakType == "specialist") {
    if(self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].available) {
      highestStreakIndex = KILLSTREAK_GIMME_SLOT;
    }
  } else {
    for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
      self_pers_killstreaks_i = self.pers["killstreaks"][i];
      if(isDefined(self_pers_killstreaks_i) &&
        isDefined(self_pers_killstreaks_i.streakName) &&
        self_pers_killstreaks_i.available) {
        highestStreakIndex = i;
      }
    }
  }

  if(isDefined(highestStreakIndex)) {
    if(level.console || self is_player_gamepad_enabled()) {
      self.killstreakIndexWeapon = highestStreakIndex;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][highestStreakIndex].streakName;

      self giveSelectedKillstreakItem();
    } else {
      for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
        self_pers_killstreaks_i = self.pers["killstreaks"][i];
        if(isDefined(self_pers_killstreaks_i) &&
          isDefined(self_pers_killstreaks_i.streakName) &&
          self_pers_killstreaks_i.available) {
          killstreakWeapon = getKillstreakWeapon(self_pers_killstreaks_i.streakName);
          weaponsListItems = self GetWeaponsListItems();
          hasKillstreakWeapon = false;
          for(j = 0; j < weaponsListItems.size; j++) {
            if(killstreakWeapon == weaponsListItems[j]) {
              hasKillstreakWeapon = true;
              break;
            }
          }

          if(!hasKillstreakWeapon) {
            self _giveWeapon(killstreakWeapon);
          } else {
            if(IsSubStr(killstreakWeapon, "airdrop_")) {
              self SetWeaponAmmoClip(killstreakWeapon, 1);
            }
          }

          self _setActionSlot(i + 4, "weapon", killstreakWeapon);
        }
      }

      self.killstreakIndexWeapon = undefined;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][highestStreakIndex].streakName;
      self updateStreakSlots();
    }
  } else {
    self.killstreakIndexWeapon = undefined;
    self.pers["lastEarnedStreak"] = undefined;
    self updateStreakSlots();

  }
}

clearKillstreaks() {
  self_pers_killstreaks = self.pers["killstreaks"];
  if(!isDefined(self_pers_killstreaks)) {
    return;
  }
  for(i = self_pers_killstreaks.size - 1; i > -1; i--) {
    self.pers["killstreaks"][i] = undefined;
  }

  initPlayerKillstreaks();

  self resetAdrenaline();
  self.killstreakIndexWeapon = undefined;
  self updateStreakSlots();
}

updateSpecialistKillstreaks() {
  if(self.adrenaline == 0) {
    for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
      if(isDefined(self.pers["killstreaks"][i])) {
        self.pers["killstreaks"][i].available = false;
        self setCommonPlayerData("killstreaksState", "hasStreak", i, false);
      }
    }
    self setCommonPlayerData("killstreaksState", "nextIndex", 1);
    self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT, false);
  } else {
    for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
      self_pers_killstreaks_i = self.pers["killstreaks"][i];
      if(isDefined(self_pers_killstreaks_i) &&
        isDefined(self_pers_killstreaks_i.streakName) &&
        self_pers_killstreaks_i.available) {
        streakVal = getStreakCost(self_pers_killstreaks_i.streakName);
        if(streakVal > self.adrenaline) {
          self.pers["killstreaks"][i].available = false;
          self setCommonPlayerData("killstreaksState", "hasStreak", i, false);
          continue;
        }

        if(self.adrenaline >= streakVal) {
          if(self getCommonPlayerData("killstreaksState", "hasStreak", i)) {
            self[[level.killstreakFuncs[self_pers_killstreaks_i.streakName]]](undefined, self_pers_killstreaks_i.streakName);

            continue;
          }

          self giveKillstreak(self_pers_killstreaks_i.streakName, self_pers_killstreaks_i.earned, false, self);
        }
      }
    }

    specialist_max_kills = self getMaxStreakCost();;
    if(isAI(self)) {
      specialist_max_kills = self.pers["specialistStreakKills"][2];
    }
    numKills = int(max(MIN_NUM_KILLS_GIVE_BONUS_PERKS, (specialist_max_kills + 2)));
    if(self _hasPerk("specialty_hardline")) {
      numKills--;
    }

    if(self.adrenaline >= numKills) {
      self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT, true);
      self giveBonusPerks();
    } else
      self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT, false);
  }

  if(self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].available) {
    streakName = self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].streakName;
    killstreakWeapon = getKillstreakWeapon(streakName);

    if(level.console || self is_player_gamepad_enabled()) {
      self giveKillstreakWeapon(killstreakWeapon);
      self.killstreakIndexWeapon = KILLSTREAK_GIMME_SLOT;
    } else {
      self _giveWeapon(killstreakWeapon);
      self _setActionSlot(4, "weapon", killstreakWeapon);
      self.killstreakIndexWeapon = undefined;
    }
  }
}

getFirstPrimaryWeapon() {
  weaponsList = self getWeaponsListPrimaries();

  assert(isDefined(weaponsList[0]));

  return weaponsList[0];
}

isTryingToUseKillstreakInGimmeSlot() {
  return isDefined(self.tryingToUseKS) && self.tryingToUseKS && isDefined(self.killstreakIndexWeapon) && self.killstreakIndexWeapon == 0;
}

isTryingToUseKillstreakSlot() {
  return isDefined(self.tryingToUseKS) && self.tryingToUseKS && isDefined(self.killstreakIndexWeapon);
}

waitForKillstreakWeaponSwitchStarted() {
  self endon("weapon_switch_invalid");

  self waittill("weapon_switch_started", newWeapon);
  self notify("killstreak_weapon_change", "switch_started", newWeapon);
}

waitForKillstreakWeaponSwitchInvalid() {
  self endon("weapon_switch_started");

  self waittill("weapon_switch_invalid", invalidWeapon);
  self notify("killstreak_weapon_change", "switch_invalid", invalidWeapon);
}

waitForKillstreakWeaponChange() {
  self childthread waitForKillstreakWeaponSwitchStarted();
  self childthread waitForKillstreakWeaponSwitchInvalid();

  self waittill("killstreak_weapon_change", result, weapon);

  if(result == "switch_started") {
    return weapon;
  }

  assert(result == "switch_invalid");
  assert(isTryingToUseKillstreakSlot());

  killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName);

  PrintLn("Invalid killstreak weapon switch: " + weapon + ". Forcing switch to " + killstreakWeapon + " instead.");

  self SwitchToWeapon(killstreakWeapon);

  waittillframeend;

  newWeapon = undefined;
  if(isDefined(self.changingWeapon)) {
    PrintLn("changing weapon defined\n");
    newWeapon = self.changingWeapon;
  } else {
    PrintLn("waiting for weapon switch\n");
    self waittill("weapon_switch_started", newWeapon);
  }

  PrintLn("Weapon switche started: " + newWeapon + "\n");

  if(newWeapon != killstreakWeapon) {
    PrintLn("Player switched weapons after script forced killstreak weapon. Skipping killstreak weapon change. " + newWeapon + " != " + killstreakWeapon);
    return undefined;
  }

  return killstreakWeapon;
}

killstreakUseWaiter() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("spawned");
  level endon("game_ended");

  self notify("killstreakUseWaiter");
  self endon("killstreakUseWaiter");

  self.lastKillStreak = 0;
  if(!isDefined(self.pers["lastEarnedStreak"])) {
    self.pers["lastEarnedStreak"] = undefined;
  }

  self thread finishDeathWaiter();

  notify_array = ["streakUsed", "streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4"];
  while(true) {
    self.tryingToUseKS = undefined;
    notify_result = self waittill_any_in_array_return_no_endon_death(notify_array);
    self.tryingToUseKS = true;

    waittillframeend;

    if(!isDefined(self.killstreakIndexWeapon) ||
      !isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon]) ||
      !isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName)) {
      continue;
    }

    if(!canCustomJuggUseKillstreak(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName)) {
      printCustomJuggKillstreakErrorMsg();

      if(notify_result != "streakUsed") {
        lastWeapon = self GetCurrentWeapon();
        self switch_to_last_weapon(lastWeapon);
      }

      continue;
    }

    if(self IsOffhandWeaponReadyToThrow()) {
      continue;
    }
    if(isDefined(self.changingWeapon)) {
      newWeapon = self.changingWeapon;
    } else {
      self waittill("weapon_switch_started", newWeapon);
    }
    killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName);
    if(newWeapon != killstreakWeapon) {
      self thread removeUnitializedKillstreakWeapon();
      continue;
    }

    self beginKillstreakWeaponSwitch();

    if(newWeapon != self GetCurrentWeapon()) {
      self thread killstreakWaitForWeaponChange();
      result = self waittill_any_timeout_no_endon_death(1.5, "ks_weapon_change", "ks_alt_weapon_change");

      if(result == "ks_alt_weapon_change") {
        self waittill("weapon_change", newWeapon, isAltToggle);
      } else {
        newWeapon = self GetCurrentWeapon();
      }
    }

    if(!IsAlive(self)) {
      self endKillstreakWeaponSwitch();
      continue;
    }

    if(newWeapon != killstreakWeapon) {
      switch_to_weapon = self.lastdroppableweapon;
      if(isKillstreakWeapon(newWeapon)) {
        if(self isJuggernaut() && isJuggernautWeapon(newWeapon)) {
          switch_to_weapon = newWeapon;
        } else if(newWeapon == "iw6_gm6helisnipe_mp_gm6scope") {
          switch_to_weapon = newWeapon;
        } else {
          self TakeWeapon(newWeapon);
        }
      }
      self SwitchToWeapon(switch_to_weapon);
      self endKillstreakWeaponSwitch();
      continue;
    }

    self.KS_aboutToUse = true;
    waittillframeend;
    self.KS_aboutToUse = undefined;

    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    isGimme = self.pers["killstreaks"][self.killstreakIndexWeapon].isGimme;

    assert(isDefined(streakName));
    assert(isDefined(level.killstreakFuncs[streakName]));

    self endKillstreakWeaponSwitch();
    result = self killstreakUsePressed();
    self beginKillstreakWeaponSwitch();

    lastWeapon = self getLastWeapon();
    if(!self HasWeapon(lastWeapon)) {
      if(isReallyAlive(self)) {
        lastWeapon = self getFirstPrimaryWeapon();
      } else {
        self _giveWeapon(lastWeapon);
      }
    }

    if(result) {
      self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
    }

    if(shouldSwitchWeaponPostKillstreak(result, streakName)) {
      self switch_to_last_weapon(lastWeapon);
    }

    currentWeapon = self GetCurrentWeapon();
    while(currentWeapon != lastWeapon) {
      self waittill("weapon_change", currentWeapon);
    }

    self endKillstreakWeaponSwitch();
  }
}

removeUnitializedKillstreakWeapon() {
  self notify("removeUnitializedKillstreakWeapon");
  self endon("removeUnitializedKillstreakWeapon");
  self endon("death");
  self endon("disconnect");

  self waittill("weapon_change", weaponName);

  weaponIsStreakInFocus = isDefined(self.killstreakIndexWeapon) &&
    isDefined(self.pers["killstreaks"]) &&
    isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon]) &&
    isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) &&
    weaponName == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName);

  if(weaponIsStreakInFocus && !isDefined(self.KS_aboutToUse)) {
    self TakeWeapon(weaponName);
    self _giveWeapon(weaponName, 0);
    self _setActionSlot(4, "weapon", weaponName);

    lastWeapon = self getLastWeapon();
    if(!self HasWeapon(lastWeapon)) {
      lastWeapon = self maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();
    }

    if(isDefined(lastWeapon)) {
      self switch_to_last_weapon(lastWeapon);
    }
  }
}

beginKillstreakWeaponSwitch() {
  self _disableWeaponSwitch();
  self _disableUsability();
  self thread killstreakWeaponSwitchWatchHostMigration();
}

endKillstreakWeaponSwitch() {
  self notify("endKillstreakWeaponSwitch");
  self _enableWeaponSwitch();
  self _enableUsability();
}

killstreakWaitForWeaponChange() {
  self waittill("weapon_change", newWeapon, isAltMode);

  if(!isAltMode) {
    self notify("ks_weapon_change");
  } else {
    self notify("ks_alt_weapon_change");
  }
}

killstreakWeaponSwitchWatchHostMigration() {
  self endon("death");
  level endon("game_ended");

  self endon("endKillstreakWeaponSwitch");

  level waittill("host_migration_end");

  if(isDefined(self)) {
    self enableWeaponSwitch();
  }
}

waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon) {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  level endon("game_ended");

  self notify("waitTakeKillstreakWeapon");
  self endon("waitTakeKillstreakWeapon");

  wasNone = (self GetCurrentWeapon() == "none");

  self waittill("weapon_change", newWeapon);

  if(newWeapon == lastWeapon) {
    takeKillstreakWeaponIfNoDupe(killstreakWeapon);

    if(!level.console && !self is_player_gamepad_enabled()) {
      self.killstreakIndexWeapon = undefined;
    }
  } else if(newWeapon != killstreakWeapon) {
    self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
  } else if(wasNone && self GetCurrentWeapon() == killstreakWeapon) {
    self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
  }
}

takeKillstreakWeaponIfNoDupe(killstreakWeapon) {
  hasKillstreak = false;
  self_pers_killstreaks = self.pers["killstreaks"];
  for(i = 0; i < self_pers_killstreaks.size; i++) {
    if(isDefined(self_pers_killstreaks[i]) && isDefined(self_pers_killstreaks[i].streakName) && self_pers_killstreaks[i].available) {
      if(!isSpecialistKillstreak(self_pers_killstreaks[i].streakName) && killstreakWeapon == getKillstreakWeapon(self_pers_killstreaks[i].streakName)) {
        hasKillstreak = true;
        break;
      }
    }
  }

  if(hasKillstreak) {
    if(level.console || self is_player_gamepad_enabled()) {
      if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon != getKillstreakWeapon(self_pers_killstreaks[self.killstreakIndexWeapon].streakName)) {
        self TakeWeapon(killstreakWeapon);
      } else if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon == getKillstreakWeapon(self_pers_killstreaks[self.killstreakIndexWeapon].streakName)) {
        self TakeWeapon(killstreakWeapon);
        self _giveWeapon(killstreakWeapon, 0);
        self _setActionSlot(4, "weapon", killstreakWeapon);
      }
    } else {
      self TakeWeapon(killstreakWeapon);
      self _giveWeapon(killstreakWeapon, 0);
    }
  } else {
    if(killstreakWeapon == "") {
      return;
    }
    self TakeWeapon(killstreakWeapon);
  }
}

shouldSwitchWeaponPostKillstreak(result, streakName) {
  if(!result) {
    return true;
  }
  if(isRideKillstreak(streakName)) {
    return false;
  }

  return true;
}

finishDeathWaiter() {
  self endon("disconnect");
  level endon("game_ended");

  self notify("finishDeathWaiter");
  self endon("finishDeathWaiter");

  self waittill("death");
  wait(0.05);
  self notify("finish_death");
  self.pers["lastEarnedStreak"] = undefined;
}

checkStreakReward() {
  foreach(streakName in self.killstreaks) {
    streakVal = getStreakCost(streakName);

    if(streakVal > self.adrenaline) {
      break;
    }

    if(self.previousAdrenaline < streakVal && self.adrenaline >= streakVal) {
      self earnKillstreak(streakName, streakVal);

      break;
    }
  }
}

killstreakEarned(streakName) {
  streakArray = "assault";
  switch (self.streakType) {
    case "assault":
      streakArray = "assaultStreaks";
      break;
    case "support":
      streakArray = "supportStreaks";
      break;
    case "specialist":
      streakArray = "specialistStreaks";
      break;
  }

  if(isDefined(self.class_num)) {
    if(self getCacPlayerData("loadouts", self.class_num, streakArray, 0) == streakName) {
      self.firstKillstreakEarned = getTime();
    } else if(self getCaCPlayerData("loadouts", self.class_num, streakArray, 2) == streakName && isDefined(self.firstKillstreakEarned)) {
      if(getTime() - self.firstKillstreakEarned < 20000) {
        self thread maps\mp\gametypes\_missions::genericChallenge("wargasm");
      }
    }
  }
}

earnKillstreak(streakName, streakVal) {
  level notify("gave_killstreak", streakName);

  self.earnedStreakLevel = streakVal;

  if(!level.gameEnded) {
    appendString = undefined;

    if(self.streakType == "specialist") {
      perkName = GetSubStr(streakName, 0, streakName.size - 3);
      if(maps\mp\gametypes\_class::isPerkUpgraded(perkName)) {
        appendString = "pro";
      }
    }
    self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal, appendString);

    if(bot_is_fireteam_mode()) {
      if(isDefined(appendString)) {
        self notify("bot_killstreak_earned", streakName + "_" + appendString, streakVal);
      } else {
        self notify("bot_killstreak_earned", streakName, streakVal);
      }
    }
  }

  self thread killstreakEarned(streakName);
  self.pers["lastEarnedStreak"] = streakName;

  self setStreakCountToNext();

  self giveKillstreak(streakName, true, true);
}

giveKillstreak(streakName, isEarned, awardXp, owner, slotNumber, streakID) {
  self endon("joined_team");
  self endon("givingLoadout");
  self endon("disconnect");

  if(!isDefined(streakID)) {
    streakID = self.pers["kID"];
    self.pers["kID"]++;
  }

  if(!isDefined(level.killstreakFuncs[streakName])) {
    AssertMsg("giveKillstreak() called with invalid killstreak: " + streakName);
    return;
  }

  if(self.team == "spectator") {
    return;
  }
  index = undefined;
  if(!isDefined(isEarned) || isEarned == false) {
    if(isDefined(slotNumber)) {
      nextSlot = slotNumber;
    } else {
      nextSlot = self.pers["killstreaks"].size;
    }

    if(!isDefined(self.pers["killstreaks"][nextSlot])) {
      self.pers["killstreaks"][nextSlot] = spawnStruct();
    }

    addedToTop = true;
    if(nextSlot > KILLSTREAK_STACKING_START_SLOT && self isTryingToUseKillstreakInGimmeSlot()) {
      addedToTop = false;
      addedSlot = nextSlot;
      currSlot = nextSlot - 1;
      currStruct = self.pers["killstreaks"][currSlot];

      addedStruct = self.pers["killstreaks"][addedSlot];
      addedStruct.available = currStruct.available;
      addedStruct.streakName = currStruct.streakName;
      addedStruct.earned = currStruct.earned;
      addedStruct.awardxp = currStruct.awardxp;
      addedStruct.owner = currStruct.owner;
      addedStruct.kID = currStruct.kID;
      addedStruct.lifeId = currStruct.lifeId;
      addedStruct.isGimme = currStruct.isGimme;
      addedStruct.isSpecialist = currStruct.isSpecialist;

      nextSlot = currSlot;
    }

    self_pers_killstreak_nextSlot = self.pers["killstreaks"][nextSlot];

    self_pers_killstreak_nextSlot.available = false;
    self_pers_killstreak_nextSlot.streakName = streakName;
    self_pers_killstreak_nextSlot.earned = false;
    self_pers_killstreak_nextSlot.awardxp = isDefined(awardXp) && awardXp;
    self_pers_killstreak_nextSlot.owner = owner;
    self_pers_killstreak_nextSlot.kID = streakID;
    self_pers_killstreak_nextSlot.lifeId = -1;
    self_pers_killstreak_nextSlot.isGimme = true;
    self_pers_killstreak_nextSlot.isSpecialist = false;

    if(!addedToTop) {
      self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].nextSlot = nextSlot + 1;

      return;
    }

    if(!isDefined(slotNumber)) {
      slotNumber = KILLSTREAK_GIMME_SLOT;
    }

    self.pers["killstreaks"][slotNumber].nextSlot = nextSlot;
    self.pers["killstreaks"][slotNumber].streakName = streakName;

    index = slotNumber;
    streakIndex = getKillstreakIndex(streakName);
    self setCommonPlayerData("killstreaksState", "icons", slotNumber, streakIndex);
  } else {
    for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
      self_pers_killstreak_i = self.pers["killstreaks"][i];
      if(isDefined(self_pers_killstreak_i) && isDefined(self_pers_killstreak_i.streakName) && streakName == self_pers_killstreak_i.streakName) {
        index = i;
        break;
      }
    }
    if(!isDefined(index)) {
      AssertMsg("earnKillstreak() trying to give unearnable killstreak with giveKillstreak(): " + streakName);
      return;
    }
  }

  self_pers_killstreak_index = self.pers["killstreaks"][index];
  self_pers_killstreak_index.available = true;
  self_pers_killstreak_index.earned = isDefined(isEarned) && isEarned;
  self_pers_killstreak_index.awardxp = isDefined(awardXp) && awardXp;
  self_pers_killstreak_index.owner = owner;
  self_pers_killstreak_index.kID = streakID;

  if(!self_pers_killstreak_index.earned) {
    self_pers_killstreak_index.lifeId = -1;
  } else {
    self_pers_killstreak_index.lifeId = self.pers["deaths"];
  }

  AssertEx(isDefined(self), "Player to be rewarded is undefined");
  AssertEx(IsPlayer(self), "Somehow a non player ent is receiving a killstreak reward");
  AssertEx(isDefined(self.streakType), "Player: " + self.name + " doesn't have a streakType defined");

  if(self.streakType == "specialist" && index != KILLSTREAK_GIMME_SLOT) {
    self_pers_killstreak_index.isSpecialist = true;
    if(isDefined(level.killstreakFuncs[streakName])) {
      self[[level.killstreakFuncs[streakName]]](-1, streakName);
    }

    self usedKillstreak(streakName, awardXp);
  } else {
    if(level.console || self is_player_gamepad_enabled()) {
      weapon = getKillstreakWeapon(streakName);
      self giveKillstreakWeapon(weapon);

      if(isDefined(self.killstreakIndexWeapon)) {
        streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
        killstreakWeapon = getKillstreakWeapon(streakName);
        if(!(self isHoldingWeapon(killstreakWeapon))) {
          self.killstreakIndexWeapon = index;
        }
      } else {
        self.killstreakIndexWeapon = index;
      }
    } else {
      if(KILLSTREAK_GIMME_SLOT == index && self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].nextSlot > KILLSTREAK_STACKING_START_SLOT) {
        slotToTake = self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].nextSlot - 1;
        killstreakWeaponToTake = getKillstreakWeapon(self.pers["killstreaks"][slotToTake].streakName);
        self TakeWeapon(killstreakWeaponToTake);
      }

      killstreakWeapon = getKillstreakWeapon(streakName);
      self _giveWeapon(killstreakWeapon, 0);

      enableActionSlot = true;

      if(isDefined(self.killstreakIndexWeapon)) {
        streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
        killstreakWeapon = getKillstreakWeapon(streakName);

        enableActionSlot = !(self isHoldingWeapon(killstreakWeapon)) && (self GetCurrentWeapon() != "none");
      }

      if(enableActionSlot) {
        self _setActionSlot(index + 4, "weapon", killstreakWeapon);
      } else {
        self _setActionSlot(index + 4, "");
        self.actionSlotEnabled[index] = false;
      }
    }
  }

  self updateStreakSlots();

  if(isDefined(level.killstreakSetupFuncs[streakName])) {
    self[[level.killstreakSetupFuncs[streakName]]]();
  }

  if(isDefined(isEarned) && isEarned && isDefined(awardXp) && awardXp) {
    self notify("received_earned_killstreak");
  }
}

giveKillstreakWeapon(weapon) {
  self endon("disconnect");

  if(!level.console && !self is_player_gamepad_enabled()) {
    return;
  }
  streakName = getKillstreakReferenceByWeapon(weapon);
  if(!canCustomJuggUseKillstreak(streakName)) {
    self _setActionSlot(4, "");
    return;
  }

  weaponList = self GetWeaponsListItems();

  foreach(item in weaponList) {
    if(!isStrStart(item, "killstreak_") && !isStrStart(item, "airdrop_") && !isStrStart(item, "deployable_")) {
      continue;
    }
    if(self isHoldingWeapon(item)) {
      continue;
    }
    while(self isChangingWeapon()) {
      wait(0.05);
    }

    self TakeWeapon(item);
  }

  if(isDefined(self.killstreakIndexWeapon)) {
    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    killstreakWeapon = getKillstreakWeapon(streakName);
    if(!(self isHoldingWeapon(killstreakWeapon))) {
      if(weapon != "") {
        self _giveWeapon(weapon, 0);
        self _setActionSlot(4, "weapon", weapon);
      }
    }
  } else {
    self _giveWeapon(weapon, 0);
    self _setActionSlot(4, "weapon", weapon);
  }
}

isHoldingWeapon(weapon) {
  return (self GetCurrentWeapon() == weapon ||
    (isDefined(self.changingWeapon) && self.changingWeapon == weapon));
}

getStreakCost(streakName) {
  cost = int(getKillstreakKills(streakName));

  if(isDefined(self) && IsPlayer(self)) {
    if(isSpecialistKillstreak(streakName)) {
      if(isDefined(self.pers["gamemodeLoadout"])) {
        if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak1"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == streakName) {
          cost = 2;
        } else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak2"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == streakName) {
          cost = 4;
        } else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak3"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == streakName) {
          cost = 6;
        } else {
          AssertMsg("getStreakCost: killstreak doesn't exist in player's loadout");
        }
      } else if(IsSubStr(self.curClass, "custom")) {
        index = 0;
        for(; index < 3; index++) {
          killstreak = self getCaCPlayerData("loadouts", self.class_num, "specialistStreaks", index);
          if(killstreak == streakName) {
            break;
          }
        }
        AssertEx(index <= 2, "getStreakCost: killstreak index greater than 2 when it shouldn't be");
        cost = self getCaCPlayerData("loadouts", self.class_num, "specialistStreakKills", index);
      } else if(IsSubStr(self.curClass, "callback")) {
        assert(isAI(self));
        assert(isDefined(self.pers["specialistStreaks"]));
        assert(isDefined(self.pers["specialistStreakKills"]));
        assert(self.pers["specialistStreakKills"].size == self.pers["specialistStreaks"].size);
        index = 0;
        foreach(index, streak in self.pers["specialistStreaks"]) {
          if(streak == streakName) {
            break;
          }
        }
        assert(index >= 0 && index < self.pers["specialistStreakKills"].size);
        cost = self.pers["specialistStreakKills"][index];
      } else if(isSubstr(self.curClass, "axis") || isSubstr(self.curClass, "allies")) {
        index = 0;
        teamName = "none";
        if(isSubstr(self.curClass, "axis")) {
          teamName = "axis";
        } else if(isSubstr(self.curClass, "allies")) {
          teamName = "allies";
        }

        classIndex = getClassIndex(self.curClass);
        for(; index < 3; index++) {
          killstreak = GetMatchRulesData("defaultClasses", teamName, classIndex, "class", "specialistStreaks", index);
          if(killstreak == streakName) {
            break;
          }
        }
        AssertEx(index <= 2, "getStreakCost: killstreak index greater than 2 when it shouldn't be");
        cost = GetMatchRulesData("defaultClasses", teamName, classIndex, "class", "specialistStreakKills", index);
      }
    }

    if(self _hasPerk("specialty_hardline") && cost > 0) {
      cost--;
    }
  }

  cost = Int(clamp(cost, 0, 30));

  return cost;
}

streakTypeResetsOnDeath(streakType) {
  switch (streakType) {
    case "assault":
    case "specialist":
      return true;
    case "support":
      return false;
  }
}

giveOwnedKillstreakItem(skipDialog) {
  self_pers_killstreaks = self.pers["killstreaks"];

  if(level.console || self is_player_gamepad_enabled()) {
    keepIndex = -1;
    highestCost = -1;
    for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
      if(isDefined(self_pers_killstreaks[i]) &&
        isDefined(self_pers_killstreaks[i].streakName) &&
        self_pers_killstreaks[i].available &&
        getStreakCost(self_pers_killstreaks[i].streakName) > highestCost) {
        highestCost = 0;
        if(!self_pers_killstreaks[i].isGimme) {
          highestCost = getStreakCost(self_pers_killstreaks[i].streakName);
        }
        keepIndex = i;
      }
    }

    if(keepIndex != -1) {
      self.killstreakIndexWeapon = keepIndex;

      streakName = self_pers_killstreaks[self.killstreakIndexWeapon].streakName;
      weapon = getKillstreakWeapon(streakName);
      self giveKillstreakWeapon(weapon);
    } else
      self.killstreakIndexWeapon = undefined;
  } else {
    keepIndex = -1;
    highestCost = -1;

    for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
      if(isDefined(self_pers_killstreaks[i]) &&
        isDefined(self_pers_killstreaks[i].streakName) &&
        self_pers_killstreaks[i].available) {
        killstreakWeapon = getKillstreakWeapon(self_pers_killstreaks[i].streakName);
        weaponsListItems = self GetWeaponsListItems();
        hasKillstreakWeapon = false;
        for(j = 0; j < weaponsListItems.size; j++) {
          if(killstreakWeapon == weaponsListItems[j]) {
            hasKillstreakWeapon = true;
            break;
          }
        }

        if(!hasKillstreakWeapon) {
          self _giveWeapon(killstreakWeapon);
        } else {
          if(IsSubStr(killstreakWeapon, "airdrop_")) {
            self SetWeaponAmmoClip(killstreakWeapon, 1);
          }
        }

        self _setActionSlot(i + 4, "weapon", killstreakWeapon);

        if(getStreakCost(self_pers_killstreaks[i].streakName) > highestCost) {
          highestCost = 0;
          if(!self_pers_killstreaks[i].isGimme) {
            highestCost = getStreakCost(self_pers_killstreaks[i].streakName);
          }
          keepIndex = i;
        }
      }
    }

    if(keepIndex != -1) {
      streakName = self_pers_killstreaks[keepIndex].streakName;
    }

    self.killstreakIndexWeapon = undefined;
  }

  updateStreakSlots();
}

initRideKillstreak(streak) {
  self _disableUsability();
  result = self initRideKillstreak_internal(streak);

  if(isDefined(self)) {
    self _enableUsability();
  }

  return result;
}

initRideKillstreak_internal(streak) {
  if(isDefined(streak) && isLaptopTimeoutKillstreak(streak)) {
    laptopWait = "timeout";
  } else {
    laptopWait = self waittill_any_timeout(1.0, "disconnect", "death", "weapon_switch_started");
  }

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(laptopWait == "weapon_switch_started") {
    return ("fail");
  }

  if(!isAlive(self)) {
    return "fail";
  }

  if(laptopWait == "disconnect" || laptopWait == "death") {
    if(laptopWait == "disconnect") {
      return ("disconnect");
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return ("success");
  }

  if(self isKillStreakDenied()) {
    return ("fail");
  }

  if(!isDefined(streak) || !IsSubStr(streak, "odin")) {
    self VisionSetNakedForPlayer("black_bw", 0.75);
    self thread set_visionset_for_watching_players("black_bw", 0.75, 1.0, undefined, true);
    blackOutWait = self waittill_any_timeout(0.80, "disconnect", "death");
  } else {
    blackOutWait = self waittill_any_timeout(1.0, "disconnect", "death");
  }

  self notify("black_out_done");

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(blackOutWait != "disconnect") {
    if(!isDefined(streak) || !IsSubStr(streak, "odin")) {
      self thread clearRideIntro(1.0);
    } else {
      self notify("intro_cleared");
    }

    if(self.team == "spectator") {
      return "fail";
    }
  }

  if(self isOnLadder()) {
    return "fail";
  }

  if(!isAlive(self)) {
    return "fail";
  }

  if(self isKillStreakDenied()) {
    return "fail";
  }

  if(blackOutWait == "disconnect") {
    return ("disconnect");
  } else {
    return ("success");
  }
}

isLaptopTimeoutKillstreak(streak) {
  switch (streak) {
    case "osprey_gunner":
    case "remote_uav":
    case "remote_tank":
    case "heli_pilot":
    case "vanguard":
    case "drone_hive":
    case "odin_support":
    case "odin_assault":
    case "ca_a10_strafe":
    case "ac130":
      return true;
  }
  return false;
}

clearRideIntro(delay, fadeBack) {
  self endon("disconnect");

  if(isDefined(delay)) {
    wait(delay);
  }

  if(!isDefined(fadeBack)) {
    fadeBack = 0;
  }

  self VisionSetNakedForPlayer("", fadeBack);
  self set_visionset_for_watching_players("", fadeBack);

  self notify("intro_cleared");
}

allowRideKillstreakPlayerExit(earlyEndNotify) {
  if(isDefined(earlyEndNotify)) {
    self endon(earlyEndNotify);
  }

  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;

  level endon("game_ended");
  owner endon("disconnect");
  owner endon("end_remote");
  self endon("death");

  while(true) {
    timeUsed = 0;
    while(owner UseButtonPressed()) {
      timeUsed += 0.05;
      if(timeUsed > 0.75) {
        self notify("killstreakExit");
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}

giveSelectedKillstreakItem() {
  streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;

  weapon = getKillstreakWeapon(streakName);
  self giveKillstreakWeapon(weapon);

  self updateStreakSlots();
}

getKillstreakCount() {
  numAvailable = 0;
  for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
    if(isDefined(self.pers["killstreaks"][i]) &&
      isDefined(self.pers["killstreaks"][i].streakName) &&
      self.pers["killstreaks"][i].available) {
      numAvailable++;
    }
  }
  return numAvailable;
}

shuffleKillstreaksUp() {
  if(getKillstreakCount() > 1) {
    while(true) {
      self.killstreakIndexWeapon++;
      if(self.killstreakIndexWeapon > KILLSTREAK_SLOT_3) {
        self.killstreakIndexWeapon = 0;
      }
      if(self.pers["killstreaks"][self.killstreakIndexWeapon].available == true) {
        break;
      }
    }

    giveSelectedKillstreakItem();
  }
}

shuffleKillstreaksDown() {
  if(getKillstreakCount() > 1) {
    while(true) {
      self.killstreakIndexWeapon--;
      if(self.killstreakIndexWeapon < 0) {
        self.killstreakIndexWeapon = KILLSTREAK_SLOT_3;
      }
      if(self.pers["killstreaks"][self.killstreakIndexWeapon].available == true) {
        break;
      }
    }

    giveSelectedKillstreakItem();
  }
}

streakSelectUpTracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_up");

    if(!level.Console && !self is_player_gamepad_enabled()) {
      continue;
    }
    if(isDefined(self.showingTacticalSelections) && self.showingTacticalSelections) {
      continue;
    }
    if(!self isMantling() &&
      (!isDefined(self.changingWeapon) || (isDefined(self.changingWeapon) && self.changingWeapon == "none")) &&
      (!isKillstreakWeapon(self GetCurrentWeapon()) || isMiniGun(self GetCurrentWeapon()) || self GetCurrentWeapon() == "venomxgun_mp" || (isKillstreakWeapon(self GetCurrentWeapon()) && self isJuggernaut())) &&
      self.streakType != "specialist" &&
      (!isDefined(self.isCarrying) || (isDefined(self.isCarrying) && self.isCarrying == false)) &&
      (!isDefined(self.lastStreakUsed) || (isDefined(self.lastStreakUsed) && (GetTime() - self.lastStreakUsed) > 100))) {
      self shuffleKillstreaksUp();
      self SetClientOmnvar("ui_killstreak_scroll", 1);
    }
    wait(.12);
  }
}

isMiniGun(sWeapon) {
  return (sWeapon == "iw6_minigunjugg_mp");
}
streakSelectDownTracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("toggled_down");

    if(!level.Console && !self is_player_gamepad_enabled()) {
      continue;
    }
    if(isDefined(self.showingTacticalSelections) && self.showingTacticalSelections) {
      continue;
    }
    if(!self isMantling() &&
      (!isDefined(self.changingWeapon) || (isDefined(self.changingWeapon) && self.changingWeapon == "none")) &&
      (!isKillstreakWeapon(self GetCurrentWeapon()) || isMiniGun(self GetCurrentWeapon()) || self GetCurrentWeapon() == "venomxgun_mp" || (isKillstreakWeapon(self GetCurrentWeapon()) && self isJuggernaut())) &&
      self.streakType != "specialist" &&
      (!isDefined(self.isCarrying) || (isDefined(self.isCarrying) && self.isCarrying == false)) &&
      (!isDefined(self.lastStreakUsed) || (isDefined(self.lastStreakUsed) && (GetTime() - self.lastStreakUsed) > 100))) {
      self shuffleKillstreaksDown();
      self SetClientOmnvar("ui_killstreak_scroll", 1);
    }
    wait(.12);
  }
}

streakUseTimeTracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("streakUsed");
    self.lastStreakUsed = GetTime();
  }
}

streakNotifyTracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(IsBot(self)) {
    return;
  }
  gameFlagWait("prematch_done");

  if(level.console || self is_player_gamepad_enabled()) {
    self notifyOnPlayerCommand("toggled_up", "+actionslot 1");
    self notifyOnPlayerCommand("toggled_down", "+actionslot 2");
    self notifyOnPlayerCommand("streakUsed", "+actionslot 4");
    self notifyOnPlayerCommand("streakUsed", "+actionslot 5");
    self notifyOnPlayerCommand("streakUsed", "+actionslot 6");
    self notifyOnPlayerCommand("streakUsed", "+actionslot 7");
  }

  if(!level.console) {
    self notifyOnPlayerCommand("streakUsed1", "+actionslot 4");
    self notifyOnPlayerCommand("streakUsed2", "+actionslot 5");
    self notifyOnPlayerCommand("streakUsed3", "+actionslot 6");
    self notifyOnPlayerCommand("streakUsed4", "+actionslot 7");
  }
}

registerAdrenalineInfo(type, value) {
  if(!isDefined(level.adrenalineInfo)) {
    level.adrenalineInfo = [];
  }

  level.adrenalineInfo[type] = value;
}

giveAdrenaline(type) {
  assertEx(isDefined(level.adrenalineInfo[type]), "Unknown adrenaline type: " + type);

  if(level.adrenalineInfo[type] == 0) {
    return;
  }
  if(self isJuggernaut() && self.streakType == "specialist") {
    return;
  }
  newAdrenaline = self.adrenaline + level.adrenalineInfo[type];
  adjustedAdrenaline = newAdrenaline;
  maxStreakCost = self getMaxStreakCost();
  if(adjustedAdrenaline > maxStreakCost && (self.streakType != "specialist")) {
    adjustedAdrenaline = adjustedAdrenaline - maxStreakCost;
  } else if(level.killstreakRewards && adjustedAdrenaline > maxStreakCost && self.streakType == "specialist") {
    specialist_max_kills = maxStreakCost;
    if(isAI(self)) {
      specialist_max_kills = self.pers["specialistStreakKills"][2];
    }
    numKills = int(max(MIN_NUM_KILLS_GIVE_BONUS_PERKS, (specialist_max_kills + 2)));
    if(self _hasPerk("specialty_hardline")) {
      numKills--;
    }

    should_give_bonus = (adjustedAdrenaline >= numKills && self GetCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT) == false);

    if(should_give_bonus) {
      self giveBonusPerks();

      self usedKillstreak("all_perks_bonus", true);
      self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("all_perks_bonus", numKills);
      self setCommonPlayerData("killstreaksState", "hasStreak", KILLSTREAK_BONUS_PERKS_SLOT, true);
      self.pers["killstreaks"][KILLSTREAK_BONUS_PERKS_SLOT].available = true;
    }

    if(maxStreakCost > 0 && !((adjustedAdrenaline - maxStreakCost) % 2)) {
      self thread maps\mp\gametypes\_rank::xpEventPopup("specialist_streaking_xp");
      self thread maps\mp\gametypes\_rank::giveRankXP("kill");
    }
  }

  self setAdrenaline(adjustedAdrenaline);
  self checkStreakReward();

  if(newAdrenaline == maxStreakCost && (self.streakType != "specialist")) {
    setAdrenaline(0);
  }
}

giveBonusPerks() {
  if(isAI(self)) {
    if(isDefined(self.pers) && isDefined(self.pers["specialistBonusStreaks"])) {
      foreach(abilityRef in self.pers["specialistBonusStreaks"]) {
        if(!self _hasPerk(abilityRef)) {
          self givePerk(abilityRef, false);
        }
      }
    }
  } else {
    for(abilityCategoryIndex = 0; abilityCategoryIndex < NUM_ABILITY_CATEGORIES; abilityCategoryIndex++) {
      for(abilityIndex = 0; abilityIndex < NUM_SUB_ABILITIES; abilityIndex++) {
        picked = false;
        if(isDefined(self.teamName)) {
          picked = getMatchRulesData("defaultClasses", self.teamName, self.class_num, "class", "specialistBonusStreaks", abilityCategoryIndex, abilityIndex);
        } else {
          picked = self GetCaCPlayerData("loadouts", self.class_num, "specialistBonusStreaks", abilityCategoryIndex, abilityIndex);
        }
        if(isDefined(picked) && picked) {
          abilityRef = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, 4 + abilityIndex);
          if(!self _hasPerk(abilityRef)) {
            self givePerk(abilityRef, false);
          }
        }
      }
    }
  }
}

resetAdrenaline() {
  self.earnedStreakLevel = 0;
  self setAdrenaline(0);
  self resetStreakCount();
  self.pers["lastEarnedStreak"] = undefined;
  self.pers["objectivePointStreak"] = 0;
  self SetClientOmnvar("ui_half_tick", false);
}

setAdrenaline(value) {
  if(value < 0) {
    value = 0;
  }

  if(isDefined(self.adrenaline)) {
    self.previousAdrenaline = self.adrenaline;
  } else {
    self.previousAdrenaline = 0;
  }

  self.adrenaline = value;

  self setClientDvar("ui_adrenaline", self.adrenaline);

  self updateStreakCount();
}

pc_watchGamepad() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  game_pad_enabled = self is_player_gamepad_enabled();
  while(true) {
    if(game_pad_enabled != self is_player_gamepad_enabled()) {
      game_pad_enabled = self is_player_gamepad_enabled();

      if(!game_pad_enabled) {
        if(isDefined(self.actionSlotEnabled)) {
          for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
            self.actionSlotEnabled[i] = true;
          }

          self notifyOnPlayerCommand("streakUsed1", "+actionslot 4");
          self notifyOnPlayerCommand("streakUsed2", "+actionslot 5");
          self notifyOnPlayerCommand("streakUsed3", "+actionslot 6");
          self notifyOnPlayerCommand("streakUsed4", "+actionslot 7");

          self giveOwnedKillstreakItem();
        }
      } else {
        weapon_list = self GetWeaponsListItems();
        foreach(weapon in weapon_list) {
          if(isKillstreakWeapon(weapon) && weapon == self GetCurrentWeapon()) {
            self SwitchToWeapon(self getLastWeapon());
            while(self isChangingWeapon()) {
              wait(0.05);
            }
          }

          if(isKillstreakWeapon(weapon)) {
            self TakeWeapon(weapon);
          }
        }

        for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
          self _setActionSlot(i + 4, "");
          self.actionSlotEnabled[i] = false;
        }

        self notifyOnPlayerCommand("toggled_up", "+actionslot 1");
        self notifyOnPlayerCommand("toggled_down", "+actionslot 2");
        self notifyOnPlayerCommand("streakUsed", "+actionslot 4");
        self notifyOnPlayerCommand("streakUsed", "+actionslot 5");
        self notifyOnPlayerCommand("streakUsed", "+actionslot 6");
        self notifyOnPlayerCommand("streakUsed", "+actionslot 7");

        self giveOwnedKillstreakItem();
      }
    }
    wait(0.05);
  }
}

pc_watchStreakUse() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self.actionSlotEnabled = [];
  self.actionSlotEnabled[KILLSTREAK_GIMME_SLOT] = true;
  self.actionSlotEnabled[KILLSTREAK_SLOT_1] = true;
  self.actionSlotEnabled[KILLSTREAK_SLOT_2] = true;
  self.actionSlotEnabled[KILLSTREAK_SLOT_3] = true;

  while(true) {
    result = self waittill_any_return("streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4");

    if(self is_player_gamepad_enabled()) {
      continue;
    }
    if(!isDefined(result)) {
      continue;
    }
    if(self.streakType == "specialist" && result != "streakUsed1") {
      continue;
    }
    if(isDefined(self.changingWeapon) && self.changingWeapon == "none") {
      continue;
    }
    if(self IsOffhandWeaponReadyToThrow()) {
      continue;
    }
    switch (result) {
      case "streakUsed1":
        if(self.pers["killstreaks"][KILLSTREAK_GIMME_SLOT].available && self.actionSlotEnabled[KILLSTREAK_GIMME_SLOT]) {
          self.killstreakIndexWeapon = KILLSTREAK_GIMME_SLOT;
        }
        break;
      case "streakUsed2":
        if(self.pers["killstreaks"][KILLSTREAK_SLOT_1].available && self.actionSlotEnabled[KILLSTREAK_SLOT_1]) {
          self.killstreakIndexWeapon = KILLSTREAK_SLOT_1;
        }
        break;
      case "streakUsed3":
        if(self.pers["killstreaks"][KILLSTREAK_SLOT_2].available && self.actionSlotEnabled[KILLSTREAK_SLOT_2]) {
          self.killstreakIndexWeapon = KILLSTREAK_SLOT_2;
        }
        break;
      case "streakUsed4":
        if(self.pers["killstreaks"][KILLSTREAK_SLOT_3].available && self.actionSlotEnabled[KILLSTREAK_SLOT_3]) {
          self.killstreakIndexWeapon = KILLSTREAK_SLOT_3;
        }
        break;
    }

    if(isDefined(self.killstreakIndexWeapon) && !self.pers["killstreaks"][self.killstreakIndexWeapon].available) {
      self.killstreakIndexWeapon = undefined;
    }

    if(isDefined(self.killstreakIndexWeapon)) {
      self disableKillstreakActionSlots();
      while(true) {
        self waittill("weapon_change", newWeapon, isAltToggle);
        if(isDefined(self.killstreakIndexWeapon)) {
          killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName);

          if(newWeapon == killstreakWeapon ||
            newWeapon == "none" ||
            (killstreakWeapon == "killstreak_uav_mp" && newWeapon == "killstreak_remote_uav_mp") ||
            (killstreakWeapon == "killstreak_uav_mp" && newWeapon == "uav_remote_mp") ||
            isAltToggle) {
            continue;
          }
          break;
        }

        break;
      }

      self enableKillstreakActionSlots();
      self.killstreakIndexWeapon = undefined;
    }
  }
}

disableKillstreakActionSlots() {
  for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
    if(!isDefined(self.killstreakIndexWeapon)) {
      break;
    }

    if(self.killstreakIndexWeapon == i) {
      continue;
    }
    self _setActionSlot(i + 4, "");
    self.actionSlotEnabled[i] = false;
  }
}

enableKillstreakActionSlots() {
  for(i = KILLSTREAK_GIMME_SLOT; i < KILLSTREAK_SLOT_3 + 1; i++) {
    if(self.pers["killstreaks"][i].available) {
      killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][i].streakName);
      self _setActionSlot(i + 4, "weapon", killstreakWeapon);
    } else {
      self _setActionSlot(i + 4, "");
    }

    self.actionSlotEnabled[i] = true;
  }
}

killstreakHit(attacker, weapon, vehicle) {
  if(isDefined(weapon) && isPlayer(attacker) && isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
    if(((level.teamBased && vehicle.owner.team != attacker.team) || !level.teamBased) && attacker != vehicle.owner) {
      if(isKillstreakWeapon(weapon)) {
        return;
      }
      if(!isDefined(attacker.lastHitTime[weapon])) {
        attacker.lastHitTime[weapon] = 0;
      }

      if(attacker.lastHitTime[weapon] == getTime()) {
        return;
      }
      attacker.lastHitTime[weapon] = getTime();

      attacker thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName(weapon, 1, "hits");

      if(!IsSquadsMode()) {
        totalShots = attacker maps\mp\gametypes\_persistence::statGetBuffered("totalShots");
        hits = attacker maps\mp\gametypes\_persistence::statGetBuffered("hits") + 1;

        if(hits <= totalShots) {
          attacker maps\mp\gametypes\_persistence::statSetBuffered("hits", hits);
          attacker maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));
          attacker maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(hits * 10000 / totalShots));
        }
      }
    }
  }
}

copy_killstreak_status(from, noTransfer) {
  self.streakType = from.streakType;
  self.pers["cur_kill_streak"] = from.pers["cur_kill_streak"];

  self maps\mp\gametypes\_persistence::statSetChild("round", "killStreak", self.pers["cur_kill_streak"]);

  self.pers["killstreaks"] = from.pers["killstreaks"];
  self.killstreaks = from.killstreaks;

  if(!isDefined(noTransfer) || noTransfer == false) {
    allEntities = getEntArray();
    foreach(ent in allEntities) {
      if(!isDefined(ent) || IsPlayer(ent)) {
        continue;
      }
      if(isDefined(ent.owner) && ent.owner == from) {
        if(ent.classname == "misc_turret") {
          ent maps\mp\killstreaks\_autosentry::sentry_setOwner(self);
        } else {
          ent.owner = self;
        }
      }
    }
  }

  self.adrenaline = undefined;
  self setAdrenaline(from.adrenaline);
  self resetStreakCount();
  self updateStreakCount();

  if(isDefined(noTransfer) && noTransfer == true && isDefined(self.killstreaks)) {
    index = 1;
    foreach(streakName in self.killstreaks) {
      killstreakIndexName = self.pers["killstreaks"][index].streakName;

      if(self.streakType == "specialist") {
        perkTokens = StrTok(self.pers["killstreaks"][index].streakName, "_");
        if(perkTokens[perkTokens.size - 1] == "ks") {
          perkName = undefined;
          foreach(token in perkTokens) {
            if(token != "ks") {
              if(!isDefined(perkName)) {
                perkName = token;
              } else {
                perkName += ("_" + token);
              }
            }
          }

          if(isStrStart(self.pers["killstreaks"][index].streakName, "_")) {
            perkName = "_" + perkName;
          }

          if(isDefined(perkName) && self maps\mp\gametypes\_class::getPerkUpgrade(perkName) != "specialty_null") {
            killstreakIndexName = self.pers["killstreaks"][index].streakName + "_pro";
          }
        }
      }

      self setCommonPlayerData("killstreaksState", "icons", index, getKillstreakIndex(killstreakIndexName));
      index++;
    }
  }

  self updateStreakSlots();

  foreach(perkName in from.perksPerkName) {
    if(!self _hasPerk(perkName)) {
      useSlot = false;
      if(isDefined(self.perksUseSlot[perkName])) {
        useSlot = self.perksUseSlot[perkName];
      }
      self givePerk(perkName, useSlot);
    }
    if(!isDefined(noTransfer) || noTransfer == false) {
      from _unsetPerk(perkName);
    }
  }
}

copy_adrenaline(from) {
  self.adrenaline = undefined;
  self setAdrenaline(from.adrenaline);
  self resetStreakCount();
  self updateStreakCount();
  self updateStreakSlots();
}

is_using_killstreak() {
  curWeap = self GetCurrentWeapon();
  usingKS = IsSubStr(curWeap, "killstreak") || (isDefined(self.selectingLocation) && self.selectingLocation == true) || !(self isWeaponEnabled()) && !(self maps\mp\gametypes\_damage::attackerInRemoteKillstreak());
  return usingKS;
}

monitorDisownKillstreaks() {
  while(isDefined(self)) {
    if(bot_is_fireteam_mode()) {
      self waittill("disconnect");
    } else {
      self waittill_any("disconnect", "joined_team", "joined_spectators");
    }
    self notify("killstreak_disowned");
  }
}

PROJECTILE_TRACE_OBSTRUCTED_THRESHOLD = 0.99;
PROJECTILE_TRACE_YAW_ANGLE_INCREMENT = 30;

findUnobstructedFiringPointAroundZ(player, targetPosition, flightDistance, angleOfAttack) {
  initialVector = RotateVector((0, 0, 1), (-1 * angleOfAttack, 0, 0));

  anglesToPlayer = VectorToAngles(targetPosition - player.origin);
  for(deltaAngle = 0; deltaAngle < 360; deltaAngle += PROJECTILE_TRACE_YAW_ANGLE_INCREMENT) {
    approachVector = flightDistance * RotateVector(initialVector, (0, deltaAngle + anglesToPlayer[1], 0));
    startPosition = targetPosition + approachVector;

    if(_findUnobstructedFiringPointHelper(player, startPosition, targetPosition)) {
      return startPosition;
    }
  }

  return undefined;
}

findUnobstructedFiringPointAroundY(player, targetPosition, flightDistance, minPitch, maxPitch, angleStep) {
  anglesToPlayer = VectorToAngles(player.origin - targetPosition);

  for(deltaAngle = minPitch; deltaAngle <= maxPitch; deltaAngle += angleStep) {
    initialVector = RotateVector((1, 0, 0), (deltaAngle - 90, 0, 0));

    approachVector = flightDistance * RotateVector(initialVector, (0, anglesToPlayer[1], 0));
    startPosition = targetPosition + approachVector;

    if(_findUnobstructedFiringPointHelper(player, startPosition, targetPosition)) {
      return startPosition;
    }
  }

  return undefined;
}

_findUnobstructedFiringPointHelper(player, startPosition, targetPosition) {
  traceResult = bulletTrace(startPosition, targetPosition, false);

  if(traceResult["fraction"] > PROJECTILE_TRACE_OBSTRUCTED_THRESHOLD) {
    return true;
  }

  return false;
}

findUnobstructedFiringPoint(player, targetPosition, flightDistance) {
  result = findUnobstructedFiringPointAroundZ(player, targetPosition, flightDistance, 30);

  if(!isDefined(result)) {
    result = findUnobstructedFiringPointAroundY(player, targetPosition, flightDistance, 15, 75, 15);
  }

  return result;
}

isAirdropMarker(weaponName) {
  switch (weaponName) {
    case "airdrop_marker_mp":
    case "airdrop_marker_assault_mp":
    case "airdrop_marker_support_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_sentry_marker_mp":
    case "airdrop_juggernaut_mp":
    case "airdrop_juggernaut_def_mp":
    case "airdrop_juggernaut_maniac_mp":
    case "airdrop_tank_marker_mp":
    case "airdrop_escort_marker_mp":
      return true;
    default:
      return false;
  }
}

isUsingHeliSniper() {
  return (isDefined(self.OnHeliSniper) && self.OnHeliSniper);
}

destroyTargetArray(attacker, victimTeam, weaponName, targetList) {
  meansOfDeath = "MOD_EXPLOSIVE";

  damage = 5000;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelName = "";
  tagName = "";
  partName = "";
  iDFlags = undefined;

  if(level.teamBased) {
    foreach(target in targetList) {
      if(isValidTeamTarget(attacker, victimTeam, target)) {
        target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weaponName);
        wait(0.05);
      }
    }
  } else {
    foreach(target in targetList) {
      if(isValidFFATarget(attacker, victimTeam, target)) {
        target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weaponName);
        wait(0.05);
      }
    }
  }
}