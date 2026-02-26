/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_defaults.gsc
********************************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\math_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\util;
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
  level endon(#"forfeit in progress", #"abort forfeit");
  forfeit_delay = 20;
  announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
  wait 10;
  announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
  wait 10;
  endreason = # "";

  if(level.multiteam) {
    setDvar(#"ui_text_endreason", game.strings[#"other_teams_forfeited"]);
    endreason = game.strings[#"other_teams_forfeited"];
    winner = team;
  } else if(!isDefined(team)) {
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

  thread globallogic::endgame();
}

function default_ondeadevent(team) {
  if(team == "all") {
    winner = level.var_c20ad7aa;
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame();
    return;
  }

  winner = getwinningteamfromloser(team);
  globallogic_utils::logteamwinstring("team eliminated", winner);
  thread globallogic::endgame();
}

function function_9fd1cc80(team) {
  if(isDefined(level.teams[team])) {
    eliminatedstring = game.strings[#"enemies_eliminated"];
    iprintln(eliminatedstring);
    setDvar(#"ui_text_endreason", eliminatedstring);
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("team eliminated", winner);
    thread globallogic::endgame();
    return;
  }

  setDvar(#"ui_text_endreason", game.strings[#"tie"]);
  globallogic_utils::logteamwinstring("tie");

  if(level.teambased) {
    thread globallogic::endgame();
    return;
  }

  thread globallogic::endgame();
}

function function_8fd32d09(team) {
  return false;
}

function function_b8fe203b(team) {
  if(function_8fd32d09(team)) {
    return true;
  }

  if(level.playercount[team] == 1 && function_a1ef346b(team).size == 1) {
    assert(function_a1ef346b(team).size == 1);

    if(function_a1ef346b(team)[0].lives > 0) {
      return true;
    }
  }

  return false;
}

function function_b322d0f3(team) {
  if(function_b8fe203b(team)) {
    return;
  }

  if(team == "all") {
    thread globallogic::endgame();
    return;
  }

  thread globallogic::endgame();
}

function default_onalivecountchange(team) {}

function default_onroundendgame(winner) {
  return winner;
}

function default_ononeleftevent(team) {}

function default_ontimelimit() {
  winner = undefined;

  if(level.teambased) {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    globallogic_utils::logteamwinstring("time limit", winner);
  } else {
    if(isDefined(winner)) {
      print("<dev string:xad>" + winner.name);
    } else {
      print("<dev string:xc2>");
    }
  }

  setDvar(#"ui_text_endreason", game.strings[#"time_limit_reached"]);
  thread globallogic::endgame();
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
    if(isDefined(winner)) {
      print("<dev string:xd5>" + winner.name);
    } else {
      print("<dev string:xea>");
    }
  }

  setDvar(#"ui_text_endreason", game.strings[#"score_limit_reached"]);
  thread globallogic::endgame();
  return true;
}

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  spawnpointname = "cp_global_intermission";
  spawnpoints = struct::get_array(spawnpointname, "targetname");
  assert(spawnpoints.size, "<dev string:xfd>" + spawnpointname + "<dev string:x10e>");
  spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
  assert(isDefined(spawnpoint.origin), "<dev string:x148>" + spawnpointname + "<dev string:x15d>");
  assert(isDefined(spawnpoint.angles), "<dev string:x148>" + spawnpointname + "<dev string:x171>" + spawnpoint.origin + "<dev string:x17a>");
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

function default_onspawnintermission() {
  spawnpointname = "cp_global_intermission";
  spawnpoints = struct::get_array(spawnpointname, "targetname");
  spawnpoint = spawnpoints[0];

  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    return;
  }

  util::error("<dev string:x18c>" + spawnpointname + "<dev string:x193>");
}

function default_gettimelimit() {
  var_a25a9aa9 = getgametypesetting(#"timelimit");

  if(!isDefined(var_a25a9aa9)) {
    var_a25a9aa9 = level.timelimitmax;
  }

  return math::clamp(var_a25a9aa9, level.timelimitmin, level.timelimitmax);
}

function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  return false;
}

function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  return false;
}