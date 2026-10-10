/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f3c7170aedfefd7.gsc
*************************************************/

#using script_54e6d1e4fb728cb8;
#using scripts\engine\utility;
#namespace namespace_15b61b6788c29fd2;

function function_9e3f4898db5d314e(callback) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("enemy_on_compass");
  self[[callback]]();
}

function function_e23dcf42aae58dad(delta, callback, onlybots) {
  level endon("game_ended");
  self endon("disconnect");

  foreach(enemy in level.players) {
    if(isDefined(onlybots) && onlybots) {
      if(!isbot(enemy)) {
        continue;
      }
    }

    function_3482e3d6bb34c1bf(enemy, delta, callback);
  }
}

function function_3482e3d6bb34c1bf(enemy, delta, callback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ftue_enemy_loot_viewed");
  self.var_ee280d08e9b9729d = callback;

  if(!isalliedsentient(self, enemy)) {
    foreach(item in enemy.var_d2dbb2fa012e6d9c) {
      if(!isDefined(item)) {
        continue;
      }

      childthread function_683c095e6767c4c8(item.origin, delta, &function_d138a208396bb595);
    }
  }
}

function function_ec7f69bba0f79ee7(callback, onlybots) {
  level endon("game_ended");
  self endon("disconnect");

  foreach(enemy in level.players) {
    if(isDefined(onlybots) && onlybots) {
      if(!isbot(enemy)) {
        continue;
      }
    }

    function_8441daa65ac853d9(enemy, callback);
  }
}

function function_8441daa65ac853d9(enemy, callback) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isalliedsentient(self, enemy)) {
    foreach(item in enemy.var_d2dbb2fa012e6d9c) {
      if(!isDefined(item)) {
        continue;
      }

      thread function_54532a3f6bfc04e8(item, callback);
    }
  }
}

function function_d138a208396bb595() {
  level endon("game_ended");
  self endon("disconnect");
  self[[self.var_ee280d08e9b9729d]]();
  self notify("ftue_enemy_loot_viewed");
}

function function_54532a3f6bfc04e8(item, callback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ftue_enemy_loot_picked");
  waittill_any("self_pickedupitem_plunder", "self_pickedupitem_weapon", "self_pickedupitem_" + item.type);
  self[[callback]]();
  self notify("ftue_enemy_loot_picked");
}