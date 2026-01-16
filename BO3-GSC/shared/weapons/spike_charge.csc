/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\spike_charge.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace sticky_grenade;

function autoexec __init__sytem__() {
  system::register("spike_charge", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["spike_light"] = "weapon/fx_light_spike_launcher";
  callback::add_weapon_type("spike_launcher", & spawned);
  callback::add_weapon_type("spike_launcher_cpzm", & spawned);
  callback::add_weapon_type("spike_charge", & spawned_spike_charge);
}

function spawned(localclientnum) {
  self thread fx_think(localclientnum);
}

function spawned_spike_charge(localclientnum) {
  self thread fx_think(localclientnum);
  self thread spike_detonation(localclientnum);
}

function fx_think(localclientnum) {
  self notify("light_disable");
  self endon("entityshutdown");
  self endon("light_disable");
  self util::waittill_dobj(localclientnum);
  interval = 0.3;
  for (;;) {
    self stop_light_fx(localclientnum);
    self start_light_fx(localclientnum);
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
    interval = math::clamp(interval / 1.2, 0.08, 0.3);
  }
}

function start_light_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  self.fx = playfxontag(localclientnum, level._effect["spike_light"], self, "tag_fx");
}

function stop_light_fx(localclientnum) {
  if(isdefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function spike_detonation(localclientnum) {
  spike_position = self.origin;
  while (isdefined(self)) {
    wait(0.016);
  }
  if(!isigcactive(localclientnum)) {
    player = getlocalplayer(localclientnum);
    explosion_distance = distancesquared(spike_position, player.origin);
    if(explosion_distance <= (450 * 450)) {
      player thread postfx::playpostfxbundle("pstfx_dust_chalk");
    }
    if(explosion_distance <= (300 * 300)) {
      player thread postfx::playpostfxbundle("pstfx_dust_concrete");
    }
  }
}