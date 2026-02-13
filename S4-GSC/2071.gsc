/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2071.gsc
*************************************************/

init() {
  level._id_E2F4 = spawnStruct();

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level._id_8DE7 = 0;
  } else {
    level._id_8DE7 = 4000;
  }

  level._id_5E7F = 0;
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  level._id_A796 = 0;
  level._id_A795 = 0;
  level.players = [];
  level._id_B78E = [];
  level._id_AE7C = [];
  level.characters = [];
  level._id_E348 = [];
  level._id_7177 = [];
  level._id_9F7E = [];
  level._id_326E = [];
  level._id_77D9 = [];
  level._id_F897 = [];
  level._id_EE46 = [];
  level._id_CC5A = [];
  level._id_F906 = [];
  level._id_B704 = [];
  level._id_E2F4._id_98C3 = getdvarfloat("#x3d0e64cbb5aa8e6b6");
  level._id_E2F4._id_98C2 = getdvarfloat("#x3ba8a644607dda232");
  level._id_E2F4._id_90A0 = [];
  level._id_E2F4._id_8F98 = [];
  level._id_E2F4._id_7E95 = [];
  level._id_E2F4._id_E37C = [];
  level._id_E2F4._id_0F5F = [];
  level._id_E2F4._id_E37B = [];
  level._id_E2F4._id_E34E = [];
  setdvarifuninitialized("#x386b12880a7d57d13", 0);
  level thread _id_E351();
  level thread _id_F405();
  level thread _id_F426();
  level thread _id_F407();
  level thread _id_F3F5();
  thread _id_BD22();
  level thread _id_9793();

  for(var_0 = 0; var_0 < level._id_EF89.size; var_0++) {
    level._id_EFAB[level._id_EF89[var_0]] = [];
    level._id_EF70[level._id_EF89[var_0]] = [];
  }

  _id_0816::_id_80B6();
  _id_96A8();
  var_1 = getEntArray("trigger_multiple_mp_spawn_lane", "classname");
  level._id_E2F4._id_8EAE = var_1;

  foreach(var_4, var_3 in level._id_E2F4._id_8EAE) {
    var_3.index = var_4;
    var_3._id_7DFC = 1 << var_4;
  }

  var_5 = getEntArray("trigger_multiple_mp_spawn_ignore", "classname");

  foreach(var_7 in var_5) {
    _id_0AA6::_id_99E8(var_7, ::_id_7D36, ::_id_7D37);
  }
}

_id_3A22(var_0) {}

_id_3A23(var_0, var_1) {
  var_2 = level._id_E2F4._id_0F5D;
  var_3 = level._id_E2F4;
  var_4 = 0.0;
  var_0._id_CF35 = level._id_E2F4._id_E34E[var_0.index];

  foreach(var_8, var_6 in var_3._id_0F5A) {
    var_7 = 0.0;

    if(isDefined(var_6._id_AE49)) {}

    var_7 = [[var_6._id_6016]](var_0);
    var_4 = var_4 + var_7 * var_6._id_10DF4;
  }

  return var_4;
}

_id_3A21(var_0, var_1) {
  var_2 = _id_0818::_id_408C(var_0);
  return var_2;
}

_id_6D4A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_4052(var_0, var_1, var_5);
  _id_D462(var_6);

  if(level._id_5E7F) {
    var_7 = _id_0818::_id_5AE3();

    if(isDefined(var_7)) {
      return var_7;
    }
  }

  if(!isDefined(var_4)) {
    var_4 = "buddy";
  }

  var_8 = _id_6D3F(var_4);
  var_9 = _id_6D5B(var_2);
  var_10 = _id_6D5B(var_3);
  var_11 = var_9 | var_10;
  var_12 = var_0 _meth_87EF(var_11);

  if(getdvarint("#x354bca663858af9a", 0) == 0) {
    var_13 = var_0 _meth_874C(var_12, var_9);
    var_14 = _id_6D3F(var_13);

    if(var_14 < 2 && var_14 <= var_8) {
      var_15 = var_0 _id_6D51(var_12, var_9, var_13);
      return var_15;
    }

    var_16 = undefined;
    var_17 = undefined;

    if(var_10 > 0) {
      var_16 = var_0 _meth_874C(var_12, var_10);
      var_17 = _id_6D3F(var_16);

      if(var_17 < 2 && var_17 <= var_8) {
        var_18 = var_0 _id_6D51(var_12, var_10, var_16);
        var_18._id_FF0B = 1;
        return var_18;
      }
    }
  } else if(getdvarint("#x354bca663858af9a", 0) == 1) {
    var_13 = var_0 _meth_874C(var_12, var_11);
    var_14 = _id_6D3F(var_13);

    if(var_14 < 2 && var_14 <= var_8) {
      var_15 = var_0 _id_6D51(var_12, var_11, var_13);
      return var_15;
    }
  }

  if(var_8 <= 1) {
    return undefined;
  }

  if(var_8 <= 3) {
    var_7 = _id_0818::_id_5AE3();

    if(isDefined(var_7)) {
      _id_0818::_id_975A("Using buddy spawn", var_0);
      var_7._id_2C7C = 3;
      return var_7;
    }
  }

  var_15 = var_0 _id_6D51(var_12, var_11, "bad");

  if(!istrue(level._id_4AE7) && !istrue(var_0._id_DDC7) && var_15._id_048C < 300) {
    var_0._id_DB64 = 1;
  }

  return var_15;
}

_id_4052(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.team = var_1;
  var_3._id_F1E8 = gettime();
  var_3._id_5899 = var_2;

  if(level.teambased) {
    var_3._id_542E = scripts\mp\utility\teams::_id_6A01(var_1)[0];
  } else {
    var_3._id_542E = "none";
  }

  return var_3;
}

_id_D462(var_0) {
  level._id_E2F4._id_0F5D = var_0;
}

_id_6D60() {
  if(getdvarint("#x386b12880a7d57d13") == 1) {
    return "mp/spawnweights_s4.csv";
  } else {
    return "mp/spawnweights.csv";
  }
}

_id_688A() {
  return level._id_E2F4._id_0F5D;
}

_id_391A() {
  level._id_E2F4._id_0F5D = undefined;
}

_id_F407() {
  for(;;) {
    self waittill("host_migration_end");
    _id_4388();
  }
}

_id_392D() {
  foreach(var_2, var_1 in level._id_E2F4._id_589A) {
    _func_0386(var_2, 0.0);
  }
}

_id_C248(var_0) {
  foreach(var_3, var_2 in var_0) {
    _func_0386(var_3, var_2);
  }

  _func_0386("script", 1.0);
}

_id_D461(var_0, var_1) {
  var_2 = level._id_E2F4;
  var_2._id_979B = 0;
  var_2._id_0F5E = var_0;
  var_2._id_0F5A = [];

  foreach(var_6, var_4 in var_2._id_E2E6[var_0]) {
    if(_id_0816::_id_884D(var_6) && _id_0816::_id_884E(var_6)) {
      var_5 = spawnStruct();
      var_5._id_6016 = _id_0816::_id_6A30(var_6);
      var_5._id_AE49 = _id_0816::_id_6A31(var_6);
      var_5._id_10DF4 = var_4;
      var_2._id_0F5A[var_6] = var_5;
    }
  }

  _id_392D();
  _id_C248(var_2._id_E2E6[var_0]);

  if(istrue(var_2._id_408D[var_1]["frontline"])) {
    var_7 = _id_0816::_id_6A70();

    if(isDefined(var_7) && isDefined(var_7._id_1773) && isDefined(var_7._id_BCCD)) {
      _func_0387(var_7._id_1773, var_7._id_BCCD);
    } else {
      _func_0387();
    }
  } else {}

  if(level.teambased) {
    _func_0388(1);
  } else {
    _func_0388(0);
  }
}

_id_96A8() {
  level._id_E2F4._id_E2E6 = [];
  level._id_E2F4._id_408D = [];
  var_0 = -1;

  for(;;) {
    var_0++;
    var_1 = _id_6D60();
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 2);
    var_4 = tablelookupbyrow(var_1, var_0, 1);

    if(var_4 == "Normal") {
      if(!isDefined(level._id_E2F4._id_E2E6[var_2])) {
        level._id_E2F4._id_E2E6[var_2] = [];
      }

      var_5 = tablelookupbyrow(var_1, var_0, 3);
      var_5 = float(var_5);
      level._id_E2F4._id_E2E6[var_2][var_3] = var_5;
      continue;
    }

    if(!isDefined(level._id_E2F4._id_408D[var_2])) {
      level._id_E2F4._id_408D[var_2] = [];
    }

    level._id_E2F4._id_408D[var_2][var_3] = 1;
  }
}

_id_CC18(var_0) {
  foreach(var_3, var_2 in level._id_E2F4._id_E2E6[level._id_E2F4._id_0F5E]) {
    _id_0816::_id_2EE6(var_0, var_3, var_2);
  }
}

_id_884C(var_0) {
  return isDefined(level._id_E2F4._id_E2E6[level._id_E2F4._id_0F5E][var_0]);
}

_id_113A(var_0, var_1, var_2) {
  var_3 = _id_6D4E(var_0);
  var_4 = [];

  if(isDefined(level._id_9FFA)) {
    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(_id_352E(var_3[var_5])) {
        continue;
      }
      var_4[var_4.size] = var_3[var_5];
    }
  } else
    var_4 = var_3;

  if(!var_4.size) {
    if(!istrue(var_1)) {}

    return;
  }

  if(!isDefined(level._id_E726)) {
    level._id_E726 = [];
  }

  if(isDefined(var_2)) {
    if(!isDefined(level._id_EFAF)) {
      level._id_EFAF = [];
    }

    if(!isDefined(level._id_EFAF[var_2])) {
      level._id_EFAF[var_2] = [];
    }
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] _id_E34C();
    var_4[var_5]._id_D054 = 0;
    var_4[var_5]._id_7EAD = 0;
    level._id_E726[level._id_E726.size] = var_4[var_5];

    if(isDefined(var_2)) {
      level._id_EFAF[var_2][level._id_EFAF[var_2].size] = var_4[var_5];
    }
  }

  if(level.teambased) {
    foreach(var_7 in var_4) {
      var_7._id_7EAD = 1;
      var_8 = anglesToForward(var_7.angles);

      foreach(var_10 in var_4) {
        if(var_7 == var_10) {
          continue;
        }
        var_11 = vectornormalize(var_10.origin - var_7.origin);
        var_12 = vectordot(var_8, var_11);

        if(var_12 > 0.86) {
          var_7._id_7EAD = 0;
          break;
        }
      }
    }
  }
}

_id_1136(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = _id_6D4E(var_1);

  if(!var_4.size) {
    if(getDvar("#x376847958d67972ef") != "mp_donetsk") {}

    return;
  }

  _id_C2B8(var_0, var_4, var_3);
}

_id_C2B8(var_0, var_1, var_2) {
  if(!isDefined(level._id_E34D)) {
    level._id_E34D = [];
  }

  if(!isDefined(level._id_EFAB[var_0])) {
    level._id_EFAB[var_0] = [];
  }

  if(!isDefined(level._id_EF70[var_0])) {
    level._id_EF70[var_0] = [];
  }

  foreach(var_4 in var_1) {
    if(_id_352E(var_4)) {
      continue;
    }
    if(!isDefined(var_4._id_8189)) {
      var_4 _id_E34C();
      level._id_E34D[level._id_E34D.size] = var_4;
    }

    if(istrue(var_2)) {
      level._id_EF70[var_0][level._id_EF70[var_0].size] = var_4;
      var_4._id_884F = 1;
      continue;
    }

    level._id_EFAB[var_0][level._id_EFAB[var_0].size] = var_4;
  }
}

_id_E34C() {
  var_0 = self;
  var_0._id_CF35 = spawnStruct();
  level._id_E2F4._id_E34E[var_0.index] = var_0._id_CF35;
  level._id_E327 = _id_57A3(level._id_E327, var_0.origin);
  level._id_E324 = _id_57A2(level._id_E324, var_0.origin);
  var_0._id_01D7 = anglesToForward(var_0.angles);
  var_0._id_DD3E = var_0.origin + (0, 0, 50);
  var_0._id_904F = gettime();
  var_0._id_AD17 = 1;
  var_0._id_8189 = 1;
  var_0._id_164F = [];
  var_0._id_903B = [];
  var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_clipshot"]);
  var_2 = _func_02C1(var_0._id_DD3E, var_0._id_DD3E + (0, 0, 1024), var_1, [], 0, "physicsquery_any");

  if(var_2 > 0) {
    var_3 = var_0._id_DD3E + var_0._id_01D7 * 100;
    var_2 = _func_02C1(var_3, var_0._id_DD3E + (0, 0, 1024), var_1, [], 0, "physicsquery_any");

    if(var_2 > 0) {
      var_0._id_AD17 = 0;
    }
  }

  if(_id_DC05() || _id_628F()) {
    var_0._id_BF41 = _id_6CB6(var_0.origin);

    if(var_0._id_BF41.size <= 0) {}
  }

  var_0._id_8EAC = 0;
  var_0._id_8EAD = [];

  foreach(var_5 in level._id_E2F4._id_8EAE) {
    if(_func_011A(var_0.origin, var_5)) {
      var_0._id_8EAC = var_0._id_8EAC | var_5._id_7DFC;
      var_0._id_8EAD[var_0._id_8EAD.size] = var_5.index;
    }
  }

  _id_8293(var_0);
  _id_979F(var_0);
}

_id_6D4E(var_0, var_1) {
  if(!isDefined(level._id_E348)) {
    level._id_E348 = [];
  }

  if(!isDefined(level._id_E348[var_0])) {
    level._id_E348[var_0] = [];

    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
      var_2 = _func_00CB(var_0);

      foreach(var_4 in var_2) {
        if(_id_352E(var_4)) {
          continue;
        }
        if(isDefined(var_4._id_039B) && var_4._id_039B == level._id_96CC) {
          level._id_E348[var_0][level._id_E348[var_0].size] = var_4;
        }
      }

      if(level._id_E348[var_0].size == 0) {
        level._id_E348[var_0] = var_2;
      }
    } else {
      var_2 = _func_00CB(var_0);

      foreach(var_4 in var_2) {
        if(_id_352E(var_4)) {
          continue;
        }
        if(isDefined(var_4._id_039B) && issubstr(var_4._id_039B, "locale")) {
          continue;
        }
        level._id_E348[var_0][level._id_E348[var_0].size] = var_4;
      }
    }
  }

  var_8 = level._id_E348[var_0];

  if(istrue(var_1)) {
    level._id_E348[var_0] = level._id_CF7A[var_0];
    return level._id_E348[var_0];
  }

  if(isDefined(level._id_CF7A) && isDefined(level._id_CF7A[var_0])) {
    var_8 = scripts\engine\utility::array_combine(var_8, level._id_CF7A[var_0]);
  }

  return var_8;
}

_id_6D51(var_0, var_1, var_2) {
  var_3 = self _meth_862B(var_0, var_1, var_2);
  var_3._id_2C7C = _id_6D3F(var_3._id_038F);
  var_3._id_8776 = var_3._id_038F == "bad";
  var_3._id_567E = var_0;
  _id_975E(var_3);
  return var_3;
}

_id_975E(var_0) {
  if(_id_07F0::_id_9BD8()) {
    if(istrue(var_0._id_01EA)) {
      var_1 = scripts\engine\utility::ter_op(self.team == "allies", var_0._id_01EC, 1);
      var_2 = scripts\engine\utility::ter_op(self.team == "axis", var_0._id_01EC, 1);
      var_3 = rotatevector(var_0._id_01E9, (0, 90, 0));
      _id_0816::_id_9796(var_0._id_01EB, var_3, var_1, var_2);
    }
  }
}

_id_6D4C(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = _id_0818::_id_34F7(var_0);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_1 = var_3;

    if(_func_0034(var_1.origin) && !_func_01A5(var_1.origin)) {
      break;
    }
  }

  return var_1;
}

_id_6D4D(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = undefined;
  var_0 = _id_0818::_id_34F7(var_0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_D054)) {
      continue;
    }
    if(var_4._id_D054) {
      continue;
    }
    if(var_4._id_7EAD) {
      var_2 = var_4;
      break;
    }

    var_2 = var_4;
  }

  if(!isDefined(var_2)) {
    if(istrue(var_1)) {
      return undefined;
    }

    var_2 = _id_6D4C(var_0);
  }

  if(isDefined(var_2)) {
    var_2._id_D054 = 1;
  }

  return var_2;
}

_id_F405() {
  for(;;) {
    level._id_7177 = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

_id_F426() {
  for(;;) {
    level._id_9F7E = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

_id_F3F5() {
  for(;;) {
    level._id_326E = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

_id_6DDD(var_0) {
  return level._id_EFAB[var_0];
}

_id_6DCD(var_0) {
  return level._id_EF70[var_0];
}

_id_8974() {
  if(!isDefined(level._id_AED7)) {
    level._id_AED7 = _func_03F2() > 150;
  }

  return level._id_AED7;
}

_id_1165() {
  level._id_AE7C[level._id_AE7C.size] = self;
}

_id_C4B0() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_AE7C.size; var_1++) {
    if(level._id_AE7C[var_1] == self) {
      for(var_0 = 1; var_1 < level._id_AE7C.size - 1; var_1++) {
        level._id_AE7C[var_1] = level._id_AE7C[var_1 + 1];
      }

      level._id_AE7C[var_1] = undefined;
      break;
    }
  }
}

_id_115A() {
  level.characters[level.characters.size] = self;
}

_id_C4A7() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++) {
        level.characters[var_1] = level.characters[var_1 + 1];
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

_id_E351() {
  var_0 = _id_628F();
  var_1 = 0;

  while(!isDefined(level._id_E34D) || level._id_E34D.size == 0) {
    waitframe();

    if(var_0) {
      wait 1;
      var_1 = var_1 + 1;

      if(var_1 > 120) {
        scripts\engine\utility::_id_5598("Timed out waiting for level.spawnPoints before building LOS data\n");
      }
    }
  }

  if(_id_DC05() || var_0) {
    if(var_0) {
      wait 1.0;
      var_2 = getEntArray();

      foreach(var_4 in var_2) {
        if(isDefined(var_4.classname) && var_4.classname == "script_brushmodel" && var_4._id_03EA & 1) {
          var_4 _meth_8093();
        }

        if(isDefined(var_4._id_0481) && var_4._id_0481 == "dynamic_door") {
          var_4 delete();
        }
      }

      waitframe();
    }

    var_6 = [];

    if(level._id_E34D.size == 0) {
      scripts\engine\utility::_id_5598("Spawn System Failure. No Spawnpoints found.");
    }

    for(var_7 = 0; var_7 < level._id_E34D.size; var_7++) {
      for(var_8 = 0; var_8 < level._id_E34D[var_7]._id_BF41.size; var_8++) {
        var_6[var_6.size] = level._id_E34D[var_7]._id_BF41[var_8];
      }
    }

    if(var_6.size > 0) {
      _func_02DA(var_6);
    } else if(var_0) {
      if(istrue(level._id_A5B7)) {
        scripts\engine\utility::_id_5598("Failed to build LOS data.This map has level.noPathnodes set, and doesn't support visibility generation.");
      } else {
        scripts\engine\utility::_id_5598("Failed to build LOS data.There are no pathnodes near any spawnpoints.");
      }
    } else if(!istrue(level._id_A5B7) && !istrue(level._id_8EE1))
      scripts\engine\utility::_id_5598("Spawn System Failure. There are no pathnodes near any spawnpoints.");
  }
}

_id_6889() {
  var_0 = [];

  foreach(var_2 in level.characters) {
    if(!scripts\mp\utility\player::isreallyalive(var_2)) {
      continue;
    }
    if(isPlayer(var_2)) {
      if(var_2.sessionstate != "playing") {
        continue;
      }
      if(!var_2 scripts\mp\utility\player::_id_898A()) {
        continue;
      }
    }

    var_2._id_E31A = _id_6D5E(var_2);

    if(var_2._id_E31A == "spectator") {
      continue;
    }
    if(isagent(var_2) && var_2._id_1210 == "seeker") {
      continue;
    }
    var_3 = _id_6C6C(var_2);
    var_4 = var_2 getEye();
    var_4 = (var_4[0], var_4[1], var_2.origin[2] + var_3);
    var_2._id_E31B = var_3;
    var_2._id_E396 = var_4;
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1137(var_0) {
  var_0 _meth_863E();
}

_id_C528(var_0) {
  var_0 _meth_863F();
}

_id_1135(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return _id_7E96(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_C51F(var_0) {
  _id_7E9D(var_0);
}

_id_8A47(var_0) {
  return _id_7E9C(var_0);
}

_id_69D4() {
  return 350;
}

_id_7E96(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3) && isDefined(var_5)) {
    var_3 = var_5.team;
  }

  var_10 = undefined;

  if(isDefined(var_5)) {
    if(isDefined(var_6)) {
      var_10 = _func_0389(var_0, var_1, var_2, var_3, var_5, var_6);
    } else {
      var_10 = _func_0389(var_0, var_1, var_2, var_3, var_5);
    }
  } else
    var_10 = _func_0389(var_0, var_1, var_2, var_3);

  if(!isDefined(var_10)) {
    return;
  }
  var_11 = _id_7E9A(var_10);

  if(!istrue(var_9)) {
    thread _id_7E97(var_11, ::_id_C51F, var_7, var_4, var_8);
  }

  return var_11;
}

_id_7E9D(var_0) {
  var_1 = _id_7E99(var_0);
  _func_038A(var_1);
  _id_7E9B(var_1);
}

_id_7E9A(var_0) {
  var_1 = level._id_E2F4;

  if(!isDefined(var_1._id_7E95[var_0])) {
    var_1._id_7E95[var_0] = 0;
  }

  var_2 = var_1._id_7E95[var_0];
  var_3 = var_2 << 16 | var_0;
  return var_3;
}

_id_7E9B(var_0) {
  var_1 = level._id_E2F4;
  var_1._id_7E95[var_0]++;
  var_2 = var_1._id_7E95[var_0];

  if(var_2 >= 65535) {
    var_2 = 0;
    var_1._id_7E95[var_0] = 0;
  }
}

_id_7E99(var_0) {
  return var_0 & 65535;
}

_id_7E98(var_0) {
  return var_0 >> 16;
}

_id_7E9C(var_0) {
  var_1 = level._id_E2F4;
  var_2 = _id_7E98(var_0);
  var_3 = _id_7E99(var_0);
  var_4 = var_1._id_7E95[var_3];
  return isDefined(var_4) && var_2 == var_4;
}

_id_7E97(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = "death";
  }

  if(isDefined(var_3)) {
    if(var_5.size > 0) {
      var_2 scripts\engine\utility::_id_10891(var_5, var_3);
    } else {
      wait(var_3);
    }
  } else if(isDefined(var_2))
    var_2 scripts\engine\utility::_id_10892(var_5);

  if(!_id_7E9C(var_0)) {
    return;
  }
  [[var_1]](var_0);
}

influencepoint_linktoent(var_0, var_1) {
  var_2 = _id_7E99(var_0);
  _func_03BC(var_2, var_1);
}

_id_FD32() {
  level._id_E3A2 = _id_6889();

  foreach(var_1 in level._id_E3A2) {
    var_1._id_E3A4 = undefined;
  }

  foreach(var_4 in level._id_F897) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4._id_E31A = _id_6D5E(var_4);
    level._id_E3A2[level._id_E3A2.size] = var_4;
    var_4._id_E3A4 = undefined;
  }

  foreach(var_7 in level._id_F906) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7._id_E31A = _id_6D5E(var_7);
    level._id_E3A2[level._id_E3A2.size] = var_7;
    var_7._id_E3A4 = undefined;
  }
}

_id_1B0C() {
  return isDefined(level._id_E3A3) && level._id_E3A3 == gettime();
}

_id_97B2(var_0, var_1) {
  if(istrue(var_0._id_2C93) || istrue(var_0._id_8816)) {
    return;
  }
  if(isDefined(level._id_9BDA)) {
    if(isDefined(level._id_9BD1) && !isDefined(var_0._id_979C)) {
      var_0._id_979C = [[level._id_9BD1]]();
    }

    if(isDefined(var_0._id_979C)) {
      var_2 = 3;

      if(level.teambased) {
        var_3 = 1;
        var_4 = 1;

        if(var_1 == "allies") {
          var_3 = var_0._id_97B1["allies"] == 0;
          var_5 = isDefined(var_0._id_9799) && (var_0._id_9799 == 0 || var_0._id_9799 == 2);
          var_4 = scripts\engine\utility::ter_op(isDefined(var_0._id_9799), var_5, 0);
        } else {
          var_4 = var_0._id_97B1["axis"] == 0;
          var_6 = isDefined(var_0._id_9799) && (var_0._id_9799 == 0 || var_0._id_9799 == 1);
          var_3 = scripts\engine\utility::ter_op(isDefined(var_0._id_9799), var_6, 0);
        }

        if(var_3 && var_4) {
          var_2 = 0;
        } else if(var_3) {
          var_2 = 1;
        } else if(var_4) {
          var_2 = 2;
        }
      } else
        var_2 = scripts\engine\utility::ter_op(var_0._id_5FF9["all"] == 0, 0, 3);

      if(!isDefined(var_0._id_9799) || var_0._id_9799 != var_2) {
        [[level._id_9BDA]](var_0._id_979C, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), var_2);
        var_0._id_9799 = var_2;
      }
    }
  }
}

_id_979F(var_0) {
  if(istrue(var_0._id_2C93) || istrue(var_0._id_8816)) {
    return;
  }
  if(isDefined(level._id_9BDA)) {
    if(isDefined(level._id_9BD1) && !isDefined(var_0._id_979C)) {
      var_0._id_979C = [[level._id_9BD1]]();
    }

    if(isDefined(var_0._id_979C) && !isDefined(var_0._id_4972)) {
      [[level._id_9BDA]](var_0._id_979C, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), 0);
      var_0._id_4972 = 1;
    }
  }
}

_id_E34B(var_0) {
  foreach(var_2 in level._id_E3A2) {
    var_3 = distancesquared(var_2.origin, var_0.origin);

    if(var_3 < var_0._id_9EB9[var_2._id_E31A]) {
      var_0._id_9EB9[var_2._id_E31A] = var_3;
    }

    if(var_2._id_E31A == "spectator") {
      continue;
    }
    var_0._id_4BBB[var_2._id_E31A] = var_0._id_4BBB[var_2._id_E31A] + var_3;
    var_0._id_4BBC[var_2._id_E31A] = var_0._id_4BBC[var_2._id_E31A] + min(var_3, _id_0816::_id_9C94());
    var_0._id_F37B[var_2._id_E31A]++;
  }

  var_0._id_7553 = 1;
}

_id_6D5E(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = var_0.team;
  }

  return var_1;
}

_id_8293(var_0) {
  _id_3982(var_0);
  _id_3981(var_0);
}

_id_3982(var_0) {
  if(level.teambased) {
    foreach(var_2 in level._id_EF89) {
      _id_398D(var_0, var_2);
    }
  } else
    _id_398D(var_0, "all");
}

_id_D8A3(var_0) {}

_id_3981(var_0) {
  if(level.teambased) {
    foreach(var_2 in level._id_EF89) {
      _id_398C(var_0, var_2);
    }
  } else
    _id_398C(var_0, "all");
}

_id_398D(var_0, var_1) {
  var_0._id_75B2[var_1] = 0;
  var_0._id_5FF9[var_1] = 0;
  var_0._id_3D75[var_1] = 0;
  var_0._id_97B1[var_1] = 0;
  var_0._id_9CA1[var_1] = 0.0;
  var_0._id_9C7D[var_1] = 0.0;
}

_id_398C(var_0, var_1) {
  var_0._id_7553 = 0;
  var_0._id_4BBB[var_1] = 0;
  var_0._id_4BBC[var_1] = 0;
  var_0._id_9EB9[var_1] = 9999999;
  var_0._id_F37B[var_1] = 0;
}

_id_6C6C(var_0, var_1) {
  if(isDefined(var_1) && var_1) {
    return 64;
  }

  var_2 = var_0 getstance();

  if(var_2 == "stand") {
    return 64;
  }

  if(var_2 == "crouch") {
    return 44;
  }

  return 32;
}

_id_10D4(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = _id_6D5E(var_3);

    if(var_0._id_5FF9[var_4]) {
      continue;
    }
    var_0._id_75B2[var_4] = 1;
    var_5 = var_3.origin + (0, 0, 50);
    var_6 = 0.0;

    if(!var_6) {
      var_6 = _func_0213(var_0, var_0._id_DD3E, var_5);
    }

    if(!var_6) {
      continue;
    }
    if(var_6 > 0.95) {
      var_0._id_5FF9[var_4]++;
      continue;
    }

    var_0._id_3D75[var_4]++;
  }
}

_id_5AA0(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  var_1 = gettime();
  self._id_904C = var_0;
  self._id_904F = var_1;
  var_0._id_904F = var_1;
  var_0._id_904E = self.team;

  if(!isDefined(var_0._id_2C7C)) {
    self _meth_862D(var_0.index);
  } else {
    if(!isDefined(var_0._id_FF0B)) {
      var_0._id_FF0B = 0;
    }

    if(!isDefined(var_0._id_048C)) {
      var_0._id_048C = -1.0;
    }

    if(!isDefined(var_0.damagemod)) {
      var_0.damagemod = -1;
    }

    self _meth_862D(var_0.index, var_0._id_2C7C, var_0._id_FF0B, var_0._id_048C, var_0.damagemod);
  }

  var_2 = level._id_E2F4._id_E34E[var_0.index];

  if(isDefined(var_2)) {
    var_2._id_FE3A = 1;
  }

  level._id_E2F4._id_90A0[self.team] = var_0;
}

_id_57A4(var_0) {
  var_1 = _id_6D4E(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level._id_E327 = _id_57A3(level._id_E327, var_1[var_2].origin);
    level._id_E324 = _id_57A2(level._id_E324, var_1[var_2].origin);
  }
}

_id_57A3(var_0, var_1) {
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

_id_57A2(var_0, var_1) {
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

_id_5AE1(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

_id_D5ED() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_57A4("mp_tdm_spawn_allies_start");
  _id_57A4("mp_tdm_spawn_axis_start");
  level._id_9AAC = _id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
}

_id_DC06() {
  if(getdvarint("#x3c803a0d8460b89f4", 0) == 1) {
    return 1;
  }

  if(!_id_07D1::_id_60BE("prematch_done") && isDefined(game["infil"]) && !_id_07D1::_id_60BE("infil_started")) {
    return 1;
  }

  if(istrue(level._id_4AF6)) {
    return 0;
  }

  return level._id_7EB0 && (!isDefined(level._id_A78D) || level._id_A78D == 0);
}

_id_6C1D(var_0, var_1) {
  if(var_1) {
    var_2 = 0;
    var_3 = _id_6968();
  } else {
    var_2 = _id_6968();
    var_3 = 250;
  }

  return _func_00B4(var_0, var_3, var_2, 512, "path");
}

_id_6CB6(var_0) {
  var_1 = [];
  var_2 = _func_0080(var_0);

  if(isDefined(var_2)) {
    var_1[0] = var_2;
  }

  if(!isDefined(var_2)) {
    var_1 = _func_00B4(var_0, _id_6968(), 0, 256, "path");

    if(var_1.size == 0) {
      var_1 = _func_00B4(var_0, 250, 0, 256, "path");
    }
  }

  return var_1;
}

_id_5676(var_0, var_1) {
  _id_356D();
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::_id_6A01(var_1)[0];
  }

  if(!_id_DC05()) {
    var_0._id_75B2[var_2] = 1;
    return;
  }

  var_3 = 0.95;
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_3 = level._id_E2F4._id_98C3;
  var_4 = level._id_E2F4._id_98C2;

  foreach(var_8 in level._id_E3A2) {
    if(level.teambased && var_8._id_E31A != var_2) {
      continue;
    }
    if(var_0._id_5FF9[var_8._id_E31A]) {
      break;
    }

    if(!isDefined(var_8._id_E3A4)) {
      var_8._id_E3A4 = var_8 _meth_84BB(_id_6A33());

      if(!isDefined(var_8._id_E3A4) || var_8._id_E3A4.size == 0) {
        if(isDefined(level._id_9BDB) && isPlayer(var_8)) {
          if(!isDefined(var_8._id_9028) || var_8._id_9028 != gettime()) {
            [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_8.name);
            var_8._id_9028 = gettime();
          }
        }
      }
    }

    if(isDefined(var_8._id_E3A4) && var_8._id_E3A4.size > 0) {
      var_9 = _id_0C9E(var_8, var_0);
      var_5 = var_9[0];
      var_6 = var_9[1];
    }

    if(!isDefined(var_5)) {
      var_10 = undefined;

      if(isPlayer(var_8)) {
        var_10 = var_8 getEye();
      } else {
        var_10 = var_8.origin + (0, 0, 50);
      }

      var_5 = _id_49CB(var_0, var_8, var_10);
      var_6 = var_5;
    }

    if(!isDefined(var_0._id_9CA1[var_8._id_E31A]) || var_5 > var_0._id_9CA1[var_8._id_E31A]) {
      var_0._id_9CA1[var_8._id_E31A] = var_5;
    }

    if(isDefined(var_6) && isPlayer(var_8)) {
      if(!isDefined(var_0._id_9C7D[var_8._id_E31A]) || var_6 > var_0._id_9C7D[var_8._id_E31A]) {
        var_0._id_9C7D[var_8._id_E31A] = var_6;
      }
    }

    if(var_5 > var_3) {
      var_0._id_5FF9[var_8._id_E31A]++;
      var_0._id_97B1[var_8._id_E31A]++;
      continue;
    }

    if(var_5 > var_4) {
      var_0._id_3D75[var_8._id_E31A]++;
    }
  }

  var_0._id_75B2[var_2] = 1;
  _id_97B2(var_0, var_2);
}

_id_0C9E(var_0, var_1) {
  var_2 = _id_356E(var_0, var_1);

  if(!isDefined(var_2)) {
    if(_id_356C(var_0, var_1)) {
      return [1.0, 1.0];
    }

    var_2 = _func_02CF(var_0._id_E3A4, var_1._id_BF41);
  }

  return var_2;
}

_id_356C(var_0, var_1) {
  return 0;
}

_id_356E(var_0, var_1) {
  if(!isDefined(level._id_E2F4._id_F7AB)) {
    return;
  }
  foreach(var_3 in var_0._id_E3A4) {
    var_4 = var_3 _meth_8162();

    if(isDefined(level._id_E2F4._id_F7AB[var_4])) {
      foreach(var_6 in var_1._id_BF41) {
        var_7 = var_6 _meth_8162();

        if(isDefined(level._id_E2F4._id_F7AB[var_4][var_7])) {
          return level._id_E2F4._id_F7AB[var_4][var_7];
        }
      }
    }
  }
}

_id_1180(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level._id_E2F4)) {
      break;
    }

    waitframe();
  }

  if(!isDefined(level._id_E2F4._id_F7AB)) {
    level._id_E2F4._id_F7AB = [];
  }

  if(!isDefined(level._id_E2F4._id_F7AB[var_0])) {
    level._id_E2F4._id_F7AB[var_0] = [];
  }

  level._id_E2F4._id_F7AB[var_0][var_1] = [var_2, var_3];

  if(!isDefined(level._id_E2F4._id_F7AB[var_1])) {
    level._id_E2F4._id_F7AB[var_1] = [];
  }

  level._id_E2F4._id_F7AB[var_1][var_0] = [var_2, var_3];
}

_id_6968() {
  return 130;
}

_id_6A33() {
  return 250;
}

_id_49CB(var_0, var_1, var_2) {
  var_3 = var_0._id_DD3E;
  var_4 = var_2;
  var_5 = physics_createcontents(["physicscontents_ainosight"]);
  var_6 = _func_02C1(var_3, var_4, var_5, var_1, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_6, 0.0, 1.0);
}

_id_6B3B() {
  return 2550;
}

_id_356D() {
  if(_id_DC05() && !_id_8AB5()) {
    if(isDefined(level._id_9BDB)) {
      [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");
    }

    if(!isDefined(level._id_75B1)) {
      level._id_75B1 = 1;
    }

    level._id_4AE1 = 1;
  }
}

_id_DC05() {
  return getdvarint("#x3ff0a501f5ad2b355", 0) == 1 && !isDefined(level._id_4AE1) && !_id_628F();
}

_id_628F() {
  return getdvarint("#x385a4233e3cfe79cd", 0) > 0;
}

_id_8AB5() {
  return _func_02D0();
}

_id_BD22() {
  level waittill("prematch_done");

  if(getdvarint("#x3decf448ab3afab5f", 0) == 1 && isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(var_1 ishost()) {
        if(!_id_DC05()) {
          var_1 iprintlnbold("TTLOS FAILED TO LOAD!");
        }

        break;
      }
    }
  }

  if(isDefined(level._id_9BDB)) {
    [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Script Version #6");

    if(_id_DC05()) {
      [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data...");
    } else {
      [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "No TTLOS Data! Not using TTLOS");
    }

    [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "CODE spawn logic enabled");

    if(isDefined(level._id_E2F4._id_0F5E)) {
      [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: " + level._id_E2F4._id_0F5E);
    } else {
      [[level._id_9BDB]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: None");
    }
  }
}

_id_8850(var_0) {
  return istrue(var_0._id_884F);
}

_id_9793() {
  if(getdvarint("#x34cf9f20c45bbabdb", 0) != 1) {
    return;
  }
  level waittill("prematch_done");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level._id_9BD1)) {
    var_0 = [[level._id_9BD1]]();
    var_1 = [[level._id_9BD1]]();
  }

  for(;;) {
    if(!_id_DC05()) {
      break;
    }

    _id_9792("allies", var_0);
    wait 0.5;
    _id_9792("axis", var_1);
    wait 0.5;
  }
}

_id_9792(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team = var_0;
  var_2.pers = [];
  var_2.pers["team"] = var_0;
  var_2._id_4AEA = 1;
  var_2._id_8816 = 1;
  var_3 = var_2[[level._id_6D4A]]();

  if(isDefined(level._id_9BDA) && isDefined(var_3) && isDefined(var_1)) {
    var_4 = scripts\engine\utility::ter_op(var_0 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level._id_9BDA]](var_1, var_0, var_4, var_3.origin[0], var_3.origin[1], gettime());
  }
}

_id_3952() {
  level._id_E2F4._id_90A0 = [];
}

_id_6BDE(var_0) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]) + " " + int(var_0.origin[2]);
}

_id_6BDF(var_0) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]);
}

_id_352E(var_0) {
  if(!isDefined(level._id_9FFA)) {
    return 0;
  }

  var_1 = undefined;
  var_2 = _id_6BDE(var_0);

  if(isDefined(level._id_9FFA[var_2])) {
    var_1 = level._id_9FFA[var_2][var_0.classname];
  }

  if(!isDefined(var_1)) {
    var_2 = _id_6BDF(var_0);

    if(isDefined(level._id_9FFA[var_2])) {
      var_1 = level._id_9FFA[var_2][var_0.classname];
    }

    if(!isDefined(var_1)) {
      return 0;
    }
  }

  if(istrue(var_1["remove"])) {
    return 1;
  }

  if(isDefined(var_1["origin"])) {
    var_0.origin = var_1["origin"];
  }

  if(isDefined(var_1["angles"])) {
    var_0.angles = var_1["angles"];
  }

  if(istrue(var_1["no_alternates"])) {
    var_0._id_A53E = 1;
  }

  return 0;
}

_id_2F01(var_0) {
  var_1 = spawnStruct();
  var_1._id_3A0A = [];

  foreach(var_3 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_3) || var_3.team != var_0 || !var_3 scripts\mp\utility\player::_id_898A()) {
      continue;
    }
    var_4 = _id_3FB5(var_3);
    var_1._id_3A0A[var_1._id_3A0A.size] = var_4;
  }

  _id_9DDD(var_1);
  return var_1;
}

_id_3FB5(var_0) {
  var_1 = spawnStruct();
  var_1._id_3385 = var_0.origin;
  var_1.players = [var_0];
  return var_1;
}

_id_9DDD(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = -1;

  for(var_5 = 0; var_5 < var_0._id_3A0A.size; var_5++) {
    var_6 = var_0._id_3A0A[var_5];

    for(var_7 = var_5 + 1; var_7 < var_0._id_3A0A.size; var_7++) {
      var_8 = var_0._id_3A0A[var_7];
      var_9 = distance2dsquared(var_6._id_3385, var_8._id_3385);

      if(var_9 > 640000) {
        continue;
      }
      if(var_4 < 0 || var_9 < var_4) {
        var_4 = var_9;
        var_1 = var_6;
        var_2 = var_8;
        var_3 = var_7;
      }
    }
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    foreach(var_11 in var_2.players) {
      var_1.players[var_1.players.size] = var_11;
    }

    var_13 = (0, 0, 0);

    foreach(var_11 in var_1.players) {
      var_13 = var_13 + var_11.origin;
    }

    var_13 = var_13 / var_1.players.size;
    var_1._id_3385 = var_13;
    var_16 = var_0._id_3A0A.size - 1;
    var_0._id_3A0A[var_3] = var_0._id_3A0A[var_16];
    var_0._id_3A0A[var_16] = undefined;
    _id_9DDD(var_0);
  }
}

_id_7D36(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 scripts\mp\utility\player::_id_5265(0, "spawnIgnoreTrigger");
}

_id_7D37(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 scripts\mp\utility\player::_id_5265(1, "spawnIgnoreTrigger");
}

_id_6D3F(var_0) {
  switch (var_0) {
    case "good":
      return 0;
    case "ok":
      return 1;
    case "bad":
      return 2;
    case "buddy":
      return 3;
  }

  return 2;
}

_id_526D(var_0) {
  foreach(var_2 in var_0) {
    _func_0385(var_2.index);
  }
}

_id_4AE9(var_0) {
  foreach(var_2 in var_0) {
    _func_0382(var_2.index);
  }
}

_id_C2B9(var_0, var_1) {
  var_2 = level._id_E2F4;

  if(_func_0107(var_1)) {
    var_2._id_E37B[var_0] = var_1;
  } else {
    var_2._id_E37B[var_0] = _id_6D4E(var_1);
  }

  var_3 = 1 << var_2._id_E37C.size;
  var_2._id_E37C[var_0] = var_3;

  foreach(var_5 in var_2._id_E37B[var_0]) {
    _func_0448(var_5.index, var_3);
  }

  return var_0;
}

_id_6D5B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = level._id_E2F4;

  if(!_func_0107(var_0)) {
    return var_1._id_E37C[var_0];
  } else {
    var_2 = 0;

    foreach(var_4 in var_0) {
      var_2 = var_2 | var_1._id_E37C[var_4];
    }

    return var_2;
  }
}

_id_0EFF(var_0, var_1) {
  var_2 = level._id_E2F4;

  if(istrue(var_1)) {
    if(var_2._id_0F5F.size == 1 && isDefined(var_2._id_0F5F[var_0])) {
      return;
    }
    _id_4388();
  } else if(isDefined(var_2._id_0F5F[var_0])) {
    return;
  }
  var_3 = var_2._id_E37B[var_0];
  _id_526D(var_3);
  var_2._id_0F5F[var_0] = 1;
}

_id_4391(var_0) {
  var_1 = level._id_E2F4;
  var_2 = [];

  foreach(var_6, var_4 in var_1._id_0F5F) {
    if(var_6 != var_0) {
      var_2[var_6] = 1;
      continue;
    }

    var_5 = var_1._id_E37B[var_0];
    _id_4AE9(var_5);
  }

  var_1._id_0F5F = var_2;
}

_id_0EE5() {
  var_0 = level._id_E2F4;

  foreach(var_2 in var_0._id_E37B) {
    foreach(var_4 in var_2) {
      _func_0385(var_4.index);
    }
  }
}

_id_4388() {
  level._id_E2F4._id_0F5F = [];
  _func_0380();
}

_id_6D5C(var_0) {
  return level._id_E2F4._id_E37B[var_0].size;
}

_id_6CCE(var_0) {
  var_1 = level._id_E2F4;
  return var_1._id_E37B[var_0][randomint(var_1._id_E37B[var_0].size)];
}

_id_6CCD() {
  var_0 = getarraykeys(level._id_E2F4._id_0F5F);
  var_1 = undefined;

  while(!isDefined(var_1) && var_0.size > 0) {
    var_1 = scripts\engine\utility::random(var_0);

    if(_id_6D5C(var_1) <= 0) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      var_1 = undefined;
    }
  }

  return level._id_E2F4._id_E37B[var_1][randomint(level._id_E2F4._id_E37B[var_1].size)];
}

_id_4046(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.classname = var_0;
  var_5.origin = var_1;
  var_5.angles = var_2;
  var_5.target = var_3;
  var_5._id_039B = var_4;
  return var_5;
}

_id_1127(var_0) {
  if(!isDefined(level._id_CF7A)) {
    level._id_CF7A = [];
  }

  foreach(var_2 in var_0) {
    var_3 = var_2.classname;
    var_4 = var_2.origin;
    var_5 = var_2.angles;

    if(isDefined(var_2.target)) {
      var_6 = var_2.target;
    } else {
      var_6 = "";
    }

    if(isDefined(var_2._id_039B)) {
      var_7 = var_2._id_039B;
    } else {
      var_7 = "";
    }

    if(!isDefined(level._id_CF7A[var_3])) {
      level._id_CF7A[var_3] = [];
    }

    var_8 = spawnStruct();
    var_8.classname = var_3;
    var_8.origin = var_4;
    var_8.angles = var_5;
    var_9 = _func_040A(var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_9) || var_9 < 0) {
      continue;
    }
    var_8.index = var_9;

    if(var_6 != "") {
      var_8.target = var_6;
    }

    if(var_7 != "") {
      var_8._id_039B = var_7;
    }

    level._id_CF7A[var_3][level._id_CF7A[var_3].size] = var_8;
  }

  level thread _id_CF7B();
}

_id_CF7B() {
  level notify("scriptedSpawnpointsOnMigration");
  level endon("scriptedSpawnpointsOnMigration");

  for(;;) {
    level waittill("host_migration_begin");

    foreach(var_1 in level._id_CF7A) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.target)) {
          var_4 = var_3.target;
        } else {
          var_4 = "";
        }

        if(isDefined(var_3._id_039B)) {
          var_5 = var_3._id_039B;
        } else {
          var_5 = "";
        }

        var_6 = _func_040A(var_3.classname, var_3.origin, var_3.angles, var_4, var_5);
      }
    }
  }
}