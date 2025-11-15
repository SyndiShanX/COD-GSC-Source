/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ingamemenus.gsc
**************************************/

#include maps\_utility;
#include maps\_cooplogic;

init() {
  level.xenon = getdvar(#"xenonGame") == "true";
  level.consolegame = getdvar(#"_id_D1AF4972") == "true";
  precachemenu("loadout_splitscreen");
  precachemenu("ObjectiveInfoMenu");
  precachemenu("InGamePopupMenu");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onmenuresponse();
  }
}

onmenuresponse() {
  for(;;) {
    self waittill("menuresponse", menu, response);

    if(menu == "loadout_splitscreen") {
      self closemenu();
      self closeingamemenu();
      self[[level.loadout]](response);
      continue;
    }

    if(response == "endround") {
      if(!level.gameended)
        level thread maps\_cooplogic::forceend();
      else {
        self closemenu();
        self closeingamemenu();
      }

      continue;
    }

    if(response == "close_all_ingame_menus")
      self closeingamemenu();
  }
}