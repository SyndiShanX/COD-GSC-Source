/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_hud.gsc
*****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_disable_hud;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

private on_begin() {
  level thread function_afe4a356();
}

function_afe4a356() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  wait 12;
  level.var_dc60105c = 1;
  level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 1);

  foreach(player in getplayers()) {
    player showcrosshair(0);
    player playsoundtoplayer(#"hash_79fced3c02a68283", player);
  }
}

private on_end(round_reset) {
  level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 0);
  level.var_dc60105c = undefined;

  if(level flag::get("round_reset") || level flag::get(#"trial_failed")) {
    return;
  }

  foreach(player in getplayers()) {
    player showcrosshair(1);
    player playsoundtoplayer(#"hash_18aab7ffde259877", player);
  }
}