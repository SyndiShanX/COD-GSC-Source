/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_free_perk.gsc
***********************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_powerup_free_perk;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_free_perk", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("free_perk", &grab_free_perk);

  if(zm_powerups::function_cc33adc8()) {
    str_model = zm_powerups::function_bcfcc27e();
    zm_powerups::add_zombie_powerup("free_perk", str_model, #"hash_165c84a677f7a58c", &zm_powerups::func_should_never_drop, 0, 0, 0);
  }
}

function grab_free_perk(var_a3878cd) {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate != "spectator") {
      var_16c042b8 = e_player zm_perks::function_b2cba45a();
    }

    if(isDefined(e_player) && isPlayer(e_player) && isDefined(self.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", self.hint);
    }
  }
}