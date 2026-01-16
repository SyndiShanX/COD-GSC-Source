/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_legacyspawnlogic.gsc
***************************************************/

init() {
  level.uselegacyspawning = issupportedmap() && issupportedmode() && getdvarint("legacySpawningEnabled", 0);
}

issupportedmap() {
  switch (level.script) {
    case "mp_countdown":
    case "mp_bog":
    case "mp_cargoship":
    case "mp_bog_summer":
      return 1;
    default:
      return 0;
  }
}

issupportedmode() {
  switch (level.gametype) {
    case "dom":
    case "conf":
    case "war":
      return 1;
    default:
      return 0;
  }
}

uselegacyspawning() {
  return level.uselegacyspawning;
}

getspawnpoint_final(var_0, var_1) {
  var_2 = undefined;

  if(!isdefined(var_0) || var_0.size == 0)
    return undefined;

  if(!isdefined(var_1))
    var_1 = 1;

  if(var_1)
    var_2 = getbestweightedspawnpoint(var_0);
  else {
    for (var_3 = 0; var_3 < var_0.size; var_3++) {
      if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == var_0[var_3]) {
        continue;
      }
      if(positionwouldtelefrag(var_0[var_3].origin)) {
        continue;
      }
      var_2 = var_0[var_3];
      break;
    }

    if(!isdefined(var_2)) {
      if(isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin)) {
        for (var_3 = 0; var_3 < var_0.size; var_3++) {
          if(var_0[var_3] == self.lastspawnpoint) {
            var_2 = var_0[var_3];
            break;
          }
        }
      }
    }
  }

  if(!isdefined(var_2)) {
    if(var_1)
      var_2 = var_0[randomint(var_0.size)];
    else
      var_2 = var_0[0];
  }

  return var_2;
}

getbestweightedspawnpoint(var_0) {
  var_1 = 3;

  for (var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = [];
    var_4 = undefined;
    var_5 = undefined;

    for (var_6 = 0; var_6 < var_0.size; var_6++) {
      if(!isdefined(var_4) || var_0[var_6].weight > var_4) {
        if(positionwouldtelefrag(var_0[var_6].origin)) {
          continue;
        }
        var_3 = [];
        var_3[0] = var_0[var_6];
        var_4 = var_0[var_6].weight;
        continue;
      }

      if(var_0[var_6].weight == var_4) {
        if(positionwouldtelefrag(var_0[var_6].origin)) {
          continue;
        }
        var_3[var_3.size] = var_0[var_6];
      }
    }

    if(var_3.size == 0)
      return undefined;

    var_5 = var_3[randomint(var_3.size)];

    if(var_2 == var_1)
      return var_5;

    if(isdefined(var_5.lastsighttracetime) && var_5.lastsighttracetime == gettime())
      return var_5;

    if(!lastminutesighttraces(var_5))
      return var_5;

    var_7 = getlospenalty();
    var_5.weight = var_5.weight - var_7;
    var_5.lastsighttracetime = gettime();
  }
}

getspawnpoint_random(var_0) {
  if(!isdefined(var_0))
    return undefined;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = randomint(var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return getspawnpoint_final(var_0, 0);
}

getallotherplayers() {
  var_0 = [];

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(!isdefined(level.players[var_1])) {
      continue;
    }
    var_2 = level.players[var_1];

    if(var_2.sessionstate != "playing" || var_2 == self) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

getallalliedandenemyplayers(var_0) {
  if(level.teambased) {
    if(self.pers["team"] == "allies") {
      var_0.allies = level.aliveplayers["allies"];
      var_0.enemies = level.aliveplayers["axis"];
    } else {
      var_0.allies = level.aliveplayers["axis"];
      var_0.enemies = level.aliveplayers["allies"];
    }
  } else {
    var_0.allies = [];
    var_0.enemies = level.activeplayers;
  }
}

initweights(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].weight = 0;
}

getspawnpoint_nearteam(var_0, var_1) {
  if(!isdefined(var_0))
    return undefined;

  if(getdvarint("scr_spawnsimple") > 0)
    return getspawnpoint_random(var_0);

  spawnlogic_begin();
  initweights(var_0);
  var_2 = spawnstruct();
  getallalliedandenemyplayers(var_2);
  var_3 = var_2.allies.size + var_2.enemies.size;
  var_4 = 2;
  var_5 = self.pers["team"];
  var_6 = maps\mp\_utility::getotherteam(var_5);

  for (var_7 = 0; var_7 < var_0.size; var_7++) {
    var_8 = var_0[var_7];

    if(var_8.numplayersatlastupdate > 0) {
      var_9 = var_8.distsum[var_5];
      var_10 = var_8.distsum[var_6];
      var_8.weight = (var_10 - var_4 * var_9) / var_8.numplayersatlastupdate;
      continue;
    }

    var_8.weight = 0;
  }

  if(isdefined(var_1)) {
    for (var_7 = 0; var_7 < var_1.size; var_7++)
      var_1[var_7].weight = var_1[var_7].weight + 25000;
  }

  avoidsamespawn(var_0);
  avoidspawnreuse(var_0, 1);
  avoidweapondamage(var_0);
  avoidvisibleenemies(var_0, 1);
  var_11 = getspawnpoint_final(var_0);
  return var_11;
}

getspawnpoint_dm(var_0) {
  if(!isdefined(var_0))
    return undefined;

  spawnlogic_begin();
  initweights(var_0);
  var_1 = getallotherplayers();
  var_2 = 1600;
  var_3 = 1200;

  if(var_1.size > 0) {
    for (var_4 = 0; var_4 < var_0.size; var_4++) {
      var_5 = 0;
      var_6 = 0;

      for (var_7 = 0; var_7 < var_1.size; var_7++) {
        var_8 = distance(var_0[var_4].origin, var_1[var_7].origin);

        if(var_8 < var_3)
          var_6 = var_6 + (var_3 - var_8) / var_3;

        var_9 = abs(var_8 - var_2);
        var_5 = var_5 + var_9;
      }

      var_10 = var_5 / var_1.size;
      var_11 = (var_2 - var_10) / var_2;
      var_0[var_4].weight = var_11 - var_6 * 2 + randomfloat(0.2);
    }
  }

  avoidsamespawn(var_0);
  avoidspawnreuse(var_0, 0);
  avoidweapondamage(var_0);
  avoidvisibleenemies(var_0, 0);
  return getspawnpoint_final(var_0);
}

spawnlogic_begin() {}

ispointvulnerable(var_0) {
  var_1 = self.origin + level.claymoremodelcenteroffset;
  var_2 = var_0 + (0, 0, 32);
  var_3 = distancesquared(var_1, var_2);
  var_4 = anglestoforward(self.angles);

  if(var_3 < level.claymoredetectionradius * level.claymoredetectionradius) {
    var_5 = vectornormalize(var_2 - var_1);
    var_6 = acos(vectordot(var_5, var_4));

    if(var_6 < level.claymoredetectionconeangle)
      return 1;
  }

  return 0;
}

avoidweapondamage(var_0) {
  if(getdvar("scr_spawnpointnewlogic") == "0") {
    return;
  }
  var_1 = 100000;

  if(getdvar("scr_spawnpointweaponpenalty") != "" && getdvar("scr_spawnpointweaponpenalty") != "0")
    var_1 = getdvarfloat("scr_spawnpointweaponpenalty");

  var_2 = 62500;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    for (var_4 = 0; var_4 < level.grenades.size; var_4++) {
      if(!isdefined(level.grenades[var_4])) {
        continue;
      }
      if(distancesquared(var_0[var_3].origin, level.grenades[var_4].origin) < var_2)
        var_0[var_3].weight = var_0[var_3].weight - var_1;
    }

    if(!isdefined(level.artillerydangercenters)) {
      continue;
    }
    var_5 = maps\mp\gametypes\_hardpoints::getairstrikedanger(var_0[var_3].origin);

    if(var_5 > 0) {
      var_6 = var_5 * var_1;
      var_0[var_3].weight = var_0[var_3].weight - var_6;
    }
  }
}

spawnperframeupdate() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  for (;;) {
    if(var_4) {
      wait 0.05;
      var_2 = 0;
      var_3 = 0;
    }

    if(!isdefined(level.spawnpoints)) {
      return;
    }
    var_0 = (var_0 + 1) % level.spawnpoints.size;
    var_5 = level.spawnpoints[var_0];

    if(level.teambased) {
      var_5.sights["axis"] = 0;
      var_5.sights["allies"] = 0;
      var_5.nearbyplayers["axis"] = [];
      var_5.nearbyplayers["allies"] = [];
    } else {
      var_5.sights = 0;
      var_5.nearbyplayers["all"] = [];
    }

    var_6 = var_5.forward;
    var_5.distsum["all"] = 0;
    var_5.distsum["allies"] = 0;
    var_5.distsum["axis"] = 0;
    var_5.numplayersatlastupdate = 0;
    var_7 = 0;

    for (var_8 = 0; var_8 < level.players.size; var_8++) {
      var_9 = level.players[var_8];

      if(var_9.sessionstate != "playing") {
        continue;
      }
      var_7++;
      var_10 = var_9.origin - var_5.origin;
      var_11 = length(var_10);
      var_12 = "all";

      if(level.teambased)
        var_12 = var_9.pers["team"];

      if(var_11 < 1024)
        var_5.nearbyplayers[var_12][var_5.nearbyplayers[var_12].size] = var_9;

      var_5.distsum[var_12] = var_5.distsum[var_12] + var_11;
      var_5.numplayersatlastupdate++;
      var_13 = anglestoforward(var_9.angles);

      if(vectordot(var_6, var_10) < 0 && vectordot(var_13, var_10) > 0) {
        continue;
      }
      var_2++;
      var_14 = legacybullettracepassed(var_9.origin + (0, 0, 50), var_5.sighttracepoint, var_5);
      var_5.lastsighttracetime = gettime();

      if(var_14) {
        if(level.teambased) {
          var_5.sights[var_9.pers["team"]]++;
          continue;
        }

        var_5.sights++;
      }
    }

    var_3++;
    var_15 = var_3 == level.spawnpoints.size;
    var_16 = var_2 + var_7 > getdvarint("legacySpawningMaxTraces", 18);
    var_4 = var_15 || var_16;
  }
}

legacybullettracepassed(var_0, var_1, var_2) {
  var_3 = getdvarfloat("legacySpawningSightFrac", 1.0);

  if(var_3 >= 1.0)
    return bullettracepassed(var_0, var_1, 0, undefined);
  else
    return spawnsighttrace(var_2, var_0, var_1, var_2.index) >= var_3;
}

getlospenalty() {
  if(getdvar("scr_spawnpointlospenalty") != "" && getdvar("scr_spawnpointlospenalty") != "0")
    return getdvarfloat("scr_spawnpointlospenalty");

  return 100000;
}

lastminutesighttraces(var_0) {
  var_1 = "all";

  if(level.teambased)
    var_1 = maps\mp\_utility::getotherteam(self.pers["team"]);

  if(!isdefined(var_0.nearbyplayers))
    return 0;

  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  for (var_6 = 0; var_6 < var_0.nearbyplayers[var_1].size; var_6++) {
    var_7 = var_0.nearbyplayers[var_1][var_6];

    if(!isdefined(var_7)) {
      continue;
    }
    if(var_7.sessionstate != "playing") {
      continue;
    }
    if(var_7 == self) {
      continue;
    }
    var_8 = distancesquared(var_0.origin, var_7.origin);

    if(!isdefined(var_2) || var_8 < var_3) {
      var_4 = var_2;
      var_5 = var_3;
      var_2 = var_7;
      var_3 = var_8;
      continue;
    }

    if(!isdefined(var_4) || var_8 < var_5) {
      var_4 = var_7;
      var_5 = var_8;
    }
  }

  if(isdefined(var_2)) {
    if(legacybullettracepassed(var_2.origin + (0, 0, 50), var_0.sighttracepoint, var_0))
      return 1;
  }

  if(isdefined(var_4)) {
    if(legacybullettracepassed(var_4.origin + (0, 0, 50), var_0.sighttracepoint, var_0))
      return 1;
  }

  return 0;
}

avoidvisibleenemies(var_0, var_1) {
  if(getdvar("scr_spawnpointnewlogic") == "0") {
    return;
  }
  var_2 = getlospenalty();
  var_3 = "axis";

  if(self.pers["team"] == "axis")
    var_3 = "allies";

  if(var_1 || maps\mp\_utility::ishodgepodgemm()) {
    for (var_4 = 0; var_4 < var_0.size; var_4++) {
      if(!isdefined(var_0[var_4].sights)) {
        continue;
      }
      var_5 = var_2 * var_0[var_4].sights[var_3];
      var_0[var_4].weight = var_0[var_4].weight - var_5;
    }
  } else {
    for (var_4 = 0; var_4 < var_0.size; var_4++) {
      if(!isdefined(var_0[var_4].sights)) {
        continue;
      }
      var_5 = var_2 * var_0[var_4].sights;
      var_0[var_4].weight = var_0[var_4].weight - var_5;
    }
  }
}

avoidspawnreuse(var_0, var_1) {
  if(getdvar("scr_spawnpointnewlogic") == "0") {
    return;
  }
  var_2 = gettime();
  var_3 = 10000;
  var_4 = 640000;

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    if(!isdefined(var_0[var_5].lastspawnedplayer) || !isdefined(var_0[var_5].lastspawntime) || !isalive(var_0[var_5].lastspawnedplayer)) {
      continue;
    }
    if(var_0[var_5].lastspawnedplayer == self) {
      continue;
    }
    if(var_1 && var_0[var_5].lastspawnedplayer.pers["team"] == self.pers["team"]) {
      continue;
    }
    var_6 = var_2 - var_0[var_5].lastspawntime;

    if(var_6 < var_3) {
      var_7 = distancesquared(var_0[var_5].lastspawnedplayer.origin, var_0[var_5].origin);

      if(var_7 < var_4) {
        var_8 = 1000 * (1 - var_7 / var_4) * (1 - var_6 / var_3);
        var_0[var_5].weight = var_0[var_5].weight - var_8;
      } else
        var_0[var_5].lastspawnedplayer = undefined;

      continue;
    }

    var_0[var_5].lastspawnedplayer = undefined;
  }
}

avoidsamespawn(var_0) {
  if(getdvar("scr_spawnpointnewlogic") == "0") {
    return;
  }
  if(!isdefined(self.lastspawnpoint)) {
    return;
  }
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] == self.lastspawnpoint) {
      var_0[var_1].weight = var_0[var_1].weight - 50000;
      break;
    }
  }
}