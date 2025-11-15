/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spear_shield.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_spear_shield;

autoexec __init__system__() {
  system::register(#"zm_weap_spear_shield", &__init__, &__main__, undefined);
}

__init__() {
  level.var_96059a93 = getweapon(#"zhield_zpear_dw");
  level.var_85ed93f4 = getweapon(#"zhield_zpear_lh");
  level.var_ce3aa8a8 = getweapon(#"zhield_zpear_turret");
}

__main__() {}