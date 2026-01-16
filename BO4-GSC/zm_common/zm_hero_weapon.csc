/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_hero_weapon.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_hero_weapon;

autoexec __init__system__() {
  system::register(#"zm_hero_weapons", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("clientuimodel", "zmhud.weaponLevel", 1, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.weaponProgression", 1, 5, "float", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter", undefined, 0, 0);
}