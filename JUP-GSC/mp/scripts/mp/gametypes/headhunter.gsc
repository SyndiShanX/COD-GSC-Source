/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\headhunter.gsc
**************************************************/

#using scripts\common\values;
#using scripts\mp\tweakables;
#namespace headhunter;

function init() {
  thread function_117e2995648ba30c();
  thread onplayerspawned();
}

function function_117e2995648ba30c() {
  level endon("game_ended");
  level waittill("tweakablesInitialized");
  scripts\mp\tweakables::settweakablevalue("game", "onlyheadshots", 1);
}

function onplayerspawned() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);
    player val::set("headhunter", "execution_attack", 0);
    player val::set("headhunter", "execution_victim", 0);
    player setsoundsubmix("jup_mode_headhunter", 0.5);
  }
}