/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_mrpukey.gsc
********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_mrpukey;

function autoexec __init__sytem__() {
  system::register("gadget_mrpukey", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(38, & gadget_mrpukey_on, & gadget_mrpukey_off);
  ability_player::register_gadget_possession_callbacks(38, & gadget_mrpukey_on_give, & gadget_mrpukey_on_take);
  ability_player::register_gadget_flicker_callbacks(38, & gadget_mrpukey_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(38, & gadget_mrpukey_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(38, & gadget_mrpukey_is_flickering);
  ability_player::register_gadget_primed_callbacks(38, & gadget_mrpukey_is_primed);
}

function gadget_mrpukey_is_inuse(slot) {
  return self flagsys::get("gadget_mrpukey_on");
}

function gadget_mrpukey_is_flickering(slot) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    return self[[level.cybercom.mrpukey._is_flickering]](slot);
  }
}

function gadget_mrpukey_on_flicker(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._on_flicker]](slot, weapon);
  }
}

function gadget_mrpukey_on_give(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._on_give]](slot, weapon);
  }
}

function gadget_mrpukey_on_take(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._on_take]](slot, weapon);
  }
}

function gadge_mrpukey_on_connect() {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._on_connect]]();
  }
}

function gadget_mrpukey_on(slot, weapon) {
  self flagsys::set("gadget_mrpukey_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._on]](slot, weapon);
  }
}

function gadget_mrpukey_off(slot, weapon) {
  self flagsys::clear("gadget_mrpukey_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._off]](slot, weapon);
  }
}

function gadget_mrpukey_is_primed(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
    self[[level.cybercom.mrpukey._is_primed]](slot, weapon);
  }
}