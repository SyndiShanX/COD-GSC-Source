/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_crawl_space.gsc
*************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_crawl_space;

autoexec __init__system__() {
  system::register(#"zm_bgb_crawl_space", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_crawl_space", "activated", 1, undefined, undefined, undefined, &activation);
}

activation() {
  a_ai = getaiarray();

  for(i = 0; i < a_ai.size; i++) {
    if(isDefined(a_ai[i]) && isalive(a_ai[i]) && a_ai[i].archetype === #"zombie" && isDefined(a_ai[i].gibdef)) {
      var_aa4b65bc = distancesquared(self.origin, a_ai[i].origin);

      if(var_aa4b65bc < 360000) {
        a_ai[i] zombie_utility::makezombiecrawler();
      }
    }
  }
}