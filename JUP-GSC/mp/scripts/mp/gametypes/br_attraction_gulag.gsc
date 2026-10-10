/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_attraction_gulag.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_attractions;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace br_attraction_gulag;

function init() {
  level.brattractions["gulag"] = spawnStruct();
  level.brattractions["gulag"].locations = [];
  registerlocations();
}

function registerlocations() {
  switch (level.script) {
    case #"hash_c9458e4403b73c27":
    case #"hash_d7b993f67c508b1d":
    case #"hash_e9af1c05b2cb1afd":
      registerlocation((51075, -39283, 1123), 400);
      registerlocation((-7677, 13727, -231), 400);
      registerlocation((1543, -29029, 89), 400);
      break;
    case #"hash_4aa5d6e97851bdbd":
      registerlocation((0, 0, 0), 400);
    default:
      break;
  }
}

function registerlocation(origin, var_ccb00530d7a24ee3) {
  var_f98843815888ea41 = 50;
  var_9b6c8be6b3c1724f = 40;
  nextindex = level.brattractions["gulag"].locations.size;
  level.brattractions["gulag"].locations[nextindex] = spawnStruct();
  location = level.brattractions["gulag"].locations[nextindex];
  location.icontrigger = scripts\mp\gametypes\br_attractions::createattractionicontrigger("gulag", 0, origin, var_f98843815888ea41, "ui_mp_br_mapmenu_icon_poi_sb_gulag", var_ccb00530d7a24ee3, undefined, undefined, "br_attraction_gulag");
  location.icontrigger scripts\mp\gametypes\br_attractions::triggeraddobjectivetext(&"MP_BR_INGAME/ATTRACT_GULAG_AREA");
  location.prompt = spawn("script_model", origin + (0, 0, var_9b6c8be6b3c1724f));
  location.prompt setModel("tag_origin");
  location.prompt thread triggerpromptthink();
}

function triggerpromptthink(location) {
  self makeusable();
  self setHintString(&"MP_BR_INGAME/ATTRACT_GULAG_PROMPT");
  self setusepriority(-1);

  while(true) {
    self waittill("trigger", player);
    player thread scripts\mp\gametypes\br_gulag::initplayerjail();
  }
}