/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_double_damage.gsc
*******************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;
#namespace zm_trial_double_damage;

function private autoexec __init__system__() {
  system::register(#"zm_trial_double_damage", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"double_damage", &on_begin, &on_end);
}

function private on_begin() {
  self.var_42fe565a = level.var_c739ead9;
  self.var_c98099cd = level.var_cfbc34ae;
  self.var_3ab281b2 = level.var_5a59b382;
  self.var_c7f3b69b = level.var_97850f30;
  level.var_c739ead9 = 2;
  level.var_cfbc34ae = 2;
  level.var_5a59b382 = 2;
  level.var_97850f30 = 2;
}

function private on_end(round_reset) {
  level.var_c739ead9 = self.var_42fe565a;
  level.var_cfbc34ae = self.var_c98099cd;
  level.var_5a59b382 = self.var_3ab281b2;
  level.var_97850f30 = self.var_c7f3b69b;
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"double_damage");
  return isDefined(challenge);
}