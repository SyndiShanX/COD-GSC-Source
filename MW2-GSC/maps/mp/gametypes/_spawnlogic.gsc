/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnlogic.gsc
********************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

findBoxCenter(mins, maxs) {
  center = (0, 0, 0);
  center = maxs - mins;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
  return center;
}

expandMins(mins, point) {
  if(mins[0] > point[0]) {
    mins = (point[0], mins[1], mins[2]);
  }
  if(mins[1] > point[1]) {
    mins = (mins[0], point[1], mins[2]);
  }
  if(mins[2] > point[2]) {
    mins = (mins[0], mins[1], point[2]);
  }
  return mins;
}

expandMaxs(maxs, point) {
  if(maxs[0] < point[0]) {
    maxs = (point[0], maxs[1], maxs[2]);
  }
  if(maxs[1] < point[1]) {
    maxs = (maxs[0], point[1], maxs[2]);
  }
  if(maxs[2] < point[2]) {
    maxs = (maxs[0], maxs[1], point[2]);
  }
  return maxs;
}

addSpawnPoints(team, spawnPointName, isSetOptional) {
  if(!isDefined(isSetOptional)) {
    isSetOptional = false;
  }

  oldSpawnPoints = [];
  if(level.teamSpawnPoints[team].size) {
    oldSpawnPoints = level.teamSpawnPoints[team];
  }

  level.teamSpawnPoints[team] = getSpawnpointArray(spawnPointName);

  if(!level.teamSpawnPoints[team].size && !isSetOptional) {
    println("^1Error: No " + spawnPointName + " spawnpoints found in level!");
    maps\mp\gametypes\_callbacksetup::AbortLevel();
    wait 1;
    return;
  }

  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  for(index = 0; index < level.teamSpawnPoints[team].size; index++) {
    spawnpoint = level.teamSpawnPoints[team][index];

    if(!isDefined(spawnpoint.inited)) {
      spawnpoint spawnPointInit();
      level.spawnpoints[level.spawnpoints.size] = spawnpoint;
    }
  }

  for(index = 0; index < oldSpawnPoints.size; index++) {
    origin = oldSpawnPoints[index].origin;

    level.spawnMins = expandMins(level.spawnMins, origin);
    level.spawnMaxs = expandMaxs(level.spawnMaxs, origin);

    level.teamSpawnPoints[team][level.teamSpawnPoints[team].size] = oldSpawnPoints[index];
  }
}

placeSpawnPoints(spawnPointName) {
  spawnPoints = getSpawnpointArray(spawnPointName);

  if(!isDefined(level.extraspawnpointsused)) {
    level.extraspawnpointsused = [];
  }

  if(!spawnPoints.size) {
    println("^1Error: No " + spawnPointName + " spawnpoints found in level!");
    maps\mp\gametypes\_callbacksetup::AbortLevel();
    wait 1;
    return;
  }

  for(index = 0; index < spawnPoints.size; index++) {
    spawnPoints[index] spawnPointInit();

    spawnPoints[index].fakeclassname = spawnPointName;
    level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnPoints[index];
  }
}

getSpawnpointArray(classname) {
  spawnPoints = getEntArray(classname, "classname");

  if(!isDefined(level.extraspawnpoints) || !isDefined(level.extraspawnpoints[classname])) {
    return spawnPoints;
  }

  for(i = 0; i < level.extraspawnpoints[classname].size; i++) {
    spawnPoints[spawnPoints.size] = level.extraspawnpoints[classname][i];
  }

  return spawnPoints;
}

expandSpawnpointBounds(classname) {
  spawnPoints = getSpawnpointArray(classname);
  for(index = 0; index < spawnPoints.size; index++) {
    level.spawnMins = expandMins(level.spawnMins, spawnPoints[index].origin);
    level.spawnMaxs = expandMaxs(level.spawnMaxs, spawnPoints[index].origin);
  }
}

setMapCenterForReflections() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::expandSpawnpointBounds("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::expandSpawnpointBounds("mp_tdm_spawn_axis_start");
  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}
spawnPointInit() {
  spawnpoint = self;
  origin = spawnpoint.origin;

  level.spawnMins = expandMins(level.spawnMins, origin);
  level.spawnMaxs = expandMaxs(level.spawnMaxs, origin);

  spawnpoint placeSpawnpoint();
  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sightTracePoint = spawnpoint.origin + (0, 0, 50);

  spawnpoint.lastspawnedplayer = spawnpoint;
  spawnpoint.lastspawntime = gettime();

  skyHeight = 1024;
  spawnpoint.outside = true;
  if(!bullettracepassed(spawnpoint.sightTracePoint, spawnpoint.sightTracePoint + (0, 0, skyHeight), false, undefined)) {
    startpoint = spawnpoint.sightTracePoint + spawnpoint.forward * 100;
    if(!bullettracepassed(startpoint, startpoint + (0, 0, skyHeight), false, undefined)) {
      spawnpoint.outside = false;
    }
  }

  right = anglesToRight(spawnpoint.angles);
  spawnpoint.alternates = [];
  AddAlternateSpawnpoint(spawnpoint, spawnpoint.origin + right * 45);
  AddAlternateSpawnpoint(spawnpoint, spawnpoint.origin - right * 45);

  spawnPointUpdate(spawnpoint);

  spawnpoint.inited = true;
}

AddAlternateSpawnpoint(spawnpoint, alternatepos) {
  spawnpointposRaised = playerPhysicsTrace(spawnpoint.origin, spawnpoint.origin + (0, 0, 18), false, undefined);
  zdiff = spawnpointposRaised[2] - spawnpoint.origin[2];

  alternateposRaised = (alternatepos[0], alternatepos[1], alternatepos[2] + zdiff);

  traceResult = playerPhysicsTrace(spawnpointposRaised, alternateposRaised, false, undefined);
  if(traceResult != alternateposRaised) {
    return;
  }
  finalAlternatePos = playerPhysicsTrace(alternateposRaised, alternatepos);

  spawnpoint.alternates[spawnpoint.alternates.size] = finalAlternatePos;
}

getTeamSpawnPoints(team) {
  return level.teamSpawnPoints[team];
}
getSpawnpoint_Final(spawnpoints, useweights) {
  prof_begin("spawn_final");

  bestspawnpoint = undefined;

  if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
    return undefined;
  }

  if(!isDefined(useweights)) {
    useweights = true;
  }

  if(useweights) {
    bestspawnpoint = getBestWeightedSpawnpoint(spawnpoints);

    thread spawnWeightDebug(spawnpoints, bestspawnpoint);
  } else {
    carePackages = getEntArray("care_package", "targetname");

    for(i = 0; i < spawnpoints.size; i++) {
      if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i]) {
        continue;
      }
      if(positionWouldTelefrag(spawnpoints[i].origin)) {
        continue;
      }
      if(carePackages.size && !canspawn(spawnpoints[i].origin)) {
        continue;
      }
      bestspawnpoint = spawnpoints[i];
      break;
    }
    if(!isDefined(bestspawnpoint)) {
      if(isDefined(self.lastspawnpoint) && !positionWouldTelefrag(self.lastspawnpoint.origin)) {
        for(i = 0; i < spawnpoints.size; i++) {
          if(spawnpoints[i] == self.lastspawnpoint) {
            bestspawnpoint = spawnpoints[i];
            break;
          }
        }
      }
    }
  }

  if(!isDefined(bestspawnpoint)) {
    if(useweights) {
      bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
    } else {
      bestspawnpoint = spawnpoints[0];
    }
  }

  prof_end("spawn_final");

  return bestspawnpoint;
}

finalizeSpawnpointChoice(spawnpoint) {
  time = getTime();

  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;
  spawnpoint.lastspawnedplayer = self;
  spawnpoint.lastspawntime = time;
}

maxSightTracedSpawnpoints = 3;

getBestWeightedSpawnpoint(spawnpoints) {
  otherteam = getOtherTeam(self.team);

  assert(spawnpoints.size > 0);

  for(
    try = 0;;
    try ++) {
    bestspawnpoints = [];
    bestspawnpoints[0] = spawnpoints[0];
    bestweight = spawnpoints[0].weight;
    for(i = 1; i < spawnpoints.size; i++) {
      spawnpoint = spawnpoints[i];
      if(spawnpoint.weight > bestweight) {
        bestspawnpoints = [];
        bestspawnpoints[0] = spawnpoint;
        bestweight = spawnpoint.weight;
      } else if(spawnpoint.weight == bestweight) {
        bestspawnpoints[bestspawnpoints.size] = spawnpoint;
      }
    }

    assert(bestspawnpoints.size > 0);
    bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];

    if(
      try >= maxSightTracedSpawnpoints) {
      println("Spawning " + self.name + " at spawnpoint " + bestspawnpoint.origin + " because the " + maxSightTracedSpawnpoints + " best spawnpoints failed last minute sight trace tests.");
      DumpSpawnData(spawnpoints, bestspawnpoint);
      return bestspawnpoint;
    }

    sights = 0;
    if(level.teambased) {
      sights = bestspawnpoint.sights[otherteam];
    } else {
      sights = bestspawnpoint.sights;
    }

    if(sights > 0) {
      println("Spawning " + self.name + " at spawnpoint " + bestspawnpoint.origin + " even though " + sights + " lines of sight to the enemy exist.");
      DumpSpawnData(spawnpoints, bestspawnpoint);
      return bestspawnpoint;
    }

    if(isDefined(bestspawnpoint.lastSightTraceTime) && bestspawnpoint.lastSightTraceTime == gettime()) {
      return bestspawnpoint;
    }

    sightValue = lastMinuteSightTraces(bestspawnpoint);
    if(sightValue == 0) {
      return bestspawnpoint;
    }

    sightValue = adjustSightValue(sightvalue);
    if(level.teambased) {
      bestspawnpoint.sights[otherteam] += sightValue;
    } else {
      bestspawnpoint.sights += sightValue;
    }

    penalty = getLosPenalty() * sightValue;

    bestspawnpoint.spawnData[bestspawnpoint.spawnData.size] = "Last minute sight trace: -" + penalty;

    bestspawnpoint.weight -= penalty;

    bestspawnpoint.lastSightTraceTime = gettime();
  }
  assertmsg("can't get here");
}

DumpSpawnData(spawnpoints, winnerspawnpoint) {
  if(getSubStr(self.name, 0, 3) == "bot") {
    if(getdvarint("scr_spawnpointdebug") == 0) {
      return;
    }
  }

  println("=================================");
  println("spawndata = spawnStruct();");
  println("spawndata.playername = \"" + self.name + "\";");
  println("spawndata.friends = [];");
  println("spawndata.enemies = [];");
  foreach(player in level.players) {
    if(player.team == self.team) {
      println("spawndata.friends[ spawndata.friends.size ] = " + player.origin + ";");
    } else {
      println("spawndata.enemies[ spawndata.enemies.size ] = " + player.origin + ";");
    }
  }
  println("spawndata.otherdata = [];");

  println("spawndata.spawnpoints = [];");
  index = 0;
  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint == winnerspawnpoint) {
      println("spawndata.spawnpointwinner = " + index + ";");
    }

    println("spawnpoint = spawnStruct();");
    println("spawnpoint.weight = " + spawnpoint.weight + ";");
    println("spawnpoint.origin = " + spawnpoint.origin + ";");
    println("spawnpoint.spawndata = [];");
    for(i = 0; i < spawnpoint.spawndata.size; i++) {
      println("spawnpoint.spawndata[" + i + "] = \"" + spawnpoint.spawndata[i] + "\";");
    }

    println("spawndata.spawnpoints[spawndata.spawnpoints.size] = spawnpoint;");
    index++;
  }
  println("=================================");
}

DrawRecordedSpawnData() {
  spawndata = undefined;

  if(isDefined(spawndata)) {
    thread drawSpawnData(spawndata);
  }
}

checkBad(spawnpoint) {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isAlive(player) || player.sessionstate != "playing") {
      continue;
    }
    if(level.teambased && player.team == self.team) {
      continue;
    }
    losExists = bullettracepassed(player.origin + (0, 0, 50), spawnpoint.sightTracePoint, false, undefined);
    if(losExists) {
      thread badSpawnLine(spawnpoint.sightTracePoint, player.origin + (0, 0, 50), self.name, player.name);
    }
  }
}

badSpawnLine(start, end, name1, name2) {
  dist = distance(start, end);
  for(i = 0; i < 20 * 10; i++) {
    line(start, end, (1, 0, 0));
    print3d(start, "Bad spawn! " + name1 + ", dist = " + dist);
    print3d(end, name2);

    wait .05;
  }
}

drawSpawnData(spawndata) {
  level notify("drawing_spawn_data");
  level endon("drawing_spawn_data");

  textoffset = (0, 0, -12);

  fakeplayer = spawnStruct();
  fakeplayer.name = spawndata.playername;

  fakeplayer thread spawnWeightDebug(spawndata.spawnpoints, spawndata.spawnpoints[spawndata.spawnpointwinner]);

  while(1) {
    for(i = 0; i < spawndata.friends.size; i++) {
      print3d(spawndata.friends[i], "=)", (.5, 1, .5), 1, 5);
    }
    for(i = 0; i < spawndata.enemies.size; i++) {
      print3d(spawndata.enemies[i], "=(", (1, .5, .5), 1, 5);
    }

    for(i = 0; i < spawndata.otherdata.size; i++) {
      print3d(spawndata.otherdata[i].origin, spawndata.otherdata[i].text, (.5, .75, 1), 1, 2);
    }

    wait .05;
  }
}

getSpawnpoint_Random(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  for(i = 0; i < spawnpoints.size; i++) {
    j = randomInt(spawnpoints.size);
    spawnpoint = spawnpoints[i];
    spawnpoints[i] = spawnpoints[j];
    spawnpoints[j] = spawnpoint;
  }

  if(isDefined(self.predictedSpawnPoint)) {
    for(i = 1; i < spawnpoints.size; i++) {
      if(spawnpoints[i] == self.predictedSpawnPoint) {
        temp = spawnpoints[0];
        spawnpoints[0] = spawnpoints[i];
        spawnpoints[i] = temp;
        break;
      }
    }
  }

  return getSpawnpoint_Final(spawnpoints, false);
}

getAllOtherPlayers() {
  aliveplayers = [];

  for(i = 0; i < level.players.size; i++) {
    if(!isDefined(level.players[i])) {
      continue;
    }
    player = level.players[i];

    if(player.sessionstate != "playing" || player == self) {
      continue;
    }
    aliveplayers[aliveplayers.size] = player;
  }
  return aliveplayers;
}
initWeights(spawnpoints) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].weight = 0;
  }

  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].spawnData = [];
  }
}

getSpawnpoint_NearTeam(spawnpoints, favoredspawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  setDevDvarIfUninitialized("scr_spawn_randomly", "0");
  if(getdvarint("scr_spawn_randomly") == 1) {
    return getSpawnpoint_Random(spawnpoints);
  }

  prof_begin("spawn_basiclogic");

  if(getdvarint("scr_spawnsimple") > 0) {
    return getSpawnpoint_Random(spawnpoints);
  }

  Spawnlogic_Begin();

  initWeights(spawnpoints);

  obj = spawnStruct();

  alliedDistanceWeight = 2;

  myTeam = self.team;
  enemyTeam = getOtherTeam(myTeam);

  carePackages = getEntArray("care_package", "targetname");
  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.numPlayersAtLastUpdate > 0) {
      allyDistSum = spawnpoint.weightedDistSum[myTeam];
      enemyDistSum = spawnpoint.distSum[enemyTeam];

      spawnpoint.weight = (enemyDistSum - alliedDistanceWeight * allyDistSum) / spawnpoint.numPlayersAtLastUpdate;

      spawnpoint.spawnData[spawnpoint.spawnData.size] = "Base weight: " + int(spawnpoint.weight) + " = (" + int(enemyDistSum) + " - " + alliedDistanceWeight + "*" + int(allyDistSum) + ") / " + spawnpoint.numPlayersAtLastUpdate;
    } else {
      spawnpoint.weight = 0;

      spawnpoint.spawnData[spawnpoint.spawnData.size] = "Base weight: 0";
    }

    if(carePackages.size && !canspawn(spawnpoint.origin)) {
      spawnpoint.weight -= 500000;
    }
  }

  if(isDefined(favoredspawnpoints)) {
    for(i = 0; i < favoredspawnpoints.size; i++) {
      favoredspawnpoints[i].weight += 50000;

      favoredspawnpoints[i].spawnData[favoredspawnpoints[i].spawnData.size] = "Favored: 50000";
    }
  }

  if(isDefined(self.predictedSpawnPoint) && isDefined(self.predictedSpawnPoint.weight)) {
    self.predictedSpawnPoint.weight += 100;

    self.predictedSpawnPoint.spawnData[self.predictedSpawnPoint.spawnData.size] = "Predicted: 100";
  }

  prof_end("spawn_basiclogic");

  prof_begin("spawn_complexlogic");

  avoidSamespawn();

  avoidWeaponDamage(spawnpoints);
  avoidVisibleEnemies(spawnpoints, true);

  prof_end("spawn_complexlogic");

  result = getSpawnpoint_Final(spawnpoints);

  setdevdvarIfUninitialized("scr_spawn_showbad", "0");
  if(getdvarint("scr_spawn_showbad") == 1) {
    checkBad(result);
  }

  return result;
}

getSpawnpoint_Safespawn(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }
  assert(spawnpoints.size > 0);

  Spawnlogic_Begin();

  safestSpawnpoint = undefined;
  safestDangerDist = undefined;

  enemyTeam = getOtherTeam(self.team);
  if(!level.teambased) {
    enemyTeam = "all";
  }

  mingrenadedistsquared = 500 * 500;

  foreach(spawnpoint in spawnpoints) {
    dangerDist = spawnpoint.minDist[enemyTeam];

    foreach(grenade in level.grenades) {
      if(!isDefined(grenade)) {
        continue;
      }
      if(distancesquared(spawnpoint.origin, grenade.origin) < mingrenadedistsquared) {
        grenadeDist = distance(spawnpoint.origin, grenade.origin) - 220;
        if(grenadeDist < dangerDist) {
          if(grenadeDist < 0) {
            grenadeDist = 0;
          }
          dangerDist = grenadeDist;
        }
      }
    }

    if(positionWouldTelefrag(spawnpoint.origin)) {
      dangerDist -= 200;
    }

    if(isDefined(level.artilleryDangerCenters)) {
      airstrikeDanger = maps\mp\killstreaks\_airstrike::getAirstrikeDanger(spawnpoint.origin);
      if(airstrikeDanger > 0) {
        dangerDist = 0;
      }
    }

    if(level.teambased) {
      if(spawnpoint.sights[enemyTeam] > 0) {
        dangerDist = 0;
      }
    } else {
      if(spawnpoint.sights > 0) {
        dangerDist = 0;
      }
    }

    if(!isDefined(safestSpawnpoint) || dangerDist > safestDangerDist) {
      safestSpawnpoint = spawnpoint;
      safestDangerDist = dangerDist;
    }
  }

  assert(isDefined(safestSpawnpoint));
  if(!isDefined(safestSpawnpoint)) {
    safestSpawnpoint = spawnpoints[randomint(spawnpoints.size)];
    safestSpawnpoint.safeSpawnDangerDist = 500;
  } else {
    safestSpawnpoint.safeSpawnDangerDist = safestDangerDist;
  }

  return safestSpawnpoint;
}

getSpawnpoint_DM(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  Spawnlogic_Begin();

  initWeights(spawnpoints);

  aliveplayers = getAllOtherPlayers();

  idealDist = 1600;
  badDist = 1200;

  if(aliveplayers.size > 0) {
    for(i = 0; i < spawnpoints.size; i++) {
      totalDistFromIdeal = 0;
      nearbyBadAmount = 0;
      for(j = 0; j < aliveplayers.size; j++) {
        dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);

        if(dist < badDist) {
          nearbyBadAmount += (badDist - dist) / badDist;
        }

        distfromideal = abs(dist - idealDist);
        totalDistFromIdeal += distfromideal;
      }
      avgDistFromIdeal = totalDistFromIdeal / aliveplayers.size;

      wellDistancedAmount = (idealDist - avgDistFromIdeal) / idealDist;

      spawnpoints[i].weight = wellDistancedAmount - nearbyBadAmount * 2 + randomfloat(.2);
    }
  }

  carePackages = getEntArray("care_package", "targetname");

  for(i = 0; i < spawnpoints.size; i++) {
    if(carePackages.size && !canspawn(spawnpoints[i].origin)) {
      spawnpoints[i].weight -= 500000;
    }
  }

  if(isDefined(self.predictedSpawnPoint) && isDefined(self.predictedSpawnPoint.weight)) {
    self.predictedSpawnPoint.weight += 100;

    self.predictedSpawnPoint.spawnData[self.predictedSpawnPoint.spawnData.size] = "Predicted: 100";
  }

  avoidSamespawn();

  avoidWeaponDamage(spawnpoints);
  avoidVisibleEnemies(spawnpoints, false);

  return getSpawnpoint_Final(spawnpoints);
}
Spawnlogic_Begin() {
  level.debugSpawning = (getdvarint("scr_spawnpointdebug") > 0);
}
init() {
  setDevDvarIfUninitialized("scr_spawnpointdebug", "0");
  setDevDvarIfUninitialized("scr_killbots", 0);
  setDevDvarIfUninitialized("scr_killbottimer", 0);

  thread loopbotspawns();

  level.spawnlogic_deaths = [];

  level.spawnlogic_spawnkills = [];
  level.players = [];
  level.grenades = [];
  level.pipebombs = [];
  level.turrets = [];
  level.helis = [];
  level.tanks = [];

  level.teamSpawnPoints["axis"] = [];
  level.teamSpawnPoints["allies"] = [];

  level thread trackGrenades();

  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  if(isDefined(level.safespawns)) {
    for(i = 0; i < level.safespawns.size; i++) {
      level.safespawns[i] spawnPointInit();
    }
  }

  if(getdvarint("scr_spawnpointdebug") > 0) {
    thread profileDebug();

    thread drawRecordedSpawnData();
  }
  thread watchSpawnProfile();
  thread spawnGraphCheck();
  thread sightCheckCost();
}

sightCheckCost() {
  traceCount = 30;

  for(;;) {
    prof_begin("sight_check_cost");

    traceType = getDvar("scr_debugcost");

    if(traceType == "bullet" && isDefined(level.players[0])) {
      for(i = 0; i < traceCount; i++) {
        bulletTracePassed(level.players[0].origin + (0, 0, 50), (0, 0, 0), false, undefined);
      }
    } else if(traceType == "damagecone" && isDefined(level.players[0])) {
      for(i = 0; i < traceCount; i++) {
        level.players[0] damageConeTrace((0, 0, 0));
      }
    } else if(traceType == "sightcone" && isDefined(level.players[0])) {
      for(i = 0; i < traceCount; i++) {
        level.players[0] sightConeTrace((0, 0, 0));
      }
    } else {
      wait(1.0);
    }

    prof_end("sight_check_cost");

    wait(0.05);
  }
}

watchSpawnProfile() {
  while(1) {
    while(getDvar("scr_spawnprofile") == "" || getDvar("scr_spawnprofile") == "0") {
      wait(0.05);
    }

    thread spawnProfile();

    while(getDvar("scr_spawnprofile") != "" && getDvar("scr_spawnprofile") != "0") {
      wait(0.05);
    }

    level notify("stop_spawn_profile");
  }
}

spawnProfile() {
  level endon("stop_spawn_profile");

  spawnObj = spawnStruct();

  while(1) {
    dvarString = getDvar("scr_spawnprofile");

    if(dvarString != "allies" && dvarString != "axis") {
      if(cointoss()) {
        dvarString = "allies";
      } else {
        dvarString = "axis";
      }
    }

    spawnObj.team = dvarString;
    spawnObj.pers["team"] = dvarString;

    spawnObj getSpawnpoint_NearTeam(level.spawnpoints);
    wait(0.05);
  }
}

spawnGraphCheck() {
  while(1) {
    if(getdvarint("scr_spawngraph") < 1) {
      wait 3;
      continue;
    }
    thread spawnGraph();
    while(getdvarint("scr_spawngraph") >= 1) {
      wait .2;
      continue;
    }
    level notify("end_spawn_graph");
    level notify("spawn_graph_stop_draw");
  }
}

spawnGraph() {
  level endon("end_spawn_graph");

  w = 20;
  h = 20;
  weightscale = .1;
  fakespawnpoints = [];

  corners = getEntArray("minimap_corner", "targetname");
  if(corners.size != 2) {
    println("^1 can't spawn graph: no minimap corners");
    return;
  }
  min = corners[0].origin;
  max = corners[0].origin;
  if(corners[1].origin[0] > max[0]) {
    max = (corners[1].origin[0], max[1], max[2]);
  } else {
    min = (corners[1].origin[0], min[1], min[2]);
  }
  if(corners[1].origin[1] > max[1]) {
    max = (max[0], corners[1].origin[1], max[2]);
  } else {
    min = (min[0], corners[1].origin[1], min[2]);
  }

  i = 0;
  for(y = 0; y < h; y++) {
    yamnt = y / (h - 1);
    for(x = 0; x < w; x++) {
      xamnt = x / (w - 1);
      fakespawnpoints[i] = spawnStruct();
      fakespawnpoints[i].origin = (min[0] * xamnt + max[0] * (1 - xamnt), min[1] * yamnt + max[1] * (1 - yamnt), min[2]);
      fakespawnpoints[i].angles = (0, 0, 0);

      fakespawnpoints[i].forward = anglesToForward(fakespawnpoints[i].angles);
      fakespawnpoints[i].sightTracePoint = fakespawnpoints[i].origin;
      fakespawnpoints[i].outside = true;
      fakespawnpoints[i].secondfloor = false;
      fakespawnpoints[i].fake = true;

      i++;
    }
  }

  didweights = false;

  while(1) {
    spawni = 0;
    numiters = 10;
    for(i = 0; i < numiters; i++) {
      if(!level.players.size || !isDefined(level.players[0].team) || level.players[0].team == "spectator" || !isDefined(level.players[0].class)) {
        break;
      }

      endspawni = spawni + fakespawnpoints.size / numiters;
      if(i == numiters - 1) {
        endspawni = fakespawnpoints.size;
      }

      for(; spawni < endspawni; spawni++) {
        spawnPointUpdate(fakespawnpoints[spawni]);
      }

      wait .05;
    }

    if(!level.players.size || !isDefined(level.players[0].team) || level.players[0].team == "spectator" || !isDefined(level.players[0].class)) {
      wait 1;
      continue;
    }

    level.players[0] getSpawnpoint_NearTeam(fakespawnpoints);

    for(i = 0; i < fakespawnpoints.size; i++) {
      setupSpawnGraphPoint(fakespawnpoints[i], weightscale);
    }

    didweights = true;

    level.players[0] drawSpawnGraph(fakespawnpoints, w, h, weightscale);

    wait .05;
  }
}

drawSpawnGraph(fakespawnpoints, w, h, weightscale) {
  level notify("spawn_graph_stop_draw");

  i = 0;
  for(y = 0; y < h; y++) {
    yamnt = y / (h - 1);
    for(x = 0; x < w; x++) {
      xamnt = x / (w - 1);

      if(y > 0) {
        thread spawnGraphLine(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
      }
      if(x > 0) {
        thread spawnGraphLine(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
      }
      i++;
    }
  }
}

setupSpawnGraphPoint(s1, weightscale) {
  s1.visible = true;
  if(s1.weight < -1000 / weightscale) {
    s1.visible = false;
  }
}

spawnGraphLine(s1, s2, weightscale) {
  if(!s1.visible || !s2.visible) {
    return;
  }
  p1 = s1.origin + (0, 0, s1.weight * weightscale + 100);
  p2 = s2.origin + (0, 0, s2.weight * weightscale + 100);

  level endon("spawn_graph_stop_draw");

  for(;;) {
    line(p1, p2, (1, 1, 1));
    wait .05;
    waittillframeend;
  }
}

loopbotspawns() {
  while(1) {
    if(getdvarint("scr_killbots") < 1) {
      wait 3;
      continue;
    }
    if(!isDefined(level.players)) {
      wait .05;
      continue;
    }

    bots = [];
    for(i = 0; i < level.players.size; i++) {
      if(!isDefined(level.players[i])) {
        continue;
      }
      if(level.players[i].sessionstate == "playing" && issubstr(level.players[i].name, "bot")) {
        bots[bots.size] = level.players[i];
      }
    }
    if(bots.size > 0) {
      if(getdvarint("scr_killbots") == 1) {
        killer = bots[randomint(bots.size)];
        victim = bots[randomint(bots.size)];

        victim thread[[level.callbackPlayerDamage]](killer, killer, 1000, 0, "MOD_RIFLE_BULLET", "none", (0, 0, 0), (0, 0, 0), "none", 0);
      } else {
        numKills = getdvarint("scr_killbots");
        lastVictim = undefined;
        for(index = 0; index < numKills; index++) {
          killer = bots[randomint(bots.size)];
          victim = bots[randomint(bots.size)];

          while(isDefined(lastVictim) && victim == lastVictim) {
            victim = bots[randomint(bots.size)];
          }

          victim thread[[level.callbackPlayerDamage]](killer, killer, 1000, 0, "MOD_RIFLE_BULLET", "none", (0, 0, 0), (0, 0, 0), "none", 0);
          lastVictim = victim;
        }
      }
    }

    if(getdvarfloat("scr_killbottimer") > .05) {
      wait getdvarfloat("scr_killbottimer");
    } else {
      wait .05;
    }
  }
}

spawnWeightDebug(spawnpoints, winner) {
  level notify("stop_spawn_weight_debug");
  level endon("stop_spawn_weight_debug");
  while(1) {
    if(getdvarint("scr_spawnpointdebug") == 0) {
      wait(3);
      continue;
    }

    textoffset = (0, 0, -12);
    for(i = 0; i < spawnpoints.size; i++) {
      amnt = 1 * (1 - spawnpoints[i].weight / (-100000));
      if(amnt < 0) amnt = 0;
      if(amnt > 1) amnt = 1;

      orig = spawnpoints[i].origin + (0, 0, 80);

      print3d(orig, int(spawnpoints[i].weight), (1, amnt, .5));
      orig += textoffset;

      if(spawnpoints[i] == winner) {
        print3d(orig, "Spawned " + self.name + " here", (1, amnt, .5));
        orig += textoffset;
      }

      if(isDefined(spawnpoints[i].spawnData)) {
        for(j = 0; j < spawnpoints[i].spawnData.size; j++) {
          print3d(orig, spawnpoints[i].spawnData[j], (.5, .5, .5));
          orig += textoffset;
        }
      }

      if(spawnpoints[i].weight > -1000) {
        height = (spawnpoints[i].weight + 1000) / 10;
      }

      amnt = spawnpoints[i].weight / 2000;
      if(amnt < 0) amnt = 0;
      if(amnt > 1) amnt = 1;

      color = (1 - amnt, 1, 0);

      pt1 = spawnpoints[i].origin + (0, 0, 95);
      pt2 = spawnpoints[i].origin + (30, 0, 95);
      pt3 = pt1 + (0, 0, height);
      pt4 = pt2 + (0, 0, height);
      line(pt1, pt2, color);
      line(pt1, pt3, color);
      line(pt2, pt4, color);
      line(pt3, pt4, color);

      if(spawnpoints[i] == winner) {
        checkpt1 = pt3 + (0, 0, 30);
        checkpt2 = pt3 + (10, 0, 10);
        checkpt3 = pt3 + (30, 0, 50);

        line(checkpt1, checkpt2, color);
        line(checkpt2, checkpt3, color);
      }
    }
    wait(.05);
  }
}

profileDebug() {
  while(1) {
    if(getDvar("scr_spawnpointprofile") != "1") {
      wait(3);
      continue;
    }

    for(i = 0; i < level.spawnpoints.size; i++) {
      level.spawnpoints[i].weight = randomint(10000);
    }
    if(level.players.size > 0) {
      level.players[randomint(level.players.size)] getSpawnpoint_NearTeam(level.spawnpoints);
    }

    wait(.05);
  }
}

debugNearbyPlayers(players, origin) {
  if(getdvarint("scr_spawnpointdebug") == 0) {
    return;
  }
  starttime = gettime();
  while(1) {
    for(i = 0; i < players.size; i++) {
      line(players[i].origin, origin, (.5, 1, .5));
    }
    if(gettime() - starttime > 5000) {
      return;
    }
    wait .05;
  }
}

trackGrenades() {
  while(1) {
    level.grenades = getEntArray("grenade", "classname");
    wait .05;
  }
}

isPointVulnerable(playerorigin) {
  pos = self.origin + level.claymoremodelcenteroffset;
  playerpos = playerorigin + (0, 0, 32);
  distsqrd = distancesquared(pos, playerpos);

  forward = anglesToForward(self.angles);

  if(distsqrd < level.claymoreDetectionRadius * level.claymoreDetectionRadius) {
    playerdir = vectornormalize(playerpos - pos);
    angle = acos(vectordot(playerdir, forward));
    if(angle < level.claymoreDetectionConeAngle) {
      return true;
    }
  }
  return false;
}

avoidWeaponDamage(spawnpoints) {
  weaponDamagePenalty = 100000;
  if(getDvar("scr_spawnpointweaponpenalty") != "" && getDvar("scr_spawnpointweaponpenalty") != "0") {
    weaponDamagePenalty = getdvarfloat("scr_spawnpointweaponpenalty");
  }

  mingrenadedistsquared = 250 * 250;

  for(i = 0; i < spawnpoints.size; i++) {
    for(j = 0; j < level.grenades.size; j++) {
      if(!isDefined(level.grenades[j])) {
        continue;
      }

      if(distancesquared(spawnpoints[i].origin, level.grenades[j].origin) < mingrenadedistsquared) {
        spawnpoints[i].weight -= weaponDamagePenalty;

        spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Was near grenade: -" + int(weaponDamagePenalty);
      }
    }

    if(!isDefined(level.artilleryDangerCenters)) {
      continue;
    }
    airstrikeDanger = maps\mp\killstreaks\_airstrike::getAirstrikeDanger(spawnpoints[i].origin);

    if(airstrikeDanger > 0) {
      worsen = airstrikeDanger * weaponDamagePenalty;
      spawnpoints[i].weight -= worsen;

      spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Was near artillery (" + int(airstrikeDanger * 100) + "% danger): -" + int(worsen);
    }
  }

}

spawnPerFrameUpdate() {
  spawnpointindex = 0;

  while(1) {
    wait .05;

    prof_begin("spawn_update");

    if(!isDefined(level.spawnPoints)) {
      return;
    }
    spawnpointindex = (spawnpointindex + 1) % level.spawnPoints.size;

    if(getDvar("scr_spawnpoint_forceindex") != "") {
      spawnpointindex = getdvarint("scr_spawnpoint_forceindex");
    }

    spawnpoint = level.spawnPoints[spawnpointindex];

    spawnPointUpdate(spawnpoint);

    prof_end("spawn_update");
  }
}

adjustSightValue(sightValue) {
  assert(sightValue >= 0);
  assert(sightValue <= 1);
  if(sightValue <= 0) {
    return 0;
  }
  if(sightValue >= 1) {
    return 1;
  }
  return sightValue * 0.5 + 0.25;
}

spawnPointUpdate(spawnpoint) {
  prof_begin(" spawn_update_init");

  if(level.teambased) {
    spawnpoint.sights["axis"] = 0;
    spawnpoint.sights["allies"] = 0;
  } else {
    spawnpoint.sights = 0;
  }

  spawnpointdir = spawnpoint.forward;

  debug = false;

  debug = (getdvarint("scr_spawnpointdebug") > 0);

  spawnpoint notify("debug_stop_LOS");

  spawnpoint.distSum["all"] = 0;
  spawnpoint.distSum["allies"] = 0;
  spawnpoint.distSum["axis"] = 0;

  spawnpoint.weightedDistSum["all"] = 0;
  spawnpoint.weightedDistSum["allies"] = 0;
  spawnpoint.weightedDistSum["axis"] = 0;

  spawnpoint.minDist["all"] = 9999999;
  spawnpoint.minDist["allies"] = 9999999;
  spawnpoint.minDist["axis"] = 9999999;

  spawnpoint.numPlayersAtLastUpdate = 0;

  totalPlayers["all"] = 0;
  totalPlayers["allies"] = 0;
  totalPlayers["axis"] = 0;

  weightSum["all"] = 0;
  weightSum["allies"] = 0;
  weightSum["axis"] = 0;

  winner = undefined;

  curTime = getTime();

  team = "all";
  teambased = level.teambased;

  prof_end(" spawn_update_init");

  prof_begin(" spawn_update_ploop");

  foreach(player in level.players) {
    if(player.sessionstate != "playing") {
      continue;
    }

    diff = player.origin - spawnpoint.origin;
    diff = (diff[0], diff[1], 0);

    weight = 1.0;

    dist = length(diff);

    if(teambased) {
      team = player.team;
    }

    if(dist < spawnpoint.minDist[team]) {
      spawnpoint.minDist[team] = dist;
    }

    if(player.wasTI && curTime - player.spawnTime < 15000) {
      weight *= 0.1;
    }

    if(player.isSniper) {
      weight *= 0.5;
    }

    weightSum[team] += weight;
    spawnpoint.weightedDistSum[team] += dist * weight;

    spawnpoint.distSum[team] += dist;
    spawnpoint.numPlayersAtLastUpdate++;

    totalPlayers[team]++;

    pdir = anglesToForward(player.angles);
    if(vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0) {
      continue;
    }

    if(isDefined(spawnpoint.fake)) {
      continue;
    }

    prof_begin(" spawn_update_trace");
    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, player.origin + (0, 0, 50));
    prof_end(" spawn_update_trace");

    spawnpoint.lastSightTraceTime = gettime();

    if(sightValue > 0) {
      sightValue = adjustSightValue(sightvalue);
      if(teamBased) {
        spawnpoint.sights[team] += sightValue;
      } else {
        spawnpoint.sights += sightValue;
      }

      if(debug) {
        spawnpoint thread spawnpointDebugLOS(player.origin + (0, 0, 50));
      }
    }
  }

  prof_end(" spawn_update_ploop");

  prof_begin(" spawn_update_other");

  nearbyEnemyRange = getFloatProperty("scr_spawn_enemyavoiddist", 1000);
  nearbyEnemyPenalty = 2000;

  foreach(team, value in weightSum) {
    if(weightSum[team]) {
      spawnpoint.weightedDistSum[team] = spawnpoint.weightedDistSum[team] / weightSum[team] * totalPlayers[team];
    }

    nearbyPenalty = 0;
    if(spawnpoint.mindist[team] < nearbyEnemyRange) {
      nearbyPenalty = nearbyEnemyPenalty * (1 - spawnpoint.mindist[team] / nearbyEnemyRange);
    }
    spawnpoint.nearbyPenalty[team] = nearbyPenalty;
  }

  foreach(tank in level.tanks) {
    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, tank.origin + (0, 0, 50));
    spawnpoint.lastSightTraceTime = gettime();

    if(sightValue <= 0) {
      continue;
    }
    sightValue = adjustSightValue(sightvalue);
    if(teamBased) {
      spawnpoint.sights[tank.team] += sightValue;
    } else {
      spawnpoint.sights += sightValue;
    }

    if(debug) {
      spawnpoint thread spawnpointDebugLOS(tank.origin + (0, 0, 50));
    }
  }

  foreach(turret in level.turrets) {
    if(!isDefined(turret)) {
      continue;
    }
    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, turret.origin + (0, 0, 50));
    spawnpoint.lastSightTraceTime = gettime();

    if(sightValue <= 0) {
      continue;
    }
    sightValue = adjustSightValue(sightvalue);
    if(teamBased) {
      spawnpoint.sights[turret.team] += sightValue;
    } else {
      spawnpoint.sights += sightValue;
    }

    if(debug) {
      spawnpoint thread spawnpointDebugLOS(turret.origin + (0, 0, 50));
    }
  }

  prof_end(" spawn_update_other");
}

spawnpointDebugLOS(point) {}

getLosPenalty() {
  if(getDvar("scr_spawnpointlospenalty") != "" && getDvar("scr_spawnpointlospenalty") != "0") {
    return getdvarfloat("scr_spawnpointlospenalty");
  }
  return 100000;
}

lastMinuteSightTraces(spawnpoint) {
  prof_begin(" spawn_final_lastminsc");

  closest = undefined;
  closestDistsq = 100000000.0;
  secondClosest = undefined;
  secondClosestDistsq = 100000000.0;
  foreach(player in level.players) {
    if(player.team == self.team && level.teambased) {
      continue;
    }
    if(player.sessionstate != "playing") {
      continue;
    }
    if(player == self) {
      continue;
    }
    distsq = distanceSquared(spawnpoint.origin, player.origin);
    if(distsq < closestDistsq) {
      secondClosest = closest;
      secondClosestDistsq = closestDistsq;

      closest = player;
      closestDistSq = distsq;
    } else if(distsq < secondClosestDistSq) {
      secondClosest = player;
      secondClosestDistSq = distsq;
    }
  }

  if(isDefined(closest)) {
    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, closest.origin + (0, 0, 50));
    if(sightValue > 0) {
      sightValue = adjustSightValue(sightvalue);
      prof_end(" spawn_final_lastminsc");
      return sightValue;
    }
  }
  if(isDefined(secondClosest)) {
    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, secondClosest.origin + (0, 0, 50));
    if(sightValue > 0) {
      sightValue = adjustSightValue(sightvalue);
      prof_end(" spawn_final_lastminsc");
      return sightValue;
    }
  }

  prof_end(" spawn_final_lastminsc");
  return 0;
}

avoidVisibleEnemies(spawnpoints, teambased) {
  lospenalty = getLosPenalty();

  otherteam = "axis";
  if(self.team == "axis") {
    otherteam = "allies";
  }

  if(teambased) {
    foreach(spawnpoint in spawnpoints) {
      penalty = lospenalty * spawnpoint.sights[otherteam];
      spawnpoint.weight -= penalty;

      if(penalty > 0) {
        spawnpoint.spawnData[spawnpoint.spawnData.size] = "Sight traces: -" + int(penalty);
      }
    }
  } else {
    foreach(spawnpoint in spawnpoints) {
      penalty = lospenalty * spawnpoint.sights;
      spawnpoint.weight -= penalty;

      if(penalty > 0) {
        spawnpoint.spawnData[spawnpoint.spawnData.size] = "Sight traces: -" + int(penalty);
      }
    }

    otherteam = "all";
  }

  foreach(spawnpoint in spawnpoints) {
    spawnpoint.weight -= spawnpoint.nearbyPenalty[otherteam];

    if(spawnpoint.nearbyPenalty[otherteam] != 0) {
      spawnpoint.spawnData[spawnpoint.spawnData.size] = "Nearest enemy at " + int(spawnpoint.minDist[otherteam]) + " units: -" + int(spawnpoint.nearbyPenalty[otherteam]);
    }

    if(positionWouldTelefrag(spawnpoint.origin)) {
      telefragCount = 1;

      foreach(alternate in spawnpoint.alternates) {
        if(positionWouldTelefrag(alternate)) {
          telefragCount++;
        } else {
          break;
        }
      }

      penalty = 100000;
      if(telefragCount < spawnpoint.alternates.size + 1) {
        penalty = 1500 * telefragCount;
        if(isDefined(self.forceSpawnNearTeammates)) {
          penalty = 0;
        }
      }

      spawnpoint.weight -= penalty;

      spawnpoint.spawnData[spawnpoint.spawnData.size] = "Would telefrag " + telefragCount + " times: -" + penalty;
    }
  }

}

avoidSpawnReuse(spawnpoints, teambased) {
  time = getTime();

  maxtime = 10 * 1000;
  maxdistSq = 1024 * 1024;

  foreach(spawnpoint in spawnpoints) {
    lastspawnedplayer = spawnpoint.lastspawnedplayer;

    if(!isalive(lastspawnedplayer)) {
      continue;
    }
    if(teambased && spawnpoint.lastspawnedplayer.team == self.team) {
      continue;
    }
    if(spawnpoint.lastspawnedplayer == self) {
      continue;
    }
    timepassed = time - spawnpoint.lastspawntime;
    if(timepassed < maxtime) {
      distSq = distanceSquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
      if(distSq < maxdistSq) {
        worsen = 5000 * (1 - distSq / maxdistSq) * (1 - timepassed / maxtime);
        spawnpoint.weight -= worsen;

        spawnpoint.spawnData[spawnpoint.spawnData.size] = "Recently spawned enemy: -" + worsen;
      } else
        spawnpoint.lastspawnedplayer = undefined;
    } else
      spawnpoint.lastspawnedplayer = undefined;
  }
}

avoidSamespawn() {
  spawnpoint = self.lastspawnpoint;

  if(!isDefined(spawnpoint) || !isDefined(spawnpoint.weight)) {
    return;
  }

  spawnpoint.weight -= 1000;

  spawnpoint.spawnData[spawnpoint.spawnData.size] = "Was last spawnpoint: -1000";
}