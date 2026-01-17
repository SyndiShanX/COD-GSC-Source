/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnscoring.gsc
***********************************************/

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

    result = criticalFactors_NearTeam(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_NearTeam(spawnChoices["primary"]);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_NearTeam(spawnChoices["secondary"]);

  logBadspawn("Buddy Spawn");
  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
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

checkDynamicSpawns(spawnPoints) {
  if(isDefined(level.dynamicSpawns)) {
    spawnPoints = [[level.dynamicSpawns]](spawnPoints);
  }

  return spawnPoints;
}

selectBestSpawnPoint(highestScoringSpawn, spawnPoints) {
  bestSpawn = highestScoringSpawn;
  numberOfPossibleSpawnChoices = 0;

  foreach(spawnPoint in spawnPoints) {
    if(spawnPoint.totalScore > 0) {
      numberOfPossibleSpawnChoices++;
    }
  }

  if((numberOfPossibleSpawnChoices == 0) || level.forceBuddySpawn) {
    if(level.teamBased && level.supportBuddySpawn) {
      teamSpawnPoint = findBuddyspawn();

      if(teamSpawnPoint.buddySpawn) {
        bestSpawn = teamSpawnPoint;
      }
    }

    if(bestSpawn.totalScore == 0) {
      logBadspawn("UNABLE TO BUDDY SPAWN. Extremely bad.");
      bestSpawn = spawnPoints[RandomInt(spawnPoints.size)];
    }
  }

  bestSpawn.numberOfPossibleSpawnChoices = numberOfPossibleSpawnChoices;

  return bestSpawn;
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

DAMAGE_COOLDOWN = 3000;
isPlayerInCombat(player, bUseLessStrictHealthCheck) {
  if(player IsSighted()) {
    debugCombatCheck(player, "IsSighted");
    return true;
  }

  if(!player IsOnGround()) {
    debugCombatCheck(player, "IsOnGround");
    return true;
  }

  if(player IsOnLadder()) {
    debugCombatCheck(player, "IsOnLadder");
    return true;
  }

  if(player isFlashed()) {
    debugCombatCheck(player, "isFlashed");
    return true;
  }

  if(isDefined(bUseLessStrictHealthCheck) && bUseLessStrictHealthCheck) {
    if(player.health < player.maxhealth &&
      (!isDefined(player.lastDamagedTime) || GetTime() < player.lastDamagedTime + DAMAGE_COOLDOWN)
    ) {
      debugCombatCheck(player, "RecentDamage");
      return true;
    }
  } else {
    if(player.health < player.maxhealth) {
      debugCombatCheck(player, "MaxHealth");
      return true;
    }
  }

  if(!avoidGrenades(player)) {
    debugCombatCheck(player, "Grenades");
    return true;
  }

  if(!avoidMines(player)) {
    debugCombatCheck(player, "Mines");
    return true;
  }

  return false;
}

debugCombatCheck(player, reason) {
  buddyName = "none";
  if(isDefined(player.battleBuddy)) {
    buddyName = player.battleBuddy.name;
  }
  bbprint("battlebuddy_spawn", "player %s buddy %s reason %s", player.name, buddyName, reason);
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

      if(getMapName() == "mp_fahrenheit") {
        if(buddyNode.origin == (1778.9, 171.6, 716) ||
          buddyNode.origin == (1772.1, 271.4, 716) ||
          buddyNode.origin == (1657.2, 259.6, 716) ||
          buddyNode.origin == (1633.7, 333.9, 716) ||
          buddyNode.origin == (1634.4, 415.7, 716) ||
          buddyNode.origin == (1537.3, 419.3, 716) ||
          buddyNode.origin == (1410.9, 420.8, 716) ||
          buddyNode.origin == (1315.6, 416.6, 716) ||
          buddyNode.origin == (1079.4, 414.6, 716) ||
          buddyNode.origin == (982.9, 421.8, 716) ||
          buddyNode.origin == (896.9, 423.8, 716))
          continue;
      }

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

findDronePathNode(owner, spawnHeight, droneHalfSize, searchRadius) {
  nodeArray = GetNodesInRadiusSorted(owner.origin, searchRadius, 32, spawnHeight, "Path");
  bestNode = undefined;

  if(isDefined(nodeArray) && nodeArray.size > 0) {
    ownerDir = anglesToForward(owner.angles);

    foreach(node in nodeArray) {
      spawnPoint = node.origin + (0, 0, spawnHeight);
      if(CapsuleTracePassed(spawnPoint, droneHalfSize, droneHalfSize * 2 + 0.01, undefined, true, true)) {
        if(BulletTracePassed(owner getEye(), spawnPoint, false, owner)) {
          bestNode = spawnPoint;
          break;
        }
      }
    }
  }

  return bestNode;
}

isSafeToSpawnOn(teamMember, pointToSpawnCheck, trace) {
  if(teamMember IsSighted()) {
    maps\mp\gametypes\_spawnscoring::debugCombatCheck(self, "IsSighted-2");
    return false;
  }

  foreach(player in level.players) {
    if(trace.currentTraceCount == trace.maxTraceCount) {
      maps\mp\gametypes\_spawnscoring::debugCombatCheck(self, "TooManyTraces");
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
      maps\mp\gametypes\_spawnscoring::debugCombatCheck(self, "lineOfSight");

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

criticalFactors_NearTeam(spawnPoint) {
  if(!critical_factor(::avoidFullVisibleEnemies, spawnPoint)) {
    return "bad";
  }

  if(!critical_factor(::avoidGrenades, spawnPoint)) {
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

  if(isDefined(spawnPoint.forcedTeam) && spawnPoint.forcedteam != self.team) {
    return "bad";
  }

  if(!critical_factor(::avoidCornerVisibleEnemies, spawnPoint)) {
    return "secondary";
  }

  if(!critical_factor(::avoidCloseEnemies, spawnPoint)) {
    return "secondary";
  }

  return "primary";
}

scoreFactors_NearTeam(spawnPoint) {
  scoreFactor = score_factor(1.25, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidRecentlyUsedByEnemies, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidRecentlyUsedByAnyone, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

criticalFactors_DZ(spawnPoint) {
  return criticalFactors_NearTeam(spawnPoint);
}

getSpawnpoint_DZ(spawnPoints, preferedPointArray) {
  AssertEx(isDefined(preferedPointArray), "no preferedPointArray was passed into getSpawnpoint_DZ");

  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_DZ(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_DZ(spawnChoices["primary"], preferedPointArray);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_DZ(spawnChoices["secondary"], preferedPointArray);

  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
}

getSpawnpoint_Domination(spawnPoints, perferdDomPointArray) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_Domination(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_Domination(spawnChoices["primary"], perferdDomPointArray);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_Domination(spawnChoices["secondary"], perferdDomPointArray);

  logBadspawn("Buddy Spawn");
  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
}

scoreSpawns_DZ(spawnPoints, preferdDomPointArray) {
  bestSpawn = spawnPoints[0];

  foreach(spawnPoint in spawnPoints) {
    scoreFactors_DZ(spawnPoint, preferdDomPointArray);

    if(spawnPoint.totalScore > bestSpawn.totalScore) {
      bestSpawn = spawnPoint;
    }
  }

  bestSpawn = selectBestSpawnPoint(bestSpawn, spawnPoints);

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
  return criticalFactors_NearTeam(spawnPoint);
}

scoreFactors_DZ(spawnPoint, preferdPointArray) {
  scoreFactor = score_factor(2.5, ::preferClosePoints, spawnPoint, preferdPointArray);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidRecentlyUsedByEnemies, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidRecentlyUsedByAnyone, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

scoreFactors_Domination(spawnPoint, perferdDomPointArray) {
  scoreFactor = score_factor(2.5, ::preferDomPoints, spawnPoint, perferdDomPointArray);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidRecentlyUsedByEnemies, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidRecentlyUsedByAnyone, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getStartSpawnpoint_FreeForAll(spawnPoints) {
  if(!isDefined(spawnPoints)) {
    return undefined;
  }

  selectedSpawnPoint = undefined;
  activePlayerList = maps\mp\gametypes\_spawnlogic::getActivePlayerList();
  spawnPoints = checkDynamicSpawns(spawnPoints);

  if(!isDefined(activePlayerList) || activePlayerList.size == 0)
    return maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);

  furthestDistSq = 0;
  foreach(spawnPoint in spawnPoints) {
    if(Canspawn(spawnPoint.origin) && !PositionWouldTelefrag(spawnPoint.origin)) {
      distToClosestEnemySq = undefined;
      foreach(player in activePlayerList) {
        distToEnemySq = DistanceSquared(spawnpoint.origin, player.origin);
        if(!isDefined(distToClosestEnemySq) || distToEnemySq < distToClosestEnemySq) {
          distToClosestEnemySq = distToEnemySq;
        }
      }

      if(!isDefined(selectedSpawnPoint) || distToClosestEnemySq > furthestDistSq) {
        selectedSpawnPoint = spawnPoint;
        furthestDistSq = distToClosestEnemySq;
      }
    }
  }

  if(!isDefined(selectedSpawnPoint))
    return maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);

  return selectedSpawnPoint;
}

getSpawnpoint_FreeForAll(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_FreeForAll(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_FreeForAll(spawnChoices["primary"]);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_FreeForAll(spawnChoices["secondary"]);

  if(GetDvarInt("scr_altFFASpawns") == 1 && spawnChoices["bad"].size) {
    logBadspawn("Bad FFA Spawn");
    return scoreSpawns_FreeForAll(spawnChoices["bad"]);
  }

  logBadspawn("FFA Random Spawn");
  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
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
  return criticalFactors_NearTeam(spawnPoint);
}

scoreFactors_FreeForAll(spawnPoint) {
  avoidAllEnemiesWeight = 3.0;

  if(GetDvarInt("scr_altFFASpawns") == 1) {
    scoreFactor = score_factor(3.0, ::avoidClosestEnemy, spawnPoint);
    spawnPoint.totalScore += scoreFactor;
    avoidAllEnemiesWeight = 2.0;
  }

  scoreFactor = score_factor(avoidAllEnemiesWeight, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(2.0, ::avoidRecentlyUsedByEnemies, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_SearchAndRescue(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_SearchAndRescue(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_SearchAndRescue(spawnChoices["primary"]);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_SearchAndRescue(spawnChoices["secondary"]);

  logBadspawn("Buddy Spawn");
  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
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
  return criticalFactors_NearTeam(spawnPoint);
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

getSpawnpoint_awayFromEnemies(spawnPoints, team, disallowBuddySpawn) {
  if(!isDefined(disallowBuddySpawn))
    disallowBuddySpawn = false;

  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_awayFromEnemies(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_awayFromEnemies(spawnChoices["primary"], team);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_awayFromEnemies(spawnChoices["secondary"], team);

  if(disallowBuddySpawn) {
    return undefined;
  } else {
    logBadspawn("Buddy Spawn");
    return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
  }
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
  return criticalFactors_NearTeam(spawnPoint);
}

scoreFactors_awayFromEnemies(spawnPoint, team) {
  scoreFactor = score_factor(2.0, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidLastAttackerLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::avoidRecentlyUsedByEnemies, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidLastDeathLocation, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidSameSpawn, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.25, ::avoidRecentlyUsedByAnyone, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

getSpawnpoint_Safeguard(spawnPoints) {
  spawnPoints = checkDynamicSpawns(spawnPoints);
  spawnChoices["primary"] = [];
  spawnChoices["secondary"] = [];
  spawnChoices["bad"] = [];

  foreach(spawnPoint in spawnPoints) {
    initScoreData(spawnPoint);

    result = criticalFactors_Safeguard(spawnPoint);

    spawnChoices[result][spawnChoices[result].size] = spawnPoint;
  }

  if(spawnChoices["primary"].size)
    return scoreSpawns_Safeguard(spawnChoices["primary"]);

  if(spawnChoices["secondary"].size)
    return scoreSpawns_Safeguard(spawnChoices["secondary"]);

  logBadspawn("Buddy Spawn");
  return selectBestSpawnPoint(spawnPoints[0], spawnPoints);
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
  return criticalFactors_NearTeam(spawnPoint);
}

scoreFactors_Safeguard(spawnPoint) {
  scoreFactor = score_factor(1.0, ::randomSpawnScore, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(1.0, ::preferAlliesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;

  scoreFactor = score_factor(0.5, ::avoidEnemiesByDistance, spawnPoint);
  spawnPoint.totalScore += scoreFactor;
}

logBadspawn(typeString) {
  if(!isDefined(typeString))
    typeString = "";
  else
    typeString = "(" + typeString + ")";
  println("^1 Spawn Error: Bad spawn used. " + typeString + "\n");

  if(isDefined(level.matchRecording_logEventMsg)) {
    [[level.matchRecording_logEventMsg]]("LOG_BAD_SPAWN", GetTime(), typeString);
  }
}