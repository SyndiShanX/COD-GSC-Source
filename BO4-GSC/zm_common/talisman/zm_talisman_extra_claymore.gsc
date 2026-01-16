/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_extra_claymore.gsc
*************************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;

#namespace zm_talisman_extra_claymore;

autoexec __init__system__() {
  system::register(#"zm_talisman_extra_claymore", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_extra_claymore", &activate_talisman);
}

activate_talisman() {
  callback::on_spawned(&function_4a46cf14);
  self.b_talisman_extra_claymore = 1;
  zm_loadout::register_lethal_grenade_for_level(#"claymore_extra");
}

function_4a46cf14() {
  self endon(#"disconnect");

  if(!(isDefined(self.b_talisman_extra_claymore) && self.b_talisman_extra_claymore)) {
    return;
  }

  level flagsys::wait_till(#"all_players_spawned");

  if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"claymore")) {
    self takeweapon(getweapon(#"claymore"));
    self giveweapon(getweapon(#"claymore_extra"));
  }
}