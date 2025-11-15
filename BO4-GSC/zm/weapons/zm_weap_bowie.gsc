/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_bowie.gsc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_bowie;

autoexec __init__system__() {
  system::register(#"bowie_knife", &__init__, &__main__, undefined);
}

private __init__() {
  zm_loadout::register_melee_weapon_for_level(#"bowie_knife");
}

private __main__() {
  if(isDefined(level.bowie_cost)) {
    cost = level.bowie_cost;
  } else {
    cost = 3000;
  }

  if(function_8b1a219a()) {
    prompt = #"hash_2791ecebb85142c4";
  } else {
    prompt = #"hash_60606b68e93a29c8";
  }

  level.var_8e4168e9 = "bowie_knife";
  level.var_63af3e00 = "bowie_flourish";
  var_57858dd5 = "zombie_fists_bowie";

  if(zm_maptable::get_story() == 1) {
    level.var_8e4168e9 = "bowie_knife_story_1";
    level.var_63af3e00 = "bowie_flourish_story_1";
    var_57858dd5 = "zombie_fists_bowie_story_1";
  }

  zm_melee_weapon::init(level.var_8e4168e9, level.var_63af3e00, cost, "bowie_upgrade", prompt, "bowie", undefined);
  zm_melee_weapon::set_fallback_weapon(level.var_8e4168e9, var_57858dd5);
  level.w_bowie_knife = getweapon(hash(level.var_8e4168e9));
}

init() {}