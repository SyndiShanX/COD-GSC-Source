/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnscoring.gsc
***************************************************/

#include maps\mp\gametypes\_spawnfactor;
#include common_scripts\utility;
#include maps\mp\_utility;

getSpawnpoint_NearTeam(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_Global(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_NearTeam(spawnChoices["primary"]);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_NearTeam(spawnChoices["secondary"]);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_NearTeam(spawnPoints) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_NearTeam(spawnPoint);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

getSpawnpoint_twar(spawnPoints, currentZone) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_Global(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_twar(spawnChoices["primary"], currentZone);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_twar(spawnChoices["secondary"], currentZone);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    if(!IsAgent(self)) {
      recon_log_spawnpoint_info(spawnPoint);
    }
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_twar(spawnPoints, currentZone) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_twar(spawnPoint, currentZone);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

checkDynamicSpawns(spawnPoints) {
  if(isDefined(level.dynamicSpawns)) {
    spawnPoints = [[level.dynamicSpawns]](spawnPoints);
  }

  return spawnPoints;
}

selectBestSpawnPoint(highestScoringSpawn, spawnPoints) {
  bestSpawn = highestScoringSpawn;
  numberOfPossibleSpawnChoices = 0;

  best_spawns = [];
  foreach(spawnPoint in spawnPoints) {
    if(spawnPoint.totalScore == bestSpawn.totalScore) {
      best_spawns[best_spawns.size] = spawnPoint;
    }
  }
  bestSpawn = best_spawns[RandomInt(best_spawns.size)];

  foreach(spawnPoint in spawnPoints) {
    if(spawnPoint.totalScore > 0) {
      numberOfPossibleSpawnChoices++;
    }
  }

  if(numberOfPossibleSpawnChoices == 0) {
    if(bestSpawn.totalScore == 0) {
      bestSpawn = spawnPoints[RandomInt(spawnPoints.size)];
      bestSpawn.isRandom = true;
    }
  }

  bestSpawn.numberOfPossibleSpawnChoices = numberOfPossibleSpawnChoices;

  return bestSpawn;
}

recon_log_spawnpoint_info(spawnpoint) {
  if(!isDefined(spawnpoint.isRandom)) {
    spawnpoint.isRandom = false;
  }

  if(!isDefined(spawnpoint.teambase)) {
    spawnpoint.teambase = "none";
  }

  if(!isDefined(spawnpoint.lastSpawnTeam)) {
    spawnpoint.lastSpawnTeam = "none";
  }

  if(!isDefined(spawnpoint.lastSpawnTime)) {
    spawnpoint.lastSpawnTime = -1;
  }

  if(level.teamBased) {
    fullsights_allies = spawnpoint.fullsights["allies"];
    fullsights_axis = spawnpoint.fullsights["axis"];
    cornersights_allies = spawnpoint.cornersights["allies"];
    cornersights_axis = spawnpoint.cornersights["axis"];
    min_dist_squared_allies = spawnpoint.mindistsquared["allies"];
    min_dist_squared_axis = spawnpoint.mindistsquared["axis"];
  } else {
    fullsights_allies = spawnpoint.fullsights["all"];
    fullsights_axis = -1;
    cornersights_allies = spawnpoint.cornersights["all"];
    cornersights_axis = -1;
    min_dist_squared_allies = spawnpoint.mindistsquared["all"];
    min_dist_squared_axis = -1;
  }

  critical_data0 = -1;
  critical_data1 = -1;
  critical_data2 = -1;
  critical_data3 = -1;
  critical_data4 = -1;
  critical_data5 = -1;
  critical_data6 = -1;
  critical_data7 = -1;

  script_file = "_spawnscoring.gsc";
  gameTime = getTime();
  classname = spawnpoint.classname;
  totalscore = spawnpoint.totalscore;
  criticalResult = spawnpoint.criticalResult;
  teambase = spawnpoint.teambase;
  outside = spawnpoint.outside;

  if(isDefined(spawnpoint.debugcriticaldata[0])) critical_data0 = spawnpoint.debugcriticaldata[0];
  if(isDefined(spawnpoint.debugcriticaldata[1])) critical_data1 = spawnpoint.debugcriticaldata[1];
  if(isDefined(spawnpoint.debugcriticaldata[2])) critical_data2 = spawnpoint.debugcriticaldata[2];
  if(isDefined(spawnpoint.debugcriticaldata[3])) critical_data3 = spawnpoint.debugcriticaldata[3];
  if(isDefined(spawnpoint.debugcriticaldata[4])) critical_data4 = spawnpoint.debugcriticaldata[4];
  if(isDefined(spawnpoint.debugcriticaldata[5])) critical_data5 = spawnpoint.debugcriticaldata[5];
  if(isDefined(spawnpoint.debugcriticaldata[6])) critical_data6 = spawnpoint.debugcriticaldata[6];
  if(isDefined(spawnpoint.debugcriticaldata[7])) critical_data7 = spawnpoint.debugcriticaldata[7];

  totalpossiblescore = spawnpoint.totalPossibleScore;

  score_data0 = -1;
  score_data1 = -1;
  score_data2 = -1;
  score_data3 = -1;
  score_data4 = -1;
  score_data5 = -1;
  score_data6 = -1;
  score_data7 = -1;

  if(isDefined(spawnpoint.debugScoreData[0])) score_data0 = spawnpoint.debugScoreData[0];
  if(isDefined(spawnpoint.debugScoreData[1])) score_data1 = spawnpoint.debugScoreData[1];
  if(isDefined(spawnpoint.debugScoreData[2])) score_data2 = spawnpoint.debugScoreData[2];
  if(isDefined(spawnpoint.debugScoreData[3])) score_data3 = spawnpoint.debugScoreData[3];
  if(isDefined(spawnpoint.debugScoreData[4])) score_data4 = spawnpoint.debugScoreData[4];
  if(isDefined(spawnpoint.debugScoreData[5])) score_data5 = spawnpoint.debugScoreData[5];
  if(isDefined(spawnpoint.debugScoreData[6])) score_data6 = spawnpoint.debugScoreData[6];
  if(isDefined(spawnpoint.debugScoreData[7])) score_data7 = spawnpoint.debugScoreData[7];

  ReconSpatialEvent(spawnpoint.origin, "script_mp_spawnpoint_score: player_name %s, life_id %d, script_file %s, gameTime %d, classname %s, totalscore %d, totalPossibleScore %d, score_data0 %d, score_data1 %d, score_data2 %d, score_data3 %d, score_data4 %d, score_data5 %d, score_data6 %d, score_data7 %d, fullsights_allies %d, fullsights_axis %d, cornersights_allies %d, cornersights_axis %d, min_dist_squared_allies %d, min_dist_squared_axis %d, criticalResult %s, critical_data0 %d, critical_data1 %d, critical_data2 %d, critical_data3 %d, critical_data4 %d, critical_data5 %d, critical_data6 %d, critical_data7 %d, teambase %s, outside %d", self.name, self.lifeId, script_file, gameTime, classname, totalscore, totalPossibleScore, score_data0, score_data1, score_data2, score_data3, score_data4, score_data5, score_data6, score_data7, fullsights_allies, fullsights_axis, cornersights_allies, cornersights_axis, min_dist_squared_allies, min_dist_squared_axis, criticalResult, critical_data0, critical_data1, critical_data2, critical_data3, critical_data4, critical_data5, critical_data6, critical_data7, teambase, outside);
}

findSecondHighestSpawnScore(highestScoringSpawn, spawnPoints) {
  if(spawnPoints.size < 2) {
    return highestScoringSpawn;
  }

  bestSpawn = spawnPoints[0];

  if(bestSpawn == highestScoringSpawn) {
    bestSpawn = spawnPoints[1];
  }

  foreach(spawnPoint in spawnPoints) {
    if(spawnPoint == highestScoringSpawn) {
      continue;
    }

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  return bestSpawn;
}

findBuddyspawn() {
  spawnLocation = spawnStruct();
  initScoreData(spawnLocation);

  teamMates = getTeamMatesOutOfCombat(self.team);

  trace = spawnStruct();
  trace.maxTraceCount = 18;
  trace.currentTraceCount = 0;

  foreach(player in teamMates) {
    location = findSpawnLocationNearPlayer(player);

    if(!isDefined(location)) {
      continue;
    }

    if(isSafeToSpawnOn(player, location, trace)) {
      spawnLocation.totalScore = 999;
      spawnLocation.buddySpawn = true;
      spawnLocation.origin = location;
      spawnLocation.angles = getBuddySpawnAngles(player, spawnLocation.origin);
      break;
    }

    if(trace.currentTraceCount == trace.maxTraceCount) {
      break;
    }
  }

  return spawnLocation;
}

getBuddySpawnAngles(buddy, spawnLocation) {
  spawnAngles = (0, buddy.angles[1], 0);

  entranceNodes = FindEntrances(spawnLocation);

  if(isDefined(entranceNodes) && (entranceNodes.size > 0)) {
    spawnAngles = VectorToAngles(entranceNodes[0].origin - spawnLocation);
  }

  return spawnAngles;
}

getTeamMatesOutOfCombat(team) {
  teamMates = [];

  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }

    if(player.sessionstate != "playing") {
      continue;
    }

    if(!isReallyAlive(player)) {
      continue;
    }

    if(player == self) {
      continue;
    }

    if(isPlayerInCombat(player)) {
      continue;
    }

    teamMates[teamMates.size] = player;
  }

  return array_randomize(teamMates);
}

isPlayerInCombat(player) {
  if(player IsSighted()) {
    return true;
  }

  if(!player IsOnGround()) {
    return true;
  }

  if(player IsOnLadder()) {
    return true;
  }

  if(player isFlashed()) {
    return true;
  }

  DAMAGE_COOLDOWN = 3000;

  if((player.health < player.maxhealth) && isDefined(player.lastDamagedTime) && (GetTime() < (player.lastDamagedTime + DAMAGE_COOLDOWN))) {
    return true;
  }

  if(!avoidGrenades(player)) {
    return true;
  }

  if(!avoidMines(player)) {
    return true;
  }

  return false;
}

findSpawnLocationNearPlayer(player) {
  playerHeight = maps\mp\gametypes\_spawnlogic::getPlayerTraceHeight(player, true);

  buddyNode = findBuddyPathNode(player, playerHeight, 0.5);

  if(isDefined(buddyNode)) {
    return buddyNode.origin;
  }

  return undefined;
}

findBuddyPathNode(buddy, playerHeight, cosAngle) {
  nodeArray = GetNodesInRadiusSorted(buddy.origin, 192, 64, playerHeight, "Path");
  bestNode = undefined;

  if(isDefined(nodeArray) && nodeArray.size > 0) {
    buddyDir = anglesToForward(buddy.angles);

    foreach(buddyNode in nodeArray) {
      directionToNode = VectorNormalize(buddyNode.origin - buddy.origin);
      dot = VectorDot(buddyDir, directionToNode);

      if((dot <= cosAngle) && !positionWouldTelefrag(buddyNode.origin)) {
        if(sightTracePassed(buddy.origin + (0, 0, playerHeight), buddyNode.origin + (0, 0, playerHeight), false, buddy)) {
          bestNode = buddyNode;

          if(dot <= 0.0) {
            break;
          }
        }
      }
    }
  }

  return bestNode;
}

isSafeToSpawnOn(teamMember, pointToSpawnCheck, trace) {
  if(teamMember IsSighted()) {
    return false;
  }

  foreach(player in level.players) {
    if(trace.currentTraceCount == trace.maxTraceCount) {
      return false;
    }

    if(player.team == self.team) {
      continue;
    }

    if(player.sessionstate != "playing") {
      continue;
    }

    if(!isReallyAlive(player)) {
      continue;
    }

    if(player == self) {
      continue;
    }

    trace.currentTraceCount++;
    playerHeight = maps\mp\gametypes\_spawnlogic::getPlayerTraceHeight(player);
    spawnTraceLocation = player getEye();
    spawnTraceLocation = (spawnTraceLocation[0], spawnTraceLocation[1], player.origin[2] + playerHeight);

    sightValue = SpawnSightTrace(trace, pointToSpawnCheck + (0, 0, playerHeight), spawnTraceLocation);

    if(sightValue > 0) {
      return false;
    }
  }

  return true;
}

initScoreData(spawnPoint) {
  spawnPoint.totalScore = 0;
  spawnPoint.numberOfPossibleSpawnChoices = 0;
  spawnPoint.buddySpawn = false;

  spawnPoint.debugScoreData = [];
  spawnPoint.debugCriticalData = [];
  spawnPoint.totalPossibleScore = 0;
}

criticalFactors_Global(spawnPoint) {
  if(!critical_factor(::avoidFullVisibleEnemies, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidGrenades, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidGasClouds, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidMines, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidAirStrikeLocations, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidCarePackages, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidTelefrag, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidEnemySpawn, spawnPoint)) {
    return "bad";
  }

  if(level.gameType == "hp") {
    if(!critical_factor(::avoidSpawnInHP, spawnPoint)) {
      return "bad";
    }
  }

  if(!critical_factor(::avoidCornerVisibleEnemies, spawnPoint)) {
    return "secondary";
  }

  return "primary";
}

scoreFactors_NearTeam(spawnPoint) {
  scoreFactor = score_factor(1.25, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.25, ::avoidRecentlyUsed, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

scoreFactors_twar(spawnPoint, currentZone) {
  scoreFactor = score_factor(1.0, ::preferTwarZone, spawnPoint, currentZone);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidRecentlyUsed, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.20, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_Domination(spawnPoints, perferdDomPointArray) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_Domination(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_Domination(spawnChoices["primary"], perferdDomPointArray);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_Domination(spawnChoices["secondary"], perferdDomPointArray);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_Domination(spawnPoints, perferdDomPointArray) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_Domination(spawnPoint, perferdDomPointArray);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

criticalFactors_Domination(spawnPoint) {
  return criticalFactors_Global(spawnPoint);
}

scoreFactors_Domination(spawnPoint, perferdDomPointArray) {
  scoreFactor = score_factor(1.0, ::preferDomPoints, spawnPoint, perferdDomPointArray);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidRecentlyUsed, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.5, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_FreeForAll(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_FreeForAll(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_FreeForAll(spawnChoices["primary"]);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_FreeForAll(spawnChoices["secondary"]);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_FreeForAll(spawnPoints) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_FreeForAll(spawnPoint);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

criticalFactors_FreeForAll(spawnPoint) {
  return criticalFactors_Global(spawnPoint);
}

scoreFactors_FreeForAll(spawnPoint) {
  scoreFactor = score_factor(1.5, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidRecentlyUsed, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_SearchAndRescue(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_SearchAndRescue(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_SearchAndRescue(spawnChoices["primary"]);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_SearchAndRescue(spawnChoices["secondary"]);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_SearchAndRescue(spawnPoints) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_SearchAndRescue(spawnPoint);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

criticalFactors_SearchAndRescue(spawnPoint) {
  return criticalFactors_Global(spawnPoint);
}

scoreFactors_SearchAndRescue(spawnPoint) {
  scoreFactor = score_factor(3.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_Hardpoint(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];
  bestSpawn = spawnPoints[RandomInt(spawnPoints.size)];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_Global(spawnPoint);
    if(spawnPoint.criticalResult == "bad") {
      continue;
    }

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_Hardpoint(spawnChoices["primary"]);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_Hardpoint(spawnChoices["secondary"]);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[RandomInt(spawnPoints.size)], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_Hardpoint(spawnPoints) {
  bestSpawn = spawnPoints[RandomInt(spawnPoints.size)];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_Hardpoint(spawnPoint);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

scoreFactors_Hardpoint(spawnPoint) {
  scoreFactor = score_factor(1.5, ::avoidHardpointPoints, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferPlayerAnchors, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_CTF(spawnPoints, team) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_awayFromEnemies(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_CTF(spawnChoices["primary"], team);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_CTF(spawnChoices["secondary"], team);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_CTF(spawnPoints, team) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_CTF(spawnPoint, team);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

scoreFactors_CTF(spawnPoint, team) {
  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.75, ::avoidFlagByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_awayFromEnemies(spawnPoints, team) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_awayFromEnemies(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_awayFromEnemies(spawnChoices["primary"], team);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_awayFromEnemies(spawnChoices["secondary"], team);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    recon_log_spawnpoint_info(spawnPoint);
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_awayFromEnemies(spawnPoints, team) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_awayFromEnemies(spawnPoint, team);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

criticalFactors_awayFromEnemies(spawnPoint) {
  return criticalFactors_Global(spawnPoint);
}

scoreFactors_awayFromEnemies(spawnPoint, team) {
  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_Safeguard(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    spawnPoint.criticalResult = criticalFactors_Safeguard(spawnPoint);

    spawnChoices[spawnPoint.criticalResult][spawnChoices[spawnPoint.criticalResult].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size) {
    bestSpawn = scoreSpawns_Safeguard(spawnChoices["primary"]);
  } else if(spawnChoices["secondary"].size) {
    bestSpawn = scoreSpawns_Safeguard(spawnChoices["secondary"]);
  } else {
    bestSpawn = selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }

  foreach(spawnPoint in spawnPoints) {
    spawnPoint.criticalResult = undefined;
  }

  return bestSpawn;
}

scoreSpawns_Safeguard(spawnPoints) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_Safeguard(spawnPoint);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

  return bestSpawn;
}

criticalFactors_Safeguard(spawnPoint) {
  return criticalFactors_Global(spawnPoint);
}

scoreFactors_Safeguard(spawnPoint) {
  scoreFactor = score_factor(1.0, ::randomSpawnScore, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}