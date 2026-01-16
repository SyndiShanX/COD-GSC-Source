/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_sticky_grenade.gsc
*************************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_equipment;

#namespace sticky_grenade;

autoexec __init__system__() {
  system::register(#"sticky_grenade", &__init__, undefined, undefined);
}

__init__() {
  zm::function_84d343d(#"eq_acid_bomb", &function_140f2522);
  zm::function_84d343d(#"eq_acid_bomb_extra", &function_140f2522);
}

function_140f2522(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_IMPACT") {
    return 0;
  }

  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
  var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
  return var_5d7b4163;
}