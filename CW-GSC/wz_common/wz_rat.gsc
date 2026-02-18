/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\wz_rat.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;
#namespace rat;

function private autoexec __init__system__() {
  system::register(#"wz_rat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  level.rat.deathcount = 0;
  addratscriptcmd("<dev string:x38>", &function_70f41194);
  addratscriptcmd("<dev string:x55>", &function_31980089);
  addratscriptcmd("<dev string:x67>", &function_1251949b);
  addratscriptcmd("<dev string:x7c>", &function_684893c8);
  addratscriptcmd("<dev string:x8f>", &function_7eabbc02);
  addratscriptcmd("<dev string:x9d>", &function_d50abf44);
  addratscriptcmd("<dev string:xb0>", &function_89684f6a);
  addratscriptcmd("<dev string:xc7>", &function_4bf92a0d);
  setDvar(#"rat_death_count", 0);
}

function function_d50abf44(params) {
  return level.players.size;
}

function function_7eabbc02(params) {
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

      if(!isDefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "<dev string:xd5>") {
        continue;
      }

      bot::remove_bot(level.players[i]);
    }
  }
}

function function_684893c8(params) {
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

function function_1251949b(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player laststand::player_is_in_laststand();
}

function function_70f41194(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.var_c212de25;
}

function function_31980089(params) {
  player = [[level.rat.common.gethostplayer]]();
  numitems = 1000;
  distance = 1000;
  name = "<dev string:xdd>";

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
    if(item.itementry.name == "<dev string:xe1>") {
      continue;
    }

    if(isDefined(params.handler)) {
      if(params.handler != item.itementry.handler && params.handler != "<dev string:xf9>") {
        continue;
      }
    }

    if(name == "<dev string:xdd>" || item.itementry.name == name) {
      function_55e20e75(params._id, item.origin);
    }
  }
}

function function_89684f6a(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.items[5].networkid != 32767;
}

function function_4bf92a0d(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player isonground();
}