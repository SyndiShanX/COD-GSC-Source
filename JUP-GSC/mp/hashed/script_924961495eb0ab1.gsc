/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_924961495eb0ab1.gsc
************************************************/

#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\juggernaut;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_miniguns;

function function_d8ab130aa8874e6b() {
  thread onplayerspawned();
  level.var_6298f362ec23d83.var_3a312a64852e713b = getdvarfloat(@ "hash_4a9a810d95be6352");
  setDvar(@ "hash_e953bd34c5277146", 80);
  thread function_492b4dec632917ec("warrior_miniguns");
}

function function_eb881ddfad8bc7eb() {
  if(level.var_6298f362ec23d83.var_3a312a64852e713b == 0) {
    setDvar(@ "hash_e953bd34c5277146", -1);
    return;
  }

  setDvar(@ "hash_e953bd34c5277146", level.var_6298f362ec23d83.var_3a312a64852e713b);
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    player setspawnweapon(scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_minigunksjugg_mp"));
  }
}