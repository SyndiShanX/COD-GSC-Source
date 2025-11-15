/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_sticky_grenade.csc
*************************************************/

#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace sticky_grenade;

autoexec __init__system__() {
  system::register(#"sticky_grenade", undefined, &__main__, undefined);
}

__main__() {
  level._effect[#"grenade_light"] = #"weapon/fx8_equip_light_os";
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
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
  }
}

start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
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
  } else if(util::is_player_view_linked_to_entity(localclientnum)) {
    return;
  }

  if(self function_e9fc6a64()) {
    return;
  }

  parent = self getparententity();

  if(isDefined(parent) && parent function_21c0fa55()) {
    parent playrumbleonentity(localclientnum, "buzz_high");
  }
}