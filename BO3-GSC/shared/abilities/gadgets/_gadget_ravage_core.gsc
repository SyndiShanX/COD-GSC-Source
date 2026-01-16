/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_ravage_core.gsc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_ravage_core;

function autoexec __init__sytem__() {
  system::register("gadget_ravage_core", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(22, & gadget_ravage_core_on, & gadget_ravage_core_off);
  ability_player::register_gadget_possession_callbacks(22, & gadget_ravage_core_on_give, & gadget_ravage_core_on_take);
  ability_player::register_gadget_flicker_callbacks(22, & gadget_ravage_core_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(22, & gadget_ravage_core_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(22, & gadget_ravage_core_is_flickering);
  callback::on_connect( & gadget_ravage_core_on_connect);
}

function gadget_ravage_core_is_inuse(slot) {
  return self flagsys::get("gadget_ravage_core_on");
}

function gadget_ravage_core_is_flickering(slot) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    return self[[level.cybercom.ravage_core._is_flickering]](slot);
  }
}

function gadget_ravage_core_on_flicker(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._on_flicker]](slot, weapon);
  }
}

function gadget_ravage_core_on_give(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._on_give]](slot, weapon);
  }
}

function gadget_ravage_core_on_take(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._on_take]](slot, weapon);
  }
}

function gadget_ravage_core_on_connect() {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._on_connect]]();
  }
}

function gadget_ravage_core_on(slot, weapon) {
  self flagsys::set("gadget_ravage_core_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._on]](slot, weapon);
  }
}

function gadget_ravage_core_off(slot, weapon) {
  self flagsys::clear("gadget_ravage_core_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
    self[[level.cybercom.ravage_core._off]](slot, weapon);
  }
}