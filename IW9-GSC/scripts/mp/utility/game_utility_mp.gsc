/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game_utility_mp.gsc
**************************************************/

game_utility_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "getTimeSinceGameStart", ::game_utility_mp_gettimesincegamestart);
}

game_utility_mp_gettimesincegamestart() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

_id_9A2FD0D19774EDDE() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "gwtdm":
    case "gwai":
    case "gwbomb":
    case "bigctf":
    case "conflict":
    case "risk":
    case "arm":
      return 1;
    default:
      return 0;
  }

  return 0;
}

modeusesgroundwarteamoobtriggers(trigger) {
  if(isDefined(trigger.script_team)) {
    switch (scripts\mp\utility\game::getgametype()) {
      case "gwtdm":
      case "gwai":
      case "gwbomb":
      case "bigctf":
      case "conflict":
      case "risk":
      case "arm":
        return 1;
      default:
        return 0;
    }
  }

  return 1;
}