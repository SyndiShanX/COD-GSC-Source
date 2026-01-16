/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\outcome.gsc
***********************************************/

#include scripts\core_common\flagsys_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_score;

#namespace outcome;

autoexec main() {
  level.var_9b671c3c[#"tie"] = {
    #flag: "tie", 
    #code_flag: 1
  };
  level.var_9b671c3c[#"overtime"] = {
    #flag: "overtime", 
    #code_flag: 2
  };
}

function_a1a81955() {
  outcome = spawnStruct();
  outcome.flags = 0;
  outcome.var_c1e98979 = 0;
  outcome.team = #"free";

  foreach(team, _ in level.teams) {
    outcome.team_score[team] = 0;
  }

  outcome.platoon = #"none";
  outcome.players = [];
  outcome.players_score = [];
  return outcome;
}

is_winner(outcome, team_or_player) {
  if(isplayer(team_or_player)) {
    if(isDefined(outcome.players) && outcome.players.size && outcome.players[0] == team_or_player) {
      return true;
    }

    if(isDefined(outcome.team) && outcome.team == team_or_player.team) {
      return true;
    }
  } else if(isDefined(outcome.team) && outcome.team == team_or_player) {
    return true;
  }

  return false;
}

set_flag(outcome, flag) {
  outcome flagsys::set(flag);
}

get_flag(outcome, flag) {
  return outcome flagsys::get(flag);
}

clear_flag(outcome, flag) {
  return outcome flagsys::clear(flag);
}

function_2e00fa44(outcome) {
  flags = 0;

  foreach(flag_type in level.var_9b671c3c) {
    if(outcome flagsys::get(flag_type.flag)) {
      flags |= flag_type.code_flag;
    }
  }

  return flags;
}

function_897438f4(outcome, var_c1e98979) {
  outcome.var_c1e98979 = var_c1e98979;
}

function_3624d032(outcome) {
  return outcome.var_c1e98979;
}

get_winning_team(outcome) {
  if(isDefined(outcome.team)) {
    return outcome.team;
  }

  if(outcome.players.size) {
    return outcome.players[0].team;
  }

  return #"free";
}

function_b5f4c9d8(outcome) {
  if(outcome.players.size) {
    return outcome.players[0];
  }

  return undefined;
}

get_winner(outcome) {
  if(isDefined(outcome.team)) {
    return outcome.team;
  }

  if(outcome.players.size) {
    return outcome.players[0];
  }

  return undefined;
}

function_d30d1a2e(outcome) {
  return outcome.platoon;
}

set_winner(outcome, team_or_player) {
  if(!isDefined(team_or_player)) {
    return;
  }

  if(isplayer(team_or_player)) {
    outcome.players[outcome.players.size] = team_or_player;
    outcome.team = team_or_player.team;
    return;
  }

  outcome.team = team_or_player;
}

function_35702443(outcome, platoon) {
  if(!isDefined(platoon)) {
    return;
  }

  outcome.platoon = platoon;
}

function_af2e264f(outcome, winner) {
  if(isDefined(winner)) {
    set_winner(outcome, winner);
    return;
  }

  set_flag(outcome, "tie");
}

function_6d0354e3() {
  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
  } else {
    winner = globallogic_score::gethighestscoringplayer();
  }

  return winner;
}

function_870759fb(outcome) {
  winner = function_6d0354e3();
  function_af2e264f(outcome, winner);
}