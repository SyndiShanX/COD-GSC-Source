/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_regen.gsc
*******************************************************/

#include scripts\core_common\player\player_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_regen;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_regen", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_regen", &on_begin, &on_end);
}

private on_begin() {
  foreach(player in getplayers()) {
    player val::set("trials_disable_regen", "health_regen", 0);
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player val::reset("trials_disable_regen", "health_regen");
  }
}

is_active(var_34f09024 = 0) {
  challenge = zm_trial::function_a36e8c38(#"disable_regen");
  return isDefined(challenge);
}