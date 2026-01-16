/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2797.gsc
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

func_DEF0(var_0, var_1, var_2) {
  if(!isDefined(level.spawnglobals.factors)) {
    level.spawnglobals.factors = [];
  }

  var_3 = spawnStruct();
  level.spawnglobals.factors[var_0] = var_3;
  var_3.var_74D6 = var_1;
  var_3.var_C8EF = var_2;
}

isfactorregistered(var_0) {
  return isDefined(level.spawnglobals.factors[var_0]);
}

func_7EAF(var_0) {
  return level.spawnglobals.factors[var_0].var_74D6;
}

func_7EB1(var_0) {
  return level.spawnglobals.factors[var_0].var_C8EF;
}

calculatefactorscore(var_0, var_1, var_2, var_3) {
  var_4 = func_7EAF(var_1);
  var_5 = func_7EB1(var_1);

  if(isDefined(var_5)) {
    if(!isDefined(var_3)) {}

    var_13 = [[var_4]](var_0, var_3);
  } else {
    var_13 = [[var_4]](var_0);
  }

  var_13 = clamp(var_13, 0, 100);
  var_13 = var_13 * var_2;
  var_0.var_11A3A = var_0.var_11A3A + 100 * var_2;
  var_0.var_A9E9[self.team] = var_0.var_A9E9[self.team] + var_13;
  var_0.totalscore = var_0.totalscore + var_13;
  return var_13;
}

critical_factor(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

avoidcarepackages(var_0) {
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

func_26B8(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isDefined(var_2) || !var_2 isexplosivedangeroustoplayer(self) || scripts\mp\utility\game::istrue(var_2.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

func_26BC(var_0) {
  var_1 = scripts\engine\utility::array_combine(level.mines, level.placedims);

  if(isDefined(level.var_126BC) && level.var_126BC.size > 0) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.var_126BC);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 isexplosivedangeroustoplayer(self) || scripts\mp\utility\game::istrue(var_3.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team)) {
    return 1;
  } else {
    var_1 = undefined;

    if(isDefined(self.owner)) {
      if(var_0 == self.owner) {
        return 1;
      }

      var_1 = self.owner.team;
    }

    if(isDefined(var_1)) {
      return var_1 != var_0.team;
    } else {
      return 1;
    }
  }
}

func_26AB(var_0) {
  if(!isDefined(level.artillerydangercenters)) {
    return 100;
  }

  if(!var_0.var_C7DA) {
    return 100;
  }

  var_1 = scripts\mp\killstreaks\airstrike::getairstrikedanger(var_0.origin);

  if(var_1 > 0) {
    return 0;
  }

  return 100;
}

func_26B3(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  if(var_0.var_466B[var_1] > 0) {
    return 0;
  }

  return 100;
}

func_26B7(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  if(var_0.var_74BC[var_1] > 0) {
    return 0;
  }

  return 100;
}

func_26AE(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0) {
    return 100;
  }

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < level.var_10680) {
      return 0;
    }
  }

  return 100;
}

func_26C4(var_0) {
  if(isDefined(self.var_1CAE)) {
    return 100;
  }

  if(positionwouldtelefrag(var_0.origin)) {
    foreach(var_2 in var_0.alternates) {
      if(!positionwouldtelefrag(var_2)) {
        return 100;
      }
    }

    return 0;
  }

  return 100;
}

avoidsamespawn(var_0) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var_0) {
    return 0;
  }

  return 100;
}

func_26B6(var_0) {
  if(isDefined(var_0.lastspawnteam) && (!level.teambased || var_0.lastspawnteam != self.team)) {
    var_1 = var_0.lastspawntime + 500;

    if(gettime() < var_1) {
      return 0;
    }
  }

  return 100;
}

avoidrecentlyusedbyenemies(var_0) {
  var_1 = !level.teambased || isDefined(var_0.lastspawnteam) && self.team != var_0.lastspawnteam;

  if(var_1 && isDefined(var_0.lastspawntime)) {
    var_2 = gettime() - var_0.lastspawntime;
    var_0.analytics.spawnusedbyenemies = var_2 / 1000;

    if(var_2 > 4000) {
      return 100;
    }

    return var_2 / 4000 * 100;
  }

  return 100;
}

avoidrecentlyusedbyanyone(var_0) {
  if(isDefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;
    var_0.analytics.timesincelastspawn = var_1 / 1000;

    if(var_1 > 4000) {
      return 100;
    }

    return var_1 / 4000 * 100;
  }

  return 100;
}

avoidlastdeathlocation(var_0) {
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

avoidlastattackerlocation(var_0) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin)) {
    return 100;
  }

  if(!scripts\mp\utility\game::isreallyalive(self.lastattacker)) {
    return 100;
  }

  var_1 = distancesquared(var_0.origin, self.lastattacker.origin);

  if(var_1 > 810000) {
    return 100;
  }

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

updatefrontline(var_0) {
  if(!updatefrontlineposition()) {
    return;
  }
  runfrontlinespawntrapchecks(var_0);
  updatefrontlinedebug();
}

updatefrontlineposition() {
  if(!func_4BED()) {
    return 0;
  }

  var_0 = getglobalfrontlineinfo();
  var_1 = gettime();

  if(!isDefined(var_0.lastupdatetime)) {
    var_0.lastupdatetime = var_1;
  } else if(var_0.isactive["allies"] && var_0.isactive["axis"]) {
    var_0.var_12F92 = var_0.var_12F92 + var_0.var_AA37;
  } else {
    var_0.var_5AFE = var_0.var_5AFE + var_0.var_AA37;
  }

  var_2 = (var_1 - var_0.lastupdatetime) / 1000.0;
  var_0.lastupdatetime = var_1;
  var_0.var_AA37 = var_2;
  var_3 = func_7ECA("allies");

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3 = (var_3[0], var_3[1], 0);
  var_0.var_1C27 = var_3;
  var_4 = func_7ECA("axis");

  if(!isDefined(var_4)) {
    return 0;
  }

  var_4 = (var_4[0], var_4[1], 0);
  var_0.var_26F3 = var_4;
  var_5 = var_4 - var_3;
  var_6 = vectortoyaw(var_5);

  if(!isDefined(var_0.teamdiffyaw) || !var_0.isactive["allies"] || !var_0.isactive["axis"]) {
    var_0.teamdiffyaw = var_6;
  }

  var_7 = 80.0 * var_2;
  var_8 = var_6 - var_0.teamdiffyaw;

  if(var_8 > 180) {
    var_8 = var_8 - 360;
  } else if(var_8 < -180) {
    var_8 = 360 + var_8;
  }

  var_7 = clamp(var_8, var_7 * -1, var_7);
  var_0.teamdiffyaw = var_0.teamdiffyaw + var_7;
  var_9 = var_3 + var_5 * 0.5;

  if(!isDefined(var_0.midpoint) || !var_0.isactive["allies"] || !var_0.isactive["axis"]) {
    var_0.midpoint = var_9;
  }

  var_10 = var_9 - var_0.midpoint;
  var_11 = length2d(var_10);
  var_12 = min(var_11, 200.0 * var_2);

  if(var_12 > 0) {
    var_10 = var_10 * (var_12 / var_11);
    var_0.midpoint = var_0.midpoint + var_10;
  }

  var_13 = anglesToForward((0, var_0.teamdiffyaw, 0));
  var_14 = level.spawnpoints;
  var_14 = scripts\mp\spawnscoring::checkdynamicspawns(var_14);

  foreach(var_16 in var_14) {
    var_17 = undefined;
    var_18 = var_0.midpoint - var_16.origin;
    var_19 = vectordot(var_18, var_13);

    if(var_19 > 0) {
      var_17 = "allies";
      var_16.var_7450 = var_17;
      continue;
    }

    var_17 = "axis";
    var_16.var_7450 = var_17;
  }

  return 1;
}

updatefrontlinedebug() {
  var_0 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  var_1 = scripts\mp\analyticslog::analyticslogenabled();

  if(!var_0 && !var_1) {
    return;
  }
  var_2 = getglobalfrontlineinfo();

  if(!isDefined(var_2.logids) && isDefined(level.matchrecording_generateid)) {
    var_2.logids = [];
    var_2.logids["line"] = [[level.matchrecording_generateid]]();
    var_2.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    var_2.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!var_2.isactive["allies"] && !var_2.isactive["axis"]) {
    return;
  }
  var_3 = (var_2.midpoint[0], var_2.midpoint[1], level.mapcenter[2]);
  var_4 = anglestoright((0, var_2.teamdiffyaw, 0));
  var_5 = var_3 + var_4 * 5000;
  var_6 = var_3 - var_4 * 5000;

  if(isDefined(level.matchrecording_logevent)) {
    var_7 = undefined;

    if(var_2.isactive["allies"] && var_2.isactive["axis"]) {
      var_7 = "FRONT_LINE";
    } else {
      var_7 = scripts\engine\utility::ter_op(var_2.isactive["allies"], "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");
    }

    [[level.matchrecording_logevent]](var_2.logids["line"], "allies", var_7, var_5[0], var_5[1], gettime(), undefined, var_6[0], var_6[1]);
  }

  scripts\mp\analyticslog::logevent_frontlineupdate(var_5, var_6, var_2.var_1C27, var_2.var_26F3, 1);

  if(isDefined(level.matchrecording_logevent)) {
    var_8 = scripts\engine\utility::ter_op(var_2.isactive["axis"], var_2.var_26F3, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["axisCenter"], "axis", "ANCHOR", var_8[0], var_8[1], gettime());
    var_9 = scripts\engine\utility::ter_op(var_2.isactive["allies"], var_2.var_1C27, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["alliesCenter"], "allies", "ANCHOR", var_9[0], var_9[1], gettime());
  }
}

func_7ECA(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_3)) {
      continue;
    }
    if(var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = scripts\mp\utility\game::func_7DEA(var_1);
  return var_5;
}

runfrontlinespawntrapchecks(var_0) {
  if(!func_4BED()) {
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

  var_3 = scripts\mp\utility\game::getotherteam(var_0);
  var_4 = 0;
  var_5 = level.spawnpoints;
  var_5 = scripts\mp\spawnscoring::checkdynamicspawns(var_5);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.var_7450) || var_7.var_7450 != var_0) {
      continue;
    }
    if(!isDefined(var_7.var_74BC) || !isDefined(var_7.var_74BC[var_3]) || var_7.var_74BC[var_3] <= 0) {
      var_4++;
    }
  }

  var_9 = var_4 / var_5.size;

  if(var_4 < var_2 || var_9 < 0.0) {
    if(var_4 < var_2) {
      var_1.disabledreason[var_0] = 0;
    } else {
      var_1.disabledreason[var_0] = 1;
    }

    var_1.isactive[var_0] = 0;
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
    level.var_744D.var_12F92 = 0.0;
    level.var_744D.var_5AFE = 0.0;
  }

  return level.var_744D;
}

preferalliesbydistance(var_0) {
  if(var_0.totalplayers[self.team] == 0) {
    return 0;
  }

  var_1 = var_0.distsumsquared[self.team] / var_0.totalplayers[self.team];
  var_1 = min(var_1, 3240000);
  var_0.analytics.allyaveragedist = var_1;
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

preferclosetoally(var_0) {
  var_1 = min(var_0.mindistsquared[self.team], 3240000);
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

func_26B4(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
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
    var_8 = var_8 + var_0.distsumsquaredcapped[var_4];
    var_9 = var_9 + var_0.totalplayers[var_4];
  }

  var_12 = var_8 / var_9;
  var_12 = min(var_12, 7290000);
  var_13 = var_12 / 7290000;
  var_0.analytics.enemyaveragedist = var_12;
  return var_13 * 100;
}

func_26B5(var_0) {
  var_1 = undefined;

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  } else {
    var_1 = "all";
  }

  foreach(var_3 in var_0.var_5721[var_1]) {
    if(var_3 < level.var_656F) {
      return 0;
    }
  }

  return 100;
}

func_26AF(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased) {
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  } else {
    var_1[var_1.size] = "all";
  }

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
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
    var_6 = var_6 + var_9 * 100;
  }

  return var_6 / var_2.size;
}

avoidclosestenemybydistance(var_0, var_1) {
  var_2 = var_1["closestEnemyInfluenceDistSq"];
  var_3 = "all";

  if(level.teambased) {
    var_3 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  if(var_0.mindistsquared[var_3] < 250000) {
    return 0;
  }

  var_4 = min(var_0.mindistsquared[var_3], var_2);
  var_5 = var_4 / var_2;
  return var_5 * 100;
}

scoreeventalwaysshowassplash(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.domflags) {
    if(isDefined(var_3.dompointnumber) && var_3.dompointnumber == var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return 100;
  }

  var_5 = var_1 scripts\mp\gameobjects::func_7E29();

  if(var_5 == "none") {
    return 100;
  } else {
    return 50.0;
  }
}

func_D82E(var_0, var_1) {
  var_2 = var_1["preferredDomPoints"];

  if(var_2[0] && var_0.dompointa) {
    return scoreeventalwaysshowassplash(0);
  }

  if(var_2[1] && var_0.dompointb) {
    return scoreeventalwaysshowassplash(1);
  }

  if(var_2[2] && var_0.dompointc) {
    return scoreeventalwaysshowassplash(2);
  }

  return 0;
}

func_D82B(var_0, var_1) {
  var_2 = var_1["closestPoints"];

  foreach(var_4 in var_2) {
    if(var_0 == var_4) {
      return 100;
    }
  }

  return 0;
}

preferbyteambase(var_0, var_1) {
  if(isDefined(var_0.teambase) && var_0.teambase == var_1) {
    return 100;
  }

  return 0;
}

func_26C2(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.var_B4C4) && isDefined(var_0.var_B4C4[var_1]), 1.0 - var_0.var_B4C4[var_1], 0.0);
  var_0.analytics.maxenemysightfraction = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

func_26C3(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.var_B4A6) && isDefined(var_0.var_B4A6[var_1]), 1.0 - var_0.var_B4A6[var_1], 0.0);
  var_0.analytics.maxjumpingenemysightfraction = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

func_26C5(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = scripts\mp\gameobjects::func_7E93(self.team);
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.var_B4A6) && isDefined(var_0.var_B4A6[var_1]), 1.0 - var_0.var_B4A6[var_1], 0.0);
  var_3 = var_2 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(var_3 < 300) {
    return 0;
  } else {
    return 100;
  }
}

randomspawnscore(var_0) {
  var_0.analytics.randomscore = randomintrange(0, 99);
  return var_0.analytics.randomscore;
}

maxplayerspawninfluencedistsquared(var_0) {
  return 3240000;
}

func_D837(var_0, var_1) {
  var_2 = var_1["activeKOTHZoneNumber"];
  var_3 = var_0.distsqtokothzones[var_2];
  var_4 = var_1["maxSquaredDistToObjective"];
  var_5 = 1.0 - var_3 / var_4;
  return 100 * var_5 + 0;
}

func_26B2(var_0, var_1) {
  var_2 = var_1["activeKOTHZoneNumber"];
  var_3 = var_0.distsqtokothzones[var_2];
  var_4 = var_1["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var_3 < var_4, 0, 100);
}

func_D82C(var_0, var_1) {
  var_2 = var_1["homeBaseTeam"];
  var_3 = var_0.disttohomebase[var_2];
  var_4 = var_1["maxDistToHomeBase"];
  var_5 = var_3 * var_3;
  var_6 = var_4 * var_4;
  var_7 = 1.0 - var_5 / var_6;
  return 100 * var_7 + 0;
}

func_26B0(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_1["activeCarrierPosition"];
  var_4 = var_1["ballPosition"];
  var_5 = var_1["avoidBallDeadZoneDistSq"];

  if(isDefined(var_3)) {
    var_2 = var_3;
  } else if(isDefined(var_4)) {
    var_2 = var_4;
  }

  if(isDefined(var_2)) {
    var_6 = distancesquared(var_2, var_0.origin);
    return scripts\engine\utility::ter_op(var_6 < var_5, 0, 100);
  } else {
    return 100;
  }
}

func_26B1(var_0, var_1) {
  var_2 = var_0.distsqtoballstart;
  var_3 = var_1["avoidBallDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(var_2 < var_3, 0, 100);
}

prefernearlastteamspawn(var_0) {
  var_1 = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_2 = int(min(var_2, 9000000));
  var_3 = 1.0 - var_2 / 9000000;
  return 100 * var_3 + 0;
}