/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_golden_knife.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_golden_knife;

autoexec __init__system__() {
  system::register(#"golden_knife", &__init__, &__main__, undefined);
}

private __init__() {
  zm_melee_weapon::init(#"golden_knife", #"golden_knife_flourish", 1000, "golden_knife", undefined, undefined, undefined);
}

private __main__() {}