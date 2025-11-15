/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\water_surface.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace water_surface;

autoexec __init__system__() {
  system::register(#"water_surface", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"water_player_jump_out"] = #"player/fx_plyr_water_jump_out_splash_1p";
  level._effect[#"hash_1e7095084eda811c"] = #"hash_123c2521c68b2167";

  if(isDefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
    return;
  }

  callback::on_localplayer_spawned(&localplayer_spawned);
}

localplayer_spawned(localclientnum) {
  if(!self function_21c0fa55()) {
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

underwaterwatchbegin() {
  self notify(#"underwaterwatchbegin");
  self endon(#"underwaterwatchbegin");
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"underwater_begin");

    if(waitresult.is_teleported) {
      filter::disable_filter_water_sheeting(self, 1);
      stop_player_fx(self);
      filter::disable_filter_water_dive(self, 1);
      stop_player_fx(self);
      continue;
    }

    self thread underwaterbegin();
  }
}

underwaterwatchend() {
  self notify(#"underwaterwatchend");
  self endon(#"underwaterwatchend");
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"underwater_end");

    if(waitresult.is_teleported) {
      filter::disable_filter_water_sheeting(self, 1);
      stop_player_fx(self);
      filter::disable_filter_water_dive(self, 1);
      stop_player_fx(self);
      continue;
    }

    self thread underwaterend();
  }
}

underwaterbegin() {
  self notify(#"water_surface_underwater_begin");
  self endon(#"water_surface_underwater_begin");
  self endon(#"death");
  localclientnum = self getlocalclientnumber();
  filter::disable_filter_water_sheeting(self, 1);
  stop_player_fx(self);

  if(islocalclientdead(localclientnum) == 0) {
    self.var_733dd716 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));

    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
      self thread postfx::playpostfxbundle(#"pstfx_watertransition");
    }
  }
}

underwaterend() {
  self notify(#"water_surface_underwater_end");
  self endon(#"water_surface_underwater_end");
  self endon(#"death");
  localclientnum = self getlocalclientnumber();

  if(islocalclientdead(localclientnum) == 0) {
    if(!isDefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
      self thread postfx::playpostfxbundle(#"pstfx_water_t_out");
    }
  }
}

startwaterdive() {
  filter::enable_filter_water_dive(self, 1);
  filter::set_filter_water_scuba_dive_speed(self, 1, 0.25);
  filter::set_filter_water_wash_color(self, 1, 0.16, 0.5, 0.9);
  filter::set_filter_water_wash_reveal_dir(self, 1, -1);
  i = 0;

  while(i < 0.05) {
    filter::set_filter_water_dive_bubbles(self, 1, i / 0.05);
    wait 0.01;
    i += 0.01;
  }

  filter::set_filter_water_dive_bubbles(self, 1, 1);
  filter::set_filter_water_scuba_bubble_attitude(self, 1, -1);
  filter::set_filter_water_scuba_bubbles(self, 1, 1);
  filter::set_filter_water_wash_reveal_dir(self, 1, 1);
  i = 0.2;

  while(i > 0) {
    filter::set_filter_water_dive_bubbles(self, 1, i / 0.2);
    wait 0.01;
    i -= 0.01;
  }

  filter::set_filter_water_dive_bubbles(self, 1, 0);
  wait 0.1;
  i = 0.2;

  while(i > 0) {
    filter::set_filter_water_scuba_bubbles(self, 1, i / 0.2);
    wait 0.01;
    i -= 0.01;
  }
}

startwatersheeting() {
  self notify(#"startwatersheeting_singleton");
  self endon(#"startwatersheeting_singleton");
  self endon(#"death");
  filter::enable_filter_water_sheeting(self, 1);
  filter::set_filter_water_sheet_reveal(self, 1, 1);
  filter::set_filter_water_sheet_speed(self, 1, 1);
  i = 2;

  while(i > 0) {
    filter::set_filter_water_sheet_reveal(self, 1, i / 2);
    filter::set_filter_water_sheet_speed(self, 1, i / 2);
    rivulet1 = i / 2 - 0.19;
    rivulet2 = i / 2 - 0.13;
    rivulet3 = i / 2 - 0.07;
    filter::set_filter_water_sheet_rivulet_reveal(self, 1, rivulet1, rivulet2, rivulet3);
    wait 0.01;
    i -= 0.01;
  }

  filter::set_filter_water_sheet_reveal(self, 1, 0);
  filter::set_filter_water_sheet_speed(self, 1, 0);
  filter::set_filter_water_sheet_rivulet_reveal(self, 1, 0, 0, 0);
}

stop_player_fx(localclient) {
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