/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\spike_charge_siegebot.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace spike_charge_siegebot;

autoexec __init__system__() {
  system::register(#"spike_charge_siegebot", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"spike_charge_siegebot_light"] = #"light/fx_light_red_spike_charge_os";
  callback::add_weapon_type(#"spike_charge_siegebot", &spawned);
  callback::add_weapon_type(#"spike_charge_siegebot_theia", &spawned);
  callback::add_weapon_type(#"siegebot_launcher_turret", &spawned);
  callback::add_weapon_type(#"siegebot_launcher_turret_theia", &spawned);
  callback::add_weapon_type(#"siegebot_javelin_turret", &spawned);
}

spawned(localclientnum) {
  self thread fx_think(localclientnum);
}

fx_think(localclientnum) {
  self notify(#"light_disable");
  self endon(#"death");
  self endon(#"light_disable");
  self util::waittill_dobj(localclientnum);

  for(interval = 0.3;; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
    self stop_light_fx(localclientnum);
    self start_light_fx(localclientnum);
    self playSound(localclientnum, #"wpn_semtex_alert");
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
  }
}

start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[#"spike_charge_siegebot_light"], self, "tag_fx");
}

stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}