/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\match.gsc
***********************************************/

#using script_3d703ef87a841fe4;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#namespace match;

function private autoexec __init__system__() {
  system::register(#"match", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_94003d29();
}

function private function_37f04b09() {
  if(!isDefined(game.outcome)) {
    game.outcome = outcome::function_a1a81955();
    game.outcome.var_3c5fdf73 = [];
  }
}

function private function_94003d29() {
  function_37f04b09();
  round::function_37f04b09();

  if(overtime::is_overtime_round()) {
    set_overtime();
  }
}

function function_f37f02fc() {
  return game.outcome;
}

function private function_b6b94df8() {
  if(overtime::is_overtime_round()) {
    set_overtime();
  }
}

function set_overtime() {
  round::set_flag("overtime");
  set_flag("overtime");
}

function set_flag(flag) {
  outcome::set_flag(game.outcome, flag);
}

function get_flag(flag) {
  return outcome::get_flag(game.outcome, flag);
}

function clear_flag(flag) {
  return outcome::clear_flag(game.outcome, flag);
}

function function_897438f4(var_c1e98979) {
  outcome::function_897438f4(game.outcome, var_c1e98979);
}

function function_3624d032() {
  return outcome::function_3624d032(game.outcome);
}

function function_c10174e7() {
  if(isDefined(game.outcome.team) && isDefined(level.teams[game.outcome.team])) {
    return true;
  }

  if(game.outcome.players.size) {
    return true;
  }

  return false;
}

function get_winning_team() {
  return outcome::get_winning_team(game.outcome);
}

function is_winning_team(team) {
  if(isDefined(game.outcome.team) && team == game.outcome.team) {
    return true;
  }

  return false;
}

function function_a2b53e17(player) {
  if(game.outcome.team !== # "none" && player.pers[# "team"] === game.outcome.team) {
    return true;
  }

  if(game.outcome.players.size) {
    if(player == game.outcome.players[0]) {
      return true;
    }
  }

  return false;
}

function function_75f97ac7() {
  if(game.outcome.players.size) {
    return true;
  }

  return false;
}

function function_517c0ce0() {
  if(game.outcome.players.size) {
    return game.outcome.players[0] ishost();
  }

  return 0;
}

function function_b5f4c9d8() {
  return outcome::function_b5f4c9d8(game.outcome);
}

function get_winner() {
  if(is_true(level.teambased)) {
    return outcome::get_winning_team(game.outcome);
  }

  return outcome::function_b5f4c9d8(game.outcome);
}

function set_winner(team_or_player) {
  outcome::set_winner(game.outcome, team_or_player);
}

function function_af2e264f(winner) {
  outcome::function_af2e264f(game.outcome, winner);
}

function function_870759fb() {
  winner = function_6d0354e3();
  outcome::function_af2e264f(game.outcome, winner);
}

function function_6d0354e3() {
  winner = round::get_winner();

  if(game.outcome.var_aefc8b8d.var_c1e98979 != 7 && game.outcome.var_aefc8b8d.var_c1e98979 != 11) {
    if(level.teambased && get_flag("overtime")) {
      if(!is_true(level.doubleovertime) || round::get_flag("tie")) {
        winner = teams::function_d85770f0("overtimeroundswon");
      }
    } else if(level.scoreroundwinbased) {
      winner = teams::function_d85770f0("roundswon");
    } else {
      winner = teams::function_ef80de99();
    }
  }

  return winner;
}

function function_10cd0ad() {
  totalkills = [];
  totaldeaths = [];
  teamkeys = getarraykeys(level.teams);

  foreach(team in teamkeys) {
    totalkills[team] = 0;
    totaldeaths[team] = 0;

    foreach(player in getplayers(team)) {
      totalkills[team] += player.pers[# "kills"];
      totaldeaths[team] += player.pers[# "deaths"];
    }
  }

  highestkillcount = undefined;
  lowestdeathcount = undefined;
  var_578c6319 = [];

  foreach(team in teamkeys) {
    killcount = totalkills[team];

    if(!isDefined(highestkillcount) || killcount > highestkillcount) {
      highestkillcount = killcount;
    }
  }

  foreach(team in teamkeys) {
    if(totalkills[team] == highestkillcount) {
      var_578c6319[var_578c6319.size] = team;
    }
  }

  if(var_578c6319.size == 1) {
    return var_578c6319[0];
  }

  if(var_578c6319.size > 0) {
    foreach(team in var_578c6319) {
      deathcount = totaldeaths[team];

      if(!isDefined(lowestdeathcount) || deathcount < lowestdeathcount) {
        lowestdeathcount = deathcount;
      }
    }

    foreach(i, team in var_578c6319) {
      if(totaldeaths[team] != lowestdeathcount) {
        var_578c6319[i] = # "hash_14ed42bb8a61e1e2";
      }
    }

    arrayremovevalue(var_578c6319, #"hash_14ed42bb8a61e1e2");

    if(var_578c6319.size > 0) {
      winnerindex = randomint(var_578c6319.size);
      return var_578c6319[winnerindex];
    }
  }

  winnerindex = randomint(teamkeys.size);
  return teamkeys[winnerindex];
}