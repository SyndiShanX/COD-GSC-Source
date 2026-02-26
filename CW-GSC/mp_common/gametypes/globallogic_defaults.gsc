/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_defaults.gsc
********************************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\math_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spectate_view;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\util;
#namespace globallogic_defaults;

function getwinningteamfromloser(losing_team) {
  if(level.multiteam) {
    return undefined;
  }

  return util::getotherteam(losing_team);
}

function function_61c8bef4(params) {
  level.var_ba92f0a8 = 1;
  level.forcedend = 1;
  round::set_flag("force_end");
  thread globallogic::end_round(11);
}

function default_onforfeit(params) {
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
  } else if(params.var_6eb69269.size) {
    round::set_winner(params.var_6eb69269[0]);
  }

  level.forcedend = 1;
  round::set_flag("force_end");
  thread globallogic::end_round(7);
}

function default_ondeadevent(team) {
  current_winner = round::get_winner();

  if(isDefined(current_winner) && current_winner != # "none") {
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

function function_dcf41142(params) {
  if(getdvarint(#"hash_3b4d2cf24a06392e", 0)) {
    return;
  }

  if(gamestate::is_game_over()) {
    return;
  }

  if(params.teams_alive.size && isDefined(level.teams[params.teams_alive[0]])) {
    round::function_af2e264f(params.teams_alive[0]);
  } else {
    round::set_flag("tie");
  }

  thread globallogic::end_round(6);
}

function function_daa7e9d5() {
  level callback::remove_callback(#"on_last_alive", &function_dcf41142);
}

function default_onalivecountchange(team) {}

function onendgame(var_c1e98979) {
  if(level.scoreroundwinbased) {
    globallogic_score::function_9779ac61();
  }

  winner = match::function_6d0354e3();

  if(level.tournamentmatch === 1 && (!isDefined(winner) || winner == # "none")) {
    winner = match::function_10cd0ad();
  }

  match::function_af2e264f(winner);
}

function default_ononeleftevent(team) {
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

function default_ontimelimit() {
  round::function_870759fb();
  thread globallogic::end_round(2);
}

function default_onscorelimit() {
  if(!level.endgameonscorelimit) {
    return false;
  }

  round::function_870759fb();
  thread globallogic::end_round(3);
  return true;
}

function default_onroundscorelimit() {
  round::function_870759fb();
  param1 = 4;
  thread globallogic::end_round(param1);
  return true;
}

function private function_85d45b4b(origin, angles) {
  self spawn(origin, angles);

  if(self.pers[#"team"] != # "spectator" && level.var_1ba484ad === 2) {
    self spectate_view::function_86df9236();
  }
}

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self function_85d45b4b(origin, angles);
    return;
  }

  spawnpoints = spawning::get_spawnpoint_array("mp_global_intermission");
  assert(spawnpoints.size, "<dev string:x38>");
  spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
  self function_85d45b4b(spawnpoint.origin, spawnpoint.angles);
}

function default_onspawnintermission(endgame) {
  if(is_true(endgame)) {
    return;
  }

  spawnpoint = spawning::get_random_intermission_point();

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
  } else {
    util::error("<dev string:x95>");
  }

  self callback::callback(#"hash_3e52a013a2eb0f16");
}

function default_gettimelimit() {
  if(getdvarfloat(#"timelimit_override", -1) != -1) {
    return math::clamp(getdvarfloat(#"timelimit_override", -1), level.timelimitmin, level.timelimitmax);
  }

  return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}

function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = 1;

  if(killstreaks::is_killstreak_weapon(weapon)) {
    teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
  }

  if(isDefined(level.var_17ae20ae) && [[level.var_17ae20ae]](einflictor, attacker, smeansofdeath, weapon)) {
    teamkill_penalty *= level.teamkillpenaltymultiplier;
  }

  return teamkill_penalty;
}

function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_score = attacker rank::getscoreinfovalue("team_kill");

  if(isDefined(level.var_17ae20ae) && [[level.var_17ae20ae]](einflictor, attacker, smeansofdeath, weapon)) {
    teamkill_score = attacker rank::getscoreinfovalue("kill");
    teamkill_score *= level.teamkillscoremultiplier;
  }

  return int(teamkill_score);
}

function get_alive_players(players) {
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