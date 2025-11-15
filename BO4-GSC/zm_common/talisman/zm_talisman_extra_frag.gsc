/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_extra_frag.gsc
*********************************************************/

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

#namespace zm_talisman_extra_frag;

autoexec __init__system__() {
  system::register(#"zm_talisman_extra_frag", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_extra_frag", &activate_talisman);
}

activate_talisman() {
  callback::on_spawned(&function_fbcc1e50);
  self.b_talisman_extra_frag = 1;
  zm_loadout::register_lethal_grenade_for_level(#"eq_frag_grenade_extra");
}

function_fbcc1e50() {
  self endon(#"disconnect");

  if(!(isDefined(self.b_talisman_extra_frag) && self.b_talisman_extra_frag)) {
    return;
  }

  level flagsys::wait_till(#"all_players_spawned");

  if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_frag_grenade")) {
    self takeweapon(getweapon(#"eq_frag_grenade"));
    self giveweapon(getweapon(#"eq_frag_grenade_extra"));
    self zm_loadout::set_player_lethal_grenade(getweapon(#"eq_frag_grenade_extra"));
  }
}