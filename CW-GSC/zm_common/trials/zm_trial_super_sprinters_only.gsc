/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_super_sprinters_only.gsc
**************************************************************/

#using script_444bc5b4fa0fe14f;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_super_sprinters_only;

function private autoexec __init__system__() {
  system::register(#"zm_trial_super_sprinters_only", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"super_sprinters_only", &on_begin, &on_end);
}

function private on_begin() {
  level.var_43fb4347 = "super_sprint";
  level.var_102b1301 = "super_sprint";
  level.var_b38bb71 = 1;
  level.var_ef0aada0 = 1;

  if(namespace_c56530a8::is_active()) {}
}

function private on_end(round_reset) {
  level.var_43fb4347 = undefined;
  level.var_102b1301 = undefined;
  level.var_b38bb71 = 0;
  level.var_ef0aada0 = 0;
}