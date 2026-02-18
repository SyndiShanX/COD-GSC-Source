/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\spike_charge.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace sticky_grenade;

function private autoexec __init__system__() {
  system::register(#"spike_charge", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._effect[# "spike_light"] = # "weapon/fx_light_spike_launcher";
  callback::add_weapon_type(#"spike_launcher", &spawned);
  callback::add_weapon_type(#"spike_launcher_cpzm", &spawned);
  callback::add_weapon_type(#"spike_charge", &spawned_spike_charge);
}

function spawned(localclientnum) {
  self thread fx_think(localclientnum);
}

function spawned_spike_charge(localclientnum) {
  self thread fx_think(localclientnum);
  self thread spike_detonation(localclientnum);
}

function fx_think(localclientnum) {
  self notify(#"light_disable");
  self endon(#"death");
  self endon(#"light_disable");
  self util::waittill_dobj(localclientnum);

  for(interval = 0.3;; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
    self stop_light_fx(localclientnum);
    self start_light_fx(localclientnum);
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
  }
}

function start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[# "spike_light"], self, "tag_fx");
}

function stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function spike_detonation(localclientnum) {
  spike_position = self.origin;

  while(isDefined(self)) {
    waitframe(1);
  }

  if(!isigcactive(localclientnum)) {
    player = function_5c10bd79(localclientnum);
    explosion_distance = distancesquared(spike_position, player.origin);

    if(explosion_distance <= sqr(450)) {
      player thread postfx::playpostfxbundle(#"pstfx_dust_chalk");
    }

    if(explosion_distance <= sqr(300)) {
      player thread postfx::playpostfxbundle(#"pstfx_dust_concrete");
    }
  }
}