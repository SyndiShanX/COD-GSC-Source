/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_weap_ray_gun;

autoexec __init__system__() {
  system::register(#"ray_gun", &__init__, undefined, undefined);
}

__init__() {
  level.var_b21bed72 = [];
  level.var_b21bed72[#"hash_5a4246956faa187e"] = getweapon(#"hash_5a4246956faa187e");
  level.var_b21bed72[#"hash_43989578a576ae26"] = getweapon(#"hash_43989578a576ae26");
  level.var_b21bed72[#"hash_43b39078a58d6d5f"] = getweapon(#"hash_43b39078a58d6d5f");
  arrayremovevalue(level.var_b21bed72, getweapon(#"none"), 1);
  zombie_utility::add_zombie_gib_weapon_callback(#"hash_5a4246956faa187e", &function_215146f5, &function_215146f5);
  zombie_utility::add_zombie_gib_weapon_callback(#"hash_43989578a576ae26", &function_215146f5, &function_215146f5);
  zombie_utility::add_zombie_gib_weapon_callback(#"hash_43b39078a58d6d5f", &function_215146f5, &function_215146f5);

  if(getdvarint(#"raygun_disintegrate", 0)) {
    callback::on_ai_killed(&on_ai_killed);
  }

  clientfield::register("actor", "raygun_disintegrate", 20000, 1, "counter");
}

on_ai_killed(s_params) {
  if(is_ray_gun(s_params.weapon)) {
    self thread ai_disintegrate();
  }
}

ai_disintegrate() {
  self endon(#"death");
  self clientfield::increment("raygun_disintegrate", 1);
  wait 1;
  self delete();
}

is_ray_gun(w_weapon) {
  if(isDefined(w_weapon)) {
    return isinarray(level.var_b21bed72, w_weapon);
  }

  return 0;
}

function_215146f5(damage_percent) {
  return false;
}