/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_cleanse.gsc
********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_cleanse;

function autoexec __init__sytem__() {
  system::register("gadget_cleanse", &__init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(17, &gadget_cleanse_on, &gadget_cleanse_off);
  ability_player::register_gadget_possession_callbacks(17, &gadget_cleanse_on_give, &gadget_cleanse_on_take);
  ability_player::register_gadget_flicker_callbacks(17, &gadget_cleanse_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(17, &gadget_cleanse_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(17, &gadget_cleanse_is_flickering);
  clientfield::register("allplayers", "gadget_cleanse_on", 1, 1, "int");
  callback::on_connect(&gadget_cleanse_on_connect);
}

function gadget_cleanse_is_inuse(slot) {
  return self flagsys::get("gadget_cleanse_on");
}

function gadget_cleanse_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_cleanse_on_flicker(slot, weapon) {
  self thread gadget_cleanse_flicker(slot, weapon);
}

function gadget_cleanse_on_give(slot, weapon) {}

function gadget_cleanse_on_take(slot, weapon) {}

function gadget_cleanse_on_connect() {}

function gadget_cleanse_on(slot, weapon) {
  self flagsys::set("gadget_cleanse_on");
  self thread gadget_cleanse_start(slot, weapon);
  self clientfield::set("gadget_cleanse_on", 1);
}

function gadget_cleanse_off(slot, weapon) {
  self flagsys::clear("gadget_cleanse_on");
  self clientfield::set("gadget_cleanse_on", 0);
}

function gadget_cleanse_start(slot, weapon) {
  self setempjammed(0);
  self gadgetsetactivatetime(slot, gettime());
  self setnormalhealth(self.maxhealth);
  self setdoublejumpenergy(1);
  self stopshellshock();
  self notify("gadget_cleanse_on");
}

function wait_until_is_done(slot, timepulse) {}

function gadget_cleanse_flicker(slot, weapon) {
  self endon("disconnect");
}

function set_gadget_cleanse_status(status, time) {}