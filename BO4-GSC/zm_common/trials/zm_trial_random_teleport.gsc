/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_random_teleport.gsc
*********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_random_teleport;

autoexec __init__system__() {
  system::register(#"zm_trial_random_teleport", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"random_teleport", &on_begin, &on_end);
}

private on_begin(n_min_time, n_max_time) {
  level.var_935c100a = zm_trial::function_5769f26a(n_min_time);
  level.var_33146b2e = zm_trial::function_5769f26a(n_max_time);

  foreach(player in getplayers()) {
    player thread function_6a04c6e6();
  }
}

private on_end(round_reset) {
  level notify(#"hash_34f9cf7500b33c6b");

  foreach(player in getplayers()) {
    player val::reset(#"bgb_anywhere_but_here", "freezecontrols");
    player val::reset(#"bgb_anywhere_but_here", "ignoreme");
  }
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"random_teleport");
  return isDefined(challenge);
}

private function_6a04c6e6() {
  self endon(#"disconnect");
  level endon(#"hash_34f9cf7500b33c6b", #"end_game");

  while(true) {
    wait randomfloatrange(level.var_935c100a, level.var_33146b2e);

    if(isalive(self)) {
      if(self isusingoffhand()) {
        self forceoffhandend();
      }

      self zm_bgb_anywhere_but_here::activation(0);
    }
  }
}