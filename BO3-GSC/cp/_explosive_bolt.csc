/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_explosive_bolt.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace _explosive_bolt;

function main() {
  level._effect["crossbow_light"] = "weapon/fx_equip_light_os";
}

function spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }
  self thread fx_think(localclientnum);
}

function fx_think(localclientnum) {
  self notify("light_disable");
  self endon("entityshutdown");
  self endon("light_disable");
  self util::waittill_dobj(localclientnum);
  interval = 0.3;
  for(;;) {
    self stop_light_fx(localclientnum);
    self start_light_fx(localclientnum);
    self fullscreen_fx(localclientnum);
    self playSound(localclientnum, "wpn_semtex_alert");
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    interval = math::clamp(interval / 1.2, 0.08, 0.3);
  }
}

function start_light_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  self.fx = playFXOnTag(localclientnum, level._effect["crossbow_light"], self, "tag_origin");
}

function stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function fullscreen_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  if(isDefined(player)) {
    if(player util::is_player_view_linked_to_entity(localclientnum)) {
      return;
    }
  }
  if(self util::friend_not_foe(localclientnum)) {
    return;
  }
  parent = self getparententity();
  if(isDefined(parent) && parent == player) {
    parent playrumbleonentity(localclientnum, "buzz_high");
  }
}