/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnfactor.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_gameobjects;

CONST_SCORE_FACTOR_MIN = 0;
CONST_SCORE_FACTOR_MAX = 100;
CONST_PLAYER_DISTANCE_SQ_MAX = 1800 * 1800;
CONST_NEARBY_DISTANCE_SQ = 500 * 500;
CONST_EXPLOSIVE_RANGE_SQUARDED = 350 * 350;
CONST_GAS_CLOUD_RANGE_SQUARDED = 300 * 300;
CONST_CARE_PACKAGE_RADIUS_SQUARED = 150 * 150;
CONST_REVENGE_DISTANCE_SQUARED = 2000 * 2000;
CONST_ENEMY_SPAWN_TIME_LIMIT = 500;
CONST_RECENT_SPAWN_TIME_LIMIT = 4000;
CONST_TWAR_ZONE_DIST_SQUARED = 3000 * 3000;
CONST_HP_SPAWN_DIST_MIN = 832 * 832;
CONST_HP_SPAWN_DIST_BEST = 1600 * 1600;
CONST_HP_SPAWN_DIST_MAX = 2600 * 2600;

score_factor(weight, spawnFactorFunction, spawnPoint, optionalParam) {
  if(isDefined(optionalParam)) {
    scoreFactor = [[spawnFactorFunction]](spawnPoint, optionalParam);
  } else {
    scoreFactor = [[spawnFactorFunction]](spawnPoint);
  }

  scoreFactor = clamp(scoreFactor, CONST_SCORE_FACTOR_MIN, CONST_SCORE_FACTOR_MAX);
  scoreFactor *= weight;

  spawnPoint.debugScoreData[spawnPoint.debugScoreData.size] = scoreFactor;
  spawnPoint.totalPossibleScore += CONST_SCORE_FACTOR_MAX * weight;

  return scoreFactor;
}

critical_factor(spawnFactorFunction, spawnPoint) {
  scoreFactor = [[spawnFactorFunction]](spawnPoint);

  scoreFactor = clamp(scoreFactor, CONST_SCORE_FACTOR_MIN, CONST_SCORE_FACTOR_MAX);

  spawnPoint.debugCriticalData[spawnPoint.debugCriticalData.size] = scoreFactor;

  return scoreFactor;
}

avoidCarePackages(spawnPoint) {
  foreach(carePackage in level.carePackages) {
    if(!isDefined(carePackage)) {
      continue;
    }

    if(DistanceSquared(spawnPoint.origin, carePackage.origin) < CONST_CARE_PACKAGE_RADIUS_SQUARED) {
      return CONST_SCORE_FACTOR_MIN;
    }
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidGasClouds(spawnPoint) {
  foreach(gas_cloud in level.missile_strike_gas_clouds) {
    if(!isDefined(gas_cloud)) {
      continue;
    }

    if(DistanceSquared(spawnPoint.origin, gas_cloud.origin) < CONST_GAS_CLOUD_RANGE_SQUARDED) {
      return CONST_SCORE_FACTOR_MIN;
    }
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidGrenades(spawnPoint) {
  foreach(grenade in level.grenades) {
    if(!isDefined(grenade) || !(grenade isExplosiveDangerousToPlayer(self))) {
      continue;
    }

    if(DistanceSquared(spawnPoint.origin, grenade.origin) < CONST_EXPLOSIVE_RANGE_SQUARDED) {
      return CONST_SCORE_FACTOR_MIN;
    }
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidMines(spawnPoint) {
  explosiveArray = level.mines;

  foreach(explosive in explosiveArray) {
    if(!isDefined(explosive) || !(explosive isExplosiveDangerousToPlayer(self))) {
      continue;
    }

    if(DistanceSquared(spawnPoint.origin, explosive.origin) < CONST_EXPLOSIVE_RANGE_SQUARDED) {
      return CONST_SCORE_FACTOR_MIN;
    }
  }

  return CONST_SCORE_FACTOR_MAX;
}

isExplosiveDangerousToPlayer(player) {
  if(!level.teamBased || level.friendlyfire || !isDefined(player.team)) {
    return true;
  }

  if(!isDefined(self.owner) || !isDefined(self.owner.team)) {
    return true;
  }

  if(player == self.owner) {
    return true;
  }

  explosiveTeam = self.owner.team;

  return (explosiveTeam != player.team);
}

avoidAirStrikeLocations(spawnPoint) {
  if(!isDefined(level.artilleryDangerCenters)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  if(!spawnPoint.outside) {
    return CONST_SCORE_FACTOR_MAX;
  }

  airstrikeDanger = maps\mp\killstreaks\_airstrike::getAirstrikeDanger(spawnPoint.origin);

  if(airstrikeDanger > 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidCornerVisibleEnemies(spawnPoint) {
  enemyTeam = "all";
  if(level.teambased) {
    enemyTeam = getEnemyTeam(self.team);
  }

  if(spawnPoint.cornerSights[enemyTeam] > 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidFullVisibleEnemies(spawnPoint) {
  enemyTeam = "all";
  if(level.teambased) {
    enemyTeam = getEnemyTeam(self.team);
  }

  if(spawnPoint.fullSights[enemyTeam] > 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidTelefrag(spawnPoint) {
  if(isDefined(self.allowTelefrag)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  if(PositionWouldTelefrag(spawnPoint.origin)) {
    foreach(alternate in spawnpoint.alternates) {
      if(!PositionWouldTelefrag(alternate)) {
        break;
      }
    }

    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidSamespawn(spawnPoint) {
  if(isDefined(self.lastspawnpoint) && (self.lastspawnpoint == spawnPoint)) {
    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidRecentlyUsed(spawnPoint) {
  if(isDefined(spawnpoint.lastspawntime)) {
    timePassed = GetTime() - spawnpoint.lastspawntime;

    if(timePassed > CONST_RECENT_SPAWN_TIME_LIMIT) {
      return CONST_SCORE_FACTOR_MAX;
    }

    return (timePassed / CONST_RECENT_SPAWN_TIME_LIMIT) * CONST_SCORE_FACTOR_MAX;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidEnemyspawn(spawnPoint) {
  if(isDefined(spawnpoint.lastspawnteam) && (!level.teamBased || (spawnpoint.lastspawnteam != self.team))) {
    allowSpawnTime = spawnpoint.lastspawntime + CONST_ENEMY_SPAWN_TIME_LIMIT;

    if(GetTime() < allowSpawnTime) {
      return CONST_SCORE_FACTOR_MIN;
    }
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidSpawnInHP(spawnPoint) {
  dist_to_hp_sq = DistanceSquared(level.zone.origin, spawnpoint.origin);

  if(dist_to_hp_sq < CONST_HP_SPAWN_DIST_MIN) {
    return CONST_SCORE_FACTOR_MIN;
  }

  return CONST_SCORE_FACTOR_MAX;
}

avoidLastDeathLocation(spawnPoint) {
  if(!isDefined(self.lastDeathPos)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  distsq = DistanceSquared(spawnpoint.origin, self.lastDeathPos);

  if(distsq > CONST_REVENGE_DISTANCE_SQUARED) {
    return CONST_SCORE_FACTOR_MAX;
  }

  percentDist = (distsq / CONST_REVENGE_DISTANCE_SQUARED);

  return percentDist * CONST_SCORE_FACTOR_MAX;
}

avoidLastAttackerLocation(spawnPoint) {
  if(!isDefined(self.lastAttacker) || !isDefined(self.lastAttacker.origin)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  if(!isReallyAlive(self.lastAttacker)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  distsq = DistanceSquared(spawnpoint.origin, self.lastAttacker.origin);

  if(distsq > CONST_REVENGE_DISTANCE_SQUARED) {
    return CONST_SCORE_FACTOR_MAX;
  }

  percentDist = (distsq / CONST_REVENGE_DISTANCE_SQUARED);

  return percentDist * CONST_SCORE_FACTOR_MAX;
}

preferAlliesByDistance(spawnPoint) {
  if(spawnpoint.totalPlayers[self.team] == 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  allyAverageDist = spawnPoint.distSumSquared[self.team] / spawnpoint.totalPlayers[self.team];
  allyAverageDist = min(allyAverageDist, CONST_PLAYER_DISTANCE_SQ_MAX);

  scoringPercentage = 1 - (allyAverageDist / CONST_PLAYER_DISTANCE_SQ_MAX);

  return scoringPercentage * CONST_SCORE_FACTOR_MAX;
}

preferTwarZone(spawnPoint, zone) {
  distsq = Distance2DSquared(spawnPoint.origin, zone.origin);

  if(distsq > CONST_TWAR_ZONE_DIST_SQUARED) {
    return CONST_SCORE_FACTOR_MIN;
  }

  percentDist = 1.0 - (distsq / CONST_TWAR_ZONE_DIST_SQUARED);

  return percentDist * CONST_SCORE_FACTOR_MAX;
}

avoidEnemiesByDistance(spawnPoint) {
  enemyTeam = "all";

  if(level.teambased) {
    enemyTeam = getEnemyTeam(self.team);
  }

  if(spawnpoint.totalPlayers[enemyTeam] == 0) {
    return CONST_SCORE_FACTOR_MAX;
  }

  enemyDist = min(spawnpoint.minDistSquared[enemyTeam], CONST_PLAYER_DISTANCE_SQ_MAX);
  scoringPercentage = enemyDist / CONST_PLAYER_DISTANCE_SQ_MAX;

  return scoringPercentage * CONST_SCORE_FACTOR_MAX;
}

avoidFlagByDistance(spawnPoint) {
  if(spawnPoint.nearestFlag.furthestSpawnDist > 0) {
    scoringPercentage = spawnPoint.nearestFlagDist / spawnPoint.nearestFlag.furthestSpawnDist;
  } else {
    scoringPercentage = 0;
  }

  return scoringPercentage * CONST_SCORE_FACTOR_MAX;
}

preferDomPoints(spawnPoint, perferdDomPointArray) {
  if(perferdDomPointArray[0] && spawnPoint.domPointA) {
    return CONST_SCORE_FACTOR_MAX;
  }

  if(perferdDomPointArray[1] && spawnPoint.domPointB) {
    return CONST_SCORE_FACTOR_MAX;
  }

  if(perferdDomPointArray[2] && spawnPoint.domPointC) {
    return CONST_SCORE_FACTOR_MAX;
  }

  return CONST_SCORE_FACTOR_MIN;
}

preferByTeamBase(spawnPoint, team) {
  if(isDefined(spawnPoint.teamBase) && (spawnPoint.teamBase == team)) {
    return CONST_SCORE_FACTOR_MAX;
  }

  return CONST_SCORE_FACTOR_MIN;
}

randomSpawnScore(spawnPoint) {
  return (RandomIntRange(CONST_SCORE_FACTOR_MIN, CONST_SCORE_FACTOR_MAX - 1));
}

avoidHardpointPoints(spawnPoint) {
  dist_to_hp_sq = DistanceSquared(level.zone.origin, spawnpoint.origin);
  dist_to_hp = dist_to_hp_sq - CONST_HP_SPAWN_DIST_MIN;
  dist_max = CONST_HP_SPAWN_DIST_MAX - CONST_HP_SPAWN_DIST_MIN;
  dist_best = CONST_HP_SPAWN_DIST_BEST - CONST_HP_SPAWN_DIST_MIN;

  if(dist_to_hp >= dist_best) {
    return CONST_SCORE_FACTOR_MAX * (1.0 - 0.25 * (dist_to_hp - dist_best) / (dist_max - dist_best));
  } else if(dist_to_hp > 0) {
    return CONST_SCORE_FACTOR_MAX * 1.0 * (dist_to_hp / dist_best);
  } else {
    return CONST_SCORE_FACTOR_MIN;
  }
}

preferPlayerAnchors(spawnPoint) {
  team = self.team;
  otherTeam = getOtherTeam(team);

  if(spawnpoint.nearbyPlayers[team] == 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  if(spawnpoint.nearbyPlayers[otherTeam] == 0) {
    return CONST_SCORE_FACTOR_MAX;
  }

  nearby_delta = spawnpoint.nearbyPlayers[team] - spawnpoint.nearbyPlayers[otherTeam];

  if(nearby_delta <= 0) {
    return CONST_SCORE_FACTOR_MIN;
  }

  if(nearby_delta == 1) {
    return CONST_SCORE_FACTOR_MAX * 0.5;
  }

  if(nearby_delta >= 2) {
    return CONST_SCORE_FACTOR_MAX * 0.75;
  }

  AssertMsg("nearby_delta is undefined or unexpected value. nearby_delta = " + toString(nearby_delta));
  return CONST_SCORE_FACTOR_MIN;
}