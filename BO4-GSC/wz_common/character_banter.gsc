/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_banter.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;

#namespace character_banter;

autoexec __init__system__() {
  system::register(#"character_banter", &__init__, undefined, undefined);
}

__init__() {
  callback::on_joined_team(&on_joined_team);
  callback::on_disconnect(&on_player_disconnect);
  level.var_8dcd4dc8 = [];
}

on_joined_team(params) {
  if(!isDefined(level.var_8dcd4dc8)) {
    return;
  }

  players = level.var_8dcd4dc8[self.team];

  if(!isarray(players)) {
    if(!isDefined(players)) {
      level.var_8dcd4dc8[self.team] = array(self);
    }

    return;
  }

  arrayinsert(players, self, randomint(players.size + 1));
}

on_player_disconnect() {
  if(!isDefined(level.var_8dcd4dc8)) {
    return;
  }

  players = level.var_8dcd4dc8[self.team];

  if(getplayers(self.team).size <= 1) {
    level.var_8dcd4dc8[self.team] = [];
    return;
  }

  if(isarray(players)) {
    arrayremovevalue(players, self);
  }
}

start() {
  if(level.maxteamplayers < 2) {
    return;
  }

  level endon(#"stop_banter");
  globallogic::waitforplayers();
  lookup = function_bb3ec038();
  var_8dcd4dc8 = [];

  while(true) {
    foreach(team, players in level.var_8dcd4dc8) {
      if(isarray(players) && players.size > 1) {
        foreach(player in players) {
          if(isDefined(player) && player function_4d9b2d83(players, lookup)) {
            level.var_8dcd4dc8[team] = 1;
            break;
          }
        }

        waitframe(1);
      }
    }

    waitframe(1);
  }
}

function_bb3ec038() {
  lookup = [];
  rowcount = tablelookuprowcount(#"hash_5ec1825aeab754a2");

  for(i = 0; i < rowcount; i++) {
    row = tablelookuprow(#"hash_5ec1825aeab754a2", i);
    player1 = row[0];
    player2 = row[1];

    if(!isDefined(lookup[player1])) {
      lookup[player1] = [];
    }

    banters = lookup[player1];

    if(!isDefined(banters[player2])) {
      banters[player2] = 0;
    }

    banters[player2]++;
  }

  return lookup;
}

function_4d9b2d83(players, lookup) {
  if(!self isonground()) {
    return false;
  }

  assetname = self getmpdialogname();

  if(!isDefined(assetname)) {
    return false;
  }

  banters = lookup[assetname];

  if(!isDefined(banters) || banters.size <= 0) {
    return false;
  }

  foreach(player in players) {
    if(!isDefined(player) || player == self || !player isonground() || distancesquared(self.origin, player.origin) > 1000000) {
      continue;
    }

    var_d8c635a4 = player getmpdialogname();

    if(!isDefined(var_d8c635a4)) {
      continue;
    }

    var_a9f3e2d4 = banters[player getmpdialogname()];

    if(isDefined(var_a9f3e2d4)) {
      self playsoundevent(1, undefined, player);
      return true;
    }
  }

  return false;
}

stop() {
  if(level.prematchperiod > 10) {
    wait level.prematchperiod - 10;
  }

  level notify(#"stop_banter");
  level.var_8dcd4dc8 = undefined;
}