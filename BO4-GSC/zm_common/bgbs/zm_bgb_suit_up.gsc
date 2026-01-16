/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_suit_up.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_armor;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_suit_up;

autoexec __init__system__() {
  system::register(#"zm_bgb_suit_up", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_suit_up", "activated", 1, undefined, undefined, &validation, &activation);
  zm_armor::register(#"hash_7bfec2f0ecb46104", 1);
}

validation() {
  if(self zm_armor::get(#"hash_7bfec2f0ecb46104") == 100) {
    return false;
  }

  return !(isDefined(self bgb::get_active()) && self bgb::get_active());
}

activation() {
  foreach(player in getplayers()) {
    if(self === player || !player laststand::player_is_in_laststand() && isalive(player) && distance2dsquared(player.origin, self.origin) < 250000) {
      player zm_armor::remove(#"hash_7bfec2f0ecb46104", 1);
      player zm_armor::add(#"hash_7bfec2f0ecb46104", 100, 100);
    }
  }
}