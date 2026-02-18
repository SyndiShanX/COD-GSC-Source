/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\ability_gadgets.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace ability_gadgets;

function private autoexec __init__system__() {
  system::register(#"ability_gadgets", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  clientfield::register_clientuimodel("huditems.abilityHoldToActivate", 1, 2, "int");
  clientfield::register_clientuimodel("huditems.abilityDelayProgress", 1, 5, "float");
}

function gadgets_print(str) {
  if(getdvarint(#"scr_debug_gadgets", 0)) {
    toprint = str;
    println(self.playername + "<dev string:x38>" + "<dev string:x3e>" + toprint);
  }
}

function on_player_connect() {}

function setflickering(slot, length = 0) {
  self gadgetflickering(slot, 1, length);
}

function on_player_spawned() {}

function event_handler[gadget_give] gadget_give_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x4e>");

  eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_take] gadget_take_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x5b>");

  eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x68>");

  eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_ready] gadget_ready_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x77>");

  eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_on] gadget_on_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x85>");

  eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_off] gadget_off_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x90>");

  eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

function event_handler[event_dfabd488] function_40d8d1ec(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x9c>");

  eventstruct.entity ability_player::function_50557027(eventstruct.slot, eventstruct.weapon);
}

function event_handler[event_e46d75fa] function_15061ae6(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:xb0>");

  eventstruct.entity ability_player::function_d5260ebe(eventstruct.slot, eventstruct.weapon);
}

function event_handler[gadget_flicker] gadget_flicker_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:xc5>");

  eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}