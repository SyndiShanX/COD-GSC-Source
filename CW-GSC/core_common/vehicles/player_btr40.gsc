/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_btr40.gsc
*************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_btr40;

function private autoexec __init__system__() {
  system::register(#"player_btr40", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_btr40", &function_a5a8e361);
}

function private function_a5a8e361() {
  self setmovingplatformenabled(1, 0);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_658070e);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_b3042635);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_32ff31aa);
  self.var_96c0f900 = [];
  self.var_96c0f900[1] = 1000;
  self.var_4ca92b57 = 30;
  self.var_57371c71 = 60;
  self.var_84fed14b = 40;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
  self vehicle::toggle_control_bone_group(1, 1);
  self vehicle::toggle_control_bone_group(2, 1);
  self vehicle::toggle_control_bone_group(3, 1);
  self thread player_vehicle::function_5bce3f3a(1, 1000);
}

function function_658070e(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
    self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 0);
  }
}

function function_b3042635(params) {
  eventstruct = params.eventstruct;

  if(eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
    self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 1);
  }
}

function function_32ff31aa(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index >= 1 && eventstruct.seat_index <= 4) {
    self vehicle::toggle_control_bone_group(eventstruct.seat_index - 1 + 1, 0);
  }

  if(eventstruct.old_seat_index >= 1 && eventstruct.old_seat_index <= 4) {
    self vehicle::toggle_control_bone_group(eventstruct.old_seat_index - 1 + 1, 1);
  }
}