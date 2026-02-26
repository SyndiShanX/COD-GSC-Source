/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_defaults.gsc
********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\util;
#namespace globallogic_defaults;

function getwinningteamfromloser(losing_team) {
  if(level.multiteam) {
    return "tie";
  }

  return util::getotherteam(losing_team);
}

function default_onforfeit(team) {
  level.gameforfeited = 1;
  level notify(#"forfeit in progress");
  level endon(#"forfeit in progress");
  level endon(#"abort forfeit");
  forfeit_delay = 20;
  announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
  wait 10;
  announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
  wait 10;
  endreason = # "";

  if(!isDefined(team)) {
    setDvar(#"ui_text_endreason", game.strings[#"players_forfeited"]);
    endreason = game.strings[#"players_forfeited"];
    winner = level.players[0];
  } else if(isDefined(level.teams[team])) {
    endreason = game.strings[team + "_forfeited"];
    setDvar(#"ui_text_endreason", endreason);
    winner = getwinningteamfromloser(team);
  } else {
    assert(isDefined(team), "<dev string:x38>");
    assert(0, "<dev string:x59>" + team + "<dev string:x6c>");
    winner = "tie";
  }

  level.forcedend = 1;

  if(isPlayer(winner)) {
    print("<dev string:x86>" + winner getxuid() + "<dev string:x98>" + winner.name + "<dev string:x9d>");
  } else {
    globallogic_utils::logteamwinstring("<dev string:xa2>", winner);
  }

  thread globallogic::endgame(winner, endreason);
}

function default_ondeadevent(team) {
  level callback::callback(#"on_team_eliminated", team);

  if(isDefined(level.teams[team])) {
    eliminatedstring = game.strings[team + "_eliminated"];
    iprintln(eliminatedstring);
    setDvar(#"ui_text_endreason", eliminatedstring);
    winner = getwinningteamfromloser(team);
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, eliminatedstring);
    return;
  }

  setDvar(#"ui_text_endreason", game.strings[#"tie"]);
  globallogic_utils::logteamwinstring("tie");

  if(level.teambased) {
    thread globallogic::endgame("tie", game.strings[#"tie"]);
    return;
  }

  thread globallogic::endgame(undefined, game.strings[#"tie"]);
}

function default_onalivecountchange(team) {}

function default_onroundendgame(winner) {
  return winner;
}

function default_ononeleftevent(team) {
  if(!level.teambased) {
    winner = globallogic_score::gethighestscoringplayer();

    if(isDefined(winner)) {
      print("<dev string:xad>" + winner.name);
    } else {
      print("<dev string:xc6>");
    }

    thread globallogic::endgame(winner, #"mp_enemies_eliminated");
    return;
  }

  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(!isalive(player)) {
      continue;
    }

    if(!isDefined(player.pers[#"team"]) || player.pers[#"team"] != team) {}
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
      print("<dev string:xe6>" + winner.name);
    } else {
      print("<dev string:xfb>");
    }
  }

  setDvar(#"ui_text_endreason", game.strings[#"time_limit_reached"]);
  thread globallogic::endgame(winner, game.strings[#"time_limit_reached"]);
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
      print("<dev string:x10e>" + winner.name);
    } else {
      print("<dev string:x123>");
    }
  }

  setDvar(#"ui_text_endreason", game.strings[#"score_limit_reached"]);
  thread globallogic::endgame(winner, game.strings[#"score_limit_reached"]);
  return true;
}

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  assert(spawnpoints.size, "<dev string:x136>");
  spawnpoint = spawnlogic::getspawnpoint_random(spawnpoints);
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

function default_onspawnintermission() {
  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  spawnpoint = spawnpoints[0];

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    return;
  }

  util::error("<dev string:x193>" + spawnpointname + "<dev string:x19a>");
}

function default_gettimelimit() {
  timelimit = getgametypesetting(#"timelimit");

  if(!isDefined(timelimit)) {
    timelimit = 0;
  }

  return math::clamp(timelimit, level.timelimitmin, level.timelimitmax);
}