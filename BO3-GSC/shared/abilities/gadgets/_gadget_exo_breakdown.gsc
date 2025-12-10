/**************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_exo_breakdown.gsc
**************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_exo_breakdown;

function autoexec __init__sytem__() {
  system::register("gadget_exo_breakdown", &__init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(20, &gadget_exo_breakdown_on, &gadget_exo_breakdown_off);
  ability_player::register_gadget_possession_callbacks(20, &gadget_exo_breakdown_on_give, &gadget_exo_breakdown_on_take);
  ability_player::register_gadget_flicker_callbacks(20, &gadget_exo_breakdown_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(20, &gadget_exo_breakdown_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(20, &gadget_exo_breakdown_is_flickering);
  ability_player::register_gadget_primed_callbacks(20, &gadget_exo_breakdown_is_primed);
  callback::on_connect(&gadget_exo_breakdown_on_connect);
}

function gadget_exo_breakdown_is_inuse(slot) {
  return self flagsys::get("gadget_exo_breakdown_on");
}

function gadget_exo_breakdown_is_flickering(slot) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    return self[[level.cybercom.exo_breakdown._is_flickering]](slot);
  }
  return 0;
}

function gadget_exo_breakdown_on_flicker(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._on_flicker]](slot, weapon);
  }
}

function gadget_exo_breakdown_on_give(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._on_give]](slot, weapon);
  }
}

function gadget_exo_breakdown_on_take(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._on_take]](slot, weapon);
  }
}

function gadget_exo_breakdown_on_connect() {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._on_connect]]();
  }
}

function gadget_exo_breakdown_on(slot, weapon) {
  self flagsys::set("gadget_exo_breakdown_on");
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._on]](slot, weapon);
  }
}

function gadget_exo_breakdown_off(slot, weapon) {
  self flagsys::clear("gadget_exo_breakdown_on");
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._off]](slot, weapon);
  }
}

function gadget_exo_breakdown_is_primed(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.exo_breakdown)) {
    self[[level.cybercom.exo_breakdown._is_primed]](slot, weapon);
  }
}