/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_speed_burst.csc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_speed_burst;

function autoexec __init__sytem__() {
  system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  clientfield::register("toplayer", "speed_burst", 1, 1, "int", &player_speed_changed, 0, 1);
  visionset_mgr::register_visionset_info("speed_burst", 1, 9, undefined, "speed_burst_initialize");
}

function on_localplayer_spawned(localclientnum) {
  if(self != getlocalplayer(localclientnum)) {
    return;
  }
  filter::init_filter_speed_burst(self);
  filter::disable_filter_speed_burst(self, 3);
}

function player_speed_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self == getlocalplayer(localclientnum)) {
      filter::enable_filter_speed_burst(self, 3);
    }
  } else if(self == getlocalplayer(localclientnum)) {
    filter::disable_filter_speed_burst(self, 3);
  }
}