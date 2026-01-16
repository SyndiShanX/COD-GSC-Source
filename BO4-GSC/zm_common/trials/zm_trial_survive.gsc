/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_survive.gsc
*************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_survive;

autoexec __init__system__() {
  system::register(#"zm_trial_survive", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"survive", &on_begin, &on_end);
}

private on_begin() {}

private on_end(round_reset) {}