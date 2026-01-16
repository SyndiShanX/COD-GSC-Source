/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_kill_with_special.gsc
***********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_kill_with_special;

autoexec __init__system__() {
  system::register(#"kill_with_special", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"kill_with_special", &on_begin, &on_end);
}

private on_begin() {}

private on_end(round_reset) {
  if(round_reset) {
    foreach(e_player in level.players) {
      e_player gadgetpowerset(level.var_a53a05b5, 100);
    }
  }
}