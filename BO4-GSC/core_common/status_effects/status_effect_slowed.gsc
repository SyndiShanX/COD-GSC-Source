/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_slowed.gsc
***************************************************************/

#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_slowed;

autoexec __init__system__() {
  system::register(#"status_effect_slowed", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(2, &slowed_apply);
  status_effect::function_5bae5120(2, &function_6fe78d40);
  status_effect::function_6f4eaf88(getstatuseffect("slowed"));
}

slowed_apply(var_756fda07, weapon, applicant) {
  self.owner.var_a010bd8f = applicant;
  self.owner.var_9060b065 = weapon;

  if(self.owner == applicant) {
    return;
  }

  var_c94d654b = applicant getentitynumber();

  if(!isDefined(self.owner.var_a4332cab)) {
    self.owner.var_a4332cab = [];
  }
}

function_6fe78d40() {
  if(isDefined(self.owner) && isDefined(self.owner.var_a010bd8f) && isDefined(self.owner.var_a010bd8f.var_9d19aa30)) {
    self.owner.var_a010bd8f.var_9d19aa30 = 0;
  }
}