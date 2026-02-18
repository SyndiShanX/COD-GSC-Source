/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\burnplayer.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace burnplayer;

function private autoexec __init__system__() {
  system::register(#"burnplayer", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "burn", 1, 1, "int");
  clientfield::register("allplayers", "burn_fx_3p", 11001, 1, "int");
  clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

function setplayerburning(duration, interval, damageperinterval, attacker, weapon, var_852d429a = 0) {
  self clientfield::set("burn", 1);

  if(is_true(var_852d429a)) {
    self clientfield::set("burn_fx_3p", 1);
  }

  self thread watchburntimer(duration);
  self thread watchburndamage(interval, damageperinterval, attacker, weapon);
  self thread watchforwater();
  self thread watchburnfinished();
}

function takingburndamage(eattacker, weapon, smeansofdeath) {
  if(isDefined(self.doing_scripted_burn_damage)) {
    self.doing_scripted_burn_damage = undefined;
    return;
  }

  if(smeansofdeath == level.weaponnone) {
    return;
  }

  if(smeansofdeath.burnduration == 0) {
    return;
  }

  self setplayerburning(float(smeansofdeath.burnduration) / 1000, float(smeansofdeath.burndamageinterval) / 1000, smeansofdeath.burndamage, weapon, smeansofdeath);
}

function watchburnfinished() {
  self endon(#"disconnect");
  self waittill(#"death", #"burn_finished");
  self clientfield::set("burn", 0);
  self clientfield::set("burn_fx_3p", 0);
}

function watchburntimer(duration) {
  self notify(#"burnplayer_watchburntimer");
  self endon(#"burnplayer_watchburntimer", #"disconnect", #"death");
  wait duration;
  self notify(#"burn_finished");
}

function watchburndamage(interval, damage, attacker, weapon) {
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

function watchforwater() {
  self endon(#"disconnect", #"death", #"burn_finished");

  while(true) {
    if(self isplayerunderwater()) {
      self notify(#"burn_finished");
    }

    wait 0.05;
  }
}