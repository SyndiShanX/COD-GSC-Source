/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_32e45a09983017e.gsc
************************************************/

#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_serpentine;

function function_c9cfdf276fba4138() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_serpentine");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player setstance("prone");
    player val::set("serpentine", "crouch", 0);
    player val::set("serpentine", "stand", 0);
    player val::set("serpentine", "supersprint", 0);
    player.var_c1229a908e2f8c21 = player.suit;
    player setsuit("jup_gamemode_warrior_serpentine");
    player takeallweapons();
    var_78a4f15343af8419 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_pi_swhiskey_mp");
    player giveweapon(var_78a4f15343af8419);
    player setspawnweapon(var_78a4f15343af8419);
  }
}

function function_cccdb1b3d660c940() {
  foreach(player in level.players) {
    player val::reset_all("serpentine");
    player setsuit(player.var_c1229a908e2f8c21);
    player.var_c1229a908e2f8c21 = undefined;
  }
}