/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\match.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\overtime;
#include scripts\mp_common\gametypes\round;

#namespace match;

autoexec __init__system__() {
  system::register(#"match", &__init__, undefined, undefined);
}

__init__() {
  function_94003d29();
}

private function_37f04b09() {
  if(!isDefined(game.outcome)) {
    game.outcome = outcome::function_a1a81955();
    game.outcome.var_3c5fdf73 = [];
  }
}

private function_94003d29() {
  function_37f04b09();
  round::function_37f04b09();

  if(overtime::is_overtime_round()) {
    set_overtime();
  }
}

function_f37f02fc() {
  return game.outcome;
}

private function_b6b94df8() {
  if(overtime::is_overtime_round()) {
    set_overtime();
  }
}

set_overtime() {
  round::set_flag("overtime");
  set_flag("overtime");
}

set_flag(flag) {
  outcome::set_flag(game.outcome, flag);
}

get_flag(flag) {
  return outcome::get_flag(game.outcome, flag);
}

clear_flag(flag) {
  return outcome::clear_flag(game.outcome, flag);
}

function_897438f4(var_c1e98979) {
  outcome::function_897438f4(game.outcome, var_c1e98979);
}

function_3624d032() {
  return outcome::function_3624d032(game.outcome);
}

function_c10174e7() {
  if(isDefined(game.outcome.team) && isDefined(level.teams[game.outcome.team])) {
    return true;
  }

  if(game.outcome.players.size) {
    return true;
  }

  return false;
}

get_winning_team() {
  return outcome::get_winning_team(game.outcome);
}

is_winning_team(team) {
  if(isDefined(game.outcome.team) && team == game.outcome.team) {
    return true;
  }

  return false;
}

function_a2b53e17(player) {
  if(game.outcome.platoon !== #"none" && getteamplatoon(player.pers[#"team"]) === game.outcome.platoon) {
    return true;
  }

  if(game.outcome.team !== #"free" && player.pers[#"team"] === game.outcome.team) {
    return true;
  }

  if(game.outcome.players.size) {
    if(player == game.outcome.players[0]) {
      return true;
    }
  }

  return false;
}

function_75f97ac7() {
  if(game.outcome.players.size) {
    return true;
  }

  return false;
}

function_517c0ce0() {
  if(game.outcome.players.size) {
    return game.outcome.players[0] ishost();
  }

  return 0;
}

function_b5f4c9d8() {
  return outcome::function_b5f4c9d8(game.outcome);
}

get_winner() {
  if(isDefined(level.teambased) && level.teambased) {
    return outcome::get_winning_team(game.outcome);
  }

  return outcome::function_b5f4c9d8(game.outcome);
}

set_winner(team_or_player) {
  outcome::set_winner(game.outcome, team_or_player);
}

function_af2e264f(winner) {
  outcome::function_af2e264f(game.outcome, winner);
}

function_870759fb() {
  winner = function_6d0354e3();
  outcome::function_af2e264f(game.outcome, winner);
}

function_35702443(platoon) {
  outcome::function_35702443(game.outcome, platoon);
}

function_d30d1a2e() {
  return outcome::function_d30d1a2e(game.outcome);
}

function_6d0354e3() {
  winner = round::get_winner();

  if(game.outcome.var_aefc8b8d.var_c1e98979 != 7) {
    if(level.teambased && get_flag("overtime")) {
      if(!(isDefined(level.doubleovertime) && level.doubleovertime) || round::get_flag("tie")) {
        winner = globallogic::determineteamwinnerbygamestat("overtimeroundswon");
      }
    } else if(level.scoreroundwinbased) {
      winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
      winner = globallogic::determineteamwinnerbyteamscore();
    }
  }

  return winner;
}