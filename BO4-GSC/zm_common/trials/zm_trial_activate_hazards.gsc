/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_activate_hazards.gsc
**********************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_activate_hazards;

autoexec __init__system__() {
  system::register(#"zm_trial_activate_hazards", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"activate_hazards", &on_begin, &on_end);
}

private on_begin() {
  level.var_2d307e50 = 1;
}

private on_end(round_reset) {
  level.var_2d307e50 = undefined;
}