/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_other.gsc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_other;

function autoexec __init__sytem__() {
  system::register("gadget_other", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(1, & gadget_other_on_activate, & gadget_other_on_off);
  ability_player::register_gadget_possession_callbacks(1, & gadget_other_on_give, & gadget_other_on_take);
  ability_player::register_gadget_flicker_callbacks(1, & gadget_other_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(1, & gadget_other_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(1, & gadget_other_is_flickering);
  ability_player::register_gadget_ready_callbacks(1, & gadget_other_ready);
}

function gadget_other_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_other_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_other_on_flicker(slot, weapon) {}

function gadget_other_on_give(slot, weapon) {}

function gadget_other_on_take(slot, weapon) {}

function gadget_other_on_connect() {}

function gadget_other_on_spawn() {}

function gadget_other_on_activate(slot, weapon) {}

function gadget_other_on_off(slot, weapon) {}

function gadget_other_ready(slot, weapon) {}

function set_gadget_other_status(weapon, status, time) {
  timestr = "";
  if(isdefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(((("Gadget Other " + weapon.name) + ": ") + status) + timestr);
  }
}