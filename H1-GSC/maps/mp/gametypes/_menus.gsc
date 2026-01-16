/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_menus.gsc
****************************************/

init() {
  if(!isdefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level.multiteambased)
      game["menu_team"] = "team_mt_options";

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level.multiteambased) {
      for (var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
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
          for (var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
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

  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread watchforclasschange();
    var_0 thread watchforopenteamselectmenu();
    var_0 thread watchforteamchange();
    var_0 thread watchforleavegame();
    var_0 thread connectedmenus();
    var_0 maps\mp\gametypes\_class::cac_setlastenvironment(getmapcustom("environment"));
  }
}

connectedmenus() {}

getclasschoice(var_0) {
  if(var_0 <= 100)
    var_0 = "custom" + var_0;
  else if(var_0 <= 200) {
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

watchforclasschange() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "class_select") {
      continue;
    }
    if(maps\mp\_utility::ismlgsplitscreen() && self ismlgspectator() && !maps\mp\_utility::invirtuallobby()) {
      self setclientomnvar("ui_options_menu", 0);
      continue;
    }

    if(!istestclient(self) && !isai(self)) {
      if("" + var_1 != "callback")
        self setclientomnvar("ui_loadout_selected", var_1);
    }

    if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
      continue;
    }
    if(!maps\mp\_utility::allowclasschoice()) {
      continue;
    }
    self setclientomnvar("ui_options_menu", 0);

    if("" + var_1 != "callback") {
      if(isbot(self) || istestclient(self)) {
        self.pers["class"] = var_1;
        self.class = var_1;
        maps\mp\gametypes\_class::clearcopycatloadout();
      } else {
        var_2 = var_1 + 1;
        var_2 = getclasschoice(var_2);

        if(!isdefined(self.pers["class"]) || var_2 == self.pers["class"]) {
          continue;
        }
        self.pers["class"] = var_2;
        self.class = var_2;
        maps\mp\gametypes\_class::clearcopycatloadout();
        maps\mp\gametypes\_class::cac_setlastclassindex(var_1 + 1);
        maps\mp\gametypes\_class::cac_setlastgrouplocation(getdvarint("xblive_privatematch"));
        thread menugiveclass(0);
      }

      continue;
    }

    menuclass("callback");
  }
}

watchforleavegame() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "end_game") {
      continue;
    }
    level thread maps\mp\gametypes\_gamelogic::forceend();
  }
}

teamchangeisfactionchange() {
  return self.sessionstate == "playing" && level.gametype == "dm";
}

watchforopenteamselectmenu() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("luinotifyserver", var_0);

    if(var_0 != "open_team_select_menu") {
      continue;
    }
    var_1 = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "spectatetype");

    if(var_1 > 0)
      maps\mp\_utility::streamnextspectatorweaponsifnecessary(0);
  }
}

watchforteamchange() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "team_select") {
      continue;
    }
    if(maps\mp\_utility::matchmakinggame() && !getdvarint("force_ranking") && !self _meth_8586()) {
      continue;
    }
    if(var_1 != 3 && !teamchangeisfactionchange() && maps\mp\_utility::allowclasschoice())
      thread showloadoutmenu();

    if(var_1 == 3) {
      self setclientomnvar("ui_options_menu", 0);
      self setclientomnvar("ui_spectator_selected", 1);
      self setclientomnvar("ui_loadout_selected", -1);
      self.spectating_actively = 1;

      if(maps\mp\_utility::ismlgsplitscreen()) {
        self setmlgspectator(1);
        self setclientomnvar("ui_use_mlg_hud", 1);
        thread maps\mp\gametypes\_spectating::setspectatepermissions();
      }

      if(teamchangeisfactionchange() && isdefined(self.addtoteam))
        self.addtoteam = undefined;
    } else {
      self setclientomnvar("ui_spectator_selected", -1);
      self.spectating_actively = 0;

      if(maps\mp\_utility::ismlgsplitscreen()) {
        self setmlgspectator(0);
        self setclientomnvar("ui_use_mlg_hud", 0);
      }

      if(teamchangeisfactionchange() || !maps\mp\_utility::allowclasschoice())
        thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
    }

    if(var_1 == 0)
      var_1 = "axis";
    else if(var_1 == 1)
      var_1 = "allies";
    else if(var_1 == 2)
      var_1 = "random";
    else
      var_1 = "spectator";

    if(isdefined(self.pers["team"]) && var_1 == self.pers["team"]) {
      if(teamchangeisfactionchange() && isdefined(self.addtoteam))
        self.addtoteam = undefined;

      self notify("selected_same_team");
      continue;
    }

    if(getdvarint("scr_lua_splashes"))
      self luinotifyevent(&"clear_notification_queue", 0);

    self setclientomnvar("ui_loadout_selected", -1);

    if(var_1 == "axis") {
      thread setteam("axis");
      continue;
    }

    if(var_1 == "allies") {
      thread setteam("allies");
      continue;
    }

    if(var_1 == "random") {
      self thread[[level.autoassign]]();
      continue;
    }

    if(var_1 == "spectator")
      thread setspectator();
  }
}

showloadoutmenu() {
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::waittill_any("joined_team", "selected_same_team");

  if(maps\mp\_utility::ishodgepodgeph() && !maps\mp\_utility::allowclasschoice()) {
    return;
  }
  self setclientomnvar("ui_options_menu", 2);
}

autoassign() {
  if(maps\mp\_utility::iscoop()) {
    thread setteam("allies");
    self.sessionteam = "allies";
  } else if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
    thread setspectator();
  else {
    var_0 = isdefined(self.team) && self.team == "axis";
    var_1 = isdefined(self.team) && self.team == "allies";

    if(level.teamcount["axis"] < level.teamcount["allies"] && !var_0) {
      thread setteam("axis");
      return;
    }

    if(level.teamcount["allies"] < level.teamcount["axis"] && !var_1) {
      thread setteam("allies");
      return;
    }

    if(level.teamcount["allies"] == level.teamcount["axis"]) {
      if(!var_0 && !var_1) {
        var_2 = getteamscore("allies");
        var_3 = getteamscore("axis");

        if(var_2 > var_3 && !var_0)
          thread setteam("axis");
        else if(var_3 > var_2 && !var_1)
          thread setteam("allies");
        else
          thread setteam(common_scripts\utility::random(["allies", "axis"]));
      }
    }
  }
}

setteam(var_0) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !maps\mp\gametypes\_teams::getjointeampermissions(var_0)) {
    return;
  }
  var_1 = level.ingraceperiod && !self.hasdonecombat;

  if(teamchangeisfactionchange()) {
    if(var_1) {
      addtoteam(var_0, 0, 1);
      maps\mp\gametypes\_class::cac_setlastteam(var_0);
    } else
      self.addtoteam = var_0;

    thread menugiveclass(1);
  } else {
    if(var_1)
      self.hasspawned = 0;

    if(self.sessionstate == "playing") {
      self.switching_teams = 1;
      self.joining_team = var_0;
      self.leaving_team = self.pers["team"];
    }

    addtoteam(var_0);
    maps\mp\gametypes\_class::cac_setlastteam(var_0);

    if(self.sessionstate == "playing")
      self suicide();

    waitforclassselect();
    endrespawnnotify();
  }

  if(self.sessionstate == "spectator") {
    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
      if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }
      maps\mp\gametypes\_playerlogic::spawnclient();
    }

    thread maps\mp\gametypes\_spectating::setspectatepermissions();
  }
}

setspectator() {
  if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  self.waitingtoselectclass = 1;

  if(maps\mp\_utility::allowclasschoice()) {
    for (;;) {
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
        maps\mp\gametypes\_class::cac_setlastclassindex(var_1);
        maps\mp\gametypes\_class::cac_setlastgrouplocation(getdvarint("xblive_privatematch"));
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
    if(!isai(self) && maps\mp\_utility::showgenericmenuonmatchstart() && (self getclientomnvar("ui_options_menu") == 0 || maps\mp\_utility::ishodgepodgeph())) {
      thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(3);

      for (;;) {
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

  if(maps\mp\_utility::allowclasschoice()) {
    thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(2);

    if(!self ismlgspectator() || maps\mp\_utility::invirtuallobby())
      waitforclassselect();

    endrespawnnotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
        if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::spawnclient();
      }

      thread maps\mp\gametypes\_spectating::setspectatepermissions();
    }

    self.connecttime = gettime();
  } else {
    thread bypassclasschoice();

    if(self.sessionstate == "spectator" && maps\mp\_utility::ishodgepodgeph()) {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam()) {
        if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread maps\mp\gametypes\_playerlogic::spawnclient();
      }

      thread maps\mp\gametypes\_spectating::setspectatepermissions();
    }
  }
}

bypassclasschoice() {
  maps\mp\gametypes\_class::clearcopycatloadout();
  self.selectedclass = 1;
  self.class = "class0";

  if(isdefined(level.bypassclasschoicefunc))
    self[[level.bypassclasschoicefunc]]();
}

beginteamchoice() {
  thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(1);
}

showmainmenuforteam() {
  var_0 = self.pers["team"];
  self openpopupmenu(game["menu_class_" + var_0]);
}

menuspectator() {
  if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  maps\mp\gametypes\_class::clearcopycatloadout();
  thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

watchhasdonecombat(var_0) {
  if(!self.hasdonecombat) {
    self endon("death");
    self endon("disconnect");
    self endon("streamClassComplete");
    level endon("game_ended");
    self waittill("hasDoneCombat");
    self notify("endStreamClass");

    if(var_0)
      self iprintlnbold(game["strings"]["change_team_cancel"]);
    else
      self iprintlnbold(game["strings"]["change_class_cancel"]);

    wait 2.0;

    if(var_0)
      self iprintlnbold(game["strings"]["change_team"]);
    else
      self iprintlnbold(game["strings"]["change_class"]);
  }
}

menugiveclass(var_0) {
  if(level.ingraceperiod && !self.hasdonecombat) {
    thread maps\mp\gametypes\_playerlogic::streamclass(1);

    if(self.classweaponswait) {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");
      self endon("endStreamClass");
      thread watchhasdonecombat(var_0);

      if(var_0)
        self iprintlnbold(game["strings"]["change_team_wait"]);
      else
        self iprintlnbold(game["strings"]["change_class_wait"]);

      self waittill("streamClassComplete");
      self iprintlnbold("");
      self onlystreamactiveweapon(0);
    }

    maps\mp\gametypes\_class::setclass(self.pers["class"]);
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    maps\mp\gametypes\_class::giveloadout(self.pers["team"], self.pers["class"]);

    if(!isdefined(self.spawnplayergivingloadout)) {
      maps\mp\gametypes\_class::applyloadout();
      maps\mp\gametypes\_hardpoints::giveownedhardpointitem();
    }

    if(maps\mp\_utility::_hasperk("specialty_moreminimap"))
      setomnvar("ui_minimap_extend_grace_period", 1);
    else
      setomnvar("ui_minimap_extend_grace_period", 0);

    self setclientomnvar("ui_class_changed_grace_period", 1);
  } else {
    maps\mp\gametypes\_playerlogic::streamclass();

    if(var_0)
      self iprintlnbold(game["strings"]["change_team"]);
    else
      self iprintlnbold(game["strings"]["change_class"]);
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

  if(isdefined(self.pers["class"]) && self.pers["class"] == var_2 && (isdefined(self.pers["primary"]) && self.pers["primary"] == var_3)) {
    return;
  }
  if(maps\mp\_utility::ishodgepodgeph() && game["roundsPlayed"] > 0) {
    return;
  }
  if(self.sessionstate == "playing") {
    if(isdefined(self.pers["lastClass"]) && isdefined(self.pers["class"])) {
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
    thread menugiveclass(0);
  } else {
    if(isdefined(self.pers["lastClass"]) && isdefined(self.pers["class"])) {
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
    if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam())
      thread maps\mp\gametypes\_playerlogic::spawnclient();
  }

  thread maps\mp\gametypes\_spectating::setspectatepermissions();
}

getuiteamindex(var_0) {
  if(var_0 == "allies")
    return 2;
  else if(var_0 == "axis")
    return 1;
}

addtoteam(var_0, var_1, var_2) {
  if(isdefined(self.team)) {
    maps\mp\gametypes\_playerlogic::removefromteamcount();

    if(isdefined(var_2) && var_2)
      maps\mp\gametypes\_playerlogic::decrementalivecount(self.team);
  }

  self.pers["team"] = var_0;
  self.team = var_0;

  if(var_0 == "allies") {
    self.lastgameteamchosen = "allies";
    self setclientomnvar("ui_team_selected", getuiteamindex("allies"));
  } else if(var_0 == "axis") {
    self.lastgameteamchosen = "axis";
    self setclientomnvar("ui_team_selected", getuiteamindex("axis"));
  }

  if(!getdvarint("party_playersCoop", 0) && (!maps\mp\_utility::matchmakinggame() || (isbot(self) || istestclient(self)) || !maps\mp\_utility::allowteamchoice() || getdvarint("force_ranking"))) {
    if(level.teambased)
      self.sessionteam = var_0;
    else if(var_0 == "spectator")
      self.sessionteam = "spectator";
    else
      self.sessionteam = "none";
  }

  if(game["state"] != "postgame") {
    maps\mp\gametypes\_playerlogic::addtoteamcount();

    if(isdefined(var_2) && var_2)
      maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
  }

  maps\mp\_utility::updateobjectivetext();

  if(isdefined(var_1) && var_1)
    waittillframeend;

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