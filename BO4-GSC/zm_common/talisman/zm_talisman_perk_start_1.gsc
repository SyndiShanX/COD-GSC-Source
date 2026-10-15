/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_perk_start_1.gsc
***********************************************************/

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

#namespace zm_talisman_perk_start_1;

autoexec __init__system__() {
  system::register(#"zm_talisman_perk_start_1", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_perk_start_1", &activate_talisman);
}

activate_talisman() {
  if(isDefined(self.var_c27f1e90) && zm_custom::function_d9f0defb(self.var_c27f1e90[0])) {
    self.talisman_perk_start_1 = 1;
  }
}