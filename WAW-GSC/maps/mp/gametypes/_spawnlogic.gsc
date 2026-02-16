/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnlogic.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
  }
}

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

addSpawnPoints(team, spawnPointName) {
  addSpawnPointClassName(spawnPointName);

  oldSpawnPoints = [];
  if(level.teamSpawnPoints[team].size) {
    oldSpawnPoints = level.teamSpawnPoints[team];
  }

  level.teamSpawnPoints[team] = getSpawnpointArray(spawnPointName);

  if(!level.teamSpawnPoints[team].size) {
    println("^1No " + spawnPointName + " spawnpoints found in level!");
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
  addSpawnPointClassName(spawnPointName);

  spawnPoints = getSpawnpointArray(spawnPointName);

  if(!isDefined(level.extraspawnpointsused)) {
    level.extraspawnpointsused = [];
  }

  if(!spawnPoints.size) {
    println("^1No " + spawnPointName + " spawnpoints found in level!");
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

addSpawnPointClassName(spawnPointClassName) {
  if(!isDefined(level.spawn_point_class_names)) {
    level.spawn_point_class_names = [];
  }

  level.spawn_point_class_names[level.spawn_point_class_names.size] = spawnPointClassName;
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

spawnPointInit() {
  spawnpoint = self;
  origin = spawnpoint.origin;

  if(!level.spawnMinsMaxsPrimed) {
    level.spawnMins = origin;
    level.spawnMaxs = origin;
    level.spawnMinsMaxsPrimed = true;
  } else {
    level.spawnMins = expandMins(level.spawnMins, origin);
    level.spawnMaxs = expandMaxs(level.spawnMaxs, origin);
  }

  spawnpoint placeSpawnpoint();
  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sightTracePoint = spawnpoint.origin + (0, 0, 50);

  spawnpoint.inited = true;
}

getTeamSpawnPoints(team) {
  return level.teamSpawnPoints[team];
}
getSpawnpoint_Final(spawnpoints, useweights) {
  bestspawnpoint = undefined;

  if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
    return undefined;
  }

  if(!isDefined(useweights)) {
    useweights = true;
  }

  if(useweights) {
    bestspawnpoint = getBestWeightedSpawnpoint(spawnpoints);
    thread spawnWeightDebug(spawnpoints);
  } else {
    for(i = 0; i < spawnpoints.size; i++) {
      if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i]) {
        continue;
      }

      if(positionWouldTelefrag(spawnpoints[i].origin)) {
        continue;
      }

      bestspawnpoint = spawnpoints[i];
      break;
    }
    if(!isDefined(bestspawnpoint)) {
      if(isDefined(self.lastspawnpoint) && !positionWouldTelefrag(self.lastspawnpoint.origin)) {
        for(i = 0; i < spawnpoints.size; i++) {
          {}
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

  self finalizeSpawnpointChoice(bestspawnpoint);

  self storeSpawnData(spawnpoints, useweights, bestspawnpoint);

  return bestspawnpoint;
}

finalizeSpawnpointChoice(spawnpoint) {
  time = getTime();

  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;
  spawnpoint.lastspawnedplayer = self;
  spawnpoint.lastspawntime = time;
}

getBestWeightedSpawnpoint(spawnpoints) {
  maxSightTracedSpawnpoints = 3;
  for(
    try = 0;
    try <= maxSightTracedSpawnpoints;
    try ++) {
    bestspawnpoints = [];
    bestweight = undefined;
    bestspawnpoint = undefined;
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(bestweight) || spawnpoints[i].weight > bestweight) {
        if(positionWouldTelefrag(spawnpoints[i].origin)) {
          continue;
        }

        bestspawnpoints = [];
        bestspawnpoints[0] = spawnpoints[i];
        bestweight = spawnpoints[i].weight;
      } else if(spawnpoints[i].weight == bestweight) {
        if(positionWouldTelefrag(spawnpoints[i].origin)) {
          continue;
        }

        bestspawnpoints[bestspawnpoints.size] = spawnpoints[i];
      }
    }
    if(bestspawnpoints.size == 0) {
      return undefined;
    }

    bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];

    if(
      try == maxSightTracedSpawnpoints) {
      return bestspawnpoint;
    }

    if(isDefined(bestspawnpoint.lastSightTraceTime) && bestspawnpoint.lastSightTraceTime == gettime()) {
      return bestspawnpoint;
    }

    if(!lastMinuteSightTraces(bestspawnpoint)) {
      return bestspawnpoint;
    }

    penalty = getLosPenalty();

    if(level.storeSpawnData || level.debugSpawning) {
      bestspawnpoint.spawnData[bestspawnpoint.spawnData.size] = "Last minute sight trace: -" + penalty;
    }

    bestspawnpoint.weight -= penalty;

    bestspawnpoint.lastSightTraceTime = gettime();
  }
}

checkBad(spawnpoint) {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isAlive(player) || player.sessionstate != "playing") {
      continue;
    }
    if(level.teambased && player.pers["team"] == self.pers["team"]) {
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

storeSpawnData(spawnpoints, useweights, bestspawnpoint) {
  if(!isDefined(level.storeSpawnData) || !level.storeSpawnData) {
    return;
  }

  level.storeSpawnData = getdvarint("scr_recordspawndata");
  if(!level.storeSpawnData) {
    return;
  }

  if(!isDefined(level.spawnID)) {
    level.spawnGameID = randomint(100);
    level.spawnID = 0;
  }

  if(bestspawnpoint.classname == "mp_global_intermission") {
    return;
  }

  level.spawnID++;

  file = openfile("spawndata.txt", "append");
  fPrintFields(file, level.spawnGameID + "." + level.spawnID + "," + spawnpoints.size + "," + self.name);

  for(i = 0; i < spawnpoints.size; i++) {
    str = vectostr(spawnpoints[i].origin) + ",";
    if(spawnpoints[i] == bestspawnpoint) {
      str = str + "1,";
    } else {
      str = str + "0,";
    }

    if(!useweights) {
      str += "0,";
    } else {
      str += spawnpoints[i].weight + ",";
    }

    if(!isDefined(spawnpoints[i].spawnData)) {
      spawnpoints[i].spawnData = [];
    }
    if(!isDefined(spawnpoints[i].sightChecks)) {
      spawnpoints[i].sightChecks = [];
    }
    str += spawnpoints[i].spawnData.size + ",";
    for(j = 0; j < spawnpoints[i].spawnData.size; j++) {
      str += spawnpoints[i].spawnData[j] + ",";
    }
    str += spawnpoints[i].sightChecks.size + ",";
    for(j = 0; j < spawnpoints[i].sightChecks.size; j++) {
      str += spawnpoints[i].sightChecks[j].penalty + "," + vectostr(spawnpoints[i].origin) + ",";
    }

    fPrintFields(file, str);
  }

  obj = spawnStruct();
  getAllAlliedAndEnemyPlayers(obj);
  numallies = 0;
  numenemies = 0;
  str = "";
  for(i = 0; i < obj.allies.size; i++) {
    if(obj.allies[i] == self) {
      continue;
    }
    numallies++;
    str += vectostr(obj.allies[i].origin) + ",";
  }
  for(i = 0; i < obj.enemies.size; i++) {
    numenemies++;
    str += vectostr(obj.enemies[i].origin) + ",";
  }
  str = numallies + "," + numenemies + "," + str;
  fPrintFields(file, str);

  otherdata = [];
  if(isDefined(level.bombguy)) {
    index = otherdata.size;
    otherdata[index] = spawnStruct();
    otherdata[index].origin = level.bombguy.origin + (0, 0, 20);
    otherdata[index].text = "Bomb holder";
  } else if(isDefined(level.bombpos)) {
    index = otherdata.size;
    otherdata[index] = spawnStruct();
    otherdata[index].origin = level.bombpos;
    otherdata[index].text = "Bomb";
  }
  if(isDefined(level.flags)) {
    for(i = 0; i < level.flags.size; i++) {
      index = otherdata.size;
      otherdata[index] = spawnStruct();
      otherdata[index].origin = level.flags[i].origin;
      otherdata[index].text = level.flags[i].useObj maps\mp\gametypes\_gameobjects::getOwnerTeam() + " flag";
    }
  }
  str = otherdata.size + ",";
  for(i = 0; i < otherdata.size; i++) {
    str += vectostr(otherdata[i].origin) + "," + otherdata[i].text + ",";
  }
  fPrintFields(file, str);

  closefile(file);

  thisspawnid = level.spawnGameID + "." + level.spawnID;
  if(isDefined(self.thisspawnid)) {}
  self.thisspawnid = thisspawnid;
}

readSpawnData(desiredID, relativepos) {
  file = openfile("spawndata.txt", "read");
  if(file < 0) {
    return;
  }

  oldspawndata = level.curspawndata;
  level.curspawndata = undefined;

  prev = undefined;
  prevThisPlayer = undefined;
  lookingForNextThisPlayer = false;
  lookingForNext = false;

  if(isDefined(relativepos) && !isDefined(oldspawndata)) {
    return;
  }

  while(1) {
    if(freadln(file) <= 0) {
      break;
    }
    data = spawnStruct();

    data.id = fgetarg(file, 0);
    numspawns = int(fgetarg(file, 1));
    if(numspawns > 256) {
      break;
    }
    data.playername = fgetarg(file, 2);

    data.spawnpoints = [];
    data.friends = [];
    data.enemies = [];
    data.otherdata = [];

    for(i = 0; i < numspawns; i++) {
      if(freadln(file) <= 0) {
        break;
      }

      spawnpoint = spawnStruct();

      spawnpoint.origin = strtovec(fgetarg(file, 0));
      spawnpoint.winner = int(fgetarg(file, 1));
      spawnpoint.weight = int(fgetarg(file, 2));
      spawnpoint.data = [];
      spawnpoint.sightchecks = [];

      if(i == 0) {
        data.minweight = spawnpoint.weight;
        data.maxweight = spawnpoint.weight;
      } else {
        if(spawnpoint.weight < data.minweight) {
          data.minweight = spawnpoint.weight;
        }
        if(spawnpoint.weight > data.maxweight) {
          data.maxweight = spawnpoint.weight;
        }
      }

      argnum = 4;

      numdata = int(fgetarg(file, 3));
      if(numdata > 256) {
        break;
      }
      for(j = 0; j < numdata; j++) {
        spawnpoint.data[spawnpoint.data.size] = fgetarg(file, argnum);
        argnum++;
      }
      numsightchecks = int(fgetarg(file, argnum));
      argnum++;
      if(numsightchecks > 256) {
        break;
      }
      for(j = 0; j < numsightchecks; j++) {
        index = spawnpoint.sightchecks.size;
        spawnpoint.sightchecks[index] = spawnStruct();
        spawnpoint.sightchecks[index].penalty = int(fgetarg(file, argnum));
        argnum++;
        spawnpoint.sightchecks[index].origin = strtovec(fgetarg(file, argnum));
        argnum++;
      }

      data.spawnpoints[data.spawnpoints.size] = spawnpoint;
    }

    if(!isDefined(data.minweight)) {
      data.minweight = -1;
      data.maxweight = 0;
    }
    if(data.minweight == data.maxweight) {
      data.minweight = data.minweight - 1;
    }

    if(freadln(file) <= 0) {
      break;
    }
    numfriends = int(fgetarg(file, 0));
    numenemies = int(fgetarg(file, 1));
    if(numfriends > 32 || numenemies > 32) {
      break;
    }
    argnum = 2;
    for(i = 0; i < numfriends; i++) {
      data.friends[data.friends.size] = strtovec(fgetarg(file, argnum));
      argnum++;
    }
    for(i = 0; i < numenemies; i++) {
      data.enemies[data.enemies.size] = strtovec(fgetarg(file, argnum));
      argnum++;
    }

    if(freadln(file) <= 0) {
      break;
    }
    numotherdata = int(fgetarg(file, 0));
    argnum = 1;
    for(i = 0; i < numotherdata; i++) {
      otherdata = spawnStruct();
      otherdata.origin = strtovec(fgetarg(file, argnum));
      argnum++;
      otherdata.text = fgetarg(file, argnum);
      argnum++;

      data.otherdata[data.otherdata.size] = otherdata;
    }

    if(isDefined(relativepos)) {
      if(relativepos == "prevthisplayer") {
        if(data.id == oldspawndata.id) {
          {}
          level.curspawndata = prevThisPlayer;
          break;
        }
      } else if(relativepos == "prev") {
        if(data.id == oldspawndata.id) {
          {}
          level.curspawndata = prev;
          break;
        }
      } else if(relativepos == "nextthisplayer") {
        if(lookingForNextThisPlayer) {
          {}
          level.curspawndata = data;
          break;
        } else if(data.id == oldspawndata.id) {
          {}
          lookingForNextThisPlayer = true;
        }
      } else if(relativepos == "next") {
        if(lookingForNext) {
          {}
          level.curspawndata = data;
          break;
        } else if(data.id == oldspawndata.id) {
          {}
          lookingForNext = true;
        }
      }
    } else {
      if(data.id == desiredID) {
        level.curspawndata = data;
        break;
      }
    }

    prev = data;
    if(isDefined(oldspawndata) && data.playername == oldspawndata.playername) {
      prevThisPlayer = data;
    }
  }
  closefile(file);
}
drawSpawnData() {
  level notify("drawing_spawn_data");
  level endon("drawing_spawn_data");

  textoffset = (0, 0, -12);
  while(1) {
    if(!isDefined(level.curspawndata)) {
      wait .5;
      continue;
    }

    for(i = 0; i < level.curspawndata.friends.size; i++) {
      print3d(level.curspawndata.friends[i], "=)", (.5, 1, .5), 1, 5);
    }
    for(i = 0; i < level.curspawndata.enemies.size; i++) {
      print3d(level.curspawndata.enemies[i], "=(", (1, .5, .5), 1, 5);
    }

    for(i = 0; i < level.curspawndata.otherdata.size; i++) {
      print3d(level.curspawndata.otherdata[i].origin, level.curspawndata.otherdata[i].text, (.5, .75, 1), 1, 2);
    }

    for(i = 0; i < level.curspawndata.spawnpoints.size; i++) {
      sp = level.curspawndata.spawnpoints[i];
      orig = sp.sightTracePoint;
      if(sp.winner) {
        print3d(orig, level.curspawndata.playername + " spawned here", (.5, .5, 1), 1, 2);
        orig += textoffset;
      }
      amnt = (sp.weight - level.curspawndata.minweight) / (level.curspawndata.maxweight - level.curspawndata.minweight);
      print3d(orig, "Weight: " + sp.weight, (1 - amnt, amnt, .5));
      orig += textoffset;
      for(j = 0; j < sp.data.size; j++) {
        print3d(orig, sp.data[j], (1, 1, 1));
        orig += textoffset;
      }
      for(j = 0; j < sp.sightchecks.size; j++) {
        print3d(orig, "Sightchecks: -" + sp.sightchecks[j].penalty, (1, .5, .5));
        orig += textoffset;
      }
    }

    wait .05;
  }
}

vectostr(vec) {
  return int(vec[0]) + "/" + int(vec[1]) + "/" + int(vec[2]);
}
strtovec(str) {
  parts = strtok(str, "/");
  if(parts.size != 3) {
    return (0, 0, 0);
  }
  return (int(parts[0]), int(parts[1]), int(parts[2]));
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

getAllAlliedAndEnemyPlayers(obj) {
  if(level.teambased) {
    if(self.pers["team"] == "allies") {
      obj.allies = level.alivePlayers["allies"];
      obj.enemies = level.alivePlayers["axis"];
    } else {
      assert(self.pers["team"] == "axis");
      obj.allies = level.alivePlayers["axis"];
      obj.enemies = level.alivePlayers["allies"];
    }
  } else {
    obj.allies = [];
    obj.enemies = level.activePlayers;
  }
}
initWeights(spawnpoints) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].weight = 0;
  }

  if(level.storeSpawnData || level.debugSpawning) {
    for(i = 0; i < spawnpoints.size; i++) {
      spawnpoints[i].spawnData = [];
      spawnpoints[i].sightChecks = [];
    }
  }

}

getSpawnpoint_NearTeam(spawnpoints, favoredspawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  if(getDvar("scr_spawn_randomly") == "") {
    setDvar("scr_spawn_randomly", "0");
  }
  if(getDvar("scr_spawn_randomly") == "1") {
    return getSpawnpoint_Random(spawnpoints);
  }

  if(getdvarint("scr_spawnsimple") > 0) {
    return getSpawnpoint_Random(spawnpoints);
  }

  Spawnlogic_Begin();

  k_favored_spawn_point_bonus = 25000;

  initWeights(spawnpoints);

  obj = spawnStruct();
  getAllAlliedAndEnemyPlayers(obj);

  numplayers = obj.allies.size + obj.enemies.size;

  alliedDistanceWeight = 2;

  myTeam = self.pers["team"];
  enemyTeam = getOtherTeam(myTeam);
  mySquadId = getplayersquad(self);
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoint = spawnpoints[i];

    if(!isDefined(spawnpoint.numPlayersAtLastUpdate)) {
      spawnpoint.numPlayersAtLastUpdate = 0;
    }

    if(spawnpoint.numPlayersAtLastUpdate > 0) {
      allyDistSum = spawnpoint.distSum[myTeam];
      enemyDistSum = spawnpoint.distSum[enemyTeam];

      spawnpoint.weight = (enemyDistSum - alliedDistanceWeight * allyDistSum) / spawnpoint.numPlayersAtLastUpdate;

      if(mySquadId > 0) {
        for(j = 0; j < spawnpoint.nearbyPlayers[myTeam].size; j++) {
          {}
          player = spawnpoint.nearbyPlayers[myTeam][j];
          if(mySquadId == getplayersquad(player)) {
            if(issquadleader(player)) {
              {}
              spawnpoint.weight += k_favored_spawn_point_bonus;
            } else {
              {}
              spawnpoint.weight += (k_favored_spawn_point_bonus / 2);
            }
          }
        }
      }

      if(level.storeSpawnData || level.debugSpawning) {
        spawnpoint.spawnData[spawnpoint.spawnData.size] = "Base weight: " + int(spawnpoint.weight) + " = (" + int(enemyDistSum) + " - " + alliedDistanceWeight + "*" + int(allyDistSum) + ") / " + spawnpoint.numPlayersAtLastUpdate;
      }
    } else {
      spawnpoint.weight = 0;

      if(level.storeSpawnData || level.debugSpawning) {
        spawnpoint.spawnData[spawnpoint.spawnData.size] = "Base weight: 0";
      }
    }
  }

  if(isDefined(favoredspawnpoints)) {
    for(i = 0; i < favoredspawnpoints.size; i++) {
      if(isDefined(favoredspawnpoints[i].weight)) {
        favoredspawnpoints[i].weight += k_favored_spawn_point_bonus;
      } else {
        favoredspawnpoints[i].weight = k_favored_spawn_point_bonus;
      }
    }
  }

  avoidSamespawn(spawnpoints);
  avoidSpawnReuse(spawnpoints, true);
  avoidWeaponDamage(spawnpoints);
  avoidVisibleEnemies(spawnpoints, true);

  result = getSpawnpoint_Final(spawnpoints);

  if(getDvar("scr_spawn_showbad") == "") {
    setDvar("scr_spawn_showbad", "0");
  }
  if(getDvar("scr_spawn_showbad") == "1") {
    checkBad(result);
  }

  return result;
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

  avoidSamespawn(spawnpoints);
  avoidSpawnReuse(spawnpoints, false);
  avoidWeaponDamage(spawnpoints);
  avoidVisibleEnemies(spawnpoints, false);

  return getSpawnpoint_Final(spawnpoints);
}
Spawnlogic_Begin() {
  level.storeSpawnData = getdvarint("scr_recordspawndata");
  level.debugSpawning = (getdvarint("scr_spawnpointdebug") > 0);
}
init() {
  if(getDvar("scr_recordspawndata") == "") {
    setDvar("scr_recordspawndata", 0);
  }
  level.storeSpawnData = getdvarint("scr_recordspawndata");

  if(getDvar("scr_killbots") == "") {
    setDvar("scr_killbots", 0);
  }
  if(getDvar("scr_killbottimer") == "") {
    setDvar("scr_killbottimer", 0.25);
  }
  thread loopbotspawns();

  level.spawnlogic_deaths = [];
  level.spawnlogic_spawnkills = [];
  level.players = [];
  level.grenades = [];
  level.pipebombs = [];

  level thread onPlayerConnect();
  level thread trackGrenades();

  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  level.spawnMinsMaxsPrimed = false;
  if(isDefined(level.safespawns)) {
    for(i = 0; i < level.safespawns.size; i++) {
      level.safespawns[i] spawnPointInit();
    }
  }

  if(getDvar("scr_spawn_enemyavoiddist") == "") {
    setDvar("scr_spawn_enemyavoiddist", "800");
  }
  if(getDvar("scr_spawn_enemyavoidweight") == "") {
    setDvar("scr_spawn_enemyavoidweight", "0");
  }

  if(getDvar("scr_spawnsimple") == "") {
    setDvar("scr_spawnsimple", "0");
  }
  if(getDvar("scr_spawnpointdebug") == "") {
    setDvar("scr_spawnpointdebug", "0");
  }
  if(getdvarint("scr_spawnpointdebug") > 0) {
    thread showDeathsDebug();
    thread updateDeathInfoDebug();
    thread profileDebug();
  }
  if(level.storeSpawnData) {
    thread allowSpawnDataReading();
  }
  if(getDvar("scr_spawnprofile") == "") {
    setDvar("scr_spawnprofile", "0");
  }
  thread watchSpawnProfile();
  thread spawnGraphCheck();
}

watchSpawnProfile() {
  while(1) {
    while(1) {
      if(getdvarint("scr_spawnprofile") > 0) {
        break;
      }
      wait .05;
    }

    thread spawnProfile();

    while(1) {
      if(getdvarint("scr_spawnprofile") <= 0) {
        break;
      }
      wait .05;
    }

    level notify("stop_spawn_profile");
  }
}

spawnProfile() {
  level endon("stop_spawn_profile");
  while(1) {
    if(level.players.size > 0 && level.spawnpoints.size > 0) {
      playerNum = randomint(level.players.size);
      player = level.players[playerNum];
      attempt = 1;
      while(!isDefined(player) && attempt < level.players.size) {
        playerNum = (playerNum + 1) % level.players.size;
        attempt++;
        player = level.players[playerNum];
      }

      player getSpawnpoint_NearTeam(level.spawnpoints);
    }
    wait .05;
  }
}

spawnGraphCheck() {
  while(1) {
    if(getdvarint("scr_spawngraph") < 1) {
      wait 3;
      continue;
    }
    thread spawnGraph();
    return;
  }
}

spawnGraph() {
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

      i++;
    }
  }

  didweights = false;

  while(1) {
    spawni = 0;
    numiters = 5;
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

      if(didweights) {
        level.players[0] drawSpawnGraph(fakespawnpoints, w, h, weightscale);
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
  i = 0;
  for(y = 0; y < h; y++) {
    yamnt = y / (h - 1);
    for(x = 0; x < w; x++) {
      xamnt = x / (w - 1);

      if(y > 0) {
        spawnGraphLine(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
      }
      if(x > 0) {
        spawnGraphLine(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
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

  line(p1, p2, (1, 1, 1));
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

        victim thread[[level.callbackPlayerDamage]](
          killer, killer, 1000, 0, "MOD_RIFLE_BULLET", "none", (0, 0, 0), (0, 0, 0), "none", 0
        );
      } else {
        numKills = getdvarint("scr_killbots");
        lastVictim = undefined;
        for(index = 0; index < numKills; index++) {
          {}
          killer = bots[randomint(bots.size)];
          victim = bots[randomint(bots.size)];

          while(isDefined(lastVictim) && victim == lastVictim) {
            victim = bots[randomint(bots.size)];
          }

          victim thread[[level.callbackPlayerDamage]](
            killer, killer, 1000, 0, "MOD_RIFLE_BULLET", "none", (0, 0, 0), (0, 0, 0), "none", 0
          );

          lastVictim = victim;
        }
      }
    }

    if(getDvar("scr_killbottimer") != "") {
      wait getdvarfloat("scr_killbottimer");
    } else {
      wait .05;
    }
  }
}
allowSpawnDataReading() {
  setDvar("scr_showspawnid", "");
  prevval = getDvar("scr_showspawnid");

  prevrelval = getDvar("scr_spawnidcycle");

  readthistime = false;

  while(1) {
    val = getDvar("scr_showspawnid");
    relval = undefined;
    if(!isDefined(val) || val == prevval) {
      relval = getDvar("scr_spawnidcycle");
      if(isDefined(relval) && relval != "") {
        setDvar("scr_spawnidcycle", "");
      } else {
        wait(.5);
        continue;
      }
    }
    prevval = val;

    readthistime = false;

    readSpawnData(val, relval);

    if(!isDefined(level.curspawndata)) {
      println("No spawn data to draw.");
    } else {
      println("Drawing spawn ID " + level.curspawndata.id);
    }

    thread drawSpawnData();
  }
}

showDeathsDebug() {
  while(1) {
    if(getDvar("scr_spawnpointdebug") == "0") {
      wait(3);
      continue;
    }

    time = getTime();

    for(i = 0; i < level.spawnlogic_deaths.size; i++) {
      if(isDefined(level.spawnlogic_deaths[i].los)) {
        line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killOrg, (1, 0, 0));
      } else {
        line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killOrg, (1, 1, 1));
      }
      killer = level.spawnlogic_deaths[i].killer;
      if(isDefined(killer) && isalive(killer)) {
        line(level.spawnlogic_deaths[i].killOrg, killer.origin, (.4, .4, .8));
      }
    }

    for(p = 0; p < level.players.size; p++) {
      if(!isDefined(level.players[p])) {
        continue;
      }
      if(isDefined(level.players[p].spawnlogic_killdist)) {
        print3d(level.players[p].origin + (0, 0, 64), level.players[p].spawnlogic_killdist, (1, 1, 1));
      }
    }

    oldspawnkills = level.spawnlogic_spawnkills;
    level.spawnlogic_spawnkills = [];
    for(i = 0; i < oldspawnkills.size; i++) {
      spawnkill = oldspawnkills[i];

      if(spawnkill.dierwasspawner) {
        line(spawnkill.spawnpointorigin, spawnkill.dierorigin, (.4, .5, .4));
        line(spawnkill.dierorigin, spawnkill.killerorigin, (0, 1, 1));
        print3d(spawnkill.dierorigin + (0, 0, 32), "SPAWNKILLED!", (0, 1, 1));
      } else {
        line(spawnkill.spawnpointorigin, spawnkill.killerorigin, (.4, .5, .4));
        line(spawnkill.killerorigin, spawnkill.dierorigin, (0, 1, 1));
        print3d(spawnkill.dierorigin + (0, 0, 32), "SPAWNDIED!", (0, 1, 1));
      }

      if(time - spawnkill.time < 60 * 1000) {
        level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
      }
    }
    wait(.05);
  }
}
updateDeathInfoDebug() {
  while(1) {
    if(getDvar("scr_spawnpointdebug") == "0") {
      wait(3);
      continue;
    }
    updateDeathInfo();
    wait(3);
  }
}
spawnWeightDebug(spawnpoints) {
  level notify("stop_spawn_weight_debug");
  level endon("stop_spawn_weight_debug");
  while(1) {
    if(getDvar("scr_spawnpointdebug") == "0") {
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

      if(isDefined(spawnpoints[i].spawnData)) {
        for(j = 0; j < spawnpoints[i].spawnData.size; j++) {
          {}
          print3d(orig, spawnpoints[i].spawnData[j], (.5, .5, .5));
          orig += textoffset;
        }
      }
      if(isDefined(spawnpoints[i].sightChecks)) {
        for(j = 0; j < spawnpoints[i].sightChecks.size; j++) {
          {}
          if(spawnpoints[i].sightChecks[j].penalty == 0) {
            continue;
          }
          print3d(orig, "Sight to enemy: -" + spawnpoints[i].sightChecks[j].penalty, (.5, .5, .5));
          orig += textoffset;
        }
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
  if(getDvar("scr_spawnpointdebug") == "0") {
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

deathOccured(dier, killer) {}
checkForSimilarDeaths(deathInfo) {
  for(i = 0; i < level.spawnlogic_deaths.size; i++) {
    if(level.spawnlogic_deaths[i].killer == deathInfo.killer) {
      dist = distance(level.spawnlogic_deaths[i].org, deathInfo.org);
      if(dist > 200) continue;
      dist = distance(level.spawnlogic_deaths[i].killOrg, deathInfo.killOrg);
      if(dist > 200) continue;

      level.spawnlogic_deaths[i].remove = true;
    }
  }
}

updateDeathInfo() {
  time = getTime();
  for(i = 0; i < level.spawnlogic_deaths.size; i++) {
    deathInfo = level.spawnlogic_deaths[i];

    if(time - deathInfo.time > 1000 * 90 || !isDefined(deathInfo.killer) || !isalive(deathInfo.killer) || (deathInfo.killer.pers["team"] != "axis" && deathInfo.killer.pers["team"] != "allies") || distance(deathInfo.killer.origin, deathInfo.killOrg) > 400) {
      level.spawnlogic_deaths[i].remove = true;
    }
  }

  oldarray = level.spawnlogic_deaths;
  level.spawnlogic_deaths = [];

  start = 0;
  if(oldarray.size - 1024 > 0) start = oldarray.size - 1024;

  for(i = start; i < oldarray.size; i++) {
    if(!isDefined(oldarray[i].remove)) {
      level.spawnlogic_deaths[level.spawnlogic_deaths.size] = oldarray[i];
    }
  }
}

trackGrenades() {
  while(1) {
    level.grenades = getEntArray("grenade", "classname");
    wait .05;
  }
}

isPointVulnerable(playerorigin) {
  pos = self.origin + level.bettymodelcenteroffset;
  playerpos = playerorigin + (0, 0, 32);
  distsqrd = distancesquared(pos, playerpos);

  forward = anglesToForward(self.angles);

  if(distsqrd < level.bettyDetectionRadius * level.bettyDetectionRadius) {
    playerdir = vectornormalize(playerpos - pos);
    angle = acos(vectordot(playerdir, forward));
    if(angle < level.bettyDetectionConeAngle) {
      return true;
    }
  }
  return false;
}

avoidWeaponDamage(spawnpoints) {
  if(getDvar("scr_spawnpointnewlogic") == "0") {
    return;
  }

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

        if(level.storeSpawnData || level.debugSpawning) {
          spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Was near grenade: -" + int(weaponDamagePenalty);
        }
      }
    }

    if(!isDefined(level.artilleryDangerCenters)) {
      continue;
    }

    airstrikeDanger = maps\mp\gametypes\_hardpoints::getArtilleryDanger(spawnpoints[i].origin);

    if(airstrikeDanger > 0) {
      worsen = airstrikeDanger * weaponDamagePenalty;
      spawnpoints[i].weight -= worsen;

      if(level.storeSpawnData || level.debugSpawning) {
        spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Was near artillery (" + int(airstrikeDanger * 100) + "% danger): -" + int(worsen);
      }
    }
  }
}

spawnPerFrameUpdate() {
  spawnpointindex = 0;

  while(1) {
    wait .05;

    if(!isDefined(level.spawnPoints)) {
      return;
    }

    spawnpointindex = (spawnpointindex + 1) % level.spawnPoints.size;
    spawnpoint = level.spawnPoints[spawnpointindex];

    spawnPointUpdate(spawnpoint);
  }
}

spawnPointUpdate(spawnpoint) {
  if(level.teambased) {
    spawnpoint.sights["axis"] = 0;
    spawnpoint.sights["allies"] = 0;

    spawnpoint.nearbyPlayers["axis"] = [];
    spawnpoint.nearbyPlayers["allies"] = [];
  } else {
    spawnpoint.sights = 0;

    spawnpoint.nearbyPlayers["all"] = [];
  }

  spawnpointdir = spawnpoint.forward;

  debug = false;

  debug = (getdvarint("scr_spawnpointdebug") > 0);

  spawnpoint.distSum["all"] = 0;
  spawnpoint.distSum["allies"] = 0;
  spawnpoint.distSum["axis"] = 0;

  spawnpoint.minDist["all"] = 9999999;
  spawnpoint.minDist["allies"] = 9999999;
  spawnpoint.minDist["axis"] = 9999999;

  spawnpoint.numPlayersAtLastUpdate = 0;

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(player.sessionstate != "playing") {
      continue;
    }

    diff = player.origin - spawnpoint.origin;
    diff = (diff[0], diff[1], 0);
    dist = length(diff);

    team = "all";
    if(level.teambased) {
      team = player.pers["team"];
    }

    if(dist < 1024) {
      spawnpoint.nearbyPlayers[team][spawnpoint.nearbyPlayers[team].size] = player;
    }

    if(dist < spawnpoint.minDist[team]) {
      spawnpoint.minDist[team] = dist;
    }

    spawnpoint.distSum[team] += dist;
    spawnpoint.numPlayersAtLastUpdate++;

    pdir = anglesToForward(player.angles);
    if(vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0) {
      continue;
    }

    losExists = bullettracepassed(player.origin + (0, 0, 50), spawnpoint.sightTracePoint, false, undefined);

    spawnpoint.lastSightTraceTime = gettime();

    if(losExists) {
      if(level.teamBased) {
        spawnpoint.sights[player.pers["team"]]++;
      } else {
        spawnpoint.sights++;
      }

      if(debug) {
        line(player.origin + (0, 0, 50), spawnpoint.sightTracePoint, (.5, 1, .5));
      }
    }

  }
}

getLosPenalty() {
  if(getDvar("scr_spawnpointlospenalty") != "" && getDvar("scr_spawnpointlospenalty") != "0") {
    return getdvarfloat("scr_spawnpointlospenalty");
  }
  return 100000;
}

lastMinuteSightTraces(spawnpoint) {
  team = "all";
  if(level.teambased) {
    team = getOtherTeam(self.pers["team"]);
  }

  if(!isDefined(spawnpoint.nearbyPlayers)) {
    return false;
  }

  closest = undefined;
  closestDistsq = undefined;
  secondClosest = undefined;
  secondClosestDistsq = undefined;
  for(i = 0; i < spawnpoint.nearbyPlayers[team].size; i++) {
    player = spawnpoint.nearbyPlayers[team][i];

    if(!isDefined(player)) {
      continue;
    }
    if(player.sessionstate != "playing") {
      continue;
    }
    if(player == self) {
      continue;
    }

    distsq = distanceSquared(spawnpoint.origin, player.origin);
    if(!isDefined(closest) || distsq < closestDistsq) {
      secondClosest = closest;
      secondClosestDistsq = closestDistsq;

      closest = player;
      closestDistSq = distsq;
    } else if(!isDefined(secondClosest) || distsq < secondClosestDistSq) {
      secondClosest = player;
      secondClosestDistSq = distsq;
    }
  }

  if(isDefined(closest)) {
    if(bullettracepassed(closest.origin + (0, 0, 50), spawnpoint.sightTracePoint, false, undefined)) {
      return true;
    }
  }
  if(isDefined(secondClosest)) {
    if(bullettracepassed(secondClosest.origin + (0, 0, 50), spawnpoint.sightTracePoint, false, undefined)) {
      return true;
    }
  }

  return false;
}

avoidVisibleEnemies(spawnpoints, teambased) {
  if(getDvar("scr_spawnpointnewlogic") == "0") {
    return;
  }

  lospenalty = getLosPenalty();

  otherteam = "axis";
  if(self.pers["team"] == "axis") {
    otherteam = "allies";
  }

  minDistTeam = otherteam;

  if(teambased) {
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(spawnpoints[i].sights)) {
        continue;
      }

      penalty = lospenalty * spawnpoints[i].sights[otherteam];
      spawnpoints[i].weight -= penalty;

      if(level.storeSpawnData || level.debugSpawning) {
        index = spawnpoints[i].sightChecks.size;
        spawnpoints[i].sightChecks[index] = spawnStruct();
        spawnpoints[i].sightChecks[index].penalty = penalty;
      }
    }
  } else {
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(spawnpoints[i].sights)) {
        continue;
      }

      penalty = lospenalty * spawnpoints[i].sights;
      spawnpoints[i].weight -= penalty;

      if(level.storeSpawnData || level.debugSpawning) {
        index = spawnpoints[i].sightChecks.size;
        spawnpoints[i].sightChecks[index] = spawnStruct();
        spawnpoints[i].sightChecks[index].penalty = penalty;
      }
    }

    minDistTeam = "all";
  }

  avoidWeight = getdvarfloat("scr_spawn_enemyavoidweight");
  if(avoidWeight != 0) {
    nearbyEnemyOuterRange = getdvarfloat("scr_spawn_enemyavoiddist");
    nearbyEnemyOuterRangeSq = nearbyEnemyOuterRange * nearbyEnemyOuterRange;
    nearbyEnemyPenalty = 1500 * avoidWeight;
    nearbyEnemyMinorPenalty = 800 * avoidWeight;

    lastAttackerOrigin = (-99999, -99999, -99999);
    lastDeathPos = (-99999, -99999, -99999);
    if(isAlive(self.lastAttacker)) {
      lastAttackerOrigin = self.lastAttacker.origin;
    }
    if(isDefined(self.lastDeathPos)) {
      lastDeathPos = self.lastDeathPos;
    }

    for(i = 0; i < spawnpoints.size; i++) {
      mindist = spawnpoints[i].minDist[minDistTeam];
      if(mindist < nearbyEnemyOuterRange * 2) {
        penalty = nearbyEnemyMinorPenalty * (1 - mindist / (nearbyEnemyOuterRange * 2));
        if(mindist < nearbyEnemyOuterRange) {
          penalty += nearbyEnemyPenalty * (1 - mindist / nearbyEnemyOuterRange);
        }
        if(penalty > 0) {
          {}
          spawnpoints[i].weight -= penalty;

          if(level.storeSpawnData || level.debugSpawning) {
            spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Nearest enemy at " + int(spawnpoints[i].minDist[minDistTeam]) + " units: -" + int(penalty);
          }
        }
      }
    }
  }
}

avoidSpawnReuse(spawnpoints, teambased) {
  if(getDvar("scr_spawnpointnewlogic") == "0") {
    return;
  }

  time = getTime();

  maxtime = 10 * 1000;
  maxdistSq = 1024 * 1024;

  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoint = spawnpoints[i];

    if(!isDefined(spawnpoint.lastspawnedplayer) || !isDefined(spawnpoint.lastspawntime) || !isalive(spawnpoint.lastspawnedplayer)) {
      continue;
    }

    if(spawnpoint.lastspawnedplayer == self) {
      continue;
    }
    if(teambased && spawnpoint.lastspawnedplayer.pers["team"] == self.pers["team"]) {
      continue;
    }

    timepassed = time - spawnpoint.lastspawntime;
    if(timepassed < maxtime) {
      distSq = distanceSquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
      if(distSq < maxdistSq) {
        worsen = 5000 * (1 - distSq / maxdistSq) * (1 - timepassed / maxtime);
        spawnpoint.weight -= worsen;

        if(level.storeSpawnData || level.debugSpawning) {
          spawnpoint.spawnData[spawnpoint.spawnData.size] = "Was recently used: -" + worsen;
        }
      } else {
        spawnpoint.lastspawnedplayer = undefined;
      }
    } else {
      spawnpoint.lastspawnedplayer = undefined;
    }
  }
}

avoidSamespawn(spawnpoints) {
  if(getDvar("scr_spawnpointnewlogic") == "0") {
    return;
  }

  if(!isDefined(self.lastspawnpoint)) {
    return;
  }

  for(i = 0; i < spawnpoints.size; i++) {
    if(spawnpoints[i] == self.lastspawnpoint) {
      spawnpoints[i].weight -= 50000;

      if(level.storeSpawnData || level.debugSpawning) {
        spawnpoints[i].spawnData[spawnpoints[i].spawnData.size] = "Was last spawnpoint: -50000";
      }

      break;
    }
  }

}