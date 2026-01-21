/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\siege.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\agents\_agent_utility;

CONST_FRIENDLY_TAG_MODEL = "prop_dogtags_friend_iw6";
CONST_ENEMY_TAG_MODEL = "prop_dogtags_foe_iw6";

OP_HELPME_NUM_TEAMMATES = 4;

CONST_DOM_TRAP_TIME = 40000;
CONST_USE_TIME = 10;

CONST_MAX_FLAGPOS_COL = 10;

main() {
  if(GetDvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(IsUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 3, 0, 9);
    registerTimeLimitDvar(level.gameType, 5);
    registerScoreLimitDvar(level.gameType, 1);
    registerRoundLimitDvar(level.gameType, 0);
    registerWinLimitDvar(level.gameType, 4);
    registerNumLivesDvar(level.gameType, 1);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.objectiveBased = true;
  level.teamBased = true;
  level.noBuddySpawns = true;
  level.gameHasStarted = false;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onPlayerKilled = ::onPlayerKilled;
  level.onDeadEvent = ::onDeadEvent;
  level.onOneLeftEvent = ::onOneLeftEvent;
  level.onTimeLimit = ::onTimeLimit;
  level.initGametypeAwards = ::initGametypeAwards;

  level.lastCapTime = GetTime();
  level.alliesPrevFlagCount = 0;
  level.axisPrevFlagCount = 0;
  level.allowLateComers = false;
  level.gameTimerBeeps = false;

  level.siegeFlagCapturing = [];

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";

  game["dialog"]["revived"] = "sr_rev";

  self thread onPlayerConnect();
  self thread onPlayerSwitchTeam();
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  roundLength = GetMatchRulesData("siegeData", "roundLength");
  SetDynamicDvar("scr_siege_timelimit", roundLength);
  registerTimeLimitDvar("siege", roundLength);

  roundSwitch = GetMatchRulesData("siegeData", "roundSwitch");
  SetDynamicDvar("scr_siege_roundswitch", roundSwitch);
  registerRoundSwitchDvar("siege", roundSwitch, 0, 9);

  winLimit = GetMatchRulesData("commonOption", "scoreLimit");
  SetDynamicDvar("scr_siege_winlimit", winLimit);
  registerWinLimitDvar("siege", winLimit);

  capRate = GetMatchRulesData("siegeData", "capRate");
  SetDynamicDvar("scr_siege_caprate", capRate);

  rushTimer = GetMatchRulesData("siegeData", "rushTimer");
  SetDynamicDvar("scr_siege_rushtimer", rushTimer);

  rushTimerAmount = GetMatchRulesData("siegeData", "rushTimerAmount");
  SetDynamicDvar("scr_siege_rushtimeramount", rushTimerAmount);

  preCapPoints = GetMatchRulesData("siegeData", "preCapPoints");
  SetDynamicDvar("scr_siege_precap", preCapPoints);

  SetDynamicDvar("scr_siege_roundlimit", 0);
  registerRoundLimitDvar("siege", 0);
  SetDynamicDvar("scr_siege_scorelimit", 1);
  registerScoreLimitDvar("siege", 1);
  SetDynamicDvar("scr_siege_halftime", 0);
  registerHalfTimeDvar("siege", 0);

  SetDynamicDvar("scr_siege_promode", 0);
}

onStartGameType() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  if(game["switchedsides"]) {
    oldAttackers = game["attackers"];
    oldDefenders = game["defenders"];
    game["attackers"] = oldDefenders;
    game["defenders"] = oldAttackers;
  }

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

  initSpawns();

  allowed[0] = "dom";
  maps\mp\gametypes\_gameobjects::main(allowed);

  level.flagBaseFXid["neutral"] = LoadFX("vfx/gameplay/mp/core/vfx_marker_base_grey");
  level.flagBaseFXid["friendly"] = LoadFX("vfx/gameplay/mp/core/vfx_marker_base_cyan");
  level.flagBaseFXid["enemy"] = LoadFX("vfx/gameplay/mp/core/vfx_marker_base_orange");

  thread domFlags();
  thread watchFlagTimerPause();
  thread watchFlagTimerReset();
  thread watchFlagEndUse();
  thread watchGameInactive();
  thread watchGameStart();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_dom_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_dom_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dom_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dom_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  SetMapCenter(level.mapCenter);
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

  Assert(isDefined(spawnpoint));
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
      bestFlagPoint = getUnownedFlagNearestStart(myTeam, undefined);
      level.bestSpawnFlag[myTeam] = bestFlagPoint;
    }

    perferdDomPointArray[bestFlagPoint.useObj.domPointNumber] = true;
    return perferdDomPointArray;
  }

  return perferdDomPointArray;
}

getTimeSinceDomPointCapture(domPoint) {
  return (GetTime() - domPoint.captureTime);
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player._domFlagEffect = [];

    player thread onPlayerDisconnect();
    player thread refreshFreecamBaseFX();

    player.siegeLateComer = true;
  }
}

onPlayerSwitchTeam() {
  level endon("game_ended");

  while(true) {
    level waittill("joined_team", player);

    if(gameHasStarted())
      player.siegeLateComer = true;
  }
}

onSpawnPlayer() {
  self setExtraScore0(0);
  if(isDefined(self.pers["captures"]))
    self setExtraScore0(self.pers["captures"]);

  level notify("spawned_player");
}

onPlayerDisconnect() {
  self waittill("disconnect");

  foreach(effect in self._domFlagEffect) {
    if(isDefined(effect))
      effect Delete();
  }
}

checkAllowSpectating() {
  wait(0.05);

  update = false;
  if(!level.aliveCount[game["attackers"]]) {
    level.spectateOverride[game["attackers"]].allowEnemySpectate = 1;
    update = true;
  }
  if(!level.aliveCount[game["defenders"]]) {
    level.spectateOverride[game["defenders"]].allowEnemySpectate = 1;
    update = true;
  }
  if(update)
    maps\mp\gametypes\_spectating::updateSpectateSettings();
}

initGametypeAwards() {
  maps\mp\_awards::initStatAward("pointscaptured", 0, maps\mp\_awards::highestWins);
}

updateGameTypeDvars() {}

domFlags() {
  level endon("game_ended");

  level.lastStatus["allies"] = 0;
  level.lastStatus["axis"] = 0;

  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";

  game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getTeamFlagModel("allies");
  game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getTeamFlagModel("axis");

  primaryFlags = getEntArray("flag_primary", "targetname");
  secondaryFlags = getEntArray("flag_secondary", "targetname");

  if((primaryFlags.size + secondaryFlags.size) < 2) {
    AssertMsg("^1Not enough domination flags found in level!");
    return;
  }

  level.flags = [];

  filename = "mp/siegeFlagPos.csv";
  currentMap = getMapName();
  searchCol = 1;

  for(returnCol = 2; returnCol < CONST_MAX_FLAGPOS_COL + 1; returnCol++) {
    returnValue = TableLookup(filename, searchCol, currentMap, returnCol);

    if(returnValue != "")
      setFlagPositions(returnCol, Float(returnValue));
  }

  for(index = 0; index < primaryFlags.size; index++)
    level.flags[level.flags.size] = primaryFlags[index];

  for(index = 0; index < secondaryFlags.size; index++)
    level.flags[level.flags.size] = secondaryFlags[index];

  level.domFlags = [];
  for(index = 0; index < level.flags.size; index++) {
    trigger = level.flags[index];

    trigger.origin = getFlagPos(trigger.script_label, trigger.origin);

    if(isDefined(trigger.target)) {
      visuals[0] = GetEnt(trigger.target, "targetname");
    } else {
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
    }

    domFlag = maps\mp\gametypes\_gameobjects::createUseObject("neutral", trigger, visuals, (0, 0, 100));
    domFlag maps\mp\gametypes\_gameobjects::allowUse("enemy");
    domFlag maps\mp\gametypes\_gameobjects::setUseTime(GetDvarFloat("scr_siege_caprate"));

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
    domFlag.prevTeam = "neutral";
    domFlag.flagCapSuccess = false;

    traceStart = visuals[0].origin + (0, 0, 32);
    traceEnd = visuals[0].origin + (0, 0, -32);
    trace = bulletTrace(traceStart, traceEnd, false, undefined);

    domFlag.baseEffectPos = trace["position"];
    upangles = VectorToAngles(trace["normal"]);
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

  if(GetDvarInt("scr_siege_precap")) {
    storeCenterFlag();

    excludedFlags = [];
    excludedFlags[excludedFlags.size] = level.centerFlag;

    if(game["switchedsides"]) {
      level.closestAlliesFlag = getUnownedFlagNearestStart("axis", level.centerFlag);
      excludedFlags[excludedFlags.size] = level.closestAlliesFlag;

      level.closestAxisFlag = getUnownedFlagNearestStart("allies", excludedFlags);
    } else {
      level.closestAlliesFlag = getUnownedFlagNearestStart("allies", level.centerFlag);
      excludedFlags[excludedFlags.size] = level.closestAlliesFlag;

      level.closestAxisFlag = getUnownedFlagNearestStart("axis", excludedFlags);
    }

    level.closestAlliesFlag.useobj setFlagCaptured("allies", "neutral", undefined, true);
    level.closestAxisFlag.useobj setFlagCaptured("axis", "neutral", undefined, true);
  }

  flagSetup();
}

setFlagPositions(col, posValue) {
  switch (col) {
    case 2:
      level.siege_A_XPos = posValue;
      break;
    case 3:
      level.siege_A_YPos = posValue;
      break;
    case 4:
      level.siege_A_ZPos = posValue;
      break;

    case 5:
      level.siege_B_XPos = posValue;
      break;
    case 6:
      level.siege_B_YPos = posValue;
      break;
    case 7:
      level.siege_B_ZPos = posValue;
      break;

    case 8:
      level.siege_C_XPos = posValue;
      break;
    case 9:
      level.siege_C_YPos = posValue;
      break;
    case 10:
      level.siege_C_ZPos = posValue;
      break;
  }
}

getFlagPos(flagLabel, flagOrigin) {
  returnOrigin = flagOrigin;

  if(flagLabel == "_a") {
    if(isDefined(level.siege_A_XPos) && isDefined(level.siege_A_YPos) && isDefined(level.siege_A_ZPos))
      returnOrigin = (level.siege_A_XPos, level.siege_A_YPos, level.siege_A_ZPos);
  } else if(flagLabel == "_b") {
    if(isDefined(level.siege_B_XPos) && isDefined(level.siege_B_YPos) && isDefined(level.siege_B_ZPos))
      returnOrigin = (level.siege_B_XPos, level.siege_B_YPos, level.siege_B_ZPos);
  } else {
    if(isDefined(level.siege_C_XPos) && isDefined(level.siege_C_YPos) && isDefined(level.siege_C_ZPos))
      returnOrigin = (level.siege_C_XPos, level.siege_C_YPos, level.siege_C_ZPos);
  }

  return returnOrigin;
}

storeCenterFlag() {
  bestcentersq = undefined;

  foreach(flag in level.flags) {
    if(flag.script_label == "_b")
      level.centerFlag = flag;
  }
}

watchFlagTimerPause() {
  level endon("game_ended");

  while(true) {
    level waittill("flag_capturing", flag);

    if(GetDvarInt("scr_siege_rushtimer")) {
      capturingTeam = getOtherTeam(flag.prevTeam);

      if(flag.prevTeam != "neutral" && (isDefined(level.siegeTimerState) && level.siegeTimerState != "pause") && !isWinningTeam(capturingTeam)) {
        level.gameTimerBeeps = false;
        level.siegeTimerState = "pause";
        pauseCountdownTimer();

        if(!flagOwnersAlive(flag.prevTeam))
          setWinner(capturingTeam, flag.prevTeam + "_eliminated");
      }
    }
  }
}

isWinningTeam(team) {
  isWinning = false;

  teamFlags = getFlagCount(team);

  if(teamFlags == 2)
    isWinning = true;

  return isWinning;
}

flagOwnersAlive(team) {
  ownersAlive = false;

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && (isReallyAlive(player) || player.pers["lives"] > 0)) {
      ownersAlive = true;
      break;
    }
  }

  return ownersAlive;
}

pauseCountdownTimer() {
  SetGameEndTime(0);

  foreach(player in level.players) {
    player SetClientOmnvar("ui_bomb_timer", 5);
  }

  level notify("siege_timer_paused");
}

watchFlagTimerReset() {
  level endon("game_ended");

  while(true) {
    level waittill("start_flag_captured", flag);

    if(GetDvarInt("scr_siege_rushtimer")) {
      if(isDefined(level.siegeTimerState) && level.siegeTimerState != "reset") {
        level.gameTimerBeeps = false;
        level.siegeTimeLeft = undefined;
        level.siegeTimerState = "reset";
        notifyPlayers("siege_timer_reset");
      }
    }

    level notify("flag_end_use", flag);
  }
}

watchFlagEndUse() {
  level endon("game_ended");

  while(true) {
    alliesFlags = 0;
    axisFlags = 0;

    level waittill("flag_end_use", flag);

    alliesFlags = getFlagCount("allies");
    axisFlags = getFlagCount("axis");

    if(alliesFlags == 2 || axisFlags == 2) {
      if(GetDvarInt("scr_siege_rushtimer")) {
        if(level.siegeFlagCapturing.size == 0 && (!flag.flagCapSuccess || !isDefined(level.siegeTimerState) || level.siegeTimerState != "start")) {
          siegeRushTimer = GetDvarFloat("scr_siege_rushtimeramount");

          if(isDefined(level.siegeTimeLeft))
            siegeRushTimer = level.siegeTimeLeft;

          gameOverTime = Int(GetTime() + siegeRushTimer * 1000);

          foreach(player in level.players) {
            player SetClientOmnvar("ui_bomb_timer", 0);
          }

          level.timeLimitOverride = true;
          maps\mp\gametypes\_gamelogic::pauseTimer();
          SetGameEndTime(gameOverTime);

          if(!isDefined(level.siegeTimerState) || level.siegeTimerState == "pause") {
            level.siegeTimerState = "start";
            notifyPlayers("siege_timer_start");
          }

          if(!level.gameTimerBeeps)
            thread watchGameTimer(siegeRushTimer);
        }
      }
    } else if(alliesFlags == 3)
      setWinner("allies", "score_limit_reached");
    else if(axisFlags == 3)
      setWinner("axis", "score_limit_reached");

    flag.prevTeam = flag.ownerTeam;
  }
}

watchGameInactive() {
  level endon("game_ended");
  level endon("flag_capturing");

  timeLimit = GetDvarFloat("scr_siege_timelimit");

  if(timeLimit > 0) {
    inactiveTime = (timeLimit * 60) - 1;

    while(inactiveTime > 0) {
      inactiveTime -= 1;
      wait(1);
    }

    level.siegeGameInactive = true;
  }
}

watchGameStart() {
  level endon("game_ended");

  gameFlagWait("prematch_done");

  while(!haveSpawnedPlayers()) {
    waitframe();
  }

  level.gameHasStarted = true;
}

haveSpawnedPlayers() {
  if(level.teamBased)
    return (level.hasSpawned["axis"] && level.hasSpawned["allies"]);

  return (level.maxPlayerCount > 1);
}

watchGameTimer(gameTime) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");

  remainingTime = gameTime;
  clockObject = spawn("script_origin", (0, 0, 0));
  clockObject Hide();

  level.gameTimerBeeps = true;

  while(remainingTime > 0) {
    remainingTime -= 1;
    level.siegeTimeLeft = remainingTime;

    if(remainingTime <= 30) {
      if(remainingTime != 0)
        clockObject playSound("ui_mp_timer_countdown");
    }

    wait(1);
  }

  onTimeLimit();
}

getFlagCount(team) {
  teamFlags = 0;

  foreach(flag in level.domFlags) {
    if(flag.ownerTeam == team && !isBeingCaptured(flag))
      teamFlags += 1;
  }

  return teamFlags;
}

isBeingCaptured(flag) {
  cappingFlag = false;

  if(isDefined(flag)) {
    if(level.siegeFlagCapturing.size > 0) {
      foreach(flagLabel in level.siegeFlagCapturing) {
        if(flag.label == flagLabel)
          cappingFlag = true;
      }
    }
  }

  return cappingFlag;
}

setWinner(team, reason) {
  if(team != "tie")
    level.finalKillCam_winner = team;
  else
    level.finalKillCam_winner = "none";

  foreach(player in level.players) {
    if(!IsAI(player)) {
      player SetClientOmnvar("ui_dom_securing", 0);
      player SetClientOmnvar("ui_bomb_timer", 0);
    }
  }

  thread maps\mp\gametypes\_gamelogic::endGame(team, game["end_reason"][reason]);
}

onBeginUse(player) {
  ownerTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
  self.didStatusNotify = false;

  self maps\mp\gametypes\_gameobjects::setUseTime(GetDvarFloat("scr_siege_caprate"));

  level.siegeFlagCapturing[level.siegeFlagCapturing.size] = self.label;

  level notify("flag_capturing", self);
}

onUse(credit_player) {
  team = credit_player.team;
  oldTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();

  self.captureTime = GetTime();

  setFlagCaptured(team, oldTeam, credit_player);

  level.useStartSpawns = false;

  if(oldTeam == "neutral") {
    otherTeam = getOtherTeam(team);
    thread printAndSoundOnEveryone(team, otherTeam, undefined, undefined, "mp_dom_flag_captured", undefined, credit_player);

    if(getTeamFlagCount(team) < level.flags.size) {
      statusDialog("secured" + self.label, team, true);
      statusDialog("enemy_has" + self.label, otherTeam, true);
    }
  }

  credit_player maps\mp\_events::giveObjectivePointStreaks();
  self thread giveFlagCaptureXP(self.touchList[team]);
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
  }
}

onEndUse(team, player, success) {
  if(IsPlayer(player)) {
    player SetClientOmnvar("ui_dom_securing", 0);
    player.ui_dom_securing = undefined;
  }

  if(success) {
    self.flagCapSuccess = true;
    level notify("start_flag_captured", self);
  } else {
    self.flagCapSuccess = false;
    level notify("flag_end_use", self);
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

  level.siegeFlagCapturing = array_remove(level.siegeFlagCapturing, self.label);
}

onReset() {}

getUnownedFlagNearestStart(team, excludeFlag) {
  best = undefined;
  bestdistsq = undefined;
  flagObj = undefined;

  foreach(flag in level.flags) {
    if(flag.useObj getFlagTeam() != "neutral") {
      continue;
    }
    distsq = DistanceSquared(flag.origin, level.startPos[team]);

    if(isDefined(excludeFlag)) {
      if(!isFlagExcluded(flag, excludeFlag) && (!isDefined(best) || distsq < bestdistsq)) {
        bestdistsq = distsq;
        best = flag;
      }
    } else {
      if((!isDefined(best) || distsq < bestdistsq)) {
        bestdistsq = distsq;
        best = flag;
      }
    }
  }
  return best;
}

isFlagExcluded(flagToCheck, excludeFlag) {
  excluded = false;

  if(IsArray(excludeFlag)) {
    foreach(flag in excludeFlag) {
      if(flagToCheck == flag) {
        excluded = true;
        break;
      }
    }
  } else {
    if(flagToCheck == excludeFlag)
      excluded = true;
  }

  return excluded;
}

onDeadEvent(team) {
  if(gameHasStarted()) {
    if(team == "all") {
      onTimeLimit();
    } else if(team == game["attackers"]) {
      if(getFlagCount(team) == 2) {
        return;
      }
      setWinner(game["defenders"], game["attackers"] + "_eliminated");
    } else if(team == game["defenders"]) {
      if(getFlagCount(team) == 2) {
        return;
      }
      setWinner(game["attackers"], game["defenders"] + "_eliminated");
    }
  }
}

onOneLeftEvent(team) {
  lastPlayer = getLastLivingPlayer(team);

  lastPlayer thread giveLastOnTeamWarning();
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(!IsPlayer(attacker) || attacker.team == self.team) {
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
      attacker thread maps\mp\gametypes\_hud_message::splashNotify("assault", maps\mp\gametypes\_rank::getScoreInfoValue("assault"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("assault");
      maps\mp\gametypes\_gamescore::givePlayerScore("assault", attacker);

      thread maps\mp\_matchdata::logKillEvent(killId, "defending");
    } else {
      awardedDefend = true;
      attacker thread maps\mp\gametypes\_hud_message::splashNotify("defend", maps\mp\gametypes\_rank::getScoreInfoValue("defend"));
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
        attacker thread maps\mp\gametypes\_hud_message::splashNotify("assault", maps\mp\gametypes\_rank::getScoreInfoValue("assault"));
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
        attacker thread maps\mp\gametypes\_hud_message::splashNotify("defend", maps\mp\gametypes\_rank::getScoreInfoValue("defend"));
      attacker thread maps\mp\gametypes\_rank::giveRankXP("defend");
      maps\mp\gametypes\_gamescore::givePlayerScore("defend", attacker);

      attacker incPersStat("defends", 1);
      attacker maps\mp\gametypes\_persistence::statSetChild("round", "defends", attacker.pers["defends"]);

      thread maps\mp\_matchdata::logKillEvent(killId, "assaulting");
    }
  }
}

giveLastOnTeamWarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waitTillRecoveredHealth(3);

  otherTeam = getOtherTeam(self.pers["team"]);

  level thread teamPlayerCardSplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamPlayerCardSplash("callout_lastenemyalive", self, otherTeam);
  level notify("last_alive", self);
  self maps\mp\gametypes\_missions::lastManSD();
}

onTimeLimit() {
  if(isDefined(level.siegeGameInactive))
    level thread maps\mp\gametypes\_gamelogic::forceEnd();
  else {
    alliesFlags = getFlagCount("allies");
    axisFlags = getFlagCount("axis");

    if(alliesFlags > axisFlags)
      setWinner("allies", "time_limit_reached");
    else if(axisFlags > alliesFlags)
      setWinner("axis", "time_limit_reached");
    else
      setWinner("tie", "time_limit_reached");
  }
}

statusDialog(dialog, team, forceDialog) {
  time = GetTime();

  if(GetTime() < level.lastStatus[team] + 5000 && (!isDefined(forceDialog) || !forceDialog)) {
    return;
  }
  thread delayedLeaderDialog(dialog, team);
  level.lastStatus[team] = GetTime();
}

delayedLeaderDialog(sound, team) {
  level endon("game_ended");
  wait 0.1;
  WaitTillSlowProcessAllowed();

  leaderDialog(sound, team);
}

teamRespawn(team, credit_player) {
  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && !isReallyAlive(player) && !array_contains(level.alive_players[player.team], player) && (!isDefined(player.waitingToSelectClass) || !player.waitingToSelectClass)) {
      if(isDefined(player.siegeLateComer) && player.siegeLateComer)
        player.siegeLateComer = false;

      player maps\mp\gametypes\_playerlogic::incrementAliveCount(player.team);
      player.alreadyAddedToAliveCount = true;

      player thread waiTillCanSpawnClient();

      player thread maps\mp\gametypes\_hud_message::splashNotify("sr_respawned");
      level notify("sr_player_respawned", player);
      player leaderDialogOnPlayer("revived");

      credit_player maps\mp\gametypes\_missions::processChallenge("ch_rescuer");

      if(!isDefined(credit_player.rescuedPlayers)) {
        credit_player.rescuedPlayers = [];
      }
      credit_player.rescuedPlayers[player.guid] = true;

      if(credit_player.rescuedPlayers.size == OP_HELPME_NUM_TEAMMATES) {
        credit_player maps\mp\gametypes\_missions::processChallenge("ch_helpme");
      }
    }
  }
}

waiTillCanSpawnClient() {
  self endon("started_spawnPlayer");

  for(;;) {
    wait(0.05);
    if(isDefined(self) && (self.sessionstate == "spectator" || !isReallyAlive(self))) {
      self.pers["lives"] = 1;
      self maps\mp\gametypes\_playerlogic::spawnClient();

      continue;
    }

    return;
  }
}

notifyPlayers(notifyString) {
  foreach(player in level.players) {
    player thread maps\mp\gametypes\_hud_message::splashNotify(notifyString);
  }

  level notify("match_ending_soon", "time");
  level notify(notifyString);
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

showCapturedBaseEffectToPlayer(team, player) {
  if(isDefined(player._domFlagEffect[self.label]))
    player._domFlagEffect[self.label] Delete();

  effect = undefined;

  viewerTeam = player.team;
  isMLG = player IsMLGSpectator();
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

getTeamFlagCount(team) {
  score = 0;
  for(i = 0; i < level.flags.size; i++) {
    if(level.domFlags[i] maps\mp\gametypes\_gameobjects::getOwnerTeam() == team)
      score++;
  }
  return score;
}

getFlagTeam() {
  return self maps\mp\gametypes\_gameobjects::getOwnerTeam();
}

flagSetup() {
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
      dist = GetPathDist(spawnPoint.origin, domPoint.levelFlag.origin, 999999);
    }

    if(!isDefined(dist) || (dist == -1)) {
      dist = DistanceSquared(domPoint.levelFlag.origin, spawnPoint.origin);
    }

    if(!isDefined(nearestDomPoint) || dist < nearestDist) {
      nearestDomPoint = domPoint;
      nearestDist = dist;
    }
  }

  return nearestDomPoint.levelFlag;
}

giveFlagCaptureXP(touchList) {
  level endon("game_ended");

  first_player = self maps\mp\gametypes\_gameobjects::getEarliestClaimPlayer();
  if(isDefined(first_player.owner))
    first_player = first_player.owner;

  level.lastCapTime = GetTime();

  if(IsPlayer(first_player)) {
    level thread teamPlayerCardSplash("callout_securedposition" + self.label, first_player);

    first_player thread maps\mp\_matchdata::logGameEvent("capture", first_player.origin);
  }

  players_touching = GetArrayKeys(touchList);
  for(index = 0; index < players_touching.size; index++) {
    player = touchList[players_touching[index]].player;
    if(isDefined(player.owner))
      player = player.owner;

    if(!IsPlayer(player)) {
      continue;
    }
    player thread maps\mp\gametypes\_hud_message::splashNotify("capture", maps\mp\gametypes\_rank::getScoreInfoValue("capture"));
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

getCapXPScale() {
  if(self.CPM < 4)
    return 1;
  else
    return 0.25;
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

setFlagCaptured(team, oldTeam, credit_player, setStartingFlags) {
  label = self maps\mp\gametypes\_gameobjects::getLabel();
  self maps\mp\gametypes\_gameobjects::setOwnerTeam(team);
  self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_capture" + label);
  self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_capture" + label);
  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defend" + self.label);
  self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defend" + self.label);
  self.visuals[0] setModel(game["flagmodels"][team]);

  if(isDefined(self.neutralFlagFx))
    self.neutralFlagFx Delete();

  foreach(player in level.players) {
    self showCapturedBaseEffectToPlayer(team, player);
  }

  if(!isDefined(setStartingFlags)) {
    if(oldTeam != "neutral") {
      statusDialog("secured" + self.label, team, true);
      statusDialog("lost" + self.label, oldTeam, true);
      playSoundOnPlayers("mp_dom_flag_lost", oldTeam);
      level.lastCapTime = GetTime();
    }

    teamRespawn(team, credit_player);

    self.firstCapture = false;
  }

  self thread baseEffectsWaitForJoined();
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