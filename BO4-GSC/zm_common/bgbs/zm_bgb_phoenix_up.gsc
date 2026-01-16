/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_phoenix_up.gsc
************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_phoenix_up;

autoexec __init__system__() {
  system::register(#"zm_bgb_phoenix_up", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_phoenix_up", "activated", 1, undefined, undefined, &validation, &activation);
  bgb::register_lost_perk_override(#"zm_bgb_phoenix_up", &lost_perk_override, 1);
}

validation() {
  players = level.players;

  foreach(player in players) {
    if(isDefined(player.var_bdeb0f02) && player.var_bdeb0f02) {
      return false;
    }

    if(isDefined(level.var_7d8a0369) && self[[level.var_7d8a0369]](player, 1, 1)) {
      return true;
    }

    if(self zm_laststand::can_revive(player, 1, 1)) {
      return true;
    }
  }

  return false;
}

activation() {
  playsoundatposition(#"zmb_bgb_phoenix_activate", (0, 0, 0));
  players = level.players;

  foreach(player in players) {
    can_revive = 0;

    if(isDefined(level.var_7d8a0369) && self[[level.var_7d8a0369]](player, 1, 1)) {
      can_revive = 1;
    } else if(self zm_laststand::can_revive(player, 1, 1)) {
      can_revive = 1;
    }

    if(can_revive) {
      player thread bgb::bgb_revive_watcher();
      player zm_laststand::auto_revive(self);
      self zm_stats::increment_challenge_stat(#"gum_gobbler_phoenix_up");
    }
  }
}

lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined) {
  self thread zm_perks::function_b2dfd295(perk, &bgb::function_bd839f2c);
  return false;
}