/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_double_damage.gsc
*******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_double_damage;

autoexec __init__system__() {
  system::register(#"zm_trial_double_damage", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"double_damage", &on_begin, &on_end);
}

private on_begin() {
  self.var_42fe565a = level.var_c739ead9;
  self.var_8271882d = level.var_4d7e8b66;
  self.var_ecdf7fbe = level.var_1bb1a2fb;
  self.var_103c25d7 = level.var_5db2341c;
  self.var_97881ccb = level.var_53c7ca1d;
  level.var_c739ead9 = 2;
  level.var_4d7e8b66 = 2;
  level.var_1bb1a2fb = 2;
  level.var_5db2341c = 2;
  level.var_53c7ca1d = 2;
}

private on_end(round_reset) {
  level.var_c739ead9 = self.var_42fe565a;
  level.var_4d7e8b66 = self.var_8271882d;
  level.var_1bb1a2fb = self.var_ecdf7fbe;
  level.var_5db2341c = self.var_103c25d7;
  level.var_53c7ca1d = self.var_97881ccb;
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"double_damage");
  return isDefined(challenge);
}