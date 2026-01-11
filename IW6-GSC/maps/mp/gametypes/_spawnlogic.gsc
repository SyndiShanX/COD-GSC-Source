/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnlogic.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level.killstreakSpawnShield = 5000;
  level.forceBuddySpawn = false;
  level.supportBuddySpawn = true;
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  level.clientTraceSpawnClass = undefined;
  level.disableClientSpawnTraces = false;
  level.numPlayersWaitingToSpawn = 0;
  level.numPlayersWaitingToEnterKillcam = 0;

  level.debugSpawning = false;

  level.players = [];
  level.participants = [];
  level.characters = [];
  level.spawnPointArray = [];
  level.grenades = [];
  level.missiles = [];
  level.carePackages = [];
  level.helis = [];
  level.turrets = [];
  level.tanks = [];
  level.scramblers = [];
  level.ims = [];
  level.ugvs = [];
  level.ballDrones = [];

  level thread onPlayerConnect();
  level thread spawnPointUpdate();
  level thread trackGrenades();
  level thread trackMissiles();
  level thread trackCarePackages();
  level thread trackHostMigrationEnd();

  if(GetDvarInt("scr_frontlineSpawns", 0) == 1) {
    if(level.gameType == "war" || level.gameType == "conf" || level.gameType == "cranked") {
      level thread maps\mp\gametypes\_spawnfactor::spawnFrontLineThink();
    }
  } else {
    anchorSpawnActive = Int(GetDvar("scr_anchorSpawns"));

    if(level.gameType == "war" || level.gameType == "conf" || level.gameType == "cranked") {
      level thread maps\mp\gametypes\_spawnfactor::correctHomogenization();
    }
  }

  for(i = 0; i < level.teamNameList.size; i++) {
    level.teamSpawnPoints[level.teamNameList[i]] = [];
  }

  maps\mp\gametypes\_spawnfactor::init_spawn_factors();
}

trackHostMigrationEnd() {
  while(true) {
    self waittill("host_migration_end");

    foreach(player in level.participants) {
      player.canPerformClientTraces = canPerformClientTraces(player);
    }
  }
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    level thread startClientSpawnPointTraces(player);
    level thread eyesOnSightChecks(player);
  }
}

eyesOnSightChecks(player) {
  player endon("disconnect");

  while(true) {
    if((player.sessionstate == "playing") && isReallyAlive(player) && !(player _hasPerk("specialty_gpsjammer"))) {
      sighted = false;
      sightingPlayers = player GetPlayersSightingMe();

      foreach(otherPlayer in sightingPlayers) {
        if(level.teamBased && (otherPlayer.team == player.team)) {
          continue;
        }

        if((player.sessionstate != "playing") || !isReallyAlive(player)) {
          continue;
        }

        sighted = true;
        player notify("eyesOn");

        break;
      }
      player MarkForEyesOn(sighted);

    } else {
      player MarkForEyesOn(false);
      player notify("eyesOff");
    }

    wait(0.05);
  }
}

startClientSpawnPointTraces(player) {
  player endon("disconnect");

  player.canPerformClientTraces = canPerformClientTraces(player);

  if(!player.canPerformClientTraces) {
    return;
  }
  wait(0.05);

  player SetClientSpawnSightTraces(level.clientTraceSpawnClass);
}

canPerformClientTraces(player) {
  if(level.disableClientSpawnTraces) {
    return false;
  }

  if(!isDefined(level.clientTraceSpawnClass)) {
    return false;
  }

  if(IsAI(player)) {
    return false;
  }

  if(player IsHost()) {
    return false;
  }

  return true;
}

addStartSpawnPoints(spawnPointName) {
  spawnPoints = getSpawnpointArray(spawnPointName);

  if(!spawnPoints.size) {
    assertmsg("^1Error: No " + spawnPointName + " spawnpoints found in level!");
    return;
  }

  if(!isDefined(level.startSpawnPoints)) {
    level.startSpawnPoints = [];
  }

  for(index = 0; index < spawnPoints.size; index++) {
    spawnPoints[index] spawnPointInit();
    spawnPoints[index].selected = false;
    level.startSpawnPoints[level.startSpawnPoints.size] = spawnPoints[index];
  }

  foreach(spawnPoint in spawnPoints) {
    spawnPoint.inFront = true;
    forwardDir = anglesToForward(spawnPoint.angles);

    foreach(adjacentSpawn in spawnPoints) {
      if(spawnPoint == adjacentSpawn) {
        continue;
      }
      vectorToAdjacent = VectorNormalize(adjacentSpawn.origin - spawnPoint.origin);
      dotToAdjacent = VectorDot(forwardDir, vectorToAdjacent);

      if(dotToAdjacent > 0.86) {
        spawnPoint.inFront = false;
        break;
      }
    }
  }
}

addSpawnPoints(team, spawnPointName, isSetOptional) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamSpawnPoints[team])) {
    level.teamSpawnPoints[team] = [];
  }

  if(!isDefined(isSetOptional)) {
    isSetOptional = false;
  }

  newSpawnPoints = [];
  newSpawnPoints = getSpawnpointArray(spawnPointName);

  if(!isDefined(level.clientTraceSpawnClass)) {
    level.clientTraceSpawnClass = spawnPointName;
  }

  AssertEx((level.clientTraceSpawnClass == spawnPointName), "only one spawn point class allowed");

  if(!newSpawnPoints.size && !isSetOptional) {
    assertmsg("^1Error: No " + spawnPointName + " spawnpoints found in level!");
    return;
  }

  foreach(spawnPoint in newSpawnPoints) {
    if(!isDefined(spawnpoint.inited)) {
      spawnpoint spawnPointInit();
      level.spawnpoints[level.spawnpoints.size] = spawnpoint;

      bbprint("spawns", "name %s x %f y %f z %f", "initialized", spawnpoint.origin[0], spawnpoint.origin[1], spawnpoint.origin[2]);

    }

    level.teamSpawnPoints[team][level.teamSpawnPoints[team].size] = spawnPoint;
  }
}

spawnPointInit() {
  spawnpoint = self;

  level.spawnMins = expandMins(level.spawnMins, spawnpoint.origin);
  level.spawnMaxs = expandMaxs(level.spawnMaxs, spawnpoint.origin);

  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sightTracePoint = spawnpoint.origin + (0, 0, 50);
  spawnpoint.lastspawntime = gettime();
  spawnpoint.outside = true;
  spawnpoint.inited = true;
  spawnpoint.alternates = [];

  skyHeight = 1024;

  if(!bullettracepassed(spawnpoint.sightTracePoint, spawnpoint.sightTracePoint + (0, 0, skyHeight), false, undefined)) {
    startpoint = spawnpoint.sightTracePoint + spawnpoint.forward * 100;
    if(!bullettracepassed(startpoint, startpoint + (0, 0, skyHeight), false, undefined)) {
      spawnpoint.outside = false;
    }
  }

  right = anglesToRight(spawnpoint.angles);

  AddAlternateSpawnpoint(spawnpoint, spawnpoint.origin + right * 45);
  AddAlternateSpawnpoint(spawnpoint, spawnpoint.origin - right * 45);

  initSpawnPointValues(spawnpoint);
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

getSpawnpointArray(classname) {
  if(!isDefined(level.spawnPointArray)) {
    level.spawnPointArray = [];
  }

  if(!isDefined(level.spawnPointArray[classname])) {
    level.spawnPointArray[classname] = [];
    level.spawnPointArray[classname] = getSpawnArray(classname);

    foreach(spawnPoint in level.spawnPointArray[classname]) {
      spawnPoint.classname = classname;
    }
  }

  return level.spawnPointArray[classname];
}

getSpawnpoint_Random(spawnPoints) {
  if(!isDefined(spawnPoints)) {
    return undefined;
  }

  randomSpawnPoint = undefined;
  spawnPoints = maps\mp\gametypes\_spawnscoring::checkDynamicSpawns(spawnPoints);
  spawnPoints = array_randomize(spawnPoints);

  foreach(spawnPoint in spawnPoints) {
    randomSpawnPoint = spawnPoint;

    if(Canspawn(randomSpawnPoint.origin) && !PositionWouldTelefrag(randomSpawnPoint.origin)) {
      break;
    }
  }

  return randomSpawnPoint;
}

getSpawnpoint_startspawn(spawnPoints) {
  if(!isDefined(spawnPoints)) {
    return undefined;
  }

  bestSpawn = undefined;

  spawnPoints = maps\mp\gametypes\_spawnscoring::checkDynamicSpawns(spawnPoints);

  foreach(spawnPoint in spawnPoints) {
    if(spawnPoint.selected) {
      continue;
    }
    if(spawnPoint.inFront) {
      bestSpawn = spawnPoint;
      break;
    }

    bestSpawn = spawnPoint;
  }

  if(!isDefined(bestSpawn)) {
    bestSpawn = getSpawnpoint_Random(spawnPoints);
  }

  bestSpawn.selected = true;
  return bestSpawn;
}

getSpawnpoint_NearTeam(spawnpoints, favoredspawnpoints) {
  assertMsg("game mode not supported by the new spawning system");

  while(true) {
    wait(5);
  }
}

trackGrenades() {
  while(true) {
    level.grenades = getEntArray("grenade", "classname");
    wait(0.05);
  }
}

trackMissiles() {
  while(true) {
    level.missiles = getEntArray("rocket", "classname");
    wait(0.05);
  }
}

trackCarePackages() {
  while(true) {
    level.carePackages = getEntArray("care_package", "targetname");
    wait(0.05);
  }
}

getTeamSpawnPoints(team) {
  return level.teamSpawnPoints[team];
}

isPathDataAvailable() {
  if(!isDefined(level.pathDataAvailable)) {
    nodes = GetAllNodes();
    level.pathDataAvailable = (isDefined(nodes) && (nodes.size > 150));
  }

  return level.pathDataAvailable;
}

addToParticipantsArray() {
  assert(IsGameParticipant(self));
  level.participants[level.participants.size] = self;
}

removeFromParticipantsArray() {
  found = false;
  for(entry = 0; entry < level.participants.size; entry++) {
    if(level.participants[entry] == self) {
      found = true;
      while(entry < level.participants.size - 1) {
        level.participants[entry] = level.participants[entry + 1];
        assert(level.participants[entry] != self);
        entry++;
      }
      level.participants[entry] = undefined;
      break;
    }
  }
  assert(found);
}

addToCharactersArray() {
  assert(IsPlayer(self) || IsBot(self) || IsAgent(self));

  if(is_aliens()) {
    for(entry = 0; entry < level.characters.size; entry++) {
      if(level.characters[entry] == self) {
        println("_spawnlogic::addToCharactersArray(): Trying to add e" + self GetEntityNumber() + " to level.characters when it already appears in the array.");

        return;
      }
    }
  }

  level.characters[level.characters.size] = self;
}

removeFromCharactersArray() {
  found = false;
  for(entry = 0; entry < level.characters.size; entry++) {
    if(level.characters[entry] == self) {
      found = true;
      while(entry < level.characters.size - 1) {
        level.characters[entry] = level.characters[entry + 1];
        assert(level.characters[entry] != self);
        entry++;
      }
      level.characters[entry] = undefined;
      break;
    }
  }
  assert(found);
}

spawnPointUpdate() {
  while(!isDefined(level.spawnPoints) || (level.spawnPoints.size == 0)) {
    wait(0.05);
  }

  setDevDvarIfUninitialized("scr_disableClientSpawnTraces", "0");

  setDevDvarIfUninitialized("scr_spawnpointdebug", "0");
  setDevDvarIfUninitialized("scr_forceBuddySpawn", "0");

  level thread spawnPointSightUpdate();
  level thread spawnPointDistanceUpdate();

  while(true) {
    level.debugSpawning = (getdvarint("scr_spawnpointdebug") > 0);
    level.forceBuddySpawn = (getdvarint("scr_forceBuddySpawn") > 0);

    level.disableClientSpawnTraces = (getdvarint("scr_disableClientSpawnTraces") > 0);

    wait(0.05);
  }

}

getActivePlayerList() {
  activePlayerList = [];

  foreach(character in level.characters) {
    if(!isReallyAlive(character)) {
      continue;
    }
    if(IsPlayer(character) && character.sessionstate != "playing") {
      continue;
    }
    if(character maps\mp\killstreaks\_killstreaks::isUsingHeliSniper() && isDefined(character.chopper) && (!isDefined(character.chopper.movedLow) || !character.chopper.movedLow)) {
      continue;
    }
    character.spawnLogicTeam = getSpawnTeam(character);
    if(character.spawnLogicTeam == "spectator") {
      continue;
    }
    if(IsAgent(character) && character.agent_type == "dog") {
      character.spawnLogicTraceHeight = getPlayerTraceHeight(character, true);
      character.spawnTraceLocation = character.origin + (0, 0, character.spawnLogicTraceHeight);
    } else if(!character.canPerformClientTraces) {
      spawnLogicTraceHeight = getPlayerTraceHeight(character);
      spawnTraceLocation = character getEye();
      spawnTraceLocation = (spawnTraceLocation[0], spawnTraceLocation[1], character.origin[2] + spawnLogicTraceHeight);

      character.spawnLogicTraceHeight = spawnLogicTraceHeight;
      character.spawnTraceLocation = spawnTraceLocation;
    }

    activePlayerList[activePlayerList.size] = character;
  }

  return activePlayerList;
}

spawnPointSightUpdate() {
  maxTracePerFrame = 18;
  traceCount = 0;
  fullLoopCompleted = false;

  activePlayerList = getActivePlayerList();

  while(true) {
    if(fullLoopCompleted) {
      wait(0.05);
      traceCount = 0;
      fullLoopCompleted = false;
      activePlayerList = getActivePlayerList();
    }

    spawnPoints = level.spawnPoints;
    spawnPoints = maps\mp\gametypes\_spawnscoring::checkDynamicSpawns(spawnPoints);
    fullLoopCompleted = true;

    foreach(spawnPoint in spawnPoints) {
      clearSpawnPointSightData(spawnpoint);

      foreach(player in activePlayerList) {
        if(spawnpoint.fullSights[player.spawnLogicTeam]) {
          continue;
        }

        if(player.canPerformClientTraces) {
          sightValue = player ClientSpawnSightTracePassed(spawnpoint.index);
        } else {
          sightValue = SpawnSightTrace(spawnpoint, spawnpoint.origin + (0, 0, player.spawnLogicTraceHeight), player.spawnTraceLocation);
          traceCount++;
        }

        if(!sightValue) {
          continue;
        }

        if(sightValue > 0.95) {
          spawnpoint.fullSights[player.spawnLogicTeam]++;
          continue;
        }

        spawnpoint.cornerSights[player.spawnLogicTeam]++;
      }

      additionalSightTraceEntities(spawnpoint, level.turrets);
      additionalSightTraceEntities(spawnpoint, level.ugvs);

      if(shouldSightTraceWait(maxTracePerFrame, traceCount)) {
        wait(0.05);
        traceCount = 0;
        fullLoopCompleted = false;
        activePlayerList = getActivePlayerList();
      }
    }
  }
}

shouldSightTraceWait(maxCount, currentCount) {
  potentialTraceCost = 0;

  foreach(player in level.participants) {
    if(!player.canPerformClientTraces) {
      potentialTraceCost++;
    }
  }

  if((currentCount + potentialTraceCost) > maxCount) {
    return true;
  }

  return false;
}

spawnPointDistanceUpdate() {
  activePlayerList = getActivePlayerList();
  currentTime = getTime();
  waitInterval = 4;
  currentCount = 0;

  while(true) {
    spawnPoints = level.spawnPoints;
    spawnPoints = maps\mp\gametypes\_spawnscoring::checkDynamicSpawns(spawnPoints);

    foreach(spawnPoint in spawnPoints) {
      clearSpawnPointDistanceData(spawnPoint);
      currentCount++;

      foreach(player in activePlayerList) {
        distSquared = DistanceSquared(player.origin, spawnpoint.origin);

        if(distSquared < spawnpoint.minDistSquared[player.spawnLogicTeam]) {
          spawnpoint.minDistSquared[player.spawnLogicTeam] = distSquared;
        }

        if(player.spawnLogicTeam == "spectator") {
          continue;
        }
        spawnpoint.distSumSquared[player.spawnLogicTeam] += distSquared;
        spawnpoint.distSumSquaredCapped[player.spawnLogicTeam] += min(distSquared, maps\mp\gametypes\_spawnfactor::maxPlayerSpawnInfluenceDistSquared());
        spawnpoint.totalPlayers[player.spawnLogicTeam]++;
      }

      if(isDefined(level.alliesWeightOrg)) {
        anchorWeight = 25;

        for(i = 0; i < anchorWeight; i++) {
          distSquared = DistanceSquared(level.alliesWeightOrg, spawnpoint.origin);
          spawnpoint.totalPlayers["allies"]++;
          spawnpoint.distSumSquared["allies"] += distSquared;
          spawnpoint.distSumSquaredCapped["allies"] += distSquared;

          distSquared = DistanceSquared(level.axisWeightOrg, spawnpoint.origin);
          spawnpoint.totalPlayers["axis"]++;
          spawnpoint.distSumSquared["axis"] += distSquared;
          spawnpoint.distSumSquaredCapped["axis"] += distSquared;
        }
      }

      if(currentCount == waitInterval) {
        wait(0.05);
        activePlayerList = getActivePlayerList();
        currentTime = getTime();
        currentCount = 0;
      }
    }
  }
}

getSpawnTeam(ent) {
  team = "all";

  if(level.teambased) {
    team = ent.team;
  }

  return team;
}

initSpawnPointValues(spawnPoint) {
  clearSpawnPointSightData(spawnPoint);
  clearSpawnPointDistanceData(spawnPoint);
}

clearSpawnPointSightData(spawnPoint) {
  if(level.teambased) {
    foreach(teamName in level.teamNameList) {
      clearTeamSpawnPointSightData(spawnPoint, teamName);
    }
  } else {
    clearTeamSpawnPointSightData(spawnPoint, "all");
  }
}

clearSpawnPointDistanceData(spawnPoint) {
  if(level.teambased) {
    foreach(teamName in level.teamNameList) {
      clearTeamSpawnPointDistanceData(spawnPoint, teamName);
    }
  } else {
    clearTeamSpawnPointDistanceData(spawnPoint, "all");
  }
}

clearTeamSpawnPointSightData(spawnPoint, team) {
  spawnPoint.fullSights[team] = 0;
  spawnPoint.cornerSights[team] = 0;
}

clearTeamSpawnPointDistanceData(spawnPoint, team) {
  spawnPoint.distSumSquared[team] = 0;
  spawnPoint.distSumSquaredCapped[team] = 0;
  spawnPoint.minDistSquared[team] = 9999999;
  spawnPoint.totalPlayers[team] = 0;
}

getPlayerTraceHeight(player, bReturnMaxHeight) {
  if(isDefined(bReturnMaxHeight) && bReturnMaxHeight) {
    return 64;
  }

  stance = player GetStance();

  if(stance == "stand") {
    return 64;
  }

  if(stance == "crouch") {
    return 44;
  }

  return 32;
}

additionalSightTraceEntities(spawnPoint, entArray) {
  foreach(ent in entArray) {
    if(!isDefined(ent)) {
      continue;
    }

    team = getSpawnTeam(ent);

    if(spawnpoint.fullSights[team]) {
      continue;
    }

    sightValue = SpawnSightTrace(spawnpoint, spawnpoint.sightTracePoint, ent.origin + (0, 0, 50));

    if(!sightValue) {
      continue;
    }

    if(sightValue > 0.95) {
      spawnpoint.fullSights[team]++;
      continue;
    }

    spawnpoint.cornerSights[team]++;
  }
}

finalizeSpawnpointChoice(spawnpoint) {
  time = getTime();

  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;

  spawnpoint.lastspawntime = time;
  spawnpoint.lastspawnteam = self.team;

  bbprint("spawns", "name %s x %f y %f z %f buddyspawn %i", "selected", spawnpoint.origin[0], spawnpoint.origin[1], spawnpoint.origin[2], spawnpoint.buddySpawn);

  spawningDebugHUD(spawnpoint);
}

expandSpawnpointBounds(classname) {
  spawnPoints = getSpawnpointArray(classname);
  for(index = 0; index < spawnPoints.size; index++) {
    level.spawnMins = expandMins(level.spawnMins, spawnPoints[index].origin);
    level.spawnMaxs = expandMaxs(level.spawnMaxs, spawnPoints[index].origin);
  }
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

findBoxCenter(mins, maxs) {
  center = (0, 0, 0);
  center = maxs - mins;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
  return center;
}

setMapCenterForDev() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::expandSpawnpointBounds("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::expandSpawnpointBounds("mp_tdm_spawn_axis_start");
  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

shouldUseTeamStartspawn() {
  return level.inGracePeriod && (!isDefined(level.numKills) || level.numKills == 0);
}

spawningDebugHUD(spawnPoint) {
  if(!allowDebugHud()) {
    destroySpawningDebugHUD();
    return;
  }

  createSpawningHUD();

  spawningHUDColor = (0, 1, 0);

  if(isDefined(spawnPoint.buddySpawn) && spawnPoint.buddySpawn) {
    spawningHUDColor = (0.5, 0.5, 1);
    spawnPoint.numberOfPossibleSpawnChoices = 999;
  }

  if(isDefined(spawnPoint.numberOfPossibleSpawnChoices)) {
    self.spawningAvailableNum setValue(spawnPoint.numberOfPossibleSpawnChoices);

    if(spawnPoint.numberOfPossibleSpawnChoices < 3) {
      spawningHUDColor = (1, 0, 0);
    }
  }

  if(isDefined(spawnPoint.totalScore)) {
    self.spawningScoreNum setValue(spawnPoint.totalScore);
  }

  setSpawningHUDColor(spawningHUDColor);
}

allowDebugHud() {
  if(!level.debugSpawning) {
    return false;
  }

  if(level.inGracePeriod) {
    return false;
  }

  if(level.players.size == 1) {
    return false;
  }

  switch (level.gametype) {
    case "war":
    case "conf":
    case "dom":
    case "dm":
    case "blitz":
      return true;
    default:
      return false;
  }

  returnfalse;
}

setSpawningHUDColor(color) {
  self.spawningAvailableText.color = color;
  self.spawningAvailableNum.color = color;
  self.spawningScoreText.color = color;
  self.spawningScoreNum.color = color;
}

destroySpawningDebugHUD() {
  if(isDefined(self.spawningAvailableText)) {
    self.spawningAvailableText Destroy();
  }

  if(isDefined(self.spawningAvailableNum)) {
    self.spawningAvailableNum Destroy();
  }

  if(isDefined(self.spawningScoreText)) {
    self.spawningScoreText Destroy();
  }

  if(isDefined(self.spawningScoreNum)) {
    self.spawningScoreNum Destroy();
  }
}

createSpawningHUD() {
  if(!isDefined(self.spawningAvailableText)) {
    self.spawningAvailableText = createSpawningHUDElement(0, 200);
    self.spawningAvailableText setText("available spawns- ");
  }

  if(!isDefined(self.spawningAvailableNum)) {
    self.spawningAvailableNum = createSpawningHUDElement(95, 200);
    self.spawningAvailableNum setValue(0);
  }

  if(!isDefined(self.spawningScoreText)) {
    self.spawningScoreText = createSpawningHUDElement(0, 212);
    self.spawningScoreText setText("spawn point score - ");
  }

  if(!isDefined(self.spawningScoreNum)) {
    self.spawningScoreNum = createSpawningHUDElement(95, 212);
    self.spawningScoreNum setValue(0);
  }
}

createSpawningHUDElement(xOffset, yOffset) {
  spawningHUD = newClientHudElem(self);

  spawningHUD.archived = false;
  spawningHUD.x = -100 + xOffset;
  spawningHUD.y = 10 + yOffset;
  spawningHUD.alignX = "left";
  spawningHUD.alignY = "top";
  spawningHUD.horzAlign = "right";
  spawningHUD.vertAlign = "top";
  spawningHUD.sort = 10;
  spawningHUD.font = "small";
  spawningHUD.foreground = true;
  spawningHUD.hideWhenInMenu = true;
  spawningHUD.fontscale = 1.2;
  spawningHUD.alpha = 1;

  return spawningHUD;
}
# /