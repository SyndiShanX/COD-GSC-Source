/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_flag_check.gsc
****************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_flag_check;

autoexec __init__system__() {
  system::register(#"zm_trial_flag_check", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"flag_check", &on_begin, &on_end);
}

private on_begin(str_flag, var_60bdad5f) {
  zm_trial_util::function_7d32b7d0(0);
  level.var_5fccce01 = str_flag;
  level.var_4ce2a315 = var_60bdad5f;
  level thread monitor_flag(str_flag);
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  if(!round_reset) {
    if(!level flag::get(level.var_5fccce01)) {
      zm_trial::fail(level.var_4ce2a315);
    }
  }
}

private monitor_flag(str_flag) {
  level endon(#"hash_7646638df88a3656");

  while(true) {
    level flag::wait_till(str_flag);
    zm_trial_util::function_7d32b7d0(1);
    level flag::wait_till_clear(str_flag);
    zm_trial_util::function_7d32b7d0(0);
  }
}