/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\spike_charge_siegebot.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace spike_charge_siegebot;

function autoexec __init__sytem__() {
  system::register("spike_charge_siegebot", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["spike_charge_siegebot_light"] = "light/fx_light_red_spike_charge_os";
  callback::add_weapon_type("spike_charge_siegebot", & spawned);
  callback::add_weapon_type("spike_charge_siegebot_theia", & spawned);
  callback::add_weapon_type("siegebot_launcher_turret", & spawned);
  callback::add_weapon_type("siegebot_launcher_turret_theia", & spawned);
  callback::add_weapon_type("siegebot_javelin_turret", & spawned);
}

function spawned(localclientnum) {
  self thread fx_think(localclientnum);
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
    self playsound(localclientnum, "wpn_semtex_alert");
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
    interval = math::clamp(interval / 1.2, 0.08, 0.3);
  }
}

function start_light_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  self.fx = playfxontag(localclientnum, level._effect["spike_charge_siegebot_light"], self, "tag_fx");
}

function stop_light_fx(localclientnum) {
  if(isdefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}