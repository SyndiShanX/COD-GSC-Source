/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\_ability_gadgets.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#namespace ability_gadgets;

function autoexec __init__sytem__() {
  system::register("ability_gadgets", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
}

function gadgets_print(str) {
  if(getdvarint("")) {
    toprint = str;
    println(((self.playername + "") + "") + toprint);
  }
}

function on_player_connect() {}

function setflickering(slot, length = 0) {
  self gadgetflickering(slot, 1, length);
}

function on_player_spawned() {}

function gadget_give_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::give_gadget(slot, weapon);
}

function gadget_take_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::take_gadget(slot, weapon);
}

function gadget_primed_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::gadget_primed(slot, weapon);
}

function gadget_ready_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::gadget_ready(slot, weapon);
}

function gadget_on_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  if(isdefined(level.bzmoncybercomoncallback)) {
    level thread[[level.bzmoncybercomoncallback]](ent);
  }
  ent ability_player::turn_gadget_on(slot, weapon);
}

function gadget_off_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::turn_gadget_off(slot, weapon);
}

function gadget_flicker_callback(ent, slot, weapon) {
  ent gadgets_print(("" + slot) + "");
  ent ability_player::gadget_flicker(slot, weapon);
}