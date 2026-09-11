/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game_utility_mp.gsc
**************************************************/

function game_utility_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "getTimeSinceGameStart", &game_utility_mp_gettimesincegamestart);
}

function game_utility_mp_gettimesincegamestart() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

function ref_11c7f() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "infect":
      return 0;
    case "dm":
      if(istrue(level.aonrules)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

function ref_11c80() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "oic":
    case "infect":
      return 0;
    case "dm":
      if(istrue(level.aonrules)) {
        return 0;
      } else {
        return 1;
      }
    case "arena":
      if(istrue(level.allowsupers)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

function ref_11c8a(var_0) {
  if(isDefined(var_0.script_team)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function track_get_reward_time(var_0, var_1) {
  if(!isDefined(level.br_level)) {
    return true;
  }

  var_2 = removeselfrevivetoken(var_1);
  var_3 = min(var_2[0][0], var_2[1][0]);
  var_4 = min(var_2[0][1], var_2[1][1]);
  var_5 = max(var_2[0][0], var_2[1][0]);
  var_6 = max(var_2[0][1], var_2[1][1]);

  if(var_0[0] <= var_3) {
    return false;
  } else if(var_0[0] >= var_5) {
    return false;
  }

  if(var_0[1] <= var_4) {
    return false;
  } else if(var_0[1] >= var_6) {
    return false;
  }

  return true;
}

function removeselfrevivetoken(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = isDefined(level.br_level.delay_set_bomber_traversals);
  var_3 = istrue(var_0);

  if(var_2 && var_3) {
    var_1 = level.br_level.delay_set_bomber_traversals;
  }

  return var_1;
}

function removespawns(var_0) {
  var_1 = removeselfrevivetoken(var_0);
  var_2 = var_1[1][0];
  var_3 = var_1[0][0];
  return abs(var_2 - var_3);
}

function removespawnprotectiononads(var_0) {
  var_1 = removeselfrevivetoken(var_0);
  var_2 = (var_1[0] + var_1[1]) * 0.5;
  return var_2;
}