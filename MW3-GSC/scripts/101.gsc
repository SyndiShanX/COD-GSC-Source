/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\101.gsc
**************************************/

_id_133D(var_0) {
  common_scripts\utility::flag_init("player_looks_away_from_spawner");
  common_scripts\utility::flag_init("friendly_spawner_locked");
  level._id_133E = [];
  level._id_133E["axis"] = [];
  level._id_133E["allies"] = [];
  level._id_133F = [];
  level._id_133F["axis"] = [];
  level._id_133F["allies"] = [];
  var_1 = [];
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_multiple", "code_classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_radius", "code_classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_once", "code_classname"));
  level._id_1340 = [];
  level._id_1340["allies"] = "allies";
  level._id_1340["axis"] = "axis";
  level._id_1340["team3"] = "axis";
  level._id_1340["neutral"] = "neutral";
  var_2 = getEntArray("info_volume", "code_classname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_1341)) {
      var_4 _id_1395(var_4._id_1341, "allies");

    }
    if(isDefined(var_4._id_1342)) {
      var_4 _id_1395(var_4._id_1342, "axis");
    }
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_7._id_1341)) {
      var_7 _id_1394(var_7._id_1341, "allies");

    }
    if(isDefined(var_7._id_1342)) {
      var_7 _id_1394(var_7._id_1342, "axis");
    }
  }

  foreach(var_10 in var_1) {
    if(isDefined(var_10._id_1341)) {
      var_10 thread _id_1357(var_10._id_1341, "allies");

    }
    if(isDefined(var_10._id_1342)) {
      var_10 thread _id_1357(var_10._id_1342, "axis");
    }
  }

  level._id_1343 = [];
  _id_1399("BAD NODE");
  _id_1399("Cover Stand");
  _id_1399("Cover Crouch");
  _id_1399("Cover Prone");
  _id_1399("Cover Crouch Window");
  _id_1399("Cover Right");
  _id_1399("Cover Left");
  _id_1399("Cover Wide Left");
  _id_1399("Cover Wide Right");
  _id_1399("Conceal Stand");
  _id_1399("Conceal Crouch");
  _id_1399("Conceal Prone");
  _id_1399("Reacquire");
  _id_1399("Balcony");
  _id_1399("Scripted");
  _id_1399("Begin");
  _id_1399("End");
  _id_1399("Turret");
  _id_139A("Ambush");
  _id_139A("Guard");
  _id_139A("Path");
  _id_139A("Exposed");
  level._id_1344 = [];
  level._id_1344[level._id_1344.size] = "r";
  level._id_1344[level._id_1344.size] = "b";
  level._id_1344[level._id_1344.size] = "y";
  level._id_1344[level._id_1344.size] = "c";
  level._id_1344[level._id_1344.size] = "g";
  level._id_1344[level._id_1344.size] = "p";
  level._id_1344[level._id_1344.size] = "o";
  level._id_1345["red"] = "r";
  level._id_1345["r"] = "r";
  level._id_1345["blue"] = "b";
  level._id_1345["b"] = "b";
  level._id_1345["yellow"] = "y";
  level._id_1345["y"] = "y";
  level._id_1345["cyan"] = "c";
  level._id_1345["c"] = "c";
  level._id_1345["green"] = "g";
  level._id_1345["g"] = "g";
  level._id_1345["purple"] = "p";
  level._id_1345["p"] = "p";
  level._id_1345["orange"] = "o";
  level._id_1345["o"] = "o";
  level._id_1346 = [];
  level._id_1346["allies"] = [];
  level._id_1346["axis"] = [];
  level._id_1347 = [];
  level._id_1347["allies"] = [];
  level._id_1347["axis"] = [];

  foreach(var_13 in level._id_1344) {
    level._id_1348["allies"][var_13] = [];
    level._id_1348["axis"][var_13] = [];
    level._id_1346["allies"][var_13] = undefined;
    level._id_1346["axis"][var_13] = undefined;
  }

  thread _id_1373();
  var_15 = getspawnerteamarray("allies");
  level._id_1349 = [];

  foreach(var_17 in var_15) {}
  level._id_1349[var_17.classname] = var_17;
}

_id_134A() {
  self._id_134B = level._id_1345[self._id_134B];
}

_id_134C(var_0) {
  if(isDefined(self._id_134B)) {
    _id_134A();
    self._id_134D = var_0;
    var_1 = self._id_134B;
    level._id_1348[_id_13B5()][var_1] = maps\_utility::_id_0BC3(level._id_1348[_id_13B5()][var_1], self);
    thread _id_134E();
    return;
  }
}

_id_134E() {
  if(!isDefined(self._id_134D)) {
    return;
  }
  var_0 = level._id_133E[_id_13B5()][self._id_134D];
  _id_1396();

  if(!isalive(self)) {
    return;
  }
  if(!maps\_utility::_id_134F()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 = level._id_133F[_id_13B5()][self._id_134D];
    _id_1370(var_1, self._id_134D);
    return;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(isalive(var_3._id_1350) && !isplayer(var_3._id_1350)) {
      continue;
    }
    thread _id_1379(var_3);
    thread _id_1392(var_3);
    return;
  }

  _id_1351();
}

_id_1351() {}

_id_1352() {
  var_0 = [];
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "c";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "o";
  return var_0;
}

_id_1353(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1[var_3] = 1;

  var_5 = [];

  foreach(var_8, var_7 in var_1) {}
  var_5[var_5.size] = var_8;

  return var_5;
}

_id_1354(var_0, var_1) {
  return _id_1355(var_0, var_1);
}

_id_1355(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = _id_1353(var_2);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = _id_1352();

  foreach(var_8 in var_2) {
    var_9 = undefined;

    foreach(var_9 in var_6) {
      if(issubstr(var_8, var_9)) {
        break;
      }
    }

    if(!_id_1356(var_1, var_8)) {
      continue;
    }
    var_4[var_9] = var_8;
    var_3[var_3.size] = var_9;
    var_5[var_5.size] = var_8;
  }

  var_2 = var_5;
  var_13 = [];
  var_13["colorCodes"] = var_2;
  var_13["colorCodesByColorIndex"] = var_4;
  var_13["colors"] = var_3;
  return var_13;
}

_id_1356(var_0, var_1) {
  if(isDefined(level._id_133E[var_0][var_1])) {
    return 1;

  }
  return isDefined(level._id_133F[var_0][var_1]);
}

_id_1357(var_0, var_1) {
  var_2 = _id_1354(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  var_0 = undefined;
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self._id_1358)) {
      self._id_1358 = undefined;
      continue;
    }

    _id_135E(var_3, var_5, var_1, var_4);

    if(isDefined(self._id_1359) && self._id_1359) {
      thread _id_135A();
    }
  }
}

_id_135A() {
  var_0 = [];

  for(var_1 = self; isDefined(var_1); var_1 = getent(var_1.targetname, "target")) {
    var_0[var_0.size] = var_1;

    if(!isDefined(var_1.targetname)) {
      break;
    }
  }

  maps\_utility::_id_135B(var_0);
}

_id_135C(var_0) {
  if(var_0 == "allies") {
    thread _id_135D(self._id_1341, var_0);
  } else {
    thread _id_135D(self._id_1342, var_0);
  }
}

_id_135D(var_0, var_1) {
  var_2 = _id_1354(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  _id_135E(var_3, var_5, var_1, var_4);
}

_id_135E(var_0, var_1, var_2, var_3) {
  return _id_135F(var_0, var_1, var_2, var_3);
}

_id_135F(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level._id_1360[var_2][var_0[var_4]])) {
      continue;
    }
    level._id_1360[var_2][var_0[var_4]] = common_scripts\utility::array_removeundefined(level._id_1360[var_2][var_0[var_4]]);

    for(var_5 = 0; var_5 < level._id_1360[var_2][var_0[var_4]].size; var_5++) {
      level._id_1360[var_2][var_0[var_4]][var_5]._id_134D = var_0[var_4];
    }
  }

  foreach(var_7 in var_1) {
    level._id_1348[var_2][var_7] = maps\_utility::_id_1361(level._id_1348[var_2][var_7]);
    level._id_1347[var_2][var_7] = level._id_1346[var_2][var_7];
    level._id_1346[var_2][var_7] = var_3[var_7];
  }

  var_11 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(_id_1363(var_2, var_1[var_4])) {
      continue;
    }
    var_12 = var_0[var_4];

    if(!isDefined(level._id_1362[var_2][var_12])) {
      continue;
    }
    var_11[var_12] = _id_136F(var_12, var_1[var_4], var_2);
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_12 = var_0[var_4];

    if(!isDefined(var_11[var_12])) {
      continue;
    }
    if(_id_1363(var_2, var_1[var_4])) {
      continue;
    }
    if(!isDefined(level._id_1362[var_2][var_12])) {
      continue;
    }
    _id_1371(var_12, var_1[var_4], var_2, var_11[var_12]);
  }
}

_id_1363(var_0, var_1) {
  if(!isDefined(level._id_1347[var_0][var_1])) {
    return 0;

  }
  return level._id_1347[var_0][var_1] == level._id_1346[var_0][var_1];
}

_id_1364(var_0, var_1) {
  if(issubstr(var_0._id_1341, var_1)) {
    self._id_1365[self._id_1365.size] = var_0;
  } else {
    self._id_1366[self._id_1366.size] = var_0;
  }
}

_id_1367(var_0, var_1) {
  if(issubstr(var_0._id_1342, var_1)) {
    self._id_1365[self._id_1365.size] = var_0;
  } else {
    self._id_1366[self._id_1366.size] = var_0;
  }
}

_id_1368(var_0, var_1) {
  self._id_1366[self._id_1366.size] = var_0;
}

_id_1369(var_0, var_1) {
  self._id_136A[self._id_136A.size] = var_0;
}

_id_136B(var_0, var_1, var_2) {
  var_3 = level._id_133E[var_0][var_1];
  var_4 = spawnStruct();
  var_4._id_136A = [];
  var_4._id_1366 = [];
  var_4._id_1365 = [];
  var_5 = isDefined(level._id_1347[var_0][var_2]);

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_4[[level._id_1343[var_7.type][var_5][var_0]]](var_7, level._id_1347[var_0][var_2]);
  }

  var_4._id_1366 = maps\_utility::_id_0B53(var_4._id_1366);
  var_8 = [];
  var_3 = [];

  foreach(var_10, var_7 in var_4._id_1366) {
    if(isDefined(var_7._id_136C)) {
      var_8[var_8.size] = var_7;
      var_3[var_10] = undefined;
      continue;
    }

    var_3[var_3.size] = var_7;
  }

  for(var_6 = 0; var_6 < var_4._id_1365.size; var_6++) {
    var_3[var_3.size] = var_4._id_1365[var_6];

  }
  for(var_6 = 0; var_6 < var_4._id_136A.size; var_6++) {
    var_3[var_3.size] = var_4._id_136A[var_6];

  }
  foreach(var_7 in var_8) {}
  var_3[var_3.size] = var_7;

  level._id_133E[var_0][var_1] = var_3;
}

_id_136D(var_0, var_1, var_2) {
  return level._id_133E[var_0][var_1];
}

_id_136E(var_0, var_1) {
  return level._id_133F[var_0][var_1];
}

_id_136F(var_0, var_1, var_2) {
  level._id_1362[var_2][var_0] = maps\_utility::_id_1361(level._id_1362[var_2][var_0]);
  var_3 = level._id_1362[var_2][var_0];
  var_3 = common_scripts\utility::array_combine(var_3, level._id_1348[var_2][var_1]);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6._id_134D) && var_6._id_134D == var_0) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  var_3 = var_4;

  if(!var_3.size) {
    return;
  }
  common_scripts\utility::array_thread(var_3, ::_id_1396);
  return var_3;
}

_id_1370(var_0, var_1) {
  self notify("stop_color_move");
  self._id_134D = var_1;

  if(isDefined(var_0.target)) {
    var_2 = getnode(var_0.target, "targetname");

    if(isDefined(var_2)) {
      self setgoalnode(var_2);
    }
  }

  self.fixednode = 0;
  self setgoalvolumeauto(var_0);
}

_id_1371(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_5 = [];

  if(isDefined(level._id_133E[var_2][var_0])) {
    _id_136B(var_2, var_0, var_1);
    var_5 = _id_136D(var_2, var_0, var_1);
  } else {
    var_6 = _id_136E(var_2, var_0);
    common_scripts\utility::array_thread(var_3, ::_id_1370, var_6, var_0);
  }

  var_7 = 0;
  var_8 = var_3.size;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = var_5[var_9];

    if(isalive(var_10._id_1350)) {
      continue;
    }
    var_11 = maps\_utility::_id_0AE9(var_10.origin, var_3);
    var_3 = common_scripts\utility::array_remove(var_3, var_11);
    var_11 _id_1372(var_10, var_0, self, var_7);
    var_7++;

    if(!var_3.size) {
      return;
    }
  }
}

_id_1372(var_0, var_1, var_2, var_3) {
  self notify("stop_color_move");
  self._id_134D = var_1;
  thread _id_138A(var_0, var_2, var_3);
}

_id_1373() {
  for(;;) {
    var_0 = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var_1 = level.player.node._id_1350;
    var_0 = level.player.node;
    var_0._id_1350 = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != var_0) {
        break;
      }

      wait 0.05;
    }

    var_0._id_1350 = undefined;
    var_0 _id_1374();
  }
}

_id_1374() {
  if(isDefined(self._id_1341)) {
    _id_1375(self._id_1341, "allies");

  }
  if(isDefined(self._id_1342)) {
    _id_1375(self._id_1342, "axis");
  }
}

_id_1375(var_0, var_1) {
  if(isDefined(self._id_1350)) {
    return;
  }
  var_2 = strtok(var_0, " ");
  var_2 = _id_1353(var_2);
  common_scripts\utility::array_levelthread(var_2, ::_id_1376, var_1);
}

_id_1376(var_0, var_1) {
  var_2 = var_0[0];

  if(!isDefined(level._id_1346[var_1][var_2])) {
    return;
  }
  if(level._id_1346[var_1][var_2] != var_0) {
    return;
  }
  var_3 = maps\_utility::_id_1377(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 _id_1378(var_0)) {
      continue;
    }
    var_5 _id_1372(self, var_0);
    return;
  }
}

_id_1378(var_0) {
  if(!isDefined(self._id_134D)) {
    return 0;

  }
  return self._id_134D == var_0;
}

_id_1379(var_0) {
  self endon("death");
  var_1 = _id_1389();

  if(var_1) {
    self endon("stop_color_move");
    wait(var_1);
  }

  thread _id_137A(var_0);
}

_id_137A(var_0) {
  self notify("stop_going_to_node");
  _id_137C(var_0);
  var_1 = level._id_133F[_id_13B5()][self._id_134D];

  if(isDefined(self._id_137B)) {
    thread _id_1384(var_0, var_1);
  }
}

_id_137C(var_0) {
  if(isDefined(self._id_137D)) {
    self thread[[self._id_137D]](var_0);

  }
  if(isDefined(self._id_137E)) {
    thread maps\_anim::_id_1252(self, self._id_137E);
    self._id_137E = undefined;
  }

  if(isDefined(self._id_137F)) {
    self thread[[self._id_137F]](var_0);
  } else {
    self setgoalnode(var_0);

  }
  if(_id_1381(var_0)) {
    thread _id_1383(var_0);
  } else if(var_0.radius > 0) {
    self.goalradius = var_0.radius;

  }
  var_1 = level._id_133F[_id_13B5()][self._id_134D];

  if(isDefined(var_1)) {
    self setfixednodesafevolume(var_1);
  } else {
    self clearfixednodesafevolume();

  }
  if(isDefined(var_0.fixednodesaferadius)) {
    self.fixednodesaferadius = var_0.fixednodesaferadius;
  } else if(isDefined(level._id_1380)) {
    self.fixednodesaferadius = level._id_1380;
  } else {
    self.fixednodesaferadius = 64;
  }
}

_id_1381(var_0) {
  if(!isDefined(self._id_1382)) {
    return 0;

  }
  if(!self._id_1382) {
    return 0;

  }
  if(!isDefined(var_0.fixednodesaferadius)) {
    return 0;

  }
  if(self.fixednode) {
    return 0;
  } else {
    return 1;
  }
}

_id_1383(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = var_0.fixednodesaferadius;
  common_scripts\utility::waittill_either("goal", "damage");

  if(var_0.radius > 0) {
    self.goalradius = var_0.radius;
  }
}

_id_1384(var_0, var_1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread _id_1385(var_0);

  for(;;) {
    _id_1388(var_0, var_1);
    _id_1386(var_0, var_1);
    self.fixednode = 1;
    _id_137C(var_0);
  }
}

_id_1385(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  _id_137C(var_0);
}

_id_1386(var_0, var_1) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(var_1)) {
    for(;;) {
      wait 1;

      if(self isknownenemyinradius(var_0.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self isknownenemyinvolume(var_1)) {
        continue;
      }
      return;
    }
  } else {
    for(;;) {
      if(!_id_1387(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

_id_1387(var_0, var_1) {
  var_2 = getaiarray("axis");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2d(var_2[var_3].origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

_id_1388(var_0, var_1) {
  if(isDefined(var_1)) {
    for(;;) {
      if(self isknownenemyinradius(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self isknownenemyinvolume(var_1)) {
        return;
      }
      wait 1;
    }
  } else {
    for(;;) {
      if(_id_1387(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

_id_1389() {
  if(!isDefined(self.node)) {
    return 0;

  }
  return self.node maps\_utility::script_delay();
}

_id_138A(var_0, var_1, var_2) {
  thread _id_1392(var_0);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(var_1)) {
    var_1 maps\_utility::script_delay();

  }
  if(!_id_1389()) {
    if(isDefined(var_2)) {
      wait(var_2 * randomfloatrange(0.2, 0.35));
    }
  }

  _id_137A(var_0);
  self._id_138B = var_0;

  for(;;) {
    self waittill("node_taken", var_3);

    if(isplayer(var_3)) {
      wait 0.05;

    }
    var_0 = _id_138E();

    if(isDefined(var_0)) {
      if(isalive(self._id_138C._id_1350) && self._id_138C._id_1350 == self) {
        self._id_138C._id_1350 = undefined;

      }
      self._id_138C = var_0;
      var_0._id_1350 = self;
      _id_137A(var_0);
    }
  }
}

_id_138D() {
  var_0 = level._id_1346[_id_13B5()][self._id_134B];
  var_1 = _id_136D(_id_13B5(), var_0, self._id_134B);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2]._id_1350)) {
      return var_1[var_2];
    }
  }
}

_id_138E() {
  var_0 = level._id_1346[_id_13B5()][self._id_134B];
  var_1 = _id_136D(_id_13B5(), var_0, self._id_134B);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self._id_138C) {
      continue;
    }
    if(!isalive(var_1[var_2]._id_1350)) {
      return var_1[var_2];
    }
  }
}

_id_138F(var_0) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }
  if(distance(var_0.origin, self.origin) < 32) {
    _id_1391(var_0);
    return;
  }

  var_1 = gettime();
  _id_1390(1);
  var_2 = gettime();

  if(var_2 - var_1 >= 1000) {
    _id_1391(var_0);
  }
}

_id_1390(var_0) {
  self endon("killanimscript");
  wait(var_0);
}

_id_1391(var_0) {
  var_1 = getaiarray();
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isDefined(var_1[var_3].node)) {
      continue;
    }
    if(var_1[var_3].node != var_0) {
      continue;
    }
    var_1[var_3] notify("eject_from_my_node");
    wait 1;
    self notify("eject_from_my_node");
    return 1;
  }

  return 0;
}

_id_1392(var_0) {
  var_0._id_1350 = self;
  self._id_138C = var_0;
  self endon("stop_color_move");
  self waittill("death");
  self._id_138C._id_1350 = undefined;
}

_id_1393(var_0) {
  for(var_1 = 0; var_1 < level._id_1344.size; var_1++) {
    if(var_0 == level._id_1344[var_1]) {
      return 1;
    }
  }

  return 0;
}

_id_1394(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = _id_1353(var_2);

  foreach(var_4 in var_2) {
    level._id_133F[var_1][var_4] = self;
    level._id_1362[var_1][var_4] = [];
    level._id_1360[var_1][var_4] = [];
  }
}

_id_1395(var_0, var_1) {
  self._id_1350 = undefined;
  var_2 = strtok(var_0, " ");
  var_2 = _id_1353(var_2);

  foreach(var_4 in var_2) {
    if(isDefined(level._id_133E[var_1]) && isDefined(level._id_133E[var_1][var_4])) {
      level._id_133E[var_1][var_4] = maps\_utility::_id_0BC3(level._id_133E[var_1][var_4], self);
      continue;
    }

    level._id_133E[var_1][var_4][0] = self;
    level._id_1362[var_1][var_4] = [];
    level._id_1360[var_1][var_4] = [];
  }
}

_id_1396() {
  if(!isDefined(self._id_138C)) {
    return;
  }
  if(isDefined(self._id_138C._id_1350) && self._id_138C._id_1350 == self) {
    self._id_138C._id_1350 = undefined;

  }
  self._id_138C = undefined;
  self notify("stop_color_move");
}

_id_1397() {
  var_0 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self._id_1342;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self._id_1341;
  }

  if(!isDefined(var_0["colorTeam"])) {
    var_0 = undefined;

  }
  return var_0;
}

_id_1398() {
  var_0 = _id_1397();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0["team"];
  var_2 = var_0["colorTeam"];
  var_3 = strtok(var_2, " ");
  var_3 = _id_1353(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    level._id_1360[var_1][var_3[var_4]] = common_scripts\utility::array_remove(level._id_1360[var_1][var_3[var_4]], self);
  }
}

_id_1399(var_0) {
  level._id_1343[var_0][1]["allies"] = ::_id_1364;
  level._id_1343[var_0][1]["axis"] = ::_id_1367;
  level._id_1343[var_0][0]["allies"] = ::_id_1368;
  level._id_1343[var_0][0]["axis"] = ::_id_1368;
}

_id_139A(var_0) {
  level._id_1343[var_0][1]["allies"] = ::_id_1369;
  level._id_1343[var_0][0]["allies"] = ::_id_1369;
  level._id_1343[var_0][1]["axis"] = ::_id_1369;
  level._id_1343[var_0][0]["axis"] = ::_id_1369;
}

_id_139B(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = _id_13AE(var_0, var_1);

  if(isDefined(level._id_139C)) {
    var_2 thread[[level._id_139C]]();

  }
  var_2 thread _id_139D();
}

_id_139D() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isDefined(self._id_139E)) {
    return;
  }
  self._id_139E = 1;
  var_0 = self.classname;
  var_1 = self._id_134B;
  waittillframeend;

  if(isalive(self)) {
    self waittill("death");

  }
  var_2 = level._id_139F;

  if(!isDefined(self._id_134B)) {
    return;
  }
  thread _id_139B(var_0, self._id_134B);

  if(isDefined(self) && isDefined(self._id_134B)) {
    var_1 = self._id_134B;

  }
  if(isDefined(self) && isDefined(self.origin)) {
    var_3 = self.origin;

  }
  for(;;) {
    if(_id_13A6(var_1, var_2) == "none") {
      return;
    }
    var_4 = maps\_utility::_id_1377("allies", var_2[var_1]);

    if(!isDefined(level._id_13A0)) {
      var_4 = maps\_utility::_id_13A1(var_4);

    }
    if(!isDefined(level._id_13A2)) {
      var_4 = maps\_utility::_id_13A3(var_4, var_0);

    }
    if(!var_4.size) {
      wait 2;
      continue;
    }

    var_5 = maps\_utility::_id_0AE9(level.player.origin, var_4);
    waittillframeend;

    if(!isalive(var_5)) {
      continue;
    }
    var_5 maps\_utility::_id_13A4(var_1);

    if(isDefined(level._id_13A5)) {
      var_5[[level._id_13A5]](var_1);

    }
    var_1 = var_2[var_1];
  }
}

_id_13A6(var_0, var_1) {
  if(!isDefined(var_0)) {
    return "none";

  }
  if(!isDefined(var_1)) {
    return "none";

  }
  if(!isDefined(var_1[var_0])) {
    return "none";

  }
  return var_1[var_0];
}

_id_13A7() {
  level._id_13A8 = 1;
  var_0 = 0;

  for(;;) {
    for(;;) {
      if(!_id_13AB()) {
        break;
      }

      wait 0.05;
    }

    wait 1;

    if(!isDefined(level._id_13A9)) {
      continue;
    }
    var_1 = level.player.origin - level._id_13A9;

    if(length(var_1) < 200) {
      _id_13B2();
      continue;
    }

    var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var_3 = vectornormalize(var_1);
    var_4 = vectordot(var_2, var_3);

    if(var_4 < 0.2) {
      _id_13B2();
      continue;
    }

    var_0++;

    if(var_0 < 3) {
      continue;
    }
    common_scripts\utility::flag_set("player_looks_away_from_spawner");
  }
}

_id_13AA(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level._id_1349[var_0])) {
      var_1 = getspawnerteamarray("allies");

      foreach(var_3 in var_1) {
        if(var_3.classname != var_0) {
          continue;
        }
        level._id_1349[var_0] = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_3 = common_scripts\utility::random(level._id_1349);

    if(!isDefined(var_3)) {
      var_1 = [];

      foreach(var_6, var_3 in level._id_1349) {
        if(isDefined(var_3)) {
          var_1[var_6] = var_3;
        }
      }

      level._id_1349 = var_1;
      return common_scripts\utility::random(level._id_1349);
    }

    return var_3;
  }

  return level._id_1349[var_0];
}

_id_13AB() {
  if(isDefined(level._id_13AC)) {
    return 0;

  }
  return common_scripts\utility::flag("respawn_friendlies");
}

_id_13AD() {
  if(common_scripts\utility::flag("player_looks_away_from_spawner")) {
    return;
  }
  level endon("player_looks_away_from_spawner");

  for(;;) {
    if(_id_13AB()) {
      return;
    }
    wait 0.05;
  }
}

_id_13AE(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = undefined;

  for(;;) {
    if(!_id_13AB()) {
      if(!isDefined(level._id_13A8)) {
        thread _id_13A7();

      }
      for(;;) {
        _id_13AD();
        common_scripts\utility::flag_waitopen("friendly_spawner_locked");

        if(common_scripts\utility::flag("player_looks_away_from_spawner") || _id_13AB()) {
          break;
        }
      }

      common_scripts\utility::flag_set("friendly_spawner_locked");
    }

    var_3 = _id_13AA(var_0);
    var_3.count = 1;
    var_4 = var_3.origin;
    var_3.origin = level._id_13A9;
    var_2 = var_3 stalingradspawn();
    var_3.origin = var_4;

    if(maps\_utility::_id_13AF(var_2)) {
      thread _id_13B0();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var_2);
    break;
  }

  for(;;) {
    if(!isDefined(var_1)) {
      break;
    }

    if(_id_13A6(var_1, level._id_139F) == "none") {
      break;
    }

    var_1 = level._id_139F[var_1];
  }

  if(isDefined(var_1)) {
    var_2 maps\_utility::_id_13A4(var_1);

  }
  thread _id_13B0();
  return var_2;
}

_id_13B0() {
  common_scripts\utility::flag_set("friendly_spawner_locked");

  if(isDefined(level._id_13B1)) {
    [[level._id_13B1]]();
  } else {
    wait 2;

  }
  common_scripts\utility::flag_clear("friendly_spawner_locked");
}

_id_13B2() {
  var_0 = 0;
  common_scripts\utility::flag_clear("player_looks_away_from_spawner");
}

_id_13B3() {
  common_scripts\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var_0 = getaiarray();
  common_scripts\utility::array_thread(var_0, ::_id_13B4);
}

_id_13B4() {
  self._id_139E = undefined;
}

_id_13B5(var_0) {
  if(isDefined(self.team) && !isDefined(var_0)) {
    var_0 = self.team;

  }
  return level._id_1340[var_0];
}