/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_coagulant.gsc
********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;

#namespace zm_talisman_coagulant;

autoexec __init__system__() {
  system::register(#"zm_talisman_coagulant", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_coagulant", &activate_talisman);
}

activate_talisman() {
  self.var_5c4f1263 = 1.5;
}