/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42e17fdd8c77a57.gsc
************************************************/

#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_dontshoot;

function function_3c1a6c0c2ccb4869() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_dontshoot");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    pistolweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_jp14_pi_rsierra12_mp");
    player giveweapon(pistolweapon);
    player setspawnweapon(pistolweapon);
    player thread function_724cc0f31814881c();
  }
}

function function_724cc0f31814881c() {
  level endon("game_ended");
  level endon("round_end_finished");
  self waittill("weapon_fired");
  self kill();
}