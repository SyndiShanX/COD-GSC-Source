/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3c775b8df460b415.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_defend_area;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace namespace_9b24ce43;

autoexec __init__system__() {
  system::register(#"hash_678d56e299d40621", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_32cdfeca4a793d78", &on_begin, &on_end);
}

private on_begin() {
  foreach(player in getplayers()) {
    player thread movement_watcher();
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player notify(#"hash_17c41292130032eb");
  }
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_32cdfeca4a793d78");
  return isDefined(challenge);
}

private movement_watcher() {
  self endon(#"disconnect", #"hash_17c41292130032eb");
  wait zm_round_logic::get_delay_between_rounds() - 2;

  while(true) {
    var_89276ce9 = 0;
    var_197c85d1 = self getvelocity();
    n_speed = length(var_197c85d1);
    var_f77522bb = self getnormalizedmovement();

    if(isalive(self) && !self laststand::player_is_in_laststand() && n_speed > 0 && !self zm_utility::is_jumping() && var_f77522bb != (0, 0, 0)) {
      if(isDefined(self.armor) && self.armor > 0) {
        if(!zm_trial_defend_area::is_active() || zm_trial_defend_area::is_active() && isDefined(self.var_ccee13fc) && self.var_ccee13fc) {
          self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
          self dodamage(11, self.origin);
          var_89276ce9 = 1;
        }
      } else if(!zm_trial_defend_area::is_active() || zm_trial_defend_area::is_active() && isDefined(self.var_ccee13fc) && self.var_ccee13fc) {
        self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
        self dodamage(6, self.origin);
        var_89276ce9 = 1;
      }
    }

    if(var_89276ce9) {
      if(zm_trial_defend_area::is_active() && isDefined(self.var_ccee13fc) && self.var_ccee13fc) {
        wait 1;
      } else {
        wait 0.2;
      }

      continue;
    }

    waitframe(1);
  }
}