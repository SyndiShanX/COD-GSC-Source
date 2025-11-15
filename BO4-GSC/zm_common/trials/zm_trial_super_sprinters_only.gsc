/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_super_sprinters_only.gsc
**************************************************************/

#include script_444bc5b4fa0fe14f;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_super_sprinters_only;

autoexec __init__system__() {
  system::register(#"zm_trial_super_sprinters_only", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"super_sprinters_only", &on_begin, &on_end);
}

private on_begin() {
  level.var_43fb4347 = "super_sprint";
  level.var_102b1301 = "super_sprint";
  level.var_153e9058 = 1;
  level.var_fe2bb2ac = 1;

  if(!namespace_c56530a8::is_active()) {
    level.var_5e45f817 = 1;
  }
}

private on_end(round_reset) {
  level.var_43fb4347 = undefined;
  level.var_102b1301 = undefined;
  level.var_153e9058 = 0;
  level.var_fe2bb2ac = 0;
  level.var_5e45f817 = 0;
}