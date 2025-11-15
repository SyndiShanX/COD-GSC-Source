/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\spawnfactor.gsc
**************************************/

func_9758() {
  if(!isDefined(level.var_10680)) {
    level.var_10680 = 250000;
  }

  if(!isDefined(level.var_656F)) {
    level.var_656F = 810000;
  }

  func_DEF0("avoidShortTimeToEnemySight", ::func_26C2, undefined);
  func_DEF0("preferAlliesByDistance", ::preferalliesbydistance, undefined);
  func_DEF0("preferCloseToAlly", ::preferclosetoally, undefined);
  func_DEF0("avoidRecentlyUsedByEnemies", ::avoidrecentlyusedbyenemies, undefined);
  func_DEF0("avoidEnemiesByDistance", ::func_26B4, undefined);
  func_DEF0("avoidEnemyInfluence", ::func_26B5, undefined);
  func_DEF0("avoidLastDeathLocation", ::avoidlastdeathlocation, undefined);
  func_DEF0("avoidLastAttackerLocation", ::avoidlastattackerlocation, undefined);
  func_DEF0("avoidShortTimeToJumpingEnemySight", ::func_26C3, undefined);
  func_DEF0("avoidVeryShortTimeToJumpingEnemySight", ::func_26C5, undefined);
  func_DEF0("avoidSameSpawn", ::avoidsamespawn, undefined);
  func_DEF0("avoidRecentlyUsedByAnyone", ::avoidrecentlyusedbyanyone, undefined);
  func_DEF0("randomSpawnScore", ::randomspawnscore, undefined);
  func_DEF0("preferNearLastTeamSpawn", ::prefernearlastteamspawn, undefined);
  func_DEF0("preferClosePoints", ::func_D82B, ["closestPoints"]);
  func_DEF0("preferShortestDistToKOTHZone", ::func_D837, ["activeKOTHZoneNumber", "maxSquaredDistToObjective"]);
  func_DEF0("avoidCloseToKOTHZone", ::func_26B2, ["activeKOTHZoneNumber", "kothZoneDeadzoneDistSq"]);
  func_DEF0("preferDomPoints", ::func_D82E, ["preferredDomPoints"]);
  func_DEF0("avoidClosestEnemy", ::func_26AF, undefined);
  func_DEF0("avoidClosestEnemyByDistance", ::avoidclosestenemybydistance, ["closestEnemyInfluenceDistSq"]);
  func_DEF0("preferClosestToHomeBase", ::func_D82C, ["homeBaseTeam", "maxDistToHomeBase"]);
  func_DEF0("avoidCloseToBall", ::func_26B0, ["activeCarrierPosition", "ballPosition", "avoidBallDeadZoneDistSq"]);
  func_DEF0("avoidCloseToBallSpawn", ::func_26B1, ["avoidBallDeadZoneDistSq"]);
}

func_DEF0(param_00, param_01, param_02) {
  if(!isDefined(level.spawnglobals.factors)) {
    level.spawnglobals.factors = [];
  }

  var_03 = spawnStruct();
  level.spawnglobals.factors[param_00] = var_03;
  var_03.var_74D6 = param_01;
  var_03.var_C8EF = param_02;
}

isfactorregistered(param_00) {
  return isDefined(level.spawnglobals.factors[param_00]);
}

func_7EAF(param_00) {
  return level.spawnglobals.factors[param_00].var_74D6;
}

func_7EB1(param_00) {
  return level.spawnglobals.factors[param_00].var_C8EF;
}

calculatefactorscore(param_00, param_01, param_02, param_03) {
  var_04 = func_7EAF(param_01);
  var_05 = func_7EB1(param_01);
  if(isDefined(var_05)) {
    if(!isDefined(param_03)) {}

    var_0D = [[var_04]](param_00, param_03);
  } else {
    var_0D = [[var_05]](param_01);
  }

  var_0D = clamp(var_0D, 0, 100);
  var_0D = var_0D * param_02;
  param_00.var_11A3A = param_00.var_11A3A + 100 * param_02;
  param_00.var_A9E9[self.team] = param_00.var_A9E9[self.team] + var_0D;
  param_00.totalscore = param_00.totalscore + var_0D;
  return var_0D;
}

critical_factor(param_00, param_01) {
  var_02 = [
    [param_00]
  ](param_01);
  var_02 = clamp(var_02, 0, 100);
  return var_02;
}

avoidcarepackages(param_00) {
  foreach(var_02 in level.carepackages) {
    if(!isDefined(var_02)) {
      continue;
    }

    if(distancesquared(param_00.origin, var_02.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

func_26B8(param_00) {
  foreach(var_02 in level.grenades) {
    if(!isDefined(var_02) || !var_02 isexplosivedangeroustoplayer(self) || scripts\mp\utility::istrue(var_02.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(param_00.origin, var_02.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

func_26BC(param_00) {
  var_01 = scripts\engine\utility::array_combine(level.mines, level.placedims);
  if(isDefined(level.var_126BC) && level.var_126BC.size > 0) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.var_126BC);
  }

  foreach(var_03 in var_01) {
    if(!isDefined(var_03) || !var_03 isexplosivedangeroustoplayer(self) || scripts\mp\utility::istrue(var_03.shouldnotblockspawns)) {
      continue;
    }

    if(distancesquared(param_00.origin, var_03.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

isexplosivedangeroustoplayer(param_00) {
  if(!level.teambased || level.friendlyfire || !isDefined(param_00.team)) {
    return 1;
  }

  var_01 = undefined;
  if(isDefined(self.triggerportableradarping)) {
    if(param_00 == self.triggerportableradarping) {
      return 1;
    }

    var_01 = self.triggerportableradarping.team;
  }

  if(isDefined(var_01)) {
    return var_01 != param_00.team;
  }

  return 1;
}

func_26AB(param_00) {
  if(!isDefined(level.artillerydangercenters)) {
    return 100;
  }

  if(!param_00.var_C7DA) {
    return 100;
  }

  var_01 = scripts\mp\killstreaks\_airstrike::getairstrikedanger(param_00.origin);
  if(var_01 > 0) {
    return 0;
  }

  return 100;
}

func_26B3(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  if(param_00.var_466B[var_01] > 0) {
    return 0;
  }

  return 100;
}

func_26B7(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  if(param_00.var_74BC[var_01] > 0) {
    return 0;
  }

  return 100;
}

func_26AE(param_00) {
  var_01 = [];
  var_02 = [];
  if(level.teambased) {
    var_01[0] = scripts\mp\gameobjects::getenemyteam(self.team);
  } else {
    var_01[var_01.size] = "all";
  }

  foreach(var_04 in var_01) {
    if(param_00.totalplayers[var_04] == 0) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  if(var_02.size == 0) {
    return 100;
  }

  foreach(var_04 in var_02) {
    if(param_00.mindistsquared[var_04] < level.var_10680) {
      return 0;
    }
  }

  return 100;
}

func_26C4(param_00) {
  if(isDefined(self.var_1CAE)) {
    return 100;
  }

  if(positionwouldtelefrag(param_00.origin)) {
    foreach(var_02 in param_00.alternates) {
      if(!positionwouldtelefrag(var_02)) {
        return 100;
      }
    }

    return 0;
  }

  return 100;
}

avoidsamespawn(param_00) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == param_00) {
    return 0;
  }

  return 100;
}

func_26B6(param_00) {
  if(isDefined(param_00.lastspawnteam) && !level.teambased || param_00.lastspawnteam != self.team) {
    var_01 = param_00.lastspawntime + 500;
    if(gettime() < var_01) {
      return 0;
    }
  }

  return 100;
}

avoidrecentlyusedbyenemies(param_00) {
  var_01 = !level.teambased || isDefined(param_00.lastspawnteam) && self.team != param_00.lastspawnteam;
  if(var_01 && isDefined(param_00.lastspawntime)) {
    var_02 = gettime() - param_00.lastspawntime;
    param_00.analytics.spawnusedbyenemies = var_02 / 1000;
    if(var_02 > 4000) {
      return 100;
    }

    return var_02 / 4000 * 100;
  }

  return 100;
}

avoidrecentlyusedbyanyone(param_00) {
  if(isDefined(param_00.lastspawntime)) {
    var_01 = gettime() - param_00.lastspawntime;
    param_00.analytics.timesincelastspawn = var_01 / 1000;
    if(var_01 > 4000) {
      return 100;
    }

    return var_01 / 4000 * 100;
  }

  return 100;
}

avoidlastdeathlocation(param_00) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var_01 = distancesquared(param_00.origin, self.lastdeathpos);
  if(var_01 > 810000) {
    return 100;
  }

  var_02 = var_01 / 810000;
  return var_02 * 100;
}

avoidlastattackerlocation(param_00) {
  if(!isDefined(self.sethalfresparticles) || !isDefined(self.sethalfresparticles.origin)) {
    return 100;
  }

  if(!scripts\mp\utility::isreallyalive(self.sethalfresparticles)) {
    return 100;
  }

  var_01 = distancesquared(param_00.origin, self.sethalfresparticles.origin);
  if(var_01 > 810000) {
    return 100;
  }

  var_02 = var_01 / 810000;
  return var_02 * 100;
}

updatefrontline(param_00) {
  if(!updatefrontlineposition()) {
    return;
  }

  runfrontlinespawntrapchecks(param_00);
  updatefrontlinedebug();
}

updatefrontlineposition() {
  if(!func_4BED()) {
    return 0;
  }

  var_00 = getglobalfrontlineinfo();
  var_01 = gettime();
  if(!isDefined(var_00.lastupdatetime)) {
    var_00.lastupdatetime = var_01;
  } else if(var_00.isactive["allies"] && var_00.isactive["axis"]) {
    var_00.var_12F92 = var_00.var_12F92 + var_00.var_AA37;
  } else {
    var_00.var_5AFE = var_00.var_5AFE + var_00.var_AA37;
  }

  var_02 = var_01 - var_00.lastupdatetime / 1000;
  var_00.lastupdatetime = var_01;
  var_00.var_AA37 = var_02;
  var_03 = func_7ECA("allies");
  if(!isDefined(var_03)) {
    return 0;
  }

  var_03 = (var_03[0], var_03[1], 0);
  var_00.var_1C27 = var_03;
  var_04 = func_7ECA("axis");
  if(!isDefined(var_04)) {
    return 0;
  }

  var_04 = (var_04[0], var_04[1], 0);
  var_00.var_26F3 = var_04;
  var_05 = var_04 - var_03;
  var_06 = vectortoyaw(var_05);
  if(!isDefined(var_00.teamdiffyaw) || !var_00.isactive["allies"] || !var_00.isactive["axis"]) {
    var_00.teamdiffyaw = var_06;
  }

  var_07 = 80 * var_02;
  var_08 = var_06 - var_00.teamdiffyaw;
  if(var_08 > 180) {
    var_08 = var_08 - 360;
  } else if(var_08 < -180) {
    var_08 = 360 + var_08;
  }

  var_07 = clamp(var_08, var_07 * -1, var_07);
  var_00.teamdiffyaw = var_00.teamdiffyaw + var_07;
  var_09 = var_03 + var_05 * 0.5;
  if(!isDefined(var_00.midpoint) || !var_00.isactive["allies"] || !var_00.isactive["axis"]) {
    var_00.midpoint = var_09;
  }

  var_0A = var_09 - var_00.midpoint;
  var_0B = length2d(var_0A);
  var_0C = min(var_0B, 200 * var_02);
  if(var_0C > 0) {
    var_0A = var_0A * var_0C / var_0B;
    var_00.midpoint = var_00.midpoint + var_0A;
  }

  var_0D = anglesToForward((0, var_00.teamdiffyaw, 0));
  var_0E = level.spawnpoints;
  var_0E = scripts\mp\spawnscoring::checkdynamicspawns(var_0E);
  foreach(var_10 in var_0E) {
    var_11 = undefined;
    var_12 = var_00.midpoint - var_10.origin;
    var_13 = vectordot(var_12, var_0D);
    if(var_13 > 0) {
      var_11 = "allies";
      var_10.var_7450 = var_11;
      continue;
    }

    var_11 = "axis";
    var_10.var_7450 = var_11;
  }

  return 1;
}

updatefrontlinedebug() {
  var_00 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  var_01 = scripts\mp\analyticslog::analyticslogenabled();
  if(!var_00 && !var_01) {
    return;
  }

  var_02 = getglobalfrontlineinfo();
  if(!isDefined(var_02.logids) && isDefined(level.matchrecording_generateid)) {
    var_02.logids = [];
    var_02.logids["line"] = [[level.matchrecording_generateid]]();
    var_02.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    var_02.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!var_02.isactive["allies"] && !var_02.isactive["axis"]) {
    return;
  }

  var_03 = (var_02.midpoint[0], var_02.midpoint[1], level.mapcenter[2]);
  var_04 = anglestoright((0, var_02.teamdiffyaw, 0));
  var_05 = var_03 + var_04 * 5000;
  var_06 = var_03 - var_04 * 5000;
  if(isDefined(level.matchrecording_logevent)) {
    var_07 = undefined;
    if(var_02.isactive["allies"] && var_02.isactive["axis"]) {
      var_07 = "FRONT_LINE";
    } else {
      var_07 = scripts\engine\utility::ter_op(var_02.isactive["allies"], "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level.matchrecording_logevent]](var_02.logids["line"], "allies", var_07, var_05[0], var_05[1], gettime(), undefined, var_06[0], var_06[1]);
  }

  scripts\mp\analyticslog::logevent_frontlineupdate(var_05, var_06, var_02.var_1C27, var_02.var_26F3, 1);
  if(isDefined(level.matchrecording_logevent)) {
    var_08 = scripts\engine\utility::ter_op(var_02.isactive["axis"], var_02.var_26F3, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_02.logids["axisCenter"], "axis", "ANCHOR", var_08[0], var_08[1], gettime());
    var_09 = scripts\engine\utility::ter_op(var_02.isactive["allies"], var_02.var_1C27, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_02.logids["alliesCenter"], "allies", "ANCHOR", var_09[0], var_09[1], gettime());
  }
}

func_7ECA(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_03)) {
      continue;
    }

    if(var_03.team == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  if(var_01.size == 0) {
    return undefined;
  }

  var_05 = scripts\mp\utility::func_7DEA(var_01);
  return var_05;
}

runfrontlinespawntrapchecks(param_00) {
  if(!func_4BED()) {
    return;
  }

  var_01 = getglobalfrontlineinfo();
  var_01.isactive[param_00] = 1;
  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }

  var_02 = getdvarint("scr_frontline_min_spawns", 0);
  if(var_02 == 0) {
    var_02 = 4;
  }

  var_03 = scripts\mp\utility::getotherteam(param_00);
  var_04 = 0;
  var_05 = level.spawnpoints;
  var_05 = scripts\mp\spawnscoring::checkdynamicspawns(var_05);
  foreach(var_07 in var_05) {
    if(!isDefined(var_07.var_7450) || var_07.var_7450 != param_00) {
      continue;
    }

    if(!isDefined(var_07.var_74BC) || !isDefined(var_07.var_74BC[var_03]) || var_07.var_74BC[var_03] <= 0) {
      var_04++;
    }
  }

  var_09 = var_04 / var_05.size;
  if(var_04 < var_02 || var_09 < 0) {
    if(var_04 < var_02) {
      var_01.disabledreason[param_00] = 0;
    } else {
      var_01.disabledreason[param_00] = 1;
    }

    var_01.isactive[param_00] = 0;
  }
}

func_4BED() {
  if(level.gametype != "war" && level.gametype != "conf" && level.gametype != "cranked") {
    return 0;
  }

  return 1;
}

getglobalfrontlineinfo() {
  if(!isDefined(level.var_744D)) {
    level.var_744D = spawnStruct();
    level.var_744D.isactive = [];
    level.var_744D.isactive["allies"] = 0;
    level.var_744D.isactive["axis"] = 0;
    level.var_744D.var_12F92 = 0;
    level.var_744D.var_5AFE = 0;
  }

  return level.var_744D;
}

preferalliesbydistance(param_00) {
  if(param_00.totalplayers[self.team] == 0) {
    return 0;
  }

  var_01 = param_00.distsumsquared[self.team] / param_00.totalplayers[self.team];
  var_01 = min(var_01, 3240000);
  param_00.analytics.allyaveragedist = var_01;
  var_02 = 1 - var_01 / 3240000;
  return var_02 * 100;
}

preferclosetoally(param_00) {
  var_01 = min(param_00.mindistsquared[self.team], 3240000);
  var_02 = 1 - var_01 / 3240000;
  return var_02 * 100;
}

func_26B4(param_00) {
  var_01 = [];
  var_02 = [];
  if(level.teambased) {
    var_01[0] = scripts\mp\gameobjects::getenemyteam(self.team);
  } else {
    var_01[var_01.size] = "all";
  }

  foreach(var_04 in var_01) {
    if(param_00.totalplayers[var_04] == 0) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  if(var_02.size == 0) {
    return 100;
  }

  foreach(var_04 in var_02) {
    if(param_00.mindistsquared[var_04] < 250000) {
      return 0;
    }
  }

  var_08 = 0;
  var_09 = 0;
  foreach(var_04 in var_02) {
    var_08 = var_08 + param_00.distsumsquaredcapped[var_04];
    var_09 = var_09 + param_00.totalplayers[var_04];
  }

  var_0C = var_08 / var_09;
  var_0C = min(var_0C, 7290000);
  var_0D = var_0C / 7290000;
  param_00.analytics.enemyaveragedist = var_0C;
  return var_0D * 100;
}

func_26B5(param_00) {
  var_01 = undefined;
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  } else {
    var_01 = "all";
  }

  foreach(var_03 in param_00.var_5721[var_01]) {
    if(var_03 < level.var_656F) {
      return 0;
    }
  }

  return 100;
}

func_26AF(param_00) {
  var_01 = [];
  var_02 = [];
  if(level.teambased) {
    var_01[0] = scripts\mp\gameobjects::getenemyteam(self.team);
  } else {
    var_01[var_01.size] = "all";
  }

  foreach(var_04 in var_01) {
    if(param_00.totalplayers[var_04] == 0) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  if(var_02.size == 0) {
    return 100;
  }

  var_06 = 0;
  foreach(var_04 in var_02) {
    if(param_00.mindistsquared[var_04] < 250000) {
      return 0;
    }

    var_08 = min(param_00.mindistsquared[var_04], 3240000);
    var_09 = var_08 / 3240000;
    var_06 = var_06 + var_09 * 100;
  }

  return var_06 / var_02.size;
}

avoidclosestenemybydistance(param_00, param_01) {
  var_02 = param_01["closestEnemyInfluenceDistSq"];
  var_03 = "all";
  if(level.teambased) {
    var_03 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  if(param_00.mindistsquared[var_03] < 250000) {
    return 0;
  }

  var_04 = min(param_00.mindistsquared[var_03], var_02);
  var_05 = var_04 / var_02;
  return var_05 * 100;
}

scoreeventalwaysshowassplash(param_00) {
  var_01 = undefined;
  foreach(var_03 in level.domflags) {
    if(isDefined(var_03.dompointnumber) && var_03.dompointnumber == param_00) {
      var_01 = var_03;
      break;
    }
  }

  if(!isDefined(var_01)) {
    return 100;
  }

  var_05 = var_01 scripts\mp\gameobjects::func_7E29();
  if(var_05 == "none") {
    return 100;
  }

  return 50;
}

func_D82E(param_00, param_01) {
  var_02 = param_01["preferredDomPoints"];
  if(var_02[0] && param_00.dompointa) {
    return scoreeventalwaysshowassplash(0);
  }

  if(var_02[1] && param_00.dompointb) {
    return scoreeventalwaysshowassplash(1);
  }

  if(var_02[2] && param_00.dompointc) {
    return scoreeventalwaysshowassplash(2);
  }

  return 0;
}

func_D82B(param_00, param_01) {
  var_02 = param_01["closestPoints"];
  foreach(var_04 in var_02) {
    if(param_00 == var_04) {
      return 100;
    }
  }

  return 0;
}

preferbyteambase(param_00, param_01) {
  if(isDefined(param_00.teambase) && param_00.teambase == param_01) {
    return 100;
  }

  return 0;
}

func_26C2(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  var_02 = scripts\engine\utility::ter_op(isDefined(param_00.var_B4C4) && isDefined(param_00.var_B4C4[var_01]), 1 - param_00.var_B4C4[var_01], 0);
  param_00.analytics.maxenemysightfraction = var_02;
  return 1 - var_02 * 0 + var_02 * 100;
}

func_26C3(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  var_02 = scripts\engine\utility::ter_op(isDefined(param_00.var_B4A6) && isDefined(param_00.var_B4A6[var_01]), 1 - param_00.var_B4A6[var_01], 0);
  param_00.analytics.maxjumpingenemysightfraction = var_02;
  return 1 - var_02 * 0 + var_02 * 100;
}

func_26C5(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = scripts\mp\gameobjects::getenemyteam(self.team);
  }

  var_02 = scripts\engine\utility::ter_op(isDefined(param_00.var_B4A6) && isDefined(param_00.var_B4A6[var_01]), 1 - param_00.var_B4A6[var_01], 0);
  var_03 = var_02 * scripts\mp\spawnlogic::getmaxdistancetolos();
  if(var_03 < 300) {
    return 0;
  }

  return 100;
}

randomspawnscore(param_00) {
  param_00.analytics.randomscore = randomintrange(0, 99);
  return param_00.analytics.randomscore;
}

maxplayerspawninfluencedistsquared(param_00) {
  return 3240000;
}

func_D837(param_00, param_01) {
  var_02 = param_01["activeKOTHZoneNumber"];
  var_03 = param_00.distsqtokothzones[var_02];
  var_04 = param_01["maxSquaredDistToObjective"];
  var_05 = 1 - var_03 / var_04;
  return 100 * var_05 + 0;
}

func_26B2(param_00, param_01) {
  var_02 = param_01["activeKOTHZoneNumber"];
  var_03 = param_00.distsqtokothzones[var_02];
  var_04 = param_01["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var_03 < var_04, 0, 100);
}

func_D82C(param_00, param_01) {
  var_02 = param_01["homeBaseTeam"];
  var_03 = param_00.disttohomebase[var_02];
  var_04 = param_01["maxDistToHomeBase"];
  var_05 = var_03 * var_03;
  var_06 = var_04 * var_04;
  var_07 = 1 - var_05 / var_06;
  return 100 * var_07 + 0;
}

func_26B0(param_00, param_01) {
  var_02 = undefined;
  var_03 = param_01["activeCarrierPosition"];
  var_04 = param_01["ballPosition"];
  var_05 = param_01["avoidBallDeadZoneDistSq"];
  if(isDefined(var_03)) {
    var_02 = var_03;
  } else if(isDefined(var_04)) {
    var_02 = var_04;
  }

  if(isDefined(var_02)) {
    var_06 = distancesquared(var_02, param_00.origin);
    return scripts\engine\utility::ter_op(var_06 < var_05, 0, 100);
  }

  return 100;
}

func_26B1(param_00, param_01) {
  var_02 = param_00.distsqtoballstart;
  var_03 = param_01["avoidBallDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(var_02 < var_03, 0, 100);
}

prefernearlastteamspawn(param_00) {
  var_01 = level.spawnglobals.lastteamspawnpoints[self.team];
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = distancesquared(var_01.origin, param_00.origin);
  var_02 = int(min(var_02, 9000000));
  var_03 = 1 - var_02 / 9000000;
  return 100 * var_03 + 0;
}