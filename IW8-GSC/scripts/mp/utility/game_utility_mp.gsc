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

function ref_11c8a(var0) {
  if(isDefined(var0.script_team)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function track_get_reward_time(var0, var1) {
  if(!isDefined(level.br_level)) {
    return true;
  }

  var2 = removeselfrevivetoken(var1);
  var3 = min(var2[0][0], var2[1][0]);
  var4 = min(var2[0][1], var2[1][1]);
  var5 = max(var2[0][0], var2[1][0]);
  var6 = max(var2[0][1], var2[1][1]);

  if(var0[0] <= var3) {
    return false;
  } else if(var0[0] >= var5) {
    return false;
  }

  if(var0[1] <= var4) {
    return false;
  } else if(var0[1] >= var6) {
    return false;
  }

  return true;
}

function removeselfrevivetoken(var0) {
  var1 = level.br_level.br_mapbounds;
  var2 = isDefined(level.br_level.delay_set_bomber_traversals);
  var3 = istrue(var0);

  if(var2 && var3) {
    var1 = level.br_level.delay_set_bomber_traversals;
  }

  return var1;
}

function removespawns(var0) {
  var1 = removeselfrevivetoken(var0);
  var2 = var1[1][0];
  var3 = var1[0][0];
  return abs(var2 - var3);
}

function removespawnprotectiononads(var0) {
  var1 = removeselfrevivetoken(var0);
  var2 = (var1[0] + var1[1]) * 0.5;
  return var2;
}