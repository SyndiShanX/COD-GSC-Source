/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game_utility_mp.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;
#namespace game_utility_mp;

function game_utility_mp_init() {
  registersharedfunc("game_utility", "getTimeSinceGameStart", &game_utility_mp_gettimesincegamestart);
}

function game_utility_mp_gettimesincegamestart() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

function function_9a2fd0d19774edde() {
  switch (scripts\mp\utility\game::getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_ca6516c10db2c95":
    case #"hash_5e78ea9021845d4a":
    case #"hash_7f9c384a34cc392f":
    case #"hash_9a6f07d0214a87db":
    case #"hash_c065cef60f38490a":
    case #"hash_c7f4420f385eeb3d":
      return true;
    default:
      return false;
  }

  return false;
}

function modeusesgroundwarteamoobtriggers(trigger) {
  if(isDefined(trigger.script_team)) {
    switch (scripts\mp\utility\game::getgametype()) {
      case #"hash_1e4846dca3ccf38":
      case #"hash_ca6516c10db2c95":
      case #"hash_5e78ea9021845d4a":
      case #"hash_7f9c384a34cc392f":
      case #"hash_9a6f07d0214a87db":
      case #"hash_c065cef60f38490a":
      case #"hash_c7f4420f385eeb3d":
        return true;
      default:
        return false;
    }
  }

  return true;
}