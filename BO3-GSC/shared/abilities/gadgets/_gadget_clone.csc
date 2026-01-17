/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_clone.csc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\abilities\gadgets\_gadget_clone_render;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_clone;

function autoexec __init__sytem__() {
  system::register("gadget_clone", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "clone_activated", 1, 1, "int", &clone_activated, 0, 1);
  clientfield::register("actor", "clone_damaged", 1, 1, "int", &clone_damaged, 0, 0);
  clientfield::register("allplayers", "clone_activated", 1, 1, "int", &player_clone_activated, 0, 0);
}

function set_shader(localclientnum, enabled, entity) {
  if(entity isfriendly(localclientnum)) {
    self duplicate_render::update_dr_flag(localclientnum, "clone_ally_on", enabled);
  } else {
    self duplicate_render::update_dr_flag(localclientnum, "clone_enemy_on", enabled);
  }
}

function clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self._isclone = 1;
    self set_shader(localclientnum, 1, self getowner(localclientnum));
    if(isDefined(level._monitor_tracker)) {
      self thread[[level._monitor_tracker]](localclientnum);
    }
    self thread gadget_clone_render::transition_shader(localclientnum);
  }
}

function player_clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    self set_shader(localclientnum, 1, self);
    self thread gadget_clone_render::transition_shader(localclientnum);
  } else {
    self set_shader(localclientnum, 0, self);
    self notify("clone_shader_off");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 0, 0, 1);
  }
}

function clone_damage_flicker(localclientnum) {
  self endon("entityshutdown");
  self notify("start_flicker");
  self endon("start_flicker");
  self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 1);
  self waittill("stop_flicker");
  self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 0);
}

function clone_damage_finish() {
  self endon("entityshutdown");
  self endon("start_flicker");
  self endon("stop_flicker");
  wait(0.2);
  self notify("stop_flicker");
}

function clone_damaged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread clone_damage_flicker(localclientnum);
  } else {
    self thread clone_damage_finish();
  }
}