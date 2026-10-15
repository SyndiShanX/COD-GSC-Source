/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\round.gsc
***********************************************/

#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\overtime;

#namespace round;

function_37f04b09() {
  outcome = outcome::function_a1a81955();
  game.outcome.var_3c5fdf73[game.outcome.var_3c5fdf73.size] = outcome;
  game.outcome.var_aefc8b8d = outcome;
}

function_f37f02fc() {
  return game.outcome.var_aefc8b8d;
}

round_stats_init() {
  if(!isDefined(game.roundsplayed)) {
    game.roundsplayed = 0;
  }

  setroundsplayed(game.roundsplayed + overtime::get_rounds_played());
  overtime::round_stats_init();

  if(!isDefined(game.roundwinner)) {
    game.roundwinner = [];
  }

  if(!isDefined(game.lastroundscore)) {
    game.lastroundscore = [];
  }

  if(!isDefined(game.stat[#"roundswon"])) {
    game.stat[#"roundswon"] = [];
  }

  if(!isDefined(game.stat[#"roundswon"][#"tie"])) {
    game.stat[#"roundswon"][#"tie"] = 0;
  }

  foreach(team, _ in level.teams) {
    if(!isDefined(game.stat[#"roundswon"][team])) {
      game.stat[#"roundswon"][team] = 0;
    }

    level.teamspawnpoints[team] = [];
    level.spawn_point_team_class_names[team] = [];
  }
}

set_flag(flag) {
  outcome::set_flag(game.outcome.var_aefc8b8d, flag);
}

get_flag(flag) {
  return outcome::get_flag(game.outcome.var_aefc8b8d, flag);
}

clear_flag(flag) {
  return outcome::clear_flag(game.outcome.var_aefc8b8d, flag);
}

function_897438f4(var_c1e98979) {
  outcome::function_897438f4(game.outcome.var_aefc8b8d, var_c1e98979);
}

function_3624d032() {
  return outcome::function_3624d032(game.outcome.var_aefc8b8d);
}

get_winning_team() {
  return outcome::get_winning_team(game.outcome.var_aefc8b8d);
}

function_b5f4c9d8() {
  return outcome::function_b5f4c9d8(game.outcome.var_aefc8b8d);
}

get_winner() {
  return outcome::get_winner(game.outcome.var_aefc8b8d);
}

is_winner(team_or_player) {
  return outcome::is_winner(game.outcome.var_aefc8b8d, team_or_player);
}

set_winner(team_or_player) {
  outcome::set_winner(game.outcome.var_aefc8b8d, team_or_player);
}

function_35702443(platoon) {
  assert(isDefined(level.platoons[platoon]));
  outcome::function_35702443(game.outcome.var_aefc8b8d, platoon);
}

function_d30d1a2e() {
  return outcome::function_d30d1a2e(game.outcome.var_aefc8b8d);
}

function_af2e264f(winner) {
  outcome::function_af2e264f(game.outcome.var_aefc8b8d, winner);
}

function_870759fb() {
  outcome::function_870759fb(game.outcome.var_aefc8b8d);
}

is_overtime_round() {
  if(game.overtime_round > 0) {
    return true;
  }

  return false;
}