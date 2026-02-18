/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\teams\teams.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\mp_common\teams\teams;
#using scripts\wz_common\hud;
#namespace teams;

function private function_74a8f2ed(var_d3ba512b, var_c0856555) {
  if(var_d3ba512b.score > var_c0856555.score) {
    return 1;
  }

  if(var_c0856555.score > var_d3ba512b.score) {
    return 0;
  }

  return function_39971b81(var_d3ba512b, var_c0856555);
}

function function_f1394038() {
  var_17616452 = [];

  foreach(team, _ in level.teams) {
    if(function_9dd75dad(team) && !is_true(level.var_606becce[team]) && !isDefined(level.var_eed7c027[team])) {
      players = getplayers(team);
      team_score = [[level._getteamscore]](team);
      team_kills = function_7e309c84(team, players);
      damage_done = function_3915e148(team, players);

      if(!isDefined(var_17616452)) {
        var_17616452 = [];
      } else if(!isarray(var_17616452)) {
        var_17616452 = array(var_17616452);
      }

      var_17616452[var_17616452.size] = {
        #team: team, #players: players, #last_alive: undefined, #kills: team_kills, #damage: damage_done, #score: team_score
      };
    }
  }

  var_ec950e92 = array::merge_sort(var_17616452, &function_74a8f2ed);
  placement = 1;

  foreach(team in var_ec950e92) {
    level.var_eed7c027[team.team] = placement;
    placement++;
  }
}

function function_94203702(team, players) {
  var_b7771cfa = 0;
  last_player = undefined;

  foreach(player in players) {
    if(is_true(player.teamkilled)) {
      continue;
    }

    if(player.deathtime > var_b7771cfa) {
      var_b7771cfa = player.deathtime;
      last_player = player;
    }
  }

  return last_player;
}

function function_7e309c84(team, players) {
  team_kills = 0;

  foreach(player in players) {
    team_kills += player.kills;
  }

  return team_kills;
}

function function_3915e148(team, players) {
  damage_done = 0;

  foreach(player in players) {
    damage_done += player.damagedone;
  }

  return damage_done;
}

function function_39971b81(var_d3ba512b, var_c0856555) {
  if(isDefined(var_d3ba512b.last_alive) && !isDefined(var_c0856555.last_alive)) {
    return true;
  }

  if(isDefined(var_c0856555.last_alive) && !isDefined(var_d3ba512b.last_alive)) {
    return false;
  }

  if(isDefined(var_d3ba512b.last_alive) && var_d3ba512b.last_alive.deathtime > var_c0856555.last_alive.deathtime) {
    return true;
  }

  if(isDefined(var_d3ba512b.last_alive) && var_c0856555.last_alive.deathtime > var_d3ba512b.last_alive.deathtime) {
    return false;
  }

  if(var_d3ba512b.kills > var_c0856555.kills) {
    return true;
  }

  if(var_c0856555.kills > var_d3ba512b.kills) {
    return false;
  }

  if(var_d3ba512b.damage > var_c0856555.damage) {
    return true;
  }

  if(var_c0856555.damage > var_d3ba512b.damage) {
    return false;
  }

  return true;
}

function function_c7eae573() {
  var_d72df62 = [];

  foreach(team, _ in level.teams) {
    if(function_9dd75dad(team) && !is_true(level.var_606becce[team]) && is_all_dead(team)) {
      players = getplayers(team);
      last_alive = function_94203702(team, players);
      team_kills = function_7e309c84(team, players);
      damage_done = function_3915e148(team, players);
      var_d72df62[var_d72df62.size] = {
        #team: team, #players: players, #last_alive: last_alive, #kills: team_kills, #damage: damage_done
      };
    }
  }

  var_ec950e92 = array::merge_sort(var_d72df62, &function_39971b81);
  return var_ec950e92;
}

function function_c2f2fb84(var_d72df62) {
  if(var_d72df62.size == 0) {
    return undefined;
  }

  if(var_d72df62.size == 1) {
    return var_d72df62[0].team;
  }

  return var_d72df62[0].team;
}

function function_5fed3908(team) {
  if(!isDefined(team)) {
    return;
  }

  callback::callback(#"hash_677c43609aa6ce47", team);
  players = getplayers(team);

  foreach(player in players) {
    if(player function_8b1a219a()) {
      player clientfield::set_to_player("RGB_keyboard_manager", 1);
    }
  }
}

function team_eliminated(team, var_293493b) {
  level.var_606becce[team] = 1;
  callback::callback(#"hash_1019ab4b81d07b35", {
    #team: team, #var_293493b: var_293493b
  });
  level hud::function_22df4165();
  level thread function_9498e451(team);
  deadteam = getplayers(team);

  foreach(teammember in deadteam) {
    teammember notify(#"end_respawn");
    teammember luinotifyevent(#"team_eliminated", 1, var_293493b);
  }

  level.var_eed7c027[team] = var_293493b;
}

function function_9498e451(team) {
  wait 1;

  while(is_true(level.var_fec861a7)) {
    waitframe(1);
  }
}