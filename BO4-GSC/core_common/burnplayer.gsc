/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\burnplayer.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace burnplayer;

autoexec __init__system__() {
  system::register(#"burnplayer", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("allplayers", "burn", 1, 1, "int");
  clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

setplayerburning(duration, interval, damageperinterval, attacker, weapon) {
  self clientfield::set("burn", 1);
  self thread watchburntimer(duration);
  self thread watchburndamage(interval, damageperinterval, attacker, weapon);
  self thread watchforwater();
  self thread watchburnfinished();
}

takingburndamage(eattacker, weapon, smeansofdeath) {
  if(isDefined(self.doing_scripted_burn_damage)) {
    self.doing_scripted_burn_damage = undefined;
    return;
  }

  if(weapon == level.weaponnone) {
    return;
  }

  if(weapon.burnduration == 0) {
    return;
  }

  self setplayerburning(float(weapon.burnduration) / 1000, float(weapon.burndamageinterval) / 1000, weapon.burndamage, eattacker, weapon);
}

watchburnfinished() {
  self endon(#"disconnect");
  self waittill(#"death", #"burn_finished");
  self clientfield::set("burn", 0);
}

watchburntimer(duration) {
  self notify(#"burnplayer_watchburntimer");
  self endon(#"burnplayer_watchburntimer", #"disconnect", #"death");
  wait duration;
  self notify(#"burn_finished");
}

watchburndamage(interval, damage, attacker, weapon) {
  if(damage == 0) {
    return;
  }

  self endon(#"disconnect", #"death", #"burnplayer_watchburntimer", #"burn_finished");

  while(true) {
    wait interval;
    self.doing_scripted_burn_damage = 1;
    self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
    self.doing_scripted_burn_damage = undefined;
  }
}

watchforwater() {
  self endon(#"disconnect", #"death", #"burn_finished");

  while(true) {
    if(self isplayerunderwater()) {
      self notify(#"burn_finished");
    }

    wait 0.05;
  }
}