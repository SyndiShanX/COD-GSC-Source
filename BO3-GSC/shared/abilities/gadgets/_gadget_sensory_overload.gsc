/*****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_sensory_overload.gsc
*****************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_sensory_overload;

function autoexec __init__sytem__() {
  system::register("gadget_sensory_overload", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(32, & gadget_sensory_overload_on, & gadget_sensory_overload_off);
  ability_player::register_gadget_possession_callbacks(32, & gadget_sensory_overload_on_give, & gadget_sensory_overload_on_take);
  ability_player::register_gadget_flicker_callbacks(32, & gadget_sensory_overload_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(32, & gadget_sensory_overload_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(32, & gadget_sensory_overload_is_flickering);
  ability_player::register_gadget_primed_callbacks(32, & gadget_sensory_overload_is_primed);
  callback::on_connect( & gadget_sensory_overload_on_connect);
}

function gadget_sensory_overload_is_inuse(slot) {
  return self flagsys::get("gadget_sensory_overload_on");
}

function gadget_sensory_overload_is_flickering(slot) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    return self[[level.cybercom.sensory_overload._is_flickering]](slot);
  }
}

function gadget_sensory_overload_on_flicker(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._on_flicker]](slot, weapon);
  }
}

function gadget_sensory_overload_on_give(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._on_give]](slot, weapon);
  }
}

function gadget_sensory_overload_on_take(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._on_take]](slot, weapon);
  }
}

function gadget_sensory_overload_on_connect() {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._on_connect]]();
  }
}

function gadget_sensory_overload_on(slot, weapon) {
  self flagsys::set("gadget_sensory_overload_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._on]](slot, weapon);
  }
}

function gadget_sensory_overload_off(slot, weapon) {
  self flagsys::clear("gadget_sensory_overload_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._off]](slot, weapon);
  }
}

function gadget_sensory_overload_is_primed(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
    self[[level.cybercom.sensory_overload._is_primed]](slot, weapon);
  }
}