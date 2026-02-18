/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_bgbs.gsc
******************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_disable_bgbs;

function private autoexec __init__system__() {
  system::register(#"zm_trial_disable_bgbs", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_bgbs", &on_begin, &on_end);
}

function private on_begin() {
  level zm_trial::function_2b3a3307(1);
  level zm_trial::function_19a1098f(1);

  foreach(player in getplayers()) {
    player bgb::take();
    player bgb_pack::function_ac9cb612(1);
  }
}

function private on_end(round_reset) {
  level zm_trial::function_2b3a3307(0);
  level zm_trial::function_19a1098f(0);

  foreach(player in getplayers()) {
    player bgb_pack::function_ac9cb612(0);
  }
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"disable_bgbs");
  return isDefined(challenge);
}