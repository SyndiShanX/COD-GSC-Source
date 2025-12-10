/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_globallogic_defaults.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\cp\gametypes\_spawnlogic;
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
  if(team == "all") {
    winner = level.enemy_ai_team;
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, &"SM_ALL_PLAYERS_KILLED");
  } else {
    winner = getwinningteamfromloser(team);
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, &"SM_ALL_PLAYERS_KILLED");
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

function things_exist_which_could_revive_player(team) {
  return false;
}

function team_can_be_revived(team) {
  if(things_exist_which_could_revive_player(team)) {
    return true;
  }
  if(level.playercount[team] == 1 && level.alivecount[team] == 1) {
    assert(level.aliveplayers[team].size == 1);
    if(level.aliveplayers[team][0].lives > 0) {
      return true;
    }
  }
  return false;
}

function default_onlaststandevent(team) {
  if(team_can_be_revived(team)) {
    return;
  }
  if(team == "all") {
    thread globallogic::endgame(level.enemy_ai_team, &"SM_ALL_PLAYERS_KILLED");
  } else {
    thread globallogic::endgame(util::getotherteam(team), &"SM_ALL_PLAYERS_KILLED");
  }
}

function default_onalivecountchange(team) {}

function default_onroundendgame(winner) {
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

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }
  spawnpointname = "cp_global_intermission";
  spawnpoints = struct::get_array(spawnpointname, "targetname");
  assert(spawnpoints.size, ("" + spawnpointname) + "");
  spawnpoint = spawnlogic::get_spawnpoint_random(spawnpoints);
  assert(isDefined(spawnpoint.origin), ("" + spawnpointname) + "");
  assert(isDefined(spawnpoint.angles), ((("" + spawnpointname) + "") + spawnpoint.origin) + "");
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

function default_onspawnintermission() {
  spawnpointname = "cp_global_intermission";
  spawnpoints = struct::get_array(spawnpointname, "targetname");
  spawnpoint = spawnpoints[0];
  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
  } else {
    util::error(("" + spawnpointname) + "");
  }
}

function default_gettimelimit() {
  return math::clamp(getgametypesetting("timeLimit"), level.timelimitmin, level.timelimitmax);
}

function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = 1;
  score = globallogic_score::_getplayerscore(attacker);
  if(score == 0) {
    teamkill_penalty = 2;
  }
  return teamkill_penalty;
}

function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  return rank::getscoreinfovalue("team_kill");
}