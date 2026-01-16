/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_sticky_grenade.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace sticky_grenade;

function autoexec __init__sytem__() {
  system::register("sticky_grenade", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["grenade_light"] = "weapon/fx_equip_light_os";
  callback::add_weapon_type("sticky_grenade", & spawned);
}

function spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }
  self thread fx_think(localclientnum);
}

function stop_sound_on_ent_shutdown(handle) {
  self waittill("entityshutdown");
  stopsound(handle);
}

function fx_think(localclientnum) {
  self notify("light_disable");
  self endon("light_disable");
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  handle = self playsound(localclientnum, "wpn_semtex_countdown");
  self thread stop_sound_on_ent_shutdown(handle);
  interval = 0.3;
  for (;;) {
    self stop_light_fx(localclientnum);
    localplayer = getlocalplayer(localclientnum);
    if(!localplayer isentitylinkedtotag(self, "j_head") && !localplayer isentitylinkedtotag(self, "j_elbow_le") && !localplayer isentitylinkedtotag(self, "j_spineupper")) {
      self start_light_fx(localclientnum);
    }
    self fullscreen_fx(localclientnum);
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
    interval = math::clamp(interval / 1.2, 0.08, 0.3);
  }
}

function start_light_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  self.fx = playfxontag(localclientnum, level._effect["grenade_light"], self, "tag_fx");
}

function stop_light_fx(localclientnum) {
  if(isdefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function sticky_indicator(player, localclientnum) {
  controllermodel = getuimodelforcontroller(localclientnum);
  stickyimagemodel = createuimodel(controllermodel, "hudItems.stickyImage");
  setuimodelvalue(stickyimagemodel, "hud_icon_stuck_semtex");
  player thread stick_indicator_watch_early_shutdown(stickyimagemodel);
  while (isdefined(self)) {
    wait(0.016);
  }
  setuimodelvalue(stickyimagemodel, "blacktransparent");
  player notify("sticky_shutdown");
}

function stick_indicator_watch_early_shutdown(stickyimagemodel) {
  self endon("sticky_shutdown");
  self endon("entityshutdown");
  self waittill("player_flashback");
  setuimodelvalue(stickyimagemodel, "blacktransparent");
}

function fullscreen_fx(localclientnum) {
  player = getlocalplayer(localclientnum);
  if(isdefined(player)) {
    if(player getinkillcam(localclientnum)) {
      return;
    }
    if(player util::is_player_view_linked_to_entity(localclientnum)) {
      return;
    }
  }
  if(self isfriendly(localclientnum)) {
    return;
  }
  parent = self getparententity();
  if(isdefined(parent) && parent == player) {
    parent playrumbleonentity(localclientnum, "buzz_high");
    if(getdvarint("ui_hud_hardcore") == 0) {
      self thread sticky_indicator(player, localclientnum);
    }
  }
}