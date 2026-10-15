/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_perkaholic.gsc
************************************************/

#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_disable_perks;
#include scripts\zm_common\trials\zm_trial_randomize_perks;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_perks;

#namespace zm_bgb_perkaholic;

autoexec __init__system__() {
  system::register(#"zm_bgb_perkaholic", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_perkaholic", "activated", 1, undefined, undefined, &validation, &activation);
}

validation() {
  if(isDefined(self.var_1eba264f) && self.var_1eba264f) {
    return false;
  }

  if(zm_trial_disable_perks::is_active() || zm_trial_randomize_perks::is_active()) {
    return false;
  }

  if(self zm_perks::function_80cb4982() && self zm_perks::function_9a0e9d65()) {
    return false;
  }

  return true;
}

activation() {
  self endon(#"fake_death", #"death", #"player_downed");

  if(!self laststand::player_is_in_laststand() && self.sessionstate != "spectator") {
    self zm_perks::function_cc24f525();
    self thread function_cd55a662();

    for(i = 0; i < 6; i++) {
      var_16c042b8 = self zm_perks::function_b2cba45a();

      if(isDefined(var_16c042b8)) {
        self.var_1eba264f = 1;
        continue;
      }

      return;
    }
  }
}

function_cd55a662() {
  self notify(#"hash_764a30e1b90e56f6");
  self endon(#"hash_764a30e1b90e56f6");
  self waittill(#"fake_death", #"player_downed", #"death");

  if(isDefined(self)) {
    self.var_1eba264f = undefined;
  }
}