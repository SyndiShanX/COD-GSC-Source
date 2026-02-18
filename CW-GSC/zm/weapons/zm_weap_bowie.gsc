/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_bowie.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_weapons;
#namespace zm_weap_bowie;

function private autoexec __init__system__() {
  system::register(#"bowie_knife", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  zm_loadout::register_melee_weapon_for_level(#"bowie_knife");
}

function private postinit() {
  if(isDefined(level.bowie_cost)) {
    cost = level.bowie_cost;
  } else {
    cost = 3000;
  }

  prompt = # "hash_60606b68e93a29c8";
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

function init() {}