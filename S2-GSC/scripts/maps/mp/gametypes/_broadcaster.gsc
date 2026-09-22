/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_broadcaster.gsc
******************************************************/

init() {
  level.broadcasters = [];
}

_id_1C8B() {
  if(!self ismlgspectator()) {
    return;
  }
  if(!_isai(self)) {
    level.broadcasters[self getentitynumber()] = self;
    thread _id_1CAD();
  }
}

monitorpuckcolor(var_0) {
  var_1 = "mp/broadcasterColors.csv";
  var_2 = 2;
  var_3 = "broadcaster_" + self getentitynumber() + "_player_puck";

  for(;;) {
    self waittill("luinotifyserver", var_4, var_5);

    if(var_4 == "broadcaster_set_color_" + var_0) {
      var_6 = int(_floor(var_5 / 100));

      if(var_6 == self getentitynumber()) {
        var_7 = var_5 % 100;
        var_8 = _tablelookupbyrow(var_1, var_7 - 1, var_2);
        level._effect[var_3 + "_" + var_0] = loadfx("vfx/ui/" + var_8);
        break;
      }
    }
  }
}

monitorzoom() {
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "broadcaster_set_initial_zoom") {
      var_2 = int(_floor(var_1 / 100));

      if(var_2 == self getentitynumber()) {
        var_3 = var_1 % 100;
        self._id_1E99._id_ACCB = var_3;
        break;
      }
    }
  }
}

initializeclientvalues() {
  if(!isDefined(level._effect["broadcaster_followed_player"])) {
    level._effect["broadcaster_followed_player"] = loadfx("vfx/ui/esports_ui_puck_selected");
  }

  thread monitorpuckcolor("allies");
  thread monitorpuckcolor("axis");
  thread monitorzoom();
  _luinotifyevent(&"broadcaster_request_client_values", 1, self getentitynumber());
  _id_1CA2();
}

_id_1CAD() {
  if(isbot(self)) {
    return;
  }
  setdvarifuninitialized("broadcaster_player_target_vfx", 0);
  setdvarifuninitialized("broadcaster_follower_killer", 1);
  setdvarifuninitialized("broadcaster_team_pucks", 1);
  self.team = "spectator";
  self._id_0179 = "spectator";
  maps\mp\_utility::_id_A165("spectator");
  _id_050F::_id_872F();
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  thread _id_1C9D();
  thread initializeclientvalues();
  thread _id_1C9B();
  _id_1CA4();
  _id_44DC();
  thread _id_1C9C();
  thread _id_1C91();
  thread _id_1CA3();
  waitframe();
  self notify("broadcaster_view_set_sky_cam");
}

_id_44DC() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!var_1 ismlgspectator() && var_1.hasspawned) {
        wait 0.15;
        thread _id_1CA7(var_1 getentitynumber());
        return;
      }
    }

    waitframe();
  }
}

_id_1CA5() {
  if(self._id_1E99._id_77AC) {
    self._id_1E99._id_77AC = 0;
    self notify("broadcaster_stop_player_pucks");
  } else {
    self._id_1E99._id_77AC = 1;
    thread _id_1CAA();
  }
}

_id_1CA2() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread _id_1CA9();

    if(isDefined(self._id_1E99._id_9815) && self._id_1E99._id_9815 == var_0) {
      thread _id_1CA8(1);
    }
  }
}

_id_1CA8(var_0) {
  level endon("game_ended");
  var_1 = self._id_1E99._id_9815;

  if(isDefined(var_1) && self._id_1E99._id_A4A8 != "first_person") {
    if(isDefined(var_1._id_981E)) {
      if(!isDefined(var_1._id_981E[self getentitynumber()])) {
        var_1._id_981E[self getentitynumber()] = 0;
      } else if(var_1._id_981E[self getentitynumber()]) {
        return;
      } else if(isDefined(var_0)) {
        wait 0.1;
      }
    } else
      var_1._id_981E = [];

    if(var_1 gettagindex("tag_origin") != -1) {
      _playfxontagforclients(common_scripts\utility::_id_44F5("broadcaster_followed_player"), var_1, "tag_origin", self);
      var_1._id_981E[self getentitynumber()] = 1;
    }

    thread _id_1C9E(var_1);
    self waittill("broadcaster_stop_target_player_puck");

    if(var_1 gettagindex("tag_origin") != -1) {
      _killfxontagforclient(common_scripts\utility::_id_44F5("broadcaster_followed_player"), var_1, "tag_origin", self);
      var_1._id_981E[self getentitynumber()] = 0;
    }
  }
}

_id_1C9E(var_0) {
  level endon("game_ended");
  self endon("broadcaster_view_player_has_changed");
  self endon("broadcaster_stop_target_player_puck");
  var_0 waittill("death");
  self notify("broadcaster_stop_target_player_puck");
}

_id_1CAA() {
  if(self._id_1E99._id_77AC) {
    foreach(var_1 in level.players) {
      if(!var_1 ismlgspectator()) {
        var_1 thread _id_1CA9();
      }
    }
  }
}

_id_1CA9() {
  level endon("game_ended");
  self endon("death");
  var_0 = self;

  foreach(var_2 in level.broadcasters) {
    if(isDefined(var_2._id_1E99) && isDefined(var_2._id_1E99._id_77AC) && var_2._id_1E99._id_77AC) {
      while(self.hasspawned == 0) {
        waitframe();
      }

      wait 0.5;

      if(var_2._id_1E99._id_A4A8 == "first_person") {
        continue;
      }
      var_3 = "broadcaster_" + var_2 getentitynumber() + "_player_puck";
      var_4 = var_3 + "_allies";
      var_5 = var_3 + "_axis";

      if(var_0.team == "allies" && common_scripts\utility::_id_3F6F(var_4)) {
        _playfxontagforclients(common_scripts\utility::_id_44F5(var_4), var_0, "tag_origin", var_2);
      } else if(var_0.team == "axis" && common_scripts\utility::_id_3F6F(var_5)) {
        _playfxontagforclients(common_scripts\utility::_id_44F5(var_5), var_0, "tag_origin", var_2);
      }

      thread _id_1C9F(var_2);
    }
  }

  thread _id_1CA0();
  thread _id_1CA1();
}

_id_1CA1() {
  self endon("death");
  level waittill("game_ended");
  broadcasterkillteampuck();
}

_id_1CA0() {
  level endon("game_ended");
  self waittill("death");
  broadcasterkillteampuck();
}

_id_1C9F(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 waittill("broadcaster_stop_player_pucks");
  _id_1CAB(var_0);
}

_id_1CAB(var_0) {
  var_1 = "broadcaster_" + var_0 getentitynumber() + "_player_puck";
  var_2 = var_1 + "_allies";
  var_3 = var_1 + "_axis";

  if(self.team == "allies" && common_scripts\utility::_id_3F6F(var_2)) {
    _killfxontagforclient(common_scripts\utility::_id_44F5(var_2), self, "tag_origin", var_0);
  } else if(self.team == "axis" && common_scripts\utility::_id_3F6F(var_3)) {
    _killfxontagforclient(common_scripts\utility::_id_44F5(var_3), self, "tag_origin", var_0);
  }
}

broadcasterkillteampuck() {
  foreach(var_1 in level.broadcasters) {
    if(isDefined(var_1)) {
      var_2 = "broadcaster_" + var_1 getentitynumber() + "_player_puck";
      var_3 = var_2 + "_allies";
      var_4 = var_2 + "_axis";

      if(self.team == "allies" && common_scripts\utility::_id_3F6F(var_3)) {
        _killfxontagforclient(common_scripts\utility::_id_44F5(var_3), self, "tag_origin", var_1);
      } else if(self.team == "axis" && common_scripts\utility::_id_3F6F(var_4)) {
        _killfxontagforclient(common_scripts\utility::_id_44F5(var_4), self, "tag_origin", var_1);
      }
    }
  }
}

_id_1C91() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = self getnormalizedmovement();
    self._id_1E99._id_5388 = var_0;
    waitframe();
  }
}

_id_1C9D() {
  level endon("game_ended");
  var_0 = 0.5;

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);
    var_3 = int(_floor(var_2 / 10000));
    var_4 = int(_floor(var_2 % 10000 / 100));

    if(var_1 == "broadcaster_view_notify" || var_1 == "broadcaster_camera_input" || var_1 == "broadcaster_client_change" || var_1 == "broadcaster_toggle_ball_cam" || var_1 == "broadcaster_set_color_allies" || var_1 == "broadcaster_set_color_axis") {
      var_5 = level.broadcasters[var_4];
      var_6 = var_2 % 100;

      if(self getentitynumber() != var_4) {
        continue;
      }
      switch (var_1) {
        case "broadcaster_view_notify":
          switch (var_6) {
            case 1:
              thread _id_1C93();
              break;
            case 2:
              self notify("broadcaster_view_set_first_person");
              break;
            case 3:
              self notify("broadcaster_view_set_sky_cam");
              break;
            case 4:
              self._id_1E99._id_ACCB = var_3;
              break;
            case 5:
              thread _id_1C97();
              break;
            case 6:
              thread _id_1CA5();
              break;
            case 7:
              thread _id_1CA6();
              break;
            case 8:
              _id_1CAC();
              break;
          }

          break;
        case "broadcaster_camera_input":
          self._id_1E99._id_1C92 = var_6 == 1;
          break;
        case "broadcaster_client_change":
          thread _id_1CA7(var_6);
          break;
        case "broadcaster_toggle_ball_cam":
          self._id_1E99.broadcasterballcamenabled = var_6 == 1;

          if(!self._id_1E99.broadcasterballcamenabled) {
            thread broadcasterkillballcam();
          } else if(self._id_1E99._id_A4A8 == "first_person") {
            thread broadcasterstartballcam();
          }

          break;
        case "broadcaster_set_color_allies":
          level.broadcastercolorindexallies = var_6;
          break;
        case "broadcaster_set_color_axis":
          level.broadcastercolorindexaxis = var_6;
          break;
      }
    }
  }
}

_id_1C9C() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    level waittill("broadcasterLoadoutChanged", var_0);
    var_1 = _getomnvar("ui_broadcaster_client_num");

    if(isDefined(var_0) && var_0 == var_1) {
      var_2 = self _meth_82F1(var_0);
      _id_A0E8(var_2);
    }
  }
}

_id_1CA6() {
  self._id_1E99._id_53C0 = 0;
  self._id_1E99._id_53C1 = 0;
  self._id_1E99._id_164B = 0;
}

_id_1CAC() {
  self._id_1E99._id_164B = !common_scripts\utility::_id_562E(self._id_1E99._id_164B);
}

_id_1CA7(var_0) {
  self endon("broadcaster_view_player_has_changed");
  self._id_1E99._id_164B = 0;
  var_1 = maps\mp\gametypes\_playerlogic::_id_4622(var_0);

  if(isDefined(self._id_1E99._id_9815) && var_1 == self._id_1E99._id_9815) {
    return;
  }
  if(self._id_1E99._id_A4A8 == "first_person") {
    self.forcespectatorclient = var_0;
    self waittill("forced_spectator_client_loaded");
  }

  self._id_1E99._id_9815 = var_1;
  self setclientomnvar("ui_broadcaster_client_num", var_0);
  var_2 = self _meth_82F1(var_0);
  _id_A0E8(var_2);
  self notify("broadcaster_stop_target_player_puck");

  if(self._id_1E99._id_A4A8 != "first_person") {
    thread _id_1CA8();
  }

  thread _id_1C96();
  self notify("broadcaster_view_player_has_changed");
}

_id_A0E9(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;
  var_4 = "ui_broadcaster_loadout_";

  if(isDefined(var_0) && var_0 != var_2) {
    var_5 = "mp/statstable.csv";
    var_6 = 18;
    var_7 = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_0);
    var_3 = _tablelookuprownum(var_5, var_6, var_7);
  } else
    var_3 = 0;

  self setclientomnvar(var_4 + var_1, var_3);
}

_id_A0E8(var_0) {
  var_1 = 3;
  var_2 = var_0._id_90E4;

  if(isDefined(var_2)) {
    _id_A0E9(var_2._id_7709.guid, "primary_weapon");
    _id_A0E9(var_2.botgetscriptgoalradius.guid, "secondary_weapon");

    for(var_3 = 0; var_3 < 4; var_3++) {
      _id_A0E9(var_2._id_76F3[var_3], "primary_attachment_" + var_3);

      if(var_3 < 2) {
        _id_A0E9(var_2.botsetflag[var_3], "secondary_attachment_" + var_3);
      }
    }

    var_4 = maps\mp\_utility::_id_4604();
    var_5 = 0;
    var_6 = var_2._id_6F69[var_1];
    var_7 = undefined;

    if(isDefined(var_6) && var_6 != var_5) {
      var_8 = maps\mp\_utility::_id_452B(var_6);
      var_7 = _tablelookuprownum(var_4, 1, var_8);
    } else
      var_7 = var_5;

    self setclientomnvar("ui_broadcaster_loadout_training", var_7);
    self setclientomnvar("ui_broadcaster_loadout_division", var_2._id_0079);

    if(var_2._id_37FE.guid != var_5) {
      _id_A0E9(var_2._id_37FE.guid, "equipment_0");
    } else {
      _id_A0E9(undefined, "equipment_0");
    }

    if(var_2._id_69AD.guid != var_5) {
      _id_A0E9(var_2._id_69AD.guid, "equipment_1");
    } else {
      _id_A0E9(undefined, "equipment_1");
    }
  }
}

_id_1C93() {
  if(self._id_1E99._id_A4A8 == "first_person") {
    return;
  }
  var_0 = self._id_1E99;
  var_1 = var_0._id_9815;
  var_2 = bulletTrace(var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 5000, 0);
  var_3 = 1000;

  foreach(var_5 in level.players) {
    if(var_5 != var_0._id_9815 && !var_5 ismlgspectator()) {
      var_6 = distance(var_5.origin, var_2["position"]);

      if(var_6 < var_3 && isalive(var_5)) {
        var_3 = var_6;
        var_1 = var_5;
      }
    }
  }

  if(var_1 == var_0._id_9815) {
    return;
  }
  _id_1CA7(var_1 getentitynumber());
}

_id_1CA4() {
  var_0 = self;
  var_1 = _getEnt("mp_global_intermission", "classname");
  var_2 = var_1.origin;
  var_3 = var_1.angles;
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel("tag_player");
  var_4._id_92F0 = var_2;
  var_4._id_92B8 = var_3;
  var_4.setmovingplatformplayerturnrate = (0, 0, 0);
  var_4._id_9815 = undefined;
  var_4._id_A4A8 = "third_person";
  var_4._id_ACCB = 0;
  var_4._id_3DC2 = 0;
  var_4._id_77AC = 1;
  var_4.broadcasterballcamenabled = 1;
  var_0 setOrigin(var_4.origin);
  var_0 setplayerangles(var_4.angles);
  var_0 playerlinkTo(var_4, "tag_player");
  var_0 cameralinkTo(var_4, "tag_player");
  var_0 allowfire(0);
  var_0._id_1E99 = var_4;
  var_4.player = var_0;
  var_0 visionsetnakedforplayer("airplane", 5);
}

_id_1CA3() {
  level endon("game_ended");
  var_0 = 0.5;

  for(;;) {
    self waittill("broadcaster_view_set_sky_cam");
    _id_1C9A(var_0);
    self waittill("broadcaster_view_set_first_person");
    _id_1C99(var_0);
  }
}

_id_1C9A(var_0) {
  self.forcespectatorclient = self getentitynumber();
  _id_050F::_id_872F();
  self._id_1E99._id_A4A8 = "third_person";
  _luinotifyeventextra(&"broadcaster_view_skycam_applied", 1, self getentitynumber());
  level notify("broadcaster_ball_end", self._id_9815);
  self notify("changeGoalFx");
  waitframe();
  self cameralinkTo(self._id_1E99, "tag_player");
  thread _id_1CAA();
  thread _id_1CA8();

  if(isDefined(level._id_AC7C) && isDefined(level._id_AC7C.broadcastermesh)) {
    level._id_AC7C.broadcastermesh showtoplayer(self);
  }

  self._id_1E99 _meth_8472();
  self._id_1E99 thread _id_1C8C(var_0);
  self visionsetnakedforplayer("airplane", var_0);
  wait(var_0);

  if(isDefined(level.bomboutlineactive) && level.bomboutlineactive && isDefined(level.freezecontrols)) {
    level.freezecontrols hudoutlineenableforclient(self, maps\mp\_utility::_id_46D4(game["attackers"]), 0);
  }
}

_id_1C99(var_0) {
  self._id_1E99 thread _id_1C95(var_0);

  if(self._id_1E99.broadcasterballcamenabled) {
    thread broadcasterstartballcam();
  }

  self notify("broadcaster_stop_player_pucks");
  self notify("broadcaster_stop_target_player_puck");
  self notify("broadcaster_stop_zoom");
  _luinotifyeventextra(&"broadcaster_view_fps_applied", 1, self getentitynumber());
  wait(var_0);

  if(isDefined(level._id_AC7C) && isDefined(level._id_AC7C.broadcastermesh)) {
    level._id_AC7C.broadcastermesh _meth_8006(self);
  }

  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self.forcespectatorclient = self._id_1E99._id_9815 getentitynumber();
  setDvar("scr_game_lockspectatorpov", 1);
  self forcespectatepov(self getxuid(), "first_person");
  self._id_1E99._id_A4A8 = "first_person";

  if(isDefined(level.bomboutlineactive) && level.bomboutlineactive && isDefined(level.freezecontrols)) {
    level.freezecontrols hudoutlinedisableforclient(self);
  }
}

_id_1C8D(var_0, var_1) {
  var_2 = 0.05;
  var_3 = 0.0;
  var_4 = self._id_9815;
  var_5 = anglesToForward(var_4.angles);
  var_6 = self.origin - (var_4.origin + var_5 * -100 + var_1);
  var_7 = self.angles;
  var_8 = 0;

  for(;;) {
    var_9 = var_4.origin + var_1;
    var_10 = var_3 / var_0;
    var_3 = var_3 + var_2;

    if(var_10 >= 1.0) {
      break;
    }

    if(!var_8) {
      var_11 = 1.25;
      var_12 = _min(var_10 * var_11, 1.0);
      var_12 = 0.5 * (1.0 - _cos(var_12 * 180.0));
      var_13 = var_9 - self.origin;
      var_14 = _axistoangles(var_13, _vectorcross(var_13, (0, 0, 1)), (0, 0, 1));
      self.angles = _func_10B(var_7, var_14, var_12);

      if(var_12 >= 1.0) {
        self _meth_8471(var_4, "fixedoffset", var_1);
        var_8 = 1;
      }
    }

    var_10 = 0.5 * (1.0 - _cos(var_10 * 180.0));
    var_5 = anglesToForward(var_4.angles);
    self.origin = var_9 + var_5 * -100 + var_6 * (1.0 - var_10);
    waitframe();
  }
}

_id_1C95(var_0) {
  self notify("end_follows");
  self._id_9815 endon("disconnect");
  self.player endon("disconnect");
  level endon("game_ended");
  self endon("end_follows");
  var_1 = self._id_9815;
  var_2 = (0, 0, 100);
  var_3 = var_1;
  _id_1C8D(var_0, var_2);

  for(;;) {
    var_1 = self._id_9815;

    if(var_1 != var_3) {
      self _meth_8471(var_1, "fixedoffset", var_2);
    }

    var_4 = anglesToForward(var_1.angles);
    var_5 = var_1.origin + var_4 * -100 + var_2;
    self.origin = var_5;
    var_3 = var_1;
    waitframe();
  }
}

_id_1C8F(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9815)) {
    return;
  }
  var_4 = 0.05;
  var_5 = 0.0;
  var_6 = self.origin - self._id_9815.origin;
  var_7 = self._id_9815.angles;

  for(;;) {
    var_8 = self._id_9815.origin;
    var_9 = var_5 / var_0;
    var_5 = var_5 + var_4;

    if(var_9 >= 1.0) {
      break;
    }

    var_10 = 3;
    var_11 = _min(var_9 * var_10, 1.0);
    var_11 = 0.5 * (1.0 - _cos(var_11 * 180.0));
    self.angles = _func_10B(var_7, var_3, var_11);
    var_9 = 0.5 * (1.0 - _cos(var_9 * 180.0));
    var_12 = (var_8[0], var_8[1] + var_2 * var_9, var_8[2] + var_1 * var_9);
    var_12 = var_12 + var_6 * (1.0 - var_9);
    self.origin = var_12;
    waitframe();
  }
}

_id_1C8E(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9815)) {
    return;
  }
  var_4 = 0.05;
  var_5 = 0.0;
  var_6 = self._id_9815;

  for(;;) {
    var_7 = var_5 / var_0;
    var_5 = var_5 + var_4;

    if(var_7 >= 1.0) {
      self._id_53C0 = 0;
      self._id_53C1 = 0;
      break;
    }

    var_8 = var_6.origin;
    var_9 = (var_8[0], var_8[1] + var_2, var_8[2] + var_1);
    var_10 = var_3.origin;
    var_11 = (var_10[0] + self._id_53C0, var_10[1] + self._id_53C1 + var_2, var_10[2] + var_1);
    var_7 = _sin(var_7 * 90.0);
    self.origin = _vectorlerp(var_11, var_9, var_7);
    waitframe();
  }
}

_id_1C8C(var_0) {
  self notify("end_follows");
  self.player endon("disconnect");
  level endon("game_ended");
  self endon("end_follows");
  var_1 = self._id_9815;

  if(!isDefined(self._id_9815)) {
    return;
  }
  self._id_9815 endon("disconnect");
  var_2 = undefined;
  self._id_53C0 = 0;
  self._id_53C1 = 0;
  self._id_164B = 0;
  var_3 = (70, 270, 0);
  self._id_1C92 = 1;

  if(!isDefined(level._id_5FF0)) {
    level._id_5FF0 = 1024;
  }

  for(;;) {
    var_1 = self._id_9815;
    var_4 = 2000 + self._id_ACCB * 250;
    var_5 = var_4 / 2;

    if(!isDefined(var_2)) {
      _id_1C8F(var_0, var_4, var_5, var_3);
    } else if(var_2 != var_1) {
      _id_1C8E(var_0, var_4, var_5, var_2);
    }

    if(self._id_1C92) {
      var_6 = self._id_5388[1];
      var_7 = self._id_5388[0];
    } else {
      var_6 = 0;
      var_7 = 0;
    }

    var_8 = self._id_53C0 - 150 * var_6;
    var_9 = self._id_53C1 - 150 * var_7;

    if(self._id_164B && isDefined(self._id_7436)) {
      var_10 = level._id_5FF0;
      var_11 = level._id_5FEB;
      var_8 = clamp(var_8 + self._id_7436[0] - var_11[0], var_10 * -1, var_10) - self._id_7436[0] + var_11[0];
      var_9 = clamp(var_9 + self._id_7436[1] - var_11[1], var_10 * -1, var_10) - self._id_7436[1] + var_11[1];
    } else {
      self._id_7436 = var_1.origin;
      var_8 = clamp(var_8, -1000, 1000);
      var_9 = clamp(var_9, -1000, 1000);
    }

    self._id_53C0 = var_8;
    self._id_53C1 = var_9;
    self.origin = (self._id_7436[0] + var_8, self._id_7436[1] + var_9 + var_5, max(self._id_7436[2] + var_4, var_1._id_9092[2] + var_5));
    self.angles = var_3;
    waitframe();
    var_2 = var_1;
  }
}

_id_1C96() {
  if(self._id_1E99._id_3DC2 == 0) {
    return;
  }
  level endon("game_ended");
  self endon("broadcaster_view_player_has_changed");
  self endon("broadcaster_follow_killer_stop");
  var_0 = self._id_1E99._id_9815;
  var_0 waittill("death");
  thread _id_1CA7(var_0._id_00E6 getentitynumber());
}

_id_1C97() {
  if(self._id_1E99._id_3DC2) {
    self._id_1E99._id_3DC2 = 0;
    self notify("broadcaster_follow_killer_stop");
  } else {
    self._id_1E99._id_3DC2 = 1;
    thread _id_1C96();
  }
}

broadcastermoveballcam(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_2 = var_2 + -80 * var_1;
  return var_0 + var_2;
}

broadcasterkillballcam() {
  self notify("broadcaster_kill_ballcam");
  _luinotifyevent(&"broadcaster_stop_ballcam", 1, self getentitynumber());

  if(self._id_1E99._id_A4A8 == "first_person") {
    self._id_1E99.watchedball = undefined;
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    self.forcespectatorclient = self._id_1E99._id_9815 getentitynumber();
    setDvar("scr_game_lockspectatorpov", 1);
    self forcespectatepov(self getxuid(), "first_person");
    self._id_1E99 _id_1C95(0.5);
  }
}

broadcasterstartballcam() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("broadcaster_kill_ballcam");

  for(;;) {
    level waittill("broadcaster_throw_ball", var_0, var_1, var_2);

    if(!self._id_1E99.broadcasterballcamenabled || self._id_1E99._id_A4A8 == "third_person" || self._id_1E99._id_9815 != var_0) {
      continue;
    }
    self._id_1E99 notify("end_follows");
    self notify("changeGoalFx");
    self._id_1E99.watchedball = var_1._id_A582[0];
    self.forcespectatorclient = self getentitynumber();
    waitframe();
    self cameralinkTo(self._id_1E99, "tag_player", 1);
    self._id_1E99 _meth_8472();
    var_3 = broadcastermoveballcam(self._id_1E99.watchedball.origin, var_2);
    self._id_1E99 moveTo(var_3, 10.5, 5.25, 5.25);
    self._id_1E99.angles = vectortoangles(var_2);
    self._id_1E99 thread updateballcam();
    thread broadcasterstopballcam();
  }
}

broadcasterstopballcam() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("broadcaster_view_set_sky_cam");
  self endon("broadcaster_kill_ballcam");
  self._id_1E99.watchedball endon("drop_object");
  self._id_1E99.watchedball endon("death");

  for(;;) {
    level waittill("broadcaster_ball_end", var_0, var_1);

    if(isDefined(self._id_1E99.watchedball) && self._id_1E99.watchedball != var_0) {
      continue;
    }
    self._id_1E99.watchedball = undefined;

    if(var_1) {
      _luinotifyevent(&"broadcaster_stop_ballcam", 1, self getentitynumber());
    }

    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    self.forcespectatorclient = self._id_1E99._id_9815 getentitynumber();
    setDvar("scr_game_lockspectatorpov", 1);
    self forcespectatepov(self getxuid(), "first_person");
    self._id_1E99 _id_1C95(0.5);
    break;
  }
}

updateballcam() {
  self.player endon("disconnect");
  self.player endon("game_ended");
  self.player endon("broadcaster_view_set_sky_cam");
  self.player endon("broadcaster_kill_ballcam");
  self.player endon("broadcaster_view_player_has_changed");
  level endon("broadcaster_ball_end");

  for(;;) {
    if(!isDefined(self.watchedball)) {
      break;
    }

    var_0 = self.watchedball.origin;
    var_1 = self.origin;
    var_2 = _distance2d(var_0, var_1);
    var_3 = var_0 - var_1;
    var_4 = (var_3[0], var_3[1], 0);
    var_4 = vectorNormalize(var_4);
    var_5 = broadcastermoveballcam(var_0, var_4);

    if(var_2 > 600) {
      self.origin = var_5;
    } else {
      self moveTo(var_5, 0.5, 0, 0.2);
    }

    self.angles = vectortoangles(var_3);
    waitframe();
  }
}

_id_1C9B() {
  var_0 = getEntArray();
  var_1 = 0;
  _setomnvar("lighting_state", var_1);

  if(!getdvarint("233")) {
    foreach(var_3 in var_0) {
      if(isDefined(var_3._id_5D56) && isDefined(var_3.classname) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3._id_5D56 == 0) {
          continue;
        }
        if(var_3._id_5D56 == var_1) {
          var_3 common_scripts\utility::_id_8BE0();
          var_3 allowriotshieldplant();
          continue;
        }

        var_3 notify("hidingLightingState");
        var_3 _meth_8006(self);
      }
    }
  }
}

resetforplayofthegamecam() {}