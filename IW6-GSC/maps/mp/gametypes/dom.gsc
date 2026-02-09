/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dom.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

CONST_DOM_TRAP_TIME = 40000;
CONST_USE_TIME = 10;

main() {
  if(getDvar("mapname") == "mp_background") {
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
    registerTimeLimitDvar(level.gameType, 30);
    registerScoreLimitDvar(level.gameType, 300);
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
  level.onPlayerKilled = ::onPlayerKilled;
  level.initGametypeAwards = ::initGametypeAwards;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.lastCapTime = GetTime();

  level.alliesCapturing = [];
  level.axisCapturing = [];

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  game["dialog"]["gametype"] = "domination";

  if(getDvarInt("g_hardcore"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  else if(getDvarInt("camera_thirdPerson"))
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getDvarInt("scr_" + level.gameType + "_promode"))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";

  self thread onPlayerConnect();
}

initializeMatchRules() {
  assert(isUsingMatchRulesData());

  setCommonRulesFromMatchRulesData();

  if(GetDvarInt("scr_playlist_type", 0) == 1 || isMLGMatch()) {
    SetDynamicDvar("scr_dom_roundswitch", 1);
    registerRoundSwitchDvar("dom", 1, 0, 1);
    SetDynamicDvar("scr_dom_roundlimit", 2);
    registerRoundLimitDvar("dom", 2);
    SetDynamicDvar("scr_dom_winlimit", 0);
    registerWinLimitDvar("dom", 0);
  } else {
    SetDynamicDvar("scr_dom_roundlimit", 1);
    registerRoundLimitDvar("dom", 1);
    SetDynamicDvar("scr_dom_winlimit", 1);
    registerWinLimitDvar("dom", 1);
  }
  SetDynamicDvar("scr_dom_halftime", 0);
  registerHalfTimeDvar("dom", 0);

  SetDynamicDvar("scr_dom_promode", 0);
}

onStartGameType() {
  setObjectiveText("allies", &"OBJECTIVES_DOM");
  setObjectiveText("axis", &"OBJECTIVES_DOM");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_DOM");
    setObjectiveScoreText("axis", &"OBJECTIVES_DOM");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_DOM_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_DOM_SCORE");
  }
  setObjectiveHintText("allies", &"OBJECTIVES_DOM_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_DOM_HINT");

  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  level.flagBaseFXid["neutral"] = LoadFx("vfx/gameplay/mp/core/vfx_marker_base_grey");
  level.flagBaseFXid["friendly"] = LoadFx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
  level.flagBaseFXid["enemy"] = LoadFx("vfx/gameplay/mp/core/vfx_marker_base_orange");

  initSpawns();

  allowed[0] = "dom";
  maps\mp\gametypes\_gameobjects::main(allowed);

  thread domFlags();
  thread updateDomScores();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_dom_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_dom_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dom_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dom_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnteam = self.pers["team"];
  otherteam = getOtherTeam(spawnTeam);

  if(level.useStartSpawns) {
    if(game["switchedsides"]) {
      spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_dom_spawn_" + otherteam + "_start");
      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
    } else {
      spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_dom_spawn_" + spawnteam + "_start");
      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
    }
  } else {
    teamDomPoints = getTeamDomPoints(spawnteam);
    enemyTeam = getOtherTeam(spawnteam);
    enemyDomPoints = getTeamDomPoints(enemyTeam);
    perferdDomPointArray = getPerferedDomPoints(teamDomPoints, enemyDomPoints);

    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_Domination(spawnPoints, perferdDomPointArray);
  }

  assert(isDefined(spawnpoint));
  return spawnpoint;
}

getTeamDomPoints(team) {
  teamDomPoints = [];

  foreach(domPoint in level.domFlags) {
    if(domPoint.ownerTeam == team) {
      teamDomPoints[teamDomPoints.size] = domPoint;
    }
  }

  return teamDomPoints;
}

getPerferedDomPoints(teamDomPoints, enemyDomPoints) {
  perferdDomPointArray = [];
  perferdDomPointArray[0] = false;
  perferdDomPointArray[1] = false;
  perferdDomPointArray[2] = false;

  self_pers_team = self.pers["team"];
  if(teamDomPoints.size == level.domFlags.size) {
    myTeam = self_pers_team;
    bestFlagPoint = level.bestSpawnFlag[self_pers_team];

    perferdDomPointArray[bestFlagPoint.useObj.domPointNumber] = true;
    return perferdDomPointArray;
  }

  if((teamDomPoints.size == 1) && (enemyDomPoints.size == 2) && !isAnyMLGMatch()) {
    enemyteam = getOtherTeam(self.team);
    scoreDifference = maps\mp\gametypes\_gamescore::_getTeamScore(enemyteam) - maps\mp\gametypes\_gamescore::_getTeamScore(self.team);

    if(scoreDifference > 15) {
      teamTimeSinceCapture = getTimeSinceDomPointCapture(teamDomPoints[0]);
      enemyTimeSinceCaptureFirstPoint = getTimeSinceDomPointCapture(enemyDomPoints[0]);
      enemyTimeSinceCaptureSecondPoint = getTimeSinceDomPointCapture(enemyDomPoints[1]);

      if((teamTimeSinceCapture > CONST_DOM_TRAP_TIME) && (enemyTimeSinceCaptureFirstPoint > CONST_DOM_TRAP_TIME) && (enemyTimeSinceCaptureSecondPoint > CONST_DOM_TRAP_TIME)) {
        return perferdDomPointArray;
      }
    }
  }

  if(teamDomPoints.size > 0) {
    foreach(domPoint in teamDomPoints) {
      perferdDomPointArray[domPoint.domPointNumber] = true;
    }

    return perferdDomPointArray;
  }

  if(teamDomPoints.size == 0) {
    myTeam = self_pers_team;
    bestFlagPoint = level.bestSpawnFlag[myTeam];

    if((enemyDomPoints.size > 0) && (enemyDomPoints.size < level.domFlags.size)) {
      bestFlagPoint = getUnownedFlagNearestStart(myTeam);
      level.bestSpawnFlag[myTeam] = bestFlagPoint;
    }

    perferdDomPointArray[bestFlagPoint.useObj.domPointNumber] = true;
    return perferdDomPointArray;
  }

  return perferdDomPointArray;
}

getTimeSinceDomPointCapture(domPoint) {
  return (getTime() - domPoint.captureTime);
}

domFlags() {
  level.lastStatus["allies"] = 0;
  level.lastStatus["axis"] = 0;

  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";

  game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getTeamFlagModel("allies");
  game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getTeamFlagModel("axis");

  primaryFlags = getEntArray("flag_primary", "targetname");
  secondaryFlags = getEntArray("flag_secondary", "targetname");

  if((primaryFlags.size + secondaryFlags.size) < 2) {
    assertmsg("^1Not enough domination flags found in level!");
    return;
  }

  level.flags = [];
  for(index = 0; index < primaryFlags.size; index++)
    level.flags[level.flags.size] = primaryFlags[index];

  for(index = 0; index < secondaryFlags.size; index++)
    level.flags[level.flags.size] = secondaryFlags[index];

  level.domFlags = [];
  for(index = 0; index < level.flags.size; index++) {
    trigger = level.flags[index];
    if(isDefined(trigger.target)) {
      visuals[0] = getEnt(trigger.target, "targetname");
    } else {
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
    }

    domFlag = maps\mp\gametypes\_gameobjects::createUseObject("neutral", trigger, visuals, (0, 0, 100));
    domFlag maps\mp\gametypes\_gameobjects::allowUse("enemy");
    domFlag maps\mp\gametypes\_gameobjects::setUseTime(CONST_USE_TIME);
    domFlag maps\mp\gametypes\_gameobjects::setUseText(&"MP_SECURING_POSITION");
    label = domFlag maps\mp\gametypes\_gameobjects::getLabel();
    domFlag.label = label;
    domFlag maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defend" + label);
    domFlag maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defend" + label);
    domFlag maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_captureneutral" + label);
    domFlag maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_captureneutral" + label);
    domFlag maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
    domFlag.onUse = ::onUse;
    domFlag.onBeginUse = ::onBeginUse;
    domFlag.onUseUpdate = ::onUseUpdate;
    domFlag.onEndUse = ::onEndUse;
    domFlag.noUseBar = true;
    domFlag.id = "domFlag";
    domFlag.firstCapture = true;

    traceStart = visuals[0].origin + (0, 0, 32);
    traceEnd = visuals[0].origin + (0, 0, -32);
    trace = bulletTrace(traceStart, traceEnd, false, undefined);

    domFlag.baseEffectPos = trace["position"];
    upangles = vectorToAngles(trace["normal"]);
    domFlag.baseeffectforward = anglesToForward(upangles);

    domFlag thread setFlagNeutral();

    level.flags[index].useObj = domFlag;
    domFlag.levelFlag = level.flags[index];

    level.domFlags[level.domFlags.size] = domFlag;
  }

  spawn_axis_start = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_dom_spawn_axis_start");
  spawn_allies_start = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_dom_spawn_allies_start");
  level.startPos["allies"] = spawn_allies_start[0].origin;
  level.startPos["axis"] = spawn_axis_start[0].origin;

  level.bestSpawnFlag = [];
  level.bestSpawnFlag["allies"] = getUnownedFlagNearestStart("allies", undefined);
  level.bestSpawnFlag["axis"] = getUnownedFlagNearestStart("axis", level.bestSpawnFlag["allies"]);

  flagSetup();

  thread domDebug();
}

getUnownedFlagNearestStart(team, excludeFlag) {
  best = undefined;
  bestdistsq = undefined;
  for(i = 0; i < level.flags.size; i++) {
    flag = level.flags[i];

    if(flag getFlagTeam() != "neutral") {
      continue;
    }
    distsq = distanceSquared(flag.origin, level.startPos[team]);
    if((!isDefined(excludeFlag) || flag != excludeFlag) && (!isDefined(best) || distsq < bestdistsq)) {
      bestdistsq = distsq;
      best = flag;
    }
  }
  return best;
}

onBeginUse(player) {
  ownerTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
  self.didStatusNotify = false;

  if(ownerTeam == "neutral") {
    statusDialog("securing" + self.label, player.team);

    if(!self.firstCapture) {
      if(self.curProgress == 0)
        self maps\mp\gametypes\_gameobjects::setUseTime(CONST_USE_TIME / 2);
    }

    return;
  }

  self maps\mp\gametypes\_gameobjects::setUseTime(CONST_USE_TIME);

  if(ownerTeam == "allies") {
    level.alliesCapturing[level.alliesCapturing.size] = self.label;
    otherTeam = "axis";
  } else {
    level.axisCapturing[level.axisCapturing.size] = self.label;
    otherTeam = "allies";
  }
}

onUseUpdate(team, progress, change) {
  ownerTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
  if(progress > 0.05 && change && !self.didStatusNotify) {
    if(ownerTeam == "neutral") {
      statusDialog("securing" + self.label, team);
      self.prevOwnerTeam = getOtherTeam(team);
    } else {
      statusDialog("losing" + self.label, ownerTeam, true);
      statusDialog("securing" + self.label, team);
    }

    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_taking" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_taking" + self.label);
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_losing" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_losing" + self.label);

    self.didStatusNotify = true;
  } else if((progress > 0.49) && change && self.didStatusNotify && (ownerTeam != "neutral")) {
    self thread setFlagNeutral();
    statusDialog("lost" + self.label, ownerTeam, true);
    playSoundOnPlayers("mp_dom_flag_lost", ownerTeam);

    level.lastCapTime = GetTime();
    self thread giveFlagAssistedCapturePoints(self.touchList[team]);
  }
}

giveFlagAssistedCapturePoints(touchlist) {
  level endon("game_ended");

  players_touching = GetArrayKeys(touchList);
  for(index = 0; index < players_touching.size; index++) {
    player = touchList[players_touching[index]].player;

    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player maps\mp\_events::giveObjectivePointStreaks();

    wait(0.05);
  }
}

statusDialog(dialog, team, forceDialog) {
  time = getTime();

  if(getTime() < level.lastStatus[team] + 5000 && (!isDefined(forceDialog) || !forceDialog)) {
    return;
  }
  thread delayedLeaderDialog(dialog, team);
  level.lastStatus[team] = getTime();
}

onEndUse(team, player, success) {
  if(isPlayer(player)) {
    player SetClientOmnvar("ui_dom_securing", 0);
    player.ui_dom_securing = undefined;
  }

  ownerTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
  if(ownerTeam != "neutral") {
    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_capture" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_capture" + self.label);
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defend" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defend" + self.label);
  } else {
    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_captureneutral" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_captureneutral" + self.label);
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_captureneutral" + self.label);
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_captureneutral" + self.label);
  }

  if(team == "allies") {
    array_remove(level.alliesCapturing, self.label);
  } else {
    array_remove(level.axisCapturing, self.label);
  }
}

resetFlagBaseEffect() {
  team = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
  if(team == "neutral") {
    playFlagNeutralFX();
  } else {
    Assert(team == "axis" || team == "allies");
    foreach(player in level.players) {
      showCapturedBaseEffectToPlayer(team, player);
    }
  }
}

onUse(credit_player) {
  team = credit_player.team;
  oldTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();

  self.captureTime = getTime();
  self.firstCapture = false;

  setFlagCaptured(team);

  level.useStartSpawns = false;

  assert(team != "neutral");

  if(oldTeam == "neutral") {
    otherTeam = getOtherTeam(team);
    thread printAndSoundOnEveryone(team, otherTeam, undefined, undefined, "mp_dom_flag_captured", undefined, credit_player);

    if(getTeamFlagCount(team) < level.flags.size) {
      statusDialog("secured" + self.label, team, true);
      statusDialog("enemy_has" + self.label, otherTeam, true);
    } else {
      statusDialog("secure_all", team);
      statusDialog("lost_all", otherTeam);

      foreach(player in level.players) {
        if(player.team == team) {
          player maps\mp\gametypes\_missions::processChallenge("ch_domdom");
        }
      }
    }
  }

  credit_player maps\mp\_events::giveObjectivePointStreaks();
  self thread giveFlagCaptureXP(self.touchList[team]);
}

giveFlagCaptureXP(touchList) {
  level endon("game_ended");

  first_player = self maps\mp\gametypes\_gameobjects::getEarliestClaimPlayer();
  if(isDefined(first_player.owner))
    first_player = first_player.owner;

  level.lastCapTime = GetTime();

  if(isPlayer(first_player)) {
    level thread teamPlayerCardSplash("callout_securedposition" + self.label, first_player);

    first_player thread maps\mp\_matchdata::logGameEvent("capture", first_player.origin);
  }

  players_touching = getArrayKeys(touchList);
  for(index = 0; index < players_touching.size; index++) {
    player = touchList[players_touching[index]].player;
    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player thread maps\mp\gametypes\_hud_message::SplashNotify("capture", maps\mp\gametypes\_rank::getScoreInfoValue("capture"));
    player thread updateCPM();
    player thread maps\mp\gametypes\_rank::giveRankXP("capture", maps\mp\gametypes\_rank::getScoreInfoValue("capture") * player getCapXPScale());

    maps\mp\gametypes\_gamescore::givePlayerScore("capture", player);

    player incPlayerStat("pointscaptured", 1);
    player incPersStat("captures", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "captures", player.pers["captures"]);

    player maps\mp\gametypes\_missions::processChallenge("ch_domcap");

    player setExtraScore0(player.pers["captures"]);

    if(player != first_player)

      player maps\mp\_events::giveObjectivePointStreaks();

    wait(0.05);
  }
}

delayedLeaderDialog(sound, team) {
  level endon("game_ended");
  wait .1;
  WaitTillSlowProcessAllowed();

  leaderDialog(sound, team);
}

updateDomScores() {
  level endon("game_ended");

  while(!level.gameEnded) {
    domFlags = getOwnedDomFlags();

    if(domFlags.size) {
      for(i = 1; i < domFlags.size; i++) {
        domFlag = domFlags[i];
        flagScore = getTime() - domFlag.captureTime;
        for(j = i - 1; j >= 0 && flagScore > (getTime() - domFlags[j].captureTime); j--)
          domFlags[j + 1] = domFlags[j];
        domFlags[j + 1] = domFlag;
      }

      foreach(domFlag in domFlags) {
        team = domFlag maps\mp\gametypes\_gameobjects::getOwnerTeam();
        assert(team == "allies" || team == "axis");
        maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(team, 1);
      }
    }

    timeSinceLastCap = GetTime() - level.lastCapTime;

    if(matchMakingGame() && (domFlags.size < 2) && timeSinceLastCap > 120000) {
      level.finalKillCam_winner = "none";
      thread maps\mp\gametypes\_gamelogic::endGame("none", game["end_reason"]["time_limit_reached"]);
      return;
    }

    wait(5.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  awardedAssault = false;
  awardedDefend = false;

  victim = self;

  foreach(trigger in victim.touchTriggers) {
    if(trigger != level.flags[0] && trigger != level.flags[1] && trigger != level.flags[2]) {
      continue;
    }
    ownerTeam = trigger.useObj.ownerTeam;
    victimTeam = victim.team;

    if(ownerTeam == "neutral") {
      continue;
    }
    if(victimTeam == ownerTeam) {
      awardedAssault = true;
      attacker thread maps\mp\gametypes\_hud_message::SplashNotify("assault", maps\mp\gametypes\_rank::getScoreInfoValue("assault"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("assault");
      maps\mp\gametypes\_gamescore::givePlayerScore("assault", attacker);

      thread maps\mp\_matchdata::logKillEvent(killId, "defending");
    } else {
      awardedDefend = true;
      attacker thread maps\mp\gametypes\_hud_message::SplashNotify("defend", maps\mp\gametypes\_rank::getScoreInfoValue("defend"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("defend");
      maps\mp\gametypes\_gamescore::givePlayerScore("defend", attacker);

      attacker incPersStat("defends", 1);
      attacker maps\mp\gametypes\_persistence::statSetChild("round", "defends", attacker.pers["defends"]);

      attacker maps\mp\gametypes\_missions::processChallenge("ch_domprotector");

      thread maps\mp\_matchdata::logKillEvent(killId, "assaulting");
    }
  }

  foreach(trigger in attacker.touchTriggers) {
    if(trigger != level.flags[0] && trigger != level.flags[1] && trigger != level.flags[2]) {
      continue;
    }
    ownerTeam = trigger.useObj.ownerTeam;
    attackerTeam = attacker.team;

    if(ownerTeam == "neutral") {
      continue;
    }
    if(attackerTeam != ownerTeam) {
      if(!awardedAssault)
        attacker thread maps\mp\gametypes\_hud_message::SplashNotify("assault", maps\mp\gametypes\_rank::getScoreInfoValue("assault"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("assault");
      maps\mp\gametypes\_gamescore::givePlayerScore("assault", attacker);

      thread maps\mp\_matchdata::logKillEvent(killId, "defending");
    }
  }

  foreach(trigger in level.flags) {
    ownerTeam = trigger.useObj.ownerTeam;
    attackerTeam = attacker.team;

    victimDistanceToFlag = DistanceSquared(trigger.origin, victim.origin);
    defendDistance = 300 * 300;

    if(attackerTeam == ownerTeam && victimDistanceToFlag < defendDistance) {
      if(!awardedDefend)
        attacker thread maps\mp\gametypes\_hud_message::SplashNotify("defend", maps\mp\gametypes\_rank::getScoreInfoValue("defend"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("defend");
      maps\mp\gametypes\_gamescore::givePlayerScore("defend", attacker);

      attacker incPersStat("defends", 1);
      attacker maps\mp\gametypes\_persistence::statSetChild("round", "defends", attacker.pers["defends"]);

      thread maps\mp\_matchdata::logKillEvent(killId, "assaulting");
    }
  }
}

getOwnedDomFlags() {
  domFlags = [];
  foreach(domFlag in level.domFlags) {
    if(domFlag maps\mp\gametypes\_gameobjects::getOwnerTeam() != "neutral" && isDefined(domFlag.captureTime))
      domFlags[domFlags.size] = domFlag;
  }

  return domFlags;
}

getTeamFlagCount(team) {
  score = 0;
  for(i = 0; i < level.flags.size; i++) {
    if(level.domFlags[i] maps\mp\gametypes\_gameobjects::getOwnerTeam() == team)
      score++;
  }
  return score;
}

getFlagTeam() {
  return self.useObj maps\mp\gametypes\_gameobjects::getOwnerTeam();
}

flagSetup() {
  setDevDvarIfUninitialized("scr_domdebug", "0");

  foreach(domPoint in level.domFlags) {
    switch (domPoint.label) {
      case "_a":
        domPoint.domPointNumber = 0;
        break;
      case "_b":
        domPoint.domPointNumber = 1;
        break;
      case "_c":
        domPoint.domPointNumber = 2;
        break;
    }
  }

  spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_dom_spawn");

  foreach(spawnPoint in spawnPoints) {
    spawnPoint.domPointA = false;
    spawnPoint.domPointB = false;
    spawnPoint.domPointC = false;

    spawnPoint.nearFlagPoint = getNearestFlagPoint(spawnPoint);

    switch (spawnPoint.nearFlagPoint.useObj.domPointNumber) {
      case 0:
        spawnPoint.domPointA = true;
        break;
      case 1:
        spawnPoint.domPointB = true;
        break;
      case 2:
        spawnPoint.domPointC = true;
        break;
    }
  }
}

getNearestFlagPoint(spawnPoint) {
  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();
  nearestDomPoint = undefined;
  nearestDist = undefined;

  foreach(domPoint in level.domFlags) {
    dist = undefined;

    if(isPathDataAvailable) {
      dist = GetPathDist(spawnPoint.origin, domPoint.levelflag.origin, 999999);
    }

    if(!isDefined(dist) || (dist == -1)) {
      dist = distancesquared(domPoint.levelflag.origin, spawnPoint.origin);
    }

    if(!isDefined(nearestDomPoint) || dist < nearestDist) {
      nearestDomPoint = domPoint;
      nearestDist = dist;
    }
  }

  return nearestDomPoint.levelflag;
}

domDebug() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");
  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();
  heightOffsetLines = (0, 0, 12);
  heightOffsetNames = (0, 0, 64);

  while(true) {
    if(getDvar("scr_domdebug") != "1") {
      wait(1);
      continue;
    }

    SetDevDvar("scr_showspawns", "1");

    while(true) {
      if(getDvar("scr_domdebug") != "1") {
        SetDevDvar("scr_showspawns", "0");
        break;
      }

      foreach(spawnPoint in spawnPoints) {
        if(isPathDataAvailable) {
          if(!isDefined(spawnPoint.nodeArray)) {
            spawnPoint.nodeArray = GetNodesOnPath(spawnPoint.origin, spawnPoint.nearFlagPoint.origin);
          }

          if(!isDefined(spawnPoint.nodeArray) || (spawnPoint.nodeArray.size == 0)) {
            continue;
          }

          line(spawnPoint.origin + heightOffsetLines, spawnPoint.nodeArray[0].origin + heightOffsetLines, (0.2, 0.2, 0.6));

          for(i = 0; i < spawnPoint.nodeArray.size - 1; i++) {
            line(spawnPoint.nodeArray[i].origin + heightOffsetLines, spawnPoint.nodeArray[i + 1].origin + heightOffsetLines, (0.2, 0.2, 0.6));
          }
        } else {
          line(spawnPoint.nearFlagPoint.origin + heightOffsetLines, spawnPoint.origin + heightOffsetLines, (0.2, 0.2, 0.6));
        }
      }

      foreach(flagLocation in level.flags) {
        if(flagLocation == level.bestSpawnFlag["allies"])
          print3d(flagLocation.origin + heightOffsetNames, "allies best spawn flag");

        if(flagLocation == level.bestSpawnFlag["axis"])
          print3d(flagLocation.origin + heightOffsetNames, "axis best spawn flag");
      }

      wait(0.05);
    }
  }
}

initGametypeAwards() {
  maps\mp\_awards::initStatAward("pointscaptured", 0, maps\mp\_awards::highestWins);
}

onSpawnPlayer() {
  self setExtraScore0(0);
  if(isDefined(self.pers["captures"]))
    self setExtraScore0(self.pers["captures"]);
}

updateCPM() {
  if(!isDefined(self.CPM)) {
    self.numCaps = 0;
    self.CPM = 0;
  }

  self.numCaps++;

  if(getMinutesPassed() < 1) {
    return;
  }
  self.CPM = self.numCaps / getMinutesPassed();
}

getCapXPScale() {
  if(self.CPM < 4)
    return 1;
  else
    return 0.25;
}

setFlagNeutral() {
  self notify("flag_neutral");

  self maps\mp\gametypes\_gameobjects::setOwnerTeam("neutral");
  self.visuals[0] setModel(game["flagmodels"]["neutral"]);

  foreach(player in level.players) {
    effect = player._domFlagEffect[self.label];
    if(isDefined(effect)) {
      effect Delete();
    }
  }

  playFlagNeutralFX();
}

playFlagNeutralFX() {
  if(isDefined(self.neutralFlagFx))
    self.neutralFlagFx Delete();
  self.neutralFlagFx = SpawnFx(level.flagBaseFXid["neutral"], self.baseEffectPos, self.baseEffectForward);
  TriggerFX(self.neutralFlagFx);
}

setFlagCaptured(team) {
  label = self maps\mp\gametypes\_gameobjects::getLabel();
  self maps\mp\gametypes\_gameobjects::setOwnerTeam(team);
  self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_capture" + label);
  self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_capture" + label);
  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defend" + self.label);
  self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defend" + self.label);
  self.visuals[0] setModel(game["flagmodels"][team]);

  self.neutralFlagFx Delete();

  foreach(player in level.players) {
    self showCapturedBaseEffectToPlayer(team, player);
  }

  self thread baseEffectsWaitForJoined();
}

showCapturedBaseEffectToPlayer(team, player) {
  if(isDefined(player._domFlagEffect[self.label]))
    player._domFlagEffect[self.label] Delete();

  effect = undefined;

  viewerTeam = player.team;
  isMLG = player isMLGSpectator();
  if(isMLG)
    viewerTeam = player GetMLGSpectatorTeam();
  else if(viewerTeam == "spectator")
    viewerTeam = "allies";

  if(viewerTeam == team) {
    effect = SpawnFXForClient(level.flagBaseFXid["friendly"], self.baseEffectPos, player, self.baseEffectForward);
  } else {
    effect = SpawnFXForClient(level.flagBaseFXid["enemy"], self.baseEffectPos, player, self.baseEffectForward);
  }

  player._domFlagEffect[self.label] = effect;
  TriggerFX(effect);
}

baseEffectsWaitForJoined() {
  level endon("game_ended");
  self endon("flag_neutral");

  while(true) {
    level waittill("joined_team", player);

    if(isDefined(player._domFlagEffect[self.label])) {
      player._domFlagEffect[self.label] Delete();
      player._domFlagEffect[self.label] = undefined;
    }

    if(player.team != "spectator") {
      self showCapturedBaseEffectToPlayer(self.ownerTeam, player);
    }
  }
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player._domFlagEffect = [];

    player thread onDisconnect();
    player thread refreshFreecamBaseFX();
  }
}

onDisconnect() {
  self waittill("disconnect");

  foreach(effect in self._domFlagEffect) {
    if(isDefined(effect))
      effect Delete();
  }
}

refreshFreecamBaseFX() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", channel, view);
    if(channel == "mlg_view_change") {
      foreach(domFlag in level.domFlags) {
        if(domFlag.ownerTeam != "neutral") {
          domFlag showCapturedBaseEffectToPlayer(domFlag.ownerTeam, self);
        }
      }
    }
  }
}