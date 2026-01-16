/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_burnplayer.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace burnplayer;

function autoexec __init__sytem__() {
  system::register("burnplayer", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "burn", 1, 1, "int");
  clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

function setplayerburning(duration, interval, damageperinterval, attacker, weapon) {
  self clientfield::set("burn", 1);
  self thread watchburntimer(duration);
  self thread watchburndamage(interval, damageperinterval, attacker, weapon);
  self thread watchforwater();
  self thread watchburnfinished();
  self playloopsound("chr_burn_loop_overlay");
}

function takingburndamage(eattacker, weapon, smeansofdeath) {
  if(isdefined(self.doing_scripted_burn_damage)) {
    self.doing_scripted_burn_damage = undefined;
    return;
  }
  if(weapon == level.weaponnone) {
    return;
  }
  if(weapon.burnduration == 0) {
    return;
  }
  self setplayerburning(weapon.burnduration / 1000, weapon.burndamageinterval / 1000, weapon.burndamage, eattacker, weapon);
}

function watchburnfinished() {
  self endon("disconnect");
  self util::waittill_any("death", "burn_finished");
  self clientfield::set("burn", 0);
  self stoploopsound(1);
}

function watchburntimer(duration) {
  self notify("burnplayer_watchburntimer");
  self endon("burnplayer_watchburntimer");
  self endon("disconnect");
  self endon("death");
  wait(duration);
  self notify("burn_finished");
}

function watchburndamage(interval, damage, attacker, weapon) {
  if(damage == 0) {
    return;
  }
  self endon("disconnect");
  self endon("death");
  self endon("burnplayer_watchburntimer");
  self endon("burn_finished");
  while (true) {
    wait(interval);
    self.doing_scripted_burn_damage = 1;
    self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
    self.doing_scripted_burn_damage = undefined;
  }
}

function watchforwater() {
  self endon("disconnect");
  self endon("death");
  self endon("burn_finished");
  while (true) {
    if(self isplayerunderwater()) {
      self notify("burn_finished");
    }
    wait(0.05);
  }
}