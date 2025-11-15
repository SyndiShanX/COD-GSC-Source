/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_shock.gsc
**************************************************************/

#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;

#namespace status_effect_shock;

autoexec __init__system__() {
  system::register(#"status_effect_shock", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(5, &shock_apply);
  status_effect::function_5bae5120(5, &shock_end);
  status_effect::function_6f4eaf88(getstatuseffect("shock"));
}

shock_apply(var_756fda07, weapon, applicant) {
  if(isDefined(var_756fda07.var_120475e6) ? var_756fda07.var_120475e6 : 0) {
    self.owner setlowready(1);
    self.owner val::set(#"shock", "freezecontrols");
  }

  self.var_52b189ce = 1;

  if(isDefined(var_756fda07)) {
    self.var_52b189ce = isDefined(var_756fda07.var_52b189ce) ? var_756fda07.var_52b189ce : 1;
  }

  if(self.var_52b189ce) {
    self.owner setelectrifiedstate(1);
    self thread shock_rumble_loop(float(self.duration) / 1000);
    self.owner playSound(#"hash_7d53dd7b886b60ae");
  }
}

shock_end() {
  if(isDefined(self)) {
    if(isDefined(self.var_4f6b79a4.var_120475e6) ? self.var_4f6b79a4.var_120475e6 : 0) {
      self.owner setlowready(0);
      self.owner val::reset(#"shock", "freezecontrols");
    }

    if(self.var_52b189ce) {
      self.owner stoprumble("proximity_grenade");
      self.owner setelectrifiedstate(0);
    }
  }
}

private shock_rumble_loop(duration) {
  self notify(#"shock_rumble_loop");
  self endon(#"shock_rumble_loop", #"endstatuseffect");
  self.owner endon(#"disconnect", #"death");
  goaltime = gettime() + int(duration * 1000);

  while(gettime() < goaltime && isDefined(self.owner)) {
    self.owner playrumbleonentity("proximity_grenade");
    wait 1;
  }
}