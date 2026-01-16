/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_wound.gsc
**************************************************************/

#include scripts\core_common\player\player_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_wound;

autoexec __init__system__() {
  system::register(#"status_effect_wound", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(6, &wound_apply);
  status_effect::function_5bae5120(6, &wound_end);
  status_effect::function_6f4eaf88(getstatuseffect("wound"));
}

wound_apply(var_756fda07, weapon, applicant) {
  self.var_f031d238 = var_756fda07.var_6406d0cd;
  self.var_4a3f5865 = var_756fda07.var_18d16a6b;

  if(!isDefined(var_756fda07.var_752c0834)) {
    return;
  }

  healthreduction = var_756fda07.var_752c0834;

  if(self.owner.maxhealth - healthreduction < var_756fda07.var_8ea635df) {
    healthreduction = self.owner.maxhealth - var_756fda07.var_8ea635df;
  }

  var_da1d7911 = [];
  var_da1d7911[0] = {
    #name: "cleanse_buff", 
    #var_b861a047: undefined
  };

  if(self.owner.health > 0) {
    self.owner player::function_2a67df65(self.var_4a3f5865, healthreduction * -1, var_da1d7911);
  }

  self.var_18d16a6b = var_756fda07.var_18d16a6b;

  if(self.owner.health > self.owner.var_66cb03ad) {
    var_1a197232 = !isDefined(self.owner.var_abe2db87);

    if(var_1a197232) {
      self.owner.health = self.owner.var_66cb03ad;
    }
  }

  if(self.endtime > 0) {
    self thread function_f6fec56f();
    self thread function_a54d41f7(self.endtime - self.duration);
  }
}

function_a54d41f7(starttime) {
  self notify(#"hash_77a943337c92549a");
  self endon(#"hash_77a943337c92549a", #"endstatuseffect");

  for(var_1420e67b = self.endtime; self.endtime > gettime(); var_1420e67b = self.endtime) {
    waitframe(1);

    if(self.endtime != var_1420e67b) {
      timesincestart = gettime() - starttime;
      self.owner function_eb1cd20(starttime, self.duration + timesincestart, self.namehash);
    }
  }
}

private function_f6fec56f() {
  self notify(#"hash_35c63d8ef4b4825");
  self endon(#"hash_35c63d8ef4b4825", #"endstatuseffect");

  while(true) {
    waitresult = self.owner waittill(#"fully_healed", #"death", #"disconnect", #"healing_disabled");

    if(waitresult._notify != "fully_healed") {
      return;
    }

    if(isDefined(self.var_f031d238)) {
      self.owner playsoundtoplayer(self.var_f031d238, self.owner);
    }
  }
}

wound_end() {
  self.owner player::function_b933de24(self.var_4a3f5865);
}