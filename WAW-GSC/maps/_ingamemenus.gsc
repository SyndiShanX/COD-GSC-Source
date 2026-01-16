/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ingamemenus.gsc
*****************************************************/

init() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _ingamemenus.gsc. Function: init()\n");
  level.xenon = (getdvar("xenonGame") == "true");
  level.consoleGame = (getdvar("consoleGame") == "true");
  precacheMenu("loadout_splitscreen");
  level thread onPlayerConnect();
  if(getdebugdvar("replay_debug") == "1")
    println("File: _ingamemenus.gsc. Function: init() - COMPLETE\n");
}

onPlayerConnect() {
  for (;;) {
    level waittill("connecting", player);
    player thread onMenuResponse();
  }
}

onMenuResponse() {
  for (;;) {
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