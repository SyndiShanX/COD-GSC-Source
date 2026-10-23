/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1293.gsc
**************************************/

init() {
  level._id_90B4 = 1.21;
  setdvarifuninitialized("spawning_revised_domination", 1);
  setdvarifuninitialized("spawning_revised_teamdeathmatch", 1);
  setdvarifuninitialized("spawning_revised_capturetheflag", 1);
  setdvarifuninitialized("spawning_revised_hardpoint", 1);
  setdvarifuninitialized("spawning_revised_cornersighttraces", 0);
  setdvarifuninitialized("spawning_revised_frontline", 0);
  setdvarifuninitialized("spawning_revised_fatique", 1);

  if(getdvarint("spawning_revised_cornersighttraces") != 0 || getdvarint("spawning_revised_frontline") != 0 || getdvarint("spawning_revised_domination") == 0) {
    level._id_90B4 = 1.22;
  }

  level._id_5A77 = 5000;
  level._id_94F3 = 0;
  level.numplayerswaitingtospawn = 0;
  level.numplayerswaitingtoenterkillcam = 0;
  level._id_9068 = spawnStruct();
  level.players = [];
  level._id_596C = [];
  level.participants = [];
  _func_2CE();
  level.grenades = [];
  level.missiles = [];
  level._id_1FFD = [];
  level.turrets = [];
  level._id_80D8 = [];
  level.ugvs = [];
  level.trackingdrones = [];
  level._id_395E = [];
  level._id_7AD1["allies"] = [];
  level._id_7AD1["axis"] = [];
  level._id_7AD1["all"] = [];
  level._id_7AD4["allies"] = [];
  level._id_7AD4["axis"] = [];
  level._id_7AD4["all"] = [];
  _id_050C::_id_534F();
  _id_050E::_id_5350();
  level thread spawnpointupdate();
  level thread _id_9BCD();
  level._id_9E41 = 1;
}

_id_908A(var_0, var_1) {
  var_2 = self;

  if(!var_1) {
    level.spawnmins = expandmins(level.spawnmins, var_2.origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_2.origin);
  }

  var_2.forward = anglesToForward(var_2.angles);
  var_2._id_8C4D = var_2.origin + (0, 0, 50);
  var_2._id_5BE2 = gettime();
  var_2._id_6C97 = 1;
  var_2._id_52B2 = 1;
  var_2._id_5700 = var_0;
  var_2._id_0CAD = [];
  var_3 = 1024;

  if(!_bullettracepassed(var_2._id_8C4D, var_2._id_8C4D + (0, 0, var_3), 0, undefined)) {
    var_4 = var_2._id_8C4D + var_2.forward * 100;

    if(!_bullettracepassed(var_4, var_4 + (0, 0, var_3), 0, undefined)) {
      var_2._id_6C97 = 0;
    }
  }

  var_5 = anglestoright(var_2.angles);

  if(!maps\mp\_utility::_id_579B()) {
    _id_0996(var_2, var_2.origin + var_5 * 45);
    _id_0996(var_2, var_2.origin - var_5 * 45);
  }

  var_2._id_78CC = _id_463E(var_2.origin);

  if(var_2._id_78CC.size <= 0) {
    if(!isDefined(level.iszombiegame) || !level.iszombiegame) {}
  }

  _id_5351(var_2);

  if(isDefined(var_2._id_0165)) {
    if(isDefined(game["switchedsides"]) && game["switchedsides"] && var_2._id_0165 == "axis_override" || (!isDefined(game["switchedsides"]) || !game["switchedsides"]) && var_2._id_0165 == "allies_override") {
      var_2._id_9849 = "allies";
    } else if(isDefined(game["switchedsides"]) && game["switchedsides"] && var_2._id_0165 == "allies_override" || (!isDefined(game["switchedsides"]) || !game["switchedsides"]) && var_2._id_0165 == "axis_override") {
      var_2._id_9849 = "axis";
    }

    if(isDefined(var_2._id_9849) && maps\mp\_utility::getmapname() == "mp_france_village" && level.gametype == "ball") {
      var_2._id_9849 = maps\mp\_utility::getotherteam(var_2._id_9849);
    }
  }
}

_id_0996(var_0, var_1) {
  var_2 = _playerphysicstrace(var_0.origin, var_0.origin + (0, 0, 18));
  var_3 = var_2[2] - var_0.origin[2];
  var_4 = (var_1[0], var_1[1], var_1[2] + var_3);
  var_5 = _playerphysicstrace(var_2, var_4);

  if(var_5 != var_4) {
    return;
  }
  var_6 = _droptoground(var_4);

  if(_abs(var_6[2] - var_1[2]) > 128) {
    return;
  }
  var_0._id_0CAD[var_0._id_0CAD.size] = var_6;
}

_id_9BCD() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    level.missiles = getEntArray("rocket", "classname");
    level._id_1FFD = getEntArray("care_package", "targetname");
    waitframe();
  }
}

_id_10E5(var_0, var_1) {
  if(isDefined(game["switchedsides"]) && game["switchedsides"]) {
    var_0 = maps\mp\_utility::getotherteam(var_0);
  }

  if(isDefined(level._id_9307) && isDefined(level._id_9307[var_0])) {}

  level._id_9307[var_0] = var_1;

  if(!isDefined(level._id_908E)) {
    level._id_908E = [];
  }

  level._id_908F[var_0] = [];
  var_2 = _setstartspawnpoints(var_1, var_0);

  if(!var_2.size) {
    return;
  }
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _id_908A(0, 0);
    level._id_908E[level._id_908E.size] = var_2[var_3];
    level._id_908F[var_0][level._id_908F[var_0].size] = var_2[var_3];
  }

  foreach(var_5 in var_2) {
    var_5._id_7702 = 1;
    var_6 = anglesToForward(var_5.angles);

    foreach(var_8 in var_2) {
      if(var_5 == var_8) {
        continue;
      }
      var_9 = vectorNormalize(var_8.origin - var_5.origin);
      var_10 = vectordot(var_6, var_9);

      if(var_10 > 0.86) {
        var_5._id_7702 = 0;
        break;
      }
    }
  }
}

_id_10DF(var_0) {
  level._id_8FDC = var_0;
  level.spawnpoints = [];
  var_1 = _setgamespawnpoints(level._id_8FDC);

  if(!var_1.size) {}

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_52B2)) {
      var_3 _id_908A(1, 0);
      level.spawnpoints[level.spawnpoints.size] = var_3;
    }
  }
}

_id_10DC(var_0) {
  level.spawnpoints = [];
  var_1 = _tablegetrowcount("mp/spawnClasses.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = _tablelookupbyrow("mp/spawnClasses.csv", var_2, 1);
    var_4 = [];
    var_4 = _setgamespawnpoints(var_3);

    if(!var_4.size) {}

    foreach(var_6 in var_4) {
      if(!isDefined(var_6._id_52B2)) {
        var_6 _id_908A(1, 0);
        level.spawnpoints[level.spawnpoints.size] = var_6;
      }
    }
  }

  level._id_8FDC = var_0;
}

_id_10E4() {
  var_0 = tablelookup("mp/spawnClasses.csv", 0, level.gametype, 2);
  var_1 = tablelookup("mp/spawnClasses.csv", 0, level.gametype, 3);
  var_2 = tablelookup("mp/spawnClasses.csv", 0, level.gametype, 1);
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(var_0) && var_0 != "none") {
    _id_10E5("allies", var_0);
  }

  if(isDefined(var_1) && var_1 != "none") {
    _id_10E5("axis", var_1);
  }

  if(getdvarint("5234", 0) == 1) {
    _id_10DC(var_2);
  } else if(isDefined(var_2) && var_2 != "none") {
    _id_10DF(var_2);
  }

  _func_300();
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);

  if(level.gametype == "air" || level.gametype == "aces") {
    level.mapcenter = (0, 0, 0);
  }

  if(maps\mp\_utility::getmapname() == "mp_shipment_s2") {
    level.mapcenter = (-938.5, 7275.5, -476);
  } else if(maps\mp\_utility::getmapname() == "mp_sandbox_01") {
    level.mapcenter = (470, 30.5, 920);
  }

  _setmapcenter(level.mapcenter);
  _id_050E::_id_2B5D();
}

_id_5661(var_0, var_1) {
  if(!isDefined(var_1.targetname) || var_1.targetname == "") {
    return 1;
  }

  if(issubstr(var_1.targetname, var_0)) {
    return 1;
  }

  return 0;
}

_id_28C0(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "free";
  }

  var_2 = [];
  var_3 = _getgamespawnpointactivelabel(var_0);

  if(level.gametype == "zombies" && isDefined(level.zombies_active_spawn_event)) {
    var_3 = level.zombies_active_spawn_event;
  }

  foreach(var_5 in var_1) {
    if(_id_5661(var_3, var_5)) {
      var_2 = common_scripts\utility::_id_0972(var_2, var_5);
    }
  }

  return var_2;
}

getspawnpointarray(var_0) {
  if(!isDefined(var_0) && isDefined(level._id_908E) && level._id_908E.size > 0) {
    return level._id_908E;
  } else if(isDefined(var_0) && isDefined(level._id_908F) && isDefined(level._id_908F[var_0]) && level._id_908F[var_0].size > 0) {
    return level._id_908F[var_0];
  } else {
    return level.spawnpoints;
  }
}

_id_44F9(var_0) {
  if(isDefined(level.spawnpoints) && level.spawnpoints.size > 0) {
    var_1 = level.spawnpoints;
  } else if(!isDefined(var_0)) {
    var_1 = level._id_908E;
  } else {
    var_1 = level._id_908F[var_0];
  }

  return _id_28C0(var_0, var_1);
}

_id_448B(var_0) {
  if(!isDefined(var_0)) {
    return level._id_908E;
  } else {
    return level._id_908F[var_0];
  }
}

_id_448A(var_0) {
  return level.spawnpoints;
}

_id_3F9B() {
  return isDefined(level.spawnpoints) && level.spawnpoints.size > 0 && isDefined(level._id_908F["allies"]) && level._id_908F["allies"].size > 0 && isDefined(level._id_908F["axis"]) && level._id_908F["axis"].size > 0;
}

_id_3ACC(var_0) {
  var_1 = "zombie_checkpoint_" + getdvarint("scr_zombieCheckpoint", 0);
  var_2 = "zombie_safe_haven_" + getdvarint("scr_zombieSafeHaven", 0);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5.targetname)) {
      if(_func_2C6(var_5.targetname, "zombie_event_spawn_")) {
        continue;
      }
    }

    if(isDefined(var_5._id_0165)) {
      if(_func_2C6(var_5._id_0165, "zombie_safe_haven_")) {
        if(var_5._id_0165 != var_2) {
          continue;
        }
      }

      if(_func_2C6(var_5._id_0165, "zombie_checkpoint_")) {
        if(var_5._id_0165 != var_1) {
          continue;
        }
      }
    }

    var_3[var_3.size] = var_5;
  }

  if(var_3.size == 0) {
    var_3 = var_0;
  }

  return var_3;
}

filterspawnpointszombiesactiveevent(var_0) {
  var_1 = "zombie_event_spawn_";

  if(isDefined(level.zombies_active_spawn_event)) {
    var_1 = var_1 + level.zombies_active_spawn_event;
  }

  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5.targetname) && var_5.targetname == var_1) {
      var_2[var_2.size] = var_5;
      continue;
    }

    if(!isDefined(var_5.targetname) || var_5.targetname == "") {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_2.size == 0) {
    if(var_3.size > 0) {
      var_2 = var_3;
    } else {
      var_2 = var_0;
    }
  }

  return var_2;
}

_id_908D(var_0, var_1) {
  var_2 = var_0.ground_origin;
  var_3 = var_1.ground_origin;
  var_4["allies"] = 0;
  var_4["axis"] = 0;

  foreach(var_6 in _id_448A()) {
    var_7 = undefined;
    var_8 = undefined;

    if(ispathdataavailable()) {
      var_7 = _getpathdist(var_6.origin, var_2, 999999);
      var_8 = _getpathdist(var_6.origin, var_3, 999999);
    }

    if(!isDefined(var_7) || var_7 == -1) {
      var_7 = distancesquared(var_2, var_6.origin);
    }

    if(!isDefined(var_8) || var_8 == -1) {
      var_8 = distancesquared(var_3, var_6.origin);
    }

    if(!isDefined(var_6._id_9849)) {
      _iprintlnbold("Side-Based Spawn Point not assigned to a side at ( " + var_6.origin[0] + ", " + var_6.origin[1] + ", " + var_6.origin[2] + " )");
      continue;
    }

    var_6._id_984B = var_4[var_6._id_9849];
    var_4[var_6._id_9849]++;

    if(var_6._id_9849 == "allies") {
      var_6._id_3ED1 = var_0;
      var_6._id_3ED2 = var_7;
      var_6._id_3767 = var_8;
    } else {
      var_6._id_3ED1 = var_1;
      var_6._id_3ED2 = var_8;
      var_6._id_3767 = var_7;
    }

    var_9 = var_6._id_3ED2 / var_6._id_3767;

    if(!isDefined(var_6._id_3ED1._id_4D3F) || var_6._id_3ED1._id_4D3F < var_9) {
      var_6._id_3ED1._id_4D3F = var_9;
    }

    if(!isDefined(var_6._id_3ED1._id_645F) || var_6._id_3ED1._id_645F == -1 || var_6._id_3767 < var_6._id_3ED1._id_645F) {
      var_6._id_3ED1._id_645F = var_6._id_3767;
    }
  }

  foreach(var_6 in _id_448A()) {
    var_6._id_984A = var_4[var_6._id_9849];
  }
}

ispathdataavailable() {
  if(!isDefined(level.pathdataavailable)) {
    var_0 = _getallnodes();
    level.pathdataavailable = isDefined(var_0) && var_0.size > 150;
  }

  return level.pathdataavailable;
}

_id_09FA() {
  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for(var_0 = 1; var_1 < level.participants.size - 1; var_1++) {
        level.participants[var_1] = level.participants[var_1 + 1];
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

spawnpointupdate() {
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(isDefined(level._id_A259) && level._id_A259) {
    return;
  }
  while(!isDefined(level._id_8FDC) && (!isDefined(level._id_9307) || !isDefined(level._id_9307["allies"]))) {
    waitframe();
  }

  if(getdvarint("5234", 0) == 1) {}

  var_0 = [];

  if(isDefined(level._id_8FDC)) {
    if(level.spawnpoints.size == 0) {
      common_scripts\utility::error("Cannot generate visibility data. No Spawnpoints found.");
    }

    for(var_1 = 0; var_1 < level.spawnpoints.size; var_1++) {
      for(var_2 = 0; var_2 < level.spawnpoints[var_1]._id_78CC.size; var_2++) {
        var_0[var_0.size] = level.spawnpoints[var_1]._id_78CC[var_2];
      }
    }
  }

  if(var_0.size > 0 || maps\mp\_utility::_id_579B()) {
    _func_305(var_0, level._id_9036["LOSDistance"]);
  } else if(isDefined(level._id_8FDC)) {
    var_3 = "Cannot generate visibility data. There are no '" + level._id_8FDC + "' pathnodes near any spawnpoints.";

    foreach(var_5 in var_0) {
      var_3 = var_3 + ("\nNode at " + var_5.origin);
    }

    var_3 = var_3 + "\nMake sure you compile with Connect Paths checked";
    common_scripts\utility::error(var_3);

    if(getdvarint("5234", 0) != 0) {
      _func_308(-1);
    }
  }
}

_id_4402() {
  var_0 = maps/_mg_penetration();

  foreach(var_2 in var_0) {
    var_2.spawnlogicteam = _func_2D5(var_2);
  }

  return var_0;
}

_id_A167() {
  level.spawnviewers = _id_4402();

  foreach(var_1 in level.spawnviewers) {
    var_1._id_90B6 = undefined;
  }

  foreach(var_4 in level.turrets) {
    var_4.spawnlogicteam = _func_2D5(var_4);
    level.spawnviewers[level.spawnviewers.size] = var_4;
    var_4._id_90B6 = undefined;
  }

  foreach(var_7 in level.ugvs) {
    var_7.spawnlogicteam = _func_2D5(var_7);
    level.spawnviewers[level.spawnviewers.size] = var_7;
    var_7._id_90B6 = undefined;
  }
}

shouldsighttracewait(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.participants) {
    if(!_func_2ED(var_4)) {
      var_2++;
    }
  }

  if(var_1 + var_2 > var_0) {
    return 1;
  }

  return 0;
}

_id_5351(var_0) {
  clearspawnpointsightdata(var_0);
}

clearspawnpointsightdata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      clearteamspawnpointsightdata(var_0, var_2);
    }
  } else
    clearteamspawnpointsightdata(var_0, "none");
}

clearteamspawnpointsightdata(var_0, var_1) {
  var_0.fullsights[var_1] = 0;
  var_0._id_266E[var_1] = 0;
  var_0.logspawndisabled[var_1] = 0;
  var_0._id_6221[var_1] = 1.0;
}

finalizespawnpointchoice(var_0) {
  var_1 = gettime();
  self.lastspawnpoint = var_0;
  self._id_5BE2 = var_1;
  var_0._id_5BE2 = var_1;
  var_0.lastspawnteam = self.team;
  var_2["position"] = var_0.origin;
  var_2["time"] = var_1;

  if(level.teambased) {
    level._id_7AD4[self.team][level._id_7AD4[self.team].size] = var_2;
  } else {
    var_2["player"] = self.guid;
    level._id_7AD4["all"][level._id_7AD4["all"].size] = var_2;
  }
}

expandspawnpointbounds(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.spawnmins = expandmins(level.spawnmins, var_0[var_1].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_0[var_1].origin);
  }
}

expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] > var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] > var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] < var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] < var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

setmapcenterfordev() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  expandspawnpointbounds(_setstartspawnpoints("mp_tdm_spawn_allies_start", "allies"));
  expandspawnpointbounds(_setstartspawnpoints("mp_tdm_spawn_axis_start", "axis"));
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  _func_300();
  _setmapcenter(level.mapcenter);
}

_id_463E(var_0) {
  var_1 = [];
  var_2 = _getclosestnodeinsight(var_0);

  if(isDefined(var_2)) {
    var_1[0] = var_2;
  }

  if(!isDefined(var_2)) {
    var_1 = _getnodesinradius(var_0, _id_445F(), 0, 256, "path");

    if(var_1.size == 0) {
      var_1 = _getnodesinradius(var_0, 250, 0, 256, "path");
    }
  }

  return var_1;
}

_id_3892(var_0, var_1) {
  var_2 = _id_04D1::getenemyteam(var_1);
  clearteamspawnpointsightdata(var_0, var_2);
  var_3 = undefined;
  var_4 = _id_580F();
  var_5 = getdvarfloat("scr_lowerLimitFullSights");
  var_6 = getdvarfloat("scr_lowerLimitCornerSights");

  foreach(var_8 in level.spawnviewers) {
    if(isDefined(level.valid_spawn_viewer) && ![[level.valid_spawn_viewer]](var_8)) {
      continue;
    }
    if(level.teambased && var_8.spawnlogicteam != var_2) {
      continue;
    }
    if(var_0.fullsights[var_8.spawnlogicteam]) {
      break;
    }

    if(!isDefined(var_8._id_90B6)) {
      var_8._id_90B6 = var_8 set_talking_currently(_id_44D5());

      if(!isDefined(var_8._id_90B6) || var_8._id_90B6.size == 0) {
        if(isDefined(level._id_602F) && var_4 && isPlayer(var_8)) {
          if(!isDefined(var_8.lastpathnodewarningtime) || var_8.lastpathnodewarningtime != gettime()) {
            [[level._id_602F]]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_8.name);
            var_8.lastpathnodewarningtime = gettime();
          }
        }
      }
    }

    var_9 = [];

    if(var_4 && isDefined(var_8._id_90B6) && var_8._id_90B6.size > 0) {
      var_9 = _func_303(var_8._id_90B6, var_0._id_78CC);

      if(isDefined(var_9)) {
        var_3 = var_9[0];
      }
    }

    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    if(!isDefined(var_0._id_6221[var_8.spawnlogicteam]) || var_3 < var_0._id_6221[var_8.spawnlogicteam]) {
      var_0._id_6221[var_8.spawnlogicteam] = var_3;
    }

    if(var_3 > var_5) {
      var_0.fullsights[var_8.spawnlogicteam]++;
      var_0.logspawndisabled[var_8.spawnlogicteam]++;
      continue;
    }

    if(var_3 > var_6) {
      var_0._id_266E[var_8.spawnlogicteam]++;
    }
  }
}

_id_445F() {
  return 130;
}

_id_44D5() {
  return 250;
}

_id_4576() {
  return 2550;
}

_id_580F() {
  return _func_304();
}