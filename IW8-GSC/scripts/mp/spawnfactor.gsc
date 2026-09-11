/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnfactor.gsc
***********************************************/

function init_spawn_factors() {
  if(!isDefined(level.spawn_closeenemydistsq)) {
    level.spawn_closeenemydistsq = 250000;
  }

  if(!isDefined(level.enemyspawninfluencedistsq)) {
    level.enemyspawninfluencedistsq = 810000;
  }

  registerfactor("preferOptimalTTLOS", &preferoptimalttlos, 0, undefined);
  registerfactor("avoidShortTimeToEnemySight", &avoidshorttimetoenemysight, 0, undefined);
  registerfactor("preferAlliesByDistance", &preferalliesbydistance, 0, undefined);
  registerfactor("preferCloseToAlly", &preferclosetoally, 0, undefined);
  registerfactor("avoidRecentlyUsedByEnemies", &avoidrecentlyusedbyenemies, 0, undefined);
  registerfactor("avoidEnemiesByDistance", &avoidenemiesbydistance, 0, undefined);
  registerfactor("avoidEnemyInfluence", &avoidenemyinfluence, 0, undefined);
  registerfactor("avoidLastDeathLocation", &avoidlastdeathlocation, 0, undefined);
  registerfactor("avoidLastAttackerLocation", &avoidlastattackerlocation, 0, undefined);
  registerfactor("avoidShortTimeToJumpingEnemySight", &avoidshorttimetojumpingenemysight, 0, undefined);
  registerfactor("avoidVeryShortTimeToJumpingEnemySight", &avoidveryshorttimetojumpingenemysight, 0, undefined);
  registerfactor("avoidSameSpawn", &avoidsamespawn, 0, undefined);
  registerfactor("avoidRecentlyUsedByAnyone", &avoidrecentlyusedbyanyone, 0, undefined);
  registerfactor("randomSpawnScore", &randomspawnscore, 0, undefined);
  registerfactor("preferNearLastTeamSpawn", &prefernearlastteamspawn, 0, undefined);
  registerfactor("preferNearGroupsOfTeamMates", &preferneargroupsofteammates, 0, undefined);
  registerfactor("preferOccupiedLanes", &preferoccupiedlanes, 0, undefined);
  registerfactor("preferToBalanceLanes", &prefertobalancelanes, 0, undefined);
  registerfactor("avoidClosestEnemy", &avoidclosestenemy, 0, undefined);
  registerfactor("scriptOnlyTest", &scriptonlytest, 1, ["test"]);
  registerfactor("avoidClosestEnemyByDistance", &avoidclosestenemybydistance, 1, ["closestEnemyInfluenceDistSq"]);
  registerfactor("preferNearSinglePoint", &prefernearsinglepoint, 1, ["singlePointPos", "minDistToSinglePointSq", "maxDistToSinglePointSq", "distRangeToSinglePointSq"]);
  registerfactor("preferDomPoints", &preferdompoints, 1, ["preferredDomPoints", "secondaryDomPoints"]);
  registerfactor("preferShortestDistToKOTHZone", &prefershortestdisttokothzone, 1, ["activeKOTHZoneNumber", "maxSquaredDistToObjective"]);
  registerfactor("avoidCloseToKOTHZone", &avoidclosetokothzone, 1, ["activeKOTHZoneNumber", "kothZoneDeadzoneDistSq"]);
  registerfactor("preferClosePoints", &preferclosepoints, 1, ["closestPoints"]);
  registerfactor("avoidRugbyOffsides", &avoidrugbyoffsides, 1, ["juggPos", "rugbyFieldDir2D"]);
  registerfactor("oneUseSpawns", &oneusespawns, 1, undefined);
  registerfactor("avoidCloseToDefenderFlag", &checkuseconditioninthink, 1, ["activeCarrierPosition", "defenderFlagPosition", "avoidDefenderFlagDeadZoneDistSq"]);
  registerfactor("avoidCloseToDefenderFlagSpawn", &checkweaponswitch, 1, ["avoidDefenderFlagDeadZoneDistSq"]);
  initfrontline();
}

function registerfactor(var0, var1, var2, var3) {
  if(!isDefined(level.spawnglobals.factors)) {
    level.spawnglobals.factors = [];
  }

  var4 = spawnStruct();
  level.spawnglobals.factors[var0] = var4;
  var4.function = var1;
  var4.paramreflist = var3;
  var4.isscriptonly = var2;
}

function isfactorregistered(var0) {
  return isDefined(level.spawnglobals.factors[var0]);
}

function isfactorscriptonly(var0) {
  return level.spawnglobals.factors[var0].isscriptonly;
}

function getfactorfunction(var0) {
  return level.spawnglobals.factors[var0].function;
}

function getfactorparamreflist(var0) {
  return level.spawnglobals.factors[var0].paramreflist;
}

function calculatefactorscore(var0, var1, var2) {
  if(!isfactorregistered(var1)) {
    return 0;
  }

  var3 = getfactorfunction(var1);
  var4 = getfactorparamreflist(var1);
  var5 = level.spawnglobals.activespawncontext;

  if(isDefined(var4)) {
    if(isDefined(var5.factorparams)) {}
  }

  var13 = [[var3]](var0);
  var13 = clamp(var13, 0, 100);
  var13 *= var2;
  var0.totalpossiblescore += 100 * var2;
  var0.lastscore[self.team] += var13;
  var0.totalscore += var13;
  return var13;
}

function critical_factor(var0, var1) {
  var2 = [[var0]](var1);
  var2 = clamp(var2, 0, 100);
  return var2;
}

function avoidcarepackages(var0) {
  foreach(var2 in level.carepackages) {
    if(!isDefined(var2)) {
      continue;
    }

    if(distancesquared(var0.origin, var2.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

function avoidbradleys(var0) {
  if(isDefined(level.bradley)) {
    foreach(var2 in level.bradley.activevehicles["total"]) {
      if(distancesquared(var0.origin, var2.origin) < 50625) {
        return 0;
      }
    }

    foreach(var2 in level.bradley.inactivevehicles["total"]) {
      if(distancesquared(var0.origin, var2.origin) < 50625) {
        return 0;
      }
    }
  }

  return 100;
}

function avoidgrenades(var0) {
  foreach(var2 in level.grenades) {
    if(!isDefined(var2) || !isexplosivedangeroustoplayer(var2, self) || istrue(var2.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(var0.origin, var2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

function avoidmines(var0) {
  var1 = level.mines;

  if(isDefined(level.traps) && level.traps.size > 0) {
    var1 = scripts\engine\utility::array_combine(var1, level.traps);
  }

  foreach(var3 in var1) {
    if(!isDefined(var3) || !isexplosivedangeroustoplayer(var3, self) || istrue(var3.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(var0.origin, var3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

function isexplosivedangeroustoplayer(var0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var0.team)) {
    return 1;
  }

  var1 = undefined;

  if(isDefined(self.owner)) {
    if(var0 == self.owner) {
      return 1;
    }

    var1 = self.owner.team;
  }

  if(isDefined(var1)) {
    return (var1 != var0.team);
  }

  return 1;
}

function avoidcornervisibleenemies(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(var0.cornersights[var1] > 0) {
    return 0;
  }

  return 100;
}

function avoidfullvisibleenemies(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(var0.fullsights[var1] > 0) {
    return 0;
  }

  return 100;
}

function avoidcloseenemies(var0) {
  var1 = [];
  var2 = [];

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var1 = "all";
  }

  foreach(var4 in var1) {
    if(var0.totalplayers[var4] == 0) {
      continue;
    }

    var2 = var4;
  }

  if(var2.size == 0) {
    return 100;
  }

  foreach(var4 in var2) {
    if(var0.mindistsquared[var4] < level.spawn_closeenemydistsq) {
      return 0;
    }
  }

  return 100;
}

function avoidtelefrag(var0) {
  return 100;
}

function avoidsamespawn(var0) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var0) {
    return 0;
  }

  return 100;
}

function avoidenemyspawn(var0) {
  if(isDefined(self.team) && isDefined(var0.lastspawnteam) && (!level.teambased || var0.lastspawnteam != self.team)) {
    var1 = var0.lastspawntime + 500;

    if(gettime() < var1) {
      return 0;
    }
  }

  return 100;
}

function avoidrecentlyusedbyenemies(var0) {
  var1 = !level.teambased || isDefined(var0.lastspawnteam) && self.team != var0.lastspawnteam;

  if(var1 && isDefined(var0.lastspawntime)) {
    var2 = gettime() - var0.lastspawntime;
    var0.analytics.spawnusedbyenemies = var2 / 1000;

    if(var2 > 4000) {
      return 100;
    }

    return (var2 / 4000 * 100);
  }

  return 100;
}

function avoidrecentlyusedbyanyone(var0) {
  if(isDefined(var0.lastspawntime)) {
    var1 = gettime() - var0.lastspawntime;
    var0.analytics.timesincelastspawn = var1 / 1000;

    if(var1 > 4000) {
      return 100;
    }

    return (var1 / 4000 * 100);
  }

  return 100;
}

function avoidlastdeathlocation(var0) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var1 = distancesquared(var0.origin, self.lastdeathpos);

  if(var1 > 810000) {
    return 100;
  }

  var2 = var1 / 810000;
  return var2 * 100;
}

function avoidlastattackerlocation(var0) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin)) {
    return 100;
  }

  if(!scripts\mp\utility\player::isreallyalive(self.lastattacker)) {
    return 100;
  }

  var1 = distancesquared(var0.origin, self.lastattacker.origin);

  if(var1 > 810000) {
    return 100;
  }

  var2 = var1 / 810000;
  return var2 * 100;
}

function initfrontline() {
  var0 = getglobalfrontlineinfo();

  if(getdvarint("scr_ignore_frontline_anchor", 0) == 1) {
    return;
  }

  var1 = [];

  if(istrue(level.testtdmanywhere)) {
    var2 = getdvarfloat("scr_tdmAnywhere_frontlineHeading", randomfloatrange(0, 359));
    var0.usinganchors = 1;
    var0.anchordir = anglesToForward((0, var2, 0));
    var0.anchorrt = anglestoright((0, var2, 0));

    if(isDefined(level.mapcenter)) {
      var0.primaryanchorpos = (level.mapcenter[0], level.mapcenter[1], 0);
    }

    level.tdmanywherefrontline = var0;
    return;
  }

  var1 = getEntArray("mp_frontline_anchor", "classname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var3 = [];

    foreach(var5 in var1) {
      if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == level.localeid) {
        var3 = var5;
        continue;
      }

      var5 delete();
    }

    var1 = var3;
  } else if(var1.size != 1) {
    var7 = [];

    foreach(var5 in var1) {
      if(!isDefined(var5.script_noteworthy) || !issubstr(var5.script_noteworthy, "locale")) {
        var7 = var5;
        continue;
      }

      var5 delete();
    }

    var1 = var7;
  }

  if(var1.size != 0) {
    var0.usinganchors = 1;
    var0.anchordir = anglesToForward(var1[0].angles);
    var0.primaryanchorpos = (var1[0].origin[0], var1[0].origin[1], 0);
    return;
  }
}

function updatefrontline(var0) {
  if(!updatefrontlineposition()) {
    return;
  }

  runfrontlinespawntrapchecks(var0);
  updatefrontlinedebug();
}

function updatefrontlineposition() {
  if(!currentspawnlogicsupportsfrontline()) {
    return false;
  }

  var0 = getglobalfrontlineinfo();
  var1 = gettime();

  if(!isDefined(var0.lastupdatetime)) {
    var0.lastupdatetime = var1;
  } else if(var0.isactive["allies"] && var0.isactive["axis"]) {
    var0.uptime += var0.lastupdatetimedelta;
  } else {
    var0.downtime += var0.lastupdatetimedelta;
  }

  var2 = (var1 - var0.lastupdatetime) / 1000;
  var0.lastupdatetime = var1;
  var0.lastupdatetimedelta = var2;
  var3 = getfrontlineteamcenter("allies");

  if(!isDefined(var3)) {
    return false;
  }

  var3 = (var3[0], var3[1], 0);
  var0.alliesaverage = var3;
  var4 = getfrontlineteamcenter("axis");

  if(!isDefined(var4)) {
    return false;
  }

  var4 = (var4[0], var4[1], 0);
  var0.axisaverage = var4;

  if(var0.usinganchors) {
    var5 = var3 - var0.primaryanchorpos;
    var6 = vectordot(var0.anchordir, var5);
    var7 = var0.anchordir * var6 + var0.primaryanchorpos;
    var0.projectedalliescenter = var7;
    var5 = var4 - var0.primaryanchorpos;
    var8 = vectordot(var0.anchordir, var5);
    var9 = var0.anchordir * var8 + var0.primaryanchorpos;
    var0.projectedaxiscenter = var9;
    var10 = abs(var6 - var8);

    if(var10 < 600 && isDefined(var0.teamdiffyaw)) {
      var0.contested = 1;
    } else {
      var0.contested = 0;
      var0.midpoint = var7 + (var9 - var7) * 0.5;
      var11 = var9 - var7;
      var0.teamdiffyaw = vectortoyaw(var11);
    }
  } else {
    var12 = var4 - var3;
    var13 = vectortoyaw(var12);
    var0.teamdiffyaw = var13;
    var14 = var3 + var12 * 0.5;
    var0.midpoint = var14;
  }

  var15 = anglesToForward((0, var0.teamdiffyaw, 0));
  var16 = level.spawnpoints;
  var16 = scripts\mp\spawnscoring::checkdynamicspawns(var16);

  foreach(var18 in var16) {
    var19 = var0.midpoint - var18.origin;
    var20 = vectordot(var19, var15);
    var18.frontlineteam = scripts\engine\utility::ter_op(var20 > 0, "allies", "axis");
  }

  return true;
}

function updatefrontlinedebug() {
  var0 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  var1 = scripts\mp\analyticslog::analyticslogenabled();

  if(!var0 && !var1) {
    return;
  }

  var2 = getglobalfrontlineinfo();

  if(!isDefined(var2.logids) && isDefined(level.matchrecording_generateid)) {
    var2.logids = [];
    var2.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    var2.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!var2.isactive["allies"] && !var2.isactive["axis"]) {
    return;
  }

  var3 = (var2.midpoint[0], var2.midpoint[1], level.mapcenter[2]);
  var4 = anglestoright((0, var2.teamdiffyaw, 0));
  logfrontlinetomatchrecording(var3, var4, var2.isactive["allies"], var2.isactive["axis"]);

  if(isDefined(level.matchrecording_logevent)) {
    var5 = scripts\engine\utility::ter_op(var2.isactive["axis"], var2.axisaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var2.logids["axisCenter"], "axis", "ANCHOR", var5[0], var5[1], gettime());
    var6 = scripts\engine\utility::ter_op(var2.isactive["allies"], var2.alliesaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var2.logids["alliesCenter"], "allies", "ANCHOR", var6[0], var6[1], gettime());
    return;
  }
}

function logfrontlinetomatchrecording(var0, var1, var2, var3) {
  if(isDefined(level.matchrecording_logevent)) {
    var4 = var0 + var1 * 5000;
    var5 = var0 - var1 * 5000;

    if(!isDefined(level.matchrecording_frontlinelogid)) {
      level.matchrecording_frontlinelogid = [[level.matchrecording_generateid]]();
    }

    var6 = undefined;

    if(var2 && var3) {
      var6 = "FRONT_LINE";
    } else {
      var6 = scripts\engine\utility::ter_op(var2, "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level.matchrecording_logevent]](level.matchrecording_frontlinelogid, "allies", var6, var4[0], var4[1], gettime(), undefined, var5[0], var5[1]);
    return;
  }
}

function getfrontlineteamcenter(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var3)) {
      continue;
    }

    if(!var3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    if(var3.team == var0) {
      var1 = var3;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var5 = scripts\mp\utility\entity::getaverageorigin(var1);
  return var5;
}

function runfrontlinespawntrapchecks(var0) {
  if(!currentspawnlogicsupportsfrontline()) {
    return;
  }

  var1 = getglobalfrontlineinfo();
  var1.isactive[var0] = 1;

  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }

  var2 = getdvarint("scr_frontline_min_spawns", 0);

  if(var2 == 0) {
    var2 = 4;
  }

  var3 = scripts\mp\utility\game::getotherteam(var0)[0];
  var4 = 0;
  var5 = level.spawnpoints;
  var5 = scripts\mp\spawnscoring::checkdynamicspawns(var5);

  foreach(var7 in var5) {
    if(!isDefined(var7.frontlineteam) || var7.frontlineteam != var0) {
      continue;
    }

    if(!isDefined(var7.fullsights) || !isDefined(var7.fullsights[var3]) || var7.fullsights[var3] <= 0) {
      var4++;
    }
  }

  var9 = var4 / var5.size;

  if(var4 < var2 || var9 < 0) {
    if(var4 < var2) {
      var1.disabledreason[var0] = 0;
    } else {
      var1.disabledreason[var0] = 1;
    }

    var1.isactive[var0] = 0;
    return;
  }
}

function currentspawnlogicsupportsfrontline() {
  return istrue(level.spawnglobals.frontlinelogictypes[level.spawnglobals.activespawnlogic]);
}

function getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["allies"] = 0;
    level.frontlineinfo.isactive["axis"] = 0;
    level.frontlineinfo.uptime = 0;
    level.frontlineinfo.downtime = 0;
    level.frontlineinfo.contested = 0;
    level.frontlineinfo.usinganchors = 0;
  }

  return level.frontlineinfo;
}

function preferalliesbydistance(var0) {
  if(var0.totalplayers[self.team] == 0) {
    return 0;
  }

  var1 = var0.distsumsquared[self.team] / var0.totalplayers[self.team];
  var1 = min(var1, 3240000);
  var0.analytics.allyaveragedist = var1;
  var2 = 1 - var1 / 3240000;
  return var2 * 100;
}

function preferclosetoally(var0) {
  var1 = min(var0.mindistsquared[self.team], 3240000);
  var2 = 1 - var1 / 3240000;
  return var2 * 100;
}

function avoidenemiesbydistance(var0) {
  var1 = [];
  var2 = [];

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var1 = "all";
  }

  foreach(var4 in var1) {
    if(var0.totalplayers[var4] == 0) {
      continue;
    }

    var2 = var4;
  }

  if(var2.size == 0) {
    return 100;
  }

  foreach(var4 in var2) {
    if(var0.mindistsquared[var4] < 250000) {
      return 0;
    }
  }

  var8 = 0;
  var9 = 0;

  foreach(var4 in var2) {
    var8 += var0.distsumsquaredcapped[var4];
    var9 += var0.totalplayers[var4];
  }

  var12 = var8 / var9;
  var12 = min(var12, 7290000);
  var13 = var12 / 7290000;
  var0.analytics.enemyaveragedist = var12;
  return var13 * 100;
}

function avoidenemyinfluence(var0) {
  var1 = undefined;

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var1 = "all";
  }

  if(var0.mindistsquared[var1] < level.enemyspawninfluencedistsq) {
    return 0;
  }

  return 100;
}

function avoidclosestenemy(var0) {
  var1 = [];
  var2 = [];

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var1 = "all";
  }

  foreach(var4 in var1) {
    if(var0.totalplayers[var4] == 0) {
      continue;
    }

    var2 = var4;
  }

  if(var2.size == 0) {
    return 100;
  }

  var6 = 0;

  foreach(var4 in var2) {
    if(var0.mindistsquared[var4] < 250000) {
      return 0;
    }

    var8 = min(var0.mindistsquared[var4], 3240000);
    var9 = var8 / 3240000;
    var6 += var9 * 100;
  }

  return var6 / var2.size;
}

function avoidclosestenemybydistance(var0) {
  var1 = level.spawnglobals.activespawncontext.factorparams["closestEnemyInfluenceDistSq"];
  var2 = "all";

  if(level.teambased) {
    var2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var3 = 0;

  foreach(var5 in level.teamdata[var2]["players"]) {
    var6 = distancesquared(var0.origin, var5.origin);

    if(var6 < var3) {
      var3 = var6;
    }
  }

  if(var3 < 250000) {
    return 0;
  }

  var8 = min(var3, var1);
  var9 = var8 / var1;
  return var9 * 100;
}

function preferdompoints(var0) {
  var1 = level.spawnglobals.activespawncontext.factorparams["preferredDomPoints"];
  var2 = level.spawnglobals.activespawncontext.factorparams["secondaryDomPoints"];
  var3 = var0.scriptdata;

  if(isDefined(var3.domflagassignments)) {
    if(var3.domflagassignments &var1) {
      return 100;
    } else if(var3.domflagassignments &var2) {
      return 50;
    }
  }

  return 0;
}

function preferclosepoints(var0) {
  var1 = level.spawnglobals.activespawncontext.factorparams["closestPoints"];

  foreach(var3 in var1) {
    if(var0 == var3) {
      return 100;
    }
  }

  return 0;
}

function preferbyteambase(var0, var1) {
  if(isDefined(var0.teambase) && var0.teambase == var1) {
    return 100;
  }

  return 0;
}

function preferoptimalttlos(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var2 = 1 - var0.maxsightvalue[var1];
  var3 = scripts\mp\spawnlogic::getmaxdistancetolos();
  var4 = var2 * var3;

  if(var4 > 1200) {
    var5 = (var3 - var4) / (var3 - 1200);
    return (100 * var5);
  }

  var5 /= 1200;
  return 100 * var5;
}

function avoidshorttimetoenemysight(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var2 = 1 - var0.maxsightvalue[var1];
  var0.analytics.maxenemysightfraction = var2;
  return (1 - var2) * 0 + var2 * 100;
}

function avoidshorttimetojumpingenemysight(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var2 = 1 - var0.maxjumpsightvalue[var1];
  var0.analytics.maxjumpingenemysightfraction = var2;
  return (1 - var2) * 0 + var2 * 100;
}

function avoidveryshorttimetojumpingenemysight(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var2 = 1 - var0.maxjumpsightvalue[var1];
  var3 = var2 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(var3 < 300) {
    return 0;
  }

  return 100;
}

function randomspawnscore(var0) {
  var0.analytics.randomscore = randomintrange(0, 99);
  return var0.analytics.randomscore;
}

function maxplayerspawninfluencedistsquared(var0) {
  return 3240000;
}

function prefershortestdisttokothzone(var0) {
  var1 = level.spawnglobals.activespawncontext;
  var2 = var1.factorparams["activeKOTHZoneNumber"];
  var3 = var0.scriptdata.distsqtokothzones[var2];
  var4 = var1.factorparams["maxSquaredDistToObjective"];
  var5 = 1 - var3 / var4;
  return 100 * var5 + 0;
}

function avoidclosetokothzone(var0) {
  var1 = level.spawnglobals.activespawncontext;
  var2 = var1.factorparams["activeKOTHZoneNumber"];
  var3 = var0.scriptdata.distsqtokothzones[var2];
  var4 = var1.factorparams["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var3 < var4, 0, 100);
}

function prefernearlastteamspawn(var0) {
  var1 = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(var1)) {
    return 0;
  }

  var2 = distancesquared(var1.origin, var0.origin);
  var2 = int(min(var2, 9000000));
  var3 = 1 - var2 / 9000000;
  return 100 * var3 + 0;
}

function preferneargroupsofteammates(var0) {
  var1 = level.spawnglobals;
  var2 = -1;

  foreach(var4 in var1.teamclusters[self.team].clusterlist) {
    if(var4.players.size <= 1) {
      continue;
    }

    var5 = distance2dsquared(var4.center, var0.origin);

    if(var2 < 0 || var5 < var2) {
      var2 = var5;
    }
  }

  if(var2 < 0) {
    return 0;
  }

  if(var2 < 10000) {
    return 100;
  }

  var2 = int(min(var2, 9000000));
  var7 = 1 - (var2 - 10000) / 8990000;
  return 100 * var7 + 0;
}

function preferoccupiedlanes(var0) {
  var1 = level.spawnglobals;
  var2 = "all";

  if(level.teambased) {
    var2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(!isDefined(var1.occupiedlanemasks[var2])) {
    return 0;
  }

  if((var0.lanemask &var1.occupiedlanemasks[var2]) != 0) {
    return 100;
  }

  return 0;
}

function prefertobalancelanes(var0) {
  var1 = level.spawnglobals;
  var2 = scripts\mp\spawnlogic::getspawnteam(self);
  var3 = "all";

  if(level.teambased) {
    var3 = scripts\mp\utility\teams::getenemyteams(var2)[0];
  }

  if(!isDefined(var1.occupiedlanemasks[var3])) {
    return 0;
  }

  var4 = var0.lanemask &var1.occupiedlanemasks[var3];
  var5 = isDefined(var1.occupiedlanemasks[var2]) && var0.lanemask &var1.occupiedlanemasks[var2];

  if(var4 && !var5) {
    return 100;
  }

  return 0;
}

function scriptonlytest(var0) {
  return false;
}

function prefernearsinglepoint(var0) {
  var1 = level.spawnglobals.activespawncontext;
  var2 = var1.factorparams["singlePointPos"];
  var3 = var1.factorparams["minDistToSinglePointSq"];
  var4 = var1.factorparams["maxDistToSinglePointSq"];
  var5 = var1.factorparams["distRangeToSinglePointSq"];
  var6 = distance2dsquared(var2, var0.origin);

  if(var6 >= var4) {
    return 0;
  }

  if(var6 <= var3) {
    return 100;
  }

  var7 = 1 - (var6 - var3) / var5;
  return 100 * var7;
}

function avoidrugbyoffsides(var0) {
  var1 = level.spawnglobals.activespawncontext;
  var2 = var1.factorparams["juggPos"];
  var3 = var1.factorparams["rugbyFieldDir2D"];
  var4 = (var0.origin - var2) * (1, 1, 0);
  var5 = vectordot(var4, var3);

  if(var5 >= 0) {
    return 0;
  }

  return 100;
}

function oneusespawns(var0) {
  var1 = var0.scriptdata;

  if(istrue(var1.used)) {
    return 0;
  }

  return 100;
}

function checkuseconditioninthink(var0, var1) {
  var2 = undefined;
  var3 = var1["activeCarrierPosition"];
  var4 = var1["defenderFlagPosition"];
  var5 = var1["avoidDefenderFlagDeadZoneDistSq"];

  if(isDefined(var3)) {
    var2 = var3;
  } else if(isDefined(var4)) {
    var2 = var4;
  }

  if(isDefined(var2)) {
    var6 = distancesquared(var2, var0.origin);
    return scripts\engine\utility::ter_op(var6 < var5, 0, 100);
  }

  return 100;
}

function checkweaponswitch(var0, var1) {
  var2 = var0.scriptdata.lootchopper_createobjective;
  var3 = var1["avoidDefenderFlagDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(var2 < var3, 0, 100);
}