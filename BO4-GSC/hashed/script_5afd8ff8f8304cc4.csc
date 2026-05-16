/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_5afd8ff8f8304cc4.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#namespace zm_trial_kill_enemies_for_health;

autoexec __init__system__() {
  system::register(#"zm_trial_kill_enemies_for_health", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"kill_enemies_for_health", &on_begin, &on_end);
}

on_begin(local_client_num, params) {
  level.var_7db2b064 = &function_ecc5a0b9;
}

on_end(local_client_num) {
  level.var_7db2b064 = undefined;
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"kill_enemies_for_health");
  return isDefined(challenge);
}

function_ecc5a0b9(local_client_num, player, damage) {
  if(int(damage) <= 1) {
    return true;
  }

  return false;
}