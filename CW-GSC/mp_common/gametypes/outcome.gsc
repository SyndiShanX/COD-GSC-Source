/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\outcome.gsc
***********************************************/

#using script_3d703ef87a841fe4;
#using scripts\core_common\flag_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#namespace outcome;

function autoexec main() {
  level.var_9b671c3c[# "tie"] = {
    #flag: "tie", #code_flag: 1
  };
  level.var_9b671c3c[# "overtime"] = {
    #flag: "overtime", #code_flag: 2
  };
}

function function_a1a81955() {
  outcome = spawnStruct();
  outcome.flags = 0;
  outcome.var_c1e98979 = 0;
  outcome.team = # "none";
  outcome.players = [];
  outcome.players_score = [];
  return outcome;
}

function is_winner(outcome, team_or_player) {
  if(isPlayer(team_or_player)) {
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

function set_flag(outcome, flag) {
  outcome flag::set(flag);
}

function get_flag(outcome, flag) {
  return outcome flag::get(flag);
}

function clear_flag(outcome, flag) {
  return outcome flag::clear(flag);
}

function function_2e00fa44(outcome) {
  flags = 0;

  foreach(flag_type in level.var_9b671c3c) {
    if(outcome flag::get(flag_type.flag)) {
      flags |= flag_type.code_flag;
    }
  }

  return flags;
}

function function_897438f4(outcome, var_c1e98979) {
  outcome.var_c1e98979 = var_c1e98979;
}

function function_3624d032(outcome) {
  return outcome.var_c1e98979;
}

function get_winning_team(outcome) {
  if(isDefined(outcome.team)) {
    return outcome.team;
  }

  if(outcome.players.size) {
    return outcome.players[0].team;
  }

  return # "none";
}

function function_b5f4c9d8(outcome) {
  if(outcome.players.size) {
    return outcome.players[0];
  }

  return undefined;
}

function get_winner(outcome) {
  if(isDefined(outcome.team)) {
    return outcome.team;
  }

  if(outcome.players.size) {
    return outcome.players[0];
  }

  return undefined;
}

function set_winner(outcome, team_or_player) {
  if(!isDefined(team_or_player)) {
    return;
  }

  if(isPlayer(team_or_player)) {
    outcome.players[outcome.players.size] = team_or_player;
    outcome.team = team_or_player.team;
    return;
  }

  outcome.team = team_or_player;
}

function function_af2e264f(outcome, winner) {
  if(isDefined(winner)) {
    set_winner(outcome, winner);
    return;
  }

  set_flag(outcome, "tie");
}

function function_6d0354e3() {
  if(level.teambased) {
    winner = teams::function_d85770f0("teamScores");
  } else {
    winner = globallogic_score::gethighestscoringplayer();
  }

  return winner;
}

function function_870759fb(outcome) {
  winner = function_6d0354e3();
  function_af2e264f(outcome, winner);
}