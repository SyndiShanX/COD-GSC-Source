/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_van.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_van;

function private autoexec __init__system__() {
  system::register(#"player_van", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_van", &function_c6b4bcab);
}

function private function_c6b4bcab() {
  self setmovingplatformenabled(1, 0);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_e26ae7d4);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_f5da89ea);
  self.var_84fed14b = 40;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
}

function function_e26ae7d4(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(validateorigin(self.origin)) {
    playsoundatposition(#"hash_5e5cbc0e6e2d1d4e", self.origin);
  }

  self vehicle::toggle_control_bone_group(1, 1);
}

function function_f5da89ea(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size == 0) {
    if(validateorigin(self.origin)) {
      playsoundatposition(#"hash_5e5cbc0e6e2d1d4e", self.origin);
    }

    self vehicle::toggle_control_bone_group(1, 0);
  }
}