/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_defaults.gsc
********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\gametypes\globallogic;
#include scripts\zm_common\gametypes\globallogic_audio;
#include scripts\zm_common\gametypes\globallogic_score;
#include scripts\zm_common\gametypes\globallogic_utils;
#include scripts\zm_common\gametypes\spawnlogic;
#include scripts\zm_common\util;

#namespace globallogic_defaults;

getwinningteamfromloser(losing_team) {
  if(level.multiteam) {
    return "tie";
  }

  return util::getotherteam(losing_team);
}

default_onforfeit(team) {
  level.gameforfeited = 1;
  level notify(#"forfeit in progress");
  level endon(#"forfeit in progress");
  level endon(#"abort forfeit");
  forfeit_delay = 20;
  announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
  wait 10;
  announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
  wait 10;
  endreason = #"";

  if(!isDefined(team)) {
    setdvar(#"ui_text_endreason", game.strings[#"players_forfeited"]);
    endreason = game.strings[#"players_forfeited"];
    winner = level.players[0];
  } else if(isDefined(level.teams[team])) {
    endreason = game.strings[team + "_forfeited"];
    setdvar(#"ui_text_endreason", endreason);
    winner = getwinningteamfromloser(team);
  } else {
    assert(isDefined(team), "<dev string:x38>");
    assert(0, "<dev string:x58>" + team + "<dev string:x6a>");
    winner = "tie";
  }

  level.forcedend = 1;

  if(isplayer(winner)) {
    print("<dev string:x83>" + winner getxuid() + "<dev string:x94>" + winner.name + "<dev string:x98>");
  } else {
    globallogic_utils::logteamwinstring("<dev string:x9c>", winner);
  }

    thread globallogic::endgame(winner, endreason);
}

default_ondeadevent(team) {
  level callback::callback(#"on_team_eliminated", team);

  if(isDefined(level.teams[team])) {
    eliminatedstring = game.strings[team + "_eliminated"];
    iprintln(eliminatedstring);
    setdvar(#"ui_text_endreason", eliminatedstring);
    winner = getwinningteamfromloser(team);
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame(winner, eliminatedstring);
    return;
  }

  setdvar(#"ui_text_endreason", game.strings[#"tie"]);
  globallogic_utils::logteamwinstring("tie");

  if(level.teambased) {
    thread globallogic::endgame("tie", game.strings[#"tie"]);
    return;
  }

  thread globallogic::endgame(undefined, game.strings[#"tie"]);
}

default_onalivecountchange(team) {}

default_onroundendgame(winner) {
  return winner;
}

default_ononeleftevent(team) {
  if(!level.teambased) {
    winner = globallogic_score::gethighestscoringplayer();

    if(isDefined(winner)) {
      print("<dev string:xa6>" + winner.name);
    } else {
      print("<dev string:xbe>");
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

default_ontimelimit() {
  winner = undefined;

  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("time limit", winner);
  } else {
    winner = globallogic_score::gethighestscoringplayer();

    if(isDefined(winner)) {
      print("<dev string:xdd>" + winner.name);
    } else {
      print("<dev string:xf1>");
    }

  }

  setdvar(#"ui_text_endreason", game.strings[#"time_limit_reached"]);
  thread globallogic::endgame(winner, game.strings[#"time_limit_reached"]);
}

default_onscorelimit() {
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
      print("<dev string:x103>" + winner.name);
    } else {
      print("<dev string:x117>");
    }

  }

  setdvar(#"ui_text_endreason", game.strings[#"score_limit_reached"]);
  thread globallogic::endgame(winner, game.strings[#"score_limit_reached"]);
  return true;
}

default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  assert(spawnpoints.size, "<dev string:x129>");
  spawnpoint = spawnlogic::getspawnpoint_random(spawnpoints);
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

default_onspawnintermission() {
  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  spawnpoint = spawnpoints[0];

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    return;
  }

  util::error("<dev string:x185>" + spawnpointname + "<dev string:x18b>");

}

default_gettimelimit() {
  return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}