/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_defaults.gsc
********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\infection;
#include scripts\core_common\math_shared;
#include scripts\core_common\platoons;
#include scripts\core_common\rank_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\teams\platoons;
#include scripts\mp_common\util;

#namespace globallogic_defaults;

getwinningteamfromloser(losing_team) {
  if(level.multiteam) {
    return undefined;
  }

  return util::getotherteam(losing_team);
}

default_onforfeit(params) {
  level.gameforfeited = 1;
  level notify(#"forfeit in progress");
  level endon(#"forfeit in progress", #"abort forfeit");
  forfeit_delay = 20;
  announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
  wait 10;
  announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
  wait 10;

  if(!isDefined(params)) {
    round::set_winner(level.players[0]);
  } else {
    if(platoons::function_382a49e0() && params.var_b2ee6c67.size) {
      round::function_35702443(params.var_b2ee6c67[0]);
    }

    if(params.var_6eb69269.size) {
      round::set_winner(params.var_6eb69269[0]);
    }
  }

  level.forcedend = 1;
  round::set_flag("force_end");
  thread globallogic::end_round(7);
}

default_ondeadevent(team) {
  current_winner = round::get_winner();

  if(isDefined(current_winner) && current_winner != #"free") {
    return;
  }

  if(isDefined(level.teams[team])) {
    round::set_winner(getwinningteamfromloser(team));
    thread globallogic::end_round(6);
    return;
  }

  round::set_flag("tie");
  thread globallogic::end_round(6);
}

function_dcf41142(params) {
  if(gamestate::is_game_over()) {
    return;
  }

  if(infection::function_74650d7() && platoons::function_382a49e0() && params.var_dfa2cc2c.size) {
    round::function_af2e264f(params.var_dfa2cc2c[0]);
  } else if(platoons::function_382a49e0() && params.platoons_alive.size) {
    round::function_35702443(params.platoons_alive[0]);
  } else if(params.teams_alive.size && isDefined(level.teams[params.teams_alive[0]])) {
    round::function_af2e264f(params.teams_alive[0]);
  } else {
    round::set_flag("tie");
  }

  thread globallogic::end_round(6);
}

function_daa7e9d5() {
  level callback::remove_callback(#"on_last_alive", &function_dcf41142);
}

default_onalivecountchange(team) {}

onendgame(var_c1e98979) {
  if(level.scoreroundwinbased) {
    globallogic_score::updateteamscorebyroundswon();
  }

  match::function_af2e264f(match::function_6d0354e3());
}

default_ononeleftevent(team) {
  if(!level.teambased) {
    round::set_winner(globallogic_score::gethighestscoringplayer());
    thread globallogic::end_round(6);
    return;
  }

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(!isDefined(player.pers[#"team"]) || player.pers[#"team"] != team) {
      continue;
    }

    player globallogic_audio::leader_dialog_on_player("sudden_death");
  }
}

default_ontimelimit() {
  round::function_870759fb();
  thread globallogic::end_round(2);
}

default_onscorelimit() {
  if(!level.endgameonscorelimit) {
    return false;
  }

  round::function_870759fb();
  thread globallogic::end_round(3);
  return true;
}

default_onroundscorelimit() {
  round::function_870759fb();
  param1 = 4;
  thread globallogic::end_round(param1);
  return true;
}

default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  spawnpoints = spawning::get_spawnpoint_array("mp_global_intermission");
  assert(spawnpoints.size, "<dev string:x38>");
  spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

default_onspawnintermission(endgame) {
  if(isDefined(endgame) && endgame) {
    return;
  }

  spawnpoint = spawning::get_random_intermission_point();

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    return;
  }

  util::error("<dev string:x94>");

}

default_gettimelimit() {

  if(getdvarfloat(#"timelimit_override", -1) != -1) {
    return math::clamp(getdvarfloat(#"timelimit_override", -1), level.timelimitmin, level.timelimitmax);
  }

    return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}

default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = 1;

  if(killstreaks::is_killstreak_weapon(weapon)) {
    teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
  }

  return teamkill_penalty;
}

default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  return attacker rank::getscoreinfovalue("team_kill");
}

get_alive_players(players) {
  alive_players = [];

  foreach(player in players) {
    if(player == self) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(!isDefined(alive_players)) {
      alive_players = [];
    } else if(!isarray(alive_players)) {
      alive_players = array(alive_players);
    }

    alive_players[alive_players.size] = player;
  }

  return alive_players;
}

function_108c4b65() {
  if(platoons::function_382a49e0()) {
    teammates = getplayers(self.team);
    var_2927adba = get_alive_players(teammates);

    if(var_2927adba.size) {
      return var_2927adba[0];
    }

    platoon = getteamplatoon(self.team);
    var_bf97e486 = platoons::function_a214d798(platoon);
    return spectating::function_18b8b7e4(var_bf97e486, self.origin);
  }
}