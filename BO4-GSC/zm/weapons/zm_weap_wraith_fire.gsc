/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_wraith_fire.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_wraith_fire;

autoexec __init__system__() {
  system::register(#"wraith_fire_zm", &__init__, &__main__, undefined);
}

__init__() {
  zm::function_84d343d(#"eq_wraith_fire", &function_36a0ef3);
  zm::function_84d343d(#"eq_wraith_fire_extra", &function_36a0ef3);
  zm::function_84d343d(#"wraith_fire_fire", &function_2b4945e4);
  zm::function_84d343d(#"wraith_fire_fire_small", &function_2b4945e4);
  zm::function_84d343d(#"wraith_fire_fire_tall", &function_2b4945e4);
  zm::function_84d343d(#"wraith_fire_fire_wall", &function_2b4945e4);
  zm::function_84d343d(#"wraith_fire_steam", &function_2b4945e4);
  namespace_9ff9f642::register_burn(#"eq_wraith_fire", 50, 5, "" + #"hash_682f9312e30af478", "" + #"hash_7fcff4f8340f11f7");
  clientfield::register("actor", "" + #"hash_682f9312e30af478", 1, 1, "int");
  clientfield::register("actor", "" + #"hash_7fcff4f8340f11f7", 1, 1, "int");
}

__main__() {
  level.var_c62ed297 = 1;
}

function_36a0ef3(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 0.25, 1);
  var_bb6709b6 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
  return var_bb6709b6;
}

function_2b4945e4(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self namespace_9ff9f642::burn(#"eq_wraith_fire", attacker, getweapon(#"eq_wraith_fire"), 50);
  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 0.25, 1);
  n_damage = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
  return n_damage;
}