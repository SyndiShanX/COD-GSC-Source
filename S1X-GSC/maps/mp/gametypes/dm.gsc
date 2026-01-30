/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dm.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerTimeLimitDvar(level.gameType, 10);
    registerScoreLimitDvar(level.gameType, 30);
    registerWinLimitDvar(level.gameType, 1);
    registerRoundLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);
    registerScoreLimitDvar(level.gameType, 30);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onPlayerScore = ::onPlayerScore;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  SetTeamMode("ffa");

  game["dialog"]["gametype"] = "ffa_intro";

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData(true);

  SetDynamicDvar("scr_dm_winlimit", 1);
  registerWinLimitDvar("dm", 1);
  SetDynamicDvar("scr_dm_roundlimit", 1);
  registerRoundLimitDvar("dm", 1);
  SetDynamicDvar("scr_dm_halftime", 0);
  registerHalfTimeDvar("dm", 0);
}

onStartGameType() {
  setClientNameMode("auto_change");

  setObjectiveText("allies", &"OBJECTIVES_DM");
  setObjectiveText("axis", &"OBJECTIVES_DM");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_DM");
    setObjectiveScoreText("axis", &"OBJECTIVES_DM");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_DM_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_DM_SCORE");
  }
  setObjectiveHintText("allies", &"OBJECTIVES_DM_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_DM_HINT");

  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);

  allowed[0] = "dm";
  maps\mp\gametypes\_gameobjects::main(allowed);

  level.QuickMessageToAll = true;
}

getSpawnPoint() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.team);

  if(level.inGracePeriod) {
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
  } else {
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);
  }

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnPoint;
}

onNormalDeath(victim, attacker, lifeId) {
  highestScore = 0;

  foreach(player in level.players) {
    if(isDefined(player.score) && player.score > highestScore) {
      highestScore = player.score;
    }
  }

  if(game["state"] == "postgame" && attacker.score >= highestScore) {
    attacker.finalKill = true;
  }
}

onPlayerScore(event, player, victim) {
  if(isSoringEvent(event)) {
    score = maps\mp\gametypes\_rank::getScoreInfoValue(event);
    player setExtraScore0(player.extrascore0 + score);
    player maps\mp\gametypes\_gamescore::updateScoreStatsFFA(player, score);
    return 1;
  }

  return 0;
}

isSoringEvent(eventName) {
  switch (eventName) {
    case "kill":
    case "warbird_kill":
    case "paladin_kill":
    case "vulcan_kill":
    case "goliath_kill":
    case "airdrop_kill":
    case "airdrop_trap_kill":
    case "missile_strike_kill":
    case "sentry_gun_kill":
    case "strafing_run_kill":
    case "assault_drone_kill":
    case "map_killstreak_kill":
      return true;
  }

  return false;
}