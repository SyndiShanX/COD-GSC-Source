/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2076.gsc
*************************************************/

init() {
  if(level.gametype != "tac_ops" && _func_00D6(scripts\mp\utility\game::getgametype(), 0, 3) != "to_") {
    return;
  }
  level._id_ED16 = spawnStruct();
  var_0 = level._id_ED16;
  var_0._id_9AAF = [];
  var_0._id_0F39 = [];
  var_0._id_7049 = [];
  var_0._id_7049["allies"] = [];
  var_0._id_7049["axis"] = [];
  _id_D85B();
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

_id_4011(var_0, var_1) {
  var_2 = level._id_ED16;
  var_2._id_9AAF[var_0] = var_1;
  var_1._id_C189 = var_0;
  var_1._id_E269 = [];
  var_1._id_E269["allies"] = [];
  var_1._id_E269["axis"] = [];
  var_1._id_9AC3 = [];
  var_1._id_9AC3["allies"] = [];
  var_1._id_9AC3["axis"] = [];
  return var_1;
}

_id_9AAE(var_0) {
  return isDefined(level._id_ED16) && isDefined(level._id_ED16._id_9AAF[var_0]);
}

_id_D45F(var_0, var_1) {
  if(!_id_9AAE(var_0)) {
    _id_3919();
    return;
  }

  if(isDefined(level._id_ED16._id_0F39[var_1]) && level._id_ED16._id_9AAF[var_0] == level._id_ED16._id_0F39[var_1]) {
    return;
  }
  level._id_ED16._id_0F39[var_1] = level._id_ED16._id_9AAF[var_0];
  level notify("tac_ops_map_changed");
}

_id_6888(var_0) {
  return level._id_ED16._id_0F39[self.team];
}

_id_3919() {
  level._id_ED16._id_0F39 = [];
  level notify("tac_ops_map_cleared");
}

_id_D714(var_0, var_1, var_2) {
  if(!_id_9AAE(var_0)) {
    _id_4011(var_0);
  }

  var_3 = level._id_ED16._id_9AAF[var_0];
  var_3._id_9AC3[var_1] = var_2;
}

_id_828E(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("mp/tac_ops_map_spawns.csv", 0, var_2);
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_1._id_1782 = var_4;
  var_1._id_F8E2 = var_3;
  var_1._id_F8E5 = var_2;
  var_1.team = var_0;
  var_1._id_523F = 1;

  if(isDefined(var_1._id_50B4)) {
    var_4 linkto(var_1._id_50B4);
  } else if(isDefined(var_1.target)) {
    var_1._id_1A53 = getEntArray(var_1.target, "targetname");
  }
}

_id_1134(var_0, var_1, var_2, var_3) {
  if(!_id_9AAE(var_0)) {
    _id_4011(var_0);
  }

  var_4 = level._id_ED16._id_9AAF[var_0];
  _id_828E(var_1, var_2, var_3);
  var_4._id_E269[var_1][var_4._id_E269[var_1].size] = var_2;
}

_id_10B4(var_0, var_1, var_2, var_3) {
  var_4 = level._id_ED16;
  _id_828E(var_1, var_2, var_3);
  var_4._id_7049[var_1][var_0] = var_2;
}

_id_C4C9(var_0, var_1) {
  level._id_ED16._id_7049[var_1][var_0] = undefined;
  level notify("tac_ops_map_changed");
}

_id_C1AB() {
  var_0 = level._id_ED16._id_0F39[self.team];

  if(!isDefined(var_0)) {
    for(var_1 = 0; var_1 < 8; var_1++) {
      self setclientomnvar("ui_tom_spawn_entity_" + var_1, undefined);
      self setclientomnvar("ui_tom_spawn_id_" + var_1, -1);
    }
  }

  var_2 = level._id_ED16._id_7049[self.team].size;
  var_3 = var_0._id_E269[self.team].size + var_2;
  var_4 = 0;

  foreach(var_6 in level._id_ED16._id_7049[self.team]) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_4, var_6._id_1782);
    self setclientomnvar("ui_tom_spawn_id_" + var_4, var_6._id_F8E2);
    var_4++;
  }

  for(var_1 = 0; var_1 < var_0._id_E269[self.team].size; var_1++) {
    var_8 = var_0._id_E269[self.team][var_1];

    if(istrue(var_8._id_523F)) {
      self setclientomnvar("ui_tom_spawn_entity_" + var_4, var_8._id_1782);
      self setclientomnvar("ui_tom_spawn_id_" + var_4, var_8._id_F8E2);
      var_4++;
    }
  }

  for(var_1 = var_4; var_1 < 8; var_1++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_1, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var_1, -1);
  }
}

_id_1082A() {
  if(isai(self)) {
    return;
  }
  var_0 = level._id_ED16._id_0F39[self.team];

  if(!isDefined(var_0)) {
    return;
  }
  waitframe();
  _id_CA75(var_0);
}

_id_CA75(var_0) {
  scripts\mp\utility\player::_id_FD26("spectator");
  _id_081A::_id_D512();
  _id_0A99::_id_D5EA(0);

  if(isDefined(self._id_8FB8)) {
    self setplayerangles(self._id_8FB8);
  }

  wait 0.5;
  var_1 = spawn("script_model", self getvieworigin());
  var_1 setModel("tag_origin");
  var_1.angles = self getplayerangles();
  self._id_ED17 = var_1;
  self._id_8AD7 = 1;
  self cameralinkto(var_1, "tag_origin", 1);
  var_1 _id_A227(var_0._id_9AC3[self.team].origin, var_0._id_9AC3[self.team].angles, self);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  _id_C1AB();
  self._id_4411 = var_0._id_9AC3[self.team].origin;
  self._id_4410 = var_0._id_9AC3[self.team].angles;
  _id_DCEF();
  var_2 = var_0;

  for(;;) {
    var_3 = _id_10AD7();
    var_4 = 1;

    switch (var_3) {
      case "tac_ops_map_selection_made":
        thread _id_3977();
        thread _id_CA72();
        var_4 = 1;
        _id_39F6();
        break;
      case "tac_ops_map_changed":
        self setclientomnvar("ui_tac_ops_map_open", 0);
        var_2 = level._id_ED16._id_0F39[self.team];
        var_1 _id_A227(var_2._id_9AC3[self.team].origin, var_2._id_9AC3[self.team].angles);
        self setclientomnvar("ui_tac_ops_map_open", 1);
        _id_C1AB();
        var_4 = 0;
        break;
      case "tac_ops_map_cleared":
        var_4 = 1;
        _id_39F6();
        _id_E900();
        break;
      case "spawned_player":
        var_4 = 1;
        _id_39F6();
        _id_E900();
        break;
      case "tac_ops_map_game_ended":
        var_4 = 0;
        _id_39F6();
        _id_E900();
        break;
      default:
        break;
    }

    if(var_4) {
      return;
    }
  }
}

_id_10AD7() {
  thread _id_52EA();
  thread _id_52EE();
  thread _id_52EC();
  thread _id_52EB();
  var_0 = scripts\engine\utility::_id_108A2("tac_ops_map_selection_made", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended");
  self notify("tac_ops_end_condition_met");
  return var_0;
}

_id_52EE() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "tac_ops_spawn_area_selected") {
      var_2 = undefined;
      var_3 = level._id_ED16._id_0F39[self.team];

      foreach(var_5 in var_3._id_E269[self.team]) {
        if(var_1 == var_5._id_1782 getentitynumber()) {
          var_2 = var_5;
          break;
        }
      }

      if(!isDefined(var_2)) {
        foreach(var_5 in level._id_ED16._id_7049[self.team]) {
          if(var_1 == var_5._id_1782 getentitynumber()) {
            var_2 = var_5;
            break;
          }
        }
      }

      self._id_ED18 = var_2;
      self notify("tac_ops_map_selection_made");
      break;
    }
  }
}

_id_52EA() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_GameEnded()");
  self endon("endConditionWatcher_GameEnded()");
  level waittill("game_ended");
  self notify("tac_ops_map_game_ended");
}

_id_52EC() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapCleared()");
  self endon("endConditionWatcher_MapCleared()");
  level waittill("tac_ops_map_cleared");
  self notify("tac_ops_map_cleared");
}

_id_52EB() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapChanged()");
  self endon("endConditionWatcher_MapChanged()");
  level waittill("tac_ops_map_changed");
  self notify("tac_ops_map_changed");
}

_id_DCEF() {
  if(!isDefined(level._id_CA76)) {
    level._id_CA76 = [];
  }

  if(scripts\mp\utility\teams::_id_6DCA(self.team, "teamCount")) {
    var_0 = 0;
    level._id_CA76[scripts\mp\utility\player::getuniqueid()] = [];

    foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
      if(var_2 == self) {
        continue;
      }
      var_3 = var_2.origin;
      var_4 = newclienthudelem(self);
      var_4.x = var_3[0];
      var_4.y = var_3[1];
      var_4._id_050C = var_3[2] + 32;
      var_4.alpha = 1.0;
      var_4.archived = 0;
      var_4.showinkillcam = 0;

      if(level.splitscreen) {
        var_4 setshader("tacops_spotted_shield_blue", 10, 10);
      } else {
        var_4 setshader("tacops_spotted_shield_blue", 5, 5);
      }

      var_4 _meth_83B2(0);
      var_4 _meth_8388(var_2);
      level._id_CA76[scripts\mp\utility\player::getuniqueid()][var_0] = var_4;
      var_0++;
    }
  }
}

_id_38A0() {
  foreach(var_1 in level._id_CA76[scripts\mp\utility\player::getuniqueid()]) {
    var_1 destroy();
  }

  level._id_CA76[scripts\mp\utility\player::getuniqueid()] = undefined;
}

_id_39F6() {
  self setclientomnvar("ui_tac_ops_map_open", 0);
  _id_38A0();
}

_id_E900() {
  self _meth_8060();
  self._id_ED17 delete();
  self._id_ED17 = undefined;
  self._id_8AD7 = undefined;
}

_id_3977() {
  self waittill("spawned_player");
  self._id_ED18 = undefined;
}

_id_CA72() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::_id_FD26("spectator");
  self cameralinkto(self._id_ED17, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self._id_ED17 moveto(var_0, 0.5);
  self._id_ED17 rotateto(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread _id_B8DB();
  scripts\mp\utility\player::_id_FD26("playing");
  _id_E900();
}

_id_B8DB() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

_id_A227(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 1.0;
  self moveto(var_0, 1.0, 0.5, 0.5);
  self rotateto(var_1, 1.0, 0.5, 0.5);
  var_2 thread _id_E705();
  wait 1.1;
}

_id_D85B() {
  var_0 = scripts\engine\utility::getstructarray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(var_3 == "to_toblitz") {
      var_3 = "to_blitz";
    }

    _id_4011(var_3, var_2);
    var_4 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_CD99) {
        case "to_spawn_area_allies":
          _id_1134(var_3, "allies", var_6, var_6._id_039B);
          break;
        case "to_spawn_area_axis":
          _id_1134(var_3, "axis", var_6, var_6._id_039B);
          break;
        case "to_allies_camera":
          _id_D714(var_3, "allies", var_6);
          break;
        case "to_axis_camera":
          _id_D714(var_3, "axis", var_6);
          break;
      }
    }
  }
}

_id_D8B3() {
  var_0 = level._id_ED16;

  foreach(var_2 in var_0._id_9AAF) {
    foreach(var_4 in var_2._id_E269) {
      foreach(var_6 in var_4) {
        var_6._id_E318 = [];

        foreach(var_8 in level._id_E34D) {
          foreach(var_10 in var_6._id_1A53) {
            if(_func_011A(var_8.origin, var_10)) {
              var_6._id_E318[var_8.index] = var_8;
              break;
            }
          }
        }
      }
    }
  }
}

_id_5A54(var_0, var_1) {
  if(isDefined(self._id_ED18)) {
    var_2 = [];

    foreach(var_4 in var_0) {
      if(isDefined(self._id_ED18._id_E318) && isDefined(self._id_ED18._id_E318[var_4.index])) {
        var_2[var_2.size] = var_4;
      }
    }

    return var_2;
  }

  return var_0;
}

_id_10A5(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_1.origin;
  var_4._id_50B4 = var_1;
  var_4._id_039B = var_3;
  var_4._id_1A53 = [];
  _id_1134(var_0, var_2, var_4, var_3);
}

_id_E705() {
  self endon("game_ended");

  if(istrue(self._id_E373)) {
    return;
  }
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 _meth_83CA(self);
  self _meth_867F("mp_spawn_camera");
  var_1 = scripts\mp\utility\teams::_id_6DDF(self.team);
  var_2 = "dx_mpo_" + var_1 + "op_drone_deathchatter";
  self._id_E373 = 1;
  self waittill("spawned_player");
  self _meth_8680("mp_spawn_camera");
  self._id_E373 = 0;
}