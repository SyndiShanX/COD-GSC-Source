/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_menus.gsc
*****************************************************/

init() {
  game["menu_team"] = "team_marinesopfor";
  game["menu_class_allies"] = "class_marines";
  game["menu_changeclass_allies"] = "changeclass_marines";
  game["menu_initteam_allies"] = "initteam_marines";
  game["menu_class_axis"] = "class_opfor";
  game["menu_changeclass_axis"] = "changeclass_opfor";
  game["menu_initteam_axis"] = "initteam_opfor";
  game["menu_class"] = "class";
  game["menu_changeclass"] = "changeclass";
  game["menu_changeclass_offline"] = "changeclass_offline";
  if(!level.console) {
    game["menu_callvote"] = "callvote";
    game["menu_muteplayer"] = "muteplayer";
    precacheMenu(game["menu_callvote"]);
    precacheMenu(game["menu_muteplayer"]);
    game["menu_eog_main"] = "endofgame";
    game["menu_eog_unlock"] = "popup_unlock";
    game["menu_eog_summary"] = "popup_summary";
    game["menu_eog_unlock_page1"] = "popup_unlock_page1";
    game["menu_eog_unlock_page2"] = "popup_unlock_page2";
    precacheMenu(game["menu_eog_main"]);
    precacheMenu(game["menu_eog_unlock"]);
    precacheMenu(game["menu_eog_summary"]);
    precacheMenu(game["menu_eog_unlock_page1"]);
    precacheMenu(game["menu_eog_unlock_page2"]);
  } else {
    game["menu_controls"] = "ingame_controls";
    game["menu_options"] = "ingame_options";
    game["menu_leavegame"] = "popup_leavegame";
    if(level.splitscreen) {
      game["menu_team"] += "_splitscreen";
      game["menu_class_allies"] += "_splitscreen";
      game["menu_changeclass_allies"] += "_splitscreen";
      game["menu_class_axis"] += "_splitscreen";
      game["menu_changeclass_axis"] += "_splitscreen";
      game["menu_class"] += "_splitscreen";
      game["menu_changeclass"] += "_splitscreen";
      game["menu_controls"] += "_splitscreen";
      game["menu_options"] += "_splitscreen";
      game["menu_leavegame"] += "_splitscreen";
    }
    precacheMenu(game["menu_controls"]);
    precacheMenu(game["menu_options"]);
    precacheMenu(game["menu_leavegame"]);
  }
  precacheMenu("scoreboard");
  precacheMenu(game["menu_team"]);
  precacheMenu(game["menu_class_allies"]);
  precacheMenu(game["menu_changeclass_allies"]);
  precacheMenu(game["menu_initteam_allies"]);
  precacheMenu(game["menu_class_axis"]);
  precacheMenu(game["menu_changeclass_axis"]);
  precacheMenu(game["menu_class"]);
  precacheMenu(game["menu_changeclass"]);
  precacheMenu(game["menu_initteam_axis"]);
  precacheMenu(game["menu_changeclass_offline"]);
  precacheString(&"MP_HOST_ENDED_GAME");
  precacheString(&"MP_HOST_ENDGAME_RESPONSE");
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player setClientDvar("ui_3dwaypointtext", "1");
    player.enable3DWaypoints = true;
    player setClientDvar("ui_deathicontext", "1");
    player.enableDeathIcons = true;
    player thread onMenuResponse();
  }
}

onMenuResponse() {
  self endon("disconnect");
  for(;;) {
    self waittill("menuresponse", menu, response);
    if(response == "back") {
      self closeMenu();
      self closeInGameMenu();
      if(level.console) {
        if(menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_team"] || menu == game["menu_controls"]) {
          if(self.pers["team"] == "allies")
            self openMenu(game["menu_class_allies"]);
          if(self.pers["team"] == "axis")
            self openMenu(game["menu_class_axis"]);
        } else if(menu == "class") {
          self[[level.showsquadinfo]]();
        }
      }
      continue;
    }
    if(response == "showsquadinfo") {
      self[[level.showsquadinfo]]();
    }
    if(response == "leavesquad") {
      self closeMenu();
      self[[level.leavesquad]]();
    }
    if(response == "joinsquad") {
      self[[level.joinsquad]]();
    }
    if(response == "createsquad") {
      self[[level.createsquad]]();
    }
    if(response == "locksquad") {
      self closeMenu();
      self[[level.locksquad]]();
    }
    if(response == "unlocksquad") {
      self closeMenu();
      self[[level.unlocksquad]]();
    }
    if(response == "changeteam") {
      self closeMenu();
      self closeInGameMenu();
      self openMenu(game["menu_team"]);
    }
    if(response == "changeclass_marines") {
      self closeMenu();
      self closeInGameMenu();
      self openMenu(game["menu_changeclass_allies"]);
      continue;
    }
    if(response == "changeclass_opfor") {
      self closeMenu();
      self closeInGameMenu();
      self openMenu(game["menu_changeclass_axis"]);
      continue;
    }
    if(response == "changeclass_marines_splitscreen")
      self openMenu("changeclass_marines_splitscreen");
    if(response == "changeclass_opfor_splitscreen")
      self openMenu("changeclass_opfor_splitscreen");
    if(response == "xpTextToggle") {
      self.enableText = !self.enableText;
      if(self.enableText)
        self setClientDvar("ui_xpText", "1");
      else
        self setClientDvar("ui_xpText", "0");
      continue;
    }
    if(response == "waypointToggle") {
      self.enable3DWaypoints = !self.enable3DWaypoints;
      if(self.enable3DWaypoints)
        self setClientDvar("ui_3dwaypointtext", "1");
      else
        self setClientDvar("ui_3dwaypointtext", "0");
      continue;
    }
    if(response == "deathIconToggle") {
      self.enableDeathIcons = !self.enableDeathIcons;
      if(self.enableDeathIcons)
        self setClientDvar("ui_deathicontext", "1");
      else
        self setClientDvar("ui_deathicontext", "0");
      self maps\mp\gametypes\_deathicons::updateDeathIconsEnabled();
      continue;
    }
    if(response == "endgame") {
      if(level.splitscreen) {
        if(level.console)
          endparty();
        level.skipVote = true;
        if(!level.gameEnded) {
          level thread maps\mp\gametypes\_globallogic::forceEnd();
        }
      }
      continue;
    }
    if(response == "endround" && level.console) {
      if(!level.gameEnded) {
        level thread maps\mp\gametypes\_globallogic::forceEnd();
      } else {
        self closeMenu();
        self closeInGameMenu();
        self iprintln(&"MP_HOST_ENDGAME_RESPONSE");
      }
      continue;
    }
    if(menu == game["menu_team"]) {
      switch (response) {
        case "allies":
          self[[level.leavesquad]]();
          self[[level.allies]]();
          break;
        case "axis":
          self[[level.leavesquad]]();
          self[[level.axis]]();
          break;
        case "autoassign":
          self[[level.leavesquad]]();
          self[[level.autoassign]]();
          break;
        case "spectator":
          self[[level.leavesquad]]();
          self[[level.spectator]]();
          break;
      }
    } else if(menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"]) {
      self closeMenu();
      self closeInGameMenu();
      self.selectedClass = true;
      self[[level.class]](response);
    } else if(!level.console) {
      if(menu == game["menu_quickcommands"])
        maps\mp\gametypes\_quickmessages::quickcommands(response);
      else if(menu == game["menu_quickstatements"])
        maps\mp\gametypes\_quickmessages::quickstatements(response);
      else if(menu == game["menu_quickresponses"])
        maps\mp\gametypes\_quickmessages::quickresponses(response);
    }
  }
}