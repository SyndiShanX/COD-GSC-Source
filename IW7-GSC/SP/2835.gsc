/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2835.gsc
**************************************/

init_colors() {
  if(!scripts\engine\utility::add_init_script("colors", ::init_colors)) {
    return;
  }
  scripts\engine\utility::flag_init("respawn_friendlies");
}

_id_957E() {
  var_0 = getallnodes();
  scripts\engine\utility::flag_init("player_looks_away_from_spawner");
  scripts\engine\utility::flag_init("friendly_spawner_locked");
  level._id_22DD = [];
  level._id_22DD["axis"] = [];
  level._id_22DD["allies"] = [];
  level._id_22DF = [];
  level._id_22DF["axis"] = [];
  level._id_22DF["allies"] = [];
  var_1 = [];
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_multiple", "code_classname"));
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_radius", "code_classname"));
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_once", "code_classname"));
  level._id_43A0 = [];
  level._id_43A0["allies"] = "allies";
  level._id_43A0["axis"] = "axis";
  level._id_43A0["team3"] = "axis";
  level._id_43A0["neutral"] = "neutral";
  var_2 = getEntArray("info_volume", "code_classname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_ED33))
      var_4 _id_171E(var_4._id_ED33, "allies");

    if(isDefined(var_4._id_ED34))
      var_4 _id_171E(var_4._id_ED34, "axis");
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_7._id_ED33))
      var_7 _id_178C(var_7._id_ED33, "allies");

    if(isDefined(var_7._id_ED34))
      var_7 _id_178C(var_7._id_ED34, "axis");
  }

  foreach(var_10 in var_1) {
    if(isDefined(var_10._id_ED33))
      var_10 thread _id_12757(var_10._id_ED33, "allies");

    if(isDefined(var_10._id_ED34))
      var_10 thread _id_12757(var_10._id_ED34, "axis");
  }

  level._id_439B = [];
  _id_16B5("BAD NODE");
  _id_16B5("Cover Stand");
  _id_16B5("Cover Crouch");
  _id_16B5("Cover Prone");
  _id_16B5("Cover Crouch Window");
  _id_16B5("Cover Right");
  _id_16B5("Cover Left");
  _id_16B5("Cover Wide Left");
  _id_16B5("Cover Wide Right");
  _id_16B5("Conceal Stand");
  _id_16B5("Conceal Crouch");
  _id_16B5("Conceal Prone");
  _id_16B5("Reacquire");
  _id_16B5("Balcony");
  _id_16B5("Scripted");
  _id_16B5("Begin");
  _id_16B5("End");
  _id_16B5("Turret");
  _id_1729("Ambush");
  _id_1729("Guard");
  _id_1729("Path");
  _id_1729("Path 3D");
  _id_1729("Exposed");
  _id_1729("Exposed 3D");
  _id_1729("Cover 3D");
  _id_1729("Cover Stand 3D");
  _id_16B5("Begin 3D");
  _id_16B5("End 3D");
  level._id_43A8 = [];
  level._id_43A8[level._id_43A8.size] = "r";
  level._id_43A8[level._id_43A8.size] = "b";
  level._id_43A8[level._id_43A8.size] = "y";
  level._id_43A8[level._id_43A8.size] = "c";
  level._id_43A8[level._id_43A8.size] = "g";
  level._id_43A8[level._id_43A8.size] = "p";
  level._id_43A8[level._id_43A8.size] = "o";
  level._id_43A3["red"] = "r";
  level._id_43A3["r"] = "r";
  level._id_43A3["blue"] = "b";
  level._id_43A3["b"] = "b";
  level._id_43A3["yellow"] = "y";
  level._id_43A3["y"] = "y";
  level._id_43A3["cyan"] = "c";
  level._id_43A3["c"] = "c";
  level._id_43A3["green"] = "g";
  level._id_43A3["g"] = "g";
  level._id_43A3["purple"] = "p";
  level._id_43A3["p"] = "p";
  level._id_43A3["orange"] = "o";
  level._id_43A3["o"] = "o";
  level._id_4BE0 = [];
  level._id_4BE0["allies"] = [];
  level._id_4BE0["axis"] = [];
  level._id_A95D = [];
  level._id_A95D["allies"] = [];
  level._id_A95D["axis"] = [];

  foreach(var_13 in level._id_43A8) {
    level._id_22E0["allies"][var_13] = [];
    level._id_22E0["axis"][var_13] = [];
    level._id_4BE0["allies"][var_13] = undefined;
    level._id_4BE0["axis"][var_13] = undefined;
  }

  thread _id_CFD2();
  var_15 = getspawnerteamarray("allies");
  level._id_11AE = [];

  foreach(var_17 in var_15)
  level._id_11AE[var_17.classname] = var_17;
}

_id_45ED() {
  self._id_EDAD = level._id_43A3[self._id_EDAD];
}

_id_19CE(var_0) {
  if(isDefined(self._id_EDAD)) {
    _id_45ED();
    self._id_4BDF = var_0;
    var_1 = self._id_EDAD;
    level._id_22E0[_id_7CE4()][var_1] = scripts\engine\utility::array_add(level._id_22E0[_id_7CE4()][var_1], self);
    thread _id_8467();
    return;
  }
}

_id_8467() {
  if(!isDefined(self._id_4BDF)) {
    return;
  }
  var_0 = level._id_22DD[_id_7CE4()][self._id_4BDF];
  _id_AB3A();

  if(!isalive(self)) {
    return;
  }
  if(!scripts\sp\utility::_id_8B6C()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 = level._id_22DF[_id_7CE4()][self._id_4BDF];
    _id_F21B(var_1, self._id_4BDF);
    return;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(isalive(var_3._id_43A2) && !isPlayer(var_3._id_43A2)) {
      continue;
    }
    thread _id_19E1(var_3);
    thread decrementcolorusers(var_3);
    return;
  }

  _id_C002();
}

_id_C002() {}

_id_78D2() {
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

_id_22AE(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3] = 1;

  var_5 = [];

  foreach(var_8, var_7 in var_1)
  var_5[var_5.size] = var_8;

  return var_5;
}

_id_78D9(var_0, var_1) {
  return _id_78D7(var_0, var_1);
}

_id_78D7(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = _id_22AE(var_2);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = _id_78D2();

  foreach(var_8 in var_2) {
    var_9 = undefined;

    foreach(var_9 in var_6) {
      if(issubstr(var_8, var_9)) {
        break;
      }
    }

    if(!_id_43A4(var_1, var_8)) {
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

_id_43A4(var_0, var_1) {
  if(isDefined(level._id_22DD[var_0][var_1]))
    return 1;

  return isDefined(level._id_22DF[var_0][var_1]);
}

_id_12757(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    _id_78D8(var_0, var_1);

    if(isDefined(self._id_EE6C) && self._id_EE6C)
      thread _id_12732();
  }
}

_id_12732() {
  var_0 = [];
  var_1[0] = self;

  while(var_1.size) {
    var_2 = [];

    foreach(var_4 in var_1) {
      var_0[var_0.size] = var_4;

      if(!isDefined(var_4.targetname)) {
        continue;
      }
      var_5 = getEntArray(var_4.targetname, "target");

      foreach(var_7 in var_5)
      var_2[var_2.size] = var_7;

      var_5 = undefined;
    }

    var_1 = [];

    foreach(var_11 in var_2) {
      if(!isDefined(var_11._id_ED33) && !isDefined(var_11._id_ED34)) {
        continue;
      }
      var_1[var_1.size] = var_11;
    }
  }

  scripts\sp\utility::_id_228A(var_0);
}

_id_159B(var_0) {
  if(var_0 == "allies")
    thread _id_78D8(self._id_ED33, var_0);
  else
    thread _id_78D8(self._id_ED34, var_0);
}

_id_78D8(var_0, var_1) {
  var_2 = _id_78D9(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  _id_159A(var_3, var_5, var_1, var_4);
}

_id_159A(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level._id_22DE[var_2][var_0[var_4]])) {
      continue;
    }
    level._id_22DE[var_2][var_0[var_4]] = scripts\engine\utility::array_removeundefined(level._id_22DE[var_2][var_0[var_4]]);

    for(var_5 = 0; var_5 < level._id_22DE[var_2][var_0[var_4]].size; var_5++)
      level._id_22DE[var_2][var_0[var_4]][var_5]._id_4BDF = var_0[var_4];
  }

  foreach(var_7 in var_1) {
    level._id_22E0[var_2][var_7] = scripts\sp\utility::_id_22B9(level._id_22E0[var_2][var_7]);
    level._id_A95D[var_2][var_7] = level._id_4BE0[var_2][var_7];
    level._id_4BE0[var_2][var_7] = var_3[var_7];
  }

  var_11 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(_id_EB12(var_2, var_1[var_4])) {
      continue;
    }
    var_12 = var_0[var_4];

    if(!isDefined(level._id_22DC[var_2][var_12])) {
      continue;
    }
    var_11[var_12] = _id_9F85(var_12, var_1[var_4], var_2);
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_12 = var_0[var_4];

    if(!isDefined(var_11[var_12])) {
      continue;
    }
    if(_id_EB12(var_2, var_1[var_4])) {
      continue;
    }
    if(!isDefined(level._id_22DC[var_2][var_12])) {
      continue;
    }
    _id_9F83(var_12, var_1[var_4], var_2, var_11[var_12]);
  }
}

_id_EB12(var_0, var_1) {
  if(!isDefined(level._id_A95D[var_0][var_1]))
    return 0;

  return level._id_A95D[var_0][var_1] == level._id_4BE0[var_0][var_1];
}

_id_D968(var_0, var_1) {
  if(issubstr(var_0._id_ED33, var_1))
    self._id_4709[self._id_4709.size] = var_0;
  else
    self._id_4708[self._id_4708.size] = var_0;
}

_id_D969(var_0, var_1) {
  if(issubstr(var_0._id_ED34, var_1))
    self._id_4709[self._id_4709.size] = var_0;
  else
    self._id_4708[self._id_4708.size] = var_0;
}

_id_D967(var_0, var_1) {
  self._id_4708[self._id_4708.size] = var_0;
}

_id_D982(var_0, var_1) {
  self._id_C961[self._id_C961.size] = var_0;
}

_id_D923(var_0, var_1, var_2) {
  var_3 = level._id_22DD[var_0][var_1];
  var_4 = spawnStruct();
  var_4._id_C961 = [];
  var_4._id_4708 = [];
  var_4._id_4709 = [];
  var_5 = isDefined(level._id_A95D[var_0][var_2]);

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_4[[level._id_439B[var_7.type][var_5][var_0]]](var_7, level._id_A95D[var_0][var_2]);
  }

  var_4._id_4708 = scripts\engine\utility::array_randomize(var_4._id_4708);
  var_8 = [];
  var_3 = [];

  foreach(var_10, var_7 in var_4._id_4708) {
    if(isDefined(var_7._id_ED38)) {
      var_8[var_8.size] = var_7;
      var_3[var_10] = undefined;
      continue;
    }

    var_3[var_3.size] = var_7;
  }

  for(var_6 = 0; var_6 < var_4._id_4709.size; var_6++)
    var_3[var_3.size] = var_4._id_4709[var_6];

  for(var_6 = 0; var_6 < var_4._id_C961.size; var_6++)
    var_3[var_3.size] = var_4._id_C961[var_6];

  foreach(var_7 in var_8)
  var_3[var_3.size] = var_7;

  level._id_22DD[var_0][var_1] = var_3;
}

_id_7BDA(var_0, var_1, var_2) {
  return level._id_22DD[var_0][var_1];
}

_id_78D6(var_0, var_1) {
  return level._id_22DF[var_0][var_1];
}

_id_9F85(var_0, var_1, var_2) {
  level._id_22DC[var_2][var_0] = scripts\sp\utility::_id_22B9(level._id_22DC[var_2][var_0]);
  var_3 = level._id_22DC[var_2][var_0];
  var_3 = scripts\engine\utility::array_combine(var_3, level._id_22E0[var_2][var_1]);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6._id_4BDF) && var_6._id_4BDF == var_0) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  var_3 = var_4;

  if(!var_3.size) {
    return;
  }
  scripts\engine\utility::array_thread(var_3, ::_id_AB3A);
  return var_3;
}

_id_F21B(var_0, var_1) {
  self notify("stop_color_move");
  self._id_4BDF = var_1;

  if(isDefined(var_0.target)) {
    var_2 = getnode(var_0.target, "targetname");

    if(isDefined(var_2))
      self _meth_82EE(var_2);
  }

  self.fixednode = 0;
  self _meth_82F1(var_0);
}

_id_9F83(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_5 = [];

  if(isDefined(level._id_22DD[var_2][var_0])) {
    _id_D923(var_2, var_0, var_1);
    var_5 = _id_7BDA(var_2, var_0, var_1);
  } else {
    var_6 = _id_78D6(var_2, var_0);
    scripts\engine\utility::array_thread(var_3, ::_id_F21B, var_6, var_0);
  }

  var_7 = 0;
  var_8 = var_3.size;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = var_5[var_9];

    if(isalive(var_10._id_43A2)) {
      continue;
    }
    var_11 = scripts\engine\utility::getclosest(var_10.origin, var_3);
    var_3 = scripts\engine\utility::array_remove(var_3, var_11);
    var_11 _id_1142E(var_10, var_0, self, var_7);
    var_7++;

    if(!var_3.size)
      return;
  }
}

_id_1142E(var_0, var_1, var_2, var_3) {
  self notify("stop_color_move");
  self._id_4BDF = var_1;
  thread _id_D966(var_0, var_2, var_3);
}

_id_CFD2() {
  for(;;) {
    var_0 = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var_1 = level.player.node._id_43A2;
    var_0 = level.player.node;
    var_0._id_43A2 = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != var_0) {
        break;
      }

      wait 0.05;
    }

    var_0._id_43A2 = undefined;
    var_0 _id_4398();
  }
}

_id_4398() {
  if(isDefined(self._id_ED33))
    _id_439A(self._id_ED33, "allies");

  if(isDefined(self._id_ED34))
    _id_439A(self._id_ED34, "axis");
}

_id_439A(var_0, var_1) {
  if(isDefined(self._id_43A2)) {
    return;
  }
  var_2 = strtok(var_0, " ");
  var_2 = _id_22AE(var_2);
  scripts\engine\utility::array_levelthread(var_2, ::_id_4399, var_1);
}

_id_4399(var_0, var_1) {
  var_2 = var_0[0];

  if(!isDefined(level._id_4BE0[var_1][var_2])) {
    return;
  }
  if(level._id_4BE0[var_1][var_2] != var_0) {
    return;
  }
  var_3 = scripts\sp\utility::_id_79C8(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 _id_C2D2(var_0)) {
      continue;
    }
    var_5 _id_1142E(self, var_0);
    return;
  }
}

_id_C2D2(var_0) {
  if(!isDefined(self._id_4BDF))
    return 0;

  return self._id_4BDF == var_0;
}

_id_19E1(var_0) {
  self endon("death");
  self endon("stop_color_move");
  _id_BE08();
  thread _id_19E0(var_0);
}

_id_19E0(var_0) {
  self notify("stop_going_to_node");
  _id_F3D2(var_0);
  var_1 = level._id_22DF[_id_7CE4()][self._id_4BDF];

  if(isDefined(self._id_ED27))
    thread _id_3A57(var_0, var_1);
}

_id_F3D2(var_0) {
  if(isDefined(self._id_43A9))
    self thread[[self._id_43A9]](var_0);

  if(isDefined(self._id_11B0)) {
    thread scripts\sp\anim::_id_1F32(self, self._id_11B0);
    self._id_11B0 = undefined;
  }

  if(isDefined(self._id_43AB))
    self thread[[self._id_43AB]](var_0);
  else
    self _meth_82EE(var_0);

  if(_id_9CFA(var_0))
    thread _id_72C8(var_0);
  else if(isDefined(var_0.radius) && var_0.radius > 0)
    self.goalradius = var_0.radius;

  var_1 = level._id_22DF[_id_7CE4()][self._id_4BDF];

  if(isDefined(var_1))
    self _meth_82E0(var_1);
  else
    self clearfixednodesafevolume();

  if(isDefined(var_0.fixednodesaferadius))
    self.fixednodesaferadius = var_0.fixednodesaferadius;
  else if(isDefined(level._id_6E02))
    self.fixednodesaferadius = level._id_6E02;
  else
    self.fixednodesaferadius = 64;
}

_id_9CFA(var_0) {
  if(!isDefined(self._id_EDB0))
    return 0;

  if(!self._id_EDB0)
    return 0;

  if(!isDefined(var_0.fixednodesaferadius))
    return 0;

  if(self.fixednode)
    return 0;
  else
    return 1;
}

_id_72C8(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = var_0.fixednodesaferadius;
  scripts\engine\utility::waittill_either("goal", "damage");

  if(isDefined(var_0.radius) && var_0.radius > 0)
    self.goalradius = var_0.radius;
}

_id_3A57(var_0, var_1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread _id_DDF9(var_0);

  for(;;) {
    _id_13689(var_0, var_1);
    _id_12FAD(var_0, var_1);
    self.fixednode = 1;
    _id_F3D2(var_0);
  }
}

_id_DDF9(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  _id_F3D2(var_0);
}

_id_12FAD(var_0, var_1) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(var_1)) {
    for(;;) {
      wait 1;

      if(self _meth_81A8(var_0.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self _meth_81A9(var_1)) {
        continue;
      }
      return;
    }
  } else {
    for(;;) {
      if(!_id_9E6E(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

_id_9E6E(var_0, var_1) {
  var_2 = getaiarray("axis");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2d(var_2[var_3].origin, var_0) < var_1)
      return 1;
  }

  return 0;
}

_id_13689(var_0, var_1) {
  if(isDefined(var_1)) {
    for(;;) {
      if(self _meth_81A8(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self _meth_81A9(var_1)) {
        return;
      }
      wait 1;
    }
  } else {
    for(;;) {
      if(_id_9E6E(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

_id_BE08() {
  if(!isDefined(self.node))
    return 0;

  if(isDefined(self._id_ED35)) {
    wait(self._id_ED35);
    return 1;
  }

  return self.node scripts\sp\utility::script_delay();
}

_id_D966(var_0, var_1, var_2) {
  thread decrementcolorusers(var_0);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(var_1))
    var_1 scripts\sp\utility::script_delay();

  if(!_id_BE08()) {
    if(isDefined(var_2))
      wait(var_2 * randomfloatrange(0.2, 0.35));
  }

  _id_19E0(var_0);
  self._id_439C = var_0;

  for(;;) {
    self waittill("node_taken", var_3);

    if(isPlayer(var_3))
      wait 0.05;

    var_0 = _id_7860();

    if(isDefined(var_0)) {
      if(isalive(self._id_4397._id_43A2) && self._id_4397._id_43A2 == self)
        self._id_4397._id_43A2 = undefined;

      self._id_4397 = var_0;
      var_0._id_43A2 = self;
      _id_19E0(var_0);
    }
  }
}

_id_785F() {
  var_0 = level._id_4BE0[_id_7CE4()][self._id_EDAD];
  var_1 = _id_7BDA(_id_7CE4(), var_0, self._id_EDAD);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2]._id_43A2))
      return var_1[var_2];
  }
}

_id_7860() {
  var_0 = level._id_4BE0[_id_7CE4()][self._id_EDAD];
  var_1 = _id_7BDA(_id_7CE4(), var_0, self._id_EDAD);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self._id_4397) {
      continue;
    }
    if(!isalive(var_1[var_2]._id_43A2))
      return var_1[var_2];
  }
}

_id_D987(var_0) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }
  if(distance(var_0.origin, self.origin) < 32) {
    _id_DD19(var_0);
    return;
  }

  var_1 = gettime();
  _id_135E3(1);
  var_2 = gettime();

  if(var_2 - var_1 >= 1000)
    _id_DD19(var_0);
}

_id_135E3(var_0) {
  self endon("killanimscript");
  wait(var_0);
}

_id_DD19(var_0) {
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

decrementcolorusers(var_0) {
  var_0._id_43A2 = self;
  self._id_4397 = var_0;
  self endon("stop_color_move");
  self waittill("death");
  self._id_4397._id_43A2 = undefined;
}

_id_43A7(var_0) {
  for(var_1 = 0; var_1 < level._id_43A8.size; var_1++) {
    if(var_0 == level._id_43A8[var_1])
      return 1;
  }

  return 0;
}

_id_178C(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = _id_22AE(var_2);

  foreach(var_4 in var_2) {
    level._id_22DF[var_1][var_4] = self;
    level._id_22DC[var_1][var_4] = [];
    level._id_22DE[var_1][var_4] = [];
  }
}

_id_171E(var_0, var_1) {
  self._id_43A2 = undefined;
  var_2 = strtok(var_0, " ");
  var_2 = _id_22AE(var_2);

  foreach(var_4 in var_2) {
    if(isDefined(level._id_22DD[var_1]) && isDefined(level._id_22DD[var_1][var_4])) {
      level._id_22DD[var_1][var_4] = scripts\engine\utility::array_add(level._id_22DD[var_1][var_4], self);
      continue;
    }

    level._id_22DD[var_1][var_4][0] = self;
    level._id_22DC[var_1][var_4] = [];
    level._id_22DE[var_1][var_4] = [];
  }
}

_id_AB3A() {
  if(!isDefined(self._id_4397)) {
    return;
  }
  if(isDefined(self._id_4397._id_43A2) && self._id_4397._id_43A2 == self)
    self._id_4397._id_43A2 = undefined;

  self._id_4397 = undefined;
  self notify("stop_color_move");
}

_id_7E3A() {
  var_0 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self._id_ED34;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self._id_ED33;
  }

  if(!isDefined(var_0["colorTeam"]))
    var_0 = undefined;

  return var_0;
}

_id_E16F() {
  var_0 = _id_7E3A();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0["team"];
  var_2 = var_0["colorTeam"];
  var_3 = strtok(var_2, " ");
  var_3 = _id_22AE(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    level._id_22DE[var_1][var_3[var_4]] = scripts\engine\utility::array_remove(level._id_22DE[var_1][var_3[var_4]], self);
}

_id_16B5(var_0) {
  level._id_439B[var_0][1]["allies"] = ::_id_D968;
  level._id_439B[var_0][1]["axis"] = ::_id_D969;
  level._id_439B[var_0][0]["allies"] = ::_id_D967;
  level._id_439B[var_0][0]["axis"] = ::_id_D967;
}

_id_1729(var_0) {
  level._id_439B[var_0][1]["allies"] = ::_id_D982;
  level._id_439B[var_0][0]["allies"] = ::_id_D982;
  level._id_439B[var_0][1]["axis"] = ::_id_D982;
  level._id_439B[var_0][0]["axis"] = ::_id_D982;
}

_id_43AC(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = _id_10735(var_0, var_1);

  if(isDefined(level._id_73F1))
    var_2 thread[[level._id_73F1]]();

  var_2 thread _id_43AA();
}

_id_43AA() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isDefined(self._id_E198)) {
    return;
  }
  self._id_E198 = 1;
  var_0 = self.classname;
  var_1 = self._id_EDAD;
  waittillframeend;

  if(isalive(self))
    self waittill("death");

  var_2 = level._id_4B58;

  if(!isDefined(self._id_EDAD)) {
    return;
  }
  thread _id_43AC(var_0, self._id_EDAD);

  if(isDefined(self) && isDefined(self._id_EDAD))
    var_1 = self._id_EDAD;

  if(isDefined(self) && isDefined(self.origin))
    var_3 = self.origin;

  for(;;) {
    if(_id_78CE(var_1, var_2) == "none") {
      return;
    }
    var_4 = scripts\sp\utility::_id_79C8("allies", var_2[var_1]);

    if(!isDefined(level._id_4392))
      var_4 = scripts\sp\utility::_id_E0AF(var_4, var_0);

    if(!var_4.size) {
      wait 2;
      continue;
    }

    var_5 = scripts\engine\utility::getclosest(level.player.origin, var_4);
    waittillframeend;

    if(!isalive(var_5)) {
      continue;
    }
    var_5 scripts\sp\utility::_id_F3B5(var_1);

    if(isDefined(level._id_73DF))
      var_5[[level._id_73DF]](var_1);

    var_1 = var_2[var_1];
  }
}

_id_78CE(var_0, var_1) {
  if(!isDefined(var_0))
    return "none";

  if(!isDefined(var_1))
    return "none";

  if(!isDefined(var_1[var_0]))
    return "none";

  return var_1[var_0];
}

_id_73E7() {
  level._id_73E1 = 1;
  var_0 = 0;

  for(;;) {
    for(;;) {
      if(!_id_E289()) {
        break;
      }

      wait 0.05;
    }

    wait 1;

    if(!isDefined(level.respawn_threshold)) {
      continue;
    }
    var_1 = level.player.origin - level.respawn_threshold;

    if(length(var_1) < 200) {
      _id_D286();
      continue;
    }

    var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var_3 = vectorNormalize(var_1);
    var_4 = vectordot(var_2, var_3);

    if(var_4 < 0.2) {
      _id_D286();
      continue;
    }

    var_0++;

    if(var_0 < 3) {
      continue;
    }
    scripts\engine\utility::flag_set("player_looks_away_from_spawner");
  }
}

_id_78D4(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level._id_11AE[var_0])) {
      var_1 = getspawnerteamarray("allies");

      foreach(var_3 in var_1) {
        if(var_3.classname != var_0) {
          continue;
        }
        level._id_11AE[var_0] = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_3 = scripts\engine\utility::random(level._id_11AE);

    if(!isDefined(var_3)) {
      var_1 = [];

      foreach(var_6, var_3 in level._id_11AE) {
        if(isDefined(var_3))
          var_1[var_6] = var_3;
      }

      level._id_11AE = var_1;
      return scripts\engine\utility::random(level._id_11AE);
    }

    return var_3;
  }

  return level._id_11AE[var_0];
}

_id_E289() {
  if(isDefined(level._id_E288))
    return 0;

  return scripts\engine\utility::flag("respawn_friendlies");
}

_id_13692() {
  if(scripts\engine\utility::flag("player_looks_away_from_spawner")) {
    return;
  }
  level endon("player_looks_away_from_spawner");

  for(;;) {
    if(_id_E289()) {
      return;
    }
    wait 0.05;
  }
}

_id_10735(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = undefined;

  for(;;) {
    if(!_id_E289()) {
      if(!isDefined(level._id_73E1))
        thread _id_73E7();

      for(;;) {
        _id_13692();
        scripts\engine\utility::flag_waitopen("friendly_spawner_locked");

        if(scripts\engine\utility::flag("player_looks_away_from_spawner") || _id_E289()) {
          break;
        }
      }

      scripts\engine\utility::flag_set("friendly_spawner_locked");
    }

    var_3 = _id_78D4(var_0);
    var_3.count = 1;
    var_4 = var_3.origin;
    var_3.origin = level.respawn_threshold;
    var_2 = var_3 _meth_8393();
    var_3.origin = var_4;

    if(scripts\sp\utility::_id_106ED(var_2)) {
      thread _id_AEE0();
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

    if(_id_78CE(var_1, level._id_4B58) == "none") {
      break;
    }

    var_1 = level._id_4B58[var_1];
  }

  if(isDefined(var_1))
    var_2 scripts\sp\utility::_id_F3B5(var_1);

  thread _id_AEE0();
  return var_2;
}

_id_AEE0() {
  scripts\engine\utility::flag_set("friendly_spawner_locked");

  if(isDefined(level._id_73E0))
    [[level._id_73E0]]();
  else
    wait 2;

  scripts\engine\utility::flag_clear("friendly_spawner_locked");
}

_id_D286() {
  var_0 = 0;
  scripts\engine\utility::flag_clear("player_looks_away_from_spawner");
}

_id_A5C7() {
  scripts\engine\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var_0 = getaiarray();
  scripts\engine\utility::array_thread(var_0, ::_id_E07E);
}

_id_E07E() {
  self._id_E198 = undefined;
}

_id_7CE4(var_0) {
  if(isDefined(self.team) && !isDefined(var_0))
    var_0 = self.team;

  return level._id_43A0[var_0];
}