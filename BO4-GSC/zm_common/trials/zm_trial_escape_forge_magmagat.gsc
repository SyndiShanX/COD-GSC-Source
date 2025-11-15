/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_escape_forge_magmagat.gsc
***************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_6c76c1da;

autoexec __init__system__() {
  system::register(#"zm_trial_escape_forge_magmagat", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"forge_magmagat", &on_begin, &on_end);
}

private on_begin() {
  level.var_e60b8c3a = undefined;
  level thread function_a543a954();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  if(!round_reset && !(isDefined(level.var_e60b8c3a) && level.var_e60b8c3a)) {
    zm_trial::fail(#"hash_12f3fd15a168901");
  }

  level.var_e60b8c3a = undefined;
}

private function_a543a954() {
  level endon(#"hash_7646638df88a3656");
  level waittill(#"hash_5dc448a84a24492", #"magma_forge_completed");
  level.var_e60b8c3a = 1;
  zm_trial_util::function_7d32b7d0(1);
}