/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_blind.gsc
**************************************************************/

#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace status_effect_blind;

autoexec __init__system__() {
  system::register(#"status_effect_blind", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(1, &blind_apply);
  status_effect::function_5bae5120(1, &function_8a261309);
  status_effect::function_6f4eaf88(getstatuseffect("blind"));
}

blind_apply(var_756fda07, weapon, applicant) {
  self.owner.flashendtime = gettime() + var_756fda07.seduration;
  self.owner.lastflashedby = applicant;

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
      if(isDefined(level.playgadgetsuccess)) {
        self.owner.var_ef9b6f0b = 1;
        level notify(#"hash_ac034f4f7553641");
        applicant.var_a467e27f = (isDefined(applicant.var_a467e27f) ? applicant.var_a467e27f : 0) + 1;

        if(isDefined(level.var_ac6052e9)) {
          var_9194a036 = [
            [level.var_ac6052e9]
          ]("swatGrenadeSuccessLineCount", 0);
        }

        if(applicant.var_a467e27f == (isDefined(var_9194a036) ? var_9194a036 : 0)) {
          applicant thread[[level.playgadgetsuccess]](getweapon(#"hash_3f62a872201cd1ce"), undefined, self.owner, undefined);
        }
      }
    }

    blindarray[var_c94d654b] = gettime();
  }
}

private function_8a261309() {
  if(isDefined(self.owner) && isDefined(self.owner.lastflashedby) && isDefined(self.owner.lastflashedby.var_a467e27f)) {
    self.owner.lastflashedby.var_a467e27f = 0;
  }

  if(isDefined(self.owner)) {
    self.owner.var_ef9b6f0b = 0;
  }
}