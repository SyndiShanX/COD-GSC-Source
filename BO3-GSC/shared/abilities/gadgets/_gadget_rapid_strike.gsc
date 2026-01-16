/*************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_rapid_strike.gsc
*************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_rapid_strike;

function autoexec __init__sytem__() {
  system::register("gadget_rapid_strike", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(30, & gadget_rapid_strike_on, & gadget_rapid_strike_off);
  ability_player::register_gadget_possession_callbacks(30, & gadget_rapid_strike_on_give, & gadget_rapid_strike_on_take);
  ability_player::register_gadget_flicker_callbacks(30, & gadget_rapid_strike_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(30, & gadget_rapid_strike_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(30, & gadget_rapid_strike_is_flickering);
  callback::on_connect( & gadget_rapid_strike_on_connect);
}

function gadget_rapid_strike_is_inuse(slot) {
  return self flagsys::get("gadget_rapid_strike_on");
}

function gadget_rapid_strike_is_flickering(slot) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    return self[[level.cybercom.rapid_strike._is_flickering]](slot);
  }
}

function gadget_rapid_strike_on_flicker(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._on_flicker]](slot, weapon);
  }
}

function gadget_rapid_strike_on_give(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._on_give]](slot, weapon);
  }
}

function gadget_rapid_strike_on_take(slot, weapon) {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._on_take]](slot, weapon);
  }
}

function gadget_rapid_strike_on_connect() {
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._on_connect]]();
  }
}

function gadget_rapid_strike_on(slot, weapon) {
  self flagsys::set("gadget_rapid_strike_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._on]](slot, weapon);
  }
}

function gadget_rapid_strike_off(slot, weapon) {
  self flagsys::clear("gadget_rapid_strike_on");
  if(isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
    self[[level.cybercom.rapid_strike._off]](slot, weapon);
  }
}