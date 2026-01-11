/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_highvaluetarget.gsc
****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_hostmigration;

CONST_XP_INCREASE = 0.5;
CONST_MIN_MULTIPLIER = 1;
CONST_MAX_MULTIPLIER = 4;

CONST_MAX_ACTIVE_HVT_PER_GAME = 4;
CONST_MAX_ACTIVE_HVT_PER_PLAYER = 2;

CONST_HVT_TIMEOUT = 10;

init() {
  level.killstreakFuncs["high_value_target"] = ::tryUseHighValueTarget;

  level.hvts_active["axis"] = 0;
  level.hvts_active["allies"] = 0;

  game["dialog"]["hvt_gone"] = "hvt_gone";
}

tryUseHighValueTarget(lifeId, streakName) {
  return useHighValueTarget(self, lifeId);
}

reached_max_xp_multiplier() {
  if(level.teamBased) {
    return (level.hvts_active[self.team] >= CONST_MAX_ACTIVE_HVT_PER_GAME);
  }
  else if(isDefined(self.hvts_active)) {
    return (self.hvts_active >= CONST_MAX_ACTIVE_HVT_PER_PLAYER);
  }

  return false;
}

useHighValueTarget(player, lifeId) {
  if(!isReallyAlive(player)) {
    return false;
  }

  if(player.team == "spectator") {
    return false;
  }

  if(reached_max_xp_multiplier() {
    ||
  }
    (isDefined(player.hvts_active) && player.hvts_active >= CONST_MAX_ACTIVE_HVT_PER_PLAYER)
  ) {
    self iPrintLnBold(&"KILLSTREAKS_HVT_MAX");
    return false;
  }

  player thread setHighValueTarget();

  level thread teamPlayerCardSplash("used_hvt", player, player.team);

  return true;
}

setHighValueTarget() {
  level endon("game_ended");
  self endon("disconnect");

  team = self.team;

  self increaseXPBoost();
  self thread watchHVTOwner(team);

  waitLongDurationWithHostMigrationPause(CONST_HVT_TIMEOUT);

  if(level.teamBased) {
    leaderDialog("hvt_gone", team);
  }
  else {
    self leaderDialogOnPlayer("hvt_gone");
  }

  if(level.teamBased) {
    level decreaseXPBoost(team);
  }
  else {
    self decreaseXPBoost();
  }
}

increaseXPBoost() {
  hvts_active = 0;
  if(level.teamBased) {
    level.hvts_active[self.team]++;
    hvts_active = level.hvts_active[self.team];
    array_index = self.team;
  } else {
    if(!isDefined(self.hvts_active)) {
      self.hvts_active = 1;
    }
    else {
      self.hvts_active++;
    }

    hvts_active = self.hvts_active;
    array_index = self GetEntityNumber();
  }

  bonus = CONST_MIN_MULTIPLIER + hvts_active * CONST_XP_INCREASE;
  level.teamXPScale[array_index] = clamp(bonus, CONST_MIN_MULTIPLIER, CONST_MAX_MULTIPLIER);
}

decreaseXPBoost(team) {
  hvts_active = 0;
  if(level.teamBased) {
    if(level.hvts_active[team] > 0) {
      level.hvts_active[team]--;
    }
    hvts_active = level.hvts_active[team];
    array_index = team;
  } else {
    if(self.hvts_active > 0) {
      self.hvts_active--;
    }

    hvts_active = self.hvts_active;
    array_index = self GetEntityNumber();
  }

  bonus = CONST_MIN_MULTIPLIER + hvts_active * CONST_XP_INCREASE;
  level.teamXPScale[array_index] = clamp(bonus, CONST_MIN_MULTIPLIER, CONST_MAX_MULTIPLIER);
}

watchHVTOwner(team) {
  level endon("game_ended");

  result = self waittill_any_return("disconnect", "joined_team", "joined_spectators");

  if(level.teamBased) {
    level decreaseXPBoost(team);
  }
  else if(isDefined(self) && result != "disconnect") {
    self decreaseXPBoost();
  }
}