/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnfactor.gsc
**********************************************/

score_factor(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3))
    var_4 = [
      [var_1]
    ](var_2, var_3);
  else
    var_4 = [
      [var_1]
    ](var_2);

  var_4 = clamp(var_4, 0, 100);
  var_4 = var_4 * var_0;
  var_2.debugscoredata[var_2.debugscoredata.size] = var_4;
  var_2.totalpossiblescore = var_2.totalpossiblescore + 100 * var_0;
  return var_4;
}

critical_factor(var_0, var_1, var_2) {
  if(isdefined(var_2))
    var_3 = [
      [var_0]
    ](var_1, var_2);
  else
    var_3 = [
      [var_0]
    ](var_1);

  var_3 = clamp(var_3, 0, 100);
  var_1.debugcriticaldata[var_1.debugcriticaldata.size] = var_3;
  return var_3;
}

avoidcarepackages(var_0) {
  foreach(var_2 in level.carepackages) {
    if(!isdefined(var_2)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 22500)
      return 0;
  }

  return 100;
}

avoidgrenades(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isdefined(var_2) || !var_2 isexplosivedangeroustoplayer(self)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500)
      return 0;
  }

  return 100;
}

avoidmines(var_0) {
  var_1 = level.mines;

  foreach(var_3 in var_1) {
    if(!isdefined(var_3) || !var_3 isexplosivedangeroustoplayer(self)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500)
      return 0;
  }

  return 100;
}

isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isdefined(var_0.team))
    return 1;

  if(!isdefined(self.owner) || !isdefined(self.owner.team))
    return 1;

  if(var_0 == self.owner)
    return 1;

  var_1 = self.owner.team;
  return var_1 != var_0.team;
}

avoidairstrikelocations(var_0) {
  if(!isdefined(level.artillerydangercenters))
    return 100;

  if(!var_0.outside)
    return 100;

  var_1 = maps\mp\gametypes\_hardpoints::getairstrikedanger(var_0.origin);

  if(var_1 > 0)
    return 0;

  return 100;
}

avoidcornervisibleenemies(var_0) {
  var_1 = "all";

  if(level.teambased)
    var_1 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);

  if(var_0.cornersights[var_1] > 0)
    return 0;

  return 100;
}

avoidfullvisibleenemies(var_0) {
  var_1 = "all";

  if(level.teambased)
    var_1 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);

  if(var_0.fullsights[var_1] > 0)
    return 0;

  return 100;
}

avoidtelefrag(var_0) {
  if(isdefined(self.allowtelefrag))
    return 100;

  if(positionwouldtelefrag(var_0.origin)) {
    foreach(var_2 in var_0.alternates) {
      if(!positionwouldtelefrag(var_2)) {
        break;
      }
    }

    return 0;
  }

  return 100;
}

avoidsamespawn(var_0) {
  if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == var_0)
    return 0;

  return 100;
}

avoidrecentlyused(var_0) {
  if(isdefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;

    if(var_1 > 4000)
      return 100;

    return var_1 / 4000 * 100;
  }

  return 100;
}

avoidenemyspawn(var_0) {
  if(isdefined(var_0.lastspawnteam) && (!level.teambased || var_0.lastspawnteam != self.team)) {
    var_1 = var_0.lastspawntime + 500;

    if(gettime() < var_1)
      return 0;
  }

  return 100;
}

avoidspawninzone(var_0, var_1) {
  var_2 = distancesquared(var_1.origin, var_0.origin);

  if(var_2 < 692224)
    return 0;

  return 100;
}

avoidlastdeathlocation(var_0) {
  if(!isdefined(self.lastdeathpos))
    return 100;

  var_1 = distancesquared(var_0.origin, self.lastdeathpos);

  if(var_1 > 4000000)
    return 100;

  var_2 = var_1 / 4000000;
  return var_2 * 100;
}

avoidlastattackerlocation(var_0) {
  if(!isdefined(self.lastattacker) || !isdefined(self.lastattacker.origin))
    return 100;

  if(!maps\mp\_utility::isreallyalive(self.lastattacker))
    return 100;

  var_1 = distancesquared(var_0.origin, self.lastattacker.origin);

  if(var_1 > 4000000)
    return 100;

  var_2 = var_1 / 4000000;
  return var_2 * 100;
}

preferalliesbydistance(var_0) {
  if(var_0.totalplayers[self.team] == 0)
    return 0;

  var_1 = var_0.distsumsquared[self.team] / var_0.totalplayers[self.team];
  var_1 = min(var_1, 3240000);
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

avoidenemiesbydistance(var_0) {
  var_1 = "all";

  if(level.teambased)
    var_1 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);

  if(var_0.totalplayers[var_1] == 0)
    return 100;

  var_2 = min(var_0.mindistsquared[var_1], 3240000);
  var_3 = var_2 / 3240000;
  return var_3 * 100;
}

avoidflagbydistance(var_0) {
  if(var_0.enemyflagdist > 0)
    var_1 = var_0.friendlyflagdist / var_0.enemyflagdist / var_0.friendlyflag.highestspawndistratio * 1.33;
  else
    var_1 = 0;

  return var_1 * 100;
}

preferdompoints(var_0, var_1) {
  if(var_1[0] && var_0.preferreddompoint == 0)
    return 100;

  if(var_1[1] && var_0.preferreddompoint == 1)
    return 100;

  if(var_1[2] && var_0.preferreddompoint == 2)
    return 100;

  return 0;
}

preferbyteambase(var_0, var_1) {
  if(isdefined(var_0.teambase) && var_0.teambase == var_1)
    return 100;

  return 0;
}

randomspawnscore(var_0) {
  return randomintrange(0, 99);
}

avoidzone(var_0, var_1) {
  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_3 = var_2 - 692224;
  var_4 = 6067776;
  var_5 = 1867776;

  if(var_3 >= var_5)
    return 100 * (1.0 - 0.25 * (var_3 - var_5) / (var_4 - var_5));
  else if(var_3 > 0)
    return 100.0 * (var_3 / var_5);
  else
    return 0;
}

preferplayeranchors(var_0) {
  var_1 = self.team;
  var_2 = maps\mp\_utility::getotherteam(var_1);

  if(var_0.nearbyplayers[var_1] == 0)
    return 0;

  if(var_0.nearbyplayers[var_2] == 0)
    return 100;

  var_3 = var_0.nearbyplayers[var_1] - var_0.nearbyplayers[var_2];

  if(var_3 <= 0)
    return 0;

  if(var_3 == 1)
    return 50.0;

  if(var_3 >= 2)
    return 75.0;

  return 0;
}