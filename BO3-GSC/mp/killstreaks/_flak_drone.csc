/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_flak_drone.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_helicopter_sounds;
#using scripts\mp\_util;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace flak_drone;

function autoexec __init__sytem__() {
  system::register("flak_drone", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
}

function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;
  if(flags_changed) {
    self duplicate_render::update_dr_filters(localclientnum);
  }
  self notify("endtest");
  self thread doreveal(localclientnum, newval != 0);
}

function doreveal(localclientnum, direction) {
  self notify("endtest");
  self endon("endtest");
  self endon("entityshutdown");
  if(direction) {
    startval = 1;
  } else {
    startval = 0;
  }
  while(startval >= 0 && startval <= 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", startval, 0, 0, 0);
    if(direction) {
      startval = startval - 0.032;
    } else {
      startval = startval + 0.032;
    }
    wait(0.016);
  }
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
  if(flags_changed) {
    self duplicate_render::update_dr_filters(localclientnum);
  }
}