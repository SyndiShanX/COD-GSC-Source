/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_regen.gsc
*******************************************************/

#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace zm_trial_disable_regen;

function private autoexec __init__system__() {
  system::register(#"zm_trial_disable_regen", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_regen", &on_begin, &on_end);
}

function private on_begin() {
  foreach(player in getplayers()) {
    player val::set("trials_disable_regen", "health_regen", 0);
  }
}

function private on_end(round_reset) {
  foreach(player in getplayers()) {
    player val::reset("trials_disable_regen", "health_regen");
  }
}

function is_active(var_34f09024) {
  challenge = zm_trial::function_a36e8c38(#"disable_regen");
  return isDefined(challenge);
}