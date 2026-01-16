/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_join_the_party.gsc
****************************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_player;

#namespace zm_bgb_join_the_party;

autoexec __init__system__() {
  system::register(#"zm_bgb_join_the_party", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_join_the_party", "activated", 1, undefined, undefined, &validation, &activation);
}

activation() {
  foreach(player in getplayers()) {
    if(player util::is_spectating()) {
      player thread zm_player::spectator_respawn_player();
    }

    can_revive = 0;

    if(isDefined(level.var_a538e6dc) && self[[level.var_a538e6dc]](player, 1, 1)) {
      can_revive = 1;
    } else if(self zm_laststand::can_revive(player, 1, 1)) {
      can_revive = 1;
    }

    if(can_revive) {
      player thread bgb::bgb_revive_watcher();
      player zm_laststand::auto_revive(self);
    }
  }
}

validation() {
  foreach(player in getplayers()) {
    if(player util::is_spectating()) {
      return true;
    }

    if(isDefined(player.var_bdeb0f02) && player.var_bdeb0f02) {
      continue;
    }

    if(isDefined(level.var_a538e6dc) && self[[level.var_a538e6dc]](player, 1, 1)) {
      return true;
    }

    if(self zm_laststand::can_revive(player, 1, 1)) {
      return true;
    }
  }

  return false;
}