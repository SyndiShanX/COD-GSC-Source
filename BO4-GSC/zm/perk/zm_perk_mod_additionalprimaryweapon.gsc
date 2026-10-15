/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_additionalprimaryweapon.gsc
***********************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_additionalprimaryweapon;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_additionalprimaryweapon", &__init__, undefined, undefined);
}

__init__() {
  enable_additional_primary_weapon_perk_for_level();
}

enable_additional_primary_weapon_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_additionalprimaryweapon", "mod_additionalprimaryweapon", #"perk_additional_primary_weapon", #"specialty_additionalprimaryweapon", 5000);
  zm_perks::register_perk_threads(#"specialty_mod_additionalprimaryweapon", &function_ffa39915, &function_8f205daa);
  zm_perks::function_2ae97a14(#"specialty_mod_additionalprimaryweapon", array(#"specialty_fastweaponswitch"));
}

function_ffa39915() {
  self.var_dd1b11fe = 1;
}

function_8f205daa(b_pause, str_perk, str_result, n_slot) {}

function_69f490a(var_aecb3e98) {
  if(!isDefined(level.var_2bb81f4b)) {
    level.var_2bb81f4b = [];
  } else if(!isarray(level.var_2bb81f4b)) {
    level.var_2bb81f4b = array(level.var_2bb81f4b);
  }

  if(!isDefined(var_aecb3e98)) {
    var_aecb3e98 = [];
  } else if(!isarray(var_aecb3e98)) {
    var_aecb3e98 = array(var_aecb3e98);
  }

  level.var_2bb81f4b = arraycombine(level.var_2bb81f4b, var_aecb3e98, 0, 0);
}

function_23c3c9db(weapon) {
  if(!isDefined(level.var_2bb81f4b)) {
    level.var_2bb81f4b = [];
  } else if(!isarray(level.var_2bb81f4b)) {
    level.var_2bb81f4b = array(level.var_2bb81f4b);
  }

  return !isinarray(level.var_2bb81f4b, weapon);
}