/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_turn_on_power.gsc
*******************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_turn_on_power;

autoexec __init__system__() {
  system::register(#"zm_trial_turn_on_power", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"turn_on_power", &on_begin, &on_end);
}

private on_begin(weapon_name) {
  zm_trial_util::function_7d32b7d0(0);
  level thread function_83b71e7c();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  if(!round_reset) {
    if(!level flag::get(level.var_5bfd847e)) {
      if(zm_utility::get_story() == 1) {
        zm_trial::fail(#"hash_ad3c47f53414b85");
        return;
      }

      zm_trial::fail(#"hash_765b6a6e9523c15a");
    }
  }
}

private function_83b71e7c() {
  level endon(#"hash_7646638df88a3656");
  self endon(#"death");

  while(true) {
    level flag::wait_till(level.var_5bfd847e);
    zm_trial_util::function_7d32b7d0(1);
    level flag::wait_till_clear(level.var_5bfd847e);
    zm_trial_util::function_7d32b7d0(0);
  }
}