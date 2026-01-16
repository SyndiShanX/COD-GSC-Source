/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\ability_gadgets.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;

#namespace ability_gadgets;

autoexec __init__system__() {
  system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int");
  clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float");
  clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 3, "int");
}

gadgets_print(str) {
  if(getdvarint(#"scr_debug_gadgets", 0)) {
    toprint = str;
    println(self.playername + "<dev string:x38>" + "<dev string:x3d>" + toprint);
  }
}

on_player_connect() {}

setflickering(slot, length = 0) {
  self gadgetflickering(slot, 1, length);
}

on_player_spawned() {}

event_handler[gadget_give] gadget_give_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x4b>");

  eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_take] gadget_take_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x57>");

  eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x63>");

  eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_ready] gadget_ready_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x71>");

  if(level flag::get("all_players_spawned")) {
    params = {
      #slot: eventstruct.slot
    };
    voiceevent("specialist_equipment_ready", eventstruct.entity, params);
  }

  eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_on] gadget_on_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x7e>");

  if(level flag::get("all_players_spawned")) {
    params = {
      #slot: eventstruct.slot
    };
    voiceevent("specialist_equipment_using", eventstruct.entity, params);
  }

  eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_off] gadget_off_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x88>");

  eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

event_handler[event_dfabd488] function_40d8d1ec(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:x93>");

  eventstruct.entity ability_player::function_50557027(eventstruct.slot, eventstruct.weapon);
}

event_handler[event_e46d75fa] function_15061ae6(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:xa6>");

  eventstruct.entity ability_player::function_d5260ebe(eventstruct.slot, eventstruct.weapon);
}

event_handler[gadget_flicker] gadget_flicker_callback(eventstruct) {
  eventstruct.entity gadgets_print("<dev string:x48>" + eventstruct.slot + "<dev string:xba>");

  eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}