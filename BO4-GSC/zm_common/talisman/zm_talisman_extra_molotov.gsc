/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_extra_molotov.gsc
************************************************************/

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

#namespace zm_talisman_extra_molotov;

autoexec __init__system__() {
  system::register(#"zm_talisman_extra_molotov", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_extra_molotov", &activate_talisman);
}

activate_talisman() {
  callback::on_spawned(&function_94c5165b);
  self.var_ae031eed = 1;
  zm_loadout::register_lethal_grenade_for_level(#"eq_wraith_fire_extra");
}

function_94c5165b() {
  self endon(#"disconnect");

  if(!(isDefined(self.var_ae031eed) && self.var_ae031eed)) {
    return;
  }

  level flagsys::wait_till(#"all_players_spawned");

  if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_wraith_fire")) {
    self takeweapon(getweapon(#"eq_wraith_fire"));
    self giveweapon(getweapon(#"eq_wraith_fire_extra"));
  }
}