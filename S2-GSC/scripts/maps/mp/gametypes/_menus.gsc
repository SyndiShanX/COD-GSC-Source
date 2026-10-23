/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_menus.gsc
************************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level.multiteambased) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        var_1 = "menu_class_" + level.teamnamelist[var_0];
        var_2 = "menu_changeclass_" + level.teamnamelist[var_0];
        game[var_1] = game["menu_class_allies"];
        game[var_2] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";

    if(level.console) {
      game["menu_controls"] = "ingame_controls";

      if(level.splitscreen) {
        if(level.multiteambased) {
          for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
            var_1 = "menu_class_" + level.teamnamelist[var_0];
            var_2 = "menu_changeclass_" + level.teamnamelist[var_0];
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
    if(maps\mp\_utility::practiceroundgame()) {
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
  if(maps\mp\_utility::_id_56B3() && self ismlgspectator() && !maps\mp\_utility::invirtuallobby()) {
    self setclientomnvar("ui_options_menu", 0);
  } else {
    if(!istestclient(self) && !_isai(self)) {
      if("" + var_0 != "callback") {
        self setclientomnvar("ui_loadout_selected", var_0);
      }
    }

    if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
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
        maps\mp\gametypes\_class::clearcopycatloadout();
        return;
      }

      var_1 = var_0 + 1;
      var_1 = getclasschoice(var_1);

      if(!isDefined(self.pers["class"]) || var_1 == self.pers["class"]) {
        return;
      }
      self.pers["class"] = var_1;
      self.class = var_1;
      maps\mp\gametypes\_class::clearcopycatloadout();
      thread menugiveclass();
      return;
      return;
    }

    menuclass("callback");
  }
}

_id_4AD2() {
  level thread maps\mp\gametypes\_gamelogic::forceend();
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
    thread showloadoutmenu();
  }

  if(var_0 == 3) {
    self setclientomnvar("ui_options_menu", 0);
    self setclientomnvar("ui_spectator_selected", 1);
    self setclientomnvar("ui_loadout_selected", -1);
    self.spectating_actively = 1;

    if(maps\mp\_utility::_id_56B3()) {
      self setmlgspectator(1);
      thread _id_050F::setspectatepermissions();
    }
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.spectating_actively = 0;

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
      thread setteam("axis");
    } else if(var_0 == "allies") {
      thread setteam("allies");
    } else {
      if(var_0 == "random") {
        self thread[[level.autoassign]]();
        return;
      }

      if(var_0 == "spectator") {
        thread setspectator();
      }
    }
  }
}

showloadoutmenu() {
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::waittill_any("joined_team", "selected_same_team");

  if(maps\mp\_utility::_id_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(2);
  } else if(maps\mp\_utility::isprophuntgametype() || maps\mp\_utility::isdogfightgametype()) {
    thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
  }
}

autoassign() {
  if(maps\mp\_utility::iscoop()) {
    thread setteam("allies");
    self._id_0179 = "allies";
  } else if(!isDefined(self.team)) {
    if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby()) {
      thread setspectator();
    } else if(_getteammode() == "hub") {
      var_0 = _func_2EE();

      if(var_0 == "axis") {
        thread setteam("axis");
      } else {
        thread setteam("allies");
      }
    } else if(level.teamcount["axis"] < level.teamcount["allies"])
      thread setteam("axis");
    else if(level.teamcount["allies"] < level.teamcount["axis"]) {
      thread setteam("allies");
    } else if(_getteamscore("allies") > _getteamscore("axis")) {
      thread setteam("axis");
    } else {
      thread setteam("allies");
    }
  } else if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
    thread setspectator();
  else {
    if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis") {
      thread setteam("axis");
      return;
    }

    if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies") {
      thread setteam("allies");
      return;
    }

    if(level.teamcount["allies"] == level.teamcount["axis"]) {
      if(_getteamscore("allies") > _getteamscore("axis") && self.team != "axis") {
        thread setteam("axis");
      } else if(self.team != "allies") {
        thread setteam("allies");
      } else {
        self setclientomnvar("ui_session_state", self.sessionstate);
      }
    }
  }
}

setteam(var_0) {
  self endon("disconnect");

  if(!_isai(self) && level.teambased && !_id_0510::getjointeampermissions(var_0)) {
    self setclientomnvar("ui_session_state", self.sessionstate);
    return;
  }

  if(level.ingraceperiod && !self.hasdonecombat) {
    self.hasspawned = 0;
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = var_0;
    self.leaving_team = self.pers["team"];
  }

  _id_09FC(var_0);

  if(self.sessionstate == "playing") {
    self suicide();
  }

  self.did_cancel_class_select = 0;
  waitforclassselect();
  endrespawnnotify();

  if(self.sessionstate == "spectator") {
    if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(self._id_3A61)) {
      self._id_3A61 = undefined;
      return;
    }

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
      if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }
      maps\mp\gametypes\_playerlogic::spawnclient();
    }

    thread _id_050F::setspectatepermissions();
  }
}

setspectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  _id_09FC("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

watch_for_cancel_class_select() {
  self notify("stop_watch_for_cancel_class_select");
  self endon("stop_watch_for_cancel_class_select");

  for(;;) {
    self waittillmatch("luinotifyserver", "class_select_cancel");

    if(self.sessionstate == "spectator") {
      maps\mp\_utility::updatesessionstate("spectator");
      level notify("class_select_cancel_spectator", self);
    }
  }
}

waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  childthread watch_for_cancel_class_select();
  self.waitingtoselectclass = 1;

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
        maps\mp\gametypes\_class::clearcopycatloadout();
      } else {
        var_1 = var_1 + 1;
        self.pers["class"] = getclasschoice(var_1);
        self.class = getclasschoice(var_1);
        maps\mp\gametypes\_class::clearcopycatloadout();
      }

      self notify("notWaitingToSelectClass");
      self.waitingtoselectclass = 0;
      return;
    }

    self notify("notWaitingToSelectClass");
    self.waitingtoselectclass = 0;
    menuclass("callback");
    return;
  } else {
    if(!_isai(self) && maps\mp\_utility::showgenericmenuonmatchstart()) {
      thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(3);

      for(;;) {
        self waittill("luinotifyserver", var_0, var_1);

        if(var_0 == "class_select") {
          break;
        }
      }
    }

    self notify("notWaitingToSelectClass");
    self.waitingtoselectclass = 0;
    bypassclasschoice();
  }
}

beginclasschoice(var_0) {
  var_1 = self.pers["team"];

  if(maps\mp\_utility::_id_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(2);

    if(!self ismlgspectator() || maps\mp\_utility::invirtuallobby()) {
      waitforclassselect();
    }

    endrespawnnotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::spawnclient();
      }

      thread _id_050F::setspectatepermissions();
    }

    self.connecttime = gettime();
  } else {
    thread bypassclasschoice();

    if(maps\mp\_utility::isprophuntgametype() && self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::spawnclient();
      }

      thread _id_050F::setspectatepermissions();
    }
  }
}

bypassclasschoice() {
  maps\mp\gametypes\_class::clearcopycatloadout();
  self.scragentrelinquishclaimednode = 1;
  self.class = "class0";

  if(isDefined(level._id_1DEA)) {
    self[[level._id_1DEA]]();
  }
}

beginteamchoice() {
  thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(1);
}

showmainmenuforteam() {
  var_0 = self.pers["team"];
  self openpopupmenu(game["menu_class_" + var_0]);
}

menuspectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  _id_09FC("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  maps\mp\gametypes\_class::clearcopycatloadout();
  thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

watchhasdonecombat() {
  if(!self.hasdonecombat) {
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

menugiveclass() {
  var_0 = maps\mp\_utility::_id_56B1();
  var_1 = level.ingraceperiod && !var_0 || var_0 && maps\mp\_utility::gettimepassed() < 5000 || common_scripts\utility::_id_562E(self._id_0C1F);

  if(self.hasdonecombat) {
    var_1 = 0;
  }

  if(var_1) {
    thread maps\mp\gametypes\_playerlogic::streamclass(1);

    if(self.classweaponswait) {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");
      self endon("endStreamClassWeapons");
      thread watchhasdonecombat();
      self iprintlnbold(game["strings"]["change_class_wait"]);
      self waittill("streamClassWeaponsComplete");
      self iprintlnbold("");
      self onlystreamactiveweapon(0);
    }

    maps\mp\gametypes\_class::setclass(self.pers["class"]);
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    maps\mp\gametypes\_class::giveloadout(self.pers["team"], self.pers["class"]);

    if(!isDefined(self.spawnplayergivingloadout)) {
      self notify("faux_spawn");
      maps\mp\gametypes\_class::_id_0F35();

      if(common_scripts\utility::_id_562E(self.loadoutkeepcurrentkillstreaks)) {
        _id_051E::updatekillstreaks(1);
      }
    }
  } else {
    maps\mp\gametypes\_playerlogic::streamclass();

    if(!maps\mp\_utility::isinkillcam()) {
      self iprintlnbold(game["strings"]["change_class"]);
    }
  }
}

menuclass(var_0) {
  var_1 = self.pers["team"];
  var_2 = maps\mp\gametypes\_class::getclasschoice(var_0);
  var_3 = maps\mp\gametypes\_class::getweaponchoice(var_0);

  if(var_2 == "restricted") {
    beginclasschoice();
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
    maps\mp\gametypes\_class::clearcopycatloadout();
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    thread menugiveclass();
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    maps\mp\gametypes\_class::clearcopycatloadout();
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
      thread maps\mp\gametypes\_playerlogic::spawnclient();
    }
  }

  thread _id_050F::setspectatepermissions();
}

_id_09FC(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    maps\mp\gametypes\_playerlogic::removefromteamcount();

    if(isDefined(var_2) && var_2) {
      maps\mp\gametypes\_playerlogic::decrementalivecount(self.team);
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
    self setfireloopmod("telemetry_error_event", ["error", ["category_id", 14, "message", "no team assigned", "code", 0, "stack_trace", "", "match_id", var_3]]);
  }

  if(game["state"] != "postgame") {
    maps\mp\gametypes\_playerlogic::_id_09FD();

    if(isDefined(var_2) && var_2) {
      maps\mp\gametypes\_playerlogic::incrementalivecount(self.team, "_menus addToTeam()");
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

endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}