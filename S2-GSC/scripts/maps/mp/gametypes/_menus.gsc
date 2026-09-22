/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_menus.gsc
************************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level._id_6520) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level._id_6520) {
      for(var_0 = 0; var_0 < level._id_985B.size; var_0++) {
        var_1 = "menu_class_" + level._id_985B[var_0];
        var_2 = "menu_changeclass_" + level._id_985B[var_0];
        game[var_1] = game["menu_class_allies"];
        game[var_2] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";

    if(level._id_258F) {
      game["menu_controls"] = "ingame_controls";

      if(level.splitscreen) {
        if(level._id_6520) {
          for(var_0 = 0; var_0 < level._id_985B.size; var_0++) {
            var_1 = "menu_class_" + level._id_985B[var_0];
            var_2 = "menu_changeclass_" + level._id_985B[var_0];
            game[var_1] = game[var_1] + "_splitscreen";
            game[var_2] = game[var_2] + "_splitscreen";
          }
        }

        game["menu_team"] = game["menu_team"] + "_splitscreen";
        game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
        game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
        game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
        game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
        game["menu_controls"] = game["menu_controls"] + "_splitscreen";
        game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
        game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
      }
    }

    precachestring(&"MP_HOST_ENDED_GAME");
    precachestring(&"MP_HOST_ENDGAME_RESPONSE");
  }

  if(!_func_367()) {
    level thread onplayerconnect();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_A921();
  }
}

getclasschoice(var_0) {
  if(var_0 <= 100) {
    if(maps\mp\_utility::_id_761E()) {
      var_0 = "practice" + var_0;
    } else {
      var_0 = "custom" + var_0;
    }
  } else if(var_0 <= 200) {
    var_0 = var_0 - 101;
    var_0 = "class" + var_0;
  } else if(var_0 <= 206) {
    var_0 = var_0 - 200;
    var_0 = "axis_recipe" + var_0;
  } else {
    var_0 = var_0 - 206;
    var_0 = "allies_recipe" + var_0;
  }

  return var_0;
}

_id_A921() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "class_select") {
      _id_4AAF(var_1);
    }

    if(var_0 == "end_game") {
      _id_4AD2();
    }

    if(var_0 == "team_select") {
      _id_4AFB(var_1);
    }
  }
}

_id_4AAF(var_0) {
  if(maps\mp\_utility::_id_56B3() && self ismlgspectator() && !maps\mp\_utility::_id_551F()) {
    self setclientomnvar("ui_options_menu", 0);
  } else {
    if(!istestclient(self) && !_isai(self)) {
      if("" + var_0 != "callback") {
        self setclientomnvar("ui_loadout_selected", var_0);
      }
    }

    if(isDefined(self._id_A6EF) && self._id_A6EF) {
      return;
    }
    if(!maps\mp\_utility::_id_0C1E()) {
      return;
    }
    self setclientomnvar("ui_options_menu", 0);

    if("" + var_0 != "callback") {
      if(isbot(self) || istestclient(self)) {
        self.pers["class"] = var_0;
        self.class = var_0;
        maps\mp\gametypes\_class::_id_23DC();
        return;
      }

      var_1 = var_0 + 1;
      var_1 = getclasschoice(var_1);

      if(!isDefined(self.pers["class"]) || var_1 == self.pers["class"]) {
        return;
      }
      self.pers["class"] = var_1;
      self.class = var_1;
      maps\mp\gametypes\_class::_id_23DC();
      thread _id_6112();
      return;
      return;
    }

    _id_6111("callback");
  }
}

_id_4AD2() {
  level thread maps\mp\gametypes\_gamelogic::_id_3E1A();
}

_id_4AFB(var_0) {
  if(!getdvarint("3193") && level.gametype != "infect") {
    if(maps\mp\_utility::matchmakinggame() && !getdvarint("850") && !getdvarint("5357")) {
      return;
    }
  }

  if(common_scripts\utility::_id_562E(level.blockteamchange) && common_scripts\utility::_id_562E(self.hasspawned)) {
    return;
  }
  if(var_0 != 3) {
    thread _id_8C08();
  }

  if(var_0 == 3) {
    self setclientomnvar("ui_options_menu", 0);
    self setclientomnvar("ui_spectator_selected", 1);
    self setclientomnvar("ui_loadout_selected", -1);
    self._id_90E3 = 1;

    if(maps\mp\_utility::_id_56B3()) {
      self setmlgspectator(1);
      thread _id_050F::_id_872F();
    }
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self._id_90E3 = 0;

    if(maps\mp\_utility::_id_56B3()) {
      self setmlgspectator(0);
    }
  }

  self setclientomnvar("ui_team_selected", var_0);

  if(var_0 == 0) {
    var_0 = "axis";
  } else if(var_0 == 1) {
    var_0 = "allies";
  } else if(var_0 == 2) {
    var_0 = "random";
  } else {
    var_0 = "spectator";
  }

  if(isDefined(self.pers["team"]) && var_0 == self.pers["team"]) {
    self notify("selected_same_team");
  } else {
    self setclientomnvar("ui_loadout_selected", -1);
    self setclientomnvar("ui_session_state", "team_select");

    if(var_0 == "axis") {
      thread _id_873A("axis");
    } else if(var_0 == "allies") {
      thread _id_873A("allies");
    } else {
      if(var_0 == "random") {
        self thread[[level._id_1385]]();
        return;
      }

      if(var_0 == "spectator") {
        thread _id_8730();
      }
    }
  }
}

_id_8C08() {
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::_id_A70A("joined_team", "selected_same_team");

  if(maps\mp\_utility::_id_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::_id_8753(2);
  } else if(maps\mp\_utility::isprophuntgametype() || maps\mp\_utility::isdogfightgametype()) {
    thread maps\mp\gametypes\_playerlogic::_id_8753(-1);
  }
}

_id_1385() {
  if(maps\mp\_utility::_id_56B9()) {
    thread _id_873A("allies");
    self._id_0179 = "allies";
  } else if(!isDefined(self.team)) {
    if(self ismlgspectator() && !maps\mp\_utility::_id_551F()) {
      thread _id_8730();
    } else if(_getteammode() == "hub") {
      var_0 = _func_2EE();

      if(var_0 == "axis") {
        thread _id_873A("axis");
      } else {
        thread _id_873A("allies");
      }
    } else if(level.teamcount["axis"] < level.teamcount["allies"])
      thread _id_873A("axis");
    else if(level.teamcount["allies"] < level.teamcount["axis"]) {
      thread _id_873A("allies");
    } else if(_getteamscore("allies") > _getteamscore("axis")) {
      thread _id_873A("axis");
    } else {
      thread _id_873A("allies");
    }
  } else if(self ismlgspectator() && !maps\mp\_utility::_id_551F())
    thread _id_8730();
  else {
    if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis") {
      thread _id_873A("axis");
      return;
    }

    if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies") {
      thread _id_873A("allies");
      return;
    }

    if(level.teamcount["allies"] == level.teamcount["axis"]) {
      if(_getteamscore("allies") > _getteamscore("axis") && self.team != "axis") {
        thread _id_873A("axis");
      } else if(self.team != "allies") {
        thread _id_873A("allies");
      } else {
        self setclientomnvar("ui_session_state", self.sessionstate);
      }
    }
  }
}

_id_873A(var_0) {
  self endon("disconnect");

  if(!_isai(self) && level.teambased && !_id_0510::_id_452D(var_0)) {
    self setclientomnvar("ui_session_state", self.sessionstate);
    return;
  }

  if(level.ingraceperiod && !self._id_4B62) {
    self.hasspawned = 0;
  }

  if(self.sessionstate == "playing") {
    self._id_9566 = 1;
    self._id_596B = var_0;
    self._id_5C62 = self.pers["team"];
  }

  _id_09FC(var_0);

  if(self.sessionstate == "playing") {
    self suicide();
  }

  self.did_cancel_class_select = 0;
  _id_A69A();
  _id_36E3();

  if(self.sessionstate == "spectator") {
    if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(self._id_3A61)) {
      self._id_3A61 = undefined;
      return;
    }

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !maps\mp\_utility::_id_5727()) {
      if(isDefined(self._id_A6F1) && self._id_A6F1) {
        return;
      }
      maps\mp\gametypes\_playerlogic::_id_9035();
    }

    thread _id_050F::_id_872F();
  }
}

_id_8730() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self._id_9566 = 1;
    self._id_596B = "spectator";
    self._id_5C62 = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  _id_09FC("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread maps\mp\gametypes\_playerlogic::_id_90A5();
}

watch_for_cancel_class_select() {
  self notify("stop_watch_for_cancel_class_select");
  self endon("stop_watch_for_cancel_class_select");

  for(;;) {
    self waittillmatch("luinotifyserver", "class_select_cancel");

    if(self.sessionstate == "spectator") {
      maps\mp\_utility::_id_A165("spectator");
      level notify("class_select_cancel_spectator", self);
    }
  }
}

_id_A69A() {
  self endon("disconnect");
  level endon("game_ended");
  childthread watch_for_cancel_class_select();
  self._id_A6EF = 1;

  if(maps\mp\_utility::_id_0C1E()) {
    for(;;) {
      self waittill("luinotifyserver", var_0, var_1);

      if(var_0 == "class_select") {
        break;
      }
    }

    if("" + var_1 != "callback") {
      if(isbot(self) || istestclient(self)) {
        self.pers["class"] = var_1;
        self.class = var_1;
        maps\mp\gametypes\_class::_id_23DC();
      } else {
        var_1 = var_1 + 1;
        self.pers["class"] = getclasschoice(var_1);
        self.class = getclasschoice(var_1);
        maps\mp\gametypes\_class::_id_23DC();
      }

      self notify("notWaitingToSelectClass");
      self._id_A6EF = 0;
      return;
    }

    self notify("notWaitingToSelectClass");
    self._id_A6EF = 0;
    _id_6111("callback");
    return;
  } else {
    if(!_isai(self) && maps\mp\_utility::_id_8BFD()) {
      thread maps\mp\gametypes\_playerlogic::_id_8753(3);

      for(;;) {
        self waittill("luinotifyserver", var_0, var_1);

        if(var_0 == "class_select") {
          break;
        }
      }
    }

    self notify("notWaitingToSelectClass");
    self._id_A6EF = 0;
    _id_1DE9();
  }
}

_id_170E(var_0) {
  var_1 = self.pers["team"];

  if(maps\mp\_utility::_id_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::_id_8753(2);

    if(!self ismlgspectator() || maps\mp\_utility::_id_551F()) {
      _id_A69A();
    }

    _id_36E3();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::_id_5727()) {
        if(isDefined(self._id_A6F1) && self._id_A6F1) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::_id_9035();
      }

      thread _id_050F::_id_872F();
    }

    self._id_2589 = gettime();
  } else {
    thread _id_1DE9();

    if(maps\mp\_utility::isprophuntgametype() && self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::_id_5727()) {
        if(isDefined(self._id_A6F1) && self._id_A6F1) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::_id_9035();
      }

      thread _id_050F::_id_872F();
    }
  }
}

_id_1DE9() {
  maps\mp\gametypes\_class::_id_23DC();
  self.scragentrelinquishclaimednode = 1;
  self.class = "class0";

  if(isDefined(level._id_1DEA)) {
    self[[level._id_1DEA]]();
  }
}

_id_171C() {
  thread maps\mp\gametypes\_playerlogic::_id_8753(1);
}

_id_8C09() {
  var_0 = self.pers["team"];
  self openpopupmenu(game["menu_class_" + var_0]);
}

_id_6116() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self._id_9566 = 1;
    self._id_596B = "spectator";
    self._id_5C62 = self.pers["team"];
    self suicide();
  }

  _id_09FC("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  maps\mp\gametypes\_class::_id_23DC();
  thread maps\mp\gametypes\_playerlogic::_id_90A5();
}

_id_A919() {
  if(!self._id_4B62) {
    self endon("death");
    self endon("disconnect");
    self endon("streamClassWeaponsComplete");
    level endon("game_ended");
    self waittill("hasDoneCombat");
    self notify("endStreamClassWeapons");
    self iprintlnbold(game["strings"]["change_class_cancel"]);
    wait 2.0;
    self iprintlnbold(game["strings"]["change_class"]);
  }
}

_id_6112() {
  var_0 = maps\mp\_utility::_id_56B1();
  var_1 = level.ingraceperiod && !var_0 || var_0 && maps\mp\_utility::gettimepassed() < 5000 || common_scripts\utility::_id_562E(self._id_0C1F);

  if(self._id_4B62) {
    var_1 = 0;
  }

  if(var_1) {
    thread maps\mp\gametypes\_playerlogic::_id_9455(1);

    if(self._id_2327) {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");
      self endon("endStreamClassWeapons");
      thread _id_A919();
      self iprintlnbold(game["strings"]["change_class_wait"]);
      self waittill("streamClassWeaponsComplete");
      self iprintlnbold("");
      self onlystreamactiveweapon(0);
    }

    maps\mp\gametypes\_class::setclass(self.pers["class"]);
    self._id_95AE = undefined;
    self._id_95AF = undefined;
    maps\mp\gametypes\_class::_id_4790(self.pers["team"], self.pers["class"]);

    if(!isDefined(self._id_9085)) {
      self notify("faux_spawn");
      maps\mp\gametypes\_class::_id_0F35();

      if(common_scripts\utility::_id_562E(self._id_5DF6)) {
        _id_051E::_id_A129(1);
      }
    }
  } else {
    maps\mp\gametypes\_playerlogic::_id_9455();

    if(!maps\mp\_utility::_id_5727()) {
      self iprintlnbold(game["strings"]["change_class"]);
    }
  }
}

_id_6111(var_0) {
  var_1 = self.pers["team"];
  var_2 = maps\mp\gametypes\_class::getclasschoice(var_0);
  var_3 = maps\mp\gametypes\_class::getweaponchoice(var_0);

  if(var_2 == "restricted") {
    _id_170E();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == var_2 && (isDefined(self.pers["primary"]) && self.pers["primary"] == var_3)) {
    return;
  }
  if(maps\mp\_utility::isprophuntgametype() && game["roundsPlayed"] > 0) {
    return;
  }
  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    maps\mp\gametypes\_class::_id_23DC();
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    thread _id_6112();
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    maps\mp\gametypes\_class::_id_23DC();
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !maps\mp\_utility::_id_5727()) {
      thread maps\mp\gametypes\_playerlogic::_id_9035();
    }
  }

  thread _id_050F::_id_872F();
}

_id_09FC(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    maps\mp\gametypes\_playerlogic::_id_7CE1();

    if(isDefined(var_2) && var_2) {
      maps\mp\gametypes\_playerlogic::_id_2B77(self.team);
    }

    _id_04E7::_id_4AFB(self.team, var_0);
  }

  self.pers["team"] = var_0;
  self.team = var_0;

  if(!getdvarint("4036", 0) && (getdvarint("3193") || !maps\mp\_utility::matchmakinggame() || (isbot(self) || istestclient(self)) || !maps\mp\_utility::_id_0C2D() || getdvarint("850") || getdvarint("5357"))) {
    if(level.teambased) {
      self._id_0179 = var_0;
    } else if(var_0 == "spectator") {
      self._id_0179 = "spectator";
    } else {
      self._id_0179 = "none";
    }
  }

  if(_isdedicatedserver() && !_func_367() && level.teambased && !(isbot(self) || istestclient(self)) && self._id_0179 == "none") {
    var_3 = getmatchdata("match_common", "matchID");
    self _meth_8681("telemetry_error_event", ["error", ["category_id", 14, "message", "no team assigned", "code", 0, "stack_trace", "", "match_id", var_3]]);
  }

  if(game["state"] != "postgame") {
    maps\mp\gametypes\_playerlogic::_id_09FD();

    if(isDefined(var_2) && var_2) {
      maps\mp\gametypes\_playerlogic::_id_50F8(self.team, "_menus addToTeam()");
    }
  }

  if(!maps\mp\_utility::_id_579B()) {
    maps\mp\_utility::updateobjectivetext();
  }

  if(isDefined(var_1) && var_1) {
    waittillframeend;
  }

  maps\mp\_utility::updatemainmenu();

  if(var_0 == "spectator") {
    self notify("joined_spectators");
    level notify("joined_team", self);
  } else {
    self notify("joined_team");
    level notify("joined_team", self);
  }
}

_id_36E3() {
  self._id_A6F0 = 0;
  self notify("end_respawn");
}