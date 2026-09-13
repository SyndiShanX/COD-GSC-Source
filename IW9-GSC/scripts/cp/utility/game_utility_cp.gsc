/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\game_utility_cp.gsc
**************************************************/

game_utility_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "getTimeSinceGameStart", ::game_utility_cp_gettimesincegamestart);
}

game_utility_cp_gettimesincegamestart() {
  return gettime() - level.starttime;
}