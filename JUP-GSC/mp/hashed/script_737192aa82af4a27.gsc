/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_737192aa82af4a27.gsc
*************************************************/

#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_knives;

function function_bdabea561d7e97b1() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_knives");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    knifeweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_me_knife_mp");
    player giveweapon(knifeweapon);
    player setspawnweapon(knifeweapon);
  }
}