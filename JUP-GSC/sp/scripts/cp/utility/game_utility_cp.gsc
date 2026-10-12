/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\game_utility_cp.gsc
**************************************************/



#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace game_utility_cp;

function game_utility_cp_init() {
  registersharedfunc("game_utility", "getTimeSinceGameStart", &game_utility_cp_gettimesincegamestart);
}

function game_utility_cp_gettimesincegamestart() {
  return gettime() - level.starttime;
}