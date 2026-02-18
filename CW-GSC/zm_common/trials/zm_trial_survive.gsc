/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_survive.gsc
*************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_survive;

function private autoexec __init__system__() {
  system::register(#"zm_trial_survive", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"survive", &on_begin, &on_end);
}

function private on_begin() {}

function private on_end(round_reset) {}