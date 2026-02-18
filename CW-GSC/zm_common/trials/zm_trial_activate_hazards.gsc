/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_activate_hazards.gsc
**********************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace zm_trial_activate_hazards;

function private autoexec __init__system__() {
  system::register(#"zm_trial_activate_hazards", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"activate_hazards", &on_begin, &on_end);
}

function private on_begin() {
  level.var_2d307e50 = 1;
}

function private on_end(round_reset) {
  level.var_2d307e50 = undefined;
}