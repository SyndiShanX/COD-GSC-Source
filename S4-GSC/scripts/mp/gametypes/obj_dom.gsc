/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
*************************************************/

_id_D896(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0.target)) {
    if(!isDefined(var_0._id_10430)) {
      var_5[0] = getent(var_0.target, "targetname");
    } else {
      var_5 = var_0._id_10430;
    }
  } else {
    var_5[0] = spawn("script_model", var_0.origin);
    var_5[0].angles = var_0.angles;
  }

  if(!isDefined(level._id_5C3B)) {
    level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 10, 0, 30);
  }

  if(isDefined(var_0._id_A8E1)) {
    var_6 = var_0._id_A8E1;
  } else {
    var_6 = var_0._id_CD99;
  }

  if(isDefined(var_0._id_7C73)) {
    var_7 = var_0._id_7C73;
  } else {
    var_7 = var_0._id_CD99;
  }

  if(istrue(var_2)) {
    var_8 = _id_6CED(var_6);
  } else {
    var_8 = undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = "neutral";
  }

  var_9 = _id_07D6::_id_406E(var_1, var_0, var_5, (0, 0, 100), var_8, var_3, var_4);
  var_9 _id_07D6::_id_15DF("enemy");
  var_9 _id_07D6::_id_316A(1);
  var_9 _id_07D6::_id_D8D2(level._id_5C3B);

  if(isDefined(level._id_3236)) {
    var_9 _id_07D6::_id_D4B2(_id_694D());
  }

  var_9._id_A8E1 = var_6;
  var_9._id_7C73 = var_7;

  if(!istrue(var_3)) {
    var_9 _id_07D6::_id_D8E0("any");
    var_9._id_ABCB = ::_id_4D4F;
    var_9._id_AA79 = ::_id_4D50;
    var_9._id_ABD4 = ::_id_4D52;
    var_9._id_AAC2 = ::_id_4D51;
    var_9._id_AA8D = ::_id_4D47;
    var_9._id_ABC7 = ::_id_4D4C;
    var_9._id_ABC8 = ::_id_4D4D;
    var_9._id_AB54 = ::_id_4D4B;
    var_9._id_ABC9 = ::_id_4D4E;
    var_9._id_E86E = ::_id_4D55;
  }

  var_9._id_A6C4 = 1;
  var_9._id_7C8C = "domFlag";
  var_9._id_37F3 = level._id_5C3B * 1000;
  var_9._id_5BC6 = 1;
  var_9 _id_07D6::_id_B0E7();
  var_10 = var_5[0].origin + (0, 0, 32);
  var_11 = var_5[0].origin + (0, 0, -32);
  var_12 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_13 = [];
  var_14 = scripts\engine\trace::ray_trace(var_10, var_11, var_13, var_12);
  var_15 = _id_3529(var_9);
  var_9._id_22B7 = var_14["position"] + var_15;
  var_16 = vectortoangles(var_14["normal"]);
  var_17 = _id_3528(var_9, var_16);
  var_9._id_22B6 = anglesToForward(var_17);
  var_18 = spawn("script_model", var_9._id_22B7);

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_18 setModel("dom_flag_holiday_scriptable");
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_18 setModel("dom_flag_valentines_scriptable");
  } else if(!scripts\engine\utility::is_equal(level.gametype, "base")) {
    var_18 setModel("dom_flag_scriptable");
  }

  var_18.angles = _func_030A(var_9._id_22B6, var_18.angles);
  var_9._id_03A9 = var_18;
  var_9._id_103BF = "";

  if(scripts\mp\utility\game::_id_875E()) {
    var_9._id_A5D5 = 1;
  }

  if(istrue(level._id_A2FC)) {
    var_9._id_A5D5 = 1;
  }

  if(istrue(var_9._id_A5D5) && !scripts\engine\utility::is_equal(level.gametype, "base")) {
    var_9._id_5C3F = spawn("script_model", var_9._id_22B7);
    var_9._id_5C3F setModel("");
    var_9._id_5C3F hide();
    var_9.friendlyflagmodel = spawn("script_model", var_9._id_22B7);
    var_9.friendlyflagmodel setModel("");
    var_9 thread flagmodelcoreloop(var_9.friendlyflagmodel, "allies");
    var_9.enemyflagmodel = spawn("script_model", var_9._id_22B7);
    var_9.enemyflagmodel setModel("");
    var_9 thread flagmodelcoreloop(var_9.enemyflagmodel, "axis");
    var_9._id_ACD6 = var_9._id_5C3F;
  }

  var_9 _id_81E4();

  if(!istrue(var_3)) {
    var_9 _id_4D27();
  }

  return var_9;
}

flagmodelcoreloop(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    if(flagupdatecolor(var_0, var_1) == 0) {
      break;
    }

    scripts\engine\utility::_id_108F5("updateFlagState", 0.5);
  }
}

flagupdatecolor(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 hide();
  var_2 = _id_07D6::_id_6C02();

  if(var_2 == var_1) {
    var_0 setModel("");
  } else if(var_2 != "neutral") {
    var_0 setModel("");
  } else {
    var_0 setModel("");
  }

  foreach(var_4 in level.players) {
    if(var_4.team == var_1) {
      var_0 showtoplayer(var_4);
    }
  }

  return 1;
}

_id_C4F2(var_0) {
  if(isDefined(var_0._id_5C3F)) {
    var_0._id_5C3F delete();
  }

  if(isDefined(var_0.enemyflagmodel)) {
    var_0.enemyflagmodel delete();
  }

  if(isDefined(var_0.friendlyflagmodel)) {
    var_0.friendlyflagmodel delete();
  }

  if(isDefined(var_0._id_03A9)) {
    var_0._id_03A9 delete();
  }

  var_0 _id_07D6::_id_479D();
}

_id_6CED(var_0) {
  switch (var_0) {
    case "_a":
      var_1 = 0;
      break;
    case "_b":
      var_1 = 1;
      break;
    case "_c":
      var_1 = 2;
      break;
    case "_d":
      var_1 = 3;
      break;
    case "_e":
      var_1 = 4;
      break;
    case "_f":
      var_1 = 5;
      break;
    case "_g":
      var_1 = 6;
      break;
    default:
      var_1 = 7;
      break;
  }

  return var_1;
}

_id_694D() {
  var_0 = "normal";

  if(level._id_3236 == 2) {
    var_0 = "neutralize";
  } else if(level._id_3236 == 3) {
    var_0 = "persistent";
  }

  return var_0;
}

_id_3529(var_0) {
  var_1 = var_0._id_A8E1;
  var_2 = (0, 0, 0);

  if(level.mapname == "mp_quarry") {
    if(var_1 == "_c") {
      var_2 = var_2 + (0, 0, 7);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_1 == "_a") {
      var_2 = var_2 + (0, 0, 4.5);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_1 == "_a") {
      var_2 = var_2 + (0, 0, 5);
    }

    if(var_1 == "_c") {
      var_2 = var_2 + (0, 0, 1);
    }
  }

  return var_2;
}

_id_3528(var_0, var_1) {
  var_2 = var_0._id_A8E1;
  var_3 = var_1;

  if(level.mapname == "mp_quarry") {
    if(var_2 == "_c") {
      var_3 = (276.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_2 == "_a") {
      var_3 = (273.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_2 == "_a") {
      var_3 = (273.5, 200.5, var_3[2]);
    }

    if(var_2 == "_c") {
      var_3 = (273.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_faridah") {
    if(_func_0121(var_2)) {
      if(var_2 == "_school") {
        var_3 = (270, 0, 0);
      } else if(var_2 == "_warehouse") {
        var_3 = (270, 0, 0);
      }
    }
  }

  return var_3;
}

_id_81E4() {
  if(isDefined(level._id_9BDA)) {
    self._id_979C = [[level._id_9BD1]]();
    var_0 = "A";

    switch (self._id_A8E1) {
      case "_a":
        var_0 = "A";
        break;
      case "_b":
        var_0 = "B";
        break;
      case "_c":
        var_0 = "C";
        break;
      case "_d":
        var_0 = "D";
        break;
      case "_e":
        var_0 = "E";
        break;
      case "_f":
        var_0 = "F";
        break;
      case "_g":
        var_0 = "G";
        break;
      case "0":
        var_0 = "0";
        break;
      case "1":
        var_0 = "1";
        break;
      case "2":
        var_0 = "2";
        break;
      case "3":
        var_0 = "3";
        break;
      case "4":
        var_0 = "4";
        break;
      default:
        break;
    }

    self._id_9791 = "FLAG_" + var_0;
  }

  if(_id_07A9::_id_1768()) {
    self._id_1769 = _id_07A9::_id_6E24();
    self._id_176A = "dom_flag" + self._id_A8E1;
  }
}

_id_4D27(var_0) {
  self notify("flag_neutral");
  _id_07D6::_id_D61B(level._id_7C74);
  _id_07D6::_id_D639("neutral");
  thread _id_FC64("idle", istrue(var_0));

  if(isDefined(level._id_9BDA) && isDefined(self._id_979C) && isDefined(self._id_9791)) {
    [[level._id_9BDA]](self._id_979C, undefined, self._id_9791, self._id_10430[0].origin[0], self._id_10430[0].origin[1], gettime(), 0);
  }

  _id_07A9::_id_976A(self._id_176A, self._id_1769, self._id_10430[0].origin, -1, "neutral");
}

_id_4D53(var_0, var_1) {
  _id_07D6::_id_D639(var_0);
  self notify("capture", var_1);
  self notify("assault", var_1);

  if(istrue(level._id_A782)) {
    var_2 = _id_6DCE(var_0);

    if(var_2 >= level._id_A782) {
      level._id_EFA5[var_0] = 1;
    } else {
      level._id_EFA5[var_0] = 0;
    }
  }

  _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);

  if(scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::_id_FCBF(self._id_ADAE, 15, 14);
  }

  if(scripts\mp\utility\game::getgametype() == "base") {
    var_3 = _func_00CA("build_scriptable", "script_noteworthy", self.origin, 3000);

    foreach(var_5 in var_3) {
      var_5.team = var_0;

      if(isDefined(var_5._id_C54F._id_FEE8)) {
        var_5._id_C54F._id_FEE8 _id_07D6::_id_D639(var_0);
        var_5._id_C54F._id_FEE8 _id_07D6::_id_15DF("friendly");
      }

      if(var_5.classname == scripts\mp\gametypes\base::_id_22BB()) {
        scripts\mp\gametypes\base::_id_FC7F(var_5);
      }
    }
  }

  self._id_A435 = 0;
  thread _id_FC64(var_0, 0, var_0);

  if(self._id_F396[var_0].size == 0 && isDefined(self._id_AA3C)) {
    self._id_F396 = self._id_AA3C;
  }

  foreach(var_8 in level._id_EF89) {
    if(isDefined(self._id_1D2E[var_8]) && var_8 != var_0) {
      self._id_1D2E[var_8] = [];
    }
  }

  if(isDefined(self._id_1D2E[var_0])) {
    var_10 = getarraykeys(self._id_1D2E[var_0]);

    foreach(var_12 in var_10) {
      var_13 = self._id_1D2E[var_0][var_12].player;

      if(isDefined(var_13.owner)) {
        var_13 = var_13.owner;
      }

      if(!isPlayer(var_13)) {
        continue;
      }
      var_13 _id_07BC::_id_AA81();
    }
  }

  thread _id_6F9A(self._id_F396[var_0], var_1, var_0);

  if(isDefined(level._id_9BDA)) {
    [[level._id_9BDA]](self._id_979C, undefined, self._id_9791, self._id_10430[0].origin[0], self._id_10430[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "allies", 1, 2));
  }

  _id_07A9::_id_976A(self._id_176A, self._id_1769, self._id_10430[0].origin, -1, "captured_" + var_0);
}

_id_4D4F(var_0) {
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
  self._id_3235 = gettime();
  self._id_A435 = 0;

  if(istrue(level._id_5C41)) {
    var_3 = _id_07D6::_id_6C02();

    if(var_3 == "neutral") {
      _id_4D53(var_1, var_0);
    } else {
      thread _id_4D27(1);
      _id_0AA2::_id_B8F1("mp_dom_flag_lost", var_3);
      level._id_8FA1 = gettime();
      thread _id_6F98(self._id_F396[var_1]);
      self._id_A435 = 1;
    }
  } else
    _id_4D53(var_1, var_0);

  if(!self._id_A435) {
    var_4 = 3;

    if(self._id_A8E1 == "_a") {
      var_4 = 1;
    } else if(self._id_A8E1 == "_b") {
      var_4 = 2;
    } else if(self._id_A8E1 == "_d") {
      var_4 = 4;
    } else if(self._id_A8E1 == "_e") {
      var_4 = 5;
    } else if(self._id_A8E1 == "_f") {
      var_4 = 6;
    } else if(self._id_A8E1 == "_g") {
      var_4 = 7;
    }

    var_5 = 21;
    var_6 = _id_6DCE(var_1);
    var_7 = level._id_A8E8.size;

    if(var_6 == var_7) {
      var_5 = 25;
    }

    scripts\mp\utility\game::_id_D5FA(var_5, var_1, var_0 getentitynumber(), var_4);

    if(isDefined(level._id_AB42)) {
      [[level._id_AB42]]("dompoint", self._id_A8E1, var_0, var_1, var_2, self);
    }
  }

  self._id_5BC6 = 0;
}

_id_4D50(var_0) {
  var_1 = _id_07D6::_id_6C02();
  self._id_A436 = istrue(level._id_5C41) && var_1 != "neutral";

  if(self._id_A436) {
    if(var_1 != var_0.team) {
      var_2 = _id_69ED();
    } else {
      var_2 = 0;
    }
  } else if(var_1 != var_0.team)
    var_2 = 1;
  else {
    var_2 = 0;
  }

  var_0 setclientomnvar("ui_objective_state", var_2);

  if(!isDefined(self._id_E776)) {
    self._id_E776 = gettime();
  }

  if(!istrue(self._id_A435) && self._id_E776 > self._id_E776 + 5000) {
    self._id_497A = 0;
    self._id_E776 = gettime();
  }

  if(isDefined(level.flagcapturetime_neutral) && var_1 == "neutral") {
    var_3 = level.flagcapturetime_neutral;
  } else {
    var_3 = scripts\engine\utility::ter_op(istrue(level._id_5C41) && !self._id_5BC6, level._id_5C3B * 0.5, level._id_5C3B);
  }

  _id_07D6::_id_D8D2(var_3);

  if(var_3 > 0) {
    self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    _id_07D6::_id_D61B(level._id_7C6F, level._id_7C87);
  }

  if(istrue(level._id_78F7)) {
    if(var_0.team != var_1) {
      _id_07D6::_id_D8E0("any");
    }
  }
}

_id_4D52(var_0, var_1, var_2, var_3) {
  _id_07F9::objective_set_claiming_team(self._id_A908, var_0);
  var_4 = _id_07D6::_id_6C02();

  if(var_1 < 1.0 && !level.gameended && !scripts\mp\utility\game::isanymlgmatch()) {
    _id_B21A(var_1, var_0);
  }

  if(isDefined(level._id_3230) && level._id_3230) {
    var_5 = 0;

    for(var_6 = 0; var_6 < level._id_3230; var_6++) {
      if(!isDefined(self._id_D030)) {
        self._id_D030 = 0;
      }

      var_7 = (var_6 + 1) / 3;

      if(var_1 > var_7 && self._id_D030 <= var_6) {
        self._id_D030 = var_6 + 1;
        var_5 = 1;
      }
    }

    if(var_5) {
      foreach(var_9 in self._id_F396[var_0]) {
        if(scripts\mp\utility\game::getgametype() == "control" && self._id_D030 != level._id_3230) {
          var_10 = var_9.player;
          var_10 thread scripts\mp\rank::_id_CC00("segment_captured");
          var_10 setclientomnvar("ui_segment_captured", self._id_D030);

          if(isDefined(var_10.pers["objective_tiers_contributed"])) {
            var_10 scripts\mp\utility\stats::_id_7DAE("objective_tiers_contributed", 1);
          }
        }
      }

      if(isDefined(self.onsegmentcapture)) {
        self[[self.onsegmentcapture]](var_0, var_3, self._id_D030);
      }

      if(self._id_D030 != level._id_3230) {
        var_12 = 2;

        if(self._id_A8E1 == "_a") {
          var_12 = 1;
        }

        scripts\mp\utility\game::_id_D5FA(23, var_0, var_3 getentitynumber(), var_12);
      }

      var_13 = spawnStruct();
      var_13.objective_entity = self;
      _id_06E2::_id_4C2A("callback_objective_state_changed", var_13);
    }
  }

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    if(var_4 == "neutral") {
      if(level._id_5C3B > 0.05) {
        _id_0A8D::_id_E775("securing" + self._id_A8E1, var_0);

        if(isDefined(level._id_A8E8) && level._id_A8E8.size == 5 && (self._id_A8E1 == "_c" || self._id_A8E1 == "_d") || self._id_A8E1 == "_b") {
          var_14 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
          _id_0A8D::_id_E775("losing" + self._id_A8E1, var_14);
        }
      }
    } else if(level._id_5C3B > 0.05) {
      _id_0A8D::_id_E775("losing" + self._id_A8E1, var_4);
      _id_0A8D::_id_E775("securing" + self._id_A8E1, var_0);
    }

    self._id_497A = 1;
  }
}

_id_4D51(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  var_3 = _id_07D6::_id_6C02();

  if(var_3 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    thread _id_FC64("idle", 0);
  } else {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
    thread _id_FC64(var_3, 0);
  }

  if(!var_2) {
    self._id_A435 = 0;
  }
}

_id_4D47() {
  _id_07D6::_id_D61B(level._id_7C48);
  _id_07F9::_id_A8B6(self._id_A908, undefined);
  thread _id_FC64("contested", 0);
  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
  var_0 = spawnStruct();
  var_0.objective_entity = self;
  _id_06E2::_id_4C2A("callback_objective_state_changed", var_0);
}

_id_4D4C(var_0) {
  if(istrue(level._id_5C41) && !self._id_5BC6) {
    _id_07D6::_id_D8D2(level._id_5C3B * 0.5);
  }

  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    if(var_0 != "none") {
      _id_07F9::_id_A8B6(self._id_A908, var_0);
    } else if(isDefined(self._id_902E)) {
      _id_07F9::_id_A8B6(self._id_A908, self._id_902E);
    }
  } else
    _id_07F9::_id_A8B6(self._id_A908, scripts\mp\utility\game::_id_6BE2(var_1)[0]);

  if(var_0 == "none" || var_1 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    self._id_497A = 0;
  } else if(scripts\mp\utility\game::getgametype() == "control" && var_1 != "neutral") {
    if(var_1 != var_0) {
      _id_07D6::_id_D61B(level._id_7C4B, level._id_7C87);
    } else {
      _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
    }
  } else
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  thread _id_FC64(var_2, 0);
  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
}

_id_B21A(var_0, var_1) {
  if(!isDefined(self._id_903F)) {
    self._id_903F = gettime();
  }

  if(self._id_903F + 995 < gettime()) {
    self._id_903F = gettime();
  }
}

_id_4D4D() {
  var_0 = _id_07D6::_id_6C02();

  if(var_0 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
  } else {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  }

  self._id_497A = 0;
  _id_07F9::objective_set_claiming_team(self._id_A908, "neutral");
}

_id_4D4B(var_0) {
  if(self._id_ADAE != "neutral" && self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
  }
}

_id_4D4E(var_0) {
  if(scripts\mp\utility\game::getgametype() != "control" && self._id_ADAE != "neutral" && !self._id_A79A[self._id_ADAE] && !self._id_E57B) {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  }
}

_id_4D55(var_0) {
  var_0 thread _id_0A9F::_id_7003("obj_prog_defend");
  _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
}

_id_D4EF(var_0) {
  if(isDefined(level._id_EB99) && level._id_EB99 && isDefined(var_0._id_3E59) && var_0._id_3E59) {
    var_0 _id_07C1::_id_D4EE("assist");
  }
}

_id_4D54() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
}

_id_FC64(var_0, var_1, var_2) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(isDefined(self._id_A5D5)) {
    return;
  }
  while(!isDefined(self._id_03A9)) {
    waitframe();
  }

  if(scripts\mp\utility\game::getgametype() == "defcon") {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arm") {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "base") {
    scripts\mp\gametypes\s4_base_util::updatebaselightstate(var_0);
    return;
  }

  if(isDefined(self._id_03A9)) {
    if(var_0 == "off") {
      _id_D52F("flag", var_0);
    } else {
      _id_D52F("flag", var_0, self._id_103BF);
    }
  }
}

_id_D52F(var_0, var_1, var_2) {
  if(!isDefined(self._id_03A9) || var_1 == "contested") {
    return;
  }
  if(isDefined(level._id_D530)) {
    if([[level._id_D530]](var_0, var_1, var_2)) {
      return;
    }
  }

  if(isDefined(var_2)) {
    var_1 = var_1 + var_2;
  }

  self._id_03A9 setscriptablepartstate(var_0, var_1);
}

_id_FC63(var_0) {
  if(isDefined(self._id_A5D5)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "defcon") {
    if(isDefined(self._id_03A9)) {
      _id_D52F("pulse", var_0, self._id_103BF);
    }
  }
}

_id_AAB6() {
  self waittill("disconnect");

  foreach(var_1 in self._id_0BC6) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  foreach(var_4 in self._id_0BC7) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

_id_6F98(var_0) {
  level endon("game_ended");
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_0[var_1[var_2]].player;

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.owner)) {
      var_3 = var_3.owner;
    }

    if(!isPlayer(var_3)) {
      continue;
    }
    if(istrue(level._id_5C41)) {
      var_3 thread scripts\mp\rank::_id_CC00("neutralized");
    } else {
      var_3 thread scripts\mp\rank::_id_CC00("capture");
    }

    var_3 thread _id_07B1::_id_6FB9("mode_dom_neutralized");
    var_3 _id_D4EF(var_3);
    wait 0.05;
  }
}

_id_6F9A(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_1;

  if(isDefined(var_3.owner)) {
    var_3 = var_3.owner;
  }

  level._id_8FA1 = gettime();
  level._id_B84F = 1;

  if(isPlayer(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "rush") {
      level thread scripts\mp\hud_util::_id_EF8D("callout_securedposition", var_3);
    } else {
      level thread scripts\mp\hud_util::_id_EF8D("callout_securedposition" + self._id_A8E1, var_3);
    }

    var_4 = spawnStruct();
    var_4.player = var_3;
    var_4._id_56B9 = "capture";
    var_4._id_033E = var_3.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_4);
  }

  if(self._id_5BC6 == 1) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }

  if(isDefined(var_0)) {
    var_6 = getarraykeys(var_0);

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      var_8 = var_0[var_6[var_7]].player;

      if(isDefined(var_8.owner)) {
        var_8 = var_8.owner;
      }

      if(!isPlayer(var_8)) {
        continue;
      }
      var_8 _id_D4B3();
      _id_6F8A(var_8, var_5, 0);
      var_8 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_012");
      _id_D4EF(var_8);
      wait 0.05;
    }

    if(isDefined(self._id_1D2E)) {
      if(self._id_1D2E[var_2].size > 0) {
        var_9 = getarraykeys(self._id_1D2E[var_2]);

        foreach(var_11 in var_6) {
          foreach(var_13 in var_9) {
            if(var_13 == var_11) {
              self._id_1D2E[var_2][var_13] = undefined;
            }
          }
        }
      }

      if(self._id_1D2E[var_2].size > 0) {
        thread _id_6F99(var_2, var_5);
      }
    }
  }
}

_id_6F99(var_0, var_1) {
  level endon("game_ended");
  var_2 = getarraykeys(self._id_1D2E[var_0]);

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = self._id_1D2E[var_0][var_2[var_3]].player;

      if(isDefined(var_4.owner)) {
        var_4 = var_4.owner;
      }

      if(!isPlayer(var_4)) {
        continue;
      }
      var_4 _id_D4B3();
      _id_6F8A(var_4, var_1, 1);
      _id_D4EF(var_4);
      self._id_1D2E[var_0][var_2[var_3]] = undefined;
      wait 0.05;
    }
  }
}

_id_6F8A(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";
  var_5 = scripts\mp\utility\game::getgametype() == "control";
  var_6 = scripts\mp\utility\game::getgametype() == "base";

  if(var_2) {
    var_0 thread scripts\mp\rank::_id_CC00("capture_assist");
    var_4 = "mode_dom_secure_assist";

    if(var_5) {
      var_4 = "mode_control_secure_assist";
    } else if(var_6) {
      var_4 = "mode_base_secure_assist";
    }
  } else if(var_1) {
    var_7 = scripts\mp\utility\game::getgametype() == "arm";
    var_8 = !var_7 && self._id_A8E1 == "_b" || var_7 && self._id_A8E1 == "_c";
    var_9 = var_7 && (self._id_A8E1 == "_b" || self._id_A8E1 == "_d");

    if(var_6) {
      var_0 thread scripts\mp\rank::_id_CC00("neutral_capture");
      var_4 = "mode_base_secure_neutral";
    } else if(var_8) {
      if(var_7) {
        var_0 thread scripts\mp\rank::_id_CC00("neutral_capture");
        var_4 = "mode_arm_secure_mid";
      } else {
        var_0 thread scripts\mp\rank::_id_CC00("neutral_b_capture");
        var_4 = "mode_dom_secure_b";
      }
    } else if(var_9) {
      var_0 thread scripts\mp\rank::_id_CC00("neutral_capture");
      var_4 = "mode_arm_secure_outer_mid";
    } else if(var_7) {
      var_0 thread scripts\mp\rank::_id_CC00("neutral_capture");
      var_4 = "mode_arm_secure_outer";
    } else {
      var_0 thread scripts\mp\rank::_id_CC00("neutral_capture");
      var_4 = "mode_dom_secure_neutral";
    }
  } else if(istrue(level._id_5C41)) {
    var_0 thread scripts\mp\rank::_id_CC00("capture");
    var_4 = "mode_dom_neutralized_cap";

    if(var_6) {
      var_4 = "mode_base_neutralized_cap";
    }
  } else {
    var_0 thread scripts\mp\rank::_id_CC00("capture");
    var_4 = "mode_dom_secure";

    if(var_5) {
      var_4 = "mode_control_secure";
    } else if(var_6) {
      var_4 = "mode_base_secure";
    }
  }

  var_0 thread _id_07B1::_id_6FB9(var_4);

  if(var_3) {
    var_0 scripts\mp\killstreaks\killstreaks::_id_6FF5("capture", 1, 0);
  }
}

_id_D4B3() {
  scripts\mp\utility\stats::_id_7DAE("captures", 1);

  if(isDefined(self.pers["captures"])) {
    scripts\mp\persistence::_id_E770("round", "captures", self.pers["captures"]);

    if(!scripts\mp\utility\game::_id_875E()) {
      scripts\mp\utility\stats::_id_D550(self.pers["captures"]);
    }
  }
}

_id_BB6E() {
  _id_E9BC();
  var_0 = [];
  var_0[var_0.size] = level._id_3390;

  if(game["switchedsides"]) {
    level._id_39EB = _id_6E25("axis", level._id_3390);
    var_0[var_0.size] = level._id_39EB;
    level._id_39EC = _id_6E25("allies", var_0);
  } else {
    level._id_39EB = _id_6E25("allies", level._id_3390);
    var_0[var_0.size] = level._id_39EB;
    level._id_39EC = _id_6E25("axis", var_0);
  }

  level._id_39EB _id_D560("allies", "neutral", undefined, 1);
  level._id_39EC _id_D560("axis", "neutral", undefined, 1);
}

_id_E9BC() {
  var_0 = undefined;

  foreach(var_2 in level._id_A8E8) {
    if(var_2._id_A8E1 == "_b") {
      level._id_3390 = var_2;
    }
  }
}

_id_D560(var_0, var_1, var_2, var_3) {
  _id_07D6::_id_D639(var_0);
  _id_07D6::_id_D61B(level._id_7C50, level._id_7C42);
  thread _id_FC64(var_0, 0);
  self._id_3235 = gettime();
  var_4 = scripts\mp\utility\game::getgametype();

  if(var_4 == "siege") {
    scripts\mp\gametypes\siege::_id_10AE9(var_0);
  }

  if(!isDefined(var_3)) {
    if(var_1 != "neutral") {
      var_5 = _id_6DCE(var_0);

      if(var_5 == 2) {
        _id_0A8D::_id_E775("friendly_captured_2", var_0);
        _id_0A8D::_id_E775("enemy_captured_2", var_1);
      } else {
        _id_0A8D::_id_E775("secured" + self._id_A8E1, var_0);
        _id_0A8D::_id_E775("lost" + self._id_A8E1, var_1);
      }

      level._id_8FA1 = gettime();
    }

    if(var_4 == "siege") {
      scripts\mp\gametypes\siege::_id_EF9C(var_0, var_2);
    }

    self._id_5BC6 = 0;
  }
}

_id_6DCE(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_8860(var_0, var_1) {
  var_2 = 0;

  if(_func_0107(var_1)) {
    foreach(var_4 in var_1) {
      if(var_0 == var_4) {
        var_2 = 1;
        break;
      }
    }
  } else if(var_0 == var_1)
    var_2 = 1;

  return var_2;
}

_id_6E25(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level._id_A8E8) {
    if(var_6 _id_07D6::_id_6C02() != "neutral") {
      continue;
    }
    var_7 = distancesquared(var_6.trigger.origin, level._id_0405[var_0]);

    if(isDefined(var_1)) {
      if(!_id_8860(var_6, var_1) && (!isDefined(var_2) || var_7 < var_3)) {
        var_3 = var_7;
        var_2 = var_6;
      }

      continue;
    }

    if(!isDefined(var_2) || var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6;
    }
  }

  return var_2;
}

_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.origin;
  var_15 = var_1.origin;
  var_16 = 0;

  if(!isDefined(var_1.team) || !isDefined(var_13.team)) {
    return;
  }
  if(isDefined(var_0)) {
    var_15 = var_0.origin;
    var_16 = var_0 == var_1;
  }

  foreach(var_18 in level._id_A8E8) {
    if(!isDefined(var_18.trigger) || istrue(var_18.trigger._id_F5E0)) {
      continue;
    }
    var_19 = var_18 _id_07D6::_id_6C02();
    var_20 = var_1 istouching(var_18.trigger);
    var_21 = var_13 istouching(var_18.trigger);

    if(var_20 && var_1.team != var_19) {
      var_1 thread _id_0A9F::_id_7003("capture_kill");
      var_18 notify("assault", var_1);
      var_11 = 1;
    }

    if(var_19 == "neutral") {
      if(var_20 || var_21) {
        if(var_18._id_37F6 == var_13.team) {
          if(!var_11) {
            var_11 = 1;
            var_1 thread scripts\mp\rank::_id_CC00("assault");
            var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
            var_18 notify("assault", var_1);
            continue;
          }
        } else if(var_18._id_37F6 == var_1.team) {
          if(!var_12) {
            var_12 = 1;
            var_1 thread scripts\mp\rank::_id_CC00("defend");
            var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
            var_18 notify("defend", var_1);
            var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
            var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
            var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
            continue;
          }
        }
      }
    } else if(var_19 != var_1.team) {
      if(!var_11) {
        var_22 = _id_4BBA(var_18.trigger, var_15, var_14);

        if(var_22) {
          var_11 = 1;
          var_1 thread scripts\mp\rank::_id_CC00("assault");
          var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
          var_18 notify("assault", var_1);
          continue;
        }
      }
    } else if(!var_12) {
      var_23 = _id_4BBA(var_18.trigger, var_15, var_14);

      if(var_23) {
        var_12 = 1;
        var_1 thread scripts\mp\rank::_id_CC00("defend");
        var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        var_18 notify("defend", var_1);
        var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
        var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
        var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
        continue;
      }
    }
  }
}

_id_4BBA(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0._id_9FF8)) {
      return 1;
    } else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_69ED() {
  switch (self._id_A8E1) {
    case "_a":
      return 6;
    case "_b":
      return 7;
    case "_c":
      return 8;
    default:
      return 6;
  }
}