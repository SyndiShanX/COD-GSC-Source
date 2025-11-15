/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\water_surface.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace water_surface;

function autoexec __init__sytem__() {
  system::register("water_surface", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["water_player_jump_in"] = "player/fx_plyr_water_jump_in_bubbles_1p";
  level._effect["water_player_jump_out"] = "player/fx_plyr_water_jump_out_splash_1p";
  if(isDefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
    return;
  }
  callback::on_localplayer_spawned( & localplayer_spawned);
}

function localplayer_spawned(localclientnum) {
  if(self != getlocalplayer(localclientnum)) {
    return;
  }
  if(isDefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
    return;
  }
  filter::init_filter_water_sheeting(self);
  filter::init_filter_water_dive(self);
  self thread underwaterwatchbegin();
  self thread underwaterwatchend();
  filter::disable_filter_water_sheeting(self, 1);
  stop_player_fx(self);
}

function underwaterwatchbegin() {
  self notify("underwaterwatchbegin");
  self endon("underwaterwatchbegin");
  self endon("entityshutdown");
  while(true) {
    self waittill("underwater_begin", teleported);
    if(teleported) {
      filter::disable_filter_water_sheeting(self, 1);
      stop_player_fx(self);
      filter::disable_filter_water_dive(self, 1);
      stop_player_fx(self);
    } else {
      self thread underwaterbegin();
    }
  }
}

function underwaterwatchend() {
  self notify("underwaterwatchend");
  self endon("underwaterwatchend");
  self endon("entityshutdown");
  while(true) {
    self waittill("underwater_end", teleported);
    if(teleported) {
      filter::disable_filter_water_sheeting(self, 1);
      stop_player_fx(self);
      filter::disable_filter_water_dive(self, 1);
      stop_player_fx(self);
    } else {
      self thread underwaterend();
    }
  }
}

function underwaterbegin() {
  self notify("water_surface_underwater_begin");
  self endon("water_surface_underwater_begin");
  self endon("entityshutdown");
  localclientnum = self getlocalclientnumber();
  filter::disable_filter_water_sheeting(self, 1);
  stop_player_fx(self);
  if(islocalclientdead(localclientnum) == 0) {
    self.firstperson_water_fx = playfxoncamera(localclientnum, level._effect["water_player_jump_in"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
      self thread postfx::playpostfxbundle("pstfx_watertransition");
    }
  }
}

function underwaterend() {
  self notify("water_surface_underwater_end");
  self endon("water_surface_underwater_end");
  self endon("entityshutdown");
  localclientnum = self getlocalclientnumber();
  if(islocalclientdead(localclientnum) == 0) {
    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
      self thread postfx::playpostfxbundle("pstfx_water_t_out");
    }
  }
}

function startwaterdive() {
  filter::enable_filter_water_dive(self, 1);
  filter::set_filter_water_scuba_dive_speed(self, 1, 0.25);
  filter::set_filter_water_wash_color(self, 1, 0.16, 0.5, 0.9);
  filter::set_filter_water_wash_reveal_dir(self, 1, -1);
  i = 0;
  while(i < 0.05) {
    filter::set_filter_water_dive_bubbles(self, 1, i / 0.05);
    wait(0.01);
    i = i + 0.01;
  }
  filter::set_filter_water_dive_bubbles(self, 1, 1);
  filter::set_filter_water_scuba_bubble_attitude(self, 1, -1);
  filter::set_filter_water_scuba_bubbles(self, 1, 1);
  filter::set_filter_water_wash_reveal_dir(self, 1, 1);
  i = 0.2;
  while(i > 0) {
    filter::set_filter_water_dive_bubbles(self, 1, i / 0.2);
    wait(0.01);
    i = i - 0.01;
  }
  filter::set_filter_water_dive_bubbles(self, 1, 0);
  wait(0.1);
  i = 0.2;
  while(i > 0) {
    filter::set_filter_water_scuba_bubbles(self, 1, i / 0.2);
    wait(0.01);
    i = i - 0.01;
  }
}

function startwatersheeting() {
  self notify("startwatersheeting_singleton");
  self endon("startwatersheeting_singleton");
  self endon("entityshutdown");
  filter::enable_filter_water_sheeting(self, 1);
  filter::set_filter_water_sheet_reveal(self, 1, 1);
  filter::set_filter_water_sheet_speed(self, 1, 1);
  i = 2;
  while(i > 0) {
    filter::set_filter_water_sheet_reveal(self, 1, i / 2);
    filter::set_filter_water_sheet_speed(self, 1, i / 2);
    rivulet1 = (i / 2) - 0.19;
    rivulet2 = (i / 2) - 0.13;
    rivulet3 = (i / 2) - 0.07;
    filter::set_filter_water_sheet_rivulet_reveal(self, 1, rivulet1, rivulet2, rivulet3);
    wait(0.01);
    i = i - 0.01;
  }
  filter::set_filter_water_sheet_reveal(self, 1, 0);
  filter::set_filter_water_sheet_speed(self, 1, 0);
  filter::set_filter_water_sheet_rivulet_reveal(self, 1, 0, 0, 0);
}

function stop_player_fx(localclient) {
  if(isDefined(localclient.firstperson_water_fx)) {
    localclientnum = localclient getlocalclientnumber();
    stopfx(localclientnum, localclient.firstperson_water_fx);
    localclient.firstperson_water_fx = undefined;
  }
}