/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\explosive_bolt.csc
***********************************************/

#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace explosive_bolt;

function main() {
  level._effect[#"crossbow_light"] = # "weapon/fx8_equip_light_os";
}

function spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  self thread fx_think(localclientnum);
}

function fx_think(localclientnum) {
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

function start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[#"crossbow_light"], self, "tag_origin");
}

function stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function fullscreen_fx(localclientnum) {
  if(util::is_player_view_linked_to_entity(localclientnum)) {
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