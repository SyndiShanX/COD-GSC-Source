/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_defaults.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\rank_shared;
#namespace globallogic_defaults;

function getwinningteamfromloser(losing_team) {
  if(level.multiteam) {
    return "tie";
  }
  return util::getotherteam(losing_team);
}

function default_onforfeit(team) {
  level.gameforfeited = 1;
  level notify("hash_d343f3a0");
  level endon("hash_d343f3a0");
  level endon("hash_577494dc");
  forfeit_delay = 20;
  announcement(game["strings"]["opponent_forfeiting_in"], forfeit_delay, 0);
  wait(10);
  announcement(game["strings"]["opponent_forfeiting_in"], 10, 0);
  wait(10);
  endreason = &"";
  if(level.multiteam) {
    setdvar("ui_text_endreason", game["strings"]["other_teams_forfeited"]);
    endreason = game["strings"]["other_teams_forfeited"];
    winner = team;
  } else {
    if(!isDefined(team)) {
      setdvar("ui_text_endreason", game["strings"]["players_forfeited"]);
      endreason = game["strings"]["players_forfeited"];
      winner = level.players[0];
    } else {
      if(isDefined(level.teams[team])) {
        endreason = game["strings"][team + "_forfeited"];
        setdvar("ui_text_endreason", endreason);
        winner = getwinningteamfromloser(team);
      } else {
        assert(isDefined(team), "");
        assert(0, ("" + team) + "");
        winner = "tie";
      }
    }
  }
  level.forcedend = 1;
  if(isplayer(winner)) {
    print(((("" + winner getxuid()) + "") + winner.name) + "");
  } else {
    globallogic_utils::logteamwinstring("", winner);
  }
  thread globallogic::endgame(winner, endreason);
}

function default_ondeadevent(team) {
  if(isDefined(level.teams[team])) {
    eliminatedstring = game["strings"][team + "_eliminated"];
    iprintln(eliminatedstring);
    setdvar("ui_text_endreason", eliminatedstring);
    winner = getwinningteamfromloser(team);
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, eliminatedstring);
  } else {
    setdvar("ui_text_endreason", game["strings"]["tie"]);
    globallogic_utils::logteamwinstring("tie");
    if(level.teambased) {
      thread globallogic::endgame("tie", game["strings"]["tie"]);
    } else {
      thread globallogic::endgame(undefined, game["strings"]["tie"]);
    }
  }
}

function default_onlastteamaliveevent(team) {
  if(isDefined(level.teams[team])) {
    eliminatedstring = game["strings"]["enemies_eliminated"];
    iprintln(eliminatedstring);
    setdvar("ui_text_endreason", eliminatedstring);
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, eliminatedstring);
  } else {
    setdvar("ui_text_endreason", game["strings"]["tie"]);
    globallogic_utils::logteamwinstring("tie");
    if(level.teambased) {
      thread globallogic::endgame("tie", game["strings"]["tie"]);
    } else {
      thread globallogic::endgame(undefined, game["strings"]["tie"]);
    }
  }
}

function default_onalivecountchange(team) {}

function default_onroundendgame(winner) {
  return winner;
}

function default_determinewinner(roundwinner) {
  if(isDefined(game["overtime_round"])) {
    if(isDefined(level.doubleovertime) && level.doubleovertime && isDefined(roundwinner) && roundwinner != "tie") {
      return roundwinner;
    }
    return globallogic::determineteamwinnerbygamestat("overtimeroundswon");
  }
  if(level.scoreroundwinbased) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
  } else {
    winner = globallogic::determineteamwinnerbyteamscore();
  }
  return winner;
}

function default_ononeleftevent(team) {
  if(!level.teambased) {
    winner = globallogic_score::gethighestscoringplayer();
    if(isDefined(winner)) {
      print("" + winner.name);
    } else {
      print("");
    }
    thread globallogic::endgame(winner, &"MP_ENEMIES_ELIMINATED");
  } else {
    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];
      if(!isalive(player)) {
        continue;
      }
      if(!isDefined(player.pers["team"]) || player.pers["team"] != team) {
        continue;
      }
      player globallogic_audio::leader_dialog_on_player("sudden_death");
    }
  }
}

function default_ontimelimit() {
  winner = undefined;
  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("time limit", winner);
  } else {
    winner = globallogic_score::gethighestscoringplayer();
    if(isDefined(winner)) {
      print("" + winner.name);
    } else {
      print("");
    }
  }
  setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
  thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

function default_onscorelimit() {
  if(!level.endgameonscorelimit) {
    return false;
  }
  winner = undefined;
  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("scorelimit", winner);
  } else {
    winner = globallogic_score::gethighestscoringplayer();
    if(isDefined(winner)) {
      print("" + winner.name);
    } else {
      print("");
    }
  }
  setdvar("ui_text_endreason", game["strings"]["score_limit_reached"]);
  thread globallogic::endgame(winner, game["strings"]["score_limit_reached"]);
  return true;
}

function default_onroundscorelimit() {
  winner = undefined;
  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("roundscorelimit", winner);
  } else {
    winner = globallogic_score::gethighestscoringplayer();
    if(isDefined(winner)) {
      print("" + winner.name);
    } else {
      print("");
    }
  }
  setdvar("ui_text_endreason", game["strings"]["round_score_limit_reached"]);
  thread globallogic::endgame(winner, game["strings"]["round_score_limit_reached"]);
  return true;
}

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }
  spawnpoints = spawnlogic::_get_spawnpoint_array("mp_global_intermission");
  assert(spawnpoints.size, "");
  spawnpoint = spawnlogic::get_spawnpoint_random(spawnpoints);
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

function default_onspawnintermission(endgame) {
  if(isDefined(endgame) && endgame) {
    return;
  }
  spawnpoint = spawnlogic::get_random_intermission_point();
  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
  } else {
    util::error("");
  }
}

function default_gettimelimit() {
  return math::clamp(getgametypesetting("timeLimit"), level.timelimitmin, level.timelimitmax);
}

function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = 1;
  if(killstreaks::is_killstreak_weapon(weapon)) {
    teamkill_penalty = teamkill_penalty * killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
  }
  return teamkill_penalty;
}

function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  return rank::getscoreinfovalue("team_kill");
}