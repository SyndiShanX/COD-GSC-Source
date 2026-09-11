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

function registerfactor(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.spawnglobals.factors)) {
    level.spawnglobals.factors = [];
  }

  var_4 = spawnStruct();
  level.spawnglobals.factors[var_0] = var_4;
  var_4.function = var_1;
  var_4.paramreflist = var_3;
  var_4.isscriptonly = var_2;
}

function isfactorregistered(var_0) {
  return isDefined(level.spawnglobals.factors[var_0]);
}

function isfactorscriptonly(var_0) {
  return level.spawnglobals.factors[var_0].isscriptonly;
}

function getfactorfunction(var_0) {
  return level.spawnglobals.factors[var_0].function;
}

function getfactorparamreflist(var_0) {
  return level.spawnglobals.factors[var_0].paramreflist;
}

function calculatefactorscore(var_0, var_1, var_2) {
  if(!isfactorregistered(var_1)) {
    return 0;
  }

  var_3 = getfactorfunction(var_1);
  var_4 = getfactorparamreflist(var_1);
  var_5 = level.spawnglobals.activespawncontext;

  if(isDefined(var_4)) {
    if(isDefined(var_5.factorparams)) {}
  }

  var_13 = [[var_3]](var_0);
  var_13 = clamp(var_13, 0, 100);
  var_13 *= var_2;
  var_0.totalpossiblescore += 100 * var_2;
  var_0.lastscore[self.team] += var_13;
  var_0.totalscore += var_13;
  return var_13;
}

function critical_factor(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

function avoidcarepackages(var_0) {
  foreach(var_2 in level.carepackages) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_2.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

function avoidbradleys(var_0) {
  if(isDefined(level.bradley)) {
    foreach(var_2 in level.bradley.activevehicles["total"]) {
      if(distancesquared(var_0.origin, var_2.origin) < 50625) {
        return 0;
      }
    }

    foreach(var_2 in level.bradley.inactivevehicles["total"]) {
      if(distancesquared(var_0.origin, var_2.origin) < 50625) {
        return 0;
      }
    }
  }

  return 100;
}

function avoidgrenades(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isDefined(var_2) || !isexplosivedangeroustoplayer(var_2, self) || istrue(var_2.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

function avoidmines(var_0) {
  var_1 = level.mines;

  if(isDefined(level.traps) && level.traps.size > 0) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.traps);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isexplosivedangeroustoplayer(var_3, self) || istrue(var_3.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

function isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team)) {
    return 1;
  }

  var_1 = undefined;

  if(isDefined(self.owner)) {
    if(var_0 == self.owner) {
      return 1;
    }

    var_1 = self.owner.team;
  }

  if(isDefined(var_1)) {
    return (var_1 != var_0.team);
  }

  return 1;
}

function avoidcornervisibleenemies(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(var_0.cornersights[var_1] > 0) {
    return 0;
  }

  return 100;
}

function avoidfullvisibleenemies(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(var_0.fullsights[var_1] > 0) {
    return 0;
  }

  return 100;
}

function avoidcloseenemies(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var_1 = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }

    var_2 = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < level.spawn_closeenemydistsq) {
      return 0;
    }
  }

  return 100;
}

function avoidtelefrag(var_0) {
  return 100;
}

function avoidsamespawn(var_0) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var_0) {
    return 0;
  }

  return 100;
}

function avoidenemyspawn(var_0) {
  if(isDefined(self.team) && isDefined(var_0.lastspawnteam) && (!level.teambased || var_0.lastspawnteam != self.team)) {
    var_1 = var_0.lastspawntime + 500;

    if(gettime() < var_1) {
      return 0;
    }
  }

  return 100;
}

function avoidrecentlyusedbyenemies(var_0) {
  var_1 = !level.teambased || isDefined(var_0.lastspawnteam) && self.team != var_0.lastspawnteam;

  if(var_1 && isDefined(var_0.lastspawntime)) {
    var_2 = gettime() - var_0.lastspawntime;
    var_0.analytics.spawnusedbyenemies = var_2 / 1000;

    if(var_2 > 4000) {
      return 100;
    }

    return (var_2 / 4000 * 100);
  }

  return 100;
}

function avoidrecentlyusedbyanyone(var_0) {
  if(isDefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;
    var_0.analytics.timesincelastspawn = var_1 / 1000;

    if(var_1 > 4000) {
      return 100;
    }

    return (var_1 / 4000 * 100);
  }

  return 100;
}

function avoidlastdeathlocation(var_0) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var_1 = distancesquared(var_0.origin, self.lastdeathpos);

  if(var_1 > 810000) {
    return 100;
  }

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

function avoidlastattackerlocation(var_0) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin)) {
    return 100;
  }

  if(!scripts\mp\utility\player::isreallyalive(self.lastattacker)) {
    return 100;
  }

  var_1 = distancesquared(var_0.origin, self.lastattacker.origin);

  if(var_1 > 810000) {
    return 100;
  }

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

function initfrontline() {
  var_0 = getglobalfrontlineinfo();

  if(getdvarint("scr_ignore_frontline_anchor", 0) == 1) {
    return;
  }

  var_1 = [];

  if(istrue(level.testtdmanywhere)) {
    var_2 = getdvarfloat("scr_tdmAnywhere_frontlineHeading", randomfloatrange(0, 359));
    var_0.usinganchors = 1;
    var_0.anchordir = anglesToForward((0, var_2, 0));
    var_0.anchorrt = anglestoright((0, var_2, 0));

    if(isDefined(level.mapcenter)) {
      var_0.primaryanchorpos = (level.mapcenter[0], level.mapcenter[1], 0);
    }

    level.tdmanywherefrontline = var_0;
    return;
  }

  var_1 = getEntArray("mp_frontline_anchor", "classname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_3 = [];

    foreach(var_5 in var_1) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
        var_3 = var_5;
        continue;
      }

      var_5 delete();
    }

    var_1 = var_3;
  } else if(var_1.size != 1) {
    var_7 = [];

    foreach(var_5 in var_1) {
      if(!isDefined(var_5.script_noteworthy) || !issubstr(var_5.script_noteworthy, "locale")) {
        var_7 = var_5;
        continue;
      }

      var_5 delete();
    }

    var_1 = var_7;
  }

  if(var_1.size != 0) {
    var_0.usinganchors = 1;
    var_0.anchordir = anglesToForward(var_1[0].angles);
    var_0.primaryanchorpos = (var_1[0].origin[0], var_1[0].origin[1], 0);
    return;
  }
}

function updatefrontline(var_0) {
  if(!updatefrontlineposition()) {
    return;
  }

  runfrontlinespawntrapchecks(var_0);
  updatefrontlinedebug();
}

function updatefrontlineposition() {
  if(!currentspawnlogicsupportsfrontline()) {
    return false;
  }

  var_0 = getglobalfrontlineinfo();
  var_1 = gettime();

  if(!isDefined(var_0.lastupdatetime)) {
    var_0.lastupdatetime = var_1;
  } else if(var_0.isactive["allies"] && var_0.isactive["axis"]) {
    var_0.uptime += var_0.lastupdatetimedelta;
  } else {
    var_0.downtime += var_0.lastupdatetimedelta;
  }

  var_2 = (var_1 - var_0.lastupdatetime) / 1000;
  var_0.lastupdatetime = var_1;
  var_0.lastupdatetimedelta = var_2;
  var_3 = getfrontlineteamcenter("allies");

  if(!isDefined(var_3)) {
    return false;
  }

  var_3 = (var_3[0], var_3[1], 0);
  var_0.alliesaverage = var_3;
  var_4 = getfrontlineteamcenter("axis");

  if(!isDefined(var_4)) {
    return false;
  }

  var_4 = (var_4[0], var_4[1], 0);
  var_0.axisaverage = var_4;

  if(var_0.usinganchors) {
    var_5 = var_3 - var_0.primaryanchorpos;
    var_6 = vectordot(var_0.anchordir, var_5);
    var_7 = var_0.anchordir * var_6 + var_0.primaryanchorpos;
    var_0.projectedalliescenter = var_7;
    var_5 = var_4 - var_0.primaryanchorpos;
    var_8 = vectordot(var_0.anchordir, var_5);
    var_9 = var_0.anchordir * var_8 + var_0.primaryanchorpos;
    var_0.projectedaxiscenter = var_9;
    var_10 = abs(var_6 - var_8);

    if(var_10 < 600 && isDefined(var_0.teamdiffyaw)) {
      var_0.contested = 1;
    } else {
      var_0.contested = 0;
      var_0.midpoint = var_7 + (var_9 - var_7) * 0.5;
      var_11 = var_9 - var_7;
      var_0.teamdiffyaw = vectortoyaw(var_11);
    }
  } else {
    var_12 = var_4 - var_3;
    var_13 = vectortoyaw(var_12);
    var_0.teamdiffyaw = var_13;
    var_14 = var_3 + var_12 * 0.5;
    var_0.midpoint = var_14;
  }

  var_15 = anglesToForward((0, var_0.teamdiffyaw, 0));
  var_16 = level.spawnpoints;
  var_16 = scripts\mp\spawnscoring::checkdynamicspawns(var_16);

  foreach(var_18 in var_16) {
    var_19 = var_0.midpoint - var_18.origin;
    var_20 = vectordot(var_19, var_15);
    var_18.frontlineteam = scripts\engine\utility::ter_op(var_20 > 0, "allies", "axis");
  }

  return true;
}

function updatefrontlinedebug() {
  var_0 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  var_1 = scripts\mp\analyticslog::analyticslogenabled();

  if(!var_0 && !var_1) {
    return;
  }

  var_2 = getglobalfrontlineinfo();

  if(!isDefined(var_2.logids) && isDefined(level.matchrecording_generateid)) {
    var_2.logids = [];
    var_2.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    var_2.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!var_2.isactive["allies"] && !var_2.isactive["axis"]) {
    return;
  }

  var_3 = (var_2.midpoint[0], var_2.midpoint[1], level.mapcenter[2]);
  var_4 = anglestoright((0, var_2.teamdiffyaw, 0));
  logfrontlinetomatchrecording(var_3, var_4, var_2.isactive["allies"], var_2.isactive["axis"]);

  if(isDefined(level.matchrecording_logevent)) {
    var_5 = scripts\engine\utility::ter_op(var_2.isactive["axis"], var_2.axisaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["axisCenter"], "axis", "ANCHOR", var_5[0], var_5[1], gettime());
    var_6 = scripts\engine\utility::ter_op(var_2.isactive["allies"], var_2.alliesaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["alliesCenter"], "allies", "ANCHOR", var_6[0], var_6[1], gettime());
    return;
  }
}

function logfrontlinetomatchrecording(var_0, var_1, var_2, var_3) {
  if(isDefined(level.matchrecording_logevent)) {
    var_4 = var_0 + var_1 * 5000;
    var_5 = var_0 - var_1 * 5000;

    if(!isDefined(level.matchrecording_frontlinelogid)) {
      level.matchrecording_frontlinelogid = [[level.matchrecording_generateid]]();
    }

    var_6 = undefined;

    if(var_2 && var_3) {
      var_6 = "FRONT_LINE";
    } else {
      var_6 = scripts\engine\utility::ter_op(var_2, "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level.matchrecording_logevent]](level.matchrecording_frontlinelogid, "allies", var_6, var_4[0], var_4[1], gettime(), undefined, var_5[0], var_5[1]);
    return;
  }
}

function getfrontlineteamcenter(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }

    if(!var_3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    if(var_3.team == var_0) {
      var_1 = var_3;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = scripts\mp\utility\entity::getaverageorigin(var_1);
  return var_5;
}

function runfrontlinespawntrapchecks(var_0) {
  if(!currentspawnlogicsupportsfrontline()) {
    return;
  }

  var_1 = getglobalfrontlineinfo();
  var_1.isactive[var_0] = 1;

  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }

  var_2 = getdvarint("scr_frontline_min_spawns", 0);

  if(var_2 == 0) {
    var_2 = 4;
  }

  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_4 = 0;
  var_5 = level.spawnpoints;
  var_5 = scripts\mp\spawnscoring::checkdynamicspawns(var_5);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.frontlineteam) || var_7.frontlineteam != var_0) {
      continue;
    }

    if(!isDefined(var_7.fullsights) || !isDefined(var_7.fullsights[var_3]) || var_7.fullsights[var_3] <= 0) {
      var_4++;
    }
  }

  var_9 = var_4 / var_5.size;

  if(var_4 < var_2 || var_9 < 0) {
    if(var_4 < var_2) {
      var_1.disabledreason[var_0] = 0;
    } else {
      var_1.disabledreason[var_0] = 1;
    }

    var_1.isactive[var_0] = 0;
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

function preferalliesbydistance(var_0) {
  if(var_0.totalplayers[self.team] == 0) {
    return 0;
  }

  var_1 = var_0.distsumsquared[self.team] / var_0.totalplayers[self.team];
  var_1 = min(var_1, 3240000);
  var_0.analytics.allyaveragedist = var_1;
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

function preferclosetoally(var_0) {
  var_1 = min(var_0.mindistsquared[self.team], 3240000);
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

function avoidenemiesbydistance(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var_1 = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }

    var_2 = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < 250000) {
      return 0;
    }
  }

  var_8 = 0;
  var_9 = 0;

  foreach(var_4 in var_2) {
    var_8 += var_0.distsumsquaredcapped[var_4];
    var_9 += var_0.totalplayers[var_4];
  }

  var_12 = var_8 / var_9;
  var_12 = min(var_12, 7290000);
  var_13 = var_12 / 7290000;
  var_0.analytics.enemyaveragedist = var_12;
  return var_13 * 100;
}

function avoidenemyinfluence(var_0) {
  var_1 = undefined;

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var_1 = "all";
  }

  if(var_0.mindistsquared[var_1] < level.enemyspawninfluencedistsq) {
    return 0;
  }

  return 100;
}

function avoidclosestenemy(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  } else {
    var_1 = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }

    var_2 = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  var_6 = 0;

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < 250000) {
      return 0;
    }

    var_8 = min(var_0.mindistsquared[var_4], 3240000);
    var_9 = var_8 / 3240000;
    var_6 += var_9 * 100;
  }

  return var_6 / var_2.size;
}

function avoidclosestenemybydistance(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["closestEnemyInfluenceDistSq"];
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var_3 = 0;

  foreach(var_5 in level.teamdata[var_2]["players"]) {
    var_6 = distancesquared(var_0.origin, var_5.origin);

    if(var_6 < var_3) {
      var_3 = var_6;
    }
  }

  if(var_3 < 250000) {
    return 0;
  }

  var_8 = min(var_3, var_1);
  var_9 = var_8 / var_1;
  return var_9 * 100;
}

function preferdompoints(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["preferredDomPoints"];
  var_2 = level.spawnglobals.activespawncontext.factorparams["secondaryDomPoints"];
  var_3 = var_0.scriptdata;

  if(isDefined(var_3.domflagassignments)) {
    if(var_3.domflagassignments &var_1) {
      return 100;
    } else if(var_3.domflagassignments &var_2) {
      return 50;
    }
  }

  return 0;
}

function preferclosepoints(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["closestPoints"];

  foreach(var_3 in var_1) {
    if(var_0 == var_3) {
      return 100;
    }
  }

  return 0;
}

function preferbyteambase(var_0, var_1) {
  if(isDefined(var_0.teambase) && var_0.teambase == var_1) {
    return 100;
  }

  return 0;
}

function preferoptimalttlos(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var_2 = 1 - var_0.maxsightvalue[var_1];
  var_3 = scripts\mp\spawnlogic::getmaxdistancetolos();
  var_4 = var_2 * var_3;

  if(var_4 > 1200) {
    var_5 = (var_3 - var_4) / (var_3 - 1200);
    return (100 * var_5);
  }

  var_5 /= 1200;
  return 100 * var_5;
}

function avoidshorttimetoenemysight(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var_2 = 1 - var_0.maxsightvalue[var_1];
  var_0.analytics.maxenemysightfraction = var_2;
  return (1 - var_2) * 0 + var_2 * 100;
}

function avoidshorttimetojumpingenemysight(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var_2 = 1 - var_0.maxjumpsightvalue[var_1];
  var_0.analytics.maxjumpingenemysightfraction = var_2;
  return (1 - var_2) * 0 + var_2 * 100;
}

function avoidveryshorttimetojumpingenemysight(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  var_2 = 1 - var_0.maxjumpsightvalue[var_1];
  var_3 = var_2 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(var_3 < 300) {
    return 0;
  }

  return 100;
}

function randomspawnscore(var_0) {
  var_0.analytics.randomscore = randomintrange(0, 99);
  return var_0.analytics.randomscore;
}

function maxplayerspawninfluencedistsquared(var_0) {
  return 3240000;
}

function prefershortestdisttokothzone(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["activeKOTHZoneNumber"];
  var_3 = var_0.scriptdata.distsqtokothzones[var_2];
  var_4 = var_1.factorparams["maxSquaredDistToObjective"];
  var_5 = 1 - var_3 / var_4;
  return 100 * var_5 + 0;
}

function avoidclosetokothzone(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["activeKOTHZoneNumber"];
  var_3 = var_0.scriptdata.distsqtokothzones[var_2];
  var_4 = var_1.factorparams["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var_3 < var_4, 0, 100);
}

function prefernearlastteamspawn(var_0) {
  var_1 = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_2 = int(min(var_2, 9000000));
  var_3 = 1 - var_2 / 9000000;
  return 100 * var_3 + 0;
}

function preferneargroupsofteammates(var_0) {
  var_1 = level.spawnglobals;
  var_2 = -1;

  foreach(var_4 in var_1.teamclusters[self.team].clusterlist) {
    if(var_4.players.size <= 1) {
      continue;
    }

    var_5 = distance2dsquared(var_4.center, var_0.origin);

    if(var_2 < 0 || var_5 < var_2) {
      var_2 = var_5;
    }
  }

  if(var_2 < 0) {
    return 0;
  }

  if(var_2 < 10000) {
    return 100;
  }

  var_2 = int(min(var_2, 9000000));
  var_7 = 1 - (var_2 - 10000) / 8990000;
  return 100 * var_7 + 0;
}

function preferoccupiedlanes(var_0) {
  var_1 = level.spawnglobals;
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  }

  if(!isDefined(var_1.occupiedlanemasks[var_2])) {
    return 0;
  }

  if((var_0.lanemask &var_1.occupiedlanemasks[var_2]) != 0) {
    return 100;
  }

  return 0;
}

function prefertobalancelanes(var_0) {
  var_1 = level.spawnglobals;
  var_2 = scripts\mp\spawnlogic::getspawnteam(self);
  var_3 = "all";

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::getenemyteams(var_2)[0];
  }

  if(!isDefined(var_1.occupiedlanemasks[var_3])) {
    return 0;
  }

  var_4 = var_0.lanemask &var_1.occupiedlanemasks[var_3];
  var_5 = isDefined(var_1.occupiedlanemasks[var_2]) && var_0.lanemask &var_1.occupiedlanemasks[var_2];

  if(var_4 && !var_5) {
    return 100;
  }

  return 0;
}

function scriptonlytest(var_0) {
  return false;
}

function prefernearsinglepoint(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["singlePointPos"];
  var_3 = var_1.factorparams["minDistToSinglePointSq"];
  var_4 = var_1.factorparams["maxDistToSinglePointSq"];
  var_5 = var_1.factorparams["distRangeToSinglePointSq"];
  var_6 = distance2dsquared(var_2, var_0.origin);

  if(var_6 >= var_4) {
    return 0;
  }

  if(var_6 <= var_3) {
    return 100;
  }

  var_7 = 1 - (var_6 - var_3) / var_5;
  return 100 * var_7;
}

function avoidrugbyoffsides(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["juggPos"];
  var_3 = var_1.factorparams["rugbyFieldDir2D"];
  var_4 = (var_0.origin - var_2) * (1, 1, 0);
  var_5 = vectordot(var_4, var_3);

  if(var_5 >= 0) {
    return 0;
  }

  return 100;
}

function oneusespawns(var_0) {
  var_1 = var_0.scriptdata;

  if(istrue(var_1.used)) {
    return 0;
  }

  return 100;
}

function checkuseconditioninthink(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_1["activeCarrierPosition"];
  var_4 = var_1["defenderFlagPosition"];
  var_5 = var_1["avoidDefenderFlagDeadZoneDistSq"];

  if(isDefined(var_3)) {
    var_2 = var_3;
  } else if(isDefined(var_4)) {
    var_2 = var_4;
  }

  if(isDefined(var_2)) {
    var_6 = distancesquared(var_2, var_0.origin);
    return scripts\engine\utility::ter_op(var_6 < var_5, 0, 100);
  }

  return 100;
}

function checkweaponswitch(var_0, var_1) {
  var_2 = var_0.scriptdata.lootchopper_createobjective;
  var_3 = var_1["avoidDefenderFlagDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(var_2 < var_3, 0, 100);
}