/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_fav_light.gsc
*****************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_fav_light;

function private autoexec __init__system__() {
  system::register(#"player_fav_light", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_fav_light", &function_6e6e0d52);
}

function private function_6e6e0d52() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1d4618ca);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_79f2b4cf);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_c4c18caf);
  self.var_d6691161 = 200;
  self.var_5002d77c = 0.6;
  self vehicle::toggle_control_bone_group(2, 1);
}

function function_1d4618ca(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index == 0) {
    self vehicle::toggle_control_bone_group(1, 1);
    return;
  }

  if(eventstruct.seat_index == 1) {
    self vehicle::toggle_control_bone_group(2, 0);
  }
}

function function_79f2b4cf(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index == 1) {
    self vehicle::toggle_control_bone_group(2, 0);
    return;
  }

  if(eventstruct.seat_index == 0) {
    self vehicle::toggle_control_bone_group(2, 1);
  }
}

function function_c4c18caf(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  eventstruct = params.eventstruct;

  if(eventstruct.seat_index == 1) {
    self vehicle::toggle_control_bone_group(2, 1);
  }

  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size == 0) {
    self vehicle::toggle_control_bone_group(1, 0);
  }
}