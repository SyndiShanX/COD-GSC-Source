/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_free_perk.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_free_perk;

autoexec __init__system__() {
  system::register(#"zm_powerup_free_perk", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("free_perk", &grab_free_perk);

  if(zm_powerups::function_cc33adc8()) {
    str_model = zm_powerups::function_bcfcc27e();
    zm_powerups::add_zombie_powerup("free_perk", str_model, #"zombie_powerup_free_perk", &zm_powerups::func_should_never_drop, 0, 0, 0);
  }
}

grab_free_perk(var_a3878cd) {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate != "spectator") {
      var_16c042b8 = e_player zm_perks::function_b2cba45a();
    }
  }
}