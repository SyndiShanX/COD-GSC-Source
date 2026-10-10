/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7163a90de898cc17.gsc
*************************************************/

#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace warrior_shocking;

function function_4629defddacd1dc1() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_shocking");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    pistolweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_jp36_ar_anov94_mp");
    player giveweapon(pistolweapon);
    player setspawnweapon(pistolweapon);
    player thread scripts\mp\utility\weapon::infiniteammothread(0.5);
    player thread function_a84504e876b9bfdd();
  }
}

function function_a84504e876b9bfdd() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  var_91beb5c3a5ab6910 = spawnStruct();
  var_91beb5c3a5ab6910.victim = self;
  var_91beb5c3a5ab6910.objweapon = self getcurrentweapon();

  if(isagent(self)) {
    thread scripts\mp\equipment\shock_stick::shockstick_haywireagent(var_91beb5c3a5ab6910);
    return;
  }

  if(isPlayer(self)) {
    tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_shockstick");
    tableinfo.bundle.gestureref = "vm_ges_shockstick_react_looping";
    thread scripts\mp\equipment\shock_stick::function_c927fd013fc6e502(var_91beb5c3a5ab6910, tableinfo.bundle);
  }
}