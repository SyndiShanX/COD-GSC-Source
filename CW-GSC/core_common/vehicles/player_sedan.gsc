/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_sedan.gsc
*************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_sedan;

function private autoexec __init__system__() {
  system::register(#"player_sedan", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_sedan", &function_3ca3e81e);
}

function private function_3ca3e81e() {
  self setmovingplatformenabled(1, 0);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_9c00eeec);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_9303f902);
  self.var_84fed14b = 40;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
}

function function_9c00eeec(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size <= 1) {
    self playSound(#"hash_50ca37222ffa9505");
    self vehicle::toggle_control_bone_group(1, 1);
  }
}

function function_9303f902(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size == 0) {
    self playSound(#"hash_50ca37222ffa9505");
    self vehicle::toggle_control_bone_group(1, 0);
  }
}