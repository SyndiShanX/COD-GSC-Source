/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_start_weapon_lmg.gsc
***************************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;

#namespace zm_talisman_start_weapon_lmg;

autoexec __init__system__() {
  system::register(#"zm_talisman_start_weapon_lmg", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_custom::function_901b751c(#"zmweaponslmg") || !zm_custom::function_901b751c(#"zmstartingweaponenabled")) {
    return;
  }

  zm_talisman::register_talisman("talisman_start_weapon_lmg", &activate_talisman);
}

activate_talisman() {
  self.talisman_weapon_start = #"lmg_standard_t8";
}