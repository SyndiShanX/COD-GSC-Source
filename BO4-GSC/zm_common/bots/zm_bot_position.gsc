/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bots\zm_bot_position.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_position;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_bot_position;

autoexec __init__system__() {
  system::register(#"zm_bot_position", &__init__, undefined, undefined);
}

__init__() {
  bot_position::function_e9e03d6f(#"zombie_in_combat", &zombie_in_combat);
  bot_position::function_e9e03d6f(#"hash_7cf5d8ae94c74382", &function_6300517d);
  bot_position::function_e9e03d6f(#"hash_26e050bc0c121f1b", &function_a3d8f155);
  bot_position::function_e9e03d6f(#"zombie_interact", &zombie_interact);
  bot_position::function_e9e03d6f(#"zombie_weapon_upgrade", &zombie_weapon_upgrade);
  bot_position::function_aa8c6854(#"zombie_interact", &function_a0b3c01e);
  bot_position::function_aa8c6854(#"zombie_weapon_upgrade", &function_957ba503);
}

zombie_in_combat(params, tacbundle) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  return bot_position::function_d0cf287b(params, tacbundle);
}

function_6300517d(params, tacbundle) {
  if(isDefined(self.enemy)) {
    return 0;
  }

  return bot_position::function_d0cf287b(params, tacbundle);
}

function_a3d8f155(params, tacbundle) {
  allies = [];

  foreach(player in getplayers()) {
    if(player == self) {
      continue;
    }

    if(!isalive(player) || isDefined(player.revivetrigger)) {
      continue;
    }

    if(!isDefined(player.sessionstate) || player.sessionstate != "playing" || self.team != player.team) {
      continue;
    }

    allies[allies.size] = player;
  }

  if(allies.size <= 0) {
    return false;
  }

  closestally = arraygetclosest(self.origin, allies);
  self bot_position::set_position(closestally.origin);
  return true;
}

zombie_interact(params, tacbundle) {
  if(!self bot::function_43a720c7()) {
    return 0;
  }

  return bot_position::function_d0cf287b(params, tacbundle);
}

zombie_weapon_upgrade(params, tacbundle) {
  if(!self bot::function_914feddd()) {
    return 0;
  }

  return bot_position::function_d0cf287b(params, tacbundle);
}

function_a0b3c01e() {
  if(!self bot::function_43a720c7()) {
    return undefined;
  }

  pathfindingradius = self getpathfindingradius();
  interact = self bot::get_interact();

  if(isentity(interact)) {
    return self bot::function_f0c35734(interact);
  }

  if(isDefined(interact.trigger_stub)) {
    return self bot::function_52947b70(interact.trigger_stub);
  } else if(isDefined(interact.unitrigger_stub)) {
    return self bot::function_52947b70(interact.unitrigger_stub);
  }

  return self bot::function_52947b70(interact);
}

function_957ba503() {
  if(!self bot::function_914feddd()) {
    return undefined;
  }

  upgrade = self bot::get_interact();
  return self bot::function_52947b70(upgrade.trigger_stub);
}