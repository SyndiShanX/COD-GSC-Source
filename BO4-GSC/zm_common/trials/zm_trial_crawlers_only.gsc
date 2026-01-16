/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_crawlers_only.gsc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_crawlers_only;

autoexec __init__system__() {
  system::register(#"zm_trial_crawlers_only", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"crawlers_only", &on_begin, &on_end);
}

private on_begin() {
  level.var_6d8a8e47 = 1;
  level.var_153e9058 = 1;
  level.var_fe2bb2ac = 1;
  level.var_5e45f817 = 1;
  level.var_d1b3ec4e = level.var_9b91564e;
  level.var_9b91564e = undefined;
}

private on_end(round_reset) {
  level.var_6d8a8e47 = 0;
  level.var_153e9058 = 0;
  level.var_fe2bb2ac = 0;
  level.var_5e45f817 = 0;
  level.var_9b91564e = level.var_d1b3ec4e;
  level.var_d1b3ec4e = undefined;
}