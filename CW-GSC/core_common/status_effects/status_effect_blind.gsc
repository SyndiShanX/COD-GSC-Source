/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_blind.gsc
**************************************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\battlechatter;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace status_effect_blind;

function private autoexec __init__system__() {
  system::register(#"status_effect_blind", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  status_effect::register_status_effect_callback_apply(1, &blind_apply);
  status_effect::function_5bae5120(1, &function_8a261309);
  status_effect::function_6f4eaf88(getstatuseffect("blind"));
}

function blind_apply(var_756fda07, weapon, applicant) {
  self.owner.flashendtime = gettime() + int(var_756fda07.seduration);
  self.owner.lastflashedby = applicant;
  self.owner.var_ba6bbd30 = weapon;

  if(self.owner == applicant) {
    return;
  }

  var_c94d654b = applicant getentitynumber();

  if(!isDefined(self.owner.var_b68518ab)) {
    self.owner.var_b68518ab = [];
  }

  blindarray = self.owner.var_b68518ab;

  if(!isDefined(blindarray[var_c94d654b])) {
    blindarray[var_c94d654b] = 0;
  }

  if(isDefined(blindarray[var_c94d654b]) && blindarray[var_c94d654b] + 3000 < gettime()) {
    if(isDefined(weapon) && weapon == getweapon(#"hash_3f62a872201cd1ce")) {
      self.owner.var_ef9b6f0b = 1;
      level notify(#"hash_ac034f4f7553641");
      applicant.var_a467e27f = (isDefined(applicant.var_a467e27f) ? applicant.var_a467e27f : 0) + 1;
      var_9194a036 = battlechatter::mpdialog_value("swatGrenadeSuccessLineCount", 0);

      if(applicant.var_a467e27f == (isDefined(var_9194a036) ? var_9194a036 : 0)) {
        applicant thread battlechatter::play_gadget_success(getweapon(#"hash_3f62a872201cd1ce"), undefined, self.owner, undefined);
      }
    }

    applicant contracts::increment_contract(#"hash_5cee5b018e1ab50e");
    blindarray[var_c94d654b] = gettime();
  }
}

function private function_8a261309() {
  if(isDefined(self.owner) && isDefined(self.owner.lastflashedby) && isDefined(self.owner.lastflashedby.var_a467e27f)) {
    self.owner.lastflashedby.var_a467e27f = 0;
  }

  if(isDefined(self.owner)) {
    self.owner.var_ef9b6f0b = 0;
  }
}