/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_kill_with_special.gsc
***********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_kill_with_special;

function private autoexec __init__system__() {
  system::register(#"kill_with_special", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"kill_with_special", &on_begin, &on_end);
}

function private on_begin() {}

function private on_end(round_reset) {
  if(round_reset) {
    foreach(e_player in level.players) {
      e_player gadgetpowerset(level.var_a53a05b5, 100);
    }
  }
}