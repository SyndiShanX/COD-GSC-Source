/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_perk_up.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\trials\zm_trial_disable_perks;
#include scripts\zm_common\trials\zm_trial_randomize_perks;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_perk_up;

autoexec __init__system__() {
  system::register(#"zm_bgb_perk_up", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_perk_up", "activated", 1, undefined, undefined, &validation, &activation);
}

validation() {
  if(isDefined(self.var_b773066d) && self.var_b773066d) {
    return false;
  }

  if(zm_trial_disable_perks::is_active() || zm_trial_randomize_perks::is_active()) {
    return false;
  }

  if(self zm_perks::function_80cb4982()) {
    return false;
  }

  return true;
}

activation() {
  self endon(#"fake_death", #"death", #"player_downed");

  if(!self laststand::player_is_in_laststand() && self.sessionstate != "spectator") {
    self thread function_183a26f5();

    for(i = 0; i < 4; i++) {
      var_16c042b8 = self zm_perks::function_b2cba45a();

      if(isDefined(var_16c042b8)) {
        self.var_b773066d = 1;
        continue;
      }

      return;
    }
  }
}

function_183a26f5() {
  self notify(#"hash_46621c50b1ffc556");
  self endon(#"hash_46621c50b1ffc556");
  self waittill(#"fake_death", #"player_downed", #"death");

  if(isDefined(self)) {
    self.var_b773066d = undefined;
  }
}