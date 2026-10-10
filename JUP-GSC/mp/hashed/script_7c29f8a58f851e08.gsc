/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c29f8a58f851e08.gsc
*************************************************/

#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_bullettime;

function function_b4220bf7ade5fc76() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_bullettime");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    var_260024495ccb1af0 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_cp24_pi_glima21_mp_bullettime");
    player giveweapon(var_260024495ccb1af0);
    player setspawnweapon(var_260024495ccb1af0);
    player thread waittill_reload(var_260024495ccb1af0);
  }
}

function waittill_reload(var_260024495ccb1af0) {
  level endon("game_ended");
  level endon("round_end_finished");
  ammostock = self getweaponammostock(var_260024495ccb1af0);

  while(true) {
    self waittill("reload");
    self setweaponammostock(var_260024495ccb1af0, ammostock);
  }
}