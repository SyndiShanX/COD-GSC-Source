/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\water_surface.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace water_surface;

function private autoexec __init__system__() {
  system::register(#"water_surface", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._effect[# "water_player_jump_out"] = # "player/fx_plyr_water_jump_out_splash_1p";
  level._effect[# "hash_1e7095084eda811c"] = # "hash_123c2521c68b2167";

  if(is_true(level.disablewatersurfacefx)) {
    return;
  }

  callback::on_localplayer_spawned(&localplayer_spawned);
}

function localplayer_spawned(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(is_true(level.disablewatersurfacefx)) {
    return;
  }

  self thread underwaterwatchbegin();
  self thread underwaterwatchend();
}

function underwaterwatchbegin() {
  self notify(#"underwaterwatchbegin");
  self endon(#"underwaterwatchbegin");
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"underwater_begin");

    if(waitresult.is_teleported) {
      continue;
    }

    self thread underwaterbegin();
  }
}

function underwaterwatchend() {
  self notify(#"underwaterwatchend");
  self endon(#"underwaterwatchend");
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"underwater_end");

    if(waitresult.is_teleported) {
      continue;
    }

    self thread underwaterend();
  }
}

function underwaterbegin() {
  self notify(#"water_surface_underwater_begin");
  self endon(#"water_surface_underwater_begin");
  self endon(#"death");
  localclientnum = self getlocalclientnumber();

  if(islocalclientdead(localclientnum) == 0 && !is_true(self.topdowncamera)) {
    self.var_733dd716 = playfxoncamera(localclientnum, level._effect[# "hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));

    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
      self thread postfx::playpostfxbundle(#"pstfx_watertransition");
    }
  }
}

function underwaterend() {
  self notify(#"water_surface_underwater_end");
  self endon(#"water_surface_underwater_end");
  self endon(#"death");
  localclientnum = self getlocalclientnumber();

  if(islocalclientdead(localclientnum) == 0 && !is_true(self.topdowncamera)) {
    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
      self thread postfx::playpostfxbundle(#"pstfx_water_t_out");
    }
  }
}

function startwaterdive() {}

function startwatersheeting() {
  self notify(#"startwatersheeting_singleton");
  self endon(#"startwatersheeting_singleton");
  self endon(#"death");
}

function stop_player_fx(localclient) {
  if(isDefined(localclient.firstperson_water_fx)) {
    localclientnum = localclient getlocalclientnumber();
    stopfx(localclientnum, localclient.firstperson_water_fx);
    localclient.firstperson_water_fx = undefined;
  }

  if(isDefined(localclient.var_733dd716)) {
    localclientnum = localclient getlocalclientnumber();
    stopfx(localclientnum, localclient.var_733dd716);
    localclient.var_733dd716 = undefined;
  }
}