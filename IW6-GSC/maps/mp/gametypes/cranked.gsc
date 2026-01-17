/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\cranked.gsc
*****************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

OP_CRANKED_RESET_TIME = 1000;

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
    registerScoreLimitDvar(level.gameType, 100);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.teamBased = (GetDvarInt("scr_cranked_teambased", 1) == 1);
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onSuicideDeath = ::onSuicideDeath;
  level.onTeamChangeDeath = ::onTeamChangeDeath;

  if(!level.teamBased) {
    level.onPlayerScore = ::onPlayerScore;
    SetDvar("scr_cranked_scorelimit", GetDvarInt("scr_cranked_scorelimit_ffa", 60));
    SetTeamMode("ffa");
  }

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  game["dialog"]["gametype"] = "cranked";

  if(getDvarInt("g_hardcore"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  else if(getDvarInt("camera_thirdPerson"))
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_" + level.gameType + "_promode"))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "crnk_hint";
  game["dialog"]["begin_cranked"] = "crnk_cranked";
  game["dialog"]["five_seconds_left"] = "crnk_det";

  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";

  level thread onPlayerConnect();
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned_player");
  }
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_cranked_roundswitch", 0);
  registerRoundSwitchDvar("cranked", 0, 0, 9);
  SetDynamicDvar("scr_cranked_roundlimit", 1);
  registerRoundLimitDvar("cranked", 1);
  SetDynamicDvar("scr_cranked_winlimit", 1);
  registerWinLimitDvar("cranked", 1);
  SetDynamicDvar("scr_cranked_halftime", 0);
  registerHalfTimeDvar("cranked", 0);

  SetDynamicDvar("scr_cranked_promode", 0);
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

  obj_text = &"OBJECTIVES_WAR";
  obj_score_text = &"OBJECTIVES_WAR_SCORE";
  obj_hint_text = &"OBJECTIVES_WAR_HINT";
  if(!level.teamBased) {
    obj_text = &"OBJECTIVES_DM";
    obj_score_text = &"OBJECTIVES_DM_SCORE";
    obj_hint_text = &"OBJECTIVES_DM_HINT";
  }

  setObjectiveText("allies", obj_text);
  setObjectiveText("axis", obj_text);

  if(level.splitscreen) {
    setObjectiveScoreText("allies", obj_text);
    setObjectiveScoreText("axis", obj_text);
  } else {
    setObjectiveScoreText("allies", obj_score_text);
    setObjectiveScoreText("axis", obj_score_text);
  }

  setObjectiveHintText("allies", obj_hint_text);
  setObjectiveHintText("axis", obj_hint_text);

  initSpawns();

  cranked();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  if(level.teamBased) {
    maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_allies_start");
    maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_axis_start");
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");
  } else {
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");
  }

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  if(level.teamBased) {
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
  } else {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.team);

    if(level.inGracePeriod) {
      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
    } else {
      spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);
    }
  }

  return spawnPoint;
}

onNormalDeath(victim, attacker, lifeId) {
  if(isDefined(victim.cranked) &&
    attacker isEnemy(victim)) {
    attacker maps\mp\gametypes\_missions::processChallenge("ch_cranky");
  }

  victim cleanupCrankedTimer();

  score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
  assert(isDefined(score));

  if(isDefined(attacker.cranked)) {
    if(attacker.cranked_end_time - GetTime() <= OP_CRANKED_RESET_TIME) {
      attacker maps\mp\gametypes\_missions::processChallenge("ch_cranked_reset");
    }

    score *= 2;

    event = "kill_cranked";
    attacker thread onKill(event);

    attacker.pers["killChains"]++;
    attacker maps\mp\gametypes\_persistence::statSetChild("round", "killChains", attacker.pers["killChains"]);
  } else {
    if(isReallyAlive(attacker))
      attacker makeCranked("begin_cranked");
  }

  if(isDefined(victim.attackers) && !isDefined(level.assists_disabled)) {
    foreach(player in victim.attackers) {
      if(!isDefined(_validateAttacker(player))) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      if(victim == player) {
        continue;
      }
      if(!isDefined(player.cranked)) {
        continue;
      }
      player thread onAssist("assist_cranked");
    }
  }

  if(level.teamBased) {
    level maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(attacker.pers["team"], score);

    if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
      attacker.finalKill = true;
  } else {
    highestScore = 0;
    foreach(player in level.players) {
      if(isDefined(player.score) && player.score > highestScore)
        highestScore = player.score;
    }
    if(game["state"] == "postgame" && attacker.score >= highestScore)
      attacker.finalKill = true;
  }
}

onSuicideDeath(victim) {
  victim cleanupCrankedTimer();
}

onTeamChangeDeath(victim) {
  victim cleanupCrankedTimer();
}

cleanupCrankedTimer() {
  self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
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

onPlayerScore(event, player, victim) {
  if(event == "kill") {
    score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
    assert(isDefined(score));

    if(isDefined(player.cranked)) {
      score *= 2;
    }

    return score;
  }

  return 0;
}

cranked() {
  level.crankedBombTimer = 30;

  SetDevDvarIfUninitialized("scr_cranked_bomb_timer", level.crankedBombTimer);
}

makeCranked(event) {
  self leaderDialogOnPlayer(event);
  self thread maps\mp\gametypes\_rank::xpEventPopup(event);
  self setCrankedBombTimer("kill");

  self.cranked = true;

  self givePerk("specialty_fastreload", false);

  self givePerk("specialty_quickdraw", false);

  self givePerk("specialty_fastoffhand", false);

  self givePerk("specialty_fastsprintrecovery", false);

  self givePerk("specialty_marathon", false);

  self givePerk("specialty_quickswap", false);

  self givePerk("specialty_stalker", false);

  self.moveSpeedScaler = 1.2;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

onKill(event) {
  level endon("game_ended");
  selfendon("disconnect");

  while(!isDefined(self.pers))
    wait(0.05);

  self thread maps\mp\gametypes\_rank::xpEventPopup(event);
  maps\mp\gametypes\_gamescore::givePlayerScore(event, self, undefined, true);
  self thread maps\mp\gametypes\_rank::giveRankXP(event);

  self setCrankedBombTimer("kill");
}

onAssist(event) {
  level endon("game_ended");
  selfendon("disconnect");

  self thread maps\mp\gametypes\_rank::xpEventPopup(event);
  self setCrankedBombTimer("assist");
}

watchBombTimer(waitTime) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  countdown_time = 5;
  maps\mp\gametypes\_hostmigration::waitLongDurationWithGameEndTimeUpdate(waitTime - countdown_time - 1);

  self leaderDialogOnPlayer("five_seconds_left");
  maps\mp\gametypes\_hostmigration::waitLongDurationWithGameEndTimeUpdate(1.0);

  self SetClientOmnvar("ui_cranked_bomb_timer_final_seconds", 1);
  while(countdown_time > 0) {
    self PlaySoundToPlayer("mp_cranked_countdown", self);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithGameEndTimeUpdate(1.0);
    countdown_time--;
  }

  if(isDefined(self) && isReallyAlive(self)) {
    self playSound("grenade_explode_metal");
    playFX(level.mine_explode, self.origin + (0, 0, 32));
    self _suicide();
    self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

setCrankedBombTimer(type) {
  waitTime = level.crankedBombTimer;

  if(type == "assist")
    waitTime = int(min(((self.cranked_end_time - GetTime()) / 1000) + (level.crankedBombTimer * 0.5), level.crankedBombTimer));

  waitTime = GetDvarInt("scr_cranked_bomb_timer");

  endTime = (waitTime * 1000) + GetTime();
  self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", endTime);
  self.cranked_end_time = endTime;

  self thread watchCrankedHostMigration();
  self thread watchBombTimer(waitTime);
  self thread watchEndGame();
}

watchCrankedHostMigration() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  level waittill("host_migration_begin");

  timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(self.cranked_end_time + timePassed < 5) {
    self SetClientOmnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(timePassed > 0) {
    self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + timePassed);
  } else {
    self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
  }
}

watchEndGame() {
  self notify("watchEndGame");
  self endon("watchEndGame");

  self endon("death");
  self endon("disconnect");

  while(true) {
    if(game["state"] == "postgame" || level.gameEnded) {
      self SetClientOmnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }
    wait(0.1);
  }
}