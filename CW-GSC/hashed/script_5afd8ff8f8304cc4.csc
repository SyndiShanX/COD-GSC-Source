/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5afd8ff8f8304cc4.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#namespace namespace_a476311c;

function private autoexec __init__system__() {
  system::register(#"hash_7ceb08aa364e4596", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_250115340b2e27a5", &on_begin, &on_end);
}

function private on_begin(local_client_num, params) {
  level.var_7db2b064 = &function_ecc5a0b9;
}

function private on_end(local_client_num) {
  level.var_7db2b064 = undefined;
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_250115340b2e27a5");
  return isDefined(challenge);
}

function private function_ecc5a0b9(local_client_num, player, damage) {
  if(int(damage) <= 1) {
    return true;
  }

  return false;
}