/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_reinforcements.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

REINFORCEMENT_TYPE_NONE = 0;
REINFORCEMENT_TYPE_COMMON = 1;
REINFORCEMENT_TYPE_UNCOMMON = 2;
REINFORCEMENT_TYPE_RARE = 3;
REINFORCEMENT_TYPE_PRACTICE = 4;

init() {
  SetDvarIfUninitialized("scr_force_reinforcements", 0);

  if(GetDvarInt("scr_isGamescom") == 1) {
    SetDvarIfUninitialized("scr_force_reinforcements_randomly", 0);
  } else {
    SetDvarIfUninitialized("scr_force_reinforcements_randomly", 1);
  }

  if(level.rankedMatch) {
    level thread onPlayerConnect();
  }
}

onPlayerConnect() {
  level endon("game_ended");

  level waittill("prematch_over");
  waitframe();

  foreach(player in level.players) {
    if(IsBot(player)) {
      continue;
    }

    player resetReinforcements();
    player thread checkForReinforcements();
  }

  while(true) {
    level waittill("connected", player);
    if(IsBot(player)) {
      continue;
    }

    player resetReinforcements();
    player thread checkForReinforcements();
  }
}

resetReinforcements() {
  self SetClientOmnvar("ui_reinforcement_timer_type", 0);
  self SetClientOmnvar("ui_reinforcement_timer", 0);
}

storePendingReinforcement(type) {
  self.pers["reinforcements"] = spawnStruct();
  self.pers["reinforcements"].type = type;
  self.pers["reinforcements"].startTimePassed = getGameTimePassedMS();
}

cancelPendingReinforcement() {
  self.pers["reinforcements"].type = 0;
}

pendingReinforcementAvailable() {
  return isDefined(self.pers["reinforcements"]);
}

checkForReinforcements() {
  self endon("disconnect");
  level endon("game_ended");

  if(!allowClassChoice()) {
    return;
  }

  if(self.health <= 0) {
    self waittill("spawned_player");
  }

  if(self pendingReinforcementAvailable()) {
    self thread continueReinforcements();
    return;
  }

  typeAvailable = REINFORCEMENT_TYPE_NONE;

  if(practiceRoundGame()) {
    typeAvailable = REINFORCEMENT_TYPE_PRACTICE;
  } else {
    typeAvailable = self ConsumeReinforcement();

    if(GetDvarInt("scr_force_reinforcements_randomly", 0) > 0) {
      i = RandomInt(100);

      if(i < 75) {
        typeAvailable = 0;
      } else if(i < 90) {
        typeAvailable = 1;
      } else if(i < 98) {
        typeAvailable = 2;
      } else if(i < 100) {
        typeAvailable = 3;
      }

    }

    if(GetDvarInt("scr_force_reinforcements", 0) > 0) {
      typeAvailable = GetDvarInt("scr_force_reinforcements", 0);
    }

    SetDvar("scr_force_reinforcements_randomly", 0);
    SetDvar("src_force_reinforcements", 0);
  }

  storePendingReinforcement(typeAvailable);

  if(typeAvailable == REINFORCEMENT_TYPE_NONE) {
    return;
  }

  timeToReinforcementMS = getTimeToReinforcementForTypeMS(typeAvailable);
  matchTimeRemainingMS = getTimeRemainingIncludingRounds();

  if(matchTimeRemainingMS < timeToReinforcementMS) {
    cancelPendingReinforcement();
    return;
  }

  self thread waitForReinforcementOfType(typeAvailable, timeToReinforcementMS);
}

continueReinforcements() {
  typeAvailable = self.pers["reinforcements"].type;
  if(typeAvailable == REINFORCEMENT_TYPE_NONE) {
    return;
  }

  timeToReinforcementMS = getTimeToReinforcementForTypeMS(typeAvailable);
  matchTimeElapsedMS = getGameTimePassedMS();
  startTimeElapsedMS = self.pers["reinforcements"].startTimePassed;

  timeToReinforcementMS -= matchTimeElapsedMS;
  timeToReinforcementMS += startTimeElapsedMS;

  self thread waitForReinforcementOfType(typeAvailable, timeToReinforcementMS);
}

getTimeRemainingIncludingRounds() {
  if(isRoundBased()) {
    numRoundsToWin = getScoreLimit();
    minRoundsRemaining = min(numRoundsToWin - getRoundsWon("allies"), numRoundsToWin - getRoundsWon("axis"));
    timeLimitMin = getTimeLimit() * minRoundsRemaining;
    return (timeLimitMin * 60 * 1000) - getTimePassed();
  } else {
    return maps\mp\gametypes\_gamelogic::getTimeRemaining();
  }
}

getTimeToReinforcementForTypeMS(type) {
  switch (type) {
    case REINFORCEMENT_TYPE_COMMON:
      return 2 * 60 * 1000;
    case REINFORCEMENT_TYPE_UNCOMMON:
      return 4 * 60 * 1000;
    case REINFORCEMENT_TYPE_RARE:
      return 6 * 60 * 1000;
    case REINFORCEMENT_TYPE_PRACTICE:
      return 1 * 60 * 1000;
    default:
      AssertMsg("getTimeToReinforcementForType(): Unhandled reinforcement type: " + type);
      break;
  }

  return 0;
}

getIconTypeForReinforcementOfType(type) {
  switch (type) {
    case REINFORCEMENT_TYPE_COMMON:
      return 1;
    case REINFORCEMENT_TYPE_UNCOMMON:
      return 2;
    case REINFORCEMENT_TYPE_RARE:
      return 3;
    case REINFORCEMENT_TYPE_PRACTICE:
      return 1;
    default:
      AssertMsg("getIconTypeForReinforcementOfType(): Unhandled reinforcement type: " + type);
      break;
  }

  return 0;
}

getCarePackageStreakForReinforcementOfType(type) {
  switch (type) {
    case REINFORCEMENT_TYPE_COMMON:
      return "airdrop_reinforcement_common";
    case REINFORCEMENT_TYPE_UNCOMMON:
      return "airdrop_reinforcement_uncommon";
    case REINFORCEMENT_TYPE_RARE:
      return "airdrop_reinforcement_rare";
    case REINFORCEMENT_TYPE_PRACTICE:
      return "airdrop_reinforcement_practice";
    default:
      AssertMsg("getCarePackageStreakForReinforcementOfType(): Unhandled reinforcement type: " + type);
      break;
  }

  return "";
}

waitForReinforcementOfType(type, timeMS) {
  self endon("disconnect");
  level endon("game_ended");

  Assert(type != REINFORCEMENT_TYPE_NONE);

  iconType = getIconTypeForReinforcementOfType(type);

  self SetClientOmnvar("ui_reinforcement_timer_type", iconType);
  self SetClientOmnvar("ui_reinforcement_timer", (GetTime() + timeMS));

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeMS / 1000.0);

  self SetClientOmnvar("ui_reinforcement_timer_type", 0);
  self SetClientOmnvar("ui_reinforcement_timer", 0);

  giveReinforcementOfType(type);
}

giveReinforcementOfType(type) {
  if(!IsPlayer(self)) {
    return;
  }

  streakName = getCarePackageStreakForReinforcementOfType(type);
  streakVal = 500;

  slotIndex = self maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex(streakName);
  self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal, undefined, undefined, slotIndex);
  self maps\mp\killstreaks\_killstreaks::giveKillstreak(streakName);

  cancelPendingReinforcement();
}