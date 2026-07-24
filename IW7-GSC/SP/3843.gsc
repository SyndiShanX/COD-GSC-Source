/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3843.gsc
**************************************/

_id_43D8(var_0) {
  setdvarifuninitialized("combat_debug", 0);
  setdvarifuninitialized("sa_node_debug", 0);
  scripts\engine\utility::flag_init("combat_pause_spawning");
  scripts\engine\utility::flag_init("spawn_dir_ally_follow_enabled");
  level.allies = [];

  if(!isDefined(level._id_FD19)) {
    level waittill("ship_assault_start");
  }

  var_1 = getEntArray("spawn_director_rooms", "script_noteworthy");
  level._id_43EA = var_1;
  level._id_43EF = [];
  level._id_43EF["regular"] = getEnt("enemy_spawner_regular", "targetname");
  level._id_43EF["space"] = getEnt("enemy_spawner_space", "targetname");
  level._id_43EF["c6"] = getEnt("enemy_spawner_c6", "targetname");
  var_2 = scripts\engine\utility::getStructArray("reinforce_locations", "targetname");

  foreach(var_5, var_4 in var_1) {
    var_4.name = "room" + var_5;
  }

  var_6 = [];

  foreach(var_5, var_4 in var_1) {
    if(var_4 _id_C8ED("start")) {
      var_6[var_6.size] = var_4;
    }

    if(var_4 _id_C8ED("forward")) {
      var_4._id_10D86 = "forward";
    } else if(var_4 _id_C8ED("backward")) {
      var_4._id_10D86 = "backward";
    }

    if(var_4 _id_C8ED("spawn_priority")) {
      var_4._id_10901 = 1;

      if(isDefined(var_4.script_count_min)) {
        var_4._id_D927 = var_4.script_count_min;
      }
    }

    if(isDefined(var_4.lookahead)) {
      var_4._id_AFFE = var_4.lookahead;
    }

    var_4._id_13D76 = [];

    foreach(var_9 in level._id_2FA3["structs"]) {
      if(ispointinvolume(var_9.origin, var_4)) {
        var_4._id_13D76 = scripts\engine\utility::array_add(var_4._id_13D76, var_9);
      }
    }

    var_4._id_DF24 = [];

    foreach(var_12 in var_2) {
      if(!isDefined(var_4.script_linkname)) {
        break;
      }

      if(!isDefined(var_12._id_00F2) && isDefined(var_12.script_parameters)) {
        var_12._id_00F2 = var_12.script_parameters;
      }

      if(var_12.script_linkto == var_4.script_linkname) {
        var_4._id_DF24[var_4._id_DF24.size] = var_12;
      }
    }

    var_4.triggered = 0;
    var_4.path = [];
    var_4.path["forward"] = [];
    var_4.path["backward"] = [];
    var_4.path["all"] = [];
    var_14 = var_4 scripts\sp\utility::_id_7A8F();
    var_4._id_1AE3 = [];
    var_4._id_1AE3["all"] = [];
    var_4._id_1AE3["forward"] = [];
    var_4._id_1AE3["backward"] = [];
    var_15 = [];

    foreach(var_17 in var_14) {
      if(isDefined(var_17.script_noteworthy) && var_17.script_noteworthy == "airlock") {
        var_17 hide();
        var_17 notsolid();
        var_4._id_1AE3["all"] = ::scripts\engine\utility::array_add(var_4._id_1AE3["all"], var_17);
        continue;
      }

      if(var_17.classname == "info_volume") {
        if(isDefined(var_17.script_parameters)) {
          var_17._id_00F2 = var_17.script_parameters;
        }

        var_4._id_8437 = var_17;
        continue;
      }

      var_15 = scripts\engine\utility::array_add(var_15, var_17);
    }

    var_19 = var_4 _id_7A9B(var_1);
    var_4.path["forward"] = var_15;
    var_4.path["backward"] = var_19;
    var_4.path["all"] = ::scripts\engine\utility::array_combine(var_4.path["forward"], var_4.path["backward"]);
    var_4 _id_E6DC(var_4.path["all"]);
  }

  _id_E6E3(var_1);
  level._id_83D1 = [];
  level._id_117C1 = [];
  level._id_117C1["combat"] = spawnStruct();
  level._id_117C1["combat"]._id_B776 = 3;
  level._id_117C1["combat"]._id_B496 = 5;
  level._id_117C1["combat"] _id_F298("regular", 60);
  level._id_117C1["combat"] _id_F298("space", 30);
  level._id_117C1["combat"] _id_F298("c6", 10);
  level._id_117C1["combat"]._id_B487 = 5;
  level._id_117C1["combat"]._id_13BE4 = [2, 3];
  level._id_117C1["combat"]._id_13BDF = [25, 35];
  level._id_117C1["combat"]._id_12F94 = "normal";
  level._id_117C1["defend"] = spawnStruct();
  level._id_117C1["defend"]._id_B776 = 5;
  level._id_117C1["defend"]._id_B496 = 7;
  level._id_117C1["defend"] _id_F298("regular", 60);
  level._id_117C1["defend"] _id_F298("space", 30);
  level._id_117C1["defend"] _id_F298("c6", 10);
  level._id_117C1["defend"]._id_B487 = 0;
  level._id_117C1["defend"]._id_13BE4 = [3, 5];
  level._id_117C1["defend"]._id_13BDF = [0.5, 1];
  level._id_117C1["defend"]._id_12F94 = "high";
  level._id_117C1["escape"] = spawnStruct();
  level._id_117C1["escape"]._id_B776 = 5;
  level._id_117C1["escape"]._id_B496 = 5;
  level._id_117C1["escape"] _id_F298("regular", 60);
  level._id_117C1["escape"] _id_F298("space", 30);
  level._id_117C1["escape"] _id_F298("c6", 10);
  level._id_117C1["escape"]._id_B487 = 0;
  level._id_117C1["escape"]._id_13BE4 = [2, 3];
  level._id_117C1["escape"]._id_13BDF = [15, 25];
  level._id_117C1["escape"]._id_12F94 = "normal";
  level._id_4B5A = "combat";
  level._id_4BA7 = undefined;

  if(!isDefined(var_0) || var_0 == 0) {
    thread _id_43F3();
  }

  scripts\engine\utility::array_thread(level._id_43EA, ::_id_43E2);
  level._id_54E6 = ["forward", "backward"];
  level._id_43D1 = undefined;
  thread _id_43D2();
  thread _id_11395();
  level._id_54E2["forward"] = (0, 1, 0);
  level._id_54E2["backward"] = (1, 0, 0);
  thread _id_94B9();
}

_id_E6E3(var_0) {
  foreach(var_2 in var_0) {
    foreach(var_4 in var_2._id_1AE3["all"]) {
      foreach(var_6 in var_2.path["forward"]) {
        if(scripts\engine\utility::array_contains(var_6._id_1AE3["all"], var_4)) {
          var_2._id_1AE3["forward"] = ::scripts\engine\utility::array_add(var_2._id_1AE3["forward"], var_4);
        }
      }

      foreach(var_6 in var_2.path["backward"]) {
        if(scripts\engine\utility::array_contains(var_6._id_1AE3["all"], var_4)) {
          var_2._id_1AE3["backward"] = ::scripts\engine\utility::array_add(var_2._id_1AE3["backward"], var_4);
        }
      }
    }
  }
}

_id_F298(var_0, var_1) {
  if(!isDefined(self._id_1B0A)) {
    self._id_1B0A = [];
    self._id_1B0C = [];
    self._id_1B0B = 0;
  }

  self._id_1B0C[self._id_1B0C.size] = var_0;
  var_1 = var_1 + self._id_1B0B;
  self._id_1B0A[var_0] = [self._id_1B0B, var_1];
  self._id_1B0B = var_1;
}

_id_43E2() {
  level endon("combat_started");
  self waittill("trigger");
  var_0 = "forward";

  if(isDefined(self._id_10D86)) {
    var_0 = self._id_10D86;
  }

  level._id_43D1 = var_0;
  thread _id_4BA9(level._id_43D1);
  level notify("combat_started");
}

_id_4BA9(var_0, var_1) {
  level._id_4BA7 = self;
  level notify("new_room_triggered", var_0);
  level endon("new_room_triggered");

  foreach(var_3 in level._id_54E6) {
    foreach(var_5 in self.path[var_3]) {
      var_5 thread _id_BF58(var_3, self);
    }
  }

  if(isDefined(var_1)) {
    thread _id_E6D7(var_0, var_1);
  }
}

_id_BF58(var_0, var_1) {
  level endon("new_room_triggered");

  for(;;) {
    self waittill("trigger");

    if(!level.player istouching(var_1)) {
      break;
    }
  }

  thread _id_4BA9(var_0, var_1);
}

_id_E6D7(var_0, var_1) {
  scripts\engine\utility::waitframe();
  var_2 = [];

  foreach(var_4 in var_1.path[var_0]) {
    foreach(var_6 in self._id_1AE3["all"]) {
      if(!scripts\engine\utility::array_contains(var_1._id_1AE3[var_0], var_6)) {
        continue;
      }
      self._id_4A33 = 1;
      var_7 = var_6.origin;
      var_6.origin = var_6.origin - (0, 0, var_6.script_index);
      var_8 = createnavobstaclebyent(var_6, "axis");
      var_2[var_2.size] = var_8;
      var_6.origin = var_7;
      self._id_4A33 = undefined;
    }
  }

  level waittill("new_room_triggered");

  foreach(var_8 in var_2) {
    destroynavobstacle(var_8);
  }
}

_id_43D2() {
  level._id_4B65 = 0;

  for(;;) {
    level waittill("new_room_triggered", var_0);

    if(scripts\engine\utility::flag("defend_in_progress")) {
      continue;
    }
    if(var_0 != level._id_43D1) {
      level._id_4B65++;
    } else {
      level._id_4B65 = 0;
    }

    if(level._id_4B65 == 2) {
      level._id_43D1 = var_0;
      level._id_4B65 = 0;
    }

    if(var_0 == level._id_43D1) {
      level notify("new_combat_room");
    }
  }
}

_id_F302(var_0) {
  level._id_43D1 = var_0;
  level._id_4B65 = 0;
}

_id_11395() {
  for(;;) {
    scripts\engine\utility::flag_wait("defend_in_progress");
    var_0 = level._id_4B5A;
    level._id_4B5A = "defend";
    var_1 = level._id_4BC6._id_4D94._id_505E;
    _id_F302(var_1);
    level notify("system_hack_started");
    scripts\engine\utility::flag_waitopen("defend_in_progress");
    level._id_4B5A = var_0;
  }
}

_id_43F3() {
  level waittill("new_combat_room");

  for(;;) {
    wait 0.05;

    if(scripts\engine\utility::flag("combat_pause_spawning")) {
      continue;
    }
    var_0 = level._id_4BA7;
    var_1 = level._id_117C1[level._id_4B5A];
    _id_3D57(var_0);
    var_2 = getaicount("axis");
    var_3 = randomintrange(var_1._id_13BE4[0], var_1._id_13BE4[1]);

    if(var_2 + var_3 > var_1._id_B496) {
      var_3 = var_1._id_B496 - var_2;
    }

    var_4 = var_0 _id_7C1D(3);
    var_5 = _id_10430(var_4);
    var_6 = 0;

    foreach(var_8 in var_5) {
      if(scripts\engine\utility::flag("combat_pause_spawning")) {
        break;
      }

      if(!var_8.combat) {
        continue;
      }
      var_9 = 0;

      if(var_1._id_12F94 == "high" || var_8._id_AFFD == 0) {
        var_9 = 1;
      }

      var_10 = var_8 _id_106D5(var_3, var_9);

      if(!isDefined(var_10)) {
        break;
      }

      var_3 = var_3 - var_10;
      var_6 = var_6 + var_10;

      if(!var_3) {
        break;
      }
    }

    var_12 = getaicount("axis");

    if(var_12 < var_1._id_B496) {
      continue;
    }
    var_13 = randomfloatrange(var_1._id_13BDF[0], var_1._id_13BDF[1]);
    level scripts\engine\utility::waittill_any_timeout(var_13, "new_combat_room", "system_hack_started");
  }
}

_id_106D5(var_0, var_1) {
  level endon("combat_pause_spawning");
  var_2 = [];

  foreach(var_4 in self.path[level._id_43D1]) {
    if(!var_4.combat) {
      continue;
    }
    var_5 = scripts\engine\utility::array_randomize(var_4.nodes[self.name]);
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_7 = scripts\engine\utility::array_randomize(self.nodes[self._id_C052.name]);
  var_8 = 0;

  for(var_9 = 0; var_9 < var_0; var_9++) {
    if(!var_7.size) {
      break;
    }

    var_10 = level._id_117C1[level._id_4B5A] _id_77E4();

    if(var_1) {
      var_11 = level._id_43EF[var_10] _id_1078D(var_7, var_2, self._id_DF24);
    } else {
      var_11 = level._id_43EF[var_10] _id_1078E(var_7);
    }

    if(!isDefined(var_11)) {
      continue;
    }
    var_7 = scripts\engine\utility::array_remove(var_7, var_11.usingnvfx);
    var_11 thread _id_43C9(var_11.usingnvfx);
    var_8++;
  }

  return var_8;
}

_id_77E4() {
  var_0 = randomint(100);

  foreach(var_2 in self._id_1B0C) {
    if(var_0 >= self._id_1B0A[var_2][0] && var_0 < self._id_1B0A[var_2][1]) {
      return var_2;
    }
  }
}

_id_10430(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_10, var_4 in var_0) {
    foreach(var_6 in var_4) {
      var_6._id_AFFD = var_10;
      var_7 = 0;

      if(isDefined(var_6._id_10901)) {
        var_8 = var_6 scripts\sp\utility::_id_77E3("axis", "human");

        if(!isDefined(var_6._id_D927) || var_8.size < var_6._id_D927) {
          var_7 = 1;
        }
      }

      if(var_7) {
        var_1[var_1.size] = var_6;
        continue;
      }

      var_2[var_2.size] = var_6;
    }
  }

  var_11 = scripts\engine\utility::array_combine(var_1, var_2);
  return var_11;
}

_id_7C1D(var_0) {
  var_1 = [];
  var_2 = self.path[level._id_43D1];

  foreach(var_4 in self.path[level._id_43D1]) {
    var_4._id_C052 = self;
  }

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_1[var_6] = var_2;
    var_7 = [];

    foreach(var_9 in var_2) {
      foreach(var_4 in var_9.path[level._id_43D1]) {
        var_4._id_C052 = var_9;
      }

      var_7 = scripts\engine\utility::array_combine(var_7, var_9.path[level._id_43D1]);
    }

    var_2 = var_7;
  }

  return var_1;
}

_id_3D57(var_0) {
  var_1 = getaiarray("bad_guys");

  foreach(var_3 in var_1) {
    var_4 = var_3 _id_56EB(var_0);

    if(var_4 >= 4) {
      scripts\sp\utility::draw_circle(var_3.origin, 24, (1, 0, 0), 1, 0, 60);
      var_3 delete();
    }
  }
}

_id_56EB(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_43EA) {
    if(self istouching(var_3)) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    if(getdvarint("combat_debug")) {}

    var_1 = scripts\engine\utility::getclosest(self.origin, level._id_43EA);
  }

  if(var_1 == var_0) {
    return 0;
  }

  var_5 = 999;
  var_6 = var_0;

  foreach(var_8 in level._id_54E6) {
    var_9 = var_0.path[var_8];

    foreach(var_11 in var_9) {
      var_11._id_A9DF = var_0;
    }

    var_13 = 0;

    while(var_9.size) {
      var_13++;

      if(var_13 == 4) {
        break;
      }

      var_14 = [];

      foreach(var_11 in var_9) {
        if(var_1 == var_11 && var_13 < var_5) {
          var_5 = var_13;
        }

        foreach(var_17 in level._id_54E6) {
          var_18 = var_11.path[var_17];

          foreach(var_20 in var_18) {
            if(isDefined(var_11._id_A9DF) && var_20 == var_11._id_A9DF) {
              continue;
            }
            var_20._id_A9DF = var_11;
            var_14 = scripts\engine\utility::array_add(var_14, var_20);
          }
        }
      }

      var_9 = var_14;
      scripts\engine\utility::waitframe();
    }
  }

  return var_5;
}

_id_7B19(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_54E6) {
    var_4 = self.path[var_3];
    var_4 scripts\engine\utility::array_remove(var_4, var_0);
    var_1 = scripts\engine\utility::array_combine(var_4, var_4);
  }

  return var_1;
}

_id_1078E(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isnodeoccupied(var_4)) {
      continue;
    }
    if(isDefined(var_4._id_1083D)) {
      continue;
    }
    if(distancesquared(level.player.origin, var_4.origin) <= squared(600)) {
      continue;
    }
    var_2 = _id_43ED(var_4.origin, var_4.angles);

    if(isDefined(var_2)) {
      var_2.usingnvfx = var_4;
      var_4 thread _id_C03E();
      break;
    }
  }

  return var_2;
}

_id_1078D(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = [];

  foreach(var_6 in var_0) {
    if(isDefined(var_6._id_1083D)) {
      continue;
    }
    if(isnodeoccupied(var_6)) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  if(!var_4.size) {
    return var_3;
  }

  var_8 = scripts\engine\utility::random(var_4);
  var_1 = sortbydistance(var_1, var_8.origin);
  var_1 = scripts\engine\utility::array_combine(var_2, var_1);

  foreach(var_6 in var_1) {
    if(isnode(var_6) && isnodeoccupied(var_6)) {
      continue;
    }
    if(isDefined(var_6._id_1083D)) {
      continue;
    }
    var_3 = _id_43ED(var_6.origin, var_6.angles);

    if(isDefined(var_3)) {
      var_6 thread _id_C03E();
      break;
    }
  }

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_8 = scripts\engine\utility::random(var_4);
  var_3.usingnvfx = var_8;
  return var_3;
}

_id_43ED(var_0, var_1) {
  scripts\engine\utility::waitframe();
  var_0 = getclosestpointonnavmesh(var_0, level.player);
  self.origin = var_0;

  if(isDefined(var_1)) {
    self.angles = var_1;
  }

  self.count = 1;
  return scripts\sp\utility::_id_10619();
}

_id_43C9(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  self.goalradius = 64;
  self _meth_82EE(var_0);

  if(isDefined(var_0._id_8437)) {
    var_1 = var_0._id_8437;
    self _meth_82F0(var_1);

    if(isDefined(var_1._id_00F2)) {
      while(level._id_43D1 == var_1._id_00F2) {
        wait 0.1;
      }

      self cleargoalvolume();
    } else
      return;
  } else {
    self waittill("goal");
    wait 2.5;
  }

  self.goalradius = level._id_4FF6;
}

_id_C03E() {
  self._id_1083D = 1;
  wait 5;
  self._id_1083D = undefined;
}

_id_E6DC(var_0) {
  var_1 = getallnodes();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4.type == "Path") {
      continue;
    }
    if(!ispointinvolume(var_4.origin, self)) {
      continue;
    }
    if(isDefined(self._id_8437)) {
      var_4._id_8437 = self._id_8437;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  self.combat = 0;

  if(!var_2.size) {
    return;
  }
  self.combat = 1;
  self.nodes = var_2;

  foreach(var_7 in var_0) {
    self.nodes[var_7.name] = [];

    foreach(var_4 in var_2) {
      var_9 = vectorNormalize(var_4.origin - var_7.origin);
      var_10 = anglesToForward(var_4.angles);
      var_11 = cos(50);
      var_11 = var_11 * -1;
      var_12 = vectordot(var_9, var_10);
      var_4._id_1E7B = var_12;

      if(var_12 >= var_11) {
        continue;
      }
      self.nodes[var_7.name] = ::scripts\engine\utility::array_add(self.nodes[var_7.name], var_4);
    }

    self._id_B4C5[var_7.name] = self.nodes[var_7.name].size;
  }
}

_id_7A9B(var_0) {
  var_1 = [];

  if(!isDefined(self.script_linkname)) {
    return var_1;
  }

  var_2 = self.script_linkname;

  foreach(var_4 in var_0) {
    if(var_4 == self) {
      continue;
    }
    if(!isDefined(var_4.script_linkto)) {
      continue;
    }
    var_5 = strtok(var_4.script_linkto, " ");

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] == var_2) {
        var_1[var_1.size] = var_4;
      }
    }
  }

  return var_1;
}

_id_C8ED(var_0, var_1) {
  if(!isDefined(self.script_parameters)) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_parameters);

  if(!isDefined(var_1)) {
    if(var_2 == var_0) {
      return 1;
    }

    return 0;
  }

  var_3 = strtok(var_2, var_1);

  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_94B9() {
  var_0 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_0 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 250, -225);
  var_1 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_1 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 250, 0);
  var_1.y = var_0.y + 10;
  var_2 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_2 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 250, 0);
  var_2.y = var_1.y + 10;
  var_3 = scripts\sp\hud_util::createfontstring("objective", 1);
  var_3 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 250, 0);
  var_3.y = var_2.y + 10;
  var_4 = [var_0, var_1, var_2, var_3];
  level waittill("combat_started");

  for(;;) {
    wait 0.1;

    if(!getdvarint("combat_debug")) {
      foreach(var_6 in var_4) {
        var_6 settext("");
      }

      continue;
    }

    var_0 settext("ENEMY COUNT : " + getaicount("axis"));
    var_1 settext("SPAWN DIRECTION : " + level._id_43D1);
    var_2 settext("STATE : " + level._id_4B5A);
    var_8 = "ON";

    if(scripts\engine\utility::flag("combat_pause_spawning")) {
      var_8 = "OFF";
    }

    var_3 settext("STATUS : " + var_8);
  }
}

_id_E6D8() {
  for(;;) {
    if(!getdvarint("combat_debug")) {
      wait 0.1;
      continue;
    }

    self waittill("trigger");

    while(level.player istouching(self)) {
      wait 0.05;
      var_0 = ["forward", "backward"];

      foreach(var_2 in var_0) {
        var_3 = level._id_54E2[var_2];

        foreach(var_5 in self.path[var_2]) {
          if(!var_5.combat) {
            continue;
          }
          foreach(var_7 in var_5.nodes[self.name]) {}
        }
      }
    }
  }
}

_id_2187() {
  if(getDvar("loadout_chosen") != "1") {
    return;
  }
  level._id_CB2A = 0;
  level._id_2239 = 0;
  level._id_59AB = [];
  scripts\engine\utility::flag_init("armory_objective_complete");
  precacheshader("icon_ks_box_of_guns_hud");
  precacheitem("iw7_erad");
  precacheitem("iw7_devastator");
  setsaveddvar("r_hudoutlineEnable", 1);
  setsaveddvar("r_hudoutlineWidth", 2);
  level._id_10D4B = gettime();
  var_0 = 3;
  var_1 = ["iw7_ake", "iw7_erad", "iw7_devastator"];
  scripts\sp\utility::_id_22C7(getspawnerteamarray("bad_guys"), ::_id_832C, var_1);
  var_2 = getEntArray("armory_weapon_trigs", "targetname");
  var_3 = var_1.size;
  var_4 = 3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = 1;

    if(var_3 - var_7 < 0) {
      var_7 = var_3;
    }

    var_5[var_6] = var_7;
    var_3 = var_3 - var_7;
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);

  foreach(var_21, var_9 in var_2) {
    var_10 = scripts\engine\utility::getStructArray(var_9.target, "targetname");
    var_11 = [];

    foreach(var_13 in var_10) {
      if(isDefined(var_13.script_noteworthy) && var_13.script_noteworthy == "armory_weapons") {
        var_11[var_11.size] = var_13;
      }
    }

    var_9._id_13CD4 = var_11;
    var_15 = getEntArray(var_9.target, "targetname");

    foreach(var_17 in var_15) {
      if(var_17.classname == "script_model") {
        var_17.trigger = var_9;
      }
    }

    var_9._id_13C72 = var_5[var_21];

    for(var_6 = 0; var_6 < var_9._id_13C72; var_6++) {
      var_13 = spawnStruct();
      var_19 = randomint(var_1.size);
      var_13._id_13CFA = var_1[var_19];

      if(!isDefined(var_13.angles)) {
        var_13.angles = (0, 0, 0);
      }

      var_20 = scripts\engine\utility::random(var_9._id_13CD4);
      var_13.origin = var_20.origin;
      var_13.angles = var_20.angles;

      if(!isDefined(var_13.angles)) {
        var_13.angles = (0, 0, 0);
      }

      var_9._id_13CD4 = scripts\engine\utility::array_remove(var_9._id_13CD4, var_20);
      var_13 thread _id_13C5D(var_9);
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_19]);
    }
  }

  if(!isDefined(level._id_FD19)) {
    level waittill("ship_assault_start");
  }

  if(getdvarint("kleenex")) {
    thread _id_220E();
    wait 2.5;
  }

  var_22 = getEntArray("objective_armories", "script_noteworthy");

  foreach(var_24 in var_22) {
    if(!isDefined(var_24.classname) || var_24.classname != "script_model") {
      continue;
    }
    var_24.opened = 0;
    var_24._id_9026 = var_24 scripts\sp\utility::_id_7A97()[0];
    var_25 = var_24 scripts\sp\utility::_id_7A8E();
    var_24.clip = var_24 scripts\sp\utility::_id_7A8E();
    var_24.clip linkTo(var_24);
    var_26 = var_24._id_9026 _id_2210();
    level._id_59AB = scripts\engine\utility::array_add(level._id_59AB, var_24);
    var_24 thread _id_2188(var_26);
  }

  wait 2;
  level notify("armory_setup_complete");
}

_id_220E() {
  wait 0.75;
  scripts\sp\utility::_id_10350("sa2_destroyer_eth_quickmissiongra");
  wait 1;
  scripts\sp\utility::_id_10350("sa2_destroyer_eth_getthesuppliesf");
  level waittill("armory_setup_complete");
}

_id_13C5D(var_0) {
  var_1 = spawn("weapon_" + self._id_13CFA, self.origin, 1);
  var_1.angles = self.angles;
  var_1 hudoutlineenable(2, 1, 0);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_noteworthy)) {
    _id_F302(var_0.script_noteworthy);
  }

  while(isDefined(var_1)) {
    wait 0.05;
  }

  level.player givemaxammo(self._id_13CFA);
  var_0._id_13C72--;
  level._id_CB2A++;
  scripts\sp\utility::_id_2669("");

  if(level._id_CB2A == 3) {
    thread _id_6A4C();
    return;
  }

  var_2 = 3 - level._id_CB2A;
}

_id_2188(var_0) {
  var_1 = self._id_9026 scripts\engine\utility::spawn_tag_origin();
  thread _id_2186(var_1, var_0);
  self._id_9026 _id_0E46::_id_48C4();
  self._id_9026 waittill("trigger", var_2);
  self.opened = 1;
  self rotateYaw(-135, 2);
  playworldsound("loot_metal_door_open", self.origin);
  level._id_2239++;

  for(;;) {
    if(level.player istouching(self.trigger)) {
      scripts\engine\utility::flag_set("combat_pause_spawning");

      while(level.player istouching(self.trigger)) {
        wait 0.1;
      }

      scripts\engine\utility::flag_clear("combat_pause_spawning");
    }

    wait 0.1;
  }
}

_id_2210() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\sp\hud_util::createicon("icon_ks_box_of_guns_hud", 120, 120);
  var_1 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -200);
  var_1.alpha = 0;
  var_1 fadeovertime(0.2);
  var_1.alpha = 1;

  if(getdvarint("kleenex")) {
    var_2 = level.player _meth_840B(var_0.origin, 65);

    if(isDefined(var_2)) {
      var_2 = var_2 + (0, -20, 0);
      var_1 moveovertime(1);
      var_1.x = var_2[0];
      var_1.y = var_2[1];
    }

    var_1 scaleovertime(1, 40, 40);
    wait 1;
    level.player thread scripts\sp\utility::play_sound_on_entity("support_drone_targeting");
  }

  var_1 setshader("icon_ks_box_of_guns_hud", 1, 1);
  var_1 setwaypoint(1, 1, 0);
  var_1 settargetEnt(var_0);
  return var_1;
}

_id_2186(var_0, var_1) {
  level waittill("armory_setup_complete");
  var_2 = self._id_9026;
  var_3 = undefined;
  var_4 = 5128;
  var_5 = var_4 / 2;
  var_6 = 0.08;
  var_7 = distance(level.player.origin, var_0.origin);
  var_8 = var_7 / var_4;
  var_9 = 1 - var_8;
  var_1.alpha = 1;
  var_1 fadeovertime(0.2);
  var_1.alpha = var_9;
  wait 0.2;

  while(!self.opened || self.trigger._id_13C72) {
    wait 0.05;

    if(level._id_CB2A == 3) {
      break;
    }

    var_10 = var_2._id_4C1D;

    if(isDefined(var_10)) {
      if(var_10.icon["circle"]._id_1012F || var_10.icon["button"]._id_1012F) {
        var_1.alpha = 0;
        continue;
      }
    }

    if(scripts\engine\utility::flag("defend_in_progress")) {
      var_1.alpha = 0;
      scripts\engine\utility::flag_waitopen("defend_in_progress");
    }

    if(level.player istouching(self.trigger)) {
      var_1.alpha = 0;
      continue;
    }

    var_7 = distance(level.player.origin, var_0.origin);

    if(isDefined(var_10)) {
      if(!var_10.icon["circle"]._id_1012F && !var_10.icon["button"]._id_1012F) {
        if(level._id_59AB.size > 1) {
          var_3 = scripts\engine\utility::getclosest(level.player.origin, level._id_59AB);
        } else {
          var_3 = self;
        }

        if(var_3 == self) {
          var_1.alpha = 1;
          continue;
        }

        var_11 = 1 - scripts\sp\math::_id_C097(0, var_5, var_7);
        var_1.alpha = max(var_6, var_11);
      }
    }
  }

  level._id_59AB = scripts\engine\utility::array_remove(level._id_59AB, self);
  var_1 destroy();
}

_id_832C(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::string_starts_with(self.weapon, var_2)) {
      scripts\sp\utility::_id_72EC("iw7_ar57", "primary");
    }
  }
}

_id_6A4C() {
  thread scripts\sp\utility::_id_10350("sa2_destroyer_eth_yougotallthearm");
  level._id_4B5A = "escape";
  var_0 = getEntArray("end_extraction", "targetname");

  foreach(var_3, var_2 in var_0) {
    var_2 thread _id_6A4D(var_3);
  }
}

_id_6A4D(var_0) {
  objective_add(var_0, "current", "", self.origin);
  objective_setpointertextoverride(var_0, "EXTRACTION");
  self waittill("trigger");
  scripts\sp\utility::_id_BF95();
}

_id_1D21(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = scripts\engine\utility::getStruct(var_3, "targetname");
  } else {
    var_5 = scripts\engine\utility::getStruct(var_0 + "_start_" + level._id_10CDA, "targetname");
  }

  var_4.origin = var_5.origin;
  var_4.angles = var_5.angles;

  if(isDefined(var_1) && var_1 == 1) {
    var_4 scripts\sp\utility::_id_1747(::_id_1CEB);
  }

  var_6 = var_4 scripts\sp\utility::_id_10619(1, 1);

  if(isDefined(var_2)) {
    var_6._id_1FBB = var_2;
  } else {
    var_6._id_1FBB = var_0;
  }

  level.allies = scripts\engine\utility::array_add(level.allies, var_6);
}

_id_1CEB() {
  level.player endon("death");
  self endon("death");
  self endon("disable_ally_follow");
  scripts\sp\utility::_id_F39E();
  scripts\sp\utility::_id_54F7();
  var_0 = level.allies.size;
  var_1 = undefined;
  var_2 = max(256, 128 * var_0);
  thread _id_1D1A(var_2);

  for(;;) {
    if(_id_0F16::_id_9C7F() == 0) {
      var_3 = getnodesinradius(level.player.origin, var_2, 96, 64, "Cover");

      if(var_3.size > 0) {
        var_3 = scripts\engine\utility::array_randomize(var_3);

        for(var_4 = 0; var_4 < var_3.size; var_4++) {
          if(!isnodeoccupied(var_3[var_4])) {
            var_1 = scripts\sp\utility::_id_78AA(self.origin, "axis");

            if(isDefined(var_1)) {
              if(var_3[var_4] _id_9C3C(var_1)) {
                thread _id_1CE3(var_1, var_3[var_4]);
                break;
              }
            } else
              break;
          }
        }

        self.goalradius = 64;

        if(isDefined(var_3[var_4])) {
          self _meth_82EE(var_3[var_4]);
          self waittill("goal");
        } else
          self _meth_80E3();

        scripts\engine\utility::waittill_any("player_out_of_range", "node_heading_invalid");
        wait(randomfloatrange(0.05, 1));
      }

      scripts\engine\utility::waitframe();
    } else
      _id_0F16::_id_13652();

    var_3 = undefined;
    var_1 = undefined;
  }
}

_id_5500() {
  self notify("disable_ally_follow");
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_61C7();
}

_id_61D4() {
  self notify("disable_ally_follow");
  thread _id_1CEB();
}

_id_228E(var_0) {
  foreach(var_2 in var_0) {
    var_2 notify("disable_ally_follow");
    var_2 thread _id_1CEB();
  }
}

_id_228C(var_0) {
  foreach(var_2 in var_0) {
    var_2 notify("disable_ally_follow");
    var_2 scripts\sp\utility::_id_F39F();
    var_2 scripts\sp\utility::_id_61C7();
  }
}

_id_9C3C(var_0) {
  var_1 = vectorNormalize(var_0.origin - self.origin);
  var_2 = anglesToForward(self.angles);
  var_3 = cos(70);
  var_4 = vectordot(var_1, var_2);
  return var_4 >= var_3;
}

_id_1D1A(var_0) {
  self endon("death");
  self endon("disable_ally_follow");

  for(;;) {
    level.player scripts\sp\utility::_id_1376D(self, var_0);
    self notify("player_out_of_range");
    scripts\engine\utility::waitframe();
  }
}

_id_1CE3(var_0, var_1) {
  self endon("death");
  self endon("disable_ally_follow");
  self endon("player_out_of_range");

  while(var_1 _id_9C3C(var_0) && isalive(var_0)) {
    wait 1;
  }

  self notify("node_heading_invalid");
}

_id_9761() {
  level._id_10AD9 = getEntArray("trig_squad_spawn", "targetname");

  foreach(var_1 in level._id_10AD9) {
    var_1._id_869F = getEntArray(var_1.target, "targetname");
    var_1._id_DD75 = scripts\sp\utility::_id_7A8F();

    foreach(var_3 in var_1._id_869F) {
      var_3.spawners = getEntArray(var_3.target, "targetname");
    }

    var_1._id_DD73 = gettime();
    scripts\engine\utility::array_thread(var_1._id_869F, ::_id_10AD8);
    scripts\engine\utility::array_thread(var_1._id_DD75, ::_id_10AD8, var_1);
    var_1 thread _id_10AD7();
  }
}

_id_10AD7() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0) || gettime() < self._id_DD73) {
      wait(max(0.05, (self._id_DD73 - gettime()) / 1000.0));
      continue;
    }

    self._id_869F = scripts\engine\utility::array_randomize(self._id_869F);

    foreach(var_2 in self._id_869F) {
      if(gettime() < var_2._id_DD73) {
        continue;
      }
      var_2._id_DD73 = _id_93C6(undefined, 1.5);
      scripts\sp\utility::_id_22CD(var_2.target, 1);
      break;
    }

    wait 0.05;
  }
}

_id_10AD8(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(!isDefined(var_0._id_DD73)) {
    var_0._id_DD73 = gettime();
  }

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      var_0._id_DD73 = _id_93C6();
      wait 0.25;
    }

    wait 0.05;
  }
}

_id_93C6(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 15;
  }

  if(isDefined(var_1)) {
    var_0 = var_0 * var_1;
  }

  return gettime() + var_0 * 1000.0;
}