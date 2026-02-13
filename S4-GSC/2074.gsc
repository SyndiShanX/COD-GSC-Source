/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2074.gsc
*************************************************/

init() {
  foreach(var_1 in level._id_EF89) {
    level._id_E3E2[var_1] = spawnStruct();
  }

  _id_0A9A::_id_C287(::_id_5F4D);
  _id_0A97::_id_C28A(::_id_AB05);

  if(getdvarint("#x3b99f63de04ee3d25", 0) != 0) {
    level thread _id_6B02();
  }
}

_id_4015(var_0, var_1) {
  _func_01B2(var_0);
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.angles = (0, 0, 0);
  return var_2;
}

_id_D5DC(var_0, var_1) {
  var_2 = var_0;

  if(var_2 >= 4) {
    var_2 = var_2 - 4;
  }

  var_3 = tolower(getDvar("#x376847958d67972ef"));
  var_4 = _func_0222(var_1, 0, var_3, var_2 * 2 + 1);

  if(var_4 != "") {
    var_5 = var_0 + 1;

    if(var_0 >= 5) {
      var_5 = var_5 - 4;
    }

    level._id_3098[var_0] = _id_4015("compass_icon_codcaster_cam", 1);
    level._id_A773[var_0] = _id_4015("compass_icon_codcaster_num" + var_5, 0);
    var_6 = _func_0222(var_1, 0, var_3, var_2 * 2 + 2);
    level._id_309F[var_0] = _id_6945(var_4);
    level._id_3083[var_0] = _id_6945(var_6);
    level._id_308F = var_0;
  }
}

_id_6B02() {
  while(!isDefined(level._id_A8DC)) {
    waitframe();
  }

  var_0 = "mp/CameraPositions";
  var_1 = var_0 + "_" + scripts\mp\utility\game::getgametype() + ".csv";
  var_0 = var_0 + ".csv";
  level._id_3098 = [];
  level._id_A773 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    _id_D5DC(var_2, var_0);
  }

  for(var_2 = 4; var_2 < 8; var_2++) {
    _id_D5DC(var_2, var_1);
  }
}

_id_6945(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = (0, 0, 0);

  if(isDefined(var_1[0]) && isDefined(var_1[1]) && isDefined(var_1[2])) {
    var_2 = (int(var_1[0]), int(var_1[1]), int(var_1[2]));
  }

  return var_2;
}

_id_AB05(var_0) {
  var_0 _id_D6E2();
}

_id_AB04(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread _id_ABA9();
  var_0 thread _id_ABAA();
  var_0 _id_D6E2();
  var_0 _id_C639();
  var_0 setclientomnvar("ui_callout_area_id", -1);

  if(var_0 _meth_81D3() || isDefined(var_0.pers["codcaster"]) && var_0.pers["codcaster"]) {
    var_0 _meth_834F(1);
    var_0 _meth_8607(0);
    var_0 thread _id_FC30();
    var_0 thread _id_1F20();
    var_0 thread _id_CB4F();
  }
}

_id_ABA9() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_cycle");
    var_0 = self getspectatingplayer();

    if(isDefined(var_0)) {
      if(isDefined(var_0._id_2F79)) {
        var_1 = level._id_2F7C._id_1A51[var_0._id_2F79];
        self setclientomnvar("ui_callout_area_id", var_1);
      }

      if(scripts\mp\utility\game::getgametype() == "ball") {
        scripts\mp\gametypes\ball::_id_212B(self);
      }
    }
  }
}

_id_ABAA() {
  self endon("disconnect");
  self endon("joined_team");

  for(;;) {
    self waittill("spectating_mlg_camera");
    var_0 = self _meth_85A9();

    if(self _meth_81D3() || isDefined(self.pers["codcaster"]) && self.pers["codcaster"]) {
      if(isDefined(var_0)) {
        self setclientomnvar("ui_callout_area_id", -1);
        continue;
      }
    }
  }
}

_id_5F4D(var_0, var_1) {
  if(var_0 == "mlg_view_change") {
    scripts\mp\playerlogic::_id_C64F();
  }
}

_id_FD35() {
  level endon("game_ended");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] _id_D6E2();
  }
}

_id_94F9(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  for(;;) {
    if(!isDefined(self._id_3A19)) {
      break;
    }

    if(self _meth_8605()) {
      waitframe();
      continue;
    }

    self cameralinkto(self._id_3A19, "tag_origin", 1);
    var_1 = level._id_3A18.origin;
    var_2 = (0, 0, 30);
    var_2 = var_2 + -80 * var_0;
    var_3 = var_1 + var_2;
    self._id_3A19 moveto(var_3, 10.5, 5.2, 5.2);
    self._id_3A19.angles = vectortoangles(var_0);
    break;
  }
}

_id_1F20() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectating_mlg_camera");
  level scripts\engine\utility::waittill_any_3("prematch_done", "start_mode_setup", "infil_started");
  level._id_9051 = game["lastSpectatedPlayer"];

  for(;;) {
    var_0 = undefined;

    if(!self _meth_81D3() || self _meth_8605() || self _meth_874D() || self _meth_8772()) {
      break;
    }

    if(level.players.size > 1) {
      if(level._id_41EA > 1 && isDefined(level._id_9051) && self.team != "follower") {
        var_0 = level._id_9051;
      } else if(self.team == "follower") {
        var_1 = self _meth_877A();
        var_2 = 0;

        foreach(var_4 in level.players) {
          if(var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
            if(var_4 getentitynumber() == var_1) {
              if(var_4.team == "spectator" || var_4.team == "follower") {
                var_2 = 1;
              } else {
                var_0 = var_1;
              }

              break;
            }
          }
        }

        if(var_2) {
          break;
        }
      } else {
        foreach(var_7 in level._id_EF89) {
          var_8 = scripts\mp\utility\teams::_id_6A59(var_7, 1);

          if(var_8.size > 0) {
            var_0 = scripts\mp\utility\player::_id_6B29(var_8, 1);
          }
        }
      }

      if(isDefined(var_0)) {
        self _meth_8606(var_0);
        break;
      }
    }

    wait 1.0;
  }
}

_id_FC30() {
  self endon("joined_team");
  self endon("disconnect");
  self._id_8B02 = 0;
  self._id_3A19 = undefined;
  self._id_E3E7 = undefined;

  for(;;) {
    if(self _meth_81D3() && self _meth_8605()) {
      var_0 = self getspectatingplayer();

      if(isDefined(var_0)) {
        level._id_9051 = var_0._id_399D;
      }
    }

    var_1 = isDefined(level._id_3A18);

    if(!var_1 || !self _meth_8608()) {
      if(self._id_8B02) {
        self._id_8B02 = 0;
        self._id_3A19 unlink();
        self._id_3A19 delete();
        self._id_3A19 = undefined;

        if(!self _meth_8605() && isDefined(self._id_E3E7)) {
          self _meth_8606(self._id_E3E7 getentitynumber());
        } else {
          self _meth_8060();
        }

        self._id_E3E7 = undefined;
      }
    } else if(!self._id_8B02) {
      if(self _meth_8608()) {
        var_0 = self getspectatingplayer();

        if(isDefined(var_0) && isDefined(level._id_3A1B) && var_0 == level._id_3A1B) {
          self._id_8B02 = 1;
          self._id_E3E7 = var_0;
          var_2 = vectornormalize(level._id_3A1A);
          var_3 = var_0 getvieworigin();
          self._id_3A19 = spawn("script_model", var_3);
          self._id_3A19.angles = vectortoangles(var_2);
          self._id_3A19 setModel("tag_origin");
          _func_0346(self getentitynumber());
          self _meth_8060();
          thread _id_94F9(var_2);
        }
      }
    } else if(isDefined(self._id_3A19)) {
      var_4 = level._id_3A18.origin;
      var_5 = self._id_3A19.origin;
      var_6 = distance2d(var_4, var_5);
      var_7 = var_4 - var_5;
      var_8 = (var_7[0], var_7[1], 0);
      var_8 = vectornormalize(var_8);
      var_9 = var_4;
      var_10 = (0, 0, 30);
      var_10 = var_10 + -80 * var_8;
      var_11 = var_9 + var_10;

      if(var_6 > 600) {
        self._id_3A19.origin = var_11;
      } else {
        self._id_3A19 moveto(var_11, 0.5, 0, 0.2);
      }

      self._id_3A19 rotateto(vectortoangles(var_7), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

_id_CB4F() {
  level waittill("game_ended");
  game["lastSpectatedPlayer"] = level._id_9051;
}

_id_D6E2(var_0) {
  if(level.gameended && gettime() - level._id_60BD >= 2000 && !istrue(level._id_BA49)) {
    if(level.teambased) {
      foreach(var_2 in level._id_EF89) {
        self _meth_8013(var_2, 0);
      }
    }

    self _meth_8013("freelook", 0);
    self _meth_8013("none", 1);
    return;
  }

  var_4 = scripts\mp\tweakables::_id_6E14("game", "spectatetype");

  if(getdvarint("#x39293fbc549331d5c", 0) == 1) {
    var_4 = 2;
  }

  if(self _meth_81D3()) {
    var_4 = 2;
  }

  if(istrue(self._id_82F0)) {
    var_4 = 0;
  }

  if(istrue(var_0)) {
    var_4 = 2;
  }

  var_5 = self.sessionteam;

  switch (var_4) {
    case 0:
      _id_D512();
      break;
    case 4:
    case 1:
      self notify("waitForGameStartSpectate");

      if(var_4 == 4) {
        var_5 = self.pers["team"];
      }

      if(var_5 != "spectator" && var_5 != "follower") {
        _id_D716(var_5);
      } else if(isDefined(self.pers["last_team"])) {
        var_5 = self.pers["last_team"];
        _id_D716(var_5);
      } else if(_id_07D1::_id_60BE("prematch_done")) {
        var_6 = randomint(level._id_EF89.size);
        _id_D716(level._id_EF89[var_6]);
      } else {
        _id_D716("allies");
        thread _id_10805();
        return;
      }

      break;
    case 2:
      _id_D56D(var_0);
      break;
    case 3:
      if(var_5 == "spectator" || var_5 == "follower") {
        _id_D56D();
      } else {
        _id_D716(var_5);
      }

      break;
  }

  if(!istrue(self._id_82F0)) {
    if(isDefined(var_5) && scripts\mp\utility\teams::_id_8878(var_5)) {
      if(istrue(level._id_E3E2[var_5]._id_15B7)) {
        self _meth_8013("freelook", 1);
      }

      if(istrue(level._id_E3E2[var_5]._id_15B5)) {
        var_7 = scripts\mp\utility\teams::_id_6A01(var_5);

        foreach(var_2 in var_7) {
          self _meth_8013(var_2, 1);
        }
      }
    }
  }
}

_id_10805() {
  self endon("waitForGameStartSpectate");
  self endon("disconnect");
  level waittill("prematch_over");
  thread _id_D6E2();
}

_id_D512() {
  self _meth_8013("freelook", 0);
  self _meth_8013("none", 0);

  foreach(var_1 in level._id_EF89) {
    self _meth_8013(var_1, 0);
  }
}

_id_D716(var_0) {
  self _meth_8013("freelook", 0);

  if(level.teambased) {
    self _meth_8013("none", 0);

    foreach(var_2 in level._id_EF89) {
      if(var_0 == var_2) {
        self _meth_8013(var_2, 1);
        continue;
      }

      self _meth_8013(var_2, 0);
    }
  } else {
    self _meth_8013("none", 1);

    foreach(var_2 in level._id_EF89) {
      self _meth_8013(var_2, 1);
    }
  }
}

_id_D56D(var_0) {
  self _meth_8013("freelook", 1);
  self _meth_8013("none", 1);

  if(_id_07D1::_id_60BE("prematch_done")) {
    foreach(var_2 in level._id_EF89) {
      self _meth_8013(var_2, 1);
    }

    if(istrue(var_0)) {
      thread scripts\mp\playerlogic::_id_E37D(undefined, undefined, 1);
      return;
    }
  } else if(self _meth_81D3()) {
    self _meth_8013("allies", 1);
    self _meth_8013("axis", 1);
    thread _id_10805();
  } else {
    var_4 = self.sessionteam;

    if(self == level.players[0] || var_4 == "spectator" || var_4 == "follower") {
      self _meth_8013("allies", 1);
      self _meth_8013("axis", 0);
      thread _id_10805();
    }
  }
}

_id_C639() {
  self._id_EC33 = undefined;
  self._id_8BDA = undefined;
  self._id_916E = undefined;
  self.pers["cur_kill_streak"] = 0;
  self._id_8D6F = 0;
}