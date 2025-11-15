/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\war.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 10);
    registerScoreLimitDvar(level.gameType, 75);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.teamBased = true;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  game["dialog"]["gametype"] = "tm_death";

  if(getDvarInt("g_hardcore"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  else if(getDvarInt("camera_thirdPerson"))
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_" + level.gameType + "_promode"))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["strings"]["overtime_hint"] = & "MP_FIRST_BLOOD";
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_war_roundswitch", 0);
  registerRoundSwitchDvar("war", 0, 0, 9);
  SetDynamicDvar("scr_war_roundlimit", 1);
  registerRoundLimitDvar("war", 1);
  SetDynamicDvar("scr_war_winlimit", 1);
  registerWinLimitDvar("war", 1);
  SetDynamicDvar("scr_war_halftime", 0);
  registerHalfTimeDvar("war", 0);

  SetDynamicDvar("scr_war_promode", 0);
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  if(game["switchedsides"]) {
    oldAttackers = game["attackers"];
    oldDefenders = game["defenders"];
    game["attackers"] = oldDefenders;
    game["defenders"] = oldAttackers;
  }

  setObjectiveText("allies", & "OBJECTIVES_WAR");
  setObjectiveText("axis", & "OBJECTIVES_WAR");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", & "OBJECTIVES_WAR");
    setObjectiveScoreText("axis", & "OBJECTIVES_WAR");
  } else {
    setObjectiveScoreText("allies", & "OBJECTIVES_WAR_SCORE");
    setObjectiveScoreText("axis", & "OBJECTIVES_WAR_SCORE");
  }

  setObjectiveHintText("allies", & "OBJECTIVES_WAR_HINT");
  setObjectiveHintText("axis", & "OBJECTIVES_WAR_HINT");

  initSpawns();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnteam = self.pers["team"];
  if(game["switchedsides"])
    spawnteam = getOtherTeam(spawnteam);

  if(maps\mp\gametypes\_spawnlogic::shouldUseTeamStartspawn()) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
  } else {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_NearTeam(spawnPoints);
  }

  return spawnPoint;
}

onNormalDeath(victim, attacker, lifeId) {
  score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
  assert(isDefined(score));

  level maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(attacker.pers["team"], score);

  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
    attacker.finalKill = true;
}

onTimeLimit() {
  level.finalKillCam_winner = "none";
  if(game["status"] == "overtime") {
    winner = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    winner = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level.finalKillCam_winner = "axis";
    winner = "axis";
  } else {
    level.finalKillCam_winner = "allies";
    winner = "allies";
  }

  thread maps\mp\gametypes\_gamelogic::endGame(winner, game["end_reason"]["time_limit_reached"]);
}