/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1975.gsc
*************************************************/

_id_8157() {}

_id_5EAD() {
  level._id_5E7E = 1;
  setomnvar("ui_broshot_debug", 1);
  return _id_8156();
}

_id_8156(var_0) {
  if(1) {
    return 0;
  }

  level._id_2FFD = spawnStruct();
  level._id_2FFD._id_22B1 = getent("camera_mp_broshot", "targetname");
  level._id_2FFD._id_33F6[0] = getent("character_loc_broshot", "targetname");
  level._id_2FFD._id_33F6[2] = getent("character_loc_broshot_a", "targetname");
  level._id_2FFD._id_33F6[1] = getent("character_loc_broshot_b", "targetname");
  level._id_2FFD._id_33F6[3] = getent("character_loc_broshot_c", "targetname");
  level._id_2FFD._id_33F6[4] = getent("character_loc_broshot_d", "targetname");
  level._id_2FFD._id_33F6[5] = getent("character_loc_broshot_e", "targetname");

  if((!isDefined(self) || !isDefined(level._id_2FFD._id_22B1) || !scripts\mp\utility\teams::_id_6DCA("allies", "teamCount") == 0 || !scripts\mp\utility\teams::_id_6DCA("axis", "teamCount")) && !istrue(level._id_5E7E)) {
    return 0;
  }

  if(level.teambased && !istrue(level._id_5E7E)) {
    if(!isDefined(var_0)) {
      var_1 = _func_00DB("allies");
      var_2 = _func_00DB("axis");

      if(var_1 == var_2) {
        return 0;
      }
    } else if(var_0 == "tie" || var_0 == "none" || var_0 == "draw")
      return 0;
  }

  level._id_2FFD._id_A370 = 40;
  level._id_2FFD._id_33F6[1].origin = level._id_2FFD._id_33F6[0].origin + anglestoleft(level._id_2FFD._id_33F6[1].angles) * -40.0 + anglesToForward(level._id_2FFD._id_33F6[1].angles) * -100.0;
  level._id_2FFD._id_33F6[2].origin = level._id_2FFD._id_33F6[0].origin + anglestoleft(level._id_2FFD._id_33F6[2].angles) * 60.0 + anglesToForward(level._id_2FFD._id_33F6[2].angles) * -130.0;
  setomnvar("ui_broshot_upside_down", istrue(level._id_FDA9));
  _id_E03E(var_0);
  level._id_A79E = int(min(3, level._id_F348.size));
  level._id_A791 = int(min(3, level._id_F345.size));
  _id_5A4F();

  for(var_3 = 0; var_3 < level._id_A79E; var_3++) {
    var_4 = level._id_2FFD._id_33F6[var_3].origin - (0, 0, 50);
    var_5 = (var_4[0], var_4[1], var_4[2] + 100);
    var_6 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 0, 0);
    var_7 = _func_02C1(var_5, var_4, var_6, undefined, 1, "physicsquery_closest");
    var_8 = isDefined(var_7) && var_7.size > 0;

    if(var_8) {
      var_9 = var_7[0]["position"];
      level._id_2FFD._id_33F6[var_3].origin = var_9;
    }

    level._id_2FFD._id_33F6[var_3].angles = level._id_2FFD._id_33F6[var_3].angles;
  }

  for(var_3 = level._id_A79E; var_3 < level._id_A79E + level._id_A791; var_3++) {
    var_10 = var_3 - level._id_A79E;
    level._id_2FFD._id_33F6[var_3].origin = level._id_2FFD._id_33F6[var_10].origin;
    level._id_2FFD._id_33F6[var_3].angles = level._id_2FFD._id_33F6[var_10].angles;
  }

  self._id_A366 = [];
  return 1;
}

_id_5A4F() {
  var_0 = min(level._id_A79E, level._id_A791);

  if(var_0 < level._id_A79E) {
    level._id_F348 = scripts\engine\utility::array_remove_index(level._id_F348, level._id_F348.size - 1, 0);
    level._id_A79E = level._id_F348.size;
  }

  if(var_0 < level._id_A791) {
    level._id_F345 = scripts\engine\utility::array_remove_index(level._id_F345, level._id_F345.size - 1, 0);
    level._id_A791 = level._id_F345.size;
  }
}

_id_F22F(var_0) {
  level endon("queuedTauntsRun");
  wait(var_0);
  thread _id_CA6F();
}

_id_BECA(var_0, var_1) {
  if(!isDefined(level._id_2C29)) {
    level._id_2C29 = [];
  }

  if(!isDefined(level._id_2C29[var_0])) {
    level._id_2C29[var_0] = var_1;

    if(0 || isDefined(level._id_44BC)) {
      if(var_0 == 0) {
        if(level._id_A79E > 1) {
          level._id_2C29[var_0 + 1] = var_1;
        }

        if(level._id_A79E > 2) {
          level._id_2C29[var_0 + 2] = var_1;
        }
      }
    }
  }

  var_2 = 0;

  foreach(var_4 in level._id_F348) {
    if(!isbot(var_4)) {
      var_2++;
    }
  }

  if(level._id_2C29.size >= var_2) {
    if(isDefined(level._id_2C27)) {
      thread _id_CA6F();
    } else {
      thread _id_10978();
    }
  }
}

_id_BD61(var_0) {
  level._id_2FF6 = [];

  if(!isDefined(level._id_2C29[0])) {
    level._id_2C29[0] = 1;
  }

  if(!isDefined(level._id_2C29[1]) && level._id_A79E > 1) {
    level._id_2C29[1] = randomint(2) + 1;
  }

  if(!isDefined(level._id_2C29[2]) && level._id_A79E > 2) {
    level._id_2C29[2] = randomint(2) + 1;
  }

  if(isDefined(level._id_2C29[2])) {
    var_1 = level._id_2C29[2];
    var_2 = _id_6944(var_1, 2);
    level._id_2FF6[2] = var_2;
  }

  if(isDefined(level._id_2C29[1])) {
    var_1 = level._id_2C29[1];
    var_2 = _id_6944(var_1, 1);
    level._id_2FF6[1] = var_2;
  }

  if(isDefined(level._id_2C29[0])) {
    var_1 = level._id_2C29[0];
    var_2 = _id_6944(var_1, 0);
    level._id_2FF6[0] = var_2;
  }
}

_id_6944(var_0, var_1) {
  if(var_0 == 1) {
    if(level._id_2C2A) {
      var_2 = _id_8D9C(var_1);
    } else {
      var_2 = _id_8D9D(var_1);
    }
  } else if(level._id_2C2A)
    var_2 = _id_3232(var_1);
  else {
    var_2 = _id_3233(var_1);
  }

  return var_2;
}

_id_1080C() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  level._id_2C27 = 1;
}

_id_10978() {
  level endon("queuedTauntsRun");
  level waittill("bro_intro_done");
  thread _id_CA6F();
}

_id_2EB3(var_0) {
  if(isDefined(var_0._id_428E)) {
    return var_0._id_428E / 30.0;
  }

  var_1 = var_0._id_8CDB[var_0._id_8CDB.size - 1];
  return var_1._id_A4E3 / 30.0;
}

_id_2EC2(var_0) {
  return var_0._id_BB78 / 30.0;
}

_id_CA6F() {
  level notify("queuedTauntsRun");

  if(!isDefined(level._id_2C29)) {
    level._id_2C29 = [];
  }

  var_0 = 11.0;
  _id_BD61(level._id_2C29);
  var_1 = 0;

  if(isDefined(level._id_2C29[2])) {
    var_2 = _id_2EB3(level._id_2FF6[2]);
    var_3 = _id_2EC2(level._id_2FF6[1]);
    var_4 = level._id_2C29[2];
    thread _id_4C47(2, var_4, var_1);
    var_0 = var_0 + var_2;
    var_1 = var_1 + (var_2 - var_3);
  }

  if(isDefined(level._id_2C29[1])) {
    var_2 = _id_2EB3(level._id_2FF6[1]);
    var_3 = _id_2EC2(level._id_2FF6[0]);
    var_4 = level._id_2C29[1];
    thread _id_4C47(1, var_4, var_1);
    var_0 = var_0 + var_2;
    var_1 = var_1 + (var_2 - var_3);
  }

  var_4 = 0;

  if(isDefined(level._id_2C29[0])) {
    var_4 = level._id_2C29[0];
  }

  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(level._id_2C2A) {
    if(var_4 == 1) {
      var_5 = 3.16667;
      var_6 = 0.733333;
      var_7 = 0.2;
      var_8 = 0.25;
      var_9 = 0.15;
    } else {
      var_5 = 2.5;
      var_6 = 1.4;
      var_7 = 0.2;
      var_8 = 0.25;
      var_9 = 0.15;
    }
  } else if(var_4 == 1) {
    var_5 = 5.33333;
    var_6 = 0.5;
    var_7 = 0.2;
    var_8 = 0.25;
    var_9 = 0.15;
  } else {
    var_5 = 6.66667;
    var_6 = 0.6;
    var_7 = 0.2;
    var_8 = 0.25;
    var_9 = 0.15;
  }

  thread _id_4C47(0, var_4, var_1, var_5, var_6, var_7, var_8, var_9);
  thread _id_A6BB(var_0);
  waitframe();
  var_10 = 0.0;

  if(isDefined(level._id_2C29[2])) {
    var_2 = _id_2EB3(level._id_2FF6[2]);
    thread _id_10AAD(2, var_4);
    var_10 = var_2;
  }

  if(isDefined(level._id_2C29[1])) {
    var_2 = _id_2EB3(level._id_2FF6[1]);
    wait(var_10);
    thread _id_10AAD(1, var_4);
    var_10 = var_2;
  }

  wait(var_10);
  thread _id_10AAD(0, var_4);
}

_id_A6BB(var_0) {
  wait(var_0);
  level notify("taunts_timed_out");

  if(istrue(level._id_44BC)) {
    level.players[0] _id_C607();
  }
}

_id_F73F(var_0) {
  if(isDefined(var_0._id_4CB1)) {
    foreach(var_2 in level.players) {
      if(isbot(var_2)) {
        continue;
      }
      var_2._id_FF0A = 1;
      var_2 _meth_830B(var_0._id_4CB1, var_0._id_4CB0, var_0._id_4CAB, var_0._id_4CAA, var_0._id_4CAF, var_0._id_4CA9);
    }
  }
}

_id_10AAD(var_0, var_1) {
  self notify("play_cam_track");
  self endon("play_cam_track");
  var_2 = level._id_2FF6[var_0];
  _id_F73F(var_2);
  var_3 = 1;

  for(var_4 = 1; isDefined(var_2) && istrue(var_4); var_3 = 0) {
    var_4 = _id_3081(var_2, var_3, var_1);
  }
}

_id_E03E(var_0) {
  if(level.teambased) {
    if(!isDefined(var_0)) {
      var_1 = _func_00DB("allies");
      var_2 = _func_00DB("axis");
      var_3 = scripts\engine\utility::ter_op(var_1 >= var_2, "allies", "axis");
    } else
      var_3 = var_0;

    level._id_F348 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA(var_3, "players"), ::_id_3AF6);
    var_4 = scripts\mp\utility\teams::_id_69FD(var_3);
    level._id_F345 = scripts\engine\utility::_id_1BD6(var_4, ::_id_3AF6);
  } else {
    level._id_F348 = level._id_B16C["all"];
    level._id_F345 = level._id_B16C["all"];
  }
}

_id_E684(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  level._id_2C28 = 1;
  _id_3882();
  _id_3888();
  var_1 = spawnStruct();
  var_1.origin = level._id_2FFD._id_33F6[0].origin;
  var_1.angles = level._id_2FFD._id_33F6[0].angles;
  level._id_2FFD._id_22B1.origin = var_1.origin;
  level._id_2FFD._id_22B1.angles = var_1.angles;

  foreach(var_3 in level.players) {
    var_3 scripts\mp\playerlogic::_id_C673(var_1.origin, var_1.angles);
    var_3 scripts\mp\gamelogic::_id_5F64();
    var_3 playerhide();
  }

  _func_0343();
  level._id_0F19 = var_1;
  level._id_2FF9 = spawn("script_model", var_1.origin);
  level._id_2FF9 setModel("tag_origin");
  level._id_2FF9.angles = var_1.angles;
  _id_4072(var_0);
  level._id_A79E = int(min(3, level._id_F348.size));
  level._id_A791 = int(min(3, level._id_F345.size));
  _id_5A4F();
  level._id_EB2C = [];
  level._id_841A = [];
  level._id_5BDD = [];

  foreach(var_3 in level.players) {
    var_3 _id_78F4();
  }

  if(!isDefined(level._id_2C2A)) {
    level._id_2C2A = level._id_F348[0].team == "allies";
  }

  for(var_7 = 0; var_7 < 6; var_7++) {
    var_8 = 1;
    var_9 = undefined;

    if(var_7 <= level._id_A79E - 1) {
      var_9 = level._id_F348[var_7];
    } else if(var_7 <= level._id_A79E + level._id_A791 - 1) {
      var_8 = 0;
      var_9 = level._id_F345[var_7 - level._id_A79E];
    }

    if(!isDefined(var_9)) {
      break;
    }

    if(!isDefined(var_9._id_965F)) {
      continue;
    }
    var_10 = undefined;
    var_11 = undefined;

    if(istrue(level._id_44BC)) {
      if(level._id_2C2A) {
        if(var_8) {
          var_10 = 10;
          var_11 = 6;
        } else {
          var_10 = 1;
          var_11 = 1;
        }
      } else if(var_8) {
        var_10 = 1;
        var_11 = 1;
      } else {
        var_10 = 10;
        var_11 = 6;
      }
    }

    _id_401A(var_7, var_9, var_8, var_10, var_11);
  }

  foreach(var_3 in level.players) {
    var_3 _meth_867F("mp_broshot");
    var_3 _meth_852B(0);
    var_3 dontinterpolate();

    if(isbot(var_3)) {
      continue;
    }
    var_3 cameralinkto(level._id_2FF9, "tag_origin", 1);
    var_3 thread scripts\mp\utility\game::_id_D73A(0.0);
    scripts\mp\utility\player::_id_0DC2("", 0);

    if(!istrue(level._id_5E7E)) {
      var_3 thread _id_58C6(1.5);
    }
  }

  level._id_2C26 = _id_2EB8();

  if(level._id_2C2A) {
    thread _id_84DE();
  } else {
    thread _id_84DF();
  }

  if(!isDefined(level._id_44BC)) {
    thread _id_F22F(10.0);
  }

  thread _id_EF2E(level._id_F348);
  level thread onplayerconnect();
  _func_033B(-1, self._id_A366);
}

_id_4072(var_0) {
  if(istrue(level._id_5E7E)) {
    if(level._id_2C2A) {
      var_1 = "allies";
      var_2 = "axis";
    } else {
      var_1 = "allies";
      var_2 = "axis";
    }

    if(scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount") > 1) {
      level._id_F348 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA(var_1, "players"), ::_id_3AF6);
    } else {
      level._id_F348 = [];
      level._id_F348[0] = self;
    }

    if(scripts\mp\utility\teams::_id_6DCA(var_2, "teamCount") > 1) {
      level._id_F345 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA(var_2, "players"), ::_id_3AF6);
      return;
    }

    level._id_F343 = [];
    level._id_F345[0] = self;
    return;
  } else
    _id_E03E(var_0);
}

_id_401A(var_0, var_1, var_2, var_3, var_4) {
  self._id_A366[var_0] = spawnStruct();

  if(scripts\mp\utility\game::getgametype() == "infect") {
    if(isbot(var_1)) {
      var_5 = var_1._id_965F;
    } else {
      var_5 = var_1 scripts\mp\class::_id_2E7E();
    }
  } else
    var_5 = var_1._id_965F;

  var_6 = tablelookuprownum("mp/battleRigTable.csv", 1, var_5);

  if(isbot(var_1) || isDefined(var_1._id_8F8C)) {
    var_7 = var_1 _meth_8128();
    var_8 = var_1 _meth_8129();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_8);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_7);

    if(isDefined(var_1._id_8F8C)) {
      var_6 = tablelookuprownum("mp/battleRigTable.csv", 1, var_1._id_8F8C._id_1A35);
    }
  } else {
    var_7 = var_1 _meth_8128();
    var_8 = var_1 _meth_8129();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_8);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_7);
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    var_9 = var_3;
    var_10 = var_4;
  } else {
    var_11 = var_1 scripts\mp\teams::_id_6A6D();
    var_9 = tablelookuprownum("mp/cac/heads.csv", 1, var_11[1]);
    var_10 = tablelookuprownum("mp/cac/bodies.csv", 1, var_11[0]);
  }

  self._id_A366[var_0].rigindex = var_6;
  self._id_A366[var_0]._id_009D = var_10;
  self._id_A366[var_0]._id_0218 = var_9;

  if(var_2) {
    if(istrue(level._id_2C2A)) {
      switch (var_0) {
        case 0:
        default:
          self._id_A366[var_0]._id_04FE = "s4_ar_stango44_mp";
          break;
        case 1:
          self._id_A366[var_0]._id_04FE = "s4_ar_stango44_mp";
          break;
        case 2:
          self._id_A366[var_0]._id_04FE = "s4_pi_mike1911";
          break;
      }
    } else {
      switch (var_0) {
        case 0:
        default:
          self._id_A366[var_0]._id_04FE = "s4_me_fists_mp";
          break;
        case 1:
          self._id_A366[var_0]._id_04FE = "s4_me_fists_mp";
          break;
        case 2:
          self._id_A366[var_0]._id_04FE = "s4_ar_stango44_mp";
          break;
      }
    }
  } else
    self._id_A366[var_0]._id_04FE = "s4_me_fists_mp";

  self._id_A366[var_0]._id_00E7 = var_1 _meth_8587();
  self._id_A366[var_0].name = var_1.name;
  self._id_A366[var_0]._id_0509 = var_1 getxuid();
  self._id_A366[var_0]._id_B991 = var_0;
  self._id_A366[var_0]._id_39A3 = var_1 getentitynumber();
  var_1 _id_D587(var_0);
  var_1._id_2BF3 = _id_99DE(var_0, level._id_2FFD._id_33F6[var_0]);
}

_id_C607() {
  level._id_2FFD._id_22B1.origin = level._id_2FFD._id_33F6[0].origin;
  level._id_2FFD._id_22B1.angles = level._id_2FFD._id_33F6[0].angles;
  level._id_2C29 = undefined;
  level._id_2C26 = _id_2EB8();

  if(level._id_2C2A) {
    setomnvar("ui_broshot_debug_restart", 2);
    thread _id_84DE();
  } else {
    setomnvar("ui_broshot_debug_restart", 1);
    thread _id_84DF();
  }

  thread _id_EF2E(level._id_F348);
  level._id_5E7E = 1;
  _id_4072();
  var_0 = int(min(3, level._id_F348.size));
  var_1 = int(min(3, level._id_F345.size));

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_3 = 1;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    if(var_2 <= var_0 - 1) {
      var_4 = level._id_F348[var_2];

      if(level._id_2C2A) {
        var_5 = 10;
        var_6 = 6;
      } else {
        var_5 = 1;
        var_6 = 1;
      }
    } else if(var_2 <= var_0 + var_1 - 1) {
      var_3 = 0;
      var_4 = level._id_F345[var_2 - var_0];

      if(level._id_2C2A) {
        var_5 = 1;
        var_6 = 1;
      } else {
        var_5 = 10;
        var_6 = 6;
      }
    }

    if(!isDefined(var_4)) {
      break;
    }

    if(!isDefined(var_4._id_965F)) {
      continue;
    }
    if(isDefined(var_4._id_2BF3)) {
      var_4._id_2BF3 delete();
    }

    _id_401A(var_2, var_4, var_3, var_5, var_6);
  }

  waitframe();
  _func_033B(-1, self._id_A366);
}

_id_84DE() {
  var_0 = _id_3094();
  _id_F73F(var_0);
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  _id_3081(var_0);
  var_0 = _id_3090();
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  level notify("bro_intro_done");
  _id_3081(var_0);
}

_id_84DF() {
  var_0 = _id_3095();
  _id_F73F(var_0);
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  _id_3081(var_0);
  var_0 = _id_3091();
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  level notify("bro_intro_done");
  _id_3081(var_0);
}

_id_84DD() {
  var_0 = _id_3093();
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  _id_3081(var_0);
  _id_3081(var_0);
  var_0 = _id_3092();
  thread _id_B902(var_0, level._id_2FFD._id_22B1);
  self notify("bro_intro_done");
  _id_3081(var_0);
}

_id_3232(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = _id_3099();
      break;
    case 1:
      var_1 = _id_309A();
      break;
    case 2:
      var_1 = _id_309B();
      break;
  }

  return var_1;
}

_id_3233(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = _id_309C();
      break;
    case 1:
      var_1 = _id_309D();
      break;
    case 2:
      var_1 = _id_309E();
      break;
  }

  return var_1;
}

_id_8D9C(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = _id_3088();
      break;
    case 1:
      var_1 = _id_308A();
      break;
    case 2:
      var_1 = _id_308B();
      break;
  }

  return var_1;
}

_id_8D9D(var_0) {
  switch (var_0) {
    case 0:
    default:
      var_1 = _id_308C();
      break;
    case 1:
      var_1 = _id_308D();
      break;
    case 2:
      var_1 = _id_308E();
      break;
  }

  return var_1;
}

_id_8D9B(var_0) {
  var_1 = _id_3096();
  thread _id_B902(var_1, var_0);
  return var_1;
}

_id_3231(var_0) {
  var_1 = _id_3084();
  thread _id_B902(var_1, var_0);
  return var_1;
}

_id_10858(var_0, var_1) {
  self endon("broshot_done");
  wait(var_1 / 30.0);
  _id_B9E2(var_0);
}

_id_78F4() {
  if(self.sessionteam == "spectator" || self.sessionteam == "follower") {
    return;
  }
  if(!isDefined(self._id_965F)) {
    return;
  }
  self setscriptablepartstate("cloak", "offImmediate", 1);
  self setscriptablepartstate("armorUpMaterial", "offImmediate", 1);
  self setscriptablepartstate("armorUp", "neutral", 1);
  self setscriptablepartstate("adrenalineHeal", "neutral", 1);
  self setscriptablepartstate("pts_drone", "off", 1);
}

_id_E2E8() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("FX_BRO_LIGHT"), level._id_2FF9, "tag_origin");
}

_id_58C6(var_0) {
  wait 27.0;
  scripts\mp\utility\player::_id_0DC2("", 0);

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }
    var_2 _meth_844E("bw", var_0);
  }
}

_id_3882() {
  self notify("bro_shot_start");
  scripts\mp\weapons::_id_475B();
  var_0 = _func_00E8();

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 delete();
    }
  }
}

_id_3888() {
  if(isDefined(level._id_EF72)) {
    if(isDefined(level._id_EF72[game["attackers"]]) && isDefined(level._id_EF72[game["attackers"]]._id_10430)) {
      for(var_0 = 0; var_0 < level._id_EF72[game["attackers"]]._id_10430.size; var_0++) {
        level._id_EF72[game["attackers"]]._id_10430[var_0] hide();
      }
    }

    if(isDefined(level._id_EF72[game["defenders"]]) && isDefined(level._id_EF72[game["defenders"]]._id_10430)) {
      for(var_0 = 0; var_0 < level._id_EF72[game["defenders"]]._id_10430.size; var_0++) {
        level._id_EF72[game["defenders"]]._id_10430[var_0] hide();
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "dom" || scripts\mp\utility\game::getgametype() == "siege") && isDefined(level._id_A8E8)) {
    foreach(var_2 in level._id_A8E8) {
      if(isDefined(var_2)) {
        var_2._id_03A9 setscriptablepartstate("flag", "off");
        var_2._id_03A9 setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "grind" && isDefined(level._id_A8E8)) {
    foreach(var_5 in level._id_A8E8) {
      if(isDefined(var_5) && isDefined(var_5._id_03A9)) {
        var_5._id_03A9 setscriptablepartstate("flag", "off");
        var_5._id_03A9 setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((scripts\mp\utility\game::getgametype() == "sr" || scripts\mp\utility\game::getgametype() == "dd" | scripts\mp\utility\game::getgametype() == "sd") && isDefined(level._id_A8E8)) {
    foreach(var_8 in level._id_A8E8) {
      if(isDefined(var_8) && isDefined(var_8._id_10430)) {
        for(var_9 = 0; var_9 < var_8._id_10430.size; var_9++) {
          if(isDefined(var_8._id_10430[var_9])) {
            var_8._id_10430[var_9] hide();
          }
        }
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "front" && isDefined(level._id_110E9)) {
    foreach(var_5 in level._id_110E9) {
      if(isDefined(var_5) && isDefined(var_5._id_10430)) {
        for(var_9 = 0; var_9 < var_5._id_10430.size; var_9++) {
          var_5._id_10430[var_9] hide();
        }
      }
    }
  }

  if(istrue(level._id_4CE9)) {
    if(isDefined(level._id_4CE8)) {
      foreach(var_14 in level._id_4CE8) {
        if(isDefined(var_14) && isDefined(var_14._id_10430)) {
          for(var_9 = 0; var_9 < var_14._id_10430.size; var_9++) {
            var_14._id_10430[var_9] hide();
          }
        }
      }
    }
  }

  if(isDefined(level._id_21B2)) {
    foreach(var_17 in level._id_21B2) {
      var_17._id_10430[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    }
  }

  if((scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd") && isDefined(level._id_110E9)) {
    foreach(var_5 in level._id_110E9) {
      if(isDefined(var_5) && isDefined(var_5._id_FE90) && isDefined(var_5._id_FE90._id_3572)) {
        foreach(var_21 in var_5._id_FE90._id_3572) {
          for(var_9 = 0; var_9 < var_21._id_A776; var_9++) {
            var_21 setscriptablepartstate("chevron_" + var_9, "off");
          }
        }
      }
    }
  }
}

_id_EF2E(var_0) {
  wait 3.0;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(!isDefined(var_0[var_1]) || isbot(var_0[var_1]) || !scripts\engine\utility::array_contains(level.players, var_0[var_1])) {
      continue;
    }
    var_0[var_1] thread _id_954C(var_1);
  }
}

_id_69E5(var_0) {
  var_1 = getcompleteweaponname(var_0._id_8FC2);

  if(!issubstr(var_1, var_0.pers["primaryWeapon"]) && !issubstr(var_1, var_0.pers["secondaryWeapon"])) {
    var_1 = getcompleteweaponname(var_0._id_E3A8);
  }

  if(issubstr(var_1, "s4_me_fists_mp") || issubstr(var_1, "s4_me_knife") || issubstr(var_1, "s4_me_knife_mp")) {
    var_1 = var_0.pers["secondaryWeapon"];
  }

  if(issubstr(var_1, "nunchucks") || issubstr(var_1, "katana")) {
    var_1 = "s4_me_fists_mp";
  }

  return var_1;
}

_id_3072(var_0, var_1, var_2, var_3) {
  self _meth_8282(var_0.origin);
  wait(var_2);
  level._id_2FF9 _meth_82CA();
  var_4 = distance(level._id_2FF9.origin, var_0.origin);
  var_5 = var_4 / var_1;

  if(var_5 < level._id_5F3A) {
    var_5 = level._id_5F3A;
  }

  level._id_2FF9._id_A203 = var_0;
  level._id_2FF9 moveto(var_0.origin, var_5);
  level._id_2FF9 rotateto(var_0.angles, var_5);

  if(isDefined(var_3)) {
    wait(var_5 - var_3);
    thread scripts\mp\utility\game::_id_D73A(var_3);
  }
}

_id_52E3() {
  level._id_2C28 = undefined;
  self notify("broshot_done");

  foreach(var_1 in level.players) {
    var_1 _meth_8680("mp_broshot");
  }
}

_id_99DE(var_0, var_1) {
  var_2 = spawn("script_character", var_1.origin, 0, 0, var_0, "MPClientCharacter");
  var_2.angles = var_1.angles;

  if(istrue(level._id_A735) && var_0 == 0) {
    playFX(scripts\engine\utility::getfx("mons_screen_ash"), var_1.origin);
  }

  var_2 _meth_8236();
  return var_2;
}

_id_954C(var_0) {
  if(!isai(self)) {
    self notifyonplayercommand("bro_action_kill", "+attack");
    self notifyonplayercommand("bro_action_capture", "+speed_throw");
  }

  thread _id_9545(var_0);
  thread _id_1080C();
  self waittill("taunt_end");
}

_id_B9E2(var_0) {
  foreach(var_2 in level.players) {
    if(!isai(var_2)) {
      var_2 setclientdvar("#x356e0c9e15809767a", var_0);
    }
  }
}

_id_9545(var_0) {
  self endon("taunt_queued");
  self endon("taunt_start");
  self endon("broshot_done");
  childthread _id_9544(var_0);
  childthread _id_954A(var_0);
}

_id_9544(var_0) {
  self waittill("bro_action_capture");
  self setclientomnvar("ui_broshot_choice_lock_in", 2);
  thread _id_BEC9(var_0, 2);
}

_id_954A(var_0) {
  self waittill("bro_action_kill");
  self setclientomnvar("ui_broshot_choice_lock_in", 1);
  thread _id_BEC9(var_0, 1);
}

_id_954B(var_0, var_1) {
  self endon("taunt_start");
  self endon("broshot_done");

  for(;;) {
    self waittill("bro_action_" + var_1);
    thread _id_4E82(var_0, var_1);
    waitframe();
  }
}

_id_BEC9(var_0, var_1) {
  self notify("taunt_queued");

  if(isDefined(level._id_AD48)) {
    var_0 = level._id_AD48 - 1;
  }

  _id_BECA(var_0, var_1);
}

_id_2EB8() {
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[1] = spawnStruct();
  var_1 = int(min(level._id_A79E, 3)) - 1;
  var_2 = [];

  if(level._id_2C2A) {
    switch (var_1) {
      case 0:
        var_2[0] = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
        var_2[1] = "iw8_mp_end_game_mercy_us_cam_a_1st";
        break;
      case 1:
        var_2[0] = "iw8_mp_end_game_execute_us_cam_a_2nd";
        var_2[1] = "iw8_mp_end_game_mercy_us_cam_a_2nd";
        break;
      case 2:
        var_2[0] = "iw8_mp_end_game_execute_us_cam_a_3rd";
        var_2[1] = "iw8_mp_end_game_mercy_us_cam_a_3rd";
        break;
    }
  } else {
    switch (var_1) {
      case 0:
        var_2[0] = "iw8_mp_end_game_execute_op_cam_a_1st";
        var_2[1] = "iw8_mp_end_game_mercy_op_cam_a_1st";
        break;
      case 1:
        var_2[0] = "iw8_mp_end_game_execute_op_cam_a_2nd";
        var_2[1] = "iw8_mp_end_game_mercy_op_cam_a_2nd";
        break;
      case 2:
        var_2[0] = "iw8_mp_end_game_execute_op_cam_a_3rd";
        var_2[1] = "iw8_mp_end_game_mercy_op_cam_a_3rd";
        break;
    }
  }

  thread _id_B838(var_1, var_2[0], var_0[0]);
  thread _id_B838(var_1, var_2[1], var_0[1]);
  return var_0;
}

_id_B838(var_0, var_1, var_2) {
  var_3 = spawn("script_model", level._id_2FFD._id_33F6[var_0].origin);
  var_3 setModel("tag_origin");
  var_3.angles = level._id_2FFD._id_33F6[var_0].angles;
  var_3 _meth_82CC(var_1);
  wait 0.5;
  var_2._id_5BC2 = var_3.origin;
  var_2._id_5BC3 = var_3.angles;
}

_id_3094() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 320;
  var_0._id_4CAA = 640;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_intro_us_cam_a_ar";
  var_0._id_8CDB[0]._id_A4E3 = 161;
  return var_0;
}

_id_3095() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 160;
  var_0._id_4CAA = 680;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_intro_op_cam_a";
  var_0._id_8CDB[0]._id_A4E3 = 240;
  return var_0;
}

_id_3090() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_idle_us_cam_ar";
  var_0._id_8CDB[0]._id_A4E3 = 191;
  return var_0;
}

_id_3091() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_idle_op_cam";
  var_0._id_8CDB[0]._id_A4E3 = 161;
  return var_0;
}

_id_308C() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_BB78 = 5;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 80;
  var_0._id_4CAA = 260;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_op_cam_a_1st";
  var_0._id_8CDB[0]._id_A4E3 = 489;
  return var_0;
}

_id_308D() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 105;
  var_0._id_BB78 = 20;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 100;
  var_0._id_4CAA = 200;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_op_cam_a_2nd";
  var_0._id_8CDB[0]._id_A4E3 = 236;
  return var_0;
}

_id_308E() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 90;
  var_0._id_BB78 = 0;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 120;
  var_0._id_4CAA = 240;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_op_cam_a_3rd";
  var_0._id_8CDB[0]._id_A4E3 = 211;
  return var_0;
}

_id_3088() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_BB78 = 0;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 140;
  var_0._id_4CAA = 200;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var_0._id_8CDB[0]._id_A4E3 = 80;
  var_0._id_8CDB[1] = spawnStruct();
  var_0._id_8CDB[1]._id_5F36 = 80;
  var_0._id_8CDB[1]._id_A4E3 = 117;
  var_0._id_8CDB[1]._id_5F2D = 0;
  var_0._id_8CDB[1]._id_5F31 = "zombiearcade";
  var_0._id_8CDB[2] = spawnStruct();
  var_0._id_8CDB[2]._id_5F36 = 117;
  var_0._id_8CDB[2]._id_A4E3 = 351;
  var_0._id_8CDB[2]._id_5F2D = 0;
  var_0._id_8CDB[2]._id_5F31 = "zombiedefault";
  return var_0;
}

_id_3089() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_us_cam_a_1st_ar";
  var_0._id_8CDB[0]._id_A4E3 = 45;
  var_0._id_8CDB[0]._id_5F2D = 16;
  var_0._id_8CDB[0]._id_5F31 = "zombiearcade";
  var_0._id_8CDB[1] = spawnStruct();
  var_0._id_8CDB[1]._id_5F36 = 45;
  var_0._id_8CDB[1]._id_F26F = 1.0;
  var_0._id_8CDB[1]._id_F26E = 0.333;
  var_0._id_8CDB[1]._id_F270 = 4.0;
  var_0._id_8CDB[1]._id_A4E3 = 165;
  var_0._id_8CDB[2] = spawnStruct();
  var_0._id_8CDB[2]._id_5F36 = 165;
  var_0._id_8CDB[2]._id_F26F = 0.333;
  var_0._id_8CDB[2]._id_F26E = 1.0;
  var_0._id_8CDB[2]._id_F270 = 2.0;
  var_0._id_8CDB[2]._id_A4E3 = 251;
  return var_0;
}

_id_308A() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 51;
  var_0._id_BB78 = 0;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 100;
  var_0._id_4CAA = 200;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_us_cam_a_2nd";
  var_0._id_8CDB[0]._id_A4E3 = 140;
  return var_0;
}

_id_308B() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 60;
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 120;
  var_0._id_4CAA = 240;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_us_cam_a_3rd";
  var_0._id_8CDB[0]._id_A4E3 = 171;
  return var_0;
}

_id_3099() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 80;
  var_0._id_4CAA = 160;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_us_cam_a_1st";
  var_0._id_8CDB[0]._id_A4E3 = 300;
  return var_0;
}

_id_309A() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 48;
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 100;
  var_0._id_4CAA = 200;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_us_cam_a_2nd";
  var_0._id_8CDB[0]._id_A4E3 = 156;
  return var_0;
}

_id_309B() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 85;
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 120;
  var_0._id_4CAA = 240;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_us_cam_a_3rd";
  var_0._id_8CDB[0]._id_A4E3 = 161;
  return var_0;
}

_id_309C() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 50;
  var_0._id_4CAB = 80;
  var_0._id_4CAA = 160;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 5.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_op_cam_a_1st";
  var_0._id_8CDB[0]._id_A4E3 = 401;
  return var_0;
}

_id_309D() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 91;
  var_0._id_BB78 = 10;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 100;
  var_0._id_4CAA = 200;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_op_cam_a_2nd";
  var_0._id_8CDB[0]._id_A4E3 = 166;
  return var_0;
}

_id_309E() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_428E = 59;
  var_0._id_BB78 = 0;
  var_0._id_4CB1 = 10;
  var_0._id_4CB0 = 80;
  var_0._id_4CAB = 120;
  var_0._id_4CAA = 240;
  var_0._id_4CAF = 7;
  var_0._id_4CA9 = 4.5;
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 45;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_op_cam_a_3rd";
  var_0._id_8CDB[0]._id_A4E3 = 131;
  return var_0;
}

_id_3093() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 34.3;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_intro_cam_A";
  var_0._id_8CDB[0]._id_A4E3 = 116;
  var_0._id_8CDB[1] = spawnStruct();
  var_0._id_8CDB[1]._id_5F36 = 116;
  var_0._id_8CDB[1]._id_5F2E = 46.8;
  var_0._id_8CDB[1]._id_E9FA = "iw8_mp_end_game_intro_cam_B";
  var_0._id_8CDB[1]._id_A4E3 = 160;
  return var_0;
}

_id_3092() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 46.8;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_idle_cam";
  return var_0;
}

_id_3096() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_5F2E = 34.3;
  var_0._id_8CDB[0]._id_A4E3 = 396;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_execute_stab_cam";
  return var_0;
}

_id_3084() {
  var_0 = spawnStruct();
  var_0._id_8CDB = [];
  var_0._id_8CDB[0] = spawnStruct();
  var_0._id_8CDB[0]._id_5F36 = 0;
  var_0._id_8CDB[0]._id_A4E3 = 34;
  var_0._id_8CDB[0]._id_5F2E = 34.3;
  var_0._id_8CDB[0]._id_E9FA = "iw8_mp_end_game_mercy_punch_cam_A";
  var_0._id_8CDB[1] = spawnStruct();
  var_0._id_8CDB[1]._id_5F36 = 34;
  var_0._id_8CDB[1]._id_5F2E = 46.8;
  var_0._id_8CDB[1]._id_A4E3 = 253;
  var_0._id_8CDB[1]._id_E9FA = "iw8_mp_end_game_mercy_punch_cam_B";
  return var_0;
}

_id_B874(var_0, var_1) {
  var_2 = var_0._id_8CDB[0];
  var_2._id_91AD = spawn("script_model", var_1.origin);
  var_2._id_91AD setModel("tag_origin");
  var_2._id_91AD.origin = var_1.origin;
  var_2._id_91AD.angles = var_1.angles;
  var_2._id_91AD _meth_82CC(var_2._id_E9FA);
}

_id_B902(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_8CDB.size; var_2++) {
    var_3 = var_0._id_8CDB[var_2];
    var_4 = undefined;

    if(var_2 > 0) {
      var_4 = var_0._id_8CDB[var_2 - 1];
    }

    if(isDefined(var_3._id_E9FA)) {
      var_3._id_2FF9 = spawn("script_model", var_1.origin);
      var_3._id_2FF9 setModel("tag_origin");
      var_3._id_2FF9.origin = var_1.origin;
      var_3._id_2FF9.angles = var_1.angles;
      var_3._id_2FF9 _meth_82CC(var_3._id_E9FA);
    } else
      var_3._id_2FF9 = var_4._id_2FF9;

    if(isDefined(var_3._id_5F2E)) {
      var_3._id_01D8 = var_3._id_5F2E;
      continue;
    }

    var_3._id_01D8 = var_4._id_01D8;
  }

  var_0._id_4204 = 0;
}

_id_3081(var_0, var_1, var_2) {
  self endon("play_cam_track");
  self endon("broshot_done");
  self notify("trackActivated");
  self endon("trackActivated");
  var_3 = var_0._id_8CDB[var_0._id_4204];
  _id_B9E2(var_3._id_01D8);

  if(istrue(var_1)) {
    if(isDefined(var_3._id_91AD)) {
      childthread _id_3097(var_3._id_91AD, var_3._id_2FF9, 0.5);
    } else {
      var_4 = spawn("script_model", level._id_2C26[var_2 - 1]._id_5BC2);
      var_4 setModel("tag_origin");
      var_4.angles = level._id_2C26[var_2 - 1]._id_5BC3;
      childthread _id_3097(var_4, var_3._id_2FF9, 0.5);
    }
  } else {
    foreach(var_6 in level.players) {
      if(isbot(var_6)) {
        continue;
      }
      var_6 _meth_8060();
      var_6 cameralinkto(var_3._id_2FF9, "tag_origin", 1);
    }

    level._id_8F82 = var_3._id_2FF9;
  }

  if(isDefined(var_3._id_5F2D) && isDefined(var_3._id_5F31)) {
    childthread _id_4CB2(var_3._id_5F2D, var_3._id_5F31);
  }

  if(isDefined(var_3._id_F26E)) {}

  if(isDefined(var_3._id_A4E3)) {
    wait((var_3._id_A4E3 - var_3._id_5F36) / 30.0);
  }

  var_0._id_4204++;
  return isDefined(var_0._id_8CDB[var_0._id_4204]);
}

_id_3097(var_0, var_1, var_2) {
  if(isDefined(level._id_8F82)) {
    var_3 = getdvarfloat("#x394d1da38be4893e7");
    setDvar("#x394d1da38be4893e7", 2.0);
    var_4 = level._id_8F82.origin;
    var_5 = level._id_8F82.angles;
    level._id_F045 = spawn("script_model", var_4);
    level._id_F045 setModel("tag_origin");
    level._id_F045.angles = var_5;

    foreach(var_7 in level.players) {
      if(isbot(var_7)) {
        continue;
      }
      var_7 _meth_8060();
      var_7 cameralinkto(level._id_F045, "tag_origin", 1);
    }

    level._id_F045 moveto(var_0.origin, var_2, 0, var_2 / 2.0);
    level._id_F045 rotateto(var_0.angles, var_2, 0, var_2 / 2.0);
    level._id_8F82 = level._id_F045;
    wait(var_2);
    setDvar("#x394d1da38be4893e7", var_3);
  } else
    level._id_8F82 = var_1;

  foreach(var_7 in level.players) {
    if(isbot(var_7)) {
      continue;
    }
    var_7 _meth_8060();
    var_7 cameralinkto(var_1, "tag_origin", 1);
  }

  level._id_8F82 = var_1;
}

_id_C613() {
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }
    var_1 _meth_8577("default");
  }
}

_id_4CB2(var_0, var_1) {
  wait(var_0 / 30.0);

  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }
    var_3 _meth_8577(var_1);
  }
}

_id_30A3() {
  self endon("broshot_done");
  _id_B9E2(34.3);
  level._id_2FF9 _meth_82CC("iw8_mp_end_game_intro_cam_A");
  wait 3.86667;
  _id_B9E2(46.8);
  level._id_2FF9 _meth_82CC("iw8_mp_end_game_intro_cam_B");
}

_id_30A4() {
  _id_B9E2(34.3);
  level._id_2FF9 _meth_82CC("iw8_mp_end_game_execute_stab_cam");
}

_id_30A2() {
  self endon("broshot_done");
  _id_B9E2(34.3);
  level._id_2FF9 _meth_82CC("iw8_mp_end_game_mercy_punch_cam");
  wait 1.13333;
  _id_B9E2(46.8);
}

_id_4C47(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("taunt_start");
  self endon("broshot_done");
  var_8 = var_2 - 0.5;

  if(var_8 > 0) {
    wait(var_8);
    _id_B874(level._id_2FF6[var_0], level._id_2FFD._id_33F6[var_0]);
  } else
    var_8 = 0;

  wait(var_2 - var_8);
  _id_B902(level._id_2FF6[var_0], level._id_2FFD._id_33F6[var_0]);
  var_9 = "ui_broshot_anim_" + var_0;
  var_10 = "ui_broshot_anim_" + var_0;
  setomnvar(var_10, var_1);

  if(isDefined(var_3)) {
    thread _id_4E76(var_3, var_5, var_4, var_6, var_7);
  }

  var_11 = 300;
  var_12 = float(var_11) / 30.0;
  var_13 = var_12;
  wait(var_13);
  level._id_EF2F = 1;
  self notify("taunt_end");
}

_id_4E76(var_0, var_1, var_2, var_3, var_4) {
  self endon("broshot_done");

  if(!isDefined(level._id_5344)) {
    _func_0428("end_of_round");
    level._id_5344 = 1;
  }

  wait(var_0);
  _func_01F0(1.0, var_1, var_3);
  wait(var_2);
  _func_01F0(var_1, 1.0, var_4);
}

_id_4E82(var_0, var_1) {
  self notify("taunt_start");
  self endon("broshot_done");

  if(isDefined(self._id_33DA)) {
    var_2 = level._id_1A39[self._id_33DA._id_1A35];
    var_3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_2, "taunts", var_1 - 1);
  } else
    var_3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "taunts", var_1 - 1);

  if(isDefined(level._id_AD48)) {
    var_0 = level._id_AD48 - 1;
  }

  if(isDefined(level._id_AD60)) {
    var_3 = _func_0222("mp/cac/taunts.csv", 0, level._id_AD60, 1);
  }

  var_4 = tablelookuprownum("mp/cac/taunts.csv", 1, var_3);
  var_5 = _func_0222("mp/cac/taunts.csv", 0, var_4, 5);

  if(var_5 == "") {
    return;
  }
  var_6 = _func_0222("mp/cac/taunts.csv", 0, var_4, 19);
  var_7 = _func_0222("mp/cac/taunts.csv", 0, var_4, 20);
  var_8 = _func_0222("mp/cac/taunts.csv", 0, var_4, 21);
  var_9 = _func_0222("mp/cac/taunts.csv", 0, var_4, 12) == "Y";
  var_10 = _func_0222("mp/cac/taunts.csv", 0, var_4, 9);
  var_11 = "ui_broshot_anim_" + var_0;

  if(isDefined(level._id_841A[var_0]) && level._id_841A[var_0] == var_10) {
    self notify("taunt_end");
    return;
  }

  var_12 = 1;

  if(!isDefined(level._id_5BDD[var_11]) && !var_12) {
    if(!(var_9 && isDefined(level._id_EB2C[var_11]))) {
      level._id_5BDD[var_11] = 1;
      _id_BE6D(var_11);
    }

    if(!var_9) {
      level._id_EB2C[var_11] = undefined;
    }
  }

  if(var_9 && !isDefined(level._id_EB2C[var_11])) {
    level._id_5BDD[var_11] = undefined;
    _id_EDD8(var_11, var_5);
    level._id_EB2C[var_11] = 1;
  }

  var_13 = _func_0222("mp/cac/taunts.csv", 0, var_4, 17);
  var_14 = _func_0222("mp/cac/taunts.csv", 0, var_4, 18);

  if(var_0 > 0 && var_13 != "" && var_14 != "") {
    if(var_0 == 1) {
      var_10 = var_13;
    } else if(var_0 == 2) {
      var_10 = var_14;
    }
  }

  _id_07B8::_id_BD6B(var_10, var_0, 1);
  var_15 = "ui_broshot_anim_" + var_0;
  setomnvar(var_15, var_4);
  var_16 = float(var_8) / 30.0;
  var_17 = var_16;

  if(var_6 != "") {
    var_17 = var_17 * float(var_6);
  }

  level._id_2FF9 _meth_82CA();
  level._id_2FF9.angles = level._id_2FFD._id_22B1.angles;
  level._id_2FF9.origin = level._id_2FFD._id_22B1.origin;
  level._id_2FF9 _meth_82CC("iw8_mp_end_game_execute_stab_cam");
  level._id_841A[var_0] = var_10;
  thread _id_841B(var_0, var_16);
  wait(var_17);
  level._id_EF2F = 1;
  self notify("taunt_end");
}

_id_BEC8(var_0, var_1) {
  self endon("broshot_done");
  wait(var_1 - 0.1);
  level._id_2FF9 _meth_82CA();
  level._id_2FF9.angles = level._id_2FFD._id_22B1.angles;
  level._id_2FF9.origin = level._id_2FFD._id_22B1.origin;
  self _meth_82CC(var_0);
}

_id_841B(var_0, var_1) {
  self notify("combo_started_" + var_0);
  self endon("combo_started_" + var_0);
  wait(var_1);
  level._id_841A[var_0] = undefined;
}

_id_68B3() {
  var_0 = _id_69E5(self);

  if(issubstr(var_0, "iw7_nrg") || issubstr(var_0, "iw7_udm45") || issubstr(var_0, "iw7_ump45_mpr_akimbo")) {
    return "_alt";
  }

  return "";
}

_id_6A86() {
  var_0 = _id_69E5(self);

  if(issubstr(var_0, "minilmg_mpl")) {
    return "augfury";
  }

  if(issubstr(var_0, "akimbo")) {
    return "akimbo";
  }

  if(issubstr(var_0, "mp28")) {
    return "mp28";
  }

  if(issubstr(var_0, "chargeshot") || issubstr(var_0, "venom")) {
    return "assault_rifle";
  }

  if(issubstr(var_0, "knife")) {
    return "knife";
  }

  if(issubstr(var_0, "axe")) {
    return "axe";
  }

  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  switch (var_1) {
    case "weapon_melee":
      return "melee";
    case "weapon_pistol":
      return "pistol";
    case "weapon_beam":
    case "weapon_smg":
      return "smg";
    case "weapon_assault":
      return "assault_rifle";
    case "weapon_lmg":
      return "lmg";
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return "sniper";
    case "weapon_shotgun":
      return "shotgun";
    case "weapon_projectile":
      return "launcher";
    default:
      return "akimbo";
  }
}

_id_6A85() {
  var_0 = _id_69E5(self);
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(issubstr(var_0, "minilmg_mpl")) {
    return 11;
  }

  if(issubstr(var_0, "mp28")) {
    return 12;
  }

  if(issubstr(var_0, "akimbo") && !issubstr(var_0, "akimbofmg") && !issubstr(var_0, "mod_akimboshotgun")) {
    if(issubstr(var_0, "iw7_nrg") || issubstr(var_0, "iw7_udm45") || issubstr(var_0, "iw7_ump45_mpr_akimbo")) {
      return 13;
    }

    return 8;
  }

  if(issubstr(var_0, "chargeshot") || issubstr(var_0, "venom")) {
    return 2;
  }

  if(issubstr(var_0, "knife")) {
    return 9;
  }

  if(issubstr(var_0, "axe")) {
    return 10;
  }

  if(issubstr(var_0, "nunchuk") || issubstr(var_0, "katana")) {
    return 7;
  }

  switch (var_1) {
    case "weapon_pistol":
      return 0;
    case "weapon_beam":
    case "weapon_smg":
      return 1;
    case "weapon_assault":
      return 2;
    case "weapon_lmg":
      return 3;
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return 4;
    case "weapon_shotgun":
      return 5;
    case "weapon_projectile":
      return 6;
    case "weapon_melee":
    default:
      return 7;
  }
}

_id_D587(var_0) {
  var_1 = "ui_broshot_weapon_type_" + var_0;

  if(var_0 > 2) {
    setomnvar(var_1, 7);
  } else {
    setomnvar(var_1, _id_6A85());
  }
}

_id_BE6D(var_0) {
  var_1 = _id_6A86();
  var_2 = var_1 + "_put_away" + _id_68B3();
  var_3 = tablelookuprownum("mp/cac/taunts.csv", 1, var_2);
  setomnvar(var_0, -1);
  var_4 = _id_6A8B(var_1);
  wait(var_4);
}

_id_EDD8(var_0, var_1) {
  var_2 = _id_6CFB(var_1) + "transout_0";
  var_3 = tablelookuprownum("mp/cac/taunts.csv", 1, var_2);
  setomnvar(var_0, var_3 + 30000);
  var_4 = _id_6CFA(var_1);
  wait(var_4);
}

_id_6CFB(var_0) {
  var_1 = "";

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = "war_";
      break;
  }

  return var_1;
}

_id_6A8B(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "akimbo":
    default:
      var_1 = 1.067;
      break;
    case "launcher":
      var_1 = 1.567;
      break;
    case "lmg":
      var_1 = 1.333;
      break;
    case "pistol":
      var_1 = 2.233;
      break;
    case "shotgun":
      var_1 = 1.233;
      break;
    case "mp28":
    case "smg":
      var_1 = 1.2;
      break;
    case "sniper":
      var_1 = 1.367;
      break;
    case "assault_rifle":
      var_1 = 1.233;
      break;
    case "melee":
      var_1 = 1.233;
      break;
  }

  return var_1 - 0.2;
}

_id_6CFA(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = 1.733;
      break;
  }

  return var_1 - 0.2;
}

_id_6CF9(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case "archetype_assault":
    default:
      var_1 = 1.267;
      break;
  }

  return var_1 - 0.2;
}

_id_3AF6(var_0, var_1) {
  return var_0._id_038F >= var_1._id_038F;
}

onplayerconnect() {
  self endon("broshot_done");

  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      thread _id_E6E0(var_0);
    }
  }
}

_id_E6E0(var_0) {
  var_0 endon("disconnect");
  wait 0.25;
  var_0 cameralinkto(level._id_2FF9, "tag_origin", 1);
  var_1 = var_0 getentitynumber();
  _func_033B(var_1, self._id_A366);
}

_id_33E6(var_0, var_1) {
  level._id_AD5D = var_0;
  var_2 = var_1 - 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  switch (var_0) {
    case 1:
    default:
      var_3 = 4;
      var_4 = 18;
      var_5 = 6;
      break;
    case 2:
      var_3 = 12;
      var_4 = 5;
      var_5 = 1;
      break;
    case 3:
      var_3 = 28;
      var_4 = 1;
      var_5 = 2;
      break;
    case 4:
      var_3 = 57;
      var_4 = 28;
      var_5 = 3;
      break;
    case 5:
      var_3 = 45;
      var_4 = 39;
      var_5 = 4;
      break;
    case 6:
      var_3 = 27;
      var_4 = 31;
      var_5 = 5;
      break;
  }

  self._id_A366 = [];
  var_6 = max(var_1, level._id_F348.size);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    self._id_A366[var_7] = spawnStruct();
    self._id_A366[var_7].rigindex = var_5;
    self._id_A366[var_7]._id_009D = var_4;
    self._id_A366[var_7]._id_0218 = var_3;
    self._id_A366[var_7]._id_04FE = _id_69E5(level.players[0]);
    self._id_A366[var_7]._id_00E7 = level.players[0] _meth_8587();
    self._id_A366[var_7].name = level.players[0].name;
    self._id_A366[var_7]._id_0509 = level.players[0] getxuid();
    self._id_A366[var_7]._id_B991 = var_1;
    self._id_A366[var_7]._id_39A3 = level.players[0] getentitynumber();

    if(!isDefined(level._id_F348[var_7])) {
      self._id_F348[var_7] = spawnStruct();
      level._id_F348[var_7]._id_2BF3 = _id_99DE(var_7, level._id_2FFD._id_33F6[var_7]);
    }
  }

  for(var_7 = 0; var_7 < var_6; var_7++) {
    level._id_F348[var_7] _id_D587(var_7);
  }

  waitframe();
  _func_033B(-1, self._id_A366);
}

_id_33E8(var_0) {
  level._id_AD60 = var_0;
}

_id_33E7(var_0) {
  level._id_AD48 = var_0;

  if(!isDefined(level._id_F348[var_0 - 1])) {
    var_1 = 0;

    if(isDefined(level._id_AD5D)) {
      var_1 = level._id_AD5D;
    }

    _id_33E6(var_1, var_0);
  }
}