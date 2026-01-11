/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dm.gsc
*****************************************************/

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

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onNormalDeath = ::onNormalDeath;
  level.onPlayerScore = ::onPlayerScore;

  level.assists_disabled = true;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  SetTeamMode("ffa");

  game["dialog"]["gametype"] = "freeforall";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("scr_" + level.gameType + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
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
    spawnPoint = maps\mp\gametypes\_spawnscoring::getStartSpawnpoint_FreeForAll(spawnPoints);
  } else {
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);
  }

  return spawnPoint;
}

onSpawnPlayer() {
  level notify("spawned_player");

  if(!isDefined(self.eventValue)) {
    self.eventValue = maps\mp\gametypes\_rank::getScoreInfoValue("kill");
    self setExtraScore0(self.eventValue);
  }
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
  player.assists = player getPersStat("longestStreak");

  if(event == "kill") {
    score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
    assert(isDefined(score));

    return score;
  }

  return 0;
}