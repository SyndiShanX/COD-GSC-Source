/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spork.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_spork;

autoexec __init__system__() {
  system::register(#"spork", &__init__, &__main__, undefined);
}

private __init__() {
  zm_melee_weapon::init(#"spork_alcatraz", #"spork_alcatraz_flourish", 1000, "spork", undefined, "spork", undefined);
}

private __main__() {}