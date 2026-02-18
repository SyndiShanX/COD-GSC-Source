/***************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_slowed.gsc
***************************************************************/

#using scripts\core_common\contracts_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#namespace status_effect_slowed;

function private autoexec __init__system__() {
  system::register(#"status_effect_slowed", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  status_effect::register_status_effect_callback_apply(2, &slowed_apply);
  status_effect::function_5bae5120(2, &function_6fe78d40);
  status_effect::function_6f4eaf88(getstatuseffect("slowed"));
}

function slowed_apply(var_756fda07, weapon, applicant) {
  self.owner.var_23ed81d6 = gettime() + int(var_756fda07.seduration);
  self.owner.var_a010bd8f = applicant;
  self.owner.var_9060b065 = weapon;

  if(!isDefined(applicant) || self.owner == applicant) {
    return;
  }

  var_c94d654b = applicant getentitynumber();
  applicant contracts::increment_contract(#"hash_1745d692d02f23be");

  if(!isDefined(self.owner.var_a4332cab)) {
    self.owner.var_a4332cab = [];
  }
}

function function_6fe78d40() {
  if(isDefined(self.owner) && isDefined(self.owner.var_a010bd8f) && isDefined(self.owner.var_a010bd8f.var_9d19aa30)) {
    self.owner.var_a010bd8f.var_9d19aa30 = 0;
  }
}