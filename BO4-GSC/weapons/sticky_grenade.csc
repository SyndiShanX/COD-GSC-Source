/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\sticky_grenade.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace sticky_grenade;

autoexec __init__system__() {
  system::register(#"sticky_grenade", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"grenade_light"] = #"weapon/fx8_equip_light_os";
  level._effect[#"hash_61fd92df093ebdb4"] = #"hash_44b0fea08babccac";
  callback::add_weapon_type(#"sticky_grenade", &spawned);
  callback::add_weapon_type(#"eq_sticky_grenade", &spawned);
  callback::add_weapon_type(#"hash_4b92b1a2aa3037f5", &spawned);
  callback::add_weapon_type(#"eq_cluster_semtex_grenade", &spawned);
  callback::add_weapon_type(#"hash_66401df7cd6bf292", &function_6054cc1e);
  callback::add_weapon_type(#"sig_bow_explosive", &function_117f61b8);
  callback::add_weapon_type(#"hash_494e1edad9bd44fd", &function_117f61b8);
  callback::add_weapon_type(#"hash_494e1ddad9bd434a", &function_117f61b8);
  callback::add_weapon_type(#"hash_494e18dad9bd3acb", &function_117f61b8);
  callback::add_weapon_type(#"sig_bow_quickshot", &spawned_arrow);
  callback::add_weapon_type(#"sig_bow_quickshot2", &spawned_arrow);
  callback::add_weapon_type(#"sig_bow_quickshot3", &spawned_arrow);
  callback::add_weapon_type(#"sig_bow_quickshot4", &spawned_arrow);
  callback::add_weapon_type(#"sig_bow_quickshot5", &spawned_arrow);
}

spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  self thread fx_think(localclientnum, 1);
}

spawned_arrow(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  self thread fx_think(localclientnum, 2);
}

function_6054cc1e(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  self thread function_c879d0fd(localclientnum);
}

function_117f61b8(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  handle = self playSound(localclientnum, #"wpn_semtex_countdown");
  self thread stop_sound_on_ent_shutdown(handle);
}

stop_sound_on_ent_shutdown(handle) {
  self waittill(#"death");
  stopsound(handle);
}

fx_think(localclientnum, var_1e60ee48) {
  self notify(#"light_disable");
  self endon(#"light_disable");
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  handle = self playSound(localclientnum, #"wpn_semtex_countdown");
  self thread stop_sound_on_ent_shutdown(handle);

  for(interval = 0.3; isDefined(self); interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
    self stop_light_fx(localclientnum);
    localplayer = function_5c10bd79(localclientnum);

    if(!isDefined(localplayer)) {
      continue;
    }

    if(!localplayer isentitylinkedtotag(self, "j_head") && !localplayer isentitylinkedtotag(self, "j_elbow_le") && !localplayer isentitylinkedtotag(self, "j_spineupper")) {
      self start_light_fx(localclientnum, level._effect[#"grenade_light"]);
    }

    self fullscreen_fx(localclientnum, var_1e60ee48);
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
  }
}

start_light_fx(localclientnum, fx) {
  self stop_light_fx(localclientnum);
  self.fx = util::playFXOnTag(localclientnum, fx, self, "tag_fx");
}

stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}

function_c879d0fd(localclientnum) {
  self notify(#"light_disable");
  self endon(#"light_disable");
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  for(interval = 0.3;; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
    self stop_light_fx(localclientnum);
    self start_light_fx(localclientnum, level._effect[#"hash_61fd92df093ebdb4"]);
    util::server_wait(localclientnum, interval, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
  }
}

sticky_indicator(localclientnum, indicator) {
  controllermodel = getuimodelforcontroller(localclientnum);
  stickyimagemodel = createuimodel(controllermodel, "hudItems.stuckImageIndex");
  setuimodelvalue(stickyimagemodel, indicator);
  player = function_5c10bd79(localclientnum);

  while(isDefined(self)) {
    waitframe(1);
  }

  setuimodelvalue(stickyimagemodel, 0);

  if(isDefined(player)) {
    player notify(#"sticky_shutdown");
  }
}

fullscreen_fx(localclientnum, indicator) {
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

    if(getdvarint(#"ui_hud_hardcore", 0) == 0) {
      self thread sticky_indicator(localclientnum, indicator);
    }
  }
}