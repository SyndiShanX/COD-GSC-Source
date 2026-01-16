/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spknifeork.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_spknifeork;

autoexec __init__system__() {
  system::register(#"spknifeork", &__init__, &__main__, undefined);
}

private __init__() {
  zm_melee_weapon::init(#"spknifeork", #"spknifeork_flourish", 1000, "spknifeork", undefined, "spknifeork", undefined);
  zm::function_84d343d(#"spknifeork", &function_958c4578);
}

private __main__() {
  callback::on_connect(&function_3b1ba6c7);
}

function_3b1ba6c7() {
  self callback::function_33f0ddd3(&function_c6b2d4d8);
}

private function_c6b2d4d8(s_event) {
  if(s_event.event === "give_weapon") {
    if(s_event.weapon === getweapon(#"golden_knife")) {
      level.var_bdba6ee8[s_event.weapon] = 0.1;
      self thread aat::acquire(s_event.weapon);
      return;
    }

    if(s_event.weapon === getweapon(#"spknifeork")) {
      level.var_bdba6ee8[s_event.weapon] = 0.2;
      self thread aat::acquire(s_event.weapon);
    }
  }
}

function_958c4578(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  return 75809;
}