/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnfactor.gsc
***********************************************/

init_spawn_factors() {
  if(!isDefined(level.spawn_closeenemydistsq))
    level.spawn_closeenemydistsq = 250000;

  if(!isDefined(level.enemyspawninfluencedistsq))
    level.enemyspawninfluencedistsq = 810000;

  registerfactor("preferOptimalTTLOS", ::preferoptimalttlos, 0, undefined);
  registerfactor("avoidShortTimeToEnemySight", ::avoidshorttimetoenemysight, 0, undefined);
  registerfactor("preferAlliesByDistance", ::preferalliesbydistance, 0, undefined);
  registerfactor("preferCloseToAlly", ::preferclosetoally, 0, undefined);
  registerfactor("avoidRecentlyUsedByEnemies", ::avoidrecentlyusedbyenemies, 0, undefined);
  registerfactor("avoidEnemiesByDistance", ::avoidenemiesbydistance, 0, undefined);
  registerfactor("avoidEnemyInfluence", ::avoidenemyinfluence, 0, undefined);
  registerfactor("avoidLastDeathLocation", ::avoidlastdeathlocation, 0, undefined);
  registerfactor("avoidLastAttackerLocation", ::avoidlastattackerlocation, 0, undefined);
  registerfactor("avoidShortTimeToJumpingEnemySight", ::avoidshorttimetojumpingenemysight, 0, undefined);
  registerfactor("avoidVeryShortTimeToJumpingEnemySight", ::avoidveryshorttimetojumpingenemysight, 0, undefined);
  registerfactor("avoidSameSpawn", ::avoidsamespawn, 0, undefined);
  registerfactor("avoidRecentlyUsedByAnyone", ::avoidrecentlyusedbyanyone, 0, undefined);
  registerfactor("avoidUsedByAnyoneEver", ::_id_990B9AF16EEE882C, 0, undefined);
  registerfactor("randomSpawnScore", ::randomspawnscore, 0, undefined);
  registerfactor("preferNearLastTeamSpawn", ::prefernearlastteamspawn, 0, undefined);
  registerfactor("preferNearGroupsOfTeamMates", ::preferneargroupsofteammates, 0, undefined);
  registerfactor("preferOccupiedLanes", ::preferoccupiedlanes, 0, undefined);
  registerfactor("preferToBalanceLanes", ::prefertobalancelanes, 0, undefined);
  registerfactor("avoidClosestEnemy", ::avoidclosestenemy, 0, undefined);
  registerfactor("scriptOnlyTest", ::scriptonlytest, 1, ["test"]);
  registerfactor("avoidClosestEnemyByDistance", ::avoidclosestenemybydistance, 1, ["closestEnemyInfluenceDistSq"]);
  registerfactor("preferNearSinglePoint", ::prefernearsinglepoint, 1, ["singlePointPos", "minDistToSinglePointSq", "maxDistToSinglePointSq", "distRangeToSinglePointSq"]);
  registerfactor("preferDomPoints", ::preferdompoints, 1, ["preferredDomPoints", "secondaryDomPoints"]);
  registerfactor("preferShortestDistToKOTHZone", ::prefershortestdisttokothzone, 1, ["activeKOTHZoneNumber", "maxSquaredDistToObjective"]);
  registerfactor("avoidCloseToKOTHZone", ::avoidclosetokothzone, 1, ["activeKOTHZoneNumber", "kothZoneDeadzoneDistSq"]);
  registerfactor("preferClosePoints", ::preferclosepoints, 1, ["closestPoints"]);
  registerfactor("avoidRugbyOffsides", ::avoidrugbyoffsides, 1, ["juggPos", "rugbyFieldDir2D"]);
  registerfactor("oneUseSpawns", ::oneusespawns, 1, undefined);
  registerfactor("avoidCloseToDefenderFlag", ::avoidclosetodefenderflag, 1, ["activeCarrierPosition", "defenderFlagPosition", "avoidDefenderFlagDeadZoneDistSq"]);
  registerfactor("avoidCloseToDefenderFlagSpawn", ::avoidclosetodefenderflagspawn, 1, ["avoidDefenderFlagDeadZoneDistSq"]);
  registerfactor("avoidFrontlineOffsides", ::_id_F0258BCBE29F7E4C, 1, ["teamForward"]);
  registerfactor("preferOptimalFrontlineDist", ::_id_D579A6C830A21F6C, 1, undefined);
  registerfactor("preferUnoccupiedLanes", ::_id_1CB1946305DD6F4B, 1, undefined);
  initfrontline();
}

registerfactor(_id_7BE5A2E10A013091, _id_A4E8F07B48BDE65E, isscriptonly, paramreflist) {
  if(!isDefined(level.spawnglobals.factors))
    level.spawnglobals.factors = [];

  _id_036247CED4A30872 = spawnStruct();
  level.spawnglobals.factors[_id_7BE5A2E10A013091] = _id_036247CED4A30872;
  _id_036247CED4A30872.function = _id_A4E8F07B48BDE65E;
  _id_036247CED4A30872.paramreflist = paramreflist;
  _id_036247CED4A30872.isscriptonly = isscriptonly;
}

isfactorregistered(_id_7BE5A2E10A013091) {
  return isDefined(level.spawnglobals.factors[_id_7BE5A2E10A013091]);
}

isfactorscriptonly(_id_7BE5A2E10A013091) {
  return level.spawnglobals.factors[_id_7BE5A2E10A013091].isscriptonly;
}

getfactorfunction(_id_7BE5A2E10A013091) {
  return level.spawnglobals.factors[_id_7BE5A2E10A013091].function;
}

getfactorparamreflist(_id_7BE5A2E10A013091) {
  return level.spawnglobals.factors[_id_7BE5A2E10A013091].paramreflist;
}

calculatefactorscore(spawnpoint, _id_7BE5A2E10A013091, weight) {
  if(!isfactorregistered(_id_7BE5A2E10A013091))
    return 0;

  _id_A4E8F07B48BDE65E = getfactorfunction(_id_7BE5A2E10A013091);
  _id_FF2D79932540D96C = getfactorparamreflist(_id_7BE5A2E10A013091);
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;

  if(isDefined(_id_FF2D79932540D96C)) {
    if(!isDefined(_id_4DB3CFD2EA2D7B8F.factorparams)) {}
  }

  score = [[_id_A4E8F07B48BDE65E]](spawnpoint);
  score = clamp(score, 0, 100);
  score = score * weight;
  spawnpoint.totalpossiblescore = spawnpoint.totalpossiblescore + 100 * weight;
  spawnpoint.lastscore[self.team] = spawnpoint.lastscore[self.team] + score;
  spawnpoint.totalscore = spawnpoint.totalscore + score;
  return score;
}

critical_factor(_id_E2CADC5BF4175E47, spawnpoint) {
  _id_913B73097FDCDB62 = [[_id_E2CADC5BF4175E47]](spawnpoint);
  _id_913B73097FDCDB62 = clamp(_id_913B73097FDCDB62, 0, 100);
  return _id_913B73097FDCDB62;
}

avoidcarepackages(spawnpoint) {
  foreach(_id_F471430A28CF8270 in level.carepackages) {
    if(!isDefined(_id_F471430A28CF8270)) {
      continue;
    }
    if(distancesquared(spawnpoint.origin, _id_F471430A28CF8270.origin) < 22500)
      return 0;
  }

  return 100;
}

avoidbradleys(spawnpoint) {
  if(isDefined(level.bradley)) {
    foreach(bradley in level.bradley.activevehicles["total"]) {
      if(distancesquared(spawnpoint.origin, bradley.origin) < 50625)
        return 0;
    }

    foreach(bradley in level.bradley.inactivevehicles["total"]) {
      if(distancesquared(spawnpoint.origin, bradley.origin) < 50625)
        return 0;
    }
  }

  return 100;
}

avoidgrenades(spawnpoint) {
  foreach(grenade in level.grenades) {
    if(!isDefined(grenade) || !grenade isexplosivedangeroustoplayer(self) || istrue(grenade.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(spawnpoint.origin, grenade.origin) < 122500)
      return 0;
  }

  return 100;
}

avoidmines(spawnpoint) {
  _id_4E5DA354865DF1FD = level.mines;

  if(isDefined(level.traps) && level.traps.size > 0)
    _id_4E5DA354865DF1FD = scripts\engine\utility::array_combine(_id_4E5DA354865DF1FD, level.traps);

  foreach(explosive in _id_4E5DA354865DF1FD) {
    if(!isDefined(explosive) || !explosive isexplosivedangeroustoplayer(self) || istrue(explosive.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(spawnpoint.origin, explosive.origin) < 122500)
      return 0;
  }

  return 100;
}

isexplosivedangeroustoplayer(player) {
  if(!level.teambased || level.friendlyfire || !isDefined(player.team))
    return 1;
  else {
    _id_567FBB57B0FBCAF9 = undefined;

    if(isDefined(self.owner)) {
      if(player == self.owner)
        return 1;

      _id_567FBB57B0FBCAF9 = self.owner.team;
    }

    if(isDefined(_id_567FBB57B0FBCAF9))
      return _id_567FBB57B0FBCAF9 != player.team;
    else
      return 1;
  }
}

avoidcornervisibleenemies(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(spawnpoint.cornersights[enemyteam] > 0)
    return 0;

  return 100;
}

avoidfullvisibleenemies(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(spawnpoint.fullsights[enemyteam] > 0)
    return 0;

  return 100;
}

avoidcloseenemies(spawnpoint) {
  _id_B0C33D224B825287 = [];
  _id_0AD5A67FE096D8B1 = [];

  if(level.teambased)
    _id_B0C33D224B825287[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    _id_B0C33D224B825287[_id_B0C33D224B825287.size] = "all";

  foreach(enemyteam in _id_B0C33D224B825287) {
    if(spawnpoint.totalplayers[enemyteam] == 0) {
      continue;
    }
    _id_0AD5A67FE096D8B1[_id_0AD5A67FE096D8B1.size] = enemyteam;
  }

  if(_id_0AD5A67FE096D8B1.size == 0)
    return 100;

  foreach(enemyteam in _id_0AD5A67FE096D8B1) {
    if(spawnpoint.mindistsquared[enemyteam] < level.spawn_closeenemydistsq)
      return 0;
  }

  return 100;
}

avoidtelefrag(spawnpoint) {
  return 100;
}

avoidsamespawn(spawnpoint) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoint)
    return 0;

  return 100;
}

avoidenemyspawn(spawnpoint) {
  if(isDefined(self.team) && isDefined(spawnpoint.lastspawnteam) && (!level.teambased || spawnpoint.lastspawnteam != self.team)) {
    _id_2FFC2EBC035D0C54 = spawnpoint.lastspawntime + 500;

    if(gettime() < _id_2FFC2EBC035D0C54)
      return 0;
  }

  return 100;
}

avoidrecentlyusedbyenemies(spawnpoint) {
  _id_973AE253ACB25D0E = !level.teambased || isDefined(spawnpoint.lastspawnteam) && self.team != spawnpoint.lastspawnteam;

  if(_id_973AE253ACB25D0E && isDefined(spawnpoint.lastspawntime)) {
    _id_3B5803E733581858 = gettime() - spawnpoint.lastspawntime;
    spawnpoint.analytics.spawnusedbyenemies = _id_3B5803E733581858 / 1000;

    if(_id_3B5803E733581858 > 4000)
      return 100;

    return _id_3B5803E733581858 / 4000 * 100;
  }

  return 100;
}

avoidrecentlyusedbyanyone(spawnpoint) {
  if(isDefined(spawnpoint.lastspawntime)) {
    _id_3B5803E733581858 = gettime() - spawnpoint.lastspawntime;
    spawnpoint.analytics.timesincelastspawn = _id_3B5803E733581858 / 1000;

    if(_id_3B5803E733581858 > 4000)
      return 100;

    return _id_3B5803E733581858 / 4000 * 100;
  }

  return 100;
}

_id_990B9AF16EEE882C() {
  return 100;
}

avoidlastdeathlocation(spawnpoint) {
  if(!isDefined(self.lastdeathpos))
    return 100;

  distsq = distancesquared(spawnpoint.origin, self.lastdeathpos);

  if(distsq > 810000)
    return 100;

  _id_6DCA750CC7C96662 = distsq / 810000;
  return _id_6DCA750CC7C96662 * 100;
}

avoidlastattackerlocation(spawnpoint) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin))
    return 100;

  if(!scripts\mp\utility\player::isreallyalive(self.lastattacker))
    return 100;

  distsq = distancesquared(spawnpoint.origin, self.lastattacker.origin);

  if(distsq > 810000)
    return 100;

  _id_6DCA750CC7C96662 = distsq / 810000;
  return _id_6DCA750CC7C96662 * 100;
}

initfrontline() {
  frontlineinfo = getglobalfrontlineinfo();

  if(getdvarint("scr_ignore_frontline_anchor", 0) == 1) {
    return;
  }
  _id_35F37345312ECE32 = [];
  yaw = getdvarfloat("dvar_F0FC1446B9AB706D", -1);

  if(yaw != -1) {
    frontlineinfo.usinganchors = 1;
    frontlineinfo.anchordir = anglesToForward((0, yaw, 0));
    frontlineinfo.anchorrt = anglestoright((0, yaw, 0));

    if(isDefined(level.mapcenter))
      frontlineinfo.primaryanchorpos = (level.mapcenter[0], level.mapcenter[1], 0);
    else
      frontlineinfo.primaryanchorpos = (0, 0, 0);
  } else if(istrue(level.testtdmanywhere)) {
    y = getdvarfloat("dvar_AA7892BB1DE8F27D", randomfloatrange(0, 359));
    frontlineinfo.usinganchors = 1;
    frontlineinfo.anchordir = anglesToForward((0, y, 0));
    frontlineinfo.anchorrt = anglestoright((0, y, 0));

    if(isDefined(level.mapcenter))
      frontlineinfo.primaryanchorpos = (level.mapcenter[0], level.mapcenter[1], 0);

    level.tdmanywherefrontline = frontlineinfo;
  } else {
    _id_35F37345312ECE32 = getEntArray("mp_frontline_anchor", "classname");

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      _id_B5C65D27DFC53F84 = [];

      foreach(ent in _id_35F37345312ECE32) {
        if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
          _id_B5C65D27DFC53F84[_id_B5C65D27DFC53F84.size] = ent;
          continue;
        }

        ent delete();
      }

      _id_35F37345312ECE32 = _id_B5C65D27DFC53F84;
    } else if(_id_35F37345312ECE32.size != 1) {
      _id_2A427A24184B5B49 = [];

      foreach(ent in _id_35F37345312ECE32) {
        if(!isDefined(ent.script_noteworthy) || !issubstr(ent.script_noteworthy, "locale")) {
          _id_2A427A24184B5B49[_id_2A427A24184B5B49.size] = ent;
          continue;
        }

        ent delete();
      }

      _id_35F37345312ECE32 = _id_2A427A24184B5B49;
    }

    if(_id_35F37345312ECE32.size != 0) {
      frontlineinfo.usinganchors = 1;
      frontlineinfo.anchordir = anglesToForward(_id_35F37345312ECE32[0].angles);
      frontlineinfo.primaryanchorpos = (_id_35F37345312ECE32[0].origin[0], _id_35F37345312ECE32[0].origin[1], 0);
    }
  }
}

updatefrontline(team) {
  if(!updatefrontlineposition()) {
    return;
  }
  runfrontlinespawntrapchecks(team);
  updatefrontlinedebug();
}

updatefrontlineposition() {
  if(!currentspawnlogicsupportsfrontline())
    return 0;

  frontlineinfo = getglobalfrontlineinfo();
  _id_6B7BEE46F2C6DA28 = gettime();

  if(!isDefined(frontlineinfo.lastupdatetime))
    frontlineinfo.lastupdatetime = _id_6B7BEE46F2C6DA28;
  else if(frontlineinfo.isactive["allies"] && frontlineinfo.isactive["axis"])
    frontlineinfo.uptime = frontlineinfo.uptime + frontlineinfo.lastupdatetimedelta;
  else
    frontlineinfo.downtime = frontlineinfo.downtime + frontlineinfo.lastupdatetimedelta;

  _id_F4C2DE4526F2E59D = (_id_6B7BEE46F2C6DA28 - frontlineinfo.lastupdatetime) / 1000.0;
  frontlineinfo.lastupdatetime = _id_6B7BEE46F2C6DA28;
  frontlineinfo.lastupdatetimedelta = _id_F4C2DE4526F2E59D;
  alliesaverage = getfrontlineteamcenter("allies");

  if(!isDefined(alliesaverage))
    return 0;

  alliesaverage = (alliesaverage[0], alliesaverage[1], 0);
  frontlineinfo.alliesaverage = alliesaverage;
  axisaverage = getfrontlineteamcenter("axis");

  if(!isDefined(axisaverage))
    return 0;

  axisaverage = (axisaverage[0], axisaverage[1], 0);
  frontlineinfo.axisaverage = axisaverage;

  if(frontlineinfo.usinganchors) {
    _id_E14EABE1E070C9C8 = alliesaverage - frontlineinfo.primaryanchorpos;
    _id_5A95892AF4420023 = vectordot(frontlineinfo.anchordir, _id_E14EABE1E070C9C8);
    projectedalliescenter = frontlineinfo.anchordir * _id_5A95892AF4420023 + frontlineinfo.primaryanchorpos;
    frontlineinfo.projectedalliescenter = projectedalliescenter;
    _id_E14EABE1E070C9C8 = axisaverage - frontlineinfo.primaryanchorpos;
    _id_26047C9C4B84B7C4 = vectordot(frontlineinfo.anchordir, _id_E14EABE1E070C9C8);
    projectedaxiscenter = frontlineinfo.anchordir * _id_26047C9C4B84B7C4 + frontlineinfo.primaryanchorpos;
    frontlineinfo.projectedaxiscenter = projectedaxiscenter;
    _id_F257A6C6CAFA27D4 = abs(_id_5A95892AF4420023 - _id_26047C9C4B84B7C4);

    if(_id_F257A6C6CAFA27D4 < 600 && isDefined(frontlineinfo.teamdiffyaw))
      frontlineinfo.contested = 1;
    else {
      frontlineinfo.contested = 0;
      frontlineinfo.midpoint = projectedalliescenter + (projectedaxiscenter - projectedalliescenter) * 0.5;
      frontlinedir = projectedaxiscenter - projectedalliescenter;
      frontlineinfo.teamdiffyaw = vectortoyaw(frontlinedir);
    }
  } else {
    _id_3C847766177E2A2C = axisaverage - alliesaverage;
    _id_DD247CC43DD18627 = vectortoyaw(_id_3C847766177E2A2C);
    frontlineinfo.teamdiffyaw = _id_DD247CC43DD18627;
    _id_24F96794CBB5CF52 = alliesaverage + _id_3C847766177E2A2C * 0.5;
    frontlineinfo.midpoint = _id_24F96794CBB5CF52;
  }

  _id_F237C6BC0CA5C62C = anglesToForward((0, frontlineinfo.teamdiffyaw, 0));
  spawnpoints = level.spawnpoints;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    _id_07E2DF766BCE34B1 = frontlineinfo.midpoint - spawnpoint.origin;
    _id_4D2D882316198C95 = vectordot(_id_07E2DF766BCE34B1, _id_F237C6BC0CA5C62C);
    spawnpoint.frontlineteam = scripts\engine\utility::ter_op(_id_4D2D882316198C95 > 0, "allies", "axis");
  }

  return 1;
}

updatefrontlinedebug() {
  _id_D8CCE60415DE6332 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  analyticslogenabled = scripts\mp\analyticslog::analyticslogenabled();

  if(!_id_D8CCE60415DE6332 && !analyticslogenabled) {
    return;
  }
  frontlineinfo = getglobalfrontlineinfo();

  if(!isDefined(frontlineinfo.logids) && isDefined(level.matchrecording_generateid)) {
    frontlineinfo.logids = [];
    frontlineinfo.logids["alliesCenter"] = [[level.matchrecording_generateid]]();
    frontlineinfo.logids["axisCenter"] = [[level.matchrecording_generateid]]();
  }

  if(!frontlineinfo.isactive["allies"] && !frontlineinfo.isactive["axis"]) {
    return;
  }
  _id_499F398B1CA169D3 = (frontlineinfo.midpoint[0], frontlineinfo.midpoint[1], level.mapcenter[2]);
  _id_4E8E12D3C7A4D029 = anglestoright((0, frontlineinfo.teamdiffyaw, 0));
  logfrontlinetomatchrecording(_id_499F398B1CA169D3, _id_4E8E12D3C7A4D029, frontlineinfo.isactive["allies"], frontlineinfo.isactive["axis"]);

  if(isDefined(level.matchrecording_logevent)) {
    axisaverage = scripts\engine\utility::ter_op(frontlineinfo.isactive["axis"], frontlineinfo.axisaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](frontlineinfo.logids["axisCenter"], "axis", "ANCHOR", axisaverage[0], axisaverage[1], gettime());
    alliesaverage = scripts\engine\utility::ter_op(frontlineinfo.isactive["allies"], frontlineinfo.alliesaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](frontlineinfo.logids["alliesCenter"], "allies", "ANCHOR", alliesaverage[0], alliesaverage[1], gettime());
  }
}

logfrontlinetomatchrecording(midpoint, direction, _id_F3C3C5C8DB76B4F0, _id_DBBD5B5E90B7C2EB) {
  if(isDefined(level.matchrecording_logevent)) {
    _id_026EEF3C170B9E66 = midpoint + direction * 5000;
    _id_026EEE3C170B9C33 = midpoint - direction * 5000;

    if(!isDefined(level.matchrecording_frontlinelogid))
      level.matchrecording_frontlinelogid = [[level.matchrecording_generateid]]();

    _id_1CC0A856DBF7D44E = undefined;

    if(_id_F3C3C5C8DB76B4F0 && _id_DBBD5B5E90B7C2EB)
      _id_1CC0A856DBF7D44E = "FRONT_LINE";
    else
      _id_1CC0A856DBF7D44E = scripts\engine\utility::ter_op(_id_F3C3C5C8DB76B4F0, "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS");

    [[level.matchrecording_logevent]](level.matchrecording_frontlinelogid, "allies", _id_1CC0A856DBF7D44E, _id_026EEF3C170B9E66[0], _id_026EEF3C170B9E66[1], gettime(), undefined, _id_026EEE3C170B9C33[0], _id_026EEE3C170B9C33[1]);
  }
}

getfrontlineteamcenter(team) {
  players = [];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("player_for_spawn_logic")) {
      continue;
    }
    if(player.team == team)
      players[players.size] = player;
  }

  if(players.size == 0)
    return undefined;

  _id_8FB9617F0786BCA7 = scripts\mp\utility\entity::getaverageorigin(players);
  return _id_8FB9617F0786BCA7;
}

runfrontlinespawntrapchecks(team) {
  if(!currentspawnlogicsupportsfrontline()) {
    return;
  }
  frontlineinfo = getglobalfrontlineinfo();
  frontlineinfo.isactive[team] = 1;

  if(getdvarint("scr_frontline_trap_checks") == 0) {
    return;
  }
  _id_A0417B1DDDC7ACD3 = getdvarint("scr_frontline_min_spawns", 0);

  if(_id_A0417B1DDDC7ACD3 == 0)
    _id_A0417B1DDDC7ACD3 = 4;

  enemyteam = scripts\mp\utility\game::getotherteam(team)[0];
  _id_7EFD0C35C23E92B4 = 0;
  spawnpoints = level.spawnpoints;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(!isDefined(spawnpoint.frontlineteam) || spawnpoint.frontlineteam != team) {
      continue;
    }
    if(!isDefined(spawnpoint.fullsights) || !isDefined(spawnpoint.fullsights[enemyteam]) || spawnpoint.fullsights[enemyteam] <= 0)
      _id_7EFD0C35C23E92B4++;
  }

  _id_4A40D7AEA77D0271 = _id_7EFD0C35C23E92B4 / spawnpoints.size;

  if(_id_7EFD0C35C23E92B4 < _id_A0417B1DDDC7ACD3 || _id_4A40D7AEA77D0271 < 0.0) {
    if(_id_7EFD0C35C23E92B4 < _id_A0417B1DDDC7ACD3)
      frontlineinfo.disabledreason[team] = 0;
    else
      frontlineinfo.disabledreason[team] = 1;

    frontlineinfo.isactive[team] = 0;
  }
}

currentspawnlogicsupportsfrontline() {
  return istrue(level.spawnglobals.frontlinelogictypes[level.spawnglobals.activespawnlogic]);
}

getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["allies"] = 0;
    level.frontlineinfo.isactive["axis"] = 0;
    level.frontlineinfo.uptime = 0.0;
    level.frontlineinfo.downtime = 0.0;
    level.frontlineinfo.contested = 0;
    level.frontlineinfo.usinganchors = 0;
  }

  return level.frontlineinfo;
}

preferalliesbydistance(spawnpoint) {
  if(spawnpoint.totalplayers[self.team] == 0)
    return 0;

  allyaveragedist = spawnpoint.distsumsquared[self.team] / spawnpoint.totalplayers[self.team];
  allyaveragedist = min(allyaveragedist, 3240000);
  spawnpoint.analytics.allyaveragedist = allyaveragedist;
  _id_B64B2F018346F72A = 1 - allyaveragedist / 3240000;
  return _id_B64B2F018346F72A * 100;
}

preferclosetoally(spawnpoint) {
  _id_A924B793B93423F3 = min(spawnpoint.mindistsquared[self.team], 3240000);
  _id_B64B2F018346F72A = 1 - _id_A924B793B93423F3 / 3240000;
  return _id_B64B2F018346F72A * 100;
}

avoidenemiesbydistance(spawnpoint) {
  _id_B0C33D224B825287 = [];
  _id_0AD5A67FE096D8B1 = [];

  if(level.teambased)
    _id_B0C33D224B825287[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    _id_B0C33D224B825287[_id_B0C33D224B825287.size] = "all";

  foreach(enemyteam in _id_B0C33D224B825287) {
    if(spawnpoint.totalplayers[enemyteam] == 0) {
      continue;
    }
    _id_0AD5A67FE096D8B1[_id_0AD5A67FE096D8B1.size] = enemyteam;
  }

  if(_id_0AD5A67FE096D8B1.size == 0)
    return 100;

  foreach(enemyteam in _id_0AD5A67FE096D8B1) {
    if(spawnpoint.mindistsquared[enemyteam] < 250000)
      return 0;
  }

  _id_A5BB1FA786D5B61E = 0;
  _id_472B151D674F3B77 = 0;

  foreach(enemyteam in _id_0AD5A67FE096D8B1) {
    _id_A5BB1FA786D5B61E = _id_A5BB1FA786D5B61E + spawnpoint.distsumsquaredcapped[enemyteam];
    _id_472B151D674F3B77 = _id_472B151D674F3B77 + spawnpoint.totalplayers[enemyteam];
  }

  _id_42E18C11C58F15F1 = _id_A5BB1FA786D5B61E / _id_472B151D674F3B77;
  _id_42E18C11C58F15F1 = min(_id_42E18C11C58F15F1, 7290000);
  _id_B64B2F018346F72A = _id_42E18C11C58F15F1 / 7290000;
  spawnpoint.analytics.enemyaveragedist = _id_42E18C11C58F15F1;
  return _id_B64B2F018346F72A * 100;
}

avoidenemyinfluence(spawnpoint) {
  enemyteam = undefined;

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    enemyteam = "all";

  if(spawnpoint.mindistsquared[enemyteam] < level.enemyspawninfluencedistsq)
    return 0;

  return 100;
}

avoidclosestenemy(spawnpoint) {
  _id_B0C33D224B825287 = [];
  _id_0AD5A67FE096D8B1 = [];

  if(level.teambased)
    _id_B0C33D224B825287[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    _id_B0C33D224B825287[_id_B0C33D224B825287.size] = "all";

  foreach(enemyteam in _id_B0C33D224B825287) {
    if(spawnpoint.totalplayers[enemyteam] == 0) {
      continue;
    }
    _id_0AD5A67FE096D8B1[_id_0AD5A67FE096D8B1.size] = enemyteam;
  }

  if(_id_0AD5A67FE096D8B1.size == 0)
    return 100;

  _id_4862098EE5021DB9 = 0;

  foreach(enemyteam in _id_0AD5A67FE096D8B1) {
    if(spawnpoint.mindistsquared[enemyteam] < 250000)
      return 0;

    _id_4D932F368B6FFDA6 = min(spawnpoint.mindistsquared[enemyteam], 3240000);
    _id_B64B2F018346F72A = _id_4D932F368B6FFDA6 / 3240000;
    _id_4862098EE5021DB9 = _id_4862098EE5021DB9 + _id_B64B2F018346F72A * 100;
  }

  return _id_4862098EE5021DB9 / _id_0AD5A67FE096D8B1.size;
}

avoidclosestenemybydistance(spawnpoint) {
  _id_DA40D465F5D6C5A6 = level.spawnglobals.activespawncontext.factorparams["closestEnemyInfluenceDistSq"];
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  _id_42CA41C7DADAE0C0 = 0;

  foreach(enemy in level.teamdata[enemyteam]["players"]) {
    distsq = distancesquared(spawnpoint.origin, enemy.origin);

    if(distsq < _id_42CA41C7DADAE0C0)
      _id_42CA41C7DADAE0C0 = distsq;
  }

  if(_id_42CA41C7DADAE0C0 < 250000)
    return 0;

  _id_4D932F368B6FFDA6 = min(_id_42CA41C7DADAE0C0, _id_DA40D465F5D6C5A6);
  _id_B64B2F018346F72A = _id_4D932F368B6FFDA6 / _id_DA40D465F5D6C5A6;
  return _id_B64B2F018346F72A * 100;
}

preferdompoints(spawnpoint) {
  _id_255BA911692A2561 = level.spawnglobals.activespawncontext.factorparams["preferredDomPoints"];
  _id_D4AFFDBF750D5880 = level.spawnglobals.activespawncontext.factorparams["secondaryDomPoints"];
  scriptdata = spawnpoint.scriptdata;

  if(isDefined(scriptdata.domflagassignments)) {
    if(scriptdata.domflagassignments &_id_255BA911692A2561)
      return 100;
    else if(scriptdata.domflagassignments &_id_D4AFFDBF750D5880)
      return 50.0;
  }

  return 0;
}

preferclosepoints(spawnpoint) {
  _id_E2231EC8BDD4A84F = level.spawnglobals.activespawncontext.factorparams["closestPoints"];

  foreach(point in _id_E2231EC8BDD4A84F) {
    if(spawnpoint == point)
      return 100;
  }

  return 0;
}

preferbyteambase(spawnpoint, team) {
  if(isDefined(spawnpoint.teambase) && spawnpoint.teambase == team)
    return 100;

  return 0;
}

preferoptimalttlos(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  _id_AF25EE969F7EDD48 = 1.0 - spawnpoint.maxsightvalue[enemyteam];
  _id_CD9F4A27303D749E = scripts\mp\spawnlogic::getmaxdistancetolos();
  _id_1C88BC619924142F = _id_AF25EE969F7EDD48 * _id_CD9F4A27303D749E;

  if(_id_1C88BC619924142F > 1200) {
    _id_B1A0228D2EBC8326 = (_id_CD9F4A27303D749E - _id_1C88BC619924142F) / (_id_CD9F4A27303D749E - 1200);
    return 100 * _id_B1A0228D2EBC8326;
  } else {
    _id_B1A0228D2EBC8326 = _id_1C88BC619924142F / 1200;
    return 100 * _id_B1A0228D2EBC8326;
  }
}

avoidshorttimetoenemysight(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  _id_AF25EE969F7EDD48 = 1.0 - spawnpoint.maxsightvalue[enemyteam];
  spawnpoint.analytics.maxenemysightfraction = _id_AF25EE969F7EDD48;
  return (1.0 - _id_AF25EE969F7EDD48) * 0 + _id_AF25EE969F7EDD48 * 100;
}

avoidshorttimetojumpingenemysight(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  _id_AF25EE969F7EDD48 = 1.0 - spawnpoint.maxjumpsightvalue[enemyteam];
  spawnpoint.analytics.maxjumpingenemysightfraction = _id_AF25EE969F7EDD48;
  return (1.0 - _id_AF25EE969F7EDD48) * 0 + _id_AF25EE969F7EDD48 * 100;
}

avoidveryshorttimetojumpingenemysight(spawnpoint) {
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  _id_AF25EE969F7EDD48 = 1.0 - spawnpoint.maxjumpsightvalue[enemyteam];
  _id_6D87052F9222032E = _id_AF25EE969F7EDD48 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(_id_6D87052F9222032E < 300)
    return 0;
  else
    return 100;
}

randomspawnscore(spawnpoint) {
  spawnpoint.analytics.randomscore = randomintrange(0, 99);
  return spawnpoint.analytics.randomscore;
}

maxplayerspawninfluencedistsquared(spawnpoint) {
  return 3240000;
}

prefershortestdisttokothzone(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_653A7E504D42846A = _id_4DB3CFD2EA2D7B8F.factorparams["activeKOTHZoneNumber"];
  distsq = spawnpoint.scriptdata.distsqtokothzones[_id_653A7E504D42846A];
  _id_9799F8752D4AE4BF = _id_4DB3CFD2EA2D7B8F.factorparams["maxSquaredDistToObjective"];
  _id_477C1209E5432ABE = 1.0 - distsq / _id_9799F8752D4AE4BF;
  return 100 * _id_477C1209E5432ABE + 0;
}

avoidclosetokothzone(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_653A7E504D42846A = _id_4DB3CFD2EA2D7B8F.factorparams["activeKOTHZoneNumber"];
  distsq = spawnpoint.scriptdata.distsqtokothzones[_id_653A7E504D42846A];
  _id_EB31D5343C6ABC39 = _id_4DB3CFD2EA2D7B8F.factorparams["kothZoneDeadzoneDistSq"];
  return scripts\engine\utility::ter_op(distsq < _id_EB31D5343C6ABC39, 0, 100);
}

prefernearlastteamspawn(spawnpoint) {
  _id_A77C3F8DACEA618B = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(_id_A77C3F8DACEA618B))
    return 0;

  distsq = distancesquared(_id_A77C3F8DACEA618B.origin, spawnpoint.origin);
  distsq = int(min(distsq, 9000000));
  _id_477C1209E5432ABE = 1.0 - distsq / 9000000;
  return 100 * _id_477C1209E5432ABE + 0;
}

preferneargroupsofteammates(spawnpoint) {
  spawnglobals = level.spawnglobals;
  _id_8471C2246452276D = -1;

  foreach(_id_3402D60C1EF6B931 in spawnglobals.teamclusters[self.team].clusterlist) {
    if(_id_3402D60C1EF6B931.players.size <= 1) {
      continue;
    }
    distsq = distance2dsquared(_id_3402D60C1EF6B931.center, spawnpoint.origin);

    if(_id_8471C2246452276D < 0 || distsq < _id_8471C2246452276D)
      _id_8471C2246452276D = distsq;
  }

  if(_id_8471C2246452276D < 0)
    return 0;

  if(_id_8471C2246452276D < 10000)
    return 100;

  _id_8471C2246452276D = int(min(_id_8471C2246452276D, 9000000));
  _id_477C1209E5432ABE = 1.0 - (_id_8471C2246452276D - 10000) / 8990000;
  return 100 * _id_477C1209E5432ABE + 0;
}

preferoccupiedlanes(spawnpoint) {
  spawnglobals = level.spawnglobals;
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(!isDefined(spawnglobals.occupiedlanemasks[enemyteam]))
    return 0;

  if((spawnpoint.lanemask &spawnglobals.occupiedlanemasks[enemyteam]) != 0)
    return 100;
  else
    return 0;
}

prefertobalancelanes(spawnpoint) {
  spawnglobals = level.spawnglobals;
  _id_AC6CA28A64718193 = scripts\mp\spawnlogic::getspawnteam(self);
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(_id_AC6CA28A64718193)[0];

  if(!isDefined(spawnglobals.occupiedlanemasks[enemyteam]))
    return 0;

  _id_E5C11A1B96BE1D3C = spawnpoint.lanemask &spawnglobals.occupiedlanemasks[enemyteam];
  _id_5E132BCEBFCC07B2 = isDefined(spawnglobals.occupiedlanemasks[_id_AC6CA28A64718193]) && spawnpoint.lanemask &spawnglobals.occupiedlanemasks[_id_AC6CA28A64718193];

  if(_id_E5C11A1B96BE1D3C && !_id_5E132BCEBFCC07B2)
    return 100;
  else
    return 0;
}

scriptonlytest(spawnpoint) {
  return 0;
}

prefernearsinglepoint(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_E7C16A7D72E19271 = _id_4DB3CFD2EA2D7B8F.factorparams["singlePointPos"];
  _id_4F0FC1C36324AFFB = _id_4DB3CFD2EA2D7B8F.factorparams["minDistToSinglePointSq"];
  _id_CDC5DD6C28C9709D = _id_4DB3CFD2EA2D7B8F.factorparams["maxDistToSinglePointSq"];
  _id_9E3A315D4F55AFC6 = _id_4DB3CFD2EA2D7B8F.factorparams["distRangeToSinglePointSq"];
  distsq = distance2dsquared(_id_E7C16A7D72E19271, spawnpoint.origin);

  if(distsq >= _id_CDC5DD6C28C9709D)
    return 0;

  if(distsq <= _id_4F0FC1C36324AFFB)
    return 100;

  _id_B1A0228D2EBC8326 = 1.0 - (distsq - _id_4F0FC1C36324AFFB) / _id_9E3A315D4F55AFC6;
  return 100 * _id_B1A0228D2EBC8326;
}

avoidrugbyoffsides(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_D55A5C273C69F3C8 = _id_4DB3CFD2EA2D7B8F.factorparams["juggPos"];
  _id_3CB9F8EB3125D3B4 = _id_4DB3CFD2EA2D7B8F.factorparams["rugbyFieldDir2D"];
  _id_9C6453D1F660C3DC = (spawnpoint.origin - _id_D55A5C273C69F3C8) * (1, 1, 0);
  dot = vectordot(_id_9C6453D1F660C3DC, _id_3CB9F8EB3125D3B4);

  if(dot >= 0)
    return 0;

  return 100;
}

oneusespawns(spawnpoint) {
  scriptdata = spawnpoint.scriptdata;

  if(istrue(scriptdata.used))
    return 0;
  else
    return 100;
}

avoidclosetodefenderflag(spawnpoint, _id_B8AD7552CE2E1E5A) {
  _id_CC1ACF45D269A8AC = undefined;
  _id_EB28D9F8D5A7784D = _id_B8AD7552CE2E1E5A["activeCarrierPosition"];
  _id_C48319E73068AA11 = _id_B8AD7552CE2E1E5A["defenderFlagPosition"];
  _id_EB31D5343C6ABC39 = _id_B8AD7552CE2E1E5A["avoidDefenderFlagDeadZoneDistSq"];

  if(isDefined(_id_EB28D9F8D5A7784D))
    _id_CC1ACF45D269A8AC = _id_EB28D9F8D5A7784D;
  else if(isDefined(_id_C48319E73068AA11))
    _id_CC1ACF45D269A8AC = _id_C48319E73068AA11;

  if(isDefined(_id_CC1ACF45D269A8AC)) {
    _id_8336F113929858A6 = distancesquared(_id_CC1ACF45D269A8AC, spawnpoint.origin);
    return scripts\engine\utility::ter_op(_id_8336F113929858A6 < _id_EB31D5343C6ABC39, 0, 100);
  } else
    return 100;
}

avoidclosetodefenderflagspawn(spawnpoint, _id_B8AD7552CE2E1E5A) {
  distsq = spawnpoint.scriptdata.distsqtodefenderfalgstart;
  _id_EB31D5343C6ABC39 = _id_B8AD7552CE2E1E5A["avoidDefenderFlagDeadZoneDistSq"];
  return scripts\engine\utility::ter_op(distsq < _id_EB31D5343C6ABC39, 0, 100);
}

_id_F0258BCBE29F7E4C(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_796860F89DEC057D = _id_4DB3CFD2EA2D7B8F.factorparams["teamForward"];
  _id_8CC8093272818080 = _id_0D17503F56B92539::_id_8964B48E4EBA5797(spawnpoint.origin);
  _id_A620CB0E6444887F = vectorNormalize(spawnpoint.origin - _id_8CC8093272818080);
  dot = vectordot(_id_A620CB0E6444887F, _id_796860F89DEC057D);

  if(dot >= 0)
    return 0;

  return 100;
}

_id_D579A6C830A21F6C(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_3A31A59B650FA9A6 = _id_4DB3CFD2EA2D7B8F.factorparams["idealDistSq"];
  _id_F6F8270F02B2B9BF = _id_0D17503F56B92539::_id_99146672EC896EFA(spawnpoint.origin);
  _id_477C1209E5432ABE = clamp(1.0 - abs(_id_F6F8270F02B2B9BF - _id_3A31A59B650FA9A6) / _id_3A31A59B650FA9A6, 0.0, 1.0);
  return 100 * _id_477C1209E5432ABE + 0;
}

_id_1CB1946305DD6F4B(spawnpoint) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_9799F8752D4AE4BF = 67108864;
  _id_F6F8270F02B2B9BF = _id_0D17503F56B92539::_id_7855EB28C2D21061(spawnpoint.origin, self.team);
  _id_477C1209E5432ABE = clamp(1.0 - _id_F6F8270F02B2B9BF / _id_9799F8752D4AE4BF, 0.0, 1.0);
  return 100 * _id_477C1209E5432ABE + 0;
}