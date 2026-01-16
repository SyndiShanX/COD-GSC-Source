/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\explosive_bolt.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace explosive_bolt;

autoexec __init__system__() {
  system::register(#"explosive_bolt", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"crossbow_light"] = #"weapon/fx8_equip_light_os";
  callback::add_weapon_type(#"explosive_bolt", &spawned);
}

spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

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
    self fullscreen_fx(localclientnum);
    self playSound(localclientnum, #"wpn_semtex_alert");
    util::server_wait(localclientnum, interval, 0.016, "player_switch");
  }
}

start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[#"crossbow_light"], self, "tag_origin");
}

stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

fullscreen_fx(localclientnum) {
  if(function_1cbf351b(localclientnum)) {
    return;
  }

  if(util::is_player_view_linked_to_entity(localclientnum)) {
    return;
  }

  if(self function_4e0ca360()) {
    return;
  }

  parent = self getparententity();

  if(isDefined(parent) && parent function_21c0fa55()) {
    parent playrumbleonentity(localclientnum, "buzz_high");
  }
}