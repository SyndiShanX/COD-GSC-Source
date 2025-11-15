/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ingamemenus.gsc
**************************************/

#include maps\_utility;

init() {
  level.xenon = (getDvar(#"xenonGame") == "true");
  level.consoleGame = (getDvar(#"consoleGame") == "true");
  precacheMenu("loadout_splitscreen");
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onMenuResponse();
  }
}

onMenuResponse() {
  for(;;) {
    self waittill("menuresponse", menu, response);
    if(menu == "loadout_splitscreen") {
      self closeMenu();
      self closeInGameMenu();
      self[[level.loadout]](response);
      continue;
    }
    if(response == "endround") {
      if(!level.gameEnded) {
        level thread maps\_cooplogic::forceEnd();
      } else {
        self closeMenu();
        self closeInGameMenu();
      }
      continue;
    }
  }
}