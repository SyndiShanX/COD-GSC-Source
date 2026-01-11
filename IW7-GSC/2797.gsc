/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2797.gsc
***************************************/

func_9758() {
  if(!isDefined(level.func_10680))
    level.func_10680 = 250000;

  if(!isDefined(level.func_656F))
    level.func_656F = 810000;

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

func_DEF0(var_00, var_01, var_02) {
  if(!isDefined(level.spawnglobals.factors))
    level.spawnglobals.factors = [];

  var_03 = spawnStruct();
  level.spawnglobals.factors[var_00] = var_03;
  var_3.func_74D6 = var_01;
  var_3.func_C8EF = var_02;
}

isfactorregistered(var_00) {
  return isDefined(level.spawnglobals.factors[var_00]);
}

func_7EAF(var_00) {
  return level.spawnglobals.factors[var_00].func_74D6;
}

func_7EB1(var_00) {
  return level.spawnglobals.factors[var_00].func_C8EF;
}

calculatefactorscore(var_00, var_01, var_02, var_03) {
  var_04 = func_7EAF(var_01);
  var_05 = func_7EB1(var_01);

  if(isDefined(var_05)) {
    if(!isDefined(var_03)) {}

    var_13 = [[var_04]](var_00, var_03);
  } else
    var_13 = [[var_04]](var_00);

  var_13 = clamp(var_13, 0, 100);
  var_13 = var_13 * var_02;
  var_0.func_11A3A = var_0.func_11A3A + 100 * var_02;
  var_0.func_A9E9[self.team] = var_0.func_A9E9[self.team] + var_13;
  var_0.totalscore = var_0.totalscore + var_13;
  return var_13;
}

critical_factor(var_00, var_01) {
  var_02 = [
    [var_00]
  ](var_01);
  var_02 = clamp(var_02, 0, 100);
  return var_02;
}

avoidcarepackages(var_00) {
  foreach(var_02 in level.carepackages) {
    if(!isDefined(var_02)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 22500)
      return 0;
  }

  return 100;
}

func_26B8(var_00) {
  foreach(var_02 in level.grenades) {
    if(!isDefined(var_02) || !var_02 isexplosivedangeroustoplayer(self) || scripts\mp\utility\game::istrue(var_2.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500)
      return 0;
  }

  return 100;
}

func_26BC(var_00) {
  var_01 = scripts\engine\utility::array_combine(level.mines, level.placedims);

  if(isDefined(level.func_126BC) && level.func_126BC.size > 0)
    var_01 = scripts\engine\utility::array_combine(var_01, level.func_126BC);

  foreach(var_03 in var_01) {
    if(!isDefined(var_03) || !var_03 isexplosivedangeroustoplayer(self) || scripts\mp\utility\game::istrue(var_3.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500)
      return 0;
  }

  return 100;
}

isexplosivedangeroustoplayer(var_00) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team))
    return 1;
  else {
    var_01 = undefined;

    if(isDefined(self.owner)) {
      if(var_00 == self.owner)
        return 1;

      var_01 = self.owner.team;
    }

    if(isDefined(var_01))
      return var_01 != var_0.team;
    else
      return 1;
  }
}

func_26AB(var_00) {
  if(!isDefined(level.artillerydangercenters))
    return 100;

  if(!var_0.func_C7DA)
    return 100;

  var_01 = scripts\mp\killstreaks\airstrike::getairstrikedanger(var_0.origin);

  if(var_01 > 0)
    return 0;

  return 100;
}

func_26B3(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);

  if(var_0.func_466B[var_01] > 0)
    return 0;

  return 100;
}

func_26B7(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);

  if(var_0.func_74BC[var_01] > 0)
    return 0;

  return 100;
}

func_26AE(var_00) {
  var_01 = [];
  var_02 = [];

  if(level.teambased)
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  else
    var_1[var_1.size] = "all";

  foreach(var_04 in var_01) {
    if(var_0.totalplayers[var_04] == 0) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  if(var_2.size == 0)
    return 100;

  foreach(var_04 in var_02) {
    if(var_0.mindistsquared[var_04] < level.func_10680)
      return 0;
  }

  return 100;
}

func_26C4(var_00) {
  if(isDefined(self.func_1CAE))
    return 100;

  if(positionwouldtelefrag(var_0.origin)) {
    foreach(var_02 in var_0.alternates) {
      if(!positionwouldtelefrag(var_02))
        return 100;
    }

    return 0;
  }

  return 100;
}

avoidsamespawn(var_00) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var_00)
    return 0;

  return 100;
}

func_26B6(var_00) {
  if(isDefined(var_0.lastspawnteam) && (!level.teambased || var_0.lastspawnteam != self.team)) {
    var_01 = var_0.lastspawntime + 500;

    if(gettime() < var_01)
      return 0;
  }

  return 100;
}

avoidrecentlyusedbyenemies(var_00) {
  var_01 = !level.teambased || isDefined(var_0.lastspawnteam) && self.team != var_0.lastspawnteam;

  if(var_01 && isDefined(var_0.lastspawntime)) {
    var_02 = gettime() - var_0.lastspawntime;
    var_0.analytics.spawnusedbyenemies = var_02 / 1000;

    if(var_02 > 4000)
      return 100;

    return var_02 / 4000 * 100;
  }

  return 100;
}

avoidrecentlyusedbyanyone(var_00) {
  if(isDefined(var_0.lastspawntime)) {
    var_01 = gettime() - var_0.lastspawntime;
    var_0.analytics.timesincelastspawn = var_01 / 1000;

    if(var_01 > 4000)
      return 100;

    return var_01 / 4000 * 100;
  }

  return 100;
}

avoidlastdeathlocation(var_00) {
  if(!isDefined(self.lastdeathpos))
    return 100;

  var_01 = distancesquared(var_0.origin, self.lastdeathpos);

  if(var_01 > 810000)
    return 100;

  var_02 = var_01 / 810000;
  return var_02 * 100;
}

avoidlastattackerlocation(var_00) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin))
    return 100;

  if(!scripts\mp\utility\game::isreallyalive(self.lastattacker))
    return 100;

  var_01 = distancesquared(var_0.origin, self.lastattacker.origin);

  if(var_01 > 810000)
    return 100;

  var_02 = var_01 / 810000;
  return var_02 * 100;
}

updatefrontline(var_00) {
  if(!updatefrontlineposition()) {
    return;
  }
  runfrontlinespawntrapchecks(var_00);
  updatefrontlinedebug();
}

updatefrontlineposition() {
  if(!func_4BED())
    return 0;

  var_00 = getglobalfrontlineinfo();
  var_01 = gettime();

  if(!isDefined(var_0.lastupdatetime))
    var_0.lastupdatetime = var_01;
  else if(var_0.isactive["allies"] && var_0.isactive["axis"])
    var_0.func_12F92 = var_0.func_12F92 + var_0.func_AA37;
  else
    var_0.func_5AFE = var_0.func_5AFE + var_0.func_AA37;

  var_02 = (var_01 - var_0.lastupdatetime) / 1000.0;
  var_0.lastupdatetime = var_01;
  var_0.func_AA37 = var_02;
  var_03 = func_7ECA("allies");

  if(!isDefined(var_03))
    return 0;

  var_03 = (var_3[0], var_3[1], 0);
  var_0.func_1C27 = var_03;
  var_04 = func_7ECA("axis");

  if(!isDefined(var_04))
    return 0;

  var_04 = (var_4[0], var_4[1], 0);
  var_0.func_26F3 = var_04;
  var_05 = var_04 - var_03;
  var_06 = vectortoyaw(var_05);

  if(!isDefined(var_0.teamdiffyaw) || !var_0.isactive["allies"] || !var_0.isactive["axis"])
    var_0.teamdiffyaw = var_06;

  var_07 = 80.0 * var_02;
  var_08 = var_06 - var_0.teamdiffyaw;

  if(var_08 > 180)
    var_08 = var_08 - 360;
  else if(var_08 < -180)
    var_08 = 360 + var_08;

  var_07 = clamp(var_08, var_07 * -1, var_07);
  var_0.teamdiffyaw = var_0.teamdiffyaw + var_07;
  var_09 = var_03 + var_05 * 0.5;

  if(!isDefined(var_0.midpoint) || !var_0.isactive["allies"] || !var_0.isactive["axis"])
    var_0.midpoint = var_09;

  var_10 = var_09 - var_0.midpoint;
  var_11 = length2d(var_10);
  var_12 = min(var_11, 200.0 * var_02);

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
      var_16.func_7450 = var_17;
      continue;
    }

    var_17 = "axis";
    var_16.func_7450 = var_17;
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

  if(!isDefined(var_2.logids) && isDefined(level.matchrecording_generateid)) {
    var_2.logids = [];
    var_2.logids["line"] = [[level.matchrecording_generateid]]();
    var_2.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    var_2.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!var_2.isactive["allies"] && !var_2.isactive["axis"]) {
    return;
  }
  var_03 = (var_2.midpoint[0], var_2.midpoint[1], level.mapcenter[2]);
  var_04 = anglestoright((0, var_2.teamdiffyaw, 0));
  var_05 = var_03 + var_04 * 5000;
  var_06 = var_03 - var_04 * 5000;

  if(isDefined(level.matchrecording_logevent)) {
    var_07 = undefined;

    if(var_2.isactive["allies"] && var_2.isactive["axis"])
      var_07 = "FRONT_LINE";
    else
      var_07 = scripts\engine\utility::ter_op(var_2.isactive["allies"], "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");

    [[level.matchrecording_logevent]](var_2.logids["line"], "allies", var_07, var_5[0], var_5[1], gettime(), undefined, var_6[0], var_6[1]);
  }

  scripts\mp\analyticslog::logevent_frontlineupdate(var_05, var_06, var_2.func_1C27, var_2.func_26F3, 1);

  if(isDefined(level.matchrecording_logevent)) {
    var_08 = scripts\engine\utility::ter_op(var_2.isactive["axis"], var_2.func_26F3, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["axisCenter"], "axis", "ANCHOR", var_8[0], var_8[1], gettime());
    var_09 = scripts\engine\utility::ter_op(var_2.isactive["allies"], var_2.func_1C27, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["alliesCenter"], "allies", "ANCHOR", var_9[0], var_9[1], gettime());
  }
}

func_7ECA(var_00) {
  var_01 = [];

  foreach(var_03 in level.players) {
    if(!isDefined(var_03)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_03)) {
      continue;
    }
    if(var_3.team == var_00)
      var_1[var_1.size] = var_03;
  }

  if(var_1.size == 0)
    return undefined;

  var_05 = scripts\mp\utility\game::func_7DEA(var_01);
  return var_05;
}

runfrontlinespawntrapchecks(var_00) {
  if(!func_4BED()) {
    return;
  }
  var_01 = getglobalfrontlineinfo();
  var_1.isactive[var_00] = 1;

  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }
  var_02 = getdvarint("scr_frontline_min_spawns", 0);

  if(var_02 == 0)
    var_02 = 4;

  var_03 = scripts\mp\utility\game::getotherteam(var_00);
  var_04 = 0;
  var_05 = level.spawnpoints;
  var_05 = scripts\mp\spawnscoring::checkdynamicspawns(var_05);

  foreach(var_07 in var_05) {
    if(!isDefined(var_7.func_7450) || var_7.func_7450 != var_00) {
      continue;
    }
    if(!isDefined(var_7.func_74BC) || !isDefined(var_7.func_74BC[var_03]) || var_7.func_74BC[var_03] <= 0)
      var_4++;
  }

  var_09 = var_04 / var_5.size;

  if(var_04 < var_02 || var_09 < 0.0) {
    if(var_04 < var_02)
      var_1.disabledreason[var_00] = 0;
    else
      var_1.disabledreason[var_00] = 1;

    var_1.isactive[var_00] = 0;
  }
}

func_4BED() {
  if(level.gametype != "war" && level.gametype != "conf" && level.gametype != "cranked")
    return 0;

  return 1;
}

getglobalfrontlineinfo() {
  if(!isDefined(level.func_744D)) {
    level.func_744D = spawnStruct();
    level.func_744D.isactive = [];
    level.func_744D.isactive["allies"] = 0;
    level.func_744D.isactive["axis"] = 0;
    level.func_744D.func_12F92 = 0.0;
    level.func_744D.func_5AFE = 0.0;
  }

  return level.func_744D;
}

preferalliesbydistance(var_00) {
  if(var_0.totalplayers[self.team] == 0)
    return 0;

  var_01 = var_0.distsumsquared[self.team] / var_0.totalplayers[self.team];
  var_01 = min(var_01, 3240000);
  var_0.analytics.allyaveragedist = var_01;
  var_02 = 1 - var_01 / 3240000;
  return var_02 * 100;
}

preferclosetoally(var_00) {
  var_01 = min(var_0.mindistsquared[self.team], 3240000);
  var_02 = 1 - var_01 / 3240000;
  return var_02 * 100;
}

func_26B4(var_00) {
  var_01 = [];
  var_02 = [];

  if(level.teambased)
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  else
    var_1[var_1.size] = "all";

  foreach(var_04 in var_01) {
    if(var_0.totalplayers[var_04] == 0) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  if(var_2.size == 0)
    return 100;

  foreach(var_04 in var_02) {
    if(var_0.mindistsquared[var_04] < 250000)
      return 0;
  }

  var_08 = 0;
  var_09 = 0;

  foreach(var_04 in var_02) {
    var_08 = var_08 + var_0.distsumsquaredcapped[var_04];
    var_09 = var_09 + var_0.totalplayers[var_04];
  }

  var_12 = var_08 / var_09;
  var_12 = min(var_12, 7290000);
  var_13 = var_12 / 7290000;
  var_0.analytics.enemyaveragedist = var_12;
  return var_13 * 100;
}

func_26B5(var_00) {
  var_01 = undefined;

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);
  else
    var_01 = "all";

  foreach(var_03 in var_0.func_5721[var_01]) {
    if(var_03 < level.func_656F)
      return 0;
  }

  return 100;
}

func_26AF(var_00) {
  var_01 = [];
  var_02 = [];

  if(level.teambased)
    var_1[0] = ::scripts\mp\gameobjects::func_7E93(self.team);
  else
    var_1[var_1.size] = "all";

  foreach(var_04 in var_01) {
    if(var_0.totalplayers[var_04] == 0) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  if(var_2.size == 0)
    return 100;

  var_06 = 0;

  foreach(var_04 in var_02) {
    if(var_0.mindistsquared[var_04] < 250000)
      return 0;

    var_08 = min(var_0.mindistsquared[var_04], 3240000);
    var_09 = var_08 / 3240000;
    var_06 = var_06 + var_09 * 100;
  }

  return var_06 / var_2.size;
}

avoidclosestenemybydistance(var_00, var_01) {
  var_02 = var_1["closestEnemyInfluenceDistSq"];
  var_03 = "all";

  if(level.teambased)
    var_03 = scripts\mp\gameobjects::func_7E93(self.team);

  if(var_0.mindistsquared[var_03] < 250000)
    return 0;

  var_04 = min(var_0.mindistsquared[var_03], var_02);
  var_05 = var_04 / var_02;
  return var_05 * 100;
}

scoreeventalwaysshowassplash(var_00) {
  var_01 = undefined;

  foreach(var_03 in level.domflags) {
    if(isDefined(var_3.dompointnumber) && var_3.dompointnumber == var_00) {
      var_01 = var_03;
      break;
    }
  }

  if(!isDefined(var_01))
    return 100;

  var_05 = var_01 scripts\mp\gameobjects::func_7E29();

  if(var_05 == "none")
    return 100;
  else
    return 50.0;
}

func_D82E(var_00, var_01) {
  var_02 = var_1["preferredDomPoints"];

  if(var_2[0] && var_0.dompointa)
    return scoreeventalwaysshowassplash(0);

  if(var_2[1] && var_0.dompointb)
    return scoreeventalwaysshowassplash(1);

  if(var_2[2] && var_0.dompointc)
    return scoreeventalwaysshowassplash(2);

  return 0;
}

func_D82B(var_00, var_01) {
  var_02 = var_1["closestPoints"];

  foreach(var_04 in var_02) {
    if(var_00 == var_04)
      return 100;
  }

  return 0;
}

preferbyteambase(var_00, var_01) {
  if(isDefined(var_0.teambase) && var_0.teambase == var_01)
    return 100;

  return 0;
}

func_26C2(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);

  var_02 = scripts\engine\utility::ter_op(isDefined(var_0.func_B4C4) && isDefined(var_0.func_B4C4[var_01]), 1.0 - var_0.func_B4C4[var_01], 0.0);
  var_0.analytics.maxenemysightfraction = var_02;
  return (1.0 - var_02) * 0 + var_02 * 100;
}

func_26C3(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);

  var_02 = scripts\engine\utility::ter_op(isDefined(var_0.func_B4A6) && isDefined(var_0.func_B4A6[var_01]), 1.0 - var_0.func_B4A6[var_01], 0.0);
  var_0.analytics.maxjumpingenemysightfraction = var_02;
  return (1.0 - var_02) * 0 + var_02 * 100;
}

func_26C5(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = scripts\mp\gameobjects::func_7E93(self.team);

  var_02 = scripts\engine\utility::ter_op(isDefined(var_0.func_B4A6) && isDefined(var_0.func_B4A6[var_01]), 1.0 - var_0.func_B4A6[var_01], 0.0);
  var_03 = var_02 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(var_03 < 300)
    return 0;
  else
    return 100;
}

randomspawnscore(var_00) {
  var_0.analytics.randomscore = randomintrange(0, 99);
  return var_0.analytics.randomscore;
}

maxplayerspawninfluencedistsquared(var_00) {
  return 3240000;
}

func_D837(var_00, var_01) {
  var_02 = var_1["activeKOTHZoneNumber"];
  var_03 = var_0.distsqtokothzones[var_02];
  var_04 = var_1["maxSquaredDistToObjective"];
  var_05 = 1.0 - var_03 / var_04;
  return 100 * var_05 + 0;
}

func_26B2(var_00, var_01) {
  var_02 = var_1["activeKOTHZoneNumber"];
  var_03 = var_0.distsqtokothzones[var_02];
  var_04 = var_1["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(var_03 < var_04, 0, 100);
}

func_D82C(var_00, var_01) {
  var_02 = var_1["homeBaseTeam"];
  var_03 = var_0.disttohomebase[var_02];
  var_04 = var_1["maxDistToHomeBase"];
  var_05 = var_03 * var_03;
  var_06 = var_04 * var_04;
  var_07 = 1.0 - var_05 / var_06;
  return 100 * var_07 + 0;
}

func_26B0(var_00, var_01) {
  var_02 = undefined;
  var_03 = var_1["activeCarrierPosition"];
  var_04 = var_1["ballPosition"];
  var_05 = var_1["avoidBallDeadZoneDistSq"];

  if(isDefined(var_03))
    var_02 = var_03;
  else if(isDefined(var_04))
    var_02 = var_04;

  if(isDefined(var_02)) {
    var_06 = distancesquared(var_02, var_0.origin);
    return scripts\engine\utility::ter_op(var_06 < var_05, 0, 100);
  } else
    return 100;
}

func_26B1(var_00, var_01) {
  var_02 = var_0.distsqtoballstart;
  var_03 = var_1["avoidBallDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(var_02 < var_03, 0, 100);
}

prefernearlastteamspawn(var_00) {
  var_01 = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(var_01))
    return 0;

  var_02 = distancesquared(var_1.origin, var_0.origin);
  var_02 = int(min(var_02, 9000000));
  var_03 = 1.0 - var_02 / 9000000;
  return 100 * var_03 + 0;
}