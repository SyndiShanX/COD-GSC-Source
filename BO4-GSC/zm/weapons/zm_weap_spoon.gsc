/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spoon.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_spoon;

autoexec __init__system__() {
  system::register(#"spoon", &__init__, &__main__, undefined);
}

private __init__() {
  zm_melee_weapon::init(#"spoon_alcatraz", #"spoon_alcatraz_flourish", 1000, "spoon", undefined, "spoon", undefined);
}

private __main__() {}