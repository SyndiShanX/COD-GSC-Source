/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_overdrive.gsc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_overdrive;

function autoexec __init__sytem__() {
  system::register("gadget_overdrive", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(28, & gadget_overdrive_on, & gadget_overdrive_off);
  ability_player::register_gadget_possession_callbacks(28, & gadget_overdrive_on_give, & gadget_overdrive_on_take);
  ability_player::register_gadget_flicker_callbacks(28, & gadget_overdrive_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(28, & gadget_overdrive_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(28, & gadget_overdrive_is_flickering);
  if(!isdefined(level.vsmgr_prio_visionset_overdrive)) {
    level.vsmgr_prio_visionset_overdrive = 65;
  }
  visionset_mgr::register_info("visionset", "overdrive", 1, level.vsmgr_prio_visionset_overdrive, 15, 1, & visionset_mgr::ramp_in_out_thread_per_player, 0);
  callback::on_connect( & gadget_overdrive_on_connect);
  clientfield::register("toplayer", "overdrive_state", 1, 1, "int");
}

function gadget_overdrive_is_inuse(slot) {
  return self flagsys::get("gadget_overdrive_on");
}

function gadget_overdrive_is_flickering(slot) {}

function gadget_overdrive_on_flicker(slot, weapon) {}

function gadget_overdrive_on_give(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
    self[[level.cybercom.overdrive._on_give]](slot, weapon);
  }
}

function gadget_overdrive_on_take(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
    self[[level.cybercom.overdrive._on_take]](slot, weapon);
  }
}

function gadget_overdrive_on_connect() {}

function gadget_overdrive_on(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
    self thread[[level.cybercom.overdrive._on]](slot, weapon);
    self flagsys::set("gadget_overdrive_on");
  }
}

function gadget_overdrive_off(slot, weapon) {
  self flagsys::clear("gadget_overdrive_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
    self thread[[level.cybercom.overdrive._off]](slot, weapon);
  }
}