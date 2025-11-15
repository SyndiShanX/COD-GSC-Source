/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_rat.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\rat_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\mp_common\laststand_warzone;

#namespace rat;

autoexec __init__system__() {
  system::register(#"wz_rat", &__init__, undefined, undefined);
}

__init__() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  level.rat.deathcount = 0;
  addratscriptcmd("<dev string:x38>", &function_70f41194);
  addratscriptcmd("<dev string:x54>", &function_31980089);
  addratscriptcmd("<dev string:x65>", &function_1251949b);
  addratscriptcmd("<dev string:x79>", &function_684893c8);
  addratscriptcmd("<dev string:x8b>", &function_7eabbc02);
  addratscriptcmd("<dev string:x98>", &function_d50abf44);
  addratscriptcmd("<dev string:xaa>", &function_89684f6a);
  setdvar(#"rat_death_count", 0);
}

function_d50abf44(params) {
  return level.players.size;
}

function_7eabbc02(params) {
  remaining = 0;
  host = [[level.rat.common.gethostplayer]]();
  hostteam = host.team;

  if(isDefined(params.remaining)) {
    remaining = int(params.remaining);
  }

  if(isDefined(level.players)) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players.size <= remaining) {
        break;
      }

      if(!isDefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "<dev string:xc0>") {
        continue;
      }

      bot::remove_bot(level.players[i]);
    }
  }
}

function_684893c8(params) {
  count = 0;

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      if(player laststand::player_is_in_laststand()) {
        count++;
      }
    }
  }

  return count;
}

function_1251949b(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player laststand::player_is_in_laststand();
}

function_70f41194(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.var_c212de25;
}

function_31980089(params) {
  player = [[level.rat.common.gethostplayer]]();
  numitems = 1000;
  distance = 1000;
  name = "<dev string:xc7>";

  if(isDefined(params.var_1d978d3)) {
    numitems = int(params.var_1d978d3);
  }

  if(isDefined(params.distance)) {
    distance = int(params.distance);
  }

  if(isDefined(params.name)) {
    name = params.name;
  }

  items = item_world::function_2e3efdda(player.origin, undefined, numitems, distance);

  foreach(item in items) {
    if(item.itementry.name == "<dev string:xca>") {
      continue;
    }

    if(isDefined(params.handler)) {
      if(params.handler != item.itementry.handler && params.handler != "<dev string:xe1>") {
        continue;
      }
    }

    if(name == "<dev string:xc7>" || item.itementry.name == name) {
      function_55e20e75(params._id, item.origin);
    }
  }
}

function_89684f6a(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.items[10].networkid != 32767;
}

