/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\platoons.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\infection;
#include scripts\core_common\platoons;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\teams\teams;

#namespace platoons;

autoexec __init__system__() {
  system::register(#"mp_platoons", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&on_start_gametype);
}

private on_start_gametype() {
  level callback::add_callback(#"hash_d8880c680eac47a", &function_a929f627);
}

update_status() {
  if(!function_382a49e0()) {
    return;
  }

  if(infection::function_74650d7()) {
    return;
  }

  params = {
    #var_1ab40902: [], 
    #var_42c20e77: []
  };

  foreach(var_b6173883, platoon in level.platoons) {
    if(platoon.var_9dd75dad == 0) {
      continue;
    }

    if(platoon.eliminated > 0) {
      continue;
    }

    platoon_teams = function_37d3bfcb(var_b6173883);
    var_87a87094 = [];

    foreach(team in platoon_teams) {
      if(teams::function_9dd75dad(team) && level.teameliminated[team] == 0) {
        if(!isDefined(var_87a87094)) {
          var_87a87094 = [];
        } else if(!isarray(var_87a87094)) {
          var_87a87094 = array(var_87a87094);
        }

        var_87a87094[var_87a87094.size] = team;
      }
    }

    if(var_87a87094.size == 0) {
      platoon.eliminated = gettime();

      if(!isDefined(params.var_42c20e77)) {
        params.var_42c20e77 = [];
      } else if(!isarray(params.var_42c20e77)) {
        params.var_42c20e77 = array(params.var_42c20e77);
      }

      params.var_42c20e77[params.var_42c20e77.size] = var_b6173883;
      continue;
    }

    if(!isDefined(params.var_1ab40902)) {
      params.var_1ab40902 = [];
    } else if(!isarray(params.var_1ab40902)) {
      params.var_1ab40902 = array(params.var_1ab40902);
    }

    params.var_1ab40902[params.var_1ab40902.size] = var_b6173883;
  }

  if(params.var_42c20e77.size > 0) {
    level callback::callback(#"hash_d8880c680eac47a", params);
  }
}

function_a929f627(params) {
  if(params.var_1ab40902.size == 0) {
    round::set_flag("tie");
    thread globallogic::end_round(6);
    return;
  }

  if(params.var_1ab40902.size == 1) {
    round::function_35702443(params.var_1ab40902[0]);
    thread globallogic::end_round(6);
  }
}

function_cea75f29() {
  count = 0;

  foreach(platoon, _ in level.platoons) {
    if(!is_all_dead(platoon)) {
      count++;
    }
  }

  return count;
}

count_players() {
  player_counts = [];

  foreach(platoon, _ in level.platoons) {
    player_counts[platoon] = 0;
  }

  var_6a39bbbd = self teams::count_players();

  foreach(team, _ in var_6a39bbbd) {
    platoon = getteamplatoon(team);

    if(!isDefined(level.platoons[platoon])) {
      continue;
    }

    player_counts[platoon] += var_6a39bbbd[team];
  }

  return player_counts;
}

private function_ef7959f0() {
  playercounts = self count_players();
  count = 9999;
  var_c15f9be2 = undefined;

  foreach(platoon, _ in level.platoons) {
    if(count > playercounts[platoon]) {
      count = playercounts[platoon];
      var_c15f9be2 = platoon;
    }
  }

  return var_c15f9be2;
}

function_77ad4730() {
  assignment = function_ef7959f0();

  var_655b66e0 = getdvarstring(#"scr_playerplatoons", "<dev string:x38>");
  playerplatoons = strtok(var_655b66e0, "<dev string:x3b>");

  if(playerplatoons.size > 0) {
    playerplatoon = playerplatoons[self getentitynumber()];

    if(isDefined(playerplatoon) && isDefined(level.platoons[playerplatoon])) {
      assignment = hash(playerplatoon);
    }
  }

    return assignment;
}

function_4b016b57() {
  if(!function_382a49e0() || level.platoon.assignment != 1) {
    return;
  }

  team = self.pers[#"team"];
  platoon = getteamplatoon(team);

  if(platoon != #"invalid" && platoon != #"none") {
    return;
  }

  assignment = function_77ad4730();
  function_334c4bec(team, assignment);
}

function_a214d798(platoon) {
  players = [];

  if(platoon == #"none" || platoon == #"invalid") {
    return players;
  }

  teams = function_37d3bfcb(platoon);

  foreach(team in teams) {
    foreach(player in level.aliveplayers[team]) {
      if(!isDefined(players)) {
        players = [];
      } else if(!isarray(players)) {
        players = array(players);
      }

      players[players.size] = player;
    }
  }

  return players;
}

is_all_dead(platoon) {
  teams = function_37d3bfcb(platoon);

  foreach(team in teams) {
    if(!teams::is_all_dead(team)) {
      return false;
    }
  }

  return true;
}