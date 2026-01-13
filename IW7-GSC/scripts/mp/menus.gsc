/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\menus.gsc
********************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";
    if(level.multiteambased) {
      game["menu_team"] = "team_mt_options";
    }

    if(scripts\mp\utility::bot_is_fireteam_mode()) {
      level.fireteam_menu = "class_commander_" + level.gametype;
      game["menu_class"] = level.fireteam_menu;
      game["menu_class_allies"] = level.fireteam_menu;
      game["menu_class_axis"] = level.fireteam_menu;
    } else {
      game["menu_class"] = "class";
      game["menu_class_allies"] = "class_marines";
      game["menu_class_axis"] = "class_opfor";
    }

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

  level thread onplayerconnect();
  level thread watchforbootmoviecomplete();
  level thread setintrocamnetworkmodel();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread watchforclasschange();
    var_0 thread watchforteamchange();
    var_0 thread watchforleavegame();
    var_0 thread func_13A67();
  }
}

setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("prematch_over");
  setintrocameraactive(0);
}

watchforbootmoviecomplete() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 0;
  for(;;) {
    level waittill("rigBootFinished");
    var_0++;
    if(level.connectingPlayers <= var_0) {
      level notify("allRigsBooted");
      break;
    }
  }
}

getclasschoice(var_0) {
  var_1 = undefined;
  if(var_0 > 100) {
    var_2 = var_0 - 100;
    var_1 = "default" + var_2;
  } else {
    var_1 = "custom" + var_0;
  }

  return var_1;
}

preloadandqueueclass(var_0) {
  var_1 = spawnStruct();
  scripts\mp\playerlogic::getplayerassets(var_1, var_0);
  scripts\mp\playerlogic::loadplayerassets(var_1);
}

watchforclasschange() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 != "class_select") {
      continue;
    }

    if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch") && self ismlgspectator()) {
      self setclientomnvar("ui_options_menu", 0);
      continue;
    }

    var_2 = isai(self) || issubstr(self.name, "tcBot");
    if(!var_2) {
      if(!isai(self) && "" + var_1 != "callback") {
        self setclientomnvar("ui_loadout_selected", var_1);
      }
    }

    if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
      continue;
    }

    if(!scripts\mp\utility::allowclasschoice() || scripts\mp\utility::showfakeloadout()) {
      continue;
    }

    if("" + var_1 != "callback") {
      if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
        self.pers["class"] = var_1;
        self.class = var_1;
      } else {
        var_3 = var_1 + 1;
        var_3 = getclasschoice(var_3);
        if(!isDefined(self.pers["class"]) || var_3 == self.pers["class"]) {
          continue;
        }

        self.pers["class"] = var_3;
        self.class = var_3;
        preloadandqueueclass(var_3);
        if(scripts\mp\class::shouldallowinstantclassswap()) {
          scripts\mp\class::giveloadoutswap();
        } else if(isalive(self)) {
          self iprintlnbold(game["strings"]["change_class"]);
        }
      }

      continue;
    }

    menuclass("callback");
  }
}

watchforleavegame() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 != "end_game") {
      continue;
    }

    level thread scripts\mp\gamelogic::forceend(var_1);
  }
}

watchforteamchange() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 != "team_select") {
      continue;
    }

    if(scripts\mp\utility::matchmakinggame()) {
      continue;
    }

    var_2 = 0;
    if(var_1 >= 3) {
      var_2 = 1;
    }

    if(var_2) {
      self setclientomnvar("ui_spectator_selected", 1);
      self setclientomnvar("ui_loadout_selected", -1);
      self.spectating_actively = 1;
    } else {
      self setclientomnvar("ui_spectator_selected", -1);
      self.spectating_actively = 0;
    }

    var_3 = self ismlgspectator();
    var_4 = !var_3 && isDefined(self.team) && self.team == "spectator";
    var_5 = (var_3 && var_1 == 3) || var_4 && var_1 == 4;
    if(var_1 == 4) {
      var_1 = 3;
      self setmlgspectator(1);
    } else {
      self setmlgspectator(0);
    }

    self setclientomnvar("ui_team_selected", var_1);
    if(var_1 == 0) {
      var_1 = "axis";
    } else if(var_1 == 1) {
      var_1 = "allies";
    } else if(var_1 == 2) {
      var_1 = "random";
    } else {
      var_1 = "spectator";
    }

    if(!var_5 && isDefined(self.pers["team"]) && var_1 == self.pers["team"]) {
      continue;
    }

    self setclientomnvar("ui_loadout_selected", -1);
    thread logteamselection(var_1);
    if(var_1 == "axis") {
      thread setteam("axis");
      continue;
    }

    if(var_1 == "allies") {
      thread setteam("allies");
      continue;
    }

    if(var_1 == "random") {
      thread autoassign();
      continue;
    }

    if(var_1 == "spectator") {
      thread setspectator(var_5);
    }
  }
}

autoassign() {
  if(level.gametype == "infect") {
    thread setteam("allies");
    return;
  }

  if(isbotmatchmakingenabled() && isDefined(self.bot_team)) {
    thread setteam(self.bot_team);
    return;
  }

  if(!isDefined(self.team)) {
    if(self ismlgspectator()) {
      thread setspectator();
    } else if(level.teamcount["axis"] < level.teamcount["allies"]) {
      thread setteam("axis");
    } else if(level.teamcount["allies"] < level.teamcount["axis"]) {
      thread setteam("allies");
    } else if(getteamscore("allies") > getteamscore("axis")) {
      thread setteam("axis");
    } else {
      thread setteam("allies");
    }

    return;
  }

  if(self ismlgspectator()) {
    thread setspectator();
    return;
  }

  if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis") {
    thread setteam("axis");
    return;
  }

  if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies") {
    thread setteam("allies");
    return;
  }

  if(level.teamcount["allies"] == level.teamcount["axis"]) {
    if(getteamscore("allies") > getteamscore("axis") && self.team != "axis") {
      thread setteam("axis");
      return;
    }

    if(self.team != "allies") {
      thread setteam("allies");
      return;
    }

    return;
  }
}

setteam(var_0) {
  self endon("disconnect");
  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(var_0) && !scripts\mp\utility::lobbyteamselectenabled()) {
    return;
  }

  if(level.ingraceperiod && !self.hasdonecombat) {
    self.hasspawned = 0;
    self.pers["lives"] = ::scripts\mp\utility::getgametypenumlives();
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = var_0;
    self.leaving_team = self.pers["team"];
  }

  addtoteam(var_0);
  if(scripts\mp\utility::isragdollzerog()) {
    self lockdeathcamera(1);
  }

  if(self.sessionstate == "playing") {
    self suicide();
  }

  waitforclassselect();
  endrespawnnotify();
  if(self.sessionstate == "spectator") {
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !scripts\mp\utility::isinkillcam()) {
      if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }

      thread scripts\mp\playerlogic::spawnclient();
    }

    thread scripts\mp\spectating::setspectatepermissions();
  }

  self notify("okToSpawn");
}

setspectator(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
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
  thread scripts\mp\playerlogic::spawnspectator();
}

waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  self.waitingtoselectclass = 1;
  for(;;) {
    if(scripts\mp\utility::allowclasschoice() || scripts\mp\utility::showfakeloadout() && !isai(self)) {
      if(!self ismlgspectator()) {
        scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["must_select_loadout_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);
      }

      self waittill("luinotifyserver", var_0, var_1);
    } else {
      bypassclasschoice();
      break;
    }

    if(var_0 != "class_select") {
      continue;
    }

    if(self.team == "spectator") {
      continue;
    }

    if("" + var_1 != "callback") {
      if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
        self.pers["class"] = var_1;
        self.class = var_1;
      } else {
        var_1 = var_1 + 1;
        self.pers["class"] = getclasschoice(var_1);
        self.class = getclasschoice(var_1);
      }

      self.waitingtoselectclass = 0;
    } else {
      self.waitingtoselectclass = 0;
      menuclass("callback");
    }

    break;
  }
}

beginclasschoice(var_0) {
  var_1 = self.pers["team"];
  if(scripts\mp\utility::allowclasschoice() || scripts\mp\utility::showfakeloadout() && !isai(self)) {
    self setclientomnvar("ui_options_menu", 2);
    if(!self ismlgspectator()) {
      waitforclassselect();
    }

    endrespawnnotify();
    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }

      if(game["state"] == "playing" && !scripts\mp\utility::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }

        thread scripts\mp\playerlogic::spawnclient();
      }

      thread scripts\mp\spectating::setspectatepermissions();
    }

    self.connecttime = gettime();
    self notify("okToSpawn");
  } else {
    thread bypassclasschoice();
  }

  if(!isalive(self)) {
    thread scripts\mp\playerlogic::predictabouttospawnplayerovertime(0.1);
  }
}

bypassclasschoice() {
  self.selectedclass = 1;
  self.waitingtoselectclass = 0;
  if(!isbot(self) && scripts\mp\utility::rankingenabled()) {
    if(level.gametype == "infect" || isDefined(level.aonrules) && level.aonrules > 0) {
      scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);
      self notifyonplayercommand("pressToSpawn", "+usereload");
      self notifyonplayercommand("pressToSpawn", "+activate");
      self waittill("pressToSpawn");
    }
  }

  if(isDefined(level.bypassclasschoicefunc)) {
    var_0 = self[[level.bypassclasschoicefunc]]();
    self.class = var_0;
    return;
  }

  self.class = "class0";
}

beginteamchoice() {
  self setclientomnvar("ui_options_menu", 1);
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

  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

menuclass(var_0) {
  var_1 = self.pers["team"];
  var_2 = scripts\mp\class::getclasschoice(var_0);
  var_3 = scripts\mp\class::getweaponchoice(var_0);
  if(var_2 == "restricted") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == var_2 && isDefined(self.pers["primary"]) && self.pers["primary"] == var_3) {
    return;
  }

  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;
    if(game["state"] == "postgame") {
      return;
    }

    if(level.ingraceperiod && !self.hasdonecombat) {
      scripts\mp\class::setclass(self.pers["class"]);
      self.weaponispreferreddrop = undefined;
      self.tag_stowed_hip = undefined;
      scripts\mp\class::giveloadout(self.pers["team"], self.pers["class"]);
    } else {
      self iprintlnbold(game["strings"]["change_class"]);
    }
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !scripts\mp\utility::isinkillcam()) {
      thread scripts\mp\playerlogic::spawnclient();
    }
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

addtoteam(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();
    if(isDefined(var_2) && var_2) {
      scripts\mp\playerlogic::decrementalivecount(self.team);
    }
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator") {
    self.pers["last_team"] = self.pers["team"];
  }

  self.pers["team"] = var_0;
  self.team = var_0;
  if((!scripts\mp\utility::matchmakinggame() || isDefined(self.pers["isBot"]) || !scripts\mp\utility::allowteamassignment()) && !isgamebattlematch()) {
    if(level.teambased) {
      self.sessionteam = var_0;
    } else if(var_0 == "spectator") {
      self.sessionteam = "spectator";
    } else {
      self.sessionteam = "none";
    }
  }

  if(game["state"] != "postgame") {
    scripts\mp\playerlogic::addtoteamcount();
    if(isDefined(var_2) && var_2) {
      scripts\mp\playerlogic::incrementalivecount(self.team);
    }
  }

  if(isgamebattlematch()) {
    setmatchdata("players", self.clientid, "team", var_0);
  }

  scripts\mp\utility::updateobjectivetext();
  if(isDefined(var_1) && var_1) {
    waittillframeend;
  }

  scripts\mp\utility::updatemainmenu();
  if(var_0 == "spectator") {
    self notify("joined_spectators");
    level notify("joined_team", self);
    return;
  }

  self notify("joined_team");
  level notify("joined_team", self);
}

endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}

logteamselection(var_0) {
  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }

  if(var_0 != "random") {
    iprintlnbold("" + self.name + " did not select auto-assign");
  }
}

func_13A67() {
  thread func_13A69();
  thread func_13A6A();
  thread func_13A6B();
}

func_13A69() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "rig_selected") {
      self.var_E535 = spawnStruct();
      self.var_E535.setprintchannel = var_1;
    }
  }
}

func_13A6A() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "super_selected") {
      if(isDefined(self.var_E535)) {
        self.var_E535.var_11261 = var_1;
        continue;
      }
    }
  }
}

func_13A6B() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "trait_selected") {
      if(isDefined(self.var_E535)) {
        self.var_E535.var_11B2D = var_1;
        if(isDefined(self.var_E535.setprintchannel) && isDefined(self.var_E535.var_11261)) {
          var_2 = level.archetypes[self.var_E535.setprintchannel];
          var_3 = level.var_11264[self.var_E535.var_11261];
          var_4 = level.var_CA5E[self.var_E535.var_11B2D];
          scripts\mp\class::changearchetype(var_2, var_3, var_4);
        }

        continue;
      }
    }
  }
}