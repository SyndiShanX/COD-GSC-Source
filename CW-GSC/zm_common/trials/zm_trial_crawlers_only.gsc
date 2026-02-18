/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_crawlers_only.gsc
*******************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_crawlers_only;

function private autoexec __init__system__() {
  system::register(#"zm_trial_crawlers_only", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"crawlers_only", &on_begin, &on_end);
}

function private on_begin() {
  level.var_6d8a8e47 = 1;
  level.var_b38bb71 = 1;
  level.var_ef0aada0 = 1;
  level.var_d1b3ec4e = level.var_9b91564e;
  level.var_9b91564e = undefined;
}

function private on_end(round_reset) {
  level.var_6d8a8e47 = 0;
  level.var_b38bb71 = 0;
  level.var_ef0aada0 = 0;
  level.var_9b91564e = level.var_d1b3ec4e;
  level.var_d1b3ec4e = undefined;
}