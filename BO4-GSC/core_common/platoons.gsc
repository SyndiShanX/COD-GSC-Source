/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\platoons.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace platoons;

autoexec __init__system__() {
  system::register(#"platoons", &__init__, undefined, undefined);
}

__init__() {
  level.platoon = {
    #count: isDefined(getgametypesetting(#"platooncount")) ? getgametypesetting(#"platooncount") : 0, 
    #assignment: isDefined(getgametypesetting(#"platoonassignment")) ? getgametypesetting(#"platoonassignment") : 0, 
    #max_players: 0
  };
  level.platoon.max_players = function_bb1ab64b();

  if(level.platoon.count) {
    level.platoon.max_players /= level.platoon.count;
  }

  callback::on_start_gametype(&on_start_gametype);
}

function_382a49e0() {
  return level.platoon.count > 0;
}

function_bb1ab64b() {
  return getdvarint(#"com_maxclients", 0);
}

private on_start_gametype() {
  level.platoons = [];

  for(var_aada11e0 = 1; var_aada11e0 <= level.platoon.count; var_aada11e0++) {
    platoon_name = "platoon_" + var_aada11e0;
    level.platoons[hash("platoon_" + var_aada11e0)] = {
      #name: platoon_name, 
      #eliminated: 0, 
      #var_9dd75dad: 0, 
      #player_count: 0
    };
  }
}

function_334c4bec(team, platoon) {
  function_909b6ab(platoon, team);
}

function_596bfb16() {
  if(game.state != "playing") {
    return;
  }

  foreach(team, _ in level.teams) {
    if(game.everexisted[team]) {
      platoon = getteamplatoon(team);

      if(platoon != #"none" && platoon != #"invalid" && level.platoons[platoon].var_9dd75dad == 0) {
        level.platoons[platoon].var_9dd75dad = gettime();
      }
    }
  }
}