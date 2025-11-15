/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\ability_gadgets.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace ability_gadgets;

autoexec __init__system__() {
  system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 3, "int", undefined, 0, 0);
}