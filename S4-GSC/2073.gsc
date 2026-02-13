/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2073.gsc
*************************************************/

init() {
  if(getdvarint("#x3a6e1a518ba5d320", 0) == 0) {
    return;
  }
  level._id_FE2D = getdvarint("#x34cfe9c598eab37b", 0) == 1;
  level._id_FED1 = getdvarint("#x35abdb4af2562fc42", 0) == 1;
  level._id_FED2 = getdvarint("#x35f608964a8d1cc36", 1) == 1;
  level._id_355C = scripts\mp\utility\game::matchmakinggame() && getdvarint("#x3672bdbced97deb98", 1) == 1;
  level._id_FECE = 0;
  level._id_1F95 = [];

  foreach(var_1 in level._id_EF89) {
    level._id_1F95[var_1] = [];
  }

  level thread _id_8294();
  _id_000F::_id_990C("tac_ops_spawn_focus_changed", ::_id_52E8);
  _id_0AA3::_id_C28D(::_id_898F);
}

_id_46DE() {}

_id_36FF() {
  var_0 = [];
  var_0[0] = "lane01_";
  var_0[1] = "lane02_";
  var_0[2] = "lane03_";
  var_1 = [];
  var_1[var_1.size] = var_0[0] + (randomint(3) + 1);
  var_1[var_1.size] = var_0[1] + (randomint(3) + 1);
  var_1[var_1.size] = var_0[2] + (randomint(3) + 1);
  _id_D6D8(var_1, "allies");
  var_2 = [];
  var_2[var_1.size] = var_0[0] + (randomint(3) + 1);
  var_2[var_1.size] = var_0[1] + (randomint(3) + 1);
  var_2[var_1.size] = var_0[2] + (randomint(3) + 1);
  _id_D6D8(var_2, "axis");
  _id_FD2F();

  for(;;) {
    wait 10.0;
    var_1 = [];
    var_1[var_1.size] = var_0[0] + (randomint(3) + 1);
    var_1[var_1.size] = var_0[1] + (randomint(3) + 1);
    var_1[var_1.size] = var_0[2] + (randomint(3) + 1);
    _id_D6D8(var_1, "allies");
    var_2 = [];
    var_2[var_2.size] = var_0[0] + (randomint(3) + 1);
    var_2[var_2.size] = var_0[1] + (randomint(3) + 1);
    var_2[var_2.size] = var_0[2] + (randomint(3) + 1);
    _id_D6D8(var_2, "axis");
    _id_FD2F();
  }
}

_id_D6D8(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_1F95[var_1]) {
    if(issubstr(var_4, "dynamic") || issubstr(var_4, "vehicle") || issubstr(var_4, "squad")) {
      var_2[var_2.size] = var_4;
    }
  }

  level._id_1F95[var_1] = [];

  foreach(var_7 in var_0) {
    if(!scripts\engine\utility::array_contains(level._id_1F95[var_1], var_7)) {
      level._id_1F95[var_1][level._id_1F95[var_1].size] = var_7;
    }
  }

  foreach(var_7 in var_2) {
    if(!scripts\engine\utility::array_contains(level._id_1F95[var_1], var_7)) {
      level._id_1F95[var_1][level._id_1F95[var_1].size] = var_7;
    }
  }
}

_id_15D6(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(level._id_1F95[var_1], var_0)) {
    level._id_1F95[var_1][level._id_1F95[var_1].size] = var_0;
  }
}

_id_C521(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_1F95[var_1]) {
    if(var_4 != var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  level._id_1F95[var_1] = var_2;
}

_id_FD2F() {
  level notify("tac_ops_map_changed");
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(getdvarint("#x386b12880a7d57d13") == 1) {
    _id_0817::_id_D461("Default", "Crit_Default");
  } else {}

  _id_D8B5();
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "arm" || var_0 == "base") {
    _id_D8B4();
  }
}

_id_D8B5() {
  while(!isDefined(level._id_60D5)) {
    waitframe();
  }

  level._id_E371 = [];

  foreach(var_1 in level._id_EF89) {
    var_2 = _id_0817::_id_6D4E(level._id_60D5[var_1]);
    _id_0817::_id_C2B8(var_1, var_2);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4.target) || var_4.target == "") {
        continue;
      }
      var_5 = getEntArray(var_4.target, "targetname");

      if(!isDefined(var_5) || var_5.size == 0) {
        var_5 = scripts\engine\utility::getstructarray(var_4.target, "targetname");
      }

      if(var_5.size == 0) {
        continue;
      }
      var_6 = undefined;

      if(var_5.size == 1) {
        var_6 = var_5[0];
      } else if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
        foreach(var_8 in var_5) {
          if(isDefined(var_8._id_039B) && var_8._id_039B == level._id_96CC) {
            var_6 = var_8;
            break;
          }
        }
      } else {
        var_10 = undefined;

        foreach(var_8 in var_5) {
          var_12 = distancesquared(var_4.origin, var_8.origin);

          if(!isDefined(var_10) || var_12 < var_10) {
            var_6 = var_8;
            var_10 = var_12;
          }
        }
      }

      if(!isDefined(var_6)) {
        continue;
      }
      var_14 = var_6._id_CD99;
      var_15 = var_1;

      if(isDefined(var_6._id_CE7D) && scripts\mp\utility\teams::_id_8878(var_6._id_CE7D) && level.gametype != "base" && level.gametype != "arm") {
        if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_quarry2" && var_6._id_0481 == "gw_fob_03_safe_axis") {
          var_15 = "axis";
        } else {
          var_15 = var_6._id_CE7D;
        }
      }

      if(isDefined(level._id_E371[var_14]) && isDefined(level._id_E371[var_14][var_15])) {
        var_16 = level._id_E371[var_14][var_15];

        if(!scripts\engine\utility::array_contains(var_16._id_E34D, var_4)) {
          var_16._id_E34D[var_16._id_E34D.size] = var_4;
        }

        continue;
      }

      var_17 = spawnStruct();
      var_17.origin = var_6.origin;
      var_17.angles = var_6.angles;
      var_17._id_E34D = [];
      var_17._id_E34D[0] = var_4;

      if(!issubstr(var_14, "safe")) {
        _id_828E(var_15, var_17, var_14);
      } else {
        level._id_E371[var_14][var_15] = var_17;
      }
    }

    foreach(var_21, var_20 in level._id_E371) {
      if(isDefined(var_20[var_1])) {
        _id_0817::_id_C2B9(var_21 + "_" + var_1, var_20[var_1]._id_E34D);
      }
    }
  }

  level._id_FECE = getdvarint("#x3a6e1a518ba5d320", 0) == 1 && level._id_E371.size > 0;

  if(level._id_FECE) {
    level._id_6D4A = ::_id_6D4A;
  }
}

_id_828E(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_2);
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_1._id_1782 = var_4;
  var_1._id_F8E2 = var_3;
  var_1._id_F8E5 = var_2;
  var_1.owner = "allies";

  if(!issubstr(var_2, "HQ") && !issubstr(var_2, "vehicle")) {
    var_5 = _id_6AF2(var_2 + "_" + level._id_96CC);

    if(!isDefined(var_5) || var_5 == -1) {
      var_1._id_8E7F = var_3;
    } else {
      var_1._id_8E7F = var_5;
    }
  } else
    var_1._id_8E7F = var_3;

  if(isDefined(var_1._id_50B4)) {
    var_4 linkto(var_1._id_50B4);
  }

  level._id_E371[var_2][var_0] = var_1;
}

_id_6AF2(var_0) {
  var_1 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_0);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  return var_1;
}

_id_D470(var_0, var_1, var_2) {
  level._id_E371[var_0][var_1]._id_1782 = var_2;
}

_id_D8B4() {
  level._id_E304 = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    var_1 = scripts\cp_mp\utility\game_utility::_id_6B17("gw_fob_0" + var_0 + "_spawnInfluenceZone");

    if(!isDefined(var_1)) {
      continue;
    }
    _id_0AA6::_id_99E8(var_1, ::_id_E302, ::_id_E303);
    var_1._id_F396 = [];
    level._id_E304["gw_fob_0" + var_0] = var_1;
  }
}

_id_E302(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }
  var_1._id_F396 = scripts\engine\utility::array_add(var_1._id_F396, var_0);
}

_id_E303(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }
  var_1._id_F396 = scripts\engine\utility::array_remove(var_1._id_F396, var_0);
}

_id_8A99(var_0) {
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in self._id_F396) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.team) && var_4.team == var_0) {
      var_1 = 1;
    }

    var_2[var_2.size] = var_4;
  }

  self._id_F396 = var_2;
  return var_1;
}

_id_6D4A() {
  if(_id_0817::_id_DC06()) {
    var_0 = _id_0817::_id_6D4E(level._id_60D6[self.team]);
    var_1 = _id_0817::_id_6D4D(var_0);
    return var_1;
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  self._id_10A1F = 0;

  if(!isDefined(self._id_D066)) {
    if(self.team == "allies") {
      self._id_D066 = "gw_fob_alliesHQ";
    } else {
      self._id_D066 = "gw_fob_axisHQ";
    }
  }

  if(isDefined(self._id_D066)) {
    if(issubstr(self._id_D066, "squad")) {
      var_4 = undefined;

      if(self._id_D066 == "squad_leader") {
        var_4 = level._id_E48E[self.team][self._id_E496]._id_E49C;
      } else {
        var_4 = int(_func_00D6(self._id_D066, self._id_D066.size - 1, self._id_D066.size));
      }

      var_5 = level._id_E48E[self.team][self._id_E496].players[var_4];
      var_1 = _id_0818::_id_5B07(var_5);

      if(!isredeploying()) {
        var_5 thread _id_0A9F::_id_7003("squad_spawn");
        thread _id_0A9F::_id_7003("squad_spawn_self");
      }

      self._id_10A1F = 1;

      if(isDefined(var_5.vehicle)) {
        self._id_E309 = 1;
        self._id_10351 = var_5.vehicle._id_1031E;
      }

      scripts\mp\utility\stats::_id_7DAE("spawnSelectSquad", 1);
      var_5 scripts\mp\utility\stats::_id_7DAE("timesSelectedAsSquadLeader", 1);
    } else if(issubstr(self._id_D066, "dynamic")) {
      var_1 = _id_0817::_id_6D4A(self, self.team, undefined, undefined, "bad");
      thread scripts\mp\gametypes\arm::_id_E33E();
    } else if(issubstr(self._id_D066, "vehicle")) {
      var_1 = _id_0817::_id_6D4A(self, self.team, undefined, undefined, "bad");
      var_6 = level._id_E371[self._id_D066][self.team]._id_50B4;
      var_1.origin = var_6.origin + anglesToForward(var_6.angles) * -200 + (0, 0, 64);
      var_1.angles = (0, var_6.angles[1], 0);
      var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_6, 1);

      if(var_7.size > 0 && istrue(_id_09E1::_id_10116(var_6))) {
        var_8 = spawnStruct();
        var_8._id_FE9B = 1;
        var_8._id_54E5 = "spawned_player";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_6, var_7[0], self, var_8);
      }

      self._id_E309 = 1;
      scripts\mp\utility\stats::_id_7DAE("spawnSelectVehicle", 1);
    } else {
      if(isDefined(level._id_E304) && level.gametype != "base") {
        var_9 = undefined;
        var_10 = getarraykeys(level._id_E304);

        foreach(var_12 in var_10) {
          if(var_12 == self._id_D066) {
            var_9 = level._id_E304[var_12];
          }
        }

        if(isDefined(var_9) && var_9 _id_8A99(scripts\mp\utility\game::_id_6BE2(self.team)[0])) {
          var_14 = self._id_D066 + "_safe_" + self.team;
          var_15 = level._id_E2F4._id_E37C[var_14];

          if(!isDefined(var_15)) {
            var_14 = self._id_D066 + "_" + self.team;
          }
        } else
          var_14 = self._id_D066 + "_" + self.team;
      } else if(scripts\engine\utility::is_equal(level.overtime_losing_team, self.team)) {
        var_14 = self._id_D066 + "_extra";
        var_3 = 1;
        self._id_C16B = 1;

        if(!isDefined(var_2)) {
          var_2 = 1200;
        }
      } else
        var_14 = self._id_D066 + "_" + self.team;

      var_1 = _id_0817::_id_6D4A(self, self.team, var_14, undefined, "bad");

      if(level.gametype == "base" && getdvarint("#x37f04f02883fb15eb", 1) == 1 && scripts\mp\gametypes\base::shouldbaseuseparachutespawns(self._id_D066)) {
        if(_id_07D1::_id_60BE("prematch_done")) {
          var_3 = 1;
          self._id_C16B = 1;

          if(!isDefined(var_2)) {
            var_2 = 2000;
          }

          if(self._id_D066 == "gw_fob_03") {
            var_2 = 1500;
            var_1.origin = var_1.origin + (0, 3000, 0);
          }
        }
      }

      if(istrue(self._id_AE39) || istrue(var_3)) {
        if(!isDefined(var_2)) {
          var_2 = 2000;
        }

        var_1.origin = var_1.origin + (0, 0, var_2);
      }
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, self.team, undefined, undefined, "bad");

  if(istrue(level._id_FED1) && istrue(self._id_E4AB)) {
    var_16 = self getspectatingplayer();

    if(isDefined(var_16) && isDefined(self._id_E496) && self.team == var_16.team && self._id_E496 == var_16._id_E496) {
      var_1 = _id_0818::_id_5B07(var_16);
      var_16 thread _id_0A9F::_id_700C("squad_spawn");
      thread _id_0A9F::_id_700C("squad_spawn_self");
      self._id_10A1F = 1;
    }
  }

  return var_1;
}

_id_C1AB() {
  for(var_0 = 0; var_0 < 16; var_0++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_0, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var_0, -1);

    if(scripts\mp\utility\game::getgametype() == "base" && var_0 < 7) {
      self setclientomnvar("ui_base_spawn_objective_index_" + var_0, 0);
    }
  }

  if(isDefined(self._id_5E8B)) {
    _id_B06E(self._id_5E8B);
  }

  if(scripts\mp\utility\game::getgametype() == "base") {
    if(istrue(self._id_B072)) {
      thread _id_5675();
    } else {
      thread evaluateallfobspawns();
    }
  } else
    thread _id_5670();

  if(istrue(level._id_FED2) && !istrue(self._id_B072)) {
    thread _id_5679();
  }
}

_id_5670() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  var_0 = [];

  for(;;) {
    if(var_0.size > level._id_1F95[self.team].size) {
      thread _id_C1AB();
      return;
    }

    var_1 = 0;

    foreach(var_3 in level._id_1F95[self.team]) {
      if(!isDefined(var_0[var_1])) {
        break;
      }

      if(var_0[var_1]._id_96CF != var_3) {
        thread _id_C1AB();
        return;
      }

      var_1++;
    }

    var_1 = 0;

    foreach(var_3 in level._id_1F95[self.team]) {
      var_6 = level._id_E371[var_3][self.team];

      if(var_1 == var_0.size) {
        var_7 = spawnStruct();
        var_7._id_96CF = undefined;
        var_7._id_019B = undefined;
        var_7._id_7C8C = undefined;
        var_0[var_0.size] = var_7;
      }

      if(!isDefined(var_0[var_1]._id_96CF)) {
        var_0[var_1]._id_96CF = var_3;
      }

      if(!isDefined(var_0[var_1]._id_019B)) {
        var_0[var_1]._id_019B = var_6._id_1782;
        self setclientomnvar("ui_tom_spawn_entity_" + var_1, var_6._id_1782);
      }

      var_8 = 0;
      var_9 = 0;
      var_10 = 0;

      if(isDefined(var_6._id_A8E1)) {
        var_8 = istrue(var_6._id_7DF7);
      } else if(issubstr(var_3, "vehicle")) {
        var_11 = var_6._id_50B4;

        if(isDefined(var_11) && !istrue(var_11._id_87FB)) {
          var_8 = istrue(var_11._id_7DF7);
          var_9 = _id_75B7(var_11, self);

          if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_11).size == 0 || !istrue(_id_09E1::_id_10116(var_11))) {
            var_10 = 1;
          }
        }
      }

      var_12 = var_6._id_8E7F;

      if(var_8) {
        var_12 = var_12 + 128;
      }

      if(istrue(var_10)) {
        var_12 = var_12 + 1024;
      }

      if(istrue(var_9)) {
        var_12 = var_12 + 2048;
      }

      if(!isDefined(var_0[var_1]._id_7C8C) || var_0[var_1]._id_7C8C != var_12) {
        var_0[var_1]._id_7C8C = var_12;
        self setclientomnvar("ui_tom_spawn_id_" + var_1, var_12);
      }

      var_1++;
    }

    waitframe();
  }
}

evaluateallfobspawns() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  var_0 = [];

  for(;;) {
    var_1 = 0;

    foreach(var_3 in level._id_14F5) {
      if(!isDefined(var_0[var_1])) {
        break;
      }

      if(var_0[var_1]._id_96CF != var_3.name) {
        thread _id_C1AB();
        return;
      }

      var_1++;
    }

    var_5 = [];

    foreach(var_3 in level._id_14F5) {
      if(scripts\mp\utility\game::getgametype() == "base") {
        if(scripts\mp\gametypes\obj_dom::_id_6CED(var_3.trigger._id_A90E) < 7 && (!isDefined(var_3.isgettingnuked) || var_3.isgettingnuked == 0)) {
          var_5[var_5.size] = var_3.name;
        }

        continue;
      }

      var_5[var_5.size] = var_3.name;
    }

    var_1 = 0;

    foreach(var_3 in var_5) {
      var_9 = level._id_E371[var_3][self.team];

      if(var_1 == var_0.size) {
        var_10 = spawnStruct();
        var_10._id_96CF = undefined;
        var_10._id_019B = undefined;
        var_10._id_7C8C = undefined;
        var_0[var_0.size] = var_10;
      }

      if(!isDefined(var_0[var_1]._id_96CF)) {
        var_0[var_1]._id_96CF = var_3;
      }

      if(!isDefined(var_0[var_1]._id_019B)) {
        var_0[var_1]._id_019B = var_9._id_1782;
        self setclientomnvar("ui_tom_spawn_entity_" + var_1, var_9._id_1782);

        if(scripts\mp\utility\game::getgametype() == "base") {
          var_11 = scripts\mp\gametypes\obj_dom::_id_6CED(var_9._id_A8E1);

          if(isDefined(var_11) && var_11 < 7) {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_1, var_11 + 1);
          } else {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_1, 0);
          }
        }
      }

      var_12 = var_9._id_8E7F;

      if(!isDefined(var_0[var_1]._id_7C8C) || var_0[var_1]._id_7C8C != var_12) {
        var_0[var_1]._id_7C8C = var_12;
        self setclientomnvar("ui_tom_spawn_id_" + var_1, var_12);
      }

      var_1++;
    }

    waitframe();
  }
}

_id_5675() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  var_0 = [];
  var_1 = scripts\mp\utility\game::_id_6BE2(self.team)[0];

  for(;;) {
    if(scripts\mp\utility\game::getgametype() == "base" && istrue(self._id_B072)) {
      var_2 = scripts\mp\gametypes\base::getbasesowned_notbeingnuked(var_1);
    } else {
      var_2 = level._id_1F95[var_1];
    }

    if(var_0.size > var_2.size) {
      thread _id_C1AB();
      return;
    }

    var_3 = 0;

    foreach(var_5 in var_2) {
      if(!isDefined(var_0[var_3])) {
        break;
      }

      if(var_0[var_3]._id_96CF != var_5) {
        thread _id_C1AB();
        return;
      }

      var_3++;
    }

    var_7 = undefined;
    var_8 = undefined;

    if(scripts\mp\utility\game::getgametype() == "base" && istrue(self._id_B072)) {
      var_7 = scripts\mp\gametypes\base::_id_D074(var_1)[0];

      if(isDefined(var_7)) {
        var_8 = scripts\mp\gametypes\base::_id_5AFE(var_7);
      }
    }

    var_3 = 0;

    foreach(var_5 in var_2) {
      if(scripts\engine\utility::is_equal(var_7, var_5)) {
        var_10 = 0;

        foreach(var_12 in level._id_232A) {
          if(var_12._id_A8E1 == var_8 && var_12._id_ADAE == self.team) {
            var_10 = 1;
          }
        }

        if(var_10) {
          continue;
        }
      }

      var_14 = level._id_E371[var_5][var_1];

      if(var_3 == var_0.size) {
        var_15 = spawnStruct();
        var_15._id_96CF = undefined;
        var_15._id_019B = undefined;
        var_15._id_7C8C = undefined;
        var_0[var_0.size] = var_15;
      }

      if(!isDefined(var_0[var_3]._id_96CF)) {
        var_0[var_3]._id_96CF = var_5;
      }

      if(!isDefined(var_0[var_3]._id_019B)) {
        var_0[var_3]._id_019B = var_14._id_1782;
        self setclientomnvar("ui_tom_spawn_entity_" + var_3, var_14._id_1782);

        if(scripts\mp\utility\game::getgametype() == "base") {
          var_16 = scripts\mp\gametypes\obj_dom::_id_6CED(var_14._id_A8E1);

          if(isDefined(var_16) && var_16 < 7) {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_3, var_16 + 1);
          } else {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_3, 0);
          }
        }
      }

      var_17 = var_14._id_8E7F;

      if(!isDefined(var_0[var_3]._id_7C8C) || var_0[var_3]._id_7C8C != var_17) {
        var_0[var_3]._id_7C8C = var_17;
        self setclientomnvar("ui_tom_spawn_id_" + var_3, var_17);
      }

      var_3++;
    }

    var_19 = [];

    foreach(var_5 in level._id_232A) {
      if(var_5._id_ADAE == "neutral") {
        var_19[var_19.size] = var_5._id_A8E1;
      }
    }

    var_2 = [];

    foreach(var_23 in var_19) {
      foreach(var_5 in level._id_14F5) {
        if(var_5.trigger._id_A90E == var_23) {
          var_2[var_2.size] = var_5.name;
          break;
        }
      }
    }

    foreach(var_5 in var_2) {
      var_14 = level._id_E371[var_5][var_1];

      if(var_3 == var_0.size) {
        var_15 = spawnStruct();
        var_15._id_96CF = undefined;
        var_15._id_019B = undefined;
        var_15._id_7C8C = undefined;
        var_0[var_0.size] = var_15;
      }

      if(!isDefined(var_0[var_3]._id_96CF)) {
        var_0[var_3]._id_96CF = var_5;
      }

      if(!isDefined(var_0[var_3]._id_019B)) {
        var_0[var_3]._id_019B = var_14._id_1782;
        self setclientomnvar("ui_tom_spawn_entity_" + var_3, var_14._id_1782);

        if(scripts\mp\utility\game::getgametype() == "base") {
          var_16 = scripts\mp\gametypes\obj_dom::_id_6CED(var_14._id_A8E1);

          if(isDefined(var_16) && var_16 < 7) {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_3, var_16 + 1);
          } else {
            self setclientomnvar("ui_base_spawn_objective_index_" + var_3, 0);
          }
        }
      }

      var_17 = var_14._id_8E7F;

      if(!isDefined(var_0[var_3]._id_7C8C) || var_0[var_3]._id_7C8C != var_17) {
        var_0[var_3]._id_7C8C = var_17;
        self setclientomnvar("ui_tom_spawn_id_" + var_3, var_17);
      }

      var_3++;
    }

    waitframe();
  }
}

_id_C1AD(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  waitframe();
  var_2 = level._id_E48E[var_0][var_1].players;
}

_id_895A(var_0, var_1) {
  if(level.gametype == "base") {
    return 0;
  } else {
    return level._id_A8E8[var_0]._id_ADAE != var_1 || level._id_A8E8[var_0]._id_E57B || level._id_A8E8[var_0]._id_3226 || istrue(level._id_A8E8[var_0]._id_E349) || level._id_A8E8[var_0]._id_37F6 != "none" && level._id_A8E8[var_0]._id_37F6 != var_1;
  }
}

_id_8AF9(var_0) {
  var_1 = gettime();
  var_2 = isDefined(var_0) && (isDefined(var_0._id_90A7) && var_0._id_90A7 + 5000 > var_1);
  var_3 = isDefined(var_0) && var_0 scripts\mp\outofbounds::_id_8AAA();
  var_4 = 0;

  if(isDefined(var_0.team)) {
    var_5 = scripts\common\utility::_id_B7C7(var_0.origin, 384);

    foreach(var_7 in var_5) {
      if(isDefined(var_7) && var_7.team != var_0.team && isalive(var_7) && !isDefined(var_7._id_59E0)) {
        if(abs(var_0.origin[2] - var_7.origin[2]) < 100) {
          var_4 = 1;
          break;
        }
      }
    }
  }

  return var_2 || var_3 || var_4;
}

_id_10311(var_0) {
  var_0 endon("death");
  var_0._id_7DF7 = 0;

  for(;;) {
    var_1 = gettime();
    var_2 = istrue(var_0._id_2D8B);
    var_3 = scripts\cp_mp\utility\weapon_utility::_id_8915(var_0);
    var_4 = isDefined(var_0) && (isDefined(var_0._id_90A7) && var_0._id_90A7 + 5000 > var_1);
    var_5 = isDefined(var_0) && var_0 scripts\mp\outofbounds::_id_8AAA();
    var_6 = 0;

    if(isDefined(var_0.team)) {
      var_7 = scripts\common\utility::_id_B7C7(var_0.origin, 384);

      foreach(var_9 in var_7) {
        if(isDefined(var_9) && var_9.team != var_0.team && isalive(var_9) && !isDefined(var_9._id_59E0)) {
          if(abs(var_0.origin[2] - var_9.origin[2]) < 100) {
            var_6 = 1;
            break;
          }
        }
      }
    }

    var_11 = var_0._id_7DF7;

    if(var_4 || var_5 || var_6 || var_2 || var_3) {
      var_0._id_7DF7 = 1;
    } else {
      var_0._id_7DF7 = 0;
    }

    waitframe();
  }
}

_id_75B7(var_0, var_1) {
  var_2 = level._id_E48E[self.team][self._id_E496].players;

  foreach(var_4 in var_0._id_A924) {
    foreach(var_6 in var_2) {
      if(var_6 == var_4) {
        return 1;
      }
    }
  }

  return 0;
}

_id_D6DC() {
  var_0 = scripts\engine\utility::getstructarray("axisLeft_alliesRight", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    var_1 = undefined;

    foreach(var_3 in var_0) {
      if(var_3._id_039B == level._id_96CC) {
        var_1 = var_3;
      }
    }
  } else
    var_1 = scripts\engine\utility::getstruct("axisLeft_alliesRight", "targetname");

  var_5 = [];

  foreach(var_7 in level._id_E371) {
    foreach(var_10, var_9 in var_7) {
      if(var_10 != self.team) {
        continue;
      } else {
        var_5[var_5.size] = var_9;
      }
    }
  }

  if(self.team == "axis") {
    var_12 = var_1 scripts\engine\utility::_id_1BD6(var_5, ::_id_E035);
  } else {
    var_12 = var_1 scripts\engine\utility::_id_1BD6(var_5, ::_id_E036);
  }

  foreach(var_10, var_14 in var_12) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_10, var_14._id_1782);
    self setclientomnvar("ui_tom_spawn_id_" + var_10, var_14._id_8E7F);
  }
}

_id_E035(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

_id_E036(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) > distancesquared(var_1.origin, self.origin);
}

_id_B06E(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_1F95[self.team]) {
    if(issubstr(var_3, var_0)) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level._id_E371[var_1])) {
    return;
  }
  var_5 = level._id_E371[var_1][self.team];

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = self.team == "allies";
  var_7 = 0;

  switch (var_0) {
    case "lane03_":
    case "spawn_selection_a":
    case "left":
      var_7 = scripts\engine\utility::ter_op(var_6, 0, 2);
      break;
    case "lane02_":
    case "spawn_selection_b":
    case "mid":
      var_7 = 1;
      break;
    case "lane01_":
    case "spawn_selection_c":
    case "right":
      var_7 = scripts\engine\utility::ter_op(var_6, 2, 0);
      break;
  }

  self setclientomnvar("ui_tom_spawn_entity_" + var_7, var_5._id_1782);
  self setclientomnvar("ui_tom_spawn_id_" + var_7, var_5._id_8E7F);
}

_id_C1AE() {
  var_0 = 3;

  foreach(var_2 in level._id_1F95[self.team]) {
    if(issubstr(var_2, "squad_")) {
      var_3 = level._id_E371[var_2][self.team];
      self setclientomnvar("ui_tom_spawn_entity_" + var_0, var_3._id_1782);
      self setclientomnvar("ui_tom_spawn_id_" + var_0, var_3._id_8E7F);
      var_0++;
    }
  }
}

_id_C1A8() {
  var_0 = 6;

  foreach(var_2 in level._id_1F95[self.team]) {
    if(issubstr(var_2, "dynamic_")) {
      if(!isDefined(level._id_E371[var_2][self.team])) {
        continue;
      }
      var_3 = level._id_E371[var_2][self.team];

      if(!isDefined(var_3)) {
        continue;
      }
      self setclientomnvar("ui_tom_spawn_entity_" + var_0, var_3._id_1782);
      self setclientomnvar("ui_tom_spawn_id_" + var_0, var_3._id_8E7F);
      var_0++;
    }
  }
}

_id_1082A(var_0, var_1) {
  if(istrue(level.gameended) || istrue(level._id_A731)) {
    _id_B076();
    return;
  }

  if(isDefined(self._id_D6DA) && !istrue(self._id_B072)) {
    return;
  }
  self endon("disconnect");
  self._id_D066 = undefined;
  _id_C1AB();

  if(scripts\mp\utility\game::getgametype() == "base" && istrue(self._id_B072)) {
    _id_696A();
  } else {
    _id_696B();
  }

  if(istrue(level._id_5ED0)) {
    _id_F288(1, 9);
    _id_B076();
    return;
  }

  if(isai(self) || istrue(var_1) || issubstr(self.name, "_hl_")) {
    _id_F288(var_0, 9);

    if(_id_0817::_id_DC06()) {
      return;
    }
    _id_B076();
    return;
  }

  while(!_id_07D1::_id_60BE("prematch_done")) {
    waitframe();
  }

  self _meth_8209(0.0, 0.2);
  _id_E378(var_0);
  self _meth_8209(1.0, 0.2);
}

_id_B076() {
  var_0 = scripts\engine\utility::array_randomize(level._id_1F95[self.team]);

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "fob") || issubstr(var_2, "HQ")) {
      self._id_D066 = var_2;
      return;
    }
  }
}

_id_B078(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "vehicle";
  }

  var_1 = scripts\engine\utility::array_randomize(level._id_1F95[self.team]);

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "vehicle")) {
      self._id_D066 = var_3;
      return;
    }
  }
}

_id_B077() {
  var_0 = scripts\engine\utility::array_randomize(level._id_1F95[self.team]);
  self._id_D066 = var_0[0];
  return;
}

_id_E378(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  thread _id_350D();

  if(istrue(level.gameended)) {
    return;
  }
  if(scripts\mp\utility\game::_id_8A95()) {
    return;
  }
  if(istrue(level._id_A731)) {
    return;
  }
  if(scripts\mp\utility\game::isbasegametype()) {
    if(istrue(self.waskilledduringglidebomb)) {
      scripts\engine\utility::_id_108F5("cruise_missile_finished", 10);
    }

    scripts\mp\gametypes\base::base_nukecratespawnsandcarriers_hidedistancetoplayer(self);
  }

  scripts\mp\class::_id_961E();
  thread _id_0815::_id_E722(0.0, 1.5, 0.5);
  self._id_82F2 = 1;
  self setclientomnvar("ui_hide_objectives", 1);
  thread _id_D06C(var_0);

  if(istrue(level._id_E375) || istrue(level._id_E374)) {
    thread _id_07D2::_id_5CCB();
  }

  if(istrue(level._id_DCF1)) {
    thread scripts\mp\gametypes\arm::_id_1025F();
  }

  if(istrue(level._id_DCF0)) {
    thread scripts\mp\gametypes\arm::_id_10260();
  }

  wait 0.5;

  if(!istrue(level._id_78F8)) {
    thread scripts\mp\gametypes\arm::_id_E36C();
  }

  self setclientomnvar("ui_hide_objectives", 0);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  _id_F288(var_0, 9);
  thread _id_D06D();

  if(istrue(level._id_355C)) {
    thread _id_10AEE();
  }

  for(;;) {
    var_1 = _id_10AD7();
    var_2 = 1;

    switch (var_1) {
      case "tac_ops_map_selection_valid":
        var_2 = 1;
        thread scripts\mp\gametypes\arms_race_audio::player_spawn_camera_whoosh();
        break;
      case "tac_ops_map_changed":
        var_2 = 0;
        _id_C1AB();
        break;
      case "tac_ops_map_cleared":
        var_2 = 1;
        _id_0815::_id_4790();
        break;
      case "spawned_player":
        var_2 = 1;
        _id_0815::_id_4790();
        break;
      case "tac_ops_map_game_ended":
        var_2 = 1;
        _id_0815::_id_4790();
        break;
      case "tac_ops_spawn_focus_changed":
        var_2 = 0;
        break;
      case "tac_ops_map_nuke":
        var_2 = 0;
        self setclientomnvar("ui_hide_objectives", 1);
        self setclientomnvar("ui_tac_ops_map_open", 0);
        thread _id_E376();
        break;
      case "tac_ops_map_overtime":
        var_2 = 1;
        break;
      default:
        break;
    }

    if(var_2) {
      self notify("stop_spawnselection_afk");
      self setclientomnvar("ui_tac_ops_map_open", 0);

      if(scripts\mp\utility\game::isbasegametype()) {
        scripts\mp\gametypes\base::base_nukecratespawnsandcarriers_showdistancetoplayer(self);
      }

      self._id_82F2 = 0;
      return;
    }
  }
}

_id_350D() {
  self endon("stop_spawnselection_afk");
  self endon("disconnect");

  while(!istrue(level.gameended)) {
    waitframe();
  }

  self setclientomnvar("ui_tac_ops_map_open", 0);
}

_id_10AEE() {
  self endon("disconnect");
  self endon("stop_spawnselection_afk");

  if(isDefined(level._id_E36D)) {
    wait(level._id_E36D);
  } else {
    wait 60.0;
  }

  self notify("afk_disconnection_imminent");
  wait 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

_id_D06C(var_0) {
  self endon("disconnect");
  self._id_31B6 = 0;

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "base") {
    self setclientomnvar("ui_arm_respawnTimerActive", 1);
  }

  if(var_0 > 0) {
    wait(var_0);
  }

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "base") {
    self setclientomnvar("ui_arm_respawnTimerActive", 0);
  }

  _id_0A99::_id_D5EA(16);
  self._id_31B6 = 1;

  if(isDefined(self._id_D066)) {
    _id_FF56();
  }
}

_id_FF56() {
  foreach(var_1 in level._id_1F95[self.team]) {
    if(var_1 == self._id_D066) {
      self notify("tac_ops_map_selection_made");
      return;
    }
  }

  self._id_D066 = undefined;
}

_id_D06D() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "tac_ops_spawn_area_selected") {
      var_1 = _id_FD02(var_1);
      var_2 = undefined;

      foreach(var_4 in level._id_E371) {
        if(isDefined(var_4[self.team]) && isDefined(var_4[self.team]._id_1782) && var_4[self.team]._id_1782 getentitynumber() == var_1) {
          _id_FD34(var_4[self.team]._id_F8E5, self, self.team);

          if(isDefined(var_4[self.team]._id_A8E1) && _id_895A(var_4[self.team]._id_A8E1, self.team)) {
            break;
          }

          if(isDefined(var_4[self.team]._id_F8E5) && issubstr(var_4[self.team]._id_F8E5, "vehicle") && istrue(var_4[self.team]._id_50B4._id_7DF7)) {
            break;
          }

          var_2 = var_4[self.team]._id_F8E5;
          break;
        } else if(scripts\mp\utility\game::getgametype() == "base" && istrue(self._id_B072)) {
          var_5 = scripts\mp\utility\game::_id_6BE2(self.team)[0];

          if(isDefined(var_4[var_5]) && isDefined(var_4[var_5]._id_1782) && var_4[var_5]._id_1782 getentitynumber() == var_1) {
            var_2 = var_4[self.team]._id_F8E5;
            break;
          }
        }
      }

      if(!isDefined(var_2)) {
        var_7 = _id_6D77(self.team, self._id_E496);

        foreach(var_4 in var_7) {
          if(isDefined(var_4._id_50B4) && var_4._id_50B4 getentitynumber() == var_1) {
            if(var_4._id_50B4.team != self.team || var_4._id_50B4._id_E496 != self._id_E496) {
              thread _id_C1AB();
              break;
            }

            if(_id_8A5E(var_4._id_50B4)) {
              break;
            }

            var_9 = var_4._id_50B4.vehicle;

            if(isDefined(var_9)) {
              if(var_9._id_1031E == "little_bird") {
                if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_9).size == 0 || !istrue(_id_09E1::_id_10116(var_9))) {
                  break;
                }
              }
            }

            var_10 = spawnStruct();
            var_10 = _id_0818::_id_321C(var_10, var_4._id_50B4);

            if(!isDefined(var_10._id_E353)) {
              var_4._id_50B4._id_A58A = gettime();
              break;
            }

            var_2 = var_4._id_F8E5;
            break;
          }
        }
      }

      if(!isDefined(var_2)) {
        continue;
      }
      self._id_D066 = var_2;

      if(istrue(self._id_31B6)) {
        self notify("tac_ops_map_selection_made");
        return;
      }
    }
  }
}

_id_FD02(var_0) {
  if(!isDefined(self._id_7347)) {
    self._id_7347 = [];
  }

  var_1 = 65536;
  var_2 = 131072;
  var_3 = 262144;
  var_4 = 524288;
  self._id_7347["rightmouseup"] = istrue(self._id_7347["rightmouseup"]) || (var_0 &var_1) > 0;
  self._id_7347["leftmouseup"] = istrue(self._id_7347["leftmouseup"]) || (var_0 &var_2) > 0;
  self._id_7347["activate"] = istrue(self._id_7347["activate"]) || (var_0 &var_3) > 0;
  self._id_7347["gostand"] = istrue(self._id_7347["gostand"]) || (var_0 &var_4) > 0;
  return var_0 &~(var_1 | var_2 | var_3 | var_4);
}

_id_10AD7() {
  self endon("disconnect");
  thread _id_52EA();
  thread endconditionwatcher_airredeploy();
  thread _id_52EE();
  thread _id_52EC();
  thread _id_52EB();
  thread _id_52ED();
  thread endconditionwatcher_overtimenuke();

  if(level.gametype == "base" && istrue(self._id_B072)) {
    thread endconditionwatcher_selectiontimer();
  }

  if(level.gametype == "base" && istrue(level._id_82D1) && istrue(self._id_B072)) {
    var_0 = "tac_ops_map_overtime";
  } else {
    var_0 = scripts\engine\utility::waittill_any_return_no_endon_death_7("tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke", "tac_ops_map_overtime");
  }

  self notify("tac_ops_end_condition_met");
  return var_0;
}

endconditionwatcher_selectiontimer() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionTimer()");
  self endon("endConditionWatcher_SelectionTimer()");
  var_0 = getdvarint("#x36b30e780f420eb79", 0);

  if(var_0 > 0) {
    self setclientomnvar("ui_base_nuke_selection_timer", gettime() + var_0 * 1000);
    wait(var_0);
    var_1 = scripts\mp\gametypes\base::autopickbasetonuke();
    var_2 = scripts\mp\gametypes\obj_dom::_id_6CED(var_1._id_A8E1);
    self._id_D066 = var_1.trigger._id_0481;
    self setclientomnvar("ui_base_auto_nuke_selection", var_2 + 1);
    wait 2;
    self notify("tac_ops_map_selection_valid");
  }
}

endconditionwatcher_airredeploy() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_AirRedeploy()");
  self endon("endConditionWatcher_AirRedeploy()");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(scripts\engine\utility::is_equal(var_0, "arms_race_redeploy")) {
      if(var_1 == 2) {
        if(self.team == "axis") {
          if(scripts\engine\utility::array_contains(level._id_1FED, level.axisspawnairdeploy[0])) {
            self._id_D066 = level.axisspawnairdeploy[0];
          } else {
            continue;
          }
        } else if(scripts\engine\utility::array_contains(level._id_1516, level.alliesspawnairdeploy[0]))
          self._id_D066 = level.alliesspawnairdeploy[0];
        else {
          continue;
        }

        self notify("tac_ops_map_selection_valid");
        break;
      }
    }
  }
}

_id_52EE() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("tac_ops_map_selection_made");

    if(istrue(self._id_31B6)) {
      self notify("tac_ops_map_selection_valid");
      break;
    }
  }
}

_id_52E8(var_0) {
  if(isDefined(self._id_D066)) {
    return;
  }
  self endon("disconnect");
  self notify("endConditionWatcher_FocusChanged()");
  self endon("endConditionWatcher_FocusChanged()");
  self notify("tac_ops_spawn_focus_changed");
  var_1 = undefined;

  foreach(var_3 in level._id_E371) {
    if(isDefined(var_3[self.team]) && isDefined(var_3[self.team]._id_1782) && var_3[self.team]._id_1782 getentitynumber() == var_0) {
      thread _id_8CCC(var_3[self.team]._id_1782.origin);
      var_1 = var_3[self.team]._id_F8E5;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_5 = _id_6D77(self.team, self._id_E496);

    foreach(var_3 in var_5) {
      if(isDefined(var_3._id_50B4) && var_3._id_50B4 getentitynumber() == var_0) {
        thread _id_8CCC(var_3._id_50B4.origin);
        var_1 = var_3._id_F8E5;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  self setclientomnvar("ui_tom_veh_health_percent", 0);

  if(issubstr(var_1, "squad")) {
    thread _id_9A31(var_1);
    var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_1);
    self setclientomnvar("ui_tom_previous_selection", var_8);
    return;
  }

  if(issubstr(var_1, "vehicle")) {
    thread _id_9A35(var_1);
    thread _id_9A36(var_1);
    var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_1);
    self setclientomnvar("ui_tom_previous_selection", var_8);
    return;
  }

  var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_1 + "_" + level._id_96CC);
  self setclientomnvar("ui_tom_previous_selection", var_8);

  if(isDefined(level._id_E278[var_1]) && isDefined(level._id_E278[var_1][self.team])) {
    self._id_5E98 = var_1;

    while(!_id_07D1::_id_60BE("prematch_done")) {
      waitframe();
    }

    thread _id_0815::_id_A274(0);
  }
}

_id_8CCC(var_0) {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");
  self endon("spawned_player");
  self notify("keepStreamPosFresh");
  self endon("keepStreamPosFresh");

  if(!isDefined(level._id_10F50)) {
    level._id_10F50 = max(getdvarint("#x3280bd2e3aabd7cf2", 20000) * 0.5 / 1000, 1.0);
  }

  for(;;) {
    self _meth_8282(var_0, 1);
    wait(level._id_10F50);
  }
}

_id_52EA() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_GameEnded()");
  self endon("endConditionWatcher_GameEnded()");
  level waittill("game_ended");
  self notify("tac_ops_map_game_ended");
}

_id_52EC() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapCleared()");
  self endon("endConditionWatcher_MapCleared()");
  level waittill("tac_ops_map_cleared");
  self notify("tac_ops_map_cleared");
}

_id_52EB() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapChanged()");
  self endon("endConditionWatcher_MapChanged()");
  level waittill("tac_ops_map_changed");
  self notify("tac_ops_map_changed");
}

endconditionwatcher_overtimenuke() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_OvertimeNuke()");
  self endon("endConditionWatcher_OvertimeNuke()");

  if(!istrue(level._id_82D1) && istrue(self._id_B072)) {
    level waittill("overtime_start");
  }

  self notify("tac_ops_map_overtime");
}

_id_52ED() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_Nuke()");
  self endon("endConditionWatcher_Nuke()");
  level waittill("nuke_detonated");
  self notify("tac_ops_map_nuke");
}

_id_E376() {
  if(!istrue(self._id_82F2)) {
    return;
  }
  self visionsetnakedforplayer("nuke_global_aftermath", 0.05);
  wait 2.0;

  if(!istrue(self._id_82F2)) {
    return;
  }
  self visionsetnakedforplayer("flir_0_black_to_white_heavy_damage", 0.05);
}

_id_10A5(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_E371[var_2]) && isDefined(level._id_E371[var_2][var_0])) {
    var_4 = level._id_E371[var_2][var_0];
    var_4.origin = var_1.origin + scripts\engine\utility::ter_op(isDefined(var_3), var_3, (0, 0, 0));
    var_4.angles = var_1.angles;
  } else {
    var_4 = spawnStruct();
    var_4.origin = var_1.origin + scripts\engine\utility::ter_op(isDefined(var_3), var_3, (0, 0, 0));
    var_4.angles = var_1.angles;
    var_4._id_50B4 = var_1;
    var_4._id_039B = var_2;
    _id_828E(var_0, var_4, var_2);
    _id_FD2F();
  }
}

_id_C496(var_0, var_1) {
  if(isDefined(level._id_E371[var_1]) && isDefined(level._id_E371[var_1][var_0])) {
    level._id_E371[var_1][var_0] = undefined;

    if(level._id_E371[var_1].size == 0) {
      level._id_E371[var_1] = undefined;
    }
  }

  _id_FD2F();
}

_id_6D77(var_0, var_1) {
  var_2 = [];

  if(isDefined(level._id_E4AD) && isDefined(level._id_E4AD[var_0]) && isDefined(level._id_E4AD[var_0][var_1])) {
    var_2 = level._id_E4AD[var_0][var_1];
  }

  return var_2;
}

_id_FD40(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_E4AD)) {
    level._id_E4AD = [];
  }

  if(!isDefined(level._id_E4AD[var_0])) {
    level._id_E4AD[var_0] = [];
  }

  if(!isDefined(level._id_E4AD[var_0][var_1])) {
    level._id_E4AD[var_0][var_1] = [];
  }

  if(isDefined(level._id_E4AD[var_0][var_1][var_2])) {
    if(!isDefined(var_3)) {
      level._id_E4AD[var_0][var_1][var_2] = undefined;
      return;
    }

    var_4 = level._id_E4AD[var_0][var_1][var_2];
    var_4._id_F8E5 = var_2;
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4._id_50B4 = var_3;
  } else {
    if(!isDefined(var_3)) {
      return;
    }
    var_4 = spawnStruct();
    var_4._id_F8E5 = var_2;
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4._id_50B4 = var_3;
    level._id_E4AD[var_0][var_1][var_2] = var_4;
  }
}

_id_C51D(var_0, var_1) {
  self endon("tac_ops_end_condition_met");
  _id_10A5(var_0, self, var_1);
  self waittill("death_or_disconnect");
  thread _id_1133(var_0, var_1);
}

_id_1133(var_0, var_1) {
  self endon("tac_ops_end_condition_met");
  _id_C496(var_0, var_1);
  self endon("disconnect");
  self waittill("spawned_player");
  thread _id_C51D(var_0, var_1);
}

_id_5679() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateSquadSpawn");
  self endon("evaluateSquadSpawn");

  if(scripts\mp\utility\game::getgametype() == "base") {
    var_0 = level._id_14F5.size;
  } else {
    var_0 = level._id_1F95[self.team].size;
  }

  var_1 = [];
  var_1[0] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_0");
  var_1[1] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_1");
  var_1[2] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_2");
  var_1[3] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_3");
  var_2 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_leader");
  var_3 = [];

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_5 = spawnStruct();
    var_5.guid = undefined;
    var_5._id_019B = undefined;
    var_5._id_7CD6 = undefined;
    var_3[var_4] = var_5;
  }

  var_6 = [];

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_6[var_4] = "squad_" + var_4;
  }

  for(;;) {
    var_7 = _id_07F2::_id_6D76(self.team, self._id_E496);
    var_8 = level._id_E48E[self.team][self._id_E496].players;

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(!isDefined(var_3[var_4].guid)) {
        continue;
      }
      if(!isDefined(var_8[var_4]) || var_8[var_4].guid != var_3[var_4].guid) {
        thread _id_C1AB();
        return;
      }
    }

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(var_4 < var_8.size) {
        var_9 = var_8[var_4];
      } else {
        var_9 = undefined;
      }

      var_10 = var_6[var_4];
      _id_FD40(self.team, self._id_E496, var_10, var_9);
    }

    var_11 = _id_6D77(self.team, self._id_E496);

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(var_4 < var_8.size) {
        var_9 = var_8[var_4];
      } else {
        var_9 = undefined;
      }

      var_12 = isDefined(var_9) && isDefined(var_7) && var_9 == var_7;

      if(!var_12 && istrue(level._id_E380)) {
        continue;
      }
      var_10 = var_6[var_4];
      var_13 = var_11[var_10];
      var_14 = isDefined(var_9) && isDefined(var_9.vehicle) && istrue(var_9.vehicle._id_89D9);

      if(isDefined(var_9) && self != var_9 && _id_8A61(var_9) && !istrue(var_14)) {
        var_15 = istrue(var_9._id_7DF7);
        var_16 = var_1[var_4];

        if(var_15) {
          var_16 = var_16 + 128;
        }

        if(var_12) {
          var_16 = var_16 + 256;
        }

        if(isDefined(var_9.vehicle)) {
          var_16 = var_16 + 512;

          if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_9.vehicle).size == 0 || !istrue(_id_09E1::_id_10116(var_9.vehicle))) {
            var_16 = var_16 + 1024;
          }

          if(var_9.vehicle._id_1031E == "little_bird") {
            var_16 = var_16 + 4096;
          }
        }

        if(!isDefined(var_3[var_4].guid)) {
          var_3[var_4].guid = var_9.guid;
        }

        if(!isDefined(var_3[var_4]._id_019B) && isDefined(var_13) && isDefined(var_13._id_50B4)) {
          var_3[var_4]._id_019B = var_13._id_50B4;
          self setclientomnvar("ui_tom_spawn_entity_" + (var_0 + var_4), var_13._id_50B4);
        }

        if(!isDefined(var_3[var_4]._id_7CD6) || var_3[var_4]._id_7CD6 != var_16) {
          var_3[var_4]._id_7CD6 = var_16;
          self setclientomnvar("ui_tom_spawn_id_" + (var_0 + var_4), var_16);
        }

        continue;
      }

      if(isDefined(var_3[var_4]._id_019B)) {
        var_3[var_4]._id_019B = undefined;
        self setclientomnvar("ui_tom_spawn_entity_" + (var_0 + var_4), undefined);
      }

      if(isDefined(var_3[var_4]._id_7CD6) && var_3[var_4]._id_7CD6 != -1) {
        var_3[var_4]._id_7CD6 = -1;
        self setclientomnvar("ui_tom_spawn_id_" + (var_0 + var_4), -1);
      }
    }

    waitframe();
  }
}

_id_748C(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = undefined;

  if(!isDefined(var_2)) {
    if(istrue(level._id_FE2E) && istrue(level._id_FE2D) && !istrue(self._id_E2BF) && isDefined(level._id_E270[self.team])) {
      var_2 = 1;
    } else if(istrue(level._id_FED1)) {
      var_2 = 0;
    } else if(istrue(level._id_FECE)) {
      var_2 = 2;
    } else if(istrue(level._id_FE2D)) {
      var_2 = 1;
    } else {
      var_2 = 3;
    }
  }

  var_3 = gettime();
  var_4 = 0;

  while(!var_4) {
    var_5 = gettime();
    var_6 = (var_3 + var_1 * 1000 - var_5) / 1000;

    switch (var_2) {
      case 0:
        self._id_E4AB = 0;
        self._id_E4AA = 0;

        if(!isai(self)) {
          thread _id_7496();
        }

        if(!var_0) {
          thread scripts\mp\playerlogic::_id_C673(self.origin + (0, 0, 60), self.angles);
        }

        var_0 = 1;
        var_7 = scripts\engine\utility::ter_op(isDefined(self._id_E36A), self._id_E36A, 0);

        if(thread _id_42A2(var_7, 1)) {
          if(!isai(self)) {
            var_8 = _id_7497(var_6);

            if(!istrue(var_8)) {
              self._id_E4AA = 1;
            } else {
              self._id_E4AB = 1;
            }
          } else {
            _id_F288(var_1, 5);

            if(scripts\engine\utility::cointoss()) {
              self._id_E4AB = 1;
            } else {
              self._id_E4AA = 1;
            }
          }
        } else
          self._id_E4AA = 1;

        if(self._id_E4AA) {
          self._id_01D2 = -1;

          if(istrue(level._id_FE2D)) {
            var_2 = 1;
          } else if(istrue(level._id_FECE)) {
            var_2 = 2;
          } else {
            var_2 = 3;
          }
        } else
          var_4 = 1;

        break;
      case 1:
        thread _id_0815::_id_E722();
        var_9 = thread _id_0815::_id_6D42();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        if(level._id_FE2E) {
          self._id_E2BF = 1;
        }

        _id_E395();
        var_4 = 1;
        break;
      case 2:
        var_10 = _id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("infil_started"));

        if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "base") && !var_10 && !_id_07D1::_id_60BE("prematch_done")) {
          var_11 = scripts\mp\gametypes\arm::_id_6B60(self.team);
          var_12 = spawn("script_model", var_11._id_E706);
          var_12 setModel("tag_origin");
          var_12.angles = var_11._id_E67A;
          self cameralinkto(var_12, "tag_origin");
          var_12 moveto(var_11._id_533C, 18);
          var_12 rotateto(var_11._id_52DF, 18);
          _id_07D1::_id_60C2("prematch_done");
          self _meth_8060();
          self._id_E282 = 0.5;
          thread _id_0815::_id_E722(0.0, 0.5, 0.5);
        } else {
          self._id_E282 = 0.5;
          thread _id_0815::_id_E722(0.0, 0.5, 0.5);
        }

        var_9 = thread _id_0815::_id_6D42();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        _id_1082A(var_6 + var_9);

        if(isDefined(self._id_D066)) {
          var_4 = 1;
        }

        break;
      case 3:
        thread _id_0815::_id_E722();
        var_9 = thread _id_0815::_id_6D42();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        _id_F288(var_6 + var_9, 9);
        var_4 = 1;
        break;
    }
  }

  if(_id_A408()) {
    if(!istrue(self._id_10848)) {
      _id_0A99::_id_D5EA(1);
    }

    if(!var_0) {
      thread scripts\mp\playerlogic::_id_C673(self.origin + (0, 0, 60), self.angles);
    }

    var_0 = 1;
    _id_1085B();
  }

  thread _id_0815::_id_534A();
}

_id_7496() {
  self endon("disconnect");
  self notify("handleSquadSpawnAbort");
  self endon("handleSquadSpawnAbort");
  self notifyonplayercommand("switchSpawnMethod", "+stance");
  self waittill("switchSpawnMethod");
  self._id_01D2 = -1;
  self._id_E4AA = 1;
  self notify("squad_spawn_abort");
}

_id_7498() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("handleSquadSpawnCycle");
  self endon("handleSquadSpawnCycle");
  self notifyonplayercommand("cyclePos", "+gostand");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("cyclePos", "cycleNeg");

    if(isDefined(var_0)) {
      var_1 = self getspectatingplayer();

      if(var_0 == "cyclePos") {
        thread _id_42A2(var_1._id_E4A0, 1);
      } else if(var_0 == "cycleNeg") {
        thread _id_42A2(var_1._id_E4A0, 0);
      }
    }
  }
}

_id_7497(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  _id_F288(var_0, 9);
  _id_0A99::_id_D5EA(35);
  self notifyonplayercommand("respawn_confirm", "+usereload");
  self waittill("respawn_confirm");
  return 1;
}

_id_42A2(var_0, var_1) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("cycleValidSquadSpectate");
  self endon("cycleValidSquadSpectate");
  var_2 = level._id_E48E[self.team][self._id_E496].players;
  var_3 = var_0;
  var_4 = scripts\engine\utility::ter_op(var_1, 1, -1);

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(_id_87DF(var_2[var_3]) || !_id_8A61(var_2[var_3])) {
      var_3 = var_3 + var_4;

      if(var_3 == var_2.size) {
        var_3 = 0;
      }

      if(var_3 == -1) {
        var_3 = var_2.size - 1;
      }

      continue;
    }

    thread _id_A145(var_2[var_3]);
    return 1;
  }

  return 0;
}

_id_87DF(var_0) {
  if(!isDefined(self._id_01D2)) {
    return 0;
  }

  var_1 = self getspectatingplayer();

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 == var_1;
}

_id_8A61(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_82F0)) {
    return 0;
  }

  if(var_0 isskydiving()) {
    return 0;
  }

  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    return 0;
  }

  if(isDefined(var_0.vehicle) && var_0 scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(var_0.vehicle).size == 0) {
    return 0;
  }

  return 1;
}

_id_898F() {
  thread _id_83D6();

  if(getdvarint("#x3d75da8c58039efc5", 0) == 1) {
    thread _id_0818::_id_E4AC();
  }
}

_id_83D6() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(_id_8A61(self)) {
      self._id_7DF7 = _id_8A5E(self);
    }

    waitframe();
  }
}

_id_8A5E(var_0) {
  var_1 = gettime();

  if(isDefined(var_0) && (isDefined(var_0._id_8FB6) && var_0._id_8FB6 + 5000 > var_1) || isDefined(var_0._id_90A7) && var_0._id_90A7 + 5000 > var_1) {
    return 1;
  }

  if(var_0 isonladder()) {
    return 1;
  }

  var_0 scripts\mp\battlechatter_mp::_id_FF55();

  if(isDefined(var_0._id_C0ED) && var_0._id_C0ED.size > 0) {
    return 1;
  }

  if(isDefined(var_0._id_90CA) && var_0._id_90CA + 3000 > var_1) {
    return 1;
  }

  if(isDefined(var_0._id_90CA) && isDefined(var_0._id_90C9) && var_0._id_90CA > var_0._id_90C9 || isDefined(var_0._id_90CA) && !isDefined(var_0._id_90C9)) {
    return 1;
  }

  var_2 = var_0 _meth_874A(384, 100, 1);

  if(isDefined(var_2)) {
    return 1;
  }

  if(isDefined(var_0.vehicle)) {
    if(istrue(var_0.vehicle._id_2D8B)) {
      return 1;
    }

    if(istrue(scripts\cp_mp\utility\weapon_utility::_id_8915(var_0.vehicle))) {
      return 1;
    }
  }

  if(isDefined(var_0) && var_0 scripts\mp\outofbounds::_id_8AAA()) {
    return 1;
  }

  if(getdvarint("#x3e29e81b2455cd094", 0) == 1) {
    var_3 = var_0 _meth_87F0(var_0.origin, 1);
    var_4 = var_0 _meth_874C(var_3, 0);
    var_4 = _id_0817::_id_6D3F(var_4);

    if(var_4 >= 2) {
      return 1;
    }
  }

  if(isDefined(var_0) && isDefined(var_0._id_A58A) && var_0._id_A58A + 1000 > var_1) {
    return 1;
  }

  if(isDefined(level.gametype) && level.gametype == "base" && scripts\mp\gametypes\base::base_isplayerindanger(var_0)) {
    return 1;
  }

  return 0;
}

_id_A145(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("monitorSquadSpectator");
  self endon("monitorSquadSpectator");
  var_1 = var_0._id_E4A0;
  self._id_01D2 = var_0 getentitynumber();
  self _meth_80FA();
  thread _id_7498();

  while(_id_8A61(var_0)) {
    if(_id_8A5E(var_0)) {
      self setclientomnvar("ui_squad_spawn_combat", 1);
    } else {
      self setclientomnvar("ui_squad_spawn_combat", 0);
    }

    self._id_E4AF = var_0.origin + anglesToForward(var_0.angles) * -80 + (0, 0, 64);
    self._id_E4AE = var_0.angles;
    waitframe();
  }

  if(!thread _id_42A2(var_1, 1)) {
    self._id_E4AA = 0;
    self notify("squad_spawn_abort");
  }
}

_id_E395() {
  self endon("disconnect");

  while(istrue(level._id_FE2D) && !isDefined(level._id_E270)) {
    waitframe();
  }

  if(!istrue(level._id_FE2D) || !isDefined(level._id_E270[self.team])) {
    wait 1.5;
    return;
  }

  if(!istrue(level._id_FE2E) && isDefined(level._id_F284) && level._id_F284[self.team] - gettime() <= (level._id_5CF5 + level._id_F206) * 1000) {
    _id_0A99::_id_D5EA(29, int(level._id_F284[self.team]));
  } else {
    _id_0A99::_id_D5EA(0);
  }

  thread scripts\mp\gametypes\arm::_id_E33E();

  if(isDefined(level._id_E270[self.team])) {
    self waittill("c130_ready");
  }
}

_id_A408() {
  if(scripts\mp\tweakables::_id_6E14("player", "forcerespawn") != 0) {
    return 0;
  }

  if(!self._id_75B4) {
    return 0;
  }

  var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(var_0) {
    return 0;
  }

  if(self._id_109C6) {
    return 0;
  }

  return 1;
}

_id_1085B() {
  self endon("disconnect");
  self endon("end_respawn");

  for(;;) {
    if(self usebuttonpressed()) {
      break;
    }

    wait 0.05;
  }
}

_id_F288(var_0, var_1) {
  self endon("disconnect");

  if(var_0 > 0) {
    if(!isDefined(var_1)) {
      var_1 = 9;
    }

    _id_0A99::_id_D5EA(var_1, int(gettime() + var_0 * 1000));
    scripts\engine\utility::_id_108AE(var_0, "force_spawn");
  }
}

_id_9A31(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageSquadCameraPosition");
  self endon("manageSquadCameraPosition");
  var_1 = undefined;

  if(var_0 == "squad_leader") {
    var_1 = level._id_E48E[self.team][self._id_E496]._id_E49C;
  } else {
    var_1 = int(_func_00D6(var_0, var_0.size - 1, var_0.size));
  }

  var_2 = undefined;

  if(isDefined(level._id_E48E[self.team]) && isDefined(level._id_E48E[self.team][self._id_E496]) && isDefined(level._id_E48E[self.team][self._id_E496].players[var_1])) {
    var_2 = level._id_E48E[self.team][self._id_E496].players[var_1];
  }

  var_3 = level._id_E377[self.team];

  while(isDefined(self._id_E277)) {
    var_4 = [];
    var_5 = [];

    if(istrue(level._id_FED7)) {
      var_6 = _id_6D8C(self.team);
      var_4 = var_6.origin;
      var_5 = var_6.angles;
    } else if(scripts\mp\utility\game::getgametype() == "base" && getdvarint("#x332c8a7db9737b21b", 1) == 1) {
      var_7 = level._id_E371["gw_fob_03"][self.team]._id_1782.origin;
      var_4 = var_7 + (0, 0, 17000);
      var_5 = (90, 0, -90);
    } else {
      if(!isDefined(var_2)) {
        return;
      }
      var_4 = var_2.origin + var_3 * -8500 + (0, 0, 7000);
      var_8 = vectornormalize(var_2.origin - var_4);
      var_5 = scripts\mp\utility\script::_id_FFE3(var_8, (0, 0, 1));

      if(istrue(level._id_FEF0)) {
        var_9 = _id_6E1F();
        var_4 = (var_4[0], var_4[1], var_9);
      }

      var_4 = var_4 + scripts\mp\gametypes\arm::_id_2EE0(self.team, var_2.origin);
    }

    self._id_E281 = var_4;
    self._id_E280 = var_5;
    self._id_E277 moveto(var_4, 0.25, 0.05, 0.2);
    self._id_E277 rotateto(var_5, 0.25, 0.05, 0.2);
    waitframe();
  }
}

_id_9A35(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleCameraPosition");
  self endon("manageVehicleCameraPosition");
  var_1 = int(_func_00D6(var_0, var_0.size - 1, var_0.size));
  var_2 = level._id_E371[var_0][self.team]._id_50B4;
  var_3 = level._id_E377[self.team];
  var_4 = 0;

  while(isDefined(self._id_E277) && isDefined(var_2) && !istrue(var_2._id_87FB)) {
    var_5 = [];
    var_6 = [];

    if(istrue(level._id_FED7)) {
      var_7 = _id_6D8C(self.team);
      var_5 = var_7.origin;
      var_6 = var_7.angles;
    } else {
      var_5 = var_2.origin + var_3 * -8500 + (0, 0, 7000);

      if(istrue(level._id_FEF0)) {
        var_8 = _id_6E1F();
        var_5 = (var_5[0], var_5[1], var_8);
      }

      var_9 = level._id_E371[var_0][self.team]._id_1782.origin;
      var_10 = var_9 + var_3 * -8500 + (0, 0, 7000);
      var_11 = vectornormalize(var_9 - var_10);
      var_6 = scripts\mp\utility\script::_id_FFE3(var_11, (0, 0, 1));
      var_5 = var_5 + scripts\mp\gametypes\arm::_id_2EE0(self.team, var_9);
    }

    self._id_E281 = var_5;
    self._id_E280 = var_6;

    if(!isDefined(self._id_E276) || gettime() > self._id_E276) {
      self._id_E277 moveto(var_5, 0.25, 0.05, 0.2);
      self._id_E277 rotateto(var_6, 0.25, 0.05, 0.2);
    } else if(!var_4) {
      var_4 = 1;
      self._id_E277 moveto(var_5, self._id_E282, self._id_E282 * 0.3, self._id_E282 * 0.4);
      self._id_E277 rotateto(var_6, self._id_E282, self._id_E282 * 0.3, self._id_E282 * 0.4);
    }

    waitframe();
  }
}

_id_9A36(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleHealthUI");
  self endon("manageVehicleHealthUI");
  var_1 = level._id_E371[var_0][self.team]._id_50B4;
  self setclientomnvar("ui_tom_veh_health_percent", 0);
  waitframe();
  var_2 = undefined;

  while(isDefined(var_1)) {
    var_3 = int(clamp(var_1.health / var_1.maxhealth * 100, 0, 100));

    if(var_3 < 0) {}

    if(!isDefined(var_2) || var_2 != var_3) {
      self setclientomnvar("ui_tom_veh_health_percent", int(var_3));
      var_2 = var_3;
    }

    waitframe();
  }
}

_id_696B() {
  var_0 = undefined;
  var_1 = undefined;

  if(!_id_07D1::_id_60BE("prematch_done") && (scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "base") || !isDefined(self._id_75C3)) {
    if(self.team == "axis") {
      var_1 = "gw_fob_axisHQ";
    } else {
      var_1 = "gw_fob_alliesHQ";
    }

    self._id_75C3 = 1;
  } else {
    var_2 = 0;

    foreach(var_4 in level._id_1F95[self.team]) {
      var_5 = distancesquared(self.origin, level._id_E371[var_4][self.team]._id_1782.origin);

      if(var_4 == "gw_fob_" + self.team + "HQ") {
        if(var_5 < 4194304) {
          var_0 = var_5;
          var_1 = var_4;
          break;
        }
      }

      if(!isDefined(var_0) || var_5 < var_0) {
        var_0 = var_5;
        var_1 = var_4;
      }
    }

    if(isDefined(level._id_E4AD) && isDefined(level._id_E4AD[self.team][self._id_E496])) {
      var_7 = _id_6D77(self.team, self._id_E496);

      foreach(var_9 in var_7) {
        if(var_9._id_50B4 == self) {
          continue;
        }
        var_5 = distancesquared(self.origin, var_9._id_50B4.origin);

        if(var_5 < var_0) {
          var_0 = var_5;
          var_1 = var_9._id_F8E5;
        }
      }
    }
  }

  if(issubstr(var_1, "vehicle")) {}

  if(isDefined(var_1)) {
    if(!issubstr(var_1, "squad") && !issubstr(var_1, "vehicle") && !issubstr(var_1, "HQ")) {
      var_11 = var_1 + "_" + level._id_96CC;
    } else {
      var_11 = var_1;
    }

    var_12 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_11);
    self setclientomnvar("ui_tom_previous_selection", var_12);
    self._id_5E98 = var_1;
  } else {
    self setclientomnvar("ui_tom_previous_selection", -1);
    self._id_5E98 = undefined;
  }
}

_id_696A() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = scripts\mp\utility\game::_id_6BE2(self.team)[0];
  var_3 = 0;

  foreach(var_5 in level._id_1F95[var_2]) {
    var_6 = distancesquared(self.origin, level._id_E371[var_5][var_2]._id_1782.origin);

    if(var_5 == "gw_fob_" + var_2 + "HQ") {
      if(var_6 < 4194304) {
        var_0 = var_6;
        var_1 = var_5;
        break;
      }
    }

    if(!isDefined(var_0) || var_6 < var_0) {
      var_0 = var_6;
      var_1 = var_5;
    }
  }

  var_8 = [];

  foreach(var_10 in level._id_232A) {
    if(var_10._id_ADAE == "neutral") {
      var_8[var_8.size] = var_10._id_A8E1;
    }
  }

  var_12 = [];

  foreach(var_14 in var_8) {
    foreach(var_10 in level._id_14F5) {
      if(var_10.trigger._id_A90E == var_14) {
        var_12[var_12.size] = var_10.name;
        break;
      }
    }
  }

  foreach(var_5 in var_12) {
    var_6 = distancesquared(self.origin, level._id_E371[var_5][var_2]._id_1782.origin);

    if(!isDefined(var_0) || var_6 < var_0) {
      var_0 = var_6;
      var_1 = var_5;
    }
  }

  if(isDefined(var_1)) {
    var_20 = var_1;
    var_21 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_20);
    self setclientomnvar("ui_tom_previous_selection", var_21);
    self._id_5E98 = var_1;
  } else {
    self setclientomnvar("ui_tom_previous_selection", -1);
    self._id_5E98 = undefined;
  }
}

_id_6D8C(var_0) {
  var_1 = spawnStruct();

  if(level.mapname == "mp_locale_test") {
    switch (level._id_96CC) {
      case "locale_6":
        if(var_0 == "axis") {
          var_1.origin = (2094, -1804, 2763);
          var_1.angles = (54, 40, 0);
        } else {
          var_1.origin = (2315, 1956, 2763);
          var_1.angles = (54, 296, 0);
        }

        break;
      case "locale_7":
        if(var_0 == "axis") {
          var_1.origin = (5556, -1368, 2464);
          var_1.angles = (56, 42, 0);
        } else {
          var_1.origin = (5636, 1630, 2446);
          var_1.angles = (56, 307, 0);
        }

        break;
      default:
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level._id_96CC) {
      case "locale_5":
        if(var_0 == "axis") {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        } else {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        }

        break;
      case "locale_6":
        if(var_0 == "axis") {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        } else {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        }

        break;
      case "locale_7":
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
      default:
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  }

  return var_1;
}

_id_6E1F() {
  if(level.mapname == "mp_locale_test") {
    switch (level._id_96CC) {
      case "locale_6":
        return 7000;
      case "locale_7":
        return 7000;
      case "locale_8":
        return 7000;
      case "locale_9":
        return 7000;
      default:
        return 7000;
    }
  } else {
    switch (level._id_96CC) {
      case "locale_5":
        return 7000;
      case "locale_6":
        return 8000;
      case "locale_7":
        return 8000;
      case "locale_8":
        return 8000;
      case "locale_9":
        return 8000;
      case "locale_16":
        return 7000;
      case "locale_17":
        return 5000;
      default:
        return 7000;
    }
  }
}

_id_FC68() {
  level thread _id_FC6A();

  for(;;) {
    foreach(var_1 in level._id_EF89) {
      foreach(var_3 in level._id_1F95[var_1]) {
        var_4 = level._id_E371[var_3][var_1];

        if(isDefined(var_4._id_A8E1)) {
          var_4._id_7DF7 = _id_895A(var_4._id_A8E1, var_1);
        }
      }
    }

    waitframe();
  }
}

_id_FC6A() {
  for(;;) {
    foreach(var_1 in level._id_EF89) {
      var_2 = scripts\mp\utility\teams::_id_6DCA(var_1, "players")[0];

      foreach(var_4 in level._id_1F95[var_1]) {
        if(!issubstr(var_4, "HQ") && issubstr(var_4, "fob")) {
          var_5 = 1;
          var_6 = isDefined(level._id_E2F4._id_E37C[var_4 + "_safe_" + var_1]);
          var_7 = var_4 + "_" + var_1;
          var_8 = undefined;

          if(var_6) {
            var_8 = var_4 + "_safe_" + var_1;
          }

          if(isDefined(level._id_E304)) {
            var_9 = undefined;
            var_10 = getarraykeys(level._id_E304);

            foreach(var_12 in var_10) {
              if(var_12 == var_4) {
                var_9 = level._id_E304[var_12];
                break;
              }
            }

            if(isDefined(var_9) && var_9 _id_8A99(scripts\mp\utility\game::_id_6BE2(var_1)[0])) {
              var_5 = 0;
            }
          }

          var_14 = 0;

          if(isDefined(var_2)) {
            if(var_5 || var_6) {
              var_15 = [];

              if(var_5) {
                var_15[0] = var_7;
              }

              if(var_6) {
                var_15[var_15.size] = var_8;
              }

              var_16 = _id_0817::_id_6D5B(var_15);
              var_17 = var_2 _meth_87EF(var_16);
              var_18 = var_2 _meth_874C(var_17, var_16);
              var_18 = _id_0817::_id_6D3F(var_18);
              var_14 = var_18 >= 2;
            }
          }

          var_19 = level._id_E371[var_4][var_1]._id_A8E1;
          level._id_A8E8[var_19]._id_E349 = var_14;
          level._id_A8E8[var_19]._id_E34A = gettime();
        }
      }
    }

    wait 1.0;
  }
}

_id_FD34(var_0, var_1, var_2) {
  var_3 = level._id_E371[var_0][var_2]._id_A8E1;

  if(!isDefined(var_3) || !isDefined(level._id_A8E8[var_3]) || !isDefined(level._id_A8E8[var_3]._id_E34A) || level._id_A8E8[var_3]._id_E34A == gettime()) {
    return;
  }
  var_4 = 1;
  var_5 = isDefined(level._id_E2F4._id_E37C[var_0 + "_safe_" + var_2]);
  var_6 = var_0 + "_" + var_2;
  var_7 = undefined;

  if(var_5) {
    var_7 = var_0 + "_safe_" + var_2;
  }

  if(isDefined(level._id_E304)) {
    var_8 = undefined;
    var_9 = getarraykeys(level._id_E304);

    foreach(var_11 in var_9) {
      if(var_11 == var_0) {
        var_8 = level._id_E304[var_11];
        break;
      }
    }

    if(isDefined(var_8) && isDefined(var_8._id_A794) && var_8._id_A794[scripts\mp\utility\game::_id_6BE2(var_2)[0]] > 0) {
      var_4 = 0;
    }
  }

  var_13 = 0;

  if(isDefined(var_1)) {
    if(var_4 || var_5) {
      var_14 = [];

      if(var_4) {
        var_14[0] = var_6;
      }

      if(var_5) {
        var_14[var_14.size] = var_7;
      }

      var_15 = _id_0817::_id_6D5B(var_14);
      var_16 = var_1 _meth_87EF(var_15);
      var_17 = var_1 _meth_874C(var_16, var_15);
      var_17 = _id_0817::_id_6D3F(var_17);
      var_13 = var_17 >= 2;
    }
  }

  level._id_A8E8[var_3]._id_E349 = var_13;
  level._id_A8E8[var_3]._id_E34A = gettime();
}

isredeploying() {
  var_0 = self;
  return istrue(var_0.isredeploying);
}